Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C176C79F8B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vck9y-0004x0-JN; Mon, 05 Jan 2026 07:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck9X-0004kp-JZ
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck9Q-00088o-0g
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kJamzIu5Cl83GuxCo518L71tooIf9xFruKQPqLcFGn4=;
 b=IX4cOWiOIVzWyEPEMgG+jD4jdnncSQ18o1b1UcHfXz6W57TcXK/Fyyxp6zG5QXw7Mn5wQp
 f/taJOCmeazW4at3XGpx2PEGm7RrIv5z3kqzRTnJYI8tSiZxT/+RBiUeZIyb51jIFbmUxG
 xm9uuIdKJdEnQcbk1whh7/fRRX6okj4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-S6rv44lDNZ2OVtk_wdFGwA-1; Mon,
 05 Jan 2026 07:57:33 -0500
X-MC-Unique: S6rv44lDNZ2OVtk_wdFGwA-1
X-Mimecast-MFC-AGG-ID: S6rv44lDNZ2OVtk_wdFGwA_1767617853
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D85381800626; Mon,  5 Jan 2026 12:57:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3341819560A7; Mon,  5 Jan 2026 12:57:29 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 36/36] hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when
 I2CM_DMA_TX/RX_ADDR set first
Date: Mon,  5 Jan 2026 13:56:13 +0100
Message-ID: <20260105125613.622667-37-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In the previous design, the I2C model would update I2CC_DMA_LEN (0x54) based on
the value of I2CM_DMA_LEN (0x1C) when the firmware set either I2CM_DMA_TX_ADDR
(0x30) or I2CM_DMA_RX_ADDR (0x34). However, this only worked correctly if the
firmware set I2CM_DMA_LEN before setting I2CM_DMA_TX_ADDR or I2CM_DMA_RX_ADDR.

If the firmware instead set I2CM_DMA_TX_ADDR or I2CM_DMA_RX_ADDR before setting
I2CM_DMA_LEN, the value written to I2CC_DMA_LEN would be incorrect.

To fix this issue, the model should be updated to set I2CC_DMA_LEN when the
firmware writes to the I2CM_DMA_LEN register, rather than when it writes to the
I2CM_DMA_RX_ADDR and I2CM_DMA_TX_ADDR registers.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Fixes: ba2cccd64e90 ("aspeed: i2c: Add new mode support")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260102090746.1130033-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i2c/aspeed_i2c.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index faf2160c0670..1b8ac561c33b 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -656,8 +656,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
         bus->dma_dram_offset =
             deposit64(bus->dma_dram_offset, 0, 32,
                       FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));
-        bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs, I2CM_DMA_LEN,
-                                                     TX_BUF_LEN) + 1;
         break;
     case A_I2CM_DMA_RX_ADDR:
         bus->regs[R_I2CM_DMA_RX_ADDR] = FIELD_EX32(value, I2CM_DMA_RX_ADDR,
@@ -665,8 +663,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
         bus->dma_dram_offset =
             deposit64(bus->dma_dram_offset, 0, 32,
                       FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));
-        bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs, I2CM_DMA_LEN,
-                                                     RX_BUF_LEN) + 1;
         break;
     case A_I2CM_DMA_LEN:
         w1t = FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN_W1T) ||
@@ -679,10 +675,16 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
         if (FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN_W1T)) {
             ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN, RX_BUF_LEN,
                              FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN));
+            bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs,
+                                                         I2CM_DMA_LEN,
+                                                         RX_BUF_LEN) + 1;
         }
         if (FIELD_EX32(value, I2CM_DMA_LEN, TX_BUF_LEN_W1T)) {
             ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN, TX_BUF_LEN,
                              FIELD_EX32(value, I2CM_DMA_LEN, TX_BUF_LEN));
+            bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs,
+                                                         I2CM_DMA_LEN,
+                                                         TX_BUF_LEN) + 1;
         }
         break;
     case A_I2CM_DMA_LEN_STS:
-- 
2.52.0


