Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FB7FCC9D7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 07:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzrjV-0000Hk-IY; Tue, 10 Mar 2026 03:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vzrjM-0000Gb-B0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 03:42:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vzrjG-0000bA-OB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 03:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773128528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yTYscQ1dk4rwUFiSRxH1bDa4BpsdA4XWcuhVNfNZCLM=;
 b=cymdquSU3BPUM4YZbn5NkL2brewCexFZ7IaKSR9ehwH1n6CnJvNuca0GDp6t28yAbesrHd
 n5tfrH2E9t+LmKbDz8R0crrf1OM/VzX5p+wAyyWm8WsRlEjuAg3dndoJQXkasPySiP9jum
 0pPSiuccfgVk6yxrD6GIk4ayxN9Iu+s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-qARmv8odNCeHGwT5XiozVg-1; Tue, 10 Mar 2026 03:42:07 -0400
X-MC-Unique: qARmv8odNCeHGwT5XiozVg-1
X-Mimecast-MFC-AGG-ID: qARmv8odNCeHGwT5XiozVg_1773128526
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48531e8ae62so15477775e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 00:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773128526; x=1773733326; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yTYscQ1dk4rwUFiSRxH1bDa4BpsdA4XWcuhVNfNZCLM=;
 b=Qvzq7tYINm0qjcYhEcWP4DyeMVcYdxCAf0lj7QpWgV0MnGqE9UrMYHA4/k7WgpKh1L
 5RpUlubRT6o7OVfwVh4HWizW2NKAIl28UtubXROo+TMRmSWidjwwTyNyJDXwz6PwruYk
 U/pFY3ikxh9D717Svplx7Efc4gUYPPMPRu4L/zVFSW7/bPCaHFO5B7yQP362eJaHmHfg
 e0ybHlTZhMDFsSLYhX/u5F4ojtZ/QI/VcUP7Yu7zo7LjI8FEUnp1xDefLUBvFETW0E2x
 NQU+nDaNeyvYCA9QW92/O0J2as7UmTKmV8GaiizFh8BH78TyAc0vsD/8gVzv8yDaQlS8
 7uQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773128526; x=1773733326;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTYscQ1dk4rwUFiSRxH1bDa4BpsdA4XWcuhVNfNZCLM=;
 b=OErQ49t6e8vlgAtw92HlmYSZP+oA7g2ky7huaQ/yrO69hmsO/42Un18BGgzNpSiu6P
 xXdW1H6JP08aJNkda/XOazq2X25TN2ecU82FDVjxX6FmuwMLEtDcLafi+WzsXRClJPQM
 8HrPBmhwmqeoSZUyu7wL9c9vEiJ/ybheymNicxGgONlxMoMmozuc0Z29QigrTWyExcL+
 OBspmbzhu6F4Vl2WKcmUqwh2qXOJ9e9MhUY7e+AZERAvsnQV206tDBEe4F4vam9cY9hn
 jmdE0YUEs3jiVFukwrSfY6axY7w6Hn3evimZlINo9AcAh9tXKfzfsP8MK3cHScjqcSko
 I8Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQqwerd5Xaz6lBpuFdZ1viNetiI6OmT5xuitEVVNIDRHQArJ+wDEV46sR/N0tX9oicdgt1BV8m/Inw@nongnu.org
X-Gm-Message-State: AOJu0Yxd+3d/rVxMFA+lXKnxLhEeXbjb3z7ALhiFlM3ETupuXq2propQ
 1NAPlRhacs9P2DOxiXK08Bv4uhY1JwMj7pAsH0Y6hK26gxstQJpP1BQyQ7tAewqOYiTfwNcZ00F
 LjYw+Ax8DwzzWgI8CwYn9vMYw3oYY+h0xG49SVj02zi1/zis/v8Dx/6fv
X-Gm-Gg: ATEYQzxEJty26HOvxwJkX4JnZXoJwbyz07INPRx9GobzRhJjysZwxVAZDSmYaawbndU
 Wsz6Yq6KW1ymEZ+7Dryo3H19g47smoRIWuqgJTe1Rx+RUx9ceDfI4uFPHTremwsugn0jWEVZ6Ll
 TjQikIU49kMyhOzCE8n9+Tu+bZgfigu42y6FlGd8TP0+E4MiRvoygk22QWokf9o/WtICUzwIfLj
 Ug+xHrKn7WkGKhTkDnvsgX3tM73hs6nIgYnyy3g6LeA3tY0iLGqeSrlMSB6Pv2/EGGXwv2TUx1L
 kDstMa+/Q193nkvFKVHGVDJs04C7qrn1ju3xFmzjN2ulbuuznAGZBusl5OrcT7XioVf0dO0r5aY
 xo59pFgBqqkcTjYJkmSnm/UuwxgGFdDL0NIdWiFnWJ8GubE0UD2k1mInMjJqO
X-Received: by 2002:a05:600c:4447:b0:485:34b3:8587 with SMTP id
 5b1f17b1804b1-48534b38969mr138930435e9.10.1773128525608; 
 Tue, 10 Mar 2026 00:42:05 -0700 (PDT)
X-Received: by 2002:a05:600c:4447:b0:485:34b3:8587 with SMTP id
 5b1f17b1804b1-48534b38969mr138929815e9.10.1773128525070; 
 Tue, 10 Mar 2026 00:42:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246fd127sm165950055e9.6.2026.03.10.00.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 00:42:04 -0700 (PDT)
