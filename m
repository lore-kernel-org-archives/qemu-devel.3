Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92277C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 08:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvXRv-0007m4-9f; Fri, 21 Mar 2025 04:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1689b3432=graf@amazon.de>)
 id 1tvXRt-0007jn-Nm
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 04:09:49 -0400
Received: from smtp-fw-52004.amazon.com ([52.119.213.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1689b3432=graf@amazon.de>)
 id 1tvXRr-0005Xt-HT
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 04:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1742544588; x=1774080588;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=6fSG6XTn+RVOKCYlBfLRvxucrnCnfK4BDsxh9FyusqI=;
 b=IB3YopcpM+cMxVuTv2bng6uz3xQRdJPdILDPPVLrb/N/QG5H0eEltBP/
 xfyTpnWkFfrehpIQq+ZqCOWXB18ZIMPOQVqHLwY2dyZxSpbfW7A/DtB1+
 T/nW/fH3WcEFcE6yF5wJClfIsjJpZ6KoJRsAOKFpKrvAEGPrWHvw3kLs3 A=;
X-IronPort-AV: E=Sophos;i="6.14,264,1736812800"; d="scan'208";a="281342386"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
 by smtp-border-fw-52004.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 08:09:42 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:19034]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.164:2525]
 with esmtp (Farcaster)
 id 61000f02-d540-434a-9a43-20af703df5f2; Fri, 21 Mar 2025 08:09:41 +0000 (UTC)
X-Farcaster-Flow-ID: 61000f02-d540-434a-9a43-20af703df5f2
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 08:09:41 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Fri, 21 Mar 2025
 08:09:37 +0000
Message-ID: <79e8ca94-3d8a-46fc-8cd8-f4ec6324b722@amazon.com>
Date: Fri, 21 Mar 2025 09:09:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Ani Sinha <anisinha@redhat.com>
CC: Gerd Hoffman <kraxel@redhat.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 <qemu-devel@nongnu.org>
References: <sxavsa2i4drnei4kmy6pd4uekk3xaa43njd47jtogar7ui7qm7@n73chaex5ms2>
 <Z9LeILiEU5GfEHrl@8bytes.org>
 <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
 <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <6684f169-29d6-4f46-b274-1efd4c191b21@amazon.com>
 <ok6u7exmwmh7qsahp5o3udnbbzbsr2km22kpqod37t6mdsywcs@yhk2whhakl63>
 <fucfv6gf22t3sclhad4iwbmxi5tdg6a5dlhvl4kl4bzhnjkktu@dtn2eqh27k32>
 <c7f840d5-19ed-493e-8de8-7d64aef38948@amazon.com>
 <CAK3XEhO4BMvDBe667=_xe9+A7pN4_N_nkGh0KH12Pq_qLu9AWQ@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAK3XEhO4BMvDBe667=_xe9+A7pN4_N_nkGh0KH12Pq_qLu9AWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=52.119.213.154;
 envelope-from=prvs=1689b3432=graf@amazon.de; helo=smtp-fw-52004.amazon.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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


On 21.03.25 04:36, Ani Sinha wrote:
> On Thu, Mar 20, 2025 at 7:24 PM Alexander Graf <graf@amazon.com> wrote:
>> Hey Gerd,
>>
>> On 18.03.25 12:11, Gerd Hoffman wrote:
>>>     Hi,
>>>
>>>> Maybe not from the user's point of view, but surely for the vmfwupdate
>>>> interface design and for the launch measurement calculations.
>>>>
>>>> When using igvm parameters for the kernel hashes we need to pass on (at
>>>> least) two items via vmfwupdate API:  The igvm image itself and the
>>>> kernel hashes, so the VMM can fill the parameters for launch.
>>>>
>>>> I tend to think it makes sense to keep the region list, so we can
>>>> actually pass on multiple items if needed, and simply add region flags
>>>> to declare that a region is an IGVM image.
>>> Went over the interface spec today, here it is.  Changes:
>>>
>>>    - Moved descriptions into source code comments.
>>>    - Added leftovers noticed in recent discussions, such as cpuid page.
>>>    - Added capability flags and region flags for IGVM.
>>>
>>> Open questions:
>>>
>>>    - Does the idea to use igvm parameters for the kernel hashes makes
>>>      sense?  Are parameters part of the launch measurement?
>>>    - Do we want actually keep the complete interface (and the functional
>>>      overlap with igvm)?
>>
>> I think if we want to embrace IGVM, we should embrace it fully and make
>> it replace the region list. At the end of the day, IGVM is effectively a
>> region list plus data.
> Are you suggesting that vmfwupdate only accept IGVM as payload? I am
> not sure if I like that idea.


I don't like it either, but I don't see a good alternative. If the spec 
allowed both IGVM and the home grown region list, hypervisors would 
still need to implement both ways to be compatible with all payloads. So 
by adding one more path, we're only adding complexity without helping 
anyone.


Alex


