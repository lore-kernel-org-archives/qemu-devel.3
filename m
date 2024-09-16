Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C13FC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 19:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqGvf-0008Go-Iw; Mon, 16 Sep 2024 14:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqGvd-00088T-Ms
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 14:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqGvc-0003Jb-5L
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 14:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726513107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7TUWMxNopOC5Sn+N0t1XWP7ZeD9STqgIv8eGWRZi4Vk=;
 b=axIbc6gXdvuL9sMyKs0SAX+VJVNa621UBU19ALJSPi4YYV45GrSKjaaDbF6x7pvq3ffgLD
 6A3gj9MIA/6C2chjKJl1dL5njREjoRbpdygQUnE1Qwr+t4utZkIMDcxmd8qR+TFG/98YKu
 23KF3sdLtAIDZ/JPMuHpHhwYh5cAiAY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-f4ibBwFBPbyMYsI87hrNwA-1; Mon,
 16 Sep 2024 14:57:18 -0400
X-MC-Unique: f4ibBwFBPbyMYsI87hrNwA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB4BA1955F45; Mon, 16 Sep 2024 18:57:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.44])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3C09195605A; Mon, 16 Sep 2024 18:57:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/12] hw/i2c/aspeed: Support discontinuous register memory
 region of I2C bus
Date: Mon, 16 Sep 2024 20:56:58 +0200
Message-ID: <20240916185708.574546-3-clg@redhat.com>
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

It only support continuous register memory region for all I2C bus.
However, the register address of all I2c bus are discontinuous
for AST2700.

Ex: the register address of I2C bus for ast2700 as following.
0x100 - 0x17F: Device 0
0x200 - 0x27F: Device 1
0x300 - 0x37F: Device 2
0x400 - 0x47F: Device 3
0x500 - 0x57F: Device 4
0x600 - 0x67F: Device 5
0x700 - 0x77F: Device 6
0x800 - 0x87F: Device 7
0x900 - 0x97F: Device 8
0xA00 - 0xA7F: Device 9
0xB00 - 0xB7F: Device 10
0xC00 - 0xC7F: Device 11
0xD00 - 0xD7F: Device 12
0xE00 - 0xE7F: Device 13
0xF00 – 0xF7F: Device 14
0x1000 – 0x107F: Device 15

Introduce a new class attribute to make user set each I2C bus gap size.
Update formula to create all I2C bus register memory regions.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i2c/aspeed_i2c.h | 1 +
 hw/i2c/aspeed_i2c.c         | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index fad5e9259a51..02ede859067e 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -275,6 +275,7 @@ struct AspeedI2CClass {
 
     uint8_t num_busses;
     uint8_t reg_size;
+    uint32_t reg_gap_size;
     uint8_t gap;
     qemu_irq (*bus_get_irq)(AspeedI2CBus *);
 
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index f19891371426..ee30243c25f9 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1012,6 +1012,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     AspeedI2CState *s = ASPEED_I2C(dev);
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(s);
+    uint32_t reg_offset = aic->reg_size + aic->reg_gap_size;
 
     sysbus_init_irq(sbd, &s->irq);
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_i2c_ctrl_ops, s,
@@ -1034,7 +1035,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        memory_region_add_subregion(&s->iomem, aic->reg_size * (i + offset),
+        memory_region_add_subregion(&s->iomem, reg_offset * (i + offset),
                                     &s->busses[i].mr);
     }
 
-- 
2.46.0


