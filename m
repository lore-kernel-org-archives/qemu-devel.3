Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032A1C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a4m-0001DU-3G; Fri, 04 Sep 2026 15:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a4k-0001CU-OJ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a4i-0007zu-Jw
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788551988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7J5rDG5/EYHfs0elw1VWOZICe1bhAnDOgdsBA4H/iS4=;
 b=VRj41Zg2DND/ujwup9BlX8gyUnoLuE8qB268boA2TR8XvnDZ0P1ylTFTVsena+/BmObARc
 tDEMFSKMM0vHj/7NtA7tsc/XCk6+ZYGdsiQD8e/OgqV6jLzLSG3gzcwlQ9Uto0B2vTfnln
 uAGeRiv++4K+pZGc7cpM8OzZirseS5w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-2FE-3UltME27Ut6_wWBkpA-1; Fri,
 04 Sep 2026 15:59:46 -0400
X-MC-Unique: 2FE-3UltME27Ut6_wWBkpA-1
X-Mimecast-MFC-AGG-ID: 2FE-3UltME27Ut6_wWBkpA_1788551985
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A8F918AB46B; Fri,  4 Sep 2026 19:59:45 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEB6030002F4; Fri,  4 Sep 2026 19:59:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:09 +0400
Subject: [PATCH v4 26/75] whpx: convert OnOffAuto hyperv property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-26-a985f168e938@redhat.com>
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
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2570;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Mn+NBGd5O+Kz+F0i6rOpINobPupnBt+Vn6TD6qzoVJo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLJ8fP+sdFSYt4ONvt0e03KCwESu//GCn+r7
 +XlMxilbvOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyQAKCRDa6OEJdZac
 5YpAEACmUWJpN1NIxQYUydZn18rG73a016bgg5lPG9xENOwa/2/4khiGgL5mk5dy891+wktaxEn
 QShWZp1KQWq7tsaTPn+DQhwH8d2EuiP+XBQnjk2ZmVbsVBO7tCCp9YOSJt0wGlZ01qYnoaGwiOD
 fy0zt3qppZmFAeo+c/bU84gSvhTl6sKr7dPeg1ChPiH6xkmiLbHqJnsKHmceuDT5iLQQTpoUC64
 aI6AZBKdKDuRVFFS6DdIUTkjJWmx+BRklVEDPeZzgGHbms1h0wkiwi3BjqqSK8UKkv+/MN17MQD
 EjzNSbIO59zrJaw+xut5urS883pyTMtxcCEOnIDaSPh6aXEm2/89kVLFU7R7nAle4UVZGgHWLpC
 f/8fWeERG9pRdUamS8az+OdR5+aYlDUocEGU4hcxL79xDtaALgQpxOXVwOHrZj4dJS4YNhrXgho
 PtoUj/LLLh0Xa9HJSTfAglm8lImFEBKUdbga1dKiBrA5Ai4S1Cm2iNFwoYWUf7ECZZVgIjAti1p
 P7VOB1sXx/QvEjnjewX+sbIPDoQUA0tsC5nZ08EF5LvBf6nJKCgkixPiZyiDJrqWBrZFd8pFjbX
 pyzRwTEpUSew/WuksYbpjOk/MTaB1ix55rrchWxZTUy+cZ8tOEknHUFFLYZNiDcVrks4H+uwQau
 nHoGmsJN5AoPE+Q==
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

Convert the hyperv OnOffAuto property from manual visitor-based
callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 accel/whpx/whpx-common.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 247e12db8128..187938c02b51 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-common.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qapi/qapi-visit-common.h"
 #include "migration/blocker.h"
 #include "accel/accel-cpu-target.h"
@@ -470,18 +471,11 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
     }
 }
 
-static void whpx_set_hyperv(Object *obj, Visitor *v,
-                                   const char *name, void *opaque,
-                                   Error **errp)
+static void whpx_set_hyperv(Object *obj, int value, Error **errp)
 {
     struct whpx_state *whpx = &whpx_global;
-    OnOffAuto mode;
 
-    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
-        return;
-    }
-
-    switch (mode) {
+    switch (value) {
     case ON_OFF_AUTO_ON:
         whpx->hyperv_enlightenments_allowed = true;
         whpx->hyperv_enlightenments_required = true;
@@ -497,11 +491,7 @@ static void whpx_set_hyperv(Object *obj, Visitor *v,
         whpx->hyperv_enlightenments_required = false;
         break;
     default:
-        /*
-         * The value was checked in visit_type_OnOffAuto() above. If
-         * we get here, then something is wrong in QEMU.
-         */
-        abort();
+        g_assert_not_reached();
     }
 }
 
@@ -533,11 +523,12 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "kernel-irqchip",
         "Configure WHPX in-kernel irqchip");
-    object_class_property_add(oc, "hyperv", "OnOffAuto",
-        NULL, whpx_set_hyperv,
-        NULL, NULL);
-    object_class_property_set_description(oc, "hyperv",
-        "Configure Hyper-V enlightenments");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "hyperv",
+        .description = "Configure Hyper-V enlightenments",
+        .qapi_type = &OnOffAuto_type_info,
+        .set = whpx_set_hyperv,
+    ));
 
     whpx_arch_accel_class_init(oc);
 }

-- 
2.55.0.543.g5ebe2ebe4ea8


