Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7C7C38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 04:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRP49-0006jn-0S; Wed, 10 Jul 2024 00:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sRP47-0006ff-VX; Wed, 10 Jul 2024 00:36:27 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sRP45-0006xI-QK; Wed, 10 Jul 2024 00:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720586185; x=1752122185;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6+OseQGpk2ndz6OpN+ZaTOVJXSOpCJ52+KKHCCTwnuA=;
 b=fEf07K3rDEjO3+QbK2QZRZU3+3TkCpoNz6384TLwVIKjgJGsfYW0z9y9
 96YYHez1ye7ZjAWAq2QJE73K7ojD4lFxAGE3wkSo2wPoG76SDvAhG3kiJ
 kkITkx9OiDEtaF5nkHV7IPj8OfGN/ofpsKTWa9hdU9qJX4tzp7Gogwe7R
 u2/swzXb7of+Vpy03bE72p9PNBVtnbfJZXOZ2zrp2PUvxk5MzEVFMmuKJ
 KsFhaVA2XDaG2wPDToNHyDQrIG7avoVwXc7v9K+h5ZM/VJEXXcjYPSwF+
 UCvB3VUz8d1emTldxZDHrCqk/UibVhqdYqg3CLNZAlPE0zmwMz+jy33gA g==;
X-CSE-ConnectionGUID: BsgYmSPJSmC0Ok+1o24E2A==
X-CSE-MsgGUID: OFDDy1qjQB6QYdiTjms+0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="28473826"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; d="scan'208";a="28473826"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 21:36:24 -0700
X-CSE-ConnectionGUID: Po2f5o8xT3y+ievXVp6YYg==
X-CSE-MsgGUID: LAxQ+A8ZQT+k+mRhg5v6ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; d="scan'208";a="79238239"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 09 Jul 2024 21:36:18 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>, Shaoqin Huang <shahuang@redhat.com>,
 Eric Auger <eauger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Yuan Yao <yuan.yao@intel.com>, Xiong Zhang <xiong.y.zhang@intel.com>,
 Mingwei Zhang <mizhang@google.com>, Jim Mattson <jmattson@google.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 5/5] i386/kvm: Support fixed counter in KVM PMU filter
Date: Wed, 10 Jul 2024 12:51:17 +0800
Message-Id: <20240710045117.3164577-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710045117.3164577-1-zhao1.liu@intel.com>
References: <20240710045117.3164577-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

KVM_SET_PMU_EVENT_FILTER of x86 KVM allows user to configure x86 fixed
function counters by a bitmap.

Add the support of x86-fixed-counter in kvm-pmu-filter object and handle
this in i386 kvm codes.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 accel/kvm/kvm-pmu.c      | 71 ++++++++++++++++++++++++++++++++++++++++
 include/sysemu/kvm-pmu.h |  1 +
 qapi/kvm.json            | 36 +++++++++++++++++++-
 target/i386/kvm/kvm.c    | 69 +++++++++++++++++++++++++-------------
 4 files changed, 153 insertions(+), 24 deletions(-)

diff --git a/accel/kvm/kvm-pmu.c b/accel/kvm/kvm-pmu.c
index 7a1720c68f8f..bad76482f426 100644
--- a/accel/kvm/kvm-pmu.c
+++ b/accel/kvm/kvm-pmu.c
@@ -256,6 +256,68 @@ fail:
     qapi_free_KVMPMUFilterEventList(head);
 }
 
