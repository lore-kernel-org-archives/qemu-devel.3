Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9F9CDB471
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hG-00030u-4J; Sun, 21 Jun 2026 00:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hD-0002zP-3L
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:12 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hB-0005ER-DO
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:10 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-69e1f777bcaso2930231eaf.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015728; x=1782620528;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nd668SF+lm2kq08PKi7pg1iSuAwXi3sSQJZZ4SwfLHE=;
 b=w86ISdq0Fjh9Ct4+fiRhFdoH3ac2JPU2gbPCtymrZ3+2l+gyWFywdCI3+h7nizdSxh
 5DZK+fUIOWzzQRMfCYnz9EThdGrrO+duNWtSezLDJpRLFT0fYjBOyfhmDEVP3f4Mpnff
 HkO2BCLikMSTHe35hFCH1VuBzTzvSxaYm5ZjcX2qQF0A+CP+MkUAlHWDCKam5t63ffOv
 pTZVgE3+uKdLoUEH7PdnFbrpBr8cDD1cujdR42N6MB24fS3w47SQW5t94B01bZy/wP67
 yQ8TcfLYUxOoZGG4lIbtg0F02IbChWEDVMsDxSBY8mtqKnJpxCJQL7H76w6IvMnXp8KJ
 s4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015728; x=1782620528;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nd668SF+lm2kq08PKi7pg1iSuAwXi3sSQJZZ4SwfLHE=;
 b=ARasOyWpT17t9iI/EZy31w5Ka3grHB8GaJ9oIpzT3FLHgiEyE6s1+MUUUBeHWyyqT6
 mrNjMw5ZPFfL6uRYe6hyvL54X0/duF2anLLB+vPlLe7SVo1W4F1rTlcGqzZvhXnGDvDM
 qq32RaDnYO//NBVrZTA0E8jj6XLjfRe3Bqgpoe0GkrnH5xqWWvJNz369eK4qFbEnsF8N
 K+xgPbKCwyqFJSZU671k7RUHzivk7K3NRciMvIysRMVgAkgt/rQpm4E3nedjEvUzMoA6
 4QxnezTkycwcQEssACvIdAqNCsNdpBivHbP85pXXMUEyiQMrcKsuzKW0E3JpbPvLzbVn
 qnew==
X-Gm-Message-State: AOJu0Yy5Q92lN4sSFAz88cmO3NLQyzlTnycRfF0SiTbgN3xQ4zlSm5ex
 cphrIzgqYSSOq0qaqatNGtKjXya8kgpafUkDNuOL+lnRkbUExU9kWx8It5lVBBhfldfbpabGix2
 up7Hk9OIWcg==
X-Gm-Gg: AfdE7cnfQ5sIM8vWRq3g8J9G4IkMP67KQR5R2NHH+ByR8yoVqQ03tj1BJPwcpYrno/5
 iv2kIAv03py+ipiQIWDOfE0HzSOxUKu3loDe8G737v61/cAPnq8CWArohzPexASrNn3upOfOEdH
 qCa8Ou4MpBOwQ9i/JDwxE628MwMwu8dG21TYvBzyZw57cbCmjGzp6xxQVWaNLJUUQFhHzxF94gq
 EPASImJ05wZPJqJRzJzgFCC4EKyzu5pL/E1Ttk34WLDM4cLfoIEl+/V6i1dTrQS2pWVWJr+fhNG
 maDyAAajYDQR6+5dX0k+MxvrLyCGkfCswBk1GKYuGEbV1hFQqtRojz1RM6jtmN9X/SDsT68Pf8t
 btIt4bC5GHcbldBrKbGWOtFIb7RaX61Ggy2wGUsZeqMjHEXA/cV1v6LVBJYPjJ+S7btMLfDASXz
 Q=
X-Received: by 2002:a05:6820:2229:b0:696:13e9:6863 with SMTP id
 006d021491bc7-6a0d9fb7a6emr5251545eaf.2.1782015728418; 
 Sat, 20 Jun 2026 21:22:08 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:07 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:07 -0600
Subject: [PATCH v3 20/40] bsd-user: Add utimes, futimes, and ktimer
 functions to os-time.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260620-misc-2026q2-v3-20-f6ce23ad8dda@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6639; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=9GsekxgX59ibndkwRpMW3vsambWIIfF/h5FULyJCcSY=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z/JsnMXKIhwHeW0Gt7jmihrB5Y/LnbEH193
 3kSYQ5zxpiJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfwAKCRBsHNEofbAR
 AM7ZD/wKr3YL9BXiKiPoWV4EPwpE2xktMSnzg/mOmqjOEsWrB84LCSM9ls48EiJenVmp6E04DTu
 rlN6VKp7OC8dnUL2CUQdvDE5xG75ppDHj7CM7ZBukkjGOd/5/o4Za3Qu1VmSCB2vSxKF57AZEP+
 XgACqAFVdCtjwxKnNTnmvP4BApDGZdDWO3dEBSVbwrpVzFBdAHU2pNEf6VW3H00J/IJaecYyIw7
 6bQ8KIKFqo3KDvAI484Cv5dp5F//VL60Vr70nPPEWB4PSvatD02LMS5m0veoMk/SGmDQYYoPTAU
 qx8tI+Wz4sh3E7950jNOryRrjTRhJYuFeO/vuCYJJ8zHTCTNy0eaahBJ5zcIon0xlLs52mKtR3G
 0BJrAmfuaHAHqYS2EW8HzzRM7QJDIkogLPXvPf3OWqp/oNvyMdsjxKcXA7aV4iM2yF+kQ31QqcB
 chTzqZGQEVz06rzToIBJPrv5/BDPSU40ygOiOeP2vCqP7qp/+jTmNKATnSn5mR7xTwagyLXq6we
 781tFIDCPyyCo38F4dJyTO9K1VTWawuGGOWTMV4nIfq2Rf5gMCSnUSDU+wz67cDis6jdeLcEpWC
 gMErQySbwbCvMKF5I2fNmR3GInVlVcvvIynMBV7HIphuB/hrzKbgEvPIlsHHcdQEpiTzGEosB6q
 Gi9fWKV2QHs940A==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2c.google.com
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
2.52.0


