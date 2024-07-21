Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF228C3DA61
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2024 08:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVRiX-0001SL-Mu; Sun, 21 Jul 2024 04:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVRiV-0001IU-6N
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 04:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVRiT-0001XS-AZ
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 04:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721549686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZFJk6N4bnlLhuN7xHBbX28ecMO0lvE2LS6iTIcHWdX8=;
 b=MoaMipXjZQUFzc4qlCpUncAD/SqLLvbnJ6HA+mPMkA39ybbrx7/xVKOCSc213X+bOxN6eM
 sOwZwL3AvN1PjyUPHT2Awxxg/spiFY2bvkEC7H7+lg0s4ixZs6ZHBaZVc+B8AbMD4QNbl5
 +yaoIy1Rfm/1QHLZdDmMDRtO6wGvBAk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-CvNePszeP8e0jDzSSl8nMw-1; Sun,
 21 Jul 2024 04:14:42 -0400
X-MC-Unique: CvNePszeP8e0jDzSSl8nMw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4A8019560AB; Sun, 21 Jul 2024 08:14:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.37])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4586C1955D47; Sun, 21 Jul 2024 08:14:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/15] hw/i2c/aspeed: support to set the different memory size
Date: Sun, 21 Jul 2024 10:13:59 +0200
Message-ID: <20240721081401.425588-14-clg@redhat.com>
In-Reply-To: <20240721081401.425588-1-clg@redhat.com>
References: <20240721081401.425588-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

According to the datasheet of ASPEED SOCs,
an I2C controller owns 8KB of register space for AST2700,
owns 4KB of register space for AST2600, AST2500 and AST2400,
and owns 64KB of register space for AST1030.

It set the memory region size 4KB by default and it does not compatible
register space for AST2700.

Introduce a new class attribute to set the I2C controller memory size
for different ASPEED SOCs.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i2c/aspeed_i2c.h | 2 +-
 hw/i2c/aspeed_i2c.c         | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index a064479e599c..065b636d2999 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -283,7 +283,7 @@ struct AspeedI2CClass {
     uint8_t *(*bus_pool_base)(AspeedI2CBus *);
     bool check_sram;
     bool has_dma;
-
+    uint64_t mem_size;
 };
 
 static inline bool aspeed_i2c_is_new_mode(AspeedI2CState *s)
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index b43afd250de4..7d5a53c4c015 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1014,7 +1014,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
 
     sysbus_init_irq(sbd, &s->irq);
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_i2c_ctrl_ops, s,
-                          "aspeed.i2c", 0x1000);
+                          "aspeed.i2c", aic->mem_size);
     sysbus_init_mmio(sbd, &s->iomem);
 
     for (i = 0; i < aic->num_busses; i++) {
@@ -1286,6 +1286,7 @@ static void aspeed_2400_i2c_class_init(ObjectClass *klass, void *data)
     aic->pool_size = 0x800;
     aic->pool_base = 0x800;
     aic->bus_pool_base = aspeed_2400_i2c_bus_pool_base;
+    aic->mem_size = 0x1000;
 }
 
 static const TypeInfo aspeed_2400_i2c_info = {
@@ -1320,6 +1321,7 @@ static void aspeed_2500_i2c_class_init(ObjectClass *klass, void *data)
     aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
     aic->check_sram = true;
     aic->has_dma = true;
+    aic->mem_size = 0x1000;
 }
 
 static const TypeInfo aspeed_2500_i2c_info = {
@@ -1353,6 +1355,7 @@ static void aspeed_2600_i2c_class_init(ObjectClass *klass, void *data)
     aic->pool_base = 0xC00;
     aic->bus_pool_base = aspeed_2600_i2c_bus_pool_base;
     aic->has_dma = true;
+    aic->mem_size = 0x1000;
 }
 
 static const TypeInfo aspeed_2600_i2c_info = {
@@ -1376,6 +1379,7 @@ static void aspeed_1030_i2c_class_init(ObjectClass *klass, void *data)
     aic->pool_base = 0xC00;
     aic->bus_pool_base = aspeed_2600_i2c_bus_pool_base;
     aic->has_dma = true;
+    aic->mem_size = 0x10000;
 }
 
 static const TypeInfo aspeed_1030_i2c_info = {
-- 
2.45.2


