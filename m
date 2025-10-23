Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989BBCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwjg-0004t9-Tn; Thu, 23 Oct 2025 10:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjf-0004q0-Ce
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjd-0005ad-GM
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47117e75258so7222265e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761231372; x=1761836172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F0pSAJ7AP3EIbBDaOPx9w3eo4OwQ/YGmc/QOEJCgnxg=;
 b=iQEdOkc9qPFbKvtYW/DlCUrib7s3HNyCyTd2fsESerjtPIuneI0IwXwonqgiW/pVcf
 L5AYjSQ+YSn4u5ueqy+F8yP5gE2IpFbls7jmmVjyQ+qH08gSHFrpRH0Mf2JXjnbUReTJ
 Ho98DXRkyPGUJOdwaqGZqO7xYNpzJCkEdr+Mb9AqGhqfUEYDpxbrv1CinnNYzR8rRonH
 sPdRhdFi/Y8oRABNdLQ1Eg3xTEcn0eutlMlf8za3ceeoS8HIqHl462QK3jCBj0eGyXM1
 m12jujCZEshdSJ/gyAqOHJH0lBejHBmmcOoA1iJy2Lluo9GVK+Z6AtjQCNjN4IGQP37N
 UfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761231372; x=1761836172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F0pSAJ7AP3EIbBDaOPx9w3eo4OwQ/YGmc/QOEJCgnxg=;
 b=j8N29QHHaclJiJjzU8MCSMyX8i9/q5cbXdbEiNYzXd52vNpQYRtqPQfSJ4OBQNPX2h
 6NnVGswGQBAo8KeTLGKFnOGTdNaDZCHad87+yjbakmG5I03ALcz9AGWXNZXeKjvgqGdS
 cPEtR9GiIJ2vN89tjtdEP0wpWDgl9Xqqq5bduC5yqyafUBDZQMQKIU1bPotDxHORDZwG
 yxQGdk463WZX1PMEtk0IDVYn8c9PL59/tR039YHSt9/vl9f4yUZcqV2QmDRQp2AuFK9G
 H9xPhQyr9yYgVQ1VAUn2UsjaA1/1i3/H+UAoXYalDnsvaelSfWZ1fvlLQicC3AgrQ3OG
 i+Zg==
X-Gm-Message-State: AOJu0Yxat3mjrPc5ou1C44egWCLejH0MzmBMcSpP4vA+LEpGR7QMnPow
 SlaCqiNyBCy7xexDcFDvDn+wSnec8BHx3wvdZA6a9N+amBT56TooUCTM1bNm9XExTnwK+n6inwQ
 SrXsm
X-Gm-Gg: ASbGncsK/0lCAWlfaD1Yj0PDXk7edBQeliOB9TQPXAaDf1mh6GWA0uFqyfIG3fgj1dB
 LXLeRybRbSKcLo/daWSvU7SMVwJMERHIMBite4WhspwDBxydPr1zplj4BtWKsNY7ImVhsUDE4oo
 fRbe2udwbBpicu58OAEUUIhot8p/DxgfcwJJc9OQEflzyEmlTH+GSt1dVbOxiAWt27O+ZaVM0hE
 yz6CCO0VwH311N0jdcUPIhb2XrGCT7ug1lBgzLgBayBV6vD8fCbVqVlqLNurFFQ0QcQITysd4vY
 NjV3LbjndemYn3lmnMmN7Z+0fg3eKdyccGFj89dIzZVLptDSYEPD7BFE2i/ahDBRF3sJ4LS0xOH
 wTXGM058UoH6K2xciCMUZpnof7/vapeNbomAwFPN21yIiu+Yn5p1fwZE0J8UJJqdsijBD/RISbC
 Kok0yCiA==
X-Google-Smtp-Source: AGHT+IH3liUeNlYpuoHGcKnshekwTa/6uKIeUzihoMjHp9CC4P2AgyT56Iq61PCY3tj4jxfKi9FJDQ==
X-Received: by 2002:a05:600c:628f:b0:468:9e79:bee0 with SMTP id
 5b1f17b1804b1-475caed394dmr20565595e9.0.1761231371747; 
 Thu, 23 Oct 2025 07:56:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc63sm4398465f8f.27.2025.10.23.07.56.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:56:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/16] target/arm: Implement org.gnu.gdb.aarch64.tls XML
 feature in gdbstub
Date: Thu, 23 Oct 2025 15:55:52 +0100
Message-ID: <20251023145554.2062752-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023145554.2062752-1-peter.maydell@linaro.org>
References: <20251023145554.2062752-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

GDB expects the TLS registers to be exposed via org.gnu.gdb.aarch64.tls,
which will contain either just "tpidr", or else "tpidr" and "tpidr2".

