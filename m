Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FB5C88E58
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54HJ-0002nR-TO; Fri, 11 Sep 2026 12:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54HH-0002X8-1k
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:39:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54HF-0006ag-Fj
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hf0XO4+R3gQa5sXkL7jGB/4v7ZvBVWznyOSE409p7Sg=;
 b=Ccf8FdAB0Q023qm4uZ/9HX0xf/RtJUAbGO1hQV3f8rBEoIZKIDH1sY4EgVESnGJnY1Bmgz
 XjH+fTIVo2b3gD1CXM1spNlbqQ6XMooQ3k3bS4OEd/lBGbxUZ8HBwas7M3T2eT4FLLcHb4
 s26a37Rkw21knFlyDAAOPMJ7lCqyunI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-a91hesuRNQaQTtdQgbK1fQ-1; Fri,
 11 Sep 2026 12:38:57 -0400
X-MC-Unique: a91hesuRNQaQTtdQgbK1fQ-1
X-Mimecast-MFC-AGG-ID: a91hesuRNQaQTtdQgbK1fQ_1789144736
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FE561953967; Fri, 11 Sep 2026 16:38:56 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 61B3A1956042; Fri, 11 Sep 2026 16:38:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:34:58 +0400
Subject: [PATCH v5 24/62] hostmem-file: convert OnOffAuto rom property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-24-7732a55b7760@redhat.com>
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
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2963;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=B3mRoWkvytxDScscm5YFItkwCjWimSwDclMREfby+x8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC24vmn1kI5syyK9SP8y7mQRjhtfRgLDFleha
 TSNzMqPeZWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtuAAKCRDa6OEJdZac
 5c/VD/9q+xca90nG+SIhIWDmf72s99sVQYYSN1uc7Z/y/1jNGdN48GrGMcfqONZ8HDpSHNfEwhS
 BA1GsdYOL39n9N1dMYmLCpjEwTgO8pG3WMMCZpE9wT9UFAbC3vRa6OkbuJWumV0SFExy1LHT/sW
 tmFOwABRt+AWuoXnoWdYUS8/4h1caYrzfC/jWYGo8EE/xANURrITf6hBRSPkQuTBIfSvzNn86Iz
 YnlPXWwP2VkrKCdzfnSpvIsP97iaSlPRDo43b6zQltEabToKZ0BgyetrZjK5s22VZe9RPJWkUhN
 pmcHpmp8MwLXniLJe/auFtGd3sSnA9+0ul68RI1qn2SUfeueQGLckAHKaM8FbwG+Yq7ePFH4ZJp
 /VQHqeJ9H4ynrRPopQED1Kv3gsS5K3PQD+SdcCuDupxPGwS139sQha5jhBAyyGOOwjG32pEkLHu
 XBXDSHe04foYYeHt/w7ItsaIQsNsTRqBA1eqyA6fgwbOb+d+Ks3YVlMpaeWbB9CUMPcKsQxVByQ
 FKKYaZDyM4rYHBCFJIJMuW6x00/sZSTEeJn4QOgq9Qib+cdpO3fMXPivQAGDm1F4pZsIEVrVgA5
 KPTBSuQD/AL03NUml+VIWHg/1YlD1I2YZbmhjiBQFetPrZ3Bs7j+MQ2NnhjU3vLnrqoUKjqyx3V
 PGofm5fVDRAb9IA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Convert the rom OnOffAuto property from manual visitor-based
callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/hostmem-file.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 8cf27ad67e13..9c7e0183d480 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -19,7 +19,7 @@
 #include "qom/object_interfaces.h"
 #include "qom/object.h"
 #include "qapi/visitor.h"
-#include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-type-infos-common.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendFile, MEMORY_BACKEND_FILE)
 
@@ -230,30 +230,24 @@ static void file_memory_backend_set_readonly(Object *obj, bool value,
     fb->readonly = value;
 }
 
-static void file_memory_backend_get_rom(Object *obj, Visitor *v,
-                                        const char *name, void *opaque,
-                                        Error **errp)
+static int file_memory_backend_get_rom(Object *obj, Error **errp)
 {
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
-    OnOffAuto rom = fb->rom;
-
-    visit_type_OnOffAuto(v, name, &rom, errp);
+    return fb->rom;
 }
 
-static void file_memory_backend_set_rom(Object *obj, Visitor *v,
-                                        const char *name, void *opaque,
-                                        Error **errp)
+static void file_memory_backend_set_rom(Object *obj, int value, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
 
     if (host_memory_backend_mr_inited(backend)) {
-        error_setg(errp, "cannot change property '%s' of %s.", name,
+        error_setg(errp, "cannot change property 'rom' of %s.",
                    object_get_typename(obj));
         return;
     }
 
-    visit_type_OnOffAuto(v, name, &fb->rom, errp);
+    fb->rom = value;
 }
 
 static void file_backend_unparent(Object *obj)
@@ -298,10 +292,13 @@ file_backend_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "readonly",
         file_memory_backend_get_readonly,
         file_memory_backend_set_readonly);
-    object_class_property_add(oc, "rom", "OnOffAuto",
-        file_memory_backend_get_rom, file_memory_backend_set_rom, NULL, NULL);
-    object_class_property_set_description(oc, "rom",
-        "Whether to create Read Only Memory (ROM)");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "rom",
+        .description = "Whether to create Read Only Memory (ROM)",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = file_memory_backend_get_rom,
+        .set = file_memory_backend_set_rom,
+    ));
 }
 
 static void file_backend_instance_finalize(Object *o)

-- 
2.55.0.543.g5ebe2ebe4ea8


