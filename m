Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C50CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 14:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuB23-0000uO-Vf; Thu, 04 Sep 2025 10:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuB21-0000pu-L2
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuB1r-0006Wn-JN
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756996411;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Rvd8zx5PhnwMcPMnDukUW4fhCSlh4rdnVhW9YU7UHY=;
 b=EXkUW6QD4XAMiliq32wCdEs6E15OfFv4duszjBoPnhiHq/n2bJLu7nxPD23ZDNCdXsrK3J
 f0g2XE54ubdBoM3DA+7uGuQUXQi707SPqei3VC3qbrz3B9hOf/gDnpxYjcpbxWUb4Ow4iD
 armMDzGBrcnYq2ldiEPSLqFSJGDmvdM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-kdqjIPomMz-t44YjpkjEzw-1; Thu, 04 Sep 2025 10:33:28 -0400
X-MC-Unique: kdqjIPomMz-t44YjpkjEzw-1
X-Mimecast-MFC-AGG-ID: kdqjIPomMz-t44YjpkjEzw_1756996408
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3e014bf8ebfso736353f8f.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 07:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756996407; x=1757601207;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Rvd8zx5PhnwMcPMnDukUW4fhCSlh4rdnVhW9YU7UHY=;
 b=i0AstPlGyZ4Izchz78xHbnZgvzgAaDBnD7PZZSuY50l7s+pEkYv58swWQ5vU3DQo+w
 tyQwRUmmM8P+NjIDCfwmJ7Qjuo3Vfq0NMyApsKZqoyEPiaVSOoRr6tPM9nJOSqrs7AE2
 7NVsgcF/v9Jrv9sYGpR7BibVL1tImwD8Rfh8ziKi5LZLWdcnw7iUWOrYHNWwRxaNcSnt
 /o+ZnaIzTFmx9Oa0hhF7s0wEU8AXvHoOu+8BsS66u6jszeVUMkcmjDJ7Gy1rLfFdPULw
 FixkhG2w1/h4NpdGnx85KoaFOVFT9a8sYjCXArS6Nt7NtIZX1s1X9fzZBlJi1xIACpG8
 8/jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKK5Y+mVIzQSmmClBFNI4S1HtawkBGwkd+2X4fW9wB6ar1fbDzHxA2PIGIOwskS1yrAePoZ9wEUEYK@nongnu.org
X-Gm-Message-State: AOJu0YyY7nKEiviK5UX5NOAKl2unxEfFDiSxlAb7kQdWNj3V4IPpAORV
 BfmkaOMv+o2FEh3kJKqqBw97gfCY2wUubVf3wUfhShAX0xH8ceC31S9UcdWbEZGPzf/jrK1IAlQ
 JHdFZDy03+T8Axc4wPZsDDSoTa+le3r4JzB9KvEClV3mLKlu9PZVDQSlf
X-Gm-Gg: ASbGnctsXRvn94KKccKa35rsHMAHlGiY9Y8t0SyqDBR/y1/kiQt/Y78J3ivm4eSIBFL
 QKLdSZQDdOgEI7lEMsCRINS30eoo1t+JLsE5B+c+Bq+pfPnRF6EIv/i6PnQmzG3Db8Q4GMhmuMf
 XagGHWFl004hPSk1n+xX114kd5MZaelX771D+/7azlaSVk2HQ0Hmi5JOdJUi90IS3oEYl+mrtR9
 Kaptnv3DTSk36YAgVh8xdKcp3TEar8A07XwCS1hwOZWJClpFKUt0ib5KR5Z3S1wl3L9KuL/6xb0
 CBncRKYJTQwBOZoHL1lbeCdhlVkayanbKcHWt4xFmT58Z8MLPRmbyvqGL9GAMF8nRhUB3XNq1m/
 /Eee/IT9Gob4=
X-Received: by 2002:a05:6000:178e:b0:3e0:63dc:913c with SMTP id
 ffacd0b85a97d-3e063dc9503mr2941475f8f.3.1756996407504; 
 Thu, 04 Sep 2025 07:33:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyDurDvrUNCb5ZwMrNsM56ZIrJNvFp6TmGhBfvPliakySuoUJJaGMPVK8IBrCnpCvOp7CDNA==
