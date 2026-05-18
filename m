Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94E8CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5VZ-0000Tk-K6; Mon, 18 May 2026 17:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VX-0000TS-DC
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:15 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VT-0000Uv-Fg
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:14 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dca00c1591so735871a34.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139690; x=1779744490;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+9XmWQulmeQTxV7cz+ITMN9VZZhvuiCJswwX1H8U88A=;
 b=EEtzBWFn1dKNpC4+eab9pMZUhBfGppEI7RVgOVZ3ZoO4k9q5F0tknyydUkYFgIlK2P
 fFYSCqNwrbWOPa4NvLv1y7LxMCnF0k/PV3fl6W51EoZjZp6SVCnsKib+SlXhJZYswy4S
 Mj7b6nFiMthIcsZa9ReP55hgqMzF3h+P2dYpKseTXNNs4grjxPEjhmz1O5vxU+4ErABy
 CneJlaUPyk8vv18VOv3oeuFLpK+hIDLkWPdNh6Qg2hb9T6YnzxOWOYltOAojEfL4b4rz
 EGqfiJkNY7cstqjwoGs8u+O2EMtY+aSXJjydVKLCIdqhON1bLjNHfzd4LKfkaVAjjI8t
 cePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139690; x=1779744490;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+9XmWQulmeQTxV7cz+ITMN9VZZhvuiCJswwX1H8U88A=;
 b=PqJXLxlqEAiCG9TR9Ad5gfGLAHLgueFdZIdjassHG5cPKoFP6Cz5uRf0tlE2169920
 /eTQsHfOag0IfpoIft9jB2x9clE8wb/KU0bkj4To1u8Law1WrY8ILl+6kFonC/MNyaHe
 uitOH4Y22t8tbu12k8VvcAeZ3KJ9UjiNBl2mBaDhN0mNXa2Q8PExbn6Xg7qVUmijgPXk
 lvKBif05hXjOu306XgG2Hij8eI2BqDT7MLObyiwu6keISzEoa7F1250Fjne/GHkVhC2w
 0QjGOA9ZgUtARkOXLqECjp4XTYmtYS86DEL5SEiA9nz1WkAC5DNUuVGUXJCbyL16dmBQ
 nMpw==
X-Gm-Message-State: AOJu0Ywp6X/Z8wm0O52GjojfobuIVdh47XzKaTa1G/Gc9gM9ryBMTluj
 AlcFgrvoU1WfkRhzFVZ+X3KzuQSeqdufttbO/BPKUDB5Fnf0SgCWRAd/FTR1o9Djpvo=
X-Gm-Gg: Acq92OGGNSnFBVHlwjhw6gksPZ+kG9eEuE/0eD4DWeL3RBh5Z0qRsm9Pu+glqfiIoX5
 yZvxM7y6MYo+jJnXdXzPgvST75NXEGiF5jLUW5AOzwRKjLSf7OPSUxt/sD2cuYQyMqHlYhgGYSm
 GOPk6tva/PFar8vv7Bp0Mx4XYbiUs6FujLG5qd2lnytLr1mKCbp+yweLl0mxj52Cvxvz8k/qqeS
 TtcI8PTRJVyFhOvK+nWygzURy2URAlxMbXxvMhy2qXJGs7E0tQUUUbz4JobODjG+wSG6FvprbuR
 vUzGq3OSCOXZXiOHIG9ZYZNDFksxJa4jzuHVkIjxWndONeGQOr2etlvnnbB9PJ3CsTDP0uDCw7D
 x1u7KleRP88j/2F3afmEPBzm0HLvHO67WcuPlyFeAiU1JUjaKpY6nFOzRNfAJn7HXL+4chmuIH6
 q4uRPnQDvxRq9obPEgsQEI
X-Received: by 2002:a05:6830:6010:b0:7dc:e37b:b5d2 with SMTP id
 46e09a7af769-7e4ea185c16mr11930302a34.8.1779139690145; 
 Mon, 18 May 2026 14:28:10 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:09 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:36 -0600
Subject: [PATCH v2 18/37] bsd-user: Add utimes, futimes, and ktimer
 functions to os-time.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-misc-2026q2-v2-18-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6472; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=GzpJa4xVkJQoXZiJ9eFNVqoa5W4JZ3qBXY89UUHqa70=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RHL7KDv6KXIZe0eaUO8jZPjojyFmd+tVVMR
 Uc5YRQcWbSJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguERwAKCRBsHNEofbAR
 AC6HEAC8usGRenx+nFXcapYGePwTBSxyBFHhVs0f6XManZ+5GVrhgzYd+/xMbPu+pTH1BLjdYwl
 l3qh0J3AOqJ5TTQtBqCCZfZsUokTLwrkPKprRP3wKaLe5MJ9H/4H0qNlfKFMvFiK+Iyh5LS6PPH
 DbLcxVYxIHCBZ7/WFXBS3aFHFNMKHoXqee29GtowOsM1Cr2pji4IoZOmnBGZEHLvP0hJxq1b2r0
 GFlXS34I1yIALr3gDV0usBf7bxZQ1w+Zdf9xH5NNomoNc4UeBiPN9zw9m/957u+9XcjERrJRSm2
 LDBfsIBxNPzfzOn0+GsM4WwvmnzB3h/2vSm0ulZtceFY3FOjGlmpRTE2jAM8PRTfliXIj3NTzYp
 Wv07s+tsomFe7a1CYllGctbhY8KTmtPh8gVVMVJmfIlw0o64JjP/dUR+NAEfUs24FR4zx62hxu5
 KEBl/ix0JenfVmF3HUIMXV2DrUGzy87E/zPxCxeTsCsKJh8HMruQXIV7frSzBOvGnsFs8XOCPkR
 OZtXyWwaQcbqxrDl0t/dl7/d9Aiz6107pUZ/iyxe5uuK9PnSuLgdvL2j8wPZUPuReLUXjyKEX5r
 qOZXKoEpfR0uWnU8r3KSjg9NmzTavfSnVadv05m2+zTM+YHfsOMVocsAbXunkWQ2sFIPF4dcdID
 SjdvO3iTiPGNWnw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x332.google.com
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-time.h | 210 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
index 16b71e6234..05fa043442 100644
--- a/bsd-user/freebsd/os-time.h
+++ b/bsd-user/freebsd/os-time.h
@@ -217,5 +217,215 @@ static inline abi_long do_freebsd_ntp_gettime(abi_ulong target_ntv_addr)
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
+                return -TARGET_EFAULT;
+            }
+        }
+
+        ret = get_errno(__sys_ktimer_create(clkid, phost_sevp, phtimer));
+        if (ret) {
+            phtimer = NULL;
+        } else {
+            if (put_user(TIMER_MAGIC | timer_index, arg3, int)) {
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
+
+        if (host_to_target_itimerspec(arg2, &hspec)) {
+            ret = -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
 
 #endif /* FREEBSD_OS_TIME_H */

-- 
2.52.0


