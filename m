Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3181C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 08:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taWNW-0002u8-LF; Wed, 22 Jan 2025 03:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taWNS-0002sT-Tg; Wed, 22 Jan 2025 03:46:22 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taWNP-0002y5-IF; Wed, 22 Jan 2025 03:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737535579; x=1769071579;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VMFyzU7rJ0ERY+XN36rgAcSEcfJLdF/jbMtrra/GTKA=;
 b=QNQsjGDijegatLLY46/MZMbH6MeFf3kYNjVizZuOJXC5IMjmUxqVfF9z
 +og0QgyM5FT6G4WBc9FPJcRSZ9v9Gqhqx8IBN1nj6JBrLq2LA7xOMwHdp
 DX1jZd8QhwQyklss+eRkX82tqyU3dr+Mf8PDpOJR1OnaBDw3DUJtWzLK2
 FV8Fzt38R9wvL6HXVhJv0UOFgJoRV6gZ7IbCPT/MkobHhljBg4CMbba2H
 ESUW0JArJ8Oyy0W9UdsNkYOXfPlHwB9Dy3cXQ0zdTK2Cwy2CGyM5MtpZB
 eaq+trml6V9V4q1GQUuKXeifvntIr7mQpGOdPVjzfnM/DkhLijxFqpY2j A==;
X-CSE-ConnectionGUID: Tlai2ovITheoaExyZsUnBA==
X-CSE-MsgGUID: NkhN/9+hQ+2mkI8X3orfRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="60451561"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; d="scan'208";a="60451561"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 00:46:17 -0800
X-CSE-ConnectionGUID: fA1qO0UsTNWEBq4maCd8bQ==
X-CSE-MsgGUID: bO2kWi3pSM6t8TGjTKIFOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="112049753"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 00:46:13 -0800
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
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 2/5] i386/kvm: Support basic KVM PMU filter
Date: Wed, 22 Jan 2025 17:05:14 +0800
Message-Id: <20250122090517.294083-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122090517.294083-1-zhao1.liu@intel.com>
References: <20250122090517.294083-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Filter PMU events with raw format in i386 code.

For i386, raw format indicates that the PMU event code is already
encoded according to the KVM ioctl requirements, and can be delivered
directly to KVM without additional encoding work.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Stop check whether per-event actions are the same, as "action" has
   been a global parameter. (Dapeng)
 * Make pmu filter related functions return int in
   target/i386/kvm/kvm.c.
---
 include/system/kvm_int.h |   2 +
 target/i386/kvm/kvm.c    | 123 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 4de6106869b0..743fed29b17b 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -17,6 +17,7 @@
 #include "hw/boards.h"
 #include "hw/i386/topology.h"
 #include "io/channel-socket.h"
+#include "system/kvm-pmu.h"
 
 typedef struct KVMSlot
 {
@@ -166,6 +167,7 @@ struct KVMState
     uint16_t xen_gnttab_max_frames;
     uint16_t xen_evtchn_max_pirq;
     char *device;
+    KVMPMUFilter *pmu_filter;
 };
 
 void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6c749d4ee812..b82adbed50f4 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -34,6 +34,7 @@
 #include "system/system.h"
 #include "system/hw_accel.h"
 #include "system/kvm_int.h"
+#include "system/kvm-pmu.h"
 #include "system/runstate.h"
 #include "kvm_i386.h"
 #include "../confidential-guest.h"
@@ -110,6 +111,7 @@ typedef struct {
 static void kvm_init_msrs(X86CPU *cpu);
 static int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
                           QEMUWRMSRHandler *wrmsr);
+static int kvm_filter_pmu_event(KVMState *s);
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
@@ -3346,6 +3348,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    if (s->pmu_filter) {
+        ret = kvm_filter_pmu_event(s);
+        if (ret < 0) {
+            error_report("Could not set KVM PMU filter");
+            return ret;
+        }
+    }
+
     return 0;
 }
 
@@ -5942,6 +5952,82 @@ static int kvm_handle_wrmsr(X86CPU *cpu, struct kvm_run *run)
     g_assert_not_reached();
 }
 
