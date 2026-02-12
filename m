Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D24EEA85A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 21:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqeQ8-00089w-0h; Thu, 12 Feb 2026 16:40:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQ3-000881-EZ
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQ1-00065G-JM
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770932412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Mkkkhk2UiUGTwPLfktE4GWh3o9J6sQJBwTAwIgfVlk=;
 b=ZV/YcwXtpLD5wzOTZHlflAZNcUDVXNbv6nqCi/yTbZnO4T2Jy2kcVG+1Ro05zSUQixo1p6
 fXLAbYKhECVLiGi19QwlXtxfxD4kd/1dHKaS7zGJCXuIWNeVG4hhj+qAI8gCijrXIIryeW
 1BFc3kRnT7Avm5xsVYriYH5qxT+vNAU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-cwbQ-_4fPd2MK4kkKSTB7g-1; Thu,
 12 Feb 2026 16:40:09 -0500
X-MC-Unique: cwbQ-_4fPd2MK4kkKSTB7g-1
X-Mimecast-MFC-AGG-ID: cwbQ-_4fPd2MK4kkKSTB7g_1770932408
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77778195606E; Thu, 12 Feb 2026 21:40:08 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B60E4180035A; Thu, 12 Feb 2026 21:40:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/16] hw/i2c/aspeed_i2c: Increase I2C device register size to
 0xA0
Date: Thu, 12 Feb 2026 22:39:43 +0100
Message-ID: <20260212213955.2225662-5-clg@redhat.com>
In-Reply-To: <20260212213955.2225662-1-clg@redhat.com>
References: <20260212213955.2225662-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to the AST2700 A1 datasheet, the register space for each I2C
device instance has been expanded from 0x80 bytes to 0xA0 bytes.

Update the AST2700 I2C controller configuration to reflect the new
register layout by increasing the per-device register size to 0xA0
and adjusting the register gap size accordingly.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Fixes: 4f53de2f103d6dfb5ad0498995d91a9694f40dd2 ("hw/arm/aspeed_ast27x0: Remove ast2700-a0 SOC")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260210024331.3984696-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i2c/aspeed_i2c.h |  2 +-
 hw/i2c/aspeed_i2c.c         | 36 ++++++++++++++++++------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 1ba0112cef6b..53a9dba71b07 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -36,7 +36,7 @@ OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)
 #define ASPEED_I2C_NR_BUSSES 16
 #define ASPEED_I2C_SHARE_POOL_SIZE 0x800
 #define ASPEED_I2C_BUS_POOL_SIZE 0x20
-#define ASPEED_I2C_NEW_NUM_REG (0x80 >> 2)
+#define ASPEED_I2C_NEW_NUM_REG (0xa0 >> 2)
 
 #define A_I2CD_M_STOP_CMD       BIT(5)
 #define A_I2CD_M_RX_CMD         BIT(3)
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 741c7a7297f5..122bfdd63dca 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1205,37 +1205,37 @@ static void aspeed_i2c_instance_init(Object *obj)
  *
  * Address Definitions (AST2700)
  *   0x000 ... 0x0FF: Global Register
- *   0x100 ... 0x17F: Device 0
+ *   0x100 ... 0x19F: Device 0
  *   0x1A0 ... 0x1BF: Device 0 buffer
- *   0x200 ... 0x27F: Device 1
+ *   0x200 ... 0x29F: Device 1
  *   0x2A0 ... 0x2BF: Device 1 buffer
- *   0x300 ... 0x37F: Device 2
+ *   0x300 ... 0x39F: Device 2
  *   0x3A0 ... 0x3BF: Device 2 buffer
- *   0x400 ... 0x47F: Device 3
+ *   0x400 ... 0x49F: Device 3
  *   0x4A0 ... 0x4BF: Device 3 buffer
- *   0x500 ... 0x57F: Device 4
+ *   0x500 ... 0x59F: Device 4
  *   0x5A0 ... 0x5BF: Device 4 buffer
- *   0x600 ... 0x67F: Device 5
+ *   0x600 ... 0x69F: Device 5
  *   0x6A0 ... 0x6BF: Device 5 buffer
- *   0x700 ... 0x77F: Device 6
+ *   0x700 ... 0x79F: Device 6
  *   0x7A0 ... 0x7BF: Device 6 buffer
- *   0x800 ... 0x87F: Device 7
+ *   0x800 ... 0x89F: Device 7
  *   0x8A0 ... 0x8BF: Device 7 buffer
- *   0x900 ... 0x97F: Device 8
+ *   0x900 ... 0x99F: Device 8
  *   0x9A0 ... 0x9BF: Device 8 buffer
- *   0xA00 ... 0xA7F: Device 9
+ *   0xA00 ... 0xA9F: Device 9
  *   0xAA0 ... 0xABF: Device 9 buffer
- *   0xB00 ... 0xB7F: Device 10
+ *   0xB00 ... 0xB9F: Device 10
  *   0xBA0 ... 0xBBF: Device 10 buffer
- *   0xC00 ... 0xC7F: Device 11
+ *   0xC00 ... 0xC9F: Device 11
  *   0xCA0 ... 0xCBF: Device 11 buffer
- *   0xD00 ... 0xD7F: Device 12
+ *   0xD00 ... 0xD9F: Device 12
  *   0xDA0 ... 0xDBF: Device 12 buffer
- *   0xE00 ... 0xE7F: Device 13
+ *   0xE00 ... 0xE9F: Device 13
  *   0xEA0 ... 0xEBF: Device 13 buffer
- *   0xF00 ... 0xF7F: Device 14
+ *   0xF00 ... 0xF9F: Device 14
  *   0xFA0 ... 0xFBF: Device 14 buffer
- *   0x1000 ... 0x107F: Device 15
+ *   0x1000 ... 0x109F: Device 15
  *   0x10A0 ... 0x10BF: Device 15 buffer
  */
 static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
@@ -1658,8 +1658,8 @@ static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *data)
     dc->desc = "ASPEED 2700 I2C Controller";
 
     aic->num_busses = 16;
-    aic->reg_size = 0x80;
-    aic->reg_gap_size = 0x80;
+    aic->reg_size = 0xa0;
+    aic->reg_gap_size = 0x60;
     aic->gap = -1; /* no gap */
     aic->bus_get_irq = aspeed_2600_i2c_bus_get_irq;
     aic->pool_size = 0x20;
-- 
2.53.0


