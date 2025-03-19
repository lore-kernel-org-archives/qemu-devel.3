Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E874C282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 02:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tujRN-0003b1-LM; Tue, 18 Mar 2025 22:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tujRG-0003Wu-E8
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 22:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tujRE-00049f-0b
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 22:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742352346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kbgtbwPmXLQ6f9P5DYfklHc2jBXnpoeusKyUKXzea9I=;
 b=PyCQ/UldOp1tVoRwAjOl6KWGm0c7rSzhQnHXZNMLY6PoFq2BBTxfWyMggoB3Km4OiM7Nzx
 dDTRb+3TjMj6rsktJKkPvn2TpC7nVrlg85wmufUSEBROYfrUiBD9kLIW2Mqn1GOqlg09yo
 Rz40iTdDR9ENszXaaGS/2ncTUmCupj8=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-VD5U-4n3NzK3TNSl0gHMeg-1; Tue, 18 Mar 2025 22:45:44 -0400
X-MC-Unique: VD5U-4n3NzK3TNSl0gHMeg-1
X-Mimecast-MFC-AGG-ID: VD5U-4n3NzK3TNSl0gHMeg_1742352344
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-85b41b906b3so729797439f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 19:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742352344; x=1742957144;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kbgtbwPmXLQ6f9P5DYfklHc2jBXnpoeusKyUKXzea9I=;
 b=JLsiE/FhdXrrc0IMgRkgrn6yR8b19j9NnIGoMnzFms0qwB9aAD7Nl/5TH8i4MAXJTv
 HgJaNQAIevDNPbwiKR2ibL2BS1lFEWxN9MWjVuJSPK3fZPnjdD//nj8D9Z9snSk1sZ3B
 R1VgiomA9ICZeuBawbTIeZFrSr9mgKnF5n7LBywZS6bqdfj72N/I7Ulx4Na1j+TIJ4sY
 nxX6buIZe6nPyk2NSefYGWEQVPh2yFMfiSPU30T1BeFyeoD23FZQwdZCxvr75uVFqX2w
 bFnYh/wcfPL9X1jSqpb0edv8sPlHPnnwkYy+34T/zFImDur22pcsauhcxrZnoFoma3AL
 6tWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH3BGbBpi0w8v/RE1G060XjHeC+7171NJPmq96if23Jur7skpyA6lf+zQ9wcbipLvpaPGqxLyoSgip@nongnu.org
X-Gm-Message-State: AOJu0YzjGWEg5fDfBQf5TMCs3EbSvkEbE8JNEnRRbQQdeJLFnhaF1tFT
 uojjizC38ftve4zJGRagM2FoX916lv+fTP3x8BBq6Q7uZJuILotrQXefQSbHWHAesW6aJY3K0JV
 mIfAlrOlQk5ZO6V41kevw8NoHLLm+JqunXnFrOtgCvhjuBN3AgMjI
X-Gm-Gg: ASbGncvlWCZh9+i88054rMesN2LasD39xmbjnfUKj5kryYSObXidf4qUhUkqrW+O1qK
 OPa70ymFZW0QwwbG1BSCQtMj2DabrvGGOvbUi7vyLsf83XTyiVaHG8f/WEko2RR5pxR1bVZCtPJ
 jH0HEpUuLWpN0IeIDGrxmGLsns8mw40EQSd0h+9abK7lWLbbXdvtp1Z2XcclUMfE2hxPRMGF//n
 ahCwg52yVhsfvdji74wOUI6ZaynEe6JP2nyCe8HcqeCbR205wyadwZPRTvhNLTBW0tbalp1kwm4
 7jnRPrZIWZhCbs8X
X-Received: by 2002:a05:6602:3a0a:b0:85b:3e32:9afb with SMTP id
 ca18e2360f4ac-85e138a678emr154259339f.14.1742352343668; 
 Tue, 18 Mar 2025 19:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFBS7253tJjnD2/zEGjrm6mRBaZ4jJE72SANf9JYB0efkeDEfeBRAvg8j0RG3j6GEQycorDA==
