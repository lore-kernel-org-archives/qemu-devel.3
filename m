Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3283EC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfa76-0006XI-O5; Thu, 29 Feb 2024 01:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa6B-00053I-J8
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:40:55 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa68-0004q0-WA
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709188853; x=1740724853;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pnXXY7cV6/NbWtgIlxRbIk+WzBzlg8AivppAS95ukro=;
 b=Xk9HZ3cYUKl80Nz7lT7XUdw20b+JgCry4z+xmAXywnqy/du+pKQRTOMY
 3y6KNsR/dQwYjg5W3Gl0l9xdaXXGLp4Qxe+mzhYP/TDJzPxntQ6F1thTC
 V8/7B4roU9Zc8JS5WHzdjHDyKZGHSXzxgDnFfenUL9XU+A/+FVI32sQnR
 Z+YXEF+gwz3JV98mieismU29rwNRqoypVQIzsE8KHSVMmbOEn2BVqsQ1j
 OHSJi2UhAeX2xgSZ52hbae+gHskL989B/4iJZD/OcM9bCl1+bLxkVXdOF
 Pgs1C2zbRiqFvtjlbCxmVC0Eoth1KHfzMupK658X+tRLQZM9N0UeX/eEB Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3802816"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3802816"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 22:40:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8075561"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 28 Feb 2024 22:40:45 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, xiaoyao.li@intel.com
Subject: [PATCH v5 30/65] i386/tdx: Support user configurable
 mrconfigid/mrowner/mrownerconfig
Date: Thu, 29 Feb 2024 01:36:51 -0500
Message-Id: <20240229063726.610065-31-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229063726.610065-1-xiaoyao.li@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.596, HK_RANDOM_FROM=0.999, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

Three sha384 hash values, mrconfigid, mrowner and mrownerconfig, of a TD
can be provided for TDX attestation. Detailed meaning of them can be
found: https://lore.kernel.org/qemu-devel/31d6dbc1-f453-4cef-ab08-4813f4e0ff92@intel.com/

Allow user to specify those values via property mrconfigid, mrowner and
mrownerconfig. They are all in base64 format.

example
-object tdx-guest, \
  mrconfigid=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
  mrowner=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
  mrownerconfig=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

---
Changes in v5:
 - refine the description of QAPI properties and add description of
   default value when not specified;

Changes in v4:
 - describe more of there fields in qom.json
 - free the old value before set new value to avoid memory leak in
   _setter(); (Daniel)

Changes in v3:
 - use base64 encoding instread of hex-string;
---
 qapi/qom.json         | 17 ++++++++-
 target/i386/kvm/tdx.c | 87 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.h |  3 ++
 3 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 89ed89b9b46e..cac875349a3a 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -905,10 +905,25 @@
 #     pages.  Some guest OS (e.g., Linux TD guest) may require this to
 #     be set, otherwise they refuse to boot.
 #
+# @mrconfigid: ID for non-owner-defined configuration of the guest TD,
+#     e.g., run-time or OS configuration (base64 encoded SHA384 digest).
+#     (A default value 0 of SHA384 is used when absent).
+#
+# @mrowner: ID for the guest TD’s owner (base64 encoded SHA384 digest).
+#     (A default value 0 of SHA384 is used when absent).
+#
+# @mrownerconfig: ID for owner-defined configuration of the guest TD,
+#     e.g., specific to the workload rather than the run-time or OS
+#     (base64 encoded SHA384 digest). (A default value 0 of SHA384 is
+#     used when absent).
+#
 # Since: 9.0
 ##
 { 'struct': 'TdxGuestProperties',
-  'data': { '*sept-ve-disable': 'bool' } }
+  'data': { '*sept-ve-disable': 'bool',
+            '*mrconfigid': 'str',
+            '*mrowner': 'str',
+            '*mrownerconfig': 'str' } }
 
 ##
 # @ThreadContextProperties:
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index d0ad4f57b5d0..4ce2f1d082ce 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/base64.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
 #include "standard-headers/asm-x86/kvm_para.h"
@@ -516,6 +517,7 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
     X86CPU *x86cpu = X86_CPU(cpu);
     CPUX86State *env = &x86cpu->env;
     g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
