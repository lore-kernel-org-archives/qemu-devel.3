Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8853F606BDFF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JcvbfkkC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwFs-0008CT-9O; Fri, 13 Nov 2026 13:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwFX-0007Yn-Nh
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwFV-0005Sf-EQ
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794595424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AhY1Ul04wOAeLuH+FICgn5g0ASX25eUaNXlPqjB5lMo=;
 b=JcvbfkkCrSupGc4VjkHT02wXh9g15Pvagn3TEWWyuulZRVjypQYxqTcS7XpnNPjFpxqKcX
 kcnxDCzURnTt9lgO4+gVMHa8DWUeWpFd75XeaeD2crR4lm5SNPjbG6uJshdI342svKGJ2S
 pRE6OhMPJy61aR/Pb272m0IQ2s0PyUM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-ywXq2AFvMn6V1GGfPynJBw-1; Fri,
 13 Nov 2026 13:43:43 -0500
X-MC-Unique: ywXq2AFvMn6V1GGfPynJBw-1
X-Mimecast-MFC-AGG-ID: ywXq2AFvMn6V1GGfPynJBw_1794595422
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DA331956064
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 18:43:42 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E299C19634E9; Fri, 13 Nov 2026 18:43:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 25/26] hw/input: mark PS/2 and PC Keyboard devices as secure
Date: Fri, 13 Nov 2026 18:42:53 +0000
Message-ID: <20261113184254.2524253-26-berrange@redhat.com>
In-Reply-To: <20261113184254.2524253-1-berrange@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These are part of the baseline x86 featureset so required for
virtualization use cases.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/input/pckbd.c | 3 ++-
 hw/input/ps2.c   | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index b09c3bce933..0250252cd67 100644
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
index 01af4350b3b..9d96dddde66 100644
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
-- 
2.56.1


