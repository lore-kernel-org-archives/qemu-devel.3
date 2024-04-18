Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4882DC04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVtg-0008AL-T3; Thu, 18 Apr 2024 13:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVte-00089K-OL; Thu, 18 Apr 2024 13:50:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVtc-0007NA-Qv; Thu, 18 Apr 2024 13:50:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 04BAD5FD62;
 Thu, 18 Apr 2024 20:49:59 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4FB95B9338;
 Thu, 18 Apr 2024 20:49:56 +0300 (MSK)
Received: (nullmailer pid 947809 invoked by uid 1000);
 Thu, 18 Apr 2024 17:49:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alex Fan <alex.fan.q@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 089/116] linux-user: Fix waitid return of siginfo_t and
 rusage
Date: Thu, 18 Apr 2024 20:49:19 +0300
Message-Id: <20240418174955.947730-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

The copy back to siginfo_t should be conditional only on arg3,
not the specific values that might have been written.
The copy back to rusage was missing entirely.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2262
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Fan <alex.fan.q@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit f0907ff4cae743f1a4ef3d0a55a047029eed06ff)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e384e14248..834a254895 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9154,14 +9154,24 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_waitid
     case TARGET_NR_waitid:
         {
+            struct rusage ru;
             siginfo_t info;
-            info.si_pid = 0;
-            ret = get_errno(safe_waitid(arg1, arg2, &info, arg4, NULL));
-            if (!is_error(ret) && arg3 && info.si_pid != 0) {
-                if (!(p = lock_user(VERIFY_WRITE, arg3, sizeof(target_siginfo_t), 0)))
+
+            ret = get_errno(safe_waitid(arg1, arg2, (arg3 ? &info : NULL),
+                                        arg4, (arg5 ? &ru : NULL)));
+            if (!is_error(ret)) {
+                if (arg3) {
+                    p = lock_user(VERIFY_WRITE, arg3,
+                                  sizeof(target_siginfo_t), 0);
+                    if (!p) {
+                        return -TARGET_EFAULT;
+                    }
+                    host_to_target_siginfo(p, &info);
+                    unlock_user(p, arg3, sizeof(target_siginfo_t));
+                }
+                if (arg5 && host_to_target_rusage(arg5, &ru)) {
                     return -TARGET_EFAULT;
-                host_to_target_siginfo(p, &info);
-                unlock_user(p, arg3, sizeof(target_siginfo_t));
+                }
             }
         }
         return ret;
-- 
2.39.2


