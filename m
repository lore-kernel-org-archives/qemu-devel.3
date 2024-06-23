Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DBFC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 05:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLG2M-0005vE-31; Sun, 23 Jun 2024 01:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLG2H-0005uw-8S
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 01:45:09 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLG2F-0000u6-6w
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 01:45:09 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c7a6da20f2so2654442a91.0
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 22:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719121505; x=1719726305;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7H7+G3pYIGPwXLN6p4bMkrC+Z5RldzGH2+dG6pMRikQ=;
 b=f+OHAqxnUoIk9NlW4qgYZmNhn+c/QtR0KdVzYAh8Nro6oVqKXSqu7AfLMg/8q5zZj6
 yrODxHkVybxMk2xJY6CEzpz2llBvpXvi4pliDWJL0qE9Qy2xpZnUOO8wB0+ZUzZxCfx5
 vkHilhUrPBqu2qNg/wBTwMzMFEWr8KjyWgMRx7lE+YBIeAyKPchSddPxOSP9fJE3ApXq
 wvrklPXtNzXjPXL/oriNTAxIteV2e8NVe7dnX5lJ2HWPW3WN3gpa6O2azt5Ng6pqz+Q/
 4iW5LUhaRT2lq/T2w3BtrB5zKLzzZUeKMPRuY/HJIhi+XAm+LmHyx7MD1bQRDTH0qKMg
 nJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719121505; x=1719726305;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7H7+G3pYIGPwXLN6p4bMkrC+Z5RldzGH2+dG6pMRikQ=;
 b=ffZGuuMwtkuzBUo3mKyLHaJ/6DScbuKGcB++dRDZZi2r9kacEw65uMjB84TB0ONKbk
 0uU92tEKSRvG4a6g676qmIP/eokybEyEupxDImhCkH0la6GgP+fWds98LoCnctwvX/Sl
 fhbirNUG9Jd2KB+M3dnO0twchnrLP2Ujy7zA15kHFCGqxIP4yOBJj6EKXaXykXcHdci0
 xk7FlKGVDsOT6n5jR+V2YlmU2Akp5GCbH81wQwqWKCZN+onoBCkyzZSOpFU46lbdK1O9
 fS7w4urvOkc/nDnPRYV0RT+zzG3yOVnpy+losS7Ub9aKSiWEKEDXnxQWGFIEj2aTGEkJ
 T3aw==
X-Gm-Message-State: AOJu0YzQCXDwkrle0VCLVaQ7Qlk783Vm5sdE8eOtFzO7XHKtPtGMnxXR
 lNlKY2o3bDDtuaW/QyKWPivEhvZ4C8XQFYIGTosTD9mx0G6ZmJi3JllPuo1HVTU=
X-Google-Smtp-Source: AGHT+IGg3ZvhMn8BoBVYicJMN+qXrrvNREgnCOLUu2heMWIak0KmBLUGBjguRgrjByfChRo4mi/hbA==
X-Received: by 2002:a17:90a:610:b0:2c3:1937:3042 with SMTP id
 98e67ed59e1d1-2c8504c7eedmr1635382a91.5.1719121505091; 
 Sat, 22 Jun 2024 22:45:05 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c819a76ccasm4269118a91.13.2024.06.22.22.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Jun 2024 22:45:04 -0700 (PDT)
Message-ID: <5054323e-6b23-4858-b8e5-7d498c2e6521@daynix.com>
Date: Sun, 23 Jun 2024 14:44:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 10/14] virtio-gpu: Support blob scanout using dmabuf fd
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240622215511.154763-1-dmitry.osipenko@collabora.com>
 <20240622215511.154763-11-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240622215511.154763-11-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1036;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/06/23 6:55, Dmitry Osipenko wrote:
> From: Robert Beckett <bob.beckett@collabora.com>
> 
> Support displaying blob resources by handling SET_SCANOUT_BLOB
> command.
> 
> Signed-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-virgl.c  | 109 +++++++++++++++++++++++++++++++++
>   hw/display/virtio-gpu.c        |  12 ++--
>   include/hw/virtio/virtio-gpu.h |   7 +++
>   3 files changed, 122 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 3ffea478e723..60befab7efc2 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -17,6 +17,8 @@
>   #include "trace.h"
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-gpu.h"
> +#include "hw/virtio/virtio-gpu-bswap.h"
> +#include "hw/virtio/virtio-gpu-pixman.h"
>   
>   #include "ui/egl-helpers.h"
>   
> @@ -78,6 +80,7 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>       res->base.height = c2d.height;
>       res->base.format = c2d.format;
>       res->base.resource_id = c2d.resource_id;
> +    res->base.dmabuf_fd = -1;
>       QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
>   
>       args.handle = c2d.resource_id;
> @@ -125,6 +128,7 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
>       res->base.height = c3d.height;
>       res->base.format = c3d.format;
>       res->base.resource_id = c3d.resource_id;
> +    res->base.dmabuf_fd = -1;
>       QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
>   
>       args.handle = c3d.resource_id;
> @@ -509,6 +513,106 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
>       g_free(resp);
>   }
>   
> +#if VIRGL_VERSION_MAJOR >= 1
> +static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
> +                                       struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virtio_gpu_framebuffer fb = { 0 };
> +    struct virgl_renderer_resource_info info;
> +    struct virtio_gpu_virgl_resource *res;
> +    struct virtio_gpu_set_scanout_blob ss;
> +    uint64_t fbend;
> +
> +    VIRTIO_GPU_FILL_CMD(ss);
> +    virtio_gpu_scanout_blob_bswap(&ss);
> +    trace_virtio_gpu_cmd_set_scanout_blob(ss.scanout_id, ss.resource_id,
> +                                          ss.r.width, ss.r.height, ss.r.x,
> +                                          ss.r.y);
> +
> +    if (ss.scanout_id >= g->parent_obj.conf.max_outputs) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout id specified %d",
> +                      __func__, ss.scanout_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
> +        return;
> +    }
> +
> +    if (ss.resource_id == 0) {
> +        virtio_gpu_disable_scanout(g, ss.scanout_id);
> +        return;
> +    }
> +
> +    if (ss.width < 16 ||
> +        ss.height < 16 ||
> +        ss.r.x + ss.r.width > ss.width ||
> +        ss.r.y + ss.r.height > ss.height) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds for"
> +                      " resource %d, rect (%d,%d)+%d,%d, fb %d %d\n",
> +                      __func__, ss.scanout_id, ss.resource_id,
> +                      ss.r.x, ss.r.y, ss.r.width, ss.r.height,
> +                      ss.width, ss.height);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
> +
> +    res = virtio_gpu_virgl_find_resource(g, ss.resource_id);
> +    if (!res) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n",
> +                      __func__, ss.resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +    if (virgl_renderer_resource_get_info(ss.resource_id, &info)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not have info %d\n",
> +                      __func__, ss.resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +    if (res->base.dmabuf_fd < 0) {
> +        res->base.dmabuf_fd = info.fd;

Just in case you missed my previous email:
 > res->base.dmabuf_fd is conditionally assigned but
 > virgl_renderer_resource_get_info() is called unconditionally, which is
 > inconsistent.

 > The relevant code is better to be moved into
 > virgl_cmd_resource_create_blob() for consistenty with
 > virtio_gpu_resource_create_blob().

