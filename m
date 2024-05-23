Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDFBC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 07:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA2eF-00059S-9f; Thu, 23 May 2024 03:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sA2e4-00055C-38
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:13:49 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sA2do-000639-33
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:13:46 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-51f74fa2a82so7747405e87.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 00:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716448409; x=1717053209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XNBJfjr5dr1WJohFuUR+Gkk5XvIY+2qiQ//CtLLHL+8=;
 b=oxULCO8GpT4jaDoTB3Ht15M0RT9bODMizor0QPjdb6ewzdz26oPLYT6//vFqKrIsZ6
 6jaUTclSgAjbHN1hxHW43Lys2GIFPKN4Rfab6O8LNa2Wnpm4MFwoSr7usMEU03mFvgfn
 olgh3uqxOgg+HyYrmIZOtU2w2R4ibKa2Rugwwp11fwVAAYN7gwaANOXrGBzmCIM+uvsj
 hSG44cS3dN8JkIWvsaOjABYetVOKWsc+9K/UpWieYwBP9dh+cLZray4NP1K7llNb7CXc
 vH7jFnq9aDVhbof3EP1d9HKNb54KnxWoyL6eC+whU9aM4a38ORmhWIEEfjb5kYY4qdtL
 lHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716448409; x=1717053209;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XNBJfjr5dr1WJohFuUR+Gkk5XvIY+2qiQ//CtLLHL+8=;
 b=TpxKMJ3LTOgrWMO7ZhGLzAct0VgnKK4dOX8D9CLOd/8ABvpww9H3HyP5i29Li+hVmg
 s5czn0vhRHUue/7Vr1Ncxu1LEe4fTFSmkA46QCsO38SdNoq21AZsJBGkmayqSCsGv3oq
 wc8nTNPajKSXxUDB+4cfK7AdLSGaU4HCSCIJ32QJrTNhU9tRqCTznd2FxkKmj9FyPsWq
 Ho2IsJOrtF0Tj7k8cMxgPg2ubDsmE+S3dmumN64GA/VNrcbLVdUw7iVfBK+jA+14YOJG
 xrtKbgK51m7HxLGOWqHItjnNqMwRbaKhB4z0zb6x2wEA8rzC3Az+Z41SrgOS8g8wdjsw
 mriA==
X-Gm-Message-State: AOJu0Ywi7VBL2c3z4MUuQZuYUncQeqfOw++BIhswn2vEm+IXDmgV39Kc
 v2adDKB+qzpseh1YorT6s/pSEjCSXDSre9e/tNNmIUTz2x3T9Qw5jHyv8DpR69shdRXnAMT7H+3
 C
X-Google-Smtp-Source: AGHT+IG/rENoBxn2dgzSAVKMl6SUe8UY3/7tArWO0VoNGtdiAW1AH+Zu26CrdCaQEIapnX5bHPIAgQ==
X-Received: by 2002:ac2:5312:0:b0:524:473f:8da5 with SMTP id
 2adb3069b0e04-526bf922032mr3600020e87.40.1716448408788; 
 Thu, 23 May 2024 00:13:28 -0700 (PDT)
