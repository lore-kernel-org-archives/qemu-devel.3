Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A541AC28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trH4h-0007m7-1t; Sun, 09 Mar 2025 09:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH4f-0007kw-Ge
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH4e-0002SV-1h
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741528330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sOhQftDZDNfv3s0xjv7CgxsqjZzoP7D7rwlNh2ARdHA=;
 b=atGAXRZtkn1s8ZADDbnTEEQTFqtRR4+dzYGBLv2hLI8tEXE0KC/0ZSVo1QcliyA5+iHYYz
 sUz0eDSkeo5Sf0XWr+3dXs1ZI0wFVIvlEt9lEcfZrc1I7sLGl1xp2I5i+I8KrK4e5S9iHH
 3raHxKpWRdE6mm18Nj+vFszzZCOcFso=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-o-I3mc6yPfyhLlJMRdaEDg-1; Sun,
 09 Mar 2025 09:52:08 -0400
X-MC-Unique: o-I3mc6yPfyhLlJMRdaEDg-1
X-Mimecast-MFC-AGG-ID: o-I3mc6yPfyhLlJMRdaEDg_1741528327
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE783180035D; Sun,  9 Mar 2025 13:52:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96B3B1956094; Sun,  9 Mar 2025 13:52:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nabih Estefan <nabihestefan@google.com>
Subject: [PULL 12/46] hw/misc/aspeed_scu: Skipping dram_init in u-boot
Date: Sun,  9 Mar 2025 14:50:56 +0100
Message-ID: <20250309135130.545764-13-clg@redhat.com>
In-Reply-To: <20250309135130.545764-1-clg@redhat.com>
References: <20250309135130.545764-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Setting BIT6 in VGA0 SCRATCH register will indicate that the ddr traning
is done, therefore skipping the u-boot-spl dram_init() process.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>
Link: https://lore.kernel.org/qemu-devel/20250304064710.2128993-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_scu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index bac1441b061a..50f74fbabd6e 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -157,6 +157,7 @@
 #define AST2700_SCU_FREQ_CNTR       TO_REG(0x3b0)
 #define AST2700_SCU_CPU_SCRATCH_0   TO_REG(0x780)
 #define AST2700_SCU_CPU_SCRATCH_1   TO_REG(0x784)
+#define AST2700_SCU_VGA_SCRATCH_0   TO_REG(0x900)
 
 #define AST2700_SCUIO_CLK_STOP_CTL_1    TO_REG(0x240)
 #define AST2700_SCUIO_CLK_STOP_CLR_1    TO_REG(0x244)
@@ -930,6 +931,7 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] = {
     [AST2700_SCU_FREQ_CNTR]         = 0x000375eb,
     [AST2700_SCU_CPU_SCRATCH_0]     = 0x00000000,
     [AST2700_SCU_CPU_SCRATCH_1]     = 0x00000004,
+    [AST2700_SCU_VGA_SCRATCH_0]     = 0x00000040,
 };
 
 static void aspeed_ast2700_scu_reset(DeviceState *dev)
-- 
2.48.1


