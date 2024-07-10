Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39490C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 04:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRP3u-0005o9-L3; Wed, 10 Jul 2024 00:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sRP3s-0005du-1T; Wed, 10 Jul 2024 00:36:12 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sRP3p-0006tm-OD; Wed, 10 Jul 2024 00:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720586169; x=1752122169;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4Gl90JTr0DPqZym9GzC30MAvpGMWS2nNyp9RK7fmVl8=;
 b=SpGrJ6JLZscttymiIfh9SPg68FtfKUISVEzk9lv5TYKvivBOo6P80V9S
 Gzi1gA7J8RIFuBxICK4qvV/P0tOMH9GFVCr7e3iGuG7ZLcJRxh4wVc+EA
 REe0jb1YrJZLiRFz2HJns1iAP5G9sH/RsuGVXbSQsMDvOi+E6Vx5JC4vX
 EQuY2s68VPHpL4id4ZlxvFsZlxlA/HnQfvW/97OvaV+K/L3lkw9hR8CRr
 hJf8rAYlHKrc9c5yEuKiEziQITacNzcbUm5gQ9DbPQiK8gxQcUb6jobKI
 5cRxFTarbi1BDIU29rwTbipClcYZ5lNGGysxPNkVbIK0kRyPafEn4zP+N Q==;
X-CSE-ConnectionGUID: nX4qN33cSFi0AA4n37/71A==
X-CSE-MsgGUID: E8R7l8RLRnqkwaq4IfuMdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="28473765"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; d="scan'208";a="28473765"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 21:36:01 -0700
X-CSE-ConnectionGUID: txlL5t2VTgSFRIUWInVasg==
X-CSE-MsgGUID: VaM4LmLvSeWe8mHnhi/OOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; d="scan'208";a="79238121"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 09 Jul 2024 21:35:57 -0700
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
Subject: [RFC 1/5] qapi/qom: Introduce kvm-pmu-filter object
Date: Wed, 10 Jul 2024 12:51:13 +0800
Message-Id: <20240710045117.3164577-2-zhao1.liu@intel.com>
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

Introduce the kvm-pmu-filter object and support the PMU event with raw
format.

The raw format, as a native PMU event code representation, can be used
for several architectures.

Considering that PMU event related fields are commonly used in
hexadecimal, define KVMPMURawEventVariant, KVMPMUFilterEventVariant, and
KVMPMUFilterPropertyVariant in kvm.json to support hexadecimal number
strings in JSON.

Additionally, define the corresponding numeric versions of
KVMPMURawEvent, KVMPMUFilterEvent, and KVMPMUFilterProperty in kvm.json.
This allows to handle numeric values more effectively and take advantage
of the qapi helpers.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 MAINTAINERS              |   1 +
 accel/kvm/kvm-pmu.c      | 143 +++++++++++++++++++++++++++++++++++++++
 accel/kvm/meson.build    |   1 +
 include/sysemu/kvm-pmu.h |  29 ++++++++
 qapi/kvm.json            | 119 ++++++++++++++++++++++++++++++++
 qapi/meson.build         |   1 +
 qapi/qapi-schema.json    |   1 +
 qapi/qom.json            |   3 +
 8 files changed, 298 insertions(+)
 create mode 100644 accel/kvm/kvm-pmu.c
 create mode 100644 include/sysemu/kvm-pmu.h
 create mode 100644 qapi/kvm.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 6725913c8b3a..8c36c04a3eb2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -439,6 +439,7 @@ F: accel/kvm/
 F: accel/stubs/kvm-stub.c
 F: include/hw/kvm/
 F: include/sysemu/kvm*.h
+F: qapi/kvm.json
 F: scripts/kvm/kvm_flightrecorder
 
 ARM KVM CPUs
