Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B083CC61CE2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoKC-0000xo-5H; Tue, 25 Aug 2026 06:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoK9-0000nn-8E
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:24:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoK6-0005xo-Fp
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787653443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4pmvqw1aKk5g+JiW9PtA2fMchRrT4yhQbzxGgZTS1M0=;
 b=VGRQavLaEbXfjv0Bc/AIXqdhOssQImHI0IMe8a0naric/LjsIKlmdUUEHeHz5DGG24U4a+
 VpqATI/EnQY8+X0wAaqyiOChImFGjLZ7UVGgxWEg5plYSHgCuvld0/EDjGF10Kh5mtFBCy
 1xhGAQN+dlE+qFFWigeGgcLfqpyOJyo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-rceEsJQBM0W9td6duwfccg-1; Tue,
 25 Aug 2026 06:24:00 -0400
X-MC-Unique: rceEsJQBM0W9td6duwfccg-1
X-Mimecast-MFC-AGG-ID: rceEsJQBM0W9td6duwfccg_1787653439
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8C13186A70B; Tue, 25 Aug 2026 10:23:58 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1446630002EF; Tue, 25 Aug 2026 10:23:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 14:20:47 +0400
Subject: [PATCH 10/18] virtio-gpu: disable blob scanouts on mapping cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-virtio-gpu-cleanup-v1-10-d3bb612b9975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1230;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=iLL5NIMdfsWGthlPU0qlwz/om0MvFo9XZbTOmTWt2Vg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjWyYL4YSP2drwu8/FHWUiriQ8VP2mY97HLZfj
 qi9UawuyeWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao1smAAKCRDa6OEJdZac
 5bHzD/9d+pqJJ3xpiXlc6BvIknepaHuiFk/28Dp6jCMVfXqq54I0Wj6oOKUEwzsyLda5tvjYE4W
 /6MaTH4a9EhCl5sZ1fv63CXj3tW55UmGhmv56lhT4MeURyvEM5Vkaxf5H3dnHHQ6jyRlwxXRY7M
 iFMcabRDNPdsfwYRfMgPOZwEXoCkzX6VYnh5cCd45MNY4zqbJG0+5LTlg/D0zepNJIhPs1yEFl8
 bdYTKFPG1AK2XQnEUe5BvQA2jAhExkXVKb39BQ++R0pF//Xq2BIFrT/fJeP1Dvfe+/OEhyhOLY0
 BPhYqCBDF7nIRoH09J3pKK2olCPwjyqGYL06wmJFHSr0Dw5DKCdrdyYLiokQDneUWfaekqva3L3
 v/Sdov/ph3+p5uLp0JNHUVQ4bBSi5xuxr3DIXObZjdBdMeSQDYE0I6DnWR5/3PTaqQgn3jvw3qA
 t6W1nUsENOhFu+J5qD7SyAqnSh4EDQxySzjky2MPDtQkkADXV0f8Mp4Nns80I4bOE0fo6lQpajF
 TdS8NA7jHRCFmmutyJs2qkjOuazpydsPFP38GMIy7QkmVv3ZGNH+CMbnWNT6sv4noNwVxRrbxkB
 +rgprKDvnpwT9/OdldNmLMP0M5DV1kP1nPm1fKb0lDy9mP09G92146HiN6EKyj+UMzWBAiRybZW
 wSvgSwuBmlvB2yw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 46ddfeeaba87..e547cac60398 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -982,6 +982,16 @@ void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,
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


