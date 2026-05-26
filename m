Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4188CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 12:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRqne-0006Pw-5t; Tue, 26 May 2026 08:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wRqnZ-0006P7-9i
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wRqnX-0002CS-Ey
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779798134;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xegYGdHu279bzwjsX3IA0WBIJCVVU/0/HehgFZDv+RY=;
 b=cqk1JDTrgEqzGcUCC9IyXfw0njp+2YVdoOX65303W3QYcEcW78T4nDTt9MnNt6OF+jVVN7
 PFTy79sAhgnhfhOaKGEIfCm+KGPEw7w2YSQcfUZPbFJq13G011VyV/4a0pkTHTi6XgKayt
 8JNnTTQ7aLlfsOIZ1h20RWkVAyh5d40=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-IC605TTMNourPsOsdAxwfg-1; Tue, 26 May 2026 08:22:13 -0400
X-MC-Unique: IC605TTMNourPsOsdAxwfg-1
X-Mimecast-MFC-AGG-ID: IC605TTMNourPsOsdAxwfg_1779798132
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48ff0eb77b5so15578405e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 05:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779798132; x=1780402932;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xegYGdHu279bzwjsX3IA0WBIJCVVU/0/HehgFZDv+RY=;
 b=gJBLhDlT4fB3yCxw2ATy86joxs/IBKQfh+334l5S0lBX8eyva/9L+M2rS1SLPyigs+
 oumBzQYJv0ePo6ZPgYxK7i8SaxgYTcIS39zzHPkvs9YnYsXmJ+7v1meJ4c7fUPC5rlxJ
 MbX712SOmO86IFh++bzaPmit2Nwdh3yQ+jo00LH54v1AGLbFqEhNOxpzK8dGqfcgf6Ib
 MM2Ldn6DRI5EFCG0livekKZIcciE3kxx1nAY+4an1Ybr6kj8FlV4g01fyqFXBSpXYfDK
 0DUNUdwzTBtZWfVfBv1NvmRKyzEC8igMzZg5DJA6GsE5fWyI8iDB8V2khdEai1ZuTDtO
 DVMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8aXs6Nm9aieU73YMn/BW3lxIKvQVmfSvoS62wrTFg5Yxozi7nDHbECErMhfEJ5ZtJd1IAyYYGraMfJ@nongnu.org
X-Gm-Message-State: AOJu0Yybedz6Wj7Bfp6jsYozvffteGNKOEzGIHJRfz0NAyCo/DuOnRWs
 pswCJk19+h+i4tjtEqCm3MKnyVX7HLSALcG6mYreaioAGyBYAqtu102HjY2Zzp9ebTG+APw3JhM
 8osu0nlw8P06IUXpoxFcHl9+SRlY04lNvmR2qvug/fW6F3RgQ3Va3mEEx
X-Gm-Gg: Acq92OEq97Y90aRGYhPjRvt7+ByMWAPXLe5J4HyCXj+hBqFCyuvw19IWVvygr//J9AI
 urjaVjARV/WZUf0kAfb+FwtISt9hBGrbHj8Uj6tE5NNl3uuf8OIg/9PzQhYabJ7H4jE//djM6Fg
 ORnsCpNuU75ssmTALeHLw2hcp70qzGW7YB9vHlz6U2SbjHHCMY9PGnmTaogCNgdEkj8+l5o7O2z
 3bmhXtSX4hRpB1Pa2DKzFp9dnl1zETBSCLVjPSlE2Fbhy4UkGcS090OJNTqxZDNvb57C6LphUXb
 dE13QFyL/opcvhdS8RhI1vE3JzqXbtwUkA3RCiy0BPEMrBUnGrLYA54xAvv4LRFu382fFaGAQiK
 PMmb9N6rbjXfVoTGb6lrCXNkCo8DN3mfFbPzJkylvy/iproY1Foxjt5E3mszeWyIaI0DXQw==
X-Received: by 2002:a05:600c:35cf:b0:490:3bad:3784 with SMTP id
 5b1f17b1804b1-490426bc6demr350772025e9.18.1779798131807; 
 Tue, 26 May 2026 05:22:11 -0700 (PDT)
