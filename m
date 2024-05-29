Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EDAC25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCQJ-0005f0-MH; Wed, 29 May 2024 02:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCQH-0005aq-HX
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:29 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCQF-0002vg-9j
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716962668; x=1748498668;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2vBh3IfNwbawhYc++Jw/OuUr0v/+Zup3/Ru69BmBxJY=;
 b=XZ612HnBIcRDa48BrnWCHW5YWy5WvgYx7POn5/hsrUk4KNibJnoirkwD
 /RimfPc/YHuW35nLq8NW9W1jSgGzpgBbJzzecP6tJ3jrFhteCtgsaBKke
 U1HsZCMtdObxXw8qAjh3aCrej5ya7b4ijEAL8mlFpmgyET4yKA9jBUMol
 l9lQBdcmcKT+YR7md0V/3QCWE3gTCQWSOVRzEFho/ltWPc8oi5RgGIgX5
 BnidGJjuBfBQ/U/xQm9mMW5VNNOdWgLnv3HKscRCnVXppyq6mmYQPm9Dg
 e/fTbF6pet2QOSfEMiie3TCXPZfOvJMp81ZZWe/o+jRYq8ffrPky77qL/ Q==;
X-CSE-ConnectionGUID: jvjBDkJ1Q/e8izCNuLFzJQ==
X-CSE-MsgGUID: RlKZhJAyTnWrOs4mHf+F0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13187514"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="13187514"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 23:04:26 -0700
X-CSE-ConnectionGUID: PKDxyjSFS2GFoLIMhNEEnQ==
X-CSE-MsgGUID: q5cuhUeDTpKRHskcoAX6/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="40144779"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 28 May 2024 23:04:23 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Yongwei Ma <yongwei.ma@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 8/8] tests/unit/test-smp-parse: Test the full 8-levels
 topology hierarchy
Date: Wed, 29 May 2024 14:19:25 +0800
Message-Id: <20240529061925.350323-9-zhao1.liu@intel.com>
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

With module level, QEMU now support 8-levels topology hierarchy.
Cover "modules" in SMP_CONFIG_WITH_FULL_TOPO related cases.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 129 ++++++++++++++++++++++++------------
 1 file changed, 85 insertions(+), 44 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 2ca8530e935e..f9bccb56abc7 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -94,11 +94,11 @@
         }
 
 /*
- * Currently QEMU supports up to a 7-level topology hierarchy, which is the
+ * Currently QEMU supports up to a 8-level topology hierarchy, which is the
  * QEMU's unified abstract representation of CPU topology.
- *  -drawers/books/sockets/dies/clusters/cores/threads
+ *  -drawers/books/sockets/dies/clusters/modules/cores/threads
  */
-#define SMP_CONFIG_WITH_FULL_TOPO(a, b, c, d, e, f, g, h, i)    \
+#define SMP_CONFIG_WITH_FULL_TOPO(a, b, c, d, e, f, g, h, i, j) \
         {                                                       \
             .has_cpus     = true, .cpus     = a,                \
             .has_drawers  = true, .drawers  = b,                \
@@ -106,9 +106,10 @@
             .has_sockets  = true, .sockets  = d,                \
             .has_dies     = true, .dies     = e,                \
             .has_clusters = true, .clusters = f,                \
-            .has_cores    = true, .cores    = g,                \
-            .has_threads  = true, .threads  = h,                \
-            .has_maxcpus  = true, .maxcpus  = i,                \
+            .has_modules  = true, .modules  = g,                \
+            .has_cores    = true, .cores    = h,                \
+            .has_threads  = true, .threads  = i,                \
+            .has_maxcpus  = true, .maxcpus  = j,                \
         }
 
 /**
@@ -336,10 +337,10 @@ static const struct SMPTestData data_generic_valid[] = {
         /*
          * Unsupported parameters are always allowed to be set to '1'
          * config:
-         *   -smp 8,drawers=1,books=1,sockets=2,dies=1,clusters=1,cores=2,\
-         *        threads=2,maxcpus=8
+         *   -smp 8,drawers=1,books=1,sockets=2,dies=1,clusters=1,modules=1,\
+         *        cores=2,threads=2,maxcpus=8
          * expect: cpus=8,sockets=2,cores=2,threads=2,maxcpus=8 */
