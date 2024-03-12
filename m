Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E27C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2Nu-0007W4-GY; Tue, 12 Mar 2024 09:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2Nj-0007NZ-Nq
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:41:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2NW-0003do-76
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710250873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WcUTy+akApizBaxjoVsyLwVwAl1LGxafwYZv6uq034=;
 b=C0ACiYCPn279/t7O+1SZ9wg6UYiwOLgKnIiuv50uSs6bCHKZOBi0Yi/wjVS8MzNcOTEUBH
 yCnhourKnMlorhodcgaweKjOeK03+AMk0tq+rBG2s97BIlL2GhfnxbQgh22JSeXENTi4mc
 ULa6YUzRONeauEhJzxStQKnwWPq+8Lg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-0NVYtER5PJ-kVOpOdrHJIA-1; Tue, 12 Mar 2024 09:41:10 -0400
X-MC-Unique: 0NVYtER5PJ-kVOpOdrHJIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 308538007AD;
 Tue, 12 Mar 2024 13:41:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E024112132A;
 Tue, 12 Mar 2024 13:41:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E576421E6939; Tue, 12 Mar 2024 14:41:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 4/4] target/loongarch: Fix query-cpu-model-expansion to reject
 props
Date: Tue, 12 Mar 2024 14:41:08 +0100
Message-ID: <20240312134108.3030801-5-armbru@redhat.com>
In-Reply-To: <20240312134108.3030801-1-armbru@redhat.com>
References: <20240312134108.3030801-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

query-cpu-model-expansion takes a CpuModelInfo argument.  The
loongarch version of the command silently ignores the argument's
member @props.  For instance,

    {"execute": "query-cpu-model-expansion", "arguments": {"type": "static", "model": {"name": "la464", "props": null}}}

and

    {"execute": "query-cpu-model-expansion", "arguments": {"type": "static", "model": {"name": "la464", "props": {"prop": null}}}}

succeed.

Add skeleton code for property processing that recognizes no
properties.  Now the two commands fail as they should:

    {"error": {"class": "GenericError", "desc": "Invalid parameter type for 'model.props', expected: object"}}

and

    {"error": {"class": "GenericError", "desc": "Parameter 'model.props.prop' is unexpected"}}

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240305145919.2186971-5-armbru@redhat.com>
[Drop #include now superfluous]
---
 target/loongarch/loongarch-qmp-cmds.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index ec33ce81f0..8721a5eb13 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -10,7 +10,6 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "cpu.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qom/qom-qobject.h"
@@ -48,6 +47,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
                                                      CpuModelInfo *model,
                                                      Error **errp)
 {
+    Visitor *visitor;
+    bool ok;
     CpuModelExpansionInfo *expansion_info;
     QDict *qdict_out;
     ObjectClass *oc;
@@ -60,6 +61,21 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         return NULL;
     }
 
+    if (model->props) {
+        visitor = qobject_input_visitor_new(model->props);
+        if (!visit_start_struct(visitor, "model.props", NULL, 0, errp)) {
+            visit_free(visitor);
+            return NULL;
+        }
+
+        ok = visit_check_struct(visitor, errp);
+        visit_end_struct(visitor, NULL);
+        visit_free(visitor);
+        if (!ok) {
+            return NULL;
+        }
+    }
+
     oc = cpu_class_by_name(TYPE_LOONGARCH_CPU, model->name);
     if (!oc) {
         error_setg(errp, "The CPU type '%s' is not a recognized LoongArch CPU type",
-- 
2.44.0


