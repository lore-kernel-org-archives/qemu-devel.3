Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182BBCEE334
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 16:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLOHY-0002gC-6M; Tue, 18 Nov 2025 11:10:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vLOH2-0002Xl-AK
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:09:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vLOGy-0004bx-4T
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763482179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mgVxzz5OS1LoXUR03jmz8qhB1FTWcW/VwHPGDd3+MG0=;
 b=N5aFEDuAMBvAbdySQw0Aglvow+6SLAONBkC207c3RbfclR5pfgO//4v17SecnmtBpwHDxI
 8IXv+K/xQOrj0jJV7y72rdlIkFgAs9bQ68kJ2gqv/z0HNloe4Tjoic/dZHPzemDDnB+W/E
 CQG4Qlz23LNEfMhyGdnszQzK3v+/7Y0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-PAOybZ_TNz6ux7snaZjr4A-1; Tue,
 18 Nov 2025 11:09:38 -0500
X-MC-Unique: PAOybZ_TNz6ux7snaZjr4A-1
X-Mimecast-MFC-AGG-ID: PAOybZ_TNz6ux7snaZjr4A_1763482175
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F786191B4CD; Tue, 18 Nov 2025 16:09:35 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDB0819560B0; Tue, 18 Nov 2025 16:09:30 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH v2 1/8] target/arm/machine: Improve traces on register
 mismatch during migration
Date: Tue, 18 Nov 2025 17:07:31 +0100
Message-ID: <20251118160920.554809-2-eric.auger@redhat.com>
In-Reply-To: <20251118160920.554809-1-eric.auger@redhat.com>
References: <20251118160920.554809-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

Currently when the number of KVM registers exposed by the source is
larger than the one exposed on the destination, the migration fails
with: "failed to load cpu:cpreg_vmstate_array_len"

This gives no information about which registers are causing the trouble.

This patch rework the target/arm/machine code so that it becomes
able to handle an input stream with a larger set of registers than
the destination and print useful information about which registers
are causing the trouble. The migration outcome is unchanged:
- unexpected registers still will fail the migration
- missing ones are printed but will not fail the migration, as done today.

The input stream can contain MAX_CPREG_VMSTATE_ANOMALIES(10) extra
registers compared to what exists on the target.

If there are more registers we will still hit the previous
"load cpu:cpreg_vmstate_array_len" error.

At most, MAX_CPREG_VMSTATE_ANOMALIES missing registers
and MAX_CPREG_VMSTATE_ANOMALIES unexpected registers are printed.

Example:

qemu-system-aarch64: kvm_arm_cpu_post_load Missing register in input stream: 0 0x6030000000160003 fw feat reg 3
qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 0 0x603000000013c103 op0:3 op1:0 crn:2 crm:0 op2:3
qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 1 0x603000000013c512 op0:3 op1:0 crn:10 crm:2 op2:2
qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 2 0x603000000013c513 op0:3 op1:0 crn:10 crm:2 op2:3
qemu-system-aarch64: error while loading state for instance 0x0 of device 'cpu'
qemu-system-aarch64: load of migration failed: Operation not permitted

