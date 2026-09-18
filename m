Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B51C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QAU-0005b7-Ge; Fri, 18 Sep 2026 00:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAQ-0005aW-Tr
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:43 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAO-0004OD-Vn
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:42 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7f4f0d298caso112827a34.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705540; x=1790310340;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wkl0oJVk85LmRY6Afc+5A1odHKE9r8qrunR4rhvN01U=;
 b=O2O2/cErXaO2AHBPfFW5GGd5w1zSqU19MbHsjJJci/rMSMglnCjP9c46BCQDddZna3
 z4U4hpEMxV9c0gKlIyQVDLZ6o9knf+KkZ3gIe7oHbd9wbqdgdaf+lW4O1gIBoVM3Poob
 Dko3aPTbc+KLSf5s4aSpSUTL/cUyGIaKlbEt58P387fdFCEkF/KPMKt+m4gMSMTSG4P2
 LH+7n1FJHK0up9EXrw+qTTqqt1u88zSTfDhLBJMNBAC1matr4VCYjS+eHdKXMeC5dCzG
 25LXE06JTRvr0MwOTNOgtJw8jFVK/tpnKIidAu/c/PIrx2wWXV3Q4aMdiFp2e4LVpQkk
 99rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705540; x=1790310340;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wkl0oJVk85LmRY6Afc+5A1odHKE9r8qrunR4rhvN01U=;
 b=J9TorSTQ6NM9RnPGpcZpJcqql7D3zVjj/EHVewZYlqbJ6yZ0pXlNv/0c3/XDfjBpNu
 cqE5Ki2Y6pYcIJlXGEGlVcs+oCoQqk3Ic2H4whl5PTOBBkEeO+7jxIM+MokC0WE/vNLj
 c+YdCMHnCie0112jqs7vHUMzDGWq96fOBQrHWFFsnV4w+TsIc1350Aa0ycezueA68g1P
 PWoXk3VLVY0T/HWGkVC1ovgPc36OH460863QjJSyryAbuh8Qe6CJjIlgaWFqqBEIXBxe
 IdYJF0JVnZhicMbHIb1Nt494/USamzV/6PSlD6D0gvrzhEqX2r0V5FwOjnTvRFbu9Evw
 WS+g==
X-Gm-Message-State: AFuF++ntWv51x9Hgh2sLNFqVl9PHrQ6t5aCX2bFPZIcG/LeKEOeFuDVi
 CCGhN5iSrpuJ7hvB46ITEWy3yJHjwPjDZFvVZ6VQKAWZMTbZPH6DSbhzdDRWlgfs4NLYMlWGuc5
 fL8XcjhA=
X-Gm-Gg: AYBFou0lw9AtdRsgjecBVhHaAtAuyyRGCWVOkfm10HWIMWcYuWhhUCLaqtPyZld0hnc
 52xVvIC2TTTrsPORXjeTiV4bM0Kl6NlQmeRD8fu72aL6uFo3KdmMZQdghBHFurwyHLkCh6usb+v
 RXQtXWH3WecLeB9DiJcmwDsqVpG/XTxv+T60l0cfWdHMmix9Cstunhk6c3MZ4+AjGNKL/UuAG75
 u+qYPFrklay4894pVp+SUpFcdVCno4+5JhQmxmtMSBN63kpo9pGTYTsW6lH/orVbEH+iGOJJVcl
 GS86B6g3QQmzLye3crEtOvFUcgSCijODHScpZjQIiIMy76As6NtvLxunLw9D5a0vv9nqXDUv+AU
 hBKnDyf+aPH7jfeLXYcJn0krOHq58kjsvGRMradXfWOyZ8XUMNDZgQVxeP4iLNtN1HpKK+/eD6J
 t+CRJ4EvjJQ5bH0PeX7Pyp3mqAmPK32cXGkqBMZp+bUjdCRwjsYppN5T6vs44/tVPVwLqO
X-Received: by 2002:a05:6830:3147:b0:7fb:547f:98bc with SMTP id
 46e09a7af769-80ddfd6bf63mr1429302a34.5.1789705539826; 
 Thu, 17 Sep 2026 21:25:39 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:39 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 26/41] bsd-user: Add sigtimedwait, itimer,
 and futimens to os-time.h
Date: Thu, 17 Sep 2026 22:24:07 -0600
Message-ID: <20260918042422.38713-27-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
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


