Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D85C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 05:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFA3-00026x-Ao; Thu, 04 Jul 2024 01:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sPFA0-00025Q-Tp
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 01:37:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sPF9m-000265-IB
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 01:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720071440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQ8pPLsA2U4GOR20i08dOOTuN9SdSmfKeBZJg0VyaHo=;
 b=in8+EBKk3vshlIg/AetAeIIqb6C4jaIqx9I7UbXmymCp+LZxR0ZuTv1oTmV7c9NAtNNmZi
 C6/DzwkMFUJRCtZb46R4ZMs5ytx0G1OrBV7QhxvL3Z1GEQHcfc6qE+4/Lm3wUcnmnFP7WV
 3UB5ndx8WN5uFQNAeIWfwo/r4uHY+Zc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-shSEDPyfPx2GYHfl7Rxctg-1; Thu,
 04 Jul 2024 01:37:17 -0400
X-MC-Unique: shSEDPyfPx2GYHfl7Rxctg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3FDF1956095; Thu,  4 Jul 2024 05:37:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.90])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31C6D195607C; Thu,  4 Jul 2024 05:37:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 4/8] aspeed: Introduce a AspeedSoCClass 'boot_from_emmc'
 handler
Date: Thu,  4 Jul 2024 07:36:47 +0200
Message-ID: <20240704053651.1100732-5-clg@redhat.com>
In-Reply-To: <20240704053651.1100732-1-clg@redhat.com>
References: <20240704053651.1100732-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Cédric Le Goater <clg@kaod.org>

Report support on the AST2600 SoC if the boot-from-eMMC HW strapping
bit is set at the board level. AST2700 also has support but it is not
yet ready in QEMU and others SoCs do not have support, so return false
always for these.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h | 1 +
 hw/arm/aspeed_ast2600.c     | 8 ++++++++
 hw/arm/aspeed_soc_common.c  | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 849ba37f9524..624d489e0d63 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -164,6 +164,7 @@ struct AspeedSoCClass {
     const hwaddr *memmap;
     uint32_t num_cpus;
     qemu_irq (*get_irq)(AspeedSoCState *s, int dev);
+    bool (*boot_from_emmc)(AspeedSoCState *s);
 };
 
 const char *aspeed_soc_cpu_type(AspeedSoCClass *sc);
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 31713de74a5f..8114e7f2759f 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -646,6 +646,13 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static bool aspeed_soc_ast2600_boot_from_emmc(AspeedSoCState *s)
+{
+    uint32_t hw_strap1 = object_property_get_uint(OBJECT(&s->scu),
+                                                  "hw-strap1", &error_abort);
+    return !!(hw_strap1 & AST2600_HW_STRAP_BOOT_SRC_EMMC);
+}
+
 static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
 {
     static const char * const valid_cpu_types[] = {
@@ -673,6 +680,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
     sc->memmap       = aspeed_soc_ast2600_memmap;
     sc->num_cpus     = 2;
     sc->get_irq      = aspeed_soc_ast2600_get_irq;
+    sc->boot_from_emmc = aspeed_soc_ast2600_boot_from_emmc;
 }
 
 static const TypeInfo aspeed_soc_ast2600_types[] = {
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 1e8f2558fdc2..05551461aea0 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -134,6 +134,11 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static bool aspeed_soc_boot_from_emmc(AspeedSoCState *s)
+{
+    return false;
+}
+
 static Property aspeed_soc_properties[] = {
     DEFINE_PROP_LINK("dram", AspeedSoCState, dram_mr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
@@ -145,9 +150,11 @@ static Property aspeed_soc_properties[] = {
 static void aspeed_soc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
+    AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
 
     dc->realize = aspeed_soc_realize;
     device_class_set_props(dc, aspeed_soc_properties);
+    sc->boot_from_emmc = aspeed_soc_boot_from_emmc;
 }
 
 static const TypeInfo aspeed_soc_types[] = {
-- 
2.45.2


