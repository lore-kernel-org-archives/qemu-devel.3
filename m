Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C900DE95377
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaCh-0003g4-Fr; Wed, 04 Feb 2026 05:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaC3-0002TY-6B
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:33:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaC1-0004CQ-Jh
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s6+IOP/ZYsZUujXSs6pRXKxziTQlt+0qFcMqUzWJnyI=;
 b=EXzMEDVoo8TIziF09LeTMtRaC0jKbX5WorXat092w8QySLSt1sWB95+grvo5e3tzQVXlUc
 hO1QOfU+mkylIfPLvbxphMYHn3W3qL7pBaOgh86l7LXdoW9ewO/XKJXeKWhg/rAND/BaDU
 HoVy2rK8yZBNxo65wM5ioxpeyeMp0yw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-lUK8ctKPMw23blPtiWhnAA-1; Wed,
 04 Feb 2026 05:33:02 -0500
X-MC-Unique: lUK8ctKPMw23blPtiWhnAA-1
X-Mimecast-MFC-AGG-ID: lUK8ctKPMw23blPtiWhnAA_1770201181
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0DAE1800259; Wed,  4 Feb 2026 10:33:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A6A918004AD; Wed,  4 Feb 2026 10:32:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nabih Estefan <nabihestefan@google.com>
Subject: [PULL 38/45] hw/arm/aspeed: Attach WDT device to AST1700 model
Date: Wed,  4 Feb 2026 11:31:29 +0100
Message-ID: <20260204103136.1795455-39-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

Connect the WDT device to AST1700 model.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>
Link: https://lore.kernel.org/qemu-devel/20260204082113.3955407-16-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_ast1700.h |  4 ++++
 hw/arm/aspeed_ast1700.c         | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
index 1005ce63645f..ee0c47d173e0 100644
--- a/include/hw/arm/aspeed_ast1700.h
+++ b/include/hw/arm/aspeed_ast1700.h
@@ -15,8 +15,11 @@
 #include "hw/i2c/aspeed_i2c.h"
 #include "hw/misc/aspeed_ltpi.h"
 #include "hw/ssi/aspeed_smc.h"
+#include "hw/watchdog/wdt_aspeed.h"
 #include "hw/char/serial-mm.h"
 
+#define AST1700_WDT_NUM              9
+
 #define TYPE_ASPEED_AST1700 "aspeed.ast1700"
 
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedAST1700SoCState, ASPEED_AST1700)
@@ -37,6 +40,7 @@ struct AspeedAST1700SoCState {
     AspeedSCUState scu;
     AspeedGPIOState gpio;
     AspeedI2CState i2c;
+    AspeedWDTState wdt[AST1700_WDT_NUM];
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
index e264b2200bc3..59954eca99aa 100644
--- a/hw/arm/aspeed_ast1700.c
+++ b/hw/arm/aspeed_ast1700.c
@@ -25,6 +25,7 @@ enum {
     ASPEED_AST1700_DEV_I2C,
     ASPEED_AST1700_DEV_UART12,
     ASPEED_AST1700_DEV_LTPI_CTRL,
+    ASPEED_AST1700_DEV_WDT,
     ASPEED_AST1700_DEV_SPI0_MEM,
 };
 
@@ -37,6 +38,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] = {
     [ASPEED_AST1700_DEV_I2C]       =  0x00C0F000,
     [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
     [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
+    [ASPEED_AST1700_DEV_WDT]       =  0x00C37000,
     [ASPEED_AST1700_DEV_SPI0_MEM]  =  0x04000000,
 };
 
@@ -135,6 +137,22 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->iomem,
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_LTPI_CTRL],
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ltpi), 0));
+    /* WDT */
+    for (int i = 0; i < AST1700_WDT_NUM; i++) {
+        AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
+        hwaddr wdt_offset = aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_WDT] +
+                            i * awc->iosize;
+
+        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu),
+                                 errp);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
+            return;
+        }
+        memory_region_add_subregion(&s->iomem,
+                        wdt_offset,
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->wdt[i]), 0));
+    }
+
 }
 
 static void aspeed_ast1700_instance_init(Object *obj)
@@ -169,6 +187,12 @@ static void aspeed_ast1700_instance_init(Object *obj)
     object_initialize_child(obj, "ltpi-ctrl",
                             &s->ltpi, TYPE_ASPEED_LTPI);
 
+    /* WDT */
+    for (int i = 0; i < AST1700_WDT_NUM; i++) {
+        object_initialize_child(obj, "ioexp-wdt[*]",
+                                &s->wdt[i], "aspeed.wdt-ast2700");
+    }
+
     return;
 }
 
-- 
2.52.0


