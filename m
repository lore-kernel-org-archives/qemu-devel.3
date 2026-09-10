Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FE6C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4a0H-0005jU-ID; Thu, 10 Sep 2026 04:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4a07-0005Si-Ra
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4a05-0004yU-Lx
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789028356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ciD/ZVt5jW5QMxT+f6uRd+L51Y2xcWI2H63rFBdrxlU=;
 b=J2UmvH0Lw8qazesi9m7NLgwXQJjNwbp6OM+gN6c25ng7Vfrdfis6vtqfc3s6r59pGiOzeP
 a2N9uDF+OWlFESq5a+a63xOPgRwcuMpqdS1/E40mqeRxiVmGkTMqN40qrL6EFrqqLV8V0C
 5kzEKFq5gYlxIRXiDeaUYD+4xQ5RsDU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-MwPevmj1OF23JbzIZzddYw-1; Thu,
 10 Sep 2026 04:19:13 -0400
X-MC-Unique: MwPevmj1OF23JbzIZzddYw-1
X-Mimecast-MFC-AGG-ID: MwPevmj1OF23JbzIZzddYw_1789028352
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 771611800644; Thu, 10 Sep 2026 08:19:12 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25C923000239; Thu, 10 Sep 2026 08:19:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 12:17:50 +0400
Subject: [PATCH v4 22/24] virtio-gpu/virgl: disable scanouts on resource unref
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v4-22-7d623714bd71@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=n0CW0Sj52YaRlzK5eDiTgnftbv+1PgAfeZqW5A1Onl0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqomeoiubOJm69hZsNSjfBPxXm5wyYr9SFDO1yp
 b9NmiQe4sWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqJnqAAKCRDa6OEJdZac
 5T8fD/sFPHU98fHx13GVRmJr5jZ3TI9AAALVXmxYcWJEOxiGNonEMheUGEi77iKQ1QNj0ajJFE3
 gd8JRRC7VU9XO6BOqU5rDu8CYNnRWWTTo0KJGN3TEzgp/CNIQfqh29RqaZnq+eKQ5QMzhnJrp+4
 AIjtuSX+yuyoTaSsUjDEEzJpnVSySokMTyrMTwpdwxWfKWfECUKnwUJQWpRvaukGbR1IRm6tPZd
 zPs8dYHmACddPLsYEM8rUyFzyOYJcYcYH0R5LIMWiu+neZ1cxkOiuH2FMkMC84HENtEcv1YDE6p
 t1HHkGMN9Rh1yD7Dc0EIBa3aattRavX+3LZBCK034yQ/0jvMX/GnWwt4F94fN28MkVqecW5d5g0
 le+ha0Zrscc2yAxk4IATYAs8Ja7nbugMSgMHvVB23kTIeWOgvpsPGzzHJnPpGB5664jd+hlxMDb
 QyMpa8fOmH3/sDDMsa0aEbifU4vKhVur4ldCJMlhYjKW0SNKSXaklk63CacEEOKLNHQvKkT0EfN
 BdXjbbLH7SJqFZbUEyeTCNzok6qVwld1TLPp4l12MKW/M2HzJbNc9mIyM2Rrvpad6D0CAVY6mur
 KEXlNiLNTbLpQIXtZ2g43ticwcABTk+G6GhtsVeOuAANBUhgUF1GqnKRfbb68GVPR0T/vMNInl6
 zoSfuTQ3KR1x2uw==
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

Disable scanouts referencing a resource being unreferenced.

The scanout disable callbacks may change the current GL context, so
restore the renderer context before detaching and unreferencing the
resource.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering support.")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-virgl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 439a6e1c1cff..494be3fb4f8d 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -431,6 +431,7 @@ virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
 {
     struct iovec *res_iovs = NULL;
     int num_iovs = 0;
+    int i;
 #if VIRGL_VERSION_MAJOR >= 1
     int ret;
 
@@ -443,6 +444,13 @@ virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
     }
 #endif
 
+    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
+        if (g->parent_obj.scanout[i].resource_id == res->base.resource_id) {
+            virtio_gpu_disable_scanout(g, i);
+        }
+    }
+
+    virgl_renderer_force_ctx_0();
     virgl_renderer_resource_detach_iov(res->base.resource_id,
                                        &res_iovs,
                                        &num_iovs);

-- 
2.55.0.543.g5ebe2ebe4ea8


