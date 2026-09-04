Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73007C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TiE-00072u-HY; Fri, 04 Sep 2026 09:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Ti5-0006lS-SK
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:12:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Ti4-0005FT-7q
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rbRdxbD6P12CEVrbxoY+AhOP0j7nufFZ/uajBCMBXvE=;
 b=Ui7Ff6ic2nBfX0U9ZZ6u53Xb6NGmgXv+MQDuoArUoC7YAt90xc1EuMhRODhmAe468tcBzL
 vgnOA0o3472YfQ0hIKS754MEZhcgi5fWoRj1n4OUndQn206OKDAFh1wbUDhWNcNg8JfPNJ
 lpqtbP1a9vPdcC6M2lwFTRyDI+bl3o8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-Hb8ytDFDP4-VWUHgcnKEYQ-1; Fri,
 04 Sep 2026 09:11:56 -0400
X-MC-Unique: Hb8ytDFDP4-VWUHgcnKEYQ-1
X-Mimecast-MFC-AGG-ID: Hb8ytDFDP4-VWUHgcnKEYQ_1788527514
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C90FB18CD28F; Fri,  4 Sep 2026 13:11:54 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 364D01953944; Fri,  4 Sep 2026 13:11:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:29 +0400
Subject: [PATCH v2 25/25] contrib/vhost-user-gpu: disable scanouts on
 resource unref
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-25-15b5ae6b0023@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1484;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VhBqERV1PpBBS/4qnNZnTFB5pbaJRCUO4hEvGx6g398=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGqawzCi5EBg/W8EvwTdwYXJSah4zLVk3/Kj3Lv7wDcAAlZG1
 YkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqmsMwAAoJENro4Ql1lpzlRg4P/2BS
 aDkAfvQ/8rj12XlnMJ9iLNydW+rlzNGNtPWl2K5wSr/TXrDTNV3WnUn6wlDknmgpEnM8R5V9Qsc
 c3/QspqAGIBCpOdaaZP84Bn04avV8Bnxzfz9f8p/+JWRpqLA9SZeIObD4iYXs0HW0zxxRd8DI7j
 8fU193Bvq2TfpT/drOFIceflcaILFVb/MeP1Z/0K9MX5FOEGkkRKycBaCLSU3gvVa993+AtblF/
 vZTUYFimaB+LuxUzeN0SyGrwIQjd3j5Mq/S5Z83SSZbb+tyVWJ8qEgNLfBi8iSEqoU07EXUeKbP
 R8I68QIqynG+gOSKlP6d00gvWdRNYnjBBIDfBVGqFUqBGPiBqqb1FcsT3jg39gLFoRBU60y4eP8
 UHwPw1LdDRkT74+bvRjh7U4VFdYksMbI+5gIWZvoxIns/m/okS53J4FeanQB9ttuuIPdDO9yZjj
 YhE8LqcPY3SX+8qaMBD0mT2R0LMiCtJ73ePqBb78g4F5HrCjUhGkg7Qa9BVy6b7bVj7v0UppDvs
 B+aMcy6ur36tzzRnGLD/8RgN9h//DHK39XyUCzodH/7PvyV29NBDFp6d6OJYwfFrqzp1YhJ6xOd
 N2KXmSj0OPZLghwwHRUFdAfQwYf3mRUFgSLCrE+hpCMWMwvJe5i0M9ktJg7e7Vgjc5YoTCTp2tf
 8ioLi
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

virgl_cmd_resource_unref() destroys the virgl renderer resource without
first disabling any scanouts that reference it. The QEMU frontend then
holds a stale DMA-BUF until another DMABUF_SCANOUT message arrives.

Send a DMABUF_SCANOUT disable message (fd=-1) for each affected scanout
before destroying the resource.

Fixes: d52c454aadcd ("contrib: add vhost-user-gpu")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-gpu/virgl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
index 20bae57d0fe4..5a5f9f14c80c 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -113,6 +113,18 @@ virgl_cmd_resource_unref(VuGpu *g,
 
     VUGPU_FILL_CMD(unref);
 
+    for (int i = 0; i < VIRTIO_GPU_MAX_SCANOUTS; i++) {
+        if (g->scanout[i].resource_id == unref.resource_id) {
+            VhostUserGpuMsg msg = {
+                .request = VHOST_USER_GPU_DMABUF_SCANOUT,
+                .size = sizeof(VhostUserGpuDMABUFScanout),
+                .payload.dmabuf_scanout.scanout_id = i,
+            };
+            vg_send_msg(g, &msg, -1);
+            g->scanout[i].resource_id = 0;
+        }
+    }
+
     virgl_renderer_resource_detach_iov(unref.resource_id,
                                        &res_iovs,
                                        &num_iovs);

-- 
2.55.0.543.g5ebe2ebe4ea8


