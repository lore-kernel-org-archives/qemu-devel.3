Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BC8EEA85A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 21:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqeQD-0008E9-Of; Thu, 12 Feb 2026 16:40:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQB-0008CG-3u
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQ9-000688-8s
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770932420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kzNIMoMsZQLW9k2rl05Uvtl5Z3XBb7ZfckzwPkttOsg=;
 b=Q2Rn2ctWGe3VBm1I9VzhM3vfSJ18a6M8NFbQrRz/cWR3veG1O2zsHIViAIOcTgaYYe4Y3J
 LmpuQ3HoBiIyFo+71a80LOciLvzypsQCyt3EXYwOMM4cYO9V15gyAKT09E4Qd5f+NPXd50
 kJHXSo+J/LLyTb/Nb+l0toqU0BRoX6g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-E8WzIMWTNPmMExCZNc_XdA-1; Thu,
 12 Feb 2026 16:40:18 -0500
X-MC-Unique: E8WzIMWTNPmMExCZNc_XdA-1
X-Mimecast-MFC-AGG-ID: E8WzIMWTNPmMExCZNc_XdA_1770932417
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11BD71800465; Thu, 12 Feb 2026 21:40:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A7C71800670; Thu, 12 Feb 2026 21:40:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nabih Estefan <nabihestefan@google.com>
Subject: [PULL 08/16] hw/arm/aspeed_ast27x0: Add AST2700 A2 SoC support
Date: Thu, 12 Feb 2026 22:39:47 +0100
Message-ID: <20260212213955.2225662-9-clg@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

AST2700 A2 is functionally identical to AST2700 A1.
There are no changes to the IRQ layout, memory map, or peripheral
configuration. The only difference is the silicon revision.

This commit introduces a dedicated AST2700 A2 SoC type by reusing
the existing AST2700 A1 implementation and setting the A2 silicon
revision accordingly.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>
Link: https://lore.kernel.org/qemu-devel/20260211021527.119674-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 61790ea1cc2b..87dcb82e1b01 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -1166,6 +1166,36 @@ static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
     sc->memmap       = aspeed_soc_ast2700_memmap;
 }
 
+static void aspeed_soc_ast2700a2_class_init(ObjectClass *oc, const void *data)
+{
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a35"),
+        NULL
+    };
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
+
+    /* Reason: The Aspeed SoC can only be instantiated from a board */
+    dc->user_creatable = false;
+    dc->realize      = aspeed_soc_ast2700_realize;
+
+    sc->valid_cpu_types = valid_cpu_types;
+    sc->silicon_rev  = AST2700_A2_SILICON_REV;
+    sc->sram_size    = 0x20000;
+    sc->pcie_num     = 3;
+    sc->spis_num     = 3;
+    sc->sgpio_num    = 2;
+    sc->ehcis_num    = 4;
+    sc->wdts_num     = 8;
+    sc->macs_num     = 3;
+    sc->uarts_num    = 13;
+    sc->num_cpus     = 4;
+    sc->ioexp_num    = 2;
+    sc->uarts_base   = ASPEED_DEV_UART0;
+    sc->irqmap       = aspeed_soc_ast2700a1_irqmap;
+    sc->memmap       = aspeed_soc_ast2700_memmap;
+}
+
 static const TypeInfo aspeed_soc_ast27x0_types[] = {
     {
         .name           = TYPE_ASPEED27X0_SOC,
@@ -1179,6 +1209,12 @@ static const TypeInfo aspeed_soc_ast27x0_types[] = {
         .instance_init  = aspeed_soc_ast2700_init,
         .class_init     = aspeed_soc_ast2700a1_class_init,
     },
+    {
+        .name           = "ast2700-a2",
+        .parent         = TYPE_ASPEED27X0_SOC,
+        .instance_init  = aspeed_soc_ast2700_init,
+        .class_init     = aspeed_soc_ast2700a2_class_init,
+    },
 };
 
 DEFINE_TYPES(aspeed_soc_ast27x0_types)
-- 
2.53.0


