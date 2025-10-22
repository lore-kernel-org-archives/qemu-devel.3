Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097C4CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXyw-0001AC-5v; Wed, 22 Oct 2025 08:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXyl-00016d-H0
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXyi-0008LD-Ae
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761136207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A8fvnFldiTzr+/y70KNLcplQCpYUtA7dZ4ZVBCMkK9A=;
 b=JZmVzTQanu08AF4S5XrKrnUHTZvyEA48vFHjOWsa05fwDQ36Vn1gWGcWYRubDISIv6HdR3
 xMhaQzwc+sHjIsIKzHrpfHafPso0d6EqvkimCBXqaO6CIw94ZrPQkdbekOME6UNGSlQoYU
 433BNZaqTNG4iwh47eXmQWTg2LHirJs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-qeDJxTTQOBCEx3B62oGolQ-1; Wed,
 22 Oct 2025 08:30:05 -0400
X-MC-Unique: qeDJxTTQOBCEx3B62oGolQ-1
X-Mimecast-MFC-AGG-ID: qeDJxTTQOBCEx3B62oGolQ_1761136204
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFB161954B00; Wed, 22 Oct 2025 12:30:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D38651800586; Wed, 22 Oct 2025 12:30:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/16] hw/arm/aspeed_ast27x0-ssp: Add SDRAM region and fix
 naming and size to 512MB
Date: Wed, 22 Oct 2025 14:29:38 +0200
Message-ID: <20251022122953.877335-2-clg@redhat.com>
In-Reply-To: <20251022122953.877335-1-clg@redhat.com>
References: <20251022122953.877335-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

Previously, the SSP memory was incorrectly modeled as "SRAM" with
a 32 MB size. This change introduces a new sdram field in
AspeedCoprocessorState and updates the realization logic accordingly.
Rename from SRAM to SDRAM and correct size from 32MB to 512MB to match
hardware.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251015062210.3128710-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_coprocessor.h |  1 +
 hw/arm/aspeed_ast27x0-ssp.c         | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index d77655d65911..0c7168a89c15 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -16,6 +16,7 @@ struct AspeedCoprocessorState {
     DeviceState parent;
 
     MemoryRegion *memory;
+    MemoryRegion sdram;
     MemoryRegion sram;
     Clock *sysclk;
 
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 936c7c72e8f7..9f3a1933a066 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -16,10 +16,10 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/arm/aspeed_coprocessor.h"
 
-#define AST2700_SSP_RAM_SIZE (32 * MiB)
+#define AST2700_SSP_SDRAM_SIZE (512 * MiB)
 
 static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
-    [ASPEED_DEV_SRAM]      =  0x00000000,
+    [ASPEED_DEV_SDRAM]     =  0x00000000,
     [ASPEED_DEV_INTC]      =  0x72100000,
     [ASPEED_DEV_SCU]       =  0x72C02000,
     [ASPEED_DEV_SCUIO]     =  0x74C02000,
@@ -165,7 +165,7 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev_soc);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
-    g_autofree char *sram_name = NULL;
+    g_autofree char *sdram_name = NULL;
     int uart;
     int i;
 
@@ -184,16 +184,16 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
                              OBJECT(s->memory), &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);
 
-    sram_name = g_strdup_printf("aspeed.dram.%d",
-                                CPU(a->armv7m.cpu)->cpu_index);
-
-    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name,
-                                AST2700_SSP_RAM_SIZE, errp)) {
+    /* SDRAM */
+    sdram_name = g_strdup_printf("aspeed.sdram.%d",
+                                 CPU(a->armv7m.cpu)->cpu_index);
+    if (!memory_region_init_ram(&s->sdram, OBJECT(s), sdram_name,
+                                AST2700_SSP_SDRAM_SIZE, errp)) {
         return;
     }
     memory_region_add_subregion(s->memory,
-                                sc->memmap[ASPEED_DEV_SRAM],
-                                &s->sram);
+                                sc->memmap[ASPEED_DEV_SDRAM],
+                                &s->sdram);
 
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
-- 
2.51.0


