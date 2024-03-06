Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11903C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhnll-0007YQ-NL; Wed, 06 Mar 2024 04:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlj-0007YI-E2
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:41:00 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlh-0002K2-F4
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709718057; x=1741254057;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wJPjIQhDPSLtPOJIxXDJGeEyfUjDSVN/nM6zcVB97uM=;
 b=Q4n32BCqpib2IPMAAqaimYWNhQWxRf89OJbJ6/MOJNMieI7yXkd4n8je
 VfDxLe2EX6JVr92nr9EYBYSKVW20KfhiGqAkb7mMefCX6EaB/HaOpt8Ce
 byTMAsm+QXplZij5QXz4TBEe8HxOx0hVX4fr0fteFjTFPyk0wClHR3X7O
 UargV/oq3GR9RbkQGuTqP8mthG1jrmnd7APcjhipUZt1OxBd+w+jcjo1V
 QjXNnqEn13hyjN98XxL6euLgNh2TpOfboWHRontT5BhpCDgCr/AmmhRSa
 zNm+6n5j1vBdaN1rgb5wmJV2G4UvPA4Hj0yvYK1rrgOftF5Vg9NSjWKti g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14897921"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="14897921"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 01:40:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="32854168"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 06 Mar 2024 01:40:54 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: Xiaoling Song <xiaoling.song@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 10/14] tests/unit/test-smp-parse: Test "drawers" parameter in
 -smp
Date: Wed,  6 Mar 2024 17:54:03 +0800
Message-Id: <20240306095407.3058909-11-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Although drawer was introduced to -smp along with book by s390 machine,
as a general topology level in QEMU that may be reused by other arches
in the future, it is desirable to cover this parameter's parsing in a
separate case.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Xiaoling Song <xiaoling.song@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-smp-parse.c | 89 +++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 090238ab23f8..aea1b2e73a55 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -329,6 +329,11 @@ static const struct SMPTestData data_generic_invalid[] = {
         .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 2, F, 0, T, 2, F,
                                                 0, F, 0, F, 0, F, 0),
         .expect_error = "books not supported by this machine's CPU topology",
+    }, {
+        /* config: -smp 2,drawers=2 */
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 2, T, 2, F, 0, F,
+                                                0, F, 0, F, 0, F, 0),
+        .expect_error = "drawers not supported by this machine's CPU topology",
     }, {
         /* config: -smp 8,sockets=2,cores=4,threads=2,maxcpus=8 */
         .config = SMP_CONFIG_GENERIC(T, 8, T, 2, T, 4, T, 2, T, 8),
@@ -420,6 +425,26 @@ static const struct SMPTestData data_with_books_invalid[] = {
     },
 };
 
+static const struct SMPTestData data_with_drawers_invalid[] = {
+    {
+        /* config: -smp 16,drawers=2,sockets=2,cores=4,threads=2,maxcpus=16 */
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 16, T, 2, F, 1, T,
+                                                2, T, 4, T, 2, T, 16),
+        .expect_error = "Invalid CPU topology: "
+                        "product of the hierarchy must match maxcpus: "
+                        "drawers (2) * sockets (2) * cores (4) * threads (2) "
+                        "!= maxcpus (16)",
+    }, {
+        /* config: -smp 34,drawers=2,sockets=2,cores=4,threads=2,maxcpus=32 */
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 34, T, 2, F, 1, T,
+                                                2, T, 4, T, 2, T, 32),
+        .expect_error = "Invalid CPU topology: "
+                        "maxcpus must be equal to or greater than smp: "
+                        "drawers (2) * sockets (2) * cores (4) * threads (2) "
+                        "== maxcpus (32) < smp_cpus (34)",
+    },
+};
+
 static char *smp_config_to_string(const SMPConfiguration *config)
 {
     return g_strdup_printf(
@@ -666,6 +691,13 @@ static void machine_with_books_class_init(ObjectClass *oc, void *data)
     mc->smp_props.books_supported = true;
 }
 
+static void machine_with_drawers_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->smp_props.drawers_supported = true;
+}
+
 static void test_generic_valid(const void *opaque)
 {
     const char *machine_type = opaque;
@@ -854,6 +886,56 @@ static void test_with_books(const void *opaque)
     object_unref(obj);
 }
 
+static void test_with_drawers(const void *opaque)
+{
+    const char *machine_type = opaque;
+    Object *obj = object_new(machine_type);
+    MachineState *ms = MACHINE(obj);
+    MachineClass *mc = MACHINE_GET_CLASS(obj);
+    SMPTestData data = {};
+    unsigned int num_drawers = 2;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(data_generic_valid); i++) {
+        data = data_generic_valid[i];
+        unsupported_params_init(mc, &data);
+
+        /* when drawers parameter is omitted, it will be set as 1 */
+        data.expect_prefer_sockets.drawers = 1;
+        data.expect_prefer_cores.drawers = 1;
+
+        smp_parse_test(ms, &data, true);
+
+        /* when drawers parameter is specified */
+        data.config.has_drawers = true;
+        data.config.drawers = num_drawers;
+        if (data.config.has_cpus) {
+            data.config.cpus *= num_drawers;
+        }
+        if (data.config.has_maxcpus) {
+            data.config.maxcpus *= num_drawers;
+        }
+
+        data.expect_prefer_sockets.drawers = num_drawers;
+        data.expect_prefer_sockets.cpus *= num_drawers;
+        data.expect_prefer_sockets.max_cpus *= num_drawers;
+        data.expect_prefer_cores.drawers = num_drawers;
+        data.expect_prefer_cores.cpus *= num_drawers;
+        data.expect_prefer_cores.max_cpus *= num_drawers;
+
+        smp_parse_test(ms, &data, true);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(data_with_drawers_invalid); i++) {
+        data = data_with_drawers_invalid[i];
+        unsupported_params_init(mc, &data);
+
+        smp_parse_test(ms, &data, false);
+    }
+
+    object_unref(obj);
+}
+
 /* Type info of the tested machine */
 static const TypeInfo smp_machine_types[] = {
     {
@@ -882,6 +964,10 @@ static const TypeInfo smp_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("smp-with-books"),
         .parent         = TYPE_MACHINE,
         .class_init     = machine_with_books_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("smp-with-drawers"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = machine_with_drawers_class_init,
     }
 };
 
@@ -908,6 +994,9 @@ int main(int argc, char *argv[])
     g_test_add_data_func("/test-smp-parse/with_books",
                          MACHINE_TYPE_NAME("smp-with-books"),
                          test_with_books);
+    g_test_add_data_func("/test-smp-parse/with_drawers",
+                         MACHINE_TYPE_NAME("smp-with-drawers"),
+                         test_with_drawers);
 
     g_test_run();
 
-- 
2.34.1


