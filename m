Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7703B606C3DD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tbq+J2nM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtDb-0003QI-VQ; Mon, 02 Nov 2026 09:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD8-0003Cj-Pf
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD5-0008R5-4p
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8+lAepfnrGEvH1FujN80D+XUgX13Xo2jCJAUioWrag=;
 b=Tbq+J2nMsKG9iaX08sNKFnmILytM7kp3hSDrhcrYlfpzHFjpWvBdVvjJi/LfGUas1r3mEm
 p8naP/KhdEUHcssuh1ASCihvxxIrTzEyls7UulJ4x/LiMsAaSo9vjS4y8GEUItrjnUuJ/M
 Lyb08PzSanBjna/tRRczvH2tYPCHYiU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-QZDjiiDaMr2iow1Wh2EPwQ-1; Mon,
 02 Nov 2026 09:40:28 -0500
X-MC-Unique: QZDjiiDaMr2iow1Wh2EPwQ-1
X-Mimecast-MFC-AGG-ID: QZDjiiDaMr2iow1Wh2EPwQ_1793630427
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A7BA195D02C; Mon,  2 Nov 2026 14:40:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35FE21955F19; Mon,  2 Nov 2026 14:40:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 65C4521E68A1; Mon, 02 Nov 2026 15:40:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 29/74] qom/qmp: populate qapi-type in QMP handlers
Date: Mon,  2 Nov 2026 15:39:33 +0100
Message-ID: <20261102144018.3212223-30-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Wire up the new qapi-type field in all four QMP handlers that return
ObjectPropertyInfo or ObjectPropertyValue: qom-list, qom-list-get,
device-list-properties, and qom-list-properties.

When an ObjectProperty has a qapi_type set, the masked QAPI type name
is copied into the response, allowing clients to cross-reference with
query-qmp-schema.

No property has it yet, the following changes will populate it.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20261101201717.3911097-13-armbru@redhat.com>
---
 qom/qom-qmp-cmds.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index f17389c730..47bf3bf293 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -25,9 +25,23 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qemu/cutils.h"
+#include "qapi/qapi-type-info.h"
 #include "qom/object_interfaces.h"
 #include "qom/qom-qobject.h"
 
+static ObjectPropertyInfo *qom_property_info(ObjectProperty *prop)
+{
+    ObjectPropertyInfo *info = g_new0(ObjectPropertyInfo, 1);
+
+    info->name = g_strdup(prop->name);
+    info->type = g_strdup(prop->type);
+    if (prop->qapi_type) {
+        assert(prop->qapi_type->masked_name);
+        info->qapi_type = g_strdup(prop->qapi_type->masked_name);
+    }
+    return info;
+}
+
 static Object *qom_resolve_path(const char *path, Error **errp)
 {
     bool ambiguous = false;
@@ -58,12 +72,7 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
 
     object_property_iter_init(&iter, obj);
     while ((prop = object_property_iter_next(&iter))) {
-        ObjectPropertyInfo *value = g_new0(ObjectPropertyInfo, 1);
-
-        QAPI_LIST_PREPEND(props, value);
-
-        value->name = g_strdup(prop->name);
-        value->type = g_strdup(prop->type);
+        QAPI_LIST_PREPEND(props, qom_property_info(prop));
     }
 
     return props;
@@ -78,6 +87,10 @@ static void qom_list_add_property_value(Object *obj, ObjectProperty *prop,
 
     item->name = g_strdup(prop->name);
     item->type = g_strdup(prop->type);
+    if (prop->qapi_type) {
+        assert(prop->qapi_type->masked_name);
+        item->qapi_type = g_strdup(prop->qapi_type->masked_name);
+    }
     item->value = object_property_get_qobject(obj, prop->name, NULL);
 }
 
@@ -241,9 +254,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
             continue;
         }
 
-        info = g_new0(ObjectPropertyInfo, 1);
-        info->name = g_strdup(prop->name);
-        info->type = g_strdup(prop->type);
+        info = qom_property_info(prop);
         info->description = g_strdup(prop->description);
         info->default_value = qobject_ref(prop->defval);
 
@@ -284,11 +295,8 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
         object_property_iter_init(&iter, obj);
     }
     while ((prop = object_property_iter_next(&iter))) {
-        ObjectPropertyInfo *info;
+        ObjectPropertyInfo *info = qom_property_info(prop);
 
-        info = g_malloc0(sizeof(*info));
-        info->name = g_strdup(prop->name);
-        info->type = g_strdup(prop->type);
         info->description = g_strdup(prop->description);
         info->default_value = qobject_ref(prop->defval);
 
-- 
2.55.0