X-Received: by 2002:a05:6602:3a0a:b0:85b:3e32:9afb with SMTP id
 ca18e2360f4ac-85e138a678emr154257939f.14.1742352343293; 
 Tue, 18 Mar 2025 19:45:43 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85db8777bf0sm293160339f.13.2025.03.18.19.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 19:45:42 -0700 (PDT)
Message-ID: <ee0025f3-7523-4fd3-8099-7a1dd1e7451b@redhat.com>
Date: Tue, 18 Mar 2025 22:45:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 16/20] hw/arm/smmuv3-accel: Read host SMMUv3 device
 info
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-17-shameerali.kolothum.thodi@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250311141045.66620-17-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Shameer,

Hey,


On 3/11/25 10:10 AM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Read the underlying SMMUv3 device info and set corresponding IDR
> bits. We need at least one cold-plugged vfio-pci dev associated
> with the smmuv3-accel instance to do this now.  Hence fail if it
> is not available.
> 
> ToDo: The above requirement will be relaxed in future when we add
> support in the kernel.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   hw/arm/smmuv3-accel.c         | 104 ++++++++++++++++++++++++++++++++++
>   hw/arm/trace-events           |   1 +
>   include/hw/arm/smmuv3-accel.h |   2 +
>   3 files changed, 107 insertions(+)
> 
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 09be838d22..fb08e1d66b 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -15,6 +15,96 @@
>   
>   #include "smmuv3-internal.h"
>   
> +static int
> +smmuv3_accel_dev_get_info(SMMUv3AccelDevice *accel_dev, uint32_t *data_type,
> +                          uint32_t data_len, void *data)
> +{
> +    uint64_t caps;
> +
> +    if (!accel_dev || !accel_dev->idev) {
> +        return -ENOENT;
> +    }
> +
> +    return !iommufd_backend_get_device_info(accel_dev->idev->iommufd,
> +                                            accel_dev->idev->devid,
> +                                            data_type, data,
> +                                            data_len, &caps, NULL);
> +}
> +
> +static void smmuv3_accel_init_regs(SMMUv3AccelState *s_accel)
> +{
> +    SMMUv3State *s = ARM_SMMUV3(s_accel);
> +    SMMUv3AccelDevice *accel_dev;
> +    uint32_t data_type;
> +    uint32_t val;
> +    int ret;
> +
> +    if (!s_accel->viommu || QLIST_EMPTY(&s_accel->viommu->device_list)) {
> +        error_report("At least one cold-plugged vfio-pci is required for smmuv3-accel!");
> +        exit(1);
> +    }
> +
> +    accel_dev = QLIST_FIRST(&s_accel->viommu->device_list);
> +    if (accel_dev->info.idr[0]) {
> +        info_report("reusing the previous hw_info");
> +        goto out;
> +    }
> +
> +    ret = smmuv3_accel_dev_get_info(accel_dev, &data_type,
> +                                    sizeof(accel_dev->info), &accel_dev->info);
> +    if (ret) {
> +        error_report("failed to get SMMU device info");
> +        return;
> +    }
> +
> +    if (data_type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
> +        error_report("Wrong data type (%d)!", data_type);
> +        return;
> +    }
> +
> +out:
> +    trace_smmuv3_accel_get_device_info(accel_dev->info.idr[0],
> +                                       accel_dev->info.idr[1],
> +                                       accel_dev->info.idr[3],
> +                                       accel_dev->info.idr[5]);
> +
> +    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, BTM);
> +    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, BTM, val);
> +    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, ATS);
> +    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, val);
> +    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, ASID16);
> +    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ASID16, val);
> +    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, TERM_MODEL);
> +    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, TERM_MODEL, val);
> +    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, STALL_MODEL);
> +    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STALL_MODEL, val);
> +    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, STLEVEL);
> +    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STLEVEL, val);
> +
> +    val = FIELD_EX32(accel_dev->info.idr[1], IDR1, SIDSIZE);
> +    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SIDSIZE, val);
> +    val = FIELD_EX32(accel_dev->info.idr[1], IDR1, SSIDSIZE);
> +    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, val);
> +
> +    val = FIELD_EX32(accel_dev->info.idr[3], IDR3, HAD);
> +    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, HAD, val);
> +    val = FIELD_EX32(accel_dev->info.idr[3], IDR3, RIL);
> +    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, val);
> +    val = FIELD_EX32(accel_dev->info.idr[3], IDR3, BBML);
> +    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, val);
> +
> +    val = FIELD_EX32(accel_dev->info.idr[5], IDR5, GRAN4K);
> +    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, val);
> +    val = FIELD_EX32(accel_dev->info.idr[5], IDR5, GRAN16K);
> +    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, val);
> +    val = FIELD_EX32(accel_dev->info.idr[5], IDR5, GRAN64K);
> +    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, val);
> +    val = FIELD_EX32(accel_dev->info.idr[5], IDR5, OAS);
> +    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, val);
> +
> +    /* FIXME check iidr and aidr registrs too */
> +}
> +
>   static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
>                                                   PCIBus *bus, int devfn)
>   {
> @@ -484,11 +574,25 @@ static void smmu_accel_realize(DeviceState *d, Error **errp)
>       bs->unset_iommu_device = smmuv3_accel_unset_iommu_device;
>   }
>   
> +static void smmuv3_accel_reset_hold(Object *obj, ResetType type)
> +{
> +    SMMUv3AccelState *s = ARM_SMMUV3_ACCEL(obj);
> +    SMMUv3AccelClass *c = ARM_SMMUV3_ACCEL_GET_CLASS(s);
> +
> +    if (c->parent_phases.hold) {
> +        c->parent_phases.hold(obj, type);
> +    }
> +    smmuv3_accel_init_regs(s);
> +}
reset has to be moved from hold to exit phase....
Eric recently posted a fix for this issue in upstream.

