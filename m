Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38BCC982D6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QA2-0005KY-4d; Fri, 18 Sep 2026 00:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA0-0005JQ-4v
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:16 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7Q9y-00049X-H9
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:15 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 46e09a7af769-804f7045f3eso85148a34.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705513; x=1790310313;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hw3PVYWVyfOZlqFEjNse5+bK9WSckDL6geC7202YNEI=;
 b=IGUZV5QMGAbOfxT6z1trQDZXAMYUmxn5DG/s8t64Yln90OZ5V9101kFW0T/E2oK//n
 8e3Mus5NLcuAmK089MaI7mEeUG2GICjnfYmUEsYnV+m62ysBIvezwN0XRE9zPjY62LOV
 jsx9Lme1bwVzq3OileZFmKjFsXRsAB97QBD1hrkGCxTY8sdUyDUhEWTdn4bgzJvyrIpL
 YPTJzN0MPG1fyTUzxQfx687uydU/Z2xAhE6tfkaqwlFdTdVSGnpmJ5m6d2sDAGFGiTX5
 MCyaFUqhSlL04ioKawNqJBqiVZ1TgwLQZowWexil8WbRgGg01HCyO6LwlZCtNrtewuBm
 BAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705513; x=1790310313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hw3PVYWVyfOZlqFEjNse5+bK9WSckDL6geC7202YNEI=;
 b=gxpAWHiUcv274V7SF2ezIixwY0OV4k+ctwcnFxQjVt10PfTNzJOs+6IXoLgqKmc2DH
 nu3IDJw8lkB1ORnbTQhZjDQxT39k7Nw2SVKR4os1eHg6Zf8G2J38snmsQOtQ/K6DxIx4
 IspoCGhCeQeneQcxc87i+fAqDP8gPfvXnKZBIG5houwv33eMuUUV9PLM2DVE75EYK7hM
 FG+zfe6jzzrmvPGIzZcH38OzUvuqRcQbDAeaaBLVjtPZ9gysurmOvsl5v5A4SxE7ZjxS
 iXkmHHU+KqitfLtSifZRbFlEtXJx6qdOBAiDweai9TDeOJ2/Vvd1M/hGvOwkZMXx9NfU
 Hgzg==
X-Gm-Message-State: AFuF++lUnZRKbyydSOnr88iEd+TxQkIRA3+n6/VXTXa0MN3hY05Wo0v9
 fDBEeaqZKtF7Uc1G+R8W/oknbSInOVP6+7ngXDqZctPr5ZIEHGyXvcEdtQwzKhz9B44SfCmEAFA
 zDb0D5R4=
X-Gm-Gg: AYBFou27364ftjmNKDWe1WCQ45QJH8a9Uo/Dc61OVfYtw6XyHdgbvqXk+Tbf0WuAc78
 9hF3ydrrpi8yYvkzaenGzMdoeNBxAJK7qCd7HeVatz2PuC2wqzXVdHOYAuTr0YtsqkLzXSyBPN/
 DaxQtk5GVIVyDjymGw6Pg8vu4ZPagvfiqt48om6cAVDCuC7Lb4twgyNy4dRO0HaQ4c4+vyKz9sR
 KsfjXkOxQTgjgdUmZixMnqbwqjuzq0qVkSzj9zy4yAdqtpJk0sqg2jwMvkDZirTm9T5XlZCR1GM
 dMWxHRI1luzarEvz7rSBexB5WcW9IeoxnA4cXztWPrQLgZVasWPz7K1+ff3Arx51i5WDKapux7q
 A+UDnlsFnrtXu230zhX2JMteMwpH1Whe9hFdEqa1MestHapko6OOP8qpzol9p8ng+xnmbHSK47B
 z75YvgSW5MoWLxfbjziizPnn+LsD+AiTObydsoM2EbOO/e8XQ87bcqUFPUTA==
X-Received: by 2002:a05:6830:4393:b0:7e6:d54e:8fe3 with SMTP id
 46e09a7af769-80de1060d28mr1454746a34.9.1789705513059; 
 Thu, 17 Sep 2026 21:25:13 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:12 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/41] bsd-user: Add signal shims sigwait through kill and
 os-signal.h
Date: Thu, 17 Sep 2026 22:23:46 -0600
Message-ID: <20260918042422.38713-6-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::11;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x11.google.com
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

Complete bsd-signal.h with sigwait, sigwaitinfo, sigqueue,
sigaltstack, kill, and killpg. Add FreeBSD-specific os-signal.h
with pdkill.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-signal.h        | 80 ++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-signal.h | 20 +++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 bsd-user/freebsd/os-signal.h

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
2.55.0


