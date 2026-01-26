Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC7CD19503
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 16:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkPsU-0000eS-LG; Mon, 26 Jan 2026 11:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkPsS-0000b5-BO
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 11:55:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkPsQ-0007SF-KG
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 11:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769446546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l457qV4i+POufgV6lrAfjlUcU2aOiTP2P7cDT3UPHb4=;
 b=A/qTuJObdJk+2uxur0MXgFrq2EaQhV4DdTMaUXEFrgQ7iE1eO4vWwn/PQSnsSUCla69V7C
 f6iw8Fyz1VDYtsq4eoqAQ1rHO78JwOTes3fxyt7FoyLrkoOF6EelpIGBz2WydVAoxsTPdI
 dPZOgAdx8X1umHHVnPeHHv10IJk21Dw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-aASa5VGnM1upXcZYF5hXgA-1; Mon,
 26 Jan 2026 11:55:42 -0500
X-MC-Unique: aASa5VGnM1upXcZYF5hXgA-1
X-Mimecast-MFC-AGG-ID: aASa5VGnM1upXcZYF5hXgA_1769446541
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 401371944E45; Mon, 26 Jan 2026 16:55:41 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3CFF51801AC9; Mon, 26 Jan 2026 16:55:37 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH v6 10/11] hw/arm/virt: Introduce framework to aggregate
 hidden-regs and safe-missing-regs
Date: Mon, 26 Jan 2026 17:53:09 +0100
Message-ID: <20260126165445.3033335-11-eric.auger@redhat.com>
In-Reply-To: <20260126165445.3033335-1-eric.auger@redhat.com>
References: <20260126165445.3033335-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Currently if a virt_machine_<n>_options() sets a TYPE_ARM_CPU
x-mig-hidden-regs or x-mig-safe-missing-regs array property, another
one cannot overwrite it or extend it. We end up with a core dump:

qemu-system-aarch64: can't apply global arm-cpu.x-mig-safe-missing-regs=0x603000000013c103, 0x603000000013c512, 0x603000000013c513: array size property x-mig-safe-missing-regs may not be set more than once
Aborted (core dumped)

In practice we would like an easy way to register regs that belong
to either of those categories and allow aggregation of those.

We introduce arm_virt_compat_register_safe_missing_reg() and
arm_virt_compat_register_hidden_reg() which populate GLists of
int64_t. After all virt_machine_<n>_options have been called and
have registered their regs, the GList are converted into the
associated array property value and the GlobalProperties are set.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>

---

v5 -> v6:
- move g_string_new after list length check
- collected Sebastian's R-b

v5:
- new patch
---
 include/hw/arm/virt.h | 23 ++++++++++++++
 hw/arm/virt.c         | 73 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 5907d41dbb2..d83e6f00068 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -41,6 +41,7 @@
 #include "system/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "qom/object.h"
+#include "qobject/qlist.h"
 
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
@@ -131,6 +132,8 @@ struct VirtMachineClass {
     bool no_tcg_lpa2;
     bool no_ns_el2_virt_timer_irq;
     bool no_nested_smmu;
+    QList *safe_missing_regs;
+    QList *hidden_regs;
 };
 
 struct VirtMachineState {
@@ -216,4 +219,24 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
             vms->highmem_redists) ? 2 : 1;
 }
 
+static inline void arm_virt_class_init(MachineClass *mc)
+{
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
+    vmc->safe_missing_regs = qlist_new();
+    vmc->hidden_regs = qlist_new();
+}
+
+static inline void
+arm_virt_compat_register_safe_missing_reg(VirtMachineClass *vmc, int64_t regidx)
+{
+    qlist_append_int(vmc->safe_missing_regs, regidx);
+}
+
+static inline void
+arm_virt_compat_register_hidden_reg(VirtMachineClass *vmc, int64_t regidx)
+{
+    qlist_append_int(vmc->hidden_regs, regidx);
+}
+
 #endif /* QEMU_ARM_VIRT_H */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 03d5af18f26..a01dfb7fb79 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -93,6 +93,7 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
