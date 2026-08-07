Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92FFC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKbX-0001BJ-E2; Fri, 07 Aug 2026 09:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wsKbH-00014x-8O
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:27:03 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wsKbF-0007hD-Q2
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:27:03 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 46ED0600D8;
 Fri,  7 Aug 2026 13:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677921F000E9;
 Fri,  7 Aug 2026 13:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786109220;
 bh=wiInlw6k2zYuD+YRAQqnhjA7W0hWpiLsPyptXCDVL9g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mFb5Fkq3+TPxgUTK5VotPSnE15t63Py5ssGRRhh3m432n7u1D9FGP2K4xMb1bqeHz
 qWQus/uyjUquFGOmvUs4dtT6LY0JUhnhysEC3oVbC49+dGkiyDiwD1odzEmhVTV1Xl
 U3+8eJo4p6unx890eol7Qx88zTEGjbd7qWMVRoTQV2jyXWN05iqhAHHhJqXfor3Nb3
 dUwzhINuKp7fB8+xIgcOIB/HTbcJpAHDtf71hnu9ENLg+CJI8e9duV953pHOKFqw6V
 veQyJuSQns8ObRucZsahtspl9H0ApDc6GiYMnMSY4lmBXeR2x8YSl6ZfRMueWbfjjS
 Kcz5Oe/cCpRGg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, deller@gmx.de,
 Laurent Vivier <laurent@vivier.eu>, Mikulas Patocka <mpatocka@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PULL 2/3] linux-user/sh4: Initialize the FPSCR register on signal
Date: Fri,  7 Aug 2026 15:26:51 +0200
Message-ID: <20260807132652.9687-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807132652.9687-1-deller@kernel.org>
References: <20260807132652.9687-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mikulas Patocka <mpatocka@redhat.com>

On the SH4 architecture, the instructions that perform single precision
and double precision floating point operations are encoded in the same
way. The bit PR in the FPSCR register determines if the CPU performs
single or double operation.

According to the ABI, the PR bit must be set at function entry and
function exit.

GCC generates code that flips this bit as needed during function
execution. If we get a signal, we must set the PR bit, so that the signal
handler finds the bit in the expected state. Qemu lacked this logic, so
that if the signal interrupts single-precision floating point
calculation, the PR bit would be incorrectly clear at signal handler
entry. If the signal handler performed some floating-point calculation,
it would get incorrect result.

This patch fixes the bug, by initializing the FPSCR register at signal
entry. Note that we initialize the whole register, because the Linux
kernel initializes the whole register too.

Cc: qemu-stable@nongnu.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/sh4/signal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index 00290d6e40..7f246e750d 100644
--- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -206,6 +206,8 @@ void setup_frame(int sig, struct target_sigaction *ka,
         __put_user(set->sig[i + 1], &frame->extramask[i]);
     }
 
+    regs->fpscr = FPSCR_PR;
+
     /* Set up to return from userspace.  If provided, use a stub
        already in userspace.  */
     if (ka->sa_flags & TARGET_SA_RESTORER) {
@@ -258,6 +260,8 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
     }
 
+    regs->fpscr = FPSCR_PR;
+
     /* Set up to return from userspace.  If provided, use a stub
        already in userspace.  */
     if (ka->sa_flags & TARGET_SA_RESTORER) {
-- 
2.54.0


