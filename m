Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D653CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn0z-0005am-Bk; Tue, 26 May 2026 04:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0r-0005WW-2G
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0p-0007yb-CX
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gb28ja1ucqIZVYvC5RV6pk6ujAMhjB1kNORkPPT5Yj8=;
 b=B0I3PENQkWaPxk/JyJmryj3nIsfuhmONr9kRdu+e8hmOdmBWnDl92GWvYC8C4Ffgl2LaMm
 qImZaZyHv3yl8aiL6j99M52SRiLHZ/I4PZ8eQRxFIfwP0QgMZe9yfRSXOOBD0oDkHriTKP
 Z+5hsafhVvg8wAT6a5D1XLWbud882Ak=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-xXNHSh02MaaMk3GrVTgoLA-1; Tue,
 26 May 2026 04:19:37 -0400
X-MC-Unique: xXNHSh02MaaMk3GrVTgoLA-1
X-Mimecast-MFC-AGG-ID: xXNHSh02MaaMk3GrVTgoLA_1779783576
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8F0718005B8; Tue, 26 May 2026 08:19:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E96FA1800357; Tue, 26 May 2026 08:19:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/37] hw/misc/aspeed_sdmc: convert to use Resettable interface
Date: Tue, 26 May 2026 10:18:32 +0200
Message-ID: <20260526081848.651835-22-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Link: https://lore.kernel.org/qemu-devel/20260525044129.3133916-8-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_sdmc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 59b4a9a42647..055abf7f50f0 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -199,9 +199,9 @@ static const MemoryRegionOps aspeed_sdmc_ops = {
     .valid.max_access_size = 4,
 };
 
-static void aspeed_sdmc_reset(DeviceState *dev)
+static void aspeed_sdmc_reset_hold(Object *obj, ResetType type)
 {
-    AspeedSDMCState *s = ASPEED_SDMC(dev);
+    AspeedSDMCState *s = ASPEED_SDMC(obj);
     AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
 
     memset(s->regs, 0, sizeof(s->regs));
@@ -302,8 +302,9 @@ static const Property aspeed_sdmc_properties[] = {
 static void aspeed_sdmc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     dc->realize = aspeed_sdmc_realize;
-    device_class_set_legacy_reset(dc, aspeed_sdmc_reset);
+    rc->phases.hold = aspeed_sdmc_reset_hold;
     dc->desc = "ASPEED SDRAM Memory Controller";
     dc->vmsd = &vmstate_aspeed_sdmc;
     device_class_set_props(dc, aspeed_sdmc_properties);
@@ -560,9 +561,9 @@ static const TypeInfo aspeed_2600_sdmc_info = {
     .class_init = aspeed_2600_sdmc_class_init,
 };
 
-static void aspeed_2700_sdmc_reset(DeviceState *dev)
+static void aspeed_2700_sdmc_reset_hold(Object *obj, ResetType type)
 {
-    AspeedSDMCState *s = ASPEED_SDMC(dev);
+    AspeedSDMCState *s = ASPEED_SDMC(obj);
     AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
 
     memset(s->regs, 0, sizeof(s->regs));
@@ -676,10 +677,11 @@ static const uint64_t
 static void aspeed_2700_sdmc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
 
     dc->desc = "ASPEED 2700 SDRAM Memory Controller";
-    device_class_set_legacy_reset(dc, aspeed_2700_sdmc_reset);
+    rc->phases.hold = aspeed_2700_sdmc_reset_hold;
 
     asc->is_bus64bit = true;
     asc->max_ram_size = 8 * GiB;
-- 
2.54.0


