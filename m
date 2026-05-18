Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B9DCD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5Vo-0000YN-Ga; Mon, 18 May 2026 17:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Ve-0000VB-Sp
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:22 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Va-0000W5-Q6
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:21 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-479dd56d016so2331437b6e.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139696; x=1779744496;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e1KKh3NJyoAfAywDQWcClG1KUzUlSs1U1KJ4/IY95AA=;
 b=gxaxx4YKZyeDr2ivO/a5vdRh1R9sDD7g+F18CvSz778KV+4LsRRn/5ud+Cu41hE4Ef
 6KHigl5ZUZG2dR3ZNEUN/Fgv9t9NXWomojeD1BXZOE0MhVJpZpF+nY8iNoZQ9fgBovtx
 bsh5X5HSY8clD2g3Q2EK3Vzg3GX38RtjsWNMCrV3rbu39Vv3CJPWCGxBjY3WFYkqcd2e
 Q/Zrtkf0Wm1+5nYIXnx5wLgPLkdgkDEBdtyYAQpdmEZu/+DWDUqXReFjimFgFVBS3uSs
 p1doxi61zpPFKMKfxMD/K6LFohd/TF9/EoGc3cLCB1Vc2ZoyjT9wRhtYMz9JfgFBkurB
 5o0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139696; x=1779744496;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e1KKh3NJyoAfAywDQWcClG1KUzUlSs1U1KJ4/IY95AA=;
 b=Dth45ZhOoiiT7ruJgdqNz4yCoiI15U3DAjZcvj6wmB2nfWMk1bS9ZYtLP8wjv+Htyh
 n/s4q/tdXesRRCOWYXH7N5V3Pm+26UB+IPuXGACs6+/DM0z1u4ZROsI3BfE+HdOX/ZDO
 wST7vExyzbnXdjdBUGJ7cREyqQKY9GKxQ/zVSqCiD0ns1as4nroGlXu/bMcYv+xzehWH
 dM1368SoW67XtCY9uhmfbHjtcZykBomB164CkIdjixM+gKDL6a+AEQ+AqVxSvGRUj/yc
 Jj9Pdy3zt9vbCtTZv0xlwuwmu9xH/tBLDyvHkW/g5HjrKgdWEwC0ZsqSl31fP4cd1Tvg
 jkGA==
X-Gm-Message-State: AOJu0YyKy2tbjIuBBQ6VXbt3COgoUR7239dJhmFlasU+RIaPdKaJRTOF
 Bve7Ddtci1KArvceetBGLnb/SRrsLkyoFTR3lQFCpeg/RITg88P/ATR5jT435TeEeJ4=
X-Gm-Gg: Acq92OGEwM+pXwJXipPYA0psbcC94nxiRQpAT+MRFI9KhUh/1ZdoIjkW+LYGFvRbht8
 xkYkp3O8E2reYWohJQPgAw6juJV7A9a8jwP/aKjZFalGljhBRuJ6Ldic2JE0a5EVmi5udigGP9b
 8PCAfzwW+fEeCkmWi/wT7ZOaZQCxKwg6jJFIwlO7d2IXfVZOOmZj6UGZWvpLsJNx3GxxkeLAqtU
 UfErXBHSls9I/4X4gAevwQK+LIq3ZqNA/gU3RZvrmkyEH8G2AmaR4PXj9WIysmgeNPBumZozjfD
 A3iQD9jZfkM4fQ55jcsMHmaR1w99Kc08Md4pFs8/ECbFY8C6J2WqLmedgdU/m6D5PYvxk5OY/rL
 p8wpTbXOfu5WHn/Qx0SihTnNMIW7cQLK0itXAkiF44RG/4gYJpwle2u10fSN8C0eXn01vz2S80k
 Y6wxN3T42ZqQ==
X-Received: by 2002:a05:6808:16a1:b0:479:72dc:bb6 with SMTP id
 5614622812f47-482e57c23c5mr10572771b6e.44.1779139696457; 
 Mon, 18 May 2026 14:28:16 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:15 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:42 -0600
Subject: [PATCH v2 24/37] bsd-user: Add thread, umtx, and ACL type definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-24-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5874; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=YQd/Oq+9S9585bZGziOcoxm1El/aE/JxQDVF39O014k=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RITGGaJkah3dvJtMcxJq3+mgSWuAiuz0LSw
 mkry1gFGbSJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguESAAKCRBsHNEofbAR
 AG66D/9QJz3ULM333QTuFw2kCRsh4nMndzEaYzLEqNrSisXnD1YkF8tLLHhLX70pjIaasS2xHnu
 Ljur9L/0G+BjFtG8UfWsuL/vnZF8uwZUONWk97ogXzvMw+JmYrUnfbE8XQzau0/JI46tk5m2JAk
 asqdX75qsXb5E9EdMD9HR9kPawo6qlZ7OPzk8Gd/k/C3GB7UKNPX1zHiuBCIQnsgDep6EO0dtOb
 PllTWyqbw3m6NJ1p3ihHsVQXVT+sqFO3H5GXSgEBWSmsxS1qZsy6hgSIYDNvZao1J7hup1IuQQj
 VsHN5GCvbh8EEaCdF6d/r//hUlN9rxM00d5NjnEeFJ67Eb0JbUXoSmL6Oaf6aVspvniaa1rOgVC
 rTtcvx8N3ansjyv31HPpkMVHvetrWmIOO3QoegrEwqDslXHSQvJR9Hv4r+sX7PCSVuBx8+Q/+Rh
 WQ37UNQIujIfCUT2xwxGNwg+1ProzlKt4js18ycM27UeM8iElUO2BMtNVOxjKc3xciFA29x1zKg
 SFCMNI/rtA05Wnm/VH1gxh3Yu5dwJYpyjFeHgyLMoPDQryqPsu9wesYQpeAYs/uc0Yrs6yofVGA
 gs26Gy2w+nWYSaMTqkhC1uMxcL0X+hD97k3AbJ4z/WdMKTYpAOxKa62L17dG18Ap0QXHm2ahPG5
 ttKBb0mKK1LDiFw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::229;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x229.google.com
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
 bsd-user/freebsd/qemu-os.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 bsd-user/qemu.h            | 41 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/bsd-user/freebsd/qemu-os.h b/bsd-user/freebsd/qemu-os.h
index 12adc50928..b1ff5c0cd5 100644
--- a/bsd-user/freebsd/qemu-os.h
+++ b/bsd-user/freebsd/qemu-os.h
@@ -32,6 +32,54 @@
 
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
+abi_long h2t_freebsd_timex(abi_ulong target_tx_addr, struct timex *host_tx);
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


