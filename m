Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293CFC982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yFh-0003K4-Ef; Sat, 19 Sep 2026 12:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFY-000372-8z
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:16 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFW-0008Kl-Go
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:16 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-7f4f0d298ccso620506a34.3
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836552; x=1790441352;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VLSICqLKeobq6RPddyEFNeUIItokenEoDmXnWrSwNUU=;
 b=XXtl3dKey0m8g5AG1lKr2RcRTXIrTE8SqSMcrn9E1EbR3ZV1gT8fDkT6CS2Z0GGI1X
 jPNu4naUoHfjpcCkWQFxIo9kKsbS2RZ9vOitxALW+G68D0ijb2NYtHuDXkr0v1EZpxSq
 dC27BsM3/+7uS2/0YuRDfMwCPBV8DVLd/RG8dv7ZJqFU2tsgsG9+546J2W8HdW7lLy7Y
 ogTL9MIDrQmME5SfBo8iyPIgBL6zVJUt3bcM+08z82MFu9RuPDsrNGG/p7HCrVhdpNPW
 XlqrnEn3Hj1vp6n0nfz3BXfrsnAgPBTtCSyuxz1AMS1IoJL35CKqWCEjQ10HtLbbSaK0
 T8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836552; x=1790441352;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VLSICqLKeobq6RPddyEFNeUIItokenEoDmXnWrSwNUU=;
 b=La5U8gfhnqKGa5P/ngVqhBWY4jwwMjAqu1Hw5g8Q8+po4a/LW4okCAkBxfxGjeB97c
 hYVVCvcD8mkEtuRBlCOuC16K9knFqoa7qfTUqoqQFhrkTSRXxOpaZMXEohb3M4LKej8S
 jZ+oYzNTbJdtzSLFCe4KWjxBFAj8L/+r4LaajtArOjn0GMkZRB2aufvVwpAmo+K6deGV
 4xCxhfjeNj1mr77zo+h7OfobewPwf21yJfWEdz/VuL6MMzVlkmLJGqnd8xmJTiOG/Nbx
 3WjWkep1Ak3Kpu7uKpi4dAZidK6/jKWxnKVPNN8Exy7DoffMRdVA4Vm5GK+oEmoLop/C
 PHqQ==
X-Gm-Message-State: AFuF++kuN4enksgQuw2g9wBXG+Bv4K2hvR2F538sQp0rf3q9OTwJUO5k
 gWK3mSm+PppCGDCK6QOGD304KpziYO8OYbZWPONf+PE5dAAXuduib9mvSMXR9rufq6q4lGd+btn
 Chau5s8M=
X-Gm-Gg: AYBFou3xoK73FxBUDJj2wpOaLkwku1V/R7SJnofNB/OV++w3CZ2f8v8rUa/+h7wCdHC
 xxtMGjtUMMrkmBIluQTeT7tL6sbJMimJQHB1ZJRG3yDiEYBo35bWzoPUzBYkupHvtbEwCW+lmaw
 Ns4fmyzAnNYaA7en8ArKXQZr+vMlnDfPg18/+ZSfhBAeGgtd36qk4XsmMXGPd8Moj60fGDh6gW6
 1BhfAJgjz10/i07mHjZUvDvMk/yVYgvxVsg49QDIBLg2zVqvNGUegPyrhF2fLYyi3629Pbh9c7n
 rfxJGhY69jThNVosxjcN45iIfajKwXXFEOuW/WZaRSC/Ow6hVPNi0HTnYXFf5VzOdDgW0vHZek0
 MxJhkg/RLzjkk23MuVZxctWDbf7iiv2vmvWm6kCBg9tsjB/o/exA1OIdTqIqYQzVLrTbLRnmmMQ
 aRScTDQmj7ZGQr0dCUXgnOEbNb6f0KxLexs92FWxhfime9VfkLbHifHwgXGJAHdpMVoyRh
X-Received: by 2002:a05:6820:625:b0:6b1:afca:5c78 with SMTP id
 006d021491bc7-6ca9bf48fd1mr5432539eaf.32.1789836552510; 
 Sat, 19 Sep 2026 09:49:12 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:11 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 23/41] bsd-user: Add utimes, futimes,
 and ktimer functions to os-time.h
Date: Sat, 19 Sep 2026 10:47:51 -0600
Message-ID: <20260919164810.70151-24-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::f; envelope-from=imp@bsdimp.com;
 helo=mail-oi2-x0f.google.com
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
 bsd-user/freebsd/os-time.h | 212 +++++++++++++++++++++++++++++++++++++
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


