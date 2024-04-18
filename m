Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D159CC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 20:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXyL-0001Zf-Fe; Thu, 18 Apr 2024 16:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxXxr-0001Uu-6r; Thu, 18 Apr 2024 16:02:35 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxXxp-0005GY-4X; Thu, 18 Apr 2024 16:02:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 56DFB5FE0B;
 Thu, 18 Apr 2024 23:02:27 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B6C8CB93F1;
 Thu, 18 Apr 2024 23:02:24 +0300 (MSK)
Received: (nullmailer pid 952848 invoked by uid 1000);
 Thu, 18 Apr 2024 20:02:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 44/59] hw/virtio: Introduce virtio_bh_new_guarded()
 helper
Date: Thu, 18 Apr 2024 23:02:04 +0300
Message-Id: <20240418200224.952785-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240418230159@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240418230159@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Introduce virtio_bh_new_guarded(), similar to qemu_bh_new_guarded()
but using the transport memory guard, instead of the device one
(there can only be one virtio device per virtio bus).

Inspired-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20240409105537.18308-2-philmd@linaro.org>
(cherry picked from commit ec0504b989ca61e03636384d3602b7bf07ffe4da)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: trivial #include context fixup in include/hw/virtio/virtio.h)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e4f8ed1e63..4a35d7cb0c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -5029,3 +5029,13 @@ static void virtio_register_types(void)
 }
 
 type_init(virtio_register_types)
+
+QEMUBH *virtio_bh_new_guarded_full(DeviceState *dev,
+                                   QEMUBHFunc *cb, void *opaque,
+                                   const char *name)
+{
+    DeviceState *transport = qdev_get_parent_bus(dev)->parent;
+
+    return qemu_bh_new_full(cb, opaque, name,
+                            &transport->mem_reentrancy_guard);
+}
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 96a56430a6..c1a7c9bd3b 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -23,6 +23,7 @@
 #include "standard-headers/linux/virtio_ring.h"
 #include "qom/object.h"
 #include "hw/virtio/vhost.h"
+#include "block/aio.h"
 
 /*
  * A guest should never accept this. It implies negotiation is broken
@@ -463,4 +464,10 @@ static inline bool virtio_device_disabled(VirtIODevice *vdev)
 bool virtio_legacy_allowed(VirtIODevice *vdev);
 bool virtio_legacy_check_disabled(VirtIODevice *vdev);
 
+QEMUBH *virtio_bh_new_guarded_full(DeviceState *dev,
+                                   QEMUBHFunc *cb, void *opaque,
+                                   const char *name);
+#define virtio_bh_new_guarded(dev, cb, opaque) \
+    virtio_bh_new_guarded_full((dev), (cb), (opaque), (stringify(cb)))
+
 #endif
-- 
2.39.2


