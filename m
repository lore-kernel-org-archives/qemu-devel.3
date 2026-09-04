Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F406AC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Ti7-0006mB-SU; Fri, 04 Sep 2026 09:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Ti2-0006dw-QB
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Thz-0005Ez-W6
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7+kWJumHiGoESszyyHPgWEThNe8AKRBcx3EKAf8V+Q=;
 b=G0ldDOffmxh7/IE8s43LEWizxMAOCYTP1WO0gFvwFCtjbSGcPhsMGndrMp8hEK6kumSb9d
 s4run77yzXxepB41eF3p+4o6pHVuJQv0svlgrS1q9CIJxE3OoqGGExZZ/Jb44O1lbDXNDP
 OeLtL7QN/S8CYWgnFQwg5KvTfJhnbPs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-O9OtoM1NPPKzaAixa9lgGA-1; Fri,
 04 Sep 2026 09:11:52 -0400
X-MC-Unique: O9OtoM1NPPKzaAixa9lgGA-1
X-Mimecast-MFC-AGG-ID: O9OtoM1NPPKzaAixa9lgGA_1788527511
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4F8E190561B; Fri,  4 Sep 2026 13:11:50 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7BEE427; Fri,  4 Sep 2026 13:11:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:28 +0400
Subject: [PATCH v2 24/25] vhost-user-gpu: release DMA-BUFs on scanout
 disable, reset and finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-24-15b5ae6b0023@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2574;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KyLeK/1UDKjo+OdCRBTXB67t9Vi4GdvzCZHlivAn0Ng=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMwS+iuZ4Ko7ueMQz1EVkt0nJ0zc96F9mJFy
 CTQy2t0FY2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDMAAKCRDa6OEJdZac
 5YxND/9izhMa4X+7vxbDjyibJjyb1VRpepzrbLnJI/EHucNKlkr64GoWK3KQk0kuEy2sjacGoz+
 6d3O97JgVCphM6SFVCnhjUNA1KFlzJPaLq1kzI9pyEGOk36eN/Rg1UAq2FdS1/wLNfCyqdiMn40
 uogqYM2W7ejO46aeIGyJCCoE42v+tAbnrlqoBk+wBxgCoSKZWWaHzkNQWnMSCHlxsTrRbfEED7C
 xi08tD3tp3KvUdq7CX5YYyNpWHiAc66fJTRNJU4zMeYYtuo9oOKeNXBG/WRfQW5lu0jG5ZHK5TI
 tU8DJY3Wt9+BfVnHcOZk4EcZ1O9YCx448V+KLYrGFYInQSR5n96DRQenI/U9CIz2uBpHqlK3oPl
 GvFGb5qkKg92e7ug7FTFRcZY06AK+0xDo3yiaQ3JFzX/X4sm74GwxZx2w2I/SKOOry6feYkGVgp
 n6kIv91bYOTnYVpujD+rY5uwzONHmo1Uq3rEQGOVfNYg4Gngn7plH18tYWf8W8KNIUCYixAtHh4
 Nkh3WBbDXpwmlkriIZ8gAHQbPbtCeVsDgH+Q1Gpb+Vs0e18IHh9p03yl4uKal6DQ9IEU7YA7120
 s/UJAn5ZxEBpvNFhtcLFs4aA4ygJT8dbzCfw0SDwTJmSYqVXC/j+1xMGuUO5mjG99I/N8XAx8X+
 NUXGrPsoJ/gZn3w==
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

When the backend sends VHOST_USER_GPU_SCANOUT with zero dimensions to
disable a scanout, the frontend only calls qemu_console_set_surface(NULL)
without releasing the g->dmabuf[] entry or invoking
qemu_console_gl_scanout_disable(). Display listeners (GTK, SDL) can
therefore remain in GL scanout mode and keep redrawing the stale buffer.

Release the DMA-BUF and call qemu_console_gl_scanout_disable() in the
SCANOUT handler when a previously active DMA-BUF exists.

Additionally, vhost_user_gpu_reset() and
vhost_user_gpu_instance_finalize() never iterate the dmabuf[] array, so
active DMA-BUFs leak on device reset or object destruction. Add cleanup
loops to both paths.

Fixes: 267f664658fe ("hw/display: add vhost-user-vga & gpu-pci")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vhost-user-gpu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index c09aca041135..3f1fd333eeab 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -263,6 +263,11 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
         con = s->con;
 
         if (m->width == 0) {
+            if (g->dmabuf[m->scanout_id]) {
+                qemu_console_gl_release_dmabuf(con, g->dmabuf[m->scanout_id]);
+                g_clear_pointer(&g->dmabuf[m->scanout_id], qemu_dmabuf_free);
+                qemu_console_gl_scanout_disable(con);
+            }
             qemu_console_set_surface(con, NULL);
         } else {
             s->ds = qemu_create_displaysurface(m->width, m->height);
@@ -631,6 +636,10 @@ vhost_user_gpu_instance_finalize(Object *obj)
 {
     VhostUserGPU *g = VHOST_USER_GPU(obj);
 
+    for (int i = 0; i < g->parent_obj.conf.max_outputs; i++) {
+        g_clear_pointer(&g->dmabuf[i], qemu_dmabuf_free);
+    }
+
     object_unref(OBJECT(g->vhost));
 }
 
@@ -639,6 +648,15 @@ vhost_user_gpu_reset(VirtIODevice *vdev)
 {
     VhostUserGPU *g = VHOST_USER_GPU(vdev);
 
+    for (int i = 0; i < g->parent_obj.conf.max_outputs; i++) {
+        if (g->dmabuf[i]) {
+            QemuConsole *con = g->parent_obj.scanout[i].con;
+            qemu_console_gl_release_dmabuf(con, g->dmabuf[i]);
+            g_clear_pointer(&g->dmabuf[i], qemu_dmabuf_free);
+            qemu_console_gl_scanout_disable(con);
+        }
+    }
+
     virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
 
     vhost_user_backend_stop(g->vhost);

-- 
2.55.0.543.g5ebe2ebe4ea8


