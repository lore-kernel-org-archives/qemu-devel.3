Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8A8C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4G6O-0004h1-AK; Wed, 09 Sep 2026 07:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G6N-0004eX-4H
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G6L-0005IF-Kc
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788951864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lIuJGnpVD5GH145GXgMfkdNa/VC4U9/ZZqHeHcYrX50=;
 b=CL9a5TwdIuQrK5JSI5f7Gw/Do4yvz2KkjFM2D4Kds6XpjimEttAh8DE3EXcaWno6YkWM93
 Gn/QG27455whLvs5GN1LInftb8Ku8leoqHppZMRTpnGvdJsrsE4JcI7Ynwzxf6l7O5Pcjt
 wj202sHZRazdPTPV8uUJ4BTL9gKwCIM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-GfFaxbQZM6ijAvDMHqZfkg-1; Wed,
 09 Sep 2026 07:04:21 -0400
X-MC-Unique: GfFaxbQZM6ijAvDMHqZfkg-1
X-Mimecast-MFC-AGG-ID: GfFaxbQZM6ijAvDMHqZfkg_1788951860
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5135F19541A0; Wed,  9 Sep 2026 11:04:20 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DCD8C1800473; Wed,  9 Sep 2026 11:04:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 09 Sep 2026 15:03:19 +0400
Subject: [PATCH v3 14/24] virtio-gpu: release the dmabuf when a scanout is
 disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-virtio-gpu-cleanup-v3-14-99266590e79d@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dZ2+WlnJ+Ih2ml2xkL8dChK2pCVpDNOwJQ4Wrb16+6s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoTzzNPIqhsp0/89e7FwplvaIUudcFtfxPw8Xz
 YkURv+SFGuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqE88wAKCRDa6OEJdZac
 5fujD/wPzlpkAygSQmmgmemRJbadw3Jvrx3SQbgVq2cuZmsRP3Upca8Xmk7UNWVtOGOE72VGIPy
 GIQWC6wawYJdZuHPw2npe7p5RcJebOXOenWWSzWK1ixwi9jTF1dpY+68UBtHJIcA09oPDgTq7M4
 UPJEbf1cwjRUhPd9oP7yUM/fCekMS+uLH3K1F1r76fPK5gr2LzZHqaZD+PoV7XaQa/NF2Z+trZd
 DB913A5xhT8130hRhDBKI8ASfqTfntv+xbwBEf564C1uQio0kS6EtBrmvOMmjgTvmmI3SDwcLLT
 MJBUgQcBrPc5QTdpLGJq+uY87Wt3ivQjCUtlBS9EfukFRXwVk0fAsnaF+RUQhChwRUOMyg+1kXt
 NuPITeTL+vd2wAEWkC2JhoPO7LTwdDTbYlEnIIfku6dGmIYizcJi1YZE8IpS2jVHqVb3QTIM9PD
 4BuNhi2z+XUEi5Nh+6Hyp48pvHcFLnL4PQSOFTQ70mP95hT45yE/wgkKXWo2gRDYM8oA87sn2Pr
 CFePVXMTjBEe6B+Gyb/FbHtQ5MrJmaIr3554y2sPs2SBiABWTkx5Zy2340E7AQ4FTCmLn0XD7pX
 XRIEqhYzfq8S/uljN9HQXGerKR/kpjD/QL+ndQ2quvt03yJ6EiN9IN7vvsVrjK4P/ooVNdG0VCV
 8SR3B6w1wx2snYw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


