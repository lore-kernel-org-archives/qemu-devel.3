Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B076C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuxN8-0004It-Jd; Wed, 19 Mar 2025 13:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuxMu-0004HI-Mr
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuxMq-0005ZV-Sf
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742405892;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dn1EhXkOVyCxerNJNsPgFaLB1/m1+olH07gNcMdi4I0=;
 b=eOYh+b3Vows1EPZzegQwo2lAVuTCbnNhuOKo/5NfVbombY5q7DhLd8kfjLeQpoYXz+xHag
 c9kzHfrqYTZMWJpxeV2/okkGliWeJxQgLzaT7y8b0slbTq8pXbnIa7BQquT+A2bAOeleEl
 urhSGJbPWJT/whTICJVcVs4JU5/vC6M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-IRensgKWPgW8N2vGFKbKwQ-1; Wed, 19 Mar 2025 13:38:07 -0400
X-MC-Unique: IRensgKWPgW8N2vGFKbKwQ-1
X-Mimecast-MFC-AGG-ID: IRensgKWPgW8N2vGFKbKwQ_1742405886
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913d8d7c3eso4022370f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 10:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742405886; x=1743010686;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dn1EhXkOVyCxerNJNsPgFaLB1/m1+olH07gNcMdi4I0=;
 b=OrIaoE1SX2IAcbRH+MZJbbPN6Yz/fer0WDSifnICPVQHJ7jftQ8gqivSUILRR9/5U8
 MyI5edyvpERD1sKr6YxY0UbMw6468vTxf5VDuO0ygPdjxbZ+eQJjo/kj/JNIwOjaLL5z
 lmOyMdLzKh8b4ovuWfdulTASckuR2TToyqrHYOONSBsZunOuWTGROwZx90eE1eHwjwXc
 Y1vEVSSb+RVlVMrXcLkhLxfs5n5kjb+PHds175ryeYauVN3xdENJETEXIfjxBiYjclfh
 6n5378ufLt67U9s3AMlT6kmFExdBZ6c1/prviuxQFlzli7dhWFTJp5KOtFrY/HEnzJW8
 6HiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbWC69Z28815+DGgmSHyNBTzEx3T3awdPZla8sF0gUom0faKU5emOdy/HRI92uWcLFmFQQJgNh5rx5@nongnu.org
X-Gm-Message-State: AOJu0YzIgdpVXETKM+WtzM3jMkeUYh2kG+zotZJ7bi6j5bGNoaVyrJyc
 BJMMfdPCt0HTMFsktEFj7WiZFOap/3GYGocYrhgtKyDfeSwyXymsUToOcgh5gMTcwkwT3gbMU1Q
 Ne//9wmCBMImzAw+jOSmo3LIc1zrTdZQ2N8sbqyGyaM8N9DM5tSwY
X-Gm-Gg: ASbGnctOK+OiyojRDlvh3SBvkcLtN/kXnVgNnaHOsQOolC7guCn16QvVhfCHVH4JHPv
 7JJK8kw5wcokmkeceZBuFMAnSg0VU+2+XNnjmemYQ7yvzJsUZd7iwAGYQOiXyFtyaesLKGZXCFQ
 jgzWuEmW9b7vnuGWkOFEnxmVhoIcZXRvwDd77EQbfSlljzxx1ve7YDN4KcZ6Ki2oTK+rVf0FYjk
 IrYC/1J86SgVa05Q+6BoGxUEWo6Gex4h+D3Q3kHcrSuGF/fNZGzEAZkPs2Jp7R5SY4il37d0c/p
 RnQA1yN9S/9ZDOL/pH254UqC6pSk8foOQowA3m8cyqg9BKFVEE2EI2oJWiWUvf0=
X-Received: by 2002:a05:6000:1842:b0:391:3f94:dc9e with SMTP id
 ffacd0b85a97d-399795aceadmr367762f8f.16.1742405886430; 
 Wed, 19 Mar 2025 10:38:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLjX+7xGvwJ6RjbVzobWTv5/NqTejAwtA+otCrNuURSImX7Bc95bR9lzACh1DvItE7oNOcwA==
X-Received: by 2002:a05:6000:1842:b0:391:3f94:dc9e with SMTP id
 ffacd0b85a97d-399795aceadmr367729f8f.16.1742405885989; 
 Wed, 19 Mar 2025 10:38:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8975febsm22086264f8f.59.2025.03.19.10.38.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 10:38:05 -0700 (PDT)
