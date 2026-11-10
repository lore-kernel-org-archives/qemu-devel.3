Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FE5606A33F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O2OVg2qz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhI8-0005PS-Gz; Tue, 10 Nov 2026 03:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xQhI5-0005KX-29
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 03:33:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xQhI3-0003Ot-8W
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 03:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794299594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4SHKCVN6tm46hUcxVbYTQ1TsH/L3RAfdeJTsmCZxHRM=;
 b=O2OVg2qztjfIEHkECYBt1taOGAgdAxX5pkinKum6A0zNIpVAvfBfrYOq6UVomn4IusLyZI
 Qs3QsdvliY/K8N+eCf0HIeQycERAgzvk8KAAozxHYSzYRm1sXRL4kurI7rWCrwJIRXPTdU
 zq4x4IxsJbi/TC9bIWZ8b6uFPvQ/zOY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-SiVousk4Mk-3GI035XBsXw-1; Tue,
 10 Nov 2026 03:33:13 -0500
X-MC-Unique: SiVousk4Mk-3GI035XBsXw-1
X-Mimecast-MFC-AGG-ID: SiVousk4Mk-3GI035XBsXw_1794299592
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A29141955EB5; Tue, 10 Nov 2026 08:33:11 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E48B195E489; Tue, 10 Nov 2026 08:33:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Nov 2026 12:31:13 +0400
Subject: [PATCH 3/4] virtio-gpu/rutabaga: reject non-32bpp cursor resources
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261110-master-v1-3-7a0505d6c259@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2852;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UusCNfK4XOsVd8CJXP7eBLC8Ea5qdSROeOTkGYcRSfc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq8ta3PVuuLhd/n9L7E2Vu8XB1HqIY9ufjjfMxl
 IF+QxbJZJ6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavLWtwAKCRDa6OEJdZac
 5U+mD/wLa3XbjpmYktFpJ+RqsJGan/eCEzxZ7JVTYcAetNPVDSJd62OB6gKAGSgHBnkxC3//ykv
 QNJTt/184pX/615YCFNBgXYEi0Uai70KslY/LNMwg+PivEvBFN2bKxqZGwi+ZNVYWa+wPwkbwyc
 LQc4bpupiNBMyDFqndwr/dbisZ2Q5WyRIiuONjRK6bMWHbDp88f4QKep0dSYl/Io5xpAwho7NqF
 zCnAJmv+wNTUBpSoY3xz11pOOqw7CM7T8AFI3fwZ2aK9VOGSGZufFzupkg7kLANTJKFBe4sjkKr
 jEQEVG5QqDg8caFDvUB8SQXeVJP4tvCUzI1Eo6HANjoAO+VYlscwXWx7DZA7T8F8jb+sHu626ak
 1RQmpDrdGC0DZplHmwwylmB2F2EidjsYZfK8Cdgb8a0JJPExmIQ+cTo0++kJiveUaZyK/UL0jRh
 hg9vqFXTNPkEbV8e6Vlwokd9mFyxL9bdfI2tlZ3caWKkkjTrXN8mi2X6SRTpAGhFZMWghTEbhSa
 eXlcPcdGHQSOjUk0Kitk5kU2wlwHzXz4NbeKBRjlJazakVbHceEPX5qdLR/P7YSlmRLi7Z6m+ya
 UmUWVX3c1gCEEDEEh+K5mryvpYHfWywHMG2dPWWg6ZFs95in5CyEP30rT5lsGN3+1iUcaFEwUzV
 q8CJ+ANNIKGlt4g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The cursor buffer is always 64x64x4, but rutabaga does not check the
resource format before the transfer read. Gfxstream copies only as many
bytes as the resource format needs, so an R8_UNORM cursor updates the
first 4096 bytes of the 16384 byte buffer and leaves the rest untouched,
while formats with a larger pixel size do not fit the request and fail.

Refuse cursor resources that are not 32bpp, reusing
virtio_gpu_get_pixman_format() as the allowlist so the 32bpp formats the
other backends accept keep working. res->format is the value passed to
rutabaga_resource_create_3d(), so it matches what gfxstream stores. Blob
resources carry no format; they were already rejected by the dimension
check and stay rejected. Log the dimension mismatch and the transfer
failure as well.

Fixes: CVE-2026-122027
Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Reported-by: Fernando Bortotti <https://gitlab.com/fernando.bortotti>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 1312a67d7011..6246aca894b0 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -44,8 +44,18 @@ virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct virtio_gpu_scanout *s,
         return;
     }
 
+    if (!virtio_gpu_format_is_cursor_capable(res->format)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: cursor resource %u has unsupported format %u\n",
+                      __func__, resource_id, res->format);
+        return;
+    }
+
     if (res->width != s->current_cursor->width ||
         res->height != s->current_cursor->height) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: cursor resource %u has unsupported dimension %ux%u\n",
+                      __func__, resource_id, res->width, res->height);
         return;
     }
 
@@ -59,9 +69,12 @@ virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct virtio_gpu_scanout *s,
     transfer_iovec.iov_base = s->current_cursor->data;
     transfer_iovec.iov_len = res->width * res->height * 4;
 
-    rutabaga_resource_transfer_read(vr->rutabaga, 0,
-                                    resource_id, &transfer,
-                                    &transfer_iovec);
+    if (rutabaga_resource_transfer_read(vr->rutabaga, 0, resource_id,
+                                        &transfer, &transfer_iovec) != 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: failed to read cursor resource %u\n",
+                      __func__, resource_id);
+    }
 }
 
 static void

-- 
2.56.0.116.g6de20f6092dc


