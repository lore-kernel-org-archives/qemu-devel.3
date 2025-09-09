Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A081CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 17:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw1fT-0006KB-BR; Tue, 09 Sep 2025 12:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uw1fF-0006Bc-6e
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uw1f5-0007WD-Mp
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757437060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3DqK2BFdY/4B0jfZv0jzbvcZYXlop4Q1Pi9PvHDOxkc=;
 b=PPU5hhmiXDHmAgbZb3eqqQiafClkjDAFRb4dwps4nk6msducTBtATLbT0yvk4weQoKcJ4u
 1g+K159Os6lYy02D00cjdsDDBgd52cIXYJlolsXW5cln6ntmuGwm5R2Uf7n7Jmc/NJ8C3Z
 RUaXKMJwAYazYrAKNXtlB3KCygC3Lvs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-Q-_05tqYMCOlGbaK__ZxFQ-1; Tue,
 09 Sep 2025 12:57:37 -0400
X-MC-Unique: Q-_05tqYMCOlGbaK__ZxFQ-1
X-Mimecast-MFC-AGG-ID: Q-_05tqYMCOlGbaK__ZxFQ_1757437056
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3013D18002C2; Tue,  9 Sep 2025 16:57:36 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1D331800446; Tue,  9 Sep 2025 16:57:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 02/15] qom: add tracking of security state of object types
Date: Tue,  9 Sep 2025 17:57:13 +0100
Message-ID: <20250909165726.3814465-3-berrange@redhat.com>
In-Reply-To: <20250909165726.3814465-1-berrange@redhat.com>
References: <20250909165726.3814465-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

This introduces two new flags "secure" and "insecure" against
the Type struct, and helpers to check this against the ObjectClass
struct.

An object type can be considered secure if it is either marked
'secure', or is not marked 'insecure'. The gives an incremental
path where the security status is undefined for most types, but
with the possibility to require explicitly secure types, or
exclude explicitly insecure types.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h | 24 ++++++++++++++++++++++++
 qom/object.c         | 19 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 26df6137b9..4b9c70f06f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -453,6 +453,11 @@ struct Object
  *   function.
  * @abstract: If this field is true, then the class is considered abstract and
  *   cannot be directly instantiated.
+ * @secure: If this field is true, then the class is considered to provide
+ *   a security boundary. If false, the security status is not defined.
+ * @insecure: If this field is true, then the class is considered to NOT
+ *   provide a security boundary. If false, the security status is not
+ *   defined.
  * @class_size: The size of the class object (derivative of #ObjectClass)
  *   for this object.  If @class_size is 0, then the size of the class will be
  *   assumed to be the size of the parent class.  This allows a type to avoid
@@ -485,6 +490,8 @@ struct TypeInfo
     void (*instance_finalize)(Object *obj);
 
     bool abstract;
+    bool secure;
+    bool insecure;
     size_t class_size;
 
     void (*class_init)(ObjectClass *klass, const void *data);
@@ -996,6 +1003,23 @@ const char *object_class_get_name(ObjectClass *klass);
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
+
+/**
+ * object_class_is_insecure:
+ * @klass: The class to check security of
+ *
+ * Returns: %true if @klass is declared to be insecure, %false if not declared
+ */
+bool object_class_is_insecure(ObjectClass *klass);
+
 /**
  * object_class_by_name:
  * @typename: The QOM typename to obtain the class for.
diff --git a/qom/object.c b/qom/object.c
index a654765e0a..a516ea0fea 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -47,6 +47,8 @@ struct InterfaceImpl
 
 enum TypeImplFlags {
     TYPE_IMPL_FLAG_ABSTRACT = (1 << 0),
+    TYPE_IMPL_FLAG_SECURE = (1 << 1),
+    TYPE_IMPL_FLAG_INSECURE = (1 << 2),
 };
 
 struct TypeImpl
@@ -134,6 +136,13 @@ static TypeImpl *type_new(const TypeInfo *info)
     if (info->abstract) {
         ti->flags |= TYPE_IMPL_FLAG_ABSTRACT;
     }
+    assert(!(info->secure && info->insecure));
+    if (info->secure) {
+        ti->flags |= TYPE_IMPL_FLAG_SECURE;
+    }
+    if (info->insecure) {
+        ti->flags |= TYPE_IMPL_FLAG_INSECURE;
+    }
 
     for (i = 0; info->interfaces && info->interfaces[i].type; i++) {
         ti->interfaces[i].typename = g_strdup(info->interfaces[i].type);
@@ -1054,6 +1063,16 @@ bool object_class_is_abstract(ObjectClass *klass)
     return klass->type->flags & TYPE_IMPL_FLAG_ABSTRACT;
 }
 
+bool object_class_is_secure(ObjectClass *klass)
+{
+    return klass->type->flags & TYPE_IMPL_FLAG_SECURE;
+}
+
+bool object_class_is_insecure(ObjectClass *klass)
+{
+    return klass->type->flags & TYPE_IMPL_FLAG_INSECURE;
+}
+
 const char *object_class_get_name(ObjectClass *klass)
 {
     return klass->type->name;
-- 
2.50.1


