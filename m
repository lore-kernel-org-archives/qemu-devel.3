Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F196AC28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 12:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4Rh-0002h1-1T; Fri, 14 Mar 2025 08:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=161315f38=graf@amazon.de>)
 id 1tt4Re-0002gW-Ue
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 08:47:23 -0400
Received: from smtp-fw-80006.amazon.com ([99.78.197.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=161315f38=graf@amazon.de>)
 id 1tt4Rc-0002tC-2g
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 08:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1741956441; x=1773492441;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5/2CO48dv3c/OYXVyiefmSEQ+x6J0RMkR+uHb6q1KYU=;
 b=eaUN+9lo/p7KsLRiqCSgoKIPDwrRZ9rxAWiMFmV5JjDo/ghHqMD6KoPe
 jF1R17tEpzLfh+HfvEbdyyvYUsslzgEP4lMyuzCD6vkJi1HFew12n0JEf
 toDnqEXzSvpoSa+l8rtJ1D38/aY9nzVvKWpo2R8HSHc85+ylC2T0LL0UM U=;
X-IronPort-AV: E=Sophos;i="6.14,246,1736812800"; d="scan'208";a="31915641"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80006.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 12:47:13 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:15647]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.235:2525]
 with esmtp (Farcaster)
 id ec14503d-2591-4755-98cb-2c0e255fa616; Fri, 14 Mar 2025 12:47:12 +0000 (UTC)
X-Farcaster-Flow-ID: ec14503d-2591-4755-98cb-2c0e255fa616
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 12:47:09 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Fri, 14 Mar 2025
 12:47:05 +0000
Message-ID: <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
Date: Fri, 14 Mar 2025 13:47:03 +0100
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
 <qemu-devel@nongnu.org>
References: <sxavsa2i4drnei4kmy6pd4uekk3xaa43njd47jtogar7ui7qm7@n73chaex5ms2>
 <Z9LeILiEU5GfEHrl@8bytes.org>
 <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
 <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=99.78.197.217;
 envelope-from=prvs=161315f38=graf@amazon.de; helo=smtp-fw-80006.amazon.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 14.03.25 12:27, Gerd Hoffman wrote:
>    Hi,
>
>>>> Open question is what we do about IGVM.
>>>>
>>>> One option would be the guest vmfwupdate tool loading and parsing igvm,
>>>> preparing the region list, then invoke the update.  Problem is that some
>>>> igvm feaures such as initial register state can not be easily supported
>>>> that way.
>>>>
>>>> We could also expect the hypervisor support igvm, so the guest can
>>>> simply load the file into memory and pass address and size to the
>>>> hypervisor.  Either as option, say via VMFWUPDATE_REGION_FLAG_IGVM, or
>>>> mandatory, i.e. scratch the region list and use IGVM exclusively.
>>> This is of course up to the QEMU maintainers to decide, but I want to
>>> highlight that IGVM already solves all the problems mentioned above,
>>> including setting multiple memory regions of different type, special
>>> data pages (cpuid, secrets, id-blob, vmsa) and more. It defines the
>>> order of setup calls the VMM has to invoke for the new context and also
>>> works for multiple platforms like TDX, SNP, non-coco, and in the future
>>> ARM as well.
>> My take on this is that instead of making the interface more complex,
>> let's empower the guest to use IGVM if they think they need more
>> guarantees around those things that IGVM solves very well today. QEMU
>> already has IGVM backend support.
> Ok, assuming we allow the guest submit a IGVM image (which makes sense
> indeed, otherwise we'll probably end up re-inventing IGVM).  How will
> the kernel hashes be handled then?  I assume they will not be part of
> the igvm image, but they must be part of the launch measurement ...


The kernel hashes must be embedded in the IGVM image by the time you 
invoke vmfwupdate. That means when you generate the FUKI, you take 4 
inputs: Generic firmware image, kernel, initramfs, cmdline. Out of 
those, you generate and embed an IGVM image that consists of the 
firmware image as well as the kernel hash page.


Alex


