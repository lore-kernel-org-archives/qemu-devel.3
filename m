Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE091CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZW9J-00027t-A7; Tue, 16 Jun 2026 11:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZW9I-00027l-3t
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:56:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZW9G-0003o8-B8
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781625381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TTqi9MQR7wiJYeoYzsF+QEaiQ0Xxlem9KZFK9Xjbd84=;
 b=W4qYUbo5m9mnkEhllDPxTShDbaKUBWzvkatmiHVMVDCHHPzazsvuEwyOmggeZuKNUe7xbp
 ZKpq3lY/Wh2Lr35emGAngtPg77VQyjnwIUl4JtnnVqJy3Hz1lSQjiz11yfBmHczCJdbOYh
 e+NBBzXxucsSh3paSFvRIcM8bTk2X8k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-uVb3ePQKNpevU-_hWYl0SQ-1; Tue,
 16 Jun 2026 11:56:18 -0400
X-MC-Unique: uVb3ePQKNpevU-_hWYl0SQ-1
X-Mimecast-MFC-AGG-ID: uVb3ePQKNpevU-_hWYl0SQ_1781625376
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F01B91800841; Tue, 16 Jun 2026 15:56:14 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.111])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B88A2195411C; Tue, 16 Jun 2026 15:56:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 2/7] qom: deprecated embedding object structs within other
 objects
Date: Tue, 16 Jun 2026 16:55:49 +0100
Message-ID: <20260616155554.264412-3-berrange@redhat.com>
In-Reply-To: <20260616155554.264412-1-berrange@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The QOM APIs currently allow objects to be either allocated directly
on the heap, or statically embedded inside the struct of another object.

For the latter QOM has logic to avoid calling 'free' on the object when
finalizers complete, however, this is not sufficient to make the
practice safe.

Users of QOM expect that if they call "object_ref" to acquire their own
reference, then object will never be freed as long as they hold it.

This expectation is broken when an instance is embedded, as the "owner"
object's may be finalized, which frees the memory that is storing the
embedded QOM instance, even if its ref-count is still live.

Worse still is that a user of a QOM object cannot easily tell if the
instance they're using is embedded or directly heap allocated.

Mark the APIs for embedding objects as deprecated as the first step
towards removal of this flawed design concept. All objects must now
be directly heap allocated going forward, and existing usage must be
incrementally converted.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h | 28 ++++++++++++++++++++++++----
 qom/object.c         |  6 ++++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 11f55613fc..dd708b1136 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -854,8 +854,13 @@ bool object_set_props_from_keyval(Object *obj, const QDict *qdict,
  * This function will initialize an object.  The memory for the object should
  * have already been allocated.  The returned object has a reference count of 1,
  * and will be finalized when the last reference is dropped.
+ *
+ * Use of this function is now deprecated. All objects must be
+ * allocated using the object_new() family of functions and not
+ * statically embedded in a larger struct.
  */
-void object_initialize(void *obj, size_t size, const char *typename);
+void object_initialize(void *obj, size_t size, const char *typename)
+    QEMU_DEPRECATED;
 
 /**
  * object_initialize_child_with_props:
@@ -873,6 +878,10 @@ void object_initialize(void *obj, size_t size, const char *typename);
  * has a reference count of 1 (for the "child<...>" property from the parent),
  * so the object will be finalized automatically when the parent gets removed.
  *
+ * Use of this function is now deprecated. All objects must be
+ * allocated using the object_new() family of functions and not
+ * statically embedded in a larger struct.
+ *
  * The variadic parameters are a list of pairs of (propname, propvalue)
  * strings. The propname of %NULL indicates the end of the property list.
  * If the object implements the user creatable interface, the object will
@@ -883,7 +892,8 @@ void object_initialize(void *obj, size_t size, const char *typename);
 bool object_initialize_child_with_props(Object *parentobj,
                              const char *propname,
                              void *childobj, size_t size, const char *type,
-                             Error **errp, ...) G_GNUC_NULL_TERMINATED;
+                             Error **errp, ...) G_GNUC_NULL_TERMINATED
+    QEMU_DEPRECATED;
 
 /**
  * object_initialize_child_with_propsv:
@@ -897,12 +907,17 @@ bool object_initialize_child_with_props(Object *parentobj,
  *
  * See object_initialize_child() for documentation.
  *
+ * Use of this function is now deprecated. All objects must be
+ * allocated using the object_new() family of functions and not
+ * statically embedded in a larger struct.
+ *
  * Returns: %true on success, %false on failure.
  */
 bool object_initialize_child_with_propsv(Object *parentobj,
                               const char *propname,
                               void *childobj, size_t size, const char *type,
-                              Error **errp, va_list vargs);
+                              Error **errp, va_list vargs)
+    QEMU_DEPRECATED;
 
 /**
  * object_initialize_child:
@@ -917,13 +932,18 @@ bool object_initialize_child_with_propsv(Object *parentobj,
  *   object_initialize_child_with_props(parent, propname,
  *                                      child, sizeof(*child), type,
  *                                      &error_abort, NULL)
+ *
+ * Use of this function is now deprecated. All objects must be
+ * allocated using the object_new() family of functions and not
+ * statically embedded in a larger struct.
  */
 #define object_initialize_child(parent, propname, child, type)          \
     object_initialize_child_internal((parent), (propname),              \
                                      (child), sizeof(*(child)), (type))
 void object_initialize_child_internal(Object *parent, const char *propname,
                                       void *child, size_t size,
-                                      const char *type);
+                                      const char *type)
+    QEMU_DEPRECATED;
 
 /**
  * object_dynamic_cast:
diff --git a/qom/object.c b/qom/object.c
index 0ac201de4c..33b2801ee4 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -522,9 +522,11 @@ bool object_initialize_child_with_props(Object *parentobj,
     bool ok;
 
     va_start(vargs, errp);
+QEMU_DEPRECATIONS_OFF;
     ok = object_initialize_child_with_propsv(parentobj, propname,
                                              childobj, size, type, errp,
                                              vargs);
+QEMU_DEPRECATIONS_ON;
     va_end(vargs);
     return ok;
 }
@@ -539,7 +541,9 @@ bool object_initialize_child_with_propsv(Object *parentobj,
     Object *obj;
     UserCreatable *uc;
 
+QEMU_DEPRECATIONS_OFF;
     object_initialize(childobj, size, type);
+QEMU_DEPRECATIONS_ON;
     obj = OBJECT(childobj);
 
     if (!object_set_propv(obj, vargs, errp)) {
@@ -576,8 +580,10 @@ void object_initialize_child_internal(Object *parent,
                                       void *child, size_t size,
                                       const char *type)
 {
+QEMU_DEPRECATIONS_OFF;
     object_initialize_child_with_props(parent, propname, child, size, type,
                                        &error_abort, NULL);
+QEMU_DEPRECATIONS_ON;
 }
 
 static inline bool object_property_is_child(ObjectProperty *prop)
-- 
2.54.0


