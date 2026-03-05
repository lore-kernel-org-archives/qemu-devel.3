Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79B0F47CA3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCx3-00070z-B9; Thu, 05 Mar 2026 12:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCwz-000700-Vq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:57:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCwx-0003V1-Ov
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JSzgSUMOxOfNGU/S9xqyN1CPD7KoKksKD2uB9sdKPA=;
 b=DYlJ/nCPgHjGKTcDcNWayIejXww12rba1dS4+G4V+7R07Ed2VL55hTREsUAg+ikpZHz2Jd
 CMf5w9zCaelfYvzyyr79pKqSPvqAwVUHsxJ/CsklF66X+vYRUzD+CTU5NYl/9HOGWU7hSL
 jP86vWto3I+j7gfLYTEjzdWsyMIcXTw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-omnzWyzwN8GsXFiej9X_MQ-1; Thu,
 05 Mar 2026 12:57:23 -0500
X-MC-Unique: omnzWyzwN8GsXFiej9X_MQ-1
X-Mimecast-MFC-AGG-ID: omnzWyzwN8GsXFiej9X_MQ_1772733442
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78B2D195608F; Thu,  5 Mar 2026 17:57:22 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5E723003E9E; Thu,  5 Mar 2026 17:57:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Subject: [PULL 03/38] hw/i3c/aspeed_i3c: Switch to DEFINE_TYPES() and align
 parent_obj naming
Date: Thu,  5 Mar 2026 18:56:36 +0100
Message-ID: <20260305175711.1119025-4-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
References: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Following review feedback, update the Aspeed I3C device to use the
DEFINE_TYPES() macro instead of an explicit type registration function.

DEFINE_TYPES() is the currently recommended approach in QEMU for
registering multiple TypeInfo entries and avoids boilerplate
type_init() code.

Additionally, rename embedded SysBusDevice fields from "parent" to
"parent_obj" to comply with the QEMU coding style guidelines for QOM
objects.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260225021158.1586584-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i3c/aspeed_i3c.h | 16 ++++++----------
 hw/i3c/aspeed_i3c.c         | 35 +++++++++++++++--------------------
 2 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h
index 7a984e1f01ab..bd0ffc84eab9 100644
--- a/include/hw/i3c/aspeed_i3c.h
+++ b/include/hw/i3c/aspeed_i3c.h
@@ -21,28 +21,24 @@ OBJECT_DECLARE_TYPE(AspeedI3CState, AspeedI3CClass, ASPEED_I3C)
 #define ASPEED_I3C_NR_DEVICES 6
 
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedI3CDevice, ASPEED_I3C_DEVICE)
-typedef struct AspeedI3CDevice {
-    /* <private> */
-    SysBusDevice parent;
+struct AspeedI3CDevice {
+    SysBusDevice parent_obj;
 
-    /* <public> */
     MemoryRegion mr;
     qemu_irq irq;
 
     uint8_t id;
     uint32_t regs[ASPEED_I3C_DEVICE_NR_REGS];
-} AspeedI3CDevice;
+};
 
-typedef struct AspeedI3CState {
-    /* <private> */
-    SysBusDevice parent;
+struct AspeedI3CState {
+    SysBusDevice parent_obj;
 
-    /* <public> */
     MemoryRegion iomem;
     MemoryRegion iomem_container;
     qemu_irq irq;
 
     uint32_t regs[ASPEED_I3C_NR_REGS];
     AspeedI3CDevice devices[ASPEED_I3C_NR_DEVICES];
-} AspeedI3CState;
+};
 #endif /* ASPEED_I3C_H */
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c
index fff259ff665f..e7cdfbfdbda6 100644
--- a/hw/i3c/aspeed_i3c.c
+++ b/hw/i3c/aspeed_i3c.c
@@ -337,13 +337,6 @@ static void aspeed_i3c_device_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, aspeed_i3c_device_properties);
 }
 
-static const TypeInfo aspeed_i3c_device_info = {
-    .name = TYPE_ASPEED_I3C_DEVICE,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(AspeedI3CDevice),
-    .class_init = aspeed_i3c_device_class_init,
-};
-
 static const VMStateDescription vmstate_aspeed_i3c = {
     .name = TYPE_ASPEED_I3C,
     .version_id = 1,
@@ -366,18 +359,20 @@ static void aspeed_i3c_class_init(ObjectClass *klass, const void *data)
     dc->vmsd = &vmstate_aspeed_i3c;
 }
 
-static const TypeInfo aspeed_i3c_info = {
-    .name = TYPE_ASPEED_I3C,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_init = aspeed_i3c_instance_init,
-    .instance_size = sizeof(AspeedI3CState),
-    .class_init = aspeed_i3c_class_init,
+static const TypeInfo aspeed_i3c_types[] = {
+    {
+        .name = TYPE_ASPEED_I3C,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_init = aspeed_i3c_instance_init,
+        .instance_size = sizeof(AspeedI3CState),
+        .class_init = aspeed_i3c_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_I3C_DEVICE,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(AspeedI3CDevice),
+        .class_init = aspeed_i3c_device_class_init,
+    },
 };
 
-static void aspeed_i3c_register_types(void)
-{
-    type_register_static(&aspeed_i3c_device_info);
-    type_register_static(&aspeed_i3c_info);
-}
-
-type_init(aspeed_i3c_register_types);
+DEFINE_TYPES(aspeed_i3c_types)
-- 
2.53.0


