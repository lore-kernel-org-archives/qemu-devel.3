Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2B0C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 18:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfjrd-0000cP-DY; Wed, 05 Feb 2025 13:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfjrb-0000bp-M3
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:11:03 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfjra-0006mR-2P
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:11:03 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso777915e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 10:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738779060; x=1739383860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y6wtcydVQZupMutRL0JRwISF7OXd17oMzRlS5uxaleE=;
 b=BpxcXs6rNlwZv1Atv7mEC7aCD/y0HM3yU7I9p/AP3lsfV5I0EkRUc8BDD0r3q1njyT
 naTSQ1KgFWdD6Gx+HNfwhRyblMQtt94jAQQkjZreELlM3M0VlVz/uUK3vB2PKvuzXlaQ
 o4YnHyFsEEEb4B91MQB+oREMBBWK6vQNN3IOSKrRmow87xpkum/N9oQG3W3/8MGacpAf
 lKQ+/NE9YlmOeB3+E7Cd5SXlzVVhq6Uff4Y4VmzcF37cmU96BORNrF93X0Ncs1VeEYUP
 hO3SqUX0wyJGR9xooUPWBupWquIjDTEjwYd5TbvRYdK9oUwx6AHL8eD4yxJPzpXWEU3v
 A4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738779060; x=1739383860;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y6wtcydVQZupMutRL0JRwISF7OXd17oMzRlS5uxaleE=;
 b=M/+MYyTqUnLRHSJb6r4CxVmdIazKCwwRtruuhEd46bCfeQWVDSRn2wCTBJKPZUnFjl
 Vy/wpzaOKNd09m8l8ayfBTiwceVhOVkvkJ3Gw0IF7+lCPStzC2VWNDO9yl/2njRDCNcn
 2MKd3HQStsWZRSAAxO2hkh7kpgErEhI70A1jlO/nPMMALLHJAYWHjPzn4ip69Nau5U08
 FwZFHup3Ko+s1srUGyQjAcdiigBUU1mISIKwTMiDrem1PIdbFNRcKywGooSV+7Pbv1ZB
 Xe/obz6rN8XuMewmBzjgUkApLyhdjxM8sAMgUJ3He4XXU50cL0ofMA1KToN5B1lwjGJJ
 4uHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUel2nxs3mR3RheoySEwjqYFqMsvA5t8/JMuQ2NXLgBLyyreV3mxhG2UhMrD8MQ227wgGre18ihZxeM@nongnu.org
X-Gm-Message-State: AOJu0YwUzaL33cNWz8NMa+/c5z2yN/VDpFM3+kopqhM7jRIKGvqQiO01
 DoyulzpuAgpsIpoWI3/kJWIwIMHFvnbKBqX1sq2kDi0WiKv2O8x6uBj/k8Rz3RM=
X-Gm-Gg: ASbGncva8u6q3yCKGPQOItsgbPEDcGzZZnAOc8CjYPrnxE2nw9C8FXiEZE/aqJhkjiB
 A6gm3NaT/1fgJmBJi49A2g0MfS9TJan+ehgfW1co92Zzyqo+OF7ce0jttu7mIFdSCi4ZCmSItVc
 Z2HbRz4qEkiB8WVJqzsnFAF6DiclUPJsyP74KEDucgTqiR5OM+JjaO2jtapaQCzlLvO79XJ0Wf1
 nGyaDfv97AglFLF4yXQK0wBzeyhpbyGqlkSdvz4tyAtPt+JsFN02XBJ2OvCJlqveeHqb61ROlRT
 TGUT4OAShH0pW7GFMK/7MeqOoH3+sqlwFHG4cuha0OImfPQ1/ht3T/L9Yno=
X-Google-Smtp-Source: AGHT+IFnv0aQDAroYKHV0WlbZak+DYoyNJhn9GfH4RpXovF9yXI8P57n/XQBgNdq18r4PamglUQdNQ==
X-Received: by 2002:a05:600c:1f83:b0:435:d22:9c9e with SMTP id
 5b1f17b1804b1-4390d55fda2mr27471935e9.19.1738779060330; 
 Wed, 05 Feb 2025 10:11:00 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1b57a8sm19737179f8f.61.2025.02.05.10.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 10:10:59 -0800 (PST)
