Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CB7FED9F0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Y5K-00020J-Pm; Tue, 17 Mar 2026 13:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y5F-0001yd-Px
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y5E-0005MF-Be
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773767994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8h0sizqDRrWh4i0kVqCLWnQ1yrxi4rvEkqw6RMr/1k4=;
 b=ekEYlOU6GhXU888HtJ//HzJOYZaw2QMwif5Rm+MzvdTJBUu1nOYZurH8ePRaceJhO8Zd81
 /5+nNHnO2f8j6vFj9Qg5iRyXPG0+ltjGNVLCPTmHxd4AfTPSkBBG4rAp+dm5/QIpSTn7Gq
 WRhI2lRC+4gHm0Y/YIiJS5lCu3AWrtg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-BMVKYw-lP2yzcljQnT6FrA-1; Tue,
 17 Mar 2026 13:19:52 -0400
X-MC-Unique: BMVKYw-lP2yzcljQnT6FrA-1
X-Mimecast-MFC-AGG-ID: BMVKYw-lP2yzcljQnT6FrA_1773767991
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DECE118005BD; Tue, 17 Mar 2026 17:19:50 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B6721800576; Tue, 17 Mar 2026 17:19:48 +0000 (UTC)
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
Subject: [PULL 04/16] virtio-gpu: fix overflow check when allocating 2d image
Date: Tue, 17 Mar 2026 21:19:04 +0400
Message-ID: <20260317171916.438575-5-marcandre.lureau@redhat.com>
In-Reply-To: <20260317171916.438575-1-marcandre.lureau@redhat.com>
References: <20260317171916.438575-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The calc_image_hostmem() comment says pixman_image_create_bits() checks
for overflow. However, this relied on the facts that "bits" was NULL and
it performed it when it was introduced. Since commit 9462ff4695aa, the
"bits" argument can be provided and the check is no longer applied.

Promotes the computation to uint64_t and adds an explicit overflow check
to avoid potential later OOB read/write on the image data.

Fixes: CVE-2026-3886
Fixes: ZDI-CAN-27578
Fixes: 9462ff4695aa ("virtio-gpu/win32: allocate shareable 2d resources/images")
Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-Id: <20260311-cve-v1-1-f72b4c7c1ab2@redhat.com>
---
 hw/display/virtio-gpu.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index de7a86a73d2..468ea6ab0fb 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -227,16 +227,20 @@ void virtio_gpu_get_edid(VirtIOGPU *g,
     virtio_gpu_ctrl_response(g, cmd, &edid.hdr, sizeof(edid));
 }
 
-static uint32_t calc_image_hostmem(pixman_format_code_t pformat,
-                                   uint32_t width, uint32_t height)
+static bool calc_image_hostmem(pixman_format_code_t pformat,
+                               uint32_t width, uint32_t height,
+                               uint32_t *hostmem)
 {
-    /* Copied from pixman/pixman-bits-image.c, skip integer overflow check.
-     * pixman_image_create_bits will fail in case it overflow.
-     */
+    uint64_t bpp = PIXMAN_FORMAT_BPP(pformat);
+    uint64_t stride = (((uint64_t)width * bpp + 0x1f) >> 5) * sizeof(uint32_t);
+    uint64_t size = (uint64_t)height * stride;
 
-    int bpp = PIXMAN_FORMAT_BPP(pformat);
-    int stride = ((width * bpp + 0x1f) >> 5) * sizeof(uint32_t);
-    return height * stride;
+    if (size > UINT32_MAX) {
+        return false;
+    }
+
+    *hostmem = size;
+    return true;
 }
 
 static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
@@ -246,6 +250,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
     pixman_format_code_t pformat;
     struct virtio_gpu_simple_resource *res;
     struct virtio_gpu_resource_create_2d c2d;
+    uint32_t hostmem;
 
     VIRTIO_GPU_FILL_CMD(c2d);
     virtio_gpu_bswap_32(&c2d, sizeof(c2d));
@@ -284,7 +289,12 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
         return;
     }
 
-    res->hostmem = calc_image_hostmem(pformat, c2d.width, c2d.height);
+    if (!calc_image_hostmem(pformat, c2d.width, c2d.height, &hostmem)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: image dimensions overflow\n",
+                      __func__);
+        goto end;
+    }
+    res->hostmem = hostmem;
     if (res->hostmem + g->hostmem < g->conf_max_hostmem) {
         if (!qemu_pixman_image_new_shareable(
                 &res->image,
@@ -1292,7 +1302,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
     VirtIOGPU *g = opaque;
     Error *err = NULL;
     struct virtio_gpu_simple_resource *res;
-    uint32_t resource_id, pformat;
+    uint32_t resource_id, pformat, hostmem;
     int i, ret;
 
     g->hostmem = 0;
@@ -1318,7 +1328,11 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             return -EINVAL;
         }
 
-        res->hostmem = calc_image_hostmem(pformat, res->width, res->height);
+        if (!calc_image_hostmem(pformat, res->width, res->height, &hostmem)) {
+            g_free(res);
+            return -EINVAL;
+        }
+        res->hostmem = hostmem;
         if (!qemu_pixman_image_new_shareable(&res->image,
                                              &res->share_handle,
                                              "virtio-gpu res",
-- 
2.53.0


