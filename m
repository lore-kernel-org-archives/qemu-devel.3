Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31DED10380
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 21:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t450M-0000xo-BI; Thu, 24 Oct 2024 17:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t450G-0000xC-Dw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:04:21 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t450E-0002Ce-N1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:04:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1729803844; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BQtA3vNjrBXB/veRtTUsndoJcc2TK8zRyuPWPxAv5oJeZZ6IBhbiPeL67b3Er2LO0QLoAXEMQvABI0r1M53fzXhjMiLBJ4YQ1pb07KxClvKf3VeSUt2QAYpbM8ewRKVIwt9mo93XfLUQC5heB9xZ19Q4fBdiCEyY5zP7CsHOHk8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1729803844;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=R4GzjIM7PsvQS30r7Two4nt6M6TL5EQYLymPdCbZjFs=; 
 b=Go3iU7opXhGNlqr29UIPUWT8oSxUbD1+s81Wg++vx3SYPAZ8OTyr1i2a27C/zm9ncVMXvqgfUmK0TtHRQbPe5PTu/fnwUym/TIf81DUki2gHJe0UjIR+AoFztyfSaDQPu4ewLn8ECQCW0ZJ56AnQQPrJnntuOmPWy/U8i5ZduaA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729803844; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=R4GzjIM7PsvQS30r7Two4nt6M6TL5EQYLymPdCbZjFs=;
 b=eULvlKUI/lt4z9vtanfdnz9tzoP/lqSxBGQPDOKFTdQdhdlUHolfb+mKhIVxRouK
 n/KRyJf1h6jueidbl+ddu23sjKrIMIgSNqg6CBzv6ki6g0cMR8VjNkQui/cwEUhGn+t
 B/2V2u0AeAhipUCr1rnW/wanECosxZrhZsdIchcA=
Received: by mx.zohomail.com with SMTPS id 1729803842640914.136009385541;
 Thu, 24 Oct 2024 14:04:02 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
Subject: [PATCH v18 05/13] virtio-gpu: Unrealize GL device
Date: Fri, 25 Oct 2024 00:03:03 +0300
Message-ID: <20241024210311.118220-6-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024210311.118220-1-dmitry.osipenko@collabora.com>
References: <20241024210311.118220-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Even though GL GPU doesn't support hotplugging today, free virgl
resources when GL device is unrealized. For consistency.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-gl.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index ea3413aa566f..753b35ed69fd 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -156,6 +156,22 @@ static Property virtio_gpu_gl_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
+{
+    VirtIOGPU *g = VIRTIO_GPU(qdev);
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(qdev);
+
+    if (gl->renderer_state >= RS_INITED) {
+        if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
+            timer_free(gl->print_stats);
+        }
+        timer_free(gl->fence_poll);
+        virgl_renderer_cleanup(NULL);
+    }
+
+    gl->renderer_state = RS_START;
+}
+
 static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -169,6 +185,7 @@ static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
     vgc->update_cursor_data = virtio_gpu_gl_update_cursor_data;
 
     vdc->realize = virtio_gpu_gl_device_realize;
+    vdc->unrealize = virtio_gpu_gl_device_unrealize;
     vdc->reset = virtio_gpu_gl_reset;
     device_class_set_props(dc, virtio_gpu_gl_properties);
 }
-- 
2.47.0