+static void
+kvm_pmu_filter_get_fixed_counter(Object *obj, Visitor *v, const char *name,
+                                 void *opaque, Error **errp)
+{
+    KVMPMUFilter *filter = KVM_PMU_FILTER(obj);
+    KVMPMUX86FixedCounterVariant *str_counter;
+
+    str_counter = g_new(KVMPMUX86FixedCounterVariant, 1);
+    str_counter->action = filter->x86_fixed_counter->action;
+    str_counter->bitmap = g_strdup_printf("0x%x",
+                                          filter->x86_fixed_counter->bitmap);
+
+    visit_type_KVMPMUX86FixedCounterVariant(v, name, &str_counter, errp);
+    qapi_free_KVMPMUX86FixedCounterVariant(str_counter);
+}
+
+static void
+kvm_pmu_filter_set_fixed_counter(Object *obj, Visitor *v, const char *name,
+                                 void *opaque, Error **errp)
+{
+    KVMPMUFilter *filter = KVM_PMU_FILTER(obj);
+    KVMPMUX86FixedCounterVariant *str_counter;
+    KVMPMUX86FixedCounter *new_counter, *old_counter;
+    uint64_t bitmap;
+    int ret;
+
+    old_counter = filter->x86_fixed_counter;
+    if (!visit_type_KVMPMUX86FixedCounterVariant(v, name,
+                                                 &str_counter, errp)) {
+        return;
+    }
+
+    new_counter  = g_new(KVMPMUX86FixedCounter, 1);
+    new_counter->action = str_counter->action;
+
+    ret = qemu_strtou64(str_counter->bitmap, NULL,
+                        0, &bitmap);
+    if (ret < 0) {
+        error_setg(errp,
+                   "Invalid x86 fixed counter (bitmap: %s): %s. "
+                   "The bitmap must be a uint32 string.",
+                   str_counter->bitmap, strerror(-ret));
+        g_free(new_counter);
+        goto fail;
+    }
+    if (bitmap > UINT32_MAX) {
+        error_setg(errp,
+                   "Invalid x86 fixed counter (bitmap: %s): "
+                   "Numerical result out of range. "
+                   "The bitmap must be a uint32 string.",
+                   str_counter->bitmap);
+        g_free(new_counter);
+        goto fail;
+    }
+    new_counter->bitmap = bitmap;
+    filter->x86_fixed_counter = new_counter;
+    qapi_free_KVMPMUX86FixedCounter(old_counter);
+
+fail:
+    qapi_free_KVMPMUX86FixedCounterVariant(str_counter);
+}
+
 static void
 kvm_pmu_filter_class_init(ObjectClass *oc, void *data)
 {
@@ -266,6 +328,15 @@ kvm_pmu_filter_class_init(ObjectClass *oc, void *data)
                               NULL, NULL);
     object_class_property_set_description(oc, "events",
                                           "KVM PMU event list");
+
+    object_class_property_add(oc, "x86-fixed-counter",
+                              "KVMPMUX86FixedCounter",
+                              kvm_pmu_filter_get_fixed_counter,
+                              kvm_pmu_filter_set_fixed_counter,
+                              NULL, NULL);
+    object_class_property_set_description(oc, "x86-fixed-counter",
+                                          "Enablement bitmap of "
+                                          "x86 PMU fixed counter");
 }
 
 static void kvm_pmu_filter_instance_init(Object *obj)
diff --git a/include/sysemu/kvm-pmu.h b/include/sysemu/kvm-pmu.h
index 707f33d604fd..e74a6a665565 100644
--- a/include/sysemu/kvm-pmu.h
+++ b/include/sysemu/kvm-pmu.h
@@ -24,6 +24,7 @@ struct KVMPMUFilter {
 
     uint32_t nevents;
     KVMPMUFilterEventList *events;
+    KVMPMUX86FixedCounter *x86_fixed_counter;
 };
 
 /*
diff --git a/qapi/kvm.json b/qapi/kvm.json
index f4e8854fa6c6..fe9a9ec940be 100644
--- a/qapi/kvm.json
+++ b/qapi/kvm.json
@@ -123,6 +123,21 @@
             'x86-default': 'KVMPMUX86DefalutEvent',
             'x86-masked-entry': 'KVMPMUX86MaskedEntry' } }
 
+##
+# @KVMPMUX86FixedCounter:
+#
+# x86 fixed counter that KVM PMU filter supports.
+#
+# @action: action that KVM PMU filter will take.
+#
+# @bitmap: x86 fixed counter bitmap.
+#
+# Since 9.1
+##
+{ 'struct': 'KVMPMUX86FixedCounter',
+  'data': { 'action': 'KVMPMUFilterAction',
+            'bitmap': 'uint32' } }
+
 ##
 # @KVMPMUFilterProperty:
 #
@@ -208,6 +223,22 @@
             'x86-default': 'KVMPMUX86DefalutEventVariant',
             'x86-masked-entry': 'KVMPMUX86MaskedEntryVariant' } }
 
+##
+# @KVMPMUX86FixedCounterVariant:
+#
+# The variant of KVMPMUX86FixedCounter with the string, rather than
+# the numeric value.
+#
+# @action: action that KVM PMU filter will take.
+#
+# @bitmap: x86 fixed counter bitmap.  This field is a uint32 string.
+#
+# Since 9.1
+##
+{ 'struct': 'KVMPMUX86FixedCounterVariant',
+  'data': { 'action': 'KVMPMUFilterAction',
+            'bitmap': 'str' } }
+
 ##
 # @KVMPMUFilterPropertyVariant:
 #
@@ -215,7 +246,10 @@
 #
 # @events: the KVMPMUFilterEventVariant list.
 #
+# @x86-fixed-counter: enablement bitmap of x86 fixed counters.
+#
 # Since 9.1
 ##
 { 'struct': 'KVMPMUFilterPropertyVariant',
-  'data': { '*events': ['KVMPMUFilterEventVariant'] } }
+  'data': { '*events': ['KVMPMUFilterEventVariant'],
+            '*x86-fixed-counter': 'KVMPMUX86FixedCounterVariant' } }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 396a93efe745..b350c4123ea2 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5419,6 +5419,7 @@ static bool kvm_install_pmu_event_filter(KVMState *s)
 {
     struct kvm_pmu_event_filter *kvm_filter;
     KVMPMUFilter *filter = s->pmu_filter;
+    KVMPMUFilterAction action;
     int ret;
 
     kvm_filter = g_malloc0(sizeof(struct kvm_pmu_event_filter) +
@@ -5426,9 +5427,14 @@ static bool kvm_install_pmu_event_filter(KVMState *s)
 
     /*
      * Currently, kvm-pmu-filter only supports configuring the same
-     * action for PMU events.
+     * action for PMU fixed-counters/events.
      */
