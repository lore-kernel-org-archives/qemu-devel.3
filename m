Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF66CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSr6L-0006d2-7l; Fri, 29 May 2026 02:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyan@cyano.uk>) id 1wSr6J-0006ci-B6
 for qemu-devel@nongnu.org; Fri, 29 May 2026 02:53:47 -0400
Received: from jupiter.guys.cyano.uk ([45.63.120.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyan@cyano.uk>) id 1wSr6H-0005MJ-JV
 for qemu-devel@nongnu.org; Fri, 29 May 2026 02:53:47 -0400
From: Xinhui Yang <cyan@cyano.uk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyano.uk; s=dkim;
 t=1780037622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cBFZXZ5VBBd96EmFFpngfIH0I1YowUTAx0q99subMTA=;
 b=Xy+cf3OOO9dIPb8ZIqOo3+SZ062u1KUR9vgiaXNEg9ntfzZkBtrvwGYwsB3NWAvWlTyajV
 r+KRar6eBxug05yAIipLSxLWkm5rLjzyfMO9qfEtZuSWFlXTIads6bK4C3UFHY6d9+qTSl
 Jv6lTD0kK94ppBxkhBkAtGou6ETkfZqPEvYfHKI2f6VfdIDH93hO1wYviHUlIFsM/W5hf5
 rrHzIFstdi9g++RZi11w+bACPgUHtM8eW8gVVPhB0ayRULt5TUhmtOJX5ub7hy/mqw2yVc
 k4CGwxv61Jk/7Oj8RBtEKefdgKGuFlFo4ilto3wiPy9XdL6d/JVL3hhD0xmY+w==
Authentication-Results: jupiter.guys.cyano.uk;
 auth=pass smtp.mailfrom=cyan@cyano.uk
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mingcong Bai <jeffbai@aosc.io>, Xinhui Yang <cyan@cyano.uk>
Subject: [PATCH v3 1/2] linux-user: implement fsmount(2) series of syscalls
Date: Fri, 29 May 2026 14:53:20 +0800
Message-ID: <193e73f7745a086b99ba68e28b665f9f22444b06.1780036891.git.cyan@cyano.uk>
In-Reply-To: <cover.1780036891.git.cyan@cyano.uk>
References: <cover.1780036891.git.cyan@cyano.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: --
Received-SPF: pass client-ip=45.63.120.176; envelope-from=cyan@cyano.uk;
 helo=jupiter.guys.cyano.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This series of syscalls replaces the old mount(2) syscall with a series
of syscalls that operates around a filesystem context. This series of
syscalls is available since Linux 5.2 and glibc 2.36+.

Their users include systemd since v259 and libmount from util-linux, and
possibly other widely used projects.

Preliminary checks are implemented to ensure the validity of the
interface.

Signed-off-by: Xinhui Yang <cyan@cyano.uk>
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
2.52.0


