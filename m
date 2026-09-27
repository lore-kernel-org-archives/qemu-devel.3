Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0A0C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmTo-0005U9-Gs; Sun, 27 Sep 2026 06:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmTm-0005PM-PD; Sun, 27 Sep 2026 06:51:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmTl-0001Us-2i; Sun, 27 Sep 2026 06:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506136; bh=P45cZDgg7RGBGwA+WWAJcHoU4NQpXQQASpMsorOwDT4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CvL6EUpTAp7bpoNZoapLw5l0YTRoUgJ1y6N9gp4HzkGYjUaOT/oEsoOxONZapVzH1
 Hbk4A0GYIlK3XF5oq0emgcHfMdXfx5rNnHYA2t7sZDX5LV+/ThoAKlx7fB1AZjVRC1
 6Egzh1wWwjZupl40PHj3KwYsZhA+EbETFIOoiwj9uSkDpCp7nqJj1fI44o7qMuXooZ
 jchfnox/1LWNqUjy40bl1wKuBnD6KR908qEboFxUA4ZidW76mKIyippSDmGc/i26+W
 51h0PqjnMBtv+k8GwjSYiUgOGHPxOr2hwth+IZnYJsCF3qtfDDs1dy90H/ZeaCmM3t
 uD4IPFI4psekA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5BDA41D8B76;
 Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5922843217E;
 Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 107445E7A6; Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 88/92] linux-user/sh4: use the kernel's sigreturn
 trampoline sequence in the vdso
Date: Sun, 27 Sep 2026 13:48:04 +0300
Message-ID: <20260927104821.196183-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
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

From: Matt Turner <mattst88@gmail.com>

With the vdso, default_sigreturn and default_rt_sigreturn point at
__kernel_sigreturn and __kernel_rt_sigreturn and setup_sigtramp() is no
longer used. The vdso trampolines load the syscall number with mov.l
instead of the kernel's mov.w/trapa/or r0,r0 sequence, which undoes
commit 9ac5aa7227 ("linux-user/sh4: Fix setup_sigtramp to match Linux
kernel trampoline pattern"): libunwind's unw_is_signal_frame() no longer
recognizes the signal frame, so unwinding through a signal handler stops
there.

Use the sequence from the kernel's own vdso,
arch/sh/kernel/vsyscall/vsyscall-sigreturn.S.

Fixes: 975bd51a88 ("linux-user/sh4: add VDSO support for sh4 and sh4eb")
Cc: qemu-stable@nongnu.org
Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 170dfd8d1f86d4baa0bd7ba7d615febde3252086)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/sh4/vdso-be.so b/linux-user/sh4/vdso-be.so
index 4f50143f828..bc1fb37e108 100755
Binary files a/linux-user/sh4/vdso-be.so and b/linux-user/sh4/vdso-be.so differ
diff --git a/linux-user/sh4/vdso-le.so b/linux-user/sh4/vdso-le.so
index c41cb5831b9..c1ff560cc16 100755
Binary files a/linux-user/sh4/vdso-le.so and b/linux-user/sh4/vdso-le.so differ
diff --git a/linux-user/sh4/vdso.S b/linux-user/sh4/vdso.S
index 4fb5ee9d31b..1faa6657746 100644
--- a/linux-user/sh4/vdso.S
+++ b/linux-user/sh4/vdso.S
@@ -43,6 +43,22 @@ vdso_syscall __vdso_clock_gettime64, __NR_clock_gettime64
 vdso_syscall __vdso_clock_getres, __NR_clock_getres
 vdso_syscall __vdso_gettimeofday, __NR_gettimeofday
 
+/*
+ * Same instruction sequence as the kernel's
+ * arch/sh/kernel/vsyscall/vsyscall-sigreturn.S. libunwind matches these
+ * bytes to recognize a signal frame.
+ */
+.macro sigreturn_tramp nr
+	mov.w	1f, r3
+	trapa	#0x10
+	or	r0, r0
+	or	r0, r0
+	or	r0, r0
+	or	r0, r0
+	or	r0, r0
+1:	.word	\nr
+.endm
+
 /*
  * Signal return trampolines.
  *
@@ -122,20 +138,14 @@ vdso_syscall __vdso_gettimeofday, __NR_gettimeofday
 
 sigreturn_region_start:
 __kernel_sigreturn:
-	mov.l	1f, r3
-	trapa	#0x10
-	.align	2
-1:	.long	__NR_sigreturn
+	sigreturn_tramp __NR_sigreturn
 endf __kernel_sigreturn
 
 	/* Update CFA base for the rt_sigreturn frame layout. */
 	.cfi_def_cfa_offset	RT_SIGFRAME_SC_OFFSET
 
 __kernel_rt_sigreturn:
-	mov.l	2f, r3
-	trapa	#0x10
-	.align	2
-2:	.long	__NR_rt_sigreturn
+	sigreturn_tramp __NR_rt_sigreturn
 endf __kernel_rt_sigreturn
 sigreturn_region_end:
 
-- 
2.47.3


