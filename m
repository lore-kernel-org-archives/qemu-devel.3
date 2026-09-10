Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D58DC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Zyu-0003Ga-Kt; Thu, 10 Sep 2026 04:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zyt-0003GS-Pa
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zys-0004sK-2n
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789028281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TikkYz8c3/fNENa6pL9yhbMSpzGUiYvvtS6AgjEfV9k=;
 b=iLO6UijDC6biPc2uaYlzOL7LgZky8fF38GF+DRZLtIwHCnVe8M/GdChDEOikamd4kLQpf8
 DzIti/6mA6juG3owGD0GdtufCzkMGORzf25h36qvD8/VWtBC3F3eO7FFHu0AS2Dc22YUXG
 FMhjRlSYnY3MUYpncaVmx7hO+9Un6vo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-wP3r31ByMMKTrUigo3GhkA-1; Thu,
 10 Sep 2026 04:17:59 -0400
X-MC-Unique: wP3r31ByMMKTrUigo3GhkA-1
X-Mimecast-MFC-AGG-ID: wP3r31ByMMKTrUigo3GhkA_1789028278
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1240219560BB; Thu, 10 Sep 2026 08:17:58 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5DFA31800351; Thu, 10 Sep 2026 08:17:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 12:17:30 +0400
Subject: [PATCH v4 02/24] virtio-gpu: clear res->blob on mapping cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v4-2-7d623714bd71@redhat.com>
References: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2329;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=PrgX7l2qQPAdPLNhPkM5aNrYf4ZSg/Qi9smSw4mXwxk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqomenYeS4ZfzYPUeiv28hNvQ2Fkvdhba2XhF1n
 KGEBKbMcBmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqJnpwAKCRDa6OEJdZac
 5brID/9pDElyhn6OYb/zddKn3Hrh1PspZo8YD+zfm0OYwVyf2Jc5Cq6buZ9jxGnpuOt1mcCR91A
 zdY/AM0rkTYCz6La4nz6VH7Ozs524iFj6G8KvH5k4CmAXVIsVe/37eAGRZ4TVQxDPDjZrz24Xdy
 3Rk934V1uzceh7hF9IDmk5fza7LVmXM+Vr53jrkvYYjpoj60XPnXX8UO3K/+hqBzw2x9dDMrZyZ
 A95ENLAX0Bp6C6Ernvc356J889k7nz1FQ5GvqPF0Du9MCozSkHat20cDUh0fgvhxFzdlDpIctym
 t10/NMUdACHg7XRBJQPVQyyqrJkpy5px+IRrD46AyaefjmXrkBjV1+usY44VmReYiU81PsGUgy7
 LVuYOvwwbzxtPYWKWOd4yhCEamB5nFkiWojP/JEGZ/FDaPzLYfe+Zw+X+908ZuHCsPtc+sYkS6i
 /Fp5Qyl1pblCeaVMuqmHFqE3sGExv73MZKdRvXTxscjAfP6uJw0LqsMEuU9CZFD1m4HiT5muRpc
 QWxygAyCbArdmvd8NwARJHnmmlOCHIfvwBlyrKaidogpbByGf7LRJ0MsSbH0AUdSmtgsAKUlBIc
 dEzg5ARqf9r05m2/ay5oaargtzmaJNMOZLTVNL8SxW2dQtilH63rBhMNViaWL8BUUts9D+owr92
 viAQSBA+oGziwSA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


