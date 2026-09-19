Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06129C982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yGv-00051K-UY; Sat, 19 Sep 2026 12:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFe-0003K5-AE
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:25 -0400
Received: from mail-oo2-x0c.google.com ([2607:f8b0:4864:31::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFc-0008OS-B0
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:22 -0400
Received: by mail-oo2-x0c.google.com with SMTP id
 006d021491bc7-6c72bd8a02fso1053744eaf.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836559; x=1790441359;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wkl0oJVk85LmRY6Afc+5A1odHKE9r8qrunR4rhvN01U=;
 b=m52ns4s3HSUccJqlaR8KqYOFl3xZAa7s2m0k9ahvpRAkXChgZThwUCBMLz5xgS+yW0
 1sTAoK+t0cFHtVTKS0hjoqUHZa8uLVVku4QjsGLI2nfbzstXnuigNQuGyYwYbuRVbQvj
 dxEroO9uSqUYkItT+u9IpMiLH2CGAYCaKLhhNaB7JBV04Hs0iaaWaCbkNZsrA+m6AzmD
 bfjnFy/RRwYPOGQ1THSANCiEMbXlJ9uZMlvqE834cmZS0GSXdF1v1PdxvOY/CvTk5VN9
 tsVg6aoJfsUm+3jT/n8EuKRUfPoRFD4gUijbIchr5/PiUwXLBcG6tvqcpu0IyEH3zuKm
 2sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836559; x=1790441359;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wkl0oJVk85LmRY6Afc+5A1odHKE9r8qrunR4rhvN01U=;
 b=sBGuo+Lz72tHL02hF3VGX2CCDGPP+GQykXaiqa8Xvt/UPi+rjWBqECtrQJ5rPuPKsr
 VOme666iY60sMxLTAdq0pCTh95iBYC09pcWEYMBhPOE0hy6vBLz0B4K9Em5e20jzmRSS
 49rwHsxyjLrgmZy2uEQw0KmNIvfUSINVMl00EOXBy3C4JmtxH+zg42ZmyhGOKR9PXPz/
 VlQrVWt/cGh/NEWrtS3UjK3iRLJ9kfPhIV5gA66eJ01WInrpDVcs/6lvpu3usdiTbBzY
 05JDNxmKmdcZxMbvVLKpniP99HrCws04CMLE0tbIZw0TwLldY8UVeRvKeBBDdGYecbGm
 TNdQ==
X-Gm-Message-State: AFuF++l0mkoY6XBU62Zf/0p+BYZakxWK5ueJncVPPAmtTO42x//13a/l
 gFloMd3ovJJ3a+F9CyECRhuEUYd3M/e85Vuv77Dcylws9KPDPTi1JB+o/Bczquhkkp9ZtGKwMPy
 P51ih8lw=
X-Gm-Gg: AYBFou1nAFBMkcqI8Bl83eBg9jrjwDV+wA24jO4kjpabt2JlJFOiaHrlyVl5eKofBoR
 P/ZfWhc+e+GZvBu0a0AvjtuYERRaQknPwprBiWX1wP70/Hj6660giG5ZZMpnwM1phJSqUuXS7wq
 oGyjXdoEuSf0nv9cTRoV8EFQGCYqW3gfgSUCpXKDwa9xnhWe6C76EH1Yc0HfdlzVA874LwcI4IO
 QAu5MqhU2jge6yGtgtHr29HBK4XkBZtMloPgWbz49AeNPWAsh0dZVJiKTVsJPBM23iCJ0tOrrWU
 GN8gTdXG3I5pKnnrqqlxZw7a/G1BaKBDmb2c8KUytteeUOgRTnqwL82LYrkCUeOLg4iOMheFg7h
 sfil3F+BfIzURClOeQNj9/HFjWACJn9VvA/iFXRqe2i367MK3pvlzoE6LP2V8sAM+UtxUgOmd6G
 npkH9LbVMna/rCJGAFDPI+paRi17L7LTrAm8advsj9w7+z0kGjUMtzfO25b7+wVxJXSyoO
X-Received: by 2002:a05:6820:161f:b0:6c9:80d8:a1f7 with SMTP id
 006d021491bc7-6ca9cb5fe72mr5565878eaf.52.1789836558891; 
 Sat, 19 Sep 2026 09:49:18 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:18 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 26/41] bsd-user: Add sigtimedwait, itimer,
 and futimens to os-time.h
Date: Sat, 19 Sep 2026 10:47:54 -0600
Message-ID: <20260919164810.70151-27-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::c; envelope-from=imp@bsdimp.com;
 helo=mail-oo2-x0c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

Complete os-time.h with sigtimedwait, setitimer, getitimer,
clock_getcpuclockid2, futimens, and utimensat system call shims.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-time.h | 194 +++++++++++++++++++++++++++++++++++--
 1 file changed, 184 insertions(+), 10 deletions(-)

diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
index 302872dd8e..05cb5db7d1 100644
--- a/bsd-user/freebsd/os-time.h
+++ b/bsd-user/freebsd/os-time.h
@@ -128,19 +128,19 @@ static inline abi_long do_freebsd_gettimeofday(abi_ulong arg1, abi_ulong arg2)
     struct timeval tv;
     struct timezone tz, *target_tz; /* XXX */
 
-    if (arg2 != 0) {
-        if (!lock_user_struct(VERIFY_READ, target_tz, arg2, 0)) {
-            return -TARGET_EFAULT;
-        }
-        __get_user(tz.tz_minuteswest, &target_tz->tz_minuteswest);
-        __get_user(tz.tz_dsttime, &target_tz->tz_dsttime);
-        unlock_user_struct(target_tz, arg2, 1);
-    }
     ret = get_errno(gettimeofday(&tv, arg2 != 0 ? &tz : NULL));
     if (!is_error(ret)) {
         if (h2t_freebsd_timeval(&tv, arg1)) {
             return -TARGET_EFAULT;
         }
+        if (arg2 != 0) {
+            if (!lock_user_struct(VERIFY_WRITE, target_tz, arg2, 0)) {
+                return -TARGET_EFAULT;
+            }
+            __put_user(tz.tz_minuteswest, &target_tz->tz_minuteswest);
+            __put_user(tz.tz_dsttime, &target_tz->tz_dsttime);
+            unlock_user_struct(target_tz, arg2, 1);
+        }
     }
 
     return ret;
@@ -153,12 +153,12 @@ static inline abi_long do_freebsd_settimeofday(abi_long arg1, abi_long arg2)
     struct timezone tz, *target_tz; /* XXX */
 
     if (arg2 != 0) {
-        if (!lock_user_struct(VERIFY_READ, target_tz, arg2, 0)) {
+        if (!lock_user_struct(VERIFY_READ, target_tz, arg2, 1)) {
             return -TARGET_EFAULT;
         }
         __get_user(tz.tz_minuteswest, &target_tz->tz_minuteswest);
         __get_user(tz.tz_dsttime, &target_tz->tz_dsttime);
-        unlock_user_struct(target_tz, arg2, 1);
+        unlock_user_struct(target_tz, arg2, 0);
     }
     if (t2h_freebsd_timeval(&tv, arg1)) {
         return -TARGET_EFAULT;
@@ -601,6 +601,7 @@ static inline abi_long do_freebsd_ppoll(CPUArchState *env, abi_long arg1,
     /* Unlike poll(), ppoll() uses struct timespec. */
     if (arg3) {
         if (t2h_freebsd_timespec(&ts, arg3)) {
+            unlock_user(target_pfd, arg1, 0);
             return -TARGET_EFAULT;
         }
         ts_ptr = &ts;
@@ -611,6 +612,7 @@ static inline abi_long do_freebsd_ppoll(CPUArchState *env, abi_long arg1,
     if (arg4 != 0) {
         p = lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1);
         if (p == NULL) {
+            unlock_user(target_pfd, arg1, 0);
             return -TARGET_EFAULT;
         }
         target_to_host_sigset(&tstate->sigsuspend_mask, p);
@@ -808,5 +810,177 @@ static inline abi_long do_freebsd_kevent(abi_long arg1, abi_ulong arg2,
 }
 
 /* sigtimedwait(2) */
+static inline abi_long do_freebsd_sigtimedwait(abi_ulong arg1, abi_ulong arg2,
+        abi_ulong arg3)
+{
+    abi_long ret;
+    void *p;
+    sigset_t set;
+    struct timespec uts, *puts;
+    siginfo_t uinfo;
+
+    p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_sigset(&set, p);
+    unlock_user(p, arg1, 0);
+    if (arg3) {
+        puts = &uts;
+        ret = t2h_freebsd_timespec(puts, arg3);
+        if (ret != 0) {
+            return ret;
+        }
+    } else {
+        puts = NULL;
+    }
+    ret = get_errno(sigtimedwait(&set, &uinfo, puts));
+    if (!is_error(ret) && arg2) {
+        p = lock_user(VERIFY_WRITE, arg2, sizeof(target_siginfo_t), 0);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+        host_to_target_siginfo(p, &uinfo);
+        unlock_user(p, arg2, sizeof(target_siginfo_t));
+    }
+    return ret;
+}
+
+/* setitimer(2) */
+static inline abi_long do_freebsd_setitimer(int arg1, abi_ulong arg2,
+    abi_ulong arg3)
+{
+    abi_long ret = 0;
+    struct itimerval value, ovalue, *pvalue;
+
+    if (arg2) {
+        pvalue = &value;
+        if (t2h_freebsd_timeval(&pvalue->it_interval, arg2) ||
+            t2h_freebsd_timeval(&pvalue->it_value,
+            arg2 + sizeof(struct target_freebsd_timeval))) {
+            return -TARGET_EFAULT;
+        }
+    } else {
+        pvalue = NULL;
+    }
+    ret = get_errno(setitimer(arg1, pvalue, &ovalue));
+    if (!is_error(ret) && arg3) {
+        if (h2t_freebsd_timeval(&ovalue.it_interval, arg3) ||
+            h2t_freebsd_timeval(&ovalue.it_value,
+            arg3 + sizeof(struct target_freebsd_timeval))) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+/* getitimer(2) */
+static inline abi_long do_freebsd_getitimer(int arg1, abi_ulong arg2)
+{
+    abi_long ret = 0;
+    struct itimerval value;
+
+    ret = get_errno(getitimer(arg1, &value));
+    if (!is_error(ret) && arg2) {
+        if (h2t_freebsd_timeval(&value.it_interval, arg2) ||
+            h2t_freebsd_timeval(&value.it_value,
+            arg2 + sizeof(struct target_freebsd_timeval))) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+/* clock_getcpuclockid2(id_t, int, clockid_t *)  Not documented. */
+static inline abi_long do_freebsd_clock_getcpuclockid2(abi_ulong arg1,
+        abi_ulong arg2, abi_ulong arg3, abi_ulong arg4)
+{
+    abi_long ret = 0;
+    id_t id;    /* 64-bit value */
+    int which;
+    abi_ulong target_clk_id_addr;
+    clockid_t clk_id;
+
+#if TARGET_ABI_BITS == 32
+    id = (id_t)target_arg64(arg1, arg2);
+    which = (int)arg3;
+    target_clk_id_addr = arg4;
+#else
+    id = (id_t)arg1;
+    which = (int)arg2;
+    target_clk_id_addr = arg3;
+#endif
+
+    if (target_clk_id_addr == 0) {
+        return -TARGET_EINVAL;
+    }
+
+    switch (which) {
+    case TARGET_CPUCLOCK_WHICH_PID:
+        ret = get_errno(clock_getcpuclockid2(id, CPUCLOCK_WHICH_PID, &clk_id));
+        break;
+
+    case TARGET_CPUCLOCK_WHICH_TID:
+        ret = get_errno(clock_getcpuclockid2(id, CPUCLOCK_WHICH_TID, &clk_id));
+        break;
+
+    default:
+        ret = -TARGET_EINVAL;
+        break;
+    }
+
+    if (!ret && put_user_s32(clk_id, target_clk_id_addr)) {
+        ret = -TARGET_EFAULT;
+    }
+
+    return ret;
+}
+
+static inline abi_long do_freebsd_futimens(abi_ulong arg1,
+        abi_ulong arg2)
+{
+    struct timespec *tvp, tv[2];
+
+    if (arg2 != 0) {
+        if (t2h_freebsd_timespec(&tv[0], arg2) ||
+            t2h_freebsd_timespec(&tv[1], arg2 +
+                sizeof(struct target_freebsd_timespec))) {
+            return -TARGET_EFAULT;
+        }
+        tvp = tv;
+    } else {
+        tvp = NULL;
+    }
+
+    return get_errno(futimens(arg1, tvp));
+}
+
+static inline abi_long do_freebsd_utimensat(abi_ulong arg1,
+        abi_ulong arg2, abi_ulong arg3, abi_ulong arg4)
+{
+    abi_long ret = 0;
+    void *p;
+    struct timespec *tvp, tv[2];
+
+    if (arg3 != 0) {
+        if (t2h_freebsd_timespec(&tv[0], arg3) ||
+                t2h_freebsd_timespec(&tv[1], arg3 +
+                        sizeof(struct target_freebsd_timespec))) {
+            return -TARGET_EFAULT;
+        }
+        tvp = tv;
+    } else {
+        tvp = NULL;
+    }
+
+    p = lock_user_string(arg2);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(utimensat(arg1, p, tvp,
+        target_to_host_bitmask(arg4, fcntl_flags_tbl)));
+    unlock_user(p, arg2, 0);
+    return ret;
+}
 
 #endif /* FREEBSD_OS_TIME_H */
-- 
2.55.0


