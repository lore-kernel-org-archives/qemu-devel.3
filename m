Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B285CD98F0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9gs-0002uw-M9; Sun, 21 Jun 2026 00:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gr-0002u6-9I
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:49 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gp-00053L-IO
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:49 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-69de9bc590aso2663918eaf.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015706; x=1782620506;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w4XqxstNC5ZdN+bCv4aDkZLciSfFgFlRhnKV1D7FmZo=;
 b=JQEcx2mvhMDi7qjsMJ3wgY76I2janZqk5eu4TLiDjHcxmUrUrdoyVT819Z4+XmSV34
 fG0CJ7UyWcySDTGFwZ2C22LzLNBpi8InD1UfLqg4MoXBdczw9hXleX8na6I9+dmayfxF
 GqdqH25H4lrfASEDUJi6ybPhF0WiblP+DPtqLtkFe8K6kgGXHZdbe3ZvJG0FVbfEHiNU
 Uu3Y4XjukUAuBrUTnaNSua0Cycr6B0mQoaizqDMupqpgkrzbGhCsHmTjVtLZeR/BwnvH
 N2UtqIqsf/lv7kTEa1cvXgSqXxQOFRSWs4uD2Q22ogGD4XWGfDteOCFVYPHED4SijW6D
 0Gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015706; x=1782620506;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w4XqxstNC5ZdN+bCv4aDkZLciSfFgFlRhnKV1D7FmZo=;
 b=Baw9PhrxvFc/ErMfYc8DH01CFV4FSE8ksv/8oFXiYBi+68vBJy2RAVpe9SXzZrC1ZC
 xdU3fteA5rmWlcA31K4mlJ/mqgtp8y4znS4RAROC08pXH/5WGUqwLYlGV0gxtc5CSp5Q
 k2lnQA4KmnBxQQAfmWQ21EHu5MTOOEzmrd+v7KjNmB0+xM6uiIs1L/2BzpNxFMbcNCJy
 ZOLlKW4FPiyMxG4U0ElVJYDiLt5OHg0X6FEJ93FUYWRrU8ic2TuGyUUIfhoaiseERxdA
 tXyhZD8xqfnohiWtJQONmiLS9SurDoBUP3tTSjwWnxGjfXRMkEHVkqombXHBM7WIBZ1k
 RHAg==
X-Gm-Message-State: AOJu0YyacGbmZ/6R8KiAVopUaioXGrHz73Gi1lhr5C9gEgK1HDunt+sU
 I6Ec1Hlfef0SvJ8f84Q9XhsivWbor5Eg5+OtWcX5nRTMgA25QaOfX4f/c12zePh66cI=
X-Gm-Gg: AfdE7cnPVdEHkfoiqSzx7UrPOya4rq6vBOaim2BnzgkBJK2fnkoZSqvVveytw1EvS1P
 RMXaZ1NMJB2d3GgfGJ2Iv36hPgQ0Rq+Wk5aP+BXz7FARc9CDKxmrDMy+Ym5xVsrRxP8q3IfLDfM
 HH9+z5MyXh+xq7F6UYTVcQNipDBjE0BCbcwVfbsDjTQihVZ2U6eCt8FVlkjbnAr14kGZOmtr57f
 I6IcQclrwKjZe5bJyhJyAZ3dBdhhJVXaTnHsXoD1+KO998McptiX65a59Wfhg5GRUQyzuIY7B8q
 1QQoVI8PteSwOtMhsZpGeGymx7Vefle+clarYexMc5r6S+qSed2MlPvRSmk1ryP+v3rEq2ws5iM
 bnllxL5gN6EOywHLLlLQoVH9eC4hJbYnjQ65b1TrCgqjSl8qkptEiqSOtJJy0kHc41onHL0963t
 Q=
X-Received: by 2002:a05:6820:4dfb:b0:69e:4246:e6d7 with SMTP id
 006d021491bc7-6a0d905f3eamr6930016eaf.45.1782015706536; 
 Sat, 20 Jun 2026 21:21:46 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:21:45 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:19:53 -0600
Subject: [PATCH v3 06/40] bsd-user: Add signal shims sigwait through kill
 and os-signal.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-6-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3910; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=D+nsnfjUUBFDuXWRM4NmZCL+u5W9K4ynuSDjuaNXXOw=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z9M72jeOeioSXG8AtIxKpYWCT5ljDQFFFTt
 uarUmLW8sSJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfQAKCRBsHNEofbAR
 ANH4D/0W2xpgXLNj0OcnrkYFKiRgDVzMadMav5raTWhG28gc55/ujzy+ArES6dQ+fzqC9KoR9wg
 0QS0pxm7NUBQKuPZxB+GXYcP0omXLzdIhVfLFXa5xVT7t7JOIejw0yCjDDgkDHSHPG8RVsw/qwd
 CjSXvaeTZk5QU2jffMzoaUnzVo8UwgMWYwzdjhqBighKLf49zUTO7uavFnc2UA8UJogay+M864J
 RyO6Q3BcQ0kf/mStEjI1sTEv3KC52T/WPSsXqrUh+CcBAM6Z74OYlPayvtY1s3YGxpNCQYAQSDQ
 +1SqXgU13EmvZFwpnaXkPJOBJ0df5kC3764gYoo3gEBsTKhE9uRyv3dTDKvm5Uxw9DoDdvzkxg9
 ZZmyG89Zo6pLZFljAnmg/UQptFtntZdiNg+mnzPXOcfZ1KDf1kv/SF8CwGwudNXXhlYJ5RRIPmm
 LahZrz9VIjXJKOT4RJNQQtkKy+8hkN3MHIWH8WuBDGxdhacS1JzF0C413b5m+uo9viYCbsspYDY
 5F/QrX593hDh7spELqrWHZWQr1y3czQkQvYE+G6fBhv9YT7GGvSGp6TQtMD1Rlob9ad6aC+0AOT
 QCH0eN3bovcwO6kTgxTnTXUc6zkl0cggdaaqoP2A3MWN2SNvuEX8Rt7ys2bH37G25Gs8HWTlgiK
 dlxu4QPDlOuFI9A==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c30;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc30.google.com
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
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
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


