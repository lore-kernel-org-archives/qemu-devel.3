Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60676C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThE-0002P0-95; Tue, 18 Aug 2026 19:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThC-0002Fy-No
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:18 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThB-0005HY-0a
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:18 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4a4cb36ae00so358101b6e.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097496; x=1787702296;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IhFAjZZMyJohtdthl03q6c5wOua16KMjZuzyVS5+u4k=;
 b=N0VmvSYfqW0FBzWmMhDUoXMBjKZMSXlOJrGxb9YVyfEtvkeJyVXimNtC5rYtWk7OXQ
 4WO5LFzWecg+SeRaXhD9BrapfOzxrDwwpceV9whQtlpkUs9ltLrI43PyByx1NSSrw04X
 GFSdK4xALF/VSEfKrjUQYMhXVBZU3Cdi5VVk5LqJT0euQDJpRTVXB1FAaCg8N31m8NlF
 Ni8dbU49CrfZtUoQovRGsmRW9ZyLp9z9dp6+DYW9UsO99cSG0TVIJQmZu/K7G6Ncvxvc
 jD4DEnuPD/AodqD4ldwqT9afIYT9xJB/papFA+cfxBXbEkYfZYojFcEMA7E6z3LvEZ+j
 37vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097496; x=1787702296;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IhFAjZZMyJohtdthl03q6c5wOua16KMjZuzyVS5+u4k=;
 b=EKtGHDAx0qYSiE0RDnomPX2+A9Klz6b7oOb8oGnYMmSKmKvjCB16KS53bJtyo4KJD+
 1Fbai4g4jgsZlQtVqAMRmKuDh4jQFOtxIHvjjm3INcAxXLahUkA5b0r6GWO6JZGxCros
 itydCVoWG+tMJGcn7WAV2HW5WeQkTJ12KOKth5JLrMngyXZLGNpZ9if6tNvz84FlSBdd
 uMbUDRpPAU1TJO9gqtc9aRE0DDqpkuIjCBeaRwkM/LH7Q5sLr7ZZX5dFEe4FV3gI/A45
 n9OlrjwScyHmb2xEMt1jV3MFy85QcmcYzOfyFCSXfQWkrcnN/MCQuV0Zc8aM47t+67gj
 M8NQ==
X-Gm-Message-State: AOJu0YxcbNXMBxK9AGgrsnql+fsmO6HzgUqSHRJ0WR/RoraW3EiPSSZn
 o/aEdnLxd93aza4eJIfDT/+cD7LGGq87b2/2+i9+qwD7wI8bW6+q5NZvckFF01BPrKs=
X-Gm-Gg: AR+sD120N6KA2xWK6K//1e0EY1sUkrZCnOR84ACXe6m9rzpEEZEUwBNuT95ozrM4TUL
 aoqWjr4nQrCNuJByexXgGqNdXrw1IkSiAYoOJ23QrN4YMfWxcbyby8Ydy3QsWdBZM5N+zAzedp2
 JZVmkFjU3/dZQyjJP0Hifw4ODl4iaLVn+AqKDXnhTNr5Db6SV2RznarUNfecVHt5GinQcXhWJig
 jZKaWW4BaOowrKhST6OAl4C2GBQNcuSCZ2jnO+qi7/UPPuf8fM3HuCT+pLOZfakjiwtbakvNzsW
 8JeFtjRQb1rwexLwolY5pIF0Y+ExGQA8zyWxH9b34u7NFRNiE/KRPYcupKdc+CA+Hbnr92EMKRV
 eSKLcJfU0/pgmdVdXS1u0+xsuM3kSqLOt5MRsCLfQu7O5G+6JNx3rGc4yn7FkxqlcHFGKIQjDTk
 Dhe2i/4gunU+yKzim/Sp+mnMsGnzRyAHX3TPF1TSLHGJ87jFQ=
X-Received: by 2002:a05:6808:6801:b0:495:d7ec:b6ae with SMTP id
 5614622812f47-4b2bcaed728mr344562b6e.16.1787097495720; 
 Tue, 18 Aug 2026 16:58:15 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:14 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:16 -0600
