Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4F2F47CA3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCww-0006yc-Rz; Thu, 05 Mar 2026 12:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCwu-0006x8-2F
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:57:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCws-0003Tr-0X
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mKePMXJ23K95Z+XGzEiwD/uekCNOWTuhbyJ3uK6SLdg=;
 b=Rz9ecnumQ3+IJ3/r8gzcqrW5I+IvOyPLGHgFkJsS7big9X+I0SeZCE0GMfrpUVDA/Sw+mq
 utIO/l+KBxv32N/S1OsiOtPVxm/zyzzCupiSm9LGoECwsCfUjLdCcThEwFIteEXzORqWyi
 Nxgvw5rxy3uJcEkU79Fb6HWWjbDi2Ug=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-EvCFO36yN0OmmYuH8489Gg-1; Thu,
 05 Mar 2026 12:57:18 -0500
X-MC-Unique: EvCFO36yN0OmmYuH8489Gg-1
X-Mimecast-MFC-AGG-ID: EvCFO36yN0OmmYuH8489Gg_1772733437
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0229E1956063; Thu,  5 Mar 2026 17:57:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C2B23003E9E; Thu,  5 Mar 2026 17:57:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/38] hw/i2c/aspeed_i2c: Fix DMA64 address handling
Date: Thu,  5 Mar 2026 18:56:34 +0100
Message-ID: <20260305175711.1119025-2-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
References: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The current code updates the upper 32 bits of dma_dram_offset only when
aic->has_dma64 is false, which is incorrect.

If aic->has_dma64 is true, the controller supports 64-bit DMA addressing
and the upper 32-bit DMA address register must be used to update the
dma_dram_offset accordingly.

Fix the condition so that the upper 32 bits are updated only when
64-bit DMA is supported.

Fixes: efea7ddb4689a1ac4bce63a9ddb32887c7f3ac50 ("hw/i2c/aspeed_i2c: Fix DMA moving data into incorrect address")
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260224073207.985162-1-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i2c/aspeed_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 122bfdd63dca..8022938f3478 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -237,7 +237,7 @@ static void aspeed_i2c_set_tx_dma_dram_offset(AspeedI2CBus *bus)
         bus->dma_dram_offset =
             deposit64(bus->dma_dram_offset, 0, 32,
                       FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));
-        if (!aic->has_dma64) {
+        if (aic->has_dma64) {
             value = bus->regs[R_I2CM_DMA_TX_ADDR_HI];
             bus->dma_dram_offset =
                 deposit64(bus->dma_dram_offset, 32, 32,
@@ -262,7 +262,7 @@ static void aspeed_i2c_set_rx_dma_dram_offset(AspeedI2CBus *bus)
         bus->dma_dram_offset =
             deposit64(bus->dma_dram_offset, 0, 32,
                       FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));
-        if (!aic->has_dma64) {
+        if (aic->has_dma64) {
             value = bus->regs[R_I2CM_DMA_RX_ADDR_HI];
             bus->dma_dram_offset =
                 deposit64(bus->dma_dram_offset, 32, 32,
-- 
2.53.0


