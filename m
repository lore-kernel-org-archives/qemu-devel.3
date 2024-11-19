Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B50D6007E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 08:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDJQn-0001km-IQ; Tue, 19 Nov 2024 03:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tDJQl-0001kG-IL
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 03:17:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tDJQj-0000RL-Cg
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 03:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732004267;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zjyO/ZAFSLWpzWsLEwOawT5J5qw9RFsT6JMYjgspwY=;
 b=KzfGys3HBcPRKCEJhW86w+dvXDoDTIGPKd1kip50qQQv4l/0VE3Xf2C2w7wruTfFkizZOx
 q+b+WtpSx36v3DNJOIB75YY2XFqC4pbfzKJgg3RC/lCh8OQgbtNOmK0hgapysNNV3aIxje
 HaOw7gYErbqvXIbdJkp22+zcIjXORU4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-BxYlpX_tMByAn6kM8_MeaA-1; Tue, 19 Nov 2024 03:17:45 -0500
X-MC-Unique: BxYlpX_tMByAn6kM8_MeaA-1
X-Mimecast-MFC-AGG-ID: BxYlpX_tMByAn6kM8_MeaA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3822ebe9321so2228637f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 00:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732004264; x=1732609064;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+zjyO/ZAFSLWpzWsLEwOawT5J5qw9RFsT6JMYjgspwY=;
 b=houSDsXYOo64YU25D1JGggccn/wn7JtFg2k0upKLsGMU7dKqhoIOW1WePGOdxJ/NsE
 y5HL4rq9sXYZe51lQkn9VRO+vwq+5cET6Udw7uw/PtCZ7UqSv8W4REkeMsCHl32gdBrR
 nC8Ez0iKOJfebfm47slTku+ncatx00Qw0WmJjmhZv6gmgRSmVs9pIrbY+JuoSEQOz+Ya
 t3iTaTFFy6IrXPW2ho0lUs7NPw+LsjkWMaS/GzsXSDfWt/q2ZS1A1P4nrSg1xBRGtiyZ
 jS9cicIv+9UnFWnwd2E9t7BOfF3SiQ6xa/r/KCo1rNhpSuMdhMmdw5epwdtQVQ0fpQv0
 QaBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnMCycUaH90W2BtA6OgXrqJIvOTQZDDYHd4rFIp35P4aSZ+KbUxdhWvnVTmDVn4ep20xs+2BtYUlVk@nongnu.org
X-Gm-Message-State: AOJu0Yws41wY6tkT9ZZEQ7FtEELy9nE6wZP9YEHPGa5FE5a7pLN/2Lff
 8iTmynFyHyiJWPHP3LKqFABpqwnamuIicyJBtBwK0NbA1X4Pc8Lbr1G+oZvm/M7o3K2jtPl594P
 vWExSCLGx9tjOv0y3riY4oQgFOkNfqIMyoDqkjCAOjihkCOzxM+Ry
X-Received: by 2002:a05:6000:1846:b0:382:49f9:74bc with SMTP id
 ffacd0b85a97d-38249f977cbmr4134816f8f.41.1732004264362; 
 Tue, 19 Nov 2024 00:17:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4KpdWuWhbWjriFNCn37+OpacMtZDX4WGY+o7K6VKE8Ch0bq0cTiqI0L9VUE3INAVWF8E+Aw==
X-Received: by 2002:a05:6000:1846:b0:382:49f9:74bc with SMTP id
 ffacd0b85a97d-38249f977cbmr4134793f8f.41.1732004264016; 
 Tue, 19 Nov 2024 00:17:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3824b28ef5fsm3164566f8f.5.2024.11.19.00.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 00:17:43 -0800 (PST)
Message-ID: <95d39240-f2e2-4427-a822-380e22783279@redhat.com>
Date: Tue, 19 Nov 2024 09:17:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Mostafa Saleh <smostafa@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Moritz Fischer <mdf@kernel.org>, Michael Shavit <mshavit@google.com>,
 Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "arighi@nvidia.com" <arighi@nvidia.com>, "ianm@nvidia.com"
 <ianm@nvidia.com>, "jan@nvidia.com" <jan@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, Don Dutile <ddutile@redhat.com>
References: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
 <1845a6b8-5214-4379-85f4-3d36b61059dd@redhat.com>
 <Zy0jiPItu8A3wNTL@Asurada-Nvidia>
 <e36a1c1c-c880-4c64-82f9-34d55a04bd00@redhat.com>
 <SJ0PR11MB67448860487317755CCCF76192202@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67448860487317755CCCF76192202@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Hi Zhenzhong,

