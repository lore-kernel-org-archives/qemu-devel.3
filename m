Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09FECAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v291n-00060r-VI; Fri, 26 Sep 2025 10:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v291W-0005wS-HI
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v291S-0004ZH-Ho
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lLG7MU/xrXHh8WM5PHRcnUsiibJ4DGwlIHHPR2ltAl0=;
 b=QStwqwbXAwcbztcuwCbO1LjFndovv6UTkpCTWTYKayVmIdN8n2h93O7rnUnMNUtS/FyEYH
 bxkWm6HNJtGysdv0P3dZUrG/YrfFjtkJhnb+Zc4Lk6RzaMiDnCvsigJ0Ymq9b6GIBsT6mp
 Zh3brzUehwrQrOjrSgDTysD/W7/wlRI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-Au95-aLwMRiqCNS8FLzukw-1; Fri,
 26 Sep 2025 10:01:59 -0400
X-MC-Unique: Au95-aLwMRiqCNS8FLzukw-1
X-Mimecast-MFC-AGG-ID: Au95-aLwMRiqCNS8FLzukw_1758895318
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E6CC1944F12; Fri, 26 Sep 2025 14:01:58 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6DC131956095; Fri, 26 Sep 2025 14:01:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 02/32] qom: add tracking of security state of object types
Date: Fri, 26 Sep 2025 15:01:13 +0100
Message-ID: <20250926140144.1998694-3-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
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

This introduces a new flag "secure" against the Type/TypeInfo
structs, and helpers to check this against the ObjectClass
struct.

If an object is considered to provide a security boundary to
protect against untrusted code, the "secure" flag must be
explicitly set to true.

If an object is considered to NOT provide protection against
untrusted code, the "secure" flag must be explicitly set to
false

If the security protection of an object has not yet been
evaluated and/or decided upon, the "secure" flag must not be
initialized. It will be implicitly set to 'false' for the
purposes of code querying the status.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h | 13 +++++++++++++
 qom/object.c         |  9 +++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 26df6137b9..9893be9ef8 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -453,6 +453,10 @@ struct Object
  *   function.
  * @abstract: If this field is true, then the class is considered abstract and
  *   cannot be directly instantiated.
+ * @secure: If this field is initialized to true, then the class is considered
+ *   to provide a security boundary. If initialized to false, the class does
+ *   not provide a security boundary. If uninitialized (and thus implicitly
+ *   false) its status is not yet defined.
  * @class_size: The size of the class object (derivative of #ObjectClass)
  *   for this object.  If @class_size is 0, then the size of the class will be
  *   assumed to be the size of the parent class.  This allows a type to avoid
@@ -485,6 +489,7 @@ struct TypeInfo
     void (*instance_finalize)(Object *obj);
 
     bool abstract;
+    bool secure;
     size_t class_size;
 
     void (*class_init)(ObjectClass *klass, const void *data);
@@ -996,6 +1001,14 @@ const char *object_class_get_name(ObjectClass *klass);
  */
 bool object_class_is_abstract(ObjectClass *klass);
 
+/**
+ * object_class_is_secure:
+ * @klass: The class to check security of
+ *
+ * Returns: %true if @klass is declared to be secure, %false if not declared
+ */
+bool object_class_is_secure(ObjectClass *klass);
+
 /**
  * object_class_by_name:
  * @typename: The QOM typename to obtain the class for.
diff --git a/qom/object.c b/qom/object.c
index a654765e0a..7e0921ae20 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -47,6 +47,7 @@ struct InterfaceImpl
 
 enum TypeImplFlags {
     TYPE_IMPL_FLAG_ABSTRACT = (1 << 0),
+    TYPE_IMPL_FLAG_SECURE = (1 << 1),
 };
 
 struct TypeImpl
@@ -134,6 +135,9 @@ static TypeImpl *type_new(const TypeInfo *info)
     if (info->abstract) {
         ti->flags |= TYPE_IMPL_FLAG_ABSTRACT;
     }
+    if (info->secure) {
+        ti->flags |= TYPE_IMPL_FLAG_SECURE;
+    }
 
     for (i = 0; info->interfaces && info->interfaces[i].type; i++) {
         ti->interfaces[i].typename = g_strdup(info->interfaces[i].type);
@@ -1054,6 +1058,11 @@ bool object_class_is_abstract(ObjectClass *klass)
     return klass->type->flags & TYPE_IMPL_FLAG_ABSTRACT;
 }
 
+bool object_class_is_secure(ObjectClass *klass)
+{
+    return klass->type->flags & TYPE_IMPL_FLAG_SECURE;
+}
+
 const char *object_class_get_name(ObjectClass *klass)
 {
     return klass->type->name;
-- 
2.50.1


