Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B574CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE68-0000zU-Qa; Mon, 15 Jun 2026 16:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE66-0000gs-9N
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:39:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE64-0002eB-Kj
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vUOuphh7lwDnDlIAl256jv50Zp2Hh7oDJoVpT2dTnLY=;
 b=enCKtFaX0dPGvIBl7ow6ainy550Z726lZkxnScq9MdNjwlKTITK6FH1a3RB2aPX7LlkNLW
 thqQTaBKn8LfnSekwVs58Zob/j6fReTXcubYqplaFy82b7EQaJYPI3MuH/RetYED69wp0X
 7eZtTncQqwIqmwHhFPa25O7iSJEzzkU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-Jy_RTC4IOkKFlH20FSBEog-1; Mon,
 15 Jun 2026 16:39:50 -0400
X-MC-Unique: Jy_RTC4IOkKFlH20FSBEog-1
X-Mimecast-MFC-AGG-ID: Jy_RTC4IOkKFlH20FSBEog_1781555989
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB1B818005B6; Mon, 15 Jun 2026 20:39:49 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8915A180049F; Mon, 15 Jun 2026 20:39:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:50 +0400
Subject: [PATCH v2 24/53] whpx: convert OnOffAuto hyperv property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-24-cc9396b9c18c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2550;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tNUW/HBog+/AnPLyqxY75SQ9HHIGR8hgSoU/pzjmByg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKONKXa1XJmVftGWrVrlLb0SO3ZktLCGOUdI
 xXtqzIjKi+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijgAKCRDa6OEJdZac
 5XISD/49CJHz5Qf/Go7dF+Wz3DjwQkQKE5g76KanvKn6AW2qEnERJq5oCvF/BlyCFlSPutZU5Q+
 JKFXPSss9vJX5H6Jb/mXuDVdzvHnDC3Qyqz8E5ZjDDNLBdBgxPimMor2jJSM9/nfyr71ZZukOcV
 OThRueV1uyGtxqU+6HjnNh91y8TjZ1Y/w9PrEJdirZMU6dJ/TKMe9ko0Ks8nfhifWnMEXM1HtgD
 ww9QWkwwhflv8bqP7PRJyPhVEaW1uZDMkVi1fgkZNOZlZpPkdIaq2CzbDB+7Dkytd0kNNb8hoyc
 B8iQZ84rGZwV95f2HRbGfCeWlmndi4yp/B7flp4111vDDa1wMTP+sXDKA+GUYjOPaWC6x22rFm7
 D1wVHIFIoG54N9vH7amanNiJLgBosw3sOdCnd9WnhTEXDdd5BNGX9K76KFe69Sc1trqpy8v6/yX
 ZtUbDO9S39K63DsgAmuffW8XVL1c4nZqqqZWmAzqUOfxcRIf6R2AGQwREcqWo/p0KCmsuV7lhYk
 xIIBdXj1sC6QGFyNl22y7xxhi/KnujtAsnproAZ+9UjwWl0diKD4H2QaIK7n1ppQgshPnt4pF0d
 h2VeCbUrVH28H7q036Nx8UnBZE8SXSCwROXz87FBRVT9WYDkOyl/tw6uTB2rNi+QDpEj3ubBkKV
 FeySrfxxU542jcQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Convert the hyperv OnOffAuto property from manual visitor-based
callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 accel/whpx/whpx-common.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 247e12db812..187938c02b5 100644
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
-
-    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
-        return;
-    }
 
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
2.54.0


