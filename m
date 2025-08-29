Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8227ECA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNk1-00084C-58; Sat, 30 Aug 2025 11:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bJ-0004Pv-OM
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:41 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bH-0003c3-FH
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:41 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-77238cb3cbbso566920b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506578; x=1757111378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hEu/Jd/KzuMLh+1O07NzkMG0vtLdDubGRA+9tMz/IuQ=;
 b=zAydEpOQW1gq4nOnjJfAiXX+HotuKYzS2jb1nyQOA4eyx03o+jIJFj4NO9I/3NQJxs
 hyb840dWO7HVHiAf4Bk0KMIPcH93TLtCNbXGDW7IH/sh5/5H3hoFALxdfnXNz7b45dWu
 S7tibfWPHDE3lSqj1BNwLjTb3PyUPdXDJKYLHuoaLotyqdy7rafDGHOrx3voX5X62ent
 +xnxNTry1OsC5Zl9CpC69wXJQqvfSWMFy43xWDZP6HGIO+vaK0W54YOgX0GftoDsOIoy
 /OuYeJrut+PmCsYyHIfCvR8sav5wzs3bB5UXmANijFQkg6HPL66WP5Woj20MxyO6vH8M
 v8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506578; x=1757111378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hEu/Jd/KzuMLh+1O07NzkMG0vtLdDubGRA+9tMz/IuQ=;
 b=GSP4TEXNom52tXv50r7zv1Z/LoNQcxf3A/kGTinKQAwh537KHl4OqqB8ydalPIZ4PC
 t3FoKpU8uW4AkliNk1VQDkxRfITrzB9d2ifEyq+DWaRzGWfvwqdPBXALK82o1jtSsS8F
 jSvq1Gcgfnr5EbZTLpGb0T5RTe/vdnBqOH5viN7BWVplFOquqnAGlZdryB1Eh+vV6sj2
 5rjJ7At9H5GGXCx0+THp2l4EllxM/cngygJ0AisUb4xqJ9aONODUYzmE5wujGgBntdr3
 AI0YnPXBjVKHr+G9dzFh0FWsFZ8K8wr0TP1rC1Swvo+oWZeqi4WecdmcxYbrmR0z4A1v
 2HEQ==
X-Gm-Message-State: AOJu0YxgK5Qwa0jiP8kJrPrx1Vz65tu+BAUZGD10YgIv1ZvseH9y0KtN
 tjz/aTTScejmbQOsWueRljvpNdCZaLFIQY5pqz2JLjUeqzBvxY7d4iEvfDDUPp/w+cC6MgDOzQg
 gufCjkB4=
X-Gm-Gg: ASbGncuN7B8pLAQQtJFSYccg+I5R0JR8YBoZPCTbjFbYhKc/uw7QaAjj0Bhl/yZ6X9p
 qECUCR5M2mYf+qRQN+E8FaP1kPHReygRxFlH+DqYFnR2sK1x1wt3HqlFMKF27I4gnAN/LBBBpqh
 SPvZN6CGqE2xW7Jba6sOdNFnfDlM9Rp95sQTanAmL+TZsXvTvfmoUYm7TGZyIni+vk6D0a8Ln9A
 McWHOSwFjAwxsKZHT3fpia6Meh+FjXml6u6IZNFE79lwTK+01M64eRnvm6bALbu6Tg5z9JFfS9E
 DHHELrxWIgXBRpK6fiqRfeBMGS7pJqQUhJDhGnY7OSQt+HPMVIDYtB7NKjzAco8uwQjW40UvcLP
 41Ce/mifKHBpEHBEFt5wWH3EYJeyypyCsjcRWObrvep6k/XY0Lu6U+C6XOa1/WL7k0psJoUmOAM
 2zyOwX2Bik
X-Google-Smtp-Source: AGHT+IHQ9xcNrneHa9ylxk59nTdyuFRCRmYWLC3rdyfVR4/RTPM355ZvaQudYLw7z9OvZpzXQGN0gA==
X-Received: by 2002:a05:6a00:390c:b0:76e:8cf4:7bc4 with SMTP id
 d2e1a72fcca58-7723e3c8c40mr233123b3a.26.1756506577893; 
 Fri, 29 Aug 2025 15:29:37 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 51/91] linux-user/openrisc: Create target_ptrace.h
Date: Sat, 30 Aug 2025 08:23:47 +1000
Message-ID: <20250829222427.289668-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move the target_pt_regs structure from target_syscall.h and
rename to target_user_regs_struct, obviating the comment.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/openrisc/target_ptrace.h  | 13 +++++++++++++
 linux-user/openrisc/target_syscall.h | 11 -----------
 linux-user/openrisc/signal.c         |  3 ++-
 3 files changed, 15 insertions(+), 12 deletions(-)
 create mode 100644 linux-user/openrisc/target_ptrace.h

diff --git a/linux-user/openrisc/target_ptrace.h b/linux-user/openrisc/target_ptrace.h
new file mode 100644
index 0000000000..563c648525
--- /dev/null
+++ b/linux-user/openrisc/target_ptrace.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef OPENRISC_TARGET_PTRACE_H
+#define OPENRISC_TARGET_PTRACE_H
+
+/* See arch/openrisc/include/uapi/asm/ptrace.h. */
+struct target_user_regs_struct {
+    abi_ulong gpr[32];
+    abi_ulong pc;
+    abi_ulong sr;
+};
+
+#endif /* OPENRISC_TARGET_PTRACE_H */
diff --git a/linux-user/openrisc/target_syscall.h b/linux-user/openrisc/target_syscall.h
index 7fe5b73d3b..c8394e9dcd 100644
--- a/linux-user/openrisc/target_syscall.h
+++ b/linux-user/openrisc/target_syscall.h
@@ -1,17 +1,6 @@
 #ifndef OPENRISC_TARGET_SYSCALL_H
 #define OPENRISC_TARGET_SYSCALL_H
 
-/* Note that in linux/arch/openrisc/include/uapi/asm/ptrace.h,
- * this is called user_regs_struct.  Given that this is what
- * is used within struct sigcontext we need this definition.
- * However, elfload.c wants this name.
- */
-struct target_pt_regs {
-    abi_ulong gpr[32];
-    abi_ulong pc;
-    abi_ulong sr;
-};
-
 #define UNAME_MACHINE "openrisc"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
diff --git a/linux-user/openrisc/signal.c b/linux-user/openrisc/signal.c
index cb74a9fe5e..40249095f2 100644
--- a/linux-user/openrisc/signal.c
+++ b/linux-user/openrisc/signal.c
@@ -21,9 +21,10 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "target_ptrace.h"
 
 typedef struct target_sigcontext {
-    struct target_pt_regs regs;
+    struct target_user_regs_struct regs;
     abi_ulong oldmask;
 } target_sigcontext;
 
-- 
2.43.0


