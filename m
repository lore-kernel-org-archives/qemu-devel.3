Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED078C48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 06:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcgBo-000566-Bu; Wed, 21 Feb 2024 01:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1rcgBm-00055T-Md
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 01:34:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1rcgBj-0000ML-Og
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 01:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708497277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=evEomn3x7RT1zwxAG5vFN0jLdOxMDNoXPbslYnl8KrA=;
 b=EKLugDwIZ2+awvrVZ1WCFhx9VoIiURtYlFeqnZuALyoZAmWu5aUaivX+yWib99BXmFalxf
 YOcBxkMHGsyXLfLgV8HvBUxRoCpxT76zsLoWjZ5wbFxvspfMQGmhxmQNSNcnpv5uroN4ew
 dgXst5tzOomVxKxHQv14KHUZh6Onmbw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-4FpiZm-OPMWgMxJCIi_9wQ-1; Wed, 21 Feb 2024 01:34:34 -0500
X-MC-Unique: 4FpiZm-OPMWgMxJCIi_9wQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E64D185A784;
 Wed, 21 Feb 2024 06:34:34 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com
 (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15B29C185C0;
 Wed, 21 Feb 2024 06:34:34 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: qemu-arm@nongnu.org
Cc: Eric Auger <eauger@redhat.com>, Shaoqin Huang <shahuang@redhat.com>,
 Sebastian Ott <sebott@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [PATCH v7] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Date: Wed, 21 Feb 2024 01:34:31 -0500
Message-Id: <20240221063431.76992-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The KVM_ARM_VCPU_PMU_V3_FILTER provides the ability to let the VMM decide
which PMU events are provided to the guest. Add a new option
`kvm-pmu-filter` as -cpu sub-option to set the PMU Event Filtering.
Without the filter, all PMU events are exposed from host to guest by
default. The usage of the new sub-option can be found from the updated
document (docs/system/arm/cpu-features.rst).

Here is an example which shows how to use the PMU Event Filtering, when
we launch a guest by use kvm, add such command line:

  # qemu-system-aarch64 \
        -accel kvm \
        -cpu host,kvm-pmu-filter="D:0x11-0x11"

Since the first action is deny, we have a global allow policy. This
filters out the cycle counter (event 0x11 being CPU_CYCLES).

And then in guest, use the perf to count the cycle:

  # perf stat sleep 1

   Performance counter stats for 'sleep 1':

              1.22 msec task-clock                       #    0.001 CPUs utilized
                 1      context-switches                 #  820.695 /sec
                 0      cpu-migrations                   #    0.000 /sec
                55      page-faults                      #   45.138 K/sec
   <not supported>      cycles
           1128954      instructions
            227031      branches                         #  186.323 M/sec
              8686      branch-misses                    #    3.83% of all branches

       1.002492480 seconds time elapsed

       0.001752000 seconds user
       0.000000000 seconds sys

As we can see, the cycle counter has been disabled in the guest, but
other pmu events do still work.

Reviewed-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
v6->v7:
  - Check return value of sscanf.
  - Improve the check condition.

v5->v6:
  - Commit message improvement.
  - Remove some unused code.
  - Collect Reviewed-by, thanks Sebastian.
  - Use g_auto(Gstrv) to replace the gchar **.          [Eric]

v4->v5:
  - Change the kvm-pmu-filter as a -cpu sub-option.     [Eric]
  - Comment tweak.                                      [Gavin]
  - Rebase to the latest branch.

v3->v4:
  - Fix the wrong check for pmu_filter_init.            [Sebastian]
  - Fix multiple alignment issue.                       [Gavin]
  - Report error by warn_report() instead of error_report(), and don't use
  abort() since the PMU Event Filter is an add-on and best-effort feature.
                                                        [Gavin]
  - Add several missing {  } for single line of code.   [Gavin]
  - Use the g_strsplit() to replace strtok().           [Gavin]

v2->v3:
  - Improve commits message, use kernel doc wording, add more explaination on
    filter example, fix some typo error.                [Eric]
  - Add g_free() in kvm_arch_set_pmu_filter() to prevent memory leak. [Eric]
  - Add more precise error message report.              [Eric]
  - In options doc, add pmu-filter rely on KVM_ARM_VCPU_PMU_V3_FILTER support in
    KVM.                                                [Eric]

v1->v2:
  - Add more description for allow and deny meaning in 
    commit message.                                     [Sebastian]
  - Small improvement.                                  [Sebastian]

 docs/system/arm/cpu-features.rst | 23 +++++++++
 target/arm/cpu.h                 |  3 ++
 target/arm/kvm.c                 | 80 ++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index a5fb929243..7c8f6a60ef 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -204,6 +204,29 @@ the list of KVM VCPU features and their descriptions.
   the guest scheduler behavior and/or be exposed to the guest
   userspace.
 
+``kvm-pmu-filter``
+  By default kvm-pmu-filter is disabled. This means that by default all pmu
+  events will be exposed to guest.
+
+  KVM implements PMU Event Filtering to prevent a guest from being able to
+  sample certain events. It depends on the KVM_ARM_VCPU_PMU_V3_FILTER
+  attribute supported in KVM. It has the following format:
+
+  kvm-pmu-filter="{A,D}:start-end[;{A,D}:start-end...]"
+
+  The A means "allow" and D means "deny", start is the first event of the
+  range and the end is the last one. The first registered range defines
+  the global policy(global ALLOW if the first @action is DENY, global DENY
+  if the first @action is ALLOW). The start and end only support hexadecimal
+  format. For example:
+
+  kvm-pmu-filter="A:0x11-0x11;A:0x23-0x3a;D:0x30-0x30"
+
+  Since the first action is allow, we have a global deny policy. It
+  will allow event 0x11 (The cycle counter), events 0x23 to 0x3a are
+  also allowed except the event 0x30 which is denied, and all the other
+  events are denied.
+
 TCG VCPU Features
 =================
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 63f31e0d98..f7f2431755 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -948,6 +948,9 @@ struct ArchCPU {
 
     /* KVM steal time */
     OnOffAuto kvm_steal_time;
+
+    /* KVM PMU Filter */
+    char *kvm_pmu_filter;
 #endif /* CONFIG_KVM */
 
     /* Uniprocessor system with MP extensions */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 81813030a5..5c62580d34 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -496,6 +496,22 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
     ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
 }
 
+static char *kvm_pmu_filter_get(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    return g_strdup(cpu->kvm_pmu_filter);
+}
+
+static void kvm_pmu_filter_set(Object *obj, const char *pmu_filter,
+                               Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    g_free(cpu->kvm_pmu_filter);
+    cpu->kvm_pmu_filter = g_strdup(pmu_filter);
+}
+
 /* KVM VCPU properties should be prefixed with "kvm-". */
 void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
 {
@@ -517,6 +533,12 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
                              kvm_steal_time_set);
     object_property_set_description(obj, "kvm-steal-time",
                                     "Set off to disable KVM steal time.");
+
+    object_property_add_str(obj, "kvm-pmu-filter", kvm_pmu_filter_get,
+                            kvm_pmu_filter_set);
+    object_property_set_description(obj, "kvm-pmu-filter",
+                                    "PMU Event Filtering description for "
+                                    "guest PMU. (default: NULL, disabled)");
 }
 
 bool kvm_arm_pmu_supported(void)
