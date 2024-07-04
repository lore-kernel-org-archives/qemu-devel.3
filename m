Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB95CC3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 21:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPTZt-0006v5-OB; Thu, 04 Jul 2024 17:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTZs-0006tI-I7; Thu, 04 Jul 2024 17:01:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTZq-0004LE-Gh; Thu, 04 Jul 2024 17:01:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D1A8677565;
 Fri,  5 Jul 2024 00:00:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E69E8FEC9F;
 Fri,  5 Jul 2024 00:00:55 +0300 (MSK)
Received: (nullmailer pid 1507737 invoked by uid 1000);
 Thu, 04 Jul 2024 21:00:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.2 08/22] linux-user: Make TARGET_NR_setgroups affect only
 the current thread
Date: Fri,  5 Jul 2024 00:00:38 +0300
Message-Id: <20240704210055.1507652-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.2-20240704162154@cover.tls.msk.ru>
References: <qemu-stable-9.0.2-20240704162154@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Like TARGET_NR_setuid, TARGET_NR_setgroups should affect only the
calling thread, and not the entire process. Therefore, implement it
using a syscall, and not a libc call.

Cc: qemu-stable@nongnu.org
Fixes: 19b84f3c35d7 ("added setgroups and getgroups syscalls")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240614154710.1078766-1-iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 54b27921026df384f67df86f04c39539df375c60)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 59fb3e911f..2edbd1ef15 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7210,11 +7210,17 @@ static inline int tswapid(int id)
 #else
 #define __NR_sys_setresgid __NR_setresgid
 #endif
+#ifdef __NR_setgroups32
+#define __NR_sys_setgroups __NR_setgroups32
+#else
+#define __NR_sys_setgroups __NR_setgroups
+#endif
 
 _syscall1(int, sys_setuid, uid_t, uid)
 _syscall1(int, sys_setgid, gid_t, gid)
 _syscall3(int, sys_setresuid, uid_t, ruid, uid_t, euid, uid_t, suid)
 _syscall3(int, sys_setresgid, gid_t, rgid, gid_t, egid, gid_t, sgid)
+_syscall2(int, sys_setgroups, int, size, gid_t *, grouplist)
 
 void syscall_init(void)
 {
@@ -11892,7 +11898,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                 unlock_user(target_grouplist, arg2,
                             gidsetsize * sizeof(target_id));
             }
-            return get_errno(setgroups(gidsetsize, grouplist));
+            return get_errno(sys_setgroups(gidsetsize, grouplist));
         }
     case TARGET_NR_fchown:
         return get_errno(fchown(arg1, low2highuid(arg2), low2highgid(arg3)));
@@ -12228,7 +12234,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                 }
                 unlock_user(target_grouplist, arg2, 0);
             }
-            return get_errno(setgroups(gidsetsize, grouplist));
+            return get_errno(sys_setgroups(gidsetsize, grouplist));
         }
 #endif
 #ifdef TARGET_NR_fchown32
-- 
2.39.2


