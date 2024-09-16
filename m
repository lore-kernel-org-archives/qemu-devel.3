Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0A4C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 18:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqGvi-0008RR-7c; Mon, 16 Sep 2024 14:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqGvg-0008LH-KN
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 14:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqGve-0003Jy-UH
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 14:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726513110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCYSgz/03iLuCf1aK93b7CSgL5Sszq+h+JISch4KYZM=;
 b=GWHwfZ1eo/xL9rAt4lruP8iMONPYwOOMOjijePP86f4vg6eYShSegfTEYW59EHVx74vP5U
 ebwKQiZzdY2l+MAkYNuMeukGQXzIVhQtWvTQXysRov24VA31xI0H0RHjzbr69oN/sL577z
 rZPM2GuexXnbo+JpgR9JmGpmWaiVyKY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-k2z8cKZoP46pP5Qn0Fp6TQ-1; Mon,
 16 Sep 2024 14:57:22 -0400
X-MC-Unique: k2z8cKZoP46pP5Qn0Fp6TQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD8EA1956083; Mon, 16 Sep 2024 18:57:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.44])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25FC21955D44; Mon, 16 Sep 2024 18:57:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/12] hw/i2c/aspeed: Support discontinuous poll buffer memory
 region of I2C bus
Date: Mon, 16 Sep 2024 20:57:00 +0200
Message-ID: <20240916185708.574546-5-clg@redhat.com>
In-Reply-To: <20240916185708.574546-1-clg@redhat.com>
References: <20240916185708.574546-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

It only support continuous pool buffer memory region for all I2C bus.
However, the pool buffer address of all I2c bus are discontinuous
for AST2700.

Ex: the pool buffer address of I2C bus for ast2700 as following.
0x1A0 - 0x1BF: Device 0 buffer
0x2A0 - 0x2BF: Device 1 buffer
0x3A0 - 0x3BF: Device 2 buffer
0x4A0 - 0x4BF: Device 3 buffer
0x5A0 - 0x5BF: Device 4 buffer
0x6A0 - 0x6BF: Device 5 buffer
0x7A0 - 0x7BF: Device 6 buffer
0x8A0 - 0x8BF: Device 7 buffer
0x9A0 - 0x9BF: Device 8 buffer
0xAA0 - 0xABF: Device 9 buffer
0xBA0 - 0xBBF: Device 10 buffer
0xCA0 - 0xCBF: Device 11 buffer
0xDA0 - 0xDBF: Device 12 buffer
0xEA0 - 0xEBF: Device 13 buffer
0xFA0 – 0xFBF: Device 14 buffer
0x10A0 – 0x10BF: Device 15 buffer

Introduce a new class attribute to make user set each I2C bus
pool buffer gap size. Update formula to create all I2C bus
pool buffer memory regions.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i2c/aspeed_i2c.h | 1 +
 hw/i2c/aspeed_i2c.c         | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 8e62ec64f835..b42c4dc5844b 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -284,6 +284,7 @@ struct AspeedI2CClass {
 
     uint64_t pool_size;
     hwaddr pool_base;
+    uint32_t pool_gap_size;
     uint8_t *(*bus_pool_base)(AspeedI2CBus *);
     bool check_sram;
     bool has_dma;
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 819f70197369..9fb246ba009e 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1098,6 +1098,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
     AspeedI2CState *s = ASPEED_I2C(dev);
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(s);
     uint32_t reg_offset = aic->reg_size + aic->reg_gap_size;
+    uint32_t pool_offset = aic->pool_size + aic->pool_gap_size;
 
     sysbus_init_irq(sbd, &s->irq);
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_i2c_ctrl_ops, s,
@@ -1133,7 +1134,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
     } else {
         for (i = 0; i < aic->num_busses; i++) {
             memory_region_add_subregion(&s->iomem,
-                                        aic->pool_base + (aic->pool_size * i),
+                                        aic->pool_base + (pool_offset * i),
                                         &s->busses[i].mr_pool);
         }
     }
-- 
2.46.0


