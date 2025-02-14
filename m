Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7130BC021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 15:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiy2c-0003Jr-Rk; Fri, 14 Feb 2025 10:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=133e246af=graf@amazon.de>)
 id 1tiy2a-0003JE-6G
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:55:44 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=133e246af=graf@amazon.de>)
 id 1tiy2W-0005VY-Fp
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1739548541; x=1771084541;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=WdZJyPseL9ONDRUETcZA0dAoxeaGm6AEjhRffdz+y9I=;
 b=nwI6NiBf6UTgOMvrV8t31yl6x7IlnLtfougbva31H1gGWe61T7FSM1+v
 azB1B2XBlmHDBgTJ+6xWQ5Ie1iU82lDiNIm61KjB2Xga1poeKDv04EM9i
 B1bzOjOQ7b2JkOQ5yiYhDHAJnl3bE6mnvJwlTZAfjFIM7Mq7ueBrzqIhp Q=;
X-IronPort-AV: E=Sophos;i="6.13,286,1732579200"; d="scan'208";a="472233841"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-6002.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 15:55:36 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:33179]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.73:2525]
 with esmtp (Farcaster)
 id 50260156-a16a-4538-926c-6a89872da688; Fri, 14 Feb 2025 15:55:35 +0000 (UTC)
X-Farcaster-Flow-ID: 50260156-a16a-4538-926c-6a89872da688
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 14 Feb 2025 15:55:34 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39; Fri, 14 Feb 2025
 15:55:31 +0000
Message-ID: <549e04b9-584e-4165-a3c8-b9b667059f78@amazon.com>
Date: Fri, 14 Feb 2025 16:55:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Ani Sinha <anisinha@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, "Gerd
 Hoffman" <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Vitaly
 Kuznetsov" <vkuznets@redhat.com>, <qemu-devel@nongnu.org>
References: <20250129063153.3967220-1-anisinha@redhat.com>
 <efbd2dce-b4c7-4c5e-b6b6-230761eefce8@amazon.com>
 <CAK3XEhMcScorAeRFjRmmt2Wx_ehvw3-Onq_VrJTc=pwD2HoVQw@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAK3XEhMcScorAeRFjRmmt2Wx_ehvw3-Onq_VrJTc=pwD2HoVQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=52.95.49.90;
 envelope-from=prvs=133e246af=graf@amazon.de; helo=smtp-fw-6002.amazon.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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


On 14.02.25 16:35, Ani Sinha wrote:
> On Mon, Feb 3, 2025 at 3:50 AM Alexander Graf <graf@amazon.com> wrote:
>> Hey Ani!
>>
>> On 28.01.25 22:31, Ani Sinha wrote:


[...]


>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>> index c23b399496..0eaf8aa3ba 100644
>>> --- a/hw/core/machine.c
>>> +++ b/hw/core/machine.c
>>> @@ -34,6 +34,7 @@
>>>    #include "hw/virtio/virtio-pci.h"
>>>    #include "hw/virtio/virtio-net.h"
>>>    #include "hw/virtio/virtio-iommu.h"
>>> +#include "hw/misc/vmfwupdate.h"
>>>    #include "audio/audio.h"
>>>
>>>    GlobalProperty hw_compat_9_2[] = {
>>> @@ -252,6 +253,7 @@ GlobalProperty hw_compat_2_8[] = {
>>>        { "virtio-pci", "x-pcie-pm-init", "off" },
>>>        { "cirrus-vga", "vgamem_mb", "8" },
>>>        { "isa-cirrus-vga", "vgamem_mb", "8" },
>>> +    {TYPE_VMFWUPDATE, "disable", "1"},
>>
>> If vmfwupdate is opt-in anyway, why disable for older machines?
> Some older machines does not have enough slots for new fw-cfg files.
> For those machines, we cannot add this device. Unless we disable the
> device, QEMU would crash on an assertion.
> This particular case was caught because the CI pipeline was failing.
> There might be other cases where we need to disable it but CI does not
> have a test case for it.


Please find a better way to fix that. You can have better error 
propagation when fw-cfg fills up so it's clear that the problem is the 
additional vmfwupdate device. But silently changing the behavior from 
"Device does what I want it to do" to "Device is attached, but not 
functional" based on machine version is a big no-go. You *must* fail 
loudly, because you can not honor the user's wish (expose vmfwupdate).


Alex


