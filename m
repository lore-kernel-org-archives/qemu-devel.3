Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC263E9E31B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 15:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCBK-0007LL-PM; Wed, 11 Feb 2026 10:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vqCBH-0007KE-41
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:31:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vqCBF-0008BB-DV
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770823864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KgZLxYej2+Jm/2mAtMCoJI/wRP+Se5cFtNVR14mJ03o=;
 b=DhANDHcRXKNAhk1zfPyKPsBAVJN+dj5Y1b2l+JLcy7wTmTr9tBFywwKzmLE+RwsReP3Vo+
 +yJUrW51LAbujNfZgRQxIh1BFDgRsN2/jPK2R0zpKthPcx/pFJzfaBRct4bBJY9WD7ks0U
 l+ngbRNG3nYvi99F10kbsq8B9WZr1uY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-zcy5oeLQND-MeMkzb8lSxg-1; Wed, 11 Feb 2026 10:31:03 -0500
X-MC-Unique: zcy5oeLQND-MeMkzb8lSxg-1
X-Mimecast-MFC-AGG-ID: zcy5oeLQND-MeMkzb8lSxg_1770823862
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4801c1056c7so13181185e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 07:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770823862; x=1771428662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KgZLxYej2+Jm/2mAtMCoJI/wRP+Se5cFtNVR14mJ03o=;
 b=qxNSZeMy2Xa+snOgS1c+/Ne31i7lbW/YnPv93gZ7IWPWClQtSoIrg1juy0reSNS0o4
 +WIff21KjqQ9mgX+h5PNVFTtiirsoFufnphEmzNtfc5VMDIQj1tPQZGF8hcPy4aKtJCm
 8/xl7gdsQviKDM8fjsUrGk+lUTXZYhObZMqjYIl46ITVO/FfK9qG5QFPHrsmevIpc+zl
 yPHi2Gv8Xu8a3G3jtSao7686sLvzxV5pGYHxAsnMIsDi8UXnlh3NVDEYF/f5Cqz7Jbm7
 b0DcLSpJiKMmiPhfPnmqI01PeWiwaU3xH1xXf3xeY9CDsLpb6CKo31GtbXGqFC1tt8d9
 zFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770823862; x=1771428662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KgZLxYej2+Jm/2mAtMCoJI/wRP+Se5cFtNVR14mJ03o=;
 b=K3CcSda8FVV963jxywHCPz5CqUFXzUBJhIFtcEThFtHp3o9cyWoEQNBP2wF4roZ3Ai
 R8LBfXP7r1aCCID4mOwySIvms1jGhbMFfPCBPu7eLqau+7Dzo5KEVc8wRyNI/0sIUUhQ
 WpBzdHo9NOTx3r0t9b4GF7yHAUqHps3hqae2YJMAIzNcIq6G47eU+FYKqisZEfO1+VCp
 lRa/zK7q70J/cGZEIjWlJ0sSsJXZKOJIjnwudMCEHaP9qJU5FWHlpXXZDDz/XAZbOLNt
 UZ0Jgwlpol/QRFRJTD1AcDXrzcbxORdAxZy+MF6ZBo600nZF7TpbBaAczcR/dkNgu+2J
 6/pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGR4pn8SZuUzmuf5RE8k+HucIczMGeZW18DPhrMvQyOA+VFrGpkduxytW7n4D4cJH+rDV78cv3LKOH@nongnu.org
X-Gm-Message-State: AOJu0YylzJ7Ko2a/pNFQ+qGvY9zzdjxcR4/ceDS57YqqBy5jLC6bIJ95
 rFwUCOgJIQiTCtfDZfb05QSA6cSzXxy+Cyt3fdazekHQzskGLm66d6oE3ledpj/+3ivzA+TEHct
 pGflwoHVVQV6xQv2Ms/afyODybqZq3X8SKU2DE1zevk7XuIoEP96YHBbB
X-Gm-Gg: AZuq6aJ+6L9m1ImUOu17AFdFwBDkgZYpMA0387UkRN1RJrYMLXewe15NembctsTgzXQ
 rw9WmV0bQM94oHtfdC00vt1sCUhNL7Ygtq52/cR4uEr/PkdzzOnhUboS/6XbUpW2eCZ7ceuQaxS
 8Xxihp6m7FqkqlJKs3jWDUOgB6cfYeBRGa7Jj5xJHed1x7IBcLPJW/HXL3PNT5fsRIwVNltjWue
 dLvcFKnoHYcwL9Z+Wy0a3HkAlr9N9K6zW+2EG1Gmhke8ZAB+qoGq8vHOpHLbuP8StMp7Gi2PKIV
 x2s1tRFECN6GvdRRNlmNZDSz1wmHpEwxl8Luz8OrjNLx0y5lkPBryFoRBruIsNycdVrrkTzzDSl
 ltHO08GWPSviEfpTUxWhFl87lCosQ0eG1JQjPN3cMepu3MMJZuqTx8456BvTtUqIk9J28QRgA91
 xJ4NoOQt1N
