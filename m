Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF169C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4G6m-0006Vv-TO; Wed, 09 Sep 2026 07:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G6k-0006O3-T3
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G6j-0005MN-7I
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788951888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dGh+L/jlT7Mb71Qal2ca84zs9ws1DPguDNuiiR+Ayw0=;
 b=XAapZNPsRth3YJA8uWrlk1B/WAfubK4n9CYvxYDOIDjT6B177FI2NTW8HgP/v70mnHHreh
 YW1cPXVcO68FtooHlRtfgCcr9Y9peZ7nyvNQCJx3uDYqvk9mE69iTdJ6QFsBCdMtHtYBFX
 LUgs5XINpIIedEoSjy+y58wfBTtcY1U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-jKm2KQ0rNHqaRwW8JOflng-1; Wed,
 09 Sep 2026 07:04:45 -0400
X-MC-Unique: jKm2KQ0rNHqaRwW8JOflng-1
X-Mimecast-MFC-AGG-ID: jKm2KQ0rNHqaRwW8JOflng_1788951884
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72BAA1800601; Wed,  9 Sep 2026 11:04:44 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 12BF41955F19; Wed,  9 Sep 2026 11:04:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 09 Sep 2026 15:03:25 +0400
Subject: [PATCH v3 20/24] virtio-gpu: consolidate disabling scanout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-virtio-gpu-cleanup-v3-20-99266590e79d@redhat.com>
References: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
In-Reply-To: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
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
 bh=fjAk7lTxT9/Ns71Yeyz4xpsvnqlRMTTqZ/qL+nEZtiQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoTzzSWF4ThxxPolPX1VBdV5c6I5epZYqlL09y
 fYWGu581KCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqE88wAKCRDa6OEJdZac
 5dP+D/9hop1cU1BcG7lQyuRRZEPIRofrAGQMgxnByM8e+0dQArZAASlhIm7ipgBzQm2t0CFFfKq
 0v50m+tnDK02hmxLC1hvD6tgbJ0JdeZZGHrmxeDT+dfIPrEDDv+XehS9xLpKSashw4+l8Brh4By
 qm9uXmWEU4Typm1n3Vj1ZyzBQaDzeutyab9bEXZFrZ0MvX1fE1hUGxu/IATCgV8HKwavWIKqKsF
 Oz11EOJnRxpbjPtc9YfpkymcL67kfwpLJCkeBQd0mM0Dtsymn4tftEvT8TEfHVw5hfLB6pm6OQF
 pwznmRe3/K9Gg1xL8Ih+gek5tbKacNswt8XujhAJegJnx3DWBgoMrh+PJXtj4F2gyrh54MvcGYY
 AIvqdMNtxOUwN6gHj0J5ry1VvIR4uKIIil1vRJ7Svf0Wp14r4Dv1kYhXCz1ofUZlK3nIwzFqLM0
 eJe116iWI13eNDedNT9+EcOU5hZFD7txqo3L4YphB4HVqVFvWiv4tIDbZFOxhIfRZoyNCQUxB7D
 u52RA7wHtDy/KQeB2oCuAy2kbTKRRf1XorB3gVEhlhc5upp2+pT+2jdnc/Kdgrl240zdCIJuxyt
 JAHUP0bR3sRhepqQCRyCHdJfX59F0TAzrq2dH/rw0eIgLiOBaQNwjXYsscq0g0IahLrorQjSVPQ
 hcdW/p2LX7ArW/Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 127.0.0.2
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
index 79d4c0b569fb..87d1fc3d5f65 100644
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
@@ -1426,8 +1425,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
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


