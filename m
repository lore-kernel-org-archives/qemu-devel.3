Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA24CCCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9mPs-0005Jm-Eb; Fri, 17 Oct 2025 11:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9mPo-0005Ev-Mi
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:30:50 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9mPd-00015P-Jg
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:30:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47114a40161so20730225e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760715031; x=1761319831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzTp5dohZBD7ZiEa8fcC1MwOC/QjlTE8j5vm3/Ww3r0=;
 b=k6gpgP/b/Nw0gK7j+SQdtBUjLikoPXF2eebRB5j/jgAmF1vqzOPN1OP6cPbd3txcVT
 dQ9Vwt9vLTSvdrN2A4IznrgvFlySCAbHRbDot0AugiLKx8k8qy23OWHtdJV6l+H+dNvT
 k0LUBTJzjjxbgaAGZpKFtbs6/Nh+8XGoN4bkw+auOvGzwJ1SxR/YWwfA87paWchSutDZ
 YYBlyFvmYDleySbpxVaXgpNEaK+nKefc0ag49qjCoHi6yytgf3KzVFawGsc+gA8Vu8eq
 +Ha6THCQUz4NC9o7jfiHPeJswMIhRyfg75/aP8otmJWX/rzyrp3nEqLZT5p45CRxaG9J
 33dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760715031; x=1761319831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jzTp5dohZBD7ZiEa8fcC1MwOC/QjlTE8j5vm3/Ww3r0=;
 b=fot3y4F3T1q39AMBVcR43sn77jCXy743L1/zNIVNRpFUF5BymJXXQX/x373qbSsphy
 YlIfQBinR8IyJ1g5XjfW6hJgD/Xf/ZAyltv5yQ3OiHLUeU40kDMVHLo2yTdy6Tww8yM+
 p63DEGVlvAXAQrJpBaJbBBkaMZXpLoOrcfQoUWa8rZ0EVe7vCCRIVFwHFzseTjrzniva
 0s57CC+v/CtDk0UqIf03U7GUdGqfREUilSz/cGZs4bqnQTTm3M/U+ctnaySzxTaa3oR2
 7OICBdsViPRVITBkT5ZZoI2cmSn7KjAaUo8cQBNcvmCMdGO2pfxqeu5dShpzXbQEklma
 AwYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/w/EErt4KRjPVUMwuMLoQbF7QBeiumw/rdyQSg3pS9Aj/oUqLkHRQOgDVfFllvYta6CmAxmAdy0XU@nongnu.org
X-Gm-Message-State: AOJu0YyjaP033GwemT0hOPsJ8wySyIvuYz7p/rgoa0x0eVBdCxqjIKjE
 pEPzsA44mvbqnXGxEmHHLQR7Ha5AlwTdycSzlKYX+8bEoApVtHEm+9+pDY/Dt5zbn8U=
X-Gm-Gg: ASbGncv7UgfMYUjZs61wrmr3YptSL4k1cWFzJkUtiOELBtSCJkWriGKozui4BWaSUGa
 rNy1jeI1zgVBw2Zmg0l7GZ4vlAgDbzZlULPz0IIch2R8CnnbBxeIHBNkojTwv7FNQnuc28ZlHPJ
 RWS1ARTwsqOze2cRxStCd3iqz1aL8MzEne+I/I18uPZ6IL0e6aFToXo4P7vqJak4jeQ6p79zK6m
 xsT5DitRkvWp02JnVuu8Ky0oWvEG74RjAGpOlg94f5+6p9oTCLQW9CXSCuG+lgrLDYr5+WlB6TD
 jwPWz5NocqHcE34lrxuEmFZb3iLqte5d0mpSGFjTs6fsM2oljCNoEwGyo6kYXHQHeAzI8odDmp1
 7Ban5v4ChVlsakHmdV2cHdnUVZfDRj120h5HnW+nC7xbwxdFCpBZdWtfkE8jlpp+4aUnWME8gvS
 ovY1O6oOYJV3UD2N23XoMl7JVIj6A=
X-Google-Smtp-Source: AGHT+IFxFuSOiLLloabMiBtAGjsllNLQ85wFjv5vkKF/QE3MyoouLh6UOQKwOQJTtJEoj6i/Y+zMzA==
X-Received: by 2002:a05:600c:8b62:b0:45d:d97c:235e with SMTP id
 5b1f17b1804b1-47117876bcdmr29750615e9.12.1760715031174; 
 Fri, 17 Oct 2025 08:30:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144d17cdsm85038635e9.18.2025.10.17.08.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 08:30:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v2 2/3] target/arm: Implement org.gnu.gdb.aarch64.tls XML
 feature in gdbstub
Date: Fri, 17 Oct 2025 16:30:26 +0100
Message-ID: <20251017153027.969016-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017153027.969016-1-peter.maydell@linaro.org>
References: <20251017153027.969016-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/arm/cpu.h       |  1 +
 target/arm/internals.h |  3 ++
 target/arm/gdbstub.c   |  6 ++++
 target/arm/gdbstub64.c | 63 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bf221e6f973..47be3076370 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -941,6 +941,7 @@ struct ArchCPU {
     DynamicGDBFeatureInfo dyn_smereg_feature;
     DynamicGDBFeatureInfo dyn_m_systemreg_feature;
     DynamicGDBFeatureInfo dyn_m_secextreg_feature;
+    DynamicGDBFeatureInfo dyn_tls_feature;
 
     /* Timers used by the generic (architected) timer */
     QEMUTimer *gt_timer[NUM_GTIMERS];
diff --git a/target/arm/internals.h b/target/arm/internals.h
index b8b07e6477c..97ff54896e6 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1715,6 +1715,7 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
 
 GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_reg);
 GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cpu, int base_reg);
+GDBFeature *arm_gen_dynamic_tls_feature(CPUState *cpu, int base_reg);
 int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
 int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg);
@@ -1727,6 +1728,8 @@ int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg);
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


