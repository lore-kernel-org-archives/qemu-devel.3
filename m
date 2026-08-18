Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DEAC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHqT-0003PC-4z; Tue, 18 Aug 2026 07:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHqR-0003Ob-Bg
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHqP-00066q-Sx
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787051941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7J5rDG5/EYHfs0elw1VWOZICe1bhAnDOgdsBA4H/iS4=;
 b=C3E8qJnP8flBn530D4yf5mAFc3cYLgsPgl2eduJkXNBe6X1Gy42kpxWa6jT+Q3MSmEMaN2
 JGNFQH18FowoN8Gd+qM274tQbCBqo5e0tJhfM9UO4T6Gt5LafPQUQ2ZLajrRyIHZ0Ldzae
 YBYWcb6oujCXSGH2sJmICstNw6xZpmQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-LfwU2R4YO-eyPqoH7JQ8-Q-1; Tue,
 18 Aug 2026 07:18:59 -0400
X-MC-Unique: LfwU2R4YO-eyPqoH7JQ8-Q-1
X-Mimecast-MFC-AGG-ID: LfwU2R4YO-eyPqoH7JQ8-Q_1787051938
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AA561955F29; Tue, 18 Aug 2026 11:18:58 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E3143000239; Tue, 18 Aug 2026 11:18:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:52 +0400
Subject: [PATCH v3 25/74] whpx: convert OnOffAuto hyperv property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-25-24b8bbbe3d86@redhat.com>
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
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2570;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Mn+NBGd5O+Kz+F0i6rOpINobPupnBt+Vn6TD6qzoVJo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD25/XIwTzrnexCY/7PRcLCO8GpGWV9ylHeZ8
 FYCKmkFnG6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uQAKCRDa6OEJdZac
 5XWrD/9IzPJ3KtiGMwGUjmI7kRXLMJ1fBSRHr5cyWkE6zId68MozjBL2VbraZoaEqmahkjr66c5
 lpa5SBq9kzXOLRNeG5JbSdAI4ALqhCHeO4J/yEVPIzqLWYbFDWEW+76PErxchuZfj2D1mbU38zf
 4yn5lMIjwtL8C7f9+fBkHy7FYlSFBAXuG1IzZ5r1Hln8mpkVtsxCgMRmd+cYCIGVBcMzVHSJHxD
 zJlHH2pnm/Q0hCT/DatEsQnlgKfcxED7e0P2xkdqWV0Sy5e5iThAtrnuVdap0lKwJFxvKu+y/Sv
 u4KCLQZKT2+g9M+bxfXjjKEu6nqFLDn0/Y5qQ7Nzk8DVT+BE7vtLrsJ6F6KUwGodT8Gaa7/jCDk
 h86huSuDQurcHdhbi+IRmeD602fflJYrcb4VI/fV6L0US+UBty0WkvT19caDqjbK2EnRhsLwVjX
 37gYRwEom8SKv+Tyj6bSdWI8NVA20h6ntnaj2T+cTvuVtwEDcKLukycX2Bk1wF2ZTkWE5IwgH/I
 mPbfhOHggZjOTFVv3QYx2JSRsW4RTdeKZfolnoCOxrwGyB1lE3Kq75VwNLrxnsnm+5G3ivqS9sD
 RcBqWGEXjf6ALNjgKh77D4ZfUFX7W7TnWNVBWetRXPFyN2kHUG9Z1nnS8wZNwTmvO4BKRRiwdD7
 nodVP1nG5qLAEkQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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


