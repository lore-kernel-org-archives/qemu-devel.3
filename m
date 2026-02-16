Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D19E63F2F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 03:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrpXs-0002hm-SJ; Sun, 15 Feb 2026 22:45:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXn-0002de-Qt
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:45:07 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXl-0002T8-3Z
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:45:07 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so27641535ad.2
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 19:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771213503; x=1771818303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oeZjdzqdE1iuyBszq/Z//al5shVLI8GhqttWbbZVCxI=;
 b=QD8H0kCA+7qH+w3USdDjw8+EmP2a1g7vpmfyASliStMJBvGoxd9fjyW7WdMrTwwvs9
 +AAisdpYdUM23j/pTzk5XuvT5ulFJHHAFcBkrIg6kyqMS33xQ6vueLqaVIWnCGqLG6z6
 +fnPTn/liNHoFXKq1gBeI78Wm4+r+6e7+t8D0xcyfhCxPQ90qK14eG7wK9LsBsq2pS0m
 sWrMZNg6woO/5spL8nhaeH15F71G1LX/uKdJ2x63/QV7Nc4avh316OsPeWmt35gkAXa+
 hpFA6lauCQacqEgKNZuOPWcB5tQr92sp3DqQP3m8ksnJp0mJS+XB+5/7+953qcRZauRN
 q0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771213503; x=1771818303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oeZjdzqdE1iuyBszq/Z//al5shVLI8GhqttWbbZVCxI=;
 b=WwKhIoyg6gmmR+jGAO7jKYLQj6SPC+3BEvlR37qgjWO6Z3liYlZJ0Ceaal0pt5366v
 ZV/o09s08kJgrNkTetfT41xUK6DWPybRSdOxpJHszotVRihPdasm59hRGoXDgFTh7aIY
 9/O8qkxAnXNW6TdaNV+ZNMy0LhklKCD0RODoYnklv5vFgWHx9BgwHpUcwcR8TpDgxZrQ
 Hxxxy4OSey2FzOrtTelGHRoGRry1hGDsOt2rX9YRoPhRIxcG2IA+Fmb2BPHwVYxV4lQp
 RIhez96bSG2hYAac07Kmhxm3rZt5vDOhVP5JMCqoNpeE06rFUrzAXF6g8iFCKvNCpZko
 LLoQ==
X-Gm-Message-State: AOJu0YyJiO5XSXAWDxHyrhpRqEUAWqgdj5RTVh8bCAn0f/kHafefv0ed
 oKyPaGikyFFjAm5A+UP7o4HnnnRFWGhPdCb983Pf+t/wzysyZQv9YG0csroVhSdF5wXsJmVAIru
 SD2ZrDFY=
X-Gm-Gg: AZuq6aJNh1brwaSxBFSLHpCkhfAy4Q34869xXiOOLp29/aOw4y/Suty1z2Hc/0tdvZY
 3LvoyBGALnIUxCSfL6DTQRTtcCFBqDRP1U/RQC1nrDEoiMXBGYbs9La0jsUPqjgATKxJQaQGoOd
 uJ0hyd7M5MDcY1pvhOZBIDBo0Qk2r2DA4SnBo0HIGBqVKD8QlYrBb6mlaSguXhGtKXr+z6mAyPz
 QydjQA4r0QV3Ax5/IlTGyAzjPy+A4xj3Fr3UqlXyRbKOAnHursyUFrCrVqCQMBFtWBT+Qq/tEH8
 pi51zJ1qmXwORTRjaX38m3sJ0Lr01hxhJhY6zB98lDKDrTBH2ephtReB8X/gjYurAuwwfv5wESi
 uMpJId0TF9xjKdnNa5f/f/ZOO5ffMaOqGNhO77RxeONpRPttKpqUTfhcakDUZ5RC2oM7LpSzG2y
 T8rik6CVbh4LnL4R8bYCMjzk089AEDLELl
X-Received: by 2002:a17:902:e787:b0:2aa:d11d:5c36 with SMTP id
 d9443c01a7336-2ab50598a38mr96753725ad.30.1771213502651; 
 Sun, 15 Feb 2026 19:45:02 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadca84sm53294155ad.70.2026.02.15.19.45.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 19:45:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 12/13] target/arm: Add SME state to kvm_arch_{get,
 put}_registers
Date: Mon, 16 Feb 2026 13:44:31 +1000
Message-ID: <20260216034432.23912-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216034432.23912-1-richard.henderson@linaro.org>
References: <20260216034432.23912-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 target/arm/kvm.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d05ad1d7e1..6d849573be 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -43,6 +43,11 @@
 #include "target/arm/gtimer.h"
 #include "migration/blocker.h"
 
+/* ??? This probably belongs in asm-arm64/kvm.h */
+#define KVM_REG_ARM64_SME_ZT0 \
+    (KVM_REG_ARM64 | KVM_REG_ARM64_SME | \
+     KVM_REG_ARM64_SME_ZT_BASE | KVM_REG_SIZE_U512)
+
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(DEVICE_CTRL),
     KVM_CAP_LAST_INFO
