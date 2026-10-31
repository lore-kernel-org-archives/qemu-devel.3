Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8E606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 06:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gapmn6nC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN33C-0002bJ-Us; Sat, 31 Oct 2026 02:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN339-0002aT-Fg
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN337-0002ip-DB
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j094ml0S1ipsv002siEeI0NiCCX0dkt23HRSNQM7/5A=;
 b=gapmn6nCB/v+yu00CZb3Pw02YnBTi2ZTRkxcGturO9o601LguuuFHDRQ40+XcuurojPI3N
 c86cQ+ylo72kDbI4qpgVBvvI36V8lr2nSF5TvgCfQxNGmP6zyf7djxrVENjJsS3IyyBA/F
 k9wPHiELxXD7rbV1Z/Ydf/FNx4EIvYA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-z24g3huwOL-GEr1YGgmxlQ-1; Sat,
 31 Oct 2026 02:58:40 -0400
X-MC-Unique: z24g3huwOL-GEr1YGgmxlQ-1
X-Mimecast-MFC-AGG-ID: z24g3huwOL-GEr1YGgmxlQ_1793429919
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BD29180049D; Sat, 31 Oct 2026 06:58:39 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76B381800677; Sat, 31 Oct 2026 06:58:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/34] hw/ssi/aspeed_smc: Fix AST2700 DMA flash address mask
Date: Sat, 31 Oct 2026 07:57:51 +0100
Message-ID: <20261031065823.191966-3-clg@redhat.com>
In-Reply-To: <20261031065823.191966-1-clg@redhat.com>
References: <20261031065823.191966-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jamin Lin <jamin_lin@aspeedtech.com>

The DMA flash address register (SPI084) holds the offset of the
flash access within the controller's flash window. The AST2700 FMC,
SPI0 and SPI1 controllers use a dma_flash_mask of 0x2FFFFFFC, which
clears bit 28, and SPI2 uses 0x0FFFFFFC, which limits DMA to the
first 256MB of the window.

With the default segment layout, FMC CS2 is mapped at offset
0x10000000. A DMA read from that offset is masked to 0x0 and returns
data from CS0 instead of CS2.

The Linux driver programs SPI084 with the window offset masked by
0x7fffffff, so bit 28 is a valid address bit.

Set dma_flash_mask to 0x3FFFFFFC for all AST2700 controllers to cover
the full 1GB flash window.

Fixes: bdb3748dba30 ("aspeed/smc: Add AST2700 support")
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261028023154.48395-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/ssi/aspeed_smc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 10ea9e5aa063..c0c3666dbca3 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -1952,7 +1952,7 @@ static void aspeed_2700_fmc_class_init(ObjectClass *klass, const void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA |
                              ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |
                              ASPEED_SMC_FEATURE_DATA_FIFO;
-    asc->dma_flash_mask    = 0x2FFFFFFC;
+    asc->dma_flash_mask    = 0x3FFFFFFC;
     asc->dma_dram_mask     = 0xFFFFFFFC;
     asc->dma_start_length  = 1;
     asc->nregs             = (0x200 + (asc->cs_num_max * 0x10)) >> 2;
@@ -1989,7 +1989,7 @@ static void aspeed_2700_spi0_class_init(ObjectClass *klass, const void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA |
                              ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |
                              ASPEED_SMC_FEATURE_DATA_FIFO;
-    asc->dma_flash_mask    = 0x2FFFFFFC;
+    asc->dma_flash_mask    = 0x3FFFFFFC;
     asc->dma_dram_mask     = 0xFFFFFFFC;
     asc->dma_start_length  = 1;
     asc->nregs             = (0x200 + (asc->cs_num_max * 0x10)) >> 2;
@@ -2025,7 +2025,7 @@ static void aspeed_2700_spi1_class_init(ObjectClass *klass, const void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA |
                              ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |
                              ASPEED_SMC_FEATURE_DATA_FIFO;
-    asc->dma_flash_mask    = 0x2FFFFFFC;
+    asc->dma_flash_mask    = 0x3FFFFFFC;
     asc->dma_dram_mask     = 0xFFFFFFFC;
     asc->dma_start_length  = 1;
     asc->nregs             = (0x200 + (asc->cs_num_max * 0x10)) >> 2;
@@ -2061,7 +2061,7 @@ static void aspeed_2700_spi2_class_init(ObjectClass *klass, const void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA |
                              ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |
                              ASPEED_SMC_FEATURE_DATA_FIFO;
-    asc->dma_flash_mask    = 0x0FFFFFFC;
+    asc->dma_flash_mask    = 0x3FFFFFFC;
     asc->dma_dram_mask     = 0xFFFFFFFC;
     asc->dma_start_length  = 1;
     asc->nregs             = (0x200 + (asc->cs_num_max * 0x10)) >> 2;
-- 
2.56.0


