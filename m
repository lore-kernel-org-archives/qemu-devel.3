Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AF5C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhnlq-0007cU-H9; Wed, 06 Mar 2024 04:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlp-0007cJ-Jz
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:41:05 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnln-0002K2-IN
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709718063; x=1741254063;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=98NJKETcDZW1zOOely50ceE+NQ46Hd2eboqvtOsOfq8=;
 b=XZDUzoMWaT8MmGVFXhxmC8fy8gyDxnJ84KINerku0RciMO87DFyC2ro2
 JDVp+xzRyx06QdaSo7VhsHR1t9+moxW9PqB0tETwOYmwW6cq9n86QVZV+
 IT1zmI1t+lwM46sgbvZxe4fwzob1lPv9GoKTwYfipc179/ZMtDEczMSBK
 naNDTRGASmxQfq8MGt5Bj7wnEY5iWYnWKef0IzG3VYiNFvgiSUDaNt8OE
 JVN1R2FqZvE3kODnOqXBmoYNjmVNLUOCeBywtaC+DBYaIFk3uSXqHF54d
 ATXrRPXVPUqNZaOkoRUBSKhWgaZSrGH/YWilEnmtA+Jn3ynOKt7xU3RC/ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14897939"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="14897939"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 01:41:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="32854185"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 06 Mar 2024 01:41:00 -0800
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
Subject: [PATCH 12/14] tests/unit/test-smp-parse: Test the full 7-levels
 topology hierarchy
Date: Wed,  6 Mar 2024 17:54:05 +0800
Message-Id: <20240306095407.3058909-13-zhao1.liu@linux.intel.com>
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

Currently, -smp supports up to 7-levels topology hierarchy:
  -drawers/books/sockets/dies/clusters/cores/threads.

Though no machine supports all these 7 levels yet, these 7 levels have
the strict containment relationship and together form the generic CPU
topology representation of QEMU.

Also, note that the maxcpus is calculated by multiplying all 7 levels:

  maxcpus = drawers * books * sockets * dies * clusters *
            cores * threads.

To cover this code path, it is necessary to test the full topology case
(with all 7 levels). This also helps to avoid introducing new issues by
further expanding the CPU topology in the future.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Xiaoling Song <xiaoling.song@intel.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-smp-parse.c | 143 ++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 0cf611519865..75581691713c 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -91,6 +91,24 @@
             .has_maxcpus  = hg, .maxcpus  = g,                 \
         }
 
