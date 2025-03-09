Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3E8C28B30
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trH5R-0001K6-VE; Sun, 09 Mar 2025 09:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH5N-00016s-T8
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH5M-0003dG-3C
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741528375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1XK49z91ep7hbSkGqBU1/BQCsBVM9Fqu5NkEZQ7BxyE=;
 b=bg43sUrfdQyZi+Oefp/eIQrKI3TkA2WX+u1FCPV3eX37xKIwyP4BO0t668bPuFYTY887pQ
 qU/83sr1fWl0IVc/yFCNV5UmaHMpYXtee/gpyBK1+fsaf8kUR950zD8UZA20dAx1SAzKWT
 884S0eo7iLIkSNyRFKaRFZ/vKmvag04=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-TC_Sjj8tOY-mDDfHLL9g7A-1; Sun,
 09 Mar 2025 09:52:52 -0400
X-MC-Unique: TC_Sjj8tOY-mDDfHLL9g7A-1
X-Mimecast-MFC-AGG-ID: TC_Sjj8tOY-mDDfHLL9g7A_1741528371
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19A3B19560B3; Sun,  9 Mar 2025 13:52:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C5461956094; Sun,  9 Mar 2025 13:52:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 29/46] hw/intc/aspeed: Add support for multiple output pins in
 INTC
Date: Sun,  9 Mar 2025 14:51:13 +0100
Message-ID: <20250309135130.545764-30-clg@redhat.com>
In-Reply-To: <20250309135130.545764-1-clg@redhat.com>
References: <20250309135130.545764-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Added support for multiple output pins in the INTC controller to
accommodate the AST2700 A1.

Introduced "num_outpins" to represent the number of output pins. Updated the
IRQ handling logic to initialize and connect output pins separately from input
pins. Modified the "aspeed_soc_ast2700_realize" function to connect source
orgates to INTC and INTC to GIC128 - GIC136. Updated the "aspeed_intc_realize"
function to initialize output pins.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250307035945.3698802-13-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/intc/aspeed_intc.h | 5 +++--
 hw/arm/aspeed_ast27x0.c       | 6 +++++-
 hw/intc/aspeed_intc.c         | 4 ++++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index 58be5b3e1323..2a22e3084615 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -16,8 +16,8 @@
 #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
 OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
 
-#define ASPEED_INTC_NR_INTS 9
 #define ASPEED_INTC_MAX_INPINS 9
+#define ASPEED_INTC_MAX_OUTPINS 9
 
 struct AspeedINTCState {
     /*< private >*/
@@ -29,7 +29,7 @@ struct AspeedINTCState {
 
     uint32_t *regs;
     OrIRQState orgates[ASPEED_INTC_MAX_INPINS];
-    qemu_irq output_pins[ASPEED_INTC_NR_INTS];
+    qemu_irq output_pins[ASPEED_INTC_MAX_OUTPINS];
 
     uint32_t enable[ASPEED_INTC_MAX_INPINS];
     uint32_t mask[ASPEED_INTC_MAX_INPINS];
@@ -41,6 +41,7 @@ struct AspeedINTCClass {
 
     uint32_t num_lines;
     uint32_t num_inpins;
+    uint32_t num_outpins;
     uint64_t mem_size;
     uint64_t nr_regs;
     uint64_t reg_offset;
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 1a3eb02af3bf..3cb95210a06f 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -534,10 +534,14 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc), 0,
                     sc->memmap[ASPEED_DEV_INTC]);
 
-    /* GICINT orgates -> INTC -> GIC */
+    /* source orgates -> INTC */
     for (i = 0; i < ic->num_inpins; i++) {
         qdev_connect_gpio_out(DEVICE(&a->intc.orgates[i]), 0,
                                 qdev_get_gpio_in(DEVICE(&a->intc), i));
+    }
+
+    /* INTC -> GIC128 - GIC136 */
+    for (i = 0; i < ic->num_outpins; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc), i,
                            qdev_get_gpio_in(DEVICE(&a->gic),
                                 aspeed_soc_ast2700_gic_intcmap[i].irq));
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 217fda6fe001..6f37afc17e25 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -347,6 +347,9 @@ static void aspeed_intc_realize(DeviceState *dev, Error **errp)
         if (!qdev_realize(DEVICE(&s->orgates[i]), NULL, errp)) {
             return;
         }
+    }
+
+    for (i = 0; i < aic->num_outpins; i++) {
         sysbus_init_irq(sbd, &s->output_pins[i]);
     }
 }
@@ -391,6 +394,7 @@ static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
     dc->desc = "ASPEED 2700 INTC Controller";
     aic->num_lines = 32;
     aic->num_inpins = 9;
+    aic->num_outpins = 9;
     aic->mem_size = 0x4000;
     aic->nr_regs = 0x808 >> 2;
     aic->reg_offset = 0x1000;
-- 
2.48.1


