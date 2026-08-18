Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12E9C5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThB-0002Fe-EE; Tue, 18 Aug 2026 19:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThA-0002FF-Cv
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:16 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTh8-0005HG-CL
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:16 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4a46a53abc9so338548b6e.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097493; x=1787702293;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dAeV52SVoEvXeU/zWlyl+QmtgiI8noDaAlyiyC4Umjk=;
 b=zQL2VgHOZ6i10EdLdsV2rMv43X8wy5JgovYt2jacTkMs29oxpLn3ubUOyQIIAXHas+
 KfV1Q0iyngZw8fmADH3O/zg/gVucQZYNJUXGkJW4qDUFwWRvw4s4TmBX6j0IjFt1mD2R
 Idejrw2qejP9Eiqh4IGSWuOZOYvv9f5pwcQwx3jctnxY04h3r+bEclBlat0O+uwGxekn
 ydtBcvwoQ3hQ5NMo2MwNQ9lTNUcYoKOxQ2Ns/fhVdiBnzndPO2c5xc4eq02M6wYQUGSf
 GIFUVTqTFiY37DNAxOVJnaFt4kfh+WVvfUcKM1bfZwcQCWfBe1EyHgJYLVcmCSWIaxQC
 zcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097493; x=1787702293;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dAeV52SVoEvXeU/zWlyl+QmtgiI8noDaAlyiyC4Umjk=;
 b=roE1Uh6Ps6gJ8i2OAIlisfbR61H8wxm/rMthqxRwdGAf3X2Y9Xvi/EMD7w9hDozye5
 h2vyI79IYMnirdXsr50BtBqLZGdCYBS1ErSEJW3gMW8ujCKFfd9NIGW0pdQfNWuTFdTG
 kV85q+ACunrk8wqXjnx9/YS0+UX4hDDbetU/o9yStzg9G/Bz7eM1vbqYue7D1Afa0Kqk
 VSvkRAO1oIoS0qIQ95kUlI2eiNrCUHZ3CbJY0+GdnKdIG7xfpbUYH/UQdY6gbzuVxEJ0
 eAw3IJTm0DNP/ooS245xdiXpPebtiAdxB8mMdxVMC2nomFs7O2slBmzfrAZ57UB7OYne
 fQmw==
X-Gm-Message-State: AOJu0YxodDU7Tu7/bJW49Ly+hU7sYeH8+2HUpeBW/IMrNXLY6bwsCo6u
 /U6cnqqPCux//n+nmtHyNq7HKmn1ycn2dJEEYCS0ePd5kd5O6hWbq9ZOpJZZZlBEuxQ=
X-Gm-Gg: AR+sD136T1FbFMHHomDGkzRlkAxwZCYSrXnRIcNroK9gNz8ZgdFuJavSAP4ykzHU9O5
 1DzQvoIFgyFngJtLKjsIK7YNv82S9h3P3eLgQTn3eOMTIqrgtX70ipGmNdhxzZpY8Edqh9UZPBd
 3/9TPv7wvNG90sNQO137XPR5DKeI8K/uTHgyg+RtgZdRs0gkvX7cFU9oTlCNwMvfpUXKAMkrjwu
 jLMf60BTGi+3rXL8GYGUUy9RNE8pr7Tep7ZmCkRBsl0A9KMzSSR+s+0V07JdR4+6UwYkYz8hn8O
 H7ZSfRjnq4Fw9p/e1IYQexkV6ciSk/G+VDBsUuTdAP6ug9j6RvG3ujt/zZxnDT80q0d482UlrKY
 szN/tZqjq90krT8B20j2ZW792kROhsrelyUIU3hNXS3z4tYc+MIrjatm2MG67c+xW1Puu1lKOml
 c2Gse/ejS/rz3d8RFwXMhKoO0KNhAKv0TQmhqhxjKV5p59OHo=
X-Received: by 2002:a05:6808:c1f4:b0:4b2:8dbf:ffc with SMTP id
 5614622812f47-4b2bcba3ad2mr370564b6e.17.1787097493375; 
 Tue, 18 Aug 2026 16:58:13 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:12 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:15 -0600
