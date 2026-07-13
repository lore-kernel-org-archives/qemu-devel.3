Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAEDC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjGCN-0005fN-9X; Mon, 13 Jul 2026 08:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wjGCG-0005cQ-4v
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wjGC5-0006T1-B8
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783947330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SGcAcEenvRAVJNJVqbwP6Wkw8Og/DHA8zNEApkGHo4s=;
 b=BwrmrChMpB33giYak5xb+5b7nV7KyFfz2kkh2Zb8gaDmmU3AiIQh95ghxzxHIE0EGSFSuQ
 oCO5/UHzbEbuhgyb4tDFm2dOAg9DB4cu953LkREGCqA9pz3rwh2spYfgjf8JaCA8O3liWp
 09XFhLapoSWFQoAbzqeTSKLdkD8o5eU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-hDg3QBIkOzerHrJSJboMpg-1; Mon,
 13 Jul 2026 08:55:27 -0400
X-MC-Unique: hDg3QBIkOzerHrJSJboMpg-1
X-Mimecast-MFC-AGG-ID: hDg3QBIkOzerHrJSJboMpg_1783947326
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D32991955D8D; Mon, 13 Jul 2026 12:55:25 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89A8C1800667; Mon, 13 Jul 2026 12:55:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] hw/display/virtio-gpu: validate iov_cnt in migration load
Date: Mon, 13 Jul 2026 16:55:21 +0400
Message-ID: <20260713125521.109320-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Cap iov_cnt at 16384 in virtio_gpu_load() and virtio_gpu_blob_load()
to match the existing limit enforced in virtio_gpu_create_mapping_iov().

An unbounded iov_cnt from the migration stream drives two g_new()
allocations whose combined size can exceed available memory, causing
GLib to abort the process.

Fixes: 0c244e50ee12 ("virtio-gpu: add live migration support")
Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3753
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 88526051a99..6289bff9f3b 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -34,6 +34,7 @@
 #include "qemu/error-report.h"
 
 #define VIRTIO_GPU_VM_VERSION 1
+#define VIRTIO_GPU_MAX_IOVEC 16384
 
 static struct virtio_gpu_simple_resource *
 virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
@@ -820,10 +821,10 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
     size_t esize, s;
     int e, v;
 
-    if (nr_entries > 16384) {
+    if (nr_entries > VIRTIO_GPU_MAX_IOVEC) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: nr_entries is too big (%d > 16384)\n",
-                      __func__, nr_entries);
+                      "%s: nr_entries is too big (%d > %d)\n",
+                      __func__, nr_entries, VIRTIO_GPU_MAX_IOVEC);
         return -1;
     }
 
@@ -1323,6 +1324,11 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
         res->format = qemu_get_be32(f);
         res->iov_cnt = qemu_get_be32(f);
 
+        if (res->iov_cnt > VIRTIO_GPU_MAX_IOVEC) {
+            g_free(res);
+            return -EINVAL;
+        }
+
         /* allocate */
         pformat = virtio_gpu_get_pixman_format(res->format);
         if (!pformat) {
@@ -1424,6 +1430,12 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
         res->resource_id = resource_id;
         res->blob_size = qemu_get_be32(f);
         res->iov_cnt = qemu_get_be32(f);
+
+        if (res->iov_cnt > VIRTIO_GPU_MAX_IOVEC) {
+            g_free(res);
+            return -EINVAL;
+        }
+
         res->addrs = g_new(uint64_t, res->iov_cnt);
         res->iov = g_new(struct iovec, res->iov_cnt);
 
-- 
2.55.0