-        .config = SMP_CONFIG_WITH_FULL_TOPO(8, 1, 1, 2, 1, 1, 2, 2, 8),
+        .config = SMP_CONFIG_WITH_FULL_TOPO(8, 1, 1, 2, 1, 1, 1, 2, 2, 8),
         .expect_prefer_sockets = CPU_TOPOLOGY_GENERIC(8, 2, 2, 2, 8),
         .expect_prefer_cores   = CPU_TOPOLOGY_GENERIC(8, 2, 2, 2, 8),
     },
@@ -561,32 +562,37 @@ static const struct SMPTestData data_full_topo_invalid[] = {
     {
         /*
          * config: -smp 200,drawers=3,books=5,sockets=2,dies=4,\
-         *              clusters=2,cores=7,threads=2,maxcpus=200
+         *              clusters=2,modules=3,cores=7,threads=2,\
+         *              maxcpus=200
          */
-        .config = SMP_CONFIG_WITH_FULL_TOPO(200, 3, 5, 2, 4, 2, 7, 2, 200),
+        .config = SMP_CONFIG_WITH_FULL_TOPO(200, 3, 5, 2, 4, 2, 3, 7, 2, 200),
         .expect_error = "Invalid CPU topology: "
                         "product of the hierarchy must match maxcpus: "
                         "drawers (3) * books (5) * sockets (2) * dies (4) * "
-                        "clusters (2) * cores (7) * threads (2) "
+                        "clusters (2) * modules (3) * cores (7) * threads (2) "
                         "!= maxcpus (200)",
     }, {
         /*
-         * config: -smp 3361,drawers=3,books=5,sockets=2,dies=4,\
-         *              clusters=2,cores=7,threads=2,maxcpus=3360
+         * config: -smp 2881,drawers=3,books=5,sockets=2,dies=4,\
+         *              clusters=2,modules=3,cores=2,threads=2,
+         *              maxcpus=2880
          */
-        .config = SMP_CONFIG_WITH_FULL_TOPO(3361, 3, 5, 2, 4, 2, 7, 2, 3360),
+        .config = SMP_CONFIG_WITH_FULL_TOPO(2881, 3, 5, 2, 4,
+                                            2, 3, 2, 2, 2880),
         .expect_error = "Invalid CPU topology: "
                         "maxcpus must be equal to or greater than smp: "
-                        "drawers (3) * books (5) * sockets (2) * dies (4) * "
-                        "clusters (2) * cores (7) * threads (2) "
-                        "== maxcpus (3360) < smp_cpus (3361)",
+                        "drawers (3) * books (5) * sockets (2) * "
+                        "dies (4) * clusters (2) * modules (3) * "
+                        "cores (2) * threads (2) == maxcpus (2880) "
+                        "< smp_cpus (2881)",
     }, {
         /*
          * config: -smp 1,drawers=3,books=5,sockets=2,dies=4,\
-         *              clusters=2,cores=7,threads=3,maxcpus=5040
+         *              clusters=2,modules=3,cores=3,threads=3,\
+         *              maxcpus=6480
          */
-        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 3, 5, 2, 4, 2, 7, 3, 5040),
-        .expect_error = "Invalid SMP CPUs 5040. The max CPUs supported "
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 3, 5, 2, 4, 2, 3, 3, 3, 6480),
+        .expect_error = "Invalid SMP CPUs 6480. The max CPUs supported "
                         "by machine '" SMP_MACHINE_NAME "' is 4096",
     },
 };
