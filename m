Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A44606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A3stDIG8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNbzr-00051i-M2; Sun, 01 Nov 2026 15:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzf-0004rQ-TI
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzc-0007Aa-Qp
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3HT5BIGoS8nHVRiDz3I3Bq8n7Gi547sTZWuTtUMsmx0=;
 b=A3stDIG8Bp9lVPj4yYsA609WJSbx7IeIVntT3OCf4y/1U0VhZqDEm471lZe2baoXCvkUqF
 Rjmq2/2SamPv/wu+mlZizvdA2DhMVq7xc6DVx07ct9KUt4p7KlMPEPuDqLylDKXg1kHXA8
 cow8xDHIL8iv5QDZoAY7O8SFndJZgTM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-BaOlv7z8Phux2OtAlu7tsQ-1; Sun,
 01 Nov 2026 15:17:26 -0500
X-MC-Unique: BaOlv7z8Phux2OtAlu7tsQ-1
X-Mimecast-MFC-AGG-ID: BaOlv7z8Phux2OtAlu7tsQ_1793564246
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC8A41956056
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96F561956088
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D4E2B21E6893; Sun, 01 Nov 2026 21:17:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v8 15/56] qom/object: Move enum property code so it is together
Date: Sun,  1 Nov 2026 21:16:36 +0100
Message-ID: <20261101201717.3911097-16-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qom/object.c | 76 ++++++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 0fbd4a7edf..9a0966c911 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1770,44 +1770,6 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
     return retval;
 }
 
-typedef struct EnumProperty {
-    const QEnumLookup *lookup;
-    int (*get)(Object *, Error **);
-    void (*set)(Object *, int, Error **);
-} EnumProperty;
-
-int object_property_get_enum(Object *obj, const char *name,
-                             const char *typename, Error **errp)
-{
-    char *str;
-    int ret;
-    ObjectProperty *prop = object_property_find_err(obj, name, errp);
-    EnumProperty *enumprop;
-
-    if (prop == NULL) {
-        return -1;
-    }
-
-    if (!g_str_equal(prop->type, typename)) {
-        error_setg(errp, "Property %s on %s is not '%s' enum type",
-                   name, object_class_get_name(
-                       object_get_class(obj)), typename);
-        return -1;
-    }
-
-    enumprop = prop->opaque;
-
-    str = object_property_get_str(obj, name, errp);
-    if (!str) {
-        return -1;
-    }
-
-    ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
-    g_free(str);
-
-    return ret;
-}
-
 bool object_property_parse(Object *obj, const char *name,
                            const char *string, Error **errp)
 {
@@ -2538,6 +2500,12 @@ object_class_property_add_bool(ObjectClass *klass, const char *name,
                                      prop);
 }
 
+typedef struct EnumProperty {
+    const QEnumLookup *lookup;
+    int (*get)(Object *, Error **);
+    void (*set)(Object *, int, Error **);
+} EnumProperty;
+
 static void property_get_enum(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
@@ -2606,6 +2574,38 @@ object_class_property_add_enum(ObjectClass *klass, const char *name,
                                      prop);
 }
 
+int object_property_get_enum(Object *obj, const char *name,
+                             const char *typename, Error **errp)
+{
+    char *str;
+    int ret;
+    ObjectProperty *prop = object_property_find_err(obj, name, errp);
+    EnumProperty *enumprop;
+
+    if (prop == NULL) {
+        return -1;
+    }
+
+    if (!g_str_equal(prop->type, typename)) {
+        error_setg(errp, "Property %s on %s is not '%s' enum type",
+                   name, object_class_get_name(
+                       object_get_class(obj)), typename);
+        return -1;
+    }
+
+    enumprop = prop->opaque;
+
+    str = object_property_get_str(obj, name, errp);
+    if (!str) {
+        return -1;
+    }
+
+    ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
+    g_free(str);
+
+    return ret;
+}
+
 typedef struct TMProperty {
     void (*get)(Object *, struct tm *, Error **);
 } TMProperty;
-- 
2.55.0


