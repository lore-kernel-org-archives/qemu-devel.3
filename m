Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC790CD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbe5-00084y-JV; Tue, 19 Mar 2024 11:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbds-0007kW-UR
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:44:46 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbdj-0005H9-IM
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:44:43 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d109e82bd0so75745921fa.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863073; x=1711467873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lvebIFUNGxL/tpQGaVwXk03NyH8W0xBvPYOuRzOi+E=;
 b=JLVbFVuQvyTWpqOjNGhS1mdR4Eb7u9ILbUVxcONSzcRy7xc0qnQm4knfbPtXCXn1lX
 nIyo5ABEDCuZQFfQsMkDWSKZrKeYx66KZvrjnwGcVGb0RHP47BL2NEcE1HsYtz81NmuB
 LrIZAwjX/U9GQ9pUuj1UF/CKrpeEvlpEJ8KpaQR0R4w3q9eJNZm7PFQp7uqokzv5XnG3
 bKVUO4pn7y+IuL8zff2s0RWyrFvecoIaN3tCpPciHWtTtwQKdxFrSEsE4IBVBrW7gZBj
 nUGAtg6YaYtQW+C8d+8RW84Okdqsxf7vxtqvnaogGSidp23DZK9tq6ma4Q12TJIZmw3c
 doYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863073; x=1711467873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3lvebIFUNGxL/tpQGaVwXk03NyH8W0xBvPYOuRzOi+E=;
 b=UC9pbyBBUhExu5oLcnrUteejgYfSueyeIUAy+EnJbT+nesm1jixX6T60RBLqrWlQs8
 I79wJf19gnx8e4xUWgT9iNWVgvAQbaRQqMOHsATDVTSeDOAFVpIqpWi05RIEPdRtkGvC
 9sOe41JpjzwzSRFFS4ha/RYMUncsqbrzEC2bVynowjmLVmztIOdEtJqM/onQqEsVtcjo
 7f9QsAYKcRkOuOCAmWMwwCQ2oqM4owIRr+ARPGapRVtIRq1Hx+yh+EO+nq0owDTPG5EO
 lxNZpu98sy5Ie283EGoKzsyjfO0M5jipjQbhLOkb4fKQjKtOMwRDEg4y/OfV2Xzwcrq1
 AvMA==
X-Gm-Message-State: AOJu0YzqWv2kzx+j0ONOss5Bz5Fpwnfu0Km3a34lOzHDEaH/8VAZwhow
 V1CKF40TTdtOj3pzC4dClpsVbj131KUyImNOPC9r1UNRDjE9bH7HZWMfPWV5QaVOXyG6sW2haEu
 J
X-Google-Smtp-Source: AGHT+IEpajiD9qxxbtkv05Ua+J05mfm0t+kemyVFtmrEfAGspXNdnYq1S8DkETH+IrACmYvE4EYSow==
X-Received: by 2002:a2e:88cf:0:b0:2d4:b153:57ab with SMTP id
 a15-20020a2e88cf000000b002d4b15357abmr1777709ljk.47.1710863073392; 
 Tue, 19 Mar 2024 08:44:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a05600c354d00b00414612a43a9sm4000401wmq.28.2024.03.19.08.44.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:44:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stafford Horne <shorne@gmail.com>
Subject: [PATCH-for-9.1 16/27] target/openrisc: Convert to
 TCGCPUOps::get_cpu_state()
Date: Tue, 19 Mar 2024 16:42:45 +0100
Message-ID: <20240319154258.71206-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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
 target/openrisc/cpu.h | 12 ------------
 target/openrisc/cpu.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index d42800242f..6997c7534e 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -351,18 +351,6 @@ static inline void cpu_set_gpr(CPUOpenRISCState *env, int i, uint32_t val)
     env->shadow_gpr[0][i] = val;
 }
 
-#define TARGET_HAS_CPU_GET_TB_CPU_STATE
-
-static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = (env->dflag ? TB_FLAGS_DFLAG : 0)
-           | (cpu_get_gpr(env, 0) ? 0 : TB_FLAGS_R0_0)
-           | (env->sr & (SR_SM | SR_DME | SR_IME | SR_OVE));
-}
-
 static inline uint32_t cpu_get_sr(const CPUOpenRISCState *env)
 {
     return (env->sr
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 33c45dbf04..ce44ac0316 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -62,6 +62,16 @@ static void openrisc_restore_state_to_opc(CPUState *cs,
     }
 }
 
+static void openrisc_get_cpu_state(CPUOpenRISCState *env, vaddr *pc,
+                                   uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = (env->dflag ? TB_FLAGS_DFLAG : 0)
+             | (cpu_get_gpr(env, 0) ? 0 : TB_FLAGS_R0_0)
+             | (env->sr & (SR_SM | SR_DME | SR_IME | SR_OVE));
+}
+
 static bool openrisc_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & (CPU_INTERRUPT_HARD |
@@ -229,6 +239,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
     .initialize = openrisc_translate_init,
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
     .restore_state_to_opc = openrisc_restore_state_to_opc,
+    .get_cpu_state = openrisc_get_cpu_state,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = openrisc_cpu_tlb_fill,
-- 
2.41.0


