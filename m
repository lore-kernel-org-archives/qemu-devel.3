Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8F6C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a3q-0006OH-8c; Fri, 04 Sep 2026 15:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3j-0005rq-E7
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3h-0007sq-Sv
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788551925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K50ZWGwg+nOOOt1h7W1bQ4V8OqkzKi0lDblUcZD8UUs=;
 b=br2lvJM0PuzQQux93iKuLws2RfnUHr5srDhHG4Wyw7G3Q+EuXc51+SZLFnd3RxDcaoFDUv
 7tbiKLLS8SgxQ0uyGYjGHJPjPae0z3aqI57Fw9x1fPqHzrB9pvMj+fHKWNfHwV4r1adxoy
 L1RtcgpF7Ar8d2x5m+MzlJ43gnkgK0Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-VYzJrZGrPDKXn91YIBLEqw-1; Fri,
 04 Sep 2026 15:58:42 -0400
X-MC-Unique: VYzJrZGrPDKXn91YIBLEqw-1
X-Mimecast-MFC-AGG-ID: VYzJrZGrPDKXn91YIBLEqw_1788551921
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFF9E19C95C6; Fri,  4 Sep 2026 19:58:40 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EFB5030002F5; Fri,  4 Sep 2026 19:58:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:57:52 +0400
Subject: [PATCH v4 09/75] qom/qmp: populate qapi-type in QMP handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-9-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3382;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+8tJKKMSqC8bFdqLXJxWJDTuj8Fy49U/fprYdWbqUWM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLIFidck6SdAYxe/wP6OOzoZEoRKMUuj9BXi
 bd/DT3I5KyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyAAKCRDa6OEJdZac
 5YcxD/4pDkBWkOy5ROro0eAmhtsQ2Qho7n3MwFgVo03+PTs+n52cTkLr/w0lJpZLlKbQcLncqID
 koxlRfh6dPj0NGFJcthCsXSZxoo1AVX50U28o8A9rRJZNV1YVMH32xH3nfYGJZoRJUiJXcu6bX8
 KHWyxu6t5SxzgGVdjAUpQJDBAFjKG/5EyK+lJljqUexOenwevcC0hap/m79FbeUVD0jpcnCpNw9
 wZNbbw22O23ZTHuqRbbGRK0wodcRKPTIzghXOm7NijWW6LaNedUcrEpG5MWWwIjKSD2Lh5jbRGg
 LTzLnC4cgzo1ygiyta3V8zXcBHFcK8nlDRA0ZRMouG4wkfuFAANLIJi3XCptFUXROElMsPf5g7Z
 a2MLOhb+5Mne6U+uV/UZWB0XTDisMuPJR0ML3EQx5QiKd2kWC0F2hy04dY3tql7OMyZpFgfa6V8
 ked1SZ5V/ykvDwWeRyXBgy5g+jikfLl79Ta9w6jxsUP4nkZ+9xMYSREzklFzB3TrS3UPEE9QgyD
 wn5h1GdEagK90wrMd/SK5Dt1rFQr5Q0saTZ+W55xIinbolp01Ir90VojAYGDNaaB4dWMsWxCYPC
 6k5XBhrXxCrz2qZKt/jpkI4i+oh51Rg6F0QEaBrYdDQbYnEfpZSq8YlXmeEb5DkgD1TPfBN/2gp
 zS6q1i3p1s+iWbA==
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
 qom/qom-qmp-cmds.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 330895361d47..f9e6d4371cc5 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -25,9 +25,22 @@
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
+        info->qapi_type = g_strdup(prop->qapi_type->masked_name);
+    }
+    return info;
+}
+
 static Object *qom_resolve_path(const char *path, Error **errp)
 {
     bool ambiguous = false;
@@ -58,12 +71,7 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
 
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
@@ -78,6 +86,9 @@ static void qom_list_add_property_value(Object *obj, ObjectProperty *prop,
 
     item->name = g_strdup(prop->name);
     item->type = g_strdup(prop->type);
+    if (prop->qapi_type) {
+        item->qapi_type = g_strdup(prop->qapi_type->masked_name);
+    }
     item->value = object_property_get_qobject(obj, prop->name, NULL);
 }
 
@@ -218,9 +229,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
             continue;
         }
 
-        info = g_new0(ObjectPropertyInfo, 1);
-        info->name = g_strdup(prop->name);
-        info->type = g_strdup(prop->type);
+        info = qom_property_info(prop);
         info->description = g_strdup(prop->description);
         info->default_value = qobject_ref(prop->defval);
 
@@ -261,11 +270,8 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
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


