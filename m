Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D3CCCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoEQ-0002ym-Um; Mon, 19 Oct 2026 10:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDJ-0002CX-6i
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDF-0005Ye-PA
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YdetL3GVMiTOVD6AaoiePxKd35lc51ZeATg2wCP+p8Q=;
 b=U87pZttvJLycCk0WuwZS0GWANYTy/tS1W+AQ/hYk0IprVNjqGn3DdXnbYkXBZv9yVlV+Jh
 4OAEvj7FBdxUfFikJIYN25pdoVwf7UhNGHrlSnIthPmo/RmJ36bun4aURx9RMUPC2IY+bJ
 4F4vhCw+nOD9zziawxo4fDsNmBhBR7A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-kCUiOSXwMYunV2n_3vH0dQ-1; Mon,
 19 Oct 2026 14:19:37 +0000
X-MC-Unique: kCUiOSXwMYunV2n_3vH0dQ-1
X-Mimecast-MFC-AGG-ID: kCUiOSXwMYunV2n_3vH0dQ_1792419575
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C6BB1954AD6; Mon, 19 Oct 2026 14:19:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 235C01955F01; Mon, 19 Oct 2026 14:19:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A3DB021E6890; Mon, 19 Oct 2026 16:19:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 13/65] qom/qmp: populate qapi-type in QMP handlers
Date: Mon, 19 Oct 2026 16:18:37 +0200
Message-ID: <20261019141929.1594337-14-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


