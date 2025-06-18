Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78314C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 07:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRmuN-00013I-MI; Wed, 18 Jun 2025 03:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRmuL-000136-Ke
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 03:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRmuH-00039t-J6
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 03:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750230502;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7wVHwTOPwsa3xmay7wK+GjnNl5J82FIv5kBs4qjDtIg=;
 b=Ejm+07301GXR2r7MRzXwTJ5HwcXdaio7Nsl/oux7K0p22UeySZeJAILvEa9+LziafqmrRw
 rcWBvGzvj3gxLKyJySOcetHKT0ypZpRMfh8zJxZrXHFTi1IAr3XE/gOfDE6sUb5JYh7nNI
 +O0z0uan/34yfPYwcDeAWQTMMIhEOCU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-RuAVy5GzP1myz6t6otju2w-1; Wed, 18 Jun 2025 03:08:21 -0400
X-MC-Unique: RuAVy5GzP1myz6t6otju2w-1
X-Mimecast-MFC-AGG-ID: RuAVy5GzP1myz6t6otju2w_1750230500
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450d290d542so39090085e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 00:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750230500; x=1750835300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7wVHwTOPwsa3xmay7wK+GjnNl5J82FIv5kBs4qjDtIg=;
 b=AwGPWpLygkUjTOelXRNBvE2DkkBus3oEQAo5Je5fPox22pT5HEZwBEbkXsUAxkZ2hH
 3AO9YI0qlMV20uKFVfRjZojpoh1ofZu1w90oIFvhEjFiwArOjXhpplHtffimsteI72SV
 yl3dYP0Rq4druDG8tzzEwFO0KFxJ4dHkFJo+5/gNRw5KDpSzc4SpWxTXl81QAs8WuN0T
 tmNKa3dHs2VekZei2aamBcpX9rn1gKwCugU8BW2BsQNfqajo4tZFBAFAHqhgnCA+AA6F
 5LJ5InkJJAdKi4LYSmxuiRmzTiCE8G4P13FJpLXyhIUNwPko73HDO8AczS5o0wZ1ohKh
 F8BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+8J9DdNPNVUgWO4fyi36xZAWl50ubRAPO4mYHp8LyovQjixT9uFUxR7XNj2tPaiWTODIRrBtsXsrw@nongnu.org
X-Gm-Message-State: AOJu0YxSgGJhGqAczGbJOz6ppBCKF1QSDIgIE8jtA+xE36wBRb4i5Wxt
 x77St4B3nwmUlpAOznbWAC3Ncp98qi0/1RrQASzhlH3trjNIzWjP+bCGfoxRi+XGCUEnwRGez8Z
 Pe5Oidg1M4Lnnz+wIQhLlEUBA1nXyiC7bcoLZb6osCyKOCFVCrxR7VjiU
X-Gm-Gg: ASbGncuTvi4AbfObmjrufTcFMtGb0Ke0ZQvZoG/imLu4+qDwuQBsH+O2PmNPnqvXjxQ
 eBIWvx3YcjycC4uRbv3OEfZ7czAdAF1fZ/EtwuJ6HRiymdSeb3KN4o4FikX34RnoBL8D6GzKa0o
 ASZuCgu7NHOzZHDUT713SvJNoluIGcsHP8JwZTYVu6rBv0otgGDIdWkDUdCeHr7Hbpv3oYOs7Ux
 1vMbxaTU5ahd9JF8/jqn/r4Hq4VO+ge2t+BiEHcAslm5YlbGTR+zz2JRMvIhOxutd2F56NNYllT
 TNgTsHS8SEdnbb49AKl7VY4H4tpt321wdtc6jSSplVsXV2iiuv9EOyiobMdSEC/G2MnGkA==
X-Received: by 2002:a05:600c:8b21:b0:445:1984:2479 with SMTP id
 5b1f17b1804b1-4533ca4291fmr140566395e9.5.1750230500015; 
 Wed, 18 Jun 2025 00:08:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0XprNkCHA7WZiC7oP3KG/nr+JWCnL7qQabFDnWkHTfBZZCg0IYldwmXITvXgjRsQiucWGdw==
X-Received: by 2002:a05:600c:8b21:b0:445:1984:2479 with SMTP id
 5b1f17b1804b1-4533ca4291fmr140565975e9.5.1750230499594; 
 Wed, 18 Jun 2025 00:08:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b18f96sm16150003f8f.66.2025.06.18.00.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 00:08:18 -0700 (PDT)
