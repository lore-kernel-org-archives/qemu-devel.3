Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CC8C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 04:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRP3v-0005qg-En; Wed, 10 Jul 2024 00:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sRP3t-0005jJ-HR; Wed, 10 Jul 2024 00:36:13 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sRP3r-0006sb-JP; Wed, 10 Jul 2024 00:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720586171; x=1752122171;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qMy1GX3+etGOKvBzHp/xRoSoF1eAUO1DrwJq/x8rfjk=;
 b=m4XXwj9FpifoJLW6CLq4gDEanKR9D5lnCJuodY5r5qvduxK9Apev7A5d
 9A84RevmIO4Z2msxUzbsp8lLtaB4CQR+EDSrhkdhUuWD9BP9arskOwQt+
 biX167hjmyHaZVuBYOilrlGtGbEsXtAZh55jMh/rpPoL9xSBU3LofPh82
 aTGw7yIghvEUb8Cd7aY28aofXZFScjjHfalk3sdiPU0G/lMuXvU6K8Q8C
 c4tOdcGBp/ahPIh/6Zqr4ZSJvdvACFlJkegQbXNKCtfGfBkSOFRpVAezx
 aioHOo7LtTO644BkVTDNnD5TqhZRGzSZGH3+imOVYUtEVoC50aRHavTes w==;
X-CSE-ConnectionGUID: itlenDkPQaCBhXhe93dP+Q==
X-CSE-MsgGUID: rXev+ZknT7uj8/nNwdmjaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="28473790"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; d="scan'208";a="28473790"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 21:36:07 -0700
X-CSE-ConnectionGUID: eNip1eA/Qs2LWBMAurq/uQ==
X-CSE-MsgGUID: 9l7NAIsHSfCngVDXlgJPxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; d="scan'208";a="79238163"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 09 Jul 2024 21:36:02 -0700
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
Subject: [RFC 2/5] i386/kvm: Support initial KVM PMU filter
Date: Wed, 10 Jul 2024 12:51:14 +0800
Message-Id: <20240710045117.3164577-3-zhao1.liu@intel.com>
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

Filter PMU events with raw format in i386 code.

For i386, raw format indicates that the PMU event code is already
encoded according to the KVM ioctl requirements, and can be delivered
directly to KVM without additional encoding work.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/sysemu/kvm_int.h   |   2 +
 target/i386/kvm/kvm.c      | 144 +++++++++++++++++++++++++++++++++++++
 target/i386/kvm/kvm_i386.h |   1 +
 3 files changed, 147 insertions(+)

diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 3f3d13f81669..9ab566cb4494 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -14,6 +14,7 @@
 #include "qemu/accel.h"
 #include "qemu/queue.h"
 #include "sysemu/kvm.h"
+#include "sysemu/kvm-pmu.h"
 
 typedef struct KVMSlot
 {
@@ -124,6 +125,7 @@ struct KVMState
     uint16_t xen_gnttab_max_frames;
     uint16_t xen_evtchn_max_pirq;
     char *device;
+    KVMPMUFilter *pmu_filter;
 };
 
 void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index becca2efa5b4..e9bf79782316 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -30,6 +30,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm_int.h"
+#include "sysemu/kvm-pmu.h"
 #include "sysemu/runstate.h"
 #include "kvm_i386.h"
 #include "../confidential-guest.h"
@@ -2806,6 +2807,16 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    if (s->pmu_filter) {
+        bool r;
+
+        r = kvm_filter_pmu_event(s);
+        if (!r) {
+            error_report("Could not set KVM PMU filter");
+            exit(1);
+        }
+    }
+
     return 0;
 }
 
@@ -5363,6 +5374,91 @@ static int kvm_handle_wrmsr(X86CPU *cpu, struct kvm_run *run)
     assert(false);
 }
 
+static bool
+kvm_config_pmu_event(KVMPMUFilter *filter,
+                     struct kvm_pmu_event_filter *kvm_filter)
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
+static bool kvm_install_pmu_event_filter(KVMState *s)
+{
+    struct kvm_pmu_event_filter *kvm_filter;
+    KVMPMUFilter *filter = s->pmu_filter;
+    int ret;
+
+    kvm_filter = g_malloc0(sizeof(struct kvm_pmu_event_filter) +
+                           filter->nevents * sizeof(uint64_t));
+
+    /*
+     * Currently, kvm-pmu-filter only supports configuring the same
+     * action for PMU events.
+     */
+    switch (filter->events->value->action) {
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
+    return true;
+fail:
+    g_free(kvm_filter);
+    return false;
+}
+
+bool kvm_filter_pmu_event(KVMState *s)
+{
+    if (!kvm_vm_check_extension(s, KVM_CAP_PMU_EVENT_FILTER)) {
+        error_report("KVM PMU filter is not supported by Host.");
+        return false;
+    }
+
+    if (!kvm_install_pmu_event_filter(s)) {
+        return false;
+    }
+
+    return true;
+}
+
 static bool has_sgx_provisioning;
 
 static bool __kvm_enable_sgx_provisioning(KVMState *s)
@@ -5958,6 +6054,46 @@ static void kvm_arch_set_xen_evtchn_max_pirq(Object *obj, Visitor *v,
     s->xen_evtchn_max_pirq = value;
 }
 
+static void kvm_arch_check_pmu_filter(const Object *obj, const char *name,
+                                      Object *child, Error **errp)
+{
+    KVMPMUFilter *filter = KVM_PMU_FILTER(child);
+    KVMPMUFilterEventList *events = filter->events;
+    KVMPMUFilterAction action;
+
+    if (!filter->nevents) {
+        error_setg(errp,
+                   "Empty KVM PMU filter.");
+        return;
+    }
+
+    action = KVM_PMU_FILTER_ACTION__MAX;
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
+        if (action == KVM_PMU_FILTER_ACTION__MAX) {
+            action = event->action;
+        } else if (action != event->action) {
+            /* TODO: Support events with different actions if necessary. */
+            error_setg(errp,
+                       "Only support PMU events with the same action");
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
@@ -5997,6 +6133,14 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
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
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 34fc60774b86..5cdc7106424d 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -76,6 +76,7 @@ typedef struct kvm_msr_handlers {
 
 bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
                     QEMUWRMSRHandler *wrmsr);
+bool kvm_filter_pmu_event(KVMState *s);
 
 #endif /* CONFIG_KVM */
 
-- 
2.34.1


