Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B91C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwnX-0004Jz-Bo; Wed, 19 Mar 2025 13:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuwmz-0004Ak-8Q
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuwmt-00072e-CV
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742403662;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=egPJf6wKxHWczXc1lB/aGNuFGvu+4Swpt75RU6whBHA=;
 b=fdo8bRm1fNrHv45I6eJ7qGwWrifMfsRM+BSai7TpNR4AnCvtU6NE1ZUKLtm3ZRbbT3VVto
 1+bfLg/oZTs95oCqQx/muL4VfYiqB+74x34vT1QsXnSN8biETuwJb98oYQ7uTAiEYvmRWd
 wvx9WmXfi2eiLYds3sctw/BsDzTkQMs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-YW9EQ1KxOainhyaGq_-_TQ-1; Wed, 19 Mar 2025 13:01:00 -0400
X-MC-Unique: YW9EQ1KxOainhyaGq_-_TQ-1
X-Mimecast-MFC-AGG-ID: YW9EQ1KxOainhyaGq_-_TQ_1742403659
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4394040fea1so4905335e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 10:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742403659; x=1743008459;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=egPJf6wKxHWczXc1lB/aGNuFGvu+4Swpt75RU6whBHA=;
 b=XdwgAsRIDMLkFiLORhzhfLijz4zzjxG21AVkrJ7f9yZzSPqxfm4Vd0dVk0ZYsmPI2b
 26pf6sx5PSgdSYjtnQGWZgJ0CpVooJcXnhokFv4iFc/IDd8JX1/MD2Ft5LJ87CFDEio8
 N2yYVEy5KBWx/3/YqurdNeXzx+7C1QcMRNYBcqmdKPDEO/GpYXTufqd8bI3DJN3boWvR
 9xUeovDEHT4/o3pDFC1ARgA8WHxoM4JTRGm0pFjQyrTigR8ODtIwUwofEXaH+pbdNWMC
 Qj3UbZmKrhqA7ZGHAqOJafeFXZxrjU1/1uFWj2H4N5Xo/r0t1mDikYZ5FAzEKsyULwTG
 KFRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsD16TfeQizPiWnT4NI0mrVGbvXdZV15tLUmz6mzZZIUzA1v13t/w1xES34UgdJH4muBxaPoQvnuL3@nongnu.org
X-Gm-Message-State: AOJu0Yxa5Q76R+2b2HVNDxlNBRDImj9xrQLwmEmXFzWD2JmAZp/oRjTh
 z8BbADGkqjNUrjgs89EGbCXJAiIoBwim2mKz1K9AJWoHe518tIaJa9mJ77Lxqra0JRO8Pi1WbkE
 plOqSanGNis0BxmaZ3O6h1eNEZpLpm4wjbcccLE5Hl7ihvNTD4Ct2
X-Gm-Gg: ASbGncttETytwUg95s3iwJ9rMoHWb3w8aYcswBH2blrpXU5Bwg0Lk1soKsziUKDjO0k
 8HpnsenDYkvVeVdp2ChFG9s5RxpAegk2zCCbNUCCSeNT3PrgyjPccJZj/NTCOfXd5viMPGuWR7I
 h8VZg6DtTd36+t+YfvIjz2HugiFKMD7pXvBmhMpQjNnfSzvFSX6kRXwL/V6l0ABgRPA7XbGA6x3
 ATRZcAP6E7PqFgNvPyI7h5kjg+RAyphAqlulHxPsDzEdLz1xxmGcdqFYEb7r4INABHeoRuesaQn
 FwPRkqfV0tvsUC4AJoks/ikNEr0Z/gMyrrY5fZfmfUYPofIZj5y+fUYQtm+dEuU=
X-Received: by 2002:a05:600c:c10e:b0:439:5d00:e78f with SMTP id
 5b1f17b1804b1-43d491b70f1mr1060355e9.11.1742403659087; 
 Wed, 19 Mar 2025 10:00:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmi+s+H1/OYd59m2PPFGfWFcbaAf2+Hzz6wEI9qQtXQeNHN48pv0r6lNw/1PuOUz12fAfLTQ==
