Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31802CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYVCJ-0000bS-4G; Sat, 13 Jun 2026 16:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVC9-0000LK-J3; Sat, 13 Jun 2026 16:43:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVC5-0005jq-C7; Sat, 13 Jun 2026 16:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382967; bh=u48ie73Wjnwd+AefzvtIOSouHz6g5JAEaBHx18K6fCM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KHhdgJOyBJYS4eB38GcFXwviuexvAb5a200vKa5wGVHMsgf0OW9G9eyUyhatNyCmS
 cTomFFc+LwRn/xe7jNU3NEMJZKevxqRsfEjeqZbkyvyDPdpxpuzTnSBHeh9nkBVFuJ
 1Ld3BwmMcePEOf1ve3YsgwrXTa85TWslbBqyX3q69EWYLYX7MsNPiUJAStuQDWxrZo
 CXziia0Kb6GhfiB1AU811cADjIftcaQdQJMGstO0q0crCS/43jdy3RHo3XXQBFeIHo
 tsQMeF5aPGHBoZZTVMFkCwgjPPDhU1pijxflYwW8C2qlV3+cvMSsLTopwUhP8+whm2
 cRTPY6fGOAp7A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 20FB91B6F2A;
 Sat, 13 Jun 2026 23:36:07 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 877E63CE973;
 Sat, 13 Jun 2026 23:36:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xinhui Yang <cyan@cyano.uk>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 71/72] linux-user: implement fsmount(2) series of
 syscalls
Date: Sat, 13 Jun 2026 23:35:37 +0300
Message-ID: <20260613203542.1809153-71-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
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

From: Xinhui Yang <cyan@cyano.uk>

This series of syscalls replaces the old mount(2) syscall with a series
of syscalls that operates around a filesystem context. This series of
syscalls is available since Linux 5.2 and glibc 2.36+.

Their users include systemd since v259 and libmount from util-linux, and
possibly other widely used projects.

Preliminary checks are implemented to ensure the validity of the
interface.

v2: Add syscall wrappers in case the build machine does not
support the fsmount() syscalls. (added by Helge Deller)

Signed-off-by: Xinhui Yang <cyan@cyano.uk>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 767c32fe69834344bf71f4071ff33292cd46f626)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 65bbeb8551..993718973a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9653,6 +9653,19 @@ _syscall5(int, sys_move_mount, int, __from_dfd, const char *, __from_pathname,
            int, __to_dfd, const char *, __to_pathname, unsigned int, flag)
 #endif
 
+#if defined(TARGET_NR_fsopen) && defined(NR_fsopen)
+#define __NR_sys_fsopen __NR_fsopen
+_syscall2(int, sys_fsopen, const char *, fs_name, unsigned int, flags);
+#define __NR_sys_fsconfig __NR_fsconfig
+_syscall5(int, sys_fsconfig, int, fs_fd, unsigned int, cmd, const char *, key,
+          const void *, value, int, aux)
+#define __NR_sys_fsmount __NR_fsmount
+_syscall3(int, sys_fsmount, int, fs_fd, unsigned int, flags,
+          unsigned int, ms_flags)
+#define __NR_sys_fspick __NR_fspick
+_syscall3(int, sys_fspick, int, dfd, const char *, path, unsigned int, flags)
+#endif
+
 /* This is an internal helper for do_syscall so that it is easier
  * to have a single return point, so that actions, such as logging
  * of syscall results, can be performed.
@@ -14348,6 +14361,97 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return do_map_shadow_stack(cpu_env, arg1, arg2, arg3);
 #endif
 
+#if defined(TARGET_NR_fsopen) && defined(NR_fsopen)
+    case TARGET_NR_fsopen:
+        {
+            p = lock_user_string(arg1);
+            if (!p) {
+                return -TARGET_EFAULT;
+            }
+            ret = get_errno(sys_fsopen(p, arg2));
+            unlock_user(p, arg1, 0);
+        }
+        return ret;
+    case TARGET_NR_fsconfig:
+        {
+            /*
+             * fsconfig(int, int, char *, void *, int)
+             * NOTE: p4 is nullable and its type might not be a string.
+             */
+            void *p3, *p4;
+            int cmd = (int) arg2;
+            switch (cmd) {
+            case FSCONFIG_SET_BINARY:
+            case FSCONFIG_SET_STRING:
+            case FSCONFIG_SET_PATH:
+            case FSCONFIG_SET_PATH_EMPTY:
+                p3 = lock_user_string(arg3);
+                if (!p3) {
+                    return -TARGET_EFAULT;
+                }
+                if (cmd != FSCONFIG_SET_BINARY) {
+                    /* key and value must be strings. */
+                    p4 = lock_user_string(arg4);
+                } else {
+                    /*
+                     * Otherwise the value must be a raw buffer with its
+                     * length specified in arg5 (aux).
+                     */
+                    p4 = lock_user(VERIFY_READ, arg4, arg5, 1);
+                }
+                if (!p4) {
+                    unlock_user(p3, arg3, 0);
+                    return -TARGET_EFAULT;
+                }
+                ret = get_errno(sys_fsconfig(arg1, arg2, p3, p4, arg5));
+                unlock_user(p3, arg3, 0);
+                unlock_user(p4, arg4, 0);
+                break;
+
+            case FSCONFIG_SET_FLAG:
+            case FSCONFIG_SET_FD:
+                /* arg4 (value) must be NULL. */
+                if (arg4) {
+                    return -TARGET_EFAULT;
+                }
+                p3 = lock_user_string(arg3);
+                if (!p3) {
+                    return -TARGET_EFAULT;
+                }
+                ret = get_errno(sys_fsconfig(arg1, arg2, p3, NULL, arg5));
+                unlock_user(p3, arg3, 0);
+                break;
+            case FSCONFIG_CMD_CREATE:
+            case FSCONFIG_CMD_RECONFIGURE:
+#ifdef FSCONFIG_CMD_CREATE_EXCL
+            /*
+             * FSCONFIG_CMD_CREATE_EXCL is only available since Linux
+             * 6.6. Guarding it to allow building with pre-6.6 headers.
+             */
+            case FSCONFIG_CMD_CREATE_EXCL:
+#endif
+                /* key and value must be NULL, aux must be 0. */
+                if (arg3 || arg4 || arg5) {
+                    return -TARGET_EFAULT;
+                }
+                ret = get_errno(sys_fsconfig(arg1, arg2, NULL, NULL, 0));
+                break;
+            default:
+                return -TARGET_EFAULT;
+            }
+        }
+        return ret;
+    case TARGET_NR_fsmount:
+        ret = get_errno(sys_fsmount(arg1, arg2, arg3));
+        return ret;
+    case TARGET_NR_fspick:
+        {
+            p = lock_user_string(arg2);
+            ret = get_errno(sys_fspick(arg1, p, arg3));
+            unlock_user(p, arg2, 0);
+        }
+        return ret;
+#endif
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
         return -TARGET_ENOSYS;
-- 
2.47.3


