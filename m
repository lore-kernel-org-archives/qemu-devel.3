Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A8ECD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn0R-0005Hp-QO; Tue, 26 May 2026 04:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0O-0005Gz-SN
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0N-0007aW-7P
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U/3pptQ2qnZ2YhvRFjOnsHg+qVvQb2qB6bEVoqGtxAY=;
 b=PNalxMQYvLxVR5i0bRdV/V97V7s7VPwqOsQyEATh2ryFfzBjnHhDBe6/Wb/2WulLkHV8Mg
 +sylEkUyWW1lmBv82NmKesLR9KTsLc0Jgj1+GBiEsC+OXmKnp3pGPmMs31yDerI/H1VZN/
 b0nHbzTrZQ8JSSsmJqfsEeIZRQPBt/I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-ADHpbhqCMd6w0jzkZw92cg-1; Tue,
 26 May 2026 04:19:12 -0400
X-MC-Unique: ADHpbhqCMd6w0jzkZw92cg-1
X-Mimecast-MFC-AGG-ID: ADHpbhqCMd6w0jzkZw92cg_1779783551
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53FCC195609E; Tue, 26 May 2026 08:19:11 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D0AD01800357; Tue, 26 May 2026 08:19:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/37] hw/arm/aspeed: Consolidate secure SRAM into SRAM array
Date: Tue, 26 May 2026 10:18:20 +0200
Message-ID: <20260526081848.651835-10-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Some Aspeed SoCs contain multiple SRAM regions with different
sizes and MMIO mappings, such as internal SRAM and secure SRAM.

The current implementation models secure SRAM separately from the
generic SRAM representation, which complicates future multi-SRAM
support and expansion.

Increase ASPEED_SRAM_NUM to 2 and migrate secure SRAM to use the
common SRAM array representation. Rename the secure SRAM memmap
entry to ASPEED_DEV_SRAM1 and update AST10x0 to initialize both
SRAM regions through sram[] and sram_size[].

This unifies SRAM-like regions under a common representation and
prepares for future SoCs with additional SRAM regions.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260525053036.3305181-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  6 ++----
 hw/arm/aspeed_ast10x0.c     | 16 +++++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index dda602e9f20c..3aac144cd408 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -60,7 +60,7 @@
 #define ASPEED_PCIE_NUM  3
 #define ASPEED_INTC_NUM  2
 #define ASPEED_IOEXP_NUM 2
-#define ASPEED_SRAM_NUM 1
+#define ASPEED_SRAM_NUM 2
 
 struct AspeedSoCState {
     DeviceState parent;
@@ -89,7 +89,6 @@ struct AspeedSoCState {
     AspeedSBCState sbc;
     AspeedSLIState sli;
     AspeedSLIState sliio;
-    MemoryRegion secsram;
     UnimplementedDeviceState sbc_unimplemented;
     AspeedSDMCState sdmc;
     AspeedPWMState pwm;
@@ -173,7 +172,6 @@ struct AspeedSoCClass {
     const char * const *valid_cpu_types;
     uint32_t silicon_rev;
     uint64_t sram_size[ASPEED_SRAM_NUM];
-    uint64_t secsram_size;
     int pcie_num;
     int spis_num;
     int sgpio_num;
@@ -225,10 +223,10 @@ enum {
     ASPEED_DEV_SCU,
     ASPEED_DEV_ADC,
     ASPEED_DEV_SBC,
-    ASPEED_DEV_SECSRAM,
     ASPEED_DEV_EMMC_BC,
     ASPEED_DEV_VIDEO,
     ASPEED_DEV_SRAM0,
+    ASPEED_DEV_SRAM1,
     ASPEED_DEV_SDHCI,
     ASPEED_DEV_GPIO,
     ASPEED_DEV_GPIO_1_8V,
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index b55f788342a6..93c81195b56a 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -21,7 +21,7 @@
 
 static const hwaddr aspeed_soc_ast1030_memmap[] = {
     [ASPEED_DEV_SRAM0]     = 0x00000000,
-    [ASPEED_DEV_SECSRAM]   = 0x79000000,
+    [ASPEED_DEV_SRAM1]     = 0x79000000, /* SEC SRAM */
     [ASPEED_DEV_IOMEM]     = 0x7E600000,
     [ASPEED_DEV_PWM]       = 0x7E610000,
     [ASPEED_DEV_FMC]       = 0x7E620000,
@@ -249,14 +249,16 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
     memory_region_add_subregion(s->memory,
                                 sc->memmap[ASPEED_DEV_SRAM0],
                                 &s->sram[0]);
-    memory_region_init_ram(&s->secsram, OBJECT(s), "sec.sram",
-                           sc->secsram_size, &err);
+
+    /* Internal SEC SRAM */
+    memory_region_init_ram(&s->sram[1], OBJECT(s), "sec.sram",
+                           sc->sram_size[1], &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return false;
     }
-    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SECSRAM],
-                                &s->secsram);
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],
+                                &s->sram[1]);
 
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
@@ -494,7 +496,7 @@ static void aspeed_soc_ast1030_class_init(ObjectClass *klass, const void *data)
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev = AST1030_A1_SILICON_REV;
     sc->sram_size[0] = 0xc0000;
-    sc->secsram_size = 0x40000; /* 256 * KiB */
+    sc->sram_size[1] = 0x40000; /* SEC SRAM 256 * KiB */
     sc->spis_num = 2;
     sc->ehcis_num = 0;
     sc->wdts_num = 4;
@@ -522,7 +524,7 @@ static void aspeed_soc_ast1060_class_init(ObjectClass *klass, const void *data)
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev = AST1060_A2_SILICON_REV;
     sc->sram_size[0] = 0xc0000;
-    sc->secsram_size = 0x40000; /* 256 * KiB */
+    sc->sram_size[1] = 0x40000; /* SEC SRAM 256 * KiB */
     sc->spis_num = 2;
     sc->wdts_num = 4;
     sc->uarts_num = 1;
-- 
2.54.0


