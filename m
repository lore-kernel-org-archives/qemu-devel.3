Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A5EC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi5dV-00067t-Ra; Fri, 10 Jul 2026 03:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi5dT-00067Z-Dk; Fri, 10 Jul 2026 03:27:00 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi5dR-0005oX-Bm; Fri, 10 Jul 2026 03:26:59 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id F1B192003C6;
 Fri, 10 Jul 2026 09:26:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783668414;
 bh=7+IEfH29HKzSg6MtCPwrf2NQfJyXfgZFiYTj8F7wswI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XmtXOTON16fLiul9xWsuGq7KlODWNbcHQzLLKTOfLkwWj2HG3EP4xsWzu62L09w/h
 YWzdzr1C6hKRsjqZZs3nguQ2Q+C9Ek6EZxLJyD+BSFRwoYyow+86Y9lHLqW/S5+S6o
 Tvspz7bl5rqwj7+AxdTRHLIjviPVZK++lowFI2HVPTWv1ic8YQaQt4D6Zf+/kMw6ka
 gPtD9lWtk244uTI2ZMFV0xQyG8m+IcIHt0E465oOG7tcZlhe0TIs1PgFSa2DeZH0LJ
 QTGk/G89reHkBVGrINB053Ht7kdxCKiE66yyaJrzJmQQVhvnPFE1Kj1bqozcGXWYFY
 cpU5tYIMDc8Vg==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:16 +0200
Subject: [PATCH 24/29] hw/arm: catalina: model PCA9555 IO expanders with
 their own type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-24-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
In-Reply-To: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Corey Minyard <cminyard@mvista.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610580; l=3586;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=7+IEfH29HKzSg6MtCPwrf2NQfJyXfgZFiYTj8F7wswI=;
 b=G08CVt1cwOYrPH/b0Avt/M0R3/KP0wNa1Y2dTja8IwdmN4Bov99M+7eXFjFgeKd3cAIAYkolG
 oJQqCVuWsrgARntsEn5IvYH5qDp9eerAJwhvSeN373Bt3ePTdvw4CYi
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=212.27.42.2; envelope-from=emmanuel.blot@free.fr;
 helo=smtp2-g21.free.fr
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

The Catalina BMC device tree describes several IO expanders as nxp,pca9555.
These were previously instantiated as PCA9552 devices as no PCA9555 model
existed. Now that a dedicated PCA9555 device is available, use it so the
emulated IO expanders match the hardware.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/arm/aspeed_ast2600_catalina.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 65495a524ea..f3b22e9aa9a 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -533,7 +533,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
                             TYPE_PCA9554, 0x27);
     /* io_expander6 - pca9555@25 */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
-                            TYPE_PCA9552, 0x25);
+                            TYPE_PCA9555, 0x25);
     /* eeprom@51 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 6), 0x51, 8 * KiB,
                           osfp_eeprom, osfp_eeprom_len);
@@ -547,11 +547,11 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c2 */
     /* io_expander0 - pca9555@20 */
-    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x20);
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9555, 0x20);
     /* io_expander0 - pca9555@21 */
-    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x21);
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9555, 0x21);
     /* io_expander0 - pca9555@27 */
-    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x27);
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9555, 0x27);
     /* eeprom@50 */
     at24c_eeprom_init(i2c[2], 0x50, 8 * KiB);
     /* eeprom@51 */
@@ -572,13 +572,13 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c6 */
     /* io_expander3 - pca9555@21 */
-    i2c_slave_create_simple(i2c[6], TYPE_PCA9552, 0x21);
+    i2c_slave_create_simple(i2c[6], TYPE_PCA9555, 0x21);
     /* rtc@6f - nct3018y */
     i2c_slave_create_simple(i2c[6], TYPE_DS1338, 0x6f);
 
     /* &i2c9 */
     /* io_expander4 - pca9555@4f */
-    i2c_slave_create_simple(i2c[9], TYPE_PCA9552, 0x4f);
+    i2c_slave_create_simple(i2c[9], TYPE_PCA9555, 0x4f);
     /* temperature-sensor@4b - tpm75 */
     i2c_slave_create_simple(i2c[9], TYPE_TMP75, 0x4b);
     /* eeprom@50 */
@@ -615,17 +615,17 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c14 */
     /* io_expander9 - pca9555@10 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x10);
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x10);
     /* io_expander10 - pca9555@11 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x11);
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x11);
     /* io_expander11 - pca9555@12 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x12);
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x12);
     /* io_expander12 - pca9555@13 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x13);
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x13);
     /* io_expander13 - pca9555@14 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x14);
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x14);
     /* io_expander14 - pca9555@15 */
-    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x15);
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x15);
 
     /* &i2c15 */
     /* temperature-sensor@1f - tmp421 */

-- 
2.50.1


