Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8546DCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgBN-0002TS-UZ; Thu, 28 Aug 2025 13:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbb6-0007KA-CE
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:19:20 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbb3-0000rv-Do
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:19:20 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-76e1fc69f86so1591296b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383556; x=1756988356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gSSqodjZuof68OvFrsej/3x/24+mS39WuwisvHqWfCs=;
 b=lF1yvDZFS+FcAwn494jh98SPI8YK4HphvvzU8ze9jquwaxqRz7HeLVVzwDl5GR/i0d
 saTk7MOeJsJWiAxgg9C6NhaV7aE4c1tcCWsmxGMk245M9DpRHUcgzGfrIqJIFG9iVRn0
 2zU/VPXzRu8u96FBO+w4obdo/jXiJmcCJrKKhVzWyd8meMZIQDp+QtrhIfmtB8ubq1lX
 VDs0+Qs8HDzIa94377mifbEVESR9CFc7xjzgV84wtsndWPD26ohqI7Mm7bkxl2P0WsfP
 4Nh5ts1WWzxxO1HRbbvdq40oARQRDPqA2wr6Ku8xtW16qQRH6pd+G5U9tRxU0O89yqXZ
 jCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383556; x=1756988356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gSSqodjZuof68OvFrsej/3x/24+mS39WuwisvHqWfCs=;
 b=W8Pe68rpLEWM1xFZ3+QTAaMaLqkmzu+CmFMdulrzCSlWG4lepAvxbCPELUdwuBRuDz
 49BdJqUqldxKEepF3TShwDoOBROUFGy2FN1zpFWsmDJPhoOPjqm2JTWw3KqPz5pEoUzZ
 CM0lICWhdhxAbzQiQ2K9J1hLYQ4ItV8xPT/HRLTTIXrPsqTBKQX5g/uTWiqCVaVKOGNr
 Y3xLSB0O/S7otdMrqglGHGs+ksn6BpQpACiprh0+fLrw8XZjoYDH1DOqZeQyxKyuiCMr
 7jntwguwcK5AO2Q/NIECseFdpW44KI5mWNSSuEZuCJ8Eyz6qDdd5mOjNQVSqwGaFq7T1
 hYpA==
X-Gm-Message-State: AOJu0YyvBwh6lkJMqsCHeWGNTbowaa4BsTZ6ovhv9Qd8f3DVYw35uo/4
 77TH0UaCMqR4r/BDcaQ13hq6F2GDQXlYLbOys1eed2HUIqtrWrs3XY9p0P0vm53J5WLMCGc1Kyp
 MIxU28rE=
X-Gm-Gg: ASbGncvyJLCVLhzRp/opmKUEp1tGgmtm6lp6xoR1bRqzzIycg2oqFLrDG1OlF0mdZVL
 dcGEaSaz2SZKZo/zFYCYVn36tPyUI8orUWoKxEa/+Y/f4ug1X+R2sfE2Kf6G5ITTMB5HEZv3KuT
 y7S1YNaqFteBPDrgNECqZogYdHp2DREzBNVGIV60awqWiODKAHcgR5rH4GW/uiOqTWpp53OZY8M
 smG/P8NOP5ULyMNK/SSxa9azV1TkH3KkJe6p2Ou9MNCqESwBnTBEzmaLE92Qa7Y7z1Jk63/Q1vP
 tZC1CMetUIjDpNK+A3zP35qU7zSzO6PjHfFCSqbV6czrgYtdwzbFCApgOk/wbqveTRRPL+x8Z5l
 qu70510MIbZnG/FOHAJrLwRn4BQ==
X-Google-Smtp-Source: AGHT+IGdu0BJwAK8OTrexjRfU20u2UDfvcGiBZAvXTVH2CRdsh5lwICR/gzCsanVUds2KAHVGHJXew==
X-Received: by 2002:a17:902:ce88:b0:242:c66f:9f62 with SMTP id
 d9443c01a7336-248753a2725mr116365855ad.26.1756383555651; 
 Thu, 28 Aug 2025 05:19:15 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248953dc1f4sm48898735ad.30.2025.08.28.05.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:19:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 86/87] linux-user/sparc: Create target_ptrace.h
Date: Thu, 28 Aug 2025 22:08:35 +1000
Message-ID: <20250828120836.195358-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
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

Move target_pt_regs to target_ptrace.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/target_ptrace.h  | 24 ++++++++++++++++++++++++
 linux-user/sparc/target_syscall.h | 19 -------------------
 linux-user/sparc/signal.c         |  2 ++
 3 files changed, 26 insertions(+), 19 deletions(-)
 create mode 100644 linux-user/sparc/target_ptrace.h

diff --git a/linux-user/sparc/target_ptrace.h b/linux-user/sparc/target_ptrace.h
new file mode 100644
index 0000000000..a4d5416c1f
--- /dev/null
+++ b/linux-user/sparc/target_ptrace.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef SPARC_TARGET_PTRACE_H
+#define SPARC_TARGET_PTRACE_H
+
+/* See arch/sparc/include/uapi/asm/ptrace.h. */
+struct target_pt_regs {
+#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+    abi_ulong u_regs[16];
+    abi_ulong tstate;
+    abi_ulong pc;
+    abi_ulong npc;
+    uint32_t y;
+    uint32_t magic;
+#else
+    abi_ulong psr;
+    abi_ulong pc;
+    abi_ulong npc;
+    abi_ulong y;
+    abi_ulong u_regs[16];
+#endif
+};
+
+#endif /* SPARC_TARGET_PTRACE_H */
diff --git a/linux-user/sparc/target_syscall.h b/linux-user/sparc/target_syscall.h
index e421165357..a90ed2983a 100644
--- a/linux-user/sparc/target_syscall.h
+++ b/linux-user/sparc/target_syscall.h
@@ -1,25 +1,6 @@
 #ifndef SPARC_TARGET_SYSCALL_H
 #define SPARC_TARGET_SYSCALL_H
 
-#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
-struct target_pt_regs {
-    abi_ulong u_regs[16];
-    abi_ulong tstate;
-    abi_ulong pc;
-    abi_ulong npc;
-    uint32_t y;
-    uint32_t magic;
-};
-#else
-struct target_pt_regs {
-    abi_ulong psr;
-    abi_ulong pc;
-    abi_ulong npc;
-    abi_ulong y;
-    abi_ulong u_regs[16];
-};
-#endif
-
 #ifdef TARGET_SPARC64
 # define UNAME_MACHINE "sparc64"
 #else
diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index 8181b8b92c..d339f89928 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -21,6 +21,8 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "target_ptrace.h"
+
 
 /* A Sparc register window */
 struct target_reg_window {
-- 
2.43.0


