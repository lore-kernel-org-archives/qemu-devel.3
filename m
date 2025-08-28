Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50341CA0FF9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgC9-0002pZ-4U; Thu, 28 Aug 2025 13:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVj-0007eK-Vg
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:13:52 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVg-0008Dg-5i
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:13:45 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-24884d9e54bso8536805ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383222; x=1756988022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7u4pTR+R/JyUYMnGEQ4Z/n/7ie4R7pKtlyLIJYnZ1yk=;
 b=zlrsmZRVQGFePNM9nqYiKwG8a6KUyUEyKnuBt2ws1VOOi7e3c9iMiDHo5YowcykCYJ
 geBoGiUC4jvHMwkpfGX7srBuRi7TLXXzXjJDsbuLwyPmVy9vC2aDN6GXsuIhwX+CfAB5
 DhHQkLGKTBIXOd0JZaWTQv2PBpjGZZjwN8M1JUjWhGn0lDD7RacFtPVEC4DRir4a/d+T
 GBL58+ogee3zRztpykAxRTTbS/a3hLjmPZSo87HIP2+BQCHyD6+XHI6kF5uCvLfVTwRN
 50FaTRWUN7as3BCUHFTAuu7oFUGRMk131URG9TGAIeRvrZXfrPYmb/NtefMbEDfx8Ryp
 Z66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383222; x=1756988022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7u4pTR+R/JyUYMnGEQ4Z/n/7ie4R7pKtlyLIJYnZ1yk=;
 b=nCDBkARhYTg5wjX9PlsKIanSyymKlSRX660dpf13k4ZgYqeiha4+fqiLqjUuA8eLij
 Xi1D2SjsklcYYNYmlQktBRuGG1J8KiZJyjfrda+knEdPJ22TOz4R+ibQ5CME5vlVJN0c
 7blv5xGgLIYtSnHpk/ArlvmUnZK0c3iIE6shapdapHtYQu8uVKRdx+SfLx6biVl3W8ln
 8m+1z2bSpb4w2ayJm4/suJAELhwfi6rEcpneB6vn6kqinMf8aLn9ZmsYMHL4ldwBuFD0
 BoTfgd2I1gcQVSwUAQPai/xy1El1phgxO7sCTuISxPaQ6yJ1pTGZXioYZOoshoV690mm
 /pZw==
X-Gm-Message-State: AOJu0YzDEiYJAPpyXx4BzcL6DWtdnFM2A62Ld7UF+Cg4k4w5VMM6prnU
 wtsYCY5AIHLkawSPULer/uLkxkQ+UVc3bkc4sRA5ahvznFNZOgK0CIO6RMy3Suy4hUhc3W6dfhm
 Ew4R13/I=
X-Gm-Gg: ASbGnctXd5T5i8mNIIZJLxXk8ixRVR5pX0Gf+3GwiEaH9yCpmAMETQmkiZDh3uW6WFL
 xEGSyTUMU9XGHPcYQNqmHCYJpIJWhzmR+26Pet0ijxQszRRZuDiNiDia7cZe4gHiKia6pq2KOnK
 ANEat7ZoxtWabGdcVSiEaCRqaPasg4xGrHGnXmA5YE4gtWA6eZzIwMIFMkEu7ecdp5zYDxyeW19
 JD87yes+3Ou0gppKz7bPR0Yd2/12XeXAah5nHl2dW2hKb4sVETM3z7gxFfZS/7m/3RxwGeDJot/
 p/GYPb2JKPNOOKKoOLnjVt4A428tx/kzPKq6v8n8O/m2Zqs7ok87iOKZmbR7Ybp2NyAoVPAMuxL
 89H7l+EL2z4l2OLRhjiKJEwEnB/OCB0RUqqLY
