Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9A4CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 16:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw1f8-000674-8z; Tue, 09 Sep 2025 12:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uw1f6-000645-2D
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uw1f1-0007Vi-NZ
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757437058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKOEfxYbwSdrTXZEFWiWj/ei+zi84OVrn7iulMS2fTU=;
 b=CZW2314ODIPNrslT2HSdR8NCN6xsTQrc81YnKc5Uod+9IewSS4u9K0YNIq7kHFWJFA8rd4
 d/+j3eKKX3ObTZNhvh/Ho2Hof5HTIGG5kOv5PYkEQ2iKLARbLhYgKmleTQVPc4moiJC6be
 xxYlzQVsrJnN3HUJo/yhjKjCvErjeFY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-IyxQDZmCPXy7Vr4HtQyvqg-1; Tue,
 09 Sep 2025 12:57:34 -0400
X-MC-Unique: IyxQDZmCPXy7Vr4HtQyvqg-1
X-Mimecast-MFC-AGG-ID: IyxQDZmCPXy7Vr4HtQyvqg_1757437053
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 802561800371; Tue,  9 Sep 2025 16:57:33 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCA911800446; Tue,  9 Sep 2025 16:57:30 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 01/15] qom: replace 'abstract' with 'flags'
Date: Tue,  9 Sep 2025 17:57:12 +0100
Message-ID: <20250909165726.3814465-2-berrange@redhat.com>
In-Reply-To: <20250909165726.3814465-1-berrange@redhat.com>
References: <20250909165726.3814465-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This will allow extra boolean flags without expending the memory
usage of the Type struct.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/object.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 1856bb36c7..a654765e0a 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -45,6 +45,10 @@ struct InterfaceImpl
     const char *typename;
 };
 
+enum TypeImplFlags {
+    TYPE_IMPL_FLAG_ABSTRACT = (1 << 0),
+};
+
 struct TypeImpl
 {
     const char *name;
@@ -63,7 +67,7 @@ struct TypeImpl
     void (*instance_post_init)(Object *obj);
     void (*instance_finalize)(Object *obj);
 
-    bool abstract;
+    int flags;
 
     const char *parent;
     TypeImpl *parent_type;
@@ -127,7 +131,9 @@ static TypeImpl *type_new(const TypeInfo *info)
     ti->instance_post_init = info->instance_post_init;
     ti->instance_finalize = info->instance_finalize;
 
-    ti->abstract = info->abstract;
+    if (info->abstract) {
+        ti->flags |= TYPE_IMPL_FLAG_ABSTRACT;
+    }
 
     for (i = 0; info->interfaces && info->interfaces[i].type; i++) {
         ti->interfaces[i].typename = g_strdup(info->interfaces[i].type);
@@ -348,11 +354,11 @@ static void type_initialize(TypeImpl *ti)
      * This means interface types are all abstract.
      */
     if (ti->instance_size == 0) {
-        ti->abstract = true;
+        ti->flags |= TYPE_IMPL_FLAG_ABSTRACT;
     }
     if (type_is_ancestor(ti, type_interface)) {
         assert(ti->instance_size == 0);
-        assert(ti->abstract);
+        assert(ti->flags & TYPE_IMPL_FLAG_ABSTRACT);
         assert(!ti->instance_init);
         assert(!ti->instance_post_init);
         assert(!ti->instance_finalize);
@@ -558,7 +564,7 @@ static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type
     type_initialize(type);
 
     g_assert(type->instance_size >= sizeof(Object));
-    g_assert(type->abstract == false);
+    g_assert(!(type->flags & TYPE_IMPL_FLAG_ABSTRACT));
     g_assert(size >= type->instance_size);
 
     memset(obj, 0, type->instance_size);
@@ -1045,7 +1051,7 @@ ObjectClass *object_get_class(Object *obj)
 
 bool object_class_is_abstract(ObjectClass *klass)
 {
-    return klass->type->abstract;
+    return klass->type->flags & TYPE_IMPL_FLAG_ABSTRACT;
 }
 
 const char *object_class_get_name(ObjectClass *klass)
@@ -1110,7 +1116,8 @@ static void object_class_foreach_tramp(gpointer key, gpointer value,
     type_initialize(type);
     k = type->class;
 
-    if (!data->include_abstract && type->abstract) {
+    if (!data->include_abstract &&
+        (type->flags & TYPE_IMPL_FLAG_ABSTRACT)) {
         return;
     }
 
-- 
2.50.1


