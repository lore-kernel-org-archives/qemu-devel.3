Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D71BC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4a01-00054l-Ve; Thu, 10 Sep 2026 04:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zzx-00051y-CV
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:19:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zzv-0004xF-HZ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789028346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+LJpzE+RjjkgYSeQKJ5RVT1MCyaZWX7PVm9AyyDt/g=;
 b=Ke0dWo0t2jQ7+VziDCX1IpvpsYm9pDKb9d7KQd6iR4PZzlVm6LeC8zDA0eVjifDF3ukP0R
 ms6JgOGd/v8Ttobtb3g3Hg04fPlfJ3QiXb/kgWXSvaR1C3YFzvP6MA921RhS7JJQHP6Mob
 FjCcBbGVX7TuhRW36XJIUBBkxfGHpyw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-quR5506ZNeS2ggOMlB_HvQ-1; Thu,
 10 Sep 2026 04:19:05 -0400
X-MC-Unique: quR5506ZNeS2ggOMlB_HvQ-1
X-Mimecast-MFC-AGG-ID: quR5506ZNeS2ggOMlB_HvQ_1789028344
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 956E9195419C; Thu, 10 Sep 2026 08:19:04 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E5CE195608B; Thu, 10 Sep 2026 08:19:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 12:17:48 +0400
Subject: [PATCH v4 20/24] virtio-gpu: consolidate disabling scanout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v4-20-7d623714bd71@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2753;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vvVc9oWVlWehPCOEZBNwVLPKhD8ajquNxr7NNx8p86Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqomeoRzt/Rdx2/hp6kfRVamoQEsGK8MyJWpJpv
 GEHhFfOXm6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqJnqAAKCRDa6OEJdZac
 5bzGEACwHOsvif5RiZLlUxefhNCn2gNDN09FF4MHciNwF2fSCQqg9gLkQevfGx5xVtN+3tBz2ey
 99evedUNEsunmDReEVKBvIumAJkiGaDkkYd9OaMCVpf//m0ySgNfY9YzGjKMp18/GuhEGdAf68O
 vaUoV+kFukqhvJPFktHpFEYpVLF5btAE+GGI+v1azNgiQkc6jd1Psl4vJsLWsndP57W9Hi+sb6R
 k5lAHo/I5zpd6iaUQjL5+jLspwhRQJQ3wU+T4vtDfR2v/HWMBbojoP+2d6hOix1mGZTkFMFb2D0
 LlhaXct3Tu+seeDQc9jViP4Xx5kJNBndiJAM4MWxDmc2fRn/nyuw14+rMYOc3XoGsj5rOwRHnzX
 JAVs9+C2Bn1gZyscNSx9NPZsmV5RpHuvrc7YmEhSgPdG3NJwdFI7/I84DfNTULDOnMzWai3swEp
 5AjLL6aaf5hv6vExO+H5wNyELttveBnppgsUx4kgQ54ElVbdm1nIyk7AMofIAOBakRhItwpGs5H
 oktLBnB+XxlCXcMXM9c6P0a7O2gJPGO73cYAhwqJoadhB6LQ+4SR4dVEn/v3J0ANXYUaEis96Qb
 +heD5u+eJsV1ijSXbW1+KJowao709ct1CuLMW7uEFxAC2c2eICg0W5Zdv51N66BkUKtiaETEvsA
 JioQzZalndMkUyQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Use the common virtio_gpu_disable_scanout() to reset the scanout state,
including GL state if any.

Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c | 4 +---
 hw/display/virtio-gpu-virgl.c    | 6 ++----
 hw/display/virtio-gpu.c          | 6 ++++--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 8a82e96b7461..8697dd6936ba 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -312,9 +312,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
     scanout = &vb->scanout[ss.scanout_id];
 
     if (ss.resource_id == 0) {
-        scanout->resource_id = 0;
-        qemu_console_set_surface(scanout->con, NULL);
-        qemu_console_gl_scanout_disable(scanout->con);
+        virtio_gpu_disable_scanout(g, ss.scanout_id);
         return;
     }
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 07349c5c5502..9ca7b946ac65 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -618,8 +618,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
             ss.r.x, ss.r.y, ss.r.width, ss.r.height,
             d3d_tex2d);
     } else {
-        qemu_console_set_surface(g->parent_obj.scanout[ss.scanout_id].con, NULL);
-        qemu_console_gl_scanout_disable(g->parent_obj.scanout[ss.scanout_id].con);
+        virtio_gpu_disable_scanout(g, ss.scanout_id);
     }
     g->parent_obj.scanout[ss.scanout_id].resource_id = ss.resource_id;
 }
@@ -1430,8 +1429,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
     int i;
 
     for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
-        qemu_console_set_surface(g->parent_obj.scanout[i].con, NULL);
-        qemu_console_gl_scanout_disable(g->parent_obj.scanout[i].con);
+        virtio_gpu_disable_scanout(g, i);
     }
 }
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index f9083e9577c3..dc5b2da9a43f 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -435,8 +435,10 @@ void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
 
-    virtio_gpu_release_scanout_dmabuf(g, scanout_id);
-
+    if (scanout->dmabuf) {
+        virtio_gpu_release_scanout_dmabuf(g, scanout_id);
+    }
+    qemu_console_gl_scanout_disable(scanout->con);
     qemu_console_set_surface(scanout->con, NULL);
     scanout->resource_id = 0;
     scanout->ds = NULL;

-- 
2.55.0.543.g5ebe2ebe4ea8


