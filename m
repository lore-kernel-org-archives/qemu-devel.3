Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC61C61CE2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoLI-0002aY-Uf; Tue, 25 Aug 2026 06:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoLG-0002Ws-NG
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoLF-0006Td-By
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787653516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iles9kpKBJi7ke6NFfqbSL3la7rXi36pHcWAFP5A89k=;
 b=YuqDKL97qRS6YoqB4FdacJF6Njp3UpHrRHw9vGogbdlGHSvIRcmCFSUGOpI5dxTSjwbApB
 cKoM8TKChMHwhqyQUPIE2QKREKDtCbXx9zkX1jQJeyFNdYP16EGpD/VtbYmIIFhO0Ry8ax
 tZ/iw1dZnb5X+BNdg1bkZ+bPnFBsFos=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-riBmDOT3P8KigrYGOn4eoQ-1; Tue,
 25 Aug 2026 06:25:13 -0400
X-MC-Unique: riBmDOT3P8KigrYGOn4eoQ-1
X-Mimecast-MFC-AGG-ID: riBmDOT3P8KigrYGOn4eoQ_1787653512
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE763195411C; Tue, 25 Aug 2026 10:25:11 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 466731955F08; Tue, 25 Aug 2026 10:25:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 14:20:53 +0400
Subject: [PATCH 16/18] virtio-gpu/virgl: disable scanouts on resource unref
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-virtio-gpu-cleanup-v1-16-d3bb612b9975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Y0tBxOCRhZ4/rYS0r3lXS7G/w7edV54bjwQPuP6dIb0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjWyY8AwaBR8KmCakQbp3wxyxK3UXDtlXCaeGy
 2may6utWYqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao1smAAKCRDa6OEJdZac
 5Q6hD/422+BCA8YCUnNDxnIS2elAytfZrEPp+tgQMh9VkFl63LCKm+h91UyH40tvgVbb1Nb7Pdd
 dNeSgt4HLl6GiD5yslF+VvEkaCdK4wOd7GmppHTTNBOwjwwzQK4XcttZhnAqnuBtDZhQC7eUm2E
 Daw0XZWpjdybeFoRCVfbj9KSrT+l9VRWEIZRf3Lmz9ghIHKg9eJ7iesYq/GAiZPO8Z/E12K1nEk
 9ikUKWyrnXPGR10L4nsyOlmgyasny/rPQkunRIifvWNZSUaBs2kDgGjLflWUqKWhYLq19Sor6PM
 VzULKlUBsMwqh2Kji687hPsXfX6bnh9mVSkmL4EtWs9bgvESrSkOTQgKsI0VyNIL7FgM2YBweu8
 iQ9ABCCUX5ZjRGr9E07nevkK2v6OUBaPMhO1jnmbgaeHb44r5zdq0LqVio7oeOV3+sAs5wZndii
 bVrotTPtF5to10Qfoep3RLULxaPQ1VhRnvzASER58kewyBJWBaCbL2w6TE12yWFgFj4PKe0So2B
 E2vWPJRVGYwp+wLLJ/wMBsGtW6voiMyeuGotEIFCRMFP548sJEgygD6xtcjKvKkfNEFUqFoi6Ps
 D2yc4DvfqhqQI7K0u02/21Kiaw//4PpwVh7LDgjfqFiya0M8ux8e632JZurOlB2vjG5AWWVS7qB
 SCBmPogYaOtLyGQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-virgl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index e2ad27343da5..8b27fe3980d6 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -412,6 +412,7 @@ virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
 {
     struct iovec *res_iovs = NULL;
     int num_iovs = 0;
+    int i;
 #if VIRGL_VERSION_MAJOR >= 1
     int ret;
 
@@ -424,6 +425,12 @@ virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
     }
 #endif
 
+    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
+        if (g->parent_obj.scanout[i].resource_id == res->base.resource_id) {
+            virtio_gpu_disable_scanout(g, i);
+        }
+    }
+
     virgl_renderer_resource_detach_iov(res->base.resource_id,
                                        &res_iovs,
                                        &num_iovs);

-- 
2.55.0.543.g5ebe2ebe4ea8


