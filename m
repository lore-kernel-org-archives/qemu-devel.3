Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CA2D2D0EB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 13:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfe0X-0006W3-0W; Tue, 13 Jan 2026 08:00:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vfe0T-0006NF-Dr; Tue, 13 Jan 2026 08:00:21 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vfe0R-00013H-Kn; Tue, 13 Jan 2026 08:00:21 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8A37117D9E0;
 Tue, 13 Jan 2026 16:00:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 83EA634C417;
 Tue, 13 Jan 2026 16:00:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH trivial 3/7] linux-user: assume inotify sycalls are always
 present
Date: Tue, 13 Jan 2026 16:00:03 +0300
Message-ID: <20260113130008.910240-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113130008.910240-1-mjt@tls.msk.ru>
References: <20260113130008.910240-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

inotify_init() and other syscalls appeared in linux 2.6.13,
inotify_init1() - in linux 2.6.27.

There's no need to check their presence on linux anymore.

Keep condition on TARGET_NR_inotify_init because modern
architectures have only more generic inotify_init1().

Other, not linux-specific, places of the code checks for
inotify_init1() syscall only.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/fd-trans.c |  5 -----
 linux-user/fd-trans.h |  4 ----
 linux-user/syscall.c  | 19 ++-----------------
 3 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index f83d1f79d5..64dd0745d2 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -18,9 +18,7 @@
 #include <sys/signalfd.h>
 #include <linux/unistd.h>
 #include <linux/audit.h>
-#ifdef CONFIG_INOTIFY
 #include <sys/inotify.h>
-#endif
 #include <linux/netlink.h>
 #ifdef CONFIG_RTNETLINK
 #include <linux/rtnetlink.h>
@@ -1861,8 +1859,6 @@ TargetFdTrans target_timerfd_trans = {
     .host_to_target_data = swap_data_u64,
 };
 
-#if defined(CONFIG_INOTIFY) && (defined(TARGET_NR_inotify_init) || \
-        defined(TARGET_NR_inotify_init1))
 static abi_long host_to_target_data_inotify(void *buf, size_t len)
 {
     struct inotify_event *ev;
@@ -1885,4 +1881,3 @@ static abi_long host_to_target_data_inotify(void *buf, size_t len)
 TargetFdTrans target_inotify_trans = {
     .host_to_target_data = host_to_target_data_inotify,
 };
-#endif
diff --git a/linux-user/fd-trans.h b/linux-user/fd-trans.h
index e14f96059c..3bbc15fa1f 100644
--- a/linux-user/fd-trans.h
+++ b/linux-user/fd-trans.h
@@ -141,9 +141,5 @@ extern TargetFdTrans target_netlink_audit_trans;
 extern TargetFdTrans target_signalfd_trans;
 extern TargetFdTrans target_eventfd_trans;
 extern TargetFdTrans target_timerfd_trans;
-#if (defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)) || \
-    (defined(CONFIG_INOTIFY1) && defined(TARGET_NR_inotify_init1) && \
-     defined(__NR_inotify_init1))
 extern TargetFdTrans target_inotify_trans;
 #endif
-#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9cc9ed2fbc..fad2bf3632 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -497,15 +497,7 @@ static int sys_renameat2(int oldfd, const char *old,
 #endif
 #endif /* TARGET_NR_renameat2 */
 
-#ifdef CONFIG_INOTIFY
 #include <sys/inotify.h>
-#else
-/* Userspace can usually survive runtime without inotify */
-#undef TARGET_NR_inotify_init
-#undef TARGET_NR_inotify_init1
-#undef TARGET_NR_inotify_add_watch
-#undef TARGET_NR_inotify_rm_watch
-#endif /* CONFIG_INOTIFY  */
 
 #if defined(TARGET_NR_prlimit64)
 #ifndef __NR_prlimit64
@@ -13267,8 +13259,8 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_futex_time64:
         return do_futex(cpu, true, arg1, arg2, arg3, arg4, arg5, arg6);
 #endif
-#ifdef CONFIG_INOTIFY
-#if defined(TARGET_NR_inotify_init)
+
+#ifdef TARGET_NR_inotify_init
     case TARGET_NR_inotify_init:
         ret = get_errno(inotify_init());
         if (ret >= 0) {
@@ -13276,7 +13268,6 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
-#if defined(TARGET_NR_inotify_init1) && defined(CONFIG_INOTIFY1)
     case TARGET_NR_inotify_init1:
         ret = get_errno(inotify_init1(target_to_host_bitmask(arg1,
                                           fcntl_flags_tbl)));
@@ -13284,19 +13275,13 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             fd_trans_register(ret, &target_inotify_trans);
         }
         return ret;
-#endif
-#if defined(TARGET_NR_inotify_add_watch)
     case TARGET_NR_inotify_add_watch:
         p = lock_user_string(arg2);
         ret = get_errno(inotify_add_watch(arg1, path(p), arg3));
         unlock_user(p, arg2, 0);
         return ret;
-#endif
-#if defined(TARGET_NR_inotify_rm_watch)
     case TARGET_NR_inotify_rm_watch:
         return get_errno(inotify_rm_watch(arg1, arg2));
-#endif
-#endif
 
 #if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
     case TARGET_NR_mq_open:
-- 
2.47.3


