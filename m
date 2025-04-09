Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6D7C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 08:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2QSo-0005Ol-Py; Wed, 09 Apr 2025 04:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2QSN-00058P-5i; Wed, 09 Apr 2025 04:06:47 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2QSJ-0000UF-KA; Wed, 09 Apr 2025 04:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744186003; x=1775722003;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gPWi6WAm1QJcGhcg000exTZdLrq/PcWVzv1PHwkLj9U=;
 b=VS9mDCmMe9ZwKjyxI/a8V8Hji+r8+pags/SkYEDS+nZGs60N8gO/UPGu
 fypkvWWLHfzMBW7FN4XSYZ3/mWRfaS2FjSZs9kOHH6PeLgrHG+pM1CW5H
 R5EF1BoyP0JeH4gaz8Iw3rwPlZ5HZYWhQYwfou9nXGEW5Nm1ftCfIgvpu
 zPhRy9Fk7rcEW/W87HTvbZjDX7rpsVilx6JdhefoaP/B76Ljy5nTxHedu
 imHqu7vqsaOMxWYoC+b91pQ1/1MHfcFJFIyjbAPjxm7R0kSxpGfaeZfV8
 iYmJLZkDhX0aV3jWLbjw2eEYZPxlYvZTpZMAZK0+Gelo/AzIjShV9zcLw Q==;
X-CSE-ConnectionGUID: iFH9g3FHRIC7gbSXx+uTgA==
X-CSE-MsgGUID: oSIUVPqETu2AO55cuSbshw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45810055"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="45810055"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 01:06:41 -0700
X-CSE-ConnectionGUID: cFIbbdPkQxO2qtm/wJUIkw==
X-CSE-MsgGUID: PWZY0nrHTyWDhy+kTpVPfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="151702666"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 09 Apr 2025 01:06:34 -0700
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
Subject: [PATCH 4/5] i386/kvm: Support event with masked entry format in KVM
 PMU filter
Date: Wed,  9 Apr 2025 16:26:48 +0800
Message-Id: <20250409082649.14733-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409082649.14733-1-zhao1.liu@intel.com>
References: <20250409082649.14733-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

KVM_SET_PMU_EVENT_FILTER of x86 KVM supports masked events mode, which
accepts masked entry format event to flexibly represent a group of PMU
events.

Support masked entry format in kvm-pmu-filter object and handle this in
i386 kvm codes.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
Changes since RFC v2:
 * Drop hexadecimal variants and support numeric version in QAPI
   directly. (Daniel)
 * Add Tested-by from Yi.
 * Add documentation in qemu-options.hx.
 * QAPI style fix:
   - KVMPMU* stuff -> KvmPmu*.
 * Bump up the supported QAPI version to v10.1.

Changes since RFC v1:
 * Bump up the supported QAPI version to v10.0.
---
 accel/kvm/kvm-pmu.c   | 14 ++++++++++++++
 qapi/kvm.json         | 29 +++++++++++++++++++++++++++--
 qemu-options.hx       | 13 +++++++++++++
 target/i386/kvm/kvm.c | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-pmu.c b/accel/kvm/kvm-pmu.c
index fa73ef428e59..9205907d1779 100644
--- a/accel/kvm/kvm-pmu.c
+++ b/accel/kvm/kvm-pmu.c
@@ -71,6 +71,20 @@ static void kvm_pmu_filter_set_event(Object *obj, Visitor *v, const char *name,
             /* No need to check the range of umask since it's uint8_t. */
             break;
         }
+        case KVM_PMU_EVENT_FORMAT_X86_MASKED_ENTRY: {
+            if (event->u.x86_masked_entry.select > UINT12_MAX) {
+                error_setg(errp,
+                           "Parameter 'select' out of range (%d).",
+                           UINT12_MAX);
+                goto fail;
+            }
+
+            /*
+             * No need to check the range of match or mask fields since
+             * they're both uint8_t.
+             */
+            break;
+        }
         default:
             g_assert_not_reached();
         }
diff --git a/qapi/kvm.json b/qapi/kvm.json
index cb151ca82e5c..1b523e058731 100644
--- a/qapi/kvm.json
+++ b/qapi/kvm.json
@@ -38,10 +38,13 @@
 #
 # @x86-select-umask: standard x86 encoding format with select and umask.
 #
+# @x86-masked-entry: KVM's masked entry format for x86, which could
+#     mask bunch of events.
+#
 # Since 10.1
 ##
 { 'enum': 'KvmPmuEventFormat',
-  'data': ['raw', 'x86-select-umask'] }
+  'data': ['raw', 'x86-select-umask', 'x86-masked-entry'] }
 
 ##
 # @KvmPmuRawEvent:
@@ -70,6 +73,27 @@
   'data': { 'select': 'uint16',
             'umask': 'uint8' } }
 
