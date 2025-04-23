Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F30CC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 13:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Zo7-0004ZW-GI; Wed, 23 Apr 2025 09:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liushuyu@aosc.io>) id 1u7UQt-0002AW-Bc
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:22:11 -0400
Received: from relay2.mymailcheap.com ([151.80.165.199])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liushuyu@aosc.io>) id 1u7UQr-00016K-Eu
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:22:11 -0400
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
 by relay2.mymailcheap.com (Postfix) with ESMTPS id 737F23E886;
 Wed, 23 Apr 2025 07:22:07 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 by nf1.mymailcheap.com (Postfix) with ESMTPSA id 09F5C40047;
 Wed, 23 Apr 2025 07:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1745392926; bh=j005wxvP8OX0uA6XORtBUYt9Cjj8Ztzc715TLsKGkjk=;
 h=Date:From:To:Cc:Subject:From;
 b=QdjEYcqeDmhaQCaka1zOVCCJvqNEAWb1VS+Olu9jpEkogdHpdy6Fap/5CzfNWmuJe
 xf1MMk6iSX7ryf8Eub4ziTlHcVS4+7QVG3MAn7IGhzA6dm8263JtTxa8Js9fxwQ37u
 TjPlb9I9oy1yhIcJng2IgN3YTrZ66DS5AUu4FzS8=
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 0F8DA4036E;
 Wed, 23 Apr 2025 07:22:06 +0000 (UTC)
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 15:22:05 +0800
From: liushuyu@aosc.io
To: qemu-devel@nongnu.org
Cc: liushuyu011@gmail.com
Subject: [PATCH] linux-user/syscall.c: add translation logic for epoll_pwait2
 syscall
Message-ID: <b4d01956e77d801af6e3d229332a2265@aosc.io>
X-Sender: liushuyu@aosc.io
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.00 / 10.00]; MIME_GOOD(-0.10)[text/plain];
 SUBJECT_RANDOM_CHARS_1(0.10)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
 ARC_NA(0.00)[]; FROM_NO_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_ONE(0.00)[1];
 SPFBL_URIBL_EMAIL_FAIL(0.00)[liushuyu.aosc.io:server fail];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; MISSING_XM_UA(0.00)[]
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 09F5C40047
Received-SPF: pass client-ip=151.80.165.199; envelope-from=liushuyu@aosc.io;
 helo=relay2.mymailcheap.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 23 Apr 2025 09:06:06 -0400
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
@@ -711,6 +711,11 @@ safe_syscall5(int, ppoll, struct pollfd *, ufds, 
unsigned int, nfds,
  safe_syscall6(int, epoll_pwait, int, epfd, struct epoll_event *, 
events,
                int, maxevents, int, timeout, const sigset_t *, sigmask,
                size_t, sigsetsize)
+#if defined(__NR_epoll_pwait2)
+safe_syscall6(int, epoll_pwait2, int, epfd, struct epoll_event *, 
events,
+              int, maxevents, struct timespec *, timeout, const 
sigset_t *, sigmask,
+              size_t, sigsetsize)
+#endif
  #if defined(__NR_futex)
  safe_syscall6(int,futex,int *,uaddr,int,op,int,val, \
                const struct timespec *,timeout,int *,uaddr2,int,val3)
@@ -13363,19 +13368,22 @@ static abi_long do_syscall1(CPUArchState 
*cpu_env, int num, abi_long arg1,
      }
  #endif

-#if defined(TARGET_NR_epoll_wait) || defined(TARGET_NR_epoll_pwait)
+#if defined(TARGET_NR_epoll_wait) || defined(TARGET_NR_epoll_pwait) || 
defined(TARGET_NR_epoll_pwait2)
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
@@ -13396,6 +13404,9 @@ static abi_long do_syscall1(CPUArchState 
*cpu_env, int num, abi_long arg1,
          switch (num) {
  #if defined(TARGET_NR_epoll_pwait)
          case TARGET_NR_epoll_pwait:
+#if defined(TARGET_NR_epoll_pwait2)
+        case TARGET_NR_epoll_pwait2:
+#endif
          {
              sigset_t *set = NULL;

@@ -13406,8 +13417,25 @@ static abi_long do_syscall1(CPUArchState 
*cpu_env, int num, abi_long arg1,
                  }
              }

-            ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, 
timeout,
-                                             set, SIGSET_T_SIZE));
+            if (num == TARGET_NR_epoll_pwait) {
+                ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, 
(int)timeout,
+                                                 set, SIGSET_T_SIZE));
+            } else {
+#if defined(TARGET_NR_epoll_pwait2)
+                struct timespec hspec;
+                struct timespec *ts_arg = NULL;
+                if (timeout) {
+                    if (target_to_host_timespec(&hspec, 
(abi_ulong)timeout)) {
+                        return -TARGET_EFAULT;
+                    }
+                    ts_arg = &hspec;
+                }
+                ret = get_errno(safe_epoll_pwait2(epfd, ep, maxevents, 
ts_arg,
+                                              set, SIGSET_T_SIZE));
+#else
+                return -TARGET_ENOSYS;
+#endif
+            }

              if (set) {
                  finish_sigsuspend_mask(ret);
-- 
2.49.0