@@ -596,81 +602,100 @@ static const struct SMPTestData data_zero_topo_invalid[] = {
         /*
          * Test "cpus=0".
          * config: -smp 0,drawers=1,books=1,sockets=1,dies=1,\
-         *              clusters=1,cores=1,threads=1,maxcpus=1
+         *              clusters=1,modules=1,cores=1,threads=1,\
+         *              maxcpus=1
          */
-        .config = SMP_CONFIG_WITH_FULL_TOPO(0, 1, 1, 1, 1, 1, 1, 1, 1),
+        .config = SMP_CONFIG_WITH_FULL_TOPO(0, 1, 1, 1, 1, 1, 1, 1, 1, 1),
         .expect_error = "Invalid CPU topology: CPU topology parameters must "
                         "be greater than zero",
     }, {
         /*
          * Test "drawers=0".
          * config: -smp 1,drawers=0,books=1,sockets=1,dies=1,\
-         *              clusters=1,cores=1,threads=1,maxcpus=1
+         *              clusters=1,modules=1,cores=1,threads=1,\
+         *              maxcpus=1
          */
-        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 0, 1, 1, 1, 1, 1, 1, 1),
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 0, 1, 1, 1, 1, 1, 1, 1, 1),
         .expect_error = "Invalid CPU topology: CPU topology parameters must "
                         "be greater than zero",
     }, {
         /*
          * Test "books=0".
          * config: -smp 1,drawers=1,books=0,sockets=1,dies=1,\
-         *              clusters=1,cores=1,threads=1,maxcpus=1
+         *              clusters=1,modules=1,cores=1,threads=1,\
+         *              maxcpus=1
          */
-        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 0, 1, 1, 1, 1, 1, 1),
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 0, 1, 1, 1, 1, 1, 1, 1),
         .expect_error = "Invalid CPU topology: CPU topology parameters must "
                         "be greater than zero",
     }, {
         /*
          * Test "sockets=0".
          * config: -smp 1,drawers=1,books=1,sockets=0,dies=1,\
-         *              clusters=1,cores=1,threads=1,maxcpus=1
+         *              clusters=1,modules=1,cores=1,threads=1,
+         *              maxcpus=1
          */
-        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 0, 1, 1, 1, 1, 1),
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 0, 1, 1, 1, 1, 1, 1),
         .expect_error = "Invalid CPU topology: CPU topology parameters must "
                         "be greater than zero",
     }, {
         /*
          * Test "dies=0".
          * config: -smp 1,drawers=1,books=1,sockets=1,dies=0,\
-         *              clusters=1,cores=1,threads=1,maxcpus=1
+         *              clusters=1,modules=1,cores=1,threads=1,\
+         *              maxcpus=1
          */
-        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 0, 1, 1, 1, 1),
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 0, 1, 1, 1, 1, 1),
         .expect_error = "Invalid CPU topology: CPU topology parameters must "
                         "be greater than zero",
     }, {
         /*
          * Test "clusters=0".
          * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
-         *              clusters=0,cores=1,threads=1,maxcpus=1
+         *              clusters=0,modules=1,cores=1,threads=1,\
+         *              maxcpus=1
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 1, 0, 1, 1, 1, 1),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    }, {
+        /*
+         * Test "modules=0".
+         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
+         *              clusters=1,modules=0,cores=1,threads=1,\
+         *              maxcpus=1
          */
-        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 1, 0, 1, 1, 1),
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 1, 1, 0, 1, 1, 1),
         .expect_error = "Invalid CPU topology: CPU topology parameters must "
                         "be greater than zero",
     }, {
         /*
          * Test "cores=0".
          * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
-         *              clusters=1,cores=0,threads=1,maxcpus=1
+         *              clusters=1,modules=1,cores=0,threads=1,
+         *              maxcpus=1
          */
-        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 1, 1, 0, 1, 1),
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 1, 1, 1, 0, 1, 1),
         .expect_error = "Invalid CPU topology: CPU topology parameters must "
                         "be greater than zero",
     }, {
         /*
          * Test "threads=0".
          * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
-         *              clusters=1,cores=1,threads=0,maxcpus=1
+         *              clusters=1,modules=1,cores=1,threads=0,\
+         *              maxcpus=1
          */
-        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 1, 1, 1, 0, 1),
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 1, 1, 1, 1, 0, 1),
         .expect_error = "Invalid CPU topology: CPU topology parameters must "
                         "be greater than zero",
     }, {
         /*
          * Test "maxcpus=0".
          * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
-         *              clusters=1,cores=1,threads=1,maxcpus=0
+         *              clusters=1,modules=1,cores=1,threads=1,\
+         *              maxcpus=0
          */
-        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 1, 1, 1, 1, 0),
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 1, 1, 1, 1, 1, 0),
         .expect_error = "Invalid CPU topology: CPU topology parameters must "
                         "be greater than zero",
     },
