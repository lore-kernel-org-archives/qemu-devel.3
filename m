Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1877C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4c98-00033T-71; Thu, 10 Sep 2026 06:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x4c96-00032q-JP
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x4c95-0007O9-1P
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789036602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iQOI/kKi8zvtrglbxEcz2zVU/y98U5uZrr+8osdGNq4=;
 b=A0Uz1b+Zy3h8x6NMmuv2c/FFRE/zew6YJL7WSapbvZPDYZhOcBQPv3PP7OcH91pUJG/Xfu
 EHkLEjzwBDZTrF5jp+HmRxbX48W2R+R9j3UTYivKAbMqetCg4VwP9FWnXDtcXDOwF8IaaU
 Pi5SCMtstK/UB1HhVU+icPAnjBfG+b0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-tBCwc5ktM2WrYC29F9UpQg-1; Thu,
 10 Sep 2026 06:36:36 -0400
X-MC-Unique: tBCwc5ktM2WrYC29F9UpQg-1
X-Mimecast-MFC-AGG-ID: tBCwc5ktM2WrYC29F9UpQg_1789036595
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 655A51955E96; Thu, 10 Sep 2026 10:36:35 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E3DA30001A2; Thu, 10 Sep 2026 10:36:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 01/14] qom: add tracking of security state of object types
Date: Thu, 10 Sep 2026 11:36:15 +0100
Message-ID: <20260910103628.2326622-2-berrange@redhat.com>
In-Reply-To: <20260910103628.2326622-1-berrange@redhat.com>
References: <20260910103628.2326622-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h | 13 +++++++++++++
 qom/object.c         |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 7ecd0f210f..687ceb6bba 100644
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
index b1834a57cc..32736a0111 100644
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
-- 
2.55.0


