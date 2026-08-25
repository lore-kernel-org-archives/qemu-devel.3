Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5C3C61DB4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoJa-00083Z-IF; Tue, 25 Aug 2026 06:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoJY-0007sK-S8
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:23:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoJX-0005rB-5k
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787653410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bfyr6qBs5Y+Qx1HUq/BkQtgFDr/r2UlyOodG7Hq24vw=;
 b=JbHUid8n1M1urrOfAhV6CjAUT2Howaw/dxJRQb+zCoyLt04MUYvQ4LbF7+dFsHYwqS/RGt
 RbJDbTaXjD/q54DeVi2KOSYx5e36yUt7tGXCtC8wBZ9r/XD0H04cYbw0rwvApzrT2+w8ts
 VJIPFTA2u2Juk3yBdm/sLSO15zRTYME=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-0eEqwPbxNAOO5jhV0f_EOg-1; Tue,
 25 Aug 2026 06:23:26 -0400
X-MC-Unique: 0eEqwPbxNAOO5jhV0f_EOg-1
X-Mimecast-MFC-AGG-ID: 0eEqwPbxNAOO5jhV0f_EOg_1787653405
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C78E1956050; Tue, 25 Aug 2026 10:23:25 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 540A85B1; Tue, 25 Aug 2026 10:23:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 14:20:44 +0400
Subject: [PATCH 07/18] virtio-gpu: release the dmabuf when a scanout is
 disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-virtio-gpu-cleanup-v1-7-d3bb612b9975@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1537;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=67Z0bv6AuE+gCsBGjRcXahvYiTOpF6YGA9WrwezNoqA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjWyYIE5TS+/hczyJj42v6TlP+2n594o37NeMu
 dRkVJ0dJXaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao1smAAKCRDa6OEJdZac
 5fW3EAC0meK5cXI5jv45jDhZJAHjd8aBEBc0iXejfxJdBYQQH9wEp/Fs2Vw00BsjMoT7/1dVX/i
 +aJGeLC9sRmwGeCx6eY5mgIzNSjuGAUb7zglYkbp5klEpb2HneYphOf9CbpLp970mByJm9e1UKy
 CfPbM35+5p/gjAHuj1XX69IxD1/RLrbP7jGmrmdYngBjc/56Bhe+DJ7T24Hir4TaceEbDvfLFXX
 qgUV8QX0d0WShc2D44RoTKXyOEY3MkC3cP58H1cuukaBudChdnGc1sgqrva1qRUzV2qyViv/wj5
 woB3c5ZSEhSsSGjqBlUyXaqWm0PwLWdwm5RD+cEBTiK8BjpvCJvKqZDbL+D9uq06h/UHejWgweO
 aQk/ccl9TvCHuI6db2+EBL4Nqf4kMCfkzu+PelmE1cN4uquvIHPpgKDdDJlFwh2FZLtaBhLagm7
 OgZhLmkxQitmN0frjxaY5pCruPla2fg5SM1cbdiIxTczXftgEE9UIZOETXymwMlGyjKV6r3GiMH
 r+PKoDJe3tX8H71L/2qjI2fL+LEwGewc3GPz3mWE8jUV3vMYVrKj7x6hE4O8feRpjKz4F2VFdVZ
 r46rHHLNLTXbM341IsOCv7ga5R+HHaueqx85otyfbKCNII9Qg/5yYgnA1AM7xGXz7/DV5Y1AOaT
 LdtBYUyjxW2TntA==
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

Rather than waiting for the next set_scanout()/update_dmabuf() to
replace it.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 0335b636068d..46ddfeeaba87 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -387,20 +387,31 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
+static void virtio_gpu_release_scanout_dmabuf(VirtIOGPU *g, int scanout_id)
+{
+    struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
+    g_autoptr(QemuDmaBuf) dmabuf = scanout->dmabuf;
+
+    if (!dmabuf) {
+        return;
+    }
+
+    scanout->dmabuf = NULL;
+    qemu_console_gl_release_dmabuf(scanout->con, dmabuf);
+}
+
 void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
     struct virtio_gpu_simple_resource *res;
 
-    if (scanout->resource_id == 0) {
-        return;
-    }
-
     res = virtio_gpu_find_resource(g, scanout->resource_id);
     if (res) {
         res->scanout_bitmask &= ~(1 << scanout_id);
     }
 
+    virtio_gpu_release_scanout_dmabuf(g, scanout_id);
+
     qemu_console_set_surface(scanout->con, NULL);
     scanout->resource_id = 0;
     scanout->ds = NULL;

-- 
2.55.0.543.g5ebe2ebe4ea8


