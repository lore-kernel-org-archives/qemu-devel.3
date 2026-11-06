Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD18606A32D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YW0E7djL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPHkg-000535-Pa; Fri, 06 Nov 2026 06:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPHkc-0004xs-DL
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:04:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPHkY-0007j0-4m
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793963089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJ0hyg0iNE7uM6wDdiPGtxNhBm5Xr6bEsdSHE3SnWq8=;
 b=YW0E7djLtn01yR8tUYm7AqwrH3IO4nq2g4WvaalMNfbnC3oOiHb7gO4VRsylzpkfxDy85w
 3o02m45AytZEwQsMi0vV59nqUDv7gqcUvbTYwBdH1mThcUj/SdVyBFchXPUmeXue3dsl8D
 HV/HNXXckZo79T5MMeOyNgq4CAQFVys=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-1owJFWZlOcyM1bO_tJzWBg-1; Fri,
 06 Nov 2026 06:04:47 -0500
X-MC-Unique: 1owJFWZlOcyM1bO_tJzWBg-1
X-Mimecast-MFC-AGG-ID: 1owJFWZlOcyM1bO_tJzWBg_1793963086
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C7C91955F44; Fri,  6 Nov 2026 11:04:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B043187C36A; Fri,  6 Nov 2026 11:04:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CDABB21E6886; Fri, 06 Nov 2026 12:04:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, mark.caveayland@nutanix.com
Subject: [PATCH 7/8] hw/gpio/pca955x: Improve @qapi-type reported by qom-list
 etc.
Date: Fri,  6 Nov 2026 12:04:39 +0100
Message-ID: <20261106110440.3552588-8-armbru@redhat.com>
In-Reply-To: <20261106110440.3552588-1-armbru@redhat.com>
References: <20261106110440.3552588-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/gpio/pca9552.c | 6 +++---
 hw/gpio/pca9554.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 99c4e0c0e2..f97ad6d083 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -23,7 +23,7 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
-#include "qapi/qapi-builtin-type-infos.h"
+#include "qapi/qapi-type-infos-machine.h"
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/visitor.h"
 #include "trace.h"
@@ -547,14 +547,14 @@ static void pca955x_pin_init(PCA955xClass *k)
             /* LED variant: expose the LED selector state as led%d. */
             name = g_strdup_printf("led%d", ix);
             object_class_property_add(OBJECT_CLASS(k), name,
-                                      "str", &str_type_info,
+                                      "str", &Pca9552LedState_type_info,
                                       pca955x_get_led, pca955x_set_led,
                                       NULL, NULL);
         } else {
             /* GPIO variant: expose the pin logic level as pin%d. */
             name = g_strdup_printf("pin%d", ix);
             object_class_property_add(OBJECT_CLASS(k), name,
-                                      "str", &str_type_info,
+                                      "str", &GpioPinState_type_info,
                                       pca955x_get_pin, pca955x_set_pin,
                                       NULL, NULL);
         }
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index 7bbfd5ed5f..e2d481866f 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -17,7 +17,7 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
-#include "qapi/qapi-builtin-type-infos.h"
+#include "qapi/qapi-type-infos-machine.h"
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/visitor.h"
 #include "trace.h"
@@ -288,7 +288,7 @@ static void pca9554_pin_init(PCA9554Class *pc)
 
         name = g_strdup_printf("pin%d", pin);
         object_class_property_add(OBJECT_CLASS(pc), name,
-                                  "str", &str_type_info,
+                                  "str", &GpioPinState_type_info,
                                   pca9554_get_pin, pca9554_set_pin,
                                   NULL, NULL);
         g_free(name);
-- 
2.55.0


