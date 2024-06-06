Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB15C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF3p5-0003cm-N9; Wed, 05 Jun 2024 23:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3ot-0003Xc-TN
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:45 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3om-0003mu-ON
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:43 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2c1a9b151bcso383491a91.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 20:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717644575; x=1718249375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qk6fRoAsjXUiIOMAFv1hh9xLZybNH+lhJEtz8n7pvqs=;
 b=A4LWK6yH7bahc2CZ08pB3hgxh1uarBNM099PLRTwIIyAFcmRjrsDxtOswqu8SLIwPf
 Zft0hSq2Rijiy4gZrlZTYJbN0dptLGzlAP+jEHT4bfIYWEXVsA2BTIn+TD0xTQn4MMZ7
 FQVax3M3q1BixxiCvR12lk2Gx6mmqXhhKvzC/Ort7leyGsXd+EJyZWgCgA5Qmjqkgk0a
 WLKfjjQRLKKpGFk1nMnexA8HdyDYDm9H1gBGFdiPC0c1mKkDYVf+8TPJVg43Z13n0C3+
 gMxJmtjUkzJ0NoIBfMca7Usqbd1CQgEUPLlTaLjRMTZEpOnCDDqMoX8UCycNiKSOpAVB
 e91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717644575; x=1718249375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qk6fRoAsjXUiIOMAFv1hh9xLZybNH+lhJEtz8n7pvqs=;
 b=I2bOgLzOsM/o5dSpjqSQCTxoTvy1coWejdWiqol8/Q2giapugb7fVFY0obs2omTNqs
 E0Guasan7emCaVxhSgJ1WCTQ0sufZ8waH53uq0psu4+BZuB7Ia3JqYaegGuj8z4yFtIi
 YloZixJKIG45oudywAFtVDb/nkwpJB1aHixTB9bakjOo8Wj2usqcAegXT/s7jaSUi7IW
 WFGJPN1HmwzIeDdazj6Q4mq58SMvx0Wcl5FdIjFd1rQ0UyFs5d4rcY17F4rY9Z0g1tNF
 EPZesbFqPSMdY++yPZ+sVBKKN/7ft1ApzeMIh6yiholnMEUzDxHEKSh3IA3qFaduFiUj
 diGQ==
X-Gm-Message-State: AOJu0YxPpoPNZAZcK8dyIm/azN36ak9jRrdgkEizpIAd4eGe37rz0v5O
 13zSCUUp796tBsYsw1GQmaBpc9ZESxocSh8EDwrmhi46Qr3rdmhfEMzMGGgMmc61MZ4PF8LDBBe
 P
X-Google-Smtp-Source: AGHT+IFayyZxhoM06SdJj+iarV6bhY6fgorrfGcBNa2Ebl5U013LEaIkXAEM3xGk7Y1kNWqICAUNZg==
X-Received: by 2002:a17:90b:188f:b0:2c1:c648:14d2 with SMTP id
 98e67ed59e1d1-2c27db003cdmr4514459a91.1.1717644575042; 
 Wed, 05 Jun 2024 20:29:35 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c254a76729sm4826265a91.0.2024.06.05.20.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 20:29:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v2 8/9] target/arm: Add aarch64_tcg_ops
Date: Wed,  5 Jun 2024 20:29:25 -0700
Message-Id: <20240606032926.83599-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606032926.83599-1-richard.henderson@linaro.org>
References: <20240606032926.83599-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

For the moment, this is an exact copy of arm_tcg_ops.
Export arm_cpu_exec_interrupt for the cross-file reference.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  1 +
 target/arm/cpu.c       |  2 +-
 target/arm/cpu64.c     | 30 ++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 11b5da2562..dc53d86249 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -364,6 +364,7 @@ void arm_restore_state_to_opc(CPUState *cs,
 
 #ifdef CONFIG_TCG
 void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
+bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 #endif /* CONFIG_TCG */
 
 typedef enum ARMFPRounding {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 35fa281f1b..3cd4711064 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -824,7 +824,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
     return unmasked || pstate_unmasked;
 }
 
-static bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     CPUClass *cc = CPU_GET_CLASS(cs);
     CPUARMState *env = cpu_env(cs);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 262a1d6c0b..7ba80099af 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -31,6 +31,9 @@
 #include "hvf_arm.h"
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
+#ifdef CONFIG_TCG
+#include "hw/core/tcg-cpu-ops.h"
+#endif
 #include "internals.h"
 #include "cpu-features.h"
 #include "cpregs.h"
@@ -793,6 +796,29 @@ static const gchar *aarch64_gdb_arch_name(CPUState *cs)
     return "aarch64";
 }
 
+#ifdef CONFIG_TCG
+static const TCGCPUOps aarch64_tcg_ops = {
+    .initialize = arm_translate_init,
+    .synchronize_from_tb = arm_cpu_synchronize_from_tb,
+    .debug_excp_handler = arm_debug_excp_handler,
+    .restore_state_to_opc = arm_restore_state_to_opc,
+
+#ifdef CONFIG_USER_ONLY
+    .record_sigsegv = arm_cpu_record_sigsegv,
+    .record_sigbus = arm_cpu_record_sigbus,
+#else
+    .tlb_fill = arm_cpu_tlb_fill,
+    .cpu_exec_interrupt = arm_cpu_exec_interrupt,
+    .do_interrupt = arm_cpu_do_interrupt,
+    .do_transaction_failed = arm_cpu_do_transaction_failed,
+    .do_unaligned_access = arm_cpu_do_unaligned_access,
+    .adjust_watchpoint_address = arm_adjust_watchpoint_address,
+    .debug_check_watchpoint = arm_debug_check_watchpoint,
+    .debug_check_breakpoint = arm_debug_check_breakpoint,
+#endif /* !CONFIG_USER_ONLY */
+};
+#endif /* CONFIG_TCG */
+
 static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
 {
     CPUClass *cc = CPU_CLASS(oc);
@@ -802,6 +828,10 @@ static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_core_xml_file = "aarch64-core.xml";
     cc->gdb_arch_name = aarch64_gdb_arch_name;
 
+#ifdef CONFIG_TCG
+    cc->tcg_ops = &aarch64_tcg_ops;
+#endif
+
     object_class_property_add_bool(oc, "aarch64", aarch64_cpu_get_aarch64,
                                    aarch64_cpu_set_aarch64);
     object_class_property_set_description(oc, "aarch64",
-- 
2.34.1


