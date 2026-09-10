Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B18FC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Zz7-0003IT-MK; Thu, 10 Sep 2026 04:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zz6-0003II-HX
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zz5-0004tG-A7
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789028294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTwr7eiOmBFT4ak8x97KiBe6gCvMvmT8l8RQTmrq2YU=;
 b=FY5DISis4Ha2mzX61xLDVi4vSezuKKxdUGSMfArgEEh0eJFdWBxGO8DGmO18mtrT3PWoRj
 2/fg2UvB20vJ2Wh0ppgIAKlEEVAvk9k51LbdpbifFV7s0jLJdHCD/HxgbSKR5Pt7uHp7TQ
 GlhoJp0Qky/axWwuuTixPiewfHF2c4o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-9JSK9h12MeabyqBFiqLGoA-1; Thu,
 10 Sep 2026 04:18:11 -0400
X-MC-Unique: 9JSK9h12MeabyqBFiqLGoA-1
X-Mimecast-MFC-AGG-ID: 9JSK9h12MeabyqBFiqLGoA_1789028290
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17672195422E; Thu, 10 Sep 2026 08:18:10 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3686433; Thu, 10 Sep 2026 08:18:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 12:17:33 +0400
Subject: [PATCH v4 05/24] hw/display/virtio-gpu: set share_handle for
 udmabuf blob resources
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v4-5-7d623714bd71@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uiiPrlH+Ljd7fNaQGlC+cwmjR9XSCfSA45QXLM5Je68=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqomeoFWDRSa8LJi62FbahwiVE2o9rhjfjxFLQA
 k5hGwzaQ2SJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqJnqAAKCRDa6OEJdZac
 5XM2D/90zQ20iJHzavKbncmq1eWkB+CVRGcklpNutlJjnPl8XyJ1Hl6x0z53osWsAOxBL2Su9Vo
 p/9giZmMg5bKsQTwx0UHKWMruxsXvwkeTF28XF02CU2qmtbWW5+bMlRGy6HrQ4vnidSFTatmiEt
 x8066RGqCJq7KXjGJMmhU5zzhO8e028YpSQV644JsfkaUYfRhfC7O+8U0ITC4yPs9/POZzJTMY8
 79nFax1W706btQgBO8PVHRGFWp8/9A8MAKsjeD4GWKlXLHfeghuBj8sU4Fq/+PjTryCLXr9IrpF
 Fcr0vKCieB9QD7tqqkKAAwEQc5FbLoXa+gk+54vTZl8pTu4des1hvu3Ofo7LMnd1vE/z1vBskkw
 UD7NTQWhB8fMWu5po/pZx496a/kg2zaGs7RJJJVkvntXHKlb8mR2PeKp9wrjs54aG4GQR0fP6Nm
 mskAOTa/sVnersbRuyTkJhRhpueSaVPW8aq4NoBeP/RVbNq+ovaE/B3jJEF29TQ5ACbGgFkqtiO
 IWufgSUer+jb/mnnWlw1cc9Wu6CBzug91Kb3kd599XQsxbQEe4ObeF9D8wLgofjPbTnJzwFDYKC
 AF2e5X9/5eHQ1PSqX+J7xn6JkX20bL122r4IAZ06+L9Asvjyj6BvRGs99pm2UjRHO0+8eCceqHH
 qoOyHOC9OGfqRUA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

Set share_handle to the dmabuf fd after successful udmabuf creation,
and reset it to SHAREABLE_NONE on teardown.

Fixes: 5f899c34af1d ("virtio-gpu: allocate shareable 2d resources on !win32")
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-udmabuf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index 03f0b29754e1..fc63f2c4ec21 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -91,6 +91,7 @@ static void virtio_gpu_destroy_udmabuf(struct virtio_gpu_simple_resource *res)
     if (res->dmabuf_fd >= 0) {
         close(res->dmabuf_fd);
         res->dmabuf_fd = -1;
+        res->share_handle = SHAREABLE_NONE;
     }
     res->blob = NULL;
 }
@@ -150,6 +151,7 @@ bool virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
             virtio_gpu_destroy_udmabuf(res);
             return false;
         }
+        res->share_handle = res->dmabuf_fd;
         pdata = res->remapped;
     }
 
@@ -183,6 +185,7 @@ void virtio_gpu_fini_udmabuf(VirtIOGPU *g, struct virtio_gpu_simple_resource *re
             res->dmabuf_fd != -1) {
             qemu_dmabuf_close(dmabuf->buf);
             res->dmabuf_fd = -1;
+            res->share_handle = SHAREABLE_NONE;
         }
     }
 

-- 
2.55.0.543.g5ebe2ebe4ea8