X-Received: by 2002:a05:600c:35cf:b0:490:3bad:3784 with SMTP id
 5b1f17b1804b1-490426bc6demr350770975e9.18.1779798131138; 
 Tue, 26 May 2026 05:22:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9de2dsm33799258f8f.4.2026.05.26.05.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 05:22:10 -0700 (PDT)
Message-ID: <ffdb0b2c-0795-4ed4-9bfb-dcd0564f7da9@redhat.com>
Date: Tue, 26 May 2026 14:22:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/32] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once
 configured
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-20-skolothumtho@nvidia.com>
 <166c5efb-0fa3-49f6-a1e7-faec85a6ec44@redhat.com>
 <CH3PR12MB7548314422301EA66803DD40AB0E2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <69ec35de-1f7c-40ae-9ea5-3727c047c590@redhat.com>
 <ag9/KMztV/pb7lA0@Asurada-Nvidia>
 <e3af7e21-f5cd-47fa-85f3-d8744b529246@redhat.com>
 <CH3PR12MB75483876FED87775450277C9AB0B2@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB75483876FED87775450277C9AB0B2@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/26/26 12:24 PM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 26 May 2026 09:37
>> To: Nicolin Chen <nicolinc@nvidia.com>
>> Cc: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org; peter.maydell@linaro.org;
>> clg@redhat.com; alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>;
>> Matt Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason
>> Gunthorpe <jgg@nvidia.com>; zhenzhong.duan@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>; phrdina@redhat.com
>> Subject: Re: [PATCH v5 19/32] hw/arm/tegra241-cmdqv: Allocate HW
>> VCMDQs once configured
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Nicolin,
>>
>> On 5/21/26 11:54 PM, Nicolin Chen wrote:
>>> On Thu, May 21, 2026 at 03:27:17PM +0200, Eric Auger wrote:
>>>> On 5/21/26 2:26 PM, Shameer Kolothum Thodi wrote:
>>>>>>> +    /* Ignore any invalid address. This may come as part of reset etc. */
>>>>>>> +    if (!address_space_range_is_ram(&address_space_memory, addr,
>> size)) {
>>>>>> why do you need to test the whole range and not only the start addressa
>>>>> That was to make it more defensive based on v4 discussion here:
>>>>> https://lore.kernel.org/qemu-devel/aft%2FDTFLqQnufzWl@nvidia.com/
>>>>>
>>>>> Please let me know if there is a better way.
>>>> Well it is unclear to me. You want to make sure the GPA was fully set
>>>> through the H and L regs. To me that's enough. As far as I understand
>>>> Nicolin's reply, the kernel checks the rest. But please sync with Jason
>>>> or Nicolin
>>> Yes. Kernel checks if the range is in the stage-2 page table, i.e.,
>>> mapped GPAs. One caveat: mapped GPA doesn't guarantee it's is_ram.
>>>
>>> So, what if the GPA is in the IO space (PCI BAR) or reserved space
>>> (firmware)?
> Looking at our helper address_space_range_is_ram(), it isn't foolproof
> for the above cases. For the PCI BAR case we could add:
>
>     if (!memory_region_is_ram(mr) || memory_region_is_ram_device(mr)) {
>         return false;
>     }
>
> But I'm not sure how to tackle the reserved spaces. For firmware ROM
> we could add a memory_region_is_rom() check, but the others will
> still look like normal RAM, so they're hard to detect at this layer.
>
>>> AFAIK, kernel doesn't have a way to know. So, it's VMM's job to do
>>> so.
>> would it jeopardize the host integrity or would it just break the
>> misbehaving guest. If the latest I am not sure this is critical to
>> check. We are not checking either with regular SMMU cmd queues
> I think it would just be the guest shooting itself in the foot. Can't think
> of a host security/integrity issue here. So we could drop the check if
> that's preferred.

In that case I would rather simplify and remove the check. But that's my
humble opinion ;-)

Eric
>
> Thanks,
> Shameer


