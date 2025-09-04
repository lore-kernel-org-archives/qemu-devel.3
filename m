Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085EACA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 14:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuB10-0000Wc-ND; Thu, 04 Sep 2025 10:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuB0w-0000W5-GX
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuB0N-00068x-Lz
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756996318;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pPn3U/ZJ08geO/khRmvMh/qxUuxJLFKtL9Kn0rdyTM0=;
 b=CAQsp+uh2Be44D6i1xT4n/xSboQGYKoLEvVlA+IEo5u3kP8nSkKZKz3HIHX3SBkvLpgrZk
 eJ/cRNtRDSZuQ+KUbe1JdPpfsOBrdCWVAydQCHoOM7bI+8lIvV2xstRLeCgM7MfcLPxgMm
 uwPVw20qFF8F6jYx2RrTtT+sYtrVUtg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-hOXrMOmrMCeJOjZHjvsebg-1; Thu, 04 Sep 2025 10:31:57 -0400
X-MC-Unique: hOXrMOmrMCeJOjZHjvsebg-1
X-Mimecast-MFC-AGG-ID: hOXrMOmrMCeJOjZHjvsebg_1756996316
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b9ca27a11so10209385e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 07:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756996316; x=1757601116;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pPn3U/ZJ08geO/khRmvMh/qxUuxJLFKtL9Kn0rdyTM0=;
 b=JnwgAuWM10E9EElq++e47jt3wyCj1x72QWnBV51S+mksCtwrhFB2L7ju+6qyPB7JQw
 ndNcKIymwkenmv4NIBes92RRKBAofclhF/yuV5YySInBhAvCumohn9zpcDH2/51tCdWe
 qCx+vo6IgAF432zkfi+4q0ZnVQZNlWtAWov6zpt63XiNK5ss5DRUbcfPh4xPWpLmR/K1
 6zwm3DhcsgjtjdsaI82JXWj2oWEOi4uvKBLWqvMEkjApxp63hR+dkt9yfgqMLJdEwjKN
 lLsgKH2g3fmpzD7D8hnieMYGVZ6OZWN9HM7+2O67KwXepw5EivctVCxzNt20TyQ8eXSz
 wX1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+wEaQPx/WBrUBLGlU1uOCtsj76HbXsy6c9Ol+6OqqZDVOM5qFj4Cd1JoqwpLNEYuCOgP8Y4sLAllq@nongnu.org
X-Gm-Message-State: AOJu0YwumpRGYLYDMBfcfutYWWayrBQGtWBc5e34SfxU8yy+6RQNvzDB
 QbNmSI5CwmlUwjtNUwXpzFkC3fcpOfF+VDZpAnenzNzmL3rC6cSUII36kLPKBqco02wxEtlP2mX
 AdBB1D1BVGJPTgNhNcb4erG+BhHyCGm0SzOCrqAEDjaUgVb3djUH3AJfu
X-Gm-Gg: ASbGnct96yvUcBkAxsTKX+1sDXdx5yFg7t4s7c9b7iQK9yJ+UkZW6Fg5Vpdyd0abRZr
 Lt1e0rkk5s+YvyZhtZnzKWgZnT4mzsUwKdVV/MJcl1Lv1W/0fDsK+mHfcDaizr43blZvSU8jNPa
 9QPqFRyiH/fKCVKgsIOdUwu8f+wmS7d+nFu6Iq3bljDGExhc4HVDMP6hF9rB07euMZ9npQwE0jN
 BDk2Hpx6qR+Rka3YUN6MixbzQi4lpBGHGRRqfNvTaF3rZGl/hBCGhIlC9QvSXoQ9Ysi8YIzmFoJ
 UXBQriMBSMHLPJ83c6YaKqiCdbeI6yRtmltKuEQwXL9EMQs28QTCNHYWUktIsFeIf2b2ZsofAm2
 jbWvXW0oY7v8=
X-Received: by 2002:a05:600c:4e0e:b0:45d:d202:77f0 with SMTP id
 5b1f17b1804b1-45dd2027c29mr18834155e9.5.1756996316193; 
 Thu, 04 Sep 2025 07:31:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErZ4c57Vh+Y2//18EYDeA/Buxfw+Je5UZkapXvS+Q5wlc560firjR8VssNVT1SoN1spMkQBA==
