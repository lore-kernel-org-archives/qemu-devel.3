Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819BBC79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4c9A-00033x-O3; Thu, 10 Sep 2026 06:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x4c99-00033k-7U
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x4c97-0007RB-Ox
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789036605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nT7oxGs/bBHJ2PpDTw2GfVUpTr87sAoUZynb4lEObp4=;
 b=Ft3oseGz9uAArVF0CXDxxBG/k3xu/OMKeEDvaQnI8QE1+WY5wKvK0fYgLfG2n3BsFgr1x9
 8rJvPiwPtoug3bnRrgDpOUOTyw1b7ILvh71QxjgUoWXqdS35AlyJ3OoYRzyJPkbKHE3bN1
 UQbHcnsuW968KnWb0rBjSnWUj30EiqE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-FYVQd0ncMCSIfoBjJy2DlA-1; Thu,
 10 Sep 2026 06:36:41 -0400
X-MC-Unique: FYVQd0ncMCSIfoBjJy2DlA-1
X-Mimecast-MFC-AGG-ID: FYVQd0ncMCSIfoBjJy2DlA_1789036600
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97CA818005AE; Thu, 10 Sep 2026 10:36:40 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59E2830001A2; Thu, 10 Sep 2026 10:36:38 +0000 (UTC)
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
Subject: [PATCH v4 03/14] qom: add helper API for checking object class
 security policy compliance
Date: Thu, 10 Sep 2026 11:36:17 +0100
Message-ID: <20260910103628.2326622-4-berrange@redhat.com>
In-Reply-To: <20260910103628.2326622-1-berrange@redhat.com>
References: <20260910103628.2326622-1-berrange@redhat.com>
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

This helper simply avoids a verbose code pattern being repeated for
many callers.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h | 13 +++++++++++++
 qom/object.c         |  9 +++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 687ceb6bba..3285218664 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2405,6 +2405,19 @@ Object *object_property_add_new_container(Object *obj, const char *name);
 char *object_property_help(const char *name, const char *type,
                            QObject *defval, const char *description);
 
+/**
+ * object_class_check_security:
+ * @klass: the object class to check
+ * @errp: a pointer to an Error that is filled if not compliant
+ *
+ * Check whether the object class @klass complies with the
+ * currently requested security policy. Reports an error
+ * in @errp if not compliant.
+ *
+ * Returns: true if compliant, false if an error was raised
+ */
+bool object_class_check_security(ObjectClass *klass, Error **errp);
+
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(Object, object_unref)
 
 #endif
diff --git a/qom/object.c b/qom/object.c
index 32736a0111..41b1ec81d4 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -23,6 +23,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/forward-visitor.h"
 #include "qapi/qapi-builtin-visit.h"
+#include "qapi/compat-policy.h"
 #include "qobject/qdict.h"
 #include "qobject/qjson.h"
 #include "qemu/id.h"
@@ -3149,6 +3150,14 @@ void object_class_property_set_description(ObjectClass *klass,
     op->description = g_strdup(description);
 }
 
+bool object_class_check_security(ObjectClass *klass, Error **errp)
+{
+    return compat_policy_check_security(&compat_policy,
+                                        object_class_get_name(klass),
+                                        object_class_is_secure(klass),
+                                        errp);
+}
+
 static void object_class_init(ObjectClass *klass, const void *data)
 {
     object_class_property_add_str(klass, "type", object_get_type,
-- 
2.55.0


