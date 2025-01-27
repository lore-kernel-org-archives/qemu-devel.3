Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B90C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 09:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcLeF-0006F0-N3; Mon, 27 Jan 2025 04:43:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tcLeB-0006DE-2m
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 04:43:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tcLe9-0005RJ-AC
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 04:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737970988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HCgBPHkwQ9noTFqoX4NtX4SFLU9O8jURWveoSWvlS7U=;
 b=ONG+9V9Cldvgo+zGVPgdHgD7uGPP5FxQzgTxqoq2Y4m0QQXYe5U6IApjICB39K4ClXHjbU
 6cwNoQrheCPkE4+vjkotkZOCz3cIT8DdDBTx2hogWu0QfnhdrPNOkup/SGmYB5+va9/1Tq
 SbDaI4KkfRfns1lUptXmSaXeThcjeGc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669--C8pNZ6JOKiRChQFyLNdGg-1; Mon,
 27 Jan 2025 04:43:04 -0500
X-MC-Unique: -C8pNZ6JOKiRChQFyLNdGg-1
X-Mimecast-MFC-AGG-ID: -C8pNZ6JOKiRChQFyLNdGg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DD001801F16; Mon, 27 Jan 2025 09:43:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F33618008E4; Mon, 27 Jan 2025 09:43:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/12] aspeed/soc: Support Timer for AST2700
Date: Mon, 27 Jan 2025 10:42:33 +0100
Message-ID: <20250127094239.636526-7-clg@redhat.com>
In-Reply-To: <20250127094239.636526-1-clg@redhat.com>
References: <20250127094239.636526-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add Timer model for AST2700 Timer support. The Timer controller include 8 sets
of 32-bit decrement counters.

The base address of TIMER0 to TIMER7 as following.
Base Address of Timer 0 = 0x12C1_0000
Base Address of Timer 1 = 0x12C1_0040
Base Address of Timer 2 = 0x12C1_0080
Base Address of Timer 3 = 0x12C1_00C0
Base Address of Timer 4 = 0x12C1_0100
Base Address of Timer 5 = 0x12C1_0140
Base Address of Timer 6 = 0x12C1_0180
Base Address of Timer 7 = 0x12C1_01C0

The interrupt of TIMER0 to TIMER7 as following.
GICINT16 = TIMER 0 interrupt
GICINT17 = TIMER 1 interrupt
GICINT18 = TIMER 2 interrupt
GICINT19 = TIMER 3 interrupt
GICINT20 = TIMER 4 interrupt
GICINT21 = TIMER 5 interrupt
GICINT22 = TIMER 6 interrupt
GICINT23 = TIMER 7 interrupt

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20250113064455.1660564-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index fee37558372a..4114e15dddf4 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -66,6 +66,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_GPIO]      =  0x14C0B000,
     [ASPEED_DEV_RTC]       =  0x12C0F000,
     [ASPEED_DEV_SDHCI]     =  0x14080000,
+    [ASPEED_DEV_TIMER1]    =  0x12C10000,
 };
 
 #define AST2700_MAX_IRQ 256
@@ -397,6 +398,9 @@ static void aspeed_soc_ast2700_init(Object *obj)
 
     object_initialize_child(obj, "emmc-controller.sdhci", &s->emmc.slots[0],
                             TYPE_SYSBUS_SDHCI);
+
+    snprintf(typename, sizeof(typename), "aspeed.timer-%s", socname);
+    object_initialize_child(obj, "timerctrl", &s->timerctrl, typename);
 }
 
 /*
@@ -716,6 +720,19 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_EMMC));
 
+    /* Timer */
+    object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
+                             &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->timerctrl), 0,
+                    sc->memmap[ASPEED_DEV_TIMER1]);
+    for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
+        irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
+    }
+
     create_unimplemented_device("ast2700.dpmcu", 0x11000000, 0x40000);
     create_unimplemented_device("ast2700.iomem0", 0x12000000, 0x01000000);
     create_unimplemented_device("ast2700.iomem1", 0x14000000, 0x01000000);
-- 
2.48.1


