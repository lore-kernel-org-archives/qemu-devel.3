Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B649C5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwK0f-0002P3-GU; Tue, 18 Aug 2026 09:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwK0e-0002KV-An
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:37:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwK0c-0000pd-KW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787060262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/xcTmQPUahfJ134xZYmQZLSB934twH1Et80D5mL4nj0=;
 b=h3Ohmm8IUCQXhMe4X0x6c6mj6PPfcOGspjpJnIcMhlZGU9v3xEQKVgvXYY8Yp7ygAXI4I6
 WV68SwJjmgvHx0mbF5Vsy4Q8OxpIA2tgP9pEANp05uMOvjm4hWc+QziSR1NqHA9BLa5AYU
 f5EXkbxLrpI/ukjl9aqB2tXb1wz1sJQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-orDUT1ZmOZGFCxn_A2S2Zw-1; Tue,
 18 Aug 2026 09:37:34 -0400
X-MC-Unique: orDUT1ZmOZGFCxn_A2S2Zw-1
X-Mimecast-MFC-AGG-ID: orDUT1ZmOZGFCxn_A2S2Zw_1787060251
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7DE918009B9; Tue, 18 Aug 2026 13:37:30 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 287303000239; Tue, 18 Aug 2026 13:37:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 17:29:38 +0400
Subject: [PATCH v3 72/74] qom: use QAPITypeInfo in object_property_get_enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-72-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4675;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5s4MLN2op9P8GCk3+gG5r8DgTGpBqvzieEC1NIucyC0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhF90TfylNqqL6DFnLw7+3WYMNJN87QNFFNPVG
 N4V2oVhowqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoRfdAAKCRDa6OEJdZac
 5QJvEACFVH/ZFoaFYIu3mCy42rE6YwGHHAjiUm5Car7anWLuE9/7a/dEEJ7tT42+NVwn70KaCN8
 IdRlgQ4IrS4aMWSU2qHekFNPv0fZm9Gm2wrtD0KsBhx/rez5I1cNX8BIGcC1WTBW0bz7RWo/jKf
 DCBnpZKDJ/zd84tvljK/cjWlaVeBce8+inllxHkWpXoIU2wcFXTIH0vS7k6dWGtp/AFANAXCCYI
 PWNauVERNoqQHsVTEx6rWEy/8Fdv9EBmRMG6Pkif4/uXPTIiknZJ5xOcPemp/G+iMpT+EsWrnkb
 zqOHZXR1A6onwucZG1+Yat7aBt0EZ9sSQf8JMFTymUb8+NjcyT7Sg21AnZjcdLFwB7hIQUDH06e
 kARP8fueSeJLy5A2C3uJrRtuHUswgr+guXZr7jj/R5ADLH7x96OIFhCGsUGeT3/gb/5SLSDON7q
 CGyIhX3Ia5PERyVFsnpXGS3VvK5/CeVDgUJL0pICZvDA4WEXYNc8wFDw+FH+LVxq0oQbebiMBQH
 yhKGx4mYR1UC/5AXLX59784gvIRd5ZSlW9CXedIvve4SpVmvFSHq7rf1/rFqxO41Zipty7OJ9Sk
 mycYv2NBRaTs+Z2LA3OBor/N6LmsbcHuTObFHy0H/QLsef+F/7q8FyFjShcW5u9aGyJQT2gp6fb
 3HOCF2fEnorqBXA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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
index 1aa5f2622986..f6f3024752b1 100644
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
index db4972294e39..e2f7d546f68f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1529,7 +1529,7 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
  * object_property_get_enum:
  * @obj: the object
  * @name: the name of the property
- * @typename: the name of the enum data type
+ * @type_info: the QAPITypeInfo of the enum
  * @errp: returns an error if this function fails
  *
  * Returns: the value of the property, converted to an integer (which
@@ -1537,7 +1537,7 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
  * value is not an enum).
  */
 int object_property_get_enum(Object *obj, const char *name,
-                             const char *typename, Error **errp);
+                             const QAPITypeInfo *type_info, Error **errp);
 
 /**
  * object_property_set:
diff --git a/qom/object.c b/qom/object.c
index 4d7c9181fb6e..dadeb5d5b991 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1761,7 +1761,7 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
 }
 
 int object_property_get_enum(Object *obj, const char *name,
-                             const char *typename, Error **errp)
+                             const QAPITypeInfo *type_info, Error **errp)
 {
     char *str;
     int ret;
@@ -1771,10 +1771,10 @@ int object_property_get_enum(Object *obj, const char *name,
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


