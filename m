Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC87CDB46F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hI-00032Y-Oz; Sun, 21 Jun 2026 00:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hG-00031S-Us
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:14 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hE-0005FJ-Ve
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:14 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-69de16f5e80so1814182eaf.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015732; x=1782620532;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fZtTWxiy3Ogv5B/0u608EIP34SRmRANB8iJf3S8OoUw=;
 b=kWLzoQgOwh4thukWBr1GZkYt5gr7D3EDtXHPnKpvLBv640Kn0yzxJj44PoR4vi/K9M
 oRm8+nJ3GjpTaOswOZkHejkh3rzcPaD0JsJvJxZ0Cxjuxqn7Zfokg6YW87VQby+acsgh
 AcHefaG8em/OrvQZcJwmVEQmtAd8E0Qbzur2QAhbrUttuRkpC8oZagT1d7R/VzBEQqh1
 AxwvaA5ijGeFn4rwUqQkppiKMEiNiEiLzH+yGFULo/lS+z136G1CPNvgxwQhY6deRFrd
 9pfn0RfjfCzcuLhwHyTp7a2pjgThCagr8RuyYFmhhl9z4Vbez8lIl4Wv8TgEGCcfwD2h
 nW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015732; x=1782620532;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fZtTWxiy3Ogv5B/0u608EIP34SRmRANB8iJf3S8OoUw=;
 b=WPP+7GtUDzmK57xpjbTpv6mBUmo6JybEoVtRShhGpuhdNFDLyLlmymcpFHSJU2aZox
 gxtz0IoOf135GcX+9JWNXIctl6aOzxJPxa4BBoQdjYpoTOAxvxBqeA4q+ePhlIhHb3aI
 aJ5NJQeXdcIMNbT93cWHn4GxTJIRYfeHxCffBkFf4+06LtamUsJ4rOJZWdfYfNQLBwxK
 xuNbEYAJpwEu+av17E+ixeWCP4GkzB9pdnLeuk4vsOQ2v7LwYCr9+Fine9VpfXCMk5Oq
 V2QycDoclyIXX5PuY14L7prqlZPFBJkdgSaGv8A3mSK7gGM3vcZTN6nS7o1xrUtaF9NC
 ngEQ==
X-Gm-Message-State: AOJu0YzodGDDahpyvRdl5AJ4AFWA8nRK6+QTPFn6A9Tmks1pfgIrV9Wl
 BSozzYPgY9ou3lidsNoAwZs0jL0zOVjIg8Trf0znAnLD9Cu4pI6N3vSptulIeoyCDiE=
X-Gm-Gg: AfdE7clyBCBFeVXcAsSnZuRSyt2ifYVxD7MDhyHxs9p8T4rVAjol/GTnpAGVXuoBX2c
 VtEwRAEcKoNwVu2jKLDBleCvqOsUrrCdmCBLWE3JhO6P74ZQExzfzDzWhZphcjzWDd/pjm7Tzbv
 75EwB2vrUmnpp9s3oObFPXI1bZqLDssgumiqT1BdGAS/IEcENWFgQ+a0wKzRbbYZKYBkkFit8E5
 yNW+X/j7sypOmiiIbz9cO/v1CLdEkTQQwwe6uV0njb/B+MyybtIlWeXUwS4OXaRDG2+SqU3AIZT
 G/QtjvGnMfPF0bs9CZoj1Rf/14JgJJ7rpQw7kJW966BXbzRSyNzepUSLujGC9sWymOeWXltQJn7
 mczWqK6gb/YU0K25CKYlFs6XBGJ9RIDVAlSPROClVGkxEr57b4G3evGkgiGJGlj6EF1IhKeTWnK
 s=
X-Received: by 2002:a05:6820:4c09:b0:69d:9c7d:3346 with SMTP id
 006d021491bc7-6a0d88787e6mr8205749eaf.12.1782015731752; 
 Sat, 20 Jun 2026 21:22:11 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:10 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:09 -0600
Subject: [PATCH v3 22/40] bsd-user: Add kqueue and kevent functions to
 os-time.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260620-misc-2026q2-v3-22-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Sean Bruno <sbruno@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8128; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=oomaEER0LpPMa4qFyXb1t1OChGdT1wqYWjUwZX0tLhc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z/Lx8CpF4JmHBs8FA2PCXNbLkX6ukL9XmIb
 Mhd2/NoqcaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfwAKCRBsHNEofbAR
 ANl2D/0YigkDyVkOz0VK3EYPLasrFbvMAl24gM2Art/vGi4xEjpWnwGl1xGgRhUHwBQTOMjgKIP
 3PgXzTRSZh+ggIe814gI6uakbTGEFFQlcZAgWDNOfGyUvt8xl612440E6c6P+h+D0HQh39KYzt4
 PRvzP2HS9vb2pTZWzAs9Oat0HCg8LErJd+iF9JzBbGaUGEp9PDUe6FtRuoc0CUshSRHHfLMnHcg
 ZardfSCDIAw3837gPjHqdIciTZDEOMTfQDaQirB/ryyZSptsxPkZK4dXas7Dz8pupfI9cEvtKGn
 EQzR+8CjOKtf9qfAuzJ4Hw/5ntfXq0nckXTbyjOw/l/nUGlj+67I/JOuHWggmB4YHxTf2o0pzdH
 v/TN5Hs/hum9tGDEcV8uhdsuhb7RgoaPWEFHS/Qfs2BSSPlILLkcUt4+lqRtkVjoolIMJn99SpL
 ZX/504gzvc6bwDUxhOZgB0pfy7AVcTlG5v3NzBE/lu69SPqhPK56Pc4+Bl2LMeoI959/7seP8QG
 sEDM+IiBq5eXYgsW537VFezYFGxfi3QMasxptYXvpiYLsmtOkplziUN9+QtFUIEF4pmpzrn70mS
 0rIYLZi5UKlL+7YtTOOijuOrojKv+e3i4ovL7iHBB8s3+PkiLSgnN7+Gt9fGBbWIrUh7LdhgIpm
 6bL11yEr+gwi9rw==
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

-- 
2.52.0


