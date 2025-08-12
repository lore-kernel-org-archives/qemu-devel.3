Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EADACA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 08:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uljz4-0004s4-Fl; Tue, 12 Aug 2025 04:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uljyy-0004rg-Gn
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 04:03:44 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uljyr-0007Xn-V1
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 04:03:43 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 57C837HU039654
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 12 Aug 2025 17:03:08 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=fobMO+6ZpTZRyA8dW9KsHL3gX7arwI/uxdtBgJRXnPU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754985788; v=1;
 b=pMvUhXq+sSilCmtfppQGNaX+ToODC8wFSpMppztJryozg3E11xUCpyyvFok7kGcG
 lsHAoTSAXrkOYFwoy2qLt/ujHYSTvfprthaKWPAhlWaSirq/nDhZA2YJVdED54iG
 3U7z69hJ9J9gwxEpZ6/ZK6Ck54HeccC6GGPbioIqUZGHy+cJG6PdE76FE60fcpru
 3B+gC2w/bR1Lv95lROXT0SrqMJuzbR+GaiF3CQtf6ce8OdhJG3Tmg0oSZIQy+L8T
 HiwbPs53gJwmmq5Sncw0cu0TQrWjRwCy6BANh9EO84aEf/GGwZEIXwrNCEAa81j3
 I4wML4a8CS/+ipVBRjneKw==
Message-ID: <73f8b2dc-d5ad-43b7-834f-6322bfe617af@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 12 Aug 2025 17:03:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 07/14] virtio-pci: implement support for extended
 features
To: Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1753297661.git.pabeni@redhat.com>
 <8e8a91adcbf4e37c7a5e086780e1000d3b3298d3.1753297661.git.pabeni@redhat.com>
 <de3c69a8-d874-44a3-bd47-91b6b298e184@rsg.ci.i.u-tokyo.ac.jp>
 <7c7c3f2c-e643-46ad-810c-aefdd486ad78@redhat.com>
 <8e3c5aa3-3180-4df2-b378-18e3e91d3f80@rsg.ci.i.u-tokyo.ac.jp>
 <CACGkMEse8cM8=8y4JwBdVQi23buz1OCzhQmVxvsRJGdQ9tgaWA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CACGkMEse8cM8=8y4JwBdVQi23buz1OCzhQmVxvsRJGdQ9tgaWA@mail.gmail.com>
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

On 2025/08/12 13:01, Jason Wang wrote:
> On Fri, Aug 8, 2025 at 12:55 PM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2025/08/08 5:18, Paolo Abeni wrote:
>>> On 7/26/25 1:52 PM, Akihiko Odaki wrote:
>>>> On 2025/07/24 4:31, Paolo Abeni wrote:
>>>>> @@ -1477,6 +1509,13 @@ int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
>>>>>         return virtio_pci_add_mem_cap(proxy, &cap.cap);
>>>>>     }
>>>>>
>>>>> +static int virtio_pci_select_max(const VirtIODevice *vdev)
>>>>> +{
>>>>> +    return virtio_features_use_ex(vdev->host_features_ex) ?
>>>>> +           VIRTIO_FEATURES_NU32S :
>>>>> +           2;
>>>>
>>>> This function could be simplified by replacing VIRTIO_FEATURES_NU32S
>>>> without any functional difference:
> 
> Did you mean using VIRTIO_FEATURES_NU32S instead?
> 
>>>>
>>>> 1. For writes: virtio_set_features_ex() already ignores extended
>>>> features when !virtio_features_use_ex(vdev->host_features_ex)
>>>> 2. For reads: When !virtio_features_use_ex(vdev->host_features_ex), the
>>>> upper bits of host_features_ex are zero, and guest_features upper bits
>>>> remain zero (since they can't be set per point 1)
> 
> I think it depends on the compatibility work which hasn't been done in
> this series.
> 
>>>>
>>>> So the conditional logic is redundant here.
> 
> See below
> 
>>>
>>> This is to satisfy a request from Jason:
>>>
>>> https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg05291.html
>>> https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg05423.html
>>>
>>> I agree there will not be functional differences always accessing the
>>> full space, but the guest could still be able to notice, i.e. the
>>> extended space will be zeroed on read with that patched qemu and
>>> untouched by the current code and this patch. To be on the safe side I
>>> think it would be better to avoid such difference, as suggested by Jason.
>>>
>>> Does the above make sense to you?
>>
>> By functional, I meant the functionality of QEMU, visible to the guest,
>> rather than the whole system including the guest, visible to the end
>> user. The guest cannot notice the difference because the extended space
>> is zero on read even without the conditional, which is described as
>> point 2 in the previous email.
> 
> I'm not sure I understand this correctly. But it doesn't harm here consider:
> 
> 1) it's the entry point from the guest, checking and failing early is
> better than depending on the low layer functions
> 2) we have checks in several layers (both virtio-pci and virtio core).
> 
> And it looks like a must for at least GF:
> 
>      case VIRTIO_PCI_COMMON_GF:
>          if (proxy->gfselect < virtio_pci_select_max(vdev)) {
>              uint64_t features[VIRTIO_FEATURES_NU64S];
>              int i;
> 
>              proxy->guest_features[proxy->gfselect] = val;

I missed proxy->guest_features. Indeed it makes a difference.

Now I have another concern with virtio_pci_select_max(). If the feature 
set grows again, virtio_pci_select_max() will return the grown size for 
the devices that have [127:64] bits, which will be a breaking change. In 
this sense, VIRTIO_FEATURES_NU32S, which will grow along with the 
feature set, is not appropriate here.

Hardcoding 4 ensures such a breaking change will not happen at least.

Perhaps QEMU_BUILD_BUG_ON() may be placed here to tell it needs to be 
updated when the feature set grows, but I don't require that since there 
is QEMU_BUILD_BUG_ON() before vmstate_virtio_pci_modern_state_sub. It 
may be a good idea to move this function somewhere close to 
QEMU_BUILD_BUG_ON().

Alternatively the function may compute the value to return by finding 
the last non-zero element in vdev->host_features_ex and multiplying by 
2. It will probably work even if the feature set grows again in the future.

Regards,
Akihiko Odaki