+/*
+ * Currently QEMU supports up to a 7-level topology hierarchy, which is the
+ * QEMU's unified abstract representation of CPU topology.
+ *  -drawers/books/sockets/dies/clusters/cores/threads
+ */
+#define SMP_CONFIG_WITH_FULL_TOPO(a, b, c, d, e, f, g, h, i)    \
+        {                                                       \
+            .has_cpus     = true, .cpus     = a,                \
+            .has_drawers  = true, .drawers  = b,                \
+            .has_books    = true, .books    = c,                \
+            .has_sockets  = true, .sockets  = d,                \
+            .has_dies     = true, .dies     = e,                \
+            .has_clusters = true, .clusters = f,                \
+            .has_cores    = true, .cores    = g,                \
+            .has_threads  = true, .threads  = h,                \
+            .has_maxcpus  = true, .maxcpus  = i,                \
+        }
+
 /**
  * @config - the given SMP configuration
  * @expect_prefer_sockets - the expected parsing result for the
@@ -472,6 +490,40 @@ static const struct SMPTestData data_with_drawers_books_invalid[] = {
     },
 };
 
+static const struct SMPTestData data_full_topo_invalid[] = {
+    {
+        /*
+         * config: -smp 200,drawers=3,books=5,sockets=2,dies=4,\
+         *              clusters=2,cores=7,threads=2,maxcpus=200
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(200, 3, 5, 2, 4, 2, 7, 2, 200),
+        .expect_error = "Invalid CPU topology: "
+                        "product of the hierarchy must match maxcpus: "
+                        "drawers (3) * books (5) * sockets (2) * dies (4) * "
+                        "clusters (2) * cores (7) * threads (2) "
+                        "!= maxcpus (200)",
+    }, {
+        /*
+         * config: -smp 3361,drawers=3,books=5,sockets=2,dies=4,\
+         *              clusters=2,cores=7,threads=2,maxcpus=3360
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(3361, 3, 5, 2, 4, 2, 7, 2, 3360),
+        .expect_error = "Invalid CPU topology: "
+                        "maxcpus must be equal to or greater than smp: "
+                        "drawers (3) * books (5) * sockets (2) * dies (4) * "
+                        "clusters (2) * cores (7) * threads (2) "
+                        "== maxcpus (3360) < smp_cpus (3361)",
+    }, {
+        /*
+         * config: -smp 1,drawers=3,books=5,sockets=2,dies=4,\
+         *              clusters=2,cores=7,threads=3,maxcpus=5040
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(3361, 3, 5, 2, 4, 2, 7, 3, 5040),
+        .expect_error = "Invalid SMP CPUs 5040. The max CPUs supported "
+                        "by machine '" SMP_MACHINE_NAME "' is 4096",
+    },
+};
+
 static char *smp_config_to_string(const SMPConfiguration *config)
 {
     return g_strdup_printf(
@@ -733,6 +785,16 @@ static void machine_with_drawers_books_class_init(ObjectClass *oc, void *data)
     mc->smp_props.books_supported = true;
 }
 
+static void machine_full_topo_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->smp_props.drawers_supported = true;
+    mc->smp_props.books_supported = true;
+    mc->smp_props.dies_supported = true;
+    mc->smp_props.clusters_supported = true;
+}
+
 static void test_generic_valid(const void *opaque)
 {
     const char *machine_type = opaque;
@@ -1032,6 +1094,80 @@ static void test_with_drawers_books(const void *opaque)
     object_unref(obj);
 }
 
+static void test_full_topo(const void *opaque)
+{
+    const char *machine_type = opaque;
+    Object *obj = object_new(machine_type);
+    MachineState *ms = MACHINE(obj);
+    MachineClass *mc = MACHINE_GET_CLASS(obj);
+    SMPTestData data = {};
+    unsigned int drawers = 5, books = 3, dies = 2, clusters = 7, multiplier;
+    int i;
+
+    multiplier = drawers * books * dies * clusters;
+    for (i = 0; i < ARRAY_SIZE(data_generic_valid); i++) {
+        data = data_generic_valid[i];
+        unsupported_params_init(mc, &data);
+
+        /*
+         * when drawers, books, dies and clusters parameters are omitted,
+         * they will be set as 1.
+         */
+        data.expect_prefer_sockets.drawers = 1;
+        data.expect_prefer_sockets.books = 1;
+        data.expect_prefer_sockets.dies = 1;
+        data.expect_prefer_sockets.clusters = 1;
+        data.expect_prefer_cores.drawers = 1;
+        data.expect_prefer_cores.books = 1;
+        data.expect_prefer_cores.dies = 1;
+        data.expect_prefer_cores.clusters = 1;
+
+        smp_parse_test(ms, &data, true);
+
+        /* when drawers, books, dies and clusters parameters are specified. */
+        data.config.has_drawers = true;
+        data.config.drawers = drawers;
+        data.config.has_books = true;
+        data.config.books = books;
+        data.config.has_dies = true;
+        data.config.dies = dies;
+        data.config.has_clusters = true;
+        data.config.clusters = clusters;
+
+        if (data.config.has_cpus) {
+            data.config.cpus *= multiplier;
+        }
+        if (data.config.has_maxcpus) {
+            data.config.maxcpus *= multiplier;
+        }
+
+        data.expect_prefer_sockets.drawers = drawers;
+        data.expect_prefer_sockets.books = books;
+        data.expect_prefer_sockets.dies = dies;
+        data.expect_prefer_sockets.clusters = clusters;
+        data.expect_prefer_sockets.cpus *= multiplier;
+        data.expect_prefer_sockets.max_cpus *= multiplier;
+
+        data.expect_prefer_cores.drawers = drawers;
+        data.expect_prefer_cores.books = books;
+        data.expect_prefer_cores.dies = dies;
+        data.expect_prefer_cores.clusters = clusters;
+        data.expect_prefer_cores.cpus *= multiplier;
+        data.expect_prefer_cores.max_cpus *= multiplier;
+
+        smp_parse_test(ms, &data, true);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(data_full_topo_invalid); i++) {
+        data = data_full_topo_invalid[i];
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
@@ -1068,6 +1204,10 @@ static const TypeInfo smp_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("smp-with-drawers-books"),
         .parent         = TYPE_MACHINE,
         .class_init     = machine_with_drawers_books_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("smp-full-topo"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = machine_full_topo_class_init,
     }
 };
 
@@ -1100,6 +1240,9 @@ int main(int argc, char *argv[])
     g_test_add_data_func("/test-smp-parse/with_drawers_books",
                          MACHINE_TYPE_NAME("smp-with-drawers-books"),
                          test_with_drawers_books);
+    g_test_add_data_func("/test-smp-parse/full",
+                         MACHINE_TYPE_NAME("smp-full-topo"),
+                         test_full_topo);
 
     g_test_run();
 
-- 
2.34.1


