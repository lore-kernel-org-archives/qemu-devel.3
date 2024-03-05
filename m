Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7494AC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 15:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhWGe-0003NH-7m; Tue, 05 Mar 2024 09:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rhWGW-0003Ci-D8
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 09:59:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rhWGN-0004Mk-NC
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 09:59:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709650767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KiA1J7t/TfETNZzis3RCpaXizwbF9sMTr/y4i4JKHh4=;
 b=Y6YcgU7g6yeDEA9wx2LzXvkf+VB22yHZKysU1MCs5ySBTbc4fXUoTja2f0hJ7mtCPZL1XR
 7WgL1O4IjN5p9M8RI2Z9ePUTEebziEjuD/evMAt3unBfyMakLbsyrypEUfMzF+oPyCW7GH
 uoW4wm1cfC46Al6OLeSd2cnH+HxqgRU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-KufdTkPrPrSYhx4cHkvXSw-1; Tue, 05 Mar 2024 09:59:21 -0500
X-MC-Unique: KufdTkPrPrSYhx4cHkvXSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A68248007AF;
 Tue,  5 Mar 2024 14:59:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2296F37FC;
 Tue,  5 Mar 2024 14:59:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0FD0D21E692E; Tue,  5 Mar 2024 15:59:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, gaosong@loongson.cn,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, thuth@redhat.com, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 3/4] target: Improve error reporting for CpuModelInfo member
 @props
Date: Tue,  5 Mar 2024 15:59:17 +0100
Message-ID: <20240305145919.2186971-4-armbru@redhat.com>
In-Reply-To: <20240305145919.2186971-1-armbru@redhat.com>
References: <20240305145919.2186971-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

query-cpu-model-comparison, query-cpu-model-baseline, and
query-cpu-model-expansion take CpuModelInfo arguments.  Errors in
@props members of these arguments are reported for 'props', without
further context.  For instance, s390x rejects

    {"execute": "query-cpu-model-comparison", "arguments": {"modela": {"name": "z13", "props": {}}, "modelb": {"name": "z14", "props": []}}}

with

    {"error": {"class": "GenericError", "desc": "Invalid parameter type for 'props', expected: object"}}

This is unusual; the common QAPI unmarshaling machinery would complain
about 'modelb.props'.  Our hand-written code to visit the @props
member neglects to provide the context.

Tweak it so it provides it.  The command above now fails with

    {"error": {"class": "GenericError", "desc": "Invalid parameter type for 'modelb.props', expected: dict"}}

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/arm/arm-qmp-cmds.c        |  2 +-
 target/i386/cpu-sysemu.c         | 11 ++++++-----
 target/riscv/riscv-qmp-cmds.c    |  6 ++++--
 target/s390x/cpu_models_sysemu.c | 17 ++++++++++-------
 tests/qtest/arm-cpu-features.c   |  5 +++--
 5 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 0167759730..0efbee8af8 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -158,7 +158,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         Error *err = NULL;
 
         visitor = qobject_input_visitor_new(model->props);
-        if (!visit_start_struct(visitor, "props", NULL, 0, errp)) {
+        if (!visit_start_struct(visitor, "model.props", NULL, 0, errp)) {
             visit_free(visitor);
             object_unref(obj);
             return NULL;
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index df91f97827..3f9093d285 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -130,14 +130,15 @@ static void x86_cpu_to_dict_full(X86CPU *cpu, QDict *props)
     }
 }
 
