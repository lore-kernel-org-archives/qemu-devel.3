Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCE0C27C77
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 07:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI1LO-00039w-LB; Fri, 14 Jun 2024 03:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1LN-00039f-GD
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1LL-0000jp-T8
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718350045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGFz00sOMUVuWd2OQ1tTLKSKBb3ZvhqhnSttbL2LqJc=;
 b=DyldFP4qTJ8KLm5fxnYGmm1MFvEN4R6d5Dgl8WAVu6IQ54qLkaLjVYRLSk/fkhIW0IRibQ
 N6/qSkZS4DdG2VJLNy3Nd87QM83IlXgMSNMjmzVJUJ0UIlvr+6LYrCUlYjlbenQ+JSYEOf
 hOe8O5d3ybQcq5Bgn+vwkD8sbHSogy8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-07hMO7kWOwSXBowTwymhZA-1; Fri,
 14 Jun 2024 03:27:21 -0400
X-MC-Unique: 07hMO7kWOwSXBowTwymhZA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C02AA19560B8; Fri, 14 Jun 2024 07:27:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C08FE300021A; Fri, 14 Jun 2024 07:27:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PULL 01/19] aspeed/smc: Reintroduce "dram-base" property for AST2700
Date: Fri, 14 Jun 2024 09:26:02 +0200
Message-ID: <20240614072620.1262053-2-clg@redhat.com>
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

The Aspeed SMC device model use to have a 'sdram_base' property. It
was removed by commit d177892d4a48 ("aspeed/smc: Remove unused
"sdram-base" property") because previous changes simplified the DMA
transaction model to use an offset in RAM and not the physical
address.

The AST2700 SoC has larger address space (64-bit) and a new register
DMA DRAM Side Address High Part (0x7C) is introduced to deal with the
high bits of the DMA address. To be able to compute the offset of the
DMA transaction, as done on the other SoCs, we will need to know where
the DRAM is mapped in the address space. Re-introduce a "dram-base"
property to hold this value.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ssi/aspeed_smc.h | 1 +
 hw/ssi/aspeed_smc.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 8e1dda556b91..8791cc0ecb11 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -76,6 +76,7 @@ struct AspeedSMCState {
     AddressSpace flash_as;
     MemoryRegion *dram_mr;
     AddressSpace dram_as;
+    uint64_t     dram_base;
 
     AspeedSMCFlash flashes[ASPEED_SMC_CS_MAX];
 
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 6e1a84c19713..7075bc9d61b0 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -1220,6 +1220,7 @@ static const VMStateDescription vmstate_aspeed_smc = {
 
 static Property aspeed_smc_properties[] = {
     DEFINE_PROP_BOOL("inject-failure", AspeedSMCState, inject_failure, false),
+    DEFINE_PROP_UINT64("dram-base", AspeedSMCState, dram_base, 0),
     DEFINE_PROP_LINK("dram", AspeedSMCState, dram_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.45.2


