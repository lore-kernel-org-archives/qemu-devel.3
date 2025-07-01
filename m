Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13BCC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSi-0005lN-Fu; Tue, 01 Jul 2025 13:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSd-0005iR-Ab
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:00 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSa-0003fq-Rs
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:59 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so4252358f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389675; x=1751994475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KRmd9q8SI1/2SMrlX261n/ejf2J7y88+dRZ3yJXd/34=;
 b=WnYNqGe3wG4n3GAGpD8b5FIYXLx8qXX8pEZCvS5Xw3Ggk+BDoI+8xT5VpKN5uEwWLf
 QbV8x4iy6JpBY46GGuuP+xauaz8g1D2VfB0gmi/3uRAubahcF8QzQmLLcA8cVOAX4jrD
 kXysgLGIO7C4fL13OWvwFDyrspgDV54O9l6Nvv0C/f61ltalEcf39Wy6fTFRDYJZtspE
 AktV3vtJHxkWmRJBjijCiBYcu3GrkaV//oHKPomzWYg10IiBg4/h/wMyFO2LZsYqB/XP
 4+hV1WgkBqXhReXjtpe4jqPvsM/VUgOeBzs5olxVJaBAC779tgMGksgm76EbuqbSA2CX
 VcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389675; x=1751994475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KRmd9q8SI1/2SMrlX261n/ejf2J7y88+dRZ3yJXd/34=;
 b=Z1X8GLH6t6Ra2AowC1Iwr5qJNJ/vy/5R/TGUhyxGyrXJLNBj9QztHK9sbCHiTNwp40
 rrGuqL6IZLCeL7ncShWiTsAWGr6t6cMThhH1B5Ai2oj8W5m93ieigQp4+VsghHyWu2sI
 C9cFe+UE4zKfaK6hsTYyvr4gPOhkSk6IrcNomrELfUJHJ3XP3GT6eqEEdQZHSPP55jQo
 5AQTz6AbJnwkn7UNsJLfFMUv53Ttg6gOii8bHSvj4ZqvniNfBM5vcgiWGOpmAkUFlHU1
 1eh/+Ryk4iCG92DyBq8tKt1g7X+gMruiq1c+bzzDpFSLsLZ8fSjhjMI15fDWHhY32Ohs
 xRFA==
X-Gm-Message-State: AOJu0YyfwpDUN2SkF0URyFJd09G3MUUvu2NzU/jxkgkeGKWXq03qKV/R
 0S1BDwP1IoK10JUUF2l03aFG9yq0uZ+NkW9mZgzgoeLi9AlJbY4cXEWPQBPafI5hoOfbUTpMeWh
 yOcL2
X-Gm-Gg: ASbGncvMo2WVUZYrzVooDoaeo05cPsGZxUaiXGPvXK5S0bbrlyFl2XRp7PMStpZX50J
 5+r6WAlcYfe7jwTk0gOBP9soHYcJ436crU5l+GDsUyVV2gLWN4iLzZlmWa+nxB1ln+RuoxdrvF5
 CBJFpXTp0GxphjLdFLgdD2INkPlakm3GrdgNSnA9gytf4WykicJHURVrjxDOEFaf5EkaN2LlLi0
 6gQb21KUsKuFcF/79LsI58zZZojx11WzyV3D+1cSKA/AM3NQgpN9maEGB7TX03Fdev1L88W9SKy
 xqy9R55qixiuuWHCsrTnuXKzTOKGbfbSSdTqUhqlXuKAiuUxhk85KYZhUaCYep1u1Atq
X-Google-Smtp-Source: AGHT+IG2vLea3YAAIuKFofkC3j1JjzjVo0YC220k2/tDIg4yKhxrw4nMsr8cI0cv1t+Ji5qNtRiPXg==
X-Received: by 2002:a05:6000:e0f:b0:3a6:ec1b:5742 with SMTP id
 ffacd0b85a97d-3a90d69c82dmr12504896f8f.22.1751389675199; 
 Tue, 01 Jul 2025 10:07:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/43] target/arm: Restrict system register properties to
 system binary
