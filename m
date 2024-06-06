Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E58C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF3pT-0003lt-VI; Wed, 05 Jun 2024 23:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3p3-0003Yj-1z
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:53 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3on-0003n2-HO
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:45 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-6c7bf648207so391080a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 20:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717644576; x=1718249376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GDW7+3DHnfg1G/3wUwHLWsAi50ZhEtSDqb4dOB/GcLQ=;
 b=eplmAYXxSI1JxvlUvA9DVtgOalOAN/ZhRj4m1GDCNahBp8ZH8WQ98OtzMLS1wfPmnV
 HcSTRW6eDVSkJzH2vNaL2Dnn1nfBNoN1/eZTPnXZ1474TIgJ10FnVYxN9Q5RuNx6EBRr
 co+qMi7iuIpUY719sOD2Ubm8A4D1LMOjy//LKt8B1AeD1VXInsDPGTSZ373tUwPp+iVo
 Qx2AcZEjGpS5BBnwVLWEZ6BnlTqceZB2skFaZn1irFzhFOBsxM8uhCawYMhaWir/MVig
 MqmEu1dhmN3hJfp2q9pWLWWKAHU8Asu0tnW/IQNoZjaShUa91IMuinuD2JIkul/cMkZX
 9cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717644576; x=1718249376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GDW7+3DHnfg1G/3wUwHLWsAi50ZhEtSDqb4dOB/GcLQ=;
 b=bE49Hjmn+FKHapaMPNRwMphAvrm5HhRHnhlkpStW+5OcS/Aqb02THWIuA6DFTN4gE9
 9OE2BoFxaBTC0uku1DyvBj8aAwPZTubK/1fs/S07TARNA45xUC3irsQRUBwy/G9/QBya
 Ar2XfO7SRPJcuYJiCAXgN/y/Yc4RkYyIABrLVGMQKldUhjC7QC82OwGk3xQhWVxUW1Xe
 NPwpA1RalwI3fsmUgjycgvtCKgA+q3X9/V9dNm6fSGbNzyUOWTTF/eLz6vCKGYm/2Iv+
 kMON9S2Z6iHdxDlwaTcK4MjX4r1PPjkUdJqYKNRsT3ArqhYRPHSnRvqmldhgfPoxxt+o
 AA7Q==
X-Gm-Message-State: AOJu0YyHDH+eL4Q1K2fRj7gXMDbZFD6jWXK5e2l18j5SP5i/PeS0ZfY6
 3KEjAbvTHQPR5Petz6nKFBQVQ5xyzdpg13uMDZ+Q1rl1xFMeWnFGjOIeX2hcRXqrmIUxg2MpBI2
 D
X-Google-Smtp-Source: AGHT+IHE6gno0i3dGtcw+e/PUsM4TckQyPYVb7KW3e2qZJB63xjHyZ8Q7YqNQHRcGSEShQ3Ispan/w==
X-Received: by 2002:a17:90a:d710:b0:2c0:29d5:350b with SMTP id
 98e67ed59e1d1-2c27db62f5emr4534293a91.48.1717644576056; 
 Wed, 05 Jun 2024 20:29:36 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c254a76729sm4826265a91.0.2024.06.05.20.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 20:29:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v2 9/9] target/arm: Implement TCGCPUOps for plugin register
 reads
Date: Wed,  5 Jun 2024 20:29:26 -0700
Message-Id: <20240606032926.83599-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606032926.83599-1-richard.henderson@linaro.org>
References: <20240606032926.83599-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h   |  7 +++++--
 target/arm/cpu.c         | 38 ++++++++++++++++++++++++++++++++++++++
 target/arm/cpu64.c       | 25 +++++++++++++++++++++++++
 target/arm/tcg/cpu-v7m.c |  2 ++
 4 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index dc53d86249..fe28937515 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -358,11 +358,14 @@ void init_cpreg_list(ARMCPU *cpu);
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
 void arm_translate_init(void);
 
+#ifdef CONFIG_TCG
 void arm_restore_state_to_opc(CPUState *cs,
                               const TranslationBlock *tb,
                               const uint64_t *data);
