Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8809CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5Vf-0000VG-1g; Mon, 18 May 2026 17:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Va-0000U8-5A
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:18 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VV-0000VC-63
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:15 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso1426881a34.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139692; x=1779744492;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=brViEU6vUuDSXtPFY7z05zUWCGk5By4iJYldPBZNo9I=;
 b=o240d/tMgWsxLhQikz/xI8TDfLHDG/+/1IPNgZTTBIrj2H4Mha2RxOugZg9mWe2T5c
 qifsmlm/F25xySbSxF6mXccO/SYJYAssQs6gtgiJK+P2RUPz7ABpWTsYl4Mi8g7joqzn
 0WRplyYlP+YdA6B8mBkgrpc+4+lQbDjCpv6xu6g4F0K1f9nkrq7tpxqD+DLp/axQj037
 KaABjOmAdBPJmspM5+7PWfa16Wgb9oiHXhquIHmZB/UuikRvJ6Mmx5eeBcQxd29xljzO
 hQbNS3ccuRNmydBDxGMiOU4EkYRR+A8jxeskIJ2SWyv2mFFEGtU58XLLOvNBf41Fv9dW
 kVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139692; x=1779744492;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=brViEU6vUuDSXtPFY7z05zUWCGk5By4iJYldPBZNo9I=;
 b=XioaNU7mdJz8VK5DHYyrz/hy9DMZ1HAjBdPxefvOcjtI6csKRgAqUOkm5+YogbM9Xs
 ZNaysA6PQI6l73stR6GOXVqUCpqTBCS4iw2Ay4QKwm4ZqjvOqik9aJ9PezmbCwR2ExXx
 zjKhrQHnniLKsIgzOXctc5VActnALeNurerCyl0ttbSSHLx5MVSNvG3SYPwZUNgd6fLM
 VihXSDE7TsPuGuVQoVzb7nl4/JJPNVepoxvYLFf0pBapgicfe0vQcz6dmus5gDagb6Gs
 jwFYM4xhoF7Q/fR2VewOzZnQGOGLBA4KQCKxE6+yv00vkpmhCkv97202l6w+vNgtwCGz
 baSA==
X-Gm-Message-State: AOJu0YwCDpcsZ/qCkoEKtllSuSkIGEagI6iD5+lHM7iX2UmAjFvL14GY
 f9analeptv73EHqLG163H4+JmSehiF+YB/9VLWPTGTWqUw9AzoVDyA8ADQ3mXI2vmRs=
X-Gm-Gg: Acq92OEM51ySAz9DFTQJZN5iKykujx95RpW96Gh7S0hiOi5lqHAfRltA/zfgfmcBHyf
 HTqR7bR8BMJ9tck6Xc+b/h1wJfGEFhdtJhFpL0/e0DvHFiXYEQ0aCRy0vX3wjXqZhWZuHQLiaP9
 S8qoF1E00qgA203e2gkCWdGkZSDKir0hFZF4vMsf58AdDzztpBKZ/RAq/5irYXRdM4b6NvQbue9
 W36izYPaNdVhC08LwkrCJW8Sa9J/3dFlp/P+TK1tkAl1sHhPJe5/vespJRRIO9uBLm74tKHyXZi
 d6m+SoSmEimqJxCLEq1e25LeJI2vivb0g0VKoLJMIpLfEC7iE9vyTGIDtvUJnu218ECDAnN55af
 nhpUWPje6klYL05VrApCBme0PkIZ3lqcX3otil1Vok3hbwx8DQhBwTg0j82QUSnkknsf/Tkd3Ev
 Uw5tvt9AE25bYK08n1rpKd
X-Received: by 2002:a05:6830:3983:b0:7de:44a5:51ea with SMTP id
 46e09a7af769-7e4ea07a522mr10373030a34.6.1779139691985; 
 Mon, 18 May 2026 14:28:11 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:11 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:38 -0600
Subject: [PATCH v2 20/37] bsd-user: Add kqueue and kevent functions to
 os-time.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-misc-2026q2-v2-20-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Sean Bruno <sbruno@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8160; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=V7aPc+aOfD1PWed0e7bWG+wlTSpCwp0HL2tfbVJtQQY=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RHBBj0qH/Gxv3NexcrLSRzHINEUOHB0FyOP
 KpS6X8qvUeJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguERwAKCRBsHNEofbAR
 AMNsEADSwqe3yqI8wOrcQS9wTCQHe9W9GjD6gsgBeJCvlyfVqYr36x3QrYz6MBtPVfoYfQHKEyZ
 ZVVU/+auUgGQGAd6JTnkrSOS5Ax/o56r/r0w0MYDZbVEXCg8+m8ODgnYDX69Ka9MlXgCDJI4LDf
 uWVoXf20lwbha9pB/4cy93QtQq5lTUCQxd+GVVGjy28UFUNPbw/4oCTgy79b1GrVrqFofCXho2I
 f15foyKCrcEP+sz1wfpsx7MHLak3M3tcS2XdNDc2AGwL7CbqtE/hxsyu6nhPOWIOs/NHhzEd/oY
 YRlhhX5QKvUK7VTZxCa/cyTHXbHN3DtZyvEYyAsFHOfqoxVuhozLlM1VYuIc7HuC3qH5B0TW7n7
 AVxpC6Emx99wJ5JRYiFwgp+jvSX03O8wJjl/y3ABcD+YXDKr8coPzCUxwvITjWU7aeJxjR/txBI
 u8fULtGjWXS8dAuJEZDLP/HkgGEapJ7WDiFnPVpCz1q0+2k9h/v6tZrY7yv5mt1MyW9CImVvmoO
 8hkDnObu/8HtBKZZdIcQMoOBMBAQpI6maEtN5fP/cNZLYARc5DtW0osipp0izuh+RjHaQDKFKi5
 l4xEImK1fljnbu/iXz8uZYq9R7DrCiWLdPD1onwMp6lZ7Fa4NWqfRqHDI6Zp/W5BL8iM+yKnbUR
 czbaGDMM8Up0n0g==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-time.h | 173 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
index 12c5ba02e8..078355392d 100644
--- a/bsd-user/freebsd/os-time.h
+++ b/bsd-user/freebsd/os-time.h
@@ -629,5 +629,178 @@ static inline abi_long do_freebsd_ppoll(CPUArchState *env, abi_long arg1,
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
+        unlock_user(target_changelist, arg2, sizeof(*target_changelist) * arg3);
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

-- 
2.52.0


