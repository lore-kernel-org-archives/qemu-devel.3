Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511E2CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Hvw-0005D4-QJ; Mon, 13 Oct 2025 08:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvM-0004fg-Ho
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvG-00082U-Ec
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p9h37oTgNmYC61PStwVjOgSvI6sNjftmWJs14KANrYw=;
 b=DolfS/hkV4MDd0H9i2TM3zlzPKxQlRyvfx3d3EWwQoiG3LE38dUAlLf0imc0004Recf2rS
 zlZnSLUwUJhBVHH2G/4yEWk4KGA59wghYW7NAQkAEu0P+o1nytTrNRw98JjWPSrvCha1xu
 +rscOIn58eREiseL5cXlC6SSMpcUUzk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-N0caCOjZMk2xsald2OvbEQ-1; Mon,
 13 Oct 2025 08:44:58 -0400
X-MC-Unique: N0caCOjZMk2xsald2OvbEQ-1
X-Mimecast-MFC-AGG-ID: N0caCOjZMk2xsald2OvbEQ_1760359497
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAE4C1956096; Mon, 13 Oct 2025 12:44:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 575DB1800446; Mon, 13 Oct 2025 12:44:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/29] hw/arm/aspeed: Remove AspeedSoCState dependency from
 aspeed_soc_uart_set_chr() API
Date: Mon, 13 Oct 2025 14:44:07 +0200
Message-ID: <20251013124421.71977-17-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Refactor the aspeed_soc_uart_set_chr() helper to remove its dependency
on AspeedSoCState and make the UART character device binding more
generic.

The function now takes SerialMM *uart, uarts_base, and uarts_num
as arguments instead of relying on AspeedSoCState. All affected call
sites in aspeed.c, aspeed_ast27x0-fc.c, and fby35.c are updated
to use the new parameter format.

This improves API flexibility and enables reuse across different Aspeed
SoC variants without requiring access to internal SoC state.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251013054334.955331-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  3 ++-
 hw/arm/aspeed.c             |  6 ++++--
 hw/arm/aspeed_ast27x0-fc.c  | 13 ++++++++++---
 hw/arm/aspeed_soc_common.c  | 10 +++++-----
 hw/arm/fby35.c              | 10 ++++++++--
 5 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 0162738f884e..c870bf55865e 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -306,7 +306,8 @@ enum {
 
 qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev);
 bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp);
-void aspeed_soc_uart_set_chr(AspeedSoCState *s, int dev, Chardev *chr);
+void aspeed_soc_uart_set_chr(SerialMM *uart, int dev, int uarts_base,
+                             int uarts_num, Chardev *chr);
 bool aspeed_soc_dram_init(AspeedSoCState *s, Error **errp);
 void aspeed_mmio_map(AspeedSoCState *s, SysBusDevice *dev, int n, hwaddr addr);
 void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index ad17471c8d61..21ee62f75044 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -299,12 +299,14 @@ static void connect_serial_hds_to_uarts(AspeedMachineState *bmc)
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     int uart_chosen = bmc->uart_chosen ? bmc->uart_chosen : amc->uart_default;
 
-    aspeed_soc_uart_set_chr(s, uart_chosen, serial_hd(0));
+    aspeed_soc_uart_set_chr(s->uart, uart_chosen, sc->uarts_base,
+                            sc->uarts_num, serial_hd(0));
     for (int i = 1, uart = sc->uarts_base; i < sc->uarts_num; uart++) {
         if (uart == uart_chosen) {
             continue;
         }
-        aspeed_soc_uart_set_chr(s, uart, serial_hd(i++));
+        aspeed_soc_uart_set_chr(s->uart, uart, sc->uarts_base, sc->uarts_num,
+                                serial_hd(i++));
     }
 }
 
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 2e16a0340a7b..e598f57ca228 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -91,7 +91,8 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
                             AST2700FC_HW_STRAP1, &error_abort);
     object_property_set_int(OBJECT(&s->ca35), "hw-strap2",
                             AST2700FC_HW_STRAP2, &error_abort);
-    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART12, serial_hd(0));
+    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART12, sc->uarts_base,
+                            sc->uarts_num, serial_hd(0));
     if (!qdev_realize(DEVICE(&s->ca35), NULL, errp)) {
         return false;
     }
@@ -115,6 +116,7 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
 static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
 {
     AspeedSoCState *soc;
+    AspeedSoCClass *sc;
     Ast2700FCState *s = AST2700A1FC(machine);
     s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
     clock_set_hz(s->ssp_sysclk, 200000000ULL);
@@ -128,7 +130,9 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
                              OBJECT(&s->ssp_memory), &error_abort);
 
     soc = ASPEED_SOC(&s->ssp);
