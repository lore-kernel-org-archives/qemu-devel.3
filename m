Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED1FC35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwYr-0003Ez-B8; Wed, 19 Mar 2025 12:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuwYS-00038M-62
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuwYL-0002tQ-2m
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742402758;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ps+r4+jdVyAOh6eJZGhPtJG9C5CqL8QyhJ6P2qBSgco=;
 b=G40VhJiDq7+chh7DzT450VfdNsMlCUfaSPCZt83OtuuLU8JXDzWBPGbIQWYTuSgG7VLLKZ
 hubYUPosYTY7dspHYnxf9QFBvoeH5CMkKN/2fnslZdQga8v9iYiSJdNIWP6YEGJe+Gsimt
 yEEU6KTPJQeMqqmlwg05tGI2RDY/MwQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-5831t1AxPwGHGcOp9cYLaw-1; Wed, 19 Mar 2025 12:45:56 -0400
X-MC-Unique: 5831t1AxPwGHGcOp9cYLaw-1
X-Mimecast-MFC-AGG-ID: 5831t1AxPwGHGcOp9cYLaw_1742402756
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d08915f61so27195925e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742402756; x=1743007556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ps+r4+jdVyAOh6eJZGhPtJG9C5CqL8QyhJ6P2qBSgco=;
 b=nQCCmnhvaCynpLDxEgE2Wus1GcKNHcub/UiC7UReHNtk8hcFovqepWdlbELyzUstSo
 2WJ/uTBY4s8GPzgygEqqhm29cqaAfbsHUFVGOsSG8EXGdsVzuVuNqQDlKdgOuNT99+Ap
 wMW6Pczd+Q5xLpJhV8geOj6f18fZWu6OGhxFpnCDHV6bNjXeHbAI13VRmFmf/ll7nVKB
 j5QYMZ4CZoJaNzs1yRInCwZv+YsLhiZo257pIIXgDtCceh+2g8e955ITcpziVogxP5ti
 YYM9Pozm5LXp4gBrp3u6aysm0o4/vOPdFtAcwSH8HRNl/uQPaWBQXxCSQPDsuSt8gyKV
 NBLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD0hJL4pDi1KDmYsb0/ZFV9jbYCIY2kjQN/HjFPEaEG2bT0wghvCtP/vHyssauVUGaZze/4p11LZBT@nongnu.org
X-Gm-Message-State: AOJu0YwvJmO3Pq5hBl5zgjow5rOsu/6veBrc8YpU1vsOrB2lmsYUwV01
 Pg8TpmCA/nOAuy7e1B/0Iy55LwG5p95kRVHhvhzhNzR/CKsWnK8PcJzLNiW0PvIRipDz8/9MaRz
 hLvk0UTjDqbONaeCLughSPqbQtUMiUBTeyS2zZa3fmYVscRRy3VEa
X-Gm-Gg: ASbGncvNZIa/oFjF1sr2U4u4e/rmo8Zx+cH3uYGZ3HnYiAgacgHXjHIYQfloHLvRzD0
 dHSH7Z5Oy4E+KUlxeE80DDwYSeLUoYZU+F8ZkyNdMJ98jp9azR0IzdoMP+uBV+2YqCHYSjAheSw
 kbgbeayV4GlpbkJ70r8c2hokyZp4l4RNKXtulA7S5/tF06KUKqstpJBGQK8GymxVNLB6MBC3vTf
 0REGPUNuZIQ+V4gIn4tQ2hzp1d6M6fjNHFrKgQGL8aGB9Z+aZJllTxUxAKIuuM/QCDkI671dhpV
 7YC6q9B9umFgs2XnqJup2IECjxwCH775e3fZq/p1FVeki0rhVxSoNabXsK3XBTQ=
X-Received: by 2002:a05:600c:5488:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-43d437f360dmr40431275e9.16.1742402755619; 
 Wed, 19 Mar 2025 09:45:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzJ4UzQr+/+12gVLWooxjYS73KvUmJiwbdV/k+0K416wDB5A19HJFSh/gSMA+5bLSOa8ZB8g==
X-Received: by 2002:a05:600c:5488:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-43d437f360dmr40430885e9.16.1742402755029; 
 Wed, 19 Mar 2025 09:45:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4870ee71sm6921655e9.30.2025.03.19.09.45.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:45:54 -0700 (PDT)
Message-ID: <11895c78-d6ab-40c8-a500-4abed1565234@redhat.com>
Date: Wed, 19 Mar 2025 17:45:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 jgg@nvidia.com, ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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




On 3/17/25 8:10 PM, Nicolin Chen wrote:
> On Mon, Mar 17, 2025 at 07:07:52PM +0100, Eric Auger wrote:
>> On 3/17/25 6:54 PM, Nicolin Chen wrote:
>>> On Wed, Mar 12, 2025 at 04:15:10PM +0100, Eric Auger wrote:
>>>> On 3/11/25 3:10 PM, Shameer Kolothum wrote:
>>>>> Based on SMMUv3 as a parent device, add a user-creatable smmuv3-accel
>>>>> device. In order to support vfio-pci dev assignment with a Guest
>>>> guest
>>>>> SMMUv3, the physical SMMUv3 has to be configured in nested(S1+s2)
>>>> nested (s1+s2)
>>>>> mode, with Guest owning the S1 page tables. Subsequent patches will
>>>> the guest
>>>>> add support for smmuv3-accel to provide this.
>>>> Can't this -accel smmu also works with emulated devices? Do we want an
>>>> exclusive usage?
>>> Is there any benefit from emulated devices working in the HW-
>>> accelerated nested translation mode?
>> Not really but do we have any justification for using different device
>> name in accel mode? I am not even sure that accel option is really
>> needed. Ideally the qemu device should be able to detect it is
>> protecting a VFIO device, in which case it shall check whether nested is
>> supported by host SMMU and then automatically turn accel mode?
>>
>> I gave the example of the vfio device which has different class
>> implementration depending on the iommufd option being set or not.
> Do you mean that we should just create a regular smmuv3 device and
> let a VFIO device to turn on this smmuv3's accel mode depending on
> its LEGACY/IOMMUFD class?

no this is not what I meant. I gave an example where depending on an
option passed to thye VFIO device you choose one class implement or the
other.
>
> Another question: how does an emulated device work with a vSMMUv3?
I don't get your question. vSMMUv3 currently only works with emulated
devices. Did you mean accelerated SMMUv3?
> I could imagine that all the accel steps would be bypassed since
> !sdev->idev. Yet, the emulated iotlb should cache its translation
> so we will need to flush the iotlb, which will increase complexity
> as the TLBI command dispatching function will need to be aware what
> ASID is for emulated device and what is for vfio device..
I don't get the issue. For emulated device you go through the usual
translate path which indeed caches configs and translations. In case the
guest invalidates something, you know the SID and you find the entries
in the cache that are tagged by this SID.

In case you have an accelerated device (indeed if sdev->idev) you don't
exercise that path. On invalidation you detect the SID matches a VFIO
devoce, propagate the invalidations to the host instead. on the
invalidation you should be able to detect pretty easily if you need to
flush the emulated caches or propagate the invalidations. Do I miss some
extra problematic?

I do not say we should support emulated devices and VFIO devices in the
same guest iommu group. But I don't see why we couldn't easily plug the
accelerated logic in the current logical for emulation/vhost and do not
require a different qemu device.

Thanks

Eric
>
> Thanks
> Nicolin
>


