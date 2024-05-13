Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA6AC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PyP-00012J-4I; Mon, 13 May 2024 03:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6PyG-0000rj-8J
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6Py8-0004Md-Q4
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715584770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vXEf6MzzW2iiMzYA77qN4WzMwGtff1QqnKjBRadxhlQ=;
 b=F3KHe1W+u9IYx2OcreNgmW5ita+I85j/TopiZAc9EJ0DDJWPzRMazmLQCU6sBttI+v/Cvh
 J0bXO7g7rIQKaIqD6R5NbxJQzX22Kedbn4HaGmuS34WhOFD3GnlSyu55SJn4Jd3KjFXH7x
 fvH5fzvzGKiwAQH3LvHJ/I2jWIhyvTA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-WT8S0rX_OpKgik_JtUUpgw-1; Mon, 13 May 2024 03:19:25 -0400
X-MC-Unique: WT8S0rX_OpKgik_JtUUpgw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F31201818690;
 Mon, 13 May 2024 07:19:23 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6411140AD3C5;
 Mon, 13 May 2024 07:19:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 3/4] virtio-gpu: add x-vmstate-version
Date: Mon, 13 May 2024 11:19:04 +0400
Message-ID: <20240513071905.499143-4-marcandre.lureau@redhat.com>
In-Reply-To: <20240513071905.499143-1-marcandre.lureau@redhat.com>
References: <20240513071905.499143-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Machine <= 8.2 use v1.

Following patch will adjust to v2 for other machines to fix migration.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 include/hw/virtio/virtio-gpu.h | 1 +
 hw/core/machine.c              | 1 +
 hw/display/virtio-gpu.c        | 6 ++++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index ed44cdad6b..af1c77eb3f 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -177,6 +177,7 @@ typedef struct VGPUDMABuf {
 struct VirtIOGPU {
     VirtIOGPUBase parent_obj;
 
+    uint8_t vmstate_version;
     uint64_t conf_max_hostmem;
 
     VirtQueue *ctrl_vq;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index c7ceb11501..cf840e0502 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -42,6 +42,7 @@ GlobalProperty hw_compat_8_2[] = {
     { "migration", "zero-page-detection", "legacy"},
     { TYPE_VIRTIO_IOMMU_PCI, "granule", "4k" },
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
+    { "virtio-gpu-device", "x-vmstate-version", "1" },
 };
 const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index ae831b6b3e..7f9fb5eacc 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1234,7 +1234,8 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
     }
     qemu_put_be32(f, 0); /* end of list */
 
-    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL);
+    return vmstate_save_state_v(f, &vmstate_virtio_gpu_scanouts, g,
+                                NULL, g->vmstate_version, NULL);
 }
 
 static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
@@ -1339,7 +1340,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
     }
 
     /* load & apply scanout state */
-    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
+    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, g->vmstate_version);
 
     return 0;
 }
@@ -1659,6 +1660,7 @@ static Property virtio_gpu_properties[] = {
     DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
     DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
+    DEFINE_PROP_UINT8("x-vmstate-version", VirtIOGPU, vmstate_version, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0.28.gd7d8841f67


