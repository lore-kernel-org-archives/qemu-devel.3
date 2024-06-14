Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB2CC27C7B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 07:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI1Ln-0003Nx-9q; Fri, 14 Jun 2024 03:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1Lm-0003Kz-Ag
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1Lk-0000mi-4h
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718350071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vp7XFPXMEU1Dwul92dfTaHpOSahTq3QmMtYEQzsSdfk=;
 b=YJOwvJm/09NC8PF2TH4I5f0LxdOAUmi7+gMLMdfooOJBOHQCyq9J8XueEe+A1+CvqVP9Xq
 zQs3gTI8bW/JqkmslG7wy/Aud4IoXdDgKNvVPMPO+HvstCvUp2vGP+YKDbQTkPIG+NyNfk
 Y1ns79cX3cBMdlzckra0S86tGkUnxy0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-FbDwJRtGOXKtxsmsa2hXMQ-1; Fri,
 14 Jun 2024 03:27:47 -0400
X-MC-Unique: FbDwJRtGOXKtxsmsa2hXMQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3E84195608B; Fri, 14 Jun 2024 07:27:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FF943000222; Fri, 14 Jun 2024 07:27:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/19] aspeed/smc: support different memory region ops for SMC
 flash region
Date: Fri, 14 Jun 2024 09:26:11 +0200
Message-ID: <20240614072620.1262053-11-clg@redhat.com>
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

It set "aspeed_smc_flash_ops" struct which containing
read and write callbacks to be used when I/O is performed
on the SMC flash region. And it set the valid max_access_size 4
by default for all ASPEED SMC models.

However, the valid max_access_size 4 only support 32 bits CPUs.
To support all ASPEED SMC model, introduce a new
"const MemoryRegionOps *" attribute in AspeedSMCClass and
use it in aspeed_smc_flash_realize function.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ssi/aspeed_smc.h |  1 +
 hw/ssi/aspeed_smc.c         | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index d305ce2e2fea..234dca32b017 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -115,6 +115,7 @@ struct AspeedSMCClass {
                            AspeedSegments *seg);
     void (*dma_ctrl)(AspeedSMCState *s, uint32_t value);
     int (*addr_width)(const AspeedSMCState *s);
+    const MemoryRegionOps *reg_ops;
 };
 
 #endif /* ASPEED_SMC_H */
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index df0c63469cd7..129d06690d36 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -1316,7 +1316,7 @@ static void aspeed_smc_flash_realize(DeviceState *dev, Error **errp)
      * Use the default segment value to size the memory region. This
      * can be changed by FW at runtime.
      */
-    memory_region_init_io(&s->mmio, OBJECT(s), &aspeed_smc_flash_ops,
+    memory_region_init_io(&s->mmio, OBJECT(s), s->asc->reg_ops,
                           s, name, s->asc->segments[s->cs].size);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
 }
@@ -1391,6 +1391,7 @@ static void aspeed_2400_smc_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2400_smc_info = {
@@ -1441,6 +1442,7 @@ static void aspeed_2400_fmc_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2400_fmc_info = {
@@ -1480,6 +1482,7 @@ static void aspeed_2400_spi1_class_init(ObjectClass *klass, void *data)
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_smc_dma_ctrl;
     asc->addr_width        = aspeed_2400_spi1_addr_width;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2400_spi1_info = {
@@ -1525,6 +1528,7 @@ static void aspeed_2500_fmc_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2500_fmc_info = {
@@ -1560,6 +1564,7 @@ static void aspeed_2500_spi1_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2500_spi1_info = {
@@ -1595,6 +1600,7 @@ static void aspeed_2500_spi2_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2500_spi2_info = {
@@ -1682,6 +1688,7 @@ static void aspeed_2600_fmc_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2600_fmc_info = {
@@ -1721,6 +1728,7 @@ static void aspeed_2600_spi1_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2600_spi1_info = {
@@ -1761,6 +1769,7 @@ static void aspeed_2600_spi2_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_2600_spi2_info = {
@@ -1843,6 +1852,7 @@ static void aspeed_1030_fmc_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_1030_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_1030_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_1030_fmc_info = {
@@ -1881,6 +1891,7 @@ static void aspeed_1030_spi1_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_1030_spi1_info = {
@@ -1918,6 +1929,7 @@ static void aspeed_1030_spi2_class_init(ObjectClass *klass, void *data)
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_smc_flash_ops;
 }
 
 static const TypeInfo aspeed_1030_spi2_info = {
-- 
2.45.2


