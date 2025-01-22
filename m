Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D45C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 08:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taWNX-0002ue-VL; Wed, 22 Jan 2025 03:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taWNV-0002ta-Jv; Wed, 22 Jan 2025 03:46:25 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taWNT-0002y5-N1; Wed, 22 Jan 2025 03:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737535584; x=1769071584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ECviX94xj1MV2LXTaHe4lkd20iyrsoewh1cwlHBtoeQ=;
 b=BikcqPPoa5CFPwWOjoqTA7wcvm1dHii3K0BLcUea8V+StZ5MetQH3deZ
 6w5dPfPnRfrCyflnu8Bu7ZFytl11W32TtMSfytzrl4K+bPrAl7pmYAsl7
 eRoMzjwy3djmgJ6UyCrTr+ipDtQyumlWZGKf5PXH36Ag5e4ScH9Sgab4P
 BfKtwXGv1KbPhMrXelM1a9bFJTwF4icE1YUwTyspNO6dYV2a1s0ImE/Aj
 L/7nfhdurSu7igEyIy2mzBFybxVihulxG34opXknQpQWnKdq7e5uf3VoB
 ygQlivQ6pugIqKx/rqrLrM/ryGYWlByiA7gP4KFU391M//6/S52Sle6mS g==;
X-CSE-ConnectionGUID: 3Oj2kwqWR6u2A5Kk8PKIXQ==
X-CSE-MsgGUID: Ld/ZPAXbR5GjERVw/+K9Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="60451577"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; d="scan'208";a="60451577"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 00:46:23 -0800
X-CSE-ConnectionGUID: pDSkkKfhRPWinRBdf/uitA==
X-CSE-MsgGUID: CRjnXgP2QpKKNi/NIuNzZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="112049828"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 00:46:18 -0800
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
Subject: [RFC v2 3/5] i386/kvm: Support event with select & umask format in
 KVM PMU filter
Date: Wed, 22 Jan 2025 17:05:15 +0800
Message-Id: <20250122090517.294083-4-zhao1.liu@intel.com>
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

The select&umask is the common way for x86 to identify the PMU event,
so support this way as the "x86-default" format in kvm-pmu-filter
object.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC v1:
 * Bump up the supported QAPI version to 10.0.
---
 accel/kvm/kvm-pmu.c      | 62 ++++++++++++++++++++++++++++++++++++++++
 include/system/kvm-pmu.h | 13 +++++++++
 qapi/kvm.json            | 46 +++++++++++++++++++++++++++--
 target/i386/kvm/kvm.c    |  5 ++++
 4 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-pmu.c b/accel/kvm/kvm-pmu.c
index 4d0d4e7a452b..cbd32e8e21f8 100644
--- a/accel/kvm/kvm-pmu.c
+++ b/accel/kvm/kvm-pmu.c
@@ -17,6 +17,8 @@
 #include "qom/object_interfaces.h"
 #include "system/kvm-pmu.h"
 
+#define UINT12_MAX (4095)
+
 static void kvm_pmu_filter_set_action(Object *obj, int value,
                                       Error **errp G_GNUC_UNUSED)
 {
@@ -54,6 +56,12 @@ static void kvm_pmu_filter_get_event(Object *obj, Visitor *v, const char *name,
             str_event->u.raw.code = g_strdup_printf("0x%lx",
                                                     event->u.raw.code);
             break;
+        case KVM_PMU_EVENT_FMT_X86_DEFAULT:
+            str_event->u.x86_default.select =
+                g_strdup_printf("0x%x", event->u.x86_default.select);
+            str_event->u.x86_default.umask =
+                g_strdup_printf("0x%x", event->u.x86_default.umask);
+            break;
         default:
             g_assert_not_reached();
         }
@@ -98,6 +106,60 @@ static void kvm_pmu_filter_set_event(Object *obj, Visitor *v, const char *name,
                 goto fail;
             }
             break;
+        case KVM_PMU_EVENT_FMT_X86_DEFAULT: {
+            uint64_t select, umask;
+
+            ret = qemu_strtou64(str_event->u.x86_default.select, NULL,
+                                0, &select);
+            if (ret < 0) {
+                error_setg(errp,
+                           "Invalid %s PMU event (select: %s): %s. "
+                           "The select must be a "
+                           "12-bit unsigned number string.",
+                           KVMPMUEventEncodeFmt_str(str_event->format),
+                           str_event->u.x86_default.select,
+                           strerror(-ret));
+                g_free(event);
+                goto fail;
+            }
+            if (select > UINT12_MAX) {
+                error_setg(errp,
+                           "Invalid %s PMU event (select: %s): "
+                           "Numerical result out of range. "
+                           "The select must be a "
+                           "12-bit unsigned number string.",
+                           KVMPMUEventEncodeFmt_str(str_event->format),
+                           str_event->u.x86_default.select);
+                g_free(event);
+                goto fail;
+            }
+            event->u.x86_default.select = select;
+
+            ret = qemu_strtou64(str_event->u.x86_default.umask, NULL,
+                                0, &umask);
+            if (ret < 0) {
+                error_setg(errp,
+                           "Invalid %s PMU event (umask: %s): %s. "
+                           "The umask must be a uint8 string.",
+                           KVMPMUEventEncodeFmt_str(str_event->format),
+                           str_event->u.x86_default.umask,
+                           strerror(-ret));
+                g_free(event);
+                goto fail;
+            }
+            if (umask > UINT8_MAX) {
+                error_setg(errp,
+                           "Invalid %s PMU event (umask: %s): "
+                           "Numerical result out of range. "
+                           "The umask must be a uint8 string.",
+                           KVMPMUEventEncodeFmt_str(str_event->format),
+                           str_event->u.x86_default.umask);
+                g_free(event);
+                goto fail;
+            }
+            event->u.x86_default.umask = umask;
+            break;
+        }
         default:
             g_assert_not_reached();
         }
