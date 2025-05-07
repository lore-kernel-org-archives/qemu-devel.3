Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDDDC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 18:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCj83-00086u-Hj; Wed, 07 May 2025 14:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uCj7z-00085E-Ni; Wed, 07 May 2025 14:04:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uCj7x-00088u-1Z; Wed, 07 May 2025 14:04:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D8C1111FEF6;
 Wed, 07 May 2025 21:03:59 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B55CB2066FB;
 Wed,  7 May 2025 21:04:12 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Zixing Liu <liushuyu@aosc.io>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 01/21] linux-user/syscall.c: add translation logic for
 epoll_pwait2 syscall
Date: Wed,  7 May 2025 21:03:52 +0300
Message-Id: <20250507180412.182797-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250507180412.182797-1-mjt@tls.msk.ru>
References: <20250507180412.182797-1-mjt@tls.msk.ru>
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

From: Zixing Liu <liushuyu@aosc.io>

Signed-off-by: Zixing Liu <liushuyu@aosc.io>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 23b901b713..d2335cb823 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -712,6 +712,11 @@ safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
 safe_syscall6(int, epoll_pwait, int, epfd, struct epoll_event *, events,
               int, maxevents, int, timeout, const sigset_t *, sigmask,
               size_t, sigsetsize)
+#if defined(__NR_epoll_pwait2)
+safe_syscall6(int, epoll_pwait2, int, epfd, struct epoll_event *, events,
+              int, maxevents, struct timespec *, timeout, const sigset_t *, sigmask,
+              size_t, sigsetsize)
+#endif
 #if defined(__NR_futex)
 safe_syscall6(int,futex,int *,uaddr,int,op,int,val, \
               const struct timespec *,timeout,int *,uaddr2,int,val3)
@@ -13364,19 +13369,22 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     }
 #endif
 
-#if defined(TARGET_NR_epoll_wait) || defined(TARGET_NR_epoll_pwait)
+#if defined(TARGET_NR_epoll_wait) || defined(TARGET_NR_epoll_pwait) || defined(TARGET_NR_epoll_pwait2)
 #if defined(TARGET_NR_epoll_wait)
     case TARGET_NR_epoll_wait:
 #endif
 #if defined(TARGET_NR_epoll_pwait)
     case TARGET_NR_epoll_pwait:
+#endif
+#if defined(TARGET_NR_epoll_pwait2)
+    case TARGET_NR_epoll_pwait2:
 #endif
     {
         struct target_epoll_event *target_ep;
         struct epoll_event *ep;
         int epfd = arg1;
         int maxevents = arg3;
-        int timeout = arg4;
+        abi_long timeout = arg4;
 
         if (maxevents <= 0 || maxevents > TARGET_EP_MAX_EVENTS) {
             return -TARGET_EINVAL;
@@ -13397,6 +13405,9 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         switch (num) {
 #if defined(TARGET_NR_epoll_pwait)
         case TARGET_NR_epoll_pwait:
+#if defined(TARGET_NR_epoll_pwait2)
+        case TARGET_NR_epoll_pwait2:
+#endif
         {
             sigset_t *set = NULL;
 
@@ -13407,8 +13418,25 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                 }
             }
 
-            ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, timeout,
-                                             set, SIGSET_T_SIZE));
+            if (num == TARGET_NR_epoll_pwait) {
+                ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, (int)timeout,
+                                                 set, SIGSET_T_SIZE));
+            } else {
+#if defined(TARGET_NR_epoll_pwait2)
+                struct timespec hspec;
+                struct timespec *ts_arg = NULL;
+                if (timeout) {
+                    if (target_to_host_timespec(&hspec, (abi_ulong)timeout)) {
+                        return -TARGET_EFAULT;
+                    }
+                    ts_arg = &hspec;
+                }
+                ret = get_errno(safe_epoll_pwait2(epfd, ep, maxevents, ts_arg,
+                                              set, SIGSET_T_SIZE));
+#else
+                return -TARGET_ENOSYS;
+#endif
+            }
 
             if (set) {
                 finish_sigsuspend_mask(ret);
-- 
2.39.5


