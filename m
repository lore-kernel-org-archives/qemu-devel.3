Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6DFC54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wodva-0001NC-Ck; Tue, 28 Jul 2026 05:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wodvY-0001MP-QK
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:16:44 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wodvX-0002G7-31
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:16:44 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E05CE411B3;
 Tue, 28 Jul 2026 09:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028EB1F000E9;
 Tue, 28 Jul 2026 09:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785230201;
 bh=AHXx/6JWT/+sw2/94m8VkSsOAJZZX+38Q7mo68/hWT4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JHw4iZfEq5L8POVtNgm7ztklKmr6X3NxeSeylF+90XrznqlhYsavLpbktAnhzEj+d
 Ax8Bt6w6d3zamdGewkas45D4rmKxxktQytY461V2+46R1V7jIt8MxytLSFWX/TOljn
 HJb5pvDGFns/KWpkHcYvlzd8Of/MPq4s725jp09YXQr/L0pSRH5ekPW9Gv1OxlBnfm
 EKS3sTjW07qGGl3g5D2UZAR1n4Wvzg9hlVJ2RMy8ZXnlYLWm42g6HT9eEPgbgkf179
 YmdqzF9RSOFjD0v6o5F+yK6DHcKzc21g42OJbrWGFQQZdWI1bmuxnImjJCg7mfKrL0
 h1wkHsmWRaPtg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Matt Turner <mattst88@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 2/3] linux-user: fix guards for the fsmount(2) syscall series
Date: Tue, 28 Jul 2026 11:16:32 +0200
Message-ID: <20260728091633.29765-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728091633.29765-1-deller@kernel.org>
References: <20260728091633.29765-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

The fsopen(), fsconfig(), fsmount() and fspick() implementations are
guarded by defined(NR_fsopen) rather than defined(__NR_fsopen). No such
macro exists, so the guard is never true and the entire series compiles
out. Guests calling any of the four get -ENOSYS, which for example makes
systemd's credential setup fail with EXIT_CREDENTIALS for most units.

The strace bits for fsconfig() have the same typo.

Check if FSCONFIG_SET_FLAG is defined to avoid build errors in the strace
code on some older distributions (Helge).

Fixes: 767c32fe6983 ("linux-user: implement fsmount(2) series of syscalls")
Fixes: 6e0aa9f6c731 ("linux-user/strace: add fsmount series of syscalls")
Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/strace.c    | 2 +-
 linux-user/strace.list | 2 +-
 linux-user/syscall.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 3a81cc95f4..bc43a95a77 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -4344,7 +4344,7 @@ print_statx(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
-#if defined(TARGET_NR_fsconfig) && defined(NR_fsconfig)
+#if defined(TARGET_NR_fsconfig) && defined(__NR_fsconfig) && defined(FSCONFIG_SET_FLAG)
 static void
 print_fsconfig_cmd_name(int cmd)
 {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index e363892e0a..25ace05187 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1725,7 +1725,7 @@
 #ifdef TARGET_NR_fsopen
 { TARGET_NR_fsopen, "fsopen", "%s(%s,%d)", NULL, NULL },
 #endif
-#if defined(TARGET_NR_fsconfig) && defined(NR_fsconfig)
+#if defined(TARGET_NR_fsconfig) && defined(__NR_fsconfig) && defined(FSCONFIG_SET_FLAG)
 { TARGET_NR_fsconfig, "fsconfig", NULL, print_fsconfig, NULL },
 #endif
 #ifdef TARGET_NR_fsmount
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3da5530d42..740142825d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9740,7 +9740,7 @@ _syscall5(int, sys_move_mount, int, __from_dfd, const char *, __from_pathname,
            int, __to_dfd, const char *, __to_pathname, unsigned int, flag)
 #endif
 
-#if defined(TARGET_NR_fsopen) && defined(NR_fsopen)
+#if defined(TARGET_NR_fsopen) && defined(__NR_fsopen)
 #define __NR_sys_fsopen __NR_fsopen
 _syscall2(int, sys_fsopen, const char *, fs_name, unsigned int, flags);
 #define __NR_sys_fsconfig __NR_fsconfig
@@ -14485,7 +14485,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return do_map_shadow_stack(cpu_env, arg1, arg2, arg3);
 #endif
 
-#if defined(TARGET_NR_fsopen) && defined(NR_fsopen)
+#if defined(TARGET_NR_fsopen) && defined(__NR_fsopen)
     case TARGET_NR_fsopen:
         {
             p = lock_user_string(arg1);
-- 
2.54.0