Date: Tue,  1 Jul 2025 18:07:09 +0100
Message-ID: <20250701170720.4072660-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Do not expose the following system-specific properties on user-mode
binaries:

 - psci-conduit
 - cntfrq (ARM_FEATURE_GENERIC_TIMER)
 - rvbar (ARM_FEATURE_V8)
 - has-mpu (ARM_FEATURE_PMSA)
 - pmsav7-dregion (ARM_FEATURE_PMSA)
 - reset-cbar (ARM_FEATURE_CBAR)
 - reset-hivecs (ARM_FEATURE_M)
 - init-nsvtor (ARM_FEATURE_M)
 - init-svtor (ARM_FEATURE_M_SECURITY)
 - idau (ARM_FEATURE_M_SECURITY)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250623121845.7214-13-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7030540f91f..a59a5b57af6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1500,6 +1500,7 @@ static void arm_cpu_initfn(Object *obj)
  * 0 means "unset, use the default value". That default might vary depending
  * on the CPU type, and is set in the realize fn.
  */
+#ifndef CONFIG_USER_ONLY
 static const Property arm_cpu_gt_cntfrq_property =
             DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq_hz, 0);
 
@@ -1509,7 +1510,6 @@ static const Property arm_cpu_reset_cbar_property =
 static const Property arm_cpu_reset_hivecs_property =
             DEFINE_PROP_BOOL("reset-hivecs", ARMCPU, reset_hivecs, false);
 
-#ifndef CONFIG_USER_ONLY
 static const Property arm_cpu_has_el2_property =
             DEFINE_PROP_BOOL("has_el2", ARMCPU, has_el2, true);
 
@@ -1532,6 +1532,7 @@ static const Property arm_cpu_has_neon_property =
 static const Property arm_cpu_has_dsp_property =
             DEFINE_PROP_BOOL("dsp", ARMCPU, has_dsp, true);
 
+#ifndef CONFIG_USER_ONLY
 static const Property arm_cpu_has_mpu_property =
             DEFINE_PROP_BOOL("has-mpu", ARMCPU, has_mpu, true);
 
@@ -1544,6 +1545,7 @@ static const Property arm_cpu_pmsav7_dregion_property =
             DEFINE_PROP_UNSIGNED_NODEFAULT("pmsav7-dregion", ARMCPU,
                                            pmsav7_dregion,
                                            qdev_prop_uint32, uint32_t);
+#endif
 
 static bool arm_get_pmu(Object *obj, Error **errp)
 {
@@ -1731,6 +1733,7 @@ static void arm_cpu_post_init(Object *obj)
                                         "Set on/off to enable/disable aarch64 "
                                         "execution state ");
     }
+#ifndef CONFIG_USER_ONLY
     if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
         arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_cbar_property);
@@ -1746,7 +1749,6 @@ static void arm_cpu_post_init(Object *obj)
                                        OBJ_PROP_FLAG_READWRITE);
     }
 
-#ifndef CONFIG_USER_ONLY
     if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
         /* Add the has_el3 state CPU property only if EL3 is allowed.  This will
          * prevent "has_el3" from existing on CPUs which cannot support EL3.
@@ -1818,6 +1820,7 @@ static void arm_cpu_post_init(Object *obj)
         qdev_property_add_static(DEVICE(obj), &arm_cpu_has_dsp_property);
     }
 
+#ifndef CONFIG_USER_ONLY
     if (arm_feature(&cpu->env, ARM_FEATURE_PMSA)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_has_mpu_property);
         if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
@@ -1854,8 +1857,6 @@ static void arm_cpu_post_init(Object *obj)
                                    &cpu->psci_conduit,
                                    OBJ_PROP_FLAG_READWRITE);
 
-    qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property);
-
     if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
         qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property);
     }
@@ -1864,7 +1865,6 @@ static void arm_cpu_post_init(Object *obj)
         kvm_arm_add_vcpu_properties(cpu);
     }
 
-#ifndef CONFIG_USER_ONLY
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) &&
         cpu_isar_feature(aa64_mte, cpu)) {
         object_property_add_link(obj, "tag-memory",
@@ -1882,6 +1882,7 @@ static void arm_cpu_post_init(Object *obj)
         }
     }
 #endif
+    qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property);
 }
 
 static void arm_cpu_finalizefn(Object *obj)
-- 
2.43.0


