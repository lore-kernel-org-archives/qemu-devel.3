Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78337E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2kD-0001bN-I4; Tue, 10 Dec 2024 11:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2k1-0001KI-KB
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:41 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2jz-0004dY-LJ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:41 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso5148225e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733846738; x=1734451538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LT6KhyB+vUkMBosuHLU40Z3OxzVZoUi/E1K2RrfIH3E=;
 b=e6jsCV+V9lto265T1/jHwQi+Eqara2nkWKnT8P8YBAV0uqKLo+2Walb7yl7jAHES7S
 uq8+lxLeQaLskCGaLHMm+rU6Hz/4WWtNxnRV+k1KoQTq5Ng6AeXfLFueYfY5u4Xy84tq
 aroR/EVC0L+IQJuWg9baA5ldyTZfhMJ6UhulnZcFUmfa7U6GlIIRCYATzXTXodT1IseA
 9pOn9W5phHQKjjKBGwS1CfFxWM1GuitJvwT6Mj6+tH3jv9/tsfzIBjSoVSucH3qI7Vn+
 l+rOHkYXIQcZCaO5AbDvYVFdWlKCr5YZJKSjZorRZlqhPLRK6ezAE2TLGpfAWYL6r6tZ
 ofWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733846738; x=1734451538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LT6KhyB+vUkMBosuHLU40Z3OxzVZoUi/E1K2RrfIH3E=;
 b=Rk7oLba7b8HT/rDt0NiGJEfT4aPJWdTPSjupYwgoW1zbxHr0qfZQ//sfxL5qVotIqP
 4EA5dB6S6rB3osiq+XMC5/rDtHQnKFtUKO7n/G9Uia4HwRdydPSwJ42vMW7PBMR9h7S+
 ZxYU/QVfSLId+EpxtqGWtg3TRNa64fVzua7QFqV6Ma8hie6/2v92r9358XG9FXQMykyy
 ggCoVnZ9qHLk96/cqQUS1zeTF6JRtlscY5z6MQI98w6DB+cKphQTfK2LXzv+qa0LHxcR
 LNCUHe8YaPO4ApDNfiZltC+mIpZvKsHcXNlyA+1dRPf9g80rIZkbTtN404D6UZB38Jn+
 AfkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBhyAZBoIAKLZdpX3bGCVo2cMrsgMFyn3u8fkq0NhsDyoRSAfL9148XakeuIIfab+3o+c3kLMMrHaM@nongnu.org
X-Gm-Message-State: AOJu0Yx6+17ffv9m3qkJ3fLkSnfQPnMSadDS9IKup9tiuscGZjEEOWta
 H+icWVjtogX9rM32lwlucc+Byd2P/+tNx23YAaEYR4oV/CzQ4feHX2oyuCc0cWs=
X-Gm-Gg: ASbGncvMnmFzEzdetbL4MoY3hXMB2NByIfRc2c6NEtQn0HyKd3d4ElaAIYVM6cxwt73
 Ky4PWWGbzTAvuO12RrYQHbSuq6Nl7joFrV9uBD62lT3kjqmvJkrFqBKpgbb90ebfSw+P3PUSI0Y
 eRgYABJ2WnjKnmZkkFD551CPPqVeE+y+O1QGn0eUr+foZQHsweGpVl7NiPv5IvuwMHsT9/dhvri
 MUyrTKtTTQYaobV5x5sbr4HrH0uPHVPAD+OeoDzzNMTYT0oIh2AGmFlwC/3
X-Google-Smtp-Source: AGHT+IFV8LtdhtZ0VZPXUS8lab5NIBW4JLTKZlYEflNIfGZ/NLZ6/IUsxNDNcumev70VJaPKoJQ6ZQ==
X-Received: by 2002:a05:600c:5799:b0:434:a4b3:5ebe with SMTP id
 5b1f17b1804b1-434dded7708mr131954605e9.24.1733846737326; 
 Tue, 10 Dec 2024 08:05:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434e8ec8072sm124671605e9.18.2024.12.10.08.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:05:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 09/10] target/arm: Move RME TLB insns to tlb-insns.c
