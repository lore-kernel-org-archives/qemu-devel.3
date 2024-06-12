Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F284C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNvK-0000vu-UA; Wed, 12 Jun 2024 09:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNv5-0000b7-JJ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNv0-0003zK-7h
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718198497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ysjaZul4ZbC1SjhznPFtrygYxu0FiigwTdLPvfz0yuU=;
 b=SmYR7yZjCQZ0Z2lRmBoiCJf279u20lDAsb/qbh+bSdGtMlQI1TMweghPjMTz/pQJSN0fbk
 7PDqJIfSL2i/wsNirdAMmijaw/kZVx09tK28vydkcooyYDU07wBVCeszrZlVzF5aaLAmoE
 FTBvKRWkGfhDw4EhkOYdcyL3QVoh5x4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-uhxMkd_3PX-dtGuPmRoXVg-1; Wed,
 12 Jun 2024 09:21:32 -0400
X-MC-Unique: uhxMkd_3PX-dtGuPmRoXVg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE2BB1954213; Wed, 12 Jun 2024 13:21:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.236])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 451421956087; Wed, 12 Jun 2024 13:21:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>
Subject: [PULL 12/15] tests/unit/test-smp-parse: Test "modules" parameter in
 -smp
Date: Wed, 12 Jun 2024 15:20:52 +0200
Message-ID: <20240612132055.326889-13-thuth@redhat.com>
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

Cover the module cases in test-smp-parse.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Message-ID: <20240529061925.350323-7-zhao1.liu@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-smp-parse.c | 112 +++++++++++++++++++++++++++++++++---
 1 file changed, 103 insertions(+), 9 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 2214e47ba9..01832e5eda 100644
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
2.45.2


