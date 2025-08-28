Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8C9CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgI2-0005ud-Sm; Thu, 28 Aug 2025 13:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbW1-0007v2-B0
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:06 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVy-0008GS-JN
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:04 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-24884d9e54bso8539055ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383240; x=1756988040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ClQXVCiA2tlbMrvUzmBh/3sPifrVl1yskq0jgrdgYlo=;
 b=aff3J8xw5bBxLBwH0bQwcWCqhhsg5CKO8TrJ/I/DkCcMCYyblmO72PjBCHkzFHrHAN
 jY9hKJk6P+X4eiMdPu8rg1fLCdB8GTUSXbyxSWqFXq3OxuN1LW7QO2oErF1DpCJghnQq
 nKKyHr9f3ZYFQ+mCN4bxoBnoTzIn2DoO7mLOTtsybY9twPyDZww1eSgjHbh7pUnjpmWx
 SqoUhcGOBhpCQD2liDITlMZyoy0ZXhczxIg2/KKcSflO3CAAkjJnz8lBm2vpp1StyJ6s
 ZM2cXN4SLDUCbO0/IOIjz2g2dvHnViNKKALKRf6AC6wIxp/E+mcMnKhzGpATVYfy6cTW
 M/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383240; x=1756988040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ClQXVCiA2tlbMrvUzmBh/3sPifrVl1yskq0jgrdgYlo=;
 b=jVtO5cVFqN97FPsk9eLGbDXpCO/fipmaSPaFOBF+vFeXjscCAl5OZTB3ttreE/H6pH
 +vB2WDIhUXAbbmBG82iE0ZuRfvCFlg3Y2lRzWC6nz/qr7kQ4+FNLV8IwDwNZ5J66JTfe
 JtOb8fkA5hfhkCWVzHufVqRpyiJ/1hH4jGY45Bq9f8YxYaDYeWfQMa/adJOWvQDZnMzf
 XhaMqvHXXCiOOkolVYDefRHYg0qmcrlTvLwR5QF8hqvHumOJtXdVZ1BnWHOUCKht1ack
 GupArTW/Dz++z9D+pqBcj2ZbGyedPM3Ei4nnT1dcN8Qh3Aoo1PZiGd4VUmZD/TVLxsOR
 soOw==
X-Gm-Message-State: AOJu0Yya2BVJiyMdrGjekHooeVLMETsoVUczefCMHuqlj5Nuh1zGVrqA
 8cDB7ppL+MkbB7xZqxanLw8zOycqWbrbgH433XOzqZ+GzQEAkvY3BxiyfysOz8fFNfGr40jbWlx
 YL7hVVaY=
X-Gm-Gg: ASbGncvoiJ/COAtPp0HggurEOjRHpcu/++urXJYVbNlp/2H74Z/+DOTdEVOYhAc92XU
 J1C3GAcBy+HXywiE5imUbiaeDnGXQDV+OakvecJql3xFLOD16EWDIHoxOmTP4UMwbgkylQSjjmO
 Yt3jtnUatU6MXKVIX62eI1BVH+Av94/Yeu0vqgdA4jF3duyEZvckiwEiyJtZFQK0UWGk9Rtifpo
 M/f2rtpit5CybyWI1Ij6J9Bpf/ah0KTkBWBwaFxGgfIW5I+cCAb30h9E3am6/OQ5YG8dS7k9zY9
 pUPZWa9703AIZ2NzIzHDlep0cdPtDPbVMjpPiafrWYnLw7R8MgonSTRB3Tun86Snigd61WjDrH8
 mGcMlU9fpSmnPxg/br6BfHwtRs86P6kX0O9gL
X-Google-Smtp-Source: AGHT+IGL8JkMNXKKGbFJ+/kdvSBwHwNxbO9ue2uQdAFYnkBUPQGR0lkvo/KqEVcUJRTVRO/hJXE4Xw==
X-Received: by 2002:a17:903:41ca:b0:248:d9af:de27 with SMTP id
 d9443c01a7336-248d9afe2famr41173775ad.1.1756383239745; 
 Thu, 28 Aug 2025 05:13:59 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:13:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 51/87] linux-user/s390x: Create target_ptrace.h
Date: Thu, 28 Aug 2025 22:08:00 +1000
Message-ID: <20250828120836.195358-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Move target_psw_t to target_ptrace.h.
Remove the target_pt_regs; add target_s390x_reg to target_ptrace.h,
which matches what is actually used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/s390x/target_ptrace.h  | 18 ++++++++++++++++++
 linux-user/s390x/target_syscall.h | 22 ----------------------
 linux-user/s390x/signal.c         |  1 +
 3 files changed, 19 insertions(+), 22 deletions(-)
 create mode 100644 linux-user/s390x/target_ptrace.h

diff --git a/linux-user/s390x/target_ptrace.h b/linux-user/s390x/target_ptrace.h
new file mode 100644
index 0000000000..a5ceb75a74
--- /dev/null
+++ b/linux-user/s390x/target_ptrace.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef S390X_TARGET_PTRACE_H
+#define S390X_TARGET_PTRACE_H
+
+typedef struct {
+    abi_ulong mask;
+    abi_ulong addr;
+} target_psw_t;
+
+struct target_s390_regs {
+    target_psw_t psw;
+    abi_ulong gprs[16];
+    abi_uint acrs[16];
+    abi_ulong orig_gpr2;
+};
+
+#endif /* S390X_TARGET_PTRACE_H */
diff --git a/linux-user/s390x/target_syscall.h b/linux-user/s390x/target_syscall.h
index 4018988a25..f01f9a0baa 100644
--- a/linux-user/s390x/target_syscall.h
+++ b/linux-user/s390x/target_syscall.h
@@ -1,28 +1,6 @@
 #ifndef S390X_TARGET_SYSCALL_H
 #define S390X_TARGET_SYSCALL_H
 
-/* this typedef defines how a Program Status Word looks like */
-typedef struct {
-    abi_ulong mask;
-    abi_ulong addr;
-} __attribute__ ((aligned(8))) target_psw_t;
-
-/*
- * The pt_regs struct defines the way the registers are stored on
- * the stack during a system call.
- */
-
-#define TARGET_NUM_GPRS        16
-
-struct target_pt_regs {
-    abi_ulong args[1];
-    target_psw_t psw;
-    abi_ulong gprs[TARGET_NUM_GPRS];
-    abi_ulong orig_gpr2;
-    unsigned short ilen;
-    unsigned short trap;
-};
-
 #define UNAME_MACHINE "s390x"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
diff --git a/linux-user/s390x/signal.c b/linux-user/s390x/signal.c
index df49c24708..96d1c8d11c 100644
--- a/linux-user/s390x/signal.c
+++ b/linux-user/s390x/signal.c
@@ -22,6 +22,7 @@
 #include "signal-common.h"
 #include "linux-user/trace.h"
 #include "vdso-asmoffset.h"
+#include "target_ptrace.h"
 
 #define __NUM_GPRS 16
 #define __NUM_FPRS 16
-- 
2.43.0