Message-ID: <b3c2430d-bf29-452d-91bb-af0d8705e54d@redhat.com>
Date: Wed, 19 Mar 2025 18:38:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Donald Dutile <ddutile@redhat.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
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
 <27aee7f3-5316-40b7-bd7e-dc68a7a1d0d2@redhat.com>
 <dd973ecfbdc541f09540bdbcbf844047@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <dd973ecfbdc541f09540bdbcbf844047@huawei.com>
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




On 3/19/25 6:12 PM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Wednesday, March 19, 2025 5:01 PM
>> To: Jason Gunthorpe <jgg@nvidia.com>; Donald Dutile
>> <ddutile@redhat.com>
>> Cc: Nicolin Chen <nicolinc@nvidia.com>; Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org; peter.maydell@linaro.org;
>> berrange@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
>> smostafa@google.com; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
>> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>> zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
>> infrastructure for smmuv3-accel device
>>
>> Hi,
>>
>>
>> On 3/19/25 1:23 AM, Jason Gunthorpe wrote:
>>> On Tue, Mar 18, 2025 at 05:22:51PM -0400, Donald Dutile wrote:
>>>
>>>> I agree with Eric that 'accel' isn't needed -- this should be
>>>> ascertained from the pSMMU that a physical device is attached to.
>>> I seem to remember the point was made that we don't actually know if
>>> accel is possible, or desired, especially in the case of hotplug.
>> that's why I think it would be better if we could instantiate a single
>> type of device that can do both accel and non accel mode.
>> Maybe that would be at the price of always enforcing MSI resv regions on
>> guest to assure MSI nesting is possible.
>>
>>> The accelerated mode has a number of limitations that the software
>>> mode does not have. I think it does make sense that the user would
>>> deliberately choose to use a more restrictive operating mode and then
>>> would have to meet the requirements - eg by creating the required
>>> number and configuration of vSMMUs.
>> To avoid any misunderstanding I am not pushing for have a single vSMMU
>> instance. I advocate for having several instances, each somehow
>> specialized for VFIO devices or emulated devices. Maybe we can opt-in
>> with accel=on but the default could be auto (the property can be
>> AUTO_ON_OFF) where the code detects if a VFIO device is translated.In
>> case incompatible devices are translated into a same vSMMU instance I
>> guess it could be detected and will fail.
>>
>> What I am pusshing for is to have a single type of QEMU device which can
>> do both accel and non accel.
>>> In general I advocate for having several vSMMU instances, each of them
>>>
>>>> Now... how does vfio(?; why not qemu?) layer determine that? --
>>>> where are SMMUv3 'accel' features exposed either: a) in the device
>>>> struct (for the smmuv3) or (b) somewhere under sysfs? ... I couldn't
>>>> find anything under either on my g-h system, but would appreciate a
>>>> ptr if there is.
>>> I think it is not discoverable yet other thatn through
>>> try-and-fail. Discoverability would probably be some bits in an
>>> iommufd GET_INFO ioctl or something like that.
>> yeah but at least we can easily detect if a VFIO device is beeing
>> translated by a vSMMU instance in which case there is no other choice to
>> turn accel on.
> Not sure, how you can handle hotplug in such a case? For example if  the smmuv3
> dev starts with an emulated device and later try plug a vfio dev? In case of "accel"
> the feature bits(IIDR) is queried from the host SMMUv3 and is presented to
> to the vSMMU(See patch  #16). We can't do this once Guest is booted.
if accel=auto, if smmu is attached to a bus where only emulated devices
are plugged, at cold start accel=false and then it effectively becomes
impossible to hotplug a vfio device.
if accel=auto and smmu is attached to a bus where a VFIO-PCI device is
cold-plugged, we end up with accel=on forced.
otherwise you always have the possible to opt-on for accel with accel=true
just like intel_iommu has caching_mode option.
>
> Also Daniel previously commented on RFCv1 that he would like to have explicit
> vSMMU<-->pSMMU association in Qemu command line. 
> https://lore.kernel.org/qemu-devel/Z6TLSdwgajmHVmGH@redhat.com/
tbh I did not understand why this explicit setting was needed and why it
can't be inferred from the HostIOMMUDevice. But I need to read this back.
>
> Though we are not there yet without a cold-plugged VFIO dev at the moment,
> having auto detection of accel is not the right approach if we want an explicit
> association in Qemu command line.
Maybe we shall not focus too much on auto detection at the moment.

Eric
>
> Thanks,
> Shameer


