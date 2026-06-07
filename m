Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC53CD8C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWE6h-0004Ip-6Z; Sun, 07 Jun 2026 10:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWE6f-0004IK-9t
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 10:04:05 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWE6d-0007zE-KD
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 10:04:05 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8DD5443857;
 Sun,  7 Jun 2026 14:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0843C1F00893;
 Sun,  7 Jun 2026 14:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780841042;
 bh=SZokrjayKiS1ulA/9qnPoBKc5DedE8QybE5mhesGm2A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eidsL1rgl/IuYZGGGN30ksXyTH8LS5jBlAvKZF7Z5CZ8JF+0g14REminHI0TOEB/U
 ZNa2J8T2G+IIQJu1ZuO5FnLd00h2EE2tr+qenMGU3NLXfpk+YwKGI6SfJ6kWWOTgye
 yqT2o26l3Ppja9rjP7CdPkbr1BOzvO/w0ybPpggokEGloXBJ83ZsUog5rS7l8bHA9V
 fs/IfK/2LNIWaEHIj8y65bKJRyik43oEc4bVswKeG2pTXcpKrVZrFiPeoMlIMOtvTZ
 xCqTR+b5FKgUvHXJ1wf6/dtGYbddi/bwE0SB3V4lFh8I6DMNJulwO8NFA7KF/vRZMw
 pX+XQkpbJ+Xow==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Helge Deller <deller@gmx.de>,
 Xinhui Yang <cyan@cyano.uk>
Subject: [PATCH 01/10] linux-user: implement fsmount(2) series of syscalls
Date: Sun,  7 Jun 2026 16:03:47 +0200
Message-ID: <20260607140356.10702-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607140356.10702-1-deller@kernel.org>
References: <20260607140356.10702-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Xinhui Yang <cyan@cyano.uk>

This series of syscalls replaces the old mount(2) syscall with a series
of syscalls that operates around a filesystem context. This series of
syscalls is available since Linux 5.2 and glibc 2.36+.

Their users include systemd since v259 and libmount from util-linux, and
possibly other widely used projects.

Preliminary checks are implemented to ensure the validity of the
interface.

Signed-off-by: Xinhui Yang <cyan@cyano.uk>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 91 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7d7a7b489c..c5c2aa80ec 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -14412,6 +14412,97 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return do_map_shadow_stack(cpu_env, arg1, arg2, arg3);
 #endif
 
+#if defined(TARGET_NR_fsopen)
+    case TARGET_NR_fsopen:
+        {
+            p = lock_user_string(arg1);
+            if (!p) {
+                return -TARGET_EFAULT;
+            }
+            ret = get_errno(fsopen(p, arg2));
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
+                ret = get_errno(fsconfig(arg1, arg2, p3, p4, arg5));
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
+                ret = get_errno(fsconfig(arg1, arg2, p3, NULL, arg5));
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
+                ret = get_errno(fsconfig(arg1, arg2, NULL, NULL, 0));
+                break;
+            default:
+                return -TARGET_EFAULT;
+            }
+        }
+        return ret;
+    case TARGET_NR_fsmount:
+        ret = get_errno(fsmount(arg1, arg2, arg3));
+        return ret;
+    case TARGET_NR_fspick:
+        {
+            p = lock_user_string(arg2);
+            ret = get_errno(fspick(arg1, p, arg3));
+            unlock_user(p, arg2, 0);
+        }
+        return ret;
+#endif
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
         return -TARGET_ENOSYS;
-- 
2.54.0


