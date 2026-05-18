Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4852CD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5VJ-0000Mc-FH; Mon, 18 May 2026 17:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VH-0000LZ-Au
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:27:59 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VF-0000Q5-Db
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:27:59 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7df05fc49e5so2995760a34.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139675; x=1779744475;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UcX93/bsPzSGtEWzCQDxEM4bepZUbVT03Usa9qIq4yg=;
 b=CbxuMFXslcvp8mMx+PGAZmr9DMfEfU0Na5N/WDEUyOXbt4qc0krUo5sUCsX8VWJgqz
 zR/NDSv1ZOcHBMon7fS0UNZwcoABIEyz65CxHEIxhCplupJMfubtYpbGiR/cX6fc6Tnv
 PH5XrvfCRBabKVRcix33taY0s/rTfzbLV1rG4oX5IAtt7BYQEnfp8mOT6GM4hsBf6A1N
 vj6EsLfnZpHWQ5g3Q7hqiKHJTqtTNIvmIPsz4N92FwLiFGij3nSkxAyjUfnPmCrhiXpH
 /ePXsKrfXVqFR7XD6OBqTWiH/fiW5AernjtV/rwSE/rnVVeFX1yHBVOh3Bg8FVCIeE5/
 kyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139675; x=1779744475;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UcX93/bsPzSGtEWzCQDxEM4bepZUbVT03Usa9qIq4yg=;
 b=AgfZiKM52x7lJsf6BkDSDR9c8CJDRNpBDEVBsaNJhbOpIkG0tqIwMIbDafVBSsd1ec
 weSkoKJj5Azox//ssLHaa0JSE0eZ8yneRgJ4P6LqHshKdhPOXvxvOral0IZBO/OTjpxI
 rS2O5PbJ4euTn8wn8r5tZm+KTjqXHMQGhLNJcSGFvddbLxhOZTleavhsywzPzv9NSSLj
 6e2mEM/JUTTBJD+Z3U5tZcvgxC4WDW9WRU/mIrLGlufnMbaHTNZ7h2CCDPUL/TBt8acV
 2OLKdAX2pbV8FXta5KEQTvqaLir1d7WNWBGgFBdVgPZPYPzDscn5UYjS1ut3QECtEsSL
 84Sw==
X-Gm-Message-State: AOJu0YzBdxr9Un+fZeNefZK2gF+PKwD3tuym5PXoBZWdEHuyW/bGONEj
 M9dThVBH07eIct8i+IJlG2ZIPwL2x4v4Gf+KRll4XlqhqchM+fDdje0hOmMmY6Ypw2k=
X-Gm-Gg: Acq92OHZv3UOo5MtbKPLGUXEKbYj+8YtvfZUrjNgx8LIEDM011JaMU6Wjt1FHwXHaBF
 yjdKIIrDs3zgN/hfk6f8n5uiU10TIBELD/LWd4HUkSdABG9tdIAldJBkzx1EQU51Qrm9ChQ2zHd
 B5/2cOuiS7spVWCafs8ovqyUb6dkcuSohn8HB6CFfDnu0397806iHy0cc505aPxCdLwx6B35H7+
 dAjWbi+WwBk5i38XJG0cs3SKOFhU7Enql5belQZyRlX1Pvt8nhAsHhQAkli0mqJGXAL3w6NitK6
 QiDrvnZgkxZxBbvlWn5d3a5l/lDpoqy7gCU2iHhKkdZL8worRGNSEtq7Q9o/yyLppX+KZ0m2gzN
 L7XUWwVEmD7FSAiOM+vupkCYpYiknkkwLCDItDu3HMtpQnnOoWejHbH5S3pJIyfQ/jJh2Rr3Y/R
 eKDoYzVYbCHg==
X-Received: by 2002:a05:6830:82ec:b0:7dc:5899:c711 with SMTP id
 46e09a7af769-7e4ea06e807mr12552515a34.3.1779139675580; 
 Mon, 18 May 2026 14:27:55 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:27:55 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:22 -0600
