Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834ADCCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtx4-0004vO-Ls; Fri, 31 Oct 2025 14:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtx2-0004uO-6n
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:16 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwU-0006FC-0F
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:15 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4710022571cso26896215e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935616; x=1762540416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U3XL23GQR2hlJ1ZtK1FxEFFucrtJdMwMPprsPYQAxQU=;
 b=TQCtHAmxkniKVwvdevvVETSyvzd4CNtQ+NDv/NibxjNIWmkOGXIyXQSztMxMJQ3W+1
 w8vlP3rmU00wVNcqD74t4cFMwi2EetuXs07Ze04yKT9Wd8ZbRBl8F+VjJGKNgQcPttkU
 Cig7ON2EV+3plZt/YH68sWSq6i9CmfycWL32ai/8gxaPrdwLNQPXJ6A64pig5XfhCfqs
 e78EbdRR+yi8A2joYdQqD4a/eBTGlKdFkXUA4fHJ5QS71pWedE9YlDNhjBBHEvb++bXG
 wxB7eMvAQu/3fKnxsj9kHnPenT/7w4Ql8+4A4O543gvRlBBBQdmV5MeCFYWw0dOEuC+k
 fR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935616; x=1762540416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3XL23GQR2hlJ1ZtK1FxEFFucrtJdMwMPprsPYQAxQU=;
 b=ReI1ClpWKdVvhkWi38ZzXCZkTpB1Qn/0bG3WJYCpa+IqxIAlmR19UZpWg8o3a4LSA3
 IOGm3evvkUrIbiVeineplEcidyWXMjL5IyyJiwPWXjlHUlYVWGi9XlAYVQkL9qZ13Sft
 T3/CBXm6miErizH6q5sM1xthlQuiMRwQIr69oU22TgHRqDU48QgtUMrbYhT0fH3onZkf
 fYDBboY28xGvhMmTSZQM1+uUggwsqJTviGBnFZBIMxhoff8VKtIQT2QEFNNx4b/GtAQj
 IizXEkXCPPlMXXwc5CzKPSnj0txQ1WlXyPymDb9XWyJX+dr7wOSx2e/Vs9HLP3l+cDLt
 0hEA==
X-Gm-Message-State: AOJu0YwOLFH+Hc5IXy2tuYmjbn2/x4HbtrK7L8pZKSf83PvTMDhBEdXj
 zvzzmLCgADi9TiQ3tiZ925omMfm0zS2DB3XOCha+aJzmpWJZlAKF4xRp8F3NkPCcHkqqxUf6EDA
 u5Jdn
X-Gm-Gg: ASbGnctR6m+Hr4woLGc0aakKzslNFLXBIQlqZ4Ht8diXZZXSkLfQkAStpfEMYk5j6md
 dPNk6yOg2gXBdVTqPfKr6JOGNQfQmSCqNLCVIh7pZlLG3n11JmYF3YMAZJyzeP5wwCtvpnxfyAE
 hheFfcxyoVrfjMe1g58DsV3XwEMBO8mngFMz7LTMi0yRiCbGFwARatd+4G5jVEKR74YtiCLAn98
 trJ14q3Ij+0/IGcouR6AKeq+4Xi63AYN5dpMiL73RFx5jTQhCgl5BNXUOpFu9T4Q4Az/+X5mfUx
 KpSovjkHntdWVXHqZGq7y0X3yd4q0eldB+rLmBHLmMj8+PUuKtI5AFaWTulKO6hByiWYVOB6bvR
 E1rxAePxti5awznPXiZh0MVNbGDNDArfV7eg/X9MXgTtMIRjric9AGzn68NZqYYzSBfK3+ISVwy
 kxnrgAqw==
X-Google-Smtp-Source: AGHT+IFsFdsNhMlvCdEAwW+tLZSj4kYVIbRCDIEsxjw/mY6RReIsVwHAIZiewPHEliUFc8sfhLmcVA==
X-Received: by 2002:a05:600c:8185:b0:475:da13:2566 with SMTP id
 5b1f17b1804b1-477308a690dmr46931695e9.35.1761935615934; 
 Fri, 31 Oct 2025 11:33:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/38] target/arm/hvf: switch hvf_arm_get_host_cpu_features to
 not create a vCPU
