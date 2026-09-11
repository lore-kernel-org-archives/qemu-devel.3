Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8C5C88E58
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54Je-0007eo-Ac; Fri, 11 Sep 2026 12:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54JQ-0007OT-90
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54JO-0007LH-DB
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WeVOBHQkCvC0XwLo7TG2qrvX/rqsXNC28uR/Ps0fpcg=;
 b=hKBuu14MqgIjpBPNI1Aj2Y2BxKaKHtwECfjpf4d/0BFDAHhzA4vfXjVeUXmaOiCJgxq1oN
 ERnyEEFVYRuPO9h7i7uAguJE3x4dNe9jgdFozZuxEo7dI0QttelT1aRUmCGkfb3vcZw3H0
 Oel48Iz4C5vpu7hLnmQKyGHh7DWK24U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-rcFW2ah9Noy68pnyUCa0KA-1; Fri,
 11 Sep 2026 12:41:08 -0400
X-MC-Unique: rcFW2ah9Noy68pnyUCa0KA-1
X-Mimecast-MFC-AGG-ID: rcFW2ah9Noy68pnyUCa0KA_1789144866
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEE68180136D; Fri, 11 Sep 2026 16:41:06 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C1ECA180034C; Fri, 11 Sep 2026 16:41:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:33 +0400
Subject: [PATCH v5 59/62] qom: use QAPITypeInfo in object_property_get_enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-59-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4675;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mCUaQP+PMbwio8wO+Fb5G23JdGsVTJ0kQ84RxKYhKgs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC28UuYSQ4M/qHrqyrG/nZa50FTpFGvPHG6tH
 D3TDrbjjPyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtvAAKCRDa6OEJdZac
 5S2wD/wM89NLkqgjdlSDVJZ9bcZOh0YusVzshKLG4hs6GH/As6w8a1k3adlFM7ObEAFZcZpSg8K
 UdytdHaOHNE1yf7PQKBQk9TQ5n0REf0Vzsl+wgYLc+cFiyUvd2cpdrLBxB4G1F/FGqIy1pE6Fks
 yhUfCzOH11mhFeQhb1LNA1lEBWQZouongzniyDg0lXH/ZZdfqQ9zCo6QnlbO1fS18htSgfri9nq
 r2Yl4Eh6irknOpKxjsZ6FpPESHvTGuJCZu0ggE3vulEJTvBFHv6F4CPZ5ob4GK278tGYE3SV3sQ
 F+oSlzR/9YWKS1B7DBbzUzgokpC+J40YH+Bl1LanXw/PDACpLiLtcedxkeltC4PCR44m4w+U/ml
 C/yh3buB89YX2R6eChmurppp6iNcUOkfp4X6EHt0P/u99xIS22Al+IyT+mvNaGIh57nZCGD8IOE
 02YZqAfLmNWcU/PudZ+btDq/4mUyCkpDEEbeCPTlj9/rlQHM7eZ/L4I66cQGWgi/DeIL4B04jws
 gUgaPIr1aAjj4JkaB0+cq2P4NcQh7j0RW267jl8QNfSJxCdsJDwbdscGUIEHUtmck9yN+hraczZ
 f7/5Pryr6ANB8q+DtmADhS5HZLf2c6JmMqHcN2X7v6xV6swEBVP6I1dOQeQjOrc7Z68gdi/zyc5
 IaXKyW/EashZSoA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The typename parameter becomes a QAPITypeInfo pointer, and the
validation compares prop->qapi_type against it instead of matching
prop->type strings.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/machine-qmp-cmds.c      | 3 ++-
 include/qom/object.h            | 4 ++--
 qom/object.c                    | 8 ++++----
 tests/unit/check-qom-proplist.c | 6 +++---
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 543dd3201b5a..1c23ec8897f0 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -18,6 +18,7 @@
 #include "qapi/qapi-commands-accelerator.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qobject/qobject.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
@@ -219,7 +220,7 @@ static int query_memdev(Object *obj, void *opaque)
         } else {
             m->has_reserve = true;
         }
-        m->policy = object_property_get_enum(obj, "policy", "HostMemPolicy",
+        m->policy = object_property_get_enum(obj, "policy", &HostMemPolicy_type_info,
                                              &error_abort);
         host_nodes = object_property_get_qobject(obj,
                                                  "host-nodes",
diff --git a/include/qom/object.h b/include/qom/object.h
index 4bedf17b6c8f..e09af481440d 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1532,7 +1532,7 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
  * object_property_get_enum:
  * @obj: the object
  * @name: the name of the property
- * @typename: the name of the enum data type
+ * @type_info: the QAPITypeInfo of the enum
  * @errp: returns an error if this function fails
  *
  * Returns: the value of the property, converted to an integer (which
@@ -1540,7 +1540,7 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
  * value is not an enum).
  */
 int object_property_get_enum(Object *obj, const char *name,
-                             const char *typename, Error **errp);
+                             const QAPITypeInfo *type_info, Error **errp);
 
 /**
  * object_property_set:
diff --git a/qom/object.c b/qom/object.c
index a0e3af61ae29..46c8e2f7c62d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1765,7 +1765,7 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
 }
 
 int object_property_get_enum(Object *obj, const char *name,
-                             const char *typename, Error **errp)
+                             const QAPITypeInfo *type_info, Error **errp)
 {
     char *str;
     int ret;
@@ -1775,10 +1775,10 @@ int object_property_get_enum(Object *obj, const char *name,
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
index 69155e720751..1cb48c7490ef 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -582,14 +582,14 @@ static void test_dummy_getenum(void)
 
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
@@ -597,7 +597,7 @@ static void test_dummy_getenum(void)
     /* A non-enum property name */
     val = object_property_get_enum(OBJECT(dobj),
                                    "iv",
-                                   "DummyAnimal",
+                                   &dummy_animal_qapi_type_info,
                                    &err);
     g_assert(val == -1);
     error_free_or_abort(&err);

-- 
2.55.0.543.g5ebe2ebe4ea8


