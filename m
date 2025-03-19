Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA60C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuxCT-000811-1l; Wed, 19 Mar 2025 13:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuxBz-0007pB-Bt
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuxBx-0000Cq-Im
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742405216;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u/rODeXf3PlV/XHc+LDEhwS17RHRnNkBAC7tdmnnkPg=;
 b=QaBqctd4Emnux6rlAZhT4kKgqcS0vtJZKGQhrtFDIFqf89XSajPLNxJXMGVM4hiE8/FxA3
 Bt32XJb1Z+8slGMvOxh1VQjiHA6NNs48Qz2eMThHge1C2AjVt05TvAjyoaqCFqZKWT7fCz
 IAt2HCGoe1zyuqfstsUOCSvXTNARM1Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-1Pr_BKrkO4SaZuNfHtQAvA-1; Wed, 19 Mar 2025 13:26:53 -0400
X-MC-Unique: 1Pr_BKrkO4SaZuNfHtQAvA-1
X-Mimecast-MFC-AGG-ID: 1Pr_BKrkO4SaZuNfHtQAvA_1742405212
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so40798515e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 10:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742405212; x=1743010012;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u/rODeXf3PlV/XHc+LDEhwS17RHRnNkBAC7tdmnnkPg=;
 b=GPbu0o8xg0yStg/xZDn1HelYXz4BnyvTrTXonrYPDLP0WaOwwevPT+NPpXlgdK3xNY
 0bPrAhKrWoENsXWRRPV9li885p4Wx0pb1bSPviT/+FM20XAbvvy/BnujRN405oZNkkjP
 627qbO8BVSeBfDXqA6J/z558hbs4BZmLBaFV8t/5oY4KuJnmuSNSSSLlimTnzMIOu8mJ
 yM8U4rkFwqFezu6J8vIy/ciUJzLHv6QZLf/b3tujkpSOruRExVvOv1f2AMgIGtxZxEJp
 hmGuNEoQJ0hd8hTvZHo/TNy/JjnBcLAyGZauCylIRO8g+6FJKTPUsS/wOAp37bJoKZq/
 +kUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWECI2zyCk0bX0B1LsUebOXI8s5uILjeJ2u2U5BaDX7WIq6vTOldiAgQV1mTWdgxmJv7VdBmONeon6Q@nongnu.org
X-Gm-Message-State: AOJu0Yyz/rQwnLpZ9IOsf5hjHwBQWflhP89q3k5lw7i+l96cG+KIe3Rt
 5IOlCnGA2fIvb7lp0NrL6NTy+KkAtWBuiYnJ4O+loMuVuunEK2AEVGA6WBoFvZuVr2SxGJqu8BE
 0s+lmz8PFEG8O1Rylb1yMfPh9JCAtUmul2wb+hhKGPP5mqIAp5AGD
X-Gm-Gg: ASbGnctUrIvRvwIKTRmecbmpcsoqoTFGjqBky70vjKzzl5dC4oy3HqEw2UsmaFqcL4w
 OM8VvH6cOy6fGK8bN1WOIu0xGa5PJwPT1kZt5Xq8CMLTqLad86xN4xy6gKrPl2EZBXdewzjsfk/
 aI8j+Bn4VStY9XrwDjQEZggcnqI+k874z1Sb3ieseM3S6AEg2wYvrCeY4zFUXp8xcr625f5C1EE
 ZLAFhaO33oeMTGYGnPvkAWmK76MifGGBWrWImBnP1MsE2VMOMXJK329PWgF0z68dJYuiB97S10u
 NIHCY8pYu4M4bqvH2gBNLYWN4okOmhonbH154KxV/AZPexnv76PLO/uj9nBvYQU=
X-Received: by 2002:a05:600c:1d9f:b0:43c:f81d:f with SMTP id
 5b1f17b1804b1-43d49542f51mr117515e9.8.1742405211781; 
 Wed, 19 Mar 2025 10:26:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1Qi1tEGYL/Oitu3dI5PzD9LZAAq9Qs/W8c14wh6MrvH1M+o566RXt1xX8W4MxHZsSBR90EA==
X-Received: by 2002:a05:600c:1d9f:b0:43c:f81d:f with SMTP id
 5b1f17b1804b1-43d49542f51mr117305e9.8.1742405211328; 
 Wed, 19 Mar 2025 10:26:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f74d9bsm24311045e9.32.2025.03.19.10.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 10:26:50 -0700 (PDT)
Message-ID: <5a273945-3557-43f6-a235-1517d5db9b48@redhat.com>
Date: Wed, 19 Mar 2025 18:26:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
 <11895c78-d6ab-40c8-a500-4abed1565234@redhat.com>
 <a1a62689da8c43ca98a4379773db241c@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <a1a62689da8c43ca98a4379773db241c@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Shameer,


On 3/19/25 5:53 PM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Wednesday, March 19, 2025 4:46 PM
>> To: Nicolin Chen <nicolinc@nvidia.com>
>> Cc: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org; peter.maydell@linaro.org; jgg@nvidia.com;
>> ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
>> infrastructure for smmuv3-accel device
>>>>> Is there any benefit from emulated devices working in the HW-
>>>>> accelerated nested translation mode?
>>>> Not really but do we have any justification for using different device
>>>> name in accel mode? I am not even sure that accel option is really
>>>> needed. Ideally the qemu device should be able to detect it is
>>>> protecting a VFIO device, in which case it shall check whether nested is
>>>> supported by host SMMU and then automatically turn accel mode?
>>>>
>>>> I gave the example of the vfio device which has different class
>>>> implementration depending on the iommufd option being set or not.
>>> Do you mean that we should just create a regular smmuv3 device and
>>> let a VFIO device to turn on this smmuv3's accel mode depending on
>>> its LEGACY/IOMMUFD class?
>> no this is not what I meant. I gave an example where depending on an
>> option passed to thye VFIO device you choose one class implement or the
>> other.
>>> Another question: how does an emulated device work with a vSMMUv3?
>> I don't get your question. vSMMUv3 currently only works with emulated
>> devices. Did you mean accelerated SMMUv3?
>>> I could imagine that all the accel steps would be bypassed since
>>> !sdev->idev. Yet, the emulated iotlb should cache its translation
>>> so we will need to flush the iotlb, which will increase complexity
>>> as the TLBI command dispatching function will need to be aware what
>>> ASID is for emulated device and what is for vfio device..
>> I don't get the issue. For emulated device you go through the usual
>> translate path which indeed caches configs and translations. In case the
>> guest invalidates something, you know the SID and you find the entries
>> in the cache that are tagged by this SID.
> Not always you get sid, eg: CMD_TLBI_NH_ASID

Effectively with ASID invalidation you potentially need to do both qemu
IOTLB invalidation and host invalidation propagation.
but this code is already in place in the code and used in vhost mode:

            smmu_inv_notifiers_all(&s->smmu_state);
            smmu_iotlb_inv_asid_vmid(bs, asid, vmid);

but as stated before in VFIO accel mode the cache is not filled so I
don't expect a huge penalty

Besides we can also disable qemu caches if it turns the accel mode is in
use, no?

Eric


>
> Thanks,
> Shameer


