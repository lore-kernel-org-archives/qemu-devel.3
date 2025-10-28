Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687FACCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 14:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDkyn-0006CR-UV; Tue, 28 Oct 2025 10:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDkyk-0006Bm-0N
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:47:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDkye-0005eb-F8
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761662825;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KAPpb0LtnR1RvA/wp60Chx0MPQGvSQfDtQV0r2hwlgE=;
 b=LuRESuJl4dE2RRG2BbLwNKDzqEjBN6zo59ibqyVyi7eGXGtcKhLdA6o8K0gH+2u8x/fDsI
 mY4+BMepzRN1yoBAI5qub/r5QiVWBFtj0LIsZVchy7pnDwinBnav3nySLz6aMujGqRidPF
 uA0JBwHs4Ip7qlt7vMOuWmoE8/vWMF8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-bTHyyzQ1Pq6DW8eeAURS3Q-1; Tue, 28 Oct 2025 10:47:04 -0400
X-MC-Unique: bTHyyzQ1Pq6DW8eeAURS3Q-1
X-Mimecast-MFC-AGG-ID: bTHyyzQ1Pq6DW8eeAURS3Q_1761662823
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42851b6a659so4975809f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 07:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761662823; x=1762267623;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KAPpb0LtnR1RvA/wp60Chx0MPQGvSQfDtQV0r2hwlgE=;
 b=jVQTTbaUlJI2ScJOWyywXHeXY5cQUmJOC3ARyRh/J/wR/6Ly86y8hEE6SKV9EPl8vh
 4AMaFJ2GQ4SJtjt0APEt7BFaKo5/EtTJVn4GucPZndzIiUAVhKmiSt8DqBFpO9Sp5G2r
 PDTn728YK6eTbdmuHODYg9ZNDCkXcJse+U7fyraOAFUKvMQqPduZZ4LROCvtDNAg4Bw9
 omcenx+c34itLruecrFPJnU0L/7FH7kiI6Gx+skd2MtMyhFw8dNbPcTJ6hN4VGtIlSos
 IVwxU3HpMHL9PL+qqIp2tJm3Csm65k265156cdnsodgZNqwtSPth9e19DzMwTTlV/qfR
 fZDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjPKXco6kekV7CjZH4lJX34JjVLf5CKsAK3bJs0Tvv0EPfAuMpaVPgFpEH+D4GEtSSauIoqpIekZmi@nongnu.org
X-Gm-Message-State: AOJu0YzfpEOCuRgcm/JyRwpC6Tg8U+rrh7u+ZrCHb2Nzx0oKJtSeEJiu
 EbNQtRUAop5zH5FYUsieobgWaqWVOO3CxqIvVpi4XpG2+iDLvQNkNYej+bQEk/S70C18CTpxa/U
 q8yl+oWrMHH1MvcQKZq+N+Egq0MqXKCCokCmE6DBv1qg5Gdj5MgVY7QJIJBoa8+JO
X-Gm-Gg: ASbGncvjPW0WW69iLKFqpQxE2dK8EjV+LUUpnLAgL2Bc82Vz5eOLR7aXu9FaVnWEXn9
 bBYXHrm4CBIhLhvNij0wwCK5akoYyzElicbO+6wssyAdJXyG7ySvsCXgZEEIvNUe7hMpRE3JVib
 9gtTM8i/UPleIDp0XO7Nxh9xd5k4dVyTsEHwE3gyb4q9FpGK7pmm4jDfGTbImO+xi5MLDI0wEzM
 LkWDCTNPZKecnhHIc+XVjWd0aVHSGxt+Q3+LzApKLbkM+gs4qje4fN51rjdSdYtfyMeiujg9SW9
 gHFKARCbYCSrHboYOtQOWVTSzf9iqIeOzltv93NhzSYfCkcOmK2qFVkSNHbntBBvt692COZd1IF
 6MpRMgBZkpA6bANTTUJkxjgWJszRsl+o/EUA22R6bBMdshQ==
X-Received: by 2002:a05:6000:2409:b0:427:6c4:f165 with SMTP id
 ffacd0b85a97d-429a7e7a197mr3493784f8f.35.1761662822654; 
 Tue, 28 Oct 2025 07:47:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB1q43KUHzZM+Ifb0OwiVK5B589uKw5onl8aa382D6Uh4Qb8DOOa/IHATdFOUdYRYYWIr7aw==
