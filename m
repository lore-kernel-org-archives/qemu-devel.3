Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D1FC982D9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Ece-00060F-4R; Thu, 17 Sep 2026 12:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7EcH-0005pV-SJ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7EcA-0006qq-Q2
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789661133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMa85vmFyQ5UuLbzWOL7PoyW7GKfUTR//SukCVfnsuI=;
 b=iDh7ZMsjcI9c5p2og8WmZmzW+io7E94RylJQNOX689teZh93y8O43IDRTtPF8rSOc+EKfW
 EbYfYKhRmqAh9PXMuVlmOKDPix3WtcAYqMWE1SMHy/3RMj7VfGTqHrvu7DiGC9+aDcumwK
 4HV2kqxLlkRCxTqXZNVERYfl+AXnRmY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-qo3qBJ41MaCldSXq4tb64w-1; Thu,
 17 Sep 2026 12:05:31 -0400
X-MC-Unique: qo3qBJ41MaCldSXq4tb64w-1
X-Mimecast-MFC-AGG-ID: qo3qBJ41MaCldSXq4tb64w_1789661130
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F95918015CC; Thu, 17 Sep 2026 16:05:30 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E76F300022B; Thu, 17 Sep 2026 16:05:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/14] qom: add tracking of security state of object types
Date: Thu, 17 Sep 2026 17:05:12 +0100
Message-ID: <20260917160525.1275388-2-berrange@redhat.com>
In-Reply-To: <20260917160525.1275388-1-berrange@redhat.com>
References: <20260917160525.1275388-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This introduces a new flag "secure" against the Type/TypeInfo
structs, and helpers to check this against the ObjectClass
struct.

If an object is considered to provide a security boundary to
protect against untrusted code, the "secure" flag must be
explicitly set to true.

If it is set to false, or left unset, this indicates that
the object does not intend to provide a security boundary.
Bugs related to this object class will be ineligible for
CVE assignment.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h | 13 +++++++++++++
 qom/object.c         |  7 +++++++
 rust/qom/src/qom.rs  |  4 ++++
 3 files changed, 24 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 7ecd0f210fb..687ceb6bba0 100644
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
@@ -487,6 +491,7 @@ struct TypeInfo
     void (*instance_finalize)(Object *obj);
 
     bool abstract;
+    bool secure;
     size_t class_size;
 
     void (*class_init)(ObjectClass *klass, const void *data);
@@ -1074,6 +1079,14 @@ const char *object_class_get_name(ObjectClass *klass);
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
index b1834a57cc9..32736a01114 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -67,6 +67,7 @@ struct TypeImpl
     void (*instance_finalize)(Object *obj);
 
     bool abstract;
+    bool secure;
 
     const char *parent;
     TypeImpl *parent_type;
@@ -122,6 +123,7 @@ static TypeImpl *type_new(const TypeInfo *info)
     ti->instance_finalize = info->instance_finalize;
 
     ti->abstract = info->abstract;
+    ti->secure = info->secure;
 
     for (i = 0; info->interfaces && info->interfaces[i].type; i++) {
         ti->interfaces[i].typename = g_strdup(info->interfaces[i].type);
@@ -1144,6 +1146,11 @@ bool object_class_is_abstract(ObjectClass *klass)
     return klass->type->abstract;
 }
 
+bool object_class_is_secure(ObjectClass *klass)
+{
+    return klass->type->secure;
+}
+
 const char *object_class_get_name(ObjectClass *klass)
 {
     return klass->type->name;
diff --git a/rust/qom/src/qom.rs b/rust/qom/src/qom.rs
index bbb485e2cfd..81449eeefad 100644
--- a/rust/qom/src/qom.rs
+++ b/rust/qom/src/qom.rs
@@ -651,6 +651,9 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
     /// Whether the object can be instantiated
     const ABSTRACT: bool = false;
 
+    /// Whether the object provides a security boundary for untrusted access
+    const SECURE: bool = false;
+
     /// Function that is called to initialize an object.  The parent class will
     /// have already been initialized so the type is only responsible for
     /// initializing its own members.
@@ -687,6 +690,7 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
         },
         instance_finalize: Some(drop_object::<Self>),
         abstract_: Self::ABSTRACT,
+        secure: Self::SECURE,
         class_size: core::mem::size_of::<Self::Class>(),
         class_init: Some(rust_class_init::<Self>),
         class_base_init: Self::CLASS_BASE_INIT,
-- 
2.55.0


