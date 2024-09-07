Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A7FE6FE4D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 07:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smpPr-0003zm-2D; Sat, 07 Sep 2024 02:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smpPp-0003ya-2q; Sat, 07 Sep 2024 02:59:25 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smpPn-0002nZ-7f; Sat, 07 Sep 2024 02:59:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B86D98C88E;
 Sat,  7 Sep 2024 09:57:59 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0EF28133D37;
 Sat,  7 Sep 2024 09:59:19 +0300 (MSK)
Received: (nullmailer pid 376231 invoked by uid 1000);
 Sat, 07 Sep 2024 06:59:19 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH trivial] linux-user/syscall.c: replace function pointer with a
 helper macro for fcntl/flock case
Date: Sat,  7 Sep 2024 09:59:18 +0300
Message-Id: <20240907065918.376217-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

There's a slight difference in fcntl locking handling on arm and others:
arm has 2 variants of struct flock argument handling, with and without eabi.
For this reason, we currently take address of the conversion function into
a variable, and for arm without eabi case, assign a different conversion
function to this pointer.  All functions are declared as inline, - and for
an inline function, it is not clear how one can have an address of it at
all.

Instead of using a function pointer, use a macro, defined differently for
arm (with arithmetic if based on eabi presence) and for all other targets
(using regular argument conversion function directly).

While at it, replace tabs with spaces in nearby code.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d418e2864a..786623d395 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6880,9 +6880,6 @@ static inline abi_long copy_to_user_flock(abi_ulong target_flock_addr,
     return 0;
 }
 
-typedef abi_long from_flock64_fn(struct flock *fl, abi_ulong target_addr);
-typedef abi_long to_flock64_fn(abi_ulong target_addr, const struct flock *fl);
-
 #if defined(TARGET_ARM) && TARGET_ABI_BITS == 32
 struct target_oabi_flock64 {
     abi_short l_type;
@@ -12402,14 +12399,19 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     {
         int cmd;
         struct flock fl;
-        from_flock64_fn *copyfrom = copy_from_user_flock64;
-        to_flock64_fn *copyto = copy_to_user_flock64;
 
 #ifdef TARGET_ARM
-        if (!cpu_env->eabi) {
-            copyfrom = copy_from_user_oabi_flock64;
-            copyto = copy_to_user_oabi_flock64;
-        }
+# define copyfrom(fl, arg) \
+           (cpu_env->eabi ? \
+             copy_from_user_flock64(fl, arg) : \
+             copy_from_user_oabi_flock64(fl, arg))
+# define copyto(arg, fl) \
+           (cpu_env->eabi ? \
+             copy_to_user_flock64(arg, fl) : \
+             copy_to_user_oabi_flock64(arg, fl))
+#else
+# define copyfrom copy_from_user_flock64
+# define copyto copy_to_user_flock64
 #endif
 
         cmd = target_to_host_fcntl_cmd(arg2);
@@ -12427,7 +12429,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             if (ret == 0) {
                 ret = copyto(arg3, &fl);
             }
-	    break;
+            break;
 
         case TARGET_F_SETLK64:
         case TARGET_F_SETLKW64:
@@ -12436,10 +12438,12 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                 break;
             }
             ret = get_errno(safe_fcntl(arg1, cmd, &fl));
-	    break;
+            break;
         default:
             ret = do_fcntl(arg1, arg2, arg3);
             break;
+#undef copyfrom
+#undef copyto
         }
         return ret;
     }
-- 
2.39.2


