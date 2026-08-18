Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52673C5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThI-0002aV-VV; Tue, 18 Aug 2026 19:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThG-0002Xo-R7
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:22 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThE-0005Hv-To
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:22 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7ee4399c3abso308576a34.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097500; x=1787702300;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YupH/ytlcUBpqsNoBinnranly+aq2V9hMP2Ck9NOXYY=;
 b=ION3+/wCBjJ5Npke+fuVfI+YAIobjR1JwXWb4Fu8OrsEs4JxPasaEvKu5I7Jgfat0P
 j/X541IntQc8JgTYT8dS9w7IvnG2rVeKKgaWzUIcHRKXk78A8iII0TeZpt3EPMQGzT+w
 UySwxV4kxFjIZKZrzN7NeNlDp1APJfwpQvbJCRHz71H6P/boILcj/yO7+D4A52J1Wm09
 rqm3yMTZzOjZwTAnJZPv50JIjzs1FzpI/5De5KWftZgdX7rFq3wBSLxhg7tuFg87VV7I
 ok08JMs7Upagg5xYzST217XxBxoEfdHIunIAIxExgS7uZCs97ei/UXlyPBeMyhLiGqLn
 kV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097500; x=1787702300;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YupH/ytlcUBpqsNoBinnranly+aq2V9hMP2Ck9NOXYY=;
 b=PB6kGK7doJOloFQaMo0Xlrr8qextiUiiY4gdlLm7lLcq6A0cMaqNLRcnso2rZ9TeLB
 pZJ1+wOMtd4HPJTg1wAxj/wwc5mPDLxmMp18ry/Z1En3RZJZ01T41CsW2nhvcIPX5JwD
 jXkaXoPFA6e6xW1E0GlZ0Hwv+cjLdN77IM1MgFwAo04p8obSs/U7SXW1qAPgpgDhE1b3
 y12Mf0JAP+qZBXeTDPn2cfyGwPUd5SIWiMKVR3z3GqmO6TUBHN3qlzq79VFDs5VkXgnR
 bqWLyWAm7vyCIxK9AJlnADXHeX5SJreNLTsKVg7lyuVmRwmx/VLek/PLxL7a419JdiRK
 D1yQ==
X-Gm-Message-State: AOJu0Ywk52z6sz5ZYhoT93QjFKEGUBtl4YIeivq5f8TtjJk/fg0nIThV
 Q7UTYwSMj0o/qW3u9DFc6yOmUTvC7sY+f5+C2mggyIVpejYuOEOAC7i/c9KOhsJzF3A=
X-Gm-Gg: AR+sD10imT272jzYfSMJO7Y/KrICXPRr4+BJG+rLCDnwdYJFMUNm90jlBXcRAqMamLI
 8FV3vxG7kqrVPMxUAQbzTdQ56AYIGh4LlgiaatvRMPzAfDaox14JlEKipnlwASB1UYWB1Ev7MnK
 GQ2N4dnX8bIDDpypH0+fAm6aIzQChMlTk8Zn7bm6TF0dTD5tJJ2HsVWpLQxWaH8PkCprcH0Ii76
 Es+7YQRqlXu7vZBtePD7hTu9s+ntvmVH5uF7MASonD5H3MSIao190mhK9KQUtK/mPeC9QJ0rzV1
 s0SVklCgKi3wTNXyby+jA308NQusf7zEsazgQ/yiFfvgLpO4yIL2bFmbdfgZfrf87sWQDM/UI8J
 3/uNb4klAf2QmVRyHpvfsOzfZOK6AvhRmV/0BjJqJavuZOwrTzEU1xIHj1Onw2XblWOzKX87Cjy
 ll9XdQ52w93Vq71gKPRSNq8Vup/ZgCd69D9NevfH19CaqkpSfgUro7mztKZg==
X-Received: by 2002:a05:6808:198d:b0:4b2:5529:ed46 with SMTP id
 5614622812f47-4b2bc976ed3mr376725b6e.8.1787097499832; 
 Tue, 18 Aug 2026 16:58:19 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:18 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:18 -0600
Subject: [PATCH v4 25/40] bsd-user: Add sigtimedwait, itimer, and futimens
 to os-time.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-misc-2026q2-v4-25-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Kyle Evans <kevans@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8262; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=13N/xwyjFGf8cRVWdwaggroKY8cPa8BwIvJqbfM9xdY=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFG9nfJy/CvMBhdnnkxBcmwaSH5uH8UJFcZx
 NtNFDaS1UOJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxRhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBLgxAAhUI+WAfDLK3kNW5bMTUDimZ3GnL95n8
 zP8eoJCPugZYA+bvsg6E13ycE3T6+0s4kdTzX0EOmTr4KLhSM57pDsaT+QJBjZWpDMpwKBMqu8q
 IUhwCWQl/0toUdOvZ/PUs6NNmwczJXCAzAEdqIhe/CljJMsO9KX8pE9YjMDDmRJhnyebZINAeYK
 8BamD0N0k+xpqfJA869ClqqssVBeA5zROzKBDEgYpC63e08go0ClnaF8CgDOku1ejVFViVUn28W
 /vdCpi6OpTozNm7AQZ9NxuSrQ/dUzhVR6PduYOxaV3WC3sXscd6otGpiAmfmQtdvboWqtBOHEix
 UEPNLjLe99A9DlhnumOe/lSLQLjbtaLV+xN0XzvdcIi4K8GS3ppOFsLVm+ljYd9T+cQR+9LesL7
 q6BV/lynhBHzG4TFv1SobEayGLHjJZEfO6cW7/kpDVMXB6tDCyFuMXUJ1OxgNR5w1EUGo19m5r7
 DUOYuYSZWKan05uV9xlk5r6N7V0+nk9/JE3XWQ+6gckj9CoJZNo3Jrzl7A5/msZRYeAxgH/PH9t
 IQoybi4iWp63R9UkhtasduecaG1v0RPmk0zNOEIU4bzRX87aZUXU+cUJpzF5b4FyPm9yc661yRa
 IXDOIpUblB76RgpBSjD3f14/RY5wMof/tVXNkQDX+GACvlVRI1M4=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
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
 bsd-user/freebsd/os-time.h | 194 ++++++++++++++++++++++++++++++++++++++++++---
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


