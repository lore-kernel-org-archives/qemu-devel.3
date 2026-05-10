Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E33CD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4WE-0005OP-LZ; Sun, 10 May 2026 09:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4W2-0004e7-Gb
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:48:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4W0-0005K9-W2
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vUOuphh7lwDnDlIAl256jv50Zp2Hh7oDJoVpT2dTnLY=;
 b=WPQXOIooUyIfCdPlJGOEhPfBfswL7OzGgeoXpaf0/cSiryFOoBcEt8hOKatYGQAwPFbCxd
 IeXze16vKw18KovrSmYUwR2e4wf5qgcFUGR8JFd3oaZbZUnXvrCP+AiJIk/u/jueCKCVT+
 tFdIwFvJjwm1EonA5+j3/QWQ2M49s+c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-Ue7ULSP4OgyVpUsbZ9UV9A-1; Sun,
 10 May 2026 09:48:11 -0400
X-MC-Unique: Ue7ULSP4OgyVpUsbZ9UV9A-1
X-Mimecast-MFC-AGG-ID: Ue7ULSP4OgyVpUsbZ9UV9A_1778420890
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65961195608E
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:48:10 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3664A3002D30; Sun, 10 May 2026 13:48:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:21 +0400
Subject: [PATCH 24/54] whpx: convert OnOffAuto hyperv property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-24-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2550;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tNUW/HBog+/AnPLyqxY75SQ9HHIGR8hgSoU/pzjmByg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItvI5fn1713UO8RcMupeUPRW1Ss8xgLD0l9H
 PX48CuUNOWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbwAKCRDa6OEJdZac
 5ef7EACa72qHz9n98mHFOQoOgSx+ec3utmD0LBWCGfpGFCUw58noJdyn2d6xtp4gisYpaq3E1di
 lJt5fzchHFVmf9E78OcmK/8se0kyJscfrZammeDs5P6tyUW59TmvGToQPXCrcZ7HaHgpFCuq0dw
 +pSEMbZK4Z5ospRX75ayywwZBE1+V5WuW4wy5BZnNGq/GcnUQRAtEIxS5+bPXqNcI0DN8maIFnL
 D5NIl3mD+hJtK36fdoRYf4BlmDtTLWG5sbByhomZ9ZBurdzzimirYa+4r0LVua+YXCxL99liI/b
 c7WwseIJtAixogQEGhqhyU0Ep74U3K56UHCE+bcM3B1sa0q5Cht/x/znFhr0GzcjCX4oYz7P85M
 NNyFNyQ9zovYQN5pQu/jR0Tulo4HhdlYERu3SgLmukIFz20G07zvMnVrBjDuIWZL82q5eoFOTy3
 3jXLsFj5QNuBY/g3NgLqMbg6TeN1wF9YQZKJwr5WUDNWKfpglydd0iqYLM3S6MlDVenieUrhS7u
 BtLdZMAgDA7k6KOf3FHUz3BpErW8qmPtRs6unufDX1Ie3AR923CAzUFTd+qU7h8ytcAbtUZcEb2
 HzcrPJKBk2IIVpchyiPMQahk0ZzoPx6D1aQS0tKB4QPbjXRpmbMimKYjC2oNWokxRTAu7FPlCo8
 55hHi9qXzgl/neQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


