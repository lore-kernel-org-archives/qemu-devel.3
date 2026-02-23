Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF35EC1115
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZM5-0004LM-BH; Mon, 23 Feb 2026 12:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZLD-0002vD-Vi
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:32 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZL9-0000PY-Bf
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:27 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48370174e18so24815725e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866194; x=1772470994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Oc4IQYy6jHc0YZ0doMPC3fB8hIXKqwZ6F4RE9AoioM0=;
 b=Z+4NqwgNKHwCgXFwfU/6FvdMfunw6YwossNC/SPg/QmqpK+w2mSLfb5FL8y6Z0Hgei
 lB0CcvdVVqboaGLNBWX1aByKFrBtUG0uPep/RKDDhNvvD50njI0rtqR6mFCsKxOj1bnf
 jbibzy4COdxz1DXVX5q3h/yPRR2b4/t1LNi+GMB9pX+fpEkCjtavxNg2rpq1F4nIhwWW
 ODhRfOtQXUWwXR567/vhqAecxlCz8GM9Vz799sQsgPMqsRUWhT3DZj8rHD68mVTxthpI
 PFYYRMeBE5R4v40IqkrC/ALKHuxvnvuMWgjKXCUCqviiGkD9lZwoWaqs/7AiZiW46d8m
 5Fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866194; x=1772470994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Oc4IQYy6jHc0YZ0doMPC3fB8hIXKqwZ6F4RE9AoioM0=;
 b=UanKQKkh79Dx3WVLLmYiTRlpCXIgJJD5wI+IgTHDOe49Z48D/oW06dzXQOPkxWZf8N
 LIruLGJp4gvBZY63ocYcRgR9J7VNSofogXl56dLycHbtrAbi9PMCn9eNg2Rhi5ahZx4Q
 7l11NLEjY+5eUsxk9qvsTSIhEPssGo+bDlVC+hshkyG82GIvNOoKojnrBAnSPVSc3b0f
 LOk/Lu/lTwzl2PfNvuoVE+pjo1lHBe0EcHxOC1zk8SJjGKIfxX/ngii2S054mnAh78Ag
 CdUWCK5nviwC7e6/AZp/gwvPFYdFyyB52VBKGTUYwv3ecZOsA5HKb5Q3K3jEwNRCovkb
 vXuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlChNZFjwg4ESYXEwAN+hrd6+LZJa+z84Mj6tNXIVMawVasTUDgCvQQRQmTTlb3y5siVD2+CRDt/b2@nongnu.org
X-Gm-Message-State: AOJu0Yw2nJ5uWKhSNH8As6UXRvMTqOlB8Dut0j7VgiCL3WFqU1kIHFwX
 cVrgz7zI0iqM9Xa6TPDhBym18o4OqTYf/s9yUZZHD9Vxtrl1GENd33e+Ku+AAiIO6TE=
X-Gm-Gg: AZuq6aKwvE4Mty1a2Dgy7DFHgIqoywio9NOAA8HT7fKlHTFdPUwjwReqgkEb4ZhjBaC
 RgP/hnbTlDs05Oz4nTN/tq8GZv44Dp7lK5ZTb9JOQouh15hK8MZ+msFBEC4jU63C7UK/jMEs1/Y
 A3YTh8bxQuV8Mpcd/jWZVHYI4etBzBGCZ4t9+qGdl9jRMXML8kxxlLnD568f9+3Bb4/o5imZpki
 0UcbzSpfss3u/0f6VROhG2gsseQCL0mTwdE0ZcuSKqEAmWQyP0X++2d/xdNgW10hdUwh5KV4r4Q
 dD6W09ZdBbkSNQ8pRqTrveiGhIOGJOv9QKwr696GdYhAXHLrkpuj7PY0naeAUYlTGy74ZciwoGo
 ++H16v+DbXqudPJilVxL5Ohh33eWdSPlNTh2oY3yMBi0+gK1dvf+5NoFoiiyf/7qAGaqhrLZm6m
 PSoeSN/4gm+itfcTWBbvZXeSVc2GDcHEjKTVpQsURX4PJxPMDHdAlXBR9CxQumaH5vl4OaaCp4m
 ACSZwdiqNTHRiHsCzFYCcHF14/jbxw=
X-Received: by 2002:a05:600c:628d:b0:483:5a29:9678 with SMTP id
 5b1f17b1804b1-483a95bd8a7mr165353425e9.2.1771866193551; 
 Mon, 23 Feb 2026 09:03:13 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:03:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 53/65] target/arm: Add has_gcie property to enable FEAT_GCIE
