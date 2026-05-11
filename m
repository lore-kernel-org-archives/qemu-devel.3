Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0BCCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRPQ-0003CA-Tw; Mon, 11 May 2026 10:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMRPJ-00039y-0i
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMRPG-00014c-LG
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778508887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rzc8AWkwb0qd8O3CFJYB0nXakC3oVlw15sch7W5AUqs=;
 b=OndltLJfOaGAM3SZGQBTLjCEOAXg5OH0nGEvXju2wml9EvkHNvCwuyS7A5++vlWpqnTwXG
 HIQDU1knB2qvKO2DiSvgc4bBYcMZaEFDiZVbbrHEDw0t+q2uXtWKxRWUO3ZQHHZ3Hef7Ed
 +hLaS24PeW83Luz8cWNxgMbyqX37Qkw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-5c38U5jjO6GczjIAldvUEw-1; Mon,
 11 May 2026 10:14:44 -0400
X-MC-Unique: 5c38U5jjO6GczjIAldvUEw-1
X-Mimecast-MFC-AGG-ID: 5c38U5jjO6GczjIAldvUEw_1778508883
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5CDC180035D; Mon, 11 May 2026 14:14:43 +0000 (UTC)
Received: from berrange.com (unknown [10.44.50.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5F4319560A6; Mon, 11 May 2026 14:14:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 07/10] qom: add object_new_with_props_from_qdict
Date: Mon, 11 May 2026 15:14:17 +0100
Message-ID: <20260511141420.229023-8-berrange@redhat.com>
In-Reply-To: <20260511141420.229023-1-berrange@redhat.com>
References: <20260511141420.229023-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This will be used to replace user_creatable_add_type with an impl
that shares most code with object_new_with_props, and is not tied
to the user creatable interface.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h | 19 +++++++++++
 qom/object.c         | 75 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 1b2b2702fc..f33d512b19 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -700,6 +700,25 @@ Object *object_new_with_propv(const char *typename,
                               va_list vargs,
                               Error **errp);
 
+/**
+ * object_new_with_props_from_qdict:
+ * @typename:  The name of the type of the object to instantiate.
+ * @parent: the parent object
+ * @id: The unique ID of the object
+ * @props: dictionary of property names and values
+ * @v: visitor to iterate over @props
+ * @errp: pointer to error object
+ *
+ * A variant of object_new_with_props() which accepts the
+ * properties in a QDict.
+ */
+Object *object_new_with_props_from_qdict(const char *typename,
+                                         Object *parent,
+                                         const char *id,
+                                         const QDict *props,
+                                         Visitor *v,
+                                         Error **errp);
+
 /**
  * object_set_props:
  * @obj: the object instance to set properties on
diff --git a/qom/object.c b/qom/object.c
index d8083dc318..0c13e5ee1c 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -757,11 +757,14 @@ Object *object_new_with_props(const char *typename,
 }
 
 
-Object *object_new_with_propv(const char *typename,
-                              Object *parent,
-                              const char *id,
-                              va_list vargs,
-                              Error **errp)
+static Object *
+object_new_with_props_helper(const char *typename,
+                             Object *parent,
+                             const char *id,
+                             void *props,
+                             bool (set_props)(Object *obj, void *props,
+                                              Error **errp),
+                             Error **errp)
 {
     Object *obj;
     ObjectClass *klass;
@@ -786,7 +789,7 @@ Object *object_new_with_propv(const char *typename,
     }
     obj = object_new_with_type(klass->type);
 
-    if (!object_set_propv(obj, vargs, errp)) {
+    if (!set_props(obj, props, errp)) {
         goto error;
     }
 
@@ -812,6 +815,66 @@ Object *object_new_with_propv(const char *typename,
     return NULL;
 }
 
+struct ObjectNewVargsData {
+    va_list vargs;
+};
+
+static bool object_new_with_propv_setter(Object *obj,
+                                         void *props,
+                                         Error **errp)
+{
+    struct ObjectNewVargsData *data = props;
+    return object_set_propv(obj, data->vargs, errp);
+}
+
+Object *object_new_with_propv(const char *typename,
+                              Object *parent,
+                              const char *id,
+                              va_list vargs,
+                              Error **errp)
+{
+    Object *obj;
+    struct ObjectNewVargsData data;
+
+    va_copy(data.vargs, vargs);
+    obj = object_new_with_props_helper(typename,
+                                       parent,
+                                       id,
+                                       &data,
+                                       object_new_with_propv_setter,
+                                       errp);
+    va_end(data.vargs);
+    return obj;
+}
+
+struct ObjectNewQDictData {
+    const QDict *props;
+    Visitor *v;
+};
+
+static bool object_new_with_qdict_setter(Object *obj,
+                                         void *props,
+                                         Error **errp)
+{
+    struct ObjectNewQDictData *data = props;
+    return object_set_props_from_qdict(obj, data->props, data->v, errp);
+}
+
+Object *object_new_with_props_from_qdict(const char *typename,
+                                         Object *parent,
+                                         const char *id,
+                                         const QDict *props,
+                                         Visitor *v,
+                                         Error **errp)
+{
+    struct ObjectNewQDictData data = { props, v };
+    return object_new_with_props_helper(typename,
+                                        parent,
+                                        id,
+                                        &data,
+                                        object_new_with_qdict_setter,
+                                        errp);
+}
 
 bool object_set_props(Object *obj,
                       Error **errp,
-- 
2.54.0


