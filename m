Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25481CCD19A
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Nov 2025 13:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKdDB-0004Ll-Ub; Sun, 16 Nov 2025 08:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKdDB-0004Ld-2c
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 08:54:37 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKdD9-0001CD-Bi
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 08:54:36 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763301258; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Bdkfi2xnwf7WbKWAhWqmXI+wk/moYUCG7oMWPYS9I7Iroo2mpxU451W849NNEUJFW7M3PghkJy1DhaFBVp1Tku69hVZ1+enbVz66jc21j9kUsPZ0YVHGDNlYHAXK1A2a2ybosMq6g9M8FGp2tH9biQK4Afhhk8iEW1ncDnEcreo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763301258;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=poHVKhwpw1ZzROjuD1JvbWMikwHoRE4hz0xrgrZKGx4=; 
 b=gIl1YbRvsCVa+nraCKRYR28bXwGukNGybYvmJBJx4A4XmXGcDtecYWC4QArPd30T1iUegZQI2RBTDkZgDb2UrNoeNUKowDxc2Asrz1CNTEEaH5vvgTKjM/Sm7IP52VVWq5qZaYJSqHpqCssCpmJaxPgwBNpLkHmZ3q8Ofvzs46k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763301258; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=poHVKhwpw1ZzROjuD1JvbWMikwHoRE4hz0xrgrZKGx4=;
 b=JMNGYpnvZtQthOg5/nk58QdCtDvqAEMhJzRCsh9GGKZimxzW9wZVzPMOsvvKlMSd
 WZkqyxE7QzPH78TnrMOPO2Z/HzafqFaxyPPsYnqc6bw/MN8ERgH1KbBdurkhFGYRGsM
 /vBpHHnJzbjv/R4g1FAIIJ3lNTMuaYQn+cJ2NUwI=
Received: by mx.zohomail.com with SMTPS id 1763301257265209.3884524764877;
 Sun, 16 Nov 2025 05:54:17 -0800 (PST)
Message-ID: <dc98cd65-6ae9-4d7f-b88a-59d741ee980f@collabora.com>
Date: Sun, 16 Nov 2025 16:54:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] virtio-gpu: Support mapping hostmem blobs with
 map_fixed
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
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
References: <20251112233118.1475381-1-dmitry.osipenko@collabora.com>
 <20251112233118.1475381-2-dmitry.osipenko@collabora.com>
 <4eceb841-8767-4d70-91b1-f6288e6f8a22@rsg.ci.i.u-tokyo.ac.jp>
 <211751d8-c6b5-42f3-8623-324bb23a63b9@rsg.ci.i.u-tokyo.ac.jp>
 <87e09bf2-117e-4b59-afec-d6ee135e0b88@collabora.com>
Content-Language: en-US
In-Reply-To: <87e09bf2-117e-4b59-afec-d6ee135e0b88@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender3-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/13/25 15:16, Dmitry Osipenko wrote:
> Hello Akihiko,
> 
> On 11/13/25 09:51, Akihiko Odaki wrote:
>> On 2025/11/13 11:52, Akihiko Odaki wrote:
>>> On 2025/11/13 8:31, Dmitry Osipenko wrote:
>>>> Support mapping virgl blobs to a fixed location of a hostmem memory
>>>> region using new virglrenderer MAP_FIXED API.
>>>>
>>>> This new feature closes multiple problems for virtio-gpu on QEMU:
>>>>
>>>> - Having dedicated memory region for each mapped blob works notoriously
>>>> slow due to QEMU's memory region software design built around RCU that
>>>> isn't optimized for frequent removal of the regions
>>>>
>>>> - KVM isn't optimized for a frequent slot changes too
>>>>
>>>> - QEMU/KVM has a limit for a total number of created memory regions,
>>>> crashing QEMU when limit is reached
>>>>
>>>> This patch makes virtio-gpu-gl to pre-create a single anonymous memory
>>>> region covering whole hostmem area to which blobs will be mapped using
>>>> the MAP_FIXED API.
>>>>
>>>> Not all virgl resources will support mapping at a fixed memory
>>>> address. For
>>>> them, we will continue to create individual nested memory sub-
>>>> regions. In
>>>> particular, vrend resources may not have MAP_FIXED capability.
>>>>
>>>> Venus and DRM native contexts will largely benefit from the MAP_FIXED
>>>> feature in terms of performance and stability improvement.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>> ---
>>>>   hw/display/virtio-gpu-gl.c     | 37 +++++++++++++++++
>>>>   hw/display/virtio-gpu-virgl.c  | 72 +++++++++++++++++++++++++++++++++-
>>>>   include/hw/virtio/virtio-gpu.h |  3 ++
>>>>   3 files changed, 110 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
>>>> index b640900fc6f1..e1481291948a 100644
>>>> --- a/hw/display/virtio-gpu-gl.c
>>>> +++ b/hw/display/virtio-gpu-gl.c
>>>> @@ -122,6 +122,9 @@ static void
>>>> virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
>>>>   {
>>>>       ERRP_GUARD();
>>>>       VirtIOGPU *g = VIRTIO_GPU(qdev);
>>>> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>>>> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
>>>
>>> Nitpick: this order is slightly odd as VirtIOGPUBase is the base class
>>> of VirtIOGPU and VirtIOGPUGL. So let's do:
>>>
>>> VirtIOGPUBase *b = VIRTIO_GPU_BASE(qdev); // super class of b
>>> VirtIOGPU *g = VIRTIO_GPU(qdev); // base class of gl
>>> VirtIOGPUGL *gl = VIRTIO_GPU_GL(qdev);
>>>
>>> Arguments are unified to qdev for consistency with other functions.
>>>
>>>> +    void *map;
>>>>   #if HOST_BIG_ENDIAN
>>>>       error_setg(errp, "virgl is not supported on bigendian platforms");
>>>> @@ -152,6 +155,31 @@ static void
>>>> virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
>>>>   #endif
>>>>       virtio_gpu_device_realize(qdev, errp);
>>>> +
>>>> +    /*
>>>> +     * Check whether virtio_gpu_device_realize() failed.
>>>> +     */
>>>> +    if (!g->ctrl_bh) {
>>>
>>> Instead, do:
>>> if (*errp) {
>>>      return;
>>> }
>>>
>>> With this change it is clear that it checks whether
>>> virtio_gpu_device_realize() failed so the comment will be unnecessary.
>>>
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (virtio_gpu_hostmem_enabled(b->conf)) {
>>>> +        map = mmap(NULL, b->conf.hostmem, PROT_NONE,
>>
>> I'm concerned that mapping with PROT_NONE may allow the guest crash QEMU
>> by accessing the hostmem region without blobs, especially with TCG (not
>> sure about KVM).
>>
>> Perhaps PROT_READ | PROT_WRITE may be a safe choice. It is ugly and lets
>> the guest read and write garbage to the region without blobs, but at
>> least avoids crashes.
> 
> Thanks a lot for a quick and thorough review, very appreciate. Will test
> how KVM behaves when accessing PROT_NONE and address TCG + rest of the
> comments.

KVM faults and terminates QEMU. Both KVM and TCG shouldn't use
PROT_NONE, good catch.

-- 
Best regards,
Dmitry