This will be important for SME in future, because the lazy state
restoration scheme requires GDB to use the TPIDR2 information.
GDB doesn't currently implement that, but we should provide the
register via the XML so that we are ready when future GDB versions
support it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251017153027.969016-3-peter.maydell@linaro.org
---
 target/arm/cpu.h       |  1 +
 target/arm/internals.h |  3 ++
 target/arm/gdbstub.c   |  6 ++++
 target/arm/gdbstub64.c | 63 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7c226a112d5..39f2b2e54de 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -943,6 +943,7 @@ struct ArchCPU {
     DynamicGDBFeatureInfo dyn_smereg_feature;
     DynamicGDBFeatureInfo dyn_m_systemreg_feature;
     DynamicGDBFeatureInfo dyn_m_secextreg_feature;
+    DynamicGDBFeatureInfo dyn_tls_feature;
 
     /* Timers used by the generic (architected) timer */
     QEMUTimer *gt_timer[NUM_GTIMERS];
diff --git a/target/arm/internals.h b/target/arm/internals.h
index bf44066f71b..f86f421a3db 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1716,6 +1716,7 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
 
 GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_reg);
 GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cpu, int base_reg);
+GDBFeature *arm_gen_dynamic_tls_feature(CPUState *cpu, int base_reg);
 int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
 int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg);
@@ -1728,6 +1729,8 @@ int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_pauth_reg(CPUState *cs, uint8_t *buf, int reg);
 int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg);
+int aarch64_gdb_get_tls_reg(CPUState *cs, GByteArray *buf, int reg);
+int aarch64_gdb_set_tls_reg(CPUState *cs, uint8_t *buf, int reg);
 void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
 void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp);
 void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 1ca3e647a84..8865f27089d 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -583,6 +583,12 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                      0);
         }
 #endif
+
+        /* All AArch64 CPUs have at least TPIDR */
+        gdb_register_coprocessor(cs, aarch64_gdb_get_tls_reg,
+                                 aarch64_gdb_set_tls_reg,
+                                 arm_gen_dynamic_tls_feature(cs, cs->gdb_num_regs),
+                                 0);
 #endif
     } else {
         if (arm_feature(env, ARM_FEATURE_NEON)) {
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 5ad00fe771d..3bc7ff45d57 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -387,6 +387,44 @@ int aarch64_gdb_set_sme2_reg(CPUState *cs, uint8_t *buf, int reg)
     return 0;
 }
 
+int aarch64_gdb_get_tls_reg(CPUState *cs, GByteArray *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    switch (reg) {
+    case 0: /* TPIDR_EL0 */
+        return gdb_get_reg64(buf, env->cp15.tpidr_el[0]);
+    case 1: /* TPIDR2_EL0 */
+        return gdb_get_reg64(buf, env->cp15.tpidr2_el0);
+    default:
+        /* gdbstub asked for something out of range */
+        break;
+    }
+
+    return 0;
+}
+
+int aarch64_gdb_set_tls_reg(CPUState *cs, uint8_t *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    switch (reg) {
+    case 0: /* TPIDR_EL0 */
+        env->cp15.tpidr_el[0] = ldq_p(buf);
+        return 8;
+    case 1: /* TPIDR2_EL0 */
+        env->cp15.tpidr2_el0 = ldq_p(buf);
+        return 8;
+    default:
+        /* gdbstub asked for something out of range */
+        break;
+    }
+
+    return 0;
+}
+
 int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -586,6 +624,31 @@ GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cs, int base_reg)
     return &cpu->dyn_smereg_feature.desc;
 }
 
+GDBFeature *arm_gen_dynamic_tls_feature(CPUState *cs, int base_reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    GDBFeatureBuilder builder;
+    int reg = 0;
+
+    gdb_feature_builder_init(&builder, &cpu->dyn_tls_feature.desc,
+                             "org.gnu.gdb.aarch64.tls", "tls-registers.xml",
+                             base_reg);
+
+    /*
+     * This feature must always have "tpidr", and may also have "tpidr2"
+     * if the CPU has that register.
+     */
+    gdb_feature_builder_append_reg(&builder, "tpidr", 64,
+                                   reg++, "data_ptr", NULL);
+    if (cpu_isar_feature(aa64_sme, cpu)) {
+        gdb_feature_builder_append_reg(&builder, "tpidr2", 64,
+                                       reg++, "data_ptr", NULL);
+    }
+    gdb_feature_builder_end(&builder);
+
+    return &cpu->dyn_tls_feature.desc;
+}
+
 #ifdef CONFIG_USER_ONLY
 int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg)
 {
-- 
2.43.0


