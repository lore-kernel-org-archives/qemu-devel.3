Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F46CD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4b8-00027F-5T; Sun, 10 May 2026 09:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4b2-0001wC-Ft
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:53:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4b0-0006Rs-Gm
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778421205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMHgE33Hk8bxjc8Z7+XxgDyHkUfsz/F1aWHoVzZJB6g=;
 b=N7QM6OLmOBjEVU3TlyQu6uHlYqU0NpDEs7mKIBytqv4Yfb7edwazxo2F2aGsowEZLxK/th
 m69blQyub7rTFlNtMlri2Sh6RZVsAwwi7msSIYPPD+SRgf6UXMpS6cHHPPQuyUsPh/vD5X
 7T/0xpGjJKRWyCWbSK4jXwzaU30Ix6s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-3rAwoZ9sOA2yuzwkP3XQ1A-1; Sun,
 10 May 2026 09:53:23 -0400
X-MC-Unique: 3rAwoZ9sOA2yuzwkP3XQ1A-1
X-Mimecast-MFC-AGG-ID: 3rAwoZ9sOA2yuzwkP3XQ1A_1778421203
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F58C1956080
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:53:23 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D26D13002D32; Sun, 10 May 2026 13:53:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:51 +0400
Subject: [PATCH 54/54] qom: use QAPITypeInfo in object_property_get_enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-54-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4649;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RI9rLy0513Xk0Jg11GM3GXY46K98BlGPdQxdRVl/trQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItxnmMmUi+8nbXZV5kDZFF9J3thfQNCCBbL4
 Ji6+BbwCjiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLcQAKCRDa6OEJdZac
 5VB7D/wMybTPK75VO0ZA44e5hqNFOBAZvltaMM0UGqZQb9IByol8zCnnwCPTgOvAdyOYlact8X/
 izyXLRI24V+ImHSEcgUi1MlVA6DQLG2ZhvZZ9O+Wcyj0N97dUXEnrg8BDfyktKjy2yU8VxjG9qM
 WYAvlkrwHKkDZzZIwdegaN0bf4Drwl1g5tn/GA4lxol1xeRvxWWJMjNuyee4eyTosma6kl0WOD6
 IRUFGwJbQCT4I9JwzWoJGa+OrAOi2taygAmE2ebJQaqdtfkb47FKP3qhM5A3GN18ZM2yHOYoqsC
 YooqVtuyVmbawgm7x/qX8+53BZs0slDtLg2scwaaCFwyRj9Cf56sw9t429ir0KVfYbtfH9Iajmu
 PLVmKuSZsh8owbBvY7vgVTA+sNU31PA6GbBxjfFXG6H1QUI1j1TBu12XW76G1RNsxWCmIrb//0I
 /z41EeGTnfJPuWLArKz0KzYMRtqy2kdEvWaYirURN+gO3qzwil0AA2Rs2vLAfWdHr3zRhl5M4+G
 d2v4ckFCd7LkUi2KqCrts+r2wJw+koLhFeutgpO0rRIyzelOQVk0pzoXWSjEtQXDYfoy2aZGSjn
 Ru7BlI4aHFCR8LgjeSzR4Ej95LaU7Ev4W+kVTC2wrOfVrDRyVjxiLo6oJkWMDHqL1WXBEeJP0S8
 1Pr5TXStepPw/Zw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The typename parameter becomes a QAPITypeInfo pointer, and the
validation compares prop->qapi_type against it instead of matching
prop->type strings.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h            | 4 ++--
 hw/core/machine-qmp-cmds.c      | 3 ++-
 qom/object.c                    | 8 ++++----
 tests/unit/check-qom-proplist.c | 6 +++---
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index ba2df54258b..573414c7270 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1410,7 +1410,7 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
  * object_property_get_enum:
  * @obj: the object
  * @name: the name of the property
- * @typename: the name of the enum data type
+ * @type_info: the QAPITypeInfo of the enum
  * @errp: returns an error if this function fails
  *
  * Returns: the value of the property, converted to an integer (which
@@ -1418,7 +1418,7 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
  * value is not an enum).
  */
 int object_property_get_enum(Object *obj, const char *name,
-                             const char *typename, Error **errp);
+                             const QAPITypeInfo *type_info, Error **errp);
 
 /**
  * object_property_set:
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index e62cb4ec888..9b449080dd5 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -17,6 +17,7 @@
 #include "qapi/qapi-commands-accelerator.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qobject/qobject.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
@@ -218,7 +219,7 @@ static int query_memdev(Object *obj, void *opaque)
         } else {
             m->has_reserve = true;
         }
-        m->policy = object_property_get_enum(obj, "policy", "HostMemPolicy",
+        m->policy = object_property_get_enum(obj, "policy", &HostMemPolicy_type_info,
                                              &error_abort);
         host_nodes = object_property_get_qobject(obj,
                                                  "host-nodes",
diff --git a/qom/object.c b/qom/object.c
index c378d20c4db..08f2e93d0a1 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1604,7 +1604,7 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
 }
 
 int object_property_get_enum(Object *obj, const char *name,
-                             const char *typename, Error **errp)
+                             const QAPITypeInfo *type_info, Error **errp)
 {
     char *str;
     int ret;
@@ -1614,10 +1614,10 @@ int object_property_get_enum(Object *obj, const char *name,
         return -1;
     }
 
-    if (!g_str_equal(prop->type, typename)) {
+    if (prop->qapi_type != type_info) {
         error_setg(errp, "Property %s on %s is not '%s' enum type",
-                   name, object_class_get_name(
-                       object_get_class(obj)), typename);
+                   name, object_class_get_name(object_get_class(obj)),
+                   type_info->name);
         return -1;
     }
 
diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index 7f10befe687..d6703e64827 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -528,14 +528,14 @@ static void test_dummy_getenum(void)
 
     val = object_property_get_enum(OBJECT(dobj),
                                    "av",
-                                   "DummyAnimal",
+                                   &dummy_animal_qapi_type_info,
                                    &error_abort);
     g_assert(val == DUMMY_PLATYPUS);
 
     /* A bad enum type name */
     val = object_property_get_enum(OBJECT(dobj),
                                    "av",
-                                   "BadAnimal",
+                                   &dummy_str_qapi_type_info,
                                    &err);
     g_assert(val == -1);
     error_free_or_abort(&err);
@@ -543,7 +543,7 @@ static void test_dummy_getenum(void)
     /* A non-enum property name */
     val = object_property_get_enum(OBJECT(dobj),
                                    "iv",
-                                   "DummyAnimal",
+                                   &dummy_animal_qapi_type_info,
                                    &err);
     g_assert(val == -1);
     error_free_or_abort(&err);

-- 
2.54.0


