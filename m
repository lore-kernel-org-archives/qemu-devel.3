Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5826EC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2Nu-0007Ug-8t; Tue, 12 Mar 2024 09:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2NZ-0007Dk-R5
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2NX-0003cg-GV
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710250872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8vlKx+bZHBkZbZf8Ce0bxRf+THoDY2ly+inY6t+AvM=;
 b=OZ87/ltvL38HsidLRPlkiQ39OrzWd2aBgX3Aqpi6zzrXwByuV2RI7VweJJHnj9uhEzP1wm
 tHDhuljY0CHVbcwdq0DsK0mPH0VheRn+0z86aeVgNCUXQ66X1kJ7uxBnvqANF1orMXPZ2C
 65waDXgzGsKJD+w5/yOztGqb7LNXDXs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-tRsv1HfIPr6RJw0pU80_rA-1; Tue,
 12 Mar 2024 09:41:10 -0400
X-MC-Unique: tRsv1HfIPr6RJw0pU80_rA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F0092802269;
 Tue, 12 Mar 2024 13:41:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D6AE2024517;
 Tue, 12 Mar 2024 13:41:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DF94421E691E; Tue, 12 Mar 2024 14:41:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 2/4] target/i386: Fix query-cpu-model-expansion to reject props
Date: Tue, 12 Mar 2024 14:41:06 +0100
Message-ID: <20240312134108.3030801-3-armbru@redhat.com>
In-Reply-To: <20240312134108.3030801-1-armbru@redhat.com>
References: <20240312134108.3030801-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

CpuModelInfo member @props is semantically a mapping from name to
value, and syntactically a JSON object on the wire.  This translates
to QDict in C.  Since the QAPI schema language lacks the means to
express 'object', we use 'any' instead.  This is QObject in C.
Commands taking a CpuModelInfo argument need to check the QObject is a
QDict.

The i386 version of qmp_query_cpu_model_expansion() fails to check.
Instead, @props is silently ignored when it's not an object.  For
instance,

    {"execute": "query-cpu-model-expansion", "arguments": {"type": "full", "model": {"name": "qemu64", "props": null}}}

succeeds.

Fix by refactoring the code to match the other targets.  Now the
command fails as it should:

    {"error": {"class": "GenericError", "desc": "Invalid parameter type for 'props', expected: object"}}

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240305145919.2186971-3-armbru@redhat.com>
---
 target/i386/cpu-sysemu.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 7422096737..df91f97827 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -25,6 +25,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-visit-run-state.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qobject-input-visitor.h"
 #include "qom/qom-qobject.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "hw/qdev-properties.h"
@@ -129,20 +130,35 @@ static void x86_cpu_to_dict_full(X86CPU *cpu, QDict *props)
     }
 }
 
-static void object_apply_props(Object *obj, QDict *props, Error **errp)
+static void object_apply_props(Object *obj, QObject *props, Error **errp)
 {
+    Visitor *visitor;
+    QDict *qdict;
     const QDictEntry *prop;
 
-    for (prop = qdict_first(props); prop; prop = qdict_next(props, prop)) {
-        if (!object_property_set_qobject(obj, qdict_entry_key(prop),
-                                         qdict_entry_value(prop), errp)) {
-            break;
+    visitor = qobject_input_visitor_new(props);
+    if (!visit_start_struct(visitor, "props", NULL, 0, errp)) {
+        visit_free(visitor);
+        return;
+    }
+
+    qdict = qobject_to(QDict, props);
+    for (prop = qdict_first(qdict); prop; prop = qdict_next(qdict, prop)) {
+        if (!object_property_set(obj, qdict_entry_key(prop),
+                                 visitor, errp)) {
+            goto out;
         }
     }
+
+    visit_check_struct(visitor, errp);
+out:
+    visit_end_struct(visitor, NULL);
+    visit_free(visitor);
 }
 
 /* Create X86CPU object according to model+props specification */
-static X86CPU *x86_cpu_from_model(const char *model, QDict *props, Error **errp)
+static X86CPU *x86_cpu_from_model(const char *model, QObject *props,
+                                  Error **errp)
 {
     X86CPU *xc = NULL;
     X86CPUClass *xcc;
@@ -187,8 +203,7 @@ qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     QDict *props = NULL;
     const char *base_name;
 
-    xc = x86_cpu_from_model(model->name, qobject_to(QDict, model->props),
-                            &err);
+    xc = x86_cpu_from_model(model->name, model->props, &err);
     if (err) {
         goto out;
     }
-- 
2.44.0