Received: from meli-email.org (adsl-49.37.6.163.tellas.gr. [37.6.163.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b896a1dsm35836446f8f.32.2024.05.23.00.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 00:13:28 -0700 (PDT)
Date: Thu, 23 May 2024 10:12:20 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@gmail.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 Roger Pau Monn=?UTF-8?B?w6kg?=<roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 Christian K=?UTF-8?B?w7Y=?= nig <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
Subject: Re: [PATCH v12 12/13] virtio-gpu: Register capsets dynamically
User-Agent: meli 0.8.5
References: <20240519212712.2605419-1-dmitry.osipenko@collabora.com>
 <20240519212712.2605419-13-dmitry.osipenko@collabora.com>
In-Reply-To: <20240519212712.2605419-13-dmitry.osipenko@collabora.com>
Message-ID: <dxg2e.kvzfqmh5mmh3@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 20 May 2024 00:27, Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
>From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>
>virtio_gpu_virgl_get_num_capsets will return "num_capsets", but we can't
>assume that capset_index 1 is always VIRGL2 once we'll support more capsets,
>like Venus and DRM capsets. Register capsets dynamically to avoid that problem.
>
>Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>---
> hw/display/virtio-gpu-gl.c     |  6 ++++--
> hw/display/virtio-gpu-virgl.c  | 33 +++++++++++++++++++++------------
> include/hw/virtio/virtio-gpu.h |  4 +++-
> 3 files changed, 28 insertions(+), 15 deletions(-)
>
>diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
>index 4d0a10070ab3..b8f395be8d2d 100644
>--- a/hw/display/virtio-gpu-gl.c
>+++ b/hw/display/virtio-gpu-gl.c
>@@ -135,8 +135,8 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
>     }
> 
>     g->parent_obj.conf.flags |= (1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED);
>-    VIRTIO_GPU_BASE(g)->virtio_config.num_capsets =
>-        virtio_gpu_virgl_get_num_capsets(g);
>+    g->capset_ids = virtio_gpu_virgl_get_capsets(g);
>+    VIRTIO_GPU_BASE(g)->virtio_config.num_capsets = g->capset_ids->len;
> 
> #ifdef HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS
>     g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED;
>@@ -159,6 +159,8 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
>     if (gl->renderer_inited) {
>         virtio_gpu_virgl_deinit(g);
>     }
>+
>+    g_array_unref(g->capset_ids);
> }
> 
> static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
>diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>index a41c4f8e1cef..70e2d28ba966 100644
>--- a/hw/display/virtio-gpu-virgl.c
>+++ b/hw/display/virtio-gpu-virgl.c
>@@ -623,19 +623,13 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
>     VIRTIO_GPU_FILL_CMD(info);
> 
>     memset(&resp, 0, sizeof(resp));
>-    if (info.capset_index == 0) {
>-        resp.capset_id = VIRTIO_GPU_CAPSET_VIRGL;
>-        virgl_renderer_get_cap_set(resp.capset_id,
>-                                   &resp.capset_max_version,
>-                                   &resp.capset_max_size);
>-    } else if (info.capset_index == 1) {
>-        resp.capset_id = VIRTIO_GPU_CAPSET_VIRGL2;
>+
>+    if (info.capset_index < g->capset_ids->len) {
>+        resp.capset_id = g_array_index(g->capset_ids, uint32_t,
>+                                       info.capset_index);
>         virgl_renderer_get_cap_set(resp.capset_id,
>                                    &resp.capset_max_version,
>                                    &resp.capset_max_size);
>-    } else {
>-        resp.capset_max_version = 0;
>-        resp.capset_max_size = 0;
>     }
>     resp.hdr.type = VIRTIO_GPU_RESP_OK_CAPSET_INFO;
>     virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
>@@ -1160,14 +1154,29 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>     return 0;
> }
> 
>-int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>+static void virtio_gpu_virgl_add_capset(GArray *capset_ids, uint32_t capset_id)
>+{
>+    g_array_append_val(capset_ids, capset_id);
>+}
>+
>+GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
> {
>     uint32_t capset2_max_ver, capset2_max_size;
>+    GArray *capset_ids;
>+
>+    capset_ids = g_array_new(false, false, sizeof(uint32_t));
>+
>+    /* VIRGL is always supported. */
>+    virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL);
>+
>     virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
>                               &capset2_max_ver,
>                               &capset2_max_size);
>+    if (capset2_max_ver) {
>+        virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL2);
>+    }
> 
>-    return capset2_max_ver ? 2 : 1;
>+    return capset_ids;
> }
> 
> void virtio_gpu_virgl_deinit(VirtIOGPU *g)
>diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
>index aea559cdacc5..7e1fee836802 100644
>--- a/include/hw/virtio/virtio-gpu.h
>+++ b/include/hw/virtio/virtio-gpu.h
>@@ -208,6 +208,8 @@ struct VirtIOGPU {
>         QTAILQ_HEAD(, VGPUDMABuf) bufs;
>         VGPUDMABuf *primary[VIRTIO_GPU_MAX_SCANOUTS];
>     } dmabuf;
>+
>+    GArray *capset_ids;
> };
> 
> struct VirtIOGPUClass {
>@@ -347,6 +349,6 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
> void virtio_gpu_virgl_reset(VirtIOGPU *g);
> int virtio_gpu_virgl_init(VirtIOGPU *g);
> void virtio_gpu_virgl_deinit(VirtIOGPU *g);
>-int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
>+GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
> 
> #endif
>-- 
>2.44.0
>
>


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

