Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2CECD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzx1-00018K-Sw; Fri, 15 May 2026 17:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzx0-00017r-Ou
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:06 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzwy-0002pV-Sx
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:06 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4670464029eso238271b6e.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880004; x=1779484804;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UcX93/bsPzSGtEWzCQDxEM4bepZUbVT03Usa9qIq4yg=;
 b=AErxRRDXA+Zne3Xla+ex19JEWkx3XwANLMcNKT6aLdWeyqLVfbwgGZCoqwMh1HRM+T
 urAHc5l0ybS2P5GlXA7AAB+1nZHs2ssWr1If5hbKrJnXseNZF26HQwhPfL0XZA433QBp
 HC5QUVZlAJHgkO5hlcQnqLCFu8yUnolKo1P8QSRTTl9kLTCs7cuu+HqWLtZrUXdXb2Da
 pTosWTagOm5/0LELq9AF6M7hCLxBTksBwOAWXWlju8AQYF1Mo7CahAQlrp6/cmR+RFsj
 BlYW3z/TNtb8qW6ZFJFhRTZhzzvGdRsiVNzvIQ4jAVCEaRVe3jlBtHcV4AjtITtXfcKw
 8Sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880004; x=1779484804;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UcX93/bsPzSGtEWzCQDxEM4bepZUbVT03Usa9qIq4yg=;
 b=shVpS9hyX+sHyYxbGNltSWva5DAxE0lyCUuSsYqup+gqLhYQN3K9A4Lmd2Pm7EUEaf
 I4ayHQ/DloqVVrbMUp0CPiV5AEGFBGtSvKYK/+0Bpeluc/XLd/CiQHt4Fdyyq4f845wq
 4ze0nikuzjWWYVKc3nvaj+WSV4GVl4xSG40n39oCrTFkqc5n1BwRI0+0N8x0KnNBEqXt
 3Mr1Hr9lS0zQ9wX+TaYUyCq/aQsRAyGTxr1YynoO4I7p6EFz+5i6snqpI2eX/T7qjYST
 V4vJkykucicNsv9t4kl1T2MCE5z0ErhrQT1gz1Peb81l5CQC63qwBOEuGjjQt06EaPMX
 Q56Q==
X-Gm-Message-State: AOJu0YweTTE+EYNsHNfmuAHXciPVc7HXOycp6CdlUQNgb1pblroq+wm3
 SAdaCa3n7EPSNjmpmU0q+Lu02wCxK1oD1Y3LyMnE2SKqbXtINLhpnFDS87kuwTOdx/c=
X-Gm-Gg: Acq92OEl9zXRzwR8h3j6Pz9c31w0G8EMal3h5uLm7tKu8dTki4qP1Iy8rv6U4h+zdgN
 ykvBHQQX1wFUifxg7A7asWsOWGndCMVv74Y3uZyNF8zRuHEqk3EPQzY+5V0FhfJlkgwdlVM8ql0
 FmPMWXHT/jR3KHYSV0Weo+QrnZcUoxmrOUgCqzOQLHWty/tCMlIB8p8h0I9N1nVC0LCh4CD/crq
 JNFl+2zIOmtY30EoZ1JRjczDWeYDUPmzBYwNXDZC0A7g987d0mQbHK/kWpGT8t4kyLnK9wwIB/v
 6kDisAITYRgOIAcnlB+vv8qmRPxTdywcjbwj1eR03wjNSNHcTNLXhog4RSu8EAb0nm4jsa7KDZe
 gUGBOvwjX6aR66OdlsKoMUzHOF88yYXVhpHI2UW+/yUul9eJeOmPWBL06n/1dDRw5ePArDbWtD3
 2kbFZonZ3csP42WB2qV8Dy
X-Received: by 2002:a05:6808:c2c2:b0:467:1e5:6768 with SMTP id
 5614622812f47-482e57c2044mr3876315b6e.43.1778880003673; 
 Fri, 15 May 2026 14:20:03 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:03 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:03 -0600
Subject: [PATCH 04/66] bsd-user: Add signal shims sigwait through kill and
 os-signal.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-4-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3843; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=N1BQ+ZOiFjKjIFi+9oZiikyUY80Tcc3sfec9pgHMLJc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43hchPrzXfGveNPfRiq97I4fx2o8GPHh60hi
 jUJwNUTUH+JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4QAKCRBsHNEofbAR
 AAL3D/wNP+2TzFOjFl3/aFrBaiZcV1pGnZd487Ybxs+hzGoapcEGONbHqiXpx0LK8TWW9Nh7nSR
 /956AdD0u4W0LRiFm6+4DMFLvMVOBS9WEuq/ehw2CK4EfqlzRaTTP6X2Cw630whXr9iak48GBF+
 cAolF+0znbBkzz6ibgP+ulkGFJkDc+YiXSgm84qJBIc8dyDelsF7Uxfk3VR/7dI/u8UBp4+rSKA
 zsHevYSW7Xal78GNek4s2vom9h+kQeE0Rf55vyR0FODqHaqNpfWWgHAgmkCn3cN5v6EDla+F0sj
 ICKsGHdgELKtRrGxCNulcwioO9NBWv9/jm4STKWVg9B19umH3LeKU1gVhR+MIEK1AqblpOIEuha
 WvC5vKJjEAyooZJgpb/3r28oh+HSpYFvkGYkcZAYs7gJZJZViEHjPUQ6SscpO7Yia6xbCtbd9LS
 P8En4U9MillZjndq7lSBmxZjeIG9TnpodvFvgeyJcS+gZpXBxGAjJ0duZS0ECznAyXxwdNatNb1
 9lN+iJG2VzgRU/NquyBikts7BTPTwbG66j1RjU2Z1ASZ3q73yc76KKjwDEJ/jjege8i10e66BGD
 gCgHVKfcmcAna5meQn7r7bMEbKc00XhSNI2KPw4fWnpbleehJZ1TNmUBrFoQt3dE4mouPrcmAEE
 fbdcutsUnVxsl8A==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::230;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x230.google.com
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


