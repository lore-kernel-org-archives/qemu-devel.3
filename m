Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41699C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 21:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whw7t-0007UD-5U; Thu, 09 Jul 2026 17:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whw7r-0007Tg-RB; Thu, 09 Jul 2026 17:17:43 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whw7p-0000da-5Q; Thu, 09 Jul 2026 17:17:43 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id DE3D62003CE;
 Thu,  9 Jul 2026 23:17:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783631856;
 bh=aGMvLXuOFOzVnrP/yOXUemJJQkpIhs625E8sG+n1uEM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Kb0DbKHuWJMzkl8OOSIxpg4E8O1tEdrsSBHZkQzHPHvS7q+v0BqXPwlY17xpV4RKb
 MYa1PdYTTXUyRXLDy6k+fOz3jo2gO8IThg5PlbUxL/5Ag3C/cvZBrAtD7sR1ieWDCE
 MJel3HVqahYY1wuLH8ooShIPEVK9EtEluepvDgLQ9jwljUv7z5mIZuWDmMdSb5paxA
 09YyoqzSOJCvDLykh0MlBk7P6ujAVCycCwXZlfsSxXnMkvc5XJhd6YOfj/5CHQMrCF
 pGGKrOSJm7Mi2aea7mzzw+kvK46+HpAkLwptcaStTcyCqM6wEbHIlnlvbdxlxFoJTL
 L1BTrIxxrdWBA==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:20 +0200
Subject: [PATCH 28/29] hw/arm: catalina: drive pca9554 io expander input
 pins externally
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-28-82a63fead90c@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610580; l=1675;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=aGMvLXuOFOzVnrP/yOXUemJJQkpIhs625E8sG+n1uEM=;
 b=qSMPPky6qvLqZcJxvCZktLn5Uw6sssbux30k3RvGn8uQ1SB9yNQuLL7hfYqemkTijtaKnwCb4
 RBPHK9L0lFgDa4gJqey0K4hO04Bll+ObyQio0dA+Q5nW/RtnujBNOnx
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=212.27.42.2; envelope-from=emmanuel.blot@free.fr;
 helo=smtp2-g21.free.fr
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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

Create io_expander5 (pca9554@27) with hw-dir=true so its pin%d QOM
properties drive the external input level of each pin, matching the
pca9555 expanders, instead of the legacy behaviour that forces the pin
to an output. This lets external agents, including tests, stimulate the
input pins and have the guest read them back.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/arm/aspeed_ast2600_catalina.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index f714c9d1b3..67b821ccb9 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -546,9 +546,16 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), TYPE_TMP75, 0x4f);
 
     /* i2c1mux0ch6 */
-    /* io_expander5 - pca9554@27 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
-                            TYPE_PCA9554, 0x27);
+    /* io_expander5 - pca9554@27 (external agents drive its input pins) */
+    {
+        I2CBus *bus = pca954x_i2c_get_bus(i2c_mux, 6);
+        I2CSlave *ioexp = i2c_slave_new(TYPE_PCA9554, 0x27);
+
+        object_property_add_child(OBJECT(bus), "0x27", OBJECT(ioexp));
+        object_property_set_bool(OBJECT(ioexp), "hw-dir", true,
+                                 &error_abort);
+        i2c_slave_realize_and_unref(ioexp, bus, &error_abort);
+    }
     /* io_expander6 - pca9555@25 */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
                             TYPE_PCA9555, 0x25);

-- 
2.50.1


