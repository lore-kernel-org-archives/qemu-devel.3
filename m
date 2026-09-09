Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2A6C79FB9
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4G5q-0002Iu-9p; Wed, 09 Sep 2026 07:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G5p-0002IR-1Q
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G5n-0005Ez-NC
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788951831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTwr7eiOmBFT4ak8x97KiBe6gCvMvmT8l8RQTmrq2YU=;
 b=CZuty4DhHjZjJEngMycTTdY/rQel2tFryY+40Wq43n1bs4N3dY1iDChTDKF84CNpDFnYRo
 CkBv2n4C91GK9dsWqG//qP1kvTdh6nsL9x4IpcePVmWVMf2wC4MhFhanoQ5w+nfByv6JA6
 pk8AlNhC3kya3WOvVrszj2tv1qM5Irk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-74zaE0bcMve5p0BVjdzYMQ-1; Wed,
 09 Sep 2026 07:03:46 -0400
X-MC-Unique: 74zaE0bcMve5p0BVjdzYMQ-1
X-Mimecast-MFC-AGG-ID: 74zaE0bcMve5p0BVjdzYMQ_1788951825
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 994F51954197; Wed,  9 Sep 2026 11:03:45 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7F853000218; Wed,  9 Sep 2026 11:03:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 09 Sep 2026 15:03:10 +0400
Subject: [PATCH v3 05/24] hw/display/virtio-gpu: set share_handle for
 udmabuf blob resources
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-virtio-gpu-cleanup-v3-5-99266590e79d@redhat.com>
References: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
In-Reply-To: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoTzydNcVMgMTAHSLHAYN2dRTTGiwT82J21bdV
 YMSm0QgkzaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqE88gAKCRDa6OEJdZac
 5XOTEACQe5R0QKLtDzbBXKnTskTnbtrDdsg5nkWHm6kVj8lcr0Kgxn0M8vLbkAOpmHusSf44lBP
 p66VlKu2Pm1nRGotZ0ii26T6qhRnF+DZg8JVkxSpQ0uk0prHCshNjkl1weQNv5lYv3r2S7JTUYc
 xluCJe55b0XKi2oZ5hM7+22mzQ27ZzpYUpEILDbBgdiod2WkbjWpKaW+6SAGi35wlnefEwDXS59
 J2wUI2Ng2Vc1qf/BMndePoMGKIn+P5cjaA9ke+vvnXKsj5ZzYSrlpZmbSwsyKHAgK7BlqApsspI
 GDoKm3qQrkK/B1MNQ1/LAcyiMBz/P4CL0iy4sgBvLk++nTBHW+tJRCiREGtr2twao5mWp50V1DE
 kQhLinXfqKC802is73UyU+2/gL5+c6RjhFK/wBTQvQjF9fe51buEe5ce16V9AJiBbvDH5kNrML+
 0pRbjF+kQtgYNjq8bxcsagVbe78rE5mxXL0BVjpXhEds/xLFXPHO6vWoVxibuaQlQmWw76+NsNw
 hWBmBWHUyNppTfBsPcCLCBCpqEYprEbv0qHfWXdm+2h1Bhi86sY8dE+8FaQbbA/Dum+/r/l5B9/
 F0bi6iVugvpU3UGcoEkFQXKotsDq6L2MzQTvI6LNrfqvNRG6tC0jJh8ldw86166caYzCj0hvh1R
 O0y5NGSaLjRLskQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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


