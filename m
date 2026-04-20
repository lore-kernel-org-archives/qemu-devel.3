Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992F7F588DE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEpGu-000337-9G; Mon, 20 Apr 2026 10:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wEpGT-0002z4-Cp
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:06:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wEpGN-0001Mx-Ff
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776693969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2GT9RJqWPAezmRzAH3IGO5ZTeLTnQClTHnsjsx0rbWA=;
 b=G+wW7Z8KSv7QtQxjflKNkiponn9yl4JjCAr1gPP43I1L9SkAaT/ldcqvTw7MiV87KiHp3O
 pCeO0/9XVD8t095Oj90vuPid/C6OBDbGGXyevofqKHaz54dNCKEW4WLXCNqsf9WUsgtZ06
 X08palsuPQZKJ/JQNpZLAhEjn3gQ5e4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-7VcxzBEMNciAS8a8jBKShw-1; Mon,
 20 Apr 2026 10:06:06 -0400
X-MC-Unique: 7VcxzBEMNciAS8a8jBKShw-1
X-Mimecast-MFC-AGG-ID: 7VcxzBEMNciAS8a8jBKShw_1776693965
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEEB618005BE; Mon, 20 Apr 2026 14:06:04 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.74])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0EB9C180057E; Mon, 20 Apr 2026 14:06:00 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v10 1/7] target/arm/cpu: Introduce the infrastructure for
 cpreg migration tolerances
Date: Mon, 20 Apr 2026 16:03:51 +0200
Message-ID: <20260420140552.104369-2-eric.auger@redhat.com>
In-Reply-To: <20260420140552.104369-1-eric.auger@redhat.com>
References: <20260420140552.104369-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We introduce a datatype for a tolerance with respect to a given
cpreg migration issue. The tolerance applies to a given cpreg kvm index,
and can be of different types:
a) mismatch in cpreg indexes
- ToleranceNotOnBothEnds (cpreg index is allowed to be only present
  on one end)
- ToleranceOnlySrcTestValue (cpreg index is allowed to be only
  present in source if its value @mask field matches @value)
b) mismatch in cpreg values
- ToleranceDiffInMask (value differences are allowed only within a mask)
- ToleranceFieldLT (incoming field value must be less than a given value)
- ToleranceFieldGT (incoming field value must be greater than a given value)

A QLIST of such tolerances can be populated using a new helper:
arm_register_cpreg_mig_tolerance() and arm_cpu_match_cpreg_mig_tolerance()
allows to check whether a tolerance exists for a given kvm index and its
criterion is matched.

callers for those helpers will be introduced in subsequent patches.

Only registration of migration tolerances related to cpreg index
mismatch is currently allowed.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v9 -> v10
- s/CPUCPREG/CPReg
- move declarations and types to internals.h
- rework doc comments and detail tolerance types
- introduce find_mig_tolerance() according to Peter's suggestion
- added ToleranceOnlySrcTestValue

v8 -> v9
- fix the tolerance type checking
- rename arm_cpu_cpreg_has_mig_tolerance into arm_cpu_match_cpreg_mig_tolerance
---
 target/arm/cpu.h       |  1 +
 target/arm/internals.h | 54 ++++++++++++++++++++++++++++
 target/arm/cpu.c       | 82 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 657ff4ab20b..512d18652aa 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1139,6 +1139,7 @@ struct ArchCPU {
 
     QLIST_HEAD(, ARMELChangeHook) pre_el_change_hooks;
     QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
+    QLIST_HEAD(, ARMCPRegMigTolerance) cpreg_mig_tolerances;
 
     int32_t node_id; /* NUMA node this CPU belongs to */
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 85980f0e69a..fb5f11d3e7a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1933,4 +1933,58 @@ int compare_u64(const void *a, const void *b);
 /* Used in FEAT_MEC to set the MECIDWidthm1 field in the MECIDR_EL2 register. */
 #define MECID_WIDTH 16
 
+typedef enum {
+    ToleranceNotOnBothEnds,
+    ToleranceOnlySrcTestValue,
+    ToleranceDiffInMask,
+    ToleranceFieldLT,
+    ToleranceFieldGT,
+} ARMCPRegMigToleranceType;
+
+typedef struct ARMCPRegMigTolerance {
+    uint64_t kvmidx;
+    uint64_t mask;
+    uint64_t value;
+    ARMCPRegMigToleranceType type;
+    QLIST_ENTRY(ARMCPRegMigTolerance) node;
+} ARMCPRegMigTolerance;
+
+/**
+ * arm_register_cpreg_mig_tolerance:
+ * Register a migration tolerance wrt one given cpreg identified by its
+ * @kvmidx. Calling this function twice for the same @kvmidx is a
+ * programming error and will cause an assertion failure.
+ *
+ * @cpu: vcpu to apply the migration tolerance on
+ * @kvmidx: kvm index of the cpreg the tolerance applies to
+ * @mask: bitmask where a difference is tolerated
+ *        (relevant with ToleranceDiffInMask)
+ * @value: value the bitmask field is compared with
+ *        (relevant with ToleranceFieldLT and ToleranceFieldGT)
+ * @type: type of the migration tolerance:
+ * - ToleranceNotOnBothEnds (cpreg index is allowed to be only present
+ *   on one end)
+ * - ToleranceOnlySrcTestValue (cpreg index is allowed to be only
+ *   present in source if its value @mask field matches @value)
+ * - ToleranceDiffInMask (mismatch in cpreg values are only tolerated
+ *   if differences are within @mask)
+ * - ToleranceFieldLT (mismatch in cpreg values are only tolerated
+ *   if incoming @bitmask field value is less than @value)
+ * - ToleranceFieldGT (mismatch in cpreg values are only tolerated
+ *   if incoming @bitmask field value is greater than @value)
+ */
+void arm_register_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
+                                      uint64_t mask, uint64_t value,
+                                      ARMCPRegMigToleranceType type);
+
+/**
+ * arm_cpu_match_cpreg_mig_tolerance:
+ * Check whether a tolerance of type @type exists for a given @kvmidx
+ * and the tolerance criterion is satisfied
+ */
+bool arm_cpu_match_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
+                                       uint64_t vmstate_value, uint64_t local_value,
+                                       ARMCPRegMigToleranceType type);
+
+
 #endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ccc47c8a9ad..7fae97ef40b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -181,6 +181,82 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
     QLIST_INSERT_HEAD(&cpu->el_change_hooks, entry, node);
 }
 
