Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A5ED68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC04q-0004CY-0J; Fri, 15 Nov 2024 12:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04i-00042s-7z
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04g-0001WY-En
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731691537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I4tw7doBeG+8gbO5Vlw4cl4cj4yji98/v8xm8WxYBAA=;
 b=UHv4mO8kIjbRSucse5D6Lty0mI/EYiVK5naj1L6j+x+MTruVwZRSzQKNOGEVVzwnQ8LPoT
 LCJD4NpNhN5ULsvEmi5cbmJcGZ6Eo7FDqKgkDtRSo16zUaDgWUyh95AjH7EETs52aBCx3R
 TFbAZD39fDcOkXaAxky3IYa32vuNWKo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-enFzytpGN7SA71PYQDos8Q-1; Fri,
 15 Nov 2024 12:25:36 -0500
X-MC-Unique: enFzytpGN7SA71PYQDos8Q-1
X-Mimecast-MFC-AGG-ID: enFzytpGN7SA71PYQDos8Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F5DC195FE24
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 17:25:35 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D3263003B71; Fri, 15 Nov 2024 17:25:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 4/9] qom: introduce object_new_dynamic()
Date: Fri, 15 Nov 2024 17:25:16 +0000
Message-ID: <20241115172521.504102-5-berrange@redhat.com>
In-Reply-To: <20241115172521.504102-1-berrange@redhat.com>
References: <20241115172521.504102-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

object_new() has a failure scenario where it will assert() if given
an abstract type. Callers which are creating objects based on user
input, or unknown/untrusted type names, must manually check the
result of object_class_is_abstract() before calling object_new()
to propagate an Error, instead of asserting.

Introduce a object_new_dynamic() method which is a counterpart to
object_new() that directly returns an Error, instead of asserting.
This new method is to be used where the typename is specified
dynamically by code separate from the immediate caller.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h | 27 +++++++++++++++++++++++++++
 qom/object.c         |  9 +++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 11ee472719..4fc01336c4 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -624,14 +624,41 @@ Object *object_new_with_class(ObjectClass *klass, Error **errp);
  * object_new:
  * @typename: The name of the type of the object to instantiate.
  *
+ * This method should be used where @typename is statically specified
+ * from a const string at build time, where the caller does not expect
+ * failure to be possible.
+ *
  * This function will initialize a new object using heap allocated memory.
  * The returned object has a reference count of 1, and will be freed when
  * the last reference is dropped.
  *
+ * If an instance of @typename is not permitted to be instantiated, an
+ * assert will be raised. This can happen if @typename is abstract.
+ *
  * Returns: The newly allocated and instantiated object.
  */
 Object *object_new(const char *typename);
 
+/**
+ * object_new_dynamic:
+ * @typename: The name of the type of the object to instantiate.
+ * @errp: pointer to be filled with error details on failure
+ *
+ * This method should be used where @typename is dynamically chosen
+ * at runtime, which has the possibility of unexpected choices leading
+ * to failures.
+ *
+ * This function will initialize a new object using heap allocated memory.
+ * The returned object has a reference count of 1, and will be freed when
+ * the last reference is dropped.
+ *
+ * If an instance of @typename is not permitted to be instantiated, an
+ * error will be raised. This can happen if @typename is abstract.
+ *
+ * Returns: The newly allocated and instantiated object.
+ */
+Object *object_new_dynamic(const char *typename, Error **errp);
+
 /**
  * object_new_with_props:
  * @typename:  The name of the type of the object to instantiate.
diff --git a/qom/object.c b/qom/object.c
index ad5b3b9582..42ef40a1fd 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -806,6 +806,15 @@ Object *object_new(const char *typename)
     return object_new_with_type(ti, &error_abort);
 }
 
+Object *object_new_dynamic(const char *typename, Error **errp)
+{
+    TypeImpl *ti = type_get_or_load_by_name(typename, errp);
+    if (!ti) {
+        return NULL;
+    }
+
+    return object_new_with_type(ti, errp);
+}
 
 Object *object_new_with_props(const char *typename,
                               Object *parent,
-- 
2.46.0


