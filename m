Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737BCFD8FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdiP-0005Lv-H5; Thu, 26 Feb 2026 10:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiN-0005LA-V6
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:48 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiM-0003ki-1I
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:47 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43988056dc3so1040677f8f.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121344; x=1772726144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lJhJpmRt2N+ostHQqi971o1Mv0Stne1iPkG3Ew0xXN8=;
 b=WcsGH2iT92hnLQkbyw++rPUYKax7lG/ixgGQ6EU521uVolU4579k143nW4GTCahKPs
 2QYURcxxe0E9EKMFM9fG4g0U5fd32GOBqGZg5zw/RZ+ckuICVdX6zAXP7RIcTnbdCaAE
 ESRdcJ5H9sLZCogde6OpFUaE3L9vXTXpWgi6VW/wsrxn3AwaZN4pdZ0rtZFZCLGoJ4Y7
 34YJfj/6F+OXaorqcz6DdjnVEzydr0BoGiiyu/Ckqq4wDLEog+opuKwiWjy91O0e6YBb
 zD7grxvaZghjoKbw9OuyQJJLiEZgGmiWO96J19Xcm3bBvMVsMswpZM3Ozfyc7wDemTtB
 mjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121344; x=1772726144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lJhJpmRt2N+ostHQqi971o1Mv0Stne1iPkG3Ew0xXN8=;
 b=wdCOVz+eoAGeG4mqAt9uKAY5RcqxZumxqMEYoRg1UpCnHuPut/oou5XgAsFdLGaAVE
 PFJmcvZ3ZDVhLtuUNEWWeCMDjoIO5eMS5obi+NeE/Pvz/TMgce/Axi2EPb34WdTB9Pw4
 PiOe9n1k0CBPic2muMtKc6Gags1pJDNIuueoerNId3WUHo11p5V87+OmGuOSZHGfnGa5
 e/tN2uDJ9qPY3z92BUlArfDa/rhCYrt2GPo+jFBwcaJ4zKYG7ghGyd53T+VLSEcvbFkF
 pYviNTx+7BGMEOCWYqD/ZGrxkH6H15L1TFaoUXIjhAEHygDSjWU9Qm9I6S1gD4x4bl0O
 RsRQ==
X-Gm-Message-State: AOJu0YwJ711ukxQ6iWNRzU+5Wm90h+DLiKRCN1j5SpS7EHOCanFIHlsC
 xa9osBtLjhj+bMSWtwcCBPdqy+3xhun3B2HBSiruTYjv+CYbPSx4k+/qydkMxvQIGaug2GPgTp1
 Ly7h5
X-Gm-Gg: ATEYQzy1w2Q6uObs4XPL+jwGWIchXaOC3EGE2elZKP3AA1Fp50vUzjvQEf8vbFcdy4p
 Y+U82ae6aIBoeyVa3X6hHGfv6My1yGiwEeqY0n8M0J3AdyWA7nAE5tFzS3vxCpSWSC8V297nvCQ
 tYWNSVDuSZKhzNqBAl90f3IhYId+YnyIMHwyeZDmFewUqQNBTLuwNpdEo9w+lUm7yN2Ll57OgSb
 1R79Zw4tdNC9F2ah9izxKkGAr7dWIQa0EI6O0twceCrAMTzh6sc/8YtxrDoj4zWCp99dcjg7tQn
 FqGzIrxHpu/4bRy78Q4LewhjWHgylBIWhLVmKbVWd3vx1ug6+ufqOmM8YLpnSOTru6++CZGb9+o
 ItqL4iK+b9yo06C92aooJrcfDVXvQ/QxenLoQzK4ACR1HX+iy22aFLR2XzNOiXjRbphwn+1l9tx
 KCrEwhFLTp1q41DCAAnCHRQt7Y6cGmuNkzBXl7AIzkFpA4Cy4kkQqmqpg6/7eKsQBsWo+jDZ26K
 7yvgXSrWRrwUUkAuaEOKQRKgZPsxMw=
X-Received: by 2002:a5d:5f43:0:b0:436:d9b:cd02 with SMTP id
 ffacd0b85a97d-43997e65811mr5012169f8f.0.1772121344116; 
 Thu, 26 Feb 2026 07:55:44 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/20] target/arm/kvm: add kvm-psci-version vcpu property
Date: Thu, 26 Feb 2026 15:55:21 +0000
Message-ID: <20260226155535.1171290-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Sebastian Ott <sebott@redhat.com>

Provide a kvm specific vcpu property to override the default
(as of kernel v6.13 that would be PSCI v1.3) PSCI version emulated
by kvm. Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3

Note: in order to support PSCI v0.1 we need to drop vcpu
initialization with KVM_CAP_ARM_PSCI_0_2 in that case.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Message-id: 20260220115656.4831-2-sebott@redhat.com
[PMM: adjust sscanf to not permit negative numbers]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/cpu-features.rst | 11 ++++++++
 target/arm/cpu.c                 |  8 +++++-
 target/arm/kvm.c                 | 48 ++++++++++++++++++++++++++++++--
 3 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 3db1f19401..ce19ae6a04 100644
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
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 10f8280eef..60f391651d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1144,7 +1144,13 @@ static void arm_cpu_initfn(Object *obj)
      * picky DTB consumer will also provide a helpful error message.
      */
     cpu->dtb_compatible = "qemu,unknown";
-    cpu->psci_version = QEMU_PSCI_VERSION_0_1; /* By default assume PSCI v0.1 */
+    if (!kvm_enabled()) {
+        /* By default KVM will use the newest PSCI version that it knows about.
+         * This can be changed using the kvm-psci-version property.
+         * For others assume PSCI v0.1 by default.
+         */
+        cpu->psci_version = QEMU_PSCI_VERSION_0_1;
+    }
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
 
     if (tcg_enabled() || hvf_enabled()) {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ded582e0da..c46ee9620b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -485,6 +485,28 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
     ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
 }
 
+static char *kvm_get_psci_version(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    return g_strdup_printf("%d.%d",
+                           (int) PSCI_VERSION_MAJOR(cpu->psci_version),
+                           (int) PSCI_VERSION_MINOR(cpu->psci_version));
+}
+
+static void kvm_set_psci_version(Object *obj, const char *value, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint16_t maj, min;
+
+    if (sscanf(value, "%hu.%hu", &maj, &min) != 2) {
+        error_setg(errp, "Invalid PSCI version.");
+        return;
+    }
+
+    cpu->psci_version = PSCI_VERSION(maj, min);
+}
+
 /* KVM VCPU properties should be prefixed with "kvm-". */
 void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
 {
@@ -506,6 +528,12 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
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
@@ -1976,8 +2004,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (cs->start_powered_off) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_POWER_OFF;
     }
-    if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
-        cpu->psci_version = QEMU_PSCI_VERSION_0_2;
+    if (cpu->psci_version != QEMU_PSCI_VERSION_0_1 &&
+        kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
+        /*
+         * Versions >= v0.2 are backward compatible with v0.2
+         * omit the feature flag for v0.1 .
+         */
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PSCI_0_2;
     }
     if (!arm_feature(env, ARM_FEATURE_AARCH64)) {
@@ -2015,6 +2047,18 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
+    if (cpu->psci_version) {
+        psciver = cpu->psci_version;
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
2.43.0


