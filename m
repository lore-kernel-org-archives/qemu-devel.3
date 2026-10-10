Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59C1CA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 13:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFXHY-0001vW-0F; Sat, 10 Oct 2026 09:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXHW-0001uk-Kr
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXHV-0004ai-7r
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791639512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JIONCANj+MKk7AafgcfEQAY6C/fPP7uZSDIuv7Ano6A=;
 b=RLLcjWaa6xQPsnfqvHo1zSJZqsI/8HBehd7mk6mCAAlHwRrrBsigcEmpdAOBSNUcyiTHJH
 95kUwMyRcARnfxqIsOQheXHgDJS271Z38PlIoIHQG/ktP4VopCe2EkFlOY/NNtyudGCRw6
 VcZlmZ3qwW1Fe4kNci6lrA3IhTkEbk0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-t-MKfQVdMCGq7EYO8RpJwg-1; Sat,
 10 Oct 2026 13:38:28 +0000
X-MC-Unique: t-MKfQVdMCGq7EYO8RpJwg-1
X-Mimecast-MFC-AGG-ID: t-MKfQVdMCGq7EYO8RpJwg_1791639506
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D0411956044; Sat, 10 Oct 2026 13:38:26 +0000 (UTC)
Received: from laptop.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4422230000E5; Sat, 10 Oct 2026 13:38:21 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v10 10/26] target/arm/kvm: Retrieve writable ID reg map
Date: Sat, 10 Oct 2026 15:36:14 +0200
Message-ID: <20261010133725.642498-11-eric.auger@redhat.com>
In-Reply-To: <20261010133725.642498-1-eric.auger@redhat.com>
References: <20261010133725.642498-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Cornelia Huck <cohuck@redhat.com>

Add a helper to retrieve the writable id reg bitmask.

then retrieve the writable_mask array and dispatch it in the writable_map
field of arm64_id_regs[] elements.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>

---

v9 -> v10:
- removed if (idx < 0 || idx > ARRAY_SIZE(arm64_id_regs)) check
- commit description cleanup

v7 -> v8
- added kvm_enabled()

v5 -> v6
- use arm64_id_regs[].writable_map
- squashed 2 commits (helper + user)
- removed stub
---
 target/arm/kvm.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 9d68801c26..2e68130611 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -28,6 +28,7 @@
 #include "kvm_arm.h"
 #include "cpu.h"
 #include "cpu-sysregs.h"
+#include "cpu-idregs.h"
 #include "trace.h"
 #include "internals.h"
 #include "hw/pci/pci.h"
@@ -51,6 +52,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
 static bool cap_has_mp_state;
 static bool cap_has_inject_serror_esr;
 static bool cap_has_inject_ext_dabt;
+static bool writable_map_dispatched;
 
 /**
  * ARMHostCPUFeatures: information about the host CPU (identified
@@ -312,6 +314,21 @@ static uint32_t kvm_arm_sve_get_vls(int fd)
     return vls[0] & MAKE_64BIT_MASK(0, ARM_MAX_VQ);
 }
 
+static int kvm_feature_idx_to_idregs_idx(int kidx)
+{
+    int op1, crm, op2;
+    ARMSysRegs sysreg;
+
+    op1 = kidx / 64;
+    if (op1 == 2) {
+        op1 = 3;
+    }
+    crm = (kidx % 64) / 8;
+    op2 = kidx % 8;
+    sysreg = ENCODE_ID_REG(3, op1, 0, crm, op2);
+    return get_sysreg_idx(sysreg);
+}
+
 static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     /* Identify the feature bits corresponding to the host CPU, and
@@ -523,9 +540,47 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     ahcf->features = features;
 }
 
+static int kvm_arm_get_writable_id_regs(uint64_t *idregmap)
+{
+    int cap_writable_id_regs;
+    struct reg_mask_range range = {
+        .range = KVM_ARM_FEATURE_ID_RANGE,
+        .reserved = {0},
+        .addr = (uint64_t)idregmap,
+    };
+
+    cap_writable_id_regs =
+        kvm_check_extension(kvm_state, KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES);
+
+    if (!cap_writable_id_regs ||
+        !(cap_writable_id_regs & (1 << KVM_ARM_FEATURE_ID_RANGE))) {
+        return -ENOSYS;
+    }
+
+    return kvm_vm_ioctl(kvm_state, KVM_ARM_GET_REG_WRITABLE_MASKS, &range);
+}
+
 void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
+    uint64_t *writable_map;
+
+    writable_map = g_new(uint64_t, KVM_ARM_FEATURE_ID_RANGE_SIZE);
+
+    if (kvm_enabled() && !writable_map_dispatched &&
+        !kvm_arm_get_writable_id_regs(writable_map)) {
+        for (int i = 0; i < KVM_ARM_FEATURE_ID_RANGE_SIZE; i++) {
+            uint64_t mask = writable_map[i];
+
+            if (mask) {
+                int idx = kvm_feature_idx_to_idregs_idx(i);
+
+                arm64_id_regs[idx].writable_mask = mask;
+            }
+        }
+        writable_map_dispatched = true;
+    }
+    g_free(writable_map);
 
     if (!arm_host_cpu_features.dtb_compatible) {
         kvm_arm_get_host_cpu_features(&arm_host_cpu_features);
-- 
2.53.0


