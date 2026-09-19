Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0EBC982E6
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yFk-0003Ug-KD; Sat, 19 Sep 2026 12:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFZ-00037Q-SA
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:18 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFX-0008L9-OB
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:17 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4b37a39a42dso693248b6e.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836554; x=1790441354;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FmM8f1a/31ZZH4KQhAtlbXbGZ6RWTojPX0uu/A3l5ag=;
 b=ymhvusRuX82zOKc7hrCtks75Dx9/kHMPxhBMlQOyJX+0ZPMzzDymCLxWUiEQIBwtmI
 7l4LfrWsQ1bVX8EW7yhtflZyKgqLhLnfA0m7NKxZnQiCfd4eX2BaVOnIu0cuuR+VsmTT
 vbF9UjsKd5Plu6rgne8Vl/GcsUR/AGNSs+1hhCmTQxqIg7Aw9azPLQKtFBJJnV0xdoyy
 E5THK2zMujqASPIAAdB7lQU9uv3nqiyU/bb+81+Gb/zhfR0TXjW+InY3gkh62XbrhCBN
 CtRxkcep+hrqBF/7wwNuySPZk56cegBFSAQgGTGnmdMjRhHed581+mRoEGEcYS9cNe4w
 yCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836554; x=1790441354;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FmM8f1a/31ZZH4KQhAtlbXbGZ6RWTojPX0uu/A3l5ag=;
 b=zdff/1BBwxnguCZ3O3kQ6OJhWgVm21pnvU1W9ggFuEHPR5WKlTmbVElHiOQFtlMBdU
 hLq+TyOoshVfcYWgx20xGJ+UToTYLzl352EWMRpc1Tqk4qZiE4c+Cs625cziJDzs9SbN
 LNjmHNhEDhCCKVqqGYqRnOmDou4FHjwvYhrynZM9y4gUv+uHpIZretqNs78+bJYJf4mj
 TezcjmGbJUChfHdEHaol17E/NLXMvDGfIpF+JkNwZiSJOpsTavPxub6sEDjZI6nDx4/x
 6vjAgfN4mXNdcfibD+p6vL5sUSlom+vauOIbmJwKGfjCYOsuI0GDGHLgccoatHeBpy0n
 nQoA==
X-Gm-Message-State: AFuF++lCi9t0fQfxlLhFLwSW9Bh5zyN4n7qe+WrPRUffGX8RFFlGHFBl
 hyj30T2CYv048Mf1Qe9EYiqFuMKBAufBLkGHRgfaVgOqjSszuQwo7WA8ZOODW1mVbkKutYUMIb6
 xZC10fck=
X-Gm-Gg: AYBFou37nTX39bDYOffMxeP36m4qfjfcTaUb2nF9miZNT54u0JHVx7Lou/OTwIonNtm
 X7EyoloHw45ALaUzFVIfT6olx8rF4a29EUAIodQ+TH2Zy/aAQTRsxIgjIs7GR5nXtnohb1rMfZt
 MY7jYnravNVxllVIbixz+64/mdpz+bGTpYUXLbwooa8ww7NIo5XbpibhQEeufTQoLVweHNOXOtO
 BIr7RK5GNGMzI5oZ5eNVi5m68lk6fSdD8VWfHjbRcMWYmQQLmWzlTQKXC1YS0kFDKliGf0/YMar
 4bsKladJ6Gw25aUYdG/03geVTvt8KD3Yi7wbm2l+XAwUdW2Db2VP/xB2viWm6C1bdmRJuIFiag0
 ibx29g+qLyf/o6RAuS4dW50JTMH3A6VnkNTHM8Xi2hkIvxqoKU8fYGV+3VWP0+cfEHJjpqxZhKd
 xH9RKNxcLqHdb+s3yyaeg2O4zB/RMVpskt2noijrFrzICgsymbE49KvsKE0Jacb22+BLqV
X-Received: by 2002:a05:6820:f030:b0:6c7:7668:a293 with SMTP id
 006d021491bc7-6ca93ccb406mr4565891eaf.29.1789836554576; 
 Sat, 19 Sep 2026 09:49:14 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:13 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 24/41] bsd-user: Add select, pselect, and ppoll to os-time.h
Date: Sat, 19 Sep 2026 10:47:52 -0600
Message-ID: <20260919164810.70151-25-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
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

