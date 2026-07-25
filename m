Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE775C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 11:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnahK-0007Kq-Ti; Sat, 25 Jul 2026 07:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnahJ-0007Ki-J0
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 07:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnahH-0001XY-Bu
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 07:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784979457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/QBAVm71+LT5IEToO5+AsB8dyFHbhSxkCmj9V0OUr7M=;
 b=TInhQDufQ/Z8WbzZgphJSQvOgCzX2UKknpbK1Htom1x/rLzLikG+VRvR3gL/AuH1KTCPYP
 KJSh8zmaxiuvMlhyNoy+JIH7GV2BjqBmVfCb63ZboOA3UgeFaRfhf28oolQGfRGDbiI1zo
 Syu2cHLxvqReLcMxuRwUaf8JIUNOH4Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-QcJmEuPZML2qne4u2BZInA-1; Sat,
 25 Jul 2026 07:37:34 -0400
X-MC-Unique: QcJmEuPZML2qne4u2BZInA-1
X-Mimecast-MFC-AGG-ID: QcJmEuPZML2qne4u2BZInA_1784979453
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31325195604B; Sat, 25 Jul 2026 11:37:33 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B15D1195608A; Sat, 25 Jul 2026 11:37:31 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2] hw/display/virtio-gpu: fix use-after-free on blob detach
 backing
Date: Sat, 25 Jul 2026 15:37:27 +0400
Message-ID: <20260725113727.1692271-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

virtio_gpu_cleanup_mapping() tears down the udmabuf mapping (or, for the
small-iov case, the guest memory mapping) via virtio_gpu_fini_udmabuf(),
but leaves res->blob pointing at it afterwards. Once a blob resource
goes through RESOURCE_DETACH_BACKING, res->blob is left dangling while
res->blob_size is still non-zero.

virtio_gpu_update_cursor_data() only checks res->blob_size before
copying from res->blob, so UPDATE_CURSOR on a detached blob resource
makes QEMU memcpy from freed memory.

virtio_gpu_do_set_scanout() also creates scanout->ds over
res->blob + fb->offset. RESOURCE_DETACH_BACKING leaves that surface
installed, so a subsequent display refresh can still read the backing
after virtio_gpu_fini_udmabuf() has unmapped it.

Disable any active scanouts referencing the resource before tearing down
its backing, clear res->blob afterwards, and check it before
dereferencing in virtio_gpu_update_cursor_data().

Fixes: CVE-2026-66020
Fixes: bdd53f739273 ("virtio-gpu: Update cursor data using blob")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3881
Reported-by: 章鱼哥@aipy (www.aipyaipy.com)
Reported-by: swing <swing@mail.exp.sh>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
v2:
 - disable active scanouts referencing the resource before tearing
   down its backing, fixing a second use-after-free through the
   display refresh path
 - add LOG_GUEST_ERROR for the blob-size-too-small early return
---
 hw/display/virtio-gpu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 211a529ed720..b21ac8dace08 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -57,8 +57,16 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
     }
 
     if (res->blob_size) {
+        if (!res->blob) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: resource %d has no blob\n",
+                          __func__, resource_id);
+            return;
+        }
         if (res->blob_size < (s->current_cursor->width *
                               s->current_cursor->height * 4)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: blob size too small for resource %d\n",
+                          __func__, resource_id);
             return;
         }
         data = res->blob;
@@ -969,6 +977,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
 
     if (res->blob) {
         virtio_gpu_fini_udmabuf(g, res);
+        res->blob = NULL;
     }
 }
 
@@ -1031,6 +1040,15 @@ virtio_gpu_resource_detach_backing(VirtIOGPU *g,
     if (!res) {
         return;
     }
+
+    if (res->scanout_bitmask) {
+        for (int i = 0; i < g->parent_obj.conf.max_outputs; i++) {
+            if (res->scanout_bitmask & (1 << i)) {
+                virtio_gpu_disable_scanout(g, i);
+            }
+        }
+    }
+
     virtio_gpu_cleanup_mapping(g, res);
 }
 
-- 
2.55.0


