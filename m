Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A92ACAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v291s-00062q-HR; Fri, 26 Sep 2025 10:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v291a-0005yh-OQ
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v291O-0004YK-PE
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKOEfxYbwSdrTXZEFWiWj/ei+zi84OVrn7iulMS2fTU=;
 b=A+jwfi2uaFuLI/fqGff6RgqdtGfPB6SL+FfoIJlly6AqffnXDvV+fvKQ1vySsnuZp+RPz7
 EzpJtQ8c8VXXRW9/vb4rOf3WMunLeBq7smcus71P3jIz2te/SBPoBT3A2Gc1/ie4w+v74p
 BOMRaAenzDJ/vqnjuKEd/jflPNS+nLQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-K1zx4fNBOuy_0rYqXQfPKQ-1; Fri,
 26 Sep 2025 10:01:54 -0400
X-MC-Unique: K1zx4fNBOuy_0rYqXQfPKQ-1
X-Mimecast-MFC-AGG-ID: K1zx4fNBOuy_0rYqXQfPKQ_1758895313
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A040A195608A; Fri, 26 Sep 2025 14:01:53 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86CFD19540ED; Fri, 26 Sep 2025 14:01:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 01/32] qom: replace 'abstract' with 'flags'
Date: Fri, 26 Sep 2025 15:01:12 +0100
Message-ID: <20250926140144.1998694-2-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


