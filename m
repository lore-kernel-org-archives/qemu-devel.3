Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F57BCD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxP-0001fr-7I; Fri, 15 May 2026 17:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxN-0001c7-Uc
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:29 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxL-00030J-N0
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:29 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-47bdee5bfc4so170518b6e.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880026; x=1779484826;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AoHEtuYMkVdqIlfawsmYMiZ+fZ9BGCllJjcLT+LPjRQ=;
 b=BFoC1Tr7YigCIjnBLaQsl21guGu7GIjtg4XMRxU2PHlrmPwE5Wa5Vfod9RrJh6u6bh
 0Pm+xTnrz5OPzpWg2ZF5y8BN8bQwJRGjFGzHErjkfeNzcgMT80xGZAyc8KYeCcxUz2CS
 VpTr+NCxDgj5gg/dbbQCWy+7JFdag0xbjpYoyOlYPgOTPUmQewrLC9EpgFAnuCxBI3QL
 Hi7C9n+/cyDd9PICqDIN0OQ2WleOQSw9SRmKVuQ9VUL4/BoBgC3w7NG2dhgLk4AVICbN
 CZKMsGgRJ98TpQPK7E0M2/Wem6uZiFgpddPQR3/GKa5GEiHAND6wtQqm2KKIC5id9g3z
 3c0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880026; x=1779484826;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AoHEtuYMkVdqIlfawsmYMiZ+fZ9BGCllJjcLT+LPjRQ=;
 b=p6wDRl9GQjyIKSuWd3vPVF1/Y99CeR4b9ajHZ49zt8xGLtImV26XBXwSCGVRCOxAwp
 IKnHxC4sN8HuKpOHfp2xUHez3pbS+LkQgS1vrXpkH8PRwNWSAoexlVrDyRpEIP0wwjAf
 eCZCv+bwjW56qBpL4bBKuXJfj1ZqWWpOfkRKwWkdm2Va5JL9Jd0rfu5pKnRheqnRpuZP
 4AoFoy5JhyL2vRozABTmPbx4jcKQmvQJdlSZKVm6FnuzcBqdCqoDGVfDgDjp94yola/6
 bivoEsfQbtaFFGaIkehmF+OYb6rfT+Mzg9mBSrRyQg3Ib1qTof+UdPaNCcHWXcuWtWxC
 PiIw==
X-Gm-Message-State: AOJu0YwGR4xETZtH1OfnuDtAURFkO1U0oq/AW3nQ4oLJrWGbxOiUgCeb
 7govETC9nVjhtXcnk5d0yhkJxXKm8XEoBvX1/b6qXX5TBo8uO5PDHR1JlXbBCbANuf4=
X-Gm-Gg: Acq92OGaRKknsGXzEf1ok0lL4wIIxO4g8Tu73sedmtXEuIUz9yzu6a3CmwnHxejSxXD
 23XwYN4BVGmI+szxPYevpUVGRDjTF0SrRH9D8uoLz8nnBrOmHAg4kDQHvR1Vt96qCMVSHNLr3PU
 MtfXaXPb90NFYX7pb406mVRo/BRRrIYbx4uK2ccBVGOflLQfSlwpLFiq7Iq6MyQVBPG2BEhAog/
 q+TfGSA/A/rotflza0OOeZU6u0eQxezDmvuFbCBLK7FLRZp9JPSNpjTxnVUxkY26lLyIAHbTiCW
 TByJwS2vbx+dDBMs4+YSd3FTR5N02DpqFjlqls5Ti/bm/DnNtK+eVs8T+v12y6wD0BlqcB7kvZo
 Cd2w/jBA97m7BdnSOWcI3h9xh93hxmrMwLuUT+KsojInL5J8ycCdmJ0tlnc30+bv8hyn/e8rimZ
 1h7R9i/tu2XPyAo3oefB3V
X-Received: by 2002:a05:6808:118c:b0:47b:2b67:71a1 with SMTP id
 5614622812f47-482cb7a8b93mr5365817b6e.14.1778880026609; 
 Fri, 15 May 2026 14:20:26 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:26 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:23 -0600
