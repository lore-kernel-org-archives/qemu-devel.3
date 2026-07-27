Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A16C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJsn-0007N4-Ai; Mon, 27 Jul 2026 07:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJsk-0007Dj-Uj
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJsh-0003lM-3i
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZ7lBwn2sR/htsLc0oYMxnHZZMHTS+rJWyREf3S1JTo=;
 b=OklJ7ZilKDeyZ9kJ8VuNi3WFYKSooA7N12aQ8/IXM7S0kL+xxp589R6lS8zwrE0Ht1EEyY
 2n6Fh6xMzCD9Kv1SzPS4BBRmo7yYrvCVqtTmDpxyjS2lKepp9yDZ0dUkF09JrW3miN5USL
 pigpoaCfF1h+oTHLAhtFpx4Lknm/cz8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-d1rBBfHYMuubf9RUpSw7eA-1; Mon,
 27 Jul 2026 07:52:25 -0400
X-MC-Unique: d1rBBfHYMuubf9RUpSw7eA-1
X-Mimecast-MFC-AGG-ID: d1rBBfHYMuubf9RUpSw7eA_1785153144
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F16251955D7C; Mon, 27 Jul 2026 11:52:23 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C83CF1800611; Mon, 27 Jul 2026 11:52:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:18 +0400
Subject: [GIT PULL 09/23] hw/display/virtio-gpu: Fix empty blob discrimination
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-9-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2287;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=F4qIZ1V325eC9D8X2pTrZSJB39kji7EVJArdTLQMEHU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y/7Pm8LBD+BLn3UHioncJmUcNyYGEahTfUz
 5BtQ1Z56PyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPwAKCRDa6OEJdZac
 5apxEACVMCHXK/CuiKj+EzEkoBn9Qn8K94b78Zb/R6UU60sZYTN+vF2YocQKbM5/HGjfpsMWBfW
 XFJ1WTvTRjb2Lver+HNuhyPxUPGs1Ei885fsmdHYolIPC/Tw3bY+3Cs2jAzvbOEx2NvOpyi/IIz
 /NRpl1idoYhpJojhX2eKnNcRuD5BZQkjq3J7kepthEe/hSN6WploKEbMHZHGFd7ZRoraRRqTes1
 8yCwbTZTcRSScJ8ABMNQElaBIl34Vc+DBn+7K0LkNmxc7X7QQoY5IpKmWSe922W7PbXOwzAT5rY
 UKjS+h+VwWRiiyV3tX7k57IDJG9LHN2pgiiSlJCTUeTwwlVy49DwAqgyx6IzB5uEBl/l1GEpclc
 3kq9jbG12yl5YLr2QbnxDI9ZF4NpH/VcbQKyQ78sBfqNAwPRAO51hXxEUnu8wHl0/L31Pg7pSor
 NjIJoAAckdYDuNj1rr9ggl245MF74C004Hi8S4yuX1iMBQfPICeTTM4QkM3YgdUDyiZsPSLfW0e
 cIIObLfyLcjzdTjnRDrwwUpl5sh2CqjIQUaCPlNg1vyvmaLQyG/3eWcdXszxOv6T7XOjlg62yZ7
 9Xct0RyYNBt6Grta8PMuQ9I8rjDCJFzkjI6EAsdMKz46xCNnRRGZ6FlGeAR8EPNY8/jlkmv09yg
 tI9vLNlhJ3zXiqA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Discriminating blobs by checking whether blob_size is nonzero fails for
empty blobs. Identify 2D resources by their non-NULL image instead.

Fixes: bdd53f739273 ("virtio-gpu: Update cursor data using blob")
Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260725-image-v1-1-4698a805afde@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index eac039c3c366..add60926f366 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -56,18 +56,18 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
         return;
     }
 
-    if (res->blob_size) {
-        if (res->blob_size < (s->current_cursor->width *
-                              s->current_cursor->height * 4)) {
-            return;
-        }
-        data = res->blob;
-    } else {
+    if (res->image) {
         if (pixman_image_get_width(res->image)  != s->current_cursor->width ||
             pixman_image_get_height(res->image) != s->current_cursor->height) {
             return;
         }
         data = pixman_image_get_data(res->image);
+    } else {
+        if (res->blob_size < (s->current_cursor->width *
+                              s->current_cursor->height * 4)) {
+            return;
+        }
+        data = res->blob;
     }
 
     pixels = s->current_cursor->width * s->current_cursor->height;
@@ -1286,7 +1286,7 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
     assert(QTAILQ_EMPTY(&g->cmdq));
 
     QTAILQ_FOREACH(res, &g->reslist, next) {
-        if (res->blob_size) {
+        if (!res->image) {
             continue;
         }
         qemu_put_be32(f, res->resource_id);
@@ -1437,7 +1437,7 @@ static int virtio_gpu_blob_save(QEMUFile *f, void *opaque, size_t size,
     assert(QTAILQ_EMPTY(&g->cmdq));
 
     QTAILQ_FOREACH(res, &g->reslist, next) {
-        if (!res->blob_size) {
+        if (res->image) {
             continue;
         }
         assert(!res->image);

-- 
2.55.0


