Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73090CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya5h-0004GU-Sk; Tue, 16 Sep 2025 14:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4w-0003Ae-4l
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:59 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4n-0001d9-Pw
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45f2f10502fso15508785e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758046000; x=1758650800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zw0lxXrZ3sXM9zNmueYN9ABFbXL8fmNkpgwpH4pUGn4=;
 b=LOUYuMo2bzbFZaogDuFWO7aMINxdnzRCJGL/TgsWqoG+XUdmUNkomqHZ5qSRQ2BwxA
 ZGyLrilSi+/weJMN1HQq4agh8Enxaizyye+ADRX64+QJNnTzIx2SPE1syBt6/GNxgbS0
 FPOfeIWkmUP2BskbasN+vnGosEXKPvuBGs7D4dsKpuK7Hmgfz0RUBjfEJqwgAT0D9oih
 bW3g+z0NVhTFEsKdTTEIsynYmgynKRb2Zl9RUeBuFDqNZyzsBfzCWW591LYlVgblqU0m
 ehASN+lH36fUb1MQep4C6b6QsFuAnGAMdu2Thd7cfINGt8PanVRtTp7vW4dh3uQjoClP
 nXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758046000; x=1758650800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zw0lxXrZ3sXM9zNmueYN9ABFbXL8fmNkpgwpH4pUGn4=;
 b=LJkIzoP8yJmJMPrhKWQu3CYTUcpLYyfl3Ch2B+eSjqXtudWzSN8y7yWzzaClPlV375
 LFwhg+q9sUh4VtjxUcFcP63qZG1iWkfgdTAb7JSYgizwj3VWAfS9qqjwRmQtvkZzDvH7
 TTYaknL+mZTEvY4mxSl/htA4EA0E8F2DihBT5Y1l4ZFeD4D8EeoVPlZ7Iu7XT7cKyPj4
 FPRH2xs+2P0HLEElwXoOPXk3lp7qsehOvawoj6mMlXGZThWFhp4HGkaMa13ITLtl4MDo
 HsbWsHwWFVyoK4cc+zIpTSQ2YIaRDRKUMwXsgjAwJKgexmfxWAGwpGKsmnZdY5HyTbno
 6Fqw==
X-Gm-Message-State: AOJu0YxtKWkiLu7CTG09R+KZh0R2WHsTxSx3geqcfDVBoegXrzsdIbw/
 jcRRtp2KJPMRKbdJLFaTfc7voLKLcwzrNSKfNBAMeXXaG10at5joJb/oPTh/wfUJQSgLFIoTeRE
 Q/jNh
X-Gm-Gg: ASbGncvz977Tsr23tufhLJuqnYLSvPfGTyrwcyJ9h5Tezr0EHCQm/dF5DVmfK0u2QGJ
 ksidjnZmF94rmsq1A3ET2rhfTwN2zozfjTeWl1a3sXZFn+Y4rxPqYXikaj/ILpPucOm84kAM6Oc
 GwaRJLg3lOGSa2fNes3JpCGDToeYgc2suKjS+Mflw3FHjtOF1lBHveMgdagFEhD2hAwgFybTgpB
 b83j5eW9Z83C4ySaNtUbhWEFwtqIrSn+hM8JYG7hOBRPY/ttJErPFHmA7MmAijtsLMeuFK6jwXT
 bp4mQS5QRl3dYTOcdGP8RYRDpgajSkEeCvAS6QZR6Pu+rmGWQXJdKTAT9B+mq7zER6RJpwRUvCC
 bcGeBK6y6AedtOSHrkkhjA4s10rhKmF7tlzJsYig=
X-Google-Smtp-Source: AGHT+IFUP6cJ9GMZ0USQ4nlRhELZjWjIF0nhfAcy31LL2DDclTFrkVGy/MtZPfBBIhiga+l4EEvqgA==
X-Received: by 2002:a05:600c:22d4:b0:450:6b55:cf91 with SMTP id
 5b1f17b1804b1-45f211cb52amr144808095e9.6.1758046000025; 
 Tue, 16 Sep 2025 11:06:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/36] target/arm: Added support for SME register exposure to
 GDB
Date: Tue, 16 Sep 2025 19:05:57 +0100
Message-ID: <20250916180611.1481266-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>

The QEMU GDB stub does not expose the ZA storage SME register to GDB
via the remote serial protocol, which can be a useful functionality
to debug SME code.  To provide this functionality for AArch64
targets, this patch registers the SME register set with the GDB stub.
To do so, this patch implements the aarch64_gdb_get_sme_reg() and
aarch64_gdb_set_sme_reg() functions to specify how to get and set the
SME registers, and the arm_gen_dynamic_smereg_feature() function to
generate the target description in XML format to indicate the target
architecture supports SME.  Finally, this patch includes a
dyn_smereg_feature structure to hold this GDB XML description of the
SME registers for each CPU.

Note that according to the GDB documentation the ZA register is
defined as a vector of bytes; however the target description xml
retrieved when using gdb natively on a host with SME capabilities
represents the ZA register as a vector of vectors of bytes, so this
is a GDB documentation error.  We follow GDB's own gdbstub
implementation and represent the ZA register as a vector of vectors
of bytes as is done by GDB here:

https://github.com/bminor/binutils-gdb/blob/5cce2b7006daa7073b98e3d1a3b176199d1381d7/gdb/features/aarch64-sme.c#L50

Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Message-id: 20250909161012.2561593-3-vacha.bhavsar@oss.qualcomm.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: fixed minor checkpatch nits]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |   1 +
 target/arm/internals.h |   3 ++
 target/arm/gdbstub.c   |  10 +++-
 target/arm/gdbstub64.c | 119 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6644043f4c2..1c0deb723d7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -925,6 +925,7 @@ struct ArchCPU {
 
     DynamicGDBFeatureInfo dyn_sysreg_feature;
     DynamicGDBFeatureInfo dyn_svereg_feature;
+    DynamicGDBFeatureInfo dyn_smereg_feature;
     DynamicGDBFeatureInfo dyn_m_systemreg_feature;
     DynamicGDBFeatureInfo dyn_m_secextreg_feature;
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 8782594b774..532fabcafc1 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1817,8 +1817,11 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
 }
 
 GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_reg);
+GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cpu, int base_reg);
 int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
+int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg);
+int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg);
 int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg);
 int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg);
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index ce4497ad7c3..2d331fff445 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -527,7 +527,8 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
          * registers so we don't need to include both.
          */
 #ifdef TARGET_AARCH64
-        if (isar_feature_aa64_sve(&cpu->isar)) {
+        if (isar_feature_aa64_sve(&cpu->isar) ||
+            isar_feature_aa64_sme(&cpu->isar)) {
             GDBFeature *feature = arm_gen_dynamic_svereg_feature(cs, cs->gdb_num_regs);
             gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
                                      aarch64_gdb_set_sve_reg, feature, 0);
@@ -537,6 +538,13 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                      gdb_find_static_feature("aarch64-fpu.xml"),
                                      0);
         }
+
+        if (isar_feature_aa64_sme(&cpu->isar)) {
+            GDBFeature *sme_feature =
+                arm_gen_dynamic_smereg_feature(cs, cs->gdb_num_regs);
+            gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
+                                     aarch64_gdb_set_sme_reg, sme_feature, 0);
+        }
         /*
          * Note that we report pauth information via the feature name
          * org.gnu.gdb.aarch64.pauth_v2, not org.gnu.gdb.aarch64.pauth.
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 08e28585396..3bccde2bf25 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -249,6 +249,90 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
     return 0;
 }
 
+int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    switch (reg) {
+    case 0: /* svg register */
+    {
+        int vq = 0;
+        if (FIELD_EX64(env->svcr, SVCR, SM)) {
+            vq = sve_vqm1_for_el_sm(env, arm_current_el(env),
+                                    FIELD_EX64(env->svcr, SVCR, SM)) + 1;
+        }
+        /* svg = vector granules (2 * vector quardwords) in streaming mode */
+        return gdb_get_reg64(buf, vq * 2);
+    }
+    case 1: /* svcr register */
+        return gdb_get_reg64(buf, env->svcr);
+    case 2: /* za register */
+    {
+        int len = 0;
+        int vq = cpu->sme_max_vq;
+        int svl = vq * 16;
+        for (int i = 0; i < svl; i++) {
+            for (int q = 0; q < vq; q++) {
+                len += gdb_get_reg128(buf,
+                                      env->za_state.za[i].d[q * 2 + 1],
+                                      env->za_state.za[i].d[q * 2]);
+            }
+        }
+        return len;
+    }
+    default:
+        /* gdbstub asked for something out of range */
+        qemu_log_mask(LOG_UNIMP, "%s: out of range register %d", __func__, reg);
+        break;
+    }
+
+    return 0;
+}
+
+int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    switch (reg) {
+    case 0: /* svg register */
+        /* cannot set svg via gdbstub */
+        return 8;
+    case 1: /* svcr register */
+        aarch64_set_svcr(env, ldq_le_p(buf),
+                         R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
+        return 8;
+    case 2: /* za register */
+    {
+        int len = 0;
+        int vq = cpu->sme_max_vq;
+        int svl = vq * 16;
+        for (int i = 0; i < svl; i++) {
+            for (int q = 0; q < vq; q++) {
+                if (target_big_endian()) {
+                    env->za_state.za[i].d[q * 2 + 1] = ldq_p(buf);
+                    buf += 8;
+                    env->za_state.za[i].d[q * 2] = ldq_p(buf);
+                } else{
+                    env->za_state.za[i].d[q * 2] = ldq_p(buf);
+                    buf += 8;
+                    env->za_state.za[i].d[q * 2 + 1] = ldq_p(buf);
+                }
+                buf += 8;
+                len += 16;
+            }
+        }
+        return len;
+    }
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
@@ -413,6 +497,41 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cs, int base_reg)
     return &cpu->dyn_svereg_feature.desc;
 }
 
+GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cs, int base_reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    int vq = cpu->sme_max_vq;
+    int svl = vq * 16;
+    GDBFeatureBuilder builder;
+    int reg = 0;
+
+    gdb_feature_builder_init(&builder, &cpu->dyn_smereg_feature.desc,
+                             "org.gnu.gdb.aarch64.sme", "sme-registers.xml",
+                             base_reg);
+
+
+    /* Create the sme_bv vector type. */
+    gdb_feature_builder_append_tag(
+        &builder, "<vector id=\"sme_bv\" type=\"uint8\" count=\"%d\"/>",
+        svl);
+
+    /* Create the sme_bvv vector type. */
+    gdb_feature_builder_append_tag(
+        &builder, "<vector id=\"sme_bvv\" type=\"sme_bv\" count=\"%d\"/>",
+        svl);
+
+    /* Define the svg, svcr, and za registers. */
+
+    gdb_feature_builder_append_reg(&builder, "svg", 64, reg++, "int", NULL);
+    gdb_feature_builder_append_reg(&builder, "svcr", 64, reg++, "int", NULL);
+    gdb_feature_builder_append_reg(&builder, "za", svl * svl * 8, reg++,
+                                   "sme_bvv", NULL);
+
+    gdb_feature_builder_end(&builder);
+
+    return &cpu->dyn_smereg_feature.desc;
+}
+
 #ifdef CONFIG_USER_ONLY
 int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg)
 {
-- 
2.43.0