X-Received: by 2002:a05:600c:c16d:b0:480:4a90:1b00 with SMTP id
 5b1f17b1804b1-4832021605bmr226049955e9.20.1770823861888; 
 Wed, 11 Feb 2026 07:31:01 -0800 (PST)
X-Received: by 2002:a05:600c:c16d:b0:480:4a90:1b00 with SMTP id
 5b1f17b1804b1-4832021605bmr226049465e9.20.1770823861415; 
 Wed, 11 Feb 2026 07:31:01 -0800 (PST)
Received: from rh.fritz.box
 (p200300f6af2d8700b4c2d356c3fafe63.dip0.t-ipconnect.de.
 [2003:f6:af2d:8700:b4c2:d356:c3fa:fe63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783d34657sm6448511f8f.6.2026.02.11.07.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 07:31:00 -0800 (PST)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v5 2/2] target/arm/kvm: add kvm-psci-version vcpu property
Date: Wed, 11 Feb 2026 16:30:32 +0100
Message-ID: <20260211153032.19327-3-sebott@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211153032.19327-1-sebott@redhat.com>
References: <20260211153032.19327-1-sebott@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Provide a kvm specific vcpu property to override the default
(as of kernel v6.13 that would be PSCI v1.3) PSCI version emulated
by kvm. Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3

Note: in order to support PSCI v0.1 we need to drop vcpu
initialization with KVM_CAP_ARM_PSCI_0_2 in that case.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 docs/system/arm/cpu-features.rst | 11 ++++++
 target/arm/cpu.h                 |  6 +++
 target/arm/kvm.c                 | 65 +++++++++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 37d5dfd15b..50b106f2eb 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -204,6 +204,17 @@ the list of KVM VCPU features and their descriptions.
   the guest scheduler behavior and/or be exposed to the guest
   userspace.
 
+``kvm-psci-version``
+  Set the Power State Coordination Interface (PSCI) firmware ABI version
+  that KVM provides to the guest. By default KVM will use the newest
+  version that it knows about (which is PSCI v1.3 in Linux v6.13).
+
+  You only need to set this if you want to be able to migrate this
+  VM to a host machine running an older kernel that does not
+  recognize the PSCI version that this host's kernel defaults to.
+
+  Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3.
+
 TCG VCPU Features
 =================
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e146f7e6c4..d3cfd444e8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1036,6 +1036,12 @@ struct ArchCPU {
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
index ded582e0da..6d13cb4f3c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -485,6 +485,46 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
     ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
 }
 
+typedef struct PSCIVersion {
+    uint32_t number;
+    const char *str;
+} PSCIVersion;
+
+static const PSCIVersion psci_versions[] = {
+    { QEMU_PSCI_VERSION_0_1, "0.1" },
+    { QEMU_PSCI_VERSION_0_2, "0.2" },
+    { QEMU_PSCI_VERSION_1_0, "1.0" },
+    { QEMU_PSCI_VERSION_1_1, "1.1" },
+    { QEMU_PSCI_VERSION_1_2, "1.2" },
+    { QEMU_PSCI_VERSION_1_3, "1.3" },
+};
+
+static char *kvm_get_psci_version(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    for (int i = 0; i < ARRAY_SIZE(psci_versions); i++) {
+        if (psci_versions[i].number == cpu->psci_version)
+            return g_strdup(psci_versions[i].str);
+    }
+
+    return g_strdup_printf("Unknown PSCI-version: %x", cpu->psci_version);
+}
+
+static void kvm_set_psci_version(Object *obj, const char *value, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    for (int i = 0; i < ARRAY_SIZE(psci_versions); i++) {
+        if (!strcmp(value, psci_versions[i].str)) {
+            cpu->kvm_prop_psci_version = psci_versions[i].number;
+            return;
+        }
+    }
+
+    error_setg(errp, "Invalid PSCI version.");
+}
+
 /* KVM VCPU properties should be prefixed with "kvm-". */
 void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
 {
@@ -506,6 +546,12 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
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
@@ -1976,7 +2022,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
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
@@ -2015,6 +2066,18 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
+    if (cpu->kvm_prop_psci_version) {
+        psciver = cpu->kvm_prop_psci_version;
+        ret = kvm_set_one_reg(cs, KVM_REG_ARM_PSCI_VERSION, &psciver);
+        if (ret) {
+            error_report("KVM in this kernel does not support PSCI version %d.%d",
+                         (int) PSCI_VERSION_MAJOR(psciver),
+                         (int) PSCI_VERSION_MINOR(psciver));
+            error_printf("Consider setting the kvm-psci-version property on the "
+                         "migration source.\n");
+            return ret;
+        }
+    }
     /*
      * KVM reports the exact PSCI version it is implementing via a
      * special sysreg. If it is present, use its contents to determine
-- 
2.52.0


