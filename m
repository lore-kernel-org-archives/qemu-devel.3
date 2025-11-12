Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD0FCD343E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 18:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJFMX-0004hx-Oe; Wed, 12 Nov 2025 13:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vJFME-0003Cg-Qz
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 13:14:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vJFMC-0006na-7m
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 13:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762971251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvPCq7VyEuzcNyp7CnFoOXZYmZVPIQ6yNur1I1qze6g=;
 b=G8EBYSWny7SrnRKq17R5Cwkvly/oXS3NnvHnRfg6vwnc2oEKKGKaty/FWc0GZDEjnbKD+/
 PgR/qVgsdn4YgLV4mRC3CHvLJulZXcBX4c7YP31Tq9WoexkHF3R935Bi0VRqAS0toEkKQh
 LFD0JTH/T/1OPG4v/CDhxMOc+TktDuM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-aY0XA6oROea03uq1vgZlFQ-1; Wed, 12 Nov 2025 13:14:10 -0500
X-MC-Unique: aY0XA6oROea03uq1vgZlFQ-1
X-Mimecast-MFC-AGG-ID: aY0XA6oROea03uq1vgZlFQ_1762971249
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4773e108333so50615e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 10:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762971249; x=1763576049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvPCq7VyEuzcNyp7CnFoOXZYmZVPIQ6yNur1I1qze6g=;
 b=TjOvT02VXePLHvHnm/rN0kDNi4KIJWfS05PG0NuyC67REQT4FDyhul1yV90knGokeh
 Z7r93bKiQhUe1xxn0VtCEqlhZmdPmREg5L5YoClfMFJhhsP8HOCH0uWDiT+FhhA2LAhh
 Zb8KTfPSgJWx7iK65vYBd3HFXGBxq3GqnrKgoblYZiZ/ofeup2lDgHAVQu3yvTYVcDM1
 4v5+6dpIwQ9uCMFZ0v2cIyEW5ryN+sAIduYuf1dtSLo9jaDuF3RSf/HG5M5pLt7vQFnF
 A9/PW//pJ2My/2S4MrHVtUOuBtD8o9+xmpZ67+ZB/O5E0MlUg9goKyVkAYT0qnKTfezz
 Wgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762971249; x=1763576049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tvPCq7VyEuzcNyp7CnFoOXZYmZVPIQ6yNur1I1qze6g=;
 b=tdviPgV9s6/sKA/COpulHA4q/ctxCNzKm9/++GrSNrtd/B2u/6k7R86y+VrqXqOtEH
 RKczcAUY/EQO38ULIygEQwM4c4FYa8wnqfHlV0sM5tA4LkUJYrhl1OZxacNzSR0kDuH2
 2/n2ds4af2bS8Y+nHxTrPrYze9yTjgkuhg4uNr772JwX2bsolAGUX5mGYrhHijuPhTIO
 BmN4h18wf325BzY0gM23vaUtI8akt7RAunJmthBi0ohkO8QhQ8G1MXEiFeO93diIYeU8
 gwMynhCuRcGL6b97tS/4wOGaHLXxq2JjbBlsBxXYlKWzSDNkmeDs9g8zX1ry+/92oK1t
 9c6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcq4wVOarjrAI/L9q2Lt4CgRbHgZwcE4llDvsMx5VgXqtIgSqXzPLCLakoUiDCuO2g7BIcr1vvJyue@nongnu.org
X-Gm-Message-State: AOJu0Yx+nWzGrI/3g9Ne1rqQ6vck8A6sKWjmD0weJfOlNN0CpOzod7MX
 5QD0O/pnHyBXSEEcq0/oWyX45FV6z8RZpKngwBLdvdRh9kHUvGVe+xbcXuS+29rEvRCbRV/xDhc
 7XY8X2rBUrhAXHVH7jEneUtJx7yTdJ49gvn5VZH/BPi+jtU6AW5Hds6M5
X-Gm-Gg: ASbGncvoVgUKN02DVHjbJOP7lfNyRBrGYthhQgUw8lBQ27mFWL83+9CwRy64tgRMqDY
 JlNn/9NLl/qMN+Z2TDpaNHqgnlwUu8lSXah8hdWVLIvklnc+PF5pADc8qJRH/m5HXU6uLtvDlMY
 HDJolIv11ruWiHBmn+sAtqTgk6i/jZUOjtWrkgktF+nZmhkOUB4T6GgpH90QGt6h2FAoUyIyI6H
 tEtSe/O2BuzOMr98CF7asSaKclInuwWEFcqufncXfkyBIhEO63u3D/5X81sC82rO8mjitl0IDSu
 WO2AftE//pKfcwvfHVk4v2beUBJbXSiHX20OFtgCGK8MnaIH6PgXBUBHeI7XfvTD4+4dIYN75oB
 NFJCg/IjTBMYfLS1bXWQ90Z3jtZMf5UmUjkx5/NpFxLhD3LZt41+9RkWUTqNzOw==
X-Received: by 2002:a05:600c:6305:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-4778704c87amr36369905e9.10.1762971248734; 
 Wed, 12 Nov 2025 10:14:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOtRuApVaSJzjluxq/syrI6PaRRaNwBA+5BiNbfifiB+oERbEdmvKrC/cBX/JWi/+NkctM3Q==
X-Received: by 2002:a05:600c:6305:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-4778704c87amr36369595e9.10.1762971248323; 
 Wed, 12 Nov 2025 10:14:08 -0800 (PST)
Received: from rh.fritz.box
 (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de.
 [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e51e49sm46851355e9.7.2025.11.12.10.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 10:14:07 -0800 (PST)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v3 2/2] target/arm/kvm: add kvm-psci-version vcpu property
Date: Wed, 12 Nov 2025 19:13:57 +0100
Message-ID: <20251112181357.38999-3-sebott@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112181357.38999-1-sebott@redhat.com>
References: <20251112181357.38999-1-sebott@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 39f2b2e54d..c2032070b7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -981,6 +981,12 @@ struct ArchCPU {
      */
     uint32_t psci_version;
 
+    /*
+     * Intermediate value used during property parsing.
+     * Once finalized, the value should be read from psci_version.
+     */
+    uint32_t prop_psci_version;
+
     /* Current power state, access guarded by BQL */
     ARMPSCIState power_state;
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0d57081e69..e91b1abfb8 100644
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
+            cpu->prop_psci_version = ver->number;
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
+    if (cpu->prop_psci_version != QEMU_PSCI_VERSION_0_1 &&
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
 
+    if (cpu->prop_psci_version) {
+        psciver = cpu->prop_psci_version;
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


