Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EC0C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PyP-000132-8z; Mon, 13 May 2024 03:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6PyF-0000pz-Ky
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6PyA-0004Mj-9k
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715584772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZW3msVu5TGi7rboppzd1KcjK9E3K8XGWczcu+sFhZXQ=;
 b=GhJjrJ00rqB51C5f0r2c7yghsUN1wiMbuaOwVherDkyjesIAogo8WSAIq7N3pOC5Yshk+o
 6jaShTVSvVKxmcFUGxpDZHi4VexWd2RSwirPT8WWe+G5IRO2K41tKk8zvKdWP++LFtFFf9
 sDNjsof9pJkZJckilKV9v/TsETUST/A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-cIgPryeuMsW6nE0wy6QoSA-1; Mon,
 13 May 2024 03:19:29 -0400
X-MC-Unique: cIgPryeuMsW6nE0wy6QoSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B747938135EF;
 Mon, 13 May 2024 07:19:28 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 144FA40AD3CB;
 Mon, 13 May 2024 07:19:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 4/4] virtio-gpu: fix v2 migration
Date: Mon, 13 May 2024 11:19:05 +0400
Message-ID: <20240513071905.499143-5-marcandre.lureau@redhat.com>
In-Reply-To: <20240513071905.499143-1-marcandre.lureau@redhat.com>
References: <20240513071905.499143-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Peter Xu <peterx@redhat.com>

Commit dfcf74fa ("virtio-gpu: fix scanout migration post-load") broke
forward/backward version migration. Versioning of nested VMSD structures
is not straightforward, as the wire format doesn't have nested
structures versions. Use the x-vmstate-version introduced before and a
field test to save/load appropriately according to the machine version.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/display/virtio-gpu.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 7f9fb5eacc..5de90bb62f 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1166,6 +1166,14 @@ static void virtio_gpu_cursor_bh(void *opaque)
     virtio_gpu_handle_cursor(&g->parent_obj.parent_obj, g->cursor_vq);
 }
 
+static bool vmstate_after_v2(void *opaque, int version)
+{
+    struct VirtIOGPUBase *base = container_of(opaque, VirtIOGPUBase, scanout);
+    struct VirtIOGPU *gpu = container_of(base, VirtIOGPU, parent_obj);
+
+    return gpu->vmstate_version >= 2;
+}
+
 static const VMStateDescription vmstate_virtio_gpu_scanout = {
     .name = "virtio-gpu-one-scanout",
     .version_id = 2,
@@ -1181,12 +1189,12 @@ static const VMStateDescription vmstate_virtio_gpu_scanout = {
         VMSTATE_UINT32(cursor.hot_y, struct virtio_gpu_scanout),
         VMSTATE_UINT32(cursor.pos.x, struct virtio_gpu_scanout),
         VMSTATE_UINT32(cursor.pos.y, struct virtio_gpu_scanout),
-        VMSTATE_UINT32_V(fb.format, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.bytes_pp, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.width, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.height, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.stride, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.offset, struct virtio_gpu_scanout, 2),
+        VMSTATE_UINT32_TEST(fb.format, struct virtio_gpu_scanout, vmstate_after_v2),
+        VMSTATE_UINT32_TEST(fb.bytes_pp, struct virtio_gpu_scanout, vmstate_after_v2),
+        VMSTATE_UINT32_TEST(fb.width, struct virtio_gpu_scanout, vmstate_after_v2),
+        VMSTATE_UINT32_TEST(fb.height, struct virtio_gpu_scanout, vmstate_after_v2),
+        VMSTATE_UINT32_TEST(fb.stride, struct virtio_gpu_scanout, vmstate_after_v2),
+        VMSTATE_UINT32_TEST(fb.offset, struct virtio_gpu_scanout, vmstate_after_v2),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -1660,7 +1668,7 @@ static Property virtio_gpu_properties[] = {
     DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
     DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
-    DEFINE_PROP_UINT8("x-vmstate-version", VirtIOGPU, vmstate_version, 1),
+    DEFINE_PROP_UINT8("x-vmstate-version", VirtIOGPU, vmstate_version, 2),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0.28.gd7d8841f67


