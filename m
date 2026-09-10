Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0869AC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4erL-000212-BI; Thu, 10 Sep 2026 09:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4erD-0001tj-Qe
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4erC-0003bT-Ab
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789047025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b+HQTuN6Q4eCJXLMuX75gYL+WGKDMaLS7r6L7oKslj8=;
 b=Yk1AgGLPfqtQBUGu6hcSop6ab5iq0B1zIOh4Woqry2IPpzUt1b6Hwk9E2RDTkzf5ZfUjgv
 Fs5tPH+jH27qh2tRoO5RLklUI0ZIM7CtRNRYcrzk3741xluap2eg/5oXmj6DZ0+SvQVnlQ
 NBgNze8ETYYUXvr3uMq+veg9aQkCuxk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-sMKRk6hUMniruTVudMOYIQ-1; Thu,
 10 Sep 2026 09:30:21 -0400
X-MC-Unique: sMKRk6hUMniruTVudMOYIQ-1
X-Mimecast-MFC-AGG-ID: sMKRk6hUMniruTVudMOYIQ_1789047020
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9651718001E1; Thu, 10 Sep 2026 13:30:20 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DED1877F; Thu, 10 Sep 2026 13:30:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 17:29:56 +0400
Subject: [GIT PULL 01/24] virtio-gpu: disable blob scanouts on mapping cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v1-1-ccb8927a671e@redhat.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=R9p5LQIIzRohkvwfRNtuO/PatWCNeFmPWXK+hMXTuqM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqorDbkQ0YgfTnaRKPUdjvjIluHKKdmKcNyWoXa
 8g9XcEt7wqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqKw2wAKCRDa6OEJdZac
 5SxuEAClvRUu12G4rdypZ16AmzsYqnTFwGDl1AONfGXLeSHhBzKska2nkAydjgRRR+ZGnXwjzYb
 9tqo2zsB4w5uigpGLjIxemleyGdzxE3yYD0mPkk7y0e6u4zLRHXnVDNYyhQdFPzS6EgDItO88Dx
 ZS4nRgAAC/X6uE9pu4W3HJIIMHxLQED84YkafO4nmRmEbL8To0IDTv8P4B9izG+AgYCK5lEKw96
 B15Zv+oguUwJscyVqw8x0+ehjvvi4k1iPRIu6TvfKkGU58mZeiN4GS1UfVF9m+ovey1/1dpa7BP
 Qk1po58BVnxeZ3b8ex1WRR8ukKcbk2sT/rLqhMN2Uf6HXs/29M7d5xcxk0em+3Tp2mm+IeTMkVA
 qrDg8NsGaQiSKN/LlkkivloMmHn8oYqnu6fZlimiML0atKwCcUscdk9Z0xtqF4DZ7MZql75PFn/
 KI2HAh0QwIwjGkvrLLSg91xgl3UDKknF37b43Ncamn4BGgpEWDnMIG1M6A4RcEyS46PlZg+01q9
 h+2r66mCF/dTINHeJEV1l+OaEUSDEEKq2rnIgihXNj/NuF07ygkD18rzcBzTY4k2zFPTAK4eIDh
 ZFPrlu2ynRLcl6b6jYcQ3TE3gXRkNTOyifXXFy0v0WipqhorECyMhEizOsTNWZMJ6/AO/iAw8PC
 iSexMKbKj4PeLsg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

When a blob resource backing is cleaned up (for ex via detach_backing),
any scanouts referencing it must be disabled first to prevent the
dmabuf from outliving its backing memory.

Fixes: CVE-2026-66020
Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 55a1c7f80fb8..5b63a292933a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1022,6 +1022,16 @@ void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,
 void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
                                 struct virtio_gpu_simple_resource *res)
 {
+    if (res->blob) {
+        int i, max_outputs = g->parent_obj.conf.max_outputs;
+
+        for (i = 0; i < max_outputs; i++) {
+            if (g->parent_obj.scanout[i].resource_id == res->resource_id) {
+                virtio_gpu_disable_scanout(g, i);
+            }
+        }
+    }
+
     virtio_gpu_cleanup_mapping_iov(g, res->iov, res->iov_cnt);
     res->iov = NULL;
     res->iov_cnt = 0;

-- 
2.55.0.543.g5ebe2ebe4ea8


