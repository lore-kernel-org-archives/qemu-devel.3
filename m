Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63904C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4erX-00029Z-VK; Thu, 10 Sep 2026 09:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4erW-000294-5v
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4erU-0003dX-PU
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789047044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTwr7eiOmBFT4ak8x97KiBe6gCvMvmT8l8RQTmrq2YU=;
 b=hS+9ymXoGQlj/D+79DUT6+2b0ZPaCVe27ndo+b6ICt4d7sQCi1vHDSrvTN5hYmNctLXPuh
 /MRSozE/cUfzOxvYxkP8aGpaDFXt6KuHNNGmvr8gHfbdxVS7XtAuulkyMsvXyyKZnNG1Z4
 iud5KhIbqzUWZvFIzQNYp7eVtbLAKxE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-jdmeCGHkONG5dfuorrXYvQ-1; Thu,
 10 Sep 2026 09:30:40 -0400
X-MC-Unique: jdmeCGHkONG5dfuorrXYvQ-1
X-Mimecast-MFC-AGG-ID: jdmeCGHkONG5dfuorrXYvQ_1789047039
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76249180062C; Thu, 10 Sep 2026 13:30:39 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8A411956040; Thu, 10 Sep 2026 13:30:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 17:30:00 +0400
Subject: [GIT PULL 05/24] hw/display/virtio-gpu: set share_handle for
 udmabuf blob resources
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v1-5-ccb8927a671e@redhat.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uiiPrlH+Ljd7fNaQGlC+cwmjR9XSCfSA45QXLM5Je68=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqorDc+/nyHjjwd06Y4ln7nzFXOgghazR/BjnKw
 s8liIysuJaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqKw3AAKCRDa6OEJdZac
 5b63D/9elAzBJhqw343+hywmFAUbmIXehUSNl6SrplKH/a9p0zIzS5m05AYorJks1yhi27egkhQ
 sH1jwwTyTBIvU19aOswzqzCEyRels4w1mA46kNQJGdYgphvR3PG15Clhs1NU1cWjdoL6k8UW0LM
 5k1i6UI9FnI2eGxqrwmkBoFB1JYUlFMECiHD8bQv3u94ktlKjrzCwkzxiCy7ETe6TUdgMuCXJ7K
 oJ9WhD27LLL9qnDEzKdLL0/WOxKmQ912q+4Y98hElKzGow3ujzQS+RTQVf3ugXqt+YnENkFoKVr
 YabcWNybULkx0nWxnO1/CF8f36McaJO6A556qcgLlZ4jrt9ahzaxFGTVdMuki4tWeXZ8RbiV0YU
 i4b3rcU7uJ/omZfF23gE2bBfmyVRAX+N565gKNi+u4XYuK7XKSD0bGb5a9zO2bhCjidHSxmTOhL
 UlU2APBVsIKsSXLn/hObtsQdjYMhwI2oPNb+R7L12KNbGmDzSgs7a2F0U9c6KTMJcWPxsU2N8VX
 rh3/PxO1nKRljK97pjF17UgX84LD86+/fLcgoJKT7clRe8IkoHZezZZQ4lwlQZIiPLsMtT0I6Of
 If0aaLrZ1k0AC7uEH77vBPSZVG1h23TNZTBlUknXaJ3M7eotAMjGa4NWIxcBMn6FhcFYSg+qq9R
 4o99TIy+91zLqdw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


