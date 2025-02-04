Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52139C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfN7p-00088G-Mz; Tue, 04 Feb 2025 12:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tfN7m-000884-C5
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:54:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tfN7k-0003Ec-N2
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738691651;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocVkwQum6xQIQj9MxspsCl6nfLCBD5by5s9rb96rDtI=;
 b=PRZmZmESp4aatl+z4wOd80f3DaNSCyRZR0VGZpHNHoe/UM0nYd+e9L5IOSVkNF1TP+A+Jt
 qUfBNckDr04SmNKY9DUThO1a/GDk6I9eOan50r8cF1o1ThRzpbQkqAN1rijj43uC/7u3OR
 /HAJTYez+GRs++hDGW+o1RN01sZeZrk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-VRDcpAxoPX2vfpfqiI4nyw-1; Tue, 04 Feb 2025 12:49:20 -0500
X-MC-Unique: VRDcpAxoPX2vfpfqiI4nyw-1
X-Mimecast-MFC-AGG-ID: VRDcpAxoPX2vfpfqiI4nyw
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-467b645935fso108777991cf.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 09:49:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738691360; x=1739296160;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ocVkwQum6xQIQj9MxspsCl6nfLCBD5by5s9rb96rDtI=;
 b=trT8sQxwpr8Y4fosIWBU5nnumyEaCQccHhwg853zDE2z/fqvifq/7C0+bIuaHdRT9Z
 /M6tHmECImMsU+4CMFzbevIojqonjsMGnk5bdKjrqgd07/7R5TR5ITEpsFCoj8r6H39J
 bW2gt4su1jxMbZGkIJz1ztn07BP/ML7RUT6QRNL3uu+BV1yGTc9WrLOzN4CUkFKEaaoY
 RGizHHvqEiiS8H9RNGK+mTGr67WCkmKhpBe3IfGtGuiYiQ1uaROt3rTaDHHltT2ak2Tc
 3of9k3XbQ8ROj+vkgKatRUHSrl6+eNnjCAdClLtevigvLSpq3A+H1AHYRaYjL3MObkH/
 XnEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfQyrF8nIzOmXy9OWPF1cdVBxTMf4vcj17+BNOxXqQ1no3zdtDDA76RkHvNLpTfflVPLDClPOyHjM/@nongnu.org
X-Gm-Message-State: AOJu0YwplKdwhMNxdf79OSaJ8xUAQVZCQSbQ6lHRlY91mT0bqvZ7L4HX
 Qm5jzs/gGFgF2+0RjhQ6aNm2kApDR/oeknGPYd2O6RZzIuKgFiH/g0dKJkL3hxISVZ6Di+npyts
 +6AphBLqzOUMuGEE2pimFg39lDRJmq6bTemZKFYkv4B6vmLK7HcHZ
X-Gm-Gg: ASbGnctLYU56Xc5DdQiZDBk7xeEBYrCvtUyfnJWPTYRALy49YojhDRnOLBgEUtQDZr0
 Dl27Yrm0VLVMY5aVDIzERx5f1qyFgsW7H3fJJNIleV8g6DmGapmh5tRa0zl0LWWlvXSOttU6w2h
 QAXEd7AP/PZfajyYilc4lHS4HXWFm+VAMROqyyiRC4Cqlut7nGUABZ3A2EpQ9yr4kbTLoagDBwJ
 nAEc23YwrFzvG7igO2UkFkP94MIdUqSBLIQD4wOCDZFd5xc2suySbcZksNdn8wtYeTsWbZhD9oV
 WjSwyXo1cFau185zoG3gwOZ8PMnJDnyuXoJuMfqYQ3F0LXk8dcNv
X-Received: by 2002:ac8:7c45:0:b0:466:9197:b503 with SMTP id
 d75a77b69052e-46fd0b9152amr338420431cf.46.1738691360344; 
 Tue, 04 Feb 2025 09:49:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpT8boCJ9G9pixAARJGNzAAoeBpOGtmXf3D/02XBqVHN3ZLJLofaiCI1YGMep9TkUxiqWLDg==