-    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(1));
+    sc = ASPEED_SOC_GET_CLASS(soc);
+    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART4, sc->uarts_base,
+                            sc->uarts_num, serial_hd(1));
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {
         return false;
     }
@@ -139,6 +143,7 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
 static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
 {
     AspeedSoCState *soc;
+    AspeedSoCClass *sc;
     Ast2700FCState *s = AST2700A1FC(machine);
     s->tsp_sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
     clock_set_hz(s->tsp_sysclk, 200000000ULL);
@@ -152,7 +157,9 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
                              OBJECT(&s->tsp_memory), &error_abort);
 
     soc = ASPEED_SOC(&s->tsp);
-    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART7, serial_hd(2));
+    sc = ASPEED_SOC_GET_CLASS(soc);
+    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART7, sc->uarts_base,
+                            sc->uarts_num, serial_hd(2));
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
         return false;
     }
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index a4e74acdce77..ddcbba0020ee 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -59,15 +59,15 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
     return true;
 }
 
-void aspeed_soc_uart_set_chr(AspeedSoCState *s, int dev, Chardev *chr)
+void aspeed_soc_uart_set_chr(SerialMM *uart, int dev, int uarts_base,
+                             int uarts_num, Chardev *chr)
 {
-    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    int uart_first = aspeed_uart_first(sc->uarts_base);
+    int uart_first = aspeed_uart_first(uarts_base);
     int uart_index = aspeed_uart_index(dev);
     int i = uart_index - uart_first;
 
-    g_assert(0 <= i && i < ARRAY_SIZE(s->uart) && i < sc->uarts_num);
-    qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr);
+    g_assert(0 <= i && i < ASPEED_UARTS_NUM && i < uarts_num);
+    qdev_prop_set_chr(DEVICE(&uart[i]), "chardev", chr);
 }
 
 /*
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index c14fc2efe9bb..5a94c847d365 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -71,9 +71,11 @@ static void fby35_bmc_write_boot_rom(DriveInfo *dinfo, MemoryRegion *mr,
 static void fby35_bmc_init(Fby35State *s)
 {
     AspeedSoCState *soc;
+    AspeedSoCClass *sc;
 
     object_initialize_child(OBJECT(s), "bmc", &s->bmc, "ast2600-a3");
     soc = ASPEED_SOC(&s->bmc);
+    sc = ASPEED_SOC_GET_CLASS(soc);
 
     memory_region_init(&s->bmc_memory, OBJECT(&s->bmc), "bmc-memory",
                        UINT64_MAX);
@@ -91,7 +93,8 @@ static void fby35_bmc_init(Fby35State *s)
                             &error_abort);
     object_property_set_int(OBJECT(&s->bmc), "hw-strap2", 0x00000003,
                             &error_abort);
-    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART5, serial_hd(0));
+    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART5, sc->uarts_base,
+                            sc->uarts_num, serial_hd(0));
     qdev_realize(DEVICE(&s->bmc), NULL, &error_abort);
 
     aspeed_board_init_flashes(&soc->fmc, "n25q00", 2, 0);
@@ -118,12 +121,14 @@ static void fby35_bmc_init(Fby35State *s)
 static void fby35_bic_init(Fby35State *s)
 {
     AspeedSoCState *soc;
+    AspeedSoCClass *sc;
 
     s->bic_sysclk = clock_new(OBJECT(s), "SYSCLK");
     clock_set_hz(s->bic_sysclk, 200000000ULL);
 
     object_initialize_child(OBJECT(s), "bic", &s->bic, "ast1030-a1");
     soc = ASPEED_SOC(&s->bic);
+    sc = ASPEED_SOC_GET_CLASS(soc);
 
     memory_region_init(&s->bic_memory, OBJECT(&s->bic), "bic-memory",
                        UINT64_MAX);
@@ -131,7 +136,8 @@ static void fby35_bic_init(Fby35State *s)
     qdev_connect_clock_in(DEVICE(&s->bic), "sysclk", s->bic_sysclk);
     object_property_set_link(OBJECT(&s->bic), "memory", OBJECT(&s->bic_memory),
                              &error_abort);
-    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART5, serial_hd(1));
+    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART5, sc->uarts_base,
+                            sc->uarts_num, serial_hd(1));
     qdev_realize(DEVICE(&s->bic), NULL, &error_abort);
 
     aspeed_board_init_flashes(&soc->fmc, "sst25vf032b", 2, 2);
-- 
2.51.0


