Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99F0C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThG-0002Wv-GJ; Tue, 18 Aug 2026 19:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThE-0002SY-Uk
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:20 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThC-0005Hj-V9
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:20 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-448b69cfc6dso391768fac.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097498; x=1787702298;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uDG4yCGcdRHP3prcLODrCCoKPU0me91/+MFRsrPpUeU=;
 b=AwM/27s7DSWsIoi1KoUa5pi2lN8iNJ9vuDTP2LiENNuX+KIE26OEYekwhlhh1wQHgq
 N1qsctOSipL+uO7eqbPTzq+9H1SlwSnmv0NhAFsqn0Sbwe9MkDeUasBHtB1mXMpE7Nrz
 L4wS0dBoA/d+eG86mBuZueStJr3H1Rb3lZoc8O+u0E79TfILaDNtp0K21DLTCOiHwUe8
 JbSqj2oiVDW3fAm4ZphOsc0CTwSXerQyKijxvR5OI/RRprI7ufch8nyNZZuTpHikgAwr
 KGrlikrEad7Tc7uvKLt0vmDtY/UO9kkScTP2qB19sviOj/oJmoAVOeLZ9BiFyCBWn2bN
 V4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097498; x=1787702298;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uDG4yCGcdRHP3prcLODrCCoKPU0me91/+MFRsrPpUeU=;
 b=JFJdRJ40naN/pEwan4j7xv9+ZvZs9rA/AoxGyeuAfCjUXu4sw7YpegRA9OVJhthifW
 ng2zZCRmN5TOf8aB/vwGqQN/YpheSppM4cSKPUkvviN4Sc4xEZ875LG/3DLfHQpx3ddj
 6r2A2mLV5zRzQQ/dyoRVjBFjOa3Ru40OB9ah1y+1am/rv18JdeDpMnKDZ7FG6ktIqOQY
 p2Nm8t3yLGuNeI2dah+k4Xpi11KKSatCEle5aJ0Y59JnmzLUtNVa6GKLPl2Q3NlYE/HV
 XiHlYNDhjchoKcq11fDm00no7OMAxmadk5b54vmNQzSvs/8C6B8f0GoAxK1oLRBWPDsy
 2H9A==
X-Gm-Message-State: AOJu0Yw4MTQUGaqx76Jf0hGfjPhQrx6R6MMOYBAleRBTNZJodT9aKRLy
 Ou1i/8m+v30M6wbpnc4NmNTkWOGXC6Q1qh7LhDoqlfIkdnKFbCKoCLK7jIMSRbSTTzw=
X-Gm-Gg: AR+sD11pVEsAXC2C+dKcuNtbk/dmsA7RUaW3zTC2QbhqjDhbbNXX0f+0bpP7jqAlQfH
 1U0bOEAM3AzpKA9SLecxlwtepvg7UtNojICWs1411ix3Ycroz+YrTunaOgyXBr+a0lHCPpc2zVT
 WL9TBbIVxAD4vSfuS/hwHQOUPLG1Hbn/96NmBxl3ulH8NlxlR6i5WKzCuPSQ/vzauG1jJLOUKeO
 cqAN09v8PWPJ/JdhogqS+Zu55YXwOPlJMXEaNbUE3X2RKseRpIbG7BEWvhHXSoxHgoMAx62xutk
 D1pv+84zYexToTdnKKdAejefq6X/iQ77y4zC7KWbNFsNOAcnQXm3r9/JyCi30ncxtRqpEPxb8iD
 efHROsmEHLQTmTratf5Tb8N3eldrK7U9vgmsGpfFi90T4HB2IuyKd7TxbTwz8Fv8mO59/JjTt4K
 tGwnsLgoaPJq/xroTSEFXTwngZwkbt9Tn8j+SJ2bsrru4BKds=
X-Received: by 2002:a05:6808:c1aa:b0:4b2:8d77:6da with SMTP id
 5614622812f47-4b2bca1ce54mr358800b6e.12.1787097497918; 
 Tue, 18 Aug 2026 16:58:17 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:16 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:17 -0600
