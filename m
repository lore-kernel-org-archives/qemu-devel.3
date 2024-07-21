Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D671C3DA5D
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2024 08:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVRiX-0001Tc-Vl; Sun, 21 Jul 2024 04:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVRi8-0000ms-7R
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 04:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVRi6-0001Oh-KI
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 04:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721549665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6a+j5V3g9hTmvqUKCI9FPfeErHidAjcSZgZGxJJbt/k=;
 b=CFyzvVpwGjNLQPRV4j5/aD/PNs82VusjOsoG4IRb7zRRRO+FzLaAbj+nt5YOMhWFK3t6Zx
 69jARNB/NCzKzdPxRIejAvc/T+siGFCS3g1aoDiGZWhHyzs4bnihgHFBKGFJduu6SqodS4
 DmuTRIdS39qpyxjZM60457Xk6cK2TAI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-LFBta79oMN2P-bXiio1jqg-1; Sun,
 21 Jul 2024 04:14:19 -0400
X-MC-Unique: LFBta79oMN2P-bXiio1jqg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DDC81955D42; Sun, 21 Jul 2024 08:14:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.37])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 11F7A1955D4D; Sun, 21 Jul 2024 08:14:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/15] aspeed: Introduce a AspeedSoCClass 'boot_from_emmc'
 handler
Date: Sun, 21 Jul 2024 10:13:51 +0200
Message-ID: <20240721081401.425588-6-clg@redhat.com>
In-Reply-To: <20240721081401.425588-1-clg@redhat.com>
References: <20240721081401.425588-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cédric Le Goater <clg@kaod.org>

Report support on the AST2600 SoC if the boot-from-eMMC HW strapping
bit is set at the board level. AST2700 also has support but it is not
yet ready in QEMU and others SoCs do not have support, so return false
always for these.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 31713de74a5f..be3eb70cdd77 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -646,6 +646,13 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static bool aspeed_soc_ast2600_boot_from_emmc(AspeedSoCState *s)
+{
+    uint32_t hw_strap1 = object_property_get_uint(OBJECT(&s->scu),
+                                                  "hw-strap1", &error_abort);
+    return !!(hw_strap1 & SCU_AST2600_HW_STRAP_BOOT_SRC_EMMC);
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


