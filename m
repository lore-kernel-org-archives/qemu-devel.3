Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C333DC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4MXu-00014U-8m; Wed, 09 Sep 2026 13:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x4MXs-00013L-Ae
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x4MXq-0004cK-NX
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788976633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8CclW0PON7nJCVjhG7xjOVoR0g63Bl/7rP5zKF5rGKg=;
 b=KI1+ga6K7dFd0RBtZicA7t1ql1eoiBkDndBDCSsRJgB9Ax9aUwnt+6ihl3ogKN4klZ5fGK
 jI/4IdbsRyawZ0g7PjO344c5/624FsN5ZzQ/DzoJxQnsvnGJ5e8ZelSB6obIBgmNhYEXkB
 RezXWJbfHtFq72c3lNfjl5CBvejwNNM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-K3rIcHfQP0KqiohKtlUe6A-1; Wed,
 09 Sep 2026 13:57:10 -0400
X-MC-Unique: K3rIcHfQP0KqiohKtlUe6A-1
X-Mimecast-MFC-AGG-ID: K3rIcHfQP0KqiohKtlUe6A_1788976629
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 755931800BC8; Wed,  9 Sep 2026 17:57:09 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D8A9195608C; Wed,  9 Sep 2026 17:57:06 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 03/14] qom: add helper APIs for checking object security
 policy compliance
Date: Wed,  9 Sep 2026 18:56:45 +0100
Message-ID: <20260909175656.1572689-4-berrange@redhat.com>
In-Reply-To: <20260909175656.1572689-1-berrange@redhat.com>
References: <20260909175656.1572689-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

These helpers simply avoid a verbose code pattern being repeated for
many callers.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h | 26 ++++++++++++++++++++++++++
 qom/object.c         | 15 +++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 687ceb6bba..3b83ceb7b1 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2405,6 +2405,32 @@ Object *object_property_add_new_container(Object *obj, const char *name);
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
+/**
+ * object_check_security:
+ * @obj: the object instance to check
+ * @errp: a pointer to an Error that is filled if not compliant
+ *
+ * Check whether the object @obj complies with the
+ * currently requested security policy. Reports an
+ * error in @errp if not compliant.
+ *
+ * Returns: true if compliant, false if an error was raised
+ */
+bool object_check_security(Object *obj, Error **errp);
+
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(Object, object_unref)
 
 #endif
diff --git a/qom/object.c b/qom/object.c
index 32736a0111..2c93c17802 100644
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
@@ -3149,6 +3150,20 @@ void object_class_property_set_description(ObjectClass *klass,
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
+bool object_check_security(Object *obj, Error **errp)
+{
+    ObjectClass *klass = OBJECT_CLASS(obj);
+    return object_class_check_security(klass, errp);
+}
+
 static void object_class_init(ObjectClass *klass, const void *data)
 {
     object_class_property_add_str(klass, "type", object_get_type,
-- 
2.55.0


