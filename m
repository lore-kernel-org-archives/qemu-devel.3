Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF47D11705
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQSyJ-0007sb-Ua; Tue, 02 Dec 2025 11:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vQSw7-0004xE-Tp
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:09:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vQSw5-00006t-5c
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764691743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1r6iwMV7OOxfpGBTEnAoro8MxvDg/dbyx+KBPvZFR2o=;
 b=idnEYckdC3HQqhJ0nNg7XZRDT5A8v8FaHHI4Y5JQPN0Tkq5gf3dG3asRAEaU8lIsRCtUut
 UtNfMtTDTuhdp2P601WmFGHi2EX+aC+23RyylV7lq58eJ7xZOlwOJvegZMawbtOIILU4zl
 HX9RTO87/B4ubJKuWwVQ0KTIHZE4m18=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-g2VbC5d6OSq7BJZfF8iWSQ-1; Tue, 02 Dec 2025 11:09:02 -0500
X-MC-Unique: g2VbC5d6OSq7BJZfF8iWSQ-1
X-Mimecast-MFC-AGG-ID: g2VbC5d6OSq7BJZfF8iWSQ_1764691741
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42e2d105358so1898329f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 08:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764691741; x=1765296541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1r6iwMV7OOxfpGBTEnAoro8MxvDg/dbyx+KBPvZFR2o=;
 b=Gy7z1XyJaMNvy7Rd3hkw5uY9fsSZ+dzeNiCQkKF7ajzb/3WBylKpyq+68P7668Bv8L
 OWodLS9KLoofAJMUeBRcNsQy/7vlE94Kw5civx0/AzecAZRHUerP3fPEom7czltntjvC
 DsGwXgMOe1p33jOw1JONjQfs+9Uf+Ffj+Wg0KzJkFgbgE9PcOFVTgqVdYvK4vyTq2Quo
 fmox8vQCnJSJImMkyHOWBiiIKJ5H2feZgeAN0os2DWmmcL7UMXD/zB6OhOGWuCMJkkBA
 iTuGDoDcNHgR33UBbnMgoKKeuhP/lMNomvZm3dPtXKA0WU30sXFS1DvnIyRXNKo+2jtD
 LSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764691741; x=1765296541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1r6iwMV7OOxfpGBTEnAoro8MxvDg/dbyx+KBPvZFR2o=;
 b=On0aFt5o/ir9hVmopt0isbAvPDtZoeBoxeMhy/IcGkd5pVT2lH1AYhgsPcbSLuSLg3
 1q7a9HMaLCJll0Gsxt4lqVXH4c3Eifo9UavsT+B+EE0/A29fPlTBBr+cLF3Fj8sEO2S4
 CGXEaG0U+M+tkVCMYWJJqMVjJOuifbK9/yNNLCBfE+EwlhGqc73q4pMrMgCoEdj8ojVU
 NKKR8yfSpjbEndR5h59wpBG79K59HNnrTXsgzgo/x9iAI14Kwn82f+Wy5/BhTE7B8Hdh
 3uJXyxSNVzRHNY4B6dcJFrZ8qoL/zdJIv75E2nAU5LlQP9LR3JDtCsh5ahZt9gENDQKV
 NzWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv/kUYvcS0HorLPOTqC6nlYzYkCHme0RgOZZrklbV0/zpuKI1YMbBuqyTUUtaF/UK0eOfQOWXj8VwE@nongnu.org
X-Gm-Message-State: AOJu0YxvkdATQBfORgXjRMoGZR7Le/gftjKgUB/PoUKoO9HjOObpipEa
 0ut0Bqg0gTVI7siftuH+kpGZoDricAwWmQNDjHnBHaY4I6O6fKo1yIkgZsEy29h30yM2MD01q7D
 nGViNPdPeQV8OV+xQXE2EYJvC1OSFtlJBX7nahuCmvfHRr6vG1e/gg4qP
X-Gm-Gg: ASbGncvmQ3G/vyhX00roNjb7Ox/owD8NDdaurlYhzyMvDsrzLKm3BGZvRHKtuQYEFMs
 HCOeuvdOrJLf5TnVVvRVjSA/wNxauD+l3UGsDQeFQBuoxNypSTJDWsiJlsnP021bt0VUWUFamS3
 tYYwpBYQ7sF3pyPf+bMzjsitJPetaCTnHFYxtB29BakkBX6bYTKN4VG1eGLIGoqsH8sWG7sbqSS
 PFga44Lvt3taBXnjZolBKTrpH5mjZBF5zpp7jxmvNwdp1uAd4Q2LHJnG9LYDAqEjG38qGR63mtl
 n0ggrb9nju/ma/GPXo/6WwnbXfx4M+t4sGjej+VpfUIVPOCQ+lIj6DpV1DQhNCao21dA2oX5anH
 +jSwtn4Eate782/80ik+3h3RM+kerWoikvqG9vAC+xHKWc8r0PJ6SlDeXhrXHtRTrj6e7g65Q
X-Received: by 2002:a5d:584d:0:b0:42b:3592:1b82 with SMTP id
 ffacd0b85a97d-42cc1ac9c76mr46078124f8f.1.1764691740739; 
 Tue, 02 Dec 2025 08:09:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5eHkIz8G/4NXCExVWJEsXbaVN2WN77R5ZJZIrxOxxmaTtp/wopCTKYSwO8GkK2AKblszQOg==