Subject: [PATCH v2 04/37] bsd-user: Add signal shims sigwait through kill
 and os-signal.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-4-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3843; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=N1BQ+ZOiFjKjIFi+9oZiikyUY80Tcc3sfec9pgHMLJc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RGhXbsCm06+k/ykljUHlkaUFVcb8P1iF0jL
 x4yO/XImoyJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguERgAKCRBsHNEofbAR
 AJQJD/wLPtpV2fXNpBVKj4kMaE6iAwNAA97SqVihoulelAybWHGkS1SUu+/F5FdGcrm/cS+laJt
 SSyq8gnsbMB76kvGw211kou+r+XJFHObWzlJogWEj/985LqnmTYBYiaPzwA2R4KGsFSVvPNg5ph
 tK9o8OBllma1SgMDj6ZIcI/w2YMbgUQbwUbQthitxrZ4Rgd879CsrmA3EsalGaM+A8hwsrd7ueW
 iwp98AgqqtmPflTn3a00kqlLRugMDlhvniabUuuIN+UDezRJKXlIoUzDdAxWBmb9a4HXb+2jwOr
 qZyYtMnCH16VQuW3Xo4OO2rHdq7wIkDzAMa6RhW390jgTaCNeJ7kN9kE8eLJTfkVwaqW/JurL8v
 2wWZkx2Lo7PEk/4MlO3YlVT/BVsgQubgp0ZTrAPlae2NELKWLXYf3HUQwVxZYJQa1ZatbsapPIJ
 wKyrha9PAqjw3U67W3TzpWy7EeJ6tAYwia4sA6s1omAQz4aNm5SSXTp1/UE0hCj+nTjamH6Ck5K
 RwSKBtkdBoshivvIa7x4Rh8DK7I4SxZ9cCZKqXRXec3aQu69rjP72/Fet110BVjnvdyglQJq2vF
 4XoMLkhPTUmhB5ha3M522LrBHCnaNwwLTxnviVSdcjXmbAjLNQZEFwIjox4cHdgdPv58ODy8t1C
 KWg/CyAzfzYeOyw==
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

Complete bsd-signal.h with sigwait, sigwaitinfo, sigqueue,
sigaltstack, kill, and killpg. Add FreeBSD-specific os-signal.h
with pdkill.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/bsd-signal.h        | 80 ++++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-signal.h | 20 +++++++++++
 2 files changed, 100 insertions(+)

diff --git a/bsd-user/bsd-signal.h b/bsd-user/bsd-signal.h
index 49e58d7436..09c5b30913 100644
--- a/bsd-user/bsd-signal.h
+++ b/bsd-user/bsd-signal.h
@@ -148,4 +148,84 @@ static inline abi_long do_bsd_sigreturn(CPUArchState *env, abi_long arg1)
 /* sigsetmask(2) - not defined */
 /* sigstack(2) - not defined */
 
+/* sigwait(2) */
+static inline abi_long do_bsd_sigwait(abi_ulong arg1, abi_ulong arg2,
+                                      abi_long arg3)
+{
+    abi_long ret;
+    void *p;
+    sigset_t set;
+    int sig;
+
+    p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_sigset(&set, p);
+    unlock_user(p, arg1, 0);
+    ret = get_errno(sigwait(&set, &sig));
+    if (!is_error(ret) && arg2) {
+        ret = put_user_s32(sig, arg2);
+    }
+    return ret;
+}
+
+/* sigwaitinfo(2) */
+static inline abi_long do_bsd_sigwaitinfo(abi_ulong arg1, abi_ulong arg2)
+{
+    abi_long ret;
+    void *p;
+    sigset_t set;
+    siginfo_t uinfo;
+
+    p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_sigset(&set, p);
+    unlock_user(p, arg1, 0);
+    ret = get_errno(sigwaitinfo(&set, &uinfo));
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
+/* sigqueue(2) */
+static inline abi_long do_bsd_sigqueue(abi_long arg1, abi_long arg2,
+                                       abi_ulong arg3)
+{
+    union sigval value;
+    target_sigval_t *tvalue = (target_sigval_t *)&arg3;
+    abi_ulong sival_ptr;
+
+    __get_user(sival_ptr, &tvalue->sival_ptr);
+    value.sival_ptr = (void *)(uintptr_t)sival_ptr;
+    return get_errno(sigqueue(arg1, target_to_host_signal(arg2), value));
+}
+
+/* sigaltstck(2) */
+static inline abi_long do_bsd_sigaltstack(CPUArchState *env, abi_ulong arg1,
+                                          abi_ulong arg2)
+{
+    return do_sigaltstack(arg1, arg2, get_sp_from_cpustate(env));
+}
+
+/* kill(2) */
+static inline abi_long do_bsd_kill(abi_long pid, abi_long sig)
+{
+    return get_errno(kill(pid, target_to_host_signal(sig)));
+}
+
+/* killpg(2) */
+static inline abi_long do_bsd_killpg(abi_long pg, abi_long sig)
+{
+   return get_errno(killpg(pg, target_to_host_signal(sig)));
+}
+
 #endif /* BSD_SIGNAL_H */
diff --git a/bsd-user/freebsd/os-signal.h b/bsd-user/freebsd/os-signal.h
new file mode 100644
index 0000000000..fe102c33e4
--- /dev/null
+++ b/bsd-user/freebsd/os-signal.h
@@ -0,0 +1,20 @@
+/*
+ * FreeBSD signal system call shims
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef FREEBSD_OS_SIGNAL_H
+#define FREEBSD_OS_SIGNAL_H
+
+#include <sys/procdesc.h>
+
+/* pdkill(2) */
+static inline abi_long do_freebsd_pdkill(abi_long arg1, abi_long arg2)
+{
+
+    return get_errno(pdkill(arg1, target_to_host_signal(arg2)));
+}
+
+#endif /* FREEBSD_OS_SIGNAL_H */

-- 
2.52.0