+##
+# @KvmPmuX86MaskedEntry:
+#
+# x86 PMU events encoding in KVM masked entry format.
+#
+# @select: x86 PMU event select, which is a 12-bit unsigned number.
+#
+# @match: umask match.
+#
+# @mask: umask mask.
+#
+# @exclude: whether the matched events are excluded.
+#
+# Since 10.1
+##
+{ 'struct': 'KvmPmuX86MaskedEntry',
+  'data': { 'select': 'uint16',
+            'match': 'uint8',
+            'mask': 'uint8',
+            'exclude': 'bool' } }
+
 ##
 # @KvmPmuFilterEvent:
 #
@@ -83,7 +107,8 @@
   'base': { 'format': 'KvmPmuEventFormat' },
   'discriminator': 'format',
   'data': { 'raw': 'KvmPmuRawEvent',
-            'x86-select-umask': 'KvmPmuX86SelectUmaskEvent' } }
+            'x86-select-umask': 'KvmPmuX86SelectUmaskEvent',
+            'x86-masked-entry': 'KvmPmuX86MaskedEntry' } }
 
 ##
 # @KvmPmuFilterProperties:
diff --git a/qemu-options.hx b/qemu-options.hx
index 5dcce067d8dd..bb89198971e0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -6183,6 +6183,19 @@ SRST
         ``{"format":"x86-select-umask","select":event_select,"umask":event_umask}``
             Specify the single x86 PMU event with select and umask fields.
 
+        ``{"format":"x86-masked-entry","select":event_select,"mask":entry_mask,"match":entry_match,"exclude":exclude}``
+            Configure a set of x86 PMU events that share the same
+            ``select`` field. The events are determined by a formula
+            that checks if an event's umask is included:
+
+        ::
+
+            event_umask & entry_mask == entry_match
+
+            The "exclude" parameter controls whether to exclude the
+            events selected based on the above formula, under the given
+            "select" field.
+
         An example KVM PMU filter object would look like:
 
         .. parsed-literal::
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 0d36ccf250ed..8786501e9c7e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5978,6 +5978,13 @@ static bool kvm_config_pmu_event(KVMPMUFilter *filter,
             code = X86_PMU_RAW_EVENT(event->u.x86_select_umask.select,
                                      event->u.x86_select_umask.umask);
             break;
+        case KVM_PMU_EVENT_FORMAT_X86_MASKED_ENTRY:
+            code = KVM_PMU_ENCODE_MASKED_ENTRY(
+                       event->u.x86_masked_entry.select,
+                       event->u.x86_masked_entry.mask,
+                       event->u.x86_masked_entry.match,
+                       event->u.x86_masked_entry.exclude ? 1 : 0);
+            break;
         default:
             g_assert_not_reached();
         }
@@ -6009,6 +6016,17 @@ static int kvm_install_pmu_event_filter(KVMState *s)
         g_assert_not_reached();
     }
 
+    kvm_filter->flags = filter->events->value->format ==
+                        KVM_PMU_EVENT_FORMAT_X86_MASKED_ENTRY ?
+                        KVM_PMU_EVENT_FLAG_MASKED_EVENTS : 0;
+
+    if (kvm_filter->flags == KVM_PMU_EVENT_FLAG_MASKED_EVENTS &&
+        !kvm_vm_check_extension(s, KVM_CAP_PMU_EVENT_MASKED_EVENTS)) {
+        error_report("Masked entry format of PMU event "
+                     "is not supported by Host.");
+        goto fail;
+    }
+
     if (!kvm_config_pmu_event(filter, kvm_filter)) {
         goto fail;
     }
@@ -6636,6 +6654,7 @@ static void kvm_arch_check_pmu_filter(const Object *obj, const char *name,
 {
     KVMPMUFilter *filter = KVM_PMU_FILTER(child);
     KvmPmuFilterEventList *events = filter->events;
+    uint32_t base_flag;
 
     if (!filter->nevents) {
         error_setg(errp,
@@ -6643,12 +6662,21 @@ static void kvm_arch_check_pmu_filter(const Object *obj, const char *name,
         return;
     }
 
+    /* Pick the first event's flag as the base one. */
+    base_flag = events->value->format ==
+                KVM_PMU_EVENT_FORMAT_X86_MASKED_ENTRY ?
+                KVM_PMU_EVENT_FLAG_MASKED_EVENTS : 0;
     while (events) {
         KvmPmuFilterEvent *event = events->value;
+        uint32_t flag;
 
         switch (event->format) {
         case KVM_PMU_EVENT_FORMAT_RAW:
         case KVM_PMU_EVENT_FORMAT_X86_SELECT_UMASK:
+            flag = 0;
+            break;
+        case KVM_PMU_EVENT_FORMAT_X86_MASKED_ENTRY:
+            flag = KVM_PMU_EVENT_FLAG_MASKED_EVENTS;
             break;
         default:
             error_setg(errp,
@@ -6657,6 +6685,13 @@ static void kvm_arch_check_pmu_filter(const Object *obj, const char *name,
             return;
         }
 
+        if (flag != base_flag) {
+            error_setg(errp,
+                       "Masked entry format cannot be mixed with "
+                       "other formats.");
+            return;
+        }
+
         events = events->next;
     }
 }
-- 
2.34.1


