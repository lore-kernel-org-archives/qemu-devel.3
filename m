Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A0EC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricSa-0000gR-Qd; Fri, 08 Mar 2024 10:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ricSZ-0000de-JN
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:48:35 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ricSX-00042e-VK
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709912915; x=1741448915;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3yBYX2nAWb+HDAcrhm+cAUvXQKvQu/GD/FeL85SWXFA=;
 b=gx2EaxopDtGNxMw5ZBM0+DtmogfLEpZzLcjvNPSz+OmzBtuYvUTmMoye
 p16+yX3hzRc+RWPvGCbTo5KO4ATc0EZs6kTMovN/ax65F1zT8oXwbavHt
 iEOd4nfHPF4gbId/YyoqX+EyaPY9ausRyrRvvP3aIp1Kl89vf2VGdMMe0
 6h1buXxGGpnAvqMGy3bdFJqi9AuzSSVo+UN7Y+flfnhIt6ES0kRQwdmrT
 oSWcHKcaexnkQztNpHtcSF44313pXLrUpFuXFIbWmTOP4MtIX0hGvBrEo
 EtJJJsOy35D+yIhvcIfPVxi3m+KXWtOZ9n22CBdrfBy2WdEpPDwVn/2ap w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4561079"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4561079"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2024 07:48:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; d="scan'208";a="10400339"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 08 Mar 2024 07:48:30 -0800
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
Subject: [PATCH v2 07/13] tests/unit/test-smp-parse: Make test cases aware of
 the book/drawer
Date: Sat,  9 Mar 2024 00:01:42 +0800
Message-Id: <20240308160148.3130837-8-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
References: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.21;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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


