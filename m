Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66831C61DB4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoKv-0001un-Op; Tue, 25 Aug 2026 06:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoKu-0001sW-It
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:24:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoKs-00065W-V2
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787653494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HAIQDMbjocaIxfDEh0+ahshbil+tSNFXN95NHjHpi2E=;
 b=CV3wbNM9C7Yl889ajMQcxC7//YuMJAtjATmIT81D0w1/+gkpPkbH/gSbJS2iz2vr4avY4b
 v2h48b50COO5Q4EI+6HqiCDb4tfc3uAYumWlS3semowvlCoMyFghq87OASp6KofgTYuuPq
 iTeDCami/VR98eQrJ8W6Fpd4xd2GqfA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-p45qpAx6M1atLa65EE8Kzg-1; Tue,
 25 Aug 2026 06:24:52 -0400
X-MC-Unique: p45qpAx6M1atLa65EE8Kzg-1
X-Mimecast-MFC-AGG-ID: p45qpAx6M1atLa65EE8Kzg_1787653491
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEC97185BE9A; Tue, 25 Aug 2026 10:24:51 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45EAD180034C; Tue, 25 Aug 2026 10:24:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 14:20:51 +0400
Subject: [PATCH 14/18] virtio-gpu: consolidate disabling scanout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-virtio-gpu-cleanup-v1-14-d3bb612b9975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2706;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KNVZEsKUGlUk+zR5a5jT0oXvtxDURe7kh0rb7LxAr/E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjWyYt3lynNO2v0uz5SujX9KGiL/rjnOmtbPtf
 KZPmrcMQKSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao1smAAKCRDa6OEJdZac
 5aIoEACFsCI5r+m+99IcZ1YFKEYTI317mQgp9x2+KXTUND1RN84GGbP4G4L5GPutdmoaT7BijFm
 rXQz1vARpEt+k2iUuEBZx06ClzldQZAlfAEVsxwf5JAC/NoUe6+0rT924FDDIOfHKb9gJBETmcC
 dcvgO0R8TfaZcTH/3zwjGAC8/IEBFortzZb2i++9c8O63dVAUEZDPLjeDWk4UO90wuE3TFRTlhe
 JqYH0DOSzTHFucfVk41GXm94tR8L7AGKsVxoYwrCEePJ6H8yoz4usX4O1J/r09bMh4/dfkarQ4N
 RleKx7K2DkYqJ0IqOKSLxHvySext7j+ohQ9pw4VmGz5H2I3AlAEEmRTTxDOWiXWEV48ThQUpUHC
 LN10m/2g/AUIgxfjbRjEjpRI2sIsz+mUx0PCFOi8MxcwOUYdBmByihVrpi2lp5JRuAmTAFuyN2m
 Ki3dXpnMWQN+RKdrEhP/Fa1ELUJe+rvr1PF56SLSNu3B3xF2mwa+St+Hf6ynDA6O5etEJYnTSdw
 kcBHgDiUz+y/478frIMorG9WnD30molipyJNEmk/HiyJanKnX1B0cx1UaCIEgO/cw4JNZ+sMiwN
 g6ekN60yGdeChNpLpTnxGUbKrp8JTYhL/A0bLWemEEqUkUqQw8Wl1Lr92AFQlklMvEJzBVu+6XY
 Q9l1o/naubVCekg==
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

Use the common virtio_gpu_disable_scanout() to reset the scanout state,
including GL state if any.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c | 4 +---
 hw/display/virtio-gpu-virgl.c    | 6 ++----
 hw/display/virtio-gpu.c          | 7 +++++--
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index fcd9c94d580c..5344a5f9e26a 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -320,9 +320,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
     scanout = &vb->scanout[ss.scanout_id];
 
     if (ss.resource_id == 0) {
-        scanout->resource_id = 0;
-        qemu_console_set_surface(scanout->con, NULL);
-        qemu_console_gl_scanout_disable(scanout->con);
+        virtio_gpu_disable_scanout(g, ss.scanout_id);
         return;
     }
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 532132e46031..6cb9365a714f 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -599,8 +599,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
             ss.r.x, ss.r.y, ss.r.width, ss.r.height,
             d3d_tex2d);
     } else {
-        qemu_console_set_surface(g->parent_obj.scanout[ss.scanout_id].con, NULL);
-        qemu_console_gl_scanout_disable(g->parent_obj.scanout[ss.scanout_id].con);
+        virtio_gpu_disable_scanout(g, ss.scanout_id);
     }
     g->parent_obj.scanout[ss.scanout_id].resource_id = ss.resource_id;
 }
@@ -1406,8 +1405,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
     int i;
 
     for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
-        qemu_console_set_surface(g->parent_obj.scanout[i].con, NULL);
-        qemu_console_gl_scanout_disable(g->parent_obj.scanout[i].con);
+        virtio_gpu_disable_scanout(g, i);
     }
 }
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index c50eb58917e8..a7f549a6a8b9 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -404,8 +404,11 @@ void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
 
-    virtio_gpu_release_scanout_dmabuf(g, scanout_id);
-
+    if (scanout->dmabuf) {
+        virtio_gpu_release_scanout_dmabuf(g, scanout_id);
+    } else {
+        qemu_console_gl_scanout_disable(scanout->con);
+    }
     qemu_console_set_surface(scanout->con, NULL);
     scanout->resource_id = 0;
     scanout->ds = NULL;

-- 
2.55.0.543.g5ebe2ebe4ea8


