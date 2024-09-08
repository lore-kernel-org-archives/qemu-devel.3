Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE9CE6FE49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 07:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snC9m-0006bs-QQ; Sun, 08 Sep 2024 03:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1snC9l-0006aM-4X; Sun, 08 Sep 2024 03:16:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1snC9j-0000Lp-3w; Sun, 08 Sep 2024 03:16:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6DEAA8CC3E;
 Sun,  8 Sep 2024 10:16:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B35AE1374D6;
 Sun,  8 Sep 2024 10:16:05 +0300 (MSK)
Received: (nullmailer pid 430447 invoked by uid 1000);
 Sun, 08 Sep 2024 07:16:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH trvivial] linux-user/syscall.c: replace function pointers for
 flock64 fcntl with macros
Date: Sun,  8 Sep 2024 10:16:00 +0300
Message-Id: <20240908071600.430410-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For 32bit ARM fcntl64 syscall there are 2 possible argument types,
depending on cpu_env->eabi.  For other architectures, it is plain
struct flock64 in all cases.  In order to solve this, old code
used to take address of the conversion function and and run it
through this pointer.  Instead, introduce 2 helper macros for
the flock64 conversion, and define them in the same block where
the oabi conversion functions are defined, and use these
helpers directly in the actual code, making each part more
self-contained and easier to read.

Also add comment to the block of code which itroduces the oabi
conversion functions.

Note also there was an inconsistency in the old code: different
the differences in single place we eliminate this difference.

While at it, replace tabs with spaces in nearby code.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d418e2864a..03250316df 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6880,10 +6880,12 @@ static inline abi_long copy_to_user_flock(abi_ulong target_flock_addr,
     return 0;
 }
 
-typedef abi_long from_flock64_fn(struct flock *fl, abi_ulong target_addr);
-typedef abi_long to_flock64_fn(abi_ulong target_addr, const struct flock *fl);
-
 #if defined(TARGET_ARM) && TARGET_ABI_BITS == 32
+/*
+ * For 32bit arm flock64 syscall there are 2 variants of target_flock
+ * depending on eabi
+ */
+
 struct target_oabi_flock64 {
     abi_short l_type;
     abi_short l_whence;
@@ -6935,6 +6937,19 @@ static inline abi_long copy_to_user_oabi_flock64(abi_ulong target_flock_addr,
     unlock_user_struct(target_fl, target_flock_addr, 1);
     return 0;
 }
+
+#define copy_from_user_flock64_2abi(cpu_env, fl, target_flock_addr) \
+          (cpu_env->eabi ? copy_from_user_flock64(fl, target_flock_addr) : \
+                           copy_from_user_oabi_flock64(fl, target_flock_addr))
+#define copy_to_user_flock64_2abi(cpu_env, target_flock_addr, fl) \
+          (cpu_env->eabi ? copy_to_user_flock64(target_flock_addr, fl) \
+                           copy_to_user_oabi_flock64(target_flock_addr, fl))
+#else
+
+#define copy_from_user_flock64_2abi(cpu_env, fl, target_flock_addr) \
+            copy_from_user_flock64(fl, target_flock_addr)
+#define copy_to_user_flock64_2abi(cpu_env, target_flock_addr, fl) \
+            copy_to_user_flock64(target_flock_addr, fl)
 #endif
 
 static inline abi_long copy_from_user_flock64(struct flock *fl,
@@ -12402,15 +12417,6 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     {
         int cmd;
         struct flock fl;
-        from_flock64_fn *copyfrom = copy_from_user_flock64;
-        to_flock64_fn *copyto = copy_to_user_flock64;
-
-#ifdef TARGET_ARM
-        if (!cpu_env->eabi) {
-            copyfrom = copy_from_user_oabi_flock64;
-            copyto = copy_to_user_oabi_flock64;
-        }
-#endif
 
         cmd = target_to_host_fcntl_cmd(arg2);
         if (cmd == -TARGET_EINVAL) {
@@ -12419,24 +12425,24 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 
         switch(arg2) {
         case TARGET_F_GETLK64:
-            ret = copyfrom(&fl, arg3);
+            ret = copy_from_user_flock64_2abi(cpu_env, &fl, arg3);
             if (ret) {
                 break;
             }
             ret = get_errno(safe_fcntl(arg1, cmd, &fl));
             if (ret == 0) {
-                ret = copyto(arg3, &fl);
+                ret = copy_to_user_flock64_2abi(cpu_env, arg3, &fl);
             }
-	    break;
+            break;
 
         case TARGET_F_SETLK64:
         case TARGET_F_SETLKW64:
-            ret = copyfrom(&fl, arg3);
+            ret = copy_from_user_flock64_2abi(cpu_env, &fl, arg3);
             if (ret) {
                 break;
             }
             ret = get_errno(safe_fcntl(arg1, cmd, &fl));
-	    break;
+            break;
         default:
             ret = do_fcntl(arg1, arg2, arg3);
             break;
-- 
2.39.2


