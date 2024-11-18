Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AFAD591AD
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 18:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD69F-0004aT-68; Mon, 18 Nov 2024 13:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tD69C-0004ZY-97; Mon, 18 Nov 2024 13:06:50 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tD698-0008Qo-NZ; Mon, 18 Nov 2024 13:06:49 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 34B3EA5481;
 Mon, 18 Nov 2024 21:06:31 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8CC4717351A;
 Mon, 18 Nov 2024 21:06:34 +0300 (MSK)
Received: (nullmailer pid 2302450 invoked by uid 1000);
 Mon, 18 Nov 2024 18:06:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@kernel.org>,
 Helge Deller <deller@gmx.de>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.15 34/39] linux-user: Fix setreuid and setregid to use
 direct syscalls
Date: Mon, 18 Nov 2024 21:06:22 +0300
Message-Id: <20241118180634.2302410-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.15-20241118210517@cover.tls.msk.ru>
References: <qemu-stable-7.2.15-20241118210517@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Helge Deller <deller@kernel.org>

The commit fd6f7798ac30 ("linux-user: Use direct syscalls for setuid(),
etc") added direct syscall wrappers for setuid(), setgid(), etc since the
system calls have different semantics than the libc functions.

Add and use the corresponding wrappers for setreuid and setregid which
were missed in that commit.

This fixes the build of the debian package of the uid_wrapper library
(https://cwrap.org/uid_wrapper.html) when running linux-user.

Cc: qemu-stable@nongnu.org
Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <Zyo2jMKqq8hG8Pkz@p100>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 8491026a08b417b2d4070f7c373dcb43134c5312)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 53c46ae951..236076e647 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7233,12 +7233,24 @@ static inline int tswapid(int id)
 #else
 #define __NR_sys_setgroups __NR_setgroups
 #endif
+#ifdef __NR_sys_setreuid32
+#define __NR_sys_setreuid __NR_setreuid32
+#else
+#define __NR_sys_setreuid __NR_setreuid
+#endif
+#ifdef __NR_sys_setregid32
+#define __NR_sys_setregid __NR_setregid32
+#else
+#define __NR_sys_setregid __NR_setregid
+#endif
 
 _syscall1(int, sys_setuid, uid_t, uid)
 _syscall1(int, sys_setgid, gid_t, gid)
 _syscall3(int, sys_setresuid, uid_t, ruid, uid_t, euid, uid_t, suid)
 _syscall3(int, sys_setresgid, gid_t, rgid, gid_t, egid, gid_t, sgid)
 _syscall2(int, sys_setgroups, int, size, gid_t *, grouplist)
+_syscall2(int, sys_setreuid, uid_t, ruid, uid_t, euid);
+_syscall2(int, sys_setregid, gid_t, rgid, gid_t, egid);
 
 void syscall_init(void)
 {
@@ -11399,9 +11411,9 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return get_errno(high2lowgid(getegid()));
 #endif
     case TARGET_NR_setreuid:
-        return get_errno(setreuid(low2highuid(arg1), low2highuid(arg2)));
+        return get_errno(sys_setreuid(low2highuid(arg1), low2highuid(arg2)));
     case TARGET_NR_setregid:
-        return get_errno(setregid(low2highgid(arg1), low2highgid(arg2)));
+        return get_errno(sys_setregid(low2highgid(arg1), low2highgid(arg2)));
     case TARGET_NR_getgroups:
         {
             int gidsetsize = arg1;
@@ -11731,11 +11743,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_setreuid32
     case TARGET_NR_setreuid32:
-        return get_errno(setreuid(arg1, arg2));
+        return get_errno(sys_setreuid(arg1, arg2));
 #endif
 #ifdef TARGET_NR_setregid32
     case TARGET_NR_setregid32:
-        return get_errno(setregid(arg1, arg2));
+        return get_errno(sys_setregid(arg1, arg2));
 #endif
 #ifdef TARGET_NR_getgroups32
     case TARGET_NR_getgroups32:
-- 
2.39.5