X-Received: by 2002:a05:6000:178e:b0:3e0:63dc:913c with SMTP id
 ffacd0b85a97d-3e063dc9503mr2941439f8f.3.1756996407000; 
 Thu, 04 Sep 2025 07:33:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34491a7fsm27152781f8f.57.2025.09.04.07.33.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Sep 2025 07:33:26 -0700 (PDT)
Message-ID: <f0473156-2e59-4467-90cc-d8315cf9063e@redhat.com>
Date: Thu, 4 Sep 2025 16:33:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, skolothumtho@nvidia.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 jgg@nvidia.com, ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, shameerkolothum@gmail.com
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-6-shameerali.kolothum.thodi@huawei.com>
 <aHU9INgBsFgvtec+@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aHU9INgBsFgvtec+@Asurada-Nvidia>
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
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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



On 7/14/25 7:23 PM, Nicolin Chen wrote:
> On Mon, Jul 14, 2025 at 04:59:31PM +0100, Shameer Kolothum wrote:
>> Also setup specific PCIIOMMUOps for accel SMMUv3 as accel
>> SMMUv3 will have different handling for those ops callbacks
>> in subsequent patches.
>>
>> The "accel" property is not yet added, so users cannot set it at this
>> point. It will be introduced in a subsequent patch once the necessary
>> support is in place.
>>
>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Overall the patch looks good to me,
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>
> with some nits:
>
>> @@ -61,7 +61,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
>>  arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
>>  arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
>>  arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
>> -arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
>> +arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
>> +arm_ss.add(when: ['CONFIG_ARM_SMMUV3', 'CONFIG_IOMMUFD'], if_true: files('smmuv3-accel.c'))
> Wondering why "arm_common_ss" is changed to "arm_ss"?
Indeed why did you need to change that?

Thanks

Eric
>
>> +static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>> +                                                PCIBus *bus, int devfn)
> There seems to be an extra space in the 2nd line.
>
>> +{
>> +    SMMUDevice *sdev = sbus->pbdev[devfn];
>> +    SMMUv3AccelDevice *accel_dev;
>> +
>> +    if (sdev) {
>> +        accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
>> +    } else {
>> +        accel_dev = g_new0(SMMUv3AccelDevice, 1);
>> +        sdev = &accel_dev->sdev;
>> +
>> +        sbus->pbdev[devfn] = sdev;
>> +        smmu_init_sdev(bs, sdev, bus, devfn);
>> +    }
> Could just:
>     if (sdev) {
>         return container_of(sdev, SMMUv3AccelDevice, sdev);
>     }
>
> Then, no extra indentations for the rest of the code.
>
>> +
>> +    return accel_dev;
>> +}
>> +
>> +static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
>> +                                              int devfn)
>> +{
>> +    SMMUState *bs = opaque;
>> +    SMMUPciBus *sbus;
>> +    SMMUv3AccelDevice *accel_dev;
>> +    SMMUDevice *sdev;
>> +
>> +    sbus = smmu_get_sbus(bs, bus);
>> +    accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
>> +    sdev = &accel_dev->sdev;
> Maybe just:
>
> +    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
> +    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
> +    SMMUDevice *sdev = &accel_dev->sdev;
>
> ?
>
>> +typedef struct SMMUv3AccelDevice {
>> +    SMMUDevice  sdev;
> Let's drop the extra space in between.
>
>> +} SMMUv3AccelDevice;
>> +
>> +#endif /* HW_ARM_SMMUV3_ACCEL_H */
>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>> index eb94623555..c459d24427 100644
>> --- a/include/hw/arm/smmu-common.h
>> +++ b/include/hw/arm/smmu-common.h
>> @@ -162,6 +162,7 @@ struct SMMUState {
>>      uint8_t bus_num;
>>      PCIBus *primary_bus;
>>      bool smmu_per_bus; /* SMMU is specific to the primary_bus */
>> +    bool accel; /* SMMU has accelerator support */
> How about:
> "SMMU is in the HW-accelerated mode for stage-1 translation"
> ?
>
> Thanks
> Nicolin
>