diff --git a/accel/kvm/kvm-pmu.c b/accel/kvm/kvm-pmu.c
new file mode 100644
index 000000000000..483d1bdf4807
--- /dev/null
+++ b/accel/kvm/kvm-pmu.c
@@ -0,0 +1,143 @@
+/*
+ * QEMU KVM PMU Abstractions
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Author: Zhao Liu <zhao1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qapi/qapi-visit-kvm.h"
+#include "qemu/cutils.h"
+#include "qom/object_interfaces.h"
+#include "sysemu/kvm-pmu.h"
+
+static void kvm_pmu_filter_get_event(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    KVMPMUFilter *filter = KVM_PMU_FILTER(obj);
+    KVMPMUFilterEventList *node;
+    KVMPMUFilterEventVariantList *head = NULL;
+    KVMPMUFilterEventVariantList **tail = &head;
+
+    for (node = filter->events; node; node = node->next) {
+        KVMPMUFilterEventVariant *str_event;
+        KVMPMUFilterEvent *event = node->value;
+
+        str_event = g_new(KVMPMUFilterEventVariant, 1);
+        str_event->action = event->action;
+        str_event->format = event->format;
+
+        switch (event->format) {
+        case KVM_PMU_EVENT_FMT_RAW:
+            str_event->u.raw.code = g_strdup_printf("0x%lx",
+                                                    event->u.raw.code);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        QAPI_LIST_APPEND(tail, str_event);
+    }
+
+    visit_type_KVMPMUFilterEventVariantList(v, name, &head, errp);
+    qapi_free_KVMPMUFilterEventVariantList(head);
+}
+
+static void kvm_pmu_filter_set_event(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    KVMPMUFilter *filter = KVM_PMU_FILTER(obj);
+    KVMPMUFilterEventVariantList *list, *node;
+    KVMPMUFilterEventList *head = NULL, *old_head;
+    KVMPMUFilterEventList **tail = &head;
+    int ret, nevents = 0;
+
+    if (!visit_type_KVMPMUFilterEventVariantList(v, name, &list, errp)) {
+        return;
+    }
+
+    for (node = list; node; node = node->next) {
+        KVMPMUFilterEvent *event = g_new(KVMPMUFilterEvent, 1);
+        KVMPMUFilterEventVariant *str_event = node->value;
+
+        event->action = str_event->action;
+        event->format = str_event->format;
+
+        switch (str_event->format) {
+        case KVM_PMU_EVENT_FMT_RAW:
+            ret = qemu_strtou64(str_event->u.raw.code, NULL,
+                                0, &event->u.raw.code);
+            if (ret < 0) {
+                error_setg(errp,
+                           "Invalid %s PMU event (code: %s): %s. "
+                           "The code must be a uint64 string.",
+                           KVMPMUEventEncodeFmt_str(str_event->format),
+                           str_event->u.raw.code, strerror(-ret));
+                g_free(event);
+                goto fail;
+            }
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        nevents++;
+        QAPI_LIST_APPEND(tail, event);
+    }
+
+    old_head = filter->events;
+    filter->events = head;
+    filter->nevents = nevents;
+
+    qapi_free_KVMPMUFilterEventVariantList(list);
+    qapi_free_KVMPMUFilterEventList(old_head);
+    return;
+
+fail:
+    qapi_free_KVMPMUFilterEventList(head);
+}
+
+static void
+kvm_pmu_filter_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add(oc, "events",
+                              "KVMPMUFilterEvent",
+                              kvm_pmu_filter_get_event,
+                              kvm_pmu_filter_set_event,
+                              NULL, NULL);
+    object_class_property_set_description(oc, "events",
+                                          "KVM PMU event list");
+}
+
+static void kvm_pmu_filter_instance_init(Object *obj)
+{
+    KVMPMUFilter *filter = KVM_PMU_FILTER(obj);
+
+    filter->nevents = 0;
+}
+
+static const TypeInfo kvm_pmu_filter_info = {
+    .parent = TYPE_OBJECT,
+    .name = TYPE_KVM_PMU_FILTER,
+    .class_init = kvm_pmu_filter_class_init,
+    .instance_size = sizeof(KVMPMUFilter),
+    .instance_init = kvm_pmu_filter_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void
+kvm_pmu_event_register_type(void)
+{
+    type_register_static(&kvm_pmu_filter_info);
+}
+
+type_init(kvm_pmu_event_register_type);
diff --git a/accel/kvm/meson.build b/accel/kvm/meson.build
index 397a1fe1fd1e..dfab2854f3a8 100644
--- a/accel/kvm/meson.build
+++ b/accel/kvm/meson.build
@@ -2,6 +2,7 @@ kvm_ss = ss.source_set()
 kvm_ss.add(files(
   'kvm-all.c',
   'kvm-accel-ops.c',
+  'kvm-pmu.c',
 ))
 
 specific_ss.add_all(when: 'CONFIG_KVM', if_true: kvm_ss)
diff --git a/include/sysemu/kvm-pmu.h b/include/sysemu/kvm-pmu.h
new file mode 100644
index 000000000000..4707759761f1
--- /dev/null
+++ b/include/sysemu/kvm-pmu.h
@@ -0,0 +1,29 @@
+/*
+ * QEMU KVM PMU Abstraction Header
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Authors:
+ *  Zhao Liu <zhao1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef KVM_PMU_H
+#define KVM_PMU_H
+
+#include "qapi/qapi-types-kvm.h"
+#include "qom/object.h"
+
+#define TYPE_KVM_PMU_FILTER "kvm-pmu-filter"
+OBJECT_DECLARE_SIMPLE_TYPE(KVMPMUFilter, KVM_PMU_FILTER)
+
+struct KVMPMUFilter {
+    Object parent_obj;
+
+    uint32_t nevents;
+    KVMPMUFilterEventList *events;
+};
+
+#endif /* KVM_PMU_H */
diff --git a/qapi/kvm.json b/qapi/kvm.json
new file mode 100644
index 000000000000..0619da83c123
--- /dev/null
+++ b/qapi/kvm.json
@@ -0,0 +1,119 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+
+##
+# = KVM based feature API
+##
+
+##
+# @KVMPMUFilterAction:
+#
+# Actions that KVM PMU filter supports.
+#
+# @deny: disable the PMU event/counter in KVM PMU filter
+#
+# @allow: enable the PMU event/counter in KVM PMU filter
+#
+# Since 9.1
+##
+{ 'enum': 'KVMPMUFilterAction',
+  'prefix': 'KVM_PMU_FILTER_ACTION',
+  'data': ['allow', 'deny'] }
+
+##
+# @KVMPMUEventEncodeFmt:
+#
+# Encoding formats of PMU event that QEMU/KVM supports.
+#
+# @raw: the encoded event code that KVM can directly consume.
+#
+# Since 9.1
+##
+{ 'enum': 'KVMPMUEventEncodeFmt',
+  'prefix': 'KVM_PMU_EVENT_FMT',
+  'data': ['raw'] }
+
+##
+# @KVMPMURawEvent:
+#
+# Raw PMU event code.
+#
+# @code: the raw value that has been encoded, and QEMU could deliver
+#     to KVM directly.
+#
+# Since 9.1
+##
+{ 'struct': 'KVMPMURawEvent',
+  'data': { 'code': 'uint64' } }
+
+##
+# @KVMPMUFilterEvent:
+#
+# PMU event filtered by KVM.
+#
+# @action: action that KVM PMU filter will take.
+#
+# @format: PMU event format.
+#
+# Since 9.1
+##
+{ 'union': 'KVMPMUFilterEvent',
+  'base': { 'action': 'KVMPMUFilterAction',
+            'format': 'KVMPMUEventEncodeFmt' },
+  'discriminator': 'format',
+  'data': { 'raw': 'KVMPMURawEvent' } }
+
+##
+# @KVMPMUFilterProperty:
+#
+# Property of KVM PMU Filter.
+#
+# @events: the KVMPMUFilterEvent list.
+#
+# Since 9.1
+##
+{ 'struct': 'KVMPMUFilterProperty',
+  'data': { '*events': ['KVMPMUFilterEvent'] } }
+
+##
+# @KVMPMURawEventVariant:
+#
+# The variant of KVMPMURawEvent with the string, rather than the
+# numeric value.
+#
+# @code: the raw value that has been encoded, and QEMU could deliver
+#     to KVM directly.  This field is a uint64 string.
+#
+# Since 9.1
+##
+{ 'struct': 'KVMPMURawEventVariant',
+  'data': { 'code': 'str' } }
+
+##
+# @KVMPMUFilterEventVariant:
+#
+# The variant of KVMPMUFilterEvent.
+#
+# @action: action that KVM PMU filter will take.
+#
+# @format: PMU event format.
+#
+# Since 9.1
+##
+{ 'union': 'KVMPMUFilterEventVariant',
+  'base': { 'action': 'KVMPMUFilterAction',
+            'format': 'KVMPMUEventEncodeFmt' },
+  'discriminator': 'format',
+  'data': { 'raw': 'KVMPMURawEventVariant' } }
+
+##
+# @KVMPMUFilterPropertyVariant:
+#
+# The variant of KVMPMUFilterProperty.
+#
+# @events: the KVMPMUFilterEventVariant list.
+#
+# Since 9.1
+##
+{ 'struct': 'KVMPMUFilterPropertyVariant',
+  'data': { '*events': ['KVMPMUFilterEventVariant'] } }
diff --git a/qapi/meson.build b/qapi/meson.build
index e7bc54e5d047..856439c76b67 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -37,6 +37,7 @@ qapi_all_modules = [
   'error',
   'introspect',
   'job',
+  'kvm',
   'machine-common',
   'machine',
   'machine-target',
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index b1581988e4eb..742818d16e45 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -64,6 +64,7 @@
 { 'include': 'compat.json' }
 { 'include': 'control.json' }
 { 'include': 'introspect.json' }
+{ 'include': 'kvm.json' }
 { 'include': 'qom.json' }
 { 'include': 'qdev.json' }
 { 'include': 'machine-common.json' }
diff --git a/qapi/qom.json b/qapi/qom.json
index 92b0fea76cb1..40175a97b4dd 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -8,6 +8,7 @@
 { 'include': 'block-core.json' }
 { 'include': 'common.json' }
 { 'include': 'crypto.json' }
+{ 'include': 'kvm.json' }
 
 ##
 # = QEMU Object Model (QOM)
@@ -1057,6 +1058,7 @@
       'if': 'CONFIG_LINUX' },
     'iommufd',
     'iothread',
+    'kvm-pmu-filter',
     'main-loop',
     { 'name': 'memory-backend-epc',
       'if': 'CONFIG_LINUX' },
@@ -1131,6 +1133,7 @@
                                       'if': 'CONFIG_LINUX' },
       'iommufd':                    'IOMMUFDProperties',
       'iothread':                   'IothreadProperties',
+      'kvm-pmu-filter':             'KVMPMUFilterPropertyVariant',
       'main-loop':                  'MainLoopProperties',
       'memory-backend-epc':         { 'type': 'MemoryBackendEpcProperties',
                                       'if': 'CONFIG_LINUX' },
-- 
2.34.1


