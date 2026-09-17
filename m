Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A691DC982D7
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Ecg-00067H-MU; Thu, 17 Sep 2026 12:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7EcH-0005pX-Vg
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7EcE-0006rP-AO
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789661136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yFy03EcNo/zN+LXjPdSvqXANo3cII39jdhmCAaK+hoc=;
 b=Q2G9Tmzo3tJnCvp/gJ00oIkTdZl8gw3olFArOZ2pYiid1xQSKrzyQHdlaTWZnVqxJe6u9G
 NiuYdWrMiMibrfIgCPCBDU2MuL6kkwYQmuh5OKH76mFB65GNub+kiWgGoPzZgZKGwEdezP
 TJoeBHgGGDHpKlAuqxET0eOF0FBiTG4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-0WXWCDLCNLqHvaCGU91Tcg-1; Thu,
 17 Sep 2026 12:05:34 -0400
X-MC-Unique: 0WXWCDLCNLqHvaCGU91Tcg-1
X-Mimecast-MFC-AGG-ID: 0WXWCDLCNLqHvaCGU91Tcg_1789661133
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB123195DE3A; Thu, 17 Sep 2026 16:05:33 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 82D96300022B; Thu, 17 Sep 2026 16:05:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/14] qom: add helper API for checking object class security
 policy compliance
Date: Thu, 17 Sep 2026 17:05:14 +0100
Message-ID: <20260917160525.1275388-4-berrange@redhat.com>
In-Reply-To: <20260917160525.1275388-1-berrange@redhat.com>
References: <20260917160525.1275388-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This helper simply avoids a verbose code pattern being repeated for
many callers.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h | 13 +++++++++++++
 qom/object.c         |  9 +++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 687ceb6bba0..32852186646 100644
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
index 32736a01114..41b1ec81d4e 100644
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