X-Received: by 2002:a05:600c:c10e:b0:439:5d00:e78f with SMTP id
 5b1f17b1804b1-43d491b70f1mr1059815e9.11.1742403658600; 
 Wed, 19 Mar 2025 10:00:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43fdeba1sm23768775e9.32.2025.03.19.10.00.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 10:00:57 -0700 (PDT)
Message-ID: <27aee7f3-5316-40b7-bd7e-dc68a7a1d0d2@redhat.com>
Date: Wed, 19 Mar 2025 18:00:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Donald Dutile <ddutile@redhat.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com,
 smostafa@google.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia> <20250317192453.GR9311@nvidia.com>
 <Z9iDxSvZVsgtasGj@Asurada-Nvidia>
 <6cb391a4-d150-4692-b62e-a509448a1034@redhat.com>
 <Z9nF6FaIU37BNg4B@Asurada-Nvidia>
 <3716d39d-3f88-4914-a9d6-440d379db3d7@redhat.com>
 <20250319002325.GG9311@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250319002325.GG9311@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,


On 3/19/25 1:23 AM, Jason Gunthorpe wrote:
> On Tue, Mar 18, 2025 at 05:22:51PM -0400, Donald Dutile wrote:
>
>> I agree with Eric that 'accel' isn't needed -- this should be
>> ascertained from the pSMMU that a physical device is attached to.
> I seem to remember the point was made that we don't actually know if
> accel is possible, or desired, especially in the case of hotplug.
that's why I think it would be better if we could instantiate a single
type of device that can do both accel and non accel mode.
Maybe that would be at the price of always enforcing MSI resv regions on
guest to assure MSI nesting is possible.

>
> The accelerated mode has a number of limitations that the software
> mode does not have. I think it does make sense that the user would
> deliberately choose to use a more restrictive operating mode and then
> would have to meet the requirements - eg by creating the required
> number and configuration of vSMMUs.
To avoid any misunderstanding I am not pushing for have a single vSMMU
instance. I advocate for having several instances, each somehow
specialized for VFIO devices or emulated devices. Maybe we can opt-in
with accel=on but the default could be auto (the property can be
AUTO_ON_OFF) where the code detects if a VFIO device is translated.In
case incompatible devices are translated into a same vSMMU instance I
guess it could be detected and will fail.

What I am pusshing for is to have a single type of QEMU device which can
do both accel and non accel.
> In general I advocate for having several vSMMU instances, each of them
>
>> Now... how does vfio(?; why not qemu?) layer determine that? --
>> where are SMMUv3 'accel' features exposed either: a) in the device
>> struct (for the smmuv3) or (b) somewhere under sysfs? ... I couldn't
>> find anything under either on my g-h system, but would appreciate a
>> ptr if there is.
> I think it is not discoverable yet other thatn through
> try-and-fail. Discoverability would probably be some bits in an
> iommufd GET_INFO ioctl or something like that.
yeah but at least we can easily detect if a VFIO device is beeing
translated by a vSMMU instance in which case there is no other choice to
turn accel on.

Thanks

Eric
>
>> and like Eric, although 'accel' is better than the
>> original 'nested', it's non-obvious what accel feature(s) are being
>> turned on, or not.
> There are really only one accel feature - direct HW usage of the IO
> Page table in the guest (no shadowing).
>
> A secondary addon would be direct HW usage of an invalidation queue in
> the guest.
>
>> kernel boot-param will be needed; if in sysfs, a write to 0 an
>> enable(disable) it maybe an alternative as well.  Bottom line: we
>> need a way to (a) ascertain the accel feature (b) a way to disable
>> it when it is broken, so qemu's smmuv3 spec will 'just work'.  
> You'd turned it off by not asking qemu to use it, that is sort of the
> reasoning behind the command line opt in for accel or not.
>
> Jason
>


