Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524C7C61DB4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoLf-0003VI-1m; Tue, 25 Aug 2026 06:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoLZ-0003MR-DW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoLX-0006a4-6m
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787653534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BMfBJFqDWXEV2/l2gMeGl2Po7R746yvHs4Ale2Jl22Q=;
 b=c0/AuVs9lWiZEyjB9BZuQbpWsHUZuaPkdWKrOFdHWlbilExQbHXuLUhNTI/F2FP1wtmFHG
 JxHV9/7jWCeHts2J+WlT5NB/CFI4VPHnJADDMOu2Iva424uEIpemwPkVuKs7OIsQ/CM+qU
 u7HwYKHzpa9Ia3j8IkgasrVzMHKnLPU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-ybHGQDZHOeKJECkOlmUd2A-1; Tue,
 25 Aug 2026 06:25:31 -0400
X-MC-Unique: ybHGQDZHOeKJECkOlmUd2A-1
X-Mimecast-MFC-AGG-ID: ybHGQDZHOeKJECkOlmUd2A_1787653529
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 684051955BDC; Tue, 25 Aug 2026 10:25:29 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3AAEF19560AB; Tue, 25 Aug 2026 10:25:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 14:20:55 +0400
Subject: [PATCH 18/18] virtio-gpu: fix use-after-free on blob cursor after
 detach
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-virtio-gpu-cleanup-v1-18-d3bb612b9975@redhat.com>
References: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
In-Reply-To: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 swing <swing@mail.exp.sh>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2741;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Zr8g1ctz3quUiR2sNqkEx836TbwwFf/BJ00Qv1bzHR8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjWyZl3RaO1dTKKRZ2NE2xWaOZv0h6Ntgb/5/Q
 kLRHCg9Xf+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao1smQAKCRDa6OEJdZac
 5R7LEACcIBFvhJgZCFrkf6ECujINT4JpiitzywOciHCWyeikhk5iP7uuipSRaJzeGvV4+snTyAF
 xJK1Ptz0Zd9LeLtrEzvQ8/0/IP5m/Ro9+XCrw/xz5cRJyHZc2CpUby+eAvnXoYCldqaZyjQNP+M
 9EH7r7OnjmQj3NOphiWcKhoE0RGwUbNZGmOYPj+1FViWEutTKzFHQid2vlOI7ec+fM+qs7Y/rYp
 LTOXHLTc9/JUf9KFL4f0uNKBSEJzZEU7O1/hRE8KDrVwvZqa6coq4IakFkFP6687Cc1Fq7EoSEh
 PxZk341wKiQ0M2fXV9nHYXeWoypYR+GSZQUItFxhMOfqKtRXfbND7CR4Iai6nsfvGpEyxDPPrHW
 O/WqHNT7VpaPu46hA7GR6ji27oif8yBQLqKZOMt2QpjRLQ2j6RUf02vRiHEJ6nqpet+qg9iBWfe
 169edY8nHEjj8w5ZRApLKJ+4QxOVbX9PCdgv5Q3CGMaZnKx/cPKqUuAn6nA6ZW625t72CeRJr/1
 6MyQkudKtZmVdyNez/8u9pKCh86jaL3iYx50I5557tHspJf9wt1N9YZ01niFFWc78XfG5zMxS+x
 v3jsVta+jU96cP3HnwaBPuobaLRnJ2IBgI3SG3J18QIvBNjjyo/UOw2zTIcY7CbzDKW0AWFf8he
 AtKBx/34YhCL9rA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

virtio_gpu_cleanup_mapping() unmaps the guest IOVs and tears down any
udmabuf mapping, but leaves res->blob pointing at the freed memory. Once
a blob resource goes through RESOURCE_DETACH_BACKING, res->blob is left
dangling while res->blob_size is still non-zero.

virtio_gpu_update_cursor_data() only checks res->blob_size before copying
from res->blob, so an UPDATE_CURSOR on a detached blob resource makes
QEMU memcpy from freed memory.

Clear res->blob after tearing down its backing, keeping init/fini
symmetric, and check it before dereferencing in
virtio_gpu_update_cursor_data(). Simplify code by dropping a needless
condition for calling fini_udmabuf().

Fixes: CVE-2026-66020
Fixes: bdd53f739273 ("virtio-gpu: Update cursor data using blob")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3881
Reported-by: 章鱼哥@aipy (www.aipyaipy.com)
Reported-by: swing <swing@mail.exp.sh>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-udmabuf.c |  1 +
 hw/display/virtio-gpu.c         | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index 4e9806f82144..3bd6a77730cd 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -89,6 +89,7 @@ void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
         close(res->dmabuf_fd);
         res->dmabuf_fd = -1;
     }
+    res->blob = NULL;
 }
 
 static int find_memory_backend_type(Object *obj, void *opaque)
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 521d4800d872..87823b2cd5af 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -63,8 +63,16 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
         }
         data = pixman_image_get_data(res->image);
     } else {
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
@@ -992,9 +1000,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
     g_free(res->addrs);
     res->addrs = NULL;
 
-    if (res->blob) {
-        virtio_gpu_fini_udmabuf(res);
-    }
+    virtio_gpu_fini_udmabuf(res);
 }
 
 static void

-- 
2.55.0.543.g5ebe2ebe4ea8


