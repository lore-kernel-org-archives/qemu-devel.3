Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48F8C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4et9-0007Im-UF; Thu, 10 Sep 2026 09:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4et7-0007Ez-DL
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4et5-000457-TN
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789047143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Wj5VzWeDqCex6YztU5VwVvg7TaKkgsfcJttpxYa4aU=;
 b=edCdFlQmdB3KIXMOltUgMV/S2TlWR1DujLHFUd1TDZMTGmasUBTE3UOJtLdm4OkfO7jmmA
 fGjcFmyZy6ccwiDLIeOAKdPyCY+Dd9v0Dy6fvIobiiTfVU3Y/1voR5tY/NmyEW4aJlTTer
 Yu3SEL9rN2PvnJTIeazbOlxbWexBUhY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-ao1h7jJnNma765Ij-3VqLw-1; Thu,
 10 Sep 2026 09:32:21 -0400
X-MC-Unique: ao1h7jJnNma765Ij-3VqLw-1
X-Mimecast-MFC-AGG-ID: ao1h7jJnNma765Ij-3VqLw_1789047141
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BD9B1800639; Thu, 10 Sep 2026 13:32:21 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 482DA1800351; Thu, 10 Sep 2026 13:32:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 17:30:19 +0400
Subject: [GIT PULL 24/24] contrib/vhost-user-gpu: disable scanouts on
 resource unref
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v1-24-ccb8927a671e@redhat.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=iZ+oUugkx5oY5Po2y4/QVsUJmAP+CsizW5ruoANWJxA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqorDdL163ZseZkprsRoR1LEcH61ifXgP8IZdYA
 V6nVE/KaCGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqKw3QAKCRDa6OEJdZac
 5U63D/9MgwjFETu9twn1bwICcGX55IcMGoTdKaf3yYtYvOLKPWZzegQQfD6iIz+RnRi8uJb6C/T
 n+X8LtBzfwf2XCOFmFkG3NIOk7g+SU8+zHOyDuh2Ys/jPxNGVnviDiKFx1Z/JmawQiMVNcHFo4U
 DqmlQNrKZ5g85plpSiTTTDKKE65vk6h7oESKDmNqigtp/oTpsMLRkrTSVr+nBVOet2VIpzG7eWT
 DiAwjhFa7Kdxt9lInnX7C+v8B+LfRazKXcMRNGPrupzWieU4QO/zgNsrTjxCTxr8RTJGNsCjC8P
 cPzfcCLf0kWjw9fYFnHhEHwNVDPpNl/KmoW8wGyefVrv1kmMWX0ktAKF7Qv7Ud6PvfwsQqnvxPR
 PF0l46+v6BjlmsA8qgByUKcVTESh5ATTokREWdIskNYjZJJD2CXYqgI+BaolZtGsmwoCGDBgTNo
 XgA+oh5ro1x/e4x38eLGX8YclZPEpX1R0CFvlSd74dVvDuKYvh6aXmC6ohOJL9x9itOM3WC9NT8
 ZrZV9OYmxCETAmQVvt4UB+GKilpMc4I4yZijEaHIZQLIqPC/rdSSTEFyEZw9Ovntn/8dR1Lwfbe
 XvbBo7Csxgw2nPMMmALucoaEAVAUJNDoCPslDyRZ39h0sLxLxS9bWovuWJCy6yI0smyTxKGS8+h
 eMP8Y/5hEfrpX4w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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


