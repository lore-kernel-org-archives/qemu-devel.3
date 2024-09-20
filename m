Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC38CF58E5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 07:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srYGw-0006PX-Fw; Fri, 20 Sep 2024 03:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYGu-0006JM-RQ; Fri, 20 Sep 2024 03:41:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYGs-0000Bj-Ay; Fri, 20 Sep 2024 03:41:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 311FE90858;
 Fri, 20 Sep 2024 10:41:16 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D430A1409DB;
 Fri, 20 Sep 2024 10:41:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 02/22] linux-user/syscall.c: drop 64 suffix from flock64 &Co
Date: Fri, 20 Sep 2024 10:41:14 +0300
Message-Id: <20240920074134.664961-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240920074134.664961-1-mjt@tls.msk.ru>
References: <20240920074134.664961-1-mjt@tls.msk.ru>
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

Since we are always building with LFS enabled, in particular
with -D_FILE_OFFSET_BITS=64, we should always have struct flock
mapped to the 64bit variant (with off64_t), and F_GETLK mapped
to F_GETLK64 etc, automatically.

So there should be no need to explicitly use the "64" suffix
for these things anymore.

Also fix a misleading comment near safe_fcntl telling us to
always use flock64 (since v2.6.0-1311-g435da5e7092a "linux-user:
Use safe_syscall wrapper for fcntl").

Reference: https://gitlab.com/qemu-project/qemu/-/issues/2215
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 62 +++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b693aeff5b..48c459e515 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -759,10 +759,8 @@ safe_syscall6(ssize_t, copy_file_range, int, infd, loff_t *, pinoff,
  * the libc function.
  */
 #define safe_ioctl(...) safe_syscall(__NR_ioctl, __VA_ARGS__)
-/* Similarly for fcntl. Note that callers must always:
- *  pass the F_GETLK64 etc constants rather than the unsuffixed F_GETLK
- *  use the flock64 struct rather than unsuffixed flock
- * This will then work and use a 64-bit offset for both 32-bit and 64-bit hosts.
+/* Similarly for fcntl. Since we always build with LFS enabled,
+ * we should be using the 64-bit structures automatically.
  */
 #ifdef __NR_fcntl64
 #define safe_fcntl(...) safe_syscall(__NR_fcntl64, __VA_ARGS__)
@@ -6722,13 +6720,13 @@ static int target_to_host_fcntl_cmd(int cmd)
         ret = cmd;
         break;
     case TARGET_F_GETLK:
-        ret = F_GETLK64;
+        ret = F_GETLK;
         break;
     case TARGET_F_SETLK:
-        ret = F_SETLK64;
+        ret = F_SETLK;
         break;
     case TARGET_F_SETLKW:
-        ret = F_SETLKW64;
+        ret = F_SETLKW;
         break;
     case TARGET_F_GETOWN:
         ret = F_GETOWN;
@@ -6744,13 +6742,13 @@ static int target_to_host_fcntl_cmd(int cmd)
         break;
 #if TARGET_ABI_BITS == 32
     case TARGET_F_GETLK64:
-        ret = F_GETLK64;
+        ret = F_GETLK;
         break;
     case TARGET_F_SETLK64:
-        ret = F_SETLK64;
+        ret = F_SETLK;
         break;
     case TARGET_F_SETLKW64:
-        ret = F_SETLKW64;
+        ret = F_SETLKW;
         break;
 #endif
     case TARGET_F_SETLEASE:
@@ -6804,8 +6802,8 @@ static int target_to_host_fcntl_cmd(int cmd)
      * them to 5, 6 and 7 before making the syscall(). Since we make the
      * syscall directly, adjust to what is supported by the kernel.
      */
-    if (ret >= F_GETLK64 && ret <= F_SETLKW64) {
-        ret -= F_GETLK64 - 5;
+    if (ret >= F_GETLK && ret <= F_SETLKW) {
+        ret -= F_GETLK - 5;
     }
 #endif
 
@@ -6838,7 +6836,7 @@ static int host_to_target_flock(int type)
     return type;
 }
 
-static inline abi_long copy_from_user_flock(struct flock64 *fl,
+static inline abi_long copy_from_user_flock(struct flock *fl,
                                             abi_ulong target_flock_addr)
 {
     struct target_flock *target_fl;
@@ -6863,7 +6861,7 @@ static inline abi_long copy_from_user_flock(struct flock64 *fl,
 }
 
 static inline abi_long copy_to_user_flock(abi_ulong target_flock_addr,
-                                          const struct flock64 *fl)
+                                          const struct flock *fl)
 {
     struct target_flock *target_fl;
     short l_type;
@@ -6882,8 +6880,8 @@ static inline abi_long copy_to_user_flock(abi_ulong target_flock_addr,
     return 0;
 }
 
-typedef abi_long from_flock64_fn(struct flock64 *fl, abi_ulong target_addr);
-typedef abi_long to_flock64_fn(abi_ulong target_addr, const struct flock64 *fl);
+typedef abi_long from_flock64_fn(struct flock *fl, abi_ulong target_addr);
+typedef abi_long to_flock64_fn(abi_ulong target_addr, const struct flock *fl);
 
 #if defined(TARGET_ARM) && TARGET_ABI_BITS == 32
 struct target_oabi_flock64 {
@@ -6894,7 +6892,7 @@ struct target_oabi_flock64 {
     abi_int   l_pid;
 } QEMU_PACKED;
 
-static inline abi_long copy_from_user_oabi_flock64(struct flock64 *fl,
+static inline abi_long copy_from_user_oabi_flock64(struct flock *fl,
                                                    abi_ulong target_flock_addr)
 {
     struct target_oabi_flock64 *target_fl;
@@ -6919,7 +6917,7 @@ static inline abi_long copy_from_user_oabi_flock64(struct flock64 *fl,
 }
 
 static inline abi_long copy_to_user_oabi_flock64(abi_ulong target_flock_addr,
-                                                 const struct flock64 *fl)
+                                                 const struct flock *fl)
 {
     struct target_oabi_flock64 *target_fl;
     short l_type;
@@ -6939,7 +6937,7 @@ static inline abi_long copy_to_user_oabi_flock64(abi_ulong target_flock_addr,
 }
 #endif
 
-static inline abi_long copy_from_user_flock64(struct flock64 *fl,
+static inline abi_long copy_from_user_flock64(struct flock *fl,
                                               abi_ulong target_flock_addr)
 {
     struct target_flock64 *target_fl;
@@ -6964,7 +6962,7 @@ static inline abi_long copy_from_user_flock64(struct flock64 *fl,
 }
 
 static inline abi_long copy_to_user_flock64(abi_ulong target_flock_addr,
-                                            const struct flock64 *fl)
+                                            const struct flock *fl)
 {
     struct target_flock64 *target_fl;
     short l_type;
@@ -6985,7 +6983,7 @@ static inline abi_long copy_to_user_flock64(abi_ulong target_flock_addr,
 
 static abi_long do_fcntl(int fd, int cmd, abi_ulong arg)
 {
-    struct flock64 fl64;
+    struct flock fl;
 #ifdef F_GETOWN_EX
     struct f_owner_ex fox;
     struct target_f_owner_ex *target_fox;
@@ -6998,45 +6996,45 @@ static abi_long do_fcntl(int fd, int cmd, abi_ulong arg)
 
     switch(cmd) {
     case TARGET_F_GETLK:
-        ret = copy_from_user_flock(&fl64, arg);
+        ret = copy_from_user_flock(&fl, arg);
         if (ret) {
             return ret;
         }
-        ret = get_errno(safe_fcntl(fd, host_cmd, &fl64));
+        ret = get_errno(safe_fcntl(fd, host_cmd, &fl));
         if (ret == 0) {
-            ret = copy_to_user_flock(arg, &fl64);
+            ret = copy_to_user_flock(arg, &fl);
         }
         break;
 
     case TARGET_F_SETLK:
     case TARGET_F_SETLKW:
-        ret = copy_from_user_flock(&fl64, arg);
+        ret = copy_from_user_flock(&fl, arg);
         if (ret) {
             return ret;
         }
-        ret = get_errno(safe_fcntl(fd, host_cmd, &fl64));
+        ret = get_errno(safe_fcntl(fd, host_cmd, &fl));
         break;
 
     case TARGET_F_GETLK64:
     case TARGET_F_OFD_GETLK:
-        ret = copy_from_user_flock64(&fl64, arg);
+        ret = copy_from_user_flock64(&fl, arg);
         if (ret) {
             return ret;
         }
-        ret = get_errno(safe_fcntl(fd, host_cmd, &fl64));
+        ret = get_errno(safe_fcntl(fd, host_cmd, &fl));
         if (ret == 0) {
-            ret = copy_to_user_flock64(arg, &fl64);
+            ret = copy_to_user_flock64(arg, &fl);
         }
         break;
     case TARGET_F_SETLK64:
     case TARGET_F_SETLKW64:
     case TARGET_F_OFD_SETLK:
     case TARGET_F_OFD_SETLKW:
-        ret = copy_from_user_flock64(&fl64, arg);
+        ret = copy_from_user_flock64(&fl, arg);
         if (ret) {
             return ret;
         }
-        ret = get_errno(safe_fcntl(fd, host_cmd, &fl64));
+        ret = get_errno(safe_fcntl(fd, host_cmd, &fl));
         break;
 
     case TARGET_F_GETFL:
@@ -12403,7 +12401,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_fcntl64:
     {
         int cmd;
-        struct flock64 fl;
+        struct flock fl;
         from_flock64_fn *copyfrom = copy_from_user_flock64;
         to_flock64_fn *copyto = copy_to_user_flock64;
 
-- 
2.39.5


