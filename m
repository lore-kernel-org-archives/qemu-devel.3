Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1028AC3DA47
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 04:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRP3x-0005yM-5R; Wed, 10 Jul 2024 00:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sRP3v-0005tO-SL; Wed, 10 Jul 2024 00:36:15 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sRP3t-0006tm-RO; Wed, 10 Jul 2024 00:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720586173; x=1752122173;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=il1oqspy53sUEFgjjMRnGbdzD5ZqcNCxcsioWrvP064=;
 b=FdMpW9MHN3qYnxMhQt+gB+uVo/Ca/iHDVfrvZ6F8+5fp6ew0v7aGt+Nb
 gkI9pbfgBawrIpge355eao0P8o7LGg9NzzAqJYBMBUGQQfu4exTdj5HX3
 o4AbuullQnix2As8Gsba+fgN2t1854ttl7ySWRP9+T4yHJtzm0/ePCWNH
 kGzeEr5NFMPHyLuI2keePtqdyYe0ejObwtEygSsTueH9ABhRM7a3jtiLY
 z6jyZ5Ccw9hRGgofOnNR78didkMxZClXdRcQF8ErIQ0UWwCxNsqGRr069
 XwOyu1rBt3lR0wZcNBcBrHeBUoIKJzStyvgGCawlIJ+Aftai9KydblUZ7 A==;
X-CSE-ConnectionGUID: YrjsECkISjGgqr5xWz8kVA==
X-CSE-MsgGUID: pSY3Z0OGTqyyj/biRPQZJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="28473798"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; d="scan'208";a="28473798"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 21:36:12 -0700
X-CSE-ConnectionGUID: XUATnMDHTsqI9za+FGvJzw==
X-CSE-MsgGUID: FNhK2+48SASyPAGhC9c+wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; d="scan'208";a="79238185"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 09 Jul 2024 21:36:08 -0700
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
Subject: [RFC 3/5] i386/kvm: Support event with select&umask format in KVM PMU
 filter
Date: Wed, 10 Jul 2024 12:51:15 +0800
Message-Id: <20240710045117.3164577-4-zhao1.liu@intel.com>
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

The select&umask is the common way for x86 to identify the PMU event,
so support this way as the "x86-default" format in kvm-pmu-filter
object.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 accel/kvm/kvm-pmu.c      | 62 ++++++++++++++++++++++++++++++++++++++++
 include/sysemu/kvm-pmu.h | 13 +++++++++
 qapi/kvm.json            | 46 +++++++++++++++++++++++++++--
 target/i386/kvm/kvm.c    |  5 ++++
 4 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-pmu.c b/accel/kvm/kvm-pmu.c
index 483d1bdf4807..51d3fba5a72a 100644
--- a/accel/kvm/kvm-pmu.c
+++ b/accel/kvm/kvm-pmu.c
@@ -17,6 +17,8 @@
 #include "qom/object_interfaces.h"
 #include "sysemu/kvm-pmu.h"
 
+#define UINT12_MAX (4095)
+
 static void kvm_pmu_filter_get_event(Object *obj, Visitor *v, const char *name,
                                      void *opaque, Error **errp)
 {
@@ -38,6 +40,12 @@ static void kvm_pmu_filter_get_event(Object *obj, Visitor *v, const char *name,
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
@@ -83,6 +91,60 @@ static void kvm_pmu_filter_set_event(Object *obj, Visitor *v, const char *name,
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
diff --git a/include/sysemu/kvm-pmu.h b/include/sysemu/kvm-pmu.h
index 4707759761f1..707f33d604fd 100644
--- a/include/sysemu/kvm-pmu.h
+++ b/include/sysemu/kvm-pmu.h
@@ -26,4 +26,17 @@ struct KVMPMUFilter {
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
index 0619da83c123..0d759884c229 100644
--- a/qapi/kvm.json
+++ b/qapi/kvm.json
@@ -27,11 +27,13 @@
 #
 # @raw: the encoded event code that KVM can directly consume.
 #
+# @x86-default: standard x86 encoding format with select and umask.
+#
 # Since 9.1
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
+# Since 9.1
+##
+{ 'struct': 'KVMPMUX86DefalutEvent',
+  'data': { 'select': 'uint16',
+            'umask': 'uint8' } }
+
 ##
 # @KVMPMUFilterEvent:
 #
@@ -61,7 +82,8 @@
   'base': { 'action': 'KVMPMUFilterAction',
             'format': 'KVMPMUEventEncodeFmt' },
   'discriminator': 'format',
-  'data': { 'raw': 'KVMPMURawEvent' } }
+  'data': { 'raw': 'KVMPMURawEvent',
+            'x86-default': 'KVMPMUX86DefalutEvent' } }
 
 ##
 # @KVMPMUFilterProperty:
@@ -89,6 +111,23 @@
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
+# Since 9.1
+##
+{ 'struct': 'KVMPMUX86DefalutEventVariant',
+  'data': { 'select': 'str',
+            'umask': 'str' } }
+
 ##
 # @KVMPMUFilterEventVariant:
 #
@@ -104,7 +143,8 @@
   'base': { 'action': 'KVMPMUFilterAction',
             'format': 'KVMPMUEventEncodeFmt' },
   'discriminator': 'format',
-  'data': { 'raw': 'KVMPMURawEventVariant' } }
+  'data': { 'raw': 'KVMPMURawEventVariant',
+            'x86-default': 'KVMPMUX86DefalutEventVariant' } }
 
 ##
 # @KVMPMUFilterPropertyVariant:
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e9bf79782316..391531c036a6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5393,6 +5393,10 @@ kvm_config_pmu_event(KVMPMUFilter *filter,
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
@@ -6073,6 +6077,7 @@ static void kvm_arch_check_pmu_filter(const Object *obj, const char *name,
 
         switch (event->format) {
         case KVM_PMU_EVENT_FMT_RAW:
+        case KVM_PMU_EVENT_FMT_X86_DEFAULT:
             break;
         default:
             error_setg(errp,
-- 
2.34.1