Subject: [PATCH v4 23/40] bsd-user: Add select, pselect, and ppoll to os-time.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-misc-2026q2-v4-23-09bf5647c98e@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6870; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=HGQ7SwnKbXuAzdRb0W1BS23erbGTC2RfkZIxZ6LrY7A=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFDt9towFUibWZQ6znxbHIdYVEylzM2m7nNW
 U6Dl6EioVmJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxQxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQDGixAA4+if6pmdbPyTsZ+ovt4MgtwYmXR1iTK
 joj2llecUvouYxZ41+2iOxDFPFzaY3vJqBjugVmqAnraBiTpy7HM/jLgarIimYiyrQEG+26RVo3
 SXd0KKFOo0uODLm1XCPE1IXr/QtxtKX2osJTn9L/x9M92Ou8Xt/ic1K8o81VK7eS5azhmp1SDFk
 ONTtuaxrArdpybKjbZtk9vpqr2JIbMiu9OUSwtax1oSFcGExPGqZC/LBNclmbYn/fURqI24kxCW
 1LLsuoLPMvHkYR2/BUja685trVEgZTVKGpMQXldzPKLTdzrxd2nHGdnSXcDU8iFCnijYX7D0nzJ
 wP1wFexr2vzAtEbZS+jTqEpV2QuykFkcq5MC3jb+29sXk1Tu527bbj/u12haTHbBCO8P5QM0F50
 5XRjeuVXso3wJ3lancZBm3dbs7cSyfBfrOLVvGzbFvInju/RHraMFZ7cqNX9HE+S1gK7WIQfT0S
 4iJ0uVOwXOnx2Y1mVIywkMduyXnjvU0Nc/1Jy2PnmGUXkPMvM/tiOCFVcBCje0h+r34gK0tRhls
 TpzJygcSpWZcno195ykqmcfH9osWM6z346c1qiLYe+1YSKBh2Us+mmNCTtn31IZVE065HwMltEs
 hTWOvO7U6KAbWSgVj+TmS+bEEPb5N4cw8QukRYtrXlxkVgfHGE0A=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::231;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x231.google.com
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

