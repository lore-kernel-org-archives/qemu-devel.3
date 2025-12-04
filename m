Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04BED1D868
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 05:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR1wZ-00037O-VG; Thu, 04 Dec 2025 00:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vR1wX-00036z-UZ
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 00:31:53 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vR1wU-0002Jp-Uy
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 00:31:53 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5B45VEHr023952
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 4 Dec 2025 14:31:36 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=5YCO9vmEGW80spn7Wmpyy86tpO/KMgSIX5PYPj0XfPI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1764826296; v=1;
 b=UbVoYAl8FkQO1XU4y3KVLX/4+kpKKaoXd3ic9+1DvoQmO9uTIe7tDByrkldOVSmk
 ysPOIa+IpW57nNIC65uacPX5QsolM26S8zJAIX9tj5jnp8jfXSR9p8oZ56zjkjj6
 v3rWdiZ1k4/gOz2ekFlQGAiYjUVQ51ZVMKt4gNeNVl++t0cOuFc+QnWhd5lG2+UJ
 Yk6MFZLs04+Ymaua/gZ8Q3SrxTvxgCR5atJceffUncykL/GVlKSCsC8692qHPu5T
 h1gmY4TFAFZyuinCDqBOr/DkdKHiRZUHaOnUHaDfwAYLw6QffigV2sYYReoeGx/s
 h7eFHd2aQ8uA083UdijhRA==
Message-ID: <adb62ec3-93ed-404e-ba25-6fa3298f74b0@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 4 Dec 2025 14:31:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/7] virtio-gpu-virgl: check page alignment of blob
 mapping
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-3-j@getutm.app>
 <b5e61b9f-3afb-42c4-a185-eaf659a4c11c@rsg.ci.i.u-tokyo.ac.jp>
 <CA+E+eSBGE7ZkhPngyurL1s-D6NXnFJLU7Yyq8nZtRu8ou+mB0g@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CA+E+eSBGE7ZkhPngyurL1s-D6NXnFJLU7Yyq8nZtRu8ou+mB0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/12/04 13:01, Joelle van Dyne wrote:
> The problem specifically with how Mesa uses it is that
> virtgpu_ioctl_map calls the IOCTL DRM_IOCTL_VIRTGPU_MAP which performs
> the VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB with an unaligned offset.

The kernel is the one who determines the offset, not Mesa. And I cannot 
blame the kernel either because the virtio specification says nothing 
about the alignment requirement.

> virtio_gpu_virgl_map_resource_blob does not error and hv_vm_map
> returns silently without doing any maps. Once that makes it to Mesa,
> it will try to mmap() and then use the region with vector instructions
> that are not supported by HVF because HVF does not emulate
> instructions when ISV=0 (this was a topic of discussion many times for
> other features like TPM emulation).

This explains the situation well. Please add a comment with a similar 
explanation and change this to perform the check only if
!IS_ENABLED(HOST_AARCH64) && tcg_enabled() (apparently kvm and whpx[1] 
have the same issue) so that it won't break other configurations.

[1] 
https://lore.kernel.org/qemu-devel/20251121100240.89117-1-mohamed@unpredictable.fr/

Regards,
Akihiko Odaki

> 
> On Wed, Dec 3, 2025 at 6:56 PM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2025/12/03 13:07, Joelle van Dyne wrote:
>>> Currently if a mapping is not page aligned, it will sliently fail and the
>>> guest, assuming it is mapped, will attempt to access the memory and fail.
>>> This is particularly an issue on macOS when the host page size is 16KiB and
>>> the guest page size is 4KiB.
>>
>> It should work. If I understand correctly, tcg doesn't care the host
>> page size. hvf will not call hv_vm_map() for misaligned regions and that
>> causes Data Abort, but it is handled by QEMU to perform memory access. I
>> think it needs more debugging.
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>>> ---
>>>    hw/display/virtio-gpu-virgl.c | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)
>>>
>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>> index 20c856c04e..adf02ac22b 100644
>>> --- a/hw/display/virtio-gpu-virgl.c
>>> +++ b/hw/display/virtio-gpu-virgl.c
>>> @@ -116,6 +116,20 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>>            return ret;
>>>        }
>>>
>>> +    if (!QEMU_IS_ALIGNED((uintptr_t)data, qemu_real_host_page_size())) {
>>> +        virgl_renderer_resource_unmap(res->base.resource_id);
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: address %p is not aligned to page size\n",
>>> +                      __func__, data);
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    if (!QEMU_IS_ALIGNED(size, qemu_real_host_page_size())) {
>>> +        virgl_renderer_resource_unmap(res->base.resource_id);
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: size 0x%llx is not aligned to page size\n",
>>> +                      __func__, size);
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>>        vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
>>>        vmr->g = g;
>>>
>>


