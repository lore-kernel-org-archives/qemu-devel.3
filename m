Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C54BF41998
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 12:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCzg5-0006Ub-IZ; Wed, 15 Apr 2026 08:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wCzfw-0006Tv-1E
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 08:49:00 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wCzfs-0003YJ-Ax
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 08:48:59 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 821EF596EA5;
 Wed, 15 Apr 2026 14:48:52 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id qjvcUGEm6UVE; Wed, 15 Apr 2026 14:48:50 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6468E596A23; Wed, 15 Apr 2026 14:48:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 62AC85969EC;
 Wed, 15 Apr 2026 14:48:50 +0200 (CEST)
Date: Wed, 15 Apr 2026 14:48:50 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
cc: slonkazoid <slonkazoid@slonk.ing>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH] add a refresh_rate option to virtio-gpu
In-Reply-To: <24cf0201-8104-4964-b992-847aaf56a7b0@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <74e45718-2212-eb4d-184b-9a4854944a7a@eik.bme.hu>
References: <20260414-virtio-gpu-refresh-rate-v1-1-59e6320eb24e@slonk.ing>
 <24cf0201-8104-4964-b992-847aaf56a7b0@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 15 Apr 2026, Akihiko Odaki wrote:
> On 2026/04/15 3:39, slonkazoid wrote:
>> Signed-off-by: slonkazoid <slonkazoid@slonk.ing>
>> ---
>> currently, the virtio-gpu module does not set a refresh rate, making it
>> default to 75Hz in the qemu edid generation logic. i wrote a sloppy patch
>> that adds a `refresh_rate` option to virtio-gpu, which propagates to all
>> the devices based on it (i was interested in virtio-vga-gl). it's not of
>> much use by itself but when combined with something like Sunshine or
>> looking-glass, it can provide *far* smoother guest graphics than the
>> inbuilt display devices. i have done a bare minimum amount of manual
>> testing (virtio-vga-gl with venus XOR amdgpu drm native context streaming
>> video games) and it functions as intended, and should not break the code
>> path to fetch the refresh rate from the active display device (?), however,
>> i have never contributed to QEMU before and i don't know the customs
>> concerning testing, documentation, etc. if there's more i should do, please
>> tell me! if this is something that would benefit QEMU, feel free to merge 
>> it.
>
>
> Hi,
>
> I think it's fine as long as you confirmed the change actually works.
>
>> it's probably not a copyrightable change anyways.
>> ---
>>   hw/display/virtio-gpu-base.c   | 1 +
>>   include/hw/virtio/virtio-gpu.h | 4 +++-
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
>> index cb76302e2d..d87f6604d0 100644
>> --- a/hw/display/virtio-gpu-base.c
>> +++ b/hw/display/virtio-gpu-base.c
>> @@ -232,6 +232,7 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>>         g->req_state[0].width = g->conf.xres;
>>       g->req_state[0].height = g->conf.yres;
>> +    g->req_state[0].refresh_rate = g->conf.refresh_rate;
>>         for (output_idx = 0, node = g->conf.outputs;
>>            node && output_idx < g->conf.max_outputs;
>> diff --git a/include/hw/virtio/virtio-gpu.h 
>> b/include/hw/virtio/virtio-gpu.h
>> index f69fc19462..66cf921045 100644
>> --- a/include/hw/virtio/virtio-gpu.h
>> +++ b/include/hw/virtio/virtio-gpu.h
>> @@ -131,6 +131,7 @@ struct virtio_gpu_base_conf {
>>       uint32_t flags;
>>       uint32_t xres;
>>       uint32_t yres;
>> +    uint32_t refresh_rate;
>>       uint64_t hostmem;
>>       VirtIOGPUOutputList *outputs;
>>   };
>> @@ -176,7 +177,8 @@ struct VirtIOGPUBaseClass {
>>       DEFINE_PROP_BIT("edid", _state, _conf.flags, \
>>                       VIRTIO_GPU_FLAG_EDID_ENABLED, true), \
>>       DEFINE_PROP_UINT32("xres", _state, _conf.xres, 1280), \
>> -    DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800)
>> +    DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800), \
>> +    DEFINE_PROP_UINT32("refresh_rate", _state, _conf.refresh_rate, 60000)
>
> Please keep the old default value. Not only it is a good practice for 
> usability, it is a requirement for migration compatibility.
> (c.f., docs/devel/migration/compatibility.rst)
>
> I prefer having a macro to define the default value and share it here and at 
> edid-generate.c. (ideally xres and yres should have such macros, but it is 
> out of scope of this change so you are not required to add them.)

There is a DEFINE_EDID_PROPERTIES macro in include/hw/display/edid.h which 
may be used but I'm not sure that sets the same defaults.

Regards,
BALATON Zoltan

> Regards,
> Akihiko Odaki
>
>>     typedef struct VGPUDMABuf {
>>       QemuDmaBuf *buf;
>> 
>> ---
>> base-commit: 985062e2319e6bf4a4be9c216ede6d34379e5777
>> change-id: 20260414-virtio-gpu-refresh-rate-37b388e7dd72
>> 
>> Best regards,
>
>
>