X-Received: by 2002:ac8:7c45:0:b0:466:9197:b503 with SMTP id
 d75a77b69052e-46fd0b9152amr338420011cf.46.1738691359835; 
 Tue, 04 Feb 2025 09:49:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254819959sm64435856d6.31.2025.02.04.09.49.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 09:49:19 -0800 (PST)
Message-ID: <77f736f6-9ef9-462b-916e-c8cfff279044@redhat.com>
Date: Tue, 4 Feb 2025 18:49:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
 <f4e64a3a-5c1d-49f2-ac72-b84ecd353c9d@redhat.com>
 <Z6EQENkHJy7TrkYy@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Z6EQENkHJy7TrkYy@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_BTC_ID=0.499, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Nicolin, Shameer,

On 2/3/25 7:50 PM, Nicolin Chen wrote:
> On Fri, Jan 31, 2025 at 05:54:56PM +0100, Eric Auger wrote:
>> On 1/9/25 5:45 AM, Nicolin Chen wrote:
>>> On Mon, Dec 16, 2024 at 10:01:29AM +0000, Shameerali Kolothum Thodi wrote:
>>>> And patches prior to this commit adds that support: 
>>>> 4ccdbe3: ("cover-letter: Add HW accelerated nesting support for arm
>>>> SMMUv3")
>>>>
>>>> Nicolin is soon going to send out those for review. Or I can include
>>>> those in this series so that it gives a complete picture. Nicolin?
>>> Just found that I forgot to reply this one...sorry
>>>
>>> I asked Don/Eric to take over that vSMMU series:
>>> https://lore.kernel.org/qemu-devel/Zy0jiPItu8A3wNTL@Asurada-Nvidia/
>>> (The majority of my effort has been still on the kernel side:
>>>  previously vIOMMU/vDEVICE, and now vEVENTQ/MSI/vCMDQ..)
>>>
>>> Don/Eric, is there any update from your side?
>> To be honest we have not much progressed so far. On my end I can
>> dedicate some cycles now. I currently try to understand how and what
>> subset I can respin and which test setup can be used. I will come back
>> to you next week.
> In summary, we will have the following series:
> 1) HWPT uAPI patches in backends/iommufd.c (Zhenzhong or Shameer)
>    https://lore.kernel.org/qemu-devel/SJ0PR11MB6744943702EB5798EC9B3B9992E02@SJ0PR11MB6744.namprd11.prod.outlook.com/
> 2) vIOMMU uAPI patches in backends/iommufd.c (I will rebase/send)
for 1 and 2, are you taking about the "Add VIOMMU infrastructure support
" series in Shameer's branch: private-smmuv3-nested-dev-rfc-v1.
Sorry I may instead refer to NVidia or Intel's branch but I am not sure
about the last ones.
> 3) vSMMUv3 patches for HW-acc/nesting (Hoping Don/you could take over)
We can start sending it upstream assuming we have a decent test environment.

However in
https://lore.kernel.org/all/329445b2f68a47269292aefb34584375@huawei.com/

Shameer suggested he may include it in his SMMU multi instance series.
What do you both prefer?

Eric


> 4) Shameer's work on "-device" in ARM virt.c
> 5) vEVENTQ for fault injection (if time is right, squash into 2/3)
>
> Perhaps, 3/4 would come in a different order, or maybe 4 could split
> into a few patches changing "-device" (sending before 3) and then a
> few other patches adding multi-vSMMU support (sending after 3).
>
> My latest QEMU branch for reference:
> https://github.com/nicolinc/qemu/commits/wip/for_iommufd_veventq-v6
> It hasn't integrated Shameer's and Nathan's work though..
> For testing, use this kernel branch:
> https://github.com/nicolinc/iommufd/commits/iommufd_veventq-v6-with-rmr
>
> I think we'd need to build a shared branch by integrating the latest
> series in the list above.
>
> Thanks
> Nicolin
>


