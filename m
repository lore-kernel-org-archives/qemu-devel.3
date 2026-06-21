Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07255CD98F0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hO-00033D-KF; Sun, 21 Jun 2026 00:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hI-00032I-CN
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:16 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hG-0005Fc-DX
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:16 -0400
Received: by mail-oo1-xc41.google.com with SMTP id
 006d021491bc7-6a0c604b9cfso2769672eaf.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015733; x=1782620533;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZeLri0UoJ+LgD9fWncJ4nGz+W8q9eJoDlnOI4fc143k=;
 b=jij5pyWFpKhW/orH9oMQJpgnMyyU2/JLefl1MCab1eGhachPTVdmTerZxqG4veS/nE
 6Q/y61rcL6zmgZWgmINaE8M1eI8D/h4GtzSi8Q/pR3932hNakushVoFy2uYCeylLKW8x
 N6bfhQ4oWbcz5k41jV5SpjXwa2QCwtIsgW/Edbpv3mvhK3Yg587baozQTMdKWKrwg35L
 AVuO/jOJlFp9Ok6VFt1GXG7ZFa4CRgZ52ujhIcD7VEIdsA9+CRqzlRsLT5hB8P7Pg8jG
 eZa2UpcN7BVTQEv5QIYVfRSa+WjMXWuT0ZkKLu941QP/Aly4K38epUEnE1d7s8hgHxvS
 0hYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015733; x=1782620533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZeLri0UoJ+LgD9fWncJ4nGz+W8q9eJoDlnOI4fc143k=;
 b=CAAitAnC2aPVZol8sesdVYxKcHlZY/bi3iVV/XapFhVSlDCeA41Gi0SfMQjfbAbTR8
 5STec796YQ0hWIyjf2DdonrDnRJOiKhBfwkMAzsyePMGCzdUpv6xbfGwEUbYulf0u8Oo
 mQkpY4cDZ46+yem9dDlvH5zXv5GTiWhRz0flL3GzE7WRQQ6IduGi5/3QPtHUbFvZ20Tn
 f8X5C65iv/vhbpMVKPbg2UkxryP9H8bHbUo/rfFB4dJWPPkh/qBnRdoQ0BIXC5Ajpxxh
 ZT1Xdmolf1Rh/ZnFLlM42lLmzWIINE8dLU2YrgDyTIQlxVKtls9qHYiGHU/51Rjvv0Tp
 uXTA==
X-Gm-Message-State: AOJu0Yz+fnQHC5tarSXgv66Ni/kziux74ORWpo3vXT9hqMJy5MCEorSh
 3yafcgrbt2kO01ZBUuXexVC1dw5edep/PqZM07iIwUMzjZlkixRuN0yzL+L2SzhcHWM=
X-Gm-Gg: AfdE7clrB++HM0/g7Msrokr8uUHygm8827twERhwevLvgQSHBO3Tgwx16JskYcMhlS3
 3CDUgNTOhMGah7mVAwlemY6LyFGUNmRlyuDqTUBGQ0zTYCXS1sZB6Jrid1mBUGR5RIREkP0FwCS
 OhBPri7MabcNC0h6YC2NABoU8VvVIc8erEE4oJ1HOT0rsNd83ze2FNTkkYtH3mDkx2LDRXDyvbJ
 xORFO7Yl9Z8YL4mJz5wRDZvoj1E1xfqLMuP+Km6kqbI8dZ6pe8PzkwSf5oMn0ZCZJTbq7I/MyTu
 T00Nbo0QgWr7hMmit52JrqQZsPG1wBXGQph5EHKWNcQolqT1PQWyM48bIZyG4YIIocksX8q6sTL
 JaB0fmEzj10e8iKmFsW+t7tR02wbZ/OUYM3as4Hvm0uQQqOW3MGBeNfZMSvrvSAkFUS4lXvPM3W
 Y=
X-Received: by 2002:a05:6820:2d05:b0:6a0:c75f:112b with SMTP id
 006d021491bc7-6a0eb55d46amr4527436eaf.50.1782015733346; 
 Sat, 20 Jun 2026 21:22:13 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:12 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:10 -0600
Subject: [PATCH v3 23/40] bsd-user: Add sigtimedwait, itimer, and futimens
 to os-time.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260620-misc-2026q2-v3-23-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8202; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=D6fEn5Wv+jGArcpmWZAyFs6/+mAY1PpuHu0njk7ak3E=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z/RQVAW+QVvzT/m5uf1r0+sy3w+33DyOt1G
 ycZ4laJOj+JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfwAKCRBsHNEofbAR
 APkKD/4l2DpNDuw4XwLkjnLURy8ys3QFzvuzXjpboDfaksP1eJ7V2f5eHEoVe7TWDm4RowRMM1P
 9DQCd6qpwkTejf8iZfBrQnfCQbAg89qGsp4G/Vdwhs8mV1LFhrXQ06oF0Kvkvuvg+Ps8mcZ0FxQ
 7uVqGfi1nsFjNPB/az6a2q9nhGMf4xaqxWXOXC8zUTsfduZ1JuLxVuwVDlDzXOOvonZNEGnaXVP
 MT5cz6//XUoePmm0QlDuPGjdu7FpoHCcXO+VBg5hl6wKJoz3ph2raasDQArz71RM412BHxeIRqT
 0sj9+Uv3r4FVqeoaSl7yzTnSVscYWZ8WvO6uAv2qV1R9c08ikTHXUsKiaS12ZVNhf/0UKNsHUBq
 v0XOEWYfmw1zmlaZJ0Vx9EScXftON4Bwnh70I0DNwfsiQfTe2cmTGGNCknHoZ7fuI8LqmFaiW/L
 dFdvdAbCiEdZFvz3QukjdCiRvOEa+mxhNfoQLzEkrvY15l2+ILM/Uv2Nh7zTs85BAXYYyjrY+R6
 7weEnuK6CCQbs0rWGinOFg5ApooyJ5KYNN2zqYhJOK38r2O1w4URSYqjX+CW4512xVDLPAwqa35
 /Y7tkyF1icJspnw/NUrPDeZrWojfVgwwqAJQL3eXTDA5vbsOFftJf0jNiLui5oNbSQc09FJusHp
 +VQnYZeHSC2d+5Q==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c41;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc41.google.com
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
2.52.0


