Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1005E95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBu-00025Q-Ar; Wed, 04 Feb 2026 05:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBm-0001oT-NL
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBk-00048N-MW
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6yRu03I1DUYDKWOh3MdB/nob0tCghHS4PP2N7JelkQ=;
 b=IE9FhciGyKQQzsnlx3gZ2R28yJ26dLawkVlIUatjD5KVEwYyyDR/OhuEF3S620Yns8wF4G
 Xtty8e0x052mqhJjjYsPWnvNyFCQ6uritZJKYwn4Lr8dtUysrB5WC8lzaHkixBbymoHOnu
 2A+PyPXvDtzakLNwE07hPUrU+hAyvqA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-i0WMt3LjNi-1FMaDlcDYcw-1; Wed,
 04 Feb 2026 05:32:44 -0500
X-MC-Unique: i0WMt3LjNi-1FMaDlcDYcw-1
X-Mimecast-MFC-AGG-ID: i0WMt3LjNi-1FMaDlcDYcw_1770201163
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C11751800465; Wed,  4 Feb 2026 10:32:43 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13935180066A; Wed,  4 Feb 2026 10:32:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nabih Estefan <nabihestefan@google.com>
Subject: [PULL 30/45] hw/arm/aspeed: Attach LTPI controller to AST1700 model
Date: Wed,  4 Feb 2026 11:31:21 +0100
Message-ID: <20260204103136.1795455-31-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Kane Chen <kane_chen@aspeedtech.com>

Connect the LTPI controller to the AST1700 model by mapping its MMIO
region.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>
Link: https://lore.kernel.org/qemu-devel/20260204082113.3955407-8-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_ast1700.h |  3 +++
 hw/arm/aspeed_ast1700.c         | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
index 378dcb437a78..addea3ab1ff9 100644
--- a/include/hw/arm/aspeed_ast1700.h
+++ b/include/hw/arm/aspeed_ast1700.h
@@ -9,6 +9,7 @@
 #define ASPEED_AST1700_H
 
 #include "hw/core/sysbus.h"
+#include "hw/misc/aspeed_ltpi.h"
 
 #define TYPE_ASPEED_AST1700 "aspeed.ast1700"
 
@@ -18,6 +19,8 @@ struct AspeedAST1700SoCState {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
+
+    AspeedLTPIState ltpi;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
index dd38b819b864..e4c8565d3f11 100644
--- a/hw/arm/aspeed_ast1700.c
+++ b/hw/arm/aspeed_ast1700.c
@@ -13,6 +13,14 @@
 
 #define AST2700_SOC_LTPI_SIZE        0x01000000
 
+enum {
+    ASPEED_AST1700_DEV_LTPI_CTRL,
+};
+
+static const hwaddr aspeed_ast1700_io_memmap[] = {
+    [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
+};
+
 static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
 {
     AspeedAST1700SoCState *s = ASPEED_AST1700(dev);
@@ -22,6 +30,25 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
     memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,
                        AST2700_SOC_LTPI_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
+
+    /* LTPI controller */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
+        return;
+    }
+    memory_region_add_subregion(&s->iomem,
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_LTPI_CTRL],
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ltpi), 0));
+}
+
+static void aspeed_ast1700_instance_init(Object *obj)
+{
+    AspeedAST1700SoCState *s = ASPEED_AST1700(obj);
+
+    /* LTPI controller */
+    object_initialize_child(obj, "ltpi-ctrl",
+                            &s->ltpi, TYPE_ASPEED_LTPI);
+
+    return;
 }
 
 static void aspeed_ast1700_class_init(ObjectClass *klass, const void *data)
@@ -36,6 +63,7 @@ static const TypeInfo aspeed_ast1700_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(AspeedAST1700SoCState),
     .class_init    = aspeed_ast1700_class_init,
+    .instance_init = aspeed_ast1700_instance_init,
 };
 
 static void aspeed_ast1700_register_types(void)
-- 
2.52.0


