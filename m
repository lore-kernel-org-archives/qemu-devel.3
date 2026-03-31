Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64627FF60D8
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7TKc-0004EG-A0; Tue, 31 Mar 2026 03:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w7TKU-0004Ch-Qp
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 03:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w7TKS-0003tb-RB
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 03:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774941359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wyLQSRoOg40vd0RIw/y8gAbzJDCk6muMGrPXcIuU42w=;
 b=bzpUQ3S1vV9tnupHDSHf+Gy6Kpneif7Y7HXPbDj60b6PXwrQhMe9tlxgWFEhIwDeFPPnVa
 Vpor4SU5+oCEQ8zosWFDtaqoEFNvMcIOdW9VfWgboy076tb04pbA2uzaIK7uNbnBPmaMOb
 Ccqw2C91aWJmSfKbO5TIui2j6hCx3+Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-83TDfgSmOdWEg4ZSKerGcw-1; Tue, 31 Mar 2026 03:15:57 -0400
X-MC-Unique: 83TDfgSmOdWEg4ZSKerGcw-1
X-Mimecast-MFC-AGG-ID: 83TDfgSmOdWEg4ZSKerGcw_1774941357
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d0c06c232so265197f8f.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 00:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774941356; x=1775546156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wyLQSRoOg40vd0RIw/y8gAbzJDCk6muMGrPXcIuU42w=;
 b=eaOxZ40pntFvjKZI7HOG3JPDQM0O8k94MV+waCmXUPx9mz+SNUatHAvmJ7dHre3Pzi
 qWP9pzfHm7IE5IFY9dLs/vJSr/v1hAaRlxEm3ci0pT9ANYJrsVe1zKJl86l4kdST0J1R
 YDJgDIdXNvj2mTb9MCDqZxTz0ZJgsHpmoz0trYNrnOSv4LYB0hCv2L+kbSYEDA4MGWuI
 M8RikDSBKD9g1Fqrs4N2KmX+09+9tecINZPb5AJQAVqw45dkcTCI7YWqr4IsxWj0oTTI
 Sy+4gYCP1BdJzBXN/TjacaqM8Rzj7TjIhfKMpi5eln1Qrf6CGP2JcM0m6csicVx4CAu2
 oqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774941356; x=1775546156;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wyLQSRoOg40vd0RIw/y8gAbzJDCk6muMGrPXcIuU42w=;
 b=mna8T2ZRpZGrpBGwS+6jLpYUPMZyFFjo7myL1Zth8OdEXK4lpf16PQ3vwxb20ttGHm
 76+nCk5EzQoJRXTgWi1Iox+2vycQPtJ1pHM35EOFtXD2mKIvtIIBTC0tzV1tzt6x58dc
 bjVSuD2Tk6YSq3XO2NQgQc3/79nvuA/s3PdAqb1ODRHus0wnzxb0adBOzvJUxeJ5t0jx
 myGKBv73zyd8Ki4Yg55DaTkXJ3JEnn9lWjhbpnInDACpofrDmWlnSANpSE6vQ5g5KvYE
 KVbIuMCfYw9YqtgCRBTTYezFx536Dzt1OB7m91uvp+2PfdSBQADF6whw6jofbctel1oK
 jwuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkdG7vk3BuDd+NNkSFCGYJeMimq6hKmXMDZe8XyErZYncMTPL5dPNwUkzC0Zy4m70wmzy84EQpWV2s@nongnu.org
X-Gm-Message-State: AOJu0Yy32fnZlx20DjJs7nC1QKjJu5kvbBvEfM7WIrgsakYzbOJPICQj
 RSmvTZjuF75FzOVTaZ8IhYwWzbXUgPuKFtO9TzU6t/JV9U1EyjX0Vf3u9W1AyrsdyN03jjRNknE
 YlZLmq4g4xJmyPzEUJCPSnwEXORnhut8mNMk0MtQyPEyMLPwnl+Vr1w10
X-Gm-Gg: ATEYQzx+XqqbjKx9wXD17Nnixvxc1/ckYBnGKLDAtZ09l5qFidw/2qRjIkLweId7f0v
 NIimYa8yAAqEEfcquRr7cv07eXUkrXEOSXxA9ONZ/i+MTJGKV+cAyAakBEMl3TXvSyK1PZ9pkPr
 V8f3EvgGWAXFyAYEeElROGsiLnTYADiXAZhVT31qdgC90wyIDlhSZxQM8NNydp3913Dva7GZikw
 XdfZqEK9zU5b7PKd+nHh+UE+3tx4DGyZNVDVTM2s9vZOTdk9ZSWsOj7fqCZ0Zkzm81ekMDNxVLB
 HXR9DQTZssHiYDjoTguFYgwrr7MnZTEV+6S3CPxkyA3ciBk+X2/4j3IXWVX6m2qm9S34XpTn9Tm
 lV6VDy2ZrDbLq29NznoEf2iCxYLOXZUdD2SHwUTtmI0eVpGUR38cBSxxiUGNv
X-Received: by 2002:a05:6000:208a:b0:439:a95b:3c43 with SMTP id
 ffacd0b85a97d-43b9e9e92e7mr25815703f8f.21.1774941356468; 
 Tue, 31 Mar 2026 00:15:56 -0700 (PDT)
