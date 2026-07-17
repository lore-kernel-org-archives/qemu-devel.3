Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F1FC4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh8s-00053C-48; Fri, 17 Jul 2026 07:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8q-00050y-Cx
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:54:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8o-0003Sg-O8
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784289244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=36RJqVPwaBMvjLN3VZbKH8Wswuy8bro5HEmKr61RjUo=;
 b=AdO2bgy7C6ktbOLfX5n0S6++l6/OueReqX79DK+DtK9cIkRidlYGg1tGRXXC+ZFuw4kHMD
 mTqfMdGbVp1ZjcCywDoztyjBAdOMbua93Kr/2sTXZatHgt15uCcBE59MMbX3XV8egzLn8w
 s+30E3G5rZM48dt5MjIozXG7mDiyBjI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-cLTfsJ3fOKyVdgwaNlhdDA-1; Fri,
 17 Jul 2026 07:54:03 -0400
X-MC-Unique: cLTfsJ3fOKyVdgwaNlhdDA-1
X-Mimecast-MFC-AGG-ID: cLTfsJ3fOKyVdgwaNlhdDA_1784289242
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 484ED1800750
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:54:02 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C28B30040BF
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:54:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Jul 2026 15:52:50 +0400
Subject: [GIT PULL 11/15] hw/display/virtio-gpu: validate stride against
 width on scanout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-fix-v1-11-cb9f7d49dc52@redhat.com>
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
In-Reply-To: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2368;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/2k1yLXrr0iajI/tlLhcu7f0CvyuxjSOgEJVPdgkS2Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqWhea7rqZfR4+V/5+jozm1ihzOwvOot3mciRki
 dxJYpRbnoeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaloXmgAKCRDa6OEJdZac
 5QgoD/97Hx/fysWjY8YhuRos+bE57XsR9yQvhgy6YjG6exiuFENj4A1iDvZLb+3vvghIxhVxQ+J
 yL5lpHYpltfK1+J/XGqIiKPF8bHvivkmYpm9dzFyHJ5GHj/qRcDngj31gjA7IVc+hPiI7/4s7Xk
 U/aJVpPs2ljjxLXLoVI2dK0aitfApDTKrtTPhziRuY7UEhuh+9KxTtjBiBSlUl+1/ADvalyCajC
 x6OfSvh1UJYl2OmZRj3aaAooMAQGxjFwMqPa0TjjXkUAxpQXcLLb6bX43J6o6N/f6eShBtQHFOD
 0GET53bpqfh9vch3+Uyqo7kTu2r2IdYbqRaYO0qzjfKYL5NIGRgMhNdl38lOqMgfxJ0PPS+DQnn
 GJmiY4zGisEQCT2fzzH38/81ffe6aHObBfbFyE8wU3311tMblsIdM8Pwa4dW4y/QlUQ+WTn9vJS
 +tpcaEYQp9aSI0FOEH6pL1Uq66O7a8GXCvowluo7byyZA2CLLRI0sVPgfBDJ8rq5SQv8EmM7kvh
 FDYp2If286r8NcsvNXEKScChXLNo0DhafvlaU2dW3kqAvDV7OMxuxKT2vfXaqq08pCeadStwJi9
 e5WhGEjJDE72f7Ho/tKrS80cfs9L1HppCwOAwT0YrDuqNlH7e7/n9sTXA3NxS1gHALrfatHC6Bb
 gJVIaHk1ChZpdsA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Validate that the framebuffer stride is at least width * bytes_per_pixel
in both virtio_gpu_scanout_blob_to_fb() and virtio_gpu_do_set_scanout().

A guest can set a very small stride while using a large width. The total
size check (offset + stride * height <= blob_size) passes because
stride * height is small, but pixman reads width * bytes_per_pixel per
row, causing heap OOB reads. The leaked data is rendered to the host
display.

The check is added in virtio_gpu_do_set_scanout() to cover all paths:
blob scanout, non-blob scanout and migration post_load. The additional
early check in virtio_gpu_scanout_blob_to_fb() rejects invalid blob
configurations early.

Fixes: CVE-2026-63109
Fixes: 7b5574225429 ("hw/display: check frame buffer can hold blob")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3989
Reported-by: Tristan @TristanInSec
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 88526051a99..e00fb6effa5 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -646,6 +646,14 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
         return false;
     }
 
+    if (fb->stride < (uint64_t)fb->width * fb->bytes_pp) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: stride %u too small for width %u at %u bpp\n",
+                      __func__, fb->stride, fb->width, fb->bytes_pp);
+        *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return false;
+    }
+
     g->parent_obj.enable = 1;
 
     if (res->blob) {
@@ -753,6 +761,14 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
     fb->width = ss->width;
     fb->height = ss->height;
     fb->stride = ss->strides[0];
+
+    if (fb->stride < (uint64_t)fb->width * fb->bytes_pp) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: stride %u too small for width %u at %u bpp\n",
+                      __func__, fb->stride, fb->width, fb->bytes_pp);
+        return false;
+    }
+
     fb->offset = ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * fb->stride;
 
     fbend = fb->offset;

-- 
2.55.0


