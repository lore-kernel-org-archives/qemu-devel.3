Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8016E95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaCB-0002ha-Gc; Wed, 04 Feb 2026 05:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaC0-0002J6-QW
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:33:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBv-0004BA-FQ
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5Zt4kq1Rbo65KukWUB+qJa4ama9kUOaYpuUA/RI8I0=;
 b=UUbpEO5/pMtOhN2y70CIqW1tcqe4sh1GWhZrZzNhymNHglI4bMuCvaByZjacISMEAU3uJk
 ogd7Tzz2fjNrovDJC+162kmCNhvely5mRcF5Ue0QIc07qrbamqrkajVVPk4WtFZs0IHaZq
 /AUyS8Tkl6kqA9qLlB/1TSo5B/zjEJM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-L5ApvZNeP7-o-VTFmYGDnw-1; Wed,
 04 Feb 2026 05:32:55 -0500
X-MC-Unique: L5ApvZNeP7-o-VTFmYGDnw-1
X-Mimecast-MFC-AGG-ID: L5ApvZNeP7-o-VTFmYGDnw_1770201174
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9074A19560BA; Wed,  4 Feb 2026 10:32:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D8AFF18003F6; Wed,  4 Feb 2026 10:32:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nabih Estefan <nabihestefan@google.com>
Subject: [PULL 35/45] hw/arm/aspeed: Attach SCU device to AST1700 model
Date: Wed,  4 Feb 2026 11:31:26 +0100
Message-ID: <20260204103136.1795455-36-clg@redhat.com>
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

Connect the SCU device to AST1700 model.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>
Link: https://lore.kernel.org/qemu-devel/20260204082113.3955407-13-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_ast1700.h |  3 +++
 hw/arm/aspeed_ast1700.c         | 17 +++++++++++++++++
 hw/arm/aspeed_ast27x0.c         |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
index 441655cee7f4..65f1497a2ddc 100644
--- a/include/hw/arm/aspeed_ast1700.h
+++ b/include/hw/arm/aspeed_ast1700.h
@@ -9,6 +9,7 @@
 #define ASPEED_AST1700_H
 
 #include "hw/core/sysbus.h"
+#include "hw/misc/aspeed_scu.h"
 #include "hw/adc/aspeed_adc.h"
 #include "hw/misc/aspeed_ltpi.h"
 #include "hw/ssi/aspeed_smc.h"
@@ -24,12 +25,14 @@ struct AspeedAST1700SoCState {
     MemoryRegion iomem;
     MemoryRegion *dram_mr;
     uint8_t board_idx;
+    uint32_t silicon_rev;
 
     AspeedLTPIState ltpi;
     SerialMM uart;
     MemoryRegion sram;
     AspeedSMCState spi;
     AspeedADCState adc;
+    AspeedSCUState scu;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
index 17577ebb5abb..49a242f3dec6 100644
--- a/hw/arm/aspeed_ast1700.c
+++ b/hw/arm/aspeed_ast1700.c
@@ -20,6 +20,7 @@ enum {
     ASPEED_AST1700_DEV_SPI0,
     ASPEED_AST1700_DEV_SRAM,
     ASPEED_AST1700_DEV_ADC,
+    ASPEED_AST1700_DEV_SCU,
     ASPEED_AST1700_DEV_UART12,
     ASPEED_AST1700_DEV_LTPI_CTRL,
     ASPEED_AST1700_DEV_SPI0_MEM,
@@ -29,6 +30,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] = {
     [ASPEED_AST1700_DEV_SPI0]      =  0x00030000,
     [ASPEED_AST1700_DEV_SRAM]      =  0x00BC0000,
     [ASPEED_AST1700_DEV_ADC]       =  0x00C00000,
+    [ASPEED_AST1700_DEV_SCU]       =  0x00C02000,
     [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
     [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
     [ASPEED_AST1700_DEV_SPI0_MEM]  =  0x04000000,
@@ -91,6 +93,16 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_ADC],
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->adc), 0));
 
+    /* SCU */
+    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
+                         s->silicon_rev);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
+        return;
+    }
+    memory_region_add_subregion(&s->iomem,
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SCU],
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->scu), 0));
+
     /* LTPI controller */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
         return;
@@ -116,6 +128,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
     object_initialize_child(obj, "ioexp-adc", &s->adc,
                             "aspeed.adc-ast2700");
 
+    /* SCU */
+    object_initialize_child(obj, "ioexp-scu", &s->scu,
+                            TYPE_ASPEED_2700_SCU);
+
     /* LTPI controller */
     object_initialize_child(obj, "ltpi-ctrl",
                             &s->ltpi, TYPE_ASPEED_LTPI);
@@ -125,6 +141,7 @@ static void aspeed_ast1700_instance_init(Object *obj)
 
 static const Property aspeed_ast1700_props[] = {
     DEFINE_PROP_UINT8("board-idx", AspeedAST1700SoCState, board_idx, 0),
+    DEFINE_PROP_UINT32("silicon-rev", AspeedAST1700SoCState, silicon_rev, 0),
     DEFINE_PROP_LINK("dram", AspeedAST1700SoCState, dram_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 5086d4c51e78..cda841e1031d 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -508,6 +508,8 @@ static void aspeed_soc_ast2700_init(Object *obj)
         /* AST1700 IOEXP */
         object_initialize_child(obj, "ioexp[*]", &s->ioexp[i],
                                 TYPE_ASPEED_AST1700);
+        qdev_prop_set_uint32(DEVICE(&s->ioexp[i]), "silicon-rev",
+                             sc->silicon_rev);
     }
 
     object_initialize_child(obj, "dpmcu", &s->dpmcu,
-- 
2.52.0