-    switch (filter->events->value->action) {
+    if (filter->x86_fixed_counter) {
+        action = filter->x86_fixed_counter->action;
+    } else {
+        action = filter->events->value->action;
+    }
+    switch (action) {
     case KVM_PMU_FILTER_ACTION_ALLOW:
         kvm_filter->action = KVM_PMU_EVENT_ALLOW;
         break;
@@ -5439,23 +5445,29 @@ static bool kvm_install_pmu_event_filter(KVMState *s)
         g_assert_not_reached();
     }
 
-    /*
-     * The check in kvm_arch_check_pmu_filter() ensures masked entry
-     * format won't be mixed with other formats.
-     */
-    kvm_filter->flags = filter->events->value->format ==
-                        KVM_PMU_EVENT_FMT_X86_MASKED_ENTRY ?
-                        KVM_PMU_EVENT_FLAG_MASKED_EVENTS : 0;
-
-    if (kvm_filter->flags == KVM_PMU_EVENT_FLAG_MASKED_EVENTS &&
-        !kvm_vm_check_extension(s, KVM_CAP_PMU_EVENT_MASKED_EVENTS)) {
-        error_report("Masked entry format of PMU event "
-                     "is not supported by Host.");
-        goto fail;
+    if (filter->x86_fixed_counter) {
+        kvm_filter->fixed_counter_bitmap = filter->x86_fixed_counter->bitmap;
     }
 
-    if (!kvm_config_pmu_event(filter, kvm_filter)) {
-        goto fail;
+    if (filter->nevents) {
+        /*
+         * The check in kvm_arch_check_pmu_filter() ensures masked entry
+         * format won't be mixed with other formats.
+         */
+        kvm_filter->flags = filter->events->value->format ==
+                            KVM_PMU_EVENT_FMT_X86_MASKED_ENTRY ?
+                            KVM_PMU_EVENT_FLAG_MASKED_EVENTS : 0;
+
+        if (kvm_filter->flags == KVM_PMU_EVENT_FLAG_MASKED_EVENTS &&
+            !kvm_vm_check_extension(s, KVM_CAP_PMU_EVENT_MASKED_EVENTS)) {
+            error_report("Masked entry format of PMU event "
+                         "is not supported by Host.");
+            goto fail;
+        }
+
+        if (!kvm_config_pmu_event(filter, kvm_filter)) {
+            goto fail;
+        }
     }
 
     ret = kvm_vm_ioctl(s, KVM_SET_PMU_EVENT_FILTER, kvm_filter);
@@ -6088,17 +6100,24 @@ static void kvm_arch_check_pmu_filter(const Object *obj, const char *name,
     KVMPMUFilterAction action;
     uint32_t base_flag;
 
-    if (!filter->nevents) {
+    if (!filter->x86_fixed_counter && !filter->nevents) {
         error_setg(errp,
                    "Empty KVM PMU filter.");
         return;
     }
 
     /* Pick the first event's flag as the base one. */
-    base_flag = events->value->format ==
-                KVM_PMU_EVENT_FMT_X86_MASKED_ENTRY ?
-                KVM_PMU_EVENT_FLAG_MASKED_EVENTS : 0;
+    base_flag = 0;
+    if (filter->nevents &&
+        events->value->format == KVM_PMU_EVENT_FMT_X86_MASKED_ENTRY) {
+        base_flag = KVM_PMU_EVENT_FLAG_MASKED_EVENTS;
+    }
+
     action = KVM_PMU_FILTER_ACTION__MAX;
+    if (filter->x86_fixed_counter) {
+        action = filter->x86_fixed_counter->action;
+    }
+
     while (events) {
         KVMPMUFilterEvent *event = events->value;
         uint32_t flag;
@@ -6128,9 +6147,13 @@ static void kvm_arch_check_pmu_filter(const Object *obj, const char *name,
         if (action == KVM_PMU_FILTER_ACTION__MAX) {
             action = event->action;
         } else if (action != event->action) {
-            /* TODO: Support events with different actions if necessary. */
+            /*
+             * TODO: Support fixed-counters/events with different actions
+             * if necessary.
+             */
             error_setg(errp,
-                       "Only support PMU events with the same action");
+                       "Only support PMU fixed-counters/events "
+                       "with the same action");
             return;
         }
 
-- 
2.34.1