X-Received: by 2002:a5d:584d:0:b0:42b:3592:1b82 with SMTP id
 ffacd0b85a97d-42cc1ac9c76mr46078089f8f.1.1764691740199; 
 Tue, 02 Dec 2025 08:09:00 -0800 (PST)
Received: from rh.redhat.com
 (p200300f6af35a800883b071bf1f3e4b6.dip0.t-ipconnect.de.
 [2003:f6:af35:a800:883b:71b:f1f3:e4b6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1caa767dsm34300899f8f.38.2025.12.02.08.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 08:08:59 -0800 (PST)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v4 2/2] target/arm/kvm: add kvm-psci-version vcpu property
Date: Tue,  2 Dec 2025 17:08:53 +0100
Message-ID: <20251202160853.22560-3-sebott@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251202160853.22560-1-sebott@redhat.com>
References: <20251202160853.22560-1-sebott@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Provide a kvm specific vcpu property to override the default
(as of kernel v6.13 that would be PSCI v1.3) PSCI version emulated
by kvm. Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3

Note: in order to support PSCI v0.1 we need to drop vcpu
initialization with KVM_CAP_ARM_PSCI_0_2 in that case.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 docs/system/arm/cpu-features.rst |  5 +++
 target/arm/cpu.h                 |  6 +++
 target/arm/kvm.c                 | 64 +++++++++++++++++++++++++++++++-
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 37d5dfd15b..1d32ce0fee 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -204,6 +204,11 @@ the list of KVM VCPU features and their descriptions.
   the guest scheduler behavior and/or be exposed to the guest
   userspace.
 
+``kvm-psci-version``
+  Override the default (as of kernel v6.13 that would be PSCI v1.3)
+  PSCI version emulated by the kernel. Current valid values are:
+  0.1, 0.2, 1.0, 1.1, 1.2, and 1.3
+
 TCG VCPU Features
 =================
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 39f2b2e54d..e2b6b587ea 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1035,6 +1035,12 @@ struct ArchCPU {
     bool kvm_vtime_dirty;
     uint64_t kvm_vtime;
 
+    /*
+     * Intermediate value used during property parsing.
+     * Once finalized, the value should be read from psci_version.
+     */
+    uint32_t kvm_prop_psci_version;
+
     /* KVM steal time */
     OnOffAuto kvm_steal_time;
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0d57081e69..cf2de87287 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -484,6 +484,49 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
     ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
 }
 
+struct psci_version {
+    uint32_t number;
+    const char *str;
+};
+
+static const struct psci_version psci_versions[] = {
+    { QEMU_PSCI_VERSION_0_1, "0.1" },
+    { QEMU_PSCI_VERSION_0_2, "0.2" },
+    { QEMU_PSCI_VERSION_1_0, "1.0" },
+    { QEMU_PSCI_VERSION_1_1, "1.1" },
+    { QEMU_PSCI_VERSION_1_2, "1.2" },
+    { QEMU_PSCI_VERSION_1_3, "1.3" },
+    { -1, NULL },
+};
+
+static char *kvm_get_psci_version(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    const struct psci_version *ver;
+
+    for (ver = psci_versions; ver->number != -1; ver++) {
+        if (ver->number == cpu->psci_version)
+            return g_strdup(ver->str);
+    }
+
+    return g_strdup_printf("Unknown PSCI-version: %x", cpu->psci_version);
+}
+
+static void kvm_set_psci_version(Object *obj, const char *value, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    const struct psci_version *ver;
+
+    for (ver = psci_versions; ver->number != -1; ver++) {
+        if (!strcmp(value, ver->str)) {
+            cpu->kvm_prop_psci_version = ver->number;
+            return;
+        }
+    }
+
+    error_setg(errp, "Invalid PSCI-version value");
+}
+
 /* KVM VCPU properties should be prefixed with "kvm-". */
 void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
 {
@@ -505,6 +548,12 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
                              kvm_steal_time_set);
     object_property_set_description(obj, "kvm-steal-time",
                                     "Set off to disable KVM steal time.");
+
+    object_property_add_str(obj, "kvm-psci-version", kvm_get_psci_version,
+                            kvm_set_psci_version);
+    object_property_set_description(obj, "kvm-psci-version",
+                                    "Set PSCI version. "
+                                    "Valid values are 0.1, 0.2, 1.0, 1.1, 1.2, 1.3");
 }
 
 bool kvm_arm_pmu_supported(void)
@@ -1959,7 +2008,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (cs->start_powered_off) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_POWER_OFF;
     }
-    if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
+    if (cpu->kvm_prop_psci_version != QEMU_PSCI_VERSION_0_1 &&
+        kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
+        /*
+         * Versions >= v0.2 are backward compatible with v0.2
+         * omit the feature flag for v0.1 .
+         */
         cpu->psci_version = QEMU_PSCI_VERSION_0_2;
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PSCI_0_2;
     }
@@ -1998,6 +2052,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
+    if (cpu->kvm_prop_psci_version) {
+        psciver = cpu->kvm_prop_psci_version;
+        ret = kvm_set_one_reg(cs, KVM_REG_ARM_PSCI_VERSION, &psciver);
+        if (ret) {
+            error_report("PSCI version %"PRIx64" is not supported by KVM", psciver);
+            return ret;
+        }
+    }
     /*
      * KVM reports the exact PSCI version it is implementing via a
      * special sysreg. If it is present, use its contents to determine
-- 
2.42.0


