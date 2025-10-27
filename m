Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4ABCCCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDNwC-00022l-7z; Mon, 27 Oct 2025 10:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDNw8-00021K-OX
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:11:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDNw0-00036h-Ay
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761574249;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yf1l1mcFurb3xeUN/ct7dLCgFOHzBGDvmzN/RLcixfs=;
 b=Hj7kOnJb2GpV7n08XQcTx55ziT1m7DbB3lXpsxZoPspEZbbW1d+aSN7RcD4xBjLsaHC8tv
 oIBoPsP9T3UHRRNYtBzstJcey5/1la6slxppgw9SAu+kh1G9bc3CjOGhL0YVOjKOhDrozt
 mPXlr8G6cYTZZb5uAd6Bu43mUipRDZQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-iv8oHHXbOKa1Wz3Sk3iesQ-1; Mon, 27 Oct 2025 10:10:48 -0400
X-MC-Unique: iv8oHHXbOKa1Wz3Sk3iesQ-1
X-Mimecast-MFC-AGG-ID: iv8oHHXbOKa1Wz3Sk3iesQ_1761574247
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4721b4f3afbso13169915e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 07:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761574246; x=1762179046;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yf1l1mcFurb3xeUN/ct7dLCgFOHzBGDvmzN/RLcixfs=;
 b=FP9c4uIlPcvrvVMBFAKJJ7JB0c5VZQ2mWcoH+4UgIcQOu2s31lP+SHxqg83qBDMMkV
 tGluyWdBqXTMEbVdgdkvqMBk4jJQwUDg3Fb6GSQWPFdenls/5DMVocqcURjo5IurWEu/
 Wjcg1gXmTeSzwoCxGNOu5MCBLHC91LmVM8trBoV18eAp+uV8VDfIIywRytH6XssXokUX
 RAzlgKSzxJ8eUJjzLThGzJU5MraXgiII8YAmzti+Y07b6A06ipQpndenfbMHrGc4qdMH
 avh+wGTc6OAE7pvjsoH7s6Rv11XYCtaGr3yc76tE0K41u+KHBqlvq9efHEd5QLtVl6LL
 ag9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmPSBBuMABgOWElGBwn3Ftm/KdcHhge94tE8TtQt//lYpNmCs+1IvAvKKTNozqzG/C4mjqTcWRUmh1@nongnu.org
X-Gm-Message-State: AOJu0Yxjk0krWl1Phm/HOaCW8attvamffotAKR7hFncVSUldWOh2NCcT
 wQtdNTSE7HvwoimvisUOg9a2C39xZF+oNiC5+i502vAvH1xtz2Xq4nP+ZNg9CKkjDEbB9lwiASF
 y6pDURTR9PCuUWibDE6k4+0UOUGaSalo/QWjE+WR82EL618agYiOJi9AII8W5Apak
X-Gm-Gg: ASbGnctwvpb+8GjGHCatuAOK+SmmbW6nDiOdPUOevGap537DGaQ2cinqXApHGiP35Ag
 5duLjHA4GI8RO9zbyuFVlqBRcJ0ofr2rudccDk+WgN+qed3TeSJCNfcS8i4dmSBt+UbAP3V1/pX
 2dcJFkGHTjUUjv4FZT042L05uFIt0xg2Y+vWju6y6cylP1lv96bRSU4KvqIlt3UtGbL25QV+Ug8
 qrHu3EqVSCtKrmUBT/L1yWkZV9khULiHmEEJs8sbvArK3JcurL0BXBV+AjASM9ZDH3gfrjV/70Z
 pTc1YZ+Rg/Qo5S54LmMWLRKKELzx+tFVUi9r8NqAbhMaoJrtA5dx5Z1TV/s46EkqTU8z2JU8ueH
 3P7/2dMPDO3z0q54hf+jEOFAwit6FUr7a6g373hvmFd9mlg==
