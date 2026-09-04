Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CD6C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Tgi-0003FV-7Z; Fri, 04 Sep 2026 09:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Tge-0003Eb-CN
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:10:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Tga-00050j-Hx
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZVQxPXRo2Mnt7IE+v54nLLeu+wwbmLgQ1Z8QgjQpdY=;
 b=Q2o0UZ7oehNcbSGMEBJncR0LvwHhboC/1VvoflKjmfUqIoSJBi2coQb04m0Gy40uu92+MV
 ephcL5oSH/7eJh+/cbSjwui/hIQJ0cRUNxPRdGIp+YLAu0Dk74JFlulIG2qGLnV0wbJPHj
 r13w1Tr7MGyUNkpS3DKeW4/Qb5YpyP4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-DiMR986iPRuZ8sB517YOtw-1; Fri,
 04 Sep 2026 09:10:24 -0400
X-MC-Unique: DiMR986iPRuZ8sB517YOtw-1
X-Mimecast-MFC-AGG-ID: DiMR986iPRuZ8sB517YOtw_1788527423
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1C131862D5F; Fri,  4 Sep 2026 13:10:22 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2493F427; Fri,  4 Sep 2026 13:10:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:06 +0400
Subject: [PATCH v2 02/25] virtio-gpu: fix use-after-free on blob cursor
 after detach
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-2-15b5ae6b0023@redhat.com>
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
In-Reply-To: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2428;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2X/5ilzIVjelS+4MXJn8US/LkdRyatM/dM7YRkwm0mE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMv2Liys2UqBOQUPaHimC4oZp5BxEBV4Vkd2
 E3Pz/sxfnOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDLwAKCRDa6OEJdZac
 5ZXFD/9Sa5NseKS+34HjCDQUsWboel3J7v6W6tPuFj08pdlJUyHRg6k2/8cdnlJu3dFClI7Jkf1
 klA8rIsy4pJ5/LmlDDBZhjHEBlPa/RO3iaNSW7g9Q+qW27K6yWEbrEVmcRpgD8hv9TsKKE9ulw0
 dkzwrH2fgdm2MAdIdVLRUNHHlWvAz1GVMEaTlH7RCqczxW47UsfsyUcq0nhFInDX0qPkdrBlkK/
 c4g1I6kXBqDC6d42ksKb3fty/Q+360lmV2H1aetMiv8vYpar40RdmHG8fHQPm+xgSkG59Q2UYHF
 NFmsssvCtTxfBE/zhGOZk5fQN5dGqkgS3awsCYR+cnc3b8QcZRnjM2fP4YeUfpFhAiUfOU68P21
 qC/89cV7GCSZLl5s9KWK80GtcJ6+47j7314zUPKEPXUKQ7Xg5iTh8W5E1WAPEBGlaDs2P+wm2/x
 bOWDMwxuvxFcpPVn0VHRRSV4mDzhYznY/6+3MRkYSjhGlxQmk2zMGFMqgGALAgvMVbanmOyXBGR
 3pWCy5/xzGVdQ39/FgYmvIMTeBZ7eVzoIxd333hKMx77juQrJ0f80UqA0L1jWfs257gvij5n+dA
 hgIo8cOkQ1v1GJrPZi9iWbS9wD+PwVuV0Md90dMcVuHpQ16DEWBri74/a5iuBG8zciC8fids+5e
 HVTWpryFzAbeRXg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
virtio_gpu_update_cursor_data().

Fixes: CVE-2026-66020
Fixes: bdd53f739273 ("virtio-gpu: Update cursor data using blob")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3881
Reported-by: 章鱼哥@aipy (www.aipyaipy.com)
Reported-by: swing <swing@mail.exp.sh>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-udmabuf.c | 1 +
 hw/display/virtio-gpu.c         | 8 ++++++++
 2 files changed, 9 insertions(+)

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
index 5b63a292933a..aeb6155130d0 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -61,8 +61,16 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
         }
         data = pixman_image_get_data(res->image);
     } else {
+        if (!res->blob) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: resource %d has no blob\n",
+                          __func__, resource_id);
+            return;
+        }
         if (!res->iov || res->blob_size < (s->current_cursor->width *
                                            s->current_cursor->height * 4)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: blob size too small for resource %d\n",
+                          __func__, resource_id);
             return;
         }
         data = res->blob;

-- 
2.55.0.543.g5ebe2ebe4ea8


