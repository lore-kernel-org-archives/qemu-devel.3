Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA78CC88E58
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52UG-0003ts-AO; Fri, 11 Sep 2026 10:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52O1-0002yL-Iw
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52Nz-0008Od-Oo
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntaO5zXCqDIHHnqqZoaRC9y/DkKQ0xZ5Zjqm3Fkdzdk=;
 b=a4fa3EzGTzJWjM9IMlui601na6ITNk72RsVqn5dpsMzeLRPXSaZJgOaKEj6nGqnzFb8EPX
 JI/XcKEy4SNYQKwA0AhaIGBTYsRWAySLXFPDeIQHNWlE+mzVbnAQJl71Wcqqg+6wjBYgFY
 1MQHXv0ncstqpWdVCutDesBH56nO5sY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-yBd4u00wMKm-TAHlAmivtQ-1; Fri,
 11 Sep 2026 10:37:49 -0400
X-MC-Unique: yBd4u00wMKm-TAHlAmivtQ-1
X-Mimecast-MFC-AGG-ID: yBd4u00wMKm-TAHlAmivtQ_1789137468
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07F5B1944F0D; Fri, 11 Sep 2026 14:37:31 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D1A6300022B; Fri, 11 Sep 2026 14:37:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 27/28] hw/input: mark PS/2 and PC Keyboard devices as secure
Date: Fri, 11 Sep 2026 15:36:26 +0100
Message-ID: <20260911143627.2743803-28-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These are part of the baseline x86 featureset so required for
virtualization use cases.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/input/pckbd.c | 3 ++-
 hw/input/ps2.c   | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index b09c3bce93..0250252cd6 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -766,7 +766,8 @@ static const TypeInfo i8042_mmio_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_init = i8042_mmio_init,
     .instance_size = sizeof(MMIOKBDState),
-    .class_init    = i8042_mmio_class_init
+    .class_init    = i8042_mmio_class_init,
+    .secure        = true,
 };
 
 void i8042_isa_mouse_fake_event(ISAKBDState *isa)
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 01af4350b3..8588f39f99 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -1293,7 +1293,8 @@ static const TypeInfo ps2_kbd_info = {
     .name          = TYPE_PS2_KBD_DEVICE,
     .parent        = TYPE_PS2_DEVICE,
     .instance_size = sizeof(PS2KbdState),
-    .class_init    = ps2_kbd_class_init
+    .class_init    = ps2_kbd_class_init,
+    .secure        = true,
 };
 
 static void ps2_mouse_class_init(ObjectClass *klass, const void *data)
@@ -1313,7 +1314,8 @@ static const TypeInfo ps2_mouse_info = {
     .name          = TYPE_PS2_MOUSE_DEVICE,
     .parent        = TYPE_PS2_DEVICE,
     .instance_size = sizeof(PS2MouseState),
-    .class_init    = ps2_mouse_class_init
+    .class_init    = ps2_mouse_class_init,
+    .secure        = true,
 };
 
 static void ps2_init(Object *obj)
@@ -1340,7 +1342,8 @@ static const TypeInfo ps2_info = {
     .instance_size = sizeof(PS2State),
     .class_init    = ps2_class_init,
     .class_size    = sizeof(PS2DeviceClass),
-    .abstract      = true
+    .abstract      = true,
+    .secure        = true,
 };
 
 static void ps2_register_types(void)
-- 
2.55.0


