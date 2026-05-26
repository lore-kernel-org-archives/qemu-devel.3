Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51127CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn15-0005ev-6t; Tue, 26 May 2026 04:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0l-0005VH-PY
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0j-0007wE-UP
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62fXpGFEzN7ecT2Aa1RSAiGPJvlFQxz9MHAABa6W9Rg=;
 b=MLFqbPNA5Xz+t9qz7hvP5to5bLAdvKCK7h9/lFTMXEhnOicD4lwnOpZyrnru+mu0RxovC/
 HpKOR4dIG3BxBWyoHwkLudi1Q+ve8z4omqTvgIptuanAaesD0RIcxTALD3YrCIcdVKQ9oY
 4bxI3qxCoSeKA1hInjYWOJzRdkHTaTk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-1ei3KDQoOZeZnV-8glxpNg-1; Tue,
 26 May 2026 04:19:33 -0400
X-MC-Unique: 1ei3KDQoOZeZnV-8glxpNg-1
X-Mimecast-MFC-AGG-ID: 1ei3KDQoOZeZnV-8glxpNg_1779783572
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 430CE19560B2; Tue, 26 May 2026 08:19:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85A5E1800577; Tue, 26 May 2026 08:19:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/37] hw/misc/aspeed_xdma: convert to use Resettable interface
Date: Tue, 26 May 2026 10:18:30 +0200
Message-ID: <20260526081848.651835-20-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Kane Chen <kane_chen@aspeedtech.com>

Replace the legacy reset callback registered via
device_class_set_legacy_reset() with the Resettable interface.

Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260525044129.3133916-6-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_xdma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
index 3e2beafcedfb..80b32593336c 100644
--- a/hw/misc/aspeed_xdma.c
+++ b/hw/misc/aspeed_xdma.c
@@ -129,9 +129,9 @@ static void aspeed_xdma_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &xdma->iomem);
 }
 
-static void aspeed_xdma_reset(DeviceState *dev)
+static void aspeed_xdma_reset_hold(Object *obj, ResetType type)
 {
-    AspeedXDMAState *xdma = ASPEED_XDMA(dev);
+    AspeedXDMAState *xdma = ASPEED_XDMA(obj);
     AspeedXDMAClass *axc = ASPEED_XDMA_GET_CLASS(xdma);
 
     xdma->bmc_cmdq_readp_set = 0;
@@ -220,9 +220,10 @@ static const TypeInfo aspeed_2400_xdma_info = {
 static void aspeed_xdma_class_init(ObjectClass *classp, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(classp);
+    ResettableClass *rc = RESETTABLE_CLASS(classp);
 
     dc->realize = aspeed_xdma_realize;
-    device_class_set_legacy_reset(dc, aspeed_xdma_reset);
+    rc->phases.hold = aspeed_xdma_reset_hold;
     dc->vmsd = &aspeed_xdma_vmstate;
 }
 
-- 
2.54.0


