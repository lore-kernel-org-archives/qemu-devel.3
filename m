Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FA4C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Zyt-0003GQ-7s; Thu, 10 Sep 2026 04:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zys-0003G4-Dq
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zyq-0004sG-Nl
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789028279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b+HQTuN6Q4eCJXLMuX75gYL+WGKDMaLS7r6L7oKslj8=;
 b=SpVrm3JTSF6LRlzBdYc+iOzJBHzxVlyCeYp/9DgWn27pJxImLM5gArbTzQl0HlGgsSxQq5
 1babzFUP8D/s/nvA/BmbgDbYaTuaZWBc4a1ZV15jlcoMwynbPkf/MlO8pd/3K8Zk9IJgtS
 2IK5h4OHZChaKmvTB+k2IJDdRB8oK74=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-OgotuSlTNJWyO4fDIlCwvQ-1; Thu,
 10 Sep 2026 04:17:55 -0400
X-MC-Unique: OgotuSlTNJWyO4fDIlCwvQ-1
X-Mimecast-MFC-AGG-ID: OgotuSlTNJWyO4fDIlCwvQ_1789028274
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C75FA1800589; Thu, 10 Sep 2026 08:17:53 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 398D41956040; Thu, 10 Sep 2026 08:17:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 12:17:29 +0400
Subject: [PATCH v4 01/24] virtio-gpu: disable blob scanouts on mapping cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v4-1-7d623714bd71@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=R9p5LQIIzRohkvwfRNtuO/PatWCNeFmPWXK+hMXTuqM=;
 b=owEBbAKT/ZANAwAKAdro4Ql1lpzlAcsmYgBqomencp3xL2aGqfWQQIPF57D+hYLP+97hcxEBU
 mv4b159MBGJAjIEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqJnpwAKCRDa6OEJdZac
 5b1gD/jRpAJJIuBTofW5lddvZf/DSA1rf3im5Qjl39HZ6pM3scDnI6CRQfl8H6W61YUYoEJe5uI
 6wr9ucK+E7l9a3BPBx9lnf1OA1ghtUmkqzSn5LXt6LkLvtkX/T4sSWuP2ip/E2b492oQqLB6Eh7
 lHFvgezTWVcRTdT7p3I7egHqataYkfHpeKlvCGaaJBHtrimTsNHToS/BrsMFEhvg9D+ynBgsCpQ
 Oc9n7WT6JUkPKBSDt8sntSkeH7dwexLPQNoYrhaNFG0hREU6qBed1hosgnPv2GlkvYdbna0Zfml
 Sr4AmT5aTkt+1qNizlTKNSv3BEVEtaQd971m80SvzS6fvdYE/q7D5Iv02OlpE/ufnW0Ema/Y6jy
 fY3V+RMVmbsC+n/c1c8M2FTDPgz49ZeZJSWd6IeWtKvowHNNawlMTo+TOQZALETSozFZZ59Nod6
 YSXxYe83R2TT5Yfb04tOWkmQ76SqxNfQq6t2lDfhMKZoJ8gjJ/7LmMVE0t2DVbVuQNpp9eV2wkn
 KOQ2BAzA2aXpxs1+Oy1+QT1HeguSIt1RrXVtbaHxKBmw4Oz4iWdlz3GzJceE+5SNSdai2B2TXr2
 B3KiaoiSDwb1v1y3J4xR9sleHXo8PgZrDF1+mAx4g5bb1KCn/r/Xsk7T3SrCiUP8T21pwudvPMn
 nrgu4jQx1DsNO
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


