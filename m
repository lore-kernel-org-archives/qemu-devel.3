Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7F3C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 13:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Zo3-0004Wd-8P; Wed, 23 Apr 2025 09:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1u7UwW-0007bv-Id; Wed, 23 Apr 2025 03:54:52 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1u7UwR-0004yE-SZ; Wed, 23 Apr 2025 03:54:52 -0400
DKIM-Signature: a=rsa-sha256; bh=JK3oAK8L/MMlxU8luzMFG3Munc7mTZPKsq7E4Di/6Lk=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1745394883; v=1;
 b=E6/Igbz/UKitnx6UoL0zG0UgoIXAEcmtAvxR0TJ1QQgfUqhqOQ/B4Bcl8XHfzBL7Pc1tXYmP
 PX/1WAVgoBXXkqT/t3ebZ6mC10dxJ2axcg2s0iin8MFKFeZFMOjg9nAOr4wa7bciDI8fy/VQV/X
 CiSykSPCDkxKy7J4FQEzfTilIvz51+3MdJGW5hv3Wob6nCGC5HBJBSsFNPtTlHC0pmRdqDGZqcD
 jpkJgEgWwgGf7bBVWbcxSjmNgb8U9J8SJsJnh9leutmCZo3/5l0/f9hnUK/fsZZ38Jdbb0YrJ+w
 1vZnhQu87XGX6lrtOMSKoq64ln9q3q2KNXWVbRjIOchIA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 1AC0F21391;
 Wed, 23 Apr 2025 07:54:43 +0000 (UTC)
From: ~liushuyu <liushuyu@git.sr.ht>
Date: Tue, 22 Apr 2025 10:35:00 +0800
Subject: [PATCH qemu] linux-user/syscall.c: add translation logic for
 epoll_pwait2 syscall
Message-ID: <174539488306.23673.10433396305045773139-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, liushuyu@aosc.io
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 20
X-Spam_score: 2.0
X-Spam_bar: ++
X-Spam_report: (2.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095,
 FREEMAIL_REPLYTO_END_DIGIT=0.25, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 23 Apr 2025 09:06:04 -0400
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
Reply-To: ~liushuyu <liushuyu011@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zixing Liu <liushuyu@aosc.io>

Signed-off-by: Zixing Liu <liushuyu@aosc.io>
---
 linux-user/syscall.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8bfe4912e1..6906e7ba38 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -711,6 +711,11 @@ safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigne=
d int, nfds,
 safe_syscall6(int, epoll_pwait, int, epfd, struct epoll_event *, events,
               int, maxevents, int, timeout, const sigset_t *, sigmask,
               size_t, sigsetsize)
+#if defined(__NR_epoll_pwait2)
+safe_syscall6(int, epoll_pwait2, int, epfd, struct epoll_event *, events,
+              int, maxevents, struct timespec *, timeout, const sigset_t *, =
sigmask,
+              size_t, sigsetsize)
+#endif
 #if defined(__NR_futex)
 safe_syscall6(int,futex,int *,uaddr,int,op,int,val, \
               const struct timespec *,timeout,int *,uaddr2,int,val3)
@@ -13363,19 +13368,22 @@ static abi_long do_syscall1(CPUArchState *cpu_env, =
int num, abi_long arg1,
     }
 #endif
=20
-#if defined(TARGET_NR_epoll_wait) || defined(TARGET_NR_epoll_pwait)
+#if defined(TARGET_NR_epoll_wait) || defined(TARGET_NR_epoll_pwait) || defin=
ed(TARGET_NR_epoll_pwait2)
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
         int epfd =3D arg1;
         int maxevents =3D arg3;
-        int timeout =3D arg4;
+        abi_long timeout =3D arg4;
=20
         if (maxevents <=3D 0 || maxevents > TARGET_EP_MAX_EVENTS) {
             return -TARGET_EINVAL;
@@ -13396,6 +13404,9 @@ static abi_long do_syscall1(CPUArchState *cpu_env, in=
t num, abi_long arg1,
         switch (num) {
 #if defined(TARGET_NR_epoll_pwait)
         case TARGET_NR_epoll_pwait:
+#if defined(TARGET_NR_epoll_pwait2)
+        case TARGET_NR_epoll_pwait2:
+#endif
         {
             sigset_t *set =3D NULL;
=20
@@ -13406,8 +13417,25 @@ static abi_long do_syscall1(CPUArchState *cpu_env, i=
nt num, abi_long arg1,
                 }
             }
=20
-            ret =3D get_errno(safe_epoll_pwait(epfd, ep, maxevents, timeout,
-                                             set, SIGSET_T_SIZE));
+            if (num =3D=3D TARGET_NR_epoll_pwait) {
+                ret =3D get_errno(safe_epoll_pwait(epfd, ep, maxevents, (int=
)timeout,
+                                                 set, SIGSET_T_SIZE));
+            } else {
+#if defined(TARGET_NR_epoll_pwait2)
+                struct timespec hspec;
+                struct timespec *ts_arg =3D NULL;
+                if (timeout) {
+                    if (target_to_host_timespec(&hspec, (abi_ulong)timeout))=
 {
+                        return -TARGET_EFAULT;
+                    }
+                    ts_arg =3D &hspec;
+                }
+                ret =3D get_errno(safe_epoll_pwait2(epfd, ep, maxevents, ts_=
arg,
+                                              set, SIGSET_T_SIZE));
+#else
+                return -TARGET_ENOSYS;
+#endif
+            }
=20
             if (set) {
                 finish_sigsuspend_mask(ret);
--=20
2.45.3

