Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA86CC25B7E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCQF-0005aY-39; Wed, 29 May 2024 02:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCQD-0005aK-S2
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:25 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCQC-0002vg-2D
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716962664; x=1748498664;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1tROmMxTH8Fj6lqefijwEFqOzoduSv9Zi31JvU5h8iI=;
 b=aXLvbRABnN9TNBIBN7lvwX8+0KPorbDJ4piq4aQH7MIrVY2NhBY+q8oq
 TCs9/HHbJIVa4WbYPwvEthQ/4vCaFOZbzQj3rMspCYt2Mb8Jy0Gd+qeJh
 0LxMZPjldZwkhaank6Ca/iJvup9lm5CFJjEcXDgVEzwoMG9CNUkO6Z0Lg
 ARVDYlFqds3IgGdqddaOpbzDAeJYfKSoc+c9ERN/vQrhPPCq4g/lvXmhz
 764gvcWeGcwYH65sLmq+FL5PCiepGg/7HEuzVKf24IH5hgg4D0IXB4csV
 MSLlErgnCYyJhEXGgj95jr03pskksj/+bKg52UvOXKGjhqw9DpX9ASRND g==;
X-CSE-ConnectionGUID: U57plTq0R+6RaMssAWveEQ==
X-CSE-MsgGUID: WIddqH/HTdaO6YxuEmhEtA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13187507"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="13187507"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 23:04:23 -0700
X-CSE-ConnectionGUID: KS823CJJTy6ntd77w0bpWw==
X-CSE-MsgGUID: BIQ9OmQLRDiyCMqPr1WXUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="40144765"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 28 May 2024 23:04:21 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Yongwei Ma <yongwei.ma@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 7/8] tests/unit/test-smp-parse: Test "modules" and "dies"
 combination case
Date: Wed, 29 May 2024 14:19:24 +0800
Message-Id: <20240529061925.350323-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529061925.350323-1-zhao1.liu@intel.com>
References: <20240529061925.350323-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since i386 PC machine supports both "modules" and "dies" in -smp, add the
"modules" and "dies" combination test case to match the actual topology
usage scenario.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 103 ++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 01832e5eda32..2ca8530e935e 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -445,6 +445,33 @@ static const struct SMPTestData data_with_dies_invalid[] = {
     },
 };
 
+static const struct SMPTestData data_with_modules_dies_invalid[] = {
+    {
+        /*
+         * config: -smp 200,sockets=3,dies=5,modules=2,cores=4,\
+         * threads=2,maxcpus=200
+         */
+        .config = SMP_CONFIG_WITH_MODS_DIES(T, 200, T, 3, T, 5, T,
+                                            2, T, 4, T, 2, T, 200),
+        .expect_error = "Invalid CPU topology: "
+                        "product of the hierarchy must match maxcpus: "
+                        "sockets (3) * dies (5) * modules (2) * "
+                        "cores (4) * threads (2) != maxcpus (200)",
+    }, {
+        /*
+         * config: -smp 242,sockets=3,dies=5,modules=2,cores=4,\
+         * threads=2,maxcpus=240
+         */
+        .config = SMP_CONFIG_WITH_MODS_DIES(T, 242, T, 3, T, 5, T,
+                                            2, T, 4, T, 2, T, 240),
+        .expect_error = "Invalid CPU topology: "
+                        "maxcpus must be equal to or greater than smp: "
+                        "sockets (3) * dies (5) * modules (2) * "
+                        "cores (4) * threads (2) "
+                        "== maxcpus (240) < smp_cpus (242)",
+    },
+};
+
 static const struct SMPTestData data_with_clusters_invalid[] = {
     {
         /* config: -smp 16,sockets=2,clusters=2,cores=4,threads=2,maxcpus=16 */
@@ -905,6 +932,14 @@ static void machine_with_dies_class_init(ObjectClass *oc, void *data)
     mc->smp_props.dies_supported = true;
 }
 
+static void machine_with_modules_dies_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->smp_props.modules_supported = true;
+    mc->smp_props.dies_supported = true;
+}
+
 static void machine_with_clusters_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1082,6 +1117,67 @@ static void test_with_dies(const void *opaque)
     object_unref(obj);
 }
 
+static void test_with_modules_dies(const void *opaque)
+{
+    const char *machine_type = opaque;
+    Object *obj = object_new(machine_type);
+    MachineState *ms = MACHINE(obj);
+    MachineClass *mc = MACHINE_GET_CLASS(obj);
+    SMPTestData data = {};
+    unsigned int num_modules = 5, num_dies = 3;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(data_generic_valid); i++) {
+        data = data_generic_valid[i];
+        unsupported_params_init(mc, &data);
+
+        /*
+         * when modules and dies parameters are omitted, they will
+         * be both set as 1.
+         */
+        data.expect_prefer_sockets.modules = 1;
+        data.expect_prefer_sockets.dies = 1;
+        data.expect_prefer_cores.modules = 1;
+        data.expect_prefer_cores.dies = 1;
+
+        smp_parse_test(ms, &data, true);
+
+        /* when modules and dies parameters are both specified */
+        data.config.has_modules = true;
+        data.config.modules = num_modules;
+        data.config.has_dies = true;
+        data.config.dies = num_dies;
+
+        if (data.config.has_cpus) {
+            data.config.cpus *= num_modules * num_dies;
+        }
+        if (data.config.has_maxcpus) {
+            data.config.maxcpus *= num_modules * num_dies;
+        }
+
+        data.expect_prefer_sockets.modules = num_modules;
+        data.expect_prefer_sockets.dies = num_dies;
+        data.expect_prefer_sockets.cpus *= num_modules * num_dies;
+        data.expect_prefer_sockets.max_cpus *= num_modules * num_dies;
+
+        data.expect_prefer_cores.modules = num_modules;
+        data.expect_prefer_cores.dies = num_dies;
+        data.expect_prefer_cores.cpus *= num_modules * num_dies;
+        data.expect_prefer_cores.max_cpus *= num_modules * num_dies;
+
+        smp_parse_test(ms, &data, true);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(data_with_modules_dies_invalid); i++) {
+        data = data_with_modules_dies_invalid[i];
+        unsupported_params_init(mc, &data);
+
+        smp_parse_test(ms, &data, false);
+    }
+
+    object_unref(obj);
+}
+
 static void test_with_clusters(const void *opaque)
 {
     const char *machine_type = opaque;
@@ -1398,6 +1494,10 @@ static const TypeInfo smp_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("smp-with-dies"),
         .parent         = TYPE_MACHINE,
         .class_init     = machine_with_dies_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("smp-with-modules-dies"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = machine_with_modules_dies_class_init,
     }, {
         .name           = MACHINE_TYPE_NAME("smp-with-clusters"),
         .parent         = TYPE_MACHINE,
@@ -1441,6 +1541,9 @@ int main(int argc, char *argv[])
     g_test_add_data_func("/test-smp-parse/with_dies",
                          MACHINE_TYPE_NAME("smp-with-dies"),
                          test_with_dies);
+    g_test_add_data_func("/test-smp-parse/with_modules_dies",
+                         MACHINE_TYPE_NAME("smp-with-modules-dies"),
+                         test_with_modules_dies);
     g_test_add_data_func("/test-smp-parse/with_clusters",
                          MACHINE_TYPE_NAME("smp-with-clusters"),
                          test_with_clusters);
-- 
2.34.1


