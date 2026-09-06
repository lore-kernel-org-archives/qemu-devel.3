Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34567C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GP4-0003vM-HO; Sun, 06 Sep 2026 13:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOj-0003eY-2V
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOg-0000A0-1v
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X2PrVe493EMGdSxO3v8Caq4rq9errC1KHX92iVjNUlg=;
 b=O14Xj9mRtIMu0EYGnA9bY481HBwJQuWwlClwDduYWUqWv0t9TtJn6FsWBhnJBePPXOyGqt
 +830By5RiseJwCM8mjFzkG0SqMnlY8D1TgkYN+8/tgURtRVw64aa5ir32TGlcaStF1Xc7q
 XHOkuOLX2AOZTDJTaVinYSiwRcSARvc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-ps9antJ6Ppeg5EtxK8XPhw-1; Sun,
 06 Sep 2026 13:11:08 -0400
X-MC-Unique: ps9antJ6Ppeg5EtxK8XPhw-1
X-Mimecast-MFC-AGG-ID: ps9antJ6Ppeg5EtxK8XPhw_1788714667
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 473611801347; Sun,  6 Sep 2026 17:11:07 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D98E31955F06; Sun,  6 Sep 2026 17:11:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/40] hw/arm/aspeed_ast10x0: Wire SEC SRAM to the SBC model
Date: Sun,  6 Sep 2026 19:09:59 +0200
Message-ID: <20260906171021.26568-19-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Introduce the "has_ecdsa" class attribute and enable it for the AST10x0 SBC,
as ECDSA is only supported on this platform.

Add an "sram" link property to the SBC model and initialize a dedicated address
space for accessing the SEC SRAM. This will be used by the ECDSA verify command
to read the public key, signature, and digest from SRAM.

Wrap the SEC SRAM in a container mapped at offset 0. This allows the ECDSA
engine added in a later patch to access the SRAM using relative offsets without
requiring the SBC model to know the SRAM's system address.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260901085238.995968-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/misc/aspeed_sbc.h |  4 ++++
 hw/arm/aspeed_ast10x0.c      |  7 ++++++-
 hw/misc/aspeed_sbc.c         | 11 +++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
index eea6e2b27fbf..756c61235697 100644
--- a/include/hw/misc/aspeed_sbc.h
+++ b/include/hw/misc/aspeed_sbc.h
@@ -40,12 +40,16 @@ struct AspeedSBCState {
     uint32_t regs[ASPEED_SBC_NR_REGS];
 
     AspeedOTPState otp;
+
+    MemoryRegion *sram;
+    AddressSpace sram_as;
 };
 
 struct AspeedSBCClass {
     SysBusDeviceClass parent_class;
 
     bool has_otp;
+    bool has_ecdsa;
 };
 
 #endif /* ASPEED_SBC_H */
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 5165dcce5912..aeb5a4423dd3 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -250,8 +250,11 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
         error_propagate(errp, err);
         return false;
     }
+    memory_region_init(&s->sram_container[1], OBJECT(s), "sec.sram-container",
+                       sc->sram_size[1]);
+    memory_region_add_subregion(&s->sram_container[1], 0, &s->sram[1]);
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],
-                                &s->sram[1]);
+                                &s->sram_container[1]);
 
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
@@ -350,6 +353,8 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
     }
 
     /* Secure Boot Controller */
+    object_property_set_link(OBJECT(&s->sbc), "sram", OBJECT(&s->sram[1]),
+                             &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sbc), errp)) {
         return false;
     }
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index 7397d9bbf066..f10f7ac578d8 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -306,6 +306,14 @@ static void aspeed_sbc_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    if (sc->has_ecdsa) {
+        if (!s->sram) {
+            error_setg(errp, TYPE_ASPEED_SBC ": 'sram' link not set");
+            return;
+        }
+        address_space_init(&s->sram_as, s->sram, TYPE_ASPEED_SBC ".sram");
+    }
+
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sbc_ops, s,
             TYPE_ASPEED_SBC, ASPEED_SBC_NR_REGS << 2);
 
@@ -325,6 +333,8 @@ static const VMStateDescription vmstate_aspeed_sbc = {
 static const Property aspeed_sbc_properties[] = {
     DEFINE_PROP_BOOL("emmc-abr", AspeedSBCState, emmc_abr, 0),
     DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_settings, 0),
+    DEFINE_PROP_LINK("sram", AspeedSBCState, sram,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
 static void aspeed_sbc_class_init(ObjectClass *klass, const void *data)
@@ -355,6 +365,7 @@ static void aspeed_ast10x0_sbc_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "AST10X0 Secure Boot Controller";
     sc->has_otp = true;
+    sc->has_ecdsa = true;
 }
 
 static const TypeInfo aspeed_sbc_types[] = {
-- 
2.55.0


