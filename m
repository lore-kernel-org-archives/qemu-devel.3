Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BD1CD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn1c-0006lz-Cx; Tue, 26 May 2026 04:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn1D-0005ps-Qf
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:20:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn1A-000894-UI
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZIgNaP/z4JcrQB/kcoUTBVDabVpUlUR46Tv7Yeawvs=;
 b=dio7TLUlvunQ7YijCRnhLZ1NXDUDx0I8NQM+VxQxBAL7iDXM8IKnkyYOKsuRdxYBR3pEpg
 tscG8nZOVS8prsPGPnQUWT6OsmLBBWfeJVGxSUWM2V0zPRQpWDtm9ipT9G6/gkm0EaggaO
 a4gHXcFxeq4ObmViByj8jBXQm0BW1Tc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-ORDEsMSsM-epRHQj92L46Q-1; Tue,
 26 May 2026 04:20:00 -0400
X-MC-Unique: ORDEsMSsM-epRHQj92L46Q-1
X-Mimecast-MFC-AGG-ID: ORDEsMSsM-epRHQj92L46Q_1779783599
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE2DF19560B4; Tue, 26 May 2026 08:19:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1EC7B1800357; Tue, 26 May 2026 08:19:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 31/37] hw/i3c/aspeed_i3c: convert to use Resettable interface
Date: Tue, 26 May 2026 10:18:42 +0200
Message-ID: <20260526081848.651835-32-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Link: https://lore.kernel.org/qemu-devel/20260525044129.3133916-18-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i3c/aspeed_i3c.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c
index bac8c55bb091..de61d67dfdee 100644
--- a/hw/i3c/aspeed_i3c.c
+++ b/hw/i3c/aspeed_i3c.c
@@ -162,9 +162,9 @@ I3CBus *aspeed_i3c_get_bus(AspeedI3CState *s, uint8_t bus_num)
     g_assert_not_reached();
 }
 
-static void aspeed_i3c_reset(DeviceState *dev)
+static void aspeed_i3c_reset_hold(Object *obj, ResetType type)
 {
-    AspeedI3CState *s = ASPEED_I3C(dev);
+    AspeedI3CState *s = ASPEED_I3C(obj);
     memset(s->regs, 0, sizeof(s->regs));
 }
 
@@ -238,9 +238,10 @@ static const VMStateDescription vmstate_aspeed_i3c = {
 static void aspeed_i3c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->realize = aspeed_i3c_realize;
-    device_class_set_legacy_reset(dc, aspeed_i3c_reset);
+    rc->phases.hold = aspeed_i3c_reset_hold;
     dc->desc = "Aspeed I3C Controller";
     dc->vmsd = &vmstate_aspeed_i3c;
 }
-- 
2.54.0


