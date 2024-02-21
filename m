Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AA2C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 08:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rchrW-0001kp-25; Wed, 21 Feb 2024 03:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchrO-0001Zx-0y; Wed, 21 Feb 2024 03:21:46 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchrL-0002CO-Nb; Wed, 21 Feb 2024 03:21:45 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B7F8A4F3CB;
 Wed, 21 Feb 2024 11:21:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 83886860AA;
 Wed, 21 Feb 2024 11:20:59 +0300 (MSK)
Received: (nullmailer pid 2142025 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 13/60] linux-user/aarch64: Add padding before
 __kernel_rt_sigreturn
Date: Wed, 21 Feb 2024 11:20:01 +0300
Message-Id: <20240221082058.2141850-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Without this padding, an unwind through the signal handler
will pick up the unwind info for the preceding syscall.

This fixes gcc's 30_threads/thread/native_handle/cancel.cc.

Cc: qemu-stable@nongnu.org
Fixes: ee95fae075c6 ("linux-user/aarch64: Add vdso")
Resolves: https://linaro.atlassian.net/browse/GNU-974
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240202034427.504686-1-richard.henderson@linaro.org>
(cherry picked from commit 6400be014f80e4c2c246eb8be709ea3a96428233)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/aarch64/vdso-be.so b/linux-user/aarch64/vdso-be.so
index 6084f3d1a7..808206ade8 100755
Binary files a/linux-user/aarch64/vdso-be.so and b/linux-user/aarch64/vdso-be.so differ
diff --git a/linux-user/aarch64/vdso-le.so b/linux-user/aarch64/vdso-le.so
index 947d534ec1..941aaf2993 100755
Binary files a/linux-user/aarch64/vdso-le.so and b/linux-user/aarch64/vdso-le.so differ
diff --git a/linux-user/aarch64/vdso.S b/linux-user/aarch64/vdso.S
index 34d3a9ebd2..a0ac1487b0 100644
--- a/linux-user/aarch64/vdso.S
+++ b/linux-user/aarch64/vdso.S
@@ -63,7 +63,11 @@ vdso_syscall __kernel_clock_getres, __NR_clock_getres
  * For now, elide the unwind info for __kernel_rt_sigreturn and rely on
  * the libgcc fallback routine as we have always done.  This requires
  * that the code sequence used be exact.
+ *
+ * Add a nop as a spacer to ensure that unwind does not pick up the
+ * unwind info from the preceding syscall.
  */
+	nop
 __kernel_rt_sigreturn:
 	/* No BTI C insn here -- we arrive via RET. */
 	mov	x8, #__NR_rt_sigreturn
-- 
2.39.2


