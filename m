Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF824EB107E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 21:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w04cm-0002Pk-IP; Tue, 10 Mar 2026 17:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w04cb-0002Ny-5p
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 17:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w04cZ-0006KZ-Nq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 17:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773178086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePfqUzp2BJii3RyoEuZ+MyEQOnXPZIcd/p62IMvnOg0=;
 b=dpf1OXHTTaSDX7IgiMMQk7IziY945/i1DTI6BN4jada3Kz5tnaxIe67Kq/+ASQumaHq2V4
 XymhCkAIElvU4uuPCAYB56F24bbpLrPwe7zLCYQdvPV6tuosD3Smm61HfS2CyxiwGhs2hq
 CtO8sp4PdOcbS5jj/VyVmrQKPLQN6Cs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-02MHvmtKNrq1XM8j4FyfAA-1; Tue,
 10 Mar 2026 17:28:01 -0400
X-MC-Unique: 02MHvmtKNrq1XM8j4FyfAA-1
X-Mimecast-MFC-AGG-ID: 02MHvmtKNrq1XM8j4FyfAA_1773178079
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E3091800365; Tue, 10 Mar 2026 21:27:59 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5791E30002D2; Tue, 10 Mar 2026 21:27:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Mar 2026 01:26:54 +0400
Subject: [PATCH 2/2] virtio-gpu: use computed rowstride instead of deriving
 it from hostmem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-cve-v1-2-f72b4c7c1ab2@redhat.com>
References: <20260311-cve-v1-0-f72b4c7c1ab2@redhat.com>
In-Reply-To: <20260311-cve-v1-0-f72b4c7c1ab2@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3551;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=u9nVPXveUB1kK2SePCTueDahzyDnXEY9gpmfXJFE9s4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpsIzNQnLamxOoSNJPSTDQZLYYtrEzjd37x2qUO
 cnAFv02T62JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabCMzQAKCRDa6OEJdZac
 5cm+D/4me8UyyLJfFK12j1kzhs9MYUJWPmX9xs45XWITCb3IjxDSBnZn63HhqU4fpkhsICmtQhm
 ecY5tp+bKdnTVIs7hVUWL+tkTBKCa02yfzNOClLgZUy8nva1CnjIqEd5rHgXNSeQW8ikkqD4uo7
 DxgWNne/Rx8TSxwxkzBpa50cS44AuyeTRwxmxkll8lSTX86sC5p/ZYA3rugGxHHCJQnwPdxoryF
 ef0H71pGogyJ+yv9zjqogyRSNnKtiDrGI8gMXwsisni+aAIA9Jf+om60ofXH72/aXtbZY0GyfeA
 4qfOfTquOChRCzEpjHUwoDNyBLtzaEXXrQ/BJn8dT1crSCLozrXizH/iXL2Kl3DkvzjWEabuW3I
 PYbG5glcgx2Dlat25t2uDa6anQurJ0uJ23PAL6IMJ6x7zQUN0LZHseglf2/vS0wm3KSzv3fEF4q
 b56dMUz6vt5PN3KgU/GCn78fkiSn8oVZhBED7DhKdb7A+fdvSQi9o3lW0MD5Q2xuvWaTiAE+0KC
 PXGCnvI5ctDd7cC5TVBomyeT/Gg1kc3uf7rswRETx4hILhzvF5X2RYecPc1HH8IWeTMNbr+h+Je
 w1O2D2T+VfHM/iHDnN3lL7TeBNec2HhlL4XrG1oTyXj4sK6svl/Ws6HlodNQVYurDnNDl9sv+Qr
 1sjqTcpy7BFHGFw==
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

Since calc_image_hostmem() already computes the stride, return it and
use it directly. This is both simpler and more correct.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


