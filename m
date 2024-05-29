Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1C3C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCQB-0005Zd-FC; Wed, 29 May 2024 02:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCQA-0005ZS-Lv
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:22 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCQ8-0002tk-OU
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716962661; x=1748498661;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RFSrIIphD9gfWDiAZ48qCDzXHovswwaxl9K4x9p8XKs=;
 b=muGaeLtU1Pgx4kM6S7cVh7G7Bud1QntEQEbi3kQIYWgmcQQQEMWN2dLX
 BUhhIPHqgkHbjrIL0GScA1n/YS5zaOH4TamxkkUXDPxSOf3qYv8Qo8JxD
 FDNahK+WKLYLD1VQ99YBYdzRHwmYzKpCqzSbQogAoMQMJYDYuro6fb4gC
 XdyPsOxDF7LdMO5JnxlQJjUlZ/bFxqQrNsJeZRc7Ti0TFdEShZf+t0h2j
 /SDaLt8qRVkd46vaFd9RUGPNpTTmvm0SQAB+9Kk0etupvlWMd4W04dOD3
 j0v3omOzzYNLfqL5J30ZR4jqLMxtTdqXGnP7AglKNtcNHR6p5DOsfhJNZ A==;
X-CSE-ConnectionGUID: mSyTAIewQgKtyVQ80FyvnQ==
X-CSE-MsgGUID: Ll80nNUQTDqyJ+Hvqg0Ejg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13187501"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="13187501"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 23:04:20 -0700
X-CSE-ConnectionGUID: zbA52bhITPOu4aptMjHG0w==
X-CSE-MsgGUID: v76N4ltZRJ6tfe71P5sUUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="40144756"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 28 May 2024 23:04:18 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Yongwei Ma <yongwei.ma@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 6/8] tests/unit/test-smp-parse: Test "modules" parameter in
 -smp
Date: Wed, 29 May 2024 14:19:23 +0800
Message-Id: <20240529061925.350323-7-zhao1.liu@intel.com>
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

Cover the module cases in test-smp-parse.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 112 +++++++++++++++++++++++++++++++++---
 1 file changed, 103 insertions(+), 9 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 2214e47ba9c0..01832e5eda32 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -48,17 +48,19 @@
         }
 
 /*
- * Currently a 4-level topology hierarchy is supported on PC machines
- *  -sockets/dies/cores/threads
+ * Currently a 5-level topology hierarchy is supported on PC machines
+ *  -sockets/dies/modules/cores/threads
  */
-#define SMP_CONFIG_WITH_DIES(ha, a, hb, b, hc, c, hd, d, he, e, hf, f) \
+#define SMP_CONFIG_WITH_MODS_DIES(ha, a, hb, b, hc, c, hd, d, \
+                                  he, e, hf, f, hg, g)        \
         {                                                     \
             .has_cpus    = ha, .cpus    = a,                  \
             .has_sockets = hb, .sockets = b,                  \
             .has_dies    = hc, .dies    = c,                  \
-            .has_cores   = hd, .cores   = d,                  \
-            .has_threads = he, .threads = e,                  \
-            .has_maxcpus = hf, .maxcpus = f,                  \
+            .has_modules = hd, .modules = d,                  \
+            .has_cores   = he, .cores   = e,                  \
+            .has_threads = hf, .threads = f,                  \
+            .has_maxcpus = hg, .maxcpus = g,                  \
         }
 
 /*
@@ -345,8 +347,14 @@ static const struct SMPTestData data_generic_valid[] = {
 
 static const struct SMPTestData data_generic_invalid[] = {
     {
+        /* config: -smp 2,modules=2 */
+        .config = SMP_CONFIG_WITH_MODS_DIES(T, 2, F, 0, F, 0, T, 2,
+                                            F, 0, F, 0, F, 0),
+        .expect_error = "modules > 1 not supported by this machine's CPU topology",
+    }, {
         /* config: -smp 2,dies=2 */
-        .config = SMP_CONFIG_WITH_DIES(T, 2, F, 0, T, 2, F, 0, F, 0, F, 0),
+        .config = SMP_CONFIG_WITH_MODS_DIES(T, 2, F, 0, T, 2, F, 0,
+                                            F, 0, F, 0, F, 0),
         .expect_error = "dies > 1 not supported by this machine's CPU topology",
     }, {
         /* config: -smp 2,clusters=2 */
@@ -397,17 +405,39 @@ static const struct SMPTestData data_generic_invalid[] = {
     },
 };
 