-static void object_apply_props(Object *obj, QObject *props, Error **errp)
+static void object_apply_props(Object *obj, QObject *props,
+                               const char *props_arg_name, Error **errp)
 {
     Visitor *visitor;
     QDict *qdict;
     const QDictEntry *prop;
 
     visitor = qobject_input_visitor_new(props);
-    if (!visit_start_struct(visitor, "props", NULL, 0, errp)) {
+    if (!visit_start_struct(visitor, props_arg_name, NULL, 0, errp)) {
         visit_free(visitor);
         return;
     }
@@ -158,7 +159,7 @@ out:
 
 /* Create X86CPU object according to model+props specification */
 static X86CPU *x86_cpu_from_model(const char *model, QObject *props,
-                                  Error **errp)
+                                  const char *props_arg_name, Error **errp)
 {
     X86CPU *xc = NULL;
     X86CPUClass *xcc;
@@ -172,7 +173,7 @@ static X86CPU *x86_cpu_from_model(const char *model, QObject *props,
 
     xc = X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
     if (props) {
-        object_apply_props(OBJECT(xc), props, &err);
+        object_apply_props(OBJECT(xc), props, props_arg_name, &err);
         if (err) {
             goto out;
         }
@@ -203,7 +204,7 @@ qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     QDict *props = NULL;
     const char *base_name;
 
-    xc = x86_cpu_from_model(model->name, model->props, &err);
+    xc = x86_cpu_from_model(model->name, model->props, "model.props", &err);
     if (err) {
         goto out;
     }
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 69dde0c3e7..ee7465297d 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -129,6 +129,7 @@ static void riscv_obj_add_profiles_qdict(Object *obj, QDict *qdict_out)
 }
 
 static void riscv_cpuobj_validate_qdict_in(Object *obj, QObject *props,
+                                           const char *props_arg_name,
                                            Error **errp)
 {
     const QDict *qdict_in;
@@ -137,7 +138,7 @@ static void riscv_cpuobj_validate_qdict_in(Object *obj, QObject *props,
     Error *local_err = NULL;
 
     visitor = qobject_input_visitor_new(props);
-    if (!visit_start_struct(visitor, "props", NULL, 0, &local_err)) {
+    if (!visit_start_struct(visitor, props_arg_name, NULL, 0, &local_err)) {
         goto err;
     }
 
@@ -198,7 +199,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     }
 
     if (model->props) {
-        riscv_cpuobj_validate_qdict_in(obj, model->props, &local_err);
+        riscv_cpuobj_validate_qdict_in(obj, model->props, "model.props",
+                                       &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             object_unref(obj);
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index ef19724888..8338084d00 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -98,7 +98,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 }
 
 static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
-                                Error **errp)
+                                const char *info_arg_name, Error **errp)
 {
     Error *err = NULL;
     const QDict *qdict;
@@ -128,8 +128,11 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
     }
 
     if (info->props) {
+        g_autofree const char *props_name = g_strdup_printf("%s.props",
+                                                            info_arg_name);
+
         visitor = qobject_input_visitor_new(info->props);
-        if (!visit_start_struct(visitor, "props", NULL, 0, errp)) {
+        if (!visit_start_struct(visitor, props_name, NULL, 0, errp)) {
             visit_free(visitor);
             object_unref(obj);
             return;
@@ -216,7 +219,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     bool delta_changes = false;
 
     /* convert it to our internal representation */
-    cpu_model_from_info(&s390_model, model, &err);
+    cpu_model_from_info(&s390_model, model, "model", &err);
     if (err) {
         error_propagate(errp, err);
         return NULL;
@@ -254,12 +257,12 @@ CpuModelCompareInfo *qmp_query_cpu_model_comparison(CpuModelInfo *infoa,
     S390CPUModel modela, modelb;
 
     /* convert both models to our internal representation */
-    cpu_model_from_info(&modela, infoa, &err);
+    cpu_model_from_info(&modela, infoa, "modela", &err);
     if (err) {
         error_propagate(errp, err);
         return NULL;
     }
-    cpu_model_from_info(&modelb, infob, &err);
+    cpu_model_from_info(&modelb, infob, "modelb", &err);
     if (err) {
         error_propagate(errp, err);
         return NULL;
@@ -331,13 +334,13 @@ CpuModelBaselineInfo *qmp_query_cpu_model_baseline(CpuModelInfo *infoa,
     uint8_t max_gen;
 
     /* convert both models to our internal representation */
-    cpu_model_from_info(&modela, infoa, &err);
+    cpu_model_from_info(&modela, infoa, "modela", &err);
     if (err) {
         error_propagate(errp, err);
         return NULL;
     }
 
-    cpu_model_from_info(&modelb, infob, &err);
+    cpu_model_from_info(&modelb, infob, "modelb", &err);
     if (err) {
         error_propagate(errp, err);
         return NULL;
diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index 1daceb2e31..9d6e6190d5 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -213,7 +213,8 @@ static void assert_bad_props(QTestState *qts, const char *cpu_type)
     error = resp_get_error(resp);
     g_assert(error);
     g_assert_cmpstr(error, ==,
-                    "Invalid parameter type for 'props', expected: object");
+                    "Invalid parameter type for 'model.props',"
+                    " expected: object");
     qobject_unref(resp);
 }
 
@@ -446,7 +447,7 @@ static void test_query_cpu_model_expansion(const void *data)
     assert_bad_props(qts, "max");
     assert_error(qts, "foo", "The CPU type 'foo' is not a recognized "
                  "ARM CPU type", NULL);
-    assert_error(qts, "max", "Parameter 'props.not-a-prop' is unexpected",
+    assert_error(qts, "max", "Parameter 'model.props.not-a-prop' is unexpected",
                  "{ 'not-a-prop': false }");
     assert_error(qts, "host", "The CPU type 'host' requires KVM", NULL);
 
-- 
2.44.0


