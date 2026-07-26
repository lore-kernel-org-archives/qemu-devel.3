Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BAAC531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 19:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo4eq-0000Vm-IF; Sun, 26 Jul 2026 15:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wo4ed-0000RR-P4
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 15:36:56 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wo4ea-0004wQ-Rn
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 15:36:54 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A17E941486;
 Sun, 26 Jul 2026 19:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE6B1F000E9;
 Sun, 26 Jul 2026 19:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785094604;
 bh=1nYPUnCmRctA+8mRGdBAjqYzc65CjhDmTnIvHCvhOMw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IOFkFGDAVd2qDCn1AMzIHInk7OzSLOd51NwEjcRP4VYovmKgQrfRwK6MIL5Ik3NCG
 5SMttojSu96X+2gNoWxct01CE3IL7XORQ6ihjiy9YFyLT+JDUOMXpsD6Dh/u0BgXwn
 bQQUYbfW8gOavwI+ijvufZNVLjTDEAN2kiBieYbN9OunAjr1/s32Z1KLBw5z+k3uNO
 rH1V45WdHfjSfcIuke+BIn2fDNYQRha6k+T+RLXF8rkH7E2ZFnS4WRiD9HurBkiwQW
 b0gyvjQwFyeWni1K3FzRW6Btk8BUvQR3OJdPd5fowGBa0D2E6kBFCJDO44WID+f2rG
 IhIp6rwcR0yUg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 2/2] linux-user: fix guards for the fsmount(2) syscall series
Date: Sun, 26 Jul 2026 21:36:36 +0200
Message-ID: <20260726193636.110586-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260726193636.110586-1-deller@kernel.org>
References: <20260726193636.110586-1-deller@kernel.org>
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
index 3a81cc95f4..af1cf9548a 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -4344,7 +4344,7 @@ print_statx(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
-#if defined(TARGET_NR_fsconfig) && defined(NR_fsconfig)
+#if defined(TARGET_NR_fsconfig) && defined(__NR_fsconfig)
 static void
 print_fsconfig_cmd_name(int cmd)
 {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index e363892e0a..ba1c1dc0ae 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1725,7 +1725,7 @@
 #ifdef TARGET_NR_fsopen
 { TARGET_NR_fsopen, "fsopen", "%s(%s,%d)", NULL, NULL },
 #endif
-#if defined(TARGET_NR_fsconfig) && defined(NR_fsconfig)
+#if defined(TARGET_NR_fsconfig) && defined(__NR_fsconfig)
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


