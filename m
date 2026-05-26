Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C596CD5BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn1e-00070Z-R3; Tue, 26 May 2026 04:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn1K-0005ye-OH
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:20:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn1H-0008Cl-Kp
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81yuRk5BTo2jsqkuZt7x9ZDYXxHHocOZ3uwomcAb0Wk=;
 b=U4Uje5/pAdq8mqy2NQTf12SPPRTaoHZtshnD08/Hf6b78jmMiI6pN+wcKqETUcMfnOzTol
 MPxX+rx0HdjnEhsffFGk7nYrG0kqQt1PmMKt/DvSlVOwFopd9eGZ5D7OWOtLmkXz7A//zT
 N9BjePx+a1azZ6u5TigTMc+2bk/8Kvk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-pie4UaOnPGWiwfvG17yCFg-1; Tue,
 26 May 2026 04:20:06 -0400
X-MC-Unique: pie4UaOnPGWiwfvG17yCFg-1
X-Mimecast-MFC-AGG-ID: pie4UaOnPGWiwfvG17yCFg_1779783605
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CC6219560B7; Tue, 26 May 2026 08:20:05 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD3D1180056E; Tue, 26 May 2026 08:20:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 34/37] hw/fsi/aspeed_apb2opb: convert to use Resettable
 interface
Date: Tue, 26 May 2026 10:18:45 +0200
Message-ID: <20260526081848.651835-35-clg@redhat.com>
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
Link: https://lore.kernel.org/qemu-devel/20260525044129.3133916-21-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/fsi/aspeed_apb2opb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/fsi/aspeed_apb2opb.c b/hw/fsi/aspeed_apb2opb.c
index 058abc86452d..f2d9a9669ada 100644
--- a/hw/fsi/aspeed_apb2opb.c
+++ b/hw/fsi/aspeed_apb2opb.c
@@ -302,9 +302,9 @@ static void fsi_aspeed_apb2opb_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void fsi_aspeed_apb2opb_reset(DeviceState *dev)
+static void fsi_aspeed_apb2opb_reset_hold(Object *obj, ResetType type)
 {
-    AspeedAPB2OPBState *s = ASPEED_APB2OPB(dev);
+    AspeedAPB2OPBState *s = ASPEED_APB2OPB(obj);
 
     memcpy(s->regs, aspeed_apb2opb_reset, ASPEED_APB2OPB_NR_REGS);
 }
@@ -312,10 +312,11 @@ static void fsi_aspeed_apb2opb_reset(DeviceState *dev)
 static void fsi_aspeed_apb2opb_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->desc = "ASPEED APB2OPB Bridge";
     dc->realize = fsi_aspeed_apb2opb_realize;
-    device_class_set_legacy_reset(dc, fsi_aspeed_apb2opb_reset);
+    rc->phases.hold = fsi_aspeed_apb2opb_reset_hold;
 }
 
 static const TypeInfo aspeed_apb2opb_info = {
-- 
2.54.0