@@ -977,6 +1002,7 @@ static void machine_full_topo_class_init(ObjectClass *oc, void *data)
     mc->smp_props.books_supported = true;
     mc->smp_props.dies_supported = true;
     mc->smp_props.clusters_supported = true;
+    mc->smp_props.modules_supported = true;
 }
 
 static void test_generic_valid(const void *opaque)
@@ -1396,30 +1422,41 @@ static void test_full_topo(const void *opaque)
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
-    unsigned int drawers = 5, books = 3, dies = 2, clusters = 7, multiplier;
+    unsigned int drawers, books, dies, clusters, modules, multiplier;
     int i;
 
-    multiplier = drawers * books * dies * clusters;
+    drawers = 5;
+    books = 3;
+    dies = 2;
+    clusters = 3;
+    modules = 2;
+
+    multiplier = drawers * books * dies * clusters * modules;
     for (i = 0; i < ARRAY_SIZE(data_generic_valid); i++) {
         data = data_generic_valid[i];
         unsupported_params_init(mc, &data);
 
         /*
-         * when drawers, books, dies and clusters parameters are omitted,
-         * they will be set as 1.
+         * when drawers, books, dies, clusters and modules parameters are
+         * omitted, they will be set as 1.
          */
         data.expect_prefer_sockets.drawers = 1;
         data.expect_prefer_sockets.books = 1;
         data.expect_prefer_sockets.dies = 1;
         data.expect_prefer_sockets.clusters = 1;
+        data.expect_prefer_sockets.modules = 1;
         data.expect_prefer_cores.drawers = 1;
         data.expect_prefer_cores.books = 1;
         data.expect_prefer_cores.dies = 1;
         data.expect_prefer_cores.clusters = 1;
+        data.expect_prefer_cores.modules = 1;
 
         smp_parse_test(ms, &data, true);
 
-        /* when drawers, books, dies and clusters parameters are specified. */
+        /*
+         * when drawers, books, dies, clusters and modules parameters
+         * are specified.
+         */
         data.config.has_drawers = true;
         data.config.drawers = drawers;
         data.config.has_books = true;
@@ -1428,6 +1465,8 @@ static void test_full_topo(const void *opaque)
         data.config.dies = dies;
         data.config.has_clusters = true;
         data.config.clusters = clusters;
+        data.config.has_modules = true;
+        data.config.modules = modules;
 
         if (data.config.has_cpus) {
             data.config.cpus *= multiplier;
@@ -1440,6 +1479,7 @@ static void test_full_topo(const void *opaque)
         data.expect_prefer_sockets.books = books;
         data.expect_prefer_sockets.dies = dies;
         data.expect_prefer_sockets.clusters = clusters;
+        data.expect_prefer_sockets.modules = modules;
         data.expect_prefer_sockets.cpus *= multiplier;
         data.expect_prefer_sockets.max_cpus *= multiplier;
 
@@ -1447,6 +1487,7 @@ static void test_full_topo(const void *opaque)
         data.expect_prefer_cores.books = books;
         data.expect_prefer_cores.dies = dies;
         data.expect_prefer_cores.clusters = clusters;
+        data.expect_prefer_cores.modules = modules;
         data.expect_prefer_cores.cpus *= multiplier;
         data.expect_prefer_cores.max_cpus *= multiplier;
 
-- 
2.34.1