X-Received: by 2002:a05:600c:4f81:b0:475:dd9d:297b with SMTP id
 5b1f17b1804b1-475dd9d29bamr60957125e9.33.1761574246238; 
 Mon, 27 Oct 2025 07:10:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3SqSLyo1/s8LqFWmTXeRXvZfKYGXeEhhZl3IzgS5MYitrxROYcZW4vVJ1esvxNhMghPMeLA==
X-Received: by 2002:a05:600c:4f81:b0:475:dd9d:297b with SMTP id
 5b1f17b1804b1-475dd9d29bamr60956555e9.33.1761574245714; 
 Mon, 27 Oct 2025 07:10:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd02cd6dsm143039245e9.2.2025.10.27.07.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 07:10:45 -0700 (PDT)
Message-ID: <6a64b4a6-1913-4ed8-9c28-b567679f25ad@redhat.com>
Date: Mon, 27 Oct 2025 15:10:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/27] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-9-skolothumtho@nvidia.com>
 <7167d287-f0d0-4bb8-8750-e38e9e31df10@redhat.com>
 <CH3PR12MB7548C5CB7B9BE18AAE5492BEABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aN6r4n2F1s2ZLm9d@Asurada-Nvidia>
 <IA0PR12MB7555B6D390BC37EE85BF6D42ABFCA@IA0PR12MB7555.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA0PR12MB7555B6D390BC37EE85BF6D42ABFCA@IA0PR12MB7555.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 10/27/25 12:56 PM, Shameer Kolothum wrote:
> Hi Eric,
>
> Based on further off-list discussions, this needs some clarification.
>
>> -----Original Message-----
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: 02 October 2025 17:44
>> To: Shameer Kolothum <skolothumtho@nvidia.com>
>> Cc: eric.auger@redhat.com; qemu-arm@nongnu.org; qemu-
>> devel@nongnu.org; peter.maydell@linaro.org; Jason Gunthorpe
>> <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
>> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>> shameerkolothum@gmail.com
>> Subject: Re: [PATCH v4 08/27] hw/arm/smmuv3-accel: Add
>> set/unset_iommu_device callback
> [..]
>
>> There are a couple of things going on here:
>> 1) We should not attach directly to the S2 HWPT that eventually
>>    will be shared across vSMMU instances. In other word, an S2
>>    HWPT will not be attachable for lacking of its tie to an SMMU
>>    instance and not having a VMID at all. Instead, each vIOMMU
>>    object allocated using this S2 HWPT will hold the VMID.
> The above statement is not 100% correct as per the current kernel
> and QEMU implementation. At present, VFIO core allocates an s2
> HWPT when IOMMU_HWPT_ALLOC_NEST_PARENT flag is set and
> attaches to it. 
>
> In the set_iommu_device () path, we use this s2 HWPT id to create a 
> vIOMMU and pre-allocate bypass and abort IOMMU_DOMAIN_NESTED
> HWPTs, which are ready to be attached if required.
those are s1 ones (bypass and abort) , right?
>
> On unset_iommu_device() path, we attach back to the s2 HWPT as it
> does today.
OK
>  
>> 2) A device cannot attach to a vIOMMU directly but has to attach
>>    through a proxy nested HWPT (IOMMU_DOMAIN_NESTED). To attach
>>    to an IOMMU_DOMAIN_NESTED, a vDEVICE must be allocated with a
>>    given vSID.
> Also, it became clear that we need to relax the above restriction and allow
> attaching proxy nested HWPTs without requiring a vDEVICE. This is necessary
> to handle cases where the SMMUv3 operates in global bypass or abort modes,
> as controlled by the GBPA register, which do not have any associated devices.
>
> Please see Nicolin’s kernel patch [0] that introduces this relaxation.
>
> I’ve updated this QEMU series accordingly. SMMUv3 GBPA based HWPT will
> now be attached during both reset() and GBPA update paths.

OK

Thank you for the update

Eric
>
> The commit log and documentation will also be updated to reflect above
> change.
>
> Thanks,
> Shameer
> [0] https://lore.kernel.org/linux-iommu/20251024040551.1711281-1-nicolinc@nvidia.com/