Subject: [PATCH 24/66] bsd-user: Add thread, umtx, and ACL type definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-24-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5796; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=eYcd23KlONZHr+bUC+1S1HGMVw1Rm4rDf8qWIjZHXxE=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43jjvkLmrnpASqmHUWN63ZsuRkm8v7w8vRko
 hSVYvuJeRiJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4wAKCRBsHNEofbAR
 AJbeD/9sjJ02pp9Ws/cQbdSRtQh7ksryslngOdJ1xZAWlM6sdo5FMoZuZeJAz0GIU80YeqzYvEN
 rBiBjBxYxGYoxLJZ0r6UpMT3JFT2LsB37fo7nMm2UD/uU4da+8nfLfKZZHNtRHx2E3TrrHv81AY
 xq51oqQZLabqj67VEab36xotLBKdT5rjuAYeyOX9rqnmzd/+4WP2qPPhpGKeic6oiwVgeG47JRI
 oCHec1ZaLYUZ+pzVkVCdzdMlStV5H2BxTZFD1LgnHYiLeLgCMPxXSy3NcrOHqGkRxS0iTnhA07R
 DAoGzN7/Gdc5Ou4lILWEz8ThD7JHItFRcfbUxxPvzXg0JMHrQb4h+jWdoxYP6Jkknvd07pfLCWe
 VOcOtC92YykH86Wh3TJqNK3p+SJhOjpA2uz2GTq3vv+5DVNS7x+XSMzA3VA9z4juZi3/pk96dM+
 OzBukfUkzppahFOIdmTdGj5bXIveBsrLvkZoVUdJ0nVsJMx8cyFlKz56w7wP0hdnp5cpbZqtgN+
 WH3CZOFt7i3/TPGQdyBG55Rs4rNkpQM6/mNERq51x7TV+VrlH/L8lTK+Xdc6P2yfmE2Xu1FlD1F
 4dkz9QN6zNZLyLdYykz/JxrD4FL8h0HPv7l8j9EXCjDfnWew3BHtLBGdMOVU0Ga5pUCz8qfKM3y
 /lLk/tmebS9bXQQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22f;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add target_freebsd_thr_param, target_freebsd_rtprio,
new_freebsd_thread_info_t, TARGET_UMTX_OP_* opcodes, umutex/urwlock
flags, and target_freebsd_acl structures to syscall_defs.h. Add forward
declarations for os-time.c, os-socket.c, os-thread.c, and os-extattr.c
functions to qemu-os.h. Add thread and umtx function declarations to
qemu.h.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/qemu-os.h | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 bsd-user/qemu.h            | 41 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/bsd-user/freebsd/qemu-os.h b/bsd-user/freebsd/qemu-os.h
index 12adc50928..bdd28f27a0 100644
--- a/bsd-user/freebsd/qemu-os.h
+++ b/bsd-user/freebsd/qemu-os.h
@@ -32,6 +32,53 @@
 
 struct freebsd11_stat;
 
+/* os-time.c */
+abi_long t2h_freebsd_timeval(struct timeval *tv, abi_ulong target_tv_addr);
+abi_long h2t_freebsd_timeval(struct timeval *tv, abi_ulong target_tv_addr);
+
+abi_long t2h_freebsd_timespec(struct timespec *ts, abi_ulong target_ts_addr);
+abi_long h2t_freebsd_timespec(abi_ulong target_ts_addr, struct timespec *ts);
+
+abi_long t2h_freebsd_umtx_time(abi_ulong target_ut_addr,
+        abi_ulong target_ut_size, void *host_t, size_t *host_tsz);
+
+abi_long t2h_freebsd_timex(struct timex *host_tx, abi_ulong target_tx_addr);
+
+abi_long h2t_freebsd_ntptimeval(abi_ulong target_ntv_addr,
+        struct ntptimeval *ntv);
+
+abi_ulong copy_from_user_fdset(fd_set *fds, abi_ulong target_fds_addr, int n);
+abi_ulong copy_from_user_fdset_ptr(fd_set *fds, fd_set **fds_ptr,
+        abi_ulong target_fds_addr, int n);
+abi_long copy_to_user_fdset(abi_ulong target_fds_addr, const fd_set *fds,
+        int n);
+
+abi_int next_free_host_timer(void);
+int host_to_target_timerid(int timerid);
+abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
+        abi_ulong target_addr);
+abi_long host_to_target_itimerspec(abi_ulong target_addr,
+        struct itimerspec *host_its);
+int get_timer_id(abi_long arg);
+
+/* os-socket.c */
+abi_long t2h_freebsd_cmsg(struct msghdr *msgh,
+                struct target_msghdr *target_msgh);
+abi_long h2t_freebsd_cmsg(struct target_msghdr *target_msgh,
+                struct msghdr *msgh);
+
+/* os-thread.c */
+abi_long t2h_freebsd_rtprio(struct rtprio *host_rtp, abi_ulong target_addr);
+abi_long h2t_freebsd_rtprio(abi_ulong target_addr, struct rtprio *host_rtp);
+abi_long do_freebsd_thr_new(CPUArchState *env, abi_ulong target_param_addr,
+        int32_t param_size);
+
+/* os-extattr.c */
+struct acl;
+abi_long t2h_freebsd_acl(struct acl *host_acl, abi_ulong target_addr);
+abi_long h2t_freebsd_acl(abi_ulong target_addr, struct acl *host_acl);
+abi_long t2h_freebsd_acl_type(acl_type_t *host_type, abi_long target_type);
+
 /* os-stat.c */
 abi_long h2t_freebsd11_stat(abi_ulong target_addr,
         struct freebsd11_stat *host_st);
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 60d1adf560..069baa7011 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -249,6 +249,47 @@ abi_long do_freebsd_sysctlbyname(CPUArchState *env, abi_ulong namep,
         abi_ulong newlen);
 abi_long do_freebsd_sysarch(CPUArchState *env, abi_long arg1, abi_long arg2);
 
