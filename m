Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1EB606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4GBTQXI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP6NT-0001Jg-0e; Thu, 05 Nov 2026 17:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP6NB-0001IH-8s
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:56:00 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP6N8-0004WC-3V
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:55:55 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CB6C9401BC;
 Thu,  5 Nov 2026 22:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E471F0089F;
 Thu,  5 Nov 2026 22:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793919352;
 bh=S4MYz3HmpV3zuE4set2Zxrehvqdp40xYuvdeqdddayM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M4GBTQXIaUX3NSYRsQ0e79gE194mJrlmDdzDTPRd6t5i9M59InijGDrkNBqlm5pim
 mllrbS9Yx+Se+SoGNy2e6Ih/1eZnDA/IfSBJ9u1cNHMEsn+LfrH1Yc8phqZprxkegH
 JDjWg+w5rawVJ4o7SbzdyAgvHvQfrwIJASCEL5/nO6mVn9oNgq1wMzdwQQoW3jEEPs
 1z8Ffm/jEJMqlfM8+7UdfKrpBCq0nhVSDEyRwr7aRfg6u89iQFSyDAH0IzPERU9OrB
 jhovCEejEgC9NhIgeH2vImz4waAboHd1qGIsLzKyWH2qc4YtCrQxWVWvLVnJiEfy1l
 RGGyduDtktfLw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL 2/2] linux-user: report EFAULT for a NULL sysinfo/getitimer
 buffer
Date: Thu,  5 Nov 2026 23:55:46 +0100
Message-ID: <20261105225547.12848-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105225547.12848-1-deller@kernel.org>
References: <20261105225547.12848-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: TAKANO Mitsuhiro <takano32@gmail.com>

Both handlers skip the copy-out when the guest pointer is zero and return
success, so a caller that forgets the buffer gets an uninitialised result
instead of the EFAULT the kernel reports for a NULL address.

Copy unconditionally: a NULL pointer then fails in lock_user_struct() and
in copy_to_user_timeval() like any other unusable address.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c                          |  4 +--
 tests/tcg/multiarch/linux/linux-null-buffer.c | 35 +++++++++++++++++--
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 59cbf5feaa..2fc61b3eab 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11551,7 +11551,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             struct itimerval value;
 
             ret = get_errno(getitimer(arg1, &value));
-            if (!is_error(ret) && arg2) {
+            if (!is_error(ret)) {
                 if (copy_to_user_timeval(arg2,
                                          &value.it_interval)
                     || copy_to_user_timeval(arg2 + sizeof(struct target_timeval),
@@ -11666,7 +11666,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             struct target_sysinfo *target_value;
             struct sysinfo value;
             ret = get_errno(sysinfo(&value));
-            if (!is_error(ret) && arg1)
+            if (!is_error(ret))
             {
                 if (!lock_user_struct(VERIFY_WRITE, target_value, arg1, 0))
                     return -TARGET_EFAULT;
diff --git a/tests/tcg/multiarch/linux/linux-null-buffer.c b/tests/tcg/multiarch/linux/linux-null-buffer.c
index 6246e47707..b099803c57 100644
--- a/tests/tcg/multiarch/linux/linux-null-buffer.c
+++ b/tests/tcg/multiarch/linux/linux-null-buffer.c
@@ -1,6 +1,15 @@
 /*
- * A zero-length getrandom() needs no valid buffer: the kernel never looks at
- * the pointer, so getrandom(NULL, 0, 0) succeeds.
+ * Degenerate buffer pointers must behave like they do in the kernel.
+ *
+ * A zero-length getrandom() needs no valid buffer: the pointer is never
+ * used, so getrandom(NULL, 0, 0) succeeds.  A required output buffer, on
+ * the other hand, must not be silently skipped: sysinfo() and getitimer()
+ * have to report EFAULT for a NULL pointer.
+ *
+ * The NULL cases go through syscall() rather than the libc wrappers: on
+ * 32-bit x86, for example, getitimer() hands the kernel a local structure
+ * and copies the result out itself, so it would follow the NULL pointer
+ * before the kernel's answer could be seen.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
@@ -9,11 +18,31 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <sys/random.h>
+#include <sys/syscall.h>
+#include <sys/sysinfo.h>
+#include <sys/time.h>
+#include <unistd.h>
 
 int main(void)
 {
+    char buf[8];
+    struct itimerval it;
+    struct sysinfo si;
+
+    /* A zero-length request is not rejected for a NULL buffer. */
     errno = 0;
-    assert(getrandom(NULL, 0, 0) == 0);
+    assert(syscall(SYS_getrandom, NULL, 0, 0) == 0);
+
+    /* A NULL output pointer is reported, not silently skipped. */
+    errno = 0;
+    assert(syscall(SYS_sysinfo, NULL) == -1 && errno == EFAULT);
+    errno = 0;
+    assert(syscall(SYS_getitimer, ITIMER_REAL, NULL) == -1 && errno == EFAULT);
+
+    /* The ordinary calls still work. */
+    assert(getrandom(buf, sizeof(buf), 0) == sizeof(buf));
+    assert(sysinfo(&si) == 0);
+    assert(getitimer(ITIMER_REAL, &it) == 0);
 
     return EXIT_SUCCESS;
 }
-- 
2.54.0