... and if accel was just a feature of the common smmuv3 support, this reset wouldn't be needed...

> +
>   static void smmuv3_accel_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>       SMMUv3AccelClass *c = ARM_SMMUV3_ACCEL_CLASS(klass);
>   
> +    resettable_class_set_parent_phases(rc, NULL, smmuv3_accel_reset_hold, NULL,
> +                                       &c->parent_phases);
>       device_class_set_parent_realize(dc, smmu_accel_realize,
>                                       &c->parent_realize);
>       dc->hotpluggable = false;
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index cd2eac31c2..c7a7e58291 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -62,6 +62,7 @@ smmu_reset_exit(void) ""
>   smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
>   smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x"
>   smmuv3_accel_install_nested_ste(uint32_t sid, uint64_t ste_1, uint64_t ste_0) "sid=%d ste=%"PRIx64":%"PRIx64
> +smmuv3_accel_get_device_info(uint32_t idr0, uint32_t idr1, uint32_t idr3, uint32_t idr5) "idr0=0x%x idr1=0x%x idr3=0x%x idr5=0x%x"
>   
>   # strongarm.c
>   strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
> diff --git a/include/hw/arm/smmuv3-accel.h b/include/hw/arm/smmuv3-accel.h
> index 58e68534c0..9e30d7d351 100644
> --- a/include/hw/arm/smmuv3-accel.h
> +++ b/include/hw/arm/smmuv3-accel.h
> @@ -52,6 +52,7 @@ typedef struct SMMUv3AccelDevice {
>       SMMUViommu *viommu;
>       SMMUVdev   *vdev;
>       AddressSpace as_sysmem;
> +    struct iommu_hw_info_arm_smmuv3 info;
>       QLIST_ENTRY(SMMUv3AccelDevice) next;
>   } SMMUv3AccelDevice;
>   
> @@ -68,6 +69,7 @@ struct SMMUv3AccelClass {
>       /*< public >*/
>   
>       DeviceRealize parent_realize;
> +    ResettablePhases parent_phases;
>   };
>   
>   #endif /* HW_ARM_SMMUV3_ACCEL_H */

In general, I would move this common code stuff at the front of the patch series... just gathering registers, capabilities, etc.

- Don


