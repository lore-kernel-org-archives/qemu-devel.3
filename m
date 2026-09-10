Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EBCC88E40
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4esK-0004Vg-VI; Thu, 10 Sep 2026 09:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4esJ-0004MR-8y
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4esH-0003jH-So
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789047093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lIuJGnpVD5GH145GXgMfkdNa/VC4U9/ZZqHeHcYrX50=;
 b=J6lmdRDJ9RI1ls6Nrh1EHVpFm6TR1Roggo/JdHEdnUj0UWdFTy0oHj7GRE5XMwDtGMkPfi
 BcarmhBOFdBEou3ITZsHR7j4DkEm8NSQVyWuRuk/wjLecRtODZW3sc3XIRSMdog8V84n4E
 P/0QLOwymxf9FM/i6jyCrDKq7MnHX30=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-GtbyktVrM1y0OT6PKxtMLg-1; Thu,
 10 Sep 2026 09:31:27 -0400
X-MC-Unique: GtbyktVrM1y0OT6PKxtMLg-1
X-Mimecast-MFC-AGG-ID: GtbyktVrM1y0OT6PKxtMLg_1789047085
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE4FB1800767; Thu, 10 Sep 2026 13:31:25 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A4B946E; Thu, 10 Sep 2026 13:31:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 17:30:09 +0400
Subject: [GIT PULL 14/24] virtio-gpu: release the dmabuf when a scanout is
 disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v1-14-ccb8927a671e@redhat.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dZ2+WlnJ+Ih2ml2xkL8dChK2pCVpDNOwJQ4Wrb16+6s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqorDcRcQrt47SiwbP8TsdhSdV8m3GqfqBwCzak
 NYjo3tXtr+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqKw3AAKCRDa6OEJdZac
 5cLGD/9+ZhiSmfSVvxVuW/QMkpqZYLLV2T1y64YF5CPYoHQ5WetVPRu/NhW6NyIpy4+PrO1mbfY
 uuaoZUKgfacjQdAhoa+oGo8Gk6LVLwIyXz6Q0TCEBz8/jM9BVrGLAeOzpLwsc1IRgEXpvYSgv1e
 NFx0LInJ8bA9Dt6HbGzxNgBajcu+E2D4bInSo8VjsnzkMIu4a8Cn8z8sX75GDeWsYzWplYGFsFz
 wgFd7hnwte7XSCCU1SgmNiPswlJqPlBCNMd+h91t2tqPARLJaByKMez/stvhlZTZQ+hZ/nKZNEb
 ct2RVTPTIf0rERWtmOv6t9D4U2k9oURn622KEPwGxUQkt2RXXsniG9tY5yF41UoKh9E21DuPlhg
 PM/8/ySqMh0J4NZJDWmZdWuDEecGZD+NY3cVGQsGrWmP6rBf/NXdEiCGNdO0tZA7A4k4vSM2Ha4
 4aJhTvpOYbOdcztlJr3fI4Xc+VZK+7PFNaI1qZn5YwCQFsc4LnheJ8liMP6CEppQfvO5b6DArw/
 6FJMvsYNRrw0duYXVIbI1/Ilt9oQS4+1hWEWQDleDTog/aBzMtYt5JHBqSxb1eoyDellMP8lB//
 efhaZHKcHO7VhfEsg9WOmwqC3ip3oF3hISpFV5KU71jYh+W7r7S0iqBnVMzYNmDGS+a6NlomvqV
 /BTf6ScEl7NlWHA==
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

Rather than waiting for the next set_scanout()/update_dmabuf() to
replace it.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index ecf3cbc4893c..bcde65b50349 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -418,20 +418,31 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
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


