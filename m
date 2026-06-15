Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEC7CD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE8e-0002MJ-7w; Mon, 15 Jun 2026 16:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE8c-0002A7-Qc
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:42:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE8b-0003IA-4G
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CchrLjPFhZL+2KlQGU6T1CSqkzB7rOe0NMGG7vf3ry8=;
 b=Sz0txBnikqUVTeEG/sXIW003FBaxar9ZAWFnRWDG3FzIomus5XlUVIs9OLa0/Pm+tS6+p9
 vYPY8jQw5vnr0h4IJsDOq+rBT3864F2tbz8Mxd8vsRKwEe0LSUKAeY7imRqPgK6KmMxSTi
 QYF66RHHxi04coD9JWOQ1DGI5lgYTSU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-WqUwXXfOPoSRTmjZ1Xuy3A-1; Mon,
 15 Jun 2026 16:42:24 -0400
X-MC-Unique: WqUwXXfOPoSRTmjZ1Xuy3A-1
X-Mimecast-MFC-AGG-ID: WqUwXXfOPoSRTmjZ1Xuy3A_1781556143
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C7BD19560AD; Mon, 15 Jun 2026 20:42:23 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C3E61800361; Mon, 15 Jun 2026 20:42:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:38:19 +0400
Subject: [PATCH v2 53/53] qom: use QAPITypeInfo in object_property_get_enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-53-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4649;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rmXKh8NaHOlNOo20yrV9ADdc3zaw1LReiSMNRI3yDvA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKQrmqGH6xOQMq6CdjAYGCFs92KWgpXoj3LM
 mw77FkZRVqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBikAAKCRDa6OEJdZac
 5QEHD/4/Dh6R0qecWZHGcJ6qWgZCgbj8/UMPVAiyPEbhUd6QK7x+vEftjHZN8bgeG9aEz8Eack2
 aQsV+aiFKuVGsw3p7qAZBjguEsdo8GOiXBfxRKswo+B1Wxhv+m2itwlmSw4VfxAO7/X3nM2ltzC
 mp8wKzyXFB+sGUCwO7Z4jC3jgn09DC9VN/fIOetldOi+3OPpf5jpt7JZj1YaYwvyOzEv/9K23bw
 MRJ3tWnekoES2CpUIIclaan4+mRlvaskcMO/+mjN+iuSJbmw9Z37cy+eOpV/l6aWL/0nW4AssZZ
 HrbK2psLo6Ww/0990MYh0Ydy9Wb54ZG1vNfKQmv4qMMafiAWNJvv7UL9mBoggX3NdZJWeXQzTXm
 YKD/X1AYcnfTx2RpSRAhITN8T4I6m5VFmNb8SfA7IuIjy0Ck+gGhu/5U/+/4zQpEUOfRbf2SbpO
 vsOglFIPNzselwvE8zGSZTiuzGsp1MgKZKHI45tANxbUoKnieHyMiz3/TE3eCZUiE6iZ+D37gTF
 TYcrEHNVIyvUQ9U+PCQ+xy0OL9xfXEAVQP+To2A1yao0Zoe9u1Hi6RjOjVpiJaynJT1KLYGoOxk
 w8cWkq/5TjIfCG4I8JC71vQIZwNHC1VOHe3ecZjE5Qk+wnB8ikLhFZmxqRn++NpKxErub46+DKN
 LRVLeJ86gx6yKrg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
index c8dc9d5bd2d..80c0b2e71f4 100644
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
index 486c36e1cd9..527e1354ae8 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1774,7 +1774,7 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
 }
 
 int object_property_get_enum(Object *obj, const char *name,
-                             const char *typename, Error **errp)
+                             const QAPITypeInfo *type_info, Error **errp)
 {
     char *str;
     int ret;
@@ -1784,10 +1784,10 @@ int object_property_get_enum(Object *obj, const char *name,
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
index b053237f0b2..cb8328d0f45 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -583,14 +583,14 @@ static void test_dummy_getenum(void)
 
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
@@ -598,7 +598,7 @@ static void test_dummy_getenum(void)
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