Date: Fri, 31 Oct 2025 18:32:56 +0000
Message-ID: <20251031183310.3778349-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Creating a vCPU locks out APIs such as hv_gic_create().

As a result, switch to using the hv_vcpu_config_get_feature_reg interface.

Besides, all the following methods must be run on a vCPU thread:

  - hv_vcpu_create()
  - hv_vcpu_get_sys_reg()
  - hv_vcpu_destroy()

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Message-ID: <20250808070137.48716-3-mohamed@unpredictable.fr>
[PMD: Release config calling os_release()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index dea1cb37d1f..fcb6950692b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -744,25 +744,24 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     ARMISARegisters host_isar = {};
     static const struct isar_regs {
-        int reg;
+        hv_feature_reg_t reg;
         ARMIDRegisterIdx index;
     } regs[] = {
-        { HV_SYS_REG_ID_AA64PFR0_EL1, ID_AA64PFR0_EL1_IDX },
-        { HV_SYS_REG_ID_AA64PFR1_EL1, ID_AA64PFR1_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64PFR0_EL1, ID_AA64PFR0_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64PFR1_EL1, ID_AA64PFR1_EL1_IDX },
         /* Add ID_AA64PFR2_EL1 here when HVF supports it */
-        { HV_SYS_REG_ID_AA64DFR0_EL1, ID_AA64DFR0_EL1_IDX },
-        { HV_SYS_REG_ID_AA64DFR1_EL1, ID_AA64DFR1_EL1_IDX },
-        { HV_SYS_REG_ID_AA64ISAR0_EL1, ID_AA64ISAR0_EL1_IDX },
-        { HV_SYS_REG_ID_AA64ISAR1_EL1, ID_AA64ISAR1_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64DFR0_EL1, ID_AA64DFR0_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64DFR1_EL1, ID_AA64DFR1_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64ISAR0_EL1, ID_AA64ISAR0_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64ISAR1_EL1, ID_AA64ISAR1_EL1_IDX },
         /* Add ID_AA64ISAR2_EL1 here when HVF supports it */
-        { HV_SYS_REG_ID_AA64MMFR0_EL1, ID_AA64MMFR0_EL1_IDX },
-        { HV_SYS_REG_ID_AA64MMFR1_EL1, ID_AA64MMFR1_EL1_IDX },
-        { HV_SYS_REG_ID_AA64MMFR2_EL1, ID_AA64MMFR2_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64MMFR0_EL1, ID_AA64MMFR0_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64MMFR1_EL1, ID_AA64MMFR1_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64MMFR2_EL1, ID_AA64MMFR2_EL1_IDX },
         /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
     };
-    hv_vcpu_t fd;
     hv_return_t r = HV_SUCCESS;
-    hv_vcpu_exit_t *exit;
+    hv_vcpu_config_t config = hv_vcpu_config_create();
     uint64_t t;
     int i;
 
@@ -773,17 +772,11 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                      (1ULL << ARM_FEATURE_PMU) |
                      (1ULL << ARM_FEATURE_GENERIC_TIMER);
 
-    /* We set up a small vcpu to extract host registers */
-
-    if (hv_vcpu_create(&fd, &exit, NULL) != HV_SUCCESS) {
-        return false;
-    }
-
     for (i = 0; i < ARRAY_SIZE(regs); i++) {
-        r |= hv_vcpu_get_sys_reg(fd, regs[i].reg,
-                                 &host_isar.idregs[regs[i].index]);
+        r |= hv_vcpu_config_get_feature_reg(config, regs[i].reg,
+                                            &host_isar.idregs[regs[i].index]);
     }
-    r |= hv_vcpu_destroy(fd);
+    os_release(config);
 
     /*
      * Hardcode MIDR because Apple deliberately doesn't expose a divergent
-- 
2.43.0


