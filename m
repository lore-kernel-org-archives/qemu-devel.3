Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AE8C2BA12
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 07:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI1Ll-0003KC-SD; Fri, 14 Jun 2024 03:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1Lk-0003JF-RV
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1Li-0000mV-Vl
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718350070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XP/iTr/BVBIoYxsQ+3kqlBLFtRaXOsgv0fgawDKkxnQ=;
 b=Qy20UWxXqc4u/sjj9x/Jf9HkP84bqYdzDgrkQn/LdnkSY0zfqFf2+TA3AN/aNUX0zW2jEX
 sxTz+3CQVCaptRCWtz/oIM9GlQuVaFdG+uD6xqNBNBYWszphMnmkJoG1fhY1CrD2I86mZu
 tAoxLyzA3mkMUe0x00qQ4f/cMIiAuzk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-2Rry6W_pNuSvUUD65gRb2Q-1; Fri,
 14 Jun 2024 03:27:43 -0400
X-MC-Unique: 2Rry6W_pNuSvUUD65gRb2Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B65B41956094; Fri, 14 Jun 2024 07:27:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE9743000219; Fri, 14 Jun 2024 07:27:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/19] aspeed/smc: support dma start length and 1 byte length
 unit
Date: Fri, 14 Jun 2024 09:26:09 +0200
Message-ID: <20240614072620.1262053-9-clg@redhat.com>
In-Reply-To: <20240614072620.1262053-1-clg@redhat.com>
References: <20240614072620.1262053-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

DMA length is from 1 byte to 32MB for AST2600 and AST10x0
and DMA length is from 4 bytes to 32MB for AST2500.

In other words, if "R_DMA_LEN" is 0, it should move at least 1 byte
data for AST2600 and AST10x0 and 4 bytes data for AST2500.
To support all ASPEED SOCs, adds dma_start_length parameter to store
the start length, add helper routines function to compute the dma length
and update DMA_LENGTH mask to "1FFFFFF" to support dma 1 byte
length unit for AST2600 and AST1030.
Currently, only supports dma length 4 bytes aligned.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ssi/aspeed_smc.h |  1 +
 hw/ssi/aspeed_smc.c         | 43 ++++++++++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 8791cc0ecb11..d305ce2e2fea 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -107,6 +107,7 @@ struct AspeedSMCClass {
     uint32_t features;
     hwaddr dma_flash_mask;
     hwaddr dma_dram_mask;
+    uint32_t dma_start_length;
     uint32_t nregs;
     uint32_t (*segment_to_reg)(const AspeedSMCState *s,
                                const AspeedSegments *seg);
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index fe1cd96b803a..0b8488a113db 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -178,13 +178,17 @@
  * DMA flash addresses should be 4 bytes aligned and the valid address
  * range is 0x20000000 - 0x2FFFFFFF.
  *
- * DMA length is from 4 bytes to 32MB
+ * DMA length is from 4 bytes to 32MB (AST2500)
  *   0: 4 bytes
- *   0x7FFFFF: 32M bytes
+ *   0x1FFFFFC: 32M bytes
+ *
+ * DMA length is from 1 byte to 32MB (AST2600, AST10x0)
+ *   0: 1 byte
+ *   0x1FFFFFF: 32M bytes
  */
 #define DMA_DRAM_ADDR(asc, val)   ((val) & (asc)->dma_dram_mask)
 #define DMA_FLASH_ADDR(asc, val)  ((val) & (asc)->dma_flash_mask)
-#define DMA_LENGTH(val)         ((val) & 0x01FFFFFC)
+#define DMA_LENGTH(val)         ((val) & 0x01FFFFFF)
 
 /* Flash opcodes. */
 #define SPI_OP_READ       0x03    /* Read data bytes (low frequency) */
@@ -843,6 +847,13 @@ static bool aspeed_smc_inject_read_failure(AspeedSMCState *s)
     }
 }
 
