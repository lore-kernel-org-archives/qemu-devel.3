Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605D9C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4G78-0007Rz-Iw; Wed, 09 Sep 2026 07:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G6q-0006k8-LH
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G6o-0005NZ-JC
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788951893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ny18XTZWgarQi6p9F7g/3cJBjiECYvkOPPCvdP9Tmko=;
 b=PFkIrKHlC8VcKOBMfmfrlUna6QXqGu0yX6R7A6n2RpFu4mmiCLeHL/ytyYr0/obz7oKNID
 CHBX511YgF7hVK9OC/6CR4rLP6INUxXvXbZ4grEqTegR7J8SHTITgK6rRz2UeBrdwIB9iW
 dQDtDFGoDX5kQL3Yn6WFAASPRw3fBPU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-fP5dvy8yMnGvbj8v9EXyDA-1; Wed,
 09 Sep 2026 07:04:52 -0400
X-MC-Unique: fP5dvy8yMnGvbj8v9EXyDA-1
X-Mimecast-MFC-AGG-ID: fP5dvy8yMnGvbj8v9EXyDA_1788951891
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67B311954209; Wed,  9 Sep 2026 11:04:51 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34713426; Wed,  9 Sep 2026 11:04:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 09 Sep 2026 15:03:27 +0400
Subject: [PATCH v3 22/24] virtio-gpu/virgl: disable scanouts on resource unref
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-virtio-gpu-cleanup-v3-22-99266590e79d@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=V+rm02I3r7+lVzdWZMkpzlQV+VEE8f+eWV1SGOMC300=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGqhPPOgbbsP+NPXvCfNMXO2MgS8N2ayG9Er+7pwRzdtmfAZo
 okCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqoTzzAAoJENro4Ql1lpzl6ocQAIQu
 78mW0k2ImfMtECoUadoaso9Pd41QjvFSfKVm7r2fPvv/+6I60L5/YreQjweF++bPuR471Tw6Dil
 6vAN28eXWQ12WYwFeH1m1RSDYXCsvLxcvz2FG3M/a+wD59Hjz6dxThF2mKMa6+iZJ9djbEttbTg
 7y/+2/NXqMEoFXgE83gTrfg5oZzPmrJYj5ADRg8nS5pDMcsBFklJtfBE3Vw6UxFoLo2FMkMckGa
 YKFlj3FxZHZDciDTrZ197K2WNgozQfl3cISayhgeJ0VkG+Q77L25GIirqVTs71yB4B5FXoaqyrC
 DXCCj+/XP9X7t8sBuHPaxwrJMeO/pT3pvf8aymrg4P5i2/Jnx5pPYPE7Le+kR31Q7QX8tqy/8uX
 UNKKZ8CQBQUQ1ft9rlylTeWQ4mZrix7B8FTc7Zmlc7clC/FlRZsg5et3f/pCxbdxejuylyQGG6c
 F6tH/V7ROUI9MRKODG0R2KqkGH8NK+FZIMdANjIV84azmE4EBbxrKhhW/MNvRwNokDZ0cDR5VqB
 iQ7hN0gg1yeo120WlkukxnIoA/AJP0RDbI84XZx7c00vpnp1pecAAfYJKA4JJtN9+FVBOLjFine
 jgnh9El6KXabibHOs35jtAKhElwF4QekLggCZrccvB8ZdTQqWaRs56OhDIKw2R2sBa0kgLvt8Ji
 WOU0K
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
index 118419171ff0..cf624761610a 100644
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


