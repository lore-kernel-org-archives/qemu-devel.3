Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AEBC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54GO-0005wT-69; Fri, 11 Sep 2026 12:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54G9-0005CA-Qn
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54G4-00063e-4O
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6TUSEu0sEClPNHL4vv4gsE23cIAhHKsqbEk0UMlAaEM=;
 b=O6JCXFNOXrMtyJ3BfZl9YO7MaqvcBWRJTw5Sh6e0DhmF7YyXpwAOU8/xwFhhr2P7IVwLJ5
 KZeHbx7+UB4YDyuTJahMUxcdEvlV44ukfkU9ozq2lcAy8Fdt07tKSpNZnOGGkOAAhTxwmq
 Ty65iAjuQPDqEpvBn3gFeTVGTp2M138=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-m6bSb6KKOvO9IvRgy6OD2g-1; Fri,
 11 Sep 2026 12:37:33 -0400
X-MC-Unique: m6bSb6KKOvO9IvRgy6OD2g-1
X-Mimecast-MFC-AGG-ID: m6bSb6KKOvO9IvRgy6OD2g_1789144652
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC2E4195D032; Fri, 11 Sep 2026 16:37:31 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB14030002E1; Fri, 11 Sep 2026 16:37:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:34:43 +0400
Subject: [PATCH v5 09/62] qom/qmp: populate qapi-type in QMP handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-9-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3481;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=V0JgLpw7o5TuWzU0v6BSi8BNq0lnGgg+9WVC1tJYi8Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC22vXDs6273oi9chS56vMq1HlyTc0H5lwGR9
 b9CXn+9g7uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQttgAKCRDa6OEJdZac
 5SFQD/wJQfuh59o7MuYQyYzmfZ+R2E6XflyYbWYoz4rCD4yn0Od7JXY13R0MvnCTt9nb2obNvcF
 3/2BgyopIKNBX2l3bTwj3ZAQ7a2MZZ2Bs9oVJvb3M/UBRGVamU/jTGbI+zxOb8WL4pY+iFfMivG
 mD0v819sbwUg9LKxot+4fDsD753Jk4Z1BcDeyB8DvCcAvIwPxv5WKY0X86GPRjV5zfEgFEnX8sE
 Gu9R9BdpArOprYkr5VUOfxi0IqNUS2bHgueGVt+AsqIzPR6YRxMKpxqGxjsrYbiv27fBZqvBeKX
 bV4lZuBkFXqnhfefhenl80xaLi+LLT4rwO0VKGvLFkNmH0pauV62XSRkkp3WlS5If9aXBa2Pq7E
 Q97Kmnagf1K/2FdVfI48CXQVC7t757diVwzz3SOG2cZa6iAZNth1lL1bs0BkxkfvWqfXy4eyheE
 NiqhB2LPh1mVEuA64eA8AkqvFuGn/gallX8vRXojikPnXSzB/KWF+qrmcyrHwZsj7qBV6FgFXKS
 aOC/wIkVvGkw56vKWduJ4V64UBbh5vqTyPRrN+9a5MG0/Bnh+4lWpnIke6gVDQaKNztFHe+ZBi/
 WfwaMaUf2w7S3c9mzZo/k9wLFthLQ/0ais4gX76eFQWt1vzzTsM2XJHTWEN0UM25r2Egqyhr5Hz
 GR5NHfyo+NuLIVg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Wire up the new qapi-type field in all four QMP handlers that return
ObjectPropertyInfo or ObjectPropertyValue: qom-list, qom-list-get,
device-list-properties, and qom-list-properties.

When an ObjectProperty has a qapi_type set, the masked QAPI type name
is copied into the response, allowing clients to cross-reference with
query-qmp-schema.

No property has it yet, the following changes will populate it.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qom/qom-qmp-cmds.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 330895361d47..500930da14cb 100644
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
 
@@ -218,9 +231,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
             continue;
         }
 
-        info = g_new0(ObjectPropertyInfo, 1);
-        info->name = g_strdup(prop->name);
-        info->type = g_strdup(prop->type);
+        info = qom_property_info(prop);
         info->description = g_strdup(prop->description);
         info->default_value = qobject_ref(prop->defval);
 
@@ -261,11 +272,8 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
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
2.55.0.543.g5ebe2ebe4ea8


