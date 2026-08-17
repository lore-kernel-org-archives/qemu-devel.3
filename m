Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A1AC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtI0-0003H4-HW; Mon, 17 Aug 2026 05:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtHm-0003Ef-HR; Mon, 17 Aug 2026 05:05:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtHi-0001c9-US; Mon, 17 Aug 2026 05:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786957506; bh=zhO/n1QZklhsKP2e4R+rNBR9EQl6WoLTCi1d/F0WVL8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rauq/8OQuNNT5qIOysWd3JPaPHFNgkTaRnF+l/0wHH/9MKttchuqR7LpP8y/Ri0a3
 MJr2s4QQf6/Ajd268lJh6tkTU27X4hRMiY7B27dLODQu0LoKU9CcLOBDdcrQwPHJVc
 bbViFK3Oybv63pl4fcpBCP2aBog1Ml50HleJ+7GvbHRRiMZqUSwpV/oceuKVR6J0ms
 +zCO71xZiccwwO23s8MX5NsEQI5RihArzFHmuOWr2SG4Knrdkpm0xRGVcMUbNzGzOo
 W1XAQFb8ZMr8ikA3E1oMhr/GOFNN8n4vU2m832aD2Kx6oblK7HQ3eeUak8NovVzOzO
 rR7+Aa7LzUpug==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 070E61CBA36;
 Mon, 17 Aug 2026 12:05:06 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D9D8540D018;
 Mon, 17 Aug 2026 12:05:26 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A42D730CE4; Mon, 17 Aug 2026 12:05:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mikulas Patocka <mpatocka@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 02/42] linux-user/sh4: Initialize the FPSCR register
 on signal
Date: Mon, 17 Aug 2026 12:04:07 +0300
Message-ID: <20260817090453.2034156-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
(cherry picked from commit 668d571bf0c2ee4851be2187798f413025647fc3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index 00290d6e40c..7f246e750d0 100644
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
2.47.3


