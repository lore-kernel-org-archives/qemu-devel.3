Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD226C369A1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 08:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2QSl-0005Fw-3i; Wed, 09 Apr 2025 04:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2QSN-00058O-4j; Wed, 09 Apr 2025 04:06:47 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2QSJ-0000T8-ER; Wed, 09 Apr 2025 04:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744186003; x=1775722003;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UPJeKBU9B6lL8PCAg4txtntOoPDJJfc8C5kkR9P+OTA=;
 b=VuGAkkc9p7m54LplHpPH/D4hmmY6UAFnJozgrieF8lCug/IPwe2gyAex
 Xy/2UC/sfeaeW2GI5EEeKfIToy1ewZal1m2/0tvHTDvBlPYGdVRSlPxmX
 V2B/40XKo6jySOB5ikABZYNlGCeyTgA6FWPdXyQ0WhDb7i4l4Ndcu1+Fm
 ryH2YA84ltewOJyDoq3EZ8/wPMhc/5DYP211VcAMsPgdNRqvG4qn5bydb
 PRcMr7o+A6pnGMSEiO75RO5gzu7Ova6F5mRWF3Kpx0vhS0x8RaWpXwOny
 BdaHM0O90t9wewwjWjMH7AidRzdGgMnS48x9g/zd9uxPiNNFOBXY6jAlk g==;
X-CSE-ConnectionGUID: YmfKM5SJQ+ysn1FAJOhPcg==
X-CSE-MsgGUID: xdsE+KW5RCeRWHCqSGlTEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45810048"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="45810048"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 01:06:41 -0700
X-CSE-ConnectionGUID: pKtH7y0SQuKiBQWP5t4yMQ==
X-CSE-MsgGUID: p6nLUmssSDqxwyFWnFhd/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="151702631"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 09 Apr 2025 01:06:29 -0700
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
Subject: [PATCH 3/5] i386/kvm: Support event with select & umask format in KVM
 PMU filter
Date: Wed,  9 Apr 2025 16:26:47 +0800
Message-Id: <20250409082649.14733-4-zhao1.liu@intel.com>
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

The select&umask is the common way for x86 to identify the PMU event,
so support this way as the "x86-default" format in kvm-pmu-filter
object.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
Changes since RFC v2:
 * Drop hexadecimal variants and support numeric version in QAPI
   directly. (Daniel)
 * Rename "x86-default" format to "x86-select-umask". (Markus)
 * Add Tested-by from Yi.
 * Add documentation in qemu-options.hx.
 * QAPI style fix:
   - KVMPMU* stuff -> KvmPmu*.
 * Bump up the supported QAPI version to v10.1.

Changes since RFC v1:
 * Bump up the supported QAPI version to v10.0.
---
 accel/kvm/kvm-pmu.c      | 20 +++++++++++++++++++-
 include/system/kvm-pmu.h | 13 +++++++++++++
 qapi/kvm.json            | 21 +++++++++++++++++++--
 qemu-options.hx          |  3 +++
 target/i386/kvm/kvm.c    |  5 +++++
 5 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-pmu.c b/accel/kvm/kvm-pmu.c
index 22f749bf9183..fa73ef428e59 100644
--- a/accel/kvm/kvm-pmu.c
+++ b/accel/kvm/kvm-pmu.c
@@ -16,6 +16,8 @@
 #include "qom/object_interfaces.h"
 #include "system/kvm-pmu.h"
 
