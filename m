Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42985CD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbdk-0006zX-8K; Tue, 19 Mar 2024 11:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbdX-00067d-QK
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:44:24 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbdL-00056B-1C
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:44:16 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-34005b5927eso2061441f8f.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863045; x=1711467845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9AmlJlFpu+sjCS8Dqdfk+383y3J9XzQtcfIth5cqVHg=;
 b=wsBGyhpCm7bq6NdO5kPpoQWgxeNQSAu4E9qxGVPeq+A6TmDzlNEh8QltvW6QOYP4Ah
 zahqNvc8QiHeoQ34brlJTGbaCQktcZACK5YTEMpYqg111R85zoX1neDLw8fd+CahKdVU
 Te5TatZAonQR8MOF4xObABTLnt1F+SFF78vZfk+4kO75peM68zwdEW4Hr55pDAS8riJU
 eAm0FlXKVG0sOWSs76bWd++bsF2Sejm4coO7WdJr0hU66aor9rfQ3T/t2Kw3s0un8B5q
 kSlMyrSTghrJLJ0OHB6IIOqi6yQ9JqCPZJFfK3+2y+bZsPV6HFp6XDhO+P8h+HF6Ep81
 Y+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863045; x=1711467845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9AmlJlFpu+sjCS8Dqdfk+383y3J9XzQtcfIth5cqVHg=;
 b=rJwd35YBupRQiwYpwisghLWiGhsCahZnLX9bW0nVgc5svA4iW3asDj+KcmMbVBMrNE
 cp+SY9PIgG+/dNC9Bs8Sfxvv7NXz0m58EdrvS4+4D50oBwJWDG/cb+JNOilXaH57aPZd
 PMCTPax66RVhNrZ8G0eUAgMERt2swkEPx+AQIAdUE2/ikt+vtrOXbpaDilBHtMPz/JLV
 nb8H+1gjxYpvRk3wEHrvcCe5DtUJfbdjMDi36xGp4f7euwGluax4c+NtjNeS+LhXKwWz
 O7Cm2qTUBK6RJc+VbH2jdqcwv8p+rjE6hlH069ae1p+JerHAQPenvJPh4FDg0sEGumwy
 jsEg==
X-Gm-Message-State: AOJu0Yz1eKbQlcekLVB6TqlMpxqCUszP5OpZL+cgOlM9InG5hq6W+pjA
 MufRwTPvOXiGr/xgcQoi3MvxLU4ZWOfKkzrfD7I/a16fY64vb0VdnjAE/o835A9Rh9oW9PA1d/9
 e
X-Google-Smtp-Source: AGHT+IFy7zrEjqR1StZ5rmVbfkE2sjLNTN6EhwkxLBF+SXaCQYjQ36AVjzQVxBuwVqCGLP8/OsjVbQ==
X-Received: by 2002:a5d:4ac4:0:b0:33e:bf11:a007 with SMTP id
 y4-20020a5d4ac4000000b0033ebf11a007mr10698783wrs.31.1710863045475; 
 Tue, 19 Mar 2024 08:44:05 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 dw11-20020a0560000dcb00b0033b66c2d61esm12575894wrb.48.2024.03.19.08.44.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:44:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH-for-9.1 11/27] target/loongarch: Convert to
 TCGCPUOps::get_cpu_state()
Date: Tue, 19 Mar 2024 16:42:40 +0100
Message-ID: <20240319154258.71206-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Convert cpu_get_tb_cpu_state() to TCGCPUOps::get_cpu_state().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu.h | 14 --------------
 target/loongarch/cpu.c | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index d814ba08dd..14f1d37606 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -443,20 +443,6 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 #define HW_FLAGS_VA32       0x20
 #define HW_FLAGS_EUEN_ASXE  0x40
 
-#define TARGET_HAS_CPU_GET_TB_CPU_STATE
-
-static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
-    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
-    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
-    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
-    *flags |= is_va32(env) * HW_FLAGS_VA32;
-}
-
 #include "exec/cpu-all.h"
 
 #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index f6ffb3aadb..a2d772ca5f 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -340,6 +340,20 @@ static void loongarch_restore_state_to_opc(CPUState *cs,
 {
     set_pc(cpu_env(cs), data[0]);
 }
+
+static void loongarch_get_cpu_state(CPULoongArchState *env, vaddr *pc,
+                                    uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
+    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
+    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
+    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
+    *flags |= is_va32(env) * HW_FLAGS_VA32;
+}
+
+
 #endif /* CONFIG_TCG */
 
 static bool loongarch_cpu_has_work(CPUState *cs)
@@ -729,6 +743,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
     .initialize = loongarch_translate_init,
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
+    .get_cpu_state = loongarch_get_cpu_state,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = loongarch_cpu_tlb_fill,
-- 
2.41.0