X-Received: by 2002:a05:600c:4e0e:b0:45d:d202:77f0 with SMTP id
 5b1f17b1804b1-45dd2027c29mr18833695e9.5.1756996315665; 
 Thu, 04 Sep 2025 07:31:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d520eada16sm19054405f8f.41.2025.09.04.07.31.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Sep 2025 07:31:55 -0700 (PDT)
Message-ID: <71ca9132-8deb-4f57-abb0-2bcc0fe93ae9@redhat.com>
Date: Thu, 4 Sep 2025 16:31:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, skolothumtho@nvidia.com
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
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-6-shameerali.kolothum.thodi@huawei.com>
 <IA3PR11MB9136ACFB4721D47304A9885C9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aHaP3ULG90gGqWHJ@Asurada-Nvidia>
 <IA3PR11MB9136C94472D7D50CDC627CB49256A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <6ee7908c8ea44270b9f4aa64abacaace@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <6ee7908c8ea44270b9f4aa64abacaace@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/16/25 11:27 AM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>> Sent: Wednesday, July 16, 2025 4:39 AM
>> To: Nicolin Chen <nicolinc@nvidia.com>
>> Cc: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org; eric.auger@redhat.com;
>> peter.maydell@linaro.org; jgg@nvidia.com; ddutile@redhat.com;
>> berrange@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
>> smostafa@google.com; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
>> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>> zhangfei.gao@linaro.org; shameerkolothum@gmail.com
>> Subject: RE: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce
>> smmuv3 accel device
>>
>>
>>
>>> -----Original Message-----
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>> Subject: Re: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce
>>> smmuv3 accel device
>>>
>>> On Tue, Jul 15, 2025 at 10:48:31AM +0000, Duan, Zhenzhong wrote:
>>>>> +static const TypeInfo types[] = {
>>>>> +    {
>>>>> +        .name = TYPE_ARM_SMMUV3_ACCEL,
>>>>> +        .parent = TYPE_ARM_SMMUV3,
>>>>> +        .class_init = smmuv3_accel_class_init,
>>>>> +    }
>>>> In cover-letter, I see "-device arm-smmuv3", so where is above accel
>>>> device created so we could use smmuv3_accel_ops?
>>> The smmu-common.c is the shared file between accel and non-accel
>>> instances. It has a module property:
>>>    DEFINE_PROP_BOOL("accel", SMMUState, accel, false),
>> It looks we expose a new TYPE_ARM_SMMUV3_ACCEL type device just for
>> exporting accel iommu_ops?
>> What about returning accel iommu_ops directly in
>> smmu_iommu_ops_by_type() and drop the new type?
> We are not creating any new device here. Its just a Class object of different type.
> I had a different approach previously and Eric suggested to try this as there
> are examples in VFIO/IOMMUFD for something like this.
>
> https://lore.kernel.org/qemu-devel/1105d100-dd1e-4aca-b518-50f903967416@redhat.com/
Actually I pointed out that usually we don't add methods in states as it
was done in v2 (in SMMUState) but rather in classes hence my suggestion
to use a class instead. Now what looks strange is your class does not
implement any method ;-)

docs/devel/qom.rst says "The #ObjectClass typically holds a table of function pointers
for the virtual methods implemented by this type."

Sorry if I was unclear.

Now if you don't need any "accel" specific methods besides the PCIIOMMUOps which have a specific struct, I am not sure we need a class anymore. or then you direct embed the PCIIOMMUOps Struct in the method?

Also it's true that's weird that the actual object is never instantiated and may also appear in qom object list. This is not the case for the example I gave, ie. the VFIOContainerBase.

I don't know if anyone has a better/more elegant idea?

Thanks

Eric

>
> Thanks,
> Shameer
>
>>> where it directs to different iommu_ops:
>>> 937 static const PCIIOMMUOps *smmu_iommu_ops_by_type(SMMUState
>> *s)
>>> 938 {
>>> 939     SMMUBaseClass *sbc;
>>> 940
>>> 941     if (s->accel) {
>>> 942         sbc =
>>> ARM_SMMU_CLASS(object_class_by_name(TYPE_ARM_SMMUV3_ACCEL));
>>> 943     } else {
>>> 944         sbc =
>>> ARM_SMMU_CLASS(object_class_by_name(TYPE_ARM_SMMU));
>>> 945     }
>>> 946     assert(sbc->iommu_ops);
>>> 947
>>> 948     return sbc->iommu_ops;
>>> 949 }
>>>
>>> Nicolin