With TCG there no user friendly formatting of the faulting
register indexes as with KVM. However the 2 added trace points
help to identify the culprint indexes.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- fixed some type in the commit msg
---
 target/arm/cpu.h        |  6 +++++
 target/arm/kvm.c        | 23 ++++++++++++++++
 target/arm/machine.c    | 58 ++++++++++++++++++++++++++++++++++++-----
 target/arm/trace-events |  7 +++++
 4 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 39f2b2e54d..077b0cce5b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -938,6 +938,12 @@ struct ArchCPU {
     uint64_t *cpreg_vmstate_values;
     int32_t cpreg_vmstate_array_len;
 
+    #define MAX_CPREG_VMSTATE_ANOMALIES 10
+    uint64_t cpreg_vmstate_missing_indexes[MAX_CPREG_VMSTATE_ANOMALIES];
+    int32_t cpreg_vmstate_missing_indexes_array_len;
+    uint64_t cpreg_vmstate_unexpected_indexes[MAX_CPREG_VMSTATE_ANOMALIES];
+    int32_t cpreg_vmstate_unexpected_indexes_array_len;
+
     DynamicGDBFeatureInfo dyn_sysreg_feature;
     DynamicGDBFeatureInfo dyn_svereg_feature;
     DynamicGDBFeatureInfo dyn_smereg_feature;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0d57081e69..58c6075a9e 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1023,6 +1023,29 @@ void kvm_arm_cpu_pre_save(ARMCPU *cpu)
 
 bool kvm_arm_cpu_post_load(ARMCPU *cpu)
 {
+    int i;
+
+    for (i = 0; i < cpu->cpreg_vmstate_missing_indexes_array_len; i++) {
+        gchar *name;
+
+        name = kvm_print_register_name(cpu->cpreg_vmstate_missing_indexes[i]);
+        trace_kvm_arm_cpu_post_load_missing_reg(name);
+        g_free(name);
+    }
+
+    for (i = 0; i < cpu->cpreg_vmstate_unexpected_indexes_array_len; i++) {
+        gchar *name;
+
+        name = kvm_print_register_name(cpu->cpreg_vmstate_unexpected_indexes[i]);
+        error_report("%s Unexpected register in input stream: %i 0x%"PRIx64" %s",
+                     __func__, i, cpu->cpreg_vmstate_unexpected_indexes[i], name);
+        g_free(name);
+    }
+    /* Fail the migration if we detect unexpected registers */
+    if (cpu->cpreg_vmstate_unexpected_indexes_array_len) {
+        return false;
+    }
+
     if (!write_list_to_kvmstate(cpu, KVM_PUT_FULL_STATE)) {
         return false;
     }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 0befdb0b28..f06a920aba 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -10,6 +10,7 @@
 #include "migration/vmstate.h"
 #include "target/arm/gtimer.h"
 #include "hw/arm/machines-qom.h"
+#include "trace.h"
 
 static bool vfp_needed(void *opaque)
 {
@@ -990,7 +991,13 @@ static int cpu_pre_load(void *opaque)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
+    int arraylen = cpu->cpreg_vmstate_array_len + MAX_CPREG_VMSTATE_ANOMALIES;
 
+    cpu->cpreg_vmstate_indexes = g_renew(uint64_t, cpu->cpreg_vmstate_indexes,
+                                         arraylen);
+    cpu->cpreg_vmstate_values = g_renew(uint64_t, cpu->cpreg_vmstate_values,
+                                        arraylen);
+    cpu->cpreg_vmstate_array_len = arraylen;
     /*
      * In an inbound migration where on the source FPSCR/FPSR/FPCR are 0,
      * there will be no fpcr_fpsr subsection so we won't call vfp_set_fpcr()
@@ -1023,7 +1030,7 @@ static int cpu_post_load(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
-    int i, v;
+    int i = 0, j = 0, k = 0, v = 0;
 
     /*
      * Handle migration compatibility from old QEMU which didn't
@@ -1051,27 +1058,66 @@ static int cpu_post_load(void *opaque, int version_id)
      * entries with the right slots in our own values array.
      */
 
-    for (i = 0, v = 0; i < cpu->cpreg_array_len
-             && v < cpu->cpreg_vmstate_array_len; i++) {
+    trace_cpu_post_load_len(cpu->cpreg_array_len, cpu->cpreg_vmstate_array_len);
+    for (; i < cpu->cpreg_array_len && v < cpu->cpreg_vmstate_array_len;) {
+        trace_cpu_post_load(i, v , cpu->cpreg_indexes[i]);
         if (cpu->cpreg_vmstate_indexes[v] > cpu->cpreg_indexes[i]) {
             /* register in our list but not incoming : skip it */
+            trace_cpu_post_load_missing(i, cpu->cpreg_indexes[i], v);
+            if (j < MAX_CPREG_VMSTATE_ANOMALIES) {
+                cpu->cpreg_vmstate_missing_indexes[j++] = cpu->cpreg_indexes[i];
+            }
+            i++;
             continue;
         }
         if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
-            /* register in their list but not ours: fail migration */
-            return -1;
+            /* register in their list but not ours: those will fail migration */
+            trace_cpu_post_load_unexpected(v, cpu->cpreg_vmstate_indexes[v], i);
+            if (k < MAX_CPREG_VMSTATE_ANOMALIES) {
+                cpu->cpreg_vmstate_unexpected_indexes[k++] =
+                    cpu->cpreg_vmstate_indexes[v];
+            }
+            v++;
+            continue;
         }
         /* matching register, copy the value over */
         cpu->cpreg_values[i] = cpu->cpreg_vmstate_values[v];
         v++;
+        i++;
     }
+    /*
+     * if we have reached the end of the incoming array but there are
+     * still regs in cpreg, continue parsing the regs which are missing
+     * in the input stream
+     */
+    for ( ; i < cpu->cpreg_array_len; i++) {
+        if (j < MAX_CPREG_VMSTATE_ANOMALIES) {
+            trace_cpu_post_load_missing(i, cpu->cpreg_indexes[i], v);
+            cpu->cpreg_vmstate_missing_indexes[j++] = cpu->cpreg_indexes[i];
+        }
+    }
+    /*
+     * if we have reached the end of the cpreg array but there are
+     * still regs in the input stream, continue parsing the vmstate array
+     */
+    for ( ; v < cpu->cpreg_vmstate_array_len; v++) {
+        if (k < MAX_CPREG_VMSTATE_ANOMALIES) {
+            trace_cpu_post_load_unexpected(v, cpu->cpreg_vmstate_indexes[v], i);
+            cpu->cpreg_vmstate_unexpected_indexes[k++] =
+                cpu->cpreg_vmstate_indexes[v];
+        }
+    }
+
+    cpu->cpreg_vmstate_missing_indexes_array_len = j;
+    cpu->cpreg_vmstate_unexpected_indexes_array_len = k;
 
     if (kvm_enabled()) {
         if (!kvm_arm_cpu_post_load(cpu)) {
             return -1;
         }
     } else {
-        if (!write_list_to_cpustate(cpu)) {
+        if (cpu->cpreg_vmstate_unexpected_indexes_array_len ||
+            !write_list_to_cpustate(cpu)) {
             return -1;
         }
     }
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 676d29fe51..0a5ed3e69d 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -13,6 +13,7 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 
 # kvm.c
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
+kvm_arm_cpu_post_load_missing_reg(char *name) "Missing register in input stream: %s"
 
 # cpu.c
 arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64
@@ -26,3 +27,9 @@ arm_powerctl_reset_cpu(uint64_t mp_aff) "cpu %" PRIu64
 
 # tcg/psci.c and hvf/hvf.c
 arm_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpuid=0x%x"
+
+# machine.c
+cpu_post_load_len(int cpreg_array_len, int cpreg_vmstate_array_len) "cpreg_array_len=%d cpreg_vmstate_array_len=%d"
+cpu_post_load(int i, int v, uint64_t regidx) "i=%d v=%d regidx=0x%"PRIx64
+cpu_post_load_missing(int i, uint64_t regidx, int v) "missing register in input stream: i=%d index=0x%"PRIx64" (v=%d)"
+cpu_post_load_unexpected(int v, uint64_t regidx, int i) "unexpected register in input stream: v=%d index=0x%"PRIx64" (i=%d)"
-- 
2.51.1


