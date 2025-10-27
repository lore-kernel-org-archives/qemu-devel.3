Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9838CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 17:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQai-0006W2-F0; Mon, 27 Oct 2025 13:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDQaG-0006DI-5y
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 13:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDQa6-0001qC-P3
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 13:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761584428;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFyGEEJsv/btQlGzcO53SOtrSj8HXWlXlL90oNywvTo=;
 b=FzFhMrnTolt1ymxzFxR8nJTW6UzmHguDgBNH8whcNDpHwX6eX2zsE4zywgdMJc+A8WIV5A
 FmCgvLa+Whvwb8KJVb1lDQzU3R4x0oOtfER+tpDyJLfP29ZYSfkHhFQyI/vwtYp08bmLYV
 vXOElvm6al5mEadObTvyaj5WD2ti+g0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-bYtsTKcUMJCX9UIGaWVuAQ-1; Mon, 27 Oct 2025 13:00:25 -0400
X-MC-Unique: bYtsTKcUMJCX9UIGaWVuAQ-1
X-Mimecast-MFC-AGG-ID: bYtsTKcUMJCX9UIGaWVuAQ_1761584424
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-428566218c6so2225936f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 10:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761584423; x=1762189223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PFyGEEJsv/btQlGzcO53SOtrSj8HXWlXlL90oNywvTo=;
 b=wYIC1Zfjy8NpIkLznUBMxCipVT6nx+dlYz5vMpN7PJTTM3Ep5L8NjIpQRJNbbhgEU0
 /yZxmlF7GZ+yxIew24msKUDkO/PiAos8Ue2TiTa0IBoK/sQakuObPjdicwsNYK/Y/Vlu
 7fyIvXCEtWOOl0belnL2m2MjrHaNgYDiOL6pA1wj56kqwkdYnUKkbOZFfQL2Xldt3d5j
 sXcfFpFoJEMigs1e22nSoNxRPbluw7ejYcCB7ocydBkXFsmFRZSgWXUXRL9WNI2hQzAM
 viaj/kTEnK4zifOf8bZgUxWQZvH26xW3ZiGJ7W0KRxrttDpBTDAgfWGrDLwrfId9Febw
 oIzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP4cXpx8KrVq1fpnXQGJRadGR3Utfel5zH5HTdGJWXS0Y0teE8OY1VH0nagJWm6GRDqd8zit9fJ4oz@nongnu.org
X-Gm-Message-State: AOJu0YwP3kZPvXBdee880WLFTo0IfTb+qSVrmrJlLwusNkAR+S5Iut3G
 ZlfTGjCQuNmG/A/FBtCnGeBlIfYcxLZw8VgpPCEBFGnAS6mbnKnBePEqDAtzaVjvnbYDUGCNrNh
 KfMD60d73zoeyzu1XD9qZ4gDJquDJ2JMBMjsiEAD2a9/BFRmRoF1mYBI4Q1GRttNm
X-Gm-Gg: ASbGncusx8srAZXp4m5itO4hw87ynGWP48O7dxTxiobd/eQ32FqPdbbD9gG/hM1ISZv
 QlaeHp5gEctD7j2w/zZcBEAewvDJm8zPoD7MXBi046QtWkoMTALVBLVKxclpVasBAr2U7aijwbx
 bfEO+79jaLKh6KbTpyHC8budSCg3opQmWGCaJ0n7yaheXVlS2ZPoFY6vpIOyeoP5YfYA5gxqaTU
 DNeX0kqfAMUrQBQMQ9311gMClXGXK1qREDcdSwzu/lcD1rmM/wb/jbFO0Picvry5R8hKcU2R3X8
 KPAUTM4CT7Aoyn+/R80KRNbIcxBrNuX+JhzEq93K5i6Wry/fKuvBVeva3FoMVdaWLUAX8RrqJXZ
 C46ynaW5rA3pvcubDfjpGlxv/hVvLd+tas3oMZnYTOaPdtQ==
X-Received: by 2002:a05:600d:4388:b0:46e:1d8d:cfa2 with SMTP id
 5b1f17b1804b1-4771840b04bmr203205e9.20.1761584423471; 
 Mon, 27 Oct 2025 10:00:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElWgmW0e5JBE0sEZI66IzLDiupXsMZ6Oys+FZPDGRcAWQUoe0TW6guVHlXglWFkdB3GMnmiw==
X-Received: by 2002:a05:600d:4388:b0:46e:1d8d:cfa2 with SMTP id
 5b1f17b1804b1-4771840b04bmr202855e9.20.1761584423011; 
 Mon, 27 Oct 2025 10:00:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4783b8sm147111875e9.15.2025.10.27.10.00.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 10:00:22 -0700 (PDT)
Message-ID: <b620c85a-973d-4bf5-a53c-4c2b5962281e@redhat.com>
Date: Mon, 27 Oct 2025 18:00:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/27] backends/iommufd: Retrieve PASID width from
 iommufd_backend_get_device_info()
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 jgg@nvidia.com, nicolinc@nvidia.com, ddutile@redhat.com,
 berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com,
 smostafa@google.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 shameerkolothum@gmail.com
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-25-skolothumtho@nvidia.com>
 <20251001145006.00001837@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251001145006.00001837@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/1/25 3:50 PM, Jonathan Cameron wrote:
> On Mon, 29 Sep 2025 14:36:40 +0100
> Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>
> Bring the bit of the description in the title down here as well.
> Depending on what tools people use for browsing git it might
> end up in very different places on their screen.
+1

Eric
>
>> And store it in HostIOMMUDeviceCaps for later use.
>>
>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Trivial comment inline.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
>> ---
>>  backends/iommufd.c                 | 6 +++++-
>>  hw/arm/smmuv3-accel.c              | 3 ++-
>>  hw/vfio/iommufd.c                  | 7 +++++--
>>  include/system/host_iommu_device.h | 2 ++
>>  include/system/iommufd.h           | 3 ++-
>>  5 files changed, 16 insertions(+), 5 deletions(-)
> ...
>
>> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
>> index ab849a4a82..c6a2a3899a 100644
>> --- a/include/system/host_iommu_device.h
>> +++ b/include/system/host_iommu_device.h
>> @@ -29,6 +29,7 @@ typedef union VendorCaps {
>>   *
>>   * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
>>   *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
> Blank line here to match local style. 
>
>> + * @max_pasid_log2: width of PASIDs supported by host IOMMU device
>>   *
>>   * @vendor_caps: host platform IOMMU vendor specific capabilities (e.g. on
>>   *               IOMMUFD this represents a user-space buffer filled by kernel
>> @@ -37,6 +38,7 @@ typedef union VendorCaps {
>>  typedef struct HostIOMMUDeviceCaps {
>>      uint32_t type;
>>      uint64_t hw_caps;
>> +    uint8_t max_pasid_log2;
>>      VendorCaps vendor_caps;
>>  } HostIOMMUDeviceCaps;
>>  #endif
>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>> index e852193f35..d3efcffc45 100644
>> --- a/include/system/iommufd.h
>> +++ b/include/system/iommufd.h
>> @@ -71,7 +71,8 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>                                hwaddr iova, ram_addr_t size);
>>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>                                       uint32_t *type, void *data, uint32_t len,
>> -                                     uint64_t *caps, Error **errp);
>> +                                     uint64_t *caps, uint8_t *pasid_log2,
>> +                                     Error **errp);
>>  bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>>                                  uint32_t pt_id, uint32_t flags,
>>                                  uint32_t data_type, uint32_t data_len,


