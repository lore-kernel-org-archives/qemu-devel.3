Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA366C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 13:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Zno-0004Sz-Ue; Wed, 23 Apr 2025 09:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liushuyu@aosc.io>) id 1u7UCB-0007ZD-CB
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:07:01 -0400
Received: from relay3.mymailcheap.com ([217.182.66.161])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liushuyu@aosc.io>) id 1u7UC7-0007Cb-HJ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:06:58 -0400
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
 by relay3.mymailcheap.com (Postfix) with ESMTPS id E92FD3E8FD
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 07:06:49 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 by nf1.mymailcheap.com (Postfix) with ESMTPSA id 545A140009
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 07:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1745392009; bh=ywaMDFSvOEiAd55OmAYPF4TmtjYsJYhO3Cd/jQYR9tA=;
 h=From:To:Cc:Subject:Date:From;
 b=aiZayUHg+rhH0t8iAQejncP0ws5SumwjhDZlLO1cPkrIKBvGmFga8LMRuGHX2YhcW
 PFTuRKKqFD5uZWO9R1Iol/gIpQAeOyuwQ4ewtNlC0c78lb7GCDVEdVOK4GUDaRC14i
 mOJkeo3KQBg9/N0PQMRIKZNLcNaOXL84Bdn0h8zA=
Received: from localhost.localdomain (unknown [117.151.12.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 0750C40165;
 Wed, 23 Apr 2025 07:06:46 +0000 (UTC)
From: Zixing Liu <liushuyu@aosc.io>
To: qemu-devel@nongnu.org
Cc: Zixing Liu <liushuyu@aosc.io>
Subject: [PATCH] linux-user/syscall.c: add translation logic for epoll_pwait2
 syscall
Date: Wed, 23 Apr 2025 15:06:00 +0800
Message-ID: <20250423070605.2989622-1-liushuyu@aosc.io>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.50 / 10.00]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 SUBJECT_RANDOM_CHARS_1(0.10)[];
 ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
 RCVD_COUNT_ONE(0.00)[1]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPFBL_URIBL_EMAIL_FAIL(0.00)[liushuyu.aosc.io:server fail];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 545A140009
Received-SPF: pass client-ip=217.182.66.161; envelope-from=liushuyu@aosc.io;
 helo=relay3.mymailcheap.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 23 Apr 2025 09:06:05 -0400
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

Signed-off-by: Zixing Liu <liushuyu@aosc.io>
---
 linux-user/syscall.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8bfe491..6906e7b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -711,6 +711,11 @@ safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
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
@@ -13363,19 +13368,22 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
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
@@ -13396,6 +13404,9 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         switch (num) {
 #if defined(TARGET_NR_epoll_pwait)
         case TARGET_NR_epoll_pwait:
+#if defined(TARGET_NR_epoll_pwait2)
+        case TARGET_NR_epoll_pwait2:
+#endif
         {
             sigset_t *set = NULL;
 
@@ -13406,8 +13417,25 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
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
2.49.0


