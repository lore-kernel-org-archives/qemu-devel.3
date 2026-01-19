Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0155D2ECF3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 21:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhx3R-0004c3-HT; Mon, 19 Jan 2026 16:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vhx3P-0004b4-6s
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 16:44:55 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vhx3M-00048B-78
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 16:44:53 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1768859076; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VS6/6fzcYQGVEbTD+oV+qAqzHbBmGX0FH508nN13O5UfDguftNisGZ+wwBkDbZEJFQPEw/dbq90duUXq+rb019TjBQxBlmr/WhLRTs7ZCjYRpjHdQBqAST7FXnJk6PvWJNhohfheR0SSZmUaAyniL/uLMeBJ+Pe148seBbatkuA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1768859076;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=PP3DgryPYrHU7aADd0qWNTZbX0l8G85x+d6Ue0fPhn0=; 
 b=fCQAUyaW1KZTbG8EWZm+eKdzVZHZ3PcGDF9QdrlXiYxsauK06sVnYJnv18i0e171D5nuCjTNMhypB+zn5RNSMpRB68njbmBY7mtxh5voIMekhtGG9NRUvOfUE7p75PaYVnjYl8kbElhPoYbKUq5U3zkNDpEsCk5ml2JInYfGk4E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768859076; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=PP3DgryPYrHU7aADd0qWNTZbX0l8G85x+d6Ue0fPhn0=;
 b=gvv60Gv3WrN7XHzhtKSg53EY4Vm993mMiH5I+wkDWAAr1iwTAKpxJV0U5S85Sc0R
 aVj3VsntRdSySSStLI+IOws2oPzS/0q6nt0tl/J7RpkB6Ts3828gPntoMNclfhxH2hi
 KLtrEtH/3yamtEcbkz2uoOQu99gyGsptaHVb6xTM=
Received: by mx.zohomail.com with SMTPS id 1768859073346199.76650740295713;
 Mon, 19 Jan 2026 13:44:33 -0800 (PST)
Message-ID: <916b868a-184a-46d6-8d16-17bb1454d2de@collabora.com>
Date: Tue, 20 Jan 2026 00:44:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 5/5] virtio-gpu: Support mapping hostmem blobs
 with map_fixed
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
References: <20260118162856.223796-1-dmitry.osipenko@collabora.com>
 <20260118162856.223796-6-dmitry.osipenko@collabora.com>
 <ba1dea86-d599-4978-9e6e-1a3ec610f486@rsg.ci.i.u-tokyo.ac.jp>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <ba1dea86-d599-4978-9e6e-1a3ec610f486@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/19/26 08:59, Akihiko Odaki wrote:
> On 2026/01/19 1:28, Dmitry Osipenko wrote:
>> Support mapping virgl blobs to a fixed location of a hostmem memory
>> region using new virglrenderer MAP_FIXED API.
>>
>> This new feature closes multiple problems for virtio-gpu on QEMU:
>>
>> - Having dedicated memory region for each mapped blob works notoriously
>> slow due to QEMU's memory region software design built around RCU that
>> isn't optimized for frequent removal of the regions
>>
>> - KVM isn't optimized for a frequent slot changes too
>>
>> - QEMU/KVM has a limit for a total number of created memory regions,
>> crashing QEMU when limit is reached
>>
>> This patch makes virtio-gpu-gl to pre-create a single anonymous memory
>> region covering whole hostmem area to which blobs will be mapped using
>> the MAP_FIXED API.
>>
>> Not all virgl resources will support mapping at a fixed memory
>> address. For
>> them, we will continue to create individual nested memory sub-regions. In
>> particular, vrend resources may not have MAP_FIXED capability.
>>
>> Venus and DRM native contexts will largely benefit from the MAP_FIXED
>> feature in terms of performance and stability improvement.
>>
>> Tested-by: Yiwei Zhang <zzyiwei@gmail.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>   hw/display/virtio-gpu-gl.c     | 40 ++++++++++++++++++++++-
>>   hw/display/virtio-gpu-virgl.c  | 59 +++++++++++++++++++++++++++++++++-
>>   include/hw/virtio/virtio-gpu.h |  3 ++
>>   3 files changed, 100 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
>> index 8b71dd6fc26f..add6af73e980 100644
>> --- a/hw/display/virtio-gpu-gl.c
>> +++ b/hw/display/virtio-gpu-gl.c
>> @@ -13,6 +13,7 @@
>>     #include "qemu/osdep.h"
>>   #include "qemu/iov.h"
>> +#include "qemu/mmap-alloc.h"
>>   #include "qemu/module.h"
>>   #include "qemu/error-report.h"
>>   #include "qapi/error.h"
>> @@ -106,7 +107,12 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
>>   static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error
>> **errp)
>>   {
>>       ERRP_GUARD();
>> -    VirtIOGPU *g = VIRTIO_GPU(qdev);
>> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(qdev);
>> +    VirtIOGPU *g = VIRTIO_GPU(b);
>> +#if !defined(CONFIG_WIN32)
>> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>> +    void *map;
>> +#endif
>>     #if HOST_BIG_ENDIAN
>>       error_setg(errp, "virgl is not supported on bigendian platforms");
>> @@ -137,6 +143,27 @@ static void
>> virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
>>   #endif
>>         virtio_gpu_device_realize(qdev, errp);
>> +    if (*errp) {
>> +        return;
>> +    }
>> +
>> +#if !defined(CONFIG_WIN32)
>> +    if (virtio_gpu_hostmem_enabled(b->conf)) {
>> +        map = qemu_ram_mmap(-1, b->conf.hostmem,
>> qemu_real_host_page_size(),
>> +                            0, 0);
>> +        if (map == MAP_FAILED) {
>> +            error_setg_errno(errp, errno,
>> +                             "virgl hostmem region could not be
>> initialized");
>> +            return;
> 
> This "return" will leak bunch of memory allocated in
> virtio_gpu_device_realize(). Though the relization code is not carefully
> written to avoid memory leaks in case of errors, it is better to avoid
> adding another by keeping virtio_gpu_device_realize() at the end.
> 
> By the way, I think this is likely to be my last comment (unless I miss
> nothing more; hopefully it won't happen). This patch and "[RFC PATCH v10
> 2/5] virtio-gpu: Validate hostmem mapping offset" are only useful after
> the new release of virglrenderer is made, but the other patches are
> independelty useful, so I suggest submitting them without RFC.
> 
> Perhaps it may be even fine to submit the MAP_FIXED changes without RFC
> before virglrenderer 1.2.1 is released since the merge request is
> already accepted, but I leave that to you.

Thanks, will move the code in v11. New virglrenderer should be released
soon as Gert Wollny returned form vacation today. May wait for the
release before sending v11 without RFC.

-- 
Best regards,
Dmitry

