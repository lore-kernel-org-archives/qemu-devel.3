Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F71BCDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbxtB-0008Fb-72; Tue, 23 Jun 2026 05:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbxt9-00087W-TC
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 05:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbxt8-0003mR-Dc
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 05:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782208669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FDaBDsCeCeayrGnc3vkPZXGa5K8jSeL4dUmbPZZjw0w=;
 b=BGV+yGjK8zABiDoXcjJ+6QuIvgvzoc5rJq95qCg95mej+GhR6MrfCs0h9EBPFZOQWn54vA
 UNxI9L8QXm4MzOeSmksDohZGPvtfuhAn2i7O2uHhqux0OG3RqCgwj3dH71QVH/NID4+tn4
 D6n2sbjsCDM8TvQHgmDzCZlwKcy8loM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-qQvmLeLVPgG0saEKmpBx5w-1; Tue,
 23 Jun 2026 05:57:47 -0400
X-MC-Unique: qQvmLeLVPgG0saEKmpBx5w-1
X-Mimecast-MFC-AGG-ID: qQvmLeLVPgG0saEKmpBx5w_1782208666
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBE521954117; Tue, 23 Jun 2026 09:57:45 +0000 (UTC)
Received: from berrange.com (unknown [10.44.34.133])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD1A61686; Tue, 23 Jun 2026 09:57:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 30/35] qom: add method for getting the "id" of a QOM object
Date: Tue, 23 Jun 2026 10:55:46 +0100
Message-ID: <20260623095551.2106712-31-berrange@redhat.com>
In-Reply-To: <20260623095551.2106712-1-berrange@redhat.com>
References: <20260623095551.2106712-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

The 'user_creatable_del' method doesn't want the 'Object *', but
instead the "id" of the object to be deleted. While most of its
work could be done with the "Object *" alone, purging the QemuOpts
values needs the "id".

The "id" is not recorded against an Object though, it is indirectly
stored as a property linking the parent and child objects together.
Add an accessor that can fetch this property name.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h | 10 ++++++++++
 qom/object.c         | 17 +++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 11f55613fc..216d2a30f6 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1759,6 +1759,16 @@ ObjectProperty *object_property_try_add_child(Object *obj, const char *name,
 ObjectProperty *object_property_add_child(Object *obj, const char *name,
                                           Object *child);
 
+/**
+ * object_property_get_child_name:
+ * @obj: the object that owns the property
+ * @child: the object referenced by the child property
+ *
+ * Return the property name against which @child is registered
+ * with @obj, or NULL if @obj is not a parent of @child.
+ */
+char *object_property_get_child_name(Object *obj, Object *child);
+
 typedef enum {
     /* Unref the link pointer when the property is deleted */
     OBJ_PROP_LINK_STRONG = 0x1,
diff --git a/qom/object.c b/qom/object.c
index f79b2cf361..66bbd1488b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1952,6 +1952,23 @@ object_property_add_child(Object *obj, const char *name,
     return object_property_try_add_child(obj, name, child, &error_abort);
 }
 
+char *object_property_get_child_name(Object *obj, Object *child)
+{
+    ObjectProperty *prop;
+    GHashTableIter iter;
+    gpointer key, value;
+
+    g_hash_table_iter_init(&iter, obj->properties);
+    while (g_hash_table_iter_next(&iter, &key, &value)) {
+        prop = value;
+        if (object_property_is_child(prop) && prop->opaque == child) {
+            return g_strdup(prop->name);
+        }
+    }
+    return NULL;
+}
+
+
 void object_property_allow_set_link(const Object *obj, const char *name,
                                     Object *val, Error **errp)
 {
-- 
2.54.0


