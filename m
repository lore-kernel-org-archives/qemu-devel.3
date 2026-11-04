Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE0F606A32C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 06:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QX6qwLC/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOUlA-0006nH-Jo; Wed, 04 Nov 2026 01:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOUl1-0006kq-1E
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 01:46:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOUkx-0002cc-SI
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 01:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793774758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJkENVTgYTdi4u0Zr1loAV2vSNshTjs+5mziHstz0QU=;
 b=QX6qwLC/WpMuSHNJWIDeGAcetqggCeMfR2AJsXgDIWo4UQeY8d8gv5cMzBPh41NgWkHhye
 sPWX1zzq/IYD0n4sumdNm6xwBDAUadjm/c/4H+W5WHA7Gnd1MpYFYaygYD2SPRQjYZB1YO
 Fn/1v0wXOQ7d1jqlARJkBVVjIG4hAuU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-vZQskqftPwWmxC5Abpx8IQ-1; Wed,
 04 Nov 2026 01:45:56 -0500
X-MC-Unique: vZQskqftPwWmxC5Abpx8IQ-1
X-Mimecast-MFC-AGG-ID: vZQskqftPwWmxC5Abpx8IQ_1793774755
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCC871956058; Wed,  4 Nov 2026 06:45:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 533D530000E8; Wed,  4 Nov 2026 06:45:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD9B721E6882; Wed, 04 Nov 2026 07:45:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 milesg@linux.ibm.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 3/4] hw: Fix up PropertyInfo to set @qapi_type
Date: Wed,  4 Nov 2026 07:45:51 +0100
Message-ID: <20261104064552.959862-4-armbru@redhat.com>
In-Reply-To: <20261104064552.959862-1-armbru@redhat.com>
References: <20261104064552.959862-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When we recently updated PropertyInfo to set @qapi_type, we missed a
few.  Update them now.

Fixes: 04dc2fe4d463 ("hw: convert device-local PropertyInfo definitions to use qapi_type")
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/gpio/pca9552.c | 5 +++--
 hw/gpio/pca9554.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 07ef0fb20b..90ccf5170e 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -23,6 +23,7 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "trace.h"
 #include "qom/object.h"
@@ -567,12 +568,12 @@ static void pca955x_initfn(Object *obj)
         if (k->has_led_support) {
             /* LED variant: expose the LED selector state as led%d. */
             name = g_strdup_printf("led%d", ix);
-            object_property_add(obj, name, "str", NULL,
+            object_property_add(obj, name, "str", &str_type_info,
                                 pca955x_get_led, pca955x_set_led, NULL, NULL);
         } else {
             /* GPIO variant: expose the pin logic level as pin%d. */
             name = g_strdup_printf("pin%d", ix);
-            object_property_add(obj, name, "str", NULL,
+            object_property_add(obj, name, "str", &str_type_info,
                                 pca955x_get_pin, pca955x_set_pin, NULL, NULL);
         }
         g_free(name);
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index 0dd063f93a..07bb00babf 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -16,6 +16,7 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "trace.h"
 #include "qom/object.h"
@@ -280,8 +281,8 @@ static void pca9554_initfn(Object *obj)
         char *name;
 
         name = g_strdup_printf("pin%d", pin);
-        object_property_add(obj, name, "str", NULL, pca9554_get_pin,
-                            pca9554_set_pin,
+        object_property_add(obj, name, "str", &str_type_info,
+                            pca9554_get_pin, pca9554_set_pin,
                             NULL, NULL);
         g_free(name);
     }
-- 
2.55.0


