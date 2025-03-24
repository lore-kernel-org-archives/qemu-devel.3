Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F54C36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 16:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twkiO-0001w6-Rd; Mon, 24 Mar 2025 12:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1713973f7=graf@amazon.de>)
 id 1twkiI-0001uz-FF
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:31:49 -0400
Received: from smtp-fw-52005.amazon.com ([52.119.213.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1713973f7=graf@amazon.de>)
 id 1twkiG-0007dh-Et
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1742833905; x=1774369905;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=NSLQ+dJSWcCtGEJsg6PAO1HtCfeeRTj5/SmsBAdVgsA=;
 b=OboeuafGq+mupXlR2kUJtwVp1Sm64uoQaeI3VhIhWz0rv+Oa4PdofFPI
 hisjJRLhJCEHtF0r8z/YI7ACllpkfKP886jVivTVg69vRTbfqwYpC0UO/
 Yj97jkSqwS6xiwRNeC/toCinNHUcx2WSlBdo+Tn8N4K1MR/5WjSR9aJZm w=;
X-IronPort-AV: E=Sophos;i="6.14,272,1736812800"; d="scan'208";a="729468524"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-52005.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 16:31:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:30742]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.102:2525]
 with esmtp (Farcaster)
 id 9030f762-0607-4682-83aa-1184b0a91dc5; Mon, 24 Mar 2025 16:31:37 +0000 (UTC)
X-Farcaster-Flow-ID: 9030f762-0607-4682-83aa-1184b0a91dc5
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Mar 2025 16:31:36 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Mon, 24 Mar 2025
 16:31:33 +0000
Message-ID: <4f6a21a9-746e-45ac-88c7-dc0204480a86@amazon.com>
Date: Mon, 24 Mar 2025 17:31:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Gerd Hoffman <kraxel@redhat.com>, Ani Sinha <anisinha@redhat.com>
CC: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <Z9vSeF67fNazkxBh@8bytes.org>
 <4p7orqixni5m3444l53isxe5awdwasrb5e5bu6wu4phhycqpir@z22wgnaxowsg>
 <CAK3XEhNeB29eaPxZ_1Cc7WfEzOGZZPcvTc5uC1XAdtG0uNfDRw@mail.gmail.com>
 <h2s75tkddnrmodbbr7hxugrivpbhq7cfpbmhmgqmnn5mlafedk@jhv5cobgtjkc>
 <CAK3XEhPYmBsn2-=PMR7qVQHiu0ydoh3EfJOEuunLccriSkKipg@mail.gmail.com>
 <53jhridwtejsuy4qojjr66rcjdebnyarwke4bs3m3w2afmqhe6@pab5zfyo46fx>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <53jhridwtejsuy4qojjr66rcjdebnyarwke4bs3m3w2afmqhe6@pab5zfyo46fx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=52.119.213.156;
 envelope-from=prvs=1713973f7=graf@amazon.de; helo=smtp-fw-52005.amazon.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 24.03.25 16:48, Gerd Hoffman wrote:
> On Mon, Mar 24, 2025 at 04:42:28PM +0530, Ani Sinha wrote:
>> On Mon, Mar 24, 2025 at 1:13 PM Gerd Hoffman <kraxel@redhat.com> wrote:
>>>    Hi,
>>>
>>>>> Going ship the distro kernel as igvm image would work too.  Will
>>>>> simplify the measurement pre-calculation.  Also there is no need to pass
>>>>> around any parameters, everything (how the firmware finds the UKI etc)
>>>>> can be arranged at igvm build time then.  Disadvantage: This introduces
>>>>> a completely new boot workflow.  Will probably need a new set of cloud
>>>>> images exclusively for the BYOF case.
>>>> What does all this mean for the hypervisor interface ?
>>> That means we'll go scratch the region list idea and depend on igvm
>>> instead.
>>>
>>> Which means we are back to the single firmware image.
>> So in this model, how are we passing the hashes of kernel, initrd and cmdline?
>> Are they going to be part of the firmware image as was previously thought?
> Either scratch the idea of using hashes to verify kernel + initrd +
> cmdline and use a secure boot signed UKI instead, or use IGVM firmware
> images and add the kernel hashes page to the igvm.


It's a nice idea to have a firmware IGVM file that contains a signature, 
so you can for example have a RHEL provided IGVM that only runs UKIs 
that are signed by Red Hat.

Unfortunately, it does not address some of the other interesting use cases:

   - Attestable Bootable Containers. In that case, the command line 
contains a hash of the target fs-verity protected partition. Red Hat can 
not be the entity signing that UKI. It must be the user.
   - Add-ons. How do you provide a "debug add-on" and prevent it to gain 
any access to confidential data?

So we need some equivalent of a hash page. That can absolutely integrate 
more deeply into UEFI and be actual PE hashes rather than the icky thing 
the OVMF code does today. But we need to support a way to embed the hash 
in the ukify.py generated IGVM on the fly. With add-ons, maybe even 
multiple ones.


Alex


