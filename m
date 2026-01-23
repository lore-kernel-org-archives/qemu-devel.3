Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFF7D74EE2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjInm-0007Lh-5P; Fri, 23 Jan 2026 10:10:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjInH-00072e-JC
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:52 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjInE-0002xQ-P9
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:51 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E545443B95;
 Fri, 23 Jan 2026 15:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55ADC19422;
 Fri, 23 Jan 2026 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769180979;
 bh=eU/gRZpkT9Xv1WWpNiUg1u46/4lFqNWL0BWL6PbrP8c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Vmav/WeY9cnMLv/bHnkHbx018GvpzMNiiVaiif+SF785JtCuk+XDmiPXOZuxdkzou
 QwQ7Oj6EnaEpp9iCFVVtku/vtVMK6GGD3B8y3QT9Tyz3mRRbjIxtjpJxUaZ/1uEl0c
 qxmMyMuvHxBkhOzFleOWXb1YB/4BHwTf6TpHLgkaI8x/LztYJUF5hkkv1kqbqORfA3
 YkIqPeXU7RH5LxsTFFZVXZq1OD/lPrzl+YZZ+ZPiw0UwqByGkan+9GlCkhegaiQprV
 DuuTxtWt0tZfu+WIQEBupL0X51dj6NXLG2xEp2y5sVGRb0/DAfqJp3p3iIpg1Ijgcf
 QfSF7nmtmas8w==
From: deller@kernel.org
To: Laurent Vivier <laurent@vivier.eu>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 3/3] linux-user: Fix MADV_XXX constants on hppa target
Date: Fri, 23 Jan 2026 16:08:00 +0100
Message-ID: <20260123150921.17891-4-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123150921.17891-1-deller@kernel.org>
References: <20260123150921.17891-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Helge Deller <deller@gmx.de>

Older hppa binaries may still use the old MADV_XXX constants for the
madivise() syscall. Fix it up in the same manner as it's done in the
Linux kernel in the parisc_madvise() function.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7cb9de97e9..80f7355ccd 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12929,6 +12929,20 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 
 #ifdef TARGET_NR_madvise
     case TARGET_NR_madvise:
+#ifdef TARGET_HPPA
+        /* Emulate old hppa mapping of MADV_xxx constants. */
+        switch (arg3) {
+        case 65: arg3 = MADV_MERGEABLE;     break;
+        case 66: arg3 = MADV_UNMERGEABLE;   break;
+        case 67: arg3 = MADV_HUGEPAGE;      break;
+        case 68: arg3 = MADV_NOHUGEPAGE;    break;
+        case 69: arg3 = MADV_DONTDUMP;      break;
+        case 70: arg3 = MADV_DODUMP;        break;
+        case 71: arg3 = MADV_WIPEONFORK;    break;
+        case 72: arg3 = MADV_KEEPONFORK;    break;
+        case 73: arg3 = MADV_COLLAPSE;      break;
+        }
+#endif /* TARGET_HPPA */
         return target_madvise(arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_fcntl64
-- 
2.52.0


