Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54804C79F9F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GOQ-0003T2-Td; Sun, 06 Sep 2026 13:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOP-0003S1-1K
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GON-00006F-2M
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=akS/REZ670piyc1Cli6DUwEG2SlM1g04NPO+7yVMVmI=;
 b=H87iUfSdtA3vOleMgboHDmX5ZwLaHtATHDcBMMTlXi4HSZoGXJczdNeSTUeAlgVDXxsalw
 NsKZyVW+x8guhhD2J9M9g3fyYvZFqI2m5O3Gpho3425QNZKWuTyQmUx7erd0VxSKT+9X+l
 fhZzwMTbZ+x895qic9laGOXLEINLqiA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-b0zrmotmP0C5UGRuula1FQ-1; Sun,
 06 Sep 2026 13:10:51 -0400
X-MC-Unique: b0zrmotmP0C5UGRuula1FQ-1
X-Mimecast-MFC-AGG-ID: b0zrmotmP0C5UGRuula1FQ_1788714650
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 878421954235; Sun,  6 Sep 2026 17:10:50 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D48D1955F0E; Sun,  6 Sep 2026 17:10:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/40] hw/arm/aspeed_ast2600: Wire up the ACRY model
Date: Sun,  6 Sep 2026 19:09:51 +0200
Message-ID: <20260906171021.26568-11-clg@redhat.com>
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

Introduce the ASPEED_DEV_ACRY enum slot and add the ACRY model state
to AspeedSoCState.

Instantiate the new ACRY model on the AST2600 SoC using its
real-silicon register address and IRQ:

- ACRY register region 0x1e6fa000-0x1e6fafff
- IRQ 160

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260901081531.898176-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  3 +++
 hw/arm/aspeed_ast2600.c     | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 46e7854727c6..8d80f1670587 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -25,6 +25,7 @@
 #include "hw/i2c/aspeed_i2c.h"
 #include "hw/i3c/aspeed_i3c.h"
 #include "hw/ssi/aspeed_smc.h"
+#include "hw/misc/aspeed_acry.h"
 #include "hw/misc/aspeed_hace.h"
 #include "hw/misc/aspeed_sbc.h"
 #include "hw/misc/aspeed_sli.h"
@@ -82,6 +83,7 @@ struct AspeedSoCState {
     AspeedSCUState scu;
     AspeedSCUState scuio;
     AspeedHACEState hace;
+    AspeedACRYState acry;
     AspeedXDMAState xdma;
     AspeedADCState adc;
     AspeedSMCState fmc;
@@ -271,6 +273,7 @@ enum {
     ASPEED_DEV_EMMC,
     ASPEED_DEV_KCS,
     ASPEED_DEV_HACE,
+    ASPEED_DEV_ACRY,
     ASPEED_DEV_DPMCU,
     ASPEED_DEV_DP,
     ASPEED_DEV_I3C,
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index f23a51c8a46f..f7c7ec7fb1d4 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -52,6 +52,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_DEV_DP]        = 0x1E6EB000,
     [ASPEED_DEV_PCIE_PHY1] = 0x1E6ED200,
     [ASPEED_DEV_SBC]       = 0x1E6F2000,
+    [ASPEED_DEV_ACRY]      = 0x1E6FA000,
     [ASPEED_DEV_EMMC_BC]   = 0x1E6f5000,
     [ASPEED_DEV_VIDEO]     = 0x1E700000,
     [ASPEED_DEV_SDHCI]     = 0x1E740000,
@@ -144,6 +145,7 @@ static const int aspeed_soc_ast2600_irqmap[] = {
     [ASPEED_DEV_FSI1]      = 100,
     [ASPEED_DEV_FSI2]      = 101,
     [ASPEED_DEV_I3C]       = 102,   /* 102 -> 107 */
+    [ASPEED_DEV_ACRY]      = 160,
 };
 
 static qemu_irq aspeed_soc_ast2600_get_irq(AspeedSoCState *s, int dev)
@@ -269,6 +271,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
     snprintf(typename, sizeof(typename), "aspeed.hace-%s", socname);
     object_initialize_child(obj, "hace", &s->hace, typename);
 
+    object_initialize_child(obj, "acry", &s->acry, TYPE_ASPEED_ACRY);
+
     object_initialize_child(obj, "i3c", &s->i3c, TYPE_ASPEED_I3C);
 
     object_initialize_child(obj, "sbc", &s->sbc, TYPE_ASPEED_AST2600_SBC);
@@ -726,6 +730,19 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
                        aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_HACE));
 
+    /* ACRY */
+    object_property_set_link(OBJECT(&s->acry), "dram", OBJECT(s->dram_mr),
+                             &error_abort);
+    object_property_set_link(OBJECT(&s->acry), "sram", OBJECT(&s->sram[1]),
+                             &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->acry), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->acry), 0,
+                    sc->memmap[ASPEED_DEV_ACRY]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->acry), 0,
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_ACRY));
+
     /* I3C */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp)) {
         return;
-- 
2.55.0


