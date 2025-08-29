Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEE6CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNj1-0005Mm-2t; Sat, 30 Aug 2025 11:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xq-0003LG-Rs
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:26:07 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xn-000359-Mi
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:26:06 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-771ed4a8124so2660168b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506360; x=1757111160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ReZ7WgJ9Kfc6uVECmtmJ6F8sDeee2buwnq/LwK97Qc=;
 b=ordxxAWeYEx5PdrymvJdg2EkYUIPVfurZ9X0QKnmWpvfMs7FCKi1UENLzxLvM26uBx
 nT6HuXiSYyZakMCq495FjBolD499h6SdWdN58y607YxNHkSUELl4UtSpvPkrDU2q9hpy
 dhUM+kBXkvV+Fv4HaLJxyV7iLargb5CxyVhuwd+Xc4+JI4Oi0figGLmffCJeJbhzVXXO
 SYHIQKoKYURHxxLHTZPSXkaEMVOO10ajDxmTlYAs/5PtnfVnXwIZmwh0sqk7ZgzxAPhR
 XidLOKXME/L/tFoq5kIE9tyeXTs5hbtPo0hXK0BBNlmTOVRK477PDwrJByFEl8c5Xgtt
 czHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506360; x=1757111160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ReZ7WgJ9Kfc6uVECmtmJ6F8sDeee2buwnq/LwK97Qc=;
 b=oXaTXA/Sjh5O/Dx8u7bLz3x70TrL6Ls8ZcTNwtWqa6HWIuWFodS1CR/id4e48kygZR
 KFZHEiMiATvkWm9z0Kr6bfi7sb6isf4UGYan10Olw5YJmXx+McJLriF5so1OoIuEWIYc
 D0cu+IZ1UosUdL2m+IVf+ra9q+t2bBlSJ38qHGp0E8CkeJM6C7Vy8Oe36XdBVyuOUKX2
 0MTetiHEJdId1OBo0/RvzQLhP5dIoj9Jjt0Ornj4fa4F6mwzPQ5W83XvYkbEIaDTvdbw
 8WT2ZZEZoefvRGwHDqPZhobKBW8Hxsv15TO/f7WZR/urUrBs5ClBWzGHgsq+/W0A+EVm
 w/Og==
X-Gm-Message-State: AOJu0Yxy4ANWy8LQcdQR1fxKoUkxC9BjdWjVxo91S0wgeYt3n6niukN6
 o94uQD13WmAap+iNFMcCwE8qTFFlKaHq4Pfk9m9Pqg4DPY0WBp4LjUx6788ryLTS+yzWhF+X9JE
 mhkz+95M=
X-Gm-Gg: ASbGncufDH7Gh4jTaEM+EPZFy7pX5wh4PokAhxCPRZM5tZ+rS06yXP4O6CJ9l/E5m8o
 NHZCqpLN6Ez6Bt9EsLXqWHs68Os8BEf2PRXOZlA/os86DOSYQvx3CbAgvg+ZbOkXZWXNhZjgzHg
 lHULh5OV8ZJiCH2aauntt/xNcvyzUPxOGxRrAISYaeQpYuK515vvHVVRXH1rnUaePjGD2pi/y59
 75JGJiXTXarKZQf71hJqXkUDQmU2KBIIMhVezLqP17NUhVcryKG3vj4RbI8ETQqBHsQOoriJZxM
 bwJ/XX3b32g0BfW1+SSX9CNiDM963mRnqVx98cCgQhP+vOGb/u2DgQLNPeKyEYcVCwmvlUBgEnC
 /StTWkDJ+3TpP6M9QOI4LzUaKNEBpCc08BZJDo3vPmm2dz2mJ0TFnq55mIrkK
X-Google-Smtp-Source: AGHT+IHjpedYRsSb6Oexc0gaRzDKnAcxoo94fd8+OQw2+hVVoswl4cTG1v7VRyVhW0PaCvXNM7Dtbw==
X-Received: by 2002:a05:6a00:2e1f:b0:76e:7ae5:ec90 with SMTP id
 d2e1a72fcca58-7723e3b28cemr206091b3a.26.1756506359762; 
 Fri, 29 Aug 2025 15:25:59 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 36/91] linux-user/x86_64: Create target_ptrace.h
Date: Sat, 30 Aug 2025 08:23:32 +1000
Message-ID: <20250829222427.289668-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Remove the target_pt_regs structure from target_syscall.h.
Add target_user_regs_struct to target_ptrace.h, which matches
what is actually used on x86_64.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/x86_64/target_ptrace.h  | 40 ++++++++++++++++++++++++++++++
 linux-user/x86_64/target_syscall.h | 28 ---------------------
 2 files changed, 40 insertions(+), 28 deletions(-)
 create mode 100644 linux-user/x86_64/target_ptrace.h

diff --git a/linux-user/x86_64/target_ptrace.h b/linux-user/x86_64/target_ptrace.h
new file mode 100644
index 0000000000..33527127cb
--- /dev/null
+++ b/linux-user/x86_64/target_ptrace.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef X86_64_TARGET_PTRACE_H
+#define X86_64_TARGET_PTRACE_H
+
+/*
+ * The struct pt_regs in arch/x86/include/uapi/asm/ptrace.h has missing
+ * register values and is not used.  See arch/x86/include/asm/user_64.h.
+ */
+struct target_user_regs_struct {
+    abi_ulong r15;
+    abi_ulong r14;
+    abi_ulong r13;
+    abi_ulong r12;
+    abi_ulong bp;
+    abi_ulong bx;
+    abi_ulong r11;
+    abi_ulong r10;
+    abi_ulong r9;
+    abi_ulong r8;
+    abi_ulong ax;
+    abi_ulong cx;
+    abi_ulong dx;
+    abi_ulong si;
+    abi_ulong di;
+    abi_ulong orig_ax;
+    abi_ulong ip;
+    abi_ulong cs;
+    abi_ulong flags;
+    abi_ulong sp;
+    abi_ulong ss;
+    abi_ulong fs_base;
+    abi_ulong gs_base;
+    abi_ulong ds;
+    abi_ulong es;
+    abi_ulong fs;
+    abi_ulong gs;
+};
+
+#endif /* X86_64_TARGET_PTRACE_H */
diff --git a/linux-user/x86_64/target_syscall.h b/linux-user/x86_64/target_syscall.h
index fb558345d3..68f55f8e7b 100644
--- a/linux-user/x86_64/target_syscall.h
+++ b/linux-user/x86_64/target_syscall.h
@@ -4,34 +4,6 @@
 #define __USER_CS	(0x33)
 #define __USER_DS	(0x2B)
 
-struct target_pt_regs {
-	abi_ulong r15;
-	abi_ulong r14;
-	abi_ulong r13;
-	abi_ulong r12;
-	abi_ulong rbp;
-	abi_ulong rbx;
-/* arguments: non interrupts/non tracing syscalls only save up to here */
-	abi_ulong r11;
-	abi_ulong r10;
-	abi_ulong r9;
-	abi_ulong r8;
-	abi_ulong rax;
-	abi_ulong rcx;
-	abi_ulong rdx;
-	abi_ulong rsi;
-	abi_ulong rdi;
-	abi_ulong orig_rax;
-/* end of arguments */
-/* cpu exception frame or undefined */
-	abi_ulong rip;
-	abi_ulong cs;
-	abi_ulong eflags;
-	abi_ulong rsp;
-	abi_ulong ss;
-/* top of stack page */
-};
-
 /* Maximum number of LDT entries supported. */
 #define TARGET_LDT_ENTRIES	8192
 /* The size of each LDT entry. */
-- 
2.43.0


