Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6585C79F8C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vck8p-0003yl-37; Mon, 05 Jan 2026 07:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8V-0003qS-If
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8T-0007xH-Q3
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQdfds82YWsuOCtG/9BPJjNBteIfOpdB0/SQ8I8VXh0=;
 b=cmMHlKe6Dd0Mm+YF1XSQuhgmPw+1iEEdusGHHApT0AIHtHSZiEQjS1LRzMR3VELgtjVi9J
 CA6o4e1SnhXGRbF9lJHMV0FVMC1fMFD3XtkExapqvXgl92EUNvLYDi32Cn0y8uWOUziQs2
 v8SMzlDlzUgmJ6MCRpUXz8eVKffj9KY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-rLfj2uUYMd2howopUlBjyw-1; Mon,
 05 Jan 2026 07:56:34 -0500
X-MC-Unique: rLfj2uUYMd2howopUlBjyw-1
X-Mimecast-MFC-AGG-ID: rLfj2uUYMd2howopUlBjyw_1767617793
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A28CE195605A; Mon,  5 Jan 2026 12:56:33 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F2C9E19560A7; Mon,  5 Jan 2026 12:56:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/36] hw/arm/aspeed_ast10x0_evb: Add AST1060 EVB machine
 support
Date: Mon,  5 Jan 2026 13:55:45 +0100
Message-ID: <20260105125613.622667-9-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Add a new machine definition ast1060-evb to support the Aspeed AST1060
evaluation board. The new EVB reuses the same MiniBMC framework used by
AST1030, as both SoCs share the same core peripherals and controller
designs.

The AST1060 EVB machine initializes the ast1060-a2 SoC and sets the
FMC and SPI flash models (w25q80bl and w25q02jvm) for simulation.
This enables QEMU to boot and emulate firmware images for AST1060-based
platforms.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251112030553.291734-10-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast10x0_evb.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/arm/aspeed_ast10x0_evb.c b/hw/arm/aspeed_ast10x0_evb.c
index 329578a542c3..c19563d1f0a6 100644
--- a/hw/arm/aspeed_ast10x0_evb.c
+++ b/hw/arm/aspeed_ast10x0_evb.c
@@ -96,12 +96,35 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
+static void aspeed_minibmc_machine_ast1060_evb_class_init(ObjectClass *oc,
+                                                          const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc = "Aspeed AST1060 Platform Root of Trust (Cortex-M4)";
+    amc->soc_name = "ast1060-a2";
+    amc->hw_strap1 = 0;
+    amc->hw_strap2 = 0;
+    mc->init = aspeed_minibmc_machine_init;
+    amc->fmc_model = "w25q80bl";
+    amc->spi_model = "w25q02jvm";
+    amc->num_cs = 2;
+    amc->macs_mask = 0;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+
 static const TypeInfo aspeed_ast10x0_evb_types[] = {
     {
         .name           = MACHINE_TYPE_NAME("ast1030-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
         .interfaces     = arm_machine_interfaces,
+    }, {
+        .name           = MACHINE_TYPE_NAME("ast1060-evb"),
+        .parent         = TYPE_ASPEED_MACHINE,
+        .class_init     = aspeed_minibmc_machine_ast1060_evb_class_init,
+        .interfaces     = arm_machine_interfaces,
     }
 };
 
-- 
2.52.0


