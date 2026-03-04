Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435EBEB7EB9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 10:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxjNj-00071g-AI; Wed, 04 Mar 2026 05:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxjNh-000715-QN
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:23:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxjNg-0002Yw-8I
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772619783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tjDePk4O5jsmiS5YlsrbMZa3ikgYLa6l2ZH7uJr9dag=;
 b=bRNMnhdn/BAJV6CnQwJ3ZaFqSR9J/sdhFVwjIy6q7Qr7fkFhSv59o+FeZJB4i/QrRn8u+f
 Q9olFRCHWJO0KHFoiFqvaAVcmD8WuoH+9cTbY1n47umNwlg8xaLXu++j3HRv7tVzN3Xg8A
 nDVvyGv4fuydXDcKRZBSWOYuwMNVWfU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-Ng5cNs6gOgSy5vzOLz8uvQ-1; Wed,
 04 Mar 2026 05:23:00 -0500
X-MC-Unique: Ng5cNs6gOgSy5vzOLz8uvQ-1
X-Mimecast-MFC-AGG-ID: Ng5cNs6gOgSy5vzOLz8uvQ_1772619779
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1973E19560A3; Wed,  4 Mar 2026 10:22:59 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.89])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A3E41958DC2; Wed,  4 Mar 2026 10:22:55 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v8 1/6] target/arm/cpu: Introduce the infrastructure for cpreg
 migration tolerances
Date: Wed,  4 Mar 2026 11:22:05 +0100
Message-ID: <20260304102249.1963784-2-eric.auger@redhat.com>
In-Reply-To: <20260304102249.1963784-1-eric.auger@redhat.com>
References: <20260304102249.1963784-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
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

We introduce a datatype for a tolerance with respect to a given
cpreg migration issue. The tolerance applies to a given cpreg kvm index,
and can be of different types:
- ToleranceNotOnBothEnds (cpreg index is allowed to be only on one end)
- ToleranceDiffInMask (value differences are allowed only within a mask)
- ToleranceFieldLT (incoming field value must be less than a given value)
- ToleranceFieldGT (incoming field value must be greater than a given value)

A QLIST of such tolerances can be populated using a new helper:
arm_register_cpreg_mig_tolerance() and arm_cpu_cpreg_has_mig_tolerance()
allows to check whether a tolerance exists for a given kvm index.

callers for those helpers will be introduced in subsequent patches.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/cpu.h | 32 +++++++++++++++++++++
 target/arm/cpu.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 657ff4ab20b..9dcc838f611 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -843,6 +843,21 @@ struct ARMELChangeHook {
     QLIST_ENTRY(ARMELChangeHook) node;
 };
 
+typedef enum {
+    ToleranceNotOnBothEnds,
+    ToleranceDiffInMask,
+    ToleranceFieldLT,
+    ToleranceFieldGT,
+} ARMCPUCPREGMigToleranceType;
+
+typedef struct ARMCPUCPREGMigTolerance {
+    uint64_t kvmidx;
+    uint64_t mask;
+    uint64_t value;
+    ARMCPUCPREGMigToleranceType type;
+    QLIST_ENTRY(ARMCPUCPREGMigTolerance) node;
+} ARMCPUCPREGMigTolerance;
+
 /* These values map onto the return values for
  * QEMU_PSCI_0_2_FN_AFFINITY_INFO */
 typedef enum ARMPSCIState {
@@ -1139,6 +1154,7 @@ struct ArchCPU {
 
     QLIST_HEAD(, ARMELChangeHook) pre_el_change_hooks;
     QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
+    QLIST_HEAD(, ARMCPUCPREGMigTolerance) cpreg_mig_tolerances;
 
     int32_t node_id; /* NUMA node this CPU belongs to */
 
@@ -2632,6 +2648,22 @@ void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
 void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook, void
         *opaque);
 
+/**
+ * arm_register_cpreg_mig_tolerance:
+ * Register a migration tolerance wrt one given cpreg identified by its
+ * @kvmidx. Only one tolerance can be registered by kvm reg idx.
+ */
+void arm_register_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
+                                      uint64_t mask, uint64_t value,
+                                      ARMCPUCPREGMigToleranceType type);
+
+/**
+ * arm_cpu_cpreg_has_mig_tolerance:
+ * Check whether a tolerance of type @type exists for a given @kvmidx
+ */
+bool arm_cpu_cpreg_has_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
+                                     uint64_t vmstate_value, uint64_t local_value,
+                                     ARMCPUCPREGMigToleranceType type);
 /**
  * arm_rebuild_hflags:
  * Rebuild the cached TBFLAGS for arbitrary changed processor state.
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7e3e84b4bbb..1c499d1b15c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -181,6 +181,75 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
     QLIST_INSERT_HEAD(&cpu->el_change_hooks, entry, node);
 }
 
+void arm_register_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
+                                      uint64_t mask, uint64_t value,
+                                      ARMCPUCPREGMigToleranceType type)
+{
+    ARMCPUCPREGMigTolerance *t, *entry;
+
+    /* make sure the kvmidx has not tolerance already registered */
+    QLIST_FOREACH(t, &cpu->cpreg_mig_tolerances, node) {
+        if (t->kvmidx == kvmidx) {
+            g_assert_not_reached();
+        }
+    }
+    entry = g_new0(ARMCPUCPREGMigTolerance, 1);
+
+    entry->kvmidx = kvmidx;
+    entry->mask = mask;
+    entry->value = value;
+    entry->type = type;
+
+    QLIST_INSERT_HEAD(&cpu->cpreg_mig_tolerances, entry, node);
+}
+
+bool arm_cpu_cpreg_has_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
+                                     uint64_t vmstate_value, uint64_t local_value,
+                                     ARMCPUCPREGMigToleranceType type)
+{
+    ARMCPUCPREGMigTolerance *t;
+    uint64_t diff, diff_outside_mask, field;
+    bool found = false;
+
+    QLIST_FOREACH(t, &cpu->cpreg_mig_tolerances, node) {
+        if (t->kvmidx == kvmidx)  {
+            found = true;
+            break;
+        }
+    }
+    if (!found) {
+        return false;
+    }
+
+    /* we found one tolerance associated to the @kvmidx */
+
+    if (type == ToleranceNotOnBothEnds) {
+        return true;
+    }
+
+    /* Need to check mask */
+    diff = vmstate_value ^ local_value;
+    diff_outside_mask = diff & ~t->mask;
+
+    if (diff_outside_mask) {
+        /* there are differences outside of the mask */
+        return false;
+    }
+    if (type == ToleranceDiffInMask) {
+        /* differences only in the field, tolerance granted */
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
@@ -1106,6 +1175,7 @@ static void arm_cpu_initfn(Object *obj)
 
     QLIST_INIT(&cpu->pre_el_change_hooks);
     QLIST_INIT(&cpu->el_change_hooks);
+    QLIST_INIT(&cpu->cpreg_mig_tolerances);
 
 #ifdef CONFIG_USER_ONLY
 # ifdef TARGET_AARCH64
@@ -1550,6 +1620,7 @@ static void arm_cpu_finalizefn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
     ARMELChangeHook *hook, *next;
+    ARMCPUCPREGMigTolerance *t, *n;
 
     g_hash_table_destroy(cpu->cp_regs);
 
@@ -1561,6 +1632,10 @@ static void arm_cpu_finalizefn(Object *obj)
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


