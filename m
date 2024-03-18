Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D304BC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 14:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmDuC-0001Pu-01; Mon, 18 Mar 2024 10:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmDu7-0001PN-T2
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:23:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmDu4-0000o2-2D
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710771827;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CL+eEXIhv3zhA8cEpzzRJKQ2cH3vW68BPm9wQM+b40Y=;
 b=K/Fg2FOK4CcgYf08b83THWiTiMDniRv6qescYAhkb9htKe0k4hlBAWaimk53EkRrIFQxSP
 TaoTtGqaH35mTKnd6b3GNeCma5MZqhuq3JQM/5wt3Ee0y99g8JVxF83tbpEm7R9pFWWNYw
 qv9A0XO8MCkDwdxtQeXqa1jfVJfd4P8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-ZERax6M4MMijz_NzI_GHnQ-1; Mon, 18 Mar 2024 10:23:45 -0400
X-MC-Unique: ZERax6M4MMijz_NzI_GHnQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-789eae32c8aso351528485a.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 07:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710771825; x=1711376625;
 h=content-transfer-encoding:in-reply-to:references:reply-to:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CL+eEXIhv3zhA8cEpzzRJKQ2cH3vW68BPm9wQM+b40Y=;
 b=Ztatmp0mHiy/IkJ2SyIOXjfkPjsewh3fnvYpCHO6Ts/JXlEIop2E2Hgw61V7al7xi1
 gAuvOFRGxEiKh2oEt0EG1Prs+LKCcLYZyCUkCYdjEUfRgg3GkS0D9PcN116ze5uFfHv6
 h6MyX7zRwVrivWPvATPxJOsv8NFeiqhWkR8GxNoFYvEw0aFcr8+J/VjSC8PMc6R/98dS
 4eyU77c69bqfMdLWfzw56hlqa30I8d/mGmMjAu6vhK1YeHjTffS3Ob7Ue7gs6GyDYeBX
 i353b13PWtg52QrduDFEF8BYJXnLkVUw6gRuCM8xEBAi/X1rK8cURVNop1YUPnjFvj56
 Eb3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9OCUqcMnwzgtXx4WO0fml9tLWXy7v/HvPxhQuak0bKBmZ0CpQYY7jTIIz3eGMSv5vTQHDzb46472kz4cnYzjMDZI/S98=
X-Gm-Message-State: AOJu0YxV6kW0HLsXNYk3q76Jf6OJ5XI6IGn8NLQwg+U0qs0xIERZZrT6
 +2luCZV3G0f+A77KWwpxVihdn7xmXtItNzTdpQxuEK909sDd6WO7QZe0SwT9mGjFYCO08bxeaC7
 WaF4B2DwE2qPsbUGv1Kx8VHssc6DtcWFtTpf0B4k4Kc4Z8/TKFzra
X-Received: by 2002:a05:620a:a93:b0:78a:533:208c with SMTP id
 v19-20020a05620a0a9300b0078a0533208cmr1533690qkg.15.1710771825264; 
 Mon, 18 Mar 2024 07:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvHRU/hawZPqpbXotWY4ZwmAtlBr1REdQ8NzXVqTGd3cZDnfjxCx3t1klw7Cm5EMzALkHd/Q==
X-Received: by 2002:a05:620a:a93:b0:78a:533:208c with SMTP id
 v19-20020a05620a0a9300b0078a0533208cmr1533657qkg.15.1710771824712; 
 Mon, 18 Mar 2024 07:23:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 z7-20020ae9c107000000b00789e1c94cf4sm3693189qki.113.2024.03.18.07.23.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 07:23:43 -0700 (PDT)
Message-ID: <6cb774f4-4e09-4560-95e5-917bd0668f15@redhat.com>
Date: Mon, 18 Mar 2024 15:23:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/11] vfio: Introduce host_iommu_device_create callback
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-6-zhenzhong.duan@intel.com>
 <d386b8e4-b597-492c-b0ab-4b4246906f94@redhat.com>
In-Reply-To: <d386b8e4-b597-492c-b0ab-4b4246906f94@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 3/18/24 14:52, Eric Auger wrote:
> Hi ZHenzhong,
> 
> On 2/28/24 04:58, Zhenzhong Duan wrote:
>> Introduce host_iommu_device_create callback and a wrapper for it.
>>
>> This callback is used to allocate a host iommu device instance and
>> initialize it based on type.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  include/hw/vfio/vfio-common.h         | 1 +
>>  include/hw/vfio/vfio-container-base.h | 1 +
>>  hw/vfio/common.c                      | 8 ++++++++
>>  3 files changed, 10 insertions(+)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index b6676c9f79..9fefea4b89 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -208,6 +208,7 @@ struct vfio_device_info *vfio_get_device_info(int fd);
>>  int vfio_attach_device(char *name, VFIODevice *vbasedev,
>>                         AddressSpace *as, Error **errp);
>>  void vfio_detach_device(VFIODevice *vbasedev);
>> +void host_iommu_device_create(VFIODevice *vbasedev);
>>  
>>  int vfio_kvm_device_add_fd(int fd, Error **errp);
>>  int vfio_kvm_device_del_fd(int fd, Error **errp);
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>> index b2813b0c11..dc003f6eb2 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -120,6 +120,7 @@ struct VFIOIOMMUClass {
>>      int (*attach_device)(const char *name, VFIODevice *vbasedev,
>>                           AddressSpace *as, Error **errp);
>>      void (*detach_device)(VFIODevice *vbasedev);
>> +    void (*host_iommu_device_create)(VFIODevice *vbasedev);
>>      /* migration feature */
>>      int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
>>                                     bool start);
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 059bfdc07a..41e9031c59 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1521,3 +1521,11 @@ void vfio_detach_device(VFIODevice *vbasedev)
>>      }
>>      vbasedev->bcontainer->ops->detach_device(vbasedev);
>>  }
>> +
>> +void host_iommu_device_create(VFIODevice *vbasedev)
>> +{
>> +    const VFIOIOMMUClass *ops = vbasedev->bcontainer->ops;
>> +
>> +    assert(ops->host_iommu_device_create);
> at this stage ops actual implementation do not exist yet so this will
> break the bisection

Sorry it is OK at the function only is called in
[PATCH v1 08/11] vfio/pci: Allocate and initialize HostIOMMUDevice after
attachment

Sorry for the noise

Eric
> 
> Eric
>> +    ops->host_iommu_device_create(vbasedev);
>> +}
> 


