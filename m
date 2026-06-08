Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0979CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSsG-0002SE-Cn; Mon, 08 Jun 2026 01:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrj-0001r4-Eg
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrh-0000hj-NQ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMNvVJ7iJrL/5zHrO8QbpJsc8b209aVkYqUV2dm0o2g=;
 b=I+9q4SZvc+RRFngFX9xaSfY9sm8jdjZvELioSeDGdnRsy1XCgXtcRr1XnkyrVfrg8ngy4l
 bFv3TYKXICH2Zgo3R3FyobnfMacj+Hmt5LIL4a+0R9Lf8fofn+CHRZQrcIKv8u3VfniDpv
 NOtdI53P6r/DpMUX1K2RMd6RmlmxvBM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-AqKZQIggMcihedJzXfWqyA-1; Mon,
 08 Jun 2026 01:49:33 -0400
X-MC-Unique: AqKZQIggMcihedJzXfWqyA-1
X-Mimecast-MFC-AGG-ID: AqKZQIggMcihedJzXfWqyA_1780897772
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F4D11800473; Mon,  8 Jun 2026 05:49:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A9FB27A; Mon,  8 Jun 2026 05:49:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 31/37] hw/i2c/aspeed_i2c: Introduce AST1040 I2C model
Date: Mon,  8 Jun 2026 07:48:20 +0200
Message-ID: <20260608054826.346488-32-clg@redhat.com>
In-Reply-To: <20260608054826.346488-1-clg@redhat.com>
References: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

Introduce the AST1040 I2C controller model.

The AST1040 I2C controller is compatible with the AST2700 I2C controller,
including DMA support and the 64-bit DMA address registers. Set has_dma64 so
firmware can access the high address register and program it to zero, as the
CM4 CPU only supports 32-bit addressing.

AST1040 has 14 I2C buses and its HyperRAM is limited to 16 MiB,
so restrict the DMA low address mask to 0x00ffffff.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260603040027.938816-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i2c/aspeed_i2c.h |  1 +
 hw/i2c/aspeed_i2c.c         | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index b2e4d2fb9dcb..156998e7c14e 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -30,6 +30,7 @@
 #define TYPE_ASPEED_2500_I2C TYPE_ASPEED_I2C "-ast2500"
 #define TYPE_ASPEED_2600_I2C TYPE_ASPEED_I2C "-ast2600"
 #define TYPE_ASPEED_1030_I2C TYPE_ASPEED_I2C "-ast1030"
+#define TYPE_ASPEED_1040_I2C TYPE_ASPEED_I2C "-ast1040"
 #define TYPE_ASPEED_2700_I2C TYPE_ASPEED_I2C "-ast2700"
 OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)
 
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 856d5dc1db64..27afcaeceedc 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1654,6 +1654,34 @@ static void aspeed_1030_i2c_class_init(ObjectClass *klass, const void *data)
     aic->dma_addr_lo_mask = 0x7fffffff;
 }
 
+static void aspeed_1040_i2c_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedI2CClass *aic = ASPEED_I2C_CLASS(klass);
+
+    dc->desc = "ASPEED 1040 I2C Controller";
+
+    /*
+     * AST1040 reuses the AST2700 I2C controller implementation since
+     * the AST1040 is compatible with AST2700. AST1040 has 14 I2C buses,
+     * and its HyperRAM is limited to 16 MiB, so the DMA low address
+     * mask is restricted accordingly.
+     */
+    aic->num_busses = 14;
+    aic->reg_size = 0xa0;
+    aic->reg_gap_size = 0x60;
+    aic->gap = -1; /* no gap */
+    aic->bus_get_irq = aspeed_2600_i2c_bus_get_irq;
+    aic->pool_size = 0x40;
+    aic->pool_gap_size = 0xc0;
+    aic->pool_base = 0x1c0;
+    aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
+    aic->has_dma = true;
+    aic->mem_size = 0x2000;
+    aic->has_dma64 = true;
+    aic->dma_addr_lo_mask = 0x00ffffff;
+}
+
 static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1703,6 +1731,11 @@ static const TypeInfo aspeed_i2c_types[] = {
         .parent = TYPE_ASPEED_I2C,
         .class_init = aspeed_1030_i2c_class_init,
     },
+    {
+        .name = TYPE_ASPEED_1040_I2C,
+        .parent = TYPE_ASPEED_I2C,
+        .class_init = aspeed_1040_i2c_class_init,
+    },
     {
         .name = TYPE_ASPEED_2400_I2C,
         .parent = TYPE_ASPEED_I2C,
-- 
2.54.0


