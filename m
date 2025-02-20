Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81813C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 18:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlBXe-0001b5-Gv; Thu, 20 Feb 2025 13:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlBXb-0001ab-Kl
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:44:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlBXa-000672-22
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740077092;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gtpgwSpX7+t0z2caFzTfcewvNLbwS43GVSHLCKl1GFE=;
 b=UHxwvRsxqTN9tGhb773baQTN76ciicFSq/04YKv2u0A0cmjJKnIMq/pDQTAeIIlOhfZV64
 VFDEtqMRSWjK349zGUxiW16XaliWpfZ1LkHE3wmp1RsbT9FQ0tGZgrW5YvdCMjQ4U7omW0
 e5bNfrxPhiOfZAKHBcYuxuQTSuXeA1M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-48PEF5IxPH6V5Hi_ymDN-A-1; Thu, 20 Feb 2025 13:44:49 -0500
X-MC-Unique: 48PEF5IxPH6V5Hi_ymDN-A-1
X-Mimecast-MFC-AGG-ID: 48PEF5IxPH6V5Hi_ymDN-A_1740077089
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4399c32efb4so10050605e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 10:44:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740077089; x=1740681889;
 h=content-transfer-encoding:in-reply-to:references:reply-to:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gtpgwSpX7+t0z2caFzTfcewvNLbwS43GVSHLCKl1GFE=;
 b=FnZCKtDMPL0Eyrl9UUYigHw5JggcTeqrUC1aCuYTxOHZiMTYgwH8QOcKkou0/cXimZ
 3KaqCcfcdHpRri8VW9NKEq898P/QGf04TJ9J9QsAGchW/YUJ65tSqNKqUe7T2N0T9Tlz
 a0y7YdnrKXPGbJRM2SYiO0KTl/i4mPbDEb8JzQYCRXFh++R6fkxnUm+ZCgxjtV2Owgsc
 akV2KIEBFQhkzA3k04gAixn1q0DTNoI4z74s9fzY3whvWHkogrKKP5XoknEpD6BUH+tF
 57TeFinfJcTyYMgdeCsNMSLTFiNSM2T+F0X0xSw0z7R12C6dC6NRYp1UTFvppYyqjM+e
 YYlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHVS2Gv/din0A4PSW7EzMONls0PHRzqEdK6dOrodL4vDe/Stw9U5wzQA+79F9v4TNRiVlCJcRvnB2w@nongnu.org
X-Gm-Message-State: AOJu0YzjGVPY6uwk/YQs7DeXrPFnYTHmVvGiZP9UDT1hOa70jdJwLQQs
 4GyNWScFNm2yPn9K5rjG6huKWqXhalJkIcCfzY73oOfkzXKc+OL6opBWiXMSnkCfyVxcZ1bIgJ8
 nSzXmp4f4xrIuhRUFdVMBWmCN+P5kB7zNd5hovwtss0LIPp4OIhM1
X-Gm-Gg: ASbGncuIW3bTx3MqIVnV/Z2r62wLJO6q+xCm7ZFeX9ERNh+6fYjPhm3a1U3mbOn4SLp
 KLrXVs40YTZ49VK8cKHkXEZg2E+G6lEWD5wln62FAQn+y9wAV6SpbOIEMFmmS2/HUDcoVO2ayrG
 RTfixG84aE1I1ZyG7MMDOIWW95UCpJL3qvSVk1m0xxEAXdtpqwiNddwSh5Qpcf96fWJgg3ibrdh
 xsk6EpIEufAWUjwYwnHux4qd/1l386ygECIvjSBVtdA8e73Dw+da3vvxm8VOw6YmoflHekDWUW6
 y9+Urao+bB6D2A3etMMzqunxbCVNbvLd7aSm4pjzgvTIAmN+e6FI
X-Received: by 2002:a05:6000:4712:b0:38f:32d5:3a92 with SMTP id
 ffacd0b85a97d-38f614b827bmr3815840f8f.12.1740077088759; 
 Thu, 20 Feb 2025 10:44:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyNX/stWXeYA489tVGT4PmADgKzDr7VB+p/aj42UA4q/RLuoLdsK5xrxXHD510hhh7d0LpQA==
X-Received: by 2002:a05:6000:4712:b0:38f:32d5:3a92 with SMTP id
 ffacd0b85a97d-38f614b827bmr3815824f8f.12.1740077088393; 
 Thu, 20 Feb 2025 10:44:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43982bcc607sm129012515e9.16.2025.02.20.10.44.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 10:44:47 -0800 (PST)
Message-ID: <6a428888-364d-4837-84f7-d6a3a3dee24f@redhat.com>
Date: Thu, 20 Feb 2025 19:44:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 06/20] host_iommu_device: Define two new
 capabilities HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-7-zhenzhong.duan@intel.com>
 <4f13004c-a6d9-4f45-938e-3fc8d49183d7@redhat.com>
In-Reply-To: <4f13004c-a6d9-4f45-938e-3fc8d49183d7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
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



On 2/20/25 7:41 PM, Eric Auger wrote:
> Hi Zhenzhong,
> 
> 
> On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  include/system/host_iommu_device.h | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
>> index df782598f2..18f8b5e5cf 100644
>> --- a/include/system/host_iommu_device.h
>> +++ b/include/system/host_iommu_device.h
>> @@ -22,10 +22,16 @@
>>   *
>>   * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
>>   *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
>> + *
>> + * @nesting: nesting page table support.
>> + *
>> + * @fs1gp: first stage(a.k.a, Stage-1) 1GB huge page support.
>>   */
>>  typedef struct HostIOMMUDeviceCaps {
>>      uint32_t type;
>>      uint64_t hw_caps;
>> +    bool nesting;
>> +    bool fs1gp;
> this looks quite vtd specific, isn't it? Shouldn't we hide this is a
> vendor specific cap struct?
>>  } HostIOMMUDeviceCaps;
>>  
>>  #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
>> @@ -122,6 +128,8 @@ struct HostIOMMUDeviceClass {
>>   */
>>  #define HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE        0
>>  #define HOST_IOMMU_DEVICE_CAP_AW_BITS           1
>> +#define HOST_IOMMU_DEVICE_CAP_NESTING           2
>> +#define HOST_IOMMU_DEVICE_CAP_FS1GP             3
>>  
>>  #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX       64
>>  #endif
> 
> Maybe you could introduce the associated implementation of
> hiod_iommufd_get_cap in this patch too?
ignore this last comment :(

Eric
> 
> Eric


