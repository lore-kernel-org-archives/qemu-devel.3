Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8611FCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H9T-0006xe-O7; Mon, 29 Sep 2025 12:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H8T-0003pI-VB
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H8M-0002xx-Hx
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dQfZbCFWhgJY25myTtGE4Qvn1E3bngTEvcqBPgfUd54=;
 b=C05TDEvAjyzkyK9O0bWFEx699ACmE3ifatr+POlPkRAZqICNFkSyk8gz/ZW+ZvYWnnvqNh
 bmDrrz24l3JpoBRgP7nZcSi5A1/zQHEg7Zr6DD9UQch8bVt0QRwu/Ir62CXRShHwZQDu9f
 zCOgmO30rNWZlZlLcs52s4Uid5Qjnzg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-ax9wkHQZMUyTaMDDIOpGkQ-1; Mon,
 29 Sep 2025 12:53:49 -0400
X-MC-Unique: ax9wkHQZMUyTaMDDIOpGkQ-1
X-Mimecast-MFC-AGG-ID: ax9wkHQZMUyTaMDDIOpGkQ_1759164828
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1A9318004D4; Mon, 29 Sep 2025 16:53:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4AA2B1800452; Mon, 29 Sep 2025 16:53:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 32/32] hw/arm/aspeed_ast27x0-fc: Make sub-init functions return
 bool with errp
Date: Mon, 29 Sep 2025 18:52:30 +0200
Message-ID: <20250929165230.797471-33-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Refactor ast2700fc_ca35_init(), ast2700fc_ssp_init(), and ast2700fc_tsp_init()
to take an Error **errp parameter and return a bool.
Each function now reports failure through the error object and returns false.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250925050535.2657256-7-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0-fc.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index ebf3784df588..2e16a0340a7b 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -56,7 +56,7 @@ struct Ast2700FCState {
 #define AST2700FC_FMC_MODEL "w25q01jvq"
 #define AST2700FC_SPI_MODEL "w25q512jv"
 
-static void ast2700fc_ca35_init(MachineState *machine)
+static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
 {
     Ast2700FCState *s = AST2700A1FC(machine);
     AspeedSoCState *soc;
@@ -71,8 +71,8 @@ static void ast2700fc_ca35_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), 0, &s->ca35_memory);
 
     if (!memory_region_init_ram(&s->ca35_dram, OBJECT(&s->ca35), "ca35-dram",
-                                AST2700FC_BMC_RAM_SIZE, &error_abort)) {
-        return;
+                                AST2700FC_BMC_RAM_SIZE, errp)) {
+        return false;
     }
     object_property_set_link(OBJECT(&s->ca35), "memory",
                              OBJECT(&s->ca35_memory), &error_abort);
@@ -92,8 +92,8 @@ static void ast2700fc_ca35_init(MachineState *machine)
     object_property_set_int(OBJECT(&s->ca35), "hw-strap2",
                             AST2700FC_HW_STRAP2, &error_abort);
     aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART12, serial_hd(0));
-    if (!qdev_realize(DEVICE(&s->ca35), NULL, &error_abort)) {
-        return;
+    if (!qdev_realize(DEVICE(&s->ca35), NULL, errp)) {
+        return false;
     }
 
     /*
@@ -108,9 +108,11 @@ static void ast2700fc_ca35_init(MachineState *machine)
     ast2700fc_board_info.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
 
     arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
+
+    return true;
 }
 
-static void ast2700fc_ssp_init(MachineState *machine)
+static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
 {
     AspeedSoCState *soc;
     Ast2700FCState *s = AST2700A1FC(machine);
@@ -127,12 +129,14 @@ static void ast2700fc_ssp_init(MachineState *machine)
 
     soc = ASPEED_SOC(&s->ssp);
     aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(1));
-    if (!qdev_realize(DEVICE(&s->ssp), NULL, &error_abort)) {
-        return;
+    if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {
+        return false;
     }
+
+    return true;
 }
 
-static void ast2700fc_tsp_init(MachineState *machine)
+static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
 {
     AspeedSoCState *soc;
     Ast2700FCState *s = AST2700A1FC(machine);
@@ -149,16 +153,18 @@ static void ast2700fc_tsp_init(MachineState *machine)
 
     soc = ASPEED_SOC(&s->tsp);
     aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART7, serial_hd(2));
-    if (!qdev_realize(DEVICE(&s->tsp), NULL, &error_abort)) {
-        return;
+    if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
+        return false;
     }
+
+    return true;
 }
 
 static void ast2700fc_init(MachineState *machine)
 {
-    ast2700fc_ca35_init(machine);
-    ast2700fc_ssp_init(machine);
-    ast2700fc_tsp_init(machine);
+    ast2700fc_ca35_init(machine, &error_abort);
+    ast2700fc_ssp_init(machine, &error_abort);
+    ast2700fc_tsp_init(machine, &error_abort);
 }
 
 static void ast2700fc_class_init(ObjectClass *oc, const void *data)
-- 
2.51.0


