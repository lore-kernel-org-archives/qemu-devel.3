Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D077CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 06:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSnN-0001mc-T5; Wed, 22 Oct 2025 02:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSnM-0001lN-FM
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:58:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSnK-00088p-SZ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761116282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rwpnWD9iw8bqt6SJCbIjLvqQbhMiOwHt9uoQCFJISgc=;
 b=A3YfpA6a5x3DzSd0Yl4BuXtY1+j/ziDM3at2kvpd1cUUSky5NsfZcrscKOzN5ytuaajEsd
 EB3LoQEQxtnpxA1gnWGhODPcc5jJEovXSlWZoC6ZJLnsmNXw4/ycj7qfaA41tm0ux4Lbci
 6UXw/JmuyLlE2joLnubBxy8s1tyuiZU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-1onX_duNMEizwbd9ks6J4w-1; Wed,
 22 Oct 2025 02:57:58 -0400
X-MC-Unique: 1onX_duNMEizwbd9ks6J4w-1
X-Mimecast-MFC-AGG-ID: 1onX_duNMEizwbd9ks6J4w_1761116277
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DB3018001C6; Wed, 22 Oct 2025 06:57:57 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7EED03000218; Wed, 22 Oct 2025 06:57:56 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 13/42] hw/audio: simplify 'hda' audio init code
Date: Wed, 22 Oct 2025 10:56:08 +0400
Message-ID: <20251022065640.1172785-14-marcandre.lureau@redhat.com>
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

For consistency, use only qdev_device_add() to instantiate the devices.
We can't rely on automatic bus lookup for the "hda-duplex" device though
as it may end up on a different "intel-hda" bus...

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/audio/intel-hda.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 6a0db0dd9e..14bcf1257d 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -21,6 +21,7 @@
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/msi.h"
+#include "monitor/qdev.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
@@ -30,6 +31,7 @@
 #include "intel-hda.h"
 #include "migration/vmstate.h"
 #include "intel-hda-defs.h"
+#include "qobject/qdict.h"
 #include "system/dma.h"
 #include "qapi/error.h"
 #include "qom/object.h"
@@ -1305,15 +1307,19 @@ static const TypeInfo hda_codec_device_type_info = {
  */
 static int intel_hda_and_codec_init(PCIBus *bus, const char *audiodev)
 {
-    DeviceState *controller;
+    g_autoptr(QDict) props = qdict_new();
+    DeviceState *intel_hda, *codec;
     BusState *hdabus;
-    DeviceState *codec;
 
-    controller = DEVICE(pci_create_simple(bus, -1, "intel-hda"));
-    hdabus = QLIST_FIRST(&controller->child_bus);
+    qdict_put_str(props, "driver", "intel-hda");
+    intel_hda = qdev_device_add_from_qdict(props, false, &error_fatal);
+    hdabus = QLIST_FIRST(&intel_hda->child_bus);
+
     codec = qdev_new("hda-duplex");
     qdev_prop_set_string(codec, "audiodev", audiodev);
     qdev_realize_and_unref(codec, hdabus, &error_fatal);
+    object_unref(intel_hda);
+
     return 0;
 }
 
-- 
2.51.0


