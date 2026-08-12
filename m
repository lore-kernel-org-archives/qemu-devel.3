Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F14FC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8hk-0006od-Ov; Wed, 12 Aug 2026 09:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8he-0006Ro-DH; Wed, 12 Aug 2026 09:09:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8hc-0005Zw-QM; Wed, 12 Aug 2026 09:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=cm+RngBCSo2MhFjaQiMg9CYUF+ABKc3VhfkjtJs3reE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uTPA7WomNfjUKHQ0rc/Kjk/0NLY7SVY55EbJt55XG/p0n0g9UVfPfuP4rp5Dhrxk/
 XiD2w6wa7dlHVqt4nRsFo+WSEFen5ExjAQGiSzVOtTEjTo9sSaAAbQhA8NgQftpPMA
 Gk4Jsg/KNfV7iA4sIiH4m4JeKSXVxT4gLx4ieLZbDbTcJDBWUIgrmDeifG3cylJOxr
 aydD3QviNlj2tP0oijzlSRV+tAwzfEmUwPSvSKrx68+vXQs7oKYoJ5OCBdM0xNn53o
 1dxgOTkKfRUdYKHI76Py2Pkn4gH5DtTSIlJYXNN7dAwXkfU3A/PCon7gnHMFcYUumw
 t5f6c3/tc23fA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 361181CA4BD;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6C66D409BA0;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6E6A72F910; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 062/102] linux-user: fix guards for the fsmount(2)
 syscall series
Date: Wed, 12 Aug 2026 16:01:37 +0300
Message-ID: <20260812130233.621965-62-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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
Fixes: ec4c92057b73 in 10.0.x
Fixes: 6e0aa9f6c731 ("linux-user/strace: add fsmount series of syscalls")
Fixes: f5e02d6a301e in 10.0.x
Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit aba80ad9d853e436047899177f92334379de4537)
(Mjt: context fixup for 10.0.x)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/strace.c b/linux-user/strace.c
index d103ac00304..04464abded2 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -4312,7 +4312,7 @@ print_statx(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
-#if defined(TARGET_NR_fsconfig) && defined(NR_fsconfig)
+#if defined(TARGET_NR_fsconfig) && defined(__NR_fsconfig) && defined(FSCONFIG_SET_FLAG)
 static void
 print_fsconfig_cmd_name(int cmd)
 {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 6a5b27d4acf..e496bd4cab8 100644
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
index 5d7c37017a3..019ce72613b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9458,7 +9458,7 @@ _syscall5(int, sys_move_mount, int, __from_dfd, const char *, __from_pathname,
            int, __to_dfd, const char *, __to_pathname, unsigned int, flag)
 #endif
 
-#if defined(TARGET_NR_fsopen) && defined(NR_fsopen)
+#if defined(TARGET_NR_fsopen) && defined(__NR_fsopen)
 #define __NR_sys_fsopen __NR_fsopen
 _syscall2(int, sys_fsopen, const char *, fs_name, unsigned int, flags);
 #define __NR_sys_fsconfig __NR_fsconfig
@@ -14184,7 +14184,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return do_riscv_hwprobe(cpu_env, arg1, arg2, arg3, arg4, arg5);
 #endif
 
-#if defined(TARGET_NR_fsopen) && defined(NR_fsopen)
+#if defined(TARGET_NR_fsopen) && defined(__NR_fsopen)
     case TARGET_NR_fsopen:
         {
             p = lock_user_string(arg1);
-- 
2.47.3


