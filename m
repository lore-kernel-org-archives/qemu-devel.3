Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23766D2D0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 12:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfdzY-0001Jk-KX; Tue, 13 Jan 2026 07:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vfdzS-0000uO-Si; Tue, 13 Jan 2026 07:59:19 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vfdzQ-0000gM-S6; Tue, 13 Jan 2026 07:59:18 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CA96717D9A8;
 Tue, 13 Jan 2026 15:58:46 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C0CA834C3FC;
 Tue, 13 Jan 2026 15:58:51 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-user@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH RFC 3/3] linux-user/syscall.c: consolidate statfs calls further
Date: Tue, 13 Jan 2026 15:58:44 +0300
Message-ID: <20260113125849.910112-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113125849.910112-1-mjt@tls.msk.ru>
References: <20260113125849.910112-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Since statfs & statfs64 implementations are exactly the same,
differs only in "64" suffix, merge them into one using a common
macro.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c | 110 ++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 70 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1f84c296d5..1b888bccfc 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10972,80 +10972,50 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return ret;
     case TARGET_NR_setpriority:
         return get_errno(setpriority(arg1, arg2, arg3));
-#ifdef TARGET_NR_statfs
-    case TARGET_NR_statfs:
-    case TARGET_NR_fstatfs:
-        {
-            struct statf stfs;
-            struct target_statfs *target_stfs;
-            if (num == TARGET_NR_statfs) {
-                if (!(p = lock_user_string(arg1))) {
-                    return -TARGET_EFAULT;
-                }
-                ret = get_errno(statfs(path(p), &stfs));
-                unlock_user(p, arg1, 0);
-            } else /* if (num == TARGET_NR_fstatfs) */ {
-                ret = get_errno(fstatfs(arg1, &stfs));
-            }
-            if (is_error(ret)) {
-                return ret;
-            }
-            if (!lock_user_struct(VERIFY_WRITE, target_stfs, arg2, 0))
-                return -TARGET_EFAULT;
-            __put_user(stfs.f_type, &target_stfs->f_type);
-            __put_user(stfs.f_bsize, &target_stfs->f_bsize);
-            __put_user(stfs.f_blocks, &target_stfs->f_blocks);
-            __put_user(stfs.f_bfree, &target_stfs->f_bfree);
-            __put_user(stfs.f_bavail, &target_stfs->f_bavail);
-            __put_user(stfs.f_files, &target_stfs->f_files);
-            __put_user(stfs.f_ffree, &target_stfs->f_ffree);
-            __put_user(stfs.f_fsid.__val[0], &target_stfs->f_fsid.val[0]);
-            __put_user(stfs.f_fsid.__val[1], &target_stfs->f_fsid.val[1]);
-            __put_user(stfs.f_namelen, &target_stfs->f_namelen);
-            __put_user(stfs.f_frsize, &target_stfs->f_frsize);
-            __put_user(stfs.f_flags, &target_stfs->f_flags);
-            memset(target_stfs->f_spare, 0, sizeof(target_stfs->f_spare));
-            unlock_user_struct(target_stfs, arg2, 1);
-            return ret;
+
+#define statfs_fstatfs_impl(variant) /* variant is statfs or statfs64 */ \
+    case TARGET_NR_##variant: \
+    case TARGET_NR_f##variant: \
+        { \
+            struct statfs stfs; \
+            struct target_##variant *target_stfs; \
+            if (num == TARGET_NR_##variant) { \
+                if (!(p = lock_user_string(arg1))) { \
+                    return -TARGET_EFAULT; \
+                } \
+                ret = get_errno(statfs(path(p), &stfs)); \
+                unlock_user(p, arg1, 0); \
+            } else /* if (num == TARGET_NR_f##variant) */ { \
+                ret = get_errno(fstatfs(arg1, &stfs)); \
+            } \
+            if (is_error(ret)) { \
+                return ret; \
+            } \
+            if (!lock_user_struct(VERIFY_WRITE, target_stfs, arg2, 0)) \
+                return -TARGET_EFAULT; \
+            __put_user(stfs.f_type, &target_stfs->f_type); \
+            __put_user(stfs.f_bsize, &target_stfs->f_bsize); \
+            __put_user(stfs.f_blocks, &target_stfs->f_blocks); \
+            __put_user(stfs.f_bfree, &target_stfs->f_bfree); \
+            __put_user(stfs.f_bavail, &target_stfs->f_bavail); \
+            __put_user(stfs.f_files, &target_stfs->f_files); \
+            __put_user(stfs.f_ffree, &target_stfs->f_ffree); \
+            __put_user(stfs.f_fsid.__val[0], &target_stfs->f_fsid.val[0]); \
+            __put_user(stfs.f_fsid.__val[1], &target_stfs->f_fsid.val[1]); \
+            __put_user(stfs.f_namelen, &target_stfs->f_namelen); \
+            __put_user(stfs.f_frsize, &target_stfs->f_frsize); \
+            __put_user(stfs.f_flags, &target_stfs->f_flags); \
+            memset(target_stfs->f_spare, 0, sizeof(target_stfs->f_spare)); \
+            unlock_user_struct(target_stfs, arg2, 1); \
+            return ret; \
         }
+#ifdef TARGET_NR_statfs
+    statfs_fstatfs_impl(statfs);
 #endif
 #ifdef TARGET_NR_statfs64
-    case TARGET_NR_statfs64:
-    case TARGET_NR_fstatfs64:
-        {
-            struct statfs stfs;
-            struct target_statfs64 *target_stfs;
-            if (num == TARGET_NR_statfs64) {
-                if (!(p = lock_user_string(arg1))) {
-                    return -TARGET_EFAULT;
-                }
-                ret = get_errno(statfs(path(p), &stfs));
-                unlock_user(p, arg1, 0);
-                } else /* if (num == TARGET_NR_fstatfs64) */ {
-                ret = get_errno(fstatfs(arg1, &stfs));
-            }
-            if (is_error(ret)) {
-                return ret;
-            }
-            if (!lock_user_struct(VERIFY_WRITE, target_stfs, arg3, 0))
-                return -TARGET_EFAULT;
-            __put_user(stfs.f_type, &target_stfs->f_type);
-            __put_user(stfs.f_bsize, &target_stfs->f_bsize);
-            __put_user(stfs.f_blocks, &target_stfs->f_blocks);
-            __put_user(stfs.f_bfree, &target_stfs->f_bfree);
-            __put_user(stfs.f_bavail, &target_stfs->f_bavail);
-            __put_user(stfs.f_files, &target_stfs->f_files);
-            __put_user(stfs.f_ffree, &target_stfs->f_ffree);
-            __put_user(stfs.f_fsid.__val[0], &target_stfs->f_fsid.val[0]);
-            __put_user(stfs.f_fsid.__val[1], &target_stfs->f_fsid.val[1]);
-            __put_user(stfs.f_namelen, &target_stfs->f_namelen);
-            __put_user(stfs.f_frsize, &target_stfs->f_frsize);
-            __put_user(stfs.f_flags, &target_stfs->f_flags);
-            memset(target_stfs->f_spare, 0, sizeof(target_stfs->f_spare));
-            unlock_user_struct(target_stfs, arg3, 1);
-            return ret;
-        }
+    statfs_fstatfs_impl(statfs64);
 #endif
+
 #ifdef TARGET_NR_socketcall
     case TARGET_NR_socketcall:
         return do_socketcall(arg1, arg2);
-- 
2.47.3


