Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEDEEB1076
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 21:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w04cZ-0002Ng-SN; Tue, 10 Mar 2026 17:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w04cU-0002Mj-1w
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 17:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w04cS-0006Jt-ID
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 17:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773178079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JIfA6sZXnB6rXP8xNkObgz5V4hkQf7uJ5hQYVnQYXEQ=;
 b=CIg3GAOu7F/kMkaNNwhE2zyHp7BtfAPltS17DE8Ln7Jw6IiVvim/g7zRtrEIvVac794rWm
 Mu7Sx9Z8lj96IPnipyChpqKrH5wTYkQyfLP3u1QngBy3bRmaN8jGPZ6mc4LwENEWRQIb1X
 JA1Hb1QTZ1/MyZuA3RougjgHgHjR/1U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-Y9zDP8IoPBeHqYlpR6xIlg-1; Tue,
 10 Mar 2026 17:27:55 -0400
X-MC-Unique: Y9zDP8IoPBeHqYlpR6xIlg-1
X-Mimecast-MFC-AGG-ID: Y9zDP8IoPBeHqYlpR6xIlg_1773178074
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D90A51956094; Tue, 10 Mar 2026 21:27:53 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1EAA23002D0D; Tue, 10 Mar 2026 21:27:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Mar 2026 01:26:53 +0400
Subject: [PATCH 1/2] virtio-gpu: fix overflow check when allocating 2d
 image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-cve-v1-1-f72b4c7c1ab2@redhat.com>
References: <20260311-cve-v1-0-f72b4c7c1ab2@redhat.com>
In-Reply-To: <20260311-cve-v1-0-f72b4c7c1ab2@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Zero Day Initiative <zdi-disclosures@trendmicro.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3880;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6f1ssAgJqcbBR7BR/kVClFuR5FkLbx0ZCP6Lc56oZb4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpsIzNVscI+YGdUAX7Wbp/1HwE48oDrtcZbb4TF
 +H79wKzbgeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabCMzQAKCRDa6OEJdZac
 5WIMD/0UhDJ8ZoWxn+iPfJ6qUIFjdRSeTr/PXF9jPnJaMVqjUSzxNatv+GagHMh01LODKemsAP1
 2IPHHXstpW0xeViYRH+sdKP26V/eWPMcawirT0dX2iibuYv/Sl7Vvy8LXWYdqQ+3ncXrC5mvoI/
 yLmPPLGuulBHNuKGiihzLVfZeDWwQFzmwa9sSn6TkEBipHhdVuAtr4+nbhvzDjliKcZpfOqrGKq
 SJwB9G43lpn758ZMMDhTV2qcWz8fa0hjEKtDI+JJUBFLpMxlcZx1dCHReMUgLeXOu93DH1aZx3y
 VC7x/z23x6Hvs55F1cfM4mw+2vrNmA10KCaNoYqqjbYafkA+yDnq/C2JV2hJ4sZm0WrDMlFGuOr
 MiEVrcjGpn1wZhEchL4iUs4Vcxctox+ErnBg3C+i2qsxTSISlOCXUtdQkvTEH630mVGvPFIQpld
 gSPSdOqnRDnqdg/SkkTx/vjKzkHoevGADAaEk4y4dFZ3heKJqoW5Wn31v79LiPaxGZ4912wqvR9
 9ynxcHcsf+AjxHbQqAWpqONVyTPGH3BgfONsqXbAKmGr/QVq7R6Z2shLV++mVl9HV0onjsbXLJR
 K6c4HKFzz8Ds/5cCWap5hr53S4CV10cczuAgazMiCalZXhzAoBaYvTsbJ01+rHfslm4AJlhVqtT
 V5MUWpKDK/R/WGA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