X-Received: by 2002:a05:6000:2409:b0:427:6c4:f165 with SMTP id
 ffacd0b85a97d-429a7e7a197mr3493753f8f.35.1761662822202; 
 Tue, 28 Oct 2025 07:47:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7b22sm20538061f8f.9.2025.10.28.07.47.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 07:47:01 -0700 (PDT)
Message-ID: <6e9d8822-36bf-457f-98f1-fe0734d78dcb@redhat.com>
Date: Tue, 28 Oct 2025 15:46:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
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
 <20250929133643.38961-23-skolothumtho@nvidia.com>
 <26f4d9b2-75be-4913-bb60-01e647a7ec83@redhat.com>
 <aP+oRLu/BYNaAPHG@Asurada-Nvidia>
 <25d22f06-69e2-4954-9bd9-f73f899fc114@redhat.com>
 <aP+xhmLCRu6y0eQm@Asurada-Nvidia> <20251028121625.GF1018328@nvidia.com>
 <9748e922-057b-4e7c-ad6b-b83f5591290a@redhat.com>
 <20251028134148.GH1018328@nvidia.com>
 <15e0d683-e524-44ed-b253-c6221585d9bd@redhat.com>
 <20251028140340.GI1018328@nvidia.com>
 <CH3PR12MB7548868B3DC111DF90364DCAABFDA@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548868B3DC111DF90364DCAABFDA@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/28/25 3:44 PM, Shameer Kolothum wrote:
>
>> -----Original Message-----
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: 28 October 2025 14:04
>> To: Eric Auger <eric.auger@redhat.com>
>> Cc: Nicolin Chen <nicolinc@nvidia.com>; Shameer Kolothum
>> <skolothumtho@nvidia.com>; qemu-arm@nongnu.org; qemu-
>> devel@nongnu.org; peter.maydell@linaro.org; ddutile@redhat.com;
>> berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
>> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>> shameerkolothum@gmail.com
>> Subject: Re: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
>>
>> On Tue, Oct 28, 2025 at 02:51:29PM +0100, Eric Auger wrote:
>>>
>>> On 10/28/25 2:41 PM, Jason Gunthorpe wrote:
>>>> On Tue, Oct 28, 2025 at 02:21:32PM +0100, Eric Auger wrote:
>>>>> On 10/28/25 1:16 PM, Jason Gunthorpe wrote:
>>>>>> On Mon, Oct 27, 2025 at 10:53:10AM -0700, Nicolin Chen wrote:
>>>>>>
>>>>>>> Hmm, that sounds a legit reason, though adding the ATS support to
>>>>>>> the emulated SMMUv3 isn't seemingly a small effort...
>>>>>> What is "emulated ATS" anyhow?
>>>>> I guess it means implementing ATS translation requests and capability to
>>>>> send ATS invalidations. something like:
>>>>>
>>>>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
>> kernel.org%2Fall%2F20250628180226.133285-1-clement.mathieu--
>> drif%40eviden.com%2F&data=05%7C02%7Cskolothumtho%40nvidia.com%
>> 7C9f9c8fc639214f54ca0808de162accab%7C43083d15727340c1b7db39efd
>> 9ccc17a%7C0%7C0%7C638972570246014005%7CUnknown%7CTWFpbGZs
>> b3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIs
>> IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=YQfzKiIcBbKj
>> kIauHU8ELDk15jclFnFcevMMRf7LHF0%3D&reserved=0
>>>> Why would you even want this? The cover letter didn't explain what the
>>>> point was.
>>> well I am just concerned about exposing ATS support to emulated EPs
>>> while we actually do not support it.
>> Sure, that shouldn't be done. There is ACPI/DT tables indicating if the
>> each device supports ATS and qemu should not be marking the emulated
>> EPs as ATS capable in the first place..
>>
>> However, there is no big work with showing EPs as ATS capable. They
>> don't implement an ATC and there is no concept of "translated address"
>> inside qemu so the only requirement to make it "work" is to just NOP
>> the ATC invalidation SMMU commands for those EPs.
> The only case where an emulated endpoint can appear with SMMUv3
> accel enabled is during a hot-plug scenario.
>
> As mentioned elsewhere in this discussion, that can be handled by propagating
> an error from the pci_device_iommu_address_space() path.
>
> I will take a look at that if this is the main concern regarding ATS.
OK thanks!

Eric
>
> Thanks,
> Shameer
>