+    size_t data_len;
     int r = 0;
 
     object_property_set_bool(OBJECT(cpu), "pmu", false, &error_abort);
@@ -528,6 +530,38 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
     init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
                         sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
 
+#define SHA384_DIGEST_SIZE  48
+
+    if (tdx_guest->mrconfigid) {
+        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrconfigid,
+                              strlen(tdx_guest->mrconfigid), &data_len, errp);
+        if (!data || data_len != SHA384_DIGEST_SIZE) {
+            error_setg(errp, "TDX: failed to decode mrconfigid");
+            return -1;
+        }
+        memcpy(init_vm->mrconfigid, data, data_len);
+    }
+
+    if (tdx_guest->mrowner) {
+        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrowner,
+                              strlen(tdx_guest->mrowner), &data_len, errp);
+        if (!data || data_len != SHA384_DIGEST_SIZE) {
+            error_setg(errp, "TDX: failed to decode mrowner");
+            return -1;
+        }
+        memcpy(init_vm->mrowner, data, data_len);
+    }
+
+    if (tdx_guest->mrownerconfig) {
+        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrownerconfig,
+                              strlen(tdx_guest->mrownerconfig), &data_len, errp);
+        if (!data || data_len != SHA384_DIGEST_SIZE) {
+            error_setg(errp, "TDX: failed to decode mrownerconfig");
+            return -1;
+        }
+        memcpy(init_vm->mrownerconfig, data, data_len);
+    }
+
     r = kvm_vm_enable_cap(kvm_state, KVM_CAP_MAX_VCPUS, 0, ms->smp.cpus);
     if (r < 0) {
         error_setg(errp, "Unable to set MAX VCPUS to %d", ms->smp.cpus);
@@ -574,6 +608,51 @@ static void tdx_guest_set_sept_ve_disable(Object *obj, bool value, Error **errp)
     }
 }
 
+static char * tdx_guest_get_mrconfigid(Object *obj, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    return g_strdup(tdx->mrconfigid);
+}
+
+static void tdx_guest_set_mrconfigid(Object *obj, const char *value, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    g_free(tdx->mrconfigid);
+    tdx->mrconfigid = g_strdup(value);
+}
+
+static char * tdx_guest_get_mrowner(Object *obj, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    return g_strdup(tdx->mrowner);
+}
+
+static void tdx_guest_set_mrowner(Object *obj, const char *value, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    g_free(tdx->mrowner);
+    tdx->mrowner = g_strdup(value);
+}
+
+static char * tdx_guest_get_mrownerconfig(Object *obj, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    return g_strdup(tdx->mrownerconfig);
+}
+
+static void tdx_guest_set_mrownerconfig(Object *obj, const char *value, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    g_free(tdx->mrownerconfig);
+    tdx->mrownerconfig = g_strdup(value);
+}
+
 /* tdx guest */
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
                                    tdx_guest,
@@ -593,6 +672,14 @@ static void tdx_guest_init(Object *obj)
     object_property_add_bool(obj, "sept-ve-disable",
                              tdx_guest_get_sept_ve_disable,
                              tdx_guest_set_sept_ve_disable);
+    object_property_add_str(obj, "mrconfigid",
+                            tdx_guest_get_mrconfigid,
+                            tdx_guest_set_mrconfigid);
+    object_property_add_str(obj, "mrowner",
+                            tdx_guest_get_mrowner, tdx_guest_set_mrowner);
+    object_property_add_str(obj, "mrownerconfig",
+                            tdx_guest_get_mrownerconfig,
+                            tdx_guest_set_mrownerconfig);
 }
 
 static void tdx_guest_finalize(Object *obj)
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 0df910725b52..2697e6bdfb1d 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -21,6 +21,9 @@ typedef struct TdxGuest {
 
     bool initialized;
     uint64_t attributes;    /* TD attributes */
+    char *mrconfigid;       /* base64 encoded sha348 digest */
+    char *mrowner;          /* base64 encoded sha348 digest */
+    char *mrownerconfig;    /* base64 encoded sha348 digest */
 } TdxGuest;
 
 #ifdef CONFIG_TDX
-- 
2.34.1