Date: Mon, 23 Feb 2026 17:02:00 +0000
Message-ID: <20260223170212.441276-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Add a has_gcie QOM property to the CPU which allows the board code to
enable FEAT_GCIE, the GICv5 CPU interface.

Enabling the GICv5 CPU interface comes with a significant
restriction: because the GICv5 architecture is Armv9, it assumes the
Armv9 requirement that only EL0 (userspace) may be in AArch32.  So
there are no GIC control system registers defined for AArch32.  We
force AArch32 at ELs 1, 2 and 3 to disabled, to avoid a guest being
able to get into an EL where interrupts are completely broken.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h |  5 +++++
 target/arm/cpu.c          | 45 +++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.h          |  2 ++
 3 files changed, 52 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e391b394ba..c0ba56f244 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1072,6 +1072,11 @@ static inline bool isar_feature_aa64_aa32_el2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, EL2) >= 2;
 }
 
+static inline bool isar_feature_aa64_aa32_el3(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, EL3) >= 2;
+}
+
 static inline bool isar_feature_aa64_ras(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, RAS) != 0;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 551be14e22..7f67e8ae47 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1191,6 +1191,9 @@ static const Property arm_cpu_has_el2_property =
 
 static const Property arm_cpu_has_el3_property =
             DEFINE_PROP_BOOL("has_el3", ARMCPU, has_el3, true);
+
+static const Property arm_cpu_has_gcie_property =
+            DEFINE_PROP_BOOL("has_gcie", ARMCPU, has_gcie, false);
 #endif
 
 static const Property arm_cpu_cfgend_property =
@@ -1423,6 +1426,11 @@ static void arm_cpu_post_init(Object *obj)
         object_property_add_uint64_ptr(obj, "rvbar",
                                        &cpu->rvbar_prop,
                                        OBJ_PROP_FLAG_READWRITE);
+
+        /* We only allow GICv5 on a 64-bit v8 CPU */
+        if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_gcie_property);
+        }
     }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
@@ -1697,6 +1705,12 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                        current_accel_name());
             return;
         }
+        if (cpu->has_gcie) {
+            error_setg(errp,
+                       "Cannot enable %s when guest CPU has GICv5 enabled",
+                       current_accel_name());
+            return;
+        }
     }
 #endif
 
@@ -2020,6 +2034,37 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         FIELD_DP32_IDREG(isar, ID_PFR1, VIRTUALIZATION, 0);
     }
 
+    /* Report FEAT_GCIE in our ID registers if property was set */
+    FIELD_DP64_IDREG(isar, ID_AA64PFR2, GCIE, cpu->has_gcie);
+    if (cpu_isar_feature(aa64_gcie, cpu)) {
+        if (!arm_feature(env, ARM_FEATURE_AARCH64)) {
+            /*
+             * We only create the have_gcie property for AArch64 CPUs,
+             * but the user might have tried aarch64=off with has_gcie=on.
+             */
+            error_setg(errp, "Cannot both enable has_gcie and disable aarch64");
+            return;
+        }
+
+        /*
+         * FEAT_GCIE implies Armv9, which implies no AArch32 above EL0.
+         * Usually we don't strictly insist on this kind of feature
+         * dependency, but in this case we enforce it, because the
+         * GICv5 CPU interface has no AArch32 versions of its system
+         * registers, so interrupts wouldn't work if we allowed AArch32
+         * in EL1 or above. Downgrade "AArch32 and AArch64" to "AArch64".
+         */
+        if (cpu_isar_feature(aa64_aa32_el3, cpu)) {
+            FIELD_DP64_IDREG(isar, ID_AA64PFR0, EL3, 1);
+        }
+        if (cpu_isar_feature(aa64_aa32_el2, cpu)) {
+            FIELD_DP64_IDREG(isar, ID_AA64PFR0, EL2, 1);
+        }
+        if (cpu_isar_feature(aa64_aa32_el1, cpu)) {
+            FIELD_DP64_IDREG(isar, ID_AA64PFR0, EL1, 1);
+        }
+    }
+
     if (cpu_isar_feature(aa64_mte, cpu)) {
         /*
          * The architectural range of GM blocksize is 2-6, however qemu
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 651fccd59b..a5f27dfe0f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1032,6 +1032,8 @@ struct ArchCPU {
     bool has_neon;
     /* CPU has M-profile DSP extension */
     bool has_dsp;
+    /* CPU has FEAT_GCIE GICv5 CPU interface */
+    bool has_gcie;
 
     /* CPU has memory protection unit */
     bool has_mpu;
-- 
2.43.0


