Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB0AC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4est-0006Uq-Ig; Thu, 10 Sep 2026 09:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4esq-00068h-66
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4esm-0003zC-R0
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789047124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MvNyUJjuFzcqC2iFaLkKRxphw3kHwaQNe4NAJWBqFPA=;
 b=YZr1J0AzfMeq4h0gHszUOOlpCCXkPVNn4Sx/OkeUqE1nm9TApm5ZsJ2UUYNJ9DKvWwGDuM
 MTN1+GMZig+tuO+NC0u2ZBKmlG1vLQOLRYpAZqXKimR5jA2wJktuK+HspT3yS23ndU9VxD
 D1uExCevrXZWXyM8dIgMGcdZ+u2Uwrs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-FroBou5PPC-PNzmLIr58KA-1; Thu,
 10 Sep 2026 09:32:00 -0400
X-MC-Unique: FroBou5PPC-PNzmLIr58KA-1
X-Mimecast-MFC-AGG-ID: FroBou5PPC-PNzmLIr58KA_1789047117
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEE401800107; Thu, 10 Sep 2026 13:31:57 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 418171800473; Thu, 10 Sep 2026 13:31:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 17:30:15 +0400
Subject: [GIT PULL 20/24] virtio-gpu: consolidate disabling scanout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v1-20-ccb8927a671e@redhat.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2706;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7XLRL3MdrOOrKTPpYXgRLHhm68Cq391ch99tcYm3POg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqorDdFdvz7vclGkwsM6vrF7X6wU/bv/GLny2hM
 jZU2V8r3/CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqKw3QAKCRDa6OEJdZac
 5ToMD/0RP9n02V6/IICJ6UgeG3rn8wUo/dyXiLKezt+HrjCNzjmf0TCqWSU73EH/p0Yaal+Guir
 bbaSjLyshwn49HsO4auP+tswpBO5NWTWLs4OV+R3VDp/hrGgtld2GyHpXz/+Ln9C318yA7wUHyt
 VcCZxoXon340EOl3+Wr0plOU/ky99ter4hU8GzAXJ1OeAF8VEJGB+wFTI6pIOYM7m2LNvbjwKXN
 cPycoqLO+DcGZWfE5G76iRlnShltqJG32rAQAicDNfG73tTWIidBY1sarS74CjPKDR9jI9t9kWE
 KwiVatGXdrMh7WSBLeL7SZbO9ZRR4ZFgN0FColSwKH2hWFG4nCVn02CUXvRe120i8Ol7aM/+SHX
 oDYXOHEaOCyMULCgjogXksmwrf1LwVSJg8xfTp/AIlWqC2y0snFk0aba5sj89ttIh/4h3xtgZVX
 wf9pVZ3f1qt4vlby8N9JwDSg0lGxS1xqKPdVQ1f911JRVd0IrVubERDBe4sy/ZNBPOTBAwGEUaJ
 JIASnmoj5kirv4w8VGXfZPUmBVxdNeN3XV3wvkW3uvfq79WwVsThxZ+EYsedUPz1szZsAsOuiny
 qIfL6ZwkCevz06pDusyd8V18DLaT27B5AFaoMkKGG98VghhLvcz4zJ5IHSmSlmNCO0sVabh+XXq
 bIMlUp7x5xyf6/Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c | 4 +---
 hw/display/virtio-gpu-virgl.c    | 6 ++----
 hw/display/virtio-gpu.c          | 2 +-
 3 files changed, 4 insertions(+), 8 deletions(-)

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
index f9083e9577c3..e8a0dd24c873 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -436,7 +436,7 @@ void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
 
     virtio_gpu_release_scanout_dmabuf(g, scanout_id);
-
+    qemu_console_gl_scanout_disable(scanout->con);
     qemu_console_set_surface(scanout->con, NULL);
     scanout->resource_id = 0;
     scanout->ds = NULL;

-- 
2.55.0.543.g5ebe2ebe4ea8