Subject: [PATCH v4 24/40] bsd-user: Add kqueue and kevent functions to
 os-time.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-misc-2026q2-v4-24-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Sean Bruno <sbruno@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8920; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=muZxOBZ3S8D8Kb7WE0PTqk9FRzzKO+A1f6tHfX8PgRU=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFFdyqCz1Nut/Uia9yb9XcFxsRVJ40tfWYk7
 IoatXzyo9aJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxRRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQCZJBAAr6ZhONxH20t5x8Lk9FqRpUuiqRatwIY
 jEwMZy5L6hKzElz4fkXW+84zIJczqYRj6Ey7hFnITXJGsRTUA0/0n2/lrdBC2IhHFeUzBOstsGr
 4GvWtWzRJE7IihZcleYWcqSTsKAIOrjwz4rQwICivzO8MJdMJmuS59ZhmkEt4E8Z9HRMU7GbbmF
 LdrNtafT+9fJ7T8I33HVe1+nk97+E0340LG9wFm4PX7TNqCK6zB4NzjoQ/EuD2sKsOT6+eTf5LJ
 qJTDaPbjjL/+D26TaSDghMuuIlBer2krvlDFHhZa5qV2DKE5qawvGF38bF4MgRGr9Dv4+SUIWSv
 uwSOaw5WDInP2/BVu3WH0Bt3/InHlSrPPpIhASAhO3ciMnegttPsiRSjqiB5rDhI8ByTPv6hAHF
 QXXwmqpa5YkZ9Q3PDuqnqA47p3dBHwzmOEnGsRnab3oyGqVtAfWwxbnbN3f7ds2Q58REqxWqoM1
 ypjeuMzbE1R+ibEdFEcDcl5ptGfKlZncbsMjQhKEK3wMmGX+5Ac8Lv/8CIn+T9n2HSLCY5LMJFb
 ZqYBd33f9exXwn3us+KEXCot07pseUEY6lQSQvQcQUlxcQ+vqiuhiO4lxBWG4XortCVBE3fKBky
 fd7Z7zT1PnZFY8JdZQkQZq1CQvRDF2KzaHN6DILwMF3PdBP10fzA=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::30;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x30.google.com
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

Add event notification system call shims: kqueue, freebsd11_kevent
(legacy 32-bit data field), and kevent (with 64-bit ext fields).

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-time.h | 173 +++++++++++++++++++++++++++++++++++++++++++++
 bsd-user/syscall_defs.h    |  22 ++++++
 2 files changed, 195 insertions(+)

diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
index 5f537fac40..302872dd8e 100644
--- a/bsd-user/freebsd/os-time.h
+++ b/bsd-user/freebsd/os-time.h
@@ -635,5 +635,178 @@ static inline abi_long do_freebsd_ppoll(CPUArchState *env, abi_long arg1,
 }
 
 /* kqueue(2) */
