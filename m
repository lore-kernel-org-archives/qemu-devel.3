Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CEACA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNjw-0007R6-D9; Sat, 30 Aug 2025 11:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bF-0004OS-N6
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:37 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bD-0003au-6t
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:37 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-32326e67c95so2848679a91.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506573; x=1757111373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTZxpZcicsbz3TLYAdHyPjm1fzfLXoCF8L5rsece6PM=;
 b=omql6CQzKM7/Z672E2B4+NEsagSGxAUuSCqJvB99hFmx/Co7PGtsBNl1Wq34zbkpmf
 yUKZRdCqxqfIHQkES62t7PbS9huI1SPGMPUv3gqfwx5LST427WSG6es1hFTq48iIQrWj
 mzDcCNFrP6vI4ze9QbWDEZ6s/D7uJ6ErZQKY2ObtQc/NyWEys1b4Brfy4W8wrVGe7mut
 PS5l9S9VoqDg5r6n6KJhogsNlHNTMIVP0K0bD/jVUuD1jMZmMzfUHvDz6RKWI5zPFfpQ
 jcJeCOOxcWyg9vvUBVSUNgRi4+3VLIPNcWM1FpXn3S44DSjrq+oK92q4yjPIY9HzWRXI
 kDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506573; x=1757111373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTZxpZcicsbz3TLYAdHyPjm1fzfLXoCF8L5rsece6PM=;
 b=ly3cnVClWXwUzAKVl/Le33GQPrsgR+QBV5xL0ii0WL4FqepDDiORgG6APH67AezgzA
 gG/TPoCekGulzcogsEBdzgKT3CfdJtub6jmk8kSBvemF9TH9SvjGypz+LPSkwkBFv2ea
 PZqEfkv1WAtHIw6BHQANppF9/c4yhs2N+neibp0G9NCY8YA6BOzNIWOEhtN3RbjjRguS
 tgXby6DrfkpmQn088itK0sjo2n3DpM3iJ1lbzydKdzf2XlfR1aT7GN6BfkuheqcsWcSE
 VbKyg+OX+OAk1fTeCu7fiIezJE/kNvg+aoavm1cweX8iEcA+pJ9JpCx8AadnvPZwnNKK
 85gA==
X-Gm-Message-State: AOJu0YydzuPuG7lOJbrVBCGt0gOyvb0Cqie7ZHzDmXc5Scu29jqFxZ09
 tKbnhPIQLa9r5GWr8RHGa37bKhGUHX+Donxh7Qfyn78usunNGUhA9cLc0cUnyefj+TMFUV/WUZy
 1E9vM6EM=
X-Gm-Gg: ASbGnctc5VSaDqiN1bessxBqYJ2HJXWge0L/ERPcvQkyiCQba4lYXk3fql6/KKBg4S8
 oDf8HmVGo4XWgVvbCxsPZcD3iByM17DZEqzipizbKKNhbpXKbv00fIIc1qA91H+rJ7m9k0Q2kNF
 CuL2JMejRz5tvCmCB91R4Y6kwyS40YVz0rll4q7yxLibLugfuu+zPN2ZOZvg/DGSkoyscS3zjyH
 p13pKkFH3eMzPJR6RsSfaNoRlFiGf1qRwNNDepj0kc8oNKm4a9FdHS7p6buBQgGbr5jorDeeoDc
 dEFt7QJMjSaDPF1fZMMNswJGCbbFni4cBcNlfb81g+CWitRq2DOB2irEbF2OnNBmhOpVXUB6gZn
 2p9zUg6ddIvnNuaOz73nTFVo411345dSlgTIDwhu4rP7RPD/hq1Fg7LSzm9GNnCY=
X-Google-Smtp-Source: AGHT+IGGFdEhxje/nzZMPj23DQnHAPYbn/TkIn2QPSYaa/lkKMNtrAIIv1WCGX7vtgLvOASM4Jhy6Q==
X-Received: by 2002:a17:90a:e7cd:b0:328:d94:174 with SMTP id
 98e67ed59e1d1-32815412b69mr277545a91.5.1756506573113; 
 Fri, 29 Aug 2025 15:29:33 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 49/91] linux-user/mips: Create target_ptrace.h
Date: Sat, 30 Aug 2025 08:23:45 +1000
Message-ID: <20250829222427.289668-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
Fix the incorrect ordering of the fields.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