@@ -1706,6 +1728,62 @@ static bool kvm_arm_set_device_attr(ARMCPU *cpu, struct kvm_device_attr *attr,
     return true;
 }
 
+static void kvm_arm_pmu_filter_init(ARMCPU *cpu)
+{
+    static bool pmu_filter_init;
+    struct kvm_pmu_event_filter filter;
+    struct kvm_device_attr attr = {
+        .group      = KVM_ARM_VCPU_PMU_V3_CTRL,
+        .attr       = KVM_ARM_VCPU_PMU_V3_FILTER,
+        .addr       = (uint64_t)&filter,
+    };
+    int i;
+    g_auto(GStrv) event_filters;
+
+    if (!cpu->kvm_pmu_filter) {
+        return;
+    }
+    if (kvm_vcpu_ioctl(CPU(cpu), KVM_HAS_DEVICE_ATTR, &attr)) {
+        warn_report("The KVM doesn't support the PMU Event Filter!");
+        return;
+    }
+
+    /*
+     * The filter only needs to be initialized through one vcpu ioctl and it
+     * will affect all other vcpu in the vm.
+     */
+    if (pmu_filter_init) {
+        return;
+    } else {
+        pmu_filter_init = true;
+    }
+
+    event_filters = g_strsplit(cpu->kvm_pmu_filter, ";", -1);
+    for (i = 0; event_filters[i]; i++) {
+        unsigned short start = 0, end = 0;
+        char act;
+
+        if (sscanf(event_filters[i], "%c:%hx-%hx", &act, &start, &end) != 3) {
+            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
+            continue;
+        }
+
+        if ((act != 'A' && act != 'D') || start > end) {
+            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
+            continue;
+        }
+
+        filter.base_event = start;
+        filter.nevents = end - start + 1;
+        filter.action = (act == 'A') ? KVM_PMU_EVENT_ALLOW :
+                                       KVM_PMU_EVENT_DENY;
+
+        if (!kvm_arm_set_device_attr(cpu, &attr, "PMU_V3_FILTER")) {
+            break;
+        }
+    }
+}
+
 void kvm_arm_pmu_init(ARMCPU *cpu)
 {
     struct kvm_device_attr attr = {
@@ -1716,6 +1794,8 @@ void kvm_arm_pmu_init(ARMCPU *cpu)
     if (!cpu->has_pmu) {
         return;
     }
+
+    kvm_arm_pmu_filter_init(cpu);
     if (!kvm_arm_set_device_attr(cpu, &attr, "PMU")) {
         error_report("failed to init PMU");
         abort();

base-commit: 760b4dcdddba4a40b9fa0eb78fdfc7eda7cb83d0
-- 
2.40.1