+static inline abi_long do_freebsd_kqueue(void)
+{
+
+    return get_errno(kqueue());
+}
+
+/* kevent(2) */
+/* XXX Maybe some day, consolidate these two... */
+static inline abi_long do_freebsd_freebsd11_kevent(abi_long arg1,
+    abi_ulong arg2, abi_long arg3, abi_ulong arg4, abi_long arg5, abi_long arg6)
+{
+    abi_long ret;
+    struct kevent *changelist = NULL, *eventlist = NULL;
+    struct target_freebsd11_kevent *target_changelist, *target_eventlist;
+    struct timespec ts;
+    int i;
+
+    if (arg3 != 0) {
+        target_changelist = lock_user(VERIFY_READ, arg2,
+                                      sizeof(*target_changelist) * arg3, 1);
+        if (target_changelist == NULL) {
+            return -TARGET_EFAULT;
+        }
+
+        changelist = alloca(sizeof(struct kevent) * arg3);
+        memset(changelist, '\0', sizeof(struct kevent) * arg3);
+        for (i = 0; i < arg3; i++) {
+            __get_user(changelist[i].ident, &target_changelist[i].ident);
+            __get_user(changelist[i].filter, &target_changelist[i].filter);
+            __get_user(changelist[i].flags, &target_changelist[i].flags);
+            __get_user(changelist[i].fflags, &target_changelist[i].fflags);
+            __get_user(changelist[i].data, &target_changelist[i].data);
+            /* __get_user(changelist[i].udata, &target_changelist[i].udata); */
+#if TARGET_ABI_BITS == 32
+            changelist[i].udata = (void *)(uintptr_t)target_changelist[i].udata;
+            tswap32s((uint32_t *)&changelist[i].udata);
+#else
+            changelist[i].udata = (void *)(uintptr_t)target_changelist[i].udata;
+            tswap64s((uint64_t *)&changelist[i].udata);
+#endif
+        }
+        unlock_user(target_changelist, arg2, 0);
+    }
+
+    if (arg5 != 0) {
+        eventlist = alloca(sizeof(struct kevent) * arg5);
+    }
+    if (arg6 != 0) {
+        if (t2h_freebsd_timespec(&ts, arg6)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(safe_kevent(arg1, changelist, arg3, eventlist, arg5,
+                                arg6 != 0 ? &ts : NULL));
+
+    if (arg5 == 0) {
+        return ret;
+    }
+
+    if (!is_error(ret)) {
+        target_eventlist = lock_user(VERIFY_WRITE, arg4,
+                                     sizeof(*target_eventlist) * arg5, 0);
+        if (target_eventlist == NULL) {
+            return -TARGET_EFAULT;
+        }
+        for (i = 0; i < ret; i++) {
+            __put_user(eventlist[i].ident, &target_eventlist[i].ident);
+            __put_user(eventlist[i].filter, &target_eventlist[i].filter);
+            __put_user(eventlist[i].flags, &target_eventlist[i].flags);
+            __put_user(eventlist[i].fflags, &target_eventlist[i].fflags);
+            __put_user(eventlist[i].data, &target_eventlist[i].data);
+            /* __put_user(eventlist[i].udata, &target_eventlist[i].udata);*/
+#if TARGET_ABI_BITS == 32
+            tswap32s((uint32_t *)&eventlist[i].udata);
+            target_eventlist[i].udata = (uintptr_t)eventlist[i].udata;
+#else
+            tswap64s((uint64_t *)&eventlist[i].udata);
+            target_eventlist[i].udata = (uintptr_t)eventlist[i].udata;
+#endif
+        }
+        unlock_user(target_eventlist, arg4,
+                    sizeof(*target_eventlist) * ret);
+    }
+    return ret;
+}
+
+/* kevent(2) */
+static inline abi_long do_freebsd_kevent(abi_long arg1, abi_ulong arg2,
+        abi_long arg3, abi_ulong arg4, abi_long arg5, abi_long arg6)
+{
+    abi_long ret;
+    struct kevent *changelist = NULL, *eventlist = NULL;
+    struct target_freebsd_kevent *target_changelist, *target_eventlist;
+    struct timespec ts;
+    int i;
+
+    if (arg3 != 0) {
+        target_changelist = lock_user(VERIFY_READ, arg2,
+                sizeof(struct target_freebsd_kevent) * arg3, 1);
+        if (target_changelist == NULL) {
+            return -TARGET_EFAULT;
+        }
+
+        changelist = alloca(sizeof(struct kevent) * arg3);
+        for (i = 0; i < arg3; i++) {
+            __get_user(changelist[i].ident, &target_changelist[i].ident);
+            __get_user(changelist[i].filter, &target_changelist[i].filter);
+            __get_user(changelist[i].flags, &target_changelist[i].flags);
+            __get_user(changelist[i].fflags, &target_changelist[i].fflags);
+            __get_user(changelist[i].data, &target_changelist[i].data);
+            /* __get_user(changelist[i].udata, &target_changelist[i].udata); */
+#if TARGET_ABI_BITS == 32
+            changelist[i].udata = (void *)(uintptr_t)target_changelist[i].udata;
+            tswap32s((uint32_t *)&changelist[i].udata);
+#else
+            changelist[i].udata = (void *)(uintptr_t)target_changelist[i].udata;
+            tswap64s((uint64_t *)&changelist[i].udata);
+#endif
+            __get_user(changelist[i].ext[0], &target_changelist[i].ext[0]);
+            __get_user(changelist[i].ext[1], &target_changelist[i].ext[1]);
+            __get_user(changelist[i].ext[2], &target_changelist[i].ext[2]);
+            __get_user(changelist[i].ext[3], &target_changelist[i].ext[3]);
+        }
+        unlock_user(target_changelist, arg2, 0);
+    }
+
+    if (arg5 != 0) {
+        eventlist = alloca(sizeof(struct kevent) * arg5);
+    }
+    if (arg6 != 0) {
+        if (t2h_freebsd_timespec(&ts, arg6)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(safe_kevent(arg1, changelist, arg3, eventlist, arg5,
+                                arg6 != 0 ? &ts : NULL));
+
+    if (arg5 == 0) {
+        return ret;
+    }
+
+    if (!is_error(ret)) {
+        target_eventlist = lock_user(VERIFY_WRITE, arg4,
+            sizeof(struct target_freebsd_kevent) * arg5, 0);
+        if (target_eventlist == NULL) {
+            return -TARGET_EFAULT;
+        }
+        for (i = 0; i < ret; i++) {
+            __put_user(eventlist[i].ident, &target_eventlist[i].ident);
+            __put_user(eventlist[i].filter, &target_eventlist[i].filter);
+            __put_user(eventlist[i].flags, &target_eventlist[i].flags);
+            __put_user(eventlist[i].fflags, &target_eventlist[i].fflags);
+            __put_user(eventlist[i].data, &target_eventlist[i].data);
+            /* __put_user(eventlist[i].udata, &target_eventlist[i].udata);*/
+#if TARGET_ABI_BITS == 32
+            tswap32s((uint32_t *)&eventlist[i].udata);
+            target_eventlist[i].udata = (uintptr_t)eventlist[i].udata;
+#else
+            tswap64s((uint64_t *)&eventlist[i].udata);
+            target_eventlist[i].udata = (uintptr_t)eventlist[i].udata;
+#endif
+            __put_user(eventlist[i].ext[0], &target_eventlist[i].ext[0]);
+            __put_user(eventlist[i].ext[1], &target_eventlist[i].ext[1]);
+            __put_user(eventlist[i].ext[2], &target_eventlist[i].ext[2]);
+            __put_user(eventlist[i].ext[3], &target_eventlist[i].ext[3]);
+        }
+        unlock_user(target_eventlist, arg4,
+                sizeof(struct target_freebsd_kevent) * ret);
+    }
+    return ret;
+}
+
+/* sigtimedwait(2) */
 
 #endif /* FREEBSD_OS_TIME_H */
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 0d7002312f..f4bb687388 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -155,6 +155,28 @@ struct target_freebsd_timeval {
 #endif
 };
 
+/*
+ * sys/event.h
+ */
+struct target_freebsd11_kevent {
+    abi_ulong  ident;
+    int16_t    filter;
+    uint16_t   flags;
+    uint32_t   fflags;
+    abi_long   data;
+    abi_ulong  udata;
+};
+
+struct target_freebsd_kevent {
+    abi_ulong  ident;
+    int16_t    filter;
+    uint16_t   flags;
+    uint32_t   fflags;
+    int64_t data;
+    abi_ulong  udata;
+    uint64_t  ext[4];
+};
+
 /*
  *  sys/resource.h
  */

-- 
2.55.0


