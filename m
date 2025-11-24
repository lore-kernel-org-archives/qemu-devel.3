Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FF0CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 07:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNQe7-0001UZ-0R; Mon, 24 Nov 2025 02:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vNQdz-0001Sw-EA
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 02:05:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vNQds-00033R-Qj
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 02:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763967937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0nrqo0l7a0+DHkslT0OJMQGKNoPf5pW2H3yUVrG9lxc=;
 b=htALFhXuhmBM6cawAvyHay/BPuH1zVYOp49IXe3Z9BDZQT64JH7JR1eGPyXclXteDgIn55
 3da+lD467S9BthmXDPQ1SUFhqaC/r39T1kDF762vBFc7848tbWp5tB/UYNlZ2nUGXqMnIt
 GxkR2K/gogGK0RvhpvqX4UiqgYyH9zU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-PsYB1J3iNPug5uy6YYzXKA-1; Mon,
 24 Nov 2025 02:05:35 -0500
X-MC-Unique: PsYB1J3iNPug5uy6YYzXKA-1
X-Mimecast-MFC-AGG-ID: PsYB1J3iNPug5uy6YYzXKA_1763967934
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13FD51956067; Mon, 24 Nov 2025 07:05:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 461611800576; Mon, 24 Nov 2025 07:05:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 2/3] hw/arm/aspeed: Fix missing SPI IRQ connection causing DMA
 interrupt failure
Date: Mon, 24 Nov 2025 08:05:23 +0100
Message-ID: <20251124070524.240618-3-clg@redhat.com>
In-Reply-To: <20251124070524.240618-1-clg@redhat.com>
References: <20251124070524.240618-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.161,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

It did not connect SPI IRQ to the Interrupt Controller, so even the SPI
model raised the IRQ, the interrupt was not received. The CPU therefore
did not trigger an interrupt via the controller, and the firmware never
received the interrupt.

Fixes: 356b230ed13889e09d087a96498887de695df17e ("aspeed/soc: Add AST1030 support")
Fixes: f25c0ae1079dc0b9de02676eb3e3949a09df9f41 ("aspeed/soc: Add AST2600 support")
Fixes: 5dd883ab0635c9f715c77cc32622e458a0724581 ("aspeed/soc: Add AST2700 support")
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251106084925.1253704-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast10x0.c | 2 ++
 hw/arm/aspeed_ast2600.c | 2 ++
 hw/arm/aspeed_ast27x0.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 7f49c13391be..ca487774aeed 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -372,6 +372,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
                         sc->memmap[ASPEED_DEV_SPI1 + i]);
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 1,
                         ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
+                           aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_SPI1 + i));
     }
 
     /* Secure Boot Controller */
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 498d1ecc078b..4c5a42ea1742 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -557,6 +557,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                         sc->memmap[ASPEED_DEV_SPI1 + i]);
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 1,
                         ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
+                           aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_SPI1 + i));
     }
 
     /* EHCI */
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 1e6f4695382e..95f155fcf1ad 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -831,6 +831,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                         sc->memmap[ASPEED_DEV_SPI0 + i]);
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 1,
                         ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
+                           aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_SPI0 + i));
     }
 
     /* EHCI */
-- 
2.51.1