+static uint32_t aspeed_smc_dma_len(AspeedSMCState *s)
+{
+    AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
+
+    return QEMU_ALIGN_UP(s->regs[R_DMA_LEN] + asc->dma_start_length, 4);
+}
+
 /*
  * Accumulate the result of the reads to provide a checksum that will
  * be used to validate the read timing settings.
@@ -850,6 +861,7 @@ static bool aspeed_smc_inject_read_failure(AspeedSMCState *s)
 static void aspeed_smc_dma_checksum(AspeedSMCState *s)
 {
     MemTxResult result;
+    uint32_t dma_len;
     uint32_t data;
 
     if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
@@ -861,7 +873,9 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
         aspeed_smc_dma_calibration(s);
     }
 
-    while (s->regs[R_DMA_LEN]) {
+    dma_len = aspeed_smc_dma_len(s);
+
+    while (dma_len) {
         data = address_space_ldl_le(&s->flash_as, s->regs[R_DMA_FLASH_ADDR],
                                     MEMTXATTRS_UNSPECIFIED, &result);
         if (result != MEMTX_OK) {
@@ -877,7 +891,8 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
          */
         s->regs[R_DMA_CHECKSUM] += data;
         s->regs[R_DMA_FLASH_ADDR] += 4;
-        s->regs[R_DMA_LEN] -= 4;
+        dma_len -= 4;
+        s->regs[R_DMA_LEN] = dma_len;
     }
 
     if (s->inject_failure && aspeed_smc_inject_read_failure(s)) {
@@ -889,14 +904,17 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
 static void aspeed_smc_dma_rw(AspeedSMCState *s)
 {
     MemTxResult result;
+    uint32_t dma_len;
     uint32_t data;
 
+    dma_len = aspeed_smc_dma_len(s);
+
     trace_aspeed_smc_dma_rw(s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE ?
                             "write" : "read",
                             s->regs[R_DMA_FLASH_ADDR],
                             s->regs[R_DMA_DRAM_ADDR],
-                            s->regs[R_DMA_LEN]);
-    while (s->regs[R_DMA_LEN]) {
+                            dma_len);
+    while (dma_len) {
         if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
             data = address_space_ldl_le(&s->dram_as, s->regs[R_DMA_DRAM_ADDR],
                                         MEMTXATTRS_UNSPECIFIED, &result);
@@ -937,7 +955,8 @@ static void aspeed_smc_dma_rw(AspeedSMCState *s)
          */
         s->regs[R_DMA_FLASH_ADDR] += 4;
         s->regs[R_DMA_DRAM_ADDR] += 4;
-        s->regs[R_DMA_LEN] -= 4;
+        dma_len -= 4;
+        s->regs[R_DMA_LEN] = dma_len;
         s->regs[R_DMA_CHECKSUM] += data;
     }
 }
@@ -1382,6 +1401,7 @@ static void aspeed_2400_fmc_class_init(ObjectClass *klass, void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x1FFFFFFC;
+    asc->dma_start_length  = 4;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
@@ -1465,6 +1485,7 @@ static void aspeed_2500_fmc_class_init(ObjectClass *klass, void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x3FFFFFFC;
+    asc->dma_start_length  = 4;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
@@ -1621,6 +1642,7 @@ static void aspeed_2600_fmc_class_init(ObjectClass *klass, void *data)
                              ASPEED_SMC_FEATURE_WDT_CONTROL;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x3FFFFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
@@ -1659,6 +1681,7 @@ static void aspeed_2600_spi1_class_init(ObjectClass *klass, void *data)
                              ASPEED_SMC_FEATURE_DMA_GRANT;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x3FFFFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
@@ -1698,6 +1721,7 @@ static void aspeed_2600_spi2_class_init(ObjectClass *klass, void *data)
                              ASPEED_SMC_FEATURE_DMA_GRANT;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x3FFFFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
@@ -1779,6 +1803,7 @@ static void aspeed_1030_fmc_class_init(ObjectClass *klass, void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x000BFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_1030_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_1030_smc_reg_to_segment;
@@ -1816,6 +1841,7 @@ static void aspeed_1030_spi1_class_init(ObjectClass *klass, void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x000BFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
@@ -1852,6 +1878,7 @@ static void aspeed_1030_spi2_class_init(ObjectClass *klass, void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x000BFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
-- 
2.45.2