diff --git a/include/system/kvm-pmu.h b/include/system/kvm-pmu.h
index b09f70d3a370..63402f75cfdc 100644
--- a/include/system/kvm-pmu.h
+++ b/include/system/kvm-pmu.h
@@ -27,4 +27,17 @@ struct KVMPMUFilter {
     KVMPMUFilterEventList *events;
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
index d51aeeba7cd8..93b869e3f90c 100644
--- a/qapi/kvm.json
+++ b/qapi/kvm.json
@@ -27,11 +27,13 @@
 #
 # @raw: the encoded event code that KVM can directly consume.
 #
+# @x86-default: standard x86 encoding format with select and umask.
+#
 # Since 10.0
 ##
 { 'enum': 'KVMPMUEventEncodeFmt',
   'prefix': 'KVM_PMU_EVENT_FMT',
-  'data': ['raw'] }
+  'data': ['raw', 'x86-default'] }
 
 ##
 # @KVMPMURawEvent:
@@ -46,6 +48,25 @@
 { 'struct': 'KVMPMURawEvent',
   'data': { 'code': 'uint64' } }
 
+##
+# @KVMPMUX86DefalutEvent:
+#
+# x86 PMU event encoding with select and umask.
+# raw_event = ((select & 0xf00UL) << 24) | \
+#              (select) & 0xff) | \
+#              ((umask) & 0xff) << 8)
+#
+# @select: x86 PMU event select field, which is a 12-bit unsigned
+#     number.
+#
+# @umask: x86 PMU event umask field.
+#
+# Since 10.0
+##
+{ 'struct': 'KVMPMUX86DefalutEvent',
+  'data': { 'select': 'uint16',
+            'umask': 'uint8' } }
+
 ##
 # @KVMPMUFilterEvent:
 #
@@ -58,7 +79,8 @@
 { 'union': 'KVMPMUFilterEvent',
   'base': { 'format': 'KVMPMUEventEncodeFmt' },
   'discriminator': 'format',
-  'data': { 'raw': 'KVMPMURawEvent' } }
+  'data': { 'raw': 'KVMPMURawEvent',
+            'x86-default': 'KVMPMUX86DefalutEvent' } }
 
 ##
 # @KVMPMUFilterProperty:
@@ -86,6 +108,23 @@
 { 'struct': 'KVMPMURawEventVariant',
   'data': { 'code': 'str' } }
 
+##
+# @KVMPMUX86DefalutEventVariant:
+#
+# The variant of KVMPMUX86DefalutEvent with the string, rather than
+# the numeric value.
+#
+# @select: x86 PMU event select field.  This field is a 12-bit
+#     unsigned number string.
+#
+# @umask: x86 PMU event umask field. This field is a uint8 string.
+#
+# Since 10.0
+##
+{ 'struct': 'KVMPMUX86DefalutEventVariant',
+  'data': { 'select': 'str',
+            'umask': 'str' } }
+
 ##
 # @KVMPMUFilterEventVariant:
 #
@@ -98,7 +137,8 @@
 { 'union': 'KVMPMUFilterEventVariant',
   'base': { 'format': 'KVMPMUEventEncodeFmt' },
   'discriminator': 'format',
-  'data': { 'raw': 'KVMPMURawEventVariant' } }
+  'data': { 'raw': 'KVMPMURawEventVariant',
+            'x86-default': 'KVMPMUX86DefalutEventVariant' } }
 
 ##
 # @KVMPMUFilterPropertyVariant:
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index b82adbed50f4..bab58761417a 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5970,6 +5970,10 @@ static bool kvm_config_pmu_event(KVMPMUFilter *filter,
         case KVM_PMU_EVENT_FMT_RAW:
             code = event->u.raw.code;
             break;
+        case KVM_PMU_EVENT_FMT_X86_DEFAULT:
+            code = X86_PMU_RAW_EVENT(event->u.x86_default.select,
+                                     event->u.x86_default.umask);
+            break;
         default:
             g_assert_not_reached();
         }
@@ -6640,6 +6644,7 @@ static void kvm_arch_check_pmu_filter(const Object *obj, const char *name,
 
         switch (event->format) {
         case KVM_PMU_EVENT_FMT_RAW:
+        case KVM_PMU_EVENT_FMT_X86_DEFAULT:
             break;
         default:
             error_setg(errp,
-- 
2.34.1