Date: Tue, 10 Dec 2024 16:04:51 +0000
Message-Id: <20241210160452.2427965-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210160452.2427965-1-peter.maydell@linaro.org>
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Move the FEAT_RME specific TLB insns across to tlb-insns.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c        | 38 --------------------------------
 target/arm/tcg/tlb-insns.c | 45 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index cd9f8650316..910ae62c476 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6525,14 +6525,6 @@ static const ARMCPRegInfo sme_reginfo[] = {
       .type = ARM_CP_CONST, .resetvalue = 0 },
 };
 
-static void tlbi_aa64_paall_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                  uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-
-    tlb_flush(cs);
-}
-
 static void gpccr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
@@ -6550,14 +6542,6 @@ static void gpccr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
                                      env_archcpu(env)->reset_l0gptsz);
 }
 
-static void tlbi_aa64_paallos_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                    uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-
-    tlb_flush_all_cpus_synced(cs);
-}
-
 static const ARMCPRegInfo rme_reginfo[] = {
     { .name = "GPCCR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 1, .opc2 = 6,
@@ -6569,28 +6553,6 @@ static const ARMCPRegInfo rme_reginfo[] = {
     { .name = "MFAR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 6, .crm = 0, .opc2 = 5,
       .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.mfar_el3) },
-    { .name = "TLBI_PAALL", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 7, .opc2 = 4,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_paall_write },
-    { .name = "TLBI_PAALLOS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 1, .opc2 = 4,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_paallos_write },
-    /*
-     * QEMU does not have a way to invalidate by physical address, thus
-     * invalidating a range of physical addresses is accomplished by
-     * flushing all tlb entries in the outer shareable domain,
-     * just like PAALLOS.
-     */
-    { .name = "TLBI_RPALOS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 4, .opc2 = 7,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_paallos_write },
-    { .name = "TLBI_RPAOS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 4, .opc2 = 3,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_paallos_write },
     { .name = "DC_CIPAPA", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 7, .crm = 14, .opc2 = 1,
       .access = PL3_W, .type = ARM_CP_NOP },
diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 51b4756e31e..d20d32624da 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -1181,6 +1181,48 @@ static const ARMCPRegInfo tlbios_reginfo[] = {
       .access = PL3_W, .type = ARM_CP_NO_RAW,
       .writefn = tlbi_aa64_vae3is_write },
 };
+
+static void tlbi_aa64_paall_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush(cs);
+}
+
+static void tlbi_aa64_paallos_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush_all_cpus_synced(cs);
+}
+
+static const ARMCPRegInfo tlbi_rme_reginfo[] = {
+    { .name = "TLBI_PAALL", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 7, .opc2 = 4,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_paall_write },
+    { .name = "TLBI_PAALLOS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 1, .opc2 = 4,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_paallos_write },
+    /*
+     * QEMU does not have a way to invalidate by physical address, thus
+     * invalidating a range of physical addresses is accomplished by
+     * flushing all tlb entries in the outer shareable domain,
+     * just like PAALLOS.
+     */
+    { .name = "TLBI_RPALOS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 4, .opc2 = 7,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_paallos_write },
+    { .name = "TLBI_RPAOS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 4, .opc2 = 3,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_paallos_write },
+};
+
 #endif
 
 void define_tlb_insn_regs(ARMCPU *cpu)
@@ -1219,5 +1261,8 @@ void define_tlb_insn_regs(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_tlbios, cpu)) {
         define_arm_cp_regs(cpu, tlbios_reginfo);
     }
+    if (cpu_isar_feature(aa64_rme, cpu)) {
+        define_arm_cp_regs(cpu, tlbi_rme_reginfo);
+    }
 #endif
 }
-- 
2.34.1


