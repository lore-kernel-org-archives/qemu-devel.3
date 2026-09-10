Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C06C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4et0-0006uV-1H; Thu, 10 Sep 2026 09:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4esy-0006si-9b
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:32:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4esw-00041t-TJ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789047134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ciD/ZVt5jW5QMxT+f6uRd+L51Y2xcWI2H63rFBdrxlU=;
 b=BZtwn02oOGE5l3noj6z9EXKNfUfV56fKOqPgiuI530TKeQfVWEkcuC+3SQmpm+22No+Bt4
 JZ//i7iR5B5jALCqNlE2t2oPZXEshA6/eAxyJhIp19jUTvmde7UMdMKChsdR6/0XiNakVy
 YI0wFFEUtj9lPhLak7kpjZXuYsk54w0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-cAO4OFpzPnaJLlAY-30fXg-1; Thu,
 10 Sep 2026 09:32:12 -0400
X-MC-Unique: cAO4OFpzPnaJLlAY-30fXg-1
X-Mimecast-MFC-AGG-ID: cAO4OFpzPnaJLlAY-30fXg_1789047131
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02DCA195607D; Thu, 10 Sep 2026 13:32:11 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FC2D1955F19; Thu, 10 Sep 2026 13:32:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 17:30:17 +0400
Subject: [GIT PULL 22/24] virtio-gpu/virgl: disable scanouts on resource unref
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v1-22-ccb8927a671e@redhat.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=n0CW0Sj52YaRlzK5eDiTgnftbv+1PgAfeZqW5A1Onl0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqorDdU1u8lAIcAeYt12oqngZMi3TBfiF1U6N3f
 kwoOBDtDQGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqKw3QAKCRDa6OEJdZac
 5UZqD/4pdaeo7FS0NiWF66GMY6iiePdzzzAMWMawUHU/GsfczP7aI7oQICDo6bp0MKwc3pWB3eq
 0Ddbdzg/QLys95bcgV7Dd8X4SgPg3yvt+gTISolvp/4G5V6h+pAb2hUzD8LSGmBi/dLI9ExKL1n
 ZPNVqFqYFQhxNMwaH53tvDpAiXlhuaYd+LynxM7hI5zPuo7lIyQ2Md0moxVwqHOtrOLqosIpHq3
 iex/JqXF0lZwGJX5yRf/stpXRL67CDZv1Q/S7vR0y/o8sG343pgxxysGkl+b+vOK8Mcf/mbXiFZ
 k2EWJhLKrpbNN3RrayXeXOmZs0AWv+U7/4/uLQuiCkieH17wPfWwTYWPSSVFeLUeBcgZdQIw7vs
 jSxVx3UcLrzO9YV9TylRPLD9s/LCAxn72De38xaSOUPR1WS3uyyEW+euXwD+VDbupZL1UwFhhA7
 +M+JeIIXaFdJ/YwmY1goMO0w6PwVDDE6NEuZRKKspu6LgnOpQKUfJPnCaslFmkyThOYyKS1Qfq9
 FDHSb8Ro9UyPopP93zos3zSSUmbqpiJREOjGgy+gHWHJF1kxpgwB4NTN36RtibZT+NN100qu9ow
 RC2oZvQuc/nzdFnaKtHdfJpvdhQQ63uP1FDiiILuXDqkaOmyYGukujHT5LS6/MKyG+MN3KoyaLf
 rOyTwV2wUqtqHAg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