+#define UINT12_MAX (4095)
+
 static void kvm_pmu_filter_set_action(Object *obj, int value,
                                       Error **errp G_GNUC_UNUSED)
 {
@@ -53,9 +55,22 @@ static void kvm_pmu_filter_set_event(Object *obj, Visitor *v, const char *name,
     }
 
     for (node = head; node; node = node->next) {
-        switch (node->value->format) {
+        KvmPmuFilterEvent *event = node->value;
+
+        switch (event->format) {
         case KVM_PMU_EVENT_FORMAT_RAW:
             break;
+        case KVM_PMU_EVENT_FORMAT_X86_SELECT_UMASK: {
+            if (event->u.x86_select_umask.select > UINT12_MAX) {
+                error_setg(errp,
+                           "Parameter 'select' out of range (%d).",
+                           UINT12_MAX);
+                goto fail;
+            }
+
+            /* No need to check the range of umask since it's uint8_t. */
+            break;
+        }
         default:
             g_assert_not_reached();
         }
@@ -67,6 +82,9 @@ static void kvm_pmu_filter_set_event(Object *obj, Visitor *v, const char *name,
     filter->events = head;
     qapi_free_KvmPmuFilterEventList(old_head);
     return;
+
+fail:
+    qapi_free_KvmPmuFilterEventList(head);
 }
 
 static void kvm_pmu_filter_class_init(ObjectClass *oc, void *data)
diff --git a/include/system/kvm-pmu.h b/include/system/kvm-pmu.h
index 818fa309c191..6abc0d037aee 100644
--- a/include/system/kvm-pmu.h
+++ b/include/system/kvm-pmu.h
@@ -32,4 +32,17 @@ struct KVMPMUFilter {
     KvmPmuFilterEventList *events;
 };
 
+/*
+ * Stolen from Linux kernel (RAW_EVENT at tools/testing/selftests/kvm/include/
+ * x86_64/pmu.h).
+ *
+ * Encode an eventsel+umask pair into event-select MSR format.  Note, this is
+ * technically AMD's format, as Intel's format only supports 8 bits for the
+ * event selector, i.e. doesn't use bits 24:16 for the selector.  But, OR-ing
+ * in '0' is a nop and won't clobber the CMASK.
+ */
+#define X86_PMU_RAW_EVENT(eventsel, umask) (((eventsel & 0xf00UL) << 24) | \
+                                            ((eventsel) & 0xff) | \
+                                            ((umask) & 0xff) << 8)
+
 #endif /* KVM_PMU_H */
diff --git a/qapi/kvm.json b/qapi/kvm.json
index 1861d86a9726..cb151ca82e5c 100644
--- a/qapi/kvm.json
+++ b/qapi/kvm.json
@@ -36,10 +36,12 @@
 #
 # @raw: the encoded event code that KVM can directly consume.
 #
+# @x86-select-umask: standard x86 encoding format with select and umask.
+#
 # Since 10.1
 ##
 { 'enum': 'KvmPmuEventFormat',
-  'data': ['raw'] }
+  'data': ['raw', 'x86-select-umask'] }
 
 ##
 # @KvmPmuRawEvent:
@@ -54,6 +56,20 @@
 { 'struct': 'KvmPmuRawEvent',
   'data': { 'code': 'uint64' } }
 
+##
+# @KvmPmuX86SelectUmaskEvent:
+#
+# @select: x86 PMU event select field, which is a 12-bit unsigned
+#     number.
+#
+# @umask: x86 PMU event umask field.
+#
+# Since 10.1
+##
+{ 'struct': 'KvmPmuX86SelectUmaskEvent',
+  'data': { 'select': 'uint16',
+            'umask': 'uint8' } }
+
 ##
 # @KvmPmuFilterEvent:
 #
@@ -66,7 +82,8 @@
 { 'union': 'KvmPmuFilterEvent',
   'base': { 'format': 'KvmPmuEventFormat' },
   'discriminator': 'format',
-  'data': { 'raw': 'KvmPmuRawEvent' } }
+  'data': { 'raw': 'KvmPmuRawEvent',
+            'x86-select-umask': 'KvmPmuX86SelectUmaskEvent' } }
 
 ##
 # @KvmPmuFilterProperties:
diff --git a/qemu-options.hx b/qemu-options.hx
index 51a7c61ce0b0..5dcce067d8dd 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -6180,6 +6180,9 @@ SRST
              ((select) & 0xff) | \
              ((umask) & 0xff) << 8)
 
+        ``{"format":"x86-select-umask","select":event_select,"umask":event_umask}``
+            Specify the single x86 PMU event with select and umask fields.
+
         An example KVM PMU filter object would look like:
 
         .. parsed-literal::
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index fa3a696654cb..0d36ccf250ed 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5974,6 +5974,10 @@ static bool kvm_config_pmu_event(KVMPMUFilter *filter,
         case KVM_PMU_EVENT_FORMAT_RAW:
             code = event->u.raw.code;
             break;
+        case KVM_PMU_EVENT_FORMAT_X86_SELECT_UMASK:
+            code = X86_PMU_RAW_EVENT(event->u.x86_select_umask.select,
+                                     event->u.x86_select_umask.umask);
+            break;
         default:
             g_assert_not_reached();
         }
@@ -6644,6 +6648,7 @@ static void kvm_arch_check_pmu_filter(const Object *obj, const char *name,
 
         switch (event->format) {
         case KVM_PMU_EVENT_FORMAT_RAW:
+        case KVM_PMU_EVENT_FORMAT_X86_SELECT_UMASK:
             break;
         default:
             error_setg(errp,
-- 
2.34.1


