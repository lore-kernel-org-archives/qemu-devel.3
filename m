Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93E4CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSsE-0002G1-Hq; Mon, 08 Jun 2026 01:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrp-0001vU-7I
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrn-0000kN-06
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5hjdZg/w+5+A9cNFmEN4Et5mITlWaoRbp5aiFQt7a0=;
 b=COJ31QmAmtHqbzzQ0WU5E6wnotosibtbMLpe8rqp+FZxtHP/KMqXzgYz+L0vP4MrKRg8Xk
 +oJkFbRpuzsm38Sr+qUXxSK412pNYv5/ogiy4XuMuAIvftcwo3CSDjCExbLb7tzvb2JzTS
 OZXFVd+4ullavDe7XXZZyFFRX1OWgFA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-VhruMntrNBycFalkG5-gcg-1; Mon,
 08 Jun 2026 01:49:37 -0400
X-MC-Unique: VhruMntrNBycFalkG5-gcg-1
X-Mimecast-MFC-AGG-ID: VhruMntrNBycFalkG5-gcg_1780897776
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3326195608F; Mon,  8 Jun 2026 05:49:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F26C527A; Mon,  8 Jun 2026 05:49:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 33/37] hw/arm/aspeed_ast1040_evb: Introduce onboard I2C device
Date: Mon,  8 Jun 2026 07:48:22 +0200
Message-ID: <20260608054826.346488-34-clg@redhat.com>
In-Reply-To: <20260608054826.346488-1-clg@redhat.com>
References: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

Introduce onboard I2C device initialization for the AST1040
EVB model.

Instantiate:
 - A 24C08-compatible EEPROM at address 0x50 on I2C bus 0
 - A TMP105 temperature sensor at address 0x4d on I2C bus 1

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260603040027.938816-10-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast1040_evb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c
index 1d9b55247f07..2b93d4dfbc55 100644
--- a/hw/arm/aspeed_ast1040_evb.c
+++ b/hw/arm/aspeed_ast1040_evb.c
@@ -14,6 +14,7 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/core/qdev-clock.h"
 #include "system/system.h"
+#include "hw/i2c/smbus_eeprom.h"
 
 #define AST1040_INTERNAL_FLASH_SIZE (4 * MiB)
 /* Main SYSCLK frequency in Hz (400MHz) */
@@ -38,12 +39,25 @@ static void aspeed_bic_machine_init(MachineState *machine)
     aspeed_connect_serial_hds_to_uarts(bmc);
     qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);
 
+    if (amc->i2c_init) {
+        amc->i2c_init(bmc);
+    }
+
     armv7m_load_kernel(ARM_CPU(first_cpu),
                        machine->kernel_filename,
                        0,
                        AST1040_INTERNAL_FLASH_SIZE);
 }
 
+static void ast1040_evb_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+    uint8_t *eeprom_buf = g_malloc0(256);
+
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50, eeprom_buf);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4d);
+}
+
 static void aspeed_machine_ast1040_evb_class_init(ObjectClass *oc,
                                                   const void *data)
 {
@@ -55,6 +69,7 @@ static void aspeed_machine_ast1040_evb_class_init(ObjectClass *oc,
     amc->hw_strap1 = 0;
     amc->hw_strap2 = 0;
     mc->init = aspeed_bic_machine_init;
+    amc->i2c_init = ast1040_evb_i2c_init;
     mc->default_ram_size = 0;
     amc->macs_mask = 0;
     amc->uart_default = ASPEED_DEV_UART12;
-- 
2.54.0


