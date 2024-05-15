Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C14C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 14:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7FRF-0004gE-UB; Wed, 15 May 2024 10:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s7FQv-0004XT-2k
 for qemu-devel@nongnu.org; Wed, 15 May 2024 10:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s7FQn-0005qk-NL
 for qemu-devel@nongnu.org; Wed, 15 May 2024 10:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715782589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zhG1n1cOXCy38EfCohGjAHrLHN6AlBRmBnbsG0Nua78=;
 b=gXAuJPO38cy+L/FB9lCCdUWR9/eHWTxmtlvFbg7MkM7ViSJEnIYmL9+KeH9QzhIJ3ekNAQ
 LtbPb0Fxcb88x2R2QkRBdZpQuLgdKPAJV8966+6tUVHw81uBnb3gIQc0p/KnsegyVJ91cp
 MXt5M5vIrKxx07CC9sonVzUC1C+Es50=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-Imts-c0-MNSY7lt6O3tfhQ-1; Wed, 15 May 2024 10:16:27 -0400
X-MC-Unique: Imts-c0-MNSY7lt6O3tfhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF9918058D5;
 Wed, 15 May 2024 14:16:26 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C428123CAE0;
 Wed, 15 May 2024 14:16:25 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 5/5] virtio-gpu: fix v2 migration
Date: Wed, 15 May 2024 18:15:56 +0400
Message-ID: <20240515141557.1277999-6-marcandre.lureau@redhat.com>
In-Reply-To: <20240515141557.1277999-1-marcandre.lureau@redhat.com>
References: <20240515141557.1277999-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Commit dfcf74fa ("virtio-gpu: fix scanout migration post-load") broke
forward/backward version migration. Versioning of nested VMSD structures
is not straightforward, as the wire format doesn't have nested
structures versions.

Use the previously introduced check_machine_version() function as a
field test to ensure proper saving/loading based on the machine version.
The VMSD.version is irrelevant now.

Fixes: dfcf74fa ("virtio-gpu: fix scanout migration post-load")
Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index ae831b6b3e..b2d8e5faeb 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -20,6 +20,7 @@
 #include "trace.h"
 #include "sysemu/dma.h"
 #include "sysemu/sysemu.h"
+#include "hw/boards.h"
 #include "hw/virtio/virtio.h"
 #include "migration/qemu-file-types.h"
 #include "hw/virtio/virtio-gpu.h"
@@ -1166,10 +1167,14 @@ static void virtio_gpu_cursor_bh(void *opaque)
     virtio_gpu_handle_cursor(&g->parent_obj.parent_obj, g->cursor_vq);
 }
 
+static bool machine_check_9_0(void *opaque, int version)
+{
+    return machine_check_version(9, 0);
+}
+
 static const VMStateDescription vmstate_virtio_gpu_scanout = {
     .name = "virtio-gpu-one-scanout",
-    .version_id = 2,
-    .minimum_version_id = 1,
+    .version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(resource_id, struct virtio_gpu_scanout),
         VMSTATE_UINT32(width, struct virtio_gpu_scanout),
@@ -1181,12 +1186,12 @@ static const VMStateDescription vmstate_virtio_gpu_scanout = {
         VMSTATE_UINT32(cursor.hot_y, struct virtio_gpu_scanout),
         VMSTATE_UINT32(cursor.pos.x, struct virtio_gpu_scanout),
         VMSTATE_UINT32(cursor.pos.y, struct virtio_gpu_scanout),
-        VMSTATE_UINT32_V(fb.format, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.bytes_pp, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.width, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.height, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.stride, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.offset, struct virtio_gpu_scanout, 2),
+        VMSTATE_UINT32_TEST(fb.format, struct virtio_gpu_scanout, machine_check_9_0),
+        VMSTATE_UINT32_TEST(fb.bytes_pp, struct virtio_gpu_scanout, machine_check_9_0),
+        VMSTATE_UINT32_TEST(fb.width, struct virtio_gpu_scanout, machine_check_9_0),
+        VMSTATE_UINT32_TEST(fb.height, struct virtio_gpu_scanout, machine_check_9_0),
+        VMSTATE_UINT32_TEST(fb.stride, struct virtio_gpu_scanout, machine_check_9_0),
+        VMSTATE_UINT32_TEST(fb.offset, struct virtio_gpu_scanout, machine_check_9_0),
         VMSTATE_END_OF_LIST()
     },
 };
-- 
2.41.0.28.gd7d8841f67