Add I/O multiplexing system call shims: select, pselect, and ppoll
with proper fd_set, timespec/timeval, and signal mask conversion.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-time.h | 202 +++++++++++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
index 06104a5b7d..5f537fac40 100644
--- a/bsd-user/freebsd/os-time.h
+++ b/bsd-user/freebsd/os-time.h
@@ -433,5 +433,207 @@ static inline abi_long do_freebsd_ktimer_gettime(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* select(2) */
+static inline abi_long do_freebsd_select(CPUArchState *env, int n,
+        abi_ulong rfd_addr, abi_ulong wfd_addr, abi_ulong efd_addr,
+        abi_ulong target_tv_addr)
+{
+    fd_set rfds, wfds, efds;
+    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
+    struct timeval tv, *tvp;
+    abi_long ret, error;
+
+    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
+    if (ret != 0) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
+    if (ret != 0) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
+    if (ret != 0) {
+        return ret;
+    }
+
+    if (target_tv_addr != 0) {
+        if (t2h_freebsd_timeval(&tv, target_tv_addr)) {
+            return -TARGET_EFAULT;
+        }
+        tvp = &tv;
+    } else {
+        tvp = NULL;
+    }
+
+    ret = get_errno(safe_select(n, rfds_ptr, wfds_ptr, efds_ptr, tvp));
+
+    if (!is_error(ret)) {
+        if (rfd_addr != 0) {
+            error = copy_to_user_fdset(rfd_addr, &rfds, n);
+            if (error != 0) {
+                return error;
+            }
+        }
+        if (wfd_addr != 0) {
+            error = copy_to_user_fdset(wfd_addr, &wfds, n);
+            if (error != 0) {
+                return error;
+            }
+        }
+        if (efd_addr != 0) {
+            error = copy_to_user_fdset(efd_addr, &efds, n);
+            if (error != 0) {
+                return error;
+            }
+        }
+        if (target_tv_addr != 0) {
+            error = h2t_freebsd_timeval(&tv, target_tv_addr);
+            if (is_error(error)) {
+                return error;
+            }
+        }
+    }
+    return ret;
+}
+
+/* pselect(2) */
+static inline abi_long do_freebsd_pselect(CPUArchState *env, int n,
+        abi_ulong rfd_addr, abi_ulong wfd_addr, abi_ulong efd_addr,
+        abi_ulong ts_addr, abi_ulong set_addr)
+{
+    CPUState *cpu = env_cpu(env);
+    TaskState *tstate = cpu->opaque;
+    fd_set rfds, wfds, efds;
+    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
+    sigset_t *set_ptr;
+    struct timespec ts, *ts_ptr;
+    void *p;
+    abi_long ret, error;
+
+    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    /* Unlike select(), pselect() uses struct timespec instead of timeval */
+    if (ts_addr) {
+        if (t2h_freebsd_timespec(&ts, ts_addr)) {
+            return -TARGET_EFAULT;
+        }
+        ts_ptr = &ts;
+    } else {
+        ts_ptr = NULL;
+    }
+
+    if (set_addr != 0) {
+        p = lock_user(VERIFY_READ, set_addr, sizeof(target_sigset_t), 1);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+        target_to_host_sigset(&tstate->sigsuspend_mask, p);
+        unlock_user(p, set_addr, 0);
+        set_ptr = &tstate->sigsuspend_mask;
+    } else {
+        set_ptr = NULL;
+    }
+
+    ret = get_errno(safe_pselect(n, rfds_ptr, wfds_ptr, efds_ptr, ts_ptr,
+        set_ptr));
+    if (ret != -TARGET_ERESTART)  {
+        tstate->in_sigsuspend = true;
+    }
+    if (!is_error(ret)) {
+        if (rfd_addr != 0) {
+            error = copy_to_user_fdset(rfd_addr, &rfds, n);
+            if (is_error(error)) {
+                return error;
+            }
+        }
+        if (wfd_addr != 0) {
+            error = copy_to_user_fdset(wfd_addr, &wfds, n);
+            if (is_error(error)) {
+                return error;
+            }
+        }
+        if (efd_addr != 0) {
+            error = copy_to_user_fdset(efd_addr, &efds, n);
+            if (is_error(error)) {
+                return error;
+            }
+        }
+    }
+    return ret;
+}
+
+/* ppoll(2) */
+static inline abi_long do_freebsd_ppoll(CPUArchState *env, abi_long arg1,
+        abi_long arg2, abi_ulong arg3, abi_ulong arg4)
+{
+    CPUState *cpu = env_cpu(env);
+    TaskState *tstate = cpu->opaque;
+    abi_long ret;
+    nfds_t i, nfds = arg2;
+    struct pollfd *pfd;
+    struct target_pollfd *target_pfd;
+    struct timespec ts, *ts_ptr;
+    sigset_t *set_ptr;
+    void *p;
+
+    target_pfd = lock_user(VERIFY_WRITE, arg1,
+                           sizeof(struct target_pollfd) * nfds, 1);
+    if (!target_pfd) {
+        return -TARGET_EFAULT;
+    }
+    pfd = alloca(sizeof(struct pollfd) * nfds);
+    for (i = 0; i < nfds; i++) {
+        pfd[i].fd = tswap32(target_pfd[i].fd);
+        pfd[i].events = tswap16(target_pfd[i].events);
+    }
+
+    /* Unlike poll(), ppoll() uses struct timespec. */
+    if (arg3) {
+        if (t2h_freebsd_timespec(&ts, arg3)) {
+            return -TARGET_EFAULT;
+        }
+        ts_ptr = &ts;
+    } else {
+        ts_ptr = NULL;
+    }
+
+    if (arg4 != 0) {
+        p = lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+        target_to_host_sigset(&tstate->sigsuspend_mask, p);
+        unlock_user(p, arg4, 0);
+        set_ptr = &tstate->sigsuspend_mask;
+    } else {
+        set_ptr = NULL;
+    }
+
+    ret = get_errno(ppoll(pfd, nfds, ts_ptr, set_ptr));
+    if (ret != -TARGET_ERESTART) {
+        tstate->in_sigsuspend = true;
+    }
+    if (!is_error(ret)) {
+        for (i = 0; i < nfds; i++) {
+            target_pfd[i].revents = tswap16(pfd[i].revents);
+        }
+    }
+    unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
+
+    return ret;
+}
+
+/* kqueue(2) */
 
 #endif /* FREEBSD_OS_TIME_H */
-- 
2.55.0