@@ -2157,10 +2162,39 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
+static int kvm_arch_put_sme(CPUState *cs, uint32_t svq)
+{
+    CPUARMState *env = cpu_env(cs);
+    ARMCPU *cpu = env_archcpu(env);
+    uint64_t tmp[ARM_MAX_VQ * 2];
+    uint64_t *r;
+    int ret;
+
+    for (int n = 0; n < svq * 16; ++n) {
+        r = sve_bswap64(tmp, &env->za_state.za[n].d[0], svq * 2);
+        ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SME_ZAHREG(n, 0), r);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    if (cpu_isar_feature(aa64_sme2, cpu)) {
+        r = sve_bswap64(tmp, env->za_state.zt0, ARRAY_SIZE(env->za_state.zt0));
+        ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SME_ZT0, r);
+        if (ret) {
+            return ret;
+        }
+    }
+    return 0;
+}
+
 int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     uint64_t val;
     uint32_t fpr;
+    bool sme_sm = false;
+    bool sme_za = false;
+    uint32_t svq = 0;
     int i, ret;
     unsigned int el;
 
@@ -2239,7 +2273,18 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
         }
     }
 
-    if (cpu_isar_feature(aa64_sve, cpu)) {
+    if (cpu_isar_feature(aa64_sme, cpu)) {
+        /* Current SVL is required for either SM or ZA */
+        sme_sm = FIELD_EX64(env->svcr, SVCR, SM);
+        sme_za = FIELD_EX64(env->svcr, SVCR, ZA);
+        if (sme_sm || sme_za) {
+            svq = sve_vqm1_for_el_sm(env, el, true) + 1;
+        }
+    }
+
+    if (sme_sm) {
+        ret = kvm_arch_put_sve(cs, svq, cpu_isar_feature(aa64_sme_fa64, cpu));
+    } else if (cpu_isar_feature(aa64_sve, cpu)) {
         ret = kvm_arch_put_sve(cs, cpu->sve_max_vq, true);
     } else {
         ret = kvm_arch_put_fpsimd(cs);
@@ -2248,6 +2293,13 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
         return ret;
     }
 
+    if (sme_za) {
+        ret = kvm_arch_put_sme(cs, svq);
+        if (ret) {
+            return ret;
+        }
+    }
+
     fpr = vfp_get_fpsr(env);
     ret = kvm_set_one_reg(cs, AARCH64_SIMD_CTRL_REG(fp_regs.fpsr), &fpr);
     if (ret) {
@@ -2342,11 +2394,41 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
+static int kvm_arch_get_sme(CPUState *cs, uint32_t svq)
+{
+    CPUARMState *env = cpu_env(cs);
+    ARMCPU *cpu = env_archcpu(env);
+    uint64_t *r;
+    int ret;
+
+    for (int n = 0; n < svq * 16; ++n) {
+        r = &env->za_state.za[n].d[0];
+        ret = kvm_get_one_reg(cs, KVM_REG_ARM64_SME_ZAHREG(n, 0), r);
+        if (ret) {
+            return ret;
+        }
+        sve_bswap64(r, r, svq * 2);
+    }
+
+    if (cpu_isar_feature(aa64_sme2, cpu)) {
+        r = env->za_state.zt0;
+        ret = kvm_get_one_reg(cs, KVM_REG_ARM64_SME_ZT0, r);
+        if (ret) {
+            return ret;
+        }
+        sve_bswap64(r, r, ARRAY_SIZE(env->za_state.zt0));
+    }
+    return 0;
+}
+
 int kvm_arch_get_registers(CPUState *cs, Error **errp)
 {
     uint64_t val;
     unsigned int el;
     uint32_t fpr;
+    bool sme_sm = false;
+    bool sme_za = false;
+    uint32_t svq = 0;
     int i, ret;
 
     ARMCPU *cpu = ARM_CPU(cs);
@@ -2424,7 +2506,18 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
         env->spsr = env->banked_spsr[i];
     }
 
-    if (cpu_isar_feature(aa64_sve, cpu)) {
+    if (cpu_isar_feature(aa64_sme, cpu)) {
+        /* Current SVL is required for either SM or ZA */
+        sme_sm = FIELD_EX64(env->svcr, SVCR, SM);
+        sme_za = FIELD_EX64(env->svcr, SVCR, ZA);
+        if (sme_sm || sme_za) {
+            svq = sve_vqm1_for_el_sm(env, el, true) + 1;
+        }
+    }
+
+    if (sme_sm) {
+        ret = kvm_arch_get_sve(cs, svq, cpu_isar_feature(aa64_sme_fa64, cpu));
+    } else if (cpu_isar_feature(aa64_sve, cpu)) {
         ret = kvm_arch_get_sve(cs, cpu->sve_max_vq, true);
     } else {
         ret = kvm_arch_get_fpsimd(cs);
@@ -2433,6 +2526,13 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
         return ret;
     }
 
+    if (sme_za) {
+        ret = kvm_arch_get_sme(cs, svq);
+        if (ret) {
+            return ret;
+        }
+    }
+
     ret = kvm_get_one_reg(cs, AARCH64_SIMD_CTRL_REG(fp_regs.fpsr), &fpr);
     if (ret) {
         return ret;
-- 
2.43.0