Subject: [PATCH v4 22/40] bsd-user: Add utimes, futimes, and ktimer
 functions to os-time.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-misc-2026q2-v4-22-09bf5647c98e@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6699; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=pbhfstJwayLAkXcJxK/Ro3zRSSytO/eRQVia/LZuXAs=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFBkQEP06aHFqVocXPz1bm76b5MQWwDKXq8I
 WvwuGaWq7WJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxQRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBPZA/6AvabogDkSvMs2++MYCi8LI+Xz+5elzD
 4G947B/6xY+9z9Qjgxe44DiNs8DMGBtyXCQBpYpnmSJVG3kYodcMEdmiFPtHne0GVhfUSC7x60N
 +5USrcqlIGJBfbTOIKP/N/ZK96eP+SFZJlq1KdDGIRTFHTExcMiSLNOf4JvR3QNCXXfUte/RTpL
 ObNE+1kw5RjHC5z4nqNNUiY6mewiI2dOx1zlg49DMRMkvlEDM9/9EMSlD4Dvco2vsJrykE+g81z
 M6hCmEAhmNibPiAE0i07Es2ISvPZxYYjWR8tHlKLOovY2fwaKDsHL35sN/qA1gvq0lzxRjYOFV2
 L1LZLfZD6/b0fJpWk1TtpS3UDRPWSYBQcAPkqoU13qieYd1WApvvRDay2piESy0z0zyODw5eWvo
 SvxXkWoDs46dLpIAjaSTeP/+PA3PIHsdbjsDu3uLh3YjVnPQtUCfEjBWy8spvhmgVhRAYab6Kj0
 KemcPDTBD6OwJ+ZokXkhYEzuycD5JoL0dxQgKci1bqI+r7pA2WSuwOIRkd43VNCPWWEaBNGBqe/
 Nece7Dde2F3hrhIl/e/nYTDpasJkG1djsgz1QaxAXmMV5bQkgubSOUtZiV1CHY1Ts0EEUd4SeBL
 N2DHen7cymV/C4teUEc8/wLwwcePk03jMM5b6tgl6ZSB0lS75tpg=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::230;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x230.google.com
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

Add time-related system call shims: utimes, lutimes, futimes,
futimesat, ktimer_create, ktimer_delete, ktimer_settime, and
ktimer_gettime.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-time.h | 212 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
index e387441d86..06104a5b7d 100644
--- a/bsd-user/freebsd/os-time.h
+++ b/bsd-user/freebsd/os-time.h
@@ -221,5 +221,217 @@ static inline abi_long do_freebsd_ntp_gettime(abi_ulong target_ntv_addr)
 }
 
 
