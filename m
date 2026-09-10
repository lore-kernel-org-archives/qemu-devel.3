Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD00C88E40
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4erR-00024x-Ve; Thu, 10 Sep 2026 09:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4erL-00021O-Fs
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4erJ-0003c8-7m
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789047032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TikkYz8c3/fNENa6pL9yhbMSpzGUiYvvtS6AgjEfV9k=;
 b=dxxj73Ov3hBjtROWjvzgDoB24GzKbZuScRNR6vFwUIJ22eSxBu6cTboHGq+9drQnIQBDGc
 nYqJy6KF4TXdGrUrwqDVE46vvqnlsRj1gBFliycLxbyBCC5bwh8nExnfOMvmlzBinHXctV
 vTDXb/uS9ExxdbDuGlhVVVjgApS/L08=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-8B61Bo0vO9eca2bTO6gxZg-1; Thu,
 10 Sep 2026 09:30:29 -0400
X-MC-Unique: 8B61Bo0vO9eca2bTO6gxZg-1
X-Mimecast-MFC-AGG-ID: 8B61Bo0vO9eca2bTO6gxZg_1789047027
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01D371954120; Thu, 10 Sep 2026 13:30:26 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32CBA418; Thu, 10 Sep 2026 13:30:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 17:29:57 +0400
Subject: [GIT PULL 02/24] virtio-gpu: clear res->blob on mapping cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v1-2-ccb8927a671e@redhat.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2329;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=PrgX7l2qQPAdPLNhPkM5aNrYf4ZSg/Qi9smSw4mXwxk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqorDbDEpXphDoWgugdhmZDyxSixfM252LuX5xu
 ex6ahSRtguJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqKw2wAKCRDa6OEJdZac
 5c6tD/sGOc+5EdoeIAUlcHpGcCOki+2n9ROuhk8xk8uNshfVTOw8JedNfuPjCzkc6pza53cmXWN
 o8nBoeXtNvl4H/Qtm+ee4IGzGLV9NGpnSzRFbR4LrT7yQ+kx8Or7JBm6tOkOyx5LZLzLskzavG1
 TLh/6cVsKe0XA7o77oDEM8r++hKivgOUZNOaQiEvwONK+qku8UDwYMklQP37ixtGxO9gAT2GeD9
 SlpuNeRZ2QVg8DS6CGO55x92FwIsm9sj7GAldJ/8yVECljcMrR4nF23uy6UGYDuuLBT5Y1DR7A/
 EMPvQUu9bL+jqAEhSKy6trVOTX3n28rKvG1UepytY7GRRF6WRtfTH+tgZkaIMH8/524ybbKX998
 3DlJMJWrPO+Y+lZpHK6MleGjblkYWs2I3JgLSI50tBC4iSrRDGYn43u7HON4R/a3FD+ghmV8Dp4
 892Rfznv7jrPIv9jGOVmsyAPhSUVWaTGGm2MkselmMh86E4mPZPRnw7BorhtggrTX3CKyZ6nxj5
 VGn/61p4B2wp/0nF2AJMn8KZnEt4cQOyLCLsGnozfJuZaNgis+AVLpr/wtxAy7a3gw/TpS+/gar
 TqkblX3NY/qBJUUZttP4+UJbC+e+7xXqTiaGRHR9n8eolZetVe01oxIlK3TSiE/QM2pLhdgWBit
 /FclK2r1ITfbIwA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

d3c2da174ca6 ("hw/display/virtio-gpu: Check cursor data presence")
already prevents the use-after-free on blob cursor after detach.

Clear res->blob in virtio_gpu_destroy_udmabuf() to keep init/fini
symmetric, and add LOG_GUEST_ERROR messages in
virtio_gpu_update_cursor_data() for missing or undersized blobs.

Fixes: bdd53f739273 ("virtio-gpu: Update cursor data using blob")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3881
Reported-by: 章鱼哥@aipy (www.aipyaipy.com)
Reported-by: swing <swing@mail.exp.sh>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-udmabuf.c |  1 +
 hw/display/virtio-gpu.c         | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index c230509852ff..03f0b29754e1 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -92,6 +92,7 @@ static void virtio_gpu_destroy_udmabuf(struct virtio_gpu_simple_resource *res)
         close(res->dmabuf_fd);
         res->dmabuf_fd = -1;
     }
+    res->blob = NULL;
 }
 
 static int find_memory_backend_type(Object *obj, void *opaque)
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5b63a292933a..3c3539e337fb 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -61,8 +61,16 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
         }
         data = pixman_image_get_data(res->image);
     } else {
-        if (!res->iov || res->blob_size < (s->current_cursor->width *
-                                           s->current_cursor->height * 4)) {
+        if (!res->blob) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: resource %d has no blob\n",
+                          __func__, resource_id);
+            return;
+        }
+        if (res->blob_size < (s->current_cursor->width *
+                              s->current_cursor->height * 4)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: blob size too small for resource %d\n",
+                          __func__, resource_id);
             return;
         }
         data = res->blob;

-- 
2.55.0.543.g5ebe2ebe4ea8


