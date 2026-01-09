Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BABD232FD
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 09:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve8VI-0006xO-D2; Fri, 09 Jan 2026 04:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1ve8VE-0006wT-Qg
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 04:09:53 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1ve8VB-0008Uq-In
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 04:09:52 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2EF3617C2D2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 12:08:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BDD77348AB4;
 Fri, 09 Jan 2026 12:09:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v2 2/2] linux-user: implement epoll_pwait2 syscall
Date: Fri,  9 Jan 2026 12:09:37 +0300
Message-ID: <20260109090937.599881-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109090937.599881-1-mjt@tls.msk.ru>
References: <20260109090937.599881-1-mjt@tls.msk.ru>
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

epoll_pwait2 is the same as epoll_pwait but with timeout being
(a pointer to) struct timespec instead of an integer.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3210
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d89c36382e..8f41cdb94b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -708,8 +708,11 @@ safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
               size_t, sigsetsize)
 #endif
 safe_syscall6(int, epoll_pwait, int, epfd, struct epoll_event *, events,
-              int, maxevents, int, timeout, const sigset_t *, sigmask,
-              size_t, sigsetsize)
+              int, maxevents, int, timeout,
+              const sigset_t *, sigmask, size_t, sigsetsize)
+safe_syscall6(int, epoll_pwait2, int, epfd, struct epoll_event *, events,
+              int, maxevents, struct timespec *, timeout_ts,
+              const sigset_t *, sigmask, size_t, sigsetsize)
 #if defined(__NR_futex)
 safe_syscall6(int,futex,int *,uaddr,int,op,int,val, \
               const struct timespec *,timeout,int *,uaddr2,int,val3)
@@ -13619,12 +13622,20 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_epoll_wait:
 #endif
     case TARGET_NR_epoll_pwait:
+    case TARGET_NR_epoll_pwait2:
     {
         struct target_epoll_event *target_ep;
         struct epoll_event *ep;
         int epfd = arg1;
         int maxevents = arg3;
-        int timeout = arg4;
+        struct timespec ts, *timeout_ts = NULL;
+
+        if (num == TARGET_NR_epoll_pwait2 && arg4 != 0) {
+            if (target_to_host_timespec(&ts, arg4)) {
+                return -TARGET_EFAULT;
+            }
+            timeout_ts = &ts;
+        }
 
         if (maxevents <= 0 || maxevents > TARGET_EP_MAX_EVENTS) {
             return -TARGET_EINVAL;
@@ -13644,6 +13655,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 
         switch (num) {
         case TARGET_NR_epoll_pwait:
+        case TARGET_NR_epoll_pwait2:
         {
             sigset_t *set = NULL;
 
@@ -13654,8 +13666,13 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                 }
             }
 
-            ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, timeout,
-                                             set, SIGSET_T_SIZE));
+            if (num == TARGET_NR_epoll_pwait) {
+                ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, arg4,
+                                                 set, SIGSET_T_SIZE));
+            } else {
+                ret = get_errno(safe_epoll_pwait2(epfd, ep, maxevents, timeout_ts,
+                                                  set, SIGSET_T_SIZE));
+            }
 
             if (set) {
                 finish_sigsuspend_mask(ret);
@@ -13664,7 +13681,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         }
 #if defined(TARGET_NR_epoll_wait)
         case TARGET_NR_epoll_wait:
-            ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, timeout,
+            ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, arg4,
                                              NULL, 0));
             break;
 #endif
-- 
2.47.3


