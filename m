Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777A5C5DF65
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFhm-0007WM-BC; Wed, 12 Aug 2026 16:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wuFhk-0007Tw-O3
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:37:40 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wuFhj-0001EP-0T
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:37:40 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9647C41EEF;
 Wed, 12 Aug 2026 20:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126B01F000E9;
 Wed, 12 Aug 2026 20:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786567050;
 bh=/lI7aCOnAv3DkQWd/BGkdXQ91OenFVJOSM6SdZu6WCk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PCIZaaNx90ZL0oUQWcoVFD8Gr1Zqpfl+MN+lmCQF/Av6mjsOg9N1O7H8zVkSSxMy0
 9k2Qcvak6WCaS+jl01iU8kba7bCsT9MadDLaY0mpXnkB417shqqhLU2YGGHKViLD5M
 9RJRA7r7Shzymec3n56opEw2i4nxVnwejoKQDi1UTe5f8Yqe3IVDCz98an3vL0w9EI
 RrWW09nu6AqtK6vSn5mOb3H21cA6OfgBtzWgbjnUSnhvgzHPDex10DpxYXNNNp4ANM
 Xbhv7UBuGFgoDDpuMDbcLE4mVJYBpJ9vaI+PfZhtAMZF9L+FvNkl5b0HPgzhFY7alo
 S1MKAOcL1Ft0g==
From: Helge Deller <deller@kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Matt Turner <mattst88@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 1/7] linux-user: implement mount_setattr(2)
Date: Wed, 12 Aug 2026 22:37:19 +0200
Message-ID: <20260812203725.10694-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812203725.10694-1-deller@kernel.org>
References: <20260812203725.10694-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

From: Matt Turner <mattst88@gmail.com>

mount_setattr() was in the syscall tables but had no implementation, so
guests always got -ENOSYS. systemd uses it when setting up per-unit
credential mounts, which fails the affected units with EXIT_CREDENTIALS.

struct mount_attr is an extensible struct like open_how, so handle it the
same way openat2() does: reject sizes smaller than the ver0 struct and
require any unknown trailing bytes to be zero. All of its fields are
64-bit, and the MOUNT_ATTR_* and MS_* propagation values are identical on
every target, so only the byte order needs fixing up.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/strace.list    |  3 +++
 linux-user/syscall.c      | 44 +++++++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h | 13 ++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index 25ace05187..e952f15d20 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1737,3 +1737,6 @@
 #ifdef TARGET_NR_fspick
 { TARGET_NR_fspick, "fspick", "%s(%d,%s,%d)", NULL, NULL },
 #endif
+#ifdef TARGET_NR_mount_setattr
+{ TARGET_NR_mount_setattr, "mount_setattr", "%s(%d,%s,%d,%p,%d)", NULL, NULL },
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dc028686f4..cfa68dfbdb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9735,6 +9735,13 @@ _syscall5(int, sys_move_mount, int, __from_dfd, const char *, __from_pathname,
            int, __to_dfd, const char *, __to_pathname, unsigned int, flag)
 #endif
 
+#if defined(TARGET_NR_mount_setattr) && defined(__NR_mount_setattr)
+#define __NR_sys_mount_setattr __NR_mount_setattr
+_syscall5(int, sys_mount_setattr, int, dfd, const char *, path,
+          unsigned int, flags, struct mount_attr_ver0 *, uattr,
+          size_t, usize)
+#endif
+
 #if defined(TARGET_NR_fsopen) && defined(__NR_fsopen)
 #define __NR_sys_fsopen __NR_fsopen
 _syscall2(int, sys_fsopen, const char *, fs_name, unsigned int, flags);
@@ -14480,6 +14487,43 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return do_map_shadow_stack(cpu_env, arg1, arg2, arg3);
 #endif
 
+#if defined(TARGET_NR_mount_setattr) && defined(__NR_mount_setattr)
+    case TARGET_NR_mount_setattr:
+        {
+            struct mount_attr_ver0 attr = {};
+            abi_ulong usize = arg5;
+
+            if (usize < sizeof(struct target_mount_attr_ver0)) {
+                return -TARGET_EINVAL;
+            }
+            ret = copy_struct_from_user(&attr, sizeof(attr), arg4, usize);
+            if (ret) {
+                if (ret == -TARGET_E2BIG) {
+                    qemu_log_mask(LOG_UNIMP,
+                                  "Unimplemented mount_setattr mount_attr "
+                                  "size: " TARGET_ABI_FMT_lu "\n", usize);
+                }
+                return ret;
+            }
+            /*
+             * MOUNT_ATTR_* and the MS_* propagation flags have the same
+             * values on all targets, so only byte order needs fixing up.
+             */
+            attr.attr_set = tswap64(attr.attr_set);
+            attr.attr_clr = tswap64(attr.attr_clr);
+            attr.propagation = tswap64(attr.propagation);
+            attr.userns_fd = tswap64(attr.userns_fd);
+
+            p = lock_user_string(arg2);
+            if (!p) {
+                return -TARGET_EFAULT;
+            }
+            ret = get_errno(sys_mount_setattr(arg1, p, arg3, &attr,
+                                              sizeof(attr)));
+            unlock_user(p, arg2, 0);
+        }
+        return ret;
+#endif
 #if defined(TARGET_NR_fsopen) && defined(__NR_fsopen)
     case TARGET_NR_fsopen:
         {
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index e033c7db34..e28853c93b 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2770,6 +2770,19 @@ struct target_open_how_ver0 {
     abi_ullong mode;
     abi_ullong resolve;
 };
+/* from kernel's include/uapi/linux/mount.h */
+struct mount_attr_ver0 {
+    uint64_t attr_set;
+    uint64_t attr_clr;
+    uint64_t propagation;
+    uint64_t userns_fd;
+};
+struct target_mount_attr_ver0 {
+    abi_ullong attr_set;
+    abi_ullong attr_clr;
+    abi_ullong propagation;
+    abi_ullong userns_fd;
+};
 #ifndef RESOLVE_NO_MAGICLINKS
 #define RESOLVE_NO_MAGICLINKS   0x02
 #endif
-- 
2.54.0


