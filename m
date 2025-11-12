Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1856FCCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 08:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ66L-0003n0-65; Wed, 12 Nov 2025 03:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vJ66I-0003gw-RI
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 03:21:10 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vJ66G-0007iP-LX
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 03:21:10 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AC8L495004430
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 12 Nov 2025 17:21:04 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=n2HXNTgh7jfEVYLhmEL6JS0qBH8EMM/P9LiVHXSVdtQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762935664; v=1;
 b=d7edQjSmzOJbnmvBT8NN25KGh1yWXD2TMmIkzMP5c9eHS+csrdEUZpfwr98BIpta
 yqhXYZjiyuf5GFGlJttW2ZLHrSaekCeVbDW05py3l0cBehFRMyWBfbSLt3S+m90t
 oG591h3iGK9g23TEWsMaXtD3N0WN4RH2emS3uWoQVKQb36/L3nv9ySlBw+LTA3sO
 xdj9LtJixsAdgeXhKg/k7nrHs3xiLu4K1eqXLcsCg9GdSxgA1iOagwAJAwdzorld
 3ZIDIQ49IOkKGRBzNlNLbvnrXTIPiwdwR4IIpU1Fg0jSxdAYbc7HnnOpBeC63wxS
 C9Xhm8pubtpDBV+3l/cizA==
Message-ID: <77fd4755-a880-4a69-90fd-7153183ebaf3@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 12 Nov 2025 17:21:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] virtio-gpu-dmabuf: Introduce
 qemu_iovec_same_memory_regions()
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-10-vivek.kasireddy@intel.com>
 <83274ca7-dd37-4856-b198-f334bf630835@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185F1DA0CD274FBB2C30672F8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB7185F1DA0CD274FBB2C30672F8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
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

On 2025/11/12 13:24, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v2 09/10] virtio-gpu-dmabuf: Introduce
>> qemu_iovec_same_memory_regions()
>>
>> On 2025/11/09 14:33, Vivek Kasireddy wrote:
>>> Add a helper to check whether the addresses in an iovec array
>>> belong to the same memory region or not. This is useful to verify
>>> before trying to create a dmabuf from an iovec array.
>>>
>>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> Cc: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>> Cc: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>> ---
>>>    hw/display/virtio-gpu-dmabuf.c | 29 +++++++++++++++++++++++++++++
>>>    1 file changed, 29 insertions(+)
>>>
>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
>> dmabuf.c
>>> index c34d4c85bc..80143034d4 100644
>>> --- a/hw/display/virtio-gpu-dmabuf.c
>>> +++ b/hw/display/virtio-gpu-dmabuf.c
>>> @@ -27,6 +27,31 @@
>>>    #include "standard-headers/linux/udmabuf.h"
>>>    #include "standard-headers/drm/drm_fourcc.h"
>>>
>>> +static bool qemu_iovec_same_memory_regions(const struct iovec *iov,
>> int iov_cnt)
>>> +{
>>> +    RAMBlock *rb, *curr_rb;
>>> +    ram_addr_t offset;
>>> +    int i;
>>> +
>>> +    rb = qemu_ram_block_from_host(iov[0].iov_base, false, &offset);
>>> +    if (!rb) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "%s: Could not find ramblock/memory region\n", __func__);
>>> +        return false;
>>> +    }
>>> +
>>> +    for (i = 1; i < iov_cnt; i++) {
>>> +	curr_rb = qemu_ram_block_from_host(iov[i].iov_base, false,
>> &offset);
>>> +	if (curr_rb != rb) {
>>> +            qemu_log_mask(LOG_GUEST_ERROR,
>>> +                          "%s: memory regions not same for iov entries\n",
>>> +                          __func__);
>>> +            return false;
>>> +	}
>>> +    }
>>> +    return true;
>>> +}
>>> +
>>>    static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource
>> *res)
>>>    {
>>>        struct udmabuf_create_list *list;
>>> @@ -137,6 +162,10 @@ void virtio_gpu_init_dmabuf(struct
>> virtio_gpu_simple_resource *res)
>>>            res->iov[0].iov_len < 4096) {
>>>            pdata = res->iov[0].iov_base;
>>>        } else {
>>> +        if (!qemu_iovec_same_memory_regions(res->iov, res->iov_cnt)) {
>>> +            return;
>>> +        }
>>> +
>>
>> This check is unnecessary. Perhaps rejecting iov with different memory
>> regions may be fine if that simplifies the code, but this actually adds
>> some code.
> I think we can keep this sanity check but I don't really mind dropping this
> patch given that buffers with mixed memory regions are not encountered
> in practical situations. Or, I guess I could move the if (curr_rb != rb) check
> to virtio_gpu_create_udmabuf() and vfio_device_create_dmabuf_fd()
> like you suggested previously.

I won't call it a "sanity check"; it is "unlikely" to have different 
memory regions, but it is still not "wrong" and is sane.

The VFIO code path still needs to check if the memory regions belong to 
one VFIO device. Trying to create one DMA-BUF using multiple VFIO 
devices is wrong.

Regards,
Akihiko Odaki