+static bool kvm_config_pmu_event(KVMPMUFilter *filter,
+                                 struct kvm_pmu_event_filter *kvm_filter)
+{
+    KVMPMUFilterEventList *events;
+    KVMPMUFilterEvent *event;
+    uint64_t code;
+    int idx = 0;
+
+    kvm_filter->nevents = filter->nevents;
+    events = filter->events;
+    while (events) {
+        assert(idx < kvm_filter->nevents);
+
+        event = events->value;
+        switch (event->format) {
+        case KVM_PMU_EVENT_FMT_RAW:
+            code = event->u.raw.code;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        kvm_filter->events[idx++] = code;
+        events = events->next;
+    }
+
+    return true;
+}
+
+static int kvm_install_pmu_event_filter(KVMState *s)
+{
+    struct kvm_pmu_event_filter *kvm_filter;
+    KVMPMUFilter *filter = s->pmu_filter;
+    int ret;
+
+    kvm_filter = g_malloc0(sizeof(struct kvm_pmu_event_filter) +
+                           filter->nevents * sizeof(uint64_t));
+
+    switch (filter->action) {
+    case KVM_PMU_FILTER_ACTION_ALLOW:
+        kvm_filter->action = KVM_PMU_EVENT_ALLOW;
+        break;
+    case KVM_PMU_FILTER_ACTION_DENY:
+        kvm_filter->action = KVM_PMU_EVENT_DENY;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (!kvm_config_pmu_event(filter, kvm_filter)) {
+        goto fail;
+    }
+
+    ret = kvm_vm_ioctl(s, KVM_SET_PMU_EVENT_FILTER, kvm_filter);
+    if (ret) {
+        error_report("KVM_SET_PMU_EVENT_FILTER fails (%s)", strerror(-ret));
+        goto fail;
+    }
+
+    g_free(kvm_filter);
+    return 0;
+fail:
+    g_free(kvm_filter);
+    return -EINVAL;
+}
+
+static int kvm_filter_pmu_event(KVMState *s)
+{
+    if (!kvm_vm_check_extension(s, KVM_CAP_PMU_EVENT_FILTER)) {
+        error_report("KVM PMU filter is not supported by Host.");
+        return -1;
+    }
+
+    return kvm_install_pmu_event_filter(s);
+}
+
 static bool has_sgx_provisioning;
 
 static bool __kvm_enable_sgx_provisioning(KVMState *s)
@@ -6537,6 +6623,35 @@ static void kvm_arch_set_xen_evtchn_max_pirq(Object *obj, Visitor *v,
     s->xen_evtchn_max_pirq = value;
 }
 
+static void kvm_arch_check_pmu_filter(const Object *obj, const char *name,
+                                      Object *child, Error **errp)
+{
+    KVMPMUFilter *filter = KVM_PMU_FILTER(child);
+    KVMPMUFilterEventList *events = filter->events;
+
+    if (!filter->nevents) {
+        error_setg(errp,
+                   "Empty KVM PMU filter.");
+        return;
+    }
+
+    while (events) {
+        KVMPMUFilterEvent *event = events->value;
+
+        switch (event->format) {
+        case KVM_PMU_EVENT_FMT_RAW:
+            break;
+        default:
+            error_setg(errp,
+                       "Unsupported PMU event format %s.",
+                       KVMPMUEventEncodeFmt_str(events->value->format));
+            return;
+        }
+
+        events = events->next;
+    }
+}
+
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
     object_class_property_add_enum(oc, "notify-vmexit", "NotifyVMexitOption",
@@ -6576,6 +6691,14 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
                               NULL, NULL);
     object_class_property_set_description(oc, "xen-evtchn-max-pirq",
                                           "Maximum number of Xen PIRQs");
+
+    object_class_property_add_link(oc, "pmu-filter",
+                                   TYPE_KVM_PMU_FILTER,
+                                   offsetof(KVMState, pmu_filter),
+                                   kvm_arch_check_pmu_filter,
+                                   OBJ_PROP_LINK_STRONG);
+    object_class_property_set_description(oc, "pmu-filter",
+                                          "Set the KVM PMU filter");
 }
 
 void kvm_set_max_apic_id(uint32_t max_apic_id)
-- 
2.34.1