X-Google-Smtp-Source: AGHT+IGt6DsRQwSdvDDJ4pIJgYN5x1Q6I8nc7gjmXLYtRDriGlzll8SOOxdcwz/WcGRD1+b0GqNwVQ==
X-Received: by 2002:a17:902:f68f:b0:248:9b68:f516 with SMTP id
 d9443c01a7336-2489b69072dmr83004405ad.37.1756383222124; 
 Thu, 28 Aug 2025 05:13:42 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:13:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 45/87] linux-user/mips: Create target_ptrace.h
Date: Thu, 28 Aug 2025 22:07:54 +1000
Message-ID: <20250828120836.195358-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Move the target_pt_regs structure from target_syscall.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mips/target_ptrace.h    | 17 +++++++++++++++++
 linux-user/mips/target_syscall.h   | 19 -------------------
 linux-user/mips64/target_ptrace.h  | 16 ++++++++++++++++
 linux-user/mips64/target_syscall.h | 16 ----------------
 4 files changed, 33 insertions(+), 35 deletions(-)
 create mode 100644 linux-user/mips/target_ptrace.h
 create mode 100644 linux-user/mips64/target_ptrace.h

diff --git a/linux-user/mips/target_ptrace.h b/linux-user/mips/target_ptrace.h
new file mode 100644
index 0000000000..2f63b27ac4
--- /dev/null
+++ b/linux-user/mips/target_ptrace.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef MIPS_TARGET_PTRACE_H
+#define MIPS_TARGET_PTRACE_H
+
+struct target_pt_regs {
+    abi_ulong pad0[6];
+    abi_ulong regs[32];
+    abi_ulong lo;
+    abi_ulong hi;
+    abi_ulong cp0_epc;
+    abi_ulong cp0_badvaddr;
+    abi_ulong cp0_status;
+    abi_ulong cp0_cause;
+};
+
+#endif /* MIPS_TARGET_PTRACE_H */
diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index 08ead67810..dfcdf320b7 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -1,25 +1,6 @@
 #ifndef MIPS_TARGET_SYSCALL_H
 #define MIPS_TARGET_SYSCALL_H
 
-/* this struct defines the way the registers are stored on the
-   stack during a system call. */
-
-struct target_pt_regs {
-	/* Pad bytes for argument save space on the stack. */
-	abi_ulong pad0[6];
-
-	/* Saved main processor registers. */
-	abi_ulong regs[32];
-
-	/* Saved special registers. */
-	abi_ulong cp0_status;
-	abi_ulong lo;
-	abi_ulong hi;
-	abi_ulong cp0_badvaddr;
-	abi_ulong cp0_cause;
-	abi_ulong cp0_epc;
-};
-
 #define UNAME_MACHINE "mips"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
diff --git a/linux-user/mips64/target_ptrace.h b/linux-user/mips64/target_ptrace.h
new file mode 100644
index 0000000000..41f0bf6c1c
--- /dev/null
+++ b/linux-user/mips64/target_ptrace.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef MIPS64_TARGET_PTRACE_H
+#define MIPS64_TARGET_PTRACE_H
+
+struct target_pt_regs {
+    target_ulong regs[32];
+    target_ulong lo;
+    target_ulong hi;
+    target_ulong cp0_epc;
+    target_ulong cp0_badvaddr;
+    target_ulong cp0_status;
+    target_ulong cp0_cause;
+};
+
+#endif /* MIPS64_TARGET_PTRACE_H */
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 358dc2d64c..9135bf5e8b 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -1,22 +1,6 @@
 #ifndef MIPS64_TARGET_SYSCALL_H
 #define MIPS64_TARGET_SYSCALL_H
 
-/* this struct defines the way the registers are stored on the
-   stack during a system call. */
-
-struct target_pt_regs {
-        /* Saved main processor registers. */
-        target_ulong regs[32];
-
-        /* Saved special registers. */
-        target_ulong cp0_status;
-        target_ulong lo;
-        target_ulong hi;
-        target_ulong cp0_badvaddr;
-        target_ulong cp0_cause;
-        target_ulong cp0_epc;
-};
-
 #define UNAME_MACHINE "mips64"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
-- 
2.43.0


