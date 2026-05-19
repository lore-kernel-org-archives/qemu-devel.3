Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24313CD5BA4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 12:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPJx9-0007pd-HC; Tue, 19 May 2026 08:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPJww-0007WF-LA
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPJwt-00016y-Iy
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779195206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+P2JDg2djh/jf+gYQ0Qt/KfwgHeJkU+Z2fiHgOikzU=;
 b=hja3Gjvw2uQd45XDkoLcABRO8xGMCxPD3jrxHqVAbQ4o5umIUNkU7/Nk9OVEdaQ1fOxJ/G
 rl3+wt1DQ0bJ3EngziVGP3zCM8ONBvlGz9N83Un3HX3aj19Xjo4p9sH0dHKLSKx4by2I4w
 npd9deuir0ehGNLgvN2deQTX2kSlFOE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-Ur7cliplPESeJBB26ojkhQ-1; Tue,
 19 May 2026 08:53:22 -0400
X-MC-Unique: Ur7cliplPESeJBB26ojkhQ-1
X-Mimecast-MFC-AGG-ID: Ur7cliplPESeJBB26ojkhQ_1779195201
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AAF8195608B; Tue, 19 May 2026 12:53:21 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 343EE18004A3; Tue, 19 May 2026 12:53:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 21/28] qom: make errp last param in methods taking va_list
Date: Tue, 19 May 2026 13:51:45 +0100
Message-ID: <20260519125153.1015315-22-berrange@redhat.com>
In-Reply-To: <20260519125153.1015315-1-berrange@redhat.com>
References: <20260519125153.1015315-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

object_new_with_props can't put 'errp' last due to the use of
variadic arguments. That constraint does not apply to the use
of va_list with object_new_with_propv, so follow normal practice
with 'errp' placement.

The same rationale applies to object_set_propv.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h            | 10 +++++-----
 qom/object.c                    | 20 ++++++++++----------
 tests/unit/check-qom-proplist.c |  4 ++--
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 2a2829343d..a905a9e42f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -689,16 +689,16 @@ Object *object_new_with_props(const char *typename,
  * @typename:  The name of the type of the object to instantiate.
  * @parent: the parent object
  * @id: The unique ID of the object
- * @errp: pointer to error object
  * @vargs: list of property names and values
+ * @errp: pointer to error object
  *
  * See object_new_with_props() for documentation.
  */
 Object *object_new_with_propv(const char *typename,
                               Object *parent,
                               const char *id,
-                              Error **errp,
-                              va_list vargs);
+                              va_list vargs,
+                              Error **errp);
 
 /**
  * object_set_props:
@@ -739,14 +739,14 @@ bool object_set_props(Object *obj, Error **errp, ...) G_GNUC_NULL_TERMINATED;
 /**
  * object_set_propv:
  * @obj: the object instance to set properties on
- * @errp: pointer to error object
  * @vargs: list of property names and values
+ * @errp: pointer to error object
  *
  * See object_set_props() for documentation.
  *
  * Returns: %true on success, %false on error.
  */
-bool object_set_propv(Object *obj, Error **errp, va_list vargs);
+bool object_set_propv(Object *obj, va_list vargs, Error **errp);
 
 /**
  * object_initialize:
diff --git a/qom/object.c b/qom/object.c
index 08fc840f39..ecae322d2a 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -541,7 +541,7 @@ bool object_initialize_child_with_propsv(Object *parentobj,
     object_initialize(childobj, size, type);
     obj = OBJECT(childobj);
 
-    if (!object_set_propv(obj, errp, vargs)) {
+    if (!object_set_propv(obj, vargs, errp)) {
         goto out;
     }
 
@@ -740,7 +740,7 @@ Object *object_new_with_props(const char *typename,
     Object *obj;
 
     va_start(vargs, errp);
-    obj = object_new_with_propv(typename, parent, id, errp, vargs);
+    obj = object_new_with_propv(typename, parent, id, vargs, errp);
     va_end(vargs);
 
     return obj;
@@ -750,8 +750,8 @@ Object *object_new_with_props(const char *typename,
 Object *object_new_with_propv(const char *typename,
                               Object *parent,
                               const char *id,
-                              Error **errp,
-                              va_list vargs)
+                              va_list vargs,
+                              Error **errp)
 {
     Object *obj;
     ObjectClass *klass;
@@ -776,7 +776,7 @@ Object *object_new_with_propv(const char *typename,
     }
     obj = object_new_with_type(klass->type);
 
-    if (!object_set_propv(obj, errp, vargs)) {
+    if (!object_set_propv(obj, vargs, errp)) {
         goto error;
     }
 
@@ -804,14 +804,14 @@ Object *object_new_with_propv(const char *typename,
 
 
 bool object_set_props(Object *obj,
-                     Error **errp,
-                     ...)
+                      Error **errp,
+                      ...)
 {
     va_list vargs;
     bool ret;
 
     va_start(vargs, errp);
-    ret = object_set_propv(obj, errp, vargs);
+    ret = object_set_propv(obj, vargs, errp);
     va_end(vargs);
 
     return ret;
@@ -819,8 +819,8 @@ bool object_set_props(Object *obj,
 
 
 bool object_set_propv(Object *obj,
-                     Error **errp,
-                     va_list vargs)
+                      va_list vargs,
+                      Error **errp)
 {
     const char *propname;
 
diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index ee3c6fb32b..7f31735459 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -373,8 +373,8 @@ static Object *new_helper(Error **errp,
     obj = object_new_with_propv(TYPE_DUMMY,
                                 parent,
                                 "dummy0",
-                                errp,
-                                vargs);
+                                vargs,
+                                errp);
     va_end(vargs);
     return obj;
 }
-- 
2.54.0


