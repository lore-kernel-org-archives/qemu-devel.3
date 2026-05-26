Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A42CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn19-0005jX-4v; Tue, 26 May 2026 04:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0u-0005XL-8k
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0r-0007yw-3U
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xpWglAaYDX5VZ5D1owjf88VBRiED1GxTE8Bt/hsgKDU=;
 b=K8qREpatwSereLn0VGNRtn/rtXAiwAeR6tjXq9TGKYVOiCbKdE0ZD7oNgJ04j0U1CNCoQr
 YeiOqNWSJuCmu3kiaA39FquzHIrX+uv6FaFjurOFfBNWpbsF/BM79lcCa8XSayZx0Kfyud
 ZaLszY759CiSKQuKj1MjV2pa4BInqOA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-6Gc6MrdvP4aj4CjsQFz3Bg-1; Tue,
 26 May 2026 04:19:40 -0400
X-MC-Unique: 6Gc6MrdvP4aj4CjsQFz3Bg-1
X-Mimecast-MFC-AGG-ID: 6Gc6MrdvP4aj4CjsQFz3Bg_1779783579
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB62A18002F0; Tue, 26 May 2026 08:19:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 278BE1800267; Tue, 26 May 2026 08:19:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/37] hw/misc/aspeed_scu: convert to use Resettable interface
Date: Tue, 26 May 2026 10:18:33 +0200
Message-ID: <20260526081848.651835-23-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Link: https://lore.kernel.org/qemu-devel/20260525044129.3133916-9-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_scu.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index c9b73a114805..19da6c075fae 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -542,10 +542,10 @@ static uint32_t aspeed_2600_scu_calc_hpll(AspeedSCUState *s, uint32_t hpll_reg)
     return clkin * multiplier;
 }
 
-static void aspeed_scu_reset(DeviceState *dev)
+static void aspeed_scu_reset_hold(Object *obj, ResetType type)
 {
-    AspeedSCUState *s = ASPEED_SCU(dev);
-    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(dev);
+    AspeedSCUState *s = ASPEED_SCU(obj);
+    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(obj);
 
     memcpy(s->regs, asc->resets, asc->nr_regs * 4);
     s->regs[SILICON_REV] = s->silicon_rev;
@@ -616,8 +616,9 @@ static const Property aspeed_scu_properties[] = {
 static void aspeed_scu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     dc->realize = aspeed_scu_realize;
-    device_class_set_legacy_reset(dc, aspeed_scu_reset);
+    rc->phases.hold = aspeed_scu_reset_hold;
     dc->desc = "ASPEED System Control Unit";
     dc->vmsd = &vmstate_aspeed_scu;
     device_class_set_props(dc, aspeed_scu_properties);
@@ -822,10 +823,10 @@ static const uint32_t ast2600_a3_resets[ASPEED_AST2600_SCU_NR_REGS] = {
     [AST2600_CHIP_ID1]          = 0x88884444,
 };
 
-static void aspeed_ast2600_scu_reset(DeviceState *dev)
+static void aspeed_ast2600_scu_reset_hold(Object *obj, ResetType type)
 {
-    AspeedSCUState *s = ASPEED_SCU(dev);
-    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(dev);
+    AspeedSCUState *s = ASPEED_SCU(obj);
+    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(obj);
 
     memcpy(s->regs, asc->resets, asc->nr_regs * 4);
 
@@ -844,10 +845,11 @@ static void aspeed_ast2600_scu_reset(DeviceState *dev)
 static void aspeed_2600_scu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
 
     dc->desc = "ASPEED 2600 System Control Unit";
-    device_class_set_legacy_reset(dc, aspeed_ast2600_scu_reset);
+    rc->phases.hold = aspeed_ast2600_scu_reset_hold;
     asc->resets = ast2600_a3_resets;
     asc->calc_hpll = aspeed_2600_scu_calc_hpll;
     asc->get_apb = aspeed_2600_scu_get_apb_freq;
@@ -950,10 +952,10 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] = {
     [AST2700_SCU_VGA_SCRATCH_0]     = 0x00000040,
 };
 
-static void aspeed_ast2700_scu_reset(DeviceState *dev)
+static void aspeed_ast2700_scu_reset_hold(Object *obj, ResetType type)
 {
-    AspeedSCUState *s = ASPEED_SCU(dev);
-    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(dev);
+    AspeedSCUState *s = ASPEED_SCU(obj);
+    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(obj);
 
     memcpy(s->regs, asc->resets, asc->nr_regs * 4);
     s->regs[AST2700_SILICON_REV] = s->silicon_rev;
@@ -963,10 +965,11 @@ static void aspeed_ast2700_scu_reset(DeviceState *dev)
 static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
 
     dc->desc = "ASPEED 2700 System Control Unit";
-    device_class_set_legacy_reset(dc, aspeed_ast2700_scu_reset);
+    rc->phases.hold = aspeed_ast2700_scu_reset_hold;
     asc->resets = ast2700_a0_resets;
     asc->calc_hpll = aspeed_2600_scu_calc_hpll;
     asc->get_apb = aspeed_2700_scu_get_apb_freq;
@@ -1082,10 +1085,11 @@ static const uint32_t ast2700_a0_resets_io[ASPEED_AST2700_SCU_NR_REGS] = {
 static void aspeed_2700_scuio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
 
     dc->desc = "ASPEED 2700 System Control Unit I/O";
-    device_class_set_legacy_reset(dc, aspeed_ast2700_scu_reset);
+    rc->phases.hold = aspeed_ast2700_scu_reset_hold;
     asc->resets = ast2700_a0_resets_io;
     asc->calc_hpll = aspeed_2600_scu_calc_hpll;
     asc->get_apb = aspeed_2700_scuio_get_apb_freq;
@@ -1123,10 +1127,10 @@ static const uint32_t ast1030_a1_resets[ASPEED_AST2600_SCU_NR_REGS] = {
     [AST2600_CHIP_ID1]          = 0x0BADCAFE,
 };
 
-static void aspeed_ast1030_scu_reset(DeviceState *dev)
+static void aspeed_ast1030_scu_reset_hold(Object *obj, ResetType type)
 {
-    AspeedSCUState *s = ASPEED_SCU(dev);
-    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(dev);
+    AspeedSCUState *s = ASPEED_SCU(obj);
+    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(obj);
 
     memcpy(s->regs, asc->resets, asc->nr_regs * 4);
 
@@ -1140,10 +1144,11 @@ static void aspeed_ast1030_scu_reset(DeviceState *dev)
 static void aspeed_1030_scu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
 
     dc->desc = "ASPEED 1030 System Control Unit";
-    device_class_set_legacy_reset(dc, aspeed_ast1030_scu_reset);
+    rc->phases.hold = aspeed_ast1030_scu_reset_hold;
     asc->resets = ast1030_a1_resets;
     asc->calc_hpll = aspeed_2600_scu_calc_hpll;
     asc->get_apb = aspeed_1030_scu_get_apb_freq;
-- 
2.54.0


