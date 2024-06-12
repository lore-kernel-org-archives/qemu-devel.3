Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23E4C27C7B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNvZ-0001GP-4O; Wed, 12 Jun 2024 09:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNvA-0000mn-Ts
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNv5-00040b-DW
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718198502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4cUKmPgrHxOvdyn6AxHRIzYDAEU26KLGZwsf7oV2h70=;
 b=HSTiwQ+q5GXx0l8e9aXg7j6/RtL8QG/Yi2ExzgLC0Qx4aGEdZpnxhlL9GVbOmk6XeOFsMs
 MVRPHEln8ghMs39nA0zHtrug2Mi9mr1nqNTKCaHoZc/94ItCt1F84eK3hifFeBMFxDbqhq
 Y8jfUIXAVFqQzXWkTGgHZm+5bsn5v+M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-GZ47Zw3HO6W4-gDRsVpZlQ-1; Wed,
 12 Jun 2024 09:21:37 -0400
X-MC-Unique: GZ47Zw3HO6W4-gDRsVpZlQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12149195DE0C; Wed, 12 Jun 2024 13:21:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.236])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 501441956087; Wed, 12 Jun 2024 13:21:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>
Subject: [PULL 13/15] tests/unit/test-smp-parse: Test "modules" and "dies"
 combination case
Date: Wed, 12 Jun 2024 15:20:53 +0200
Message-ID: <20240612132055.326889-14-thuth@redhat.com>
In-Reply-To: <20240612132055.326889-1-thuth@redhat.com>
References: <20240612132055.326889-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

Since i386 PC machine supports both "modules" and "dies" in -smp, add the
"modules" and "dies" combination test case to match the actual topology
usage scenario.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Message-ID: <20240529061925.350323-8-zhao1.liu@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-smp-parse.c | 103 ++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 01832e5eda..2ca8530e93 100644
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
2.45.2


