Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4311FC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2ThP-0004np-Cx; Fri, 04 Sep 2026 09:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2ThO-0004kF-AG
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2ThM-00057G-3B
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dylo7uRlN2jGtbkt4NZGoGkiwnxIrYCu9WsQYWsaljE=;
 b=GjFtQeZhzz8MlmtGMfEEmLVGKuMgTT8vAudJyNsOTnAi4KQ7bb9aYRpoIFs2nZTa9mHphk
 xhwZzsh5JT/Flizu2p911H9vGxk4CxCBdeiFt7NOXrfwCaF8m9w8Vl6ucUy4vX7eW/ddWG
 v9tfsBmAQSnr54OO00f8wMZkhHhQQ/s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-U3kZN3UbOf-aub5n0WmIMg-1; Fri,
 04 Sep 2026 09:11:14 -0400
X-MC-Unique: U3kZN3UbOf-aub5n0WmIMg-1
X-Mimecast-MFC-AGG-ID: U3kZN3UbOf-aub5n0WmIMg_1788527473
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D812F195FCF6; Fri,  4 Sep 2026 13:11:12 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 561721955F10; Fri,  4 Sep 2026 13:11:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:18 +0400
Subject: [PATCH v2 14/25] virtio-gpu: release the dmabuf when a scanout is
 disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-14-15b5ae6b0023@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1537;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=G+Xs5SEHOp7PGnyBeL+nUCL9JN/NzEETW+C6fPka598=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMwFheo9Gf3g6VUTd87kEQ+9yngba7wFeNW5
 ytoeNhSCwOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDMAAKCRDa6OEJdZac
 5WLfD/9tMlPhjNoy325UJe3qw2pFo4LDj/wzOA/ue1Jvm4ZhPqWFt2SM93kjqh2MO+/ZpH0zstY
 fDnBJ0cn+p6klPap2bNsFWsoA8rIydbNcDf8X8YRelwgo9xGcSb/J0cTm1S466zVHpq9cNpcgHy
 Lq+jErJw1rmxds5V3dXXmShDipawsC1fgY2cxCeBhk473P5beoPoHm7Qsmn5paXpOHNMAZDCnlv
 /K8nE+JL4AZ6kNYkAPbWSm872uHJiqVTnKJACtL57Z3aUput9/fmC4P0xvtwWYvtvucDi1ippel
 canThvmYxB7XbwlhYc4Sg8u1bVD9szvRWT2Jxr+3NkzXNZdBKBLegB/IwHs9snl+/P6q//c9lRf
 NtjHFOfcHiAT1z6kNVVOmUTPzJ5NDhJZanXjAI6Dk72QTtzHCDmLKF/QINvVHgPHY9PrVPXIeSi
 qzeol1uShOYKJsmXiPVpfPMMthryQf6Fk2rZjFx9yNsynEnhtZVvPTkdW3kqJyqy616fKzQXGVf
 Xn7tGF5MfrJfckXJcF5JetwXz1rZ5YU7gQH5npQyE5ZrVrizZT9l50Zv5IZT4AW/KcKUyoyP2pb
 l1f58ZiaZ+ZHrNQzBPtWT9xb2V/FeMf4tDXRn5cUNhUUh92T0T8/yYc/xjx0bMGx8OIdzITMoqJ
 DcM+d/nvgTn4PfQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
index c1981efa5cab..95c905b4fec5 100644
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


