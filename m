Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C51FFEA837
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 08:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5K1I-0007wx-Dq; Wed, 25 Mar 2026 04:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1w5K1F-0007wk-5s; Wed, 25 Mar 2026 04:55:17 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1w5K1C-0006oc-L9; Wed, 25 Mar 2026 04:55:16 -0400
X-UUID: 4a012f24282811f1a21c59e7364eecb8-20260325
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:ee45a32f-ffaf-4bcd-9921-75d2f085acbc, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:33daf92fbfd1b051932e3f78995da9a0,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
 3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
 V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4a012f24282811f1a21c59e7364eecb8-20260325
X-User: zhaoguohan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1648777527; Wed, 25 Mar 2026 16:54:53 +0800
From: GuoHan Zhao <zhaoguohan@kylinos.cn>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: [PATCH] hw/i2c/aspeed_i2c: reset and migrate pending_intr_sts
Date: Wed, 25 Mar 2026 16:54:50 +0800
Message-ID: <20260325085450.126595-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Commit 7e82393ed058 ("hw/i2c/aspeed: fix lost interrupts on
back-to-back commands") introduced pending_intr_sts to preserve
interrupt bits that collide with already pending status bits.

That deferred interrupt state is consumed later when the guest clears
INTR_STS, but it is not reset in aspeed_i2c_bus_reset() and it is not
part of the bus migration state. A reset can therefore leave stale
deferred bits behind, and migration can silently drop them.

Clear pending_intr_sts on reset and include it in VMState while keeping
compatibility with older migration streams.

Fixes: 7e82393ed058 ("hw/i2c/aspeed: fix lost interrupts on back-to-back commands")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 hw/i2c/aspeed_i2c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 5d18f8d49ea4..90f83a03fd4f 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1134,10 +1134,11 @@ static const MemoryRegionOps aspeed_i2c_bus_pool_ops = {
 
 static const VMStateDescription aspeed_i2c_bus_vmstate = {
     .name = TYPE_ASPEED_I2C,
-    .version_id = 6,
+    .version_id = 7,
     .minimum_version_id = 6,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedI2CBus, ASPEED_I2C_NEW_NUM_REG),
+        VMSTATE_UINT32_V(pending_intr_sts, AspeedI2CBus, 7),
         VMSTATE_UINT8_ARRAY(pool, AspeedI2CBus, ASPEED_I2C_BUS_POOL_SIZE),
         VMSTATE_UINT64(dma_dram_offset, AspeedI2CBus),
         VMSTATE_END_OF_LIST()
@@ -1510,6 +1511,7 @@ static void aspeed_i2c_bus_reset(DeviceState *dev)
     AspeedI2CBus *s = ASPEED_I2C_BUS(dev);
 
     memset(s->regs, 0, sizeof(s->regs));
+    s->pending_intr_sts = 0;
     i2c_end_transfer(s->bus);
 }
 
-- 
2.43.0


