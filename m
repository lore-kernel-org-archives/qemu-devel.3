Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B077C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GOP-0003Sd-MN; Sun, 06 Sep 2026 13:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GON-0003QW-FM
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOL-00005i-G7
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r55YnGa/a9f5bUoQL7xslE3Y9mV2gapw8hfz089wfvU=;
 b=ijxMxQX9ocoPOHBxcl6ysVZNMYD5kisS8Crls0s2Lm4Jt+p7ioqg5phV1XfdSLUPIMEedA
 80OI92bu5CKHb1vl1vZKzWa9qXY9Trwztod+YyNPZToCDpmTYLJ0UV0cJ6H+yzHbeq10PP
 4S/AjMwWyHA8Dp5D9RfcoVq4Bz+IiP0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-h4gDa_sPMdirKqCNoiQqRg-1; Sun,
 06 Sep 2026 13:10:49 -0400
X-MC-Unique: h4gDa_sPMdirKqCNoiQqRg-1
X-Mimecast-MFC-AGG-ID: h4gDa_sPMdirKqCNoiQqRg_1788714648
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F75E1955E76; Sun,  6 Sep 2026 17:10:48 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EAF61955F06; Sun,  6 Sep 2026 17:10:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/40] hw/arm/aspeed_ast2600: Introduce the ACRY SRAM
Date: Sun,  6 Sep 2026 19:09:50 +0200
Message-ID: <20260906171021.26568-10-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
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

Reuse the existing SRAM array convention on AspeedSoCState to add the
64 KiB ACRY SRAM region to the AST2600 at its real-silicon address
(0x1e710000-0x1e71ffff).

Wrap the RAM in a container mapped at offset 0 so the ACRY engine wired
up in a later patch can address the SRAM by relative offset without the
device model knowing its mapping address.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260901081531.898176-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  1 +
 hw/arm/aspeed_ast2600.c     | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index cd68c7f1caa2..46e7854727c6 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -69,6 +69,7 @@ struct AspeedSoCState {
     MemoryRegion *dram_mr;
     MemoryRegion dram_container;
     MemoryRegion sram[ASPEED_SRAM_NUM];
+    MemoryRegion sram_container[ASPEED_SRAM_NUM];
     MemoryRegion spi_boot_container;
     MemoryRegion spi_boot;
     MemoryRegion vbootrom;
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index d1f18e471aa0..f23a51c8a46f 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/aspeed_soc.h"
@@ -24,6 +25,7 @@
 static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_DEV_SPI_BOOT]  = 0x00000000,
     [ASPEED_DEV_SRAM0]     = 0x10000000,
+    [ASPEED_DEV_SRAM1]     = 0x1E710000, /* ACRY SRAM */
     [ASPEED_DEV_DPMCU]     = 0x18000000,
     /* 0x16000000     0x17FFFFFF : AHB BUS do LPC Bus bridge */
     [ASPEED_DEV_IOMEM]     = 0x1E600000,
@@ -361,6 +363,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     qemu_irq irq;
+    g_autofree char *sram1_name = NULL;
     g_autofree char *sram_name = NULL;
     int uart;
 
@@ -444,6 +447,19 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(s->memory,
                                 sc->memmap[ASPEED_DEV_SRAM0], &s->sram[0]);
 
+    /* ACRY SRAM */
+    sram1_name = g_strdup_printf("aspeed.acry.sram.%d",
+                                 CPU(&a->cpu[0])->cpu_index);
+    if (!memory_region_init_ram(&s->sram[1], OBJECT(s), sram1_name,
+                                sc->sram_size[1], errp)) {
+        return;
+    }
+    memory_region_init(&s->sram_container[1], OBJECT(s),
+                       "aspeed.acry.sram-container", sc->sram_size[1]);
+    memory_region_add_subregion(&s->sram_container[1], 0, &s->sram[1]);
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],
+                                &s->sram_container[1]);
+
     /* DPMCU */
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
                                   "aspeed.dpmcu",
@@ -765,6 +781,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, const void *data)
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2600_A3_SILICON_REV;
     sc->sram_size[0] = 0x16400;
+    sc->sram_size[1] = 64 * KiB; /* ACRY SRAM */
     sc->spis_num     = 2;
     sc->ehcis_num    = 2;
     sc->wdts_num     = 4;
-- 
2.55.0