+#include "qobject/qnum.h"
 
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
@@ -100,15 +101,18 @@ static GlobalProperty arm_virt_compat_defaults[] = {
 static const size_t arm_virt_compat_defaults_len =
     G_N_ELEMENTS(arm_virt_compat_defaults);
 
+/*
+ * Array made of x-mig-safe-missing-regs and x-mig-hidden-regs global
+ * properties. It is populated by arm_virt_aggregate_x_mig_props() that
+ * aggregates registrations respectively made with:
+ * - arm_virt_compat_register_safe_missing_reg() and
+ * - arm_virt_compat_register_hidden_reg()
+ */
+static GlobalProperty aggregated_x_mig_array_props[2];
+
 /* Register erronously exposed on 10.2 and earlier */
 #define DBGDTRTX 0x40200000200e0298
 
-static GlobalProperty arm_virt_compat_10_2[] = {
-    { TYPE_ARM_CPU, "x-mig-safe-missing-regs", stringify(DBGDTRTX)},
-};
-static const size_t arm_virt_compat_10_2_len =
-    G_N_ELEMENTS(arm_virt_compat_10_2);
-
 /*
  * This cannot be called from the virt_machine_class_init() because
  * TYPE_VIRT_MACHINE is abstract and mc->compat_props g_ptr_array_new()
@@ -120,14 +124,67 @@ static void arm_virt_compat_default_set(MachineClass *mc)
                      arm_virt_compat_defaults_len);
 }
 
+static char *get_prop_value_from_reg_qlist(QList *l)
+{
+    size_t size = qlist_size(l);
+    QListEntry *item;
+    GString *s;
+    int i = 0;
+    QNum *qi;
+
+    if (!size) {
+        return NULL;
+    }
+
+    s = g_string_new("");
+
+    QLIST_FOREACH_ENTRY(l, item) {
+        qi = qobject_to(QNum, qlist_entry_obj(item));
+        int64_t regidx;
+
+        qnum_get_try_int(qi, &regidx);
+        if (i++ > 0) {
+            g_string_append(s, ", ");
+        }
+        g_string_append_printf(s, "%" G_GINT64_FORMAT, regidx);
+    }
+    return g_string_free(s, false);
+}
+
+static void arm_virt_aggregate_x_mig_props(MachineClass *mc)
+{
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+    const char *safe_missing_regs_prop_value =
+                    get_prop_value_from_reg_qlist(vmc->safe_missing_regs);
+    const char *hidden_regs_prop_value =
+                    get_prop_value_from_reg_qlist(vmc->hidden_regs);
+    int i = 0;
+
+    if (safe_missing_regs_prop_value) {
+        aggregated_x_mig_array_props[i].driver = TYPE_ARM_CPU;
+        aggregated_x_mig_array_props[i].property = "x-mig-safe-missing-regs";
+        aggregated_x_mig_array_props[i++].value = safe_missing_regs_prop_value;
+    }
+
+    if (hidden_regs_prop_value) {
+        aggregated_x_mig_array_props[i].driver = TYPE_ARM_CPU;
+        aggregated_x_mig_array_props[i].property = "x-mig-hidden-regs";
+        aggregated_x_mig_array_props[i++].value = hidden_regs_prop_value;
+    }
+
+    compat_props_add(mc->compat_props, aggregated_x_mig_array_props, i);
+}
+
 #define DEFINE_VIRT_MACHINE_IMPL(latest, ...) \
     static void MACHINE_VER_SYM(class_init, virt, __VA_ARGS__)( \
         ObjectClass *oc, \
         const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
+        arm_virt_class_init(mc); \
         arm_virt_compat_default_set(mc); \
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
+        arm_virt_aggregate_x_mig_props(mc); \
         mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " ARM Virtual Machine"; \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
         if (latest) { \
@@ -3559,9 +3616,11 @@ DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)
 
 static void virt_machine_10_2_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_11_0_options(mc);
     compat_props_add(mc->compat_props, hw_compat_10_2, hw_compat_10_2_len);
-    compat_props_add(mc->compat_props, arm_virt_compat_10_2, arm_virt_compat_10_2_len);
+    arm_virt_compat_register_safe_missing_reg(vmc, DBGDTRTX);
 }
 DEFINE_VIRT_MACHINE(10, 2)
 
-- 
2.52.0