+static ARMCPRegMigTolerance *find_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx)
+{
+    ARMCPRegMigTolerance *t;
+    QLIST_FOREACH(t, &cpu->cpreg_mig_tolerances, node) {
+        if (t->kvmidx == kvmidx)  {
+            return t;
+        }
+    }
+    return NULL;
+}
+
+void arm_register_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
+                                      uint64_t mask, uint64_t value,
+                                      ARMCPRegMigToleranceType type)
+{
+    ARMCPRegMigTolerance *entry;
+
+    /* make sure the kvmidx has not tolerance already registered */
+    assert(!find_mig_tolerance(cpu, kvmidx));
+
+    assert(type == ToleranceNotOnBothEnds ||
+           type == ToleranceOnlySrcTestValue);
+
+    entry = g_new0(ARMCPRegMigTolerance, 1);
+
+    entry->kvmidx = kvmidx;
+    entry->mask = mask;
+    entry->value = value;
+    entry->type = type;
+
+    QLIST_INSERT_HEAD(&cpu->cpreg_mig_tolerances, entry, node);
+}
+
+bool arm_cpu_match_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
+                                       uint64_t vmstate_value, uint64_t local_value,
+                                       ARMCPRegMigToleranceType type)
+{
+    ARMCPRegMigTolerance *t = find_mig_tolerance(cpu, kvmidx);
+    uint64_t diff, diff_outside_mask, field;
+
+    if (!t || t->type != type) {
+        return false;
+    }
+
+    if (type == ToleranceNotOnBothEnds) {
+        return true;
+    }
+
+    if (type == ToleranceOnlySrcTestValue &&
+        ((vmstate_value & t->mask) == t->value)) {
+        return true;
+    }
+
+    /* Need to check the mask */
+    diff = vmstate_value ^ local_value;
+    diff_outside_mask = diff & ~t->mask;
+
+    if (diff_outside_mask) {
+        /* there are differences outside of the mask */
+        return false;
+    }
+    if (type == ToleranceDiffInMask) {
+        /* differences only in the field, tolerance matched */
+        return true;
+    }
+    /* need to compare field value against authorized ones */
+    field = vmstate_value & t->mask;
+    if (type == ToleranceFieldLT && (field < t->value)) {
+        return true;
+    }
+    if (type == ToleranceFieldGT && (field > t->value)) {
+        return true;
+    }
+    return false;
+}
+
 static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
 {
     /* Reset a single ARMCPRegInfo register */
@@ -1106,6 +1182,7 @@ static void arm_cpu_initfn(Object *obj)
 
     QLIST_INIT(&cpu->pre_el_change_hooks);
     QLIST_INIT(&cpu->el_change_hooks);
+    QLIST_INIT(&cpu->cpreg_mig_tolerances);
 
 #ifdef CONFIG_USER_ONLY
 # ifdef TARGET_AARCH64
@@ -1550,6 +1627,7 @@ static void arm_cpu_finalizefn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
     ARMELChangeHook *hook, *next;
+    ARMCPRegMigTolerance *t, *n;
 
     g_hash_table_destroy(cpu->cp_regs);
 
@@ -1561,6 +1639,10 @@ static void arm_cpu_finalizefn(Object *obj)
         QLIST_REMOVE(hook, node);
         g_free(hook);
     }
+    QLIST_FOREACH_SAFE(t, &cpu->cpreg_mig_tolerances, node, n) {
+        QLIST_REMOVE(t, node);
+        g_free(t);
+    }
 #ifndef CONFIG_USER_ONLY
     if (cpu->pmu_timer) {
         timer_free(cpu->pmu_timer);
-- 
2.53.0


