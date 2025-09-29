Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2EBCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H8b-0003zg-83; Mon, 29 Sep 2025 12:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7W-0002qj-O4
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7U-0002mV-E3
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JsAKygJGiNk7d1ptcQRrUCTPNwgWjaOSaIyJuRLVUB4=;
 b=UuPcdka7WRcryKKaTq0xsvBQrkOSzN2XTDh706dmCI3iZlY7esCCZIs49hEOBW7mFeXiAM
 8xCfoIzXhUQwZnfqpEZ2Vn0g7D0jJWDzff/tDAW0SFkb9ZtQy1l8bWJ0z6xuva3xRHorSL
 XM4jUPYCpclvHfpFUmzmdKQjLTX9w04=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-g5G2lEclP8eNMP3B9sIHKA-1; Mon,
 29 Sep 2025 12:52:53 -0400
X-MC-Unique: g5G2lEclP8eNMP3B9sIHKA-1
X-Mimecast-MFC-AGG-ID: g5G2lEclP8eNMP3B9sIHKA_1759164772
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DAE718005BF; Mon, 29 Sep 2025 16:52:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5BD29180141C; Mon, 29 Sep 2025 16:52:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane-Chen-AS <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/32] hw/arm: Integrate ASPEED OTP memory support into AST1030
 SoCs
Date: Mon, 29 Sep 2025 18:52:04 +0200
Message-ID: <20250929165230.797471-7-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

The has_otp attribute is enabled in the SBC subclasses for AST1030 to
control the presence of OTP support per SoC type.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250812094011.2617526-7-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/misc/aspeed_sbc.h |  1 +
 hw/arm/aspeed_ast10x0.c      |  2 +-
 hw/misc/aspeed_sbc.c         | 16 ++++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
index 0c2746d392a4..7d640a022e4d 100644
--- a/include/hw/misc/aspeed_sbc.h
+++ b/include/hw/misc/aspeed_sbc.h
@@ -14,6 +14,7 @@
 
 #define TYPE_ASPEED_SBC "aspeed.sbc"
 #define TYPE_ASPEED_AST2600_SBC TYPE_ASPEED_SBC "-ast2600"
+#define TYPE_ASPEED_AST10X0_SBC TYPE_ASPEED_SBC "-ast10x0"
 OBJECT_DECLARE_TYPE(AspeedSBCState, AspeedSBCClass, ASPEED_SBC)
 
 #define ASPEED_SBC_NR_REGS (0x93c >> 2)
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index e6e1ee63c1c4..c446e70b24a9 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -154,7 +154,7 @@ static void aspeed_soc_ast1030_init(Object *obj)
 
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
 
-    object_initialize_child(obj, "sbc", &s->sbc, TYPE_ASPEED_SBC);
+    object_initialize_child(obj, "sbc", &s->sbc, TYPE_ASPEED_AST10X0_SBC);
 
     for (i = 0; i < sc->wdts_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index b56a8b767815..052c70fd422f 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -285,9 +285,25 @@ static const TypeInfo aspeed_ast2600_sbc_info = {
     .class_init = aspeed_ast2600_sbc_class_init,
 };
 
+static void aspeed_ast10x0_sbc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSBCClass *sc = ASPEED_SBC_CLASS(klass);
+
+    dc->desc = "AST10X0 Secure Boot Controller";
+    sc->has_otp = true;
+}
+
+static const TypeInfo aspeed_ast10x0_sbc_info = {
+    .name = TYPE_ASPEED_AST10X0_SBC,
+    .parent = TYPE_ASPEED_SBC,
+    .class_init = aspeed_ast10x0_sbc_class_init,
+};
+
 static void aspeed_sbc_register_types(void)
 {
     type_register_static(&aspeed_ast2600_sbc_info);
+    type_register_static(&aspeed_ast10x0_sbc_info);
     type_register_static(&aspeed_sbc_info);
 }
 
-- 
2.51.0


