Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F786C61DB4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoKk-0001jh-H3; Tue, 25 Aug 2026 06:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoKj-0001jV-I5
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoKi-00064L-4a
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787653483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8tW+ZtXYwMHJzhR2UUaGK0H3jUg7Q78i83iuCfaafjM=;
 b=ABzfV3zDN6EIofrC7sPxXvoWRiCNpYZ57DM11qZHx7FfHKNlV0t5sixUbsQPLUaahKax5y
 Swxvb5/roBWSZfeVNWdqhFEfM+J33ksv5phtPItmWpU88MZT0qiWLZ0R05APwOavVXdugh
 VhdLs0IZRuhfOTEMf5D4MmgNoZAjtM4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-PpwB_-N5NGyp1atv4TIk6Q-1; Tue,
 25 Aug 2026 06:24:39 -0400
X-MC-Unique: PpwB_-N5NGyp1atv4TIk6Q-1
X-Mimecast-MFC-AGG-ID: PpwB_-N5NGyp1atv4TIk6Q_1787653478
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EABCB1977667; Tue, 25 Aug 2026 10:24:37 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9DD118005B6; Tue, 25 Aug 2026 10:24:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 14:20:50 +0400
Subject: [PATCH 13/18] virtio-gpu/virgl: release dmabuf when a texture
 replaces a scanout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-virtio-gpu-cleanup-v1-13-d3bb612b9975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2259;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LHNnFxC4pjL/D6mhLfKD2xVRaY/Sv4yHWpNX6gamutU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjWyYOMHezjh83J25O5t3FSGUuJ3kB50cql/wQ
 7EcL0OsV9uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao1smAAKCRDa6OEJdZac
 5fPqEACU7c6yokFqB/riklC9HWJm3FajRqeKepijn1HGceQt19QL8MxVole/UkC1pqAqzGfclFn
 LnrBUx0DctAMkaa5+uo3uBciKem411miPd81vHdWuZ/78uiRB1E/YWI3Gygz2uVqRJbfNHPgX/v
 6Mo5x8e59MPD/hJVykrEAMUWFOXXTTZSgWATCUdmad/n10DBUL+1jMnqVq54VGdydat8Qm9jU3F
 d8Ga3P+hiuQRvXGRcFILHLkElkJC2Ei9TFSzmPwyxkHGYB3575s2mkDHvnloAAlPhfJrcPaZ62a
 4nRd7PrijnnE0GASf4Ouh5JtriD26HyUzXic/OAjJ47sAsv70ubrfWvZ784bFKzyjUHc5wkUO6t
 aqFFJ7WP/dcRRp9tpdpBTfE7LL+WXAYcviAp7HXhM5WG1Gzz1wQAnOEfD1+fmoIbUSb5Rb3yEHl
 zbp+kRm9jv2JGyQEuPFglP4STVgTZZJiu6duJOi5mMiqyaS0P53C6fkCege7vL4QTsyC5rTHhic
 QbPqEQinDttQDu728p/use5/7siGnLkDCnUh92js8Q5ck936QiSoS5dukbzFdRJYoC+Uxns0bzk
 9CpRZ8nt/Gx4Ts/VQKIQ4He8muuygZ6ZVA+YUa1wxBe+bsO2wrRFOa/TQOcfWlo0ykAyjwnnilv
 7YZak6dQ8Kf4/pg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Release the scanout dmabuf before installing the texture. A full
virtio_gpu_disable_scanout() is not used because the scanout is
reassigned immediately afterwards.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-virgl.c  | 3 +++
 hw/display/virtio-gpu.c        | 2 +-
 include/hw/virtio/virtio-gpu.h | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 6e298f997d66..532132e46031 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -586,6 +586,9 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
                                              &cmd->error)) {
             return;
         }
+
+        virtio_gpu_release_scanout_dmabuf(g, ss.scanout_id);
+
         qemu_console_resize(g->parent_obj.scanout[ss.scanout_id].con,
                             ss.r.width, ss.r.height);
         virgl_renderer_force_ctx_0();
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index a74475dc6741..c50eb58917e8 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -387,7 +387,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
-static void virtio_gpu_release_scanout_dmabuf(VirtIOGPU *g, int scanout_id)
+void virtio_gpu_release_scanout_dmabuf(VirtIOGPU *g, int scanout_id)
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
     g_autoptr(QemuDmaBuf) dmabuf = scanout->dmabuf;
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 1816cb21de76..22a38589d63d 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -360,6 +360,8 @@ bool virtio_gpu_check_scanout_bounds(uint32_t scanout_id, uint32_t resource_id,
                                      const struct virtio_gpu_rect *r,
                                      uint32_t *error);
 
+void virtio_gpu_release_scanout_dmabuf(VirtIOGPU *g, int scanout_id);
+
 /**
  * virtio_gpu_scanout_blob_to_fb() - fill out fb based on scanout data
  * fb: the frame-buffer descriptor to fill out

-- 
2.55.0.543.g5ebe2ebe4ea8


