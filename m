Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329D9E94625
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 03:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdz8-0001m9-FZ; Mon, 09 Feb 2026 22:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyp-0001FT-2m
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 22:00:04 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyj-0004En-8w
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692393; x=1802228393;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k4278D/unK5bwhnrNdxt3ByvRIvl2uTcZ+7sAYt5EQ8=;
 b=FTCQRrhlGPaeb6EDicFIoNZ8bnxUx1Hzm6NT1O5Vzf9+lLZ37evmDVss
 E0N3htA0YzNNNCiHcCtCaaZSi2NeVaje96Xmutp7/YD67AO3B0ejICUUA
 XhMF3YjfQHdiS+ffqG5EM1Zp9poS5+kaKJGGVdeM3fQS9je8GYzvQR+7o
 fW+gt8XnZWnPgmFMdjKG1bxeAWRC5m143VD7FpfvV61fMGGfMz3R3ezEf
 VtPAhmajQrYmLUXoPhXmAx2rhOy4JQJT0j2Gm0jP2oVJZCTzNbBnfECGN
 jCKGk8evC1UdgXutgYTu4gkWr8xasd7A+hhmdQ7X1JFmid4E07PjQWGX2 Q==;
X-CSE-ConnectionGUID: LhZvm5wETU6soCoDWHn4aQ==
X-CSE-MsgGUID: YuQwNruzQ2C4TA/xXjl/IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75660026"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75660026"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:59:52 -0800
X-CSE-ConnectionGUID: R1aMdRTGRnSweM0ElxSd+Q==
X-CSE-MsgGUID: rOuhMUKASpSp2/7FEzorpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800818"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:59:48 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org
Subject: [PATCH v2 21/21] hw/core/qdev-properties: support valid default value
 for DEFINE_PROP_UINT64_CHECKMASK
Date: Tue, 10 Feb 2026 11:23:48 +0800
Message-Id: <20260210032348.987549-22-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210032348.987549-1-zhao1.liu@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DEFINE_PROP_UINT64_CHECKMASK is designed to detect and check user's
property setting:
 * checking: check property value against a bitmask.
 * detection: ask caller to provide an invalid value as the initial
     "sentinel" value, which is impossible to be set by users. However,
     this detection is not strict, since the property could be also
     set internally.

The entire mechanism is not easy to use.

Now there's USER_SET flag in place (and the current unique use case
"lbr-fmt" has been converted to checking USER_SET way), manual setting
of invalid initial values is no longer required.

Thus, extend DEFINE_PROP_UINT64_CHECKMASK to support *valid* default
value, and for "lbr-fmt" case, replace the invalid initialization value
`~PERF_CAP_LBR_FMT` with a valid value `0`.

In addition, considering DEFINE_PROP_UINT64_CHECKMASK itself actually
doesn't identify whether the property is set by the user or not, remove
"user-supplied" related description in its document.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/qdev-properties.c         |  1 +
 include/hw/core/qdev-properties.h | 14 +++++++-------
 target/i386/cpu.c                 |  4 +---
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 91c4010e7dc9..b84214e60f19 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -507,6 +507,7 @@ const PropertyInfo qdev_prop_uint64_checkmask = {
     .type  = "uint64",
     .get   = get_uint64,
     .set   = set_uint64_checkmask,
+    .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
 /* --- pointer-size integer --- */
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index c06de37b1e9d..2ac784bb5e9c 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -128,14 +128,14 @@ extern const PropertyInfo qdev_prop_link;
                 ##__VA_ARGS__)
 
 /**
- * The DEFINE_PROP_UINT64_CHECKMASK macro checks a user-supplied value
- * against corresponding bitmask, rejects the value if it violates.
- * The default value is set in instance_init().
+ * The DEFINE_PROP_UINT64_CHECKMASK macro checks a value against corresponding
+ * bitmask, rejects the value if it violates.
  */
-#define DEFINE_PROP_UINT64_CHECKMASK(_name, _state, _field, _bitmask)   \
-    DEFINE_PROP(_name, _state, _field, qdev_prop_uint64_checkmask, uint64_t, \
-                .bitmask    = (_bitmask),                     \
-                .set_default = false)
+#define DEFINE_PROP_UINT64_CHECKMASK(_name, _state, _field, _bitmask, _defval) \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_uint64_checkmask, uint64_t,   \
+                .bitmask    = (_bitmask),                                      \
+                .set_default = true,                                           \
+                .defval.u    = (_defval))
 
 /**
  * DEFINE_PROP_ARRAY:
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a6d943c53a3f..56735570d66c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10265,9 +10265,7 @@ static void x86_cpu_initfn(Object *obj)
     object_property_add_alias(obj, "pause_filter", obj, "pause-filter");
     object_property_add_alias(obj, "sse4_1", obj, "sse4.1");
     object_property_add_alias(obj, "sse4_2", obj, "sse4.2");
-
     object_property_add_alias(obj, "hv-apicv", obj, "hv-avic");
-    cpu->lbr_fmt = ~PERF_CAP_LBR_FMT;
     object_property_add_alias(obj, "lbr_fmt", obj, "lbr-fmt");
 
     if (xcc->model) {
@@ -10439,7 +10437,7 @@ static const Property x86_cpu_properties[] = {
 #endif
     DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
-    DEFINE_PROP_UINT64_CHECKMASK("lbr-fmt", X86CPU, lbr_fmt, PERF_CAP_LBR_FMT),
+    DEFINE_PROP_UINT64_CHECKMASK("lbr-fmt", X86CPU, lbr_fmt, PERF_CAP_LBR_FMT, 0),
 
     DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
                        HYPERV_SPINLOCK_NEVER_NOTIFY),
-- 
2.34.1


