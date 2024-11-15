Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D5AD68BCF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC04d-00042F-QK; Fri, 15 Nov 2024 12:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04c-000425-U8
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04b-0001W0-DS
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731691532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LGGf/6SXD4klp11oD3a3PZ0lZYftk0LuT8kkItR+FyY=;
 b=IqPtp3bGy5goLt+qKNdg80E5JwyTIbdFNeKrEcFNdfLX8UQyrduudtE64ZiCg23aHPXQx3
 LiN9hscvSpE5WY7E5aMtz3ib1xyFVAWxm1NMGRW36WWPwlK9cKtJN445KJe9nf0uR6KlRt
 1IDRA0sXhG/ksay1LFAQ4lZZKyRs9XM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-na-wT9zFN4-vDBaEF4b5YQ-1; Fri,
 15 Nov 2024 12:25:31 -0500
X-MC-Unique: na-wT9zFN4-vDBaEF4b5YQ-1
X-Mimecast-MFC-AGG-ID: na-wT9zFN4-vDBaEF4b5YQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B081197731C
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 17:25:30 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B9573003B71; Fri, 15 Nov 2024 17:25:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 2/9] qom: refactor checking abstract property when creating
 instances
Date: Fri, 15 Nov 2024 17:25:14 +0000
Message-ID: <20241115172521.504102-3-berrange@redhat.com>
In-Reply-To: <20241115172521.504102-1-berrange@redhat.com>
References: <20241115172521.504102-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Push an Error object into object_initialize_with_type, so that
reporting of attempts to create an abstract type is handled at
the lowest level.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/object.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 9edc06d391..9632a894ee 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -559,14 +559,20 @@ static void object_class_property_init_all(Object *obj)
     }
 }
 
-static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type)
+static bool object_initialize_with_type(Object *obj, size_t size,
+                                        TypeImpl *type, Error **errp)
 {
     type_initialize(type);
 
     g_assert(type->instance_size >= sizeof(Object));
-    g_assert(type->abstract == false);
     g_assert(size >= type->instance_size);
 
+    if (type->abstract) {
+        error_setg(errp, "Abstract type '%s' cannot be instantiated",
+                   type->name);
+        return false;
+    }
+
     memset(obj, 0, type->instance_size);
     obj->class = type->class;
     object_ref(obj);
@@ -575,13 +581,15 @@ static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type
                                             NULL, object_property_free);
     object_init_with_type(obj, type);
     object_post_init_with_type(obj, type);
+
+    return true;
 }
 
 void object_initialize(void *data, size_t size, const char *typename)
 {
     TypeImpl *type = type_get_or_load_by_name(typename, &error_fatal);
 
-    object_initialize_with_type(data, size, type);
+    object_initialize_with_type(data, size, type, &error_abort);
 }
 
 bool object_initialize_child_with_props(Object *parentobj,
@@ -753,7 +761,7 @@ typedef union {
 } qemu_max_align_t;
 #endif
 
-static Object *object_new_with_type(Type type)
+static Object *object_new_with_type(Type type, Error **errp)
 {
     Object *obj;
     size_t size, align;
@@ -777,7 +785,10 @@ static Object *object_new_with_type(Type type)
         obj_free = qemu_vfree;
     }
 
-    object_initialize_with_type(obj, size, type);
+    if (!object_initialize_with_type(obj, size, type, errp)) {
+        obj_free(obj);
+        return NULL;
+    }
     obj->free = obj_free;
 
     return obj;
@@ -785,14 +796,14 @@ static Object *object_new_with_type(Type type)
 
 Object *object_new_with_class(ObjectClass *klass)
 {
-    return object_new_with_type(klass->type);
+    return object_new_with_type(klass->type, &error_abort);
 }
 
 Object *object_new(const char *typename)
 {
     TypeImpl *ti = type_get_or_load_by_name(typename, &error_fatal);
 
-    return object_new_with_type(ti);
+    return object_new_with_type(ti, &error_abort);
 }
 
 
@@ -829,11 +840,10 @@ Object *object_new_with_propv(const char *typename,
         return NULL;
     }
 
-    if (object_class_is_abstract(klass)) {
-        error_setg(errp, "object type '%s' is abstract", typename);
+    obj = object_new_with_type(klass->type, errp);
+    if (!obj) {
         return NULL;
     }
-    obj = object_new_with_type(klass->type);
 
     if (!object_set_propv(obj, errp, vargs)) {
         goto error;
-- 
2.46.0


