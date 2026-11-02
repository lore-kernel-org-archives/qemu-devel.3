Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EFD606A5BC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fw+4gSjh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtDo-0003WM-Mi; Mon, 02 Nov 2026 09:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtDH-0003GA-St
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD8-0008T3-Ex
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HgWj8FyqJvvr9WM7Y2RJU3bqGMRLvuO9KJ4LAR5cySs=;
 b=fw+4gSjhZYV2QJSlXb1GEpUs9Ml2St74qJWHs86k0Xu4MuXoPB8m/GJT83W4ZoknvVXtrY
 VtY2eHhl4DcO05w4FiGa5wm4EaJEEiE2ip405jmIRn3IoNiwjhaml1MkcuDLWEMjKFFhV0
 msLQBC5Bff4OkFOm+vKNCd7WRRoiAQA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-N-Ejf07SOWmA8YL1bTsR-A-1; Mon,
 02 Nov 2026 09:40:31 -0500
X-MC-Unique: N-Ejf07SOWmA8YL1bTsR-A-1
X-Mimecast-MFC-AGG-ID: N-Ejf07SOWmA8YL1bTsR-A_1793630430
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BFE1195DB8E; Mon,  2 Nov 2026 14:40:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A31611956088; Mon,  2 Nov 2026 14:40:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A352221E6836; Mon, 02 Nov 2026 15:40:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 43/74] hostmem: convert OnOffAuto rom property to QAPI-aware
 registration
Date: Mon,  2 Nov 2026 15:39:47 +0100
Message-ID: <20261102144018.3212223-44-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Convert the hostmem-file's rom property and hostmem-memfd's
guest-memfd property from manual visitor-based callbacks to
object_class_property_add_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20261101201717.3911097-27-armbru@redhat.com>
---
 backends/hostmem-file.c  | 25 ++++++++++---------------
 backends/hostmem-memfd.c | 23 ++++++++++-------------
 2 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index aec38bac2f..15b5fee246 100644
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
@@ -298,9 +292,10 @@ file_backend_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "readonly",
         file_memory_backend_get_readonly,
         file_memory_backend_set_readonly);
-    object_class_property_add(oc, "rom", "OnOffAuto", NULL,
-                              file_memory_backend_get_rom,
-                              file_memory_backend_set_rom, NULL, NULL);
+    object_class_property_add_enum(oc, "rom", "OnOffAuto",
+                                   &OnOffAuto_type_info, NULL,
+                                   file_memory_backend_get_rom,
+                                   file_memory_backend_set_rom);
     object_class_property_set_description(oc, "rom",
         "Whether to create Read Only Memory (ROM)");
 }
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 7df0440071..28f7e180f4 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -20,7 +20,7 @@
 #include "migration/cpr.h"
 #include "system/kvm.h"
 #include <linux/kvm.h>
-#include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-type-infos-common.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
 
@@ -98,24 +98,20 @@ have_fd:
                                           backend->size, ram_flags, fd, 0, errp);
 }
 
-static void
-memfd_backend_get_guest_memfd(Object *o, Visitor *v,
-                              const char *value, void *opaque,
-                              Error **errp)
+static int
+memfd_backend_get_guest_memfd(Object *o, Error **errp)
 {
     HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(o);
 
-    visit_type_OnOffAuto(v, value, &m->guest_memfd, errp);
+    return m->guest_memfd;
 }
 
 static void
-memfd_backend_set_guest_memfd(Object *o, Visitor *v,
-                              const char *value, void *opaque,
-                              Error **errp)
+memfd_backend_set_guest_memfd(Object *o, int value, Error **errp)
 {
     HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(o);
 
-    visit_type_OnOffAuto(v, value, &m->guest_memfd, errp);
+    m->guest_memfd = value;
 }
 
 static bool
@@ -206,9 +202,10 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
                                               "Huge pages size (ex: 2M, 1G)");
     }
 
-    object_class_property_add(oc, "guest-memfd", "OnOffAuto", NULL,
-                              memfd_backend_get_guest_memfd,
-                              memfd_backend_set_guest_memfd, NULL, NULL);
+    object_class_property_add_enum(oc, "guest-memfd",  "OnOffAuto",
+                                   &OnOffAuto_type_info, NULL,
+                                   memfd_backend_get_guest_memfd,
+                                   memfd_backend_set_guest_memfd);
     object_class_property_set_description(oc, "guest-memfd",
                                           "Use guest memfd");
 
-- 
2.55.0


