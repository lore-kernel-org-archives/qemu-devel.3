Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEA7C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhnlf-0007XT-9r; Wed, 06 Mar 2024 04:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnld-0007XF-HL
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:54 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlb-0002K2-SV
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709718052; x=1741254052;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3yBYX2nAWb+HDAcrhm+cAUvXQKvQu/GD/FeL85SWXFA=;
 b=mM0eyEXMJiQMEfiFJyypkGcieEI/xhfZGQE+lmtgMAAWv3dHwCkj8fWS
 cxdTMSAmesbyrVYDaJi+yWCMH9i1cHZ8cidflOlBkULp5jEd15dXjIO87
 yNwB4MgrOzk8EAyu7aduHHHuNAzHmv9fr9xmGRH7GbkQ8nH0Xw5qgNcUS
 WNtURN8EPVivpikqpFYaHM+QtA5LBV9fy8TWlR4QP2QR7Pqgw62mhY8eJ
 Ys3yNEBp5fgHRmmKhxQzjtmfAnIEaDuQE2TZf1Gb+fgohU/VIin6O2Jzq
 n1ue0hX7O75E8EYfYGz6ecTbYeXGrJ2/TdgxhhQ9Hto8O7gAAMTV5/9/0 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14897891"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="14897891"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 01:40:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="32854159"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 06 Mar 2024 01:40:48 -0800
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
Subject: [PATCH 08/14] tests/unit/test-smp-parse: Make test cases aware of the
 book/drawer
Date: Wed,  6 Mar 2024 17:54:01 +0800
Message-Id: <20240306095407.3058909-9-zhao1.liu@linux.intel.com>
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

Currently, -smp supports 2 more new levels: book and drawer.

It is necessary to consider the effects of book and drawer in the test
cases to ensure that the calculations are correct. This is also the
preparation to add new book and drawer test cases.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Xiaoling Song <xiaoling.song@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-smp-parse.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 2eb9533bc505..f656bbb6da27 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -384,6 +384,8 @@ static char *smp_config_to_string(const SMPConfiguration *config)
     return g_strdup_printf(
         "(SMPConfiguration) {\n"
         "    .has_cpus     = %5s, cpus     = %" PRId64 ",\n"
+        "    .has_drawers  = %5s, drawers  = %" PRId64 ",\n"
+        "    .has_books    = %5s, books    = %" PRId64 ",\n"
         "    .has_sockets  = %5s, sockets  = %" PRId64 ",\n"
         "    .has_dies     = %5s, dies     = %" PRId64 ",\n"
         "    .has_clusters = %5s, clusters = %" PRId64 ",\n"
@@ -392,6 +394,8 @@ static char *smp_config_to_string(const SMPConfiguration *config)
         "    .has_maxcpus  = %5s, maxcpus  = %" PRId64 ",\n"
         "}",
         config->has_cpus ? "true" : "false", config->cpus,
+        config->has_drawers ? "true" : "false", config->drawers,
+        config->has_books ? "true" : "false", config->books,
         config->has_sockets ? "true" : "false", config->sockets,
         config->has_dies ? "true" : "false", config->dies,
         config->has_clusters ? "true" : "false", config->clusters,
@@ -404,10 +408,10 @@ static char *smp_config_to_string(const SMPConfiguration *config)
 static unsigned int cpu_topology_get_threads_per_socket(const CpuTopology *topo)
 {
     /* Check the divisor to avoid invalid topology examples causing SIGFPE. */
-    if (!topo->sockets) {
+    if (!topo->drawers || !topo->books || !topo->sockets) {
         return 0;
     } else {
-        return topo->max_cpus / topo->sockets;
+        return topo->max_cpus / topo->drawers / topo->books / topo->sockets;
     }
 }
 
@@ -429,6 +433,8 @@ static char *cpu_topology_to_string(const CpuTopology *topo,
     return g_strdup_printf(
         "(CpuTopology) {\n"
         "    .cpus               = %u,\n"
+        "    .drawers            = %u,\n"
+        "    .books              = %u,\n"
         "    .sockets            = %u,\n"
         "    .dies               = %u,\n"
         "    .clusters           = %u,\n"
@@ -438,7 +444,8 @@ static char *cpu_topology_to_string(const CpuTopology *topo,
         "    .threads_per_socket = %u,\n"
         "    .cores_per_socket   = %u,\n"
         "}",
-        topo->cpus, topo->sockets, topo->dies, topo->clusters,
+        topo->cpus, topo->drawers, topo->books,
+        topo->sockets, topo->dies, topo->clusters,
         topo->cores, topo->threads, topo->max_cpus,
         threads_per_socket, cores_per_socket);
 }
@@ -473,6 +480,8 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
     if (is_valid) {
         if ((err == NULL) &&
             (ms->smp.cpus == expect_topo->cpus) &&
+            (ms->smp.drawers == expect_topo->drawers) &&
+            (ms->smp.books == expect_topo->books) &&
             (ms->smp.sockets == expect_topo->sockets) &&
             (ms->smp.dies == expect_topo->dies) &&
             (ms->smp.clusters == expect_topo->clusters) &&
@@ -564,6 +573,16 @@ static void unsupported_params_init(const MachineClass *mc, SMPTestData *data)
         data->expect_prefer_sockets.clusters = 1;
         data->expect_prefer_cores.clusters = 1;
     }
+
+    if (!mc->smp_props.books_supported) {
+        data->expect_prefer_sockets.books = 1;
+        data->expect_prefer_cores.books = 1;
+    }
+
+    if (!mc->smp_props.drawers_supported) {
+        data->expect_prefer_sockets.drawers = 1;
+        data->expect_prefer_cores.drawers = 1;
+    }
 }
 
 static void machine_base_class_init(ObjectClass *oc, void *data)
-- 
2.34.1


