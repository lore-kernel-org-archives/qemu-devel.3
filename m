Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AE2606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NWFWD7YY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWWIg-0008C2-Ft; Thu, 26 Nov 2026 05:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIX-000880-Vs
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIV-0006gX-OE
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795687305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RzXps0Qjiq+RYHERQ+HmU/uz4fv27Tb+Tqf6uDAG4N4=;
 b=NWFWD7YY+OsXzk9MhlPZf0dhuYJnnxmNZYgrcPNd2ft4iD9+nnEp25+ouvSMajs07J2FiX
 FNftAxLq8shM8lvy4jxjczQo/ZZZjVdU2SPE0iosRG8p0OFbqVz39v4DIqaMbMlusVt61A
 SvZwiu6Z3yD+nkbOin3IuY4DufdG6vo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-OWnFJ-GYN2SMtukLsUV-og-1; Thu,
 26 Nov 2026 10:01:43 +0000
X-MC-Unique: OWnFJ-GYN2SMtukLsUV-og-1
X-Mimecast-MFC-AGG-ID: OWnFJ-GYN2SMtukLsUV-og_1795687302
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A23431800358; Thu, 26 Nov 2026 10:01:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 492B31800286; Thu, 26 Nov 2026 10:01:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C84F921E6883; Thu, 26 Nov 2026 11:01:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 jsnow@redhat.com, crosa@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org
Subject: [PATCH 04/16] qom: New ObjectProperty member @qom_type
Date: Thu, 26 Nov 2026 11:01:27 +0100
Message-ID: <20261126100139.3557890-5-armbru@redhat.com>
In-Reply-To: <20261126100139.3557890-1-armbru@redhat.com>
References: <20261126100139.3557890-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ObjectProperty member @type is "child<T>" for a child property of QOM
type T, and "link<T>" for a link property of QOM type T.  We parse
@type in various places to extract "is child?", "is link?", and "T".
Undesirable.

Add member @qom_type.  It is is "T" when @type is "child<T>" or
"link<T>", else null.  The next commits will use it to get rid of the
parsing.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qom/object.h | 1 +
 qom/object.c         | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 70d8ea3e299..c8cedfe0f89 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -93,6 +93,7 @@ struct ObjectProperty
     char *type;
     char *description;
     const QAPITypeInfo *qapi_type;
+    char *qom_type;
     ObjectPropertyAccessor *get;
     ObjectPropertyAccessor *set;
     ObjectPropertyResolve *resolve;
diff --git a/qom/object.c b/qom/object.c
index 9276b7a4351..3c5a8f49154 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -331,6 +331,7 @@ static void object_property_free(gpointer data)
     }
     g_free(prop->name);
     g_free(prop->type);
+    g_free(prop->qom_type);
     g_free(prop->description);
     g_free(prop);
 }
@@ -1905,6 +1906,7 @@ ObjectProperty *
 object_property_try_add_child(Object *obj, const char *name,
                               Object *child, Error **errp)
 {
+    const char *qom_type = object_get_typename(child);
     g_autofree char *type = NULL;
     ObjectProperty *op;
 
@@ -1912,7 +1914,7 @@ object_property_try_add_child(Object *obj, const char *name,
                                     child, child->class->type->name);
     assert(!child->parent);
 
-    type = g_strdup_printf("child<%s>", object_get_typename(child));
+    type = g_strdup_printf("child<%s>", qom_type);
 
     op = object_property_try_add(obj, name, type, &str_type_info,
                                  object_get_child_property,
@@ -1921,6 +1923,7 @@ object_property_try_add_child(Object *obj, const char *name,
     if (!op) {
         return NULL;
     }
+    op->qom_type = g_strdup(qom_type);
     op->resolve = object_resolve_child_property;
     object_ref(child);
     child->parent = obj;
@@ -2114,6 +2117,7 @@ object_add_link_prop(Object *obj, const char *name,
                              check ? object_set_link_property : NULL,
                              object_release_link_property,
                              prop);
+    op->qom_type = g_strdup(type);
     op->resolve = object_resolve_link_property;
     return op;
 }
@@ -2152,6 +2156,7 @@ object_class_property_add_link(ObjectClass *oc,
                                    object_release_link_property,
                                    prop);
 
+    op->qom_type = g_strdup(type);
     op->resolve = object_resolve_link_property;
 
     g_free(full_type);
@@ -3105,6 +3110,7 @@ object_property_add_alias(Object *obj, const char *name,
                              property_set_alias,
                              property_release_alias,
                              prop);
+    op->qom_type = g_strdup(target_prop->qom_type);
     op->resolve = property_resolve_alias;
     if (target_prop->defval) {
         op->defval = qobject_ref(target_prop->defval);
@@ -3150,6 +3156,7 @@ object_class_property_add_alias(ObjectClass *klass, const char *name,
                                    property_set_alias,
                                    property_release_alias,
                                    prop);
+    op->qom_type = g_strdup(target_prop->qom_type);
     op->resolve = property_resolve_alias;
     if (target_prop->defval) {
         op->defval = qobject_ref(target_prop->defval);
-- 
2.55.0


