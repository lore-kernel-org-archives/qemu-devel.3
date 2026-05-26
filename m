Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5C4CD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn0O-0005Gp-Ii; Tue, 26 May 2026 04:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0M-0005GE-TW
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0K-0007a0-S5
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C3LqYBgUxfiRAj8SWlnUdZvpCGVfqmzKBwcNBEn9UIM=;
 b=XR5vVaPvTrsxfuCK8pqh+69EDywX8tq9kVli4JqtqxJY4ljjMs7wURrc4jZEfhr64QFhgi
 8wmGouhiZCaFKBZMXSnsmnrRMFrGYhbxFQwpxBBeXoqKF+dfQo+VjDO28HertS2agfA4cT
 rES7J2DD7u4yqkmCEofJwL0wJsmz/4M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-WI_BIR1hOQyO9SnpAblyuQ-1; Tue,
 26 May 2026 04:19:08 -0400
X-MC-Unique: WI_BIR1hOQyO9SnpAblyuQ-1
X-Mimecast-MFC-AGG-ID: WI_BIR1hOQyO9SnpAblyuQ_1779783547
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AF9F1800611; Tue, 26 May 2026 08:19:07 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB15A180056E; Tue, 26 May 2026 08:19:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/37] hw/arm/aspeed: Convert SRAM size definition to array type
Date: Tue, 26 May 2026 10:18:18 +0200
Message-ID: <20260526081848.651835-8-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Prepare the Aspeed SoC model for future platforms that may contain
multiple SRAM regions with different sizes and MMIO mappings.

The current implementation stores SRAM size information in a single
sram_size field, which limits extensibility when additional SRAM
instances are introduced.

Convert sram_size into an array-based definition and update all
existing users to reference sram_size[0]. This aligns with the
previous SRAM MemoryRegion array conversion and provides a scalable
foundation for supporting multiple SRAM regions in future SoCs.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260525053036.3305181-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h | 2 +-
 hw/arm/aspeed_ast10x0.c     | 8 ++++----
 hw/arm/aspeed_ast2400.c     | 6 +++---
 hw/arm/aspeed_ast2600.c     | 4 ++--
 hw/arm/aspeed_ast27x0.c     | 8 ++++----
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index e6942b2936ae..3a7db959a9ae 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -172,7 +172,7 @@ struct AspeedSoCClass {
     /** valid_cpu_types: NULL terminated array of a single CPU type. */
     const char * const *valid_cpu_types;
     uint32_t silicon_rev;
-    uint64_t sram_size;
+    uint64_t sram_size[ASPEED_SRAM_NUM];
     uint64_t secsram_size;
     int pcie_num;
     int spis_num;
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 3e478f752058..9e597a75ec53 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -240,8 +240,8 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
     /* Internal SRAM */
     sram_name = g_strdup_printf("aspeed.sram.%d",
                                 CPU(a->armv7m.cpu)->cpu_index);
-    memory_region_init_ram(&s->sram[0], OBJECT(s), sram_name, sc->sram_size,
-                           &err);
+    memory_region_init_ram(&s->sram[0], OBJECT(s), sram_name,
+                           sc->sram_size[0], &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return false;
@@ -493,7 +493,7 @@ static void aspeed_soc_ast1030_class_init(ObjectClass *klass, const void *data)
 
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev = AST1030_A1_SILICON_REV;
-    sc->sram_size = 0xc0000;
+    sc->sram_size[0] = 0xc0000;
     sc->secsram_size = 0x40000; /* 256 * KiB */
     sc->spis_num = 2;
     sc->ehcis_num = 0;
@@ -521,7 +521,7 @@ static void aspeed_soc_ast1060_class_init(ObjectClass *klass, const void *data)
 
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev = AST1060_A2_SILICON_REV;
-    sc->sram_size = 0xc0000;
+    sc->sram_size[0] = 0xc0000;
     sc->secsram_size = 0x40000; /* 256 * KiB */
     sc->spis_num = 2;
     sc->wdts_num = 4;
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index d79aa832f3fa..c4e5388999e6 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -282,7 +282,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     /* SRAM */
     sram_name = g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_index);
     if (!memory_region_init_ram(&s->sram[0], OBJECT(s), sram_name,
-                                sc->sram_size, errp)) {
+                                sc->sram_size[0], errp)) {
         return;
     }
     memory_region_add_subregion(s->memory,
@@ -533,7 +533,7 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *oc, const void *data)
 
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2400_A1_SILICON_REV;
-    sc->sram_size    = 0x8000;
+    sc->sram_size[0] = 0x8000;
     sc->spis_num     = 1;
     sc->ehcis_num    = 1;
     sc->wdts_num     = 2;
@@ -560,7 +560,7 @@ static void aspeed_soc_ast2500_class_init(ObjectClass *oc, const void *data)
 
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2500_A1_SILICON_REV;
-    sc->sram_size    = 0x9000;
+    sc->sram_size[0] = 0x9000;
     sc->spis_num     = 2;
     sc->ehcis_num    = 2;
     sc->wdts_num     = 3;
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index a69103de89ea..2f8f49a37689 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -438,7 +438,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     /* SRAM */
     sram_name = g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_index);
     if (!memory_region_init_ram(&s->sram[0], OBJECT(s), sram_name,
-                                sc->sram_size, errp)) {
+                                sc->sram_size[0], errp)) {
         return;
     }
     memory_region_add_subregion(s->memory,
@@ -764,7 +764,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, const void *data)
 
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2600_A3_SILICON_REV;
-    sc->sram_size    = 0x16400;
+    sc->sram_size[0] = 0x16400;
     sc->spis_num     = 2;
     sc->ehcis_num    = 2;
     sc->wdts_num     = 4;
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 0fb5e4b24c9d..30883ea7ce40 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -778,8 +778,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
 
     /* SRAM */
     name = g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_index);
-    if (!memory_region_init_ram(&s->sram[0], OBJECT(s), name, sc->sram_size,
-                                errp)) {
+    if (!memory_region_init_ram(&s->sram[0], OBJECT(s), name,
+                                sc->sram_size[0], errp)) {
         return;
     }
     memory_region_add_subregion(s->memory,
@@ -1151,7 +1151,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
 
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2700_A1_SILICON_REV;
-    sc->sram_size    = 0x20000;
+    sc->sram_size[0] = 0x20000;
     sc->pcie_num     = 3;
     sc->spis_num     = 3;
     sc->sgpio_num    = 2;
@@ -1181,7 +1181,7 @@ static void aspeed_soc_ast2700a2_class_init(ObjectClass *oc, const void *data)
 
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2700_A2_SILICON_REV;
-    sc->sram_size    = 0x20000;
+    sc->sram_size[0] = 0x20000;
     sc->pcie_num     = 3;
     sc->spis_num     = 3;
     sc->sgpio_num    = 2;
-- 
2.54.0


