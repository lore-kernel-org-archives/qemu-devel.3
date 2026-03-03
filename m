Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3DDEB3648
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxENe-00053g-GL; Mon, 02 Mar 2026 20:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vxENL-0004zk-Gp
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:16:40 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vxENF-00088J-0D
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:16:36 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxNMFrNqZpFeMWAA--.21792S3;
 Tue, 03 Mar 2026 09:16:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCx_8JfNqZpFmpNAA--.16102S5;
 Tue, 03 Mar 2026 09:16:26 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 3/8] target/loongarch: Add property set with
 query-cpu-model-expansion
Date: Tue,  3 Mar 2026 08:50:56 +0800
Message-Id: <20260303005101.3561064-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260303005101.3561064-1-gaosong@loongson.cn>
References: <20260303005101.3561064-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx_8JfNqZpFmpNAA--.16102S5
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bibo Mao <maobibo@loongson.cn>

On LoongArch with QMP command query-cpu-model-expansion, property
setting is not supported witch command such as:
  query-cpu-model-expansion type=static model={"name":"max","props":{"lasx":false}}

Here add property setting support with QMP command.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/loongarch-qmp-cmds.c | 40 +++++++++++++++++++--------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index 6a95080fe4..f053f22bb8 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -50,7 +50,6 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
                                                      Error **errp)
 {
     Visitor *visitor;
-    bool ok;
     CpuModelExpansionInfo *expansion_info;
     QDict *qdict_out;
     ObjectClass *oc;
@@ -64,30 +63,47 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         return NULL;
     }
 
+    oc = cpu_class_by_name(TYPE_LOONGARCH_CPU, model->name);
+    if (!oc) {
+        error_setg(errp, "The CPU type '%s' is not a recognized LoongArch "
+                         "CPU type", model->name);
+        return NULL;
+    }
+
+    obj = object_new(object_class_get_name(oc));
     if (model->props) {
+        Error *err = NULL;
+        const QDict *qdict_in;
+
         visitor = qobject_input_visitor_new(model->props);
         if (!visit_start_struct(visitor, "model.props", NULL, 0, errp)) {
             visit_free(visitor);
+            object_unref(obj);
             return NULL;
         }
 
-        ok = visit_check_struct(visitor, errp);
+        qdict_in = qobject_to(QDict, model->props);
+        i = 0;
+        while ((name = cpu_model_advertised_features[i++]) != NULL) {
+            if (qdict_get(qdict_in, name)) {
+                if (!object_property_set(obj, name, visitor, &err)) {
+                    break;
+                }
+            }
+        }
+
+        if (!err) {
+            visit_check_struct(visitor, &err);
+        }
         visit_end_struct(visitor, NULL);
         visit_free(visitor);
-        if (!ok) {
+        if (err) {
+            error_propagate(errp, err);
+            object_unref(obj);
             return NULL;
         }
     }
 
-    oc = cpu_class_by_name(TYPE_LOONGARCH_CPU, model->name);
-    if (!oc) {
-        error_setg(errp, "The CPU type '%s' is not a recognized LoongArch CPU type",
-                   model->name);
-        return NULL;
-    }
-
-    obj = object_new(object_class_get_name(oc));
-
     expansion_info = g_new0(CpuModelExpansionInfo, 1);
     expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
     expansion_info->model->name = g_strdup(model->name);
-- 
2.52.0