Add I/O multiplexing system call shims: select, pselect, and ppoll
with proper fd_set, timespec/timeval, and signal mask conversion.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-time.h | 202 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
index 06104a5b7d..5f537fac40 100644
--- a/bsd-user/freebsd/os-time.h
+++ b/bsd-user/freebsd/os-time.h
@@ -433,5 +433,207 @@ static inline abi_long do_freebsd_ktimer_gettime(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* select(2) */
+static inline abi_long do_freebsd_select(CPUArchState *env, int n,
+        abi_ulong rfd_addr, abi_ulong wfd_addr, abi_ulong efd_addr,
+        abi_ulong target_tv_addr)
+{
+    fd_set rfds, wfds, efds;
+    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
+    struct timeval tv, *tvp;
+    abi_long ret, error;
+
+    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
+    if (ret != 0) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
+    if (ret != 0) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
+    if (ret != 0) {
+        return ret;
+    }
+
+    if (target_tv_addr != 0) {
+        if (t2h_freebsd_timeval(&tv, target_tv_addr)) {
+            return -TARGET_EFAULT;
+        }
+        tvp = &tv;
+    } else {
+        tvp = NULL;
+    }
+
+    ret = get_errno(safe_select(n, rfds_ptr, wfds_ptr, efds_ptr, tvp));
+
+    if (!is_error(ret)) {
+        if (rfd_addr != 0) {
+            error = copy_to_user_fdset(rfd_addr, &rfds, n);
+            if (error != 0) {
+                return error;
+            }
+        }
+        if (wfd_addr != 0) {
+            error = copy_to_user_fdset(wfd_addr, &wfds, n);
+            if (error != 0) {
+                return error;
+            }
+        }
+        if (efd_addr != 0) {
+            error = copy_to_user_fdset(efd_addr, &efds, n);
+            if (error != 0) {
+                return error;
+            }
+        }
+        if (target_tv_addr != 0) {
+            error = h2t_freebsd_timeval(&tv, target_tv_addr);
+            if (is_error(error)) {
+                return error;
+            }
+        }
+    }
+    return ret;
+}
+
+/* pselect(2) */
+static inline abi_long do_freebsd_pselect(CPUArchState *env, int n,
+        abi_ulong rfd_addr, abi_ulong wfd_addr, abi_ulong efd_addr,
+        abi_ulong ts_addr, abi_ulong set_addr)
+{
+    CPUState *cpu = env_cpu(env);
+    TaskState *tstate = cpu->opaque;
+    fd_set rfds, wfds, efds;
+    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
+    sigset_t *set_ptr;
+    struct timespec ts, *ts_ptr;
+    void *p;
+    abi_long ret, error;
+
+    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    /* Unlike select(), pselect() uses struct timespec instead of timeval */
+    if (ts_addr) {
+        if (t2h_freebsd_timespec(&ts, ts_addr)) {
+            return -TARGET_EFAULT;
+        }
+        ts_ptr = &ts;
+    } else {
+        ts_ptr = NULL;
+    }
+
+    if (set_addr != 0) {
+        p = lock_user(VERIFY_READ, set_addr, sizeof(target_sigset_t), 1);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+        target_to_host_sigset(&tstate->sigsuspend_mask, p);
+        unlock_user(p, set_addr, 0);
+        set_ptr = &tstate->sigsuspend_mask;
+    } else {
+        set_ptr = NULL;
+    }
+
+    ret = get_errno(safe_pselect(n, rfds_ptr, wfds_ptr, efds_ptr, ts_ptr,
+        set_ptr));
+    if (ret != -TARGET_ERESTART)  {
+        tstate->in_sigsuspend = true;
+    }
+    if (!is_error(ret)) {
+        if (rfd_addr != 0) {
+            error = copy_to_user_fdset(rfd_addr, &rfds, n);
+            if (is_error(error)) {
+                return error;
+            }
+        }
+        if (wfd_addr != 0) {
+            error = copy_to_user_fdset(wfd_addr, &wfds, n);
+            if (is_error(error)) {
+                return error;
+            }
+        }
+        if (efd_addr != 0) {
+            error = copy_to_user_fdset(efd_addr, &efds, n);
+            if (is_error(error)) {
+                return error;
+            }
+        }
+    }
+    return ret;
+}
+
+/* ppoll(2) */
+static inline abi_long do_freebsd_ppoll(CPUArchState *env, abi_long arg1,
+        abi_long arg2, abi_ulong arg3, abi_ulong arg4)
+{
+    CPUState *cpu = env_cpu(env);
+    TaskState *tstate = cpu->opaque;
+    abi_long ret;
+    nfds_t i, nfds = arg2;
+    struct pollfd *pfd;
+    struct target_pollfd *target_pfd;
+    struct timespec ts, *ts_ptr;
+    sigset_t *set_ptr;
+    void *p;
+
+    target_pfd = lock_user(VERIFY_WRITE, arg1,
+                           sizeof(struct target_pollfd) * nfds, 1);
+    if (!target_pfd) {
+        return -TARGET_EFAULT;
+    }
+    pfd = alloca(sizeof(struct pollfd) * nfds);
+    for (i = 0; i < nfds; i++) {
+        pfd[i].fd = tswap32(target_pfd[i].fd);
+        pfd[i].events = tswap16(target_pfd[i].events);
+    }
+
+    /* Unlike poll(), ppoll() uses struct timespec. */
+    if (arg3) {
+        if (t2h_freebsd_timespec(&ts, arg3)) {
+            return -TARGET_EFAULT;
+        }
+        ts_ptr = &ts;
+    } else {
+        ts_ptr = NULL;
+    }
+
+    if (arg4 != 0) {
+        p = lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+        target_to_host_sigset(&tstate->sigsuspend_mask, p);
+        unlock_user(p, arg4, 0);
+        set_ptr = &tstate->sigsuspend_mask;
+    } else {
+        set_ptr = NULL;
+    }
+
+    ret = get_errno(ppoll(pfd, nfds, ts_ptr, set_ptr));
+    if (ret != -TARGET_ERESTART) {
+        tstate->in_sigsuspend = true;
+    }
+    if (!is_error(ret)) {
+        for (i = 0; i < nfds; i++) {
+            target_pfd[i].revents = tswap16(pfd[i].revents);
+        }
+    }
+    unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
+
+    return ret;
+}
+
+/* kqueue(2) */
 
 #endif /* FREEBSD_OS_TIME_H */

-- 
2.55.0


