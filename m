Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44941CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxM-0001Wu-M1; Fri, 15 May 2026 17:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxK-0001U0-Kr
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:26 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxI-0002zC-UT
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:26 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7de431da8fbso321052a34.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880023; x=1779484823;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nsywyvrou/nifvOPzoxYiCCFY2AVnkqkPANe7KEMhOc=;
 b=fQbWFaTQOmRpWUuUuhbec9Or9mHshlMiA0Lf+OSZNODrpna0t6x2N53SPPCFmifmVx
 h39amY5env83IZjDIiKlaQYeL60s5PCSxRCtQPhNLhAF8A/Rhx/smiGRmjf2GZ97zbtp
 3YS5uzbmY5Ij/FB3c04cCUatb2EavG8kQnNQdYJ5GAGThOu8xy8fXGem0iLGPvQHXXkn
 hXTrc0HcKNwEU36BpHMDo4c6SCMHpZcqbk82pYDVW65BhYBO0X2Tv61TSd7izPBhUOtu
 lA2sMSh8GgEGSXhF+sKMvhgscUQAYK3s69BR+0EK8OvdYSD+D79hUr/BhX5vUshjPXtg
 d4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880023; x=1779484823;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nsywyvrou/nifvOPzoxYiCCFY2AVnkqkPANe7KEMhOc=;
 b=fhgVEX2l4Zj+5mrZNbWBtQ6XiBOaLBbkk6cfv+DfPN+mGNNI6FRMBCAivvdB2OBgib
 /JY7EzjbEn4KhwVXXLMtQh9jMoFVEatN4Tav/jj4wqpOaTK4dgwEUv06yEib5/VueW25
 C+EhyNglanv3oUQA54zOAPWJcuT2qZWuJSIhU0mITOHihlycFBOuLeuqyi+XwnK9P/wa
 UEJ02mGyPrir3hutUojsgziPffVCBfxf4wjMyEXVt8UsWHxpeMH18WxtvCMGQkXKGlzu
 Ve0ZavFSSn/o/B+TGaFqwFTP53z2IY9N7TvzgoH4B8ol42cSbDfePxS2fqQwjo4w7h3z
 nDQA==
X-Gm-Message-State: AOJu0Yxf2RD4ILfWChK+B8IdV1siGDOfcN8jpwE2ZCj5dMUblXS2mGsM
 XPunF6Hg2/d9/1slyguokHmtJCecFxWoMFXTlDmHwTFMqSt1wyf7CPgVBC3l27MoVIU=
X-Gm-Gg: Acq92OGA23ti5Cay46/005EK6Qqgqlo31twSxsPzn9VF/0Ko/nTdki5NWdqPT0k5+JM
 lgWKnxK02dySu8AFFm6tgMzeBqMkQzuCWq9a8WBn2FOmpYpAEhZTW5k2Iv4B+rVuu6GiwtacoEb
 c5bjBASxj268QBfUcjZQoz2sQA+RKLlKcezd4nV49elgmIV6gHBKDAYtXBwG5jeVCKHXZU1Ivkn
 VRAsANxg9tWTOXgJN7bEdsX3SWMKsLSsuuySSNWb4fPQMJJhdz5+dzV1Q7F0NXUI6HYy3Rd0Gn5
 kBbPbp4+nXRqe6XlKD26vosfC2tGZT3e5ZMg+XZlDNs03QMRJzFQf7tkwCGv+cmNTYx+1UBaDOf
 VlFlzzzT3DNFQ9+pvWAkccPoUbkbhC89bUF5JZiHNUatdu05tOCPT/05MNReAMtT4MVNaT0He4l
 shMyyzIgZgxg==
X-Received: by 2002:a05:6830:608b:b0:7e3:7dcf:9d3f with SMTP id
 46e09a7af769-7e4f2b80758mr3918862a34.16.1778880023616; 
 Fri, 15 May 2026 14:20:23 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:23 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:20 -0600
Subject: [PATCH 21/66] bsd-user: Add sigtimedwait, itimer, and futimens to
 os-time.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-misc-2026q2-v1-21-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5571; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=OezK06KQzfBQ8sP0O3UBskrUbtUhLqlbcFGitRzC+ps=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43jKvYQGL8e9ELougghcnwvBdLQ08BOR6Izx
 3lwHrm6mRiJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4wAKCRBsHNEofbAR
 AL3pEACHbZ/H9QUttPM2/67awInnk6YDGscD/Psrunl4J483LNf9QL+FVkQRwIUsOtPebo7UywO
 5X0U4Vuv2rvzH2vVI0NW/mlaMct1NUF3AM55F2wAgyrTATIx44XQSrDn3q1gQuKDxH6G+W+knBa
 7DrfYmiEdQL2hhHvPvEM7HQhMrLZDQ2iS4FwmrXslxmVIZZHiNUmwRNzQxOh/IxNmMHbRyGhGPs
 89cKB/IxKZXJGvJxrVbl9MgecyYigZFmO/XyDlrHHg+AjVtP6s8s3S+2pjeHEKHM0pEJITvLblg
 cVe4vvibXhCcmNukNuyab3pzNzZ0xROMI6WpGsJjhTv5q0CHpcEiJF+L1YwQvukQHBN5Jx5dVyb
 KCq+JyHRenKblDFo4zhUHfPPJ1aSl3LE4QS2W5hrfHdPEKk8/O72JmKjjVOJKDw4BMh26Syqp2i
 TCHWujKin2LedurWf8Ts1jtyV7RBC+BnjQoPh4dDZUPTUeanDK1LcHGSQsikAJuQqN1Hu4cw0zv
 GLkdvSr6ioNpjN+tupjD1ERynsG9ZTGBQ+dj/uerYkch4ut0Vy4t7ayw2eJ6aTRqdWxoS2SBi/J
 pSMefoRTPuD6LwbkydeIfJyttspZAmv10kQgenx9xktA2aUf98uE93mp/zt+7RVW+d9Mat7PC+Z
 bGdwXgDXPX9f8Dg==
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

Complete os-time.h with sigtimedwait, setitimer, getitimer,
clock_getcpuclockid2, futimens, and utimensat system call shims.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-time.h | 169 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
index f724acdd0a..d838994742 100644
--- a/bsd-user/freebsd/os-time.h
+++ b/bsd-user/freebsd/os-time.h
@@ -803,5 +803,174 @@ static inline abi_long do_freebsd_kevent(abi_long arg1, abi_ulong arg2,
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
+        t2h_freebsd_timespec(puts, arg3);
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


