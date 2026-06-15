Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A762BCD98E3
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE5y-00005g-Hy; Mon, 15 Jun 2026 16:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE5w-0008W9-VF
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE5v-0002dE-Bx
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dTVSsz2qCp97WwEvttSm7q5i8iO+M//bld04U21UP3Q=;
 b=LTgMyc0oCFph/YntCpHdvmfBTyi1jTBeFJib4eZG/puHP8RA45MqdGrqLqMK2v1WVFcZoc
 3CFFrqtG2IsF7q4hu900PBP+OpEo5UwEDbUaF9CMhMOgbqL7G6OTIiIwVFomdcT4BqDxIF
 mvBIPkfIyCWgUTpMT2x6v9Od1oaJh9g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-1S5iQQ4jOQSGL6nRPDF-ww-1; Mon,
 15 Jun 2026 16:39:39 -0400
X-MC-Unique: 1S5iQQ4jOQSGL6nRPDF-ww-1
X-Mimecast-MFC-AGG-ID: 1S5iQQ4jOQSGL6nRPDF-ww_1781555978
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A24391800599; Mon, 15 Jun 2026 20:39:38 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 99B5F195410F; Mon, 15 Jun 2026 20:39:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:48 +0400
Subject: [PATCH v2 22/53] hostmem-file: convert OnOffAuto rom property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-22-cc9396b9c18c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2943;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=CuFSJq8iGNGVCOyVHepOCVE13II6sJjnLOPYuRRy6k0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKOFqLZRoYv2uovHN/RR4QqzidVcYexW54cs
 d+wtldpX12JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijgAKCRDa6OEJdZac
 5WZsD/0fj7mMfshUVoFGqx0YaoTkRbEzV2MH6yhJEGyyPE6BBfo67ErLWWn/cjBzUUKbbnKM765
 qa+G0I3kMJl4dR9oTKhNJXwNxFPAvG2p0toNORuSrViVgGVHYnP6miD7vv+Rl1sY+pRXCNNIjIo
 3vZLEzFKlbBv5lUQgfHuyzH21fHkUGbWFpLWzFzQOLQ9H5H9rfWcXLw4REDhOdVvkg5fVCDsUV6
 j24/G8jKGpyjsB9lWXj5xnxBP7c0TAsZ1/9vDFI4SbARunwfNRwS0koRWAaEXtKtYHK+/tPAxLZ
 RvSazXE+BpuUBzVuEN0vH945ciC+xHb0kAfjguK/Ven2tSqW2h4AWLhWHbejDgSlDazH+GJ3OHB
 8GbKNa1ZXrrKuBdoLYO4uXkclX1BnFN5F6aOItwj+22KHGFtTWNBg3ETCDblQlNrQb7KzvD2zDp
 fHG8Ob5MxJXLgUO9MzTPIZtzHQPl4QVsZY4ooHgsCqbKhhCwHfygrzY/1C3c1JABJc+e/Qg9/e1
 I/JIYQ1HWw8a4EMCyudRcUT8YFM+bfak0hddyxRlmeqf2srBCePpwBsZLTXNvB3/vf9VHv/vfZM
 JmU83nIuU5YFPDBXPKj3ZmyVysTdwW1e6Py8uZjw+B4AF0nMI6nLom8U6mR7U/GdlHYXIm/qkpJ
 FKwkESaGkvi3KGw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Convert the rom OnOffAuto property from manual visitor-based
callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/hostmem-file.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 8e3219c0617..52b62f71533 100644
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
2.54.0


