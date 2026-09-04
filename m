Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166E3C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Thl-0005qb-CJ; Fri, 04 Sep 2026 09:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Thj-0005jf-JW
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Thi-0005Bs-30
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCNMy2CvVf79esuze58qFl+MHajxnyU48srBBmsZXqc=;
 b=LekMdxLCqqWFB5/HA7OkfmsiP4EtVXp9/JmlB6ZC0BihzrEdgobEgcg2TF0Mv0Xy4c3VUv
 VgVGvbclech0gJn6WBZbXGNvqRCybJp7SSZsuiCxO1KWIlQppDBC9e8TSjMDFqPLsihJQf
 bn2UWYC7ekwlOyhnWxR8wZP5Hk6QSzk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-1ZHmQ0fYMgCZ4jotAIFwpQ-1; Fri,
 04 Sep 2026 09:11:33 -0400
X-MC-Unique: 1ZHmQ0fYMgCZ4jotAIFwpQ-1
X-Mimecast-MFC-AGG-ID: 1ZHmQ0fYMgCZ4jotAIFwpQ_1788527492
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 271C918CD289; Fri,  4 Sep 2026 13:11:32 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C349A1955F00; Fri,  4 Sep 2026 13:11:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:23 +0400
Subject: [PATCH v2 19/25] virtio-gpu/virgl: release dmabuf when a texture
 replaces a scanout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-19-15b5ae6b0023@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2326;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eW7Q8CWWp1NbLU+0pwDCazy7H8yDhaZDMn306wrFAB8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMwKvdNVgzAEaqFyjI+xGJp4ZJb/OYOV86CG
 B9Bm8jptkWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDMAAKCRDa6OEJdZac
 5dbHD/wI3JMFuyCFjliZK6lQWP7kwxrwOCU9ovd5FNr5ilkRL/EJWQs4m8WEUPsb1XJquRAPZLq
 FG+iCG+73B8DjL7fVRk257K1d1Mi8C4doimGlmJkjiaH07U+2kmdgWc7Ju/Lji+olRjqqjxdfx6
 YTOkQxtaqGvO5fJgGuN488ANZxbtj+wzwTOHSjCae5nPSiYIdKDoopbd5oqzywP4A7oOe9dpRMp
 qxFOZMCX8Wk5lJ19gl9t3bU9rpoqh7jsFhtWt22DQYpIkkWtmol/1ZnsVm8VECd/uv5wo38O5+c
 EaUS8FzRzMd/ktgqTuXATX7H6t1RrknZ/2XjyPlyazLQyw0VFE/QYE1qAEiNy7Relu4CAX7gtuq
 GIVD7zh2iUdr57koqGJu/v/c+IBwv9Bg+JHeDbDPRYRBQCKlzNFTHgO5blt3rEceW9nc+mSgd7D
 Dco5Kx7wmirObQojENg4KonGck3OSKwy+Kdrj7hUDzRWscYmG1pgq4ZpRIjFC6422LN8R5uIijA
 43tWOjQivewlY9LLMIKVPF2cRpGK4r/VqhCQapmw0MCCdtyQUTTVF5Azh0QoeXTMaBYEpQPssAQ
 0PJY9jKN39zf4Zov5itmNEf8VJ4qhRb+NPRp8zlb317UiP1pYqe22SWTQjnjuB3Vc9WVpOhT3Z2
 Ih0Ttucw7bQc2Ug==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Release the scanout dmabuf before installing the texture. A full
virtio_gpu_disable_scanout() is not used because the scanout is
reassigned immediately afterwards.

Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-virgl.c  | 3 +++
 hw/display/virtio-gpu.c        | 2 +-
 include/hw/virtio/virtio-gpu.h | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 7f1d1e0c3276..79d4c0b569fb 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -605,6 +605,9 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
                                              &cmd->error)) {
             return;
         }
+
+        virtio_gpu_release_scanout_dmabuf(g, ss.scanout_id);
+
         qemu_console_resize(g->parent_obj.scanout[ss.scanout_id].con,
                             ss.r.width, ss.r.height);
         virgl_renderer_force_ctx_0();
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5c3cd2fb4616..ae1f87ad68b2 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -418,7 +418,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
-static void virtio_gpu_release_scanout_dmabuf(VirtIOGPU *g, int scanout_id)
+void virtio_gpu_release_scanout_dmabuf(VirtIOGPU *g, int scanout_id)
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
     g_autoptr(QemuDmaBuf) dmabuf = scanout->dmabuf;
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 071cbbb6113e..2f18d839ccd3 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -371,6 +371,8 @@ bool virtio_gpu_check_scanout_bounds(uint32_t scanout_id, uint32_t resource_id,
                                      const struct virtio_gpu_rect *r,
                                      uint32_t *error);
 
+void virtio_gpu_release_scanout_dmabuf(VirtIOGPU *g, int scanout_id);
+
 /**
  * virtio_gpu_scanout_blob_to_fb() - fill out fb based on scanout data
  * fb: the frame-buffer descriptor to fill out

-- 
2.55.0.543.g5ebe2ebe4ea8