Message-ID: <cc846f3c-ca84-4acf-a4f6-bb1685e91b6c@linaro.org>
Date: Wed, 5 Feb 2025 19:10:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 9/9] hw/xen: Have legacy Xen backend inherit from
 DYNAMIC_SYS_BUS_DEVICE
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Jason Wang
 <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <graf@amazon.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20250125181343.59151-1-philmd@linaro.org>
 <20250125181343.59151-10-philmd@linaro.org>
 <9A2B297A-6270-4482-B1B6-81F518C07C1E@gmail.com>
 <02ea4b41-3594-4ead-90d3-0ab06f2be7fa@linaro.org>
 <685742EB-EDAA-488F-852C-C0AA24BD4721@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <685742EB-EDAA-488F-852C-C0AA24BD4721@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/2/25 00:12, Bernhard Beschow wrote:
> 
> 
> Am 4. Februar 2025 21:25:46 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> Hi Bernhard,
>>
>> On 27/1/25 10:46, Bernhard Beschow wrote:
>>> Am 25. Januar 2025 18:13:43 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>>>> Because the legacy Xen backend devices can optionally be plugged on the
>>>> TYPE_PLATFORM_BUS_DEVICE, have it inherit TYPE_DYNAMIC_SYS_BUS_DEVICE.
>>>> Remove the implicit TYPE_XENSYSDEV instance_size.
>>>>
>>>> Untested, but I'm surprised the legacy devices work because they
>>>> had a broken instance size (QDev instead of Sysbus...), so accesses
>>>> of XenLegacyDevice fields were overwritting sysbus ones.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>> include/hw/xen/xen_pvdev.h  | 3 ++-
>>>> hw/xen/xen-legacy-backend.c | 7 ++-----
>>>> 2 files changed, 4 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/include/hw/xen/xen_pvdev.h b/include/hw/xen/xen_pvdev.h
>>>> index 0c984440476..48950dc2b57 100644
>>>> --- a/include/hw/xen/xen_pvdev.h
>>>> +++ b/include/hw/xen/xen_pvdev.h
>>>> @@ -32,7 +32,8 @@ struct XenDevOps {
>>>> };
>>>>
>>>> struct XenLegacyDevice {
>>>> -    DeviceState        qdev;
>>>> +    SysBusDevice parent_obj;
>>>
>>> This then needs sysbus.h rather than qdev-core.h include.
>>>
>>> Moreover, the patch in the reply needs to be inserted into the series before this patch.
>>>
>>> Both are needed for the patch to compile.
>>
>> Per your reply on patch #7, might I include your
>>
>> Tested-by: Bernhard Beschow <shentey@gmail.com>
>> Acked-by: Bernhard Beschow <shentey@gmail.com>
>> (or R-b)
> 
> I only did a compile test and I'm not a Xen maintainer, so I guess above tags don't apply. Right?

Indeed, A-b is preferable for maintainers, but its meaning depends.

Xen maintainers have been Cc'ed for 2 weeks. If they report a problem,
we can still revert.


> 
> 
>>
>> squashing:
>>
>> -- >8 --
>> diff --git a/include/hw/xen/xen_pvdev.h b/include/hw/xen/xen_pvdev.h
>> index 48950dc2b57..629bec90d09 100644
>> --- a/include/hw/xen/xen_pvdev.h
>> +++ b/include/hw/xen/xen_pvdev.h
>> @@ -1,7 +1,7 @@
>> #ifndef QEMU_HW_XEN_PVDEV_H
>> #define QEMU_HW_XEN_PVDEV_H
>>
>> -#include "hw/qdev-core.h"
>> +#include "hw/sysbus.h"
>> #include "hw/xen/xen_backend_ops.h"
>>
>> /* ------------------------------------------------------------- */
>> ---
>>
>> ?
> 
> With the squash applied:
> Reviewed-by: Bernhard Beschow <shentey@gmail.com>

Thanks!

