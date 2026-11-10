Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEEE606B9C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XvPjnG/9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhI1-00054x-3o; Tue, 10 Nov 2026 03:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xQhHy-0004xu-1M
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 03:33:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xQhHw-0003OY-Fo
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 03:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794299586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4+PeeUg1L0PvbmpaMiBoNKFbJTrOkGimcAzCBgBaxw=;
 b=XvPjnG/9ib9L+nWiGF8zRfdx7DpAQVZk0Q9fkQxFdhRnyTarqeqBQK42+ZDROVPX8htjan
 TVY+3YmllDk/UQDJ0DFpK5tqcv9AOw3BeOayGgphXOgcCyCOPAQ+vV462A3oJRl7SgHay+
 n51vPOUccgTDtsJ0d5b7fmO89Wj+62s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-en7ZyXRzOJSEHEbXlLFPXQ-1; Tue,
 10 Nov 2026 03:33:05 -0500
X-MC-Unique: en7ZyXRzOJSEHEbXlLFPXQ-1
X-Mimecast-MFC-AGG-ID: en7ZyXRzOJSEHEbXlLFPXQ_1794299584
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B0AC1955EB5; Tue, 10 Nov 2026 08:33:03 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 22CCB18004E9; Tue, 10 Nov 2026 08:33:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Nov 2026 12:31:11 +0400
Subject: [PATCH 1/4] virtio-gpu: make some 2d callbacks statics
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261110-master-v1-1-7a0505d6c259@redhat.com>
References: <20261110-master-v1-0-7a0505d6c259@redhat.com>
In-Reply-To: <20261110-master-v1-0-7a0505d6c259@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Gurchetan Singh <gurchetan.singh.foss@gmail.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2331;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4lwsIzq85WLiw+N7jSTWAcOZ1RbzjQcYyDz8rp6zHuE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq8ta3RM+jrHQr5GklixyQrFwPrT3eINLxRCjH+
 yMR5K+ac0OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavLWtwAKCRDa6OEJdZac
 5Tw2EACIjaSoH86ceD3HAQjLmiBOFVFVi/lys+J6IIWMPAdqvIW8biR0j6I0YIpBsW5lbBiZDks
 hPuOmbN654yj4dxhvmJ0OQaXV7Gc2JXOq8Rps6yfaNmKslYAghDApyGKyc440XDQTYgDldkP/dy
 szg9wSRbXSOdZ0zUxErFOIwofAK8sI0RgO41MCnR0NKtnZGFrEcFBSu8mhjMgkOQgYlV4Pxcf92
 jLBn1LNXziH61QlaLKuqXBb9V8Mu8Pgh7qTjOMY2izdhKcRSHw85f+9mWZGUHGDYp4V+DafNYtJ
 VrzXnHjc4V9PLy480DjtvR538Cop0XOUy6P+ahJTYc8KEGCQzOZJCTnFoK3Mm0BHdfqXGMD+Juv
 nlneZ3figwbn+bSPprPYcIngPpPHHwPVaGfaAFS+HUVbO6/JXeOrD5nR+UoLZGcTcwqCgC9Bg+Z
 Es5CvinIQ2Zx1EQRWQ2LUt7b2oj5P5ophZWTYPZnChyTZNaLz+rP7v7SeJaVnjdM9KFzoiBlgdH
 0rQ05lwmM45F06jxHRjbY1JtiJdOp/Tme2Uv8gvGedncQFUTw+/cHlgXV82PlxAFDNIoUy0ewI8
 jdOWT9aRDfRkKna9PxjWK3BrsVP517Px4MED2RhsdVKM7cOHNPUFqET28icWoDWMyDPY/UB0vUr
 YVwD0HJR8U57mXQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Those functions are not shared with other units.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c        | 12 +++++++-----
 include/hw/virtio/virtio-gpu.h |  4 ----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5d43ffb99184..6450f4734861 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -81,9 +81,10 @@ virtio_gpu_simple_resource_new_blob(uint32_t resource_id, uint64_t blob_size)
     return res;
 }
 
-void virtio_gpu_update_cursor_data(VirtIOGPU *g,
-                                   struct virtio_gpu_scanout *s,
-                                   uint32_t resource_id)
+static void
+virtio_gpu_update_cursor_data(VirtIOGPU *g,
+                              struct virtio_gpu_scanout *s,
+                              uint32_t resource_id)
 {
     struct virtio_gpu_simple_resource *res;
     uint32_t pixels;
@@ -1178,8 +1179,9 @@ virtio_gpu_resource_detach_backing(VirtIOGPU *g,
     virtio_gpu_cleanup_mapping(g, res);
 }
 
-void virtio_gpu_simple_process_cmd(VirtIOGPU *g,
-                                   struct virtio_gpu_ctrl_command *cmd)
+static void
+virtio_gpu_simple_process_cmd(VirtIOGPU *g,
+                              struct virtio_gpu_ctrl_command *cmd)
 {
     VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
     virtio_gpu_ctrl_hdr_bswap(&cmd->cmd_hdr);
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 631dfc63a4d4..65e96b8fc4de 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -361,10 +361,6 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
 void virtio_gpu_process_cmdq(VirtIOGPU *g);
 void virtio_gpu_device_realize(DeviceState *qdev, Error **errp);
 void virtio_gpu_reset(VirtIODevice *vdev);
-void virtio_gpu_simple_process_cmd(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd);
-void virtio_gpu_update_cursor_data(VirtIOGPU *g,
-                                   struct virtio_gpu_scanout *s,
-                                   uint32_t resource_id);
 
 bool virtio_gpu_check_scanout_bounds(uint32_t scanout_id, uint32_t resource_id,
                                      uint32_t width, uint32_t height,

-- 
2.56.0.116.g6de20f6092dc


