Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99C4C79F8D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vck8q-0003zT-UB; Mon, 05 Jan 2026 07:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8M-0003kx-P5
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8K-0007uo-So
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=horSo4GLaZE0t3/vJOGkQfg7YC1r8kXsbkI/7d+A1SU=;
 b=eOSf4rlLzON4EkmSvT+DZVlzXtJPWipazVASAiSYK+Fjz+iCZ46fYJCeXaPYwGry/Fxwpk
 GOAMine/hLnmqIsCEAGmlcC9lNjv3ALaaDzxTUlCMbiCwTiYH2OJTgyZ6W6l6OmEra56aI
 KhTCitkdlTmgAZJczmBsoU8nh/iz3RY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-duO7CqV4OgCTFhxnL5GUIw-1; Mon,
 05 Jan 2026 07:56:26 -0500
X-MC-Unique: duO7CqV4OgCTFhxnL5GUIw-1
X-Mimecast-MFC-AGG-ID: duO7CqV4OgCTFhxnL5GUIw_1767617785
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A447E195DE56; Mon,  5 Jan 2026 12:56:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3129919560A7; Mon,  5 Jan 2026 12:56:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/36] hw/arm/aspeed_ast10x0: Add common init function for
 AST10x0 SoCs
Date: Mon,  5 Jan 2026 13:55:41 +0100
Message-ID: <20260105125613.622667-5-clg@redhat.com>
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

Introduce a new common initialization function
aspeed_soc_ast10x0_init() for AST10x0 series SoCs. This separates the
shared initialization logic from the AST1030-specific part, allowing
reuse by future SoCs such as AST1060.

The AST1060 does not include the LPC and PECI models, so the common
initializer is used for all shared modules, while
aspeed_soc_ast1030_init() adds initialization of LPC and PECI, which
are unique to AST1030.

This refactor improves code reuse and prepares the codebase for
supporting the AST1060 platform.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251112030553.291734-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast10x0.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index f923b9505b78..1dd1a95ea5bd 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -107,7 +107,7 @@ static qemu_irq aspeed_soc_ast1030_get_irq(AspeedSoCState *s, int dev)
     return qdev_get_gpio_in(DEVICE(&a->armv7m), sc->irqmap[dev]);
 }
 
-static void aspeed_soc_ast1030_init(Object *obj)
+static void aspeed_soc_ast10x0_init(Object *obj)
 {
     Aspeed10x0SoCState *a = ASPEED10X0_SOC(obj);
     AspeedSoCState *s = ASPEED_SOC(obj);
@@ -150,10 +150,6 @@ static void aspeed_soc_ast1030_init(Object *obj)
         object_initialize_child(obj, "spi[*]", &s->spi[i], typename);
     }
 
-    object_initialize_child(obj, "lpc", &s->lpc, TYPE_ASPEED_LPC);
-
-    object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
-
     object_initialize_child(obj, "sbc", &s->sbc, TYPE_ASPEED_AST10X0_SBC);
 
     for (i = 0; i < sc->wdts_num; i++) {
@@ -185,6 +181,15 @@ static void aspeed_soc_ast1030_init(Object *obj)
                             TYPE_UNIMPLEMENTED_DEVICE);
 }
 
+static void aspeed_soc_ast1030_init(Object *obj)
+{
+    AspeedSoCState *s = ASPEED_SOC(obj);
+
+    aspeed_soc_ast10x0_init(obj);
+    object_initialize_child(obj, "lpc", &s->lpc, TYPE_ASPEED_LPC);
+    object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
+}
+
 static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
 {
     Aspeed10x0SoCState *a = ASPEED10X0_SOC(dev_soc);
-- 
2.52.0


