Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C1BFED9F1
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Y5O-000218-Mr; Tue, 17 Mar 2026 13:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y5M-00020m-UF
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y5L-0005Nx-Bs
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773768002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QK4arTFAt+/iC6WBUuTOJKFd3Oz0W2dHfZqKVMJNBFI=;
 b=DFEo1For+QiMf0fPZ6JN/ZfQZiWKmrHbDb2/9NyV1pilIR4PrgxomZhq7lGNoIAcGFXZ+e
 T5JH477Oo6w3Vg8syrtGTpcOTxZmWBkslWddOKppsuaNgCcic8S6Raq1/+bQbkFPZ3L6d0
 SXJOwCwv0/efjhTspVHpeNA1E/vZA/k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-bVvGmpscPqyNfpP8IA2nlA-1; Tue,
 17 Mar 2026 13:19:59 -0400
X-MC-Unique: bVvGmpscPqyNfpP8IA2nlA-1
X-Mimecast-MFC-AGG-ID: bVvGmpscPqyNfpP8IA2nlA_1773767997
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F72A19560AE; Tue, 17 Mar 2026 17:19:57 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D5E11955F19; Tue, 17 Mar 2026 17:19:54 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 05/16] virtio-gpu: use computed rowstride instead of deriving
 it from hostmem
Date: Tue, 17 Mar 2026 21:19:05 +0400
Message-ID: <20260317171916.438575-6-marcandre.lureau@redhat.com>
In-Reply-To: <20260317171916.438575-1-marcandre.lureau@redhat.com>
References: <20260317171916.438575-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Since calc_image_hostmem() already computes the stride, return it and
use it directly. This is both simpler and more correct.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-Id: <20260311-cve-v1-2-f72b4c7c1ab2@redhat.com>
---
 hw/display/virtio-gpu.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 468ea6ab0fb..b998ce8324d 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -229,7 +229,7 @@ void virtio_gpu_get_edid(VirtIOGPU *g,
 
 static bool calc_image_hostmem(pixman_format_code_t pformat,
                                uint32_t width, uint32_t height,
-                               uint32_t *hostmem)
+                               uint32_t *hostmem, uint32_t *rowstride_bytes)
 {
     uint64_t bpp = PIXMAN_FORMAT_BPP(pformat);
     uint64_t stride = (((uint64_t)width * bpp + 0x1f) >> 5) * sizeof(uint32_t);
@@ -240,6 +240,7 @@ static bool calc_image_hostmem(pixman_format_code_t pformat,
     }
 
     *hostmem = size;
+    *rowstride_bytes = stride;
     return true;
 }
 
@@ -250,7 +251,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
     pixman_format_code_t pformat;
     struct virtio_gpu_simple_resource *res;
     struct virtio_gpu_resource_create_2d c2d;
-    uint32_t hostmem;
+    uint32_t hostmem, rowstride_bytes;
 
     VIRTIO_GPU_FILL_CMD(c2d);
     virtio_gpu_bswap_32(&c2d, sizeof(c2d));
@@ -289,7 +290,8 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
         return;
     }
 
-    if (!calc_image_hostmem(pformat, c2d.width, c2d.height, &hostmem)) {
+    if (!calc_image_hostmem(pformat, c2d.width, c2d.height,
+                            &hostmem, &rowstride_bytes)) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: image dimensions overflow\n",
                       __func__);
         goto end;
@@ -303,7 +305,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
                 pformat,
                 c2d.width,
                 c2d.height,
-                c2d.height ? res->hostmem / c2d.height : 0,
+                rowstride_bytes,
                 &err)) {
             warn_report_err(err);
             goto end;
@@ -1302,7 +1304,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
     VirtIOGPU *g = opaque;
     Error *err = NULL;
     struct virtio_gpu_simple_resource *res;
-    uint32_t resource_id, pformat, hostmem;
+    uint32_t resource_id, pformat, hostmem, rowstride_bytes;
     int i, ret;
 
     g->hostmem = 0;
@@ -1328,7 +1330,8 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             return -EINVAL;
         }
 
-        if (!calc_image_hostmem(pformat, res->width, res->height, &hostmem)) {
+        if (!calc_image_hostmem(pformat, res->width, res->height,
+                                &hostmem, &rowstride_bytes)) {
             g_free(res);
             return -EINVAL;
         }
@@ -1339,7 +1342,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
                                              pformat,
                                              res->width,
                                              res->height,
-                                             res->height ? res->hostmem / res->height : 0,
+                                             rowstride_bytes,
                                              &err)) {
             warn_report_err(err);
             g_free(res);
-- 
2.53.0


