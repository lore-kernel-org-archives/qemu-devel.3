Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76C0C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNx-0002FR-88; Tue, 11 Aug 2026 12:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNk-0001fD-HV
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNi-0000lt-0H
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJJUzqn+NYdLPzZO7G4u2U0lVkccVFGFHPCSVRzYbzI=;
 b=Yaop2lBWlnUYTFB2kTQd94EXfmcn+1R1GbBd4hrQcR3NxeoPhtDKVCh349Wx6JiGKkJGnx
 hwrLjLflodMw4IHdDV6WvQESNPDhgxoR2Mi4JjvosxkUwGFyYhpNj9zprMi6gcvEc3ne9O
 iiJAWpw1x9v9cow83wM4Bc3ogKvq5KI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-VLjCF2N3NTy03u1cw4iH3Q-1; Tue,
 11 Aug 2026 12:31:09 -0400
X-MC-Unique: VLjCF2N3NTy03u1cw4iH3Q-1
X-Mimecast-MFC-AGG-ID: VLjCF2N3NTy03u1cw4iH3Q_1786465867
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 670151956040; Tue, 11 Aug 2026 16:31:07 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67CCA195DF91; Tue, 11 Aug 2026 16:31:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 39/83] hw/gpio: pca9552: use the Resettable interface instead
 of legacy reset
Date: Tue, 11 Aug 2026 18:28:54 +0200
Message-ID: <20260811162938.1403216-40-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

Convert the PCA9552 and PCA9535/PCA9555 reset handlers from the legacy
device reset hook to the Resettable interface: move each reset body into
a ResettableHoldPhase handler and register it through the class's
ResettableClass::phases.hold instead of device_class_set_legacy_reset().

No functional change.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-6-814575bc076b@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/gpio/pca9552.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 3b9b63eb1766..66f699bf6a0b 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -406,9 +406,9 @@ static const VMStateDescription pca9552_vmstate = {
     }
 };
 
-static void pca9552_reset(DeviceState *dev)
+static void pca9552_reset_hold(Object *obj, ResetType type)
 {
-    PCA955xState *s = PCA955X(dev);
+    PCA955xState *s = PCA955X(obj);
 
     s->regs[PCA9552_PSC0] = 0xFF;
     s->regs[PCA9552_PWM0] = 0x80;
@@ -426,9 +426,9 @@ static void pca9552_reset(DeviceState *dev)
     s->len = 0;
 }
 
-static void pca9535_reset(DeviceState *dev)
+static void pca9535_reset_hold(Object *obj, ResetType type)
 {
-    PCA955xState *s = PCA955X(dev);
+    PCA955xState *s = PCA955X(obj);
 
     s->regs[PCA9535_INPUT0] = 0xFF;   /* All inputs high (pull-ups) */
     s->regs[PCA9535_INPUT1] = 0xFF;   /* All inputs high (pull-ups) */
@@ -514,9 +514,10 @@ static void pca955x_class_init(ObjectClass *klass, const void *data)
 static void pca9552_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
     PCA955xClass *pc = PCA955X_CLASS(oc);
 
-    device_class_set_legacy_reset(dc, pca9552_reset);
+    rc->phases.hold = pca9552_reset_hold;
     dc->vmsd = &pca9552_vmstate;
     pc->max_reg = PCA9552_LS3;
     pc->pin_count = 16;
@@ -526,9 +527,10 @@ static void pca9552_class_init(ObjectClass *oc, const void *data)
 static void pca95x5_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
     PCA955xClass *pc = PCA955X_CLASS(oc);
 
-    device_class_set_legacy_reset(dc, pca9535_reset);
+    rc->phases.hold = pca9535_reset_hold;
     dc->vmsd = &pca9552_vmstate;
     pc->max_reg = PCA9535_CONFIG1;
     pc->pin_count = 16;
-- 
2.55.0


