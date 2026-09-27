Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF733C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmTv-0005rV-Ci; Sun, 27 Sep 2026 06:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmTs-0005gV-Fj; Sun, 27 Sep 2026 06:51:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmTq-0001Wb-Sp; Sun, 27 Sep 2026 06:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506136; bh=yAUoIeZa3Nzaze9xoITWPF4GL86OWmPA5QNZRIm4f3Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JCrF/ImMPY8mI0KVyXzChPb7SpqN52JQjQYpV+zmPpx/g9JAsdBTJ630vSmza9RC1
 CBogE0shxNUrERgHJfGcmF0NuyugyI7y6K5NfFXiVqNdQ8J7OfNAce5+3KmfS0Ulsf
 rPec+RhlITCey+DafCf7nMNC2Cao2CU7EJU5j/saDRJ+1UjzE1i0uOPcLin4mQz/cM
 lmZ9WwtxvrowRPuw4cSS809zEJI8iGR247qVHbKcNwAwGu1vn/ehHWWgyVDZycVu+2
 1bTgoPqrO6mdHh/fHhtuxjjR6YyrcWObEWBlMa28L+uDqcqXm0Uqcs9umQzUr767qc
 DBlkXAccz6B8Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 695A11D8B79;
 Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6468E432180;
 Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 169685E7AA; Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 90/92] linux-user/sh4: align the vdso sigreturn
 trampolines
Date: Sun, 27 Sep 2026 13:48:06 +0300
Message-ID: <20260927104821.196183-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Matt Turner <mattst88@gmail.com>

libunwind's unw_is_signal_frame() reads the trampoline as 32-bit words,
but __kernel_sigreturn is only 2-byte aligned. Align both trampolines
to 4 bytes, as the kernel's vsyscall-sigreturn.S does (with .balign 32).

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 95e14595d398d0044ec8b03ffcf1459dc157a69f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/sh4/vdso-be.so b/linux-user/sh4/vdso-be.so
index df9fa22efab..d74a2d78e86 100755
Binary files a/linux-user/sh4/vdso-be.so and b/linux-user/sh4/vdso-be.so differ
diff --git a/linux-user/sh4/vdso-le.so b/linux-user/sh4/vdso-le.so
index decd6742022..a59c9e5244d 100755
Binary files a/linux-user/sh4/vdso-le.so and b/linux-user/sh4/vdso-le.so differ
diff --git a/linux-user/sh4/vdso.S b/linux-user/sh4/vdso.S
index 290eb498aeb..a66cac7439a 100644
--- a/linux-user/sh4/vdso.S
+++ b/linux-user/sh4/vdso.S
@@ -135,6 +135,7 @@ vdso_syscall __vdso_gettimeofday, __NR_gettimeofday
 	.cfi_offset		24, SC_FPSCR
 
 	nop
+	.balign	4
 
 sigreturn_region_start:
 __kernel_sigreturn:
@@ -144,6 +145,7 @@ endf __kernel_sigreturn
 	/* rt_sigreturn frame layout; nop for the same reason as above. */
 	.cfi_def_cfa_offset	RT_SIGFRAME_SC_OFFSET
 	nop
+	.balign	4
 
 __kernel_rt_sigreturn:
 	sigreturn_tramp __NR_rt_sigreturn
-- 
2.47.3


