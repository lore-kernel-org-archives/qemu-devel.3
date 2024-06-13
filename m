Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF4CC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHfgf-0007k9-6s; Thu, 13 Jun 2024 04:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sHfge-0007jy-7w
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sHfga-000276-Sj
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718266795;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=thlmxb1rZHYKdu9asnjkyVzXF7++vcUBHJ8DAa+qOj0=;
 b=I/uI2vL0zKF/8BjkWnOKcFIeluy5VGGF1Wt6/V7ozY0iOm9UuhgDxKHQ/zBjMUxcByuoDk
 Rv4qrBuLVTaJ6v+3mdP/c8QxWoGs3HKO09s0UaSmiX7/CERjTqjFLA9BvKOfohhY6mjgIN
 KK8z+G4M/E51uL8HvRJ2yBWPVVQuOHM=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-PUwh7KAKMtik4KnIFhZMFQ-1; Thu, 13 Jun 2024 04:19:53 -0400
X-MC-Unique: PUwh7KAKMtik4KnIFhZMFQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dfec7058deeso1456637276.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 01:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718266793; x=1718871593;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=thlmxb1rZHYKdu9asnjkyVzXF7++vcUBHJ8DAa+qOj0=;
 b=bxLLXuJNXjb4OlbGTAuyL2yBu4NZL+g28DrxJyUcaPTLnUrXYU8bkH02Ojd9bFonbU
 zVZrv1TL24Vf1W7fRxX66RcmBUmCXzc2pkwwfmELoncrNUSTu1TQeAGXRpo8vRWGa5zI
 ynYYgMdOQpOhclaucuXgxVpsuVvnPn9HyO3KNKbXWwYhBUZXK3Zm4D1+SzpaNrAQMGzo
 pHz/3+OY09zt4pKcq0KiQOMlwkA+v1RKco2lQUD3IiHTmA/GxOC61N/hX23PY4ufSpH4
 v7slTEPtoWKMM5e8+glekuSxV69QSsgUm+hQb6u0HEE9k2FOYG6muBnj/zoFtP0ArSac
 ESUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlXkB0RBwQ+SCtmA3fc9kQD+in4NMHrQm9XrFEFzzYEnLFRV1Es/rMvoItGnzZWxghExIL5TSd77G4jAutCufUR2LRi5M=
X-Gm-Message-State: AOJu0Yxgl8LTc6w1LWhlZd0P5vJmpGz5TzZj0BvVoo2oKTUrN5gt/4PD
 zRXajKOcLGFWzEdwBm7qxDME5u7ooRihUovC7QKSWVVs4iMj3GaId164I2XM17ZyQiRPRIB1ogK
 Pyr0ShIpjq24KMHsGEBAy3KvBO9YbBvH+mofBNHfvt7eVitVLTSPj
X-Received: by 2002:a25:4982:0:b0:dfb:3bc:ba57 with SMTP id
 3f1490d57ef6-dfe68e0f563mr3838901276.64.1718266793068; 
 Thu, 13 Jun 2024 01:19:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwQLdek1eTYw0cx2yZdaMD10R2KNaltM2E5YkpqRib92xMqBr1I9ZwDUlNsT06+++xRAjUgA==
X-Received: by 2002:a25:4982:0:b0:dfb:3bc:ba57 with SMTP id
 3f1490d57ef6-dfe68e0f563mr3838885276.64.1718266792680; 
 Thu, 13 Jun 2024 01:19:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5eda78csm4280416d6.106.2024.06.13.01.19.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 01:19:52 -0700 (PDT)
Message-ID: <29c1416f-48b7-445b-b41d-850223a725d1@redhat.com>
Date: Thu, 13 Jun 2024 10:19:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 3/7] HostIOMMUDevice: Introduce get_iova_ranges callback
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "yanghliu@redhat.com"
 <yanghliu@redhat.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
References: <20240607143905.765133-1-eric.auger@redhat.com>
 <20240607143905.765133-4-eric.auger@redhat.com>
 <SJ0PR11MB67446074AA4133BDE258C40392C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67446074AA4133BDE258C40392C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

On 6/11/24 05:24, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: [RFC v2 3/7] HostIOMMUDevice: Introduce get_iova_ranges
>> callback
>>
>> Introduce a new HostIOMMUDevice callback that allows to
>> retrieve the usable IOVA ranges.
>>
>> Implement this callback in the legacy VFIO and IOMMUFD VFIO
>> host iommu devices. This relies on the VFIODevice agent's
>> base container iova_ranges resource.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> include/sysemu/host_iommu_device.h |  8 ++++++++
>> hw/vfio/container.c                | 14 ++++++++++++++
>> hw/vfio/iommufd.c                  | 14 ++++++++++++++
>> 3 files changed, 36 insertions(+)
>>
>> diff --git a/include/sysemu/host_iommu_device.h
>> b/include/sysemu/host_iommu_device.h
>> index 3e5f058e7b..40e0fa13ef 100644
>> --- a/include/sysemu/host_iommu_device.h
>> +++ b/include/sysemu/host_iommu_device.h
>> @@ -80,6 +80,14 @@ struct HostIOMMUDeviceClass {
>>      * i.e., HOST_IOMMU_DEVICE_CAP_AW_BITS.
>>      */
>>     int (*get_cap)(HostIOMMUDevice *hiod, int cap, Error **errp);
>> +    /**
>> +     * @get_iova_ranges: Return the list of usable iova_ranges along with
>> +     * @hiod Host IOMMU device
>> +     *
>> +     * @hiod: handle to the host IOMMU device
>> +     * @errp: error handle
>> +     */
>> +    GList* (*get_iova_ranges)(HostIOMMUDevice *hiod, Error **errp);
> Previous I thought expose iova_ranges directly in HostIOMMUDevice::caps.iova_ranges,
> But a new callback looks better for a Glist pointer.
OK so we are aligned.
>
>> };
>>
>> /*
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index b728b978a2..edd0df6262 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -1164,12 +1164,26 @@ static int
>> hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
>>     }
>> }
>>
>> +static GList *
>> +hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
>> +{
>> +    VFIODevice *vdev = hiod->agent;
>> +    GList *l = NULL;
> g_assert(vdev)?
yes
>
>> +
>> +    if (vdev && vdev->bcontainer) {
>> +        l = g_list_copy(vdev->bcontainer->iova_ranges);
>> +    }
>> +
>> +    return l;
>> +}
>> +
>> static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
>> {
>>     HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
>>
>>     hioc->realize = hiod_legacy_vfio_realize;
>>     hioc->get_cap = hiod_legacy_vfio_get_cap;
>> +    hioc->get_iova_ranges = hiod_legacy_vfio_get_iova_ranges;
>> };
>>
>> static const TypeInfo types[] = {
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index dbdae1adbb..1706784063 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -645,11 +645,25 @@ static bool
>> hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>     return true;
>> }
>>
>> +static GList *
>> +hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error
>> **errp)
>> +{
>> +    VFIODevice *vdev = hiod->agent;
>> +    GList *l = NULL;
>> +
> Same here.
yes

Thanks

Eric
>
> Thanks
> Zhenzhong
>
>> +    if (vdev && vdev->bcontainer) {
>> +        l = g_list_copy(vdev->bcontainer->iova_ranges);
>> +    }
>> +
>> +    return l;
>> +}
>> +
>> static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
>> {
>>     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
>>
>>     hiodc->realize = hiod_iommufd_vfio_realize;
>> +    hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
>> };
>>
>> static const TypeInfo types[] = {
>> --
>> 2.41.0


