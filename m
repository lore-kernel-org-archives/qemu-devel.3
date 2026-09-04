Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D1AC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a4g-00015u-Eb; Fri, 04 Sep 2026 15:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a4e-0000vF-HY
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a4c-0007yf-Ls
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788551982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DOkU7q0xcLJ9xK7CvuM4Ad4dMtqmoGyTkqHMZwunjcU=;
 b=KfiewZfs/WImzSmlHg4OJfytfDHIJZ/raUfXqZ5u5J3go8Ss9agCWlUDRbCXRYgdUZyhdp
 wNbljwC5o4ztjXsN/Z69jLX4eTc1iFf88rF0fWjsjbD/L3dgswp8V0QkX3e8fjRoTol7+R
 axDq4hy42HM8tgjGhpvFNfQ8KBdMb6o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-QICGy3RSPsK6CUMWAkl2aA-1; Fri,
 04 Sep 2026 15:59:38 -0400
X-MC-Unique: QICGy3RSPsK6CUMWAkl2aA-1
X-Mimecast-MFC-AGG-ID: QICGy3RSPsK6CUMWAkl2aA_1788551977
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 847DA19540CA; Fri,  4 Sep 2026 19:59:37 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89ED530002F4; Fri,  4 Sep 2026 19:59:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:07 +0400
Subject: [PATCH v4 24/75] hostmem-file: convert OnOffAuto rom property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-24-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
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
 bh=JNLqfIMCYBOz/tg8GWZhShisq3K0syh9AaTWFqpB/+o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLJH9vR+epp1/UbIDEicRw3fhgZQYqJ1I6HH
 /Us7OW4fv+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyQAKCRDa6OEJdZac
 5e4+D/0UmMbXZwuYWDedkBXrwNU6UXWIEU2kmKg8yIOW3w/SjdLSRrCM0U/YUo1O45qmHIHgV3N
 lSS4uNq/DEjWwO4mYwD8Da2kdYDWmssHTnPbne/tU6qlxr/bTP7zEe/HgDylcQmXKXN+A5CVOod
 k9GyRxNh77cIm0hqhFxADYywhARsqqx7u4a71I9Q3qFBB1zlvmbLGB+dH1JHQRnEnhILhXLe3pV
 EXYCihmOAprp0cw/ps72YUGzW/gba4Xj8ssVtuWcrnZB3gfBu5759PykKMQg2CLD+sv8cZehg3d
 pU/byeEZ7MhgecByIBuh0LzchzEbJQE8wbjrF+SNm0YVKfJHUeYf82fBy5qMuxIIVI8tE5ECaYu
 Ip15j+V0uaB2PM0zWZCPsixeVoIiDvthSZEck2XAcbHagiZG0QV3mxhIoV5FnwReUDsQ8TOCUl/
 jVZ8xFcS60kRq3qUPGJhiV21pgFWiVBgx7OBtJ6UUJgIiQpIcM5Dbi61Seq53Q35z/K3/mWP1XH
 DvTUDvHU5iRb3Y8o+o3QTlxMLNGB1RN0sp1MamfN/rtnQ+wy/VKidJddUI2+kn4i9zzdGjiCgMO
 4XVg7SYjrjCZLHpGjRkVZ0Xj2Z8NZTm5UFpTfT2DwXfLsFW01VC5sNpBFP8sXYMHqr/hfK1Ladj
 PSiYllPCWP5iJzQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
index 8e3219c06172..52b62f715334 100644
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