+/* os-thread.c */
+extern pthread_mutex_t *new_freebsd_thread_lock_ptr;
+extern pthread_mutex_t *freebsd_umtx_wait_lck_ptr;
+void *new_freebsd_thread_start(void *arg);
+abi_long freebsd_lock_umtx(abi_ulong target_addr, abi_long tid,
+        size_t tsz, void *t);
+abi_long freebsd_unlock_umtx(abi_ulong target_addr, abi_long id);
+abi_long freebsd_umtx_wait(abi_ulong targ_addr, abi_ulong id,
+        size_t tsz, void *t);
+abi_long freebsd_umtx_wake(abi_ulong target_addr, uint32_t n_wake);
+abi_long freebsd_umtx_wake_unsafe(abi_ulong target_addr, uint32_t n_wake);
+abi_long freebsd_umtx_mutex_wake(abi_ulong target_addr, abi_long val);
+abi_long freebsd_umtx_wait_uint(abi_ulong obj, uint32_t val, size_t tsz,
+        void *t);
+abi_long freebsd_umtx_wait_uint_private(abi_ulong obj, uint32_t val,
+        size_t tsz, void *t);
+abi_long freebsd_umtx_wake_private(abi_ulong obj, uint32_t val);
+abi_long freebsd_umtx_nwake_private(abi_ulong obj, uint32_t val);
+abi_long freebsd_umtx_mutex_wake2(abi_ulong obj, uint32_t val);
+abi_long freebsd_umtx_sem2_wait(abi_ulong obj, size_t tsz, void *t);
+abi_long freebsd_umtx_sem2_wake(abi_ulong obj);
+abi_long freebsd_umtx_sem_wait(abi_ulong obj, size_t tsz, void *t);
+abi_long freebsd_umtx_sem_wake(abi_ulong obj);
+abi_long freebsd_lock_umutex(abi_ulong target_addr, uint32_t id,
+        void *ts, size_t tsz, int mode, abi_ulong val);
+abi_long freebsd_unlock_umutex(abi_ulong target_addr, uint32_t id);
+abi_long freebsd_cv_wait(abi_ulong target_ucond_addr,
+        abi_ulong target_umtx_addr, struct timespec *ts, int wflags);
+abi_long freebsd_cv_signal(abi_ulong target_ucond_addr);
+abi_long freebsd_cv_broadcast(abi_ulong target_ucond_addr);
+abi_long freebsd_rw_rdlock(abi_ulong target_addr, long fflag,
+        size_t tsz, void *t);
+abi_long freebsd_rw_wrlock(abi_ulong target_addr, long fflag,
+        size_t tsz, void *t);
+abi_long freebsd_rw_unlock(abi_ulong target_addr);
+abi_long freebsd_umtx_shm(abi_ulong target_addr, long fflag);
+abi_long freebsd_umtx_robust_list(abi_ulong target_addr, size_t rbsize);
+abi_long freebsd_set_ceiling(abi_ulong target_addr, uint32_t ceiling,
+        uint32_t *old_ceiling);
+CPUArchState *cpu_copy(CPUArchState *env);
+
 /* user access */
 
 #define VERIFY_READ  PAGE_READ

-- 
2.52.0


