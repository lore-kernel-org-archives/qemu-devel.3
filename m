Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C3BCA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 17:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulsqq-0007iK-Uv; Tue, 12 Aug 2025 13:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsqo-0007hW-HQ
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:31:54 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsqm-0003wg-At
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:31:54 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b792b0b829so5613202f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 10:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755019907; x=1755624707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjnVYhq1zyLWWCSIOk8jGgKJqb2cCbKFxf1rvETdLlw=;
 b=C6PIpo2l5ZAXvmZrCH59UOfO3qTdvHnL/a02hwOqY+HswTL/R1M9fIrPch4qKsUrcD
 aLN/2yiI8HCE09iN/8VNIUN90M6wLuiv4aQx2CFWXHA59yTTaevhmuemxhzFwKRiQkSc
 Ax4h0A/zemWUgbZljfMYxinHmHDAoxrWD7162ksPqjFuXhqr2MJXvTj1w1QLzpFpAa9z
 bKQyTJqxojF3WpZthOWNBmttm8l3mDY1XaK92EYgrOMWt8209PX5zd5rR2l8BzNucX1d
 4Gpq8zztxdUIATKCMPGe3+zJtkGF4zypM/AepqQ5LIICOwn6PBEDXIqVg0lA3xm9pjug
 VKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755019907; x=1755624707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FjnVYhq1zyLWWCSIOk8jGgKJqb2cCbKFxf1rvETdLlw=;
 b=bhspCI3ntPTxutuYaoVh4khCgUElFIgAQMjQq8iEtJqYFYFTwVHORRKehI2QIkhq82
 8HhXFzKaG9npxoPHD9VNM1qB2U6dO3JBay7GWBSupvOsN+cDm8AzLGgm8NTNcgXIrwI9
 Xvp7QXG5kmwozL7EQlXvroI91yiz2i8oqrwFTi2byxdVYnldjsTIjbtrS7ULC21sFgNv
 fI5ZaJZiEGO+oHg+/qP7rZJuNGQ5mxNOCrH+CYPBJtqBwSy0LLivFZOqBeeMNcI5VEX/
 VdmzKBEUkybTSu8Gz57qi5urdmXkQmov2ns9qMTSZsrKi53qw7Rf8k6a5u/4Srbf1tRY
 uzVw==
X-Gm-Message-State: AOJu0Ywk/IGDEoGi6SLA1xX4Ffh+GrsDZZj1qmRrYfMsxBv0DVnrIpQH
 iut6hG07uQnbbbdXo37q02IdSyEM/gLrDVzzHn47PVT+KXuRbTQxVtf0k4NZ0GHsMo2LvVglfXT
 pUPqY
X-Gm-Gg: ASbGncsd0+EEknB2bibNCrp/90cu+0WEGRmJRbFtO+JzXjeh952bHxAONEz3kKugiGp
 mmi7q6fGWFBRNlv7lJ+IJV7QqWm+6OcqkvPuVoXF46mSIku9sapOh8OGytdqORU4YDTZ7RkYgfI
 n/T4hGo5C1qon44TeJvD8R7wvGZ/NCMWodba+ciKe+UGzVyawn6xSFTsuZMHuOoIEvWe8D/w0Gr
 1vg50YFhO7DJDSZgYEG6gt4U8S88lsX1mqdTYdljJ451dE3e5lgmMdcVTjWGpFAQd8xIa8Cn1ZR
 8hSpkAyUazd46lDU5X5Rla+eV9GBj121/8FpYLOiAVwm6Rwwd8kMR7ZnpWncQVRUGKVv39lxxtr
 URlWy8hRgulIFtiDudAHuRpdy/HYbHsZL6tboLYWb291uU3Huby4yD45NY6mpK4cyq8pCxGq0
X-Google-Smtp-Source: AGHT+IEtd5L0jW86Ar6WLd6Ww86OMtiv2D5ZzZ1HpTHh6p/p+A+PvclInEfr4XkgVxPeZYGiUKEy/A==
X-Received: by 2002:a05:6000:290b:b0:3b5:f0af:4bb0 with SMTP id
 ffacd0b85a97d-3b9172649f9mr194931f8f.23.1755019906766; 
 Tue, 12 Aug 2025 10:31:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bf970sm44724147f8f.25.2025.08.12.10.31.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Aug 2025 10:31:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: [RFC PATCH v2 07/10] target/arm: Replace kvm_arm_el2_supported by
 host_cpu_feature_supported
Date: Tue, 12 Aug 2025 19:31:31 +0200
Message-ID: <20250812173131.86888-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812173131.86888-1-philmd@linaro.org>
References: <20250812172823.86329-1-philmd@linaro.org>
 <20250812173131.86888-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Use the generic host_cpu_feature_supported() helper to
check for the EL2 feature support. This will allow to
expand to non-KVM accelerators such HVF.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/kvm_arm.h  | 11 -----------
 hw/arm/virt.c         |  8 +-------
 target/arm/kvm-stub.c |  5 -----
 target/arm/kvm.c      |  6 +++---
 4 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 364578c50d6..7e5755d76b2 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -191,12 +191,6 @@ bool kvm_arm_sve_supported(void);
  */
 bool kvm_arm_mte_supported(void);
 
-/**
- * kvm_arm_el2_supported:
- *
- * Returns true if KVM can enable EL2 and false otherwise.
- */
-bool kvm_arm_el2_supported(void);
 #else
 
 static inline bool kvm_arm_aarch32_supported(void)
@@ -213,11 +207,6 @@ static inline bool kvm_arm_mte_supported(void)
 {
     return false;
 }
-
-static inline bool kvm_arm_el2_supported(void)
-{
-    return false;
-}
 #endif
 
 /**
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ef6be3660f5..62350f642ef 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2267,13 +2267,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && kvm_enabled() && !kvm_arm_el2_supported()) {
-        error_report("mach-virt: host kernel KVM does not support providing "
-                     "Virtualization extensions to the guest CPU");
-        exit(1);
-    }
-
-    if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
+    if (vms->virt && !host_cpu_feature_supported(ARM_FEATURE_EL2)) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 3beb336416d..35afcc7d6f9 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -42,11 +42,6 @@ bool kvm_arm_mte_supported(void)
     return false;
 }
 
-bool kvm_arm_el2_supported(void)
-{
-    return false;
-}
-
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0aa2680a8e6..53aebd77bf1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -274,7 +274,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     /*
      * Ask for EL2 if supported.
      */
-    el2_supported = kvm_arm_el2_supported();
+    el2_supported = host_cpu_feature_supported(ARM_FEATURE_EL2);
     if (el2_supported) {
         init.features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
     }
@@ -1780,7 +1780,7 @@ bool host_cpu_feature_supported(enum arm_features feature)
     case ARM_FEATURE_PMU:
         return kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3);
     case ARM_FEATURE_EL2:
-        return kvm_arm_el2_supported();
+        return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2);
     case ARM_FEATURE_EL3:
         return false;
     default:
@@ -1918,7 +1918,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         cpu->kvm_init_features[0] |= (1 << KVM_ARM_VCPU_PTRAUTH_ADDRESS |
                                       1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
-    if (cpu->has_el2 && kvm_arm_el2_supported()) {
+    if (cpu->has_el2 && host_cpu_feature_supported(ARM_FEATURE_EL2)) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
     }
 
-- 
2.49.0


