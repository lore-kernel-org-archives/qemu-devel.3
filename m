Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99720C5518F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr9SJ-0002Yu-21; Tue, 04 Aug 2026 03:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wr9SD-0002M3-Ux
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 03:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wr9SB-0001Vo-Pk
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 03:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785828045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/YLITtyQZk/29n/Ki+VXTGedtcpRCCASc2TUbUo+E6I=;
 b=AkarhlSoZWc3sChrHDRKHJhUzmp+8YPw6dsu7DSX8Y4sl9wEGdzQTSXlDXlju5vQ+JNBAV
 Ure3M1NggRZMxGPOodHlA2MiY0rwP2SXnwUNF15qKM1+rTtuobwNkuQgq8JxLRuszm/vto
 hvVwPpyCNNMOEtC+WOBdIaq/ACZ3KSg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-u3HbEawpMfipLhlYryj9jA-1; Tue,
 04 Aug 2026 03:20:38 -0400
X-MC-Unique: u3HbEawpMfipLhlYryj9jA-1
X-Mimecast-MFC-AGG-ID: u3HbEawpMfipLhlYryj9jA_1785828034
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B50C1800623; Tue,  4 Aug 2026 07:20:34 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88A81300019F; Tue,  4 Aug 2026 07:20:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 04 Aug 2026 11:18:54 +0400
Subject: [GIT PULL 5/9] hw/display/virtio-gpu: drop redundant node->value
 NULL checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-fix-v1-5-0c2be5390809@redhat.com>
References: <20260804-fix-v1-0-0c2be5390809@redhat.com>
In-Reply-To: <20260804-fix-v1-0-0c2be5390809@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sjywyeADAIGro/JFp1dJCBH1U0aQQKbRC3WkRHfn7go=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcZJdZ+qbUs7Va0TESwMg46J2DvVidvH2in6uy
 aH1yUKQK3yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanGSXQAKCRDa6OEJdZac
 5UF6D/9aZUCkIydDEJyM47s7eDMJTqXBH/38424s+CWkbzvg3pSnoBQlGo3sVoRaCiO8+oQTXt5
 +YFbX1oKstEn78dctW+XWjxJxrZw6SNA14W+6piRIqOoEGgZ/d28qQSas+6TNHxFbnWWbrUeqOt
 8rD6Odk+Cbqg/KCBUbxUPQJaE16UXePomZ8T6Pt/5Icxs5irnyDgz69qlk/pz/SuzO2VRc+WGbQ
 5O6I7uPXWF9cGN9KwFXzwB9y2Fxm0kxr8YduXkqaQ5xdUD6MOc3gSE9J0uW/DSSha58BxUjbxjd
 MU3qM0kgevM7ypfaN5LjHHEyoWttzp9mEMz6i4eleuDhM8SUp5sXVzJCi1x9U1Mz3Vvn5fIIZJT
 h3x494RnRYY3dEhF7ImWnrX+AVJz0Xk+XrjAROmYxC4sVx09+o7ksKh19ZLp4MYKBavDO56vhVZ
 aXK2Rcwgv60L1HmzYYDz4zX/W9KvaQthxV5isLpClo8Xi3xdBEhXdPiNBVZ74upb1FIklYfEzqj
 JKzG7uSF2mhMk7moiquy/gstEKSuMRa+qyOBiJuC0j25QorALLArTB8rDK8jm7Yr2TrP+Y4nyoJ
 n+RrSUeJ2/Aob61PacOYIqcdKXGXTnVnIxlX+hds1ibKF9hyW7kSUbxIJdnWspGJkHtASSeY1iy
 IJgZqlU0NGAzKCA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

QAPI-generated list visitors guarantee that node->value is never NULL:
the input visitor allocates it via g_malloc0() in visit_start_struct(),
and on failure the entire list parse is aborted and freed.

Remove the unnecessary NULL checks from both callsites iterating
g->conf.outputs.

Resolves: Coverity CID 1664272
Fixes: 8dc8449a678f ("hw/display/virtio-gpu: Avoid leaking migration blocker")
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260730114751.3515083-1-marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 946e56b42f61..270fbaae1029 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -69,7 +69,7 @@ virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
 
     for (output_idx = 0, node = g->conf.outputs;
          output_idx <= scanout && node; output_idx++, node = node->next) {
-        if (output_idx == scanout && node->value && node->value->name) {
+        if (output_idx == scanout && node->value->name) {
             info.name = node->value->name;
             break;
         }
@@ -206,7 +206,7 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
             error_setg(errp, "invalid outputs > %d", g->conf.max_outputs);
             return false;
         }
-        if (node->value && node->value->name &&
+        if (node->value->name &&
             strlen(node->value->name) > EDID_NAME_MAX_LENGTH) {
             error_setg(errp, "invalid output name '%s' > %d",
                        node->value->name, EDID_NAME_MAX_LENGTH);

-- 
2.55.0


