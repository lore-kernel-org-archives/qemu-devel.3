Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C646BCF58E5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 07:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srYH0-0006Z9-SO; Fri, 20 Sep 2024 03:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYGu-0006Jv-Vr; Fri, 20 Sep 2024 03:41:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYGt-0000Bq-5S; Fri, 20 Sep 2024 03:41:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C666D90859;
 Fri, 20 Sep 2024 10:41:16 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 555DB1409DC;
 Fri, 20 Sep 2024 10:41:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 03/22] linux-user/syscall.c: eliminate other explicit LFS usages
Date: Fri, 20 Sep 2024 10:41:15 +0300
Message-Id: <20240920074134.664961-4-mjt@tls.msk.ru>
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

Since we alwasy build with LFS enabled, and with -D_FILE_OFFSET_BITS=64
in particular, there is no need to use 64bit versions of various system
calls and constants, regular ones will do just fine.  Eliminate a few
last uses of the following constructs in linux-user/syscall.c:
  off64_t
  ftruncate64()
  lseek64()
  pread64()
  pwrite64()

This way it can be built on systems where the 64bit variants of
everything is not defined (since the system always uses 64bit
variants), such as on recent MUSL.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2215
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 48c459e515..a666986189 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7265,7 +7265,7 @@ static inline abi_long target_truncate64(CPUArchState *cpu_env, const char *arg1
         arg2 = arg3;
         arg3 = arg4;
     }
-    return get_errno(truncate64(arg1, target_offset64(arg2, arg3)));
+    return get_errno(truncate(arg1, target_offset64(arg2, arg3)));
 }
 #endif
 
@@ -7279,7 +7279,7 @@ static inline abi_long target_ftruncate64(CPUArchState *cpu_env, abi_long arg1,
         arg2 = arg3;
         arg3 = arg4;
     }
-    return get_errno(ftruncate64(arg1, target_offset64(arg2, arg3)));
+    return get_errno(ftruncate(arg1, target_offset64(arg2, arg3)));
 }
 #endif
 
@@ -8664,7 +8664,7 @@ static int do_getdents(abi_long dirfd, abi_long arg2, abi_long count)
     void *tdirp;
     int hlen, hoff, toff;
     int hreclen, treclen;
-    off64_t prev_diroff = 0;
+    off_t prev_diroff = 0;
 
     hdirp = g_try_malloc(count);
     if (!hdirp) {
@@ -8717,7 +8717,7 @@ static int do_getdents(abi_long dirfd, abi_long arg2, abi_long count)
              * Return what we have, resetting the file pointer to the
              * location of the first record not returned.
              */
-            lseek64(dirfd, prev_diroff, SEEK_SET);
+            lseek(dirfd, prev_diroff, SEEK_SET);
             break;
         }
 
@@ -8751,7 +8751,7 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
     void *tdirp;
     int hlen, hoff, toff;
     int hreclen, treclen;
-    off64_t prev_diroff = 0;
+    off_t prev_diroff = 0;
 
     hdirp = g_try_malloc(count);
     if (!hdirp) {
@@ -8793,7 +8793,7 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
              * Return what we have, resetting the file pointer to the
              * location of the first record not returned.
              */
-            lseek64(dirfd, prev_diroff, SEEK_SET);
+            lseek(dirfd, prev_diroff, SEEK_SET);
             break;
         }
 
@@ -11524,7 +11524,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                 return -TARGET_EFAULT;
             }
         }
-        ret = get_errno(pread64(arg1, p, arg3, target_offset64(arg4, arg5)));
+        ret = get_errno(pread(arg1, p, arg3, target_offset64(arg4, arg5)));
         unlock_user(p, arg2, ret);
         return ret;
     case TARGET_NR_pwrite64:
@@ -11541,7 +11541,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                 return -TARGET_EFAULT;
             }
         }
-        ret = get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, arg5)));
+        ret = get_errno(pwrite(arg1, p, arg3, target_offset64(arg4, arg5)));
         unlock_user(p, arg2, 0);
         return ret;
 #endif
-- 
2.39.5