Message-ID: <b76df308-6731-4d30-9665-34d4cb71159d@redhat.com>
Date: Tue, 10 Mar 2026 08:42:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/8] hw/arm/smmuv3-accel: Add helper for resolving
 auto parameters
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-2-nathanc@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260309192119.870186-2-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/9/26 20:21, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
> 
> Introduce smmuv3_accel_auto_finalise() to resolve properties
> that are set to 'auto' for accelerated SMMUv3. This helper
> function allows properties such as ATS, RIL, SSIDSIZE, and OAS
> support to be resolved from host IOMMU values, while avoiding
> triggering auto-resolved values for hot-plugged devices.
> 
> Auto mode requires at least one cold-plugged device to retrieve
> and finalise these properties, and we fail boot if that is not
> the case.

IIUC, QEMU will require a minimum of one PCI device if
arm-smmuv3,accel=on is passed on the command line and if the
smmu properties are set to 'auto'.

I would try to enforce this requirement in the realize routine.
Can't we leverage the supports_address_space() handler ? See :


     static bool smmuv3_accel_supports_as(PCIBus *bus, void *opaque, int devfn,
                                          Error **errp)
     {
         PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
         bool vfio_pci = false;
     
         if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
             if (vfio_pci) {
                 error_setg(errp, "vfio-pci endpoint devices without an iommufd "
                            "backend not allowed when using arm-smmuv3,accel=on");
     ...

      

> 
> Subsequent patches will make use of this helper to set the
> values when we convert the values to OnOffAuto. New auto_mode
> and auto_finalised bool members are added to SMMUv3AccelState.
> smmuv3_accel_init() will set auto_mode to true when 'auto' is
> detected for the accel SMMUv3 properties.
> smmuv3_accel_auto_finalise() will set auto_finalised to true
> after all 'auto' properties are resolved, and subsequent
> calls to this function will return early if auto_finalised is
> set to true.
> 
> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>   hw/arm/smmuv3-accel.c | 38 +++++++++++++++++++++++++++++++++-----
>   hw/arm/smmuv3-accel.h |  2 ++
>   2 files changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 17306cd04b..617629bacd 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -35,11 +35,34 @@ static int smmuv3_oas_bits(uint32_t oas)
>       return map[oas];
>   }
>   
> +static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
> +                                       struct iommu_hw_info_arm_smmuv3 *info) {
> +    SMMUv3AccelState *accel = s->s_accel;
> +
> +    /* Return if no auto for any or finalised already */
> +    if (!accel->auto_mode || accel->auto_finalised) {
> +        return;
> +    }
> +
> +    /* We can't update if device is hotplugged */
> +    if (DEVICE(pdev)->hotplugged) {
> +        warn_report("arm-smmuv3: 'auto' feature property detected, but host "
> +                    "value cannot be applied for hot-plugged device; using "
> +                    "existing value");

Please add an 'Error **' parameter instead.

> +        return;
> +    }
> +
> +    accel->auto_finalised = true;
> +}
> +
>   static bool
>   smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>                                    struct iommu_hw_info_arm_smmuv3 *info,
> +                                 PCIDevice *pdev,
>                                    Error **errp)
>   {
> +    smmuv3_accel_auto_finalise(s, pdev, info);
> +
>       /* QEMU SMMUv3 supports both linear and 2-level stream tables */
>       if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
>                   FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
> @@ -124,7 +147,7 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>   
>   static bool
>   smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
> -                           Error **errp)
> +                           PCIDevice *pdev, Error **errp)
>   {
>       struct iommu_hw_info_arm_smmuv3 info;
>       uint32_t data_type;
> @@ -142,7 +165,7 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>           return false;
>       }
>   
> -    if (!smmuv3_accel_check_hw_compatible(s, &info, errp)) {
> +    if (!smmuv3_accel_check_hw_compatible(s, &info, pdev, errp)) {
>           return false;
>       }
>       return true;
> @@ -595,6 +618,7 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>       SMMUv3State *s = ARM_SMMUV3(bs);
>       SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
>       SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
>   
>       if (!idev) {
>           return true;
> @@ -613,7 +637,7 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>        * Check the host SMMUv3 associated with the dev is compatible with the
>        * QEMU SMMUv3 accel.
>        */
> -    if (!smmuv3_accel_hw_compatible(s, idev, errp)) {
> +    if (!smmuv3_accel_hw_compatible(s, idev, pdev, errp)) {
>           return false;
>       }
>   
> @@ -867,8 +891,12 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
>   
>   void smmuv3_accel_reset(SMMUv3State *s)
>   {
> -     /* Attach a HWPT based on GBPA reset value */
> -     smmuv3_accel_attach_gbpa_hwpt(s, NULL);
> +    if (s->s_accel && s->s_accel->auto_mode && !s->s_accel->auto_finalised) {
> +        error_report("AUTO mode specified but properties not finalised.");

This is not a very friendly message for the user.


> +        exit(1);

QEMU should not exit in the reset phase. Can this check be done during
the realize stage ?

Thanks,

C.

> +    }
> +    /* Attach a HWPT based on GBPA reset value */
> +    smmuv3_accel_attach_gbpa_hwpt(s, NULL);
>   }
>   
>   static void smmuv3_accel_as_init(SMMUv3State *s)
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index dba6c71de5..3c1cd55714 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -26,6 +26,8 @@ typedef struct SMMUv3AccelState {
>       uint32_t bypass_hwpt_id;
>       uint32_t abort_hwpt_id;
>       QLIST_HEAD(, SMMUv3AccelDevice) device_list;
> +    bool auto_mode;
> +    bool auto_finalised;
>   } SMMUv3AccelState;
>   
>   typedef struct SMMUS1Hwpt {