-
-#ifdef CONFIG_TCG
+bool arm_plugin_need_unwind_for_reg(CPUState *cs, int reg);
+int arm_plugin_unwind_read_reg(CPUState *cs, GByteArray *buf, int reg,
+                               const TranslationBlock *tb,
+                               const uint64_t *data);
 void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
 bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 #endif /* CONFIG_TCG */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3cd4711064..e8ac3da351 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -29,6 +29,7 @@
 #include "cpu.h"
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
+#include "gdbstub/helpers.h"
 #endif /* CONFIG_TCG */
 #include "internals.h"
 #include "cpu-features.h"
@@ -120,6 +121,41 @@ void arm_restore_state_to_opc(CPUState *cs,
         env->exception.syndrome = data[2] << ARM_INSN_START_WORD2_SHIFT;
     }
 }
+
+bool arm_plugin_need_unwind_for_reg(CPUState *cs, int reg)
+{
+    return reg == 15 || reg == 25; /* pc (r15) or cpsr */
+}
+
+int arm_plugin_unwind_read_reg(CPUState *cs, GByteArray *buf, int reg,
+                               const TranslationBlock *tb,
+                               const uint64_t *data)
+{
+    CPUARMState *env = cpu_env(cs);
+    uint32_t val, condexec;
+
+    switch (reg) {
+    case 15: /* PC */
+        val = data[0];
+        if (tb_cflags(tb) & CF_PCREL) {
+            val |= env->regs[15] & TARGET_PAGE_MASK;
+        }
+        break;
+    case 25: /* CPSR, or XPSR for M-profile */
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            val = xpsr_read(env);
+        } else {
+            val = cpsr_read(env);
+        }
+        condexec = data[1] & 0xff;
+        val = (val & ~(3 << 25)) | ((condexec & 3) << 25);
+        val = (val & ~(0xfc << 8)) | ((condexec & 0xfc) << 8);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return gdb_get_reg32(buf, val);
+}
 #endif /* CONFIG_TCG */
 
 /*
@@ -2657,6 +2693,8 @@ static const TCGCPUOps arm_tcg_ops = {
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
+    .plugin_need_unwind_for_reg = arm_plugin_need_unwind_for_reg,
+    .plugin_unwind_read_reg = arm_plugin_unwind_read_reg,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 7ba80099af..1595be5d8f 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -33,6 +33,8 @@
 #include "hw/qdev-properties.h"
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
+#include "exec/translation-block.h"
+#include "gdbstub/helpers.h"
 #endif
 #include "internals.h"
 #include "cpu-features.h"
@@ -797,11 +799,34 @@ static const gchar *aarch64_gdb_arch_name(CPUState *cs)
 }
 
 #ifdef CONFIG_TCG
+static bool aarch64_plugin_need_unwind_for_reg(CPUState *cs, int reg)
+{
+    return reg == 32; /* pc */
+}
+
+static int aarch64_plugin_unwind_read_reg(CPUState *cs, GByteArray *buf,
+                                          int reg, const TranslationBlock *tb,
+                                          const uint64_t *data)
+{
+    CPUARMState *env = cpu_env(cs);
+    uint64_t val;
+
+    assert(reg == 32);
+
+    val = data[0];
+    if (tb_cflags(tb) & CF_PCREL) {
+        val |= env->pc & TARGET_PAGE_MASK;
+    }
+    return gdb_get_reg64(buf, val);
+}
+
 static const TCGCPUOps aarch64_tcg_ops = {
     .initialize = arm_translate_init,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
+    .plugin_need_unwind_for_reg = aarch64_plugin_need_unwind_for_reg,
+    .plugin_unwind_read_reg = aarch64_plugin_unwind_read_reg,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index c059c681e9..47e44f70c7 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -237,6 +237,8 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
+    .plugin_need_unwind_for_reg = arm_plugin_need_unwind_for_reg,
+    .plugin_unwind_read_reg = arm_plugin_unwind_read_reg,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
-- 
2.34.1


