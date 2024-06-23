Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA26EC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 13:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLMpc-00038E-UA; Sun, 23 Jun 2024 09:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sLMpS-00036m-Pt
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 09:00:25 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sLMpQ-00077d-IT
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 09:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1719147616;
 bh=KZNMfH0731ceSOSoB1Px/Y+CdznOMIA78lZrOXCWtLc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CTWYZFoeEtl6fRXgBdK1DevGdxd+1+WFl2g8/CtWDO8MT2hIDiYbCKPM59TcMjKMc
 isn4RU4MdFH4DcchjKGY4H110Myu4uSRD74KWVMVZSV2ypSiENIYrGXG0OxSgsgXk+
 zBae8AqijO/nKQFjgiu/MFojVGa4jYZiMF/mxAMDVkiRmZ+uf2gBzsccU2R9RQey8K
 KKQrq0s1Oi2Q49DRqr95NNUf6AvJwE43vY9GbPQwkyp7gdMeVW/yuendjGJagPo9+4
 h0obpn4xXM///JZM8psU1w7G+JnEuuOqc4MSDw7ZS1dssvUYGmWPaBVLSS1FNEbwSb
 a5jZ8ETnaitqw==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id EBB4D37809D2;
 Sun, 23 Jun 2024 13:00:14 +0000 (UTC)
Message-ID: <4024a6d2-bbe2-4675-9f39-57f22025fc45@collabora.com>
Date: Sun, 23 Jun 2024 16:00:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 10/14] virtio-gpu: Support blob scanout using dmabuf fd
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
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
 <5054323e-6b23-4858-b8e5-7d498c2e6521@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <5054323e-6b23-4858-b8e5-7d498c2e6521@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/23/24 08:44, Akihiko Odaki wrote:
> On 2024/06/23 6:55, Dmitry Osipenko wrote:
>> From: Robert Beckett <bob.beckett@collabora.com>
>>
>> Support displaying blob resources by handling SET_SCANOUT_BLOB
>> command.
>>
>> Signed-by: Antonio Caggiano <antonio.caggiano@collabora.com>
>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>> Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>   hw/display/virtio-gpu-virgl.c  | 109 +++++++++++++++++++++++++++++++++
>>   hw/display/virtio-gpu.c        |  12 ++--
>>   include/hw/virtio/virtio-gpu.h |   7 +++
>>   3 files changed, 122 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/display/virtio-gpu-virgl.c
>> b/hw/display/virtio-gpu-virgl.c
>> index 3ffea478e723..60befab7efc2 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -17,6 +17,8 @@
>>   #include "trace.h"
>>   #include "hw/virtio/virtio.h"
>>   #include "hw/virtio/virtio-gpu.h"
>> +#include "hw/virtio/virtio-gpu-bswap.h"
>> +#include "hw/virtio/virtio-gpu-pixman.h"
>>     #include "ui/egl-helpers.h"
>>   @@ -78,6 +80,7 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU
>> *g,
>>       res->base.height = c2d.height;
>>       res->base.format = c2d.format;
>>       res->base.resource_id = c2d.resource_id;
>> +    res->base.dmabuf_fd = -1;
>>       QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
>>         args.handle = c2d.resource_id;
>> @@ -125,6 +128,7 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU
>> *g,
>>       res->base.height = c3d.height;
>>       res->base.format = c3d.format;
>>       res->base.resource_id = c3d.resource_id;
>> +    res->base.dmabuf_fd = -1;
>>       QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
>>         args.handle = c3d.resource_id;
>> @@ -509,6 +513,106 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
>>       g_free(resp);
>>   }
>>   +#if VIRGL_VERSION_MAJOR >= 1
>> +static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
>> +                                       struct virtio_gpu_ctrl_command
>> *cmd)
>> +{
>> +    struct virtio_gpu_framebuffer fb = { 0 };
>> +    struct virgl_renderer_resource_info info;
>> +    struct virtio_gpu_virgl_resource *res;
>> +    struct virtio_gpu_set_scanout_blob ss;
>> +    uint64_t fbend;
>> +
>> +    VIRTIO_GPU_FILL_CMD(ss);
>> +    virtio_gpu_scanout_blob_bswap(&ss);
>> +    trace_virtio_gpu_cmd_set_scanout_blob(ss.scanout_id, ss.resource_id,
>> +                                          ss.r.width, ss.r.height,
>> ss.r.x,
>> +                                          ss.r.y);
>> +
>> +    if (ss.scanout_id >= g->parent_obj.conf.max_outputs) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout id
>> specified %d",
>> +                      __func__, ss.scanout_id);
>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
>> +        return;
>> +    }
>> +
>> +    if (ss.resource_id == 0) {
>> +        virtio_gpu_disable_scanout(g, ss.scanout_id);
>> +        return;
>> +    }
>> +
>> +    if (ss.width < 16 ||
>> +        ss.height < 16 ||
>> +        ss.r.x + ss.r.width > ss.width ||
>> +        ss.r.y + ss.r.height > ss.height) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds
>> for"
>> +                      " resource %d, rect (%d,%d)+%d,%d, fb %d %d\n",
>> +                      __func__, ss.scanout_id, ss.resource_id,
>> +                      ss.r.x, ss.r.y, ss.r.width, ss.r.height,
>> +                      ss.width, ss.height);
>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>> +        return;
>> +    }
>> +
>> +    res = virtio_gpu_virgl_find_resource(g, ss.resource_id);
>> +    if (!res) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist
>> %d\n",
>> +                      __func__, ss.resource_id);
>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>> +        return;
>> +    }
>> +    if (virgl_renderer_resource_get_info(ss.resource_id, &info)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not have
>> info %d\n",
>> +                      __func__, ss.resource_id);
>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>> +        return;
>> +    }
>> +    if (res->base.dmabuf_fd < 0) {
>> +        res->base.dmabuf_fd = info.fd;
> 
> Just in case you missed my previous email:
>> res->base.dmabuf_fd is conditionally assigned but
>> virgl_renderer_resource_get_info() is called unconditionally, which is
>> inconsistent.
> 
>> The relevant code is better to be moved into
>> virgl_cmd_resource_create_blob() for consistenty with
>> virtio_gpu_resource_create_blob().

Right, I squashed this change into patch #12 instead of #10 by mistake.
Will fix it shortly, thanks for the review!

-- 
Best regards,
Dmitry