On 11/19/24 08:07, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Tuesday, November 19, 2024 2:00 AM
>> Subject: Re: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
>>
>> Hi Nicolin,
>>
>> On 11/7/24 21:31, Nicolin Chen wrote:
>>> Hi Eric,
>>>
>>> On Thu, Nov 07, 2024 at 12:11:05PM +0100, Eric Auger wrote:
>>>> On 11/1/24 05:09, Nicolin Chen wrote:
>>>>> Hi,
>>>>>
>>>>> This is a continued discussion following previous month's:
>>>>> https://lore.kernel.org/qemu-devel/Zvr%2Fbf7KgLN1cjOl@Asurada-Nvidia/
>>>>>
>>>>> Kernel changes are getting closer to merge, as Jason's planning to
>>>>> take vIOMMU series and smmuv3_nesting series into the iommufd tree:
>>>>> https://lore.kernel.org/all/cover.1730313494.git.nicolinc@nvidia.com/
>>>>> https://lore.kernel.org/all/cover.1730313494.git.nicolinc@nvidia.com/
>>>>> https://lore.kernel.org/all/0-v4-9e99b76f3518+3a8-
>> smmuv3_nesting_jgg@nvidia.com/
>>>>> So, I think it's probably a good time to align with each others and
>>>>> talk about kicking off some QEMU upstream work in the month ahead.
>>>>>
>>>>> @Shameer,
>>>>> Do you have some update on the pluggable smmuv3 module?
>>>>>
>>>>> Updates on my side:
>>>>> 1) I have kept uAPI updated to the latest version and verified too.
>>>>>    There should be some polishing changes depending on how the basic
>>>>>    nesting infrastructure would look like from Intel/Duan's work.
>>>>> 2) I got some help from NVIDIA folks for the libvirt task. And they
>>>>>    have done some drafting and are now verifying the PCI topology
>>>>>    with "iommu=none".
>>>>>
>>>>> Once the pluggable smmuv3 module is ready to test, we will make some
>>>>> change to libvirt for that and drop the auto-assigning patches from
>>>>> the VIRT code, so as to converge for a libvirt+QEMU test.
>>>>>
>>>>> FWIW, Robin requested a different solution for MSI mapping [1], v.s.
>>>>> the RMR one that we have been using since Eric's work. I drafted a
>>>>> few VFIO/IOMMUFD patches for that, yet paused for getting the vIOMMU
>>>>> series merged to this kernel cycle. I plan to continue in Nov/Dec.
>>>>> So, for the near term we will continue with the RMR solution, until
>>>>> we have something solid later.
>>>>>
>>>>> [1] https://lore.kernel.org/linux-iommu/ZrVN05VylFq8lK4q@Asurada-Nvidia/
>>>> At Red Hat we may find some cycles to resume working on the QEMU
>>>> integration. Please can you sketch some tasks we could carry out in
>>>> coordination with you and Shameer? Adding Don in the loop.
>>> That is great!
>>>
>>> So, given that Shameer is working on pluggable module part and we
>>> have folks working on libvirt. I think the only big thing here is
>>> the SMMUv3 series itself. Please refer to the changes in the link:
>>>  - cover-letter: Add HW accelerated nesting support for arm SMMUv3
>>>  - https://github.com/nicolinc/qemu/commits/wip/for_smmuv3_nesting-v4/
>> Looking at your branch I see the following series (marked with cover-letter)
>> *
>>
>>  *
>>
>>    cover-letter: Add RMR WAR for MSI mappings (based on former RMR flat
>>    mapping and not related to *[PATCH RFCv1 0/7] vfio: Allow userspace
>>    to specify the address for each MSI vector
>>    <https://lore.kernel.org/kvm/cover.1731130093.git.nicolinc@nvidia.com/#r>
>>    I guess)*
>>
>>  *
>>
>>    cover-letter: hw/arm/virt: Add multiple nested SMMUs (Nicolin ->
>>    Shameer)
>>
>>  *
>>
>>    cover-letter: Add HW accelerated nesting support for arm SMMUv3
>>    (Nicolin)
>>
>>  *
>>
>>    cover-letter: Add VIOMMU infrastructure support (Nicolin)
>>
>>  *
>>
>>    cover-letter: intel_iommu: Enable stage-1 translation for
>>    passthrough device (Zhenzhong)
>>
>>  *
>>
>>    cover-letter: intel_iommu: Enable stage-1 translation for emulated
>>    device (Zhenzhong)
>>
>> The last one is covered by *[PATCH v5 00/20] intel_iommu: Enable stage-1
>> translation for emulated device
>> <https://lore.kernel.org/all/20241111083457.2090664-1-
>> zhenzhong.duan@intel.com/#r>
>> *
>>
>> *I see there is a reference to *"Enable stage-1 translation for
>> passthrough device" series but has it been posted for review? Adding
>> Zhenzhong in copy.
> There is an RFCv1 posted upstream which is a combination of
> " intel_iommu: Enable stage-1 translation for emulated device" and
> " intel_iommu: Enable stage-1 translation for passthrough device".
> Link: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02740.html
>
> If you means the split version, not sent yet. Plan it after the series about
> emulated device is accepted.
OK thank you very much for the link and confirmation.

Eric
>
> Thanks
> Zhenzhong
>