+static const struct SMPTestData data_with_modules_invalid[] = {
+    {
+        /* config: -smp 16,sockets=2,modules=2,cores=4,threads=2,maxcpus=16 */
+        .config = SMP_CONFIG_WITH_MODS_DIES(T, 16, T, 2, F, 0, T, 2,
+                                            T, 4, T, 2, T, 16),
+        .expect_error = "Invalid CPU topology: "
+                        "product of the hierarchy must match maxcpus: "
+                        "sockets (2) * modules (2) * cores (4) * threads (2) "
+                        "!= maxcpus (16)",
+    }, {
+        /* config: -smp 34,sockets=2,modules=2,cores=4,threads=2,maxcpus=32 */
+        .config = SMP_CONFIG_WITH_MODS_DIES(T, 34, T, 2, F, 0, T, 2,
+                                            T, 4, T, 2, T, 32),
+        .expect_error = "Invalid CPU topology: "
+                        "maxcpus must be equal to or greater than smp: "
+                        "sockets (2) * modules (2) * cores (4) * threads (2) "
+                        "== maxcpus (32) < smp_cpus (34)",
+    },
+};
+
 static const struct SMPTestData data_with_dies_invalid[] = {
     {
         /* config: -smp 16,sockets=2,dies=2,cores=4,threads=2,maxcpus=16 */
-        .config = SMP_CONFIG_WITH_DIES(T, 16, T, 2, T, 2, T, 4, T, 2, T, 16),
+        .config = SMP_CONFIG_WITH_MODS_DIES(T, 16, T, 2, T, 2, F, 0,
+                                            T, 4, T, 2, T, 16),
         .expect_error = "Invalid CPU topology: "
                         "product of the hierarchy must match maxcpus: "
                         "sockets (2) * dies (2) * cores (4) * threads (2) "
                         "!= maxcpus (16)",
     }, {
         /* config: -smp 34,sockets=2,dies=2,cores=4,threads=2,maxcpus=32 */
-        .config = SMP_CONFIG_WITH_DIES(T, 34, T, 2, T, 2, T, 4, T, 2, T, 32),
+        .config = SMP_CONFIG_WITH_MODS_DIES(T, 34, T, 2, T, 2, F, 0,
+                                            T, 4, T, 2, T, 32),
         .expect_error = "Invalid CPU topology: "
                         "maxcpus must be equal to or greater than smp: "
                         "sockets (2) * dies (2) * cores (4) * threads (2) "
@@ -861,6 +891,13 @@ static void machine_generic_invalid_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = MAX_CPUS - 1;
 }
 
+static void machine_with_modules_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->smp_props.modules_supported = true;
+}
+
 static void machine_with_dies_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -945,6 +982,56 @@ static void test_generic_invalid(const void *opaque)
     object_unref(obj);
 }
 
+static void test_with_modules(const void *opaque)
+{
+    const char *machine_type = opaque;
+    Object *obj = object_new(machine_type);
+    MachineState *ms = MACHINE(obj);
+    MachineClass *mc = MACHINE_GET_CLASS(obj);
+    SMPTestData data = {};
+    unsigned int num_modules = 2;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(data_generic_valid); i++) {
+        data = data_generic_valid[i];
+        unsupported_params_init(mc, &data);
+
+        /* when modules parameter is omitted, it will be set as 1 */
+        data.expect_prefer_sockets.modules = 1;
+        data.expect_prefer_cores.modules = 1;
+
+        smp_parse_test(ms, &data, true);
+
+        /* when modules parameter is specified */
+        data.config.has_modules = true;
+        data.config.modules = num_modules;
+        if (data.config.has_cpus) {
+            data.config.cpus *= num_modules;
+        }
+        if (data.config.has_maxcpus) {
+            data.config.maxcpus *= num_modules;
+        }
+
+        data.expect_prefer_sockets.modules = num_modules;
+        data.expect_prefer_sockets.cpus *= num_modules;
+        data.expect_prefer_sockets.max_cpus *= num_modules;
+        data.expect_prefer_cores.modules = num_modules;
+        data.expect_prefer_cores.cpus *= num_modules;
+        data.expect_prefer_cores.max_cpus *= num_modules;
+
+        smp_parse_test(ms, &data, true);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(data_with_modules_invalid); i++) {
+        data = data_with_modules_invalid[i];
+        unsupported_params_init(mc, &data);
+
+        smp_parse_test(ms, &data, false);
+    }
+
+    object_unref(obj);
+}
+
 static void test_with_dies(const void *opaque)
 {
     const char *machine_type = opaque;
@@ -1303,6 +1390,10 @@ static const TypeInfo smp_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("smp-generic-invalid"),
         .parent         = TYPE_MACHINE,
         .class_init     = machine_generic_invalid_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("smp-with-modules"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = machine_with_modules_class_init,
     }, {
         .name           = MACHINE_TYPE_NAME("smp-with-dies"),
         .parent         = TYPE_MACHINE,
@@ -1344,6 +1435,9 @@ int main(int argc, char *argv[])
     g_test_add_data_func("/test-smp-parse/generic/invalid",
                          MACHINE_TYPE_NAME("smp-generic-invalid"),
                          test_generic_invalid);
+    g_test_add_data_func("/test-smp-parse/with_modules",
+                         MACHINE_TYPE_NAME("smp-with-modules"),
+                         test_with_modules);
     g_test_add_data_func("/test-smp-parse/with_dies",
                          MACHINE_TYPE_NAME("smp-with-dies"),
                          test_with_dies);
-- 
2.34.1