X-Received: by 2002:a05:6000:208a:b0:439:a95b:3c43 with SMTP id
 ffacd0b85a97d-43b9e9e92e7mr25815658f8f.21.1774941355987; 
 Tue, 31 Mar 2026 00:15:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf245ebafsm23734351f8f.21.2026.03.31.00.15.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 00:15:55 -0700 (PDT)
Message-ID: <516a1c81-d850-40b9-8a29-e45495850195@redhat.com>
Date: Tue, 31 Mar 2026 09:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex@shazbot.org" <alex@shazbot.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Hao, Xudong" <xudong.hao@intel.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-3-zhenzhong.duan@intel.com>
 <13a43ce3-3afc-4308-8fb7-fc0441fef3d2@redhat.com>
 <IA3PR11MB91366A2F88EBDE4032A6DE8A9253A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA3PR11MB91366A2F88EBDE4032A6DE8A9253A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/31/26 07:31, Duan, Zhenzhong wrote:
> Hi
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Monday, March 30, 2026 8:43 PM
>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; qemu-devel@nongnu.org
>> Cc: alex@shazbot.org; eric.auger@redhat.com; mst@redhat.com;
>> jasowang@redhat.com; jgg@nvidia.com; nicolinc@nvidia.com;
>> skolothumtho@nvidia.com; joao.m.martins@oracle.com; clement.mathieu--
>> drif@bull.com; Tian, Kevin <kevin.tian@intel.com>; Liu, Yi L <yi.l.liu@intel.com>;
>> Hao, Xudong <xudong.hao@intel.com>; qemu-arm@nongnu.org
>> Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
>> support pasid
>>
>> Zhenzhong
>>
>> On 3/26/26 10:11, Zhenzhong Duan wrote:
>>> Same for the two wrappers and their call sites.
>>>
>>> Suggested-by: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
>>> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>>> ---
>>>    include/system/iommufd.h    | 16 +++++++++++-----
>>>    backends/iommufd.c          |  9 +++++----
>>>    hw/arm/smmuv3-accel.c       | 12 ++++++++----
>>>    hw/i386/intel_iommu_accel.c |  8 +++++---
>>>    hw/vfio/iommufd.c           | 10 +++++-----
>>>    5 files changed, 34 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>>> index 7062944fe6..45a9e87cb0 100644
>>> --- a/include/system/iommufd.h
>>> +++ b/include/system/iommufd.h
>>> @@ -138,14 +138,16 @@ struct HostIOMMUDeviceIOMMUFDClass {
>>>         *
>>>         * @idev: host IOMMU device backed by IOMMUFD backend.
>>>         *
>>> +     * @pasid: target pasid of attach.
>>> +     *
>>>         * @hwpt_id: ID of IOMMUFD hardware page table.
>>>         *
>>>         * @errp: pass an Error out when attachment fails.
>>>         *
>>>         * Returns: true on success, false on failure.
>>>         */
>>> -    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t hwpt_id,
>>> -                        Error **errp);
>>> +    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t pasid,
>>> +                        uint32_t hwpt_id, Error **errp);
>>>        /**
>>>         * @detach_hwpt: detach host IOMMU device from IOMMUFD hardware
>> page table.
>>>         * VFIO and VDPA device can have different implementation.
>>> @@ -154,15 +156,19 @@ struct HostIOMMUDeviceIOMMUFDClass {
>>>         *
>>>         * @idev: host IOMMU device backed by IOMMUFD backend.
>>>         *
>>> +     * @pasid: target pasid of detach.
>>> +     *
>>>         * @errp: pass an Error out when attachment fails.
>>>         *
>>>         * Returns: true on success, false on failure.
>>>         */
>>> -    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, Error **errp);
>>> +    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t pasid,
>>> +                        Error **errp);
>>>    };
>>>
>>>    bool
>> host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>>> -                                           uint32_t hwpt_id, Error **errp);
>>> -bool
>> host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>>> +                                           uint32_t pasid, uint32_t hwpt_id,
>>>                                               Error **errp);
>>> +bool
>> host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>>> +                                           uint32_t pasid, Error **errp);
>>>    #endif
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index e1fee16acf..ab612e4874 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -539,23 +539,24 @@ bool
>> iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
>>>    }
>>>
>>>    bool
>> host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>>> -                                           uint32_t hwpt_id, Error **errp)
>>> +                                           uint32_t pasid, uint32_t hwpt_id,
>>> +                                           Error **errp)
>>>    {
>>>        HostIOMMUDeviceIOMMUFDClass *idevc =
>>>            HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
>>
>>
>> For consistency with the rest of the code, I would rename all the
>> idev and idevc variables, to hiod and hiodc.
> 
> We have used hiod and hiodc for the base HostIOMMUDevice type:
> 
> HostIOMMUDevice *hiod;
> HostIOMMUDeviceClass *hiodc;
> 
> To avoid conflict, what about hiodi and hiodic for HostIOMMUDeviceIOMMUFD type?
> 
fine with me.

Thanks,

C.


