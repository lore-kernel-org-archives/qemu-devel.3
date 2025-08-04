Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D07C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 11:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uitET-0000Lp-K9; Mon, 04 Aug 2025 07:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uiswl-0007PN-DN
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 07:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uiswh-0008Il-Fd
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 07:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754305291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uh4Pu4qORzVpObvVonRmF6kJnPZFMmhhlUmq5DIoVtU=;
 b=OVpW2hkbjIsQmO7uALIUhcCV2Aluk7Q/KCi1VW9y0hRYkZLOOSwVU2lMaoNwrRGqknlPq5
 h4ogfLMfFjIanVvxgEg2En/I2xrS2wZUmG//Il9KaMiPT+NYnX5vSVhekXg7rluDx9vX3k
 cebVDdJFGqcXN2E+RDG7vQjk19zVVG8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-6s_TaA_oMT2cTAeZoUzKGw-1; Mon,
 04 Aug 2025 07:01:28 -0400
X-MC-Unique: 6s_TaA_oMT2cTAeZoUzKGw-1
X-Mimecast-MFC-AGG-ID: 6s_TaA_oMT2cTAeZoUzKGw_1754305287
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60D2519373DF; Mon,  4 Aug 2025 11:01:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.225])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 986EA1800359; Mon,  4 Aug 2025 11:01:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 4/4] hw/ssi/aspeed_smc: Fix incorrect FMC_WDT2 register read on
 AST1030
Date: Mon,  4 Aug 2025 13:01:08 +0200
Message-ID: <20250804110108.2414355-5-clg@redhat.com>
In-Reply-To: <20250804110108.2414355-1-clg@redhat.com>
References: <20250804110108.2414355-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On AST1030, reading the FMC_WDT2 register always returns 0xFFFFFFFF.
This issue is due to the aspeed_smc_read function, which checks for the
ASPEED_SMC_FEATURE_WDT_CONTROL feature. Since AST1030 was missing this
feature flag, the read operation fails and returns -1.

To resolve this, add the WDT_CONTROL feature to AST1030's feature set
so that FMC_WDT2 can be correctly accessed by firmware.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Fixes: 2850df6a81bcdc2e063dfdd56751ee2d11c58030 ("aspeed/smc: Add AST1030 support ")
Link: https://lore.kernel.org/qemu-devel/20250804014633.512737-1-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/ssi/aspeed_smc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 614528b8ef65..e33496f50298 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -1857,7 +1857,8 @@ static void aspeed_1030_fmc_class_init(ObjectClass *klass, const void *data)
     asc->resets            = aspeed_1030_fmc_resets;
     asc->flash_window_base = 0x80000000;
     asc->flash_window_size = 0x10000000;
-    asc->features          = ASPEED_SMC_FEATURE_DMA;
+    asc->features          = ASPEED_SMC_FEATURE_DMA |
+                             ASPEED_SMC_FEATURE_WDT_CONTROL;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x000BFFFC;
     asc->dma_start_length  = 1;
-- 
2.50.1


