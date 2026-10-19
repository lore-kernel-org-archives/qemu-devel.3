Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46455CCF2E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoEM-0002wE-3V; Mon, 19 Oct 2026 10:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDK-0002EK-TO
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDI-0005Zn-1w
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJyyv8rvzax8wOyTCTRG8y6MXAQ6T4s3zGnen5jyrhs=;
 b=FdDoAZgpmHrpOI5b56dgC5BvsbUT3drqeFepAOD3d/HCzHtjLuBdTV5sMd2H1zKl4AMDeo
 8UxWkcz8kclLm0Akc0TMy4PiCelCh3hxrdob8pxlgeUS4xtmJ4hNmAoRMkWANZV797iRiR
 0UEkhDhcJzegRo8thC55HRh7+UPpV4Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-q6DsYMFrOyyrrGB7nFXdxA-1; Mon,
 19 Oct 2026 14:19:39 +0000
X-MC-Unique: q6DsYMFrOyyrrGB7nFXdxA-1
X-Mimecast-MFC-AGG-ID: q6DsYMFrOyyrrGB7nFXdxA_1792419578
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C8E61954206; Mon, 19 Oct 2026 14:19:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB4CB1955F23; Mon, 19 Oct 2026 14:19:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F109A21E68A1; Mon, 19 Oct 2026 16:19:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 29/65] whpx: convert OnOffAuto hyperv property to
 QAPI-aware registration
Date: Mon, 19 Oct 2026 16:18:53 +0200
Message-ID: <20261019141929.1594337-30-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Convert the hyperv OnOffAuto property from manual visitor-based
callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 accel/whpx/whpx-common.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 247e12db81..187938c02b 100644
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
2.55.0


