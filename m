Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44903C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QAO-0005a9-Ea; Fri, 18 Sep 2026 00:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAL-0005ZA-Ta
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:37 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAK-0004Ng-6U
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:37 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-805cc8b4231so149004a34.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705535; x=1790310335;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VLSICqLKeobq6RPddyEFNeUIItokenEoDmXnWrSwNUU=;
 b=HaLabAK3W3UAGe/0i+0613YFHT9tFuauK0Bht769S8sgqOyI/MGdXPV32HmGofobop
 F3Zaodmp4ChMnwtHaD9sVanwWf5CY9S1bmuB/S754SgeJa4/NN8oC/9m/BQELzZ7MM/0
 88vXt0LiH4AC8iWI7xsY43BUijvwOHPxriYIroNmeNwf+l+E7DZPQS7Cnnc0gL1c8yHb
 dLvvnUi/YfHQXkspIWlQvtxQ2oOlXLaK8Soruo9wRPqFeF0D8Aky6ZR7yvic//1BYvX7
 YmouFwI4eF+21lZh9S8LD8WSrNVCtezVuP0LjGTGMuxL1vCyTDk+1YzsUN2WacHstBJ3
 +Bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705535; x=1790310335;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VLSICqLKeobq6RPddyEFNeUIItokenEoDmXnWrSwNUU=;
 b=vgW9snJLDQbJ/BKPZbRAVPD0djYKXTkDbptxFJ0WyqB0y3GHaNiQhY6tC/41se/6l7
 SJWYH9YzhJSgzLpJkxaaRlheLzBOXckGFUN82p76Ww1c6t3ZyEDT9ZvoiNgZSVQvpysi
 0Cz+hAB/C4jqHeRIBQoZUtlyFbuh3vLDXd6IWa6DMGDCY7veH3fOexIdd28mPARPWhEP
 ESmDqWGxMXr/OgqNorWb16awyjbz5QWVy+XwDZj6Nh1hLCIzu6pvseb1afBEFaOyGHRg
 CFGiT9nyXIZniShhQb1F4a1X7EL2isvriAiRiqqZJuwjLCLQf+MShS1RD4Sbg00gUvKX
 SIuw==
X-Gm-Message-State: AFuF++mYSKyMPKUSF+pEr6CEPqhU01iNCzXPBLKN2sQG400lBA/qcJrP
 twGnW4po3eucGQEsjQfTxgSlqA0runJvoSzrmArFV4BTg8ryFVnbFmOg7g5iOF6yxsXZA8tg7gg
 w5BomtU4=
X-Gm-Gg: AYBFou1FTTwQCxPBsYVwcUwOiMEBvaNM6HjFsRG06YTI0+O5Gh5g9aGzJx48fAPgjs3
 9FOWc/PtmsdbI+CcQodOlmKggihz4IhZ2xH2OLFKiGy0kmf4ziSfiPzbBLNY8ryhLCR7hfcx09v
 JOWrEP7W+sc1BVN36KRfKA7ucaXuVGh0SZJSXDo17YmyIGJhRBtkE8ap4KzWgxykEX9clnibRSs
 +5yWtvjFuMlYhkn53cKgv6k/NadB10VkVGS/FUuHQFStc+YL4fx7HgY++cfm+NGE5sX3MufQvi3
 uWs5GSjjo+6mIYEM58pmbM3KUd/0UeAxReuIUIM9i66qsYBHEQVf6LbAOuh2q14ytmi6F4qhOSp
 TzrRWmiUhWOvU+BOcwemmWJj5T1OZvtSzWk6gJTzuD+L8yAMXTluC+EWSMP8JFgeKrMszsk8rUx
 KJcb2l/xD1ZtkhglwxGpz8frp3fh5KX63p0CyDn4LB/qeW9B/fmK205TsxMg==
X-Received: by 2002:a05:6830:3147:b0:7dc:c749:ade3 with SMTP id
 46e09a7af769-80ddfd69cfamr1631030a34.3.1789705534946; 
 Thu, 17 Sep 2026 21:25:34 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:33 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 23/41] bsd-user: Add utimes, futimes,
 and ktimer functions to os-time.h
Date: Thu, 17 Sep 2026 22:24:04 -0600
Message-ID: <20260918042422.38713-24-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
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


