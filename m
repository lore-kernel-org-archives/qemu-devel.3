Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07CBC35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 17:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuEHt-00077K-PO; Mon, 17 Mar 2025 13:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1643bdb98=graf@amazon.de>)
 id 1tuEHj-00073n-Ja
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 13:29:56 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1643bdb98=graf@amazon.de>)
 id 1tuEHY-00021Q-O9
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 13:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1742232584; x=1773768584;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9CsYtDFxMspjRFQ4cDjdb2WUgsmiSWilOydzAZInoE8=;
 b=GIdRqK8KtDqBpLakfvqgRjSxe8Zg15yRbaYk4tmaRdYeuQRJACQTrM0M
 rnbxFQ+9Mdn8lJGi+nSq/RDeifPCeCdIBT4zQIBogxd+FvxWkWQ+XJN5/
 rm2CaqWNWb1pqiR9KA23OcG1qzPQE3wBUEhupGOhzS769a3aHicMfCyZO Q=;
X-IronPort-AV: E=Sophos;i="6.14,254,1736812800"; d="scan'208";a="481114960"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-6002.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 17:29:29 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:25933]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.235:2525]
 with esmtp (Farcaster)
 id fdf63275-6946-4907-8eb7-a8e70f163ea7; Mon, 17 Mar 2025 17:29:28 +0000 (UTC)
X-Farcaster-Flow-ID: fdf63275-6946-4907-8eb7-a8e70f163ea7
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Mar 2025 17:29:28 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Mon, 17 Mar 2025
 17:29:24 +0000
Message-ID: <6684f169-29d6-4f46-b274-1efd4c191b21@amazon.com>
Date: Mon, 17 Mar 2025 18:29:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Gerd Hoffman <kraxel@redhat.com>
CC: Ani Sinha <anisinha@redhat.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
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
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=52.95.49.90;
 envelope-from=prvs=1643bdb98=graf@amazon.de; helo=smtp-fw-6002.amazon.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 17.03.25 10:56, Gerd Hoffman wrote:
> On Fri, Mar 14, 2025 at 03:50:19PM +0100, Alexander Graf wrote:
>> On 14.03.25 15:08, Gerd Hoffman wrote:
>>>     Hi,
>>>
>>>>> Ok, assuming we allow the guest submit a IGVM image (which makes sense
>>>>> indeed, otherwise we'll probably end up re-inventing IGVM).  How will
>>>>> the kernel hashes be handled then?  I assume they will not be part of
>>>>> the igvm image, but they must be part of the launch measurement ...
>>>> The kernel hashes must be embedded in the IGVM image by the time you invoke
>>>> vmfwupdate. That means when you generate the FUKI, you take 4 inputs:
>>>> Generic firmware image, kernel, initramfs, cmdline. Out of those, you
>>>> generate and embed an IGVM image that consists of the firmware image as well
>>>> as the kernel hash page.
>>> If your input firmware image already is an IGVM (say coconut), what is
>>> supposed to happen?
>> I'll leave the details to Jörg on how he envisions it, but IIUC the flow for
>> a "readily assembled IGVM" is different. In case of a COCONUT-SVSM IGVM, you
>> expect chaining of trust. So the SVSM implements a TPM which then the OS
>> would use with measured boot etc etc.
> Well, I don't consider igvm being useful for svsm only.  Shipping
> standard edk2 as igvm looks useful to me.  Main benefit: pre-calculate
> launch measurements without having to know qemu internals.
>
>> It's a fundamentally different concept from FUKI.
> Hmm?  IGVM is just a different way to ship the firmware (and optionally
> more).
>
>> But it could share the same vmfwupdate mechanism to load.
> Yep.  But we have to sort the details.
>
>   (1) How we are going to load kernel + initrd in case the firmware is
>       igvm?  Just update the igvm to also include linux kernel and
>       initrd (see parallel reply from Jörg)?  If so, how does the
>       launched firmware find the kernel + initrd?
>       While digging around in the igvm spec I've seen there is the
>       concept of 'parameters'.  Can this be used to pass on the memory
>       location of kernel + initrd + cmdline?  Maybe the kernel hashes too?


I don't know. But even if not, the only thing customers can actually 
reason about is a combined hash of firmware + kernel + initrd + cmdline. 
Whether we assemble that using an edk2 IGVM plus parameters or by 
generating an IGVM from a "proprietary format" such as the edk2 BIOS 
blob plus a generated kernel hash page does not really make a difference 
from the user's point of view.

The flow will be the same: You use ukify to generate a FUKI from source 
files and get a FUKI plus precalculated hashes.


>   (2) Will the igvm be generated on the fly from FUKI data?  Or should
>       the distros ship igvm images with firmware + kernel + initrd?


If your distro embraces UKIs today, they should IMHO also embrace 
prebuilt FUKIs. Whether they are building their IGVM on the fly but 
precalculate the hash for that on-the-fly generated image ahead of time 
or whether they embed an IGVM is not terribly important I think.

The main difference between the 2 approaches is that dynamic generation 
allows you to have multiple different environment builds in a single 
FUKI. That way you can for example support UKI addons [1]


>   (3) How we are going to handle uki add-ons?


You can only (sensibly) handle them with on the fly generation.


>   (4) Do we want keep the region list?  Or declare that igvm should be
>       used in case a single region is not enough?  Or even go all-in and
>       use IGVM exclusively?


IGVM would replace the region list I think. Before making that jump, I 
would like to see it actually work though.


Alex


[1] 
https://archive.fosdem.org/2024/events/attachments/fosdem-2024-2024-uki-addons-and-extensions-safely-extending-ukis-kernel-command-line-and-initrd/slides/22125/Uki_addons_O97iYns.pdf


>
> take care,
>    Gerd
>

