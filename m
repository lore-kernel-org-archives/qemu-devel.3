Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965ABCD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbdl-0007HH-W2; Tue, 19 Mar 2024 11:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbdY-00068e-Il
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:44:26 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbdM-00058f-U2
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:44:16 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d48d75ab70so60890771fa.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863051; x=1711467851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dfAUn7JpYvclLzB4k+47U+LtLO2gvCUyK6vzKcLd+98=;
 b=JBEbn6mw/a0KI8BBAso4Oe4WjWydFjcRSGsMmIIE0Oyi7y4u2uTjo2V6o4Corg3kPe
 tTYWLKKnRrqCLAl58QNzd5qbOznF2MtPqqmbdawEOweTC4pOhLFoXF8hMrDkkn2RZoic
 qz80K6WtFcknrtFBPsaBhqc5xTKUKNBO7r2NNyzO2e07sP6dwOBStjOIsmxceOVvABXE
 ph/HJm0sVTKu7alP2AxvAnGG9nb4cOKCKiCAw5U8hUn0t872w1xiknHsCjkDQnpjipgq
 qhDW7O0YEU1NPtKUFsgjGfZPal8oROV/Q62jnveMIr/E7v5bdWNyaG3h/QYKVO0JLOYL
 aAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863051; x=1711467851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfAUn7JpYvclLzB4k+47U+LtLO2gvCUyK6vzKcLd+98=;
 b=JEQESCSQ5LNQJl0rbu8+T7dkvKRXrEPRYngaXvwjrwKTASfLQG4jbMnqMxJ5v3vPyb
 LMLSHQdbcUgt/rk0dp3YuH2k2QcQaPLcHPH+qoUAhY29yzNVjzQXZgZ/HrH1QJ+kDscb
 a5mKJvzWkNSXMfPKZwT8F2sq+Ye4UY8uOfop0lUUOga2kmdnHoi3xqtpnBkdfc2Ps+Y9
 4JlYZOp9Hu9aKB9lkWkVngzPHWVHxqygpiPbFfWdQeBSn8YU91MxMKTnKN/ramchCmEw
 8neSnP8R6scAzx1x1oPpCFwntIrKh8Y9Bi5OQqX+SIHwq4sO9YOQYfaH0mdA19bTC/xY
 fdHQ==
X-Gm-Message-State: AOJu0YwnNVt8sszvoMWwteIHXH+Fkw1652kaGuXRaCC4yhT24zdFWbjr
 mifKMvvhbUByH1X1dIoyHSHSwuv+jXDnhSE8sJ8HFjQDO42y2MliMz/6fZIdYWg6h8KtWeaD+ft
 w
X-Google-Smtp-Source: AGHT+IHEPddFNzixiX/RNPVpVxkOmbDZ/5YQd7XJjNPV34NBokux8UAeiscILHKbMYTvNbQoStyuyw==
X-Received: by 2002:a2e:8645:0:b0:2d4:51f4:dbee with SMTP id
 i5-20020a2e8645000000b002d451f4dbeemr9931008ljj.53.1710863050839; 
 Tue, 19 Mar 2024 08:44:10 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a05600c4ec600b004140726eac3sm11900174wmq.6.2024.03.19.08.44.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:44:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH-for-9.1 12/27] target/m68k: Convert to
 TCGCPUOps::get_cpu_state()
Date: Tue, 19 Mar 2024 16:42:41 +0100
Message-ID: <20240319154258.71206-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

Convert cpu_get_tb_cpu_state() to TCGCPUOps::get_cpu_state().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/cpu.h | 18 ------------------
 target/m68k/cpu.c | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 2790d61115..2f5f973bd4 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -604,24 +604,6 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 #define TB_FLAGS_TRACE          16
 #define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
 
-#define TARGET_HAS_CPU_GET_TB_CPU_STATE
-
-static inline void cpu_get_tb_cpu_state(CPUM68KState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = (env->macsr >> 4) & TB_FLAGS_MACSR;
-    if (env->sr & SR_S) {
-        *flags |= TB_FLAGS_MSR_S;
-        *flags |= (env->sfc << (TB_FLAGS_SFC_S_BIT - 2)) & TB_FLAGS_SFC_S;
-        *flags |= (env->dfc << (TB_FLAGS_DFC_S_BIT - 2)) & TB_FLAGS_DFC_S;
-    }
-    if (M68K_SR_TRACE(env->sr) == M68K_SR_TRACE_ANY_INS) {
-        *flags |= TB_FLAGS_TRACE;
-    }
-}
-
 void dump_mmu(CPUM68KState *env);
 
 #endif
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 7c8efbb42c..3bb9f58651 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -51,6 +51,22 @@ static void m68k_restore_state_to_opc(CPUState *cs,
     }
 }
 
+static void m68k_get_cpu_state(CPUM68KState *env, vaddr *pc,
+                               uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = (env->macsr >> 4) & TB_FLAGS_MACSR;
+    if (env->sr & SR_S) {
+        *flags |= TB_FLAGS_MSR_S;
+        *flags |= (env->sfc << (TB_FLAGS_SFC_S_BIT - 2)) & TB_FLAGS_SFC_S;
+        *flags |= (env->dfc << (TB_FLAGS_DFC_S_BIT - 2)) & TB_FLAGS_DFC_S;
+    }
+    if (M68K_SR_TRACE(env->sr) == M68K_SR_TRACE_ANY_INS) {
+        *flags |= TB_FLAGS_TRACE;
+    }
+}
+
 static bool m68k_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
@@ -524,6 +540,7 @@ static const struct SysemuCPUOps m68k_sysemu_ops = {
 static const TCGCPUOps m68k_tcg_ops = {
     .initialize = m68k_tcg_init,
     .restore_state_to_opc = m68k_restore_state_to_opc,
+    .get_cpu_state = m68k_get_cpu_state,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = m68k_cpu_tlb_fill,
-- 
2.41.0


