Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C22CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn1b-0006gu-Co; Tue, 26 May 2026 04:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn1H-0005sG-1X
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:20:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn1F-0008CA-4m
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vxt9/kOpjBY3Tyx41ZaMqB7n8sh4/A1mKGT/vjjNipU=;
 b=XfXRWrBm48HR9iFFeSdwhvC6fBDt6jrKJjDXA3HYPPzkrwZLnGCSw3RVzadgyDvCg2u0FC
 +NRa+YdYXHTFL7u0fqWPozv/RpXpUsWoECKFfcgYoQ0e8cdESeWXGHq04yjXGPVEzZL1eM
 13mD+YF9+gdQ3/thQjYnttEhJ/Jyw8k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-xfH2I5WOPYyFKmL30q8jYA-1; Tue,
 26 May 2026 04:20:04 -0400
X-MC-Unique: xfH2I5WOPYyFKmL30q8jYA-1
X-Mimecast-MFC-AGG-ID: xfH2I5WOPYyFKmL30q8jYA_1779783603
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AAA61956061; Tue, 26 May 2026 08:20:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D0CE180056E; Tue, 26 May 2026 08:20:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 33/37] hw/net/ftgmac100: convert to use Resettable interface
Date: Tue, 26 May 2026 10:18:44 +0200
Message-ID: <20260526081848.651835-34-clg@redhat.com>
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
Link: https://lore.kernel.org/qemu-devel/20260525044129.3133916-20-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/ftgmac100.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index b3da48c343c7..2bec817b9dec 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -723,9 +723,9 @@ static void ftgmac100_do_reset(FTGMAC100State *s, bool sw_reset)
     phy_reset(s);
 }
 
-static void ftgmac100_reset(DeviceState *d)
+static void ftgmac100_reset_hold(Object *obj, ResetType type)
 {
-    ftgmac100_do_reset(FTGMAC100(d), false);
+    ftgmac100_do_reset(FTGMAC100(obj), false);
 }
 
 static uint64_t ftgmac100_read(void *opaque, hwaddr addr, unsigned size)
@@ -1269,9 +1269,10 @@ static const Property ftgmac100_properties[] = {
 static void ftgmac100_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->vmsd = &vmstate_ftgmac100;
-    device_class_set_legacy_reset(dc, ftgmac100_reset);
+    rc->phases.hold = ftgmac100_reset_hold;
     device_class_set_props(dc, ftgmac100_properties);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     dc->realize = ftgmac100_realize;
@@ -1387,9 +1388,9 @@ static const MemoryRegionOps aspeed_mii_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void aspeed_mii_reset(DeviceState *dev)
+static void aspeed_mii_reset_hold(Object *obj, ResetType type)
 {
-    AspeedMiiState *s = ASPEED_MII(dev);
+    AspeedMiiState *s = ASPEED_MII(obj);
 
     s->phycr = 0;
     s->phydata = 0;
@@ -1428,9 +1429,10 @@ static const Property aspeed_mii_properties[] = {
 static void aspeed_mii_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->vmsd = &vmstate_aspeed_mii;
-    device_class_set_legacy_reset(dc, aspeed_mii_reset);
+    rc->phases.hold = aspeed_mii_reset_hold;
     dc->realize = aspeed_mii_realize;
     dc->desc = "Aspeed MII controller";
     device_class_set_props(dc, aspeed_mii_properties);
-- 
2.54.0