Message-ID: <8ae7e5d2-185f-440b-bd82-d86b44f54f92@redhat.com>
Date: Wed, 18 Jun 2025 09:08:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/15] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
 <20250606100416.346132-4-zhenzhong.duan@intel.com>
 <a8b1cf9e-260f-4659-8eac-77993ebab842@redhat.com>
 <IA3PR11MB9136D8164C170467FE8C59C89272A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA3PR11MB9136D8164C170467FE8C59C89272A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 6/18/25 4:14 AM, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v1 03/15] intel_iommu: Check for compatibility with
>> IOMMUFD backed device when x-flts=on
>>
>> Hi Zhenzhong,
>>
>> On 6/6/25 12:04 PM, Zhenzhong Duan wrote:
>>> When vIOMMU is configured x-flts=on in scalable mode, stage-1 page table
>>> is passed to host to construct nested page table. We need to check
>>> compatibility of some critical IOMMU capabilities between vIOMMU and
>>> host IOMMU to ensure guest stage-1 page table could be used by host.
>>>
>>> For instance, vIOMMU supports stage-1 1GB huge page mapping, but host
>>> does not, then this IOMMUFD backed device should be failed.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  hw/i386/intel_iommu_internal.h |  1 +
>>>  hw/i386/intel_iommu.c          | 28 ++++++++++++++++++++++++++++
>>>  2 files changed, 29 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>>> index e8b211e8b0..2cda744786 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -191,6 +191,7 @@
>>>  #define VTD_ECAP_PT                 (1ULL << 6)
>>>  #define VTD_ECAP_SC                 (1ULL << 7)
>>>  #define VTD_ECAP_MHMV               (15ULL << 20)
>>> +#define VTD_ECAP_NEST               (1ULL << 26)
>>>  #define VTD_ECAP_SRS                (1ULL << 31)
>>>  #define VTD_ECAP_PASID              (1ULL << 40)
>>>  #define VTD_ECAP_SMTS               (1ULL << 43)
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index a2f3250724..c42ef83ddc 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -39,6 +39,7 @@
>>>  #include "kvm/kvm_i386.h"
>>>  #include "migration/vmstate.h"
>>>  #include "trace.h"
>>> +#include "system/iommufd.h"
>>>
>>>  /* context entry operations */
>>>  #define VTD_CE_GET_RID2PASID(ce) \
>>> @@ -4361,6 +4362,33 @@ static bool vtd_check_hiod(IntelIOMMUState *s,
>> HostIOMMUDevice *hiod,
>>>          return true;
>>>      }
>>>
>>> +#ifdef CONFIG_IOMMUFD
>> is it requested?
> Yes, windows build needs it.
> iommu_hw_info_vtd and IOMMU_HW_INFO_TYPE_INTEL_VTD are defined in linux/iommufd.h,
which is a linux dep
> meanwhile all below check take effect only when IOMMUFD is supported.
OK. I tried to remove #imply IOMMUFD in hw/i386/Kconfig and I did not
get any error but well I did not build for Windows.

Eric
>
> Thanks

> Zhenzhong
>
>> Cheers
>>
>> Eric
>>> +    struct HostIOMMUDeviceCaps *caps = &hiod->caps;
>>> +    struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
>>> +
>>> +    /* Remaining checks are all stage-1 translation specific */
>>> +    if (!object_dynamic_cast(OBJECT(hiod),
>> TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
>>> +        error_setg(errp, "Need IOMMUFD backend when x-flts=on");
>>> +        return false;
>>> +    }
>>> +
>>> +    if (caps->type != IOMMU_HW_INFO_TYPE_INTEL_VTD) {
>>> +        error_setg(errp, "Incompatible host platform IOMMU type %d",
>>> +                   caps->type);
>>> +        return false;
>>> +    }
>>> +
>>> +    if (!(vtd->ecap_reg & VTD_ECAP_NEST)) {
>>> +        error_setg(errp, "Host IOMMU doesn't support nested translation");
>>> +        return false;
>>> +    }
>>> +
>>> +    if (s->fs1gp && !(vtd->cap_reg & VTD_CAP_FS1GP)) {
>>> +        error_setg(errp, "Stage-1 1GB huge page is unsupported by host IOMMU");
>>> +        return false;
>>> +    }
>>> +#endif
>>> +
>>>      error_setg(errp, "host device is uncompatible with stage-1 translation");
>>>      return false;
>>>  }