+/* utimes(2) */
+static inline abi_long do_freebsd_utimes(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    struct timeval *tvp, tv[2];
+
+    if (arg2 != 0) {
+        if (t2h_freebsd_timeval(&tv[0], arg2) ||
+                t2h_freebsd_timeval(&tv[1], arg2 +
+                        sizeof(struct target_freebsd_timeval))) {
+            return -TARGET_EFAULT;
+        }
+        tvp = tv;
+    } else {
+        tvp = NULL;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(utimes(p, tvp));
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* lutimes(2) */
+static inline abi_long do_freebsd_lutimes(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    struct timeval *tvp, tv[2];
+
+    if (arg2 != 0) {
+        if (t2h_freebsd_timeval(&tv[0], arg2) ||
+                t2h_freebsd_timeval(&tv[1], arg2 +
+                        sizeof(struct target_freebsd_timeval))) {
+            return -TARGET_EFAULT;
+        }
+        tvp = tv;
+    } else {
+        tvp = NULL;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(lutimes(p, tvp));
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* futimes(2) */
+static inline abi_long do_freebsd_futimes(abi_long arg1, abi_long arg2)
+{
+    struct timeval *tvp, tv[2];
+
+    if (arg2 != 0) {
+        if (t2h_freebsd_timeval(&tv[0], arg2) ||
+                t2h_freebsd_timeval(&tv[1], arg2 +
+                        sizeof(struct target_freebsd_timeval))) {
+            return -TARGET_EFAULT;
+        }
+        tvp = tv;
+    } else {
+        tvp = NULL;
+    }
+
+    return get_errno(futimes(arg1, tvp));
+}
+
+/* futimesat(2) */
+static inline abi_long do_freebsd_futimesat(abi_long arg1, abi_long arg2,
+        abi_long arg3)
+{
+    abi_long ret;
+    void *p;
+    struct timeval *tvp, tv[2];
+
+    if (arg3 != 0) {
+        if (t2h_freebsd_timeval(&tv[0], arg3) ||
+                t2h_freebsd_timeval(&tv[1], arg3 +
+                        sizeof(struct target_freebsd_timeval))) {
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
+    ret = get_errno(futimesat(arg1, p, tvp));
+    unlock_user(p, arg2, 0);
+
+    return ret;
+}
+
+/* timer_create(2) */
+static inline abi_long do_freebsd_ktimer_create(abi_long arg1, abi_long arg2,
+        abi_long arg3)
+{
+    /* args: clockid_t clockid, struct sigevent *sevp, int *timerid */
+    abi_long ret;
+
+    struct sigevent host_sevp = { 0 }, *phost_sevp = NULL;
+
+    int clkid = arg1;
+    int timer_index = next_free_host_timer();
+
+    if (timer_index < 0) {
+        ret = -TARGET_EAGAIN;
+    } else {
+        int *phtimer = g_posix_timers  + timer_index;
+
+        if (arg2) {
+            phost_sevp = &host_sevp;
+            ret = target_to_host_sigevent(phost_sevp, arg2);
+            if (ret != 0) {
+                g_posix_timers[timer_index] = 0;
+                return -TARGET_EFAULT;
+            }
+        }
+
+        ret = get_errno(__sys_ktimer_create(clkid, phost_sevp, phtimer));
+        if (ret) {
+            phtimer = NULL;
+        } else {
+            if (put_user(TIMER_MAGIC | timer_index, arg3, int)) {
+                __sys_ktimer_delete(g_posix_timers[timer_index]);
+                g_posix_timers[timer_index] = 0;
+                ret = -TARGET_EFAULT;
+            }
+        }
+    }
+    return ret;
+}
+
+/* timer_delete(2) */
+static inline abi_long do_freebsd_ktimer_delete(abi_long arg1)
+{
+    /* args: int timerid */
+    abi_long ret;
+    int timerid = get_timer_id(arg1);
+
+    if (timerid < 0) {
+        ret = timerid;
+    } else {
+        int htimer = g_posix_timers[timerid];
+        ret = get_errno(__sys_ktimer_delete(htimer));
+        g_posix_timers[timerid] = 0;
+    }
+    return ret;
+}
+
+/* timer_settime(2) */
+static inline abi_long do_freebsd_ktimer_settime(abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4)
+{
+    /*
+     * args: int timerid, int flags, const struct itimerspec *new_value,
+     * struct itimerspec * old_value
+     */
+    abi_long ret;
+    int timerid = get_timer_id(arg1);
+
+    if (timerid < 0) {
+        ret = timerid;
+    } else if (arg3 == 0) {
+        ret = -TARGET_EINVAL;
+    } else {
+        int htimer = g_posix_timers[timerid];
+        struct itimerspec hspec_new = {{0},}, hspec_old = {{0},};
+
+        if (target_to_host_itimerspec(&hspec_new, arg3)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(
+            __sys_ktimer_settime(htimer, arg2, &hspec_new, &hspec_old));
+        if (arg4 && host_to_target_itimerspec(arg4, &hspec_old)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+/* timer_gettime(2) */
+static inline abi_long do_freebsd_ktimer_gettime(abi_long arg1, abi_long arg2)
+{
+    /* args: int timerid, struct itimerspec *curr_value */
+    abi_long ret;
+    int timerid = get_timer_id(arg1);
+
+    if (timerid < 0) {
+        ret = timerid;
+    } else if (!arg2) {
+        ret = -TARGET_EFAULT;
+    } else {
+        int htimer = g_posix_timers[timerid];
+        struct itimerspec hspec;
+        ret = get_errno(__sys_ktimer_gettime(htimer, &hspec));
+        if (!is_error(ret)) {
+            ret = host_to_target_itimerspec(arg2, &hspec);
+        }
+    }
+    return ret;
+}
+
 
 #endif /* FREEBSD_OS_TIME_H */

-- 
2.55.0


