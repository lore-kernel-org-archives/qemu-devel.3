Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF47310A1E7E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 11:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5izX-0001Wg-JA; Thu, 26 Mar 2026 07:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5izU-0001RD-41
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5izS-0006nB-14
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774524905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GmJc25TpxiNuhXy0BlLDA1L6RtQk86BaW+oomGkSDB0=;
 b=Liu+wzyBM3wuSpU7gzwEE897x7/vA/zLPL5CELTH72aIuB2fbXRcmSLYPDFoSMT1TNvNdW
 blGkCi9wx1FD5csUZkhIg5ZXqLB/20aoq+N6VouUCiVafLm1HXa6piqlt0HLn4NX2JXLUW
 Xn4WY0Y4DXeIatRRVnYNU/RrsmleeEk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-kAcu9s_vOL6-_3w5uZRkdQ-1; Thu,
 26 Mar 2026 07:35:03 -0400
X-MC-Unique: kAcu9s_vOL6-_3w5uZRkdQ-1
X-Mimecast-MFC-AGG-ID: kAcu9s_vOL6-_3w5uZRkdQ_1774524903
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C075B19560AA; Thu, 26 Mar 2026 11:35:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 843A41800361; Thu, 26 Mar 2026 11:34:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] hw/display/vga-isa: Fix migration of the isa-vga device
Date: Thu, 26 Mar 2026 12:34:57 +0100
Message-ID: <20260326113457.159065-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

QEMU currently crashes when migrating a guest that uses the
isa-vga device as display. This happens because vga_isa_class_initfn()
registers a vmsd for vmstate_vga_common that operates on VGACommonState.
But the isa-vga device is derived from ISADevice, not from VGACommonState,
so the migration code tries to fill in the data for VGACommonState to
the memory that is a ISADevice instead, which is of cause causing trouble.

We need an indirection here as it's also e.g. done in vga-pci.c, so
that the migration data gets filled into the right location.

While we're at it, also drop the "global_vmstate = true" here. Since
migration was broken for this device during the last 15 years (!) anyway,
we don't have to worry about maintaining backward compatibility with this
switch for older versions of QEMU anymore.

Fixes: 7435b791ca9 ("vga-isa: convert to qdev")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/display/vga-isa.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index 95d85ff69a5..5f55c884a1b 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -32,6 +32,7 @@
 #include "qemu/timer.h"
 #include "hw/core/loader.h"
 #include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
 #include "ui/console.h"
 #include "qom/object.h"
 
@@ -62,7 +63,6 @@ static void vga_isa_realizefn(DeviceState *dev, Error **errp)
     MemoryRegion *vga_io_memory;
     const MemoryRegionPortio *vga_ports, *vbe_ports;
 
-    s->global_vmstate = true;
     if (!vga_common_init(s, OBJECT(dev), errp)) {
         return;
     }
@@ -88,6 +88,15 @@ static void vga_isa_realizefn(DeviceState *dev, Error **errp)
     rom_add_vga(VGABIOS_FILENAME);
 }
 
+static const VMStateDescription vmstate_vga_isa = {
+    .name = "vga-isa",
+    .version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(state, ISAVGAState, 0, vmstate_vga_common, VGACommonState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const Property vga_isa_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", ISAVGAState, state.vram_size_mb, 8),
 };
@@ -98,7 +107,7 @@ static void vga_isa_class_initfn(ObjectClass *klass, const void *data)
 
     dc->realize = vga_isa_realizefn;
     device_class_set_legacy_reset(dc, vga_isa_reset);
-    dc->vmsd = &vmstate_vga_common;
+    dc->vmsd = &vmstate_vga_isa;
     device_class_set_props(dc, vga_isa_properties);
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
 }
-- 
2.53.0


