Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D10CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE63-0000WN-UR; Mon, 15 Jun 2026 16:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE62-0000UR-TP
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:39:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE61-0002dc-Fs
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DbC92ksq5of7KZTbfXcdyg2RQLwK8IIt/OArcqPyFI8=;
 b=SEoVPxHwEKkukGmPnNbw5fFFsYVLcv/XfO+4FyPrhKUTAWIKk366d6C8KVMusZIotmqsnk
 nNy6mUnWGt1xboKJHdyd5twj+V0OpLcF9I6FEjYIeBaOyKJIQe5M33eLRJlMda2eyvSbaC
 edC01y3JtLuI9KbkEdRJAVEizoUr2gs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-TaDKJwpANWGE9TWbWvUXPA-1; Mon,
 15 Jun 2026 16:39:45 -0400
X-MC-Unique: TaDKJwpANWGE9TWbWvUXPA-1
X-Mimecast-MFC-AGG-ID: TaDKJwpANWGE9TWbWvUXPA_1781555984
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4813D1954B1C; Mon, 15 Jun 2026 20:39:44 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFACC19560B2; Mon, 15 Jun 2026 20:39:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:49 +0400
Subject: [PATCH v2 23/53] sev: convert OnOffAuto legacy-vm-type property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-23-cc9396b9c18c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2858;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AJinG3zfRjZMCV6VAf3JzTG4jCr2+Ek+86GoMl4GKrY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKOMCm7Cd0KJHqxNobnVWNFuG5ZUCnLDD6Yv
 jThgn7tS4GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijgAKCRDa6OEJdZac
 5ervEACjW4qHXaKANxc5KsrCux24ucjxQDm3Su7wdHjaod2eDAU5al+1yXGFoDJt8Nxu5Oj21iu
 Q0UuGEUx6vHVzUbtJm8BZYISstnzqrwFLqhOazqwjoIcPg0eEulOJAsCpDoQC94kZMoKiI4Nh4R
 Cc3sq+c7St82nSoV/gAC7d9l7wNZ/CaIZmfdPx8odAx4KrdEoESDRn5sfjRBXF/k/Di9RuR+Vyk
 zBk1tpiF15PbHwwEwdnws5juL2rZlKqpfCLyvGyNsAJw8s8jf5kJNNE53woUTFEJO5mfezbyoS7
 clx2WYmAyjy5+p5p18EIFNNeJAtxGEjnd4P9fMdjFOMsZ5x6gsVvSEVOCUBiXACAO+5AY8gHhV1
 uKz4Ou2/yZh1/4OB29VHDJQLMIbDFycjBXRDWIFAWoaKSRkeuhyL2EA0evxCTNq5NCRQ7etD7Pv
 ZfFuC+XQzhdBc5k+P+0zL/OlkffNwmY02kyH7G/kPaknrVHZz5xsdtakAE/TfiQ8k8DAKkt+Q6a
 l1DLzaTs+xQRCmWMNOHuEIG3HGzMx0JEFQjgJ5E2Cn3n3qN+j4HBFvVmf7TgJfjwPZXr+v8Rt9I
 lS2y6ujLEt+/6iCpONB3NkSDQjRAHgIri9RTq4HEB08nSE2uud0uTFIJDsL0skMroXK23+1LFHz
 PSxuecS67iJFfpQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Convert the legacy-vm-type OnOffAuto property from manual
visitor-based callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/sev.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 99cf30806be..63ccae4c26c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -20,6 +20,7 @@
 #include <sys/ioctl.h>
 
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qom/object_interfaces.h"
 #include "qemu/base64.h"
 #include "qemu/module.h"
@@ -2884,23 +2885,16 @@ sev_guest_set_session_file(Object *obj, const char *value, Error **errp)
     SEV_GUEST(obj)->session_file = g_strdup(value);
 }
 
-static void sev_guest_get_legacy_vm_type(Object *obj, Visitor *v,
-                                         const char *name, void *opaque,
-                                         Error **errp)
+static int sev_guest_get_legacy_vm_type(Object *obj, Error **errp)
 {
     SevGuestState *sev_guest = SEV_GUEST(obj);
-    OnOffAuto legacy_vm_type = sev_guest->legacy_vm_type;
-
-    visit_type_OnOffAuto(v, name, &legacy_vm_type, errp);
+    return sev_guest->legacy_vm_type;
 }
 
-static void sev_guest_set_legacy_vm_type(Object *obj, Visitor *v,
-                                         const char *name, void *opaque,
-                                         Error **errp)
+static void sev_guest_set_legacy_vm_type(Object *obj, int value, Error **errp)
 {
     SevGuestState *sev_guest = SEV_GUEST(obj);
-
-    visit_type_OnOffAuto(v, name, &sev_guest->legacy_vm_type, errp);
+    sev_guest->legacy_vm_type = value;
 }
 
 static void
@@ -2926,11 +2920,14 @@ sev_guest_class_init(ObjectClass *oc, const void *data)
                                   sev_guest_set_session_file);
     object_class_property_set_description(oc, "session-file",
             "guest owners session parameters (encoded with base64)");
-    object_class_property_add(oc, "legacy-vm-type", "OnOffAuto",
-                              sev_guest_get_legacy_vm_type,
-                              sev_guest_set_legacy_vm_type, NULL, NULL);
-    object_class_property_set_description(oc, "legacy-vm-type",
-            "use legacy VM type to maintain measurement compatibility with older QEMU or kernel versions.");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "legacy-vm-type",
+        .description = "use legacy VM type to maintain measurement "
+                       "compatibility with older QEMU or kernel versions.",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = sev_guest_get_legacy_vm_type,
+        .set = sev_guest_set_legacy_vm_type,
+    ));
 }
 
 static void

-- 
2.54.0


