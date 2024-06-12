Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DAFC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNvm-00020p-0Y; Wed, 12 Jun 2024 09:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNvH-00010X-FF
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNv9-00041A-T9
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718198506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOfjBdntAepIxFZzZ7peqwPdszRHHDJUcIIq7tm5rMg=;
 b=L25CN6wzsRaA9J4o4dBnN/mCREIx0dB4pTjNIElnmOE6WkP0qHV/gxPMlOQ0jl6Qo+BBFN
 yBk7NMe3QIIWAKGbCn0r92ho85K2rszUxDerAG0QXrRnh9mKd91p7G99uZHRJeyrMwA0hB
 3lHnhQx2wKG23JLksJFiMbm6nv+W4gA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-I9YzEPqgNhuNvN_X8U9f0g-1; Wed,
 12 Jun 2024 09:21:42 -0400
X-MC-Unique: I9YzEPqgNhuNvN_X8U9f0g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E8331955D64; Wed, 12 Jun 2024 13:21:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.236])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 704C8196BE8C; Wed, 12 Jun 2024 13:21:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>
Subject: [PULL 14/15] tests/unit/test-smp-parse: Test the full 8-levels
 topology hierarchy
Date: Wed, 12 Jun 2024 15:20:54 +0200
Message-ID: <20240612132055.326889-15-thuth@redhat.com>
In-Reply-To: <20240612132055.326889-1-thuth@redhat.com>
References: <20240612132055.326889-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

With module level, QEMU now support 8-levels topology hierarchy.
Cover "modules" in SMP_CONFIG_WITH_FULL_TOPO related cases.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Message-ID: <20240529061925.350323-9-zhao1.liu@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-smp-parse.c | 129 ++++++++++++++++++++++++------------
 1 file changed, 85 insertions(+), 44 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 2ca8530e93..f9bccb56ab 100644
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
2.45.2


