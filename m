Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A10CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKkP-0003nz-Rd; Mon, 27 Oct 2025 06:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDKkN-0003mZ-Iy
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDKkK-0002Nr-O8
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761561997;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FmCI4CFlIlpO5XbDp8FpQdT99z9xtBk9MdxOfGMxWDQ=;
 b=OJmdOuMMtsh4955h4HjFTvpaTLxZojAi2Dkt/+z7B+/GhEp3SW8hV49rnT+PBBK0kGhYzZ
 ZdtbxyUMOcNUozvdgUVvjFo5nnpPObKcVC+zxkTEKZ7YQ+gO9vcN+jc0QxdVH5+BxZI9LV
 nwfyYV6GG7LAKJzIVHCTAqnNVF0bQEk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563--hN7D-gGP-aJY-CmcXrvjg-1; Mon, 27 Oct 2025 06:46:36 -0400
X-MC-Unique: -hN7D-gGP-aJY-CmcXrvjg-1
X-Mimecast-MFC-AGG-ID: -hN7D-gGP-aJY-CmcXrvjg_1761561995
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47106a388cfso25635555e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 03:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761561995; x=1762166795;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FmCI4CFlIlpO5XbDp8FpQdT99z9xtBk9MdxOfGMxWDQ=;
 b=GqMDMm5DyXWO5JvQoctsb8c2JKFeW15S7QIWw33lDasAmwf+OeiQvgczkKGla+5JRj
 TLJbx0w9/14bAItAz0EtX1uQPwZghAndvsSHxdnB6ZANPkTxxR0MzgSZoMiEDm2qOiXS
 0fHRpVHR7Q4vibJ8jl5CrIQ5Ra6bZCVQM3aJ0WYnp9DC4xP0+iKrShQo+cP8WqSdB3P9
 AkmgwsO9B9P0OzrRyBvmePdqZ8Nuh8c26sTMrazMh5TpQh0+MHh2LzAX4ggpEuG/yvIi
 Ox84BPkcDHtb9qIKnUD7NmjUHglWB7kqqKmyctQgMYk35bzwt9LFuzvlgIhEcKCF4wtB
 juEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTjLOB+6tUXKDBHZ17rLmYdov+04xmMdxZDai9Xns19KySpmCXRGmAfsBK/39JChULbobBz01fB27C@nongnu.org
X-Gm-Message-State: AOJu0YxBMjequUXgFdETsukF0QISocVF3flQvHD5rEukQK1v89kKtvYF
 QTUrONGmJX/wOq7fJND8dFnrtC55D0pv56+Q1vnfDG7DSpN0bopbOcwuB6nDzfblrmIH/1w6oik
 FSWvFhYUCzvFpJN/RY+8cRovNVfiqY/KZd47ivaFZMJZW8QpkGSgu06KP
X-Gm-Gg: ASbGncvMoDd02DgwmqeZSbUkEmeDAD+qPSy9F7Fidn2bnfRoiEo3On3OnacrA4scPVM
 LuZOx1RFzTKrMG/P88UGLoMYW/dJN7SSblv0H5ukswkhtnRihxAqhPL0kjxF72S9cDWCsWqLEWE
 DIqCuIX0HEMca89CCEWKxY/l6Ck3+PoxqIBJ7oK4IA8y8r5GgP293f71auGqwIt0b6EByzGamwr
 uC+6fiGXHXUGTdITImvObiD90J4QlEPEWqaF757KetBDcWg6DMBLEVWkRwtudT6sD4yYNu340RZ
 pEA/JrP0BAGcA3SGLr68fia2eYJ/RxTLLPCK6CxJNB/01DwpQSBOTBcPVhRk/8QOX9Ta/DNuyp2
 FSVMTQtHfDoFV9dTthQDNSyib3QpLjPL4XtnVkUmhhQalXA==
X-Received: by 2002:a05:600c:3b8d:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-471179176b9mr325877815e9.28.1761561995299; 
 Mon, 27 Oct 2025 03:46:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5dRTaE6QJAVnzFty1GjXpeTc/xnv2a0oHeAoTrpETA0dawahkIRzTlpgo9g7HOPmIRHqhzA==
X-Received: by 2002:a05:600c:3b8d:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-471179176b9mr325877455e9.28.1761561994803; 
 Mon, 27 Oct 2025 03:46:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd489e6dsm128426165e9.6.2025.10.27.03.46.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 03:46:34 -0700 (PDT)
Message-ID: <46292ce1-e930-4ae8-97fe-626ed2e4d3c4@redhat.com>
Date: Mon, 27 Oct 2025 11:46:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/27] hw/arm/smmuv3-accel: Get host SMMUv3 hw info and
 validate
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 shameerkolothum@gmail.com
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-15-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250929133643.38961-15-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 9/29/25 3:36 PM, Shameer Kolothum wrote:
> Just before the device gets attached to the SMMUv3, make sure QEMU SMMUv3
> features are compatible with the host SMMUv3.
>
> Not all fields in the host SMMUv3 IDR registers are meaningful for userspace.
> Only the following fields can be used:
>
>   - IDR0: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN, CD2L, ASID16, TTF
>   - IDR1: SIDSIZE, SSIDSIZE
>   - IDR3: BBML, RIL
>   - IDR5: VAX, GRAN64K, GRAN16K, GRAN4K
>
> For now, the check is to make sure the features are in sync to enable
> basic accelerated SMMUv3 support.
>
> One other related change is, move the smmuv3_init_regs() to smmu_realize()
> so that we do have that early enough for the check mentioned above.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 98 +++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3.c       |  4 +-
>  2 files changed, 100 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 9ad8595ce2..defeddbd8c 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -39,6 +39,96 @@
>  #define STE1_MASK     (STE1_ETS | STE1_S1STALLD | STE1_S1CSH | STE1_S1COR | \
>                         STE1_S1CIR | STE1_S1DSS)
>  
> +static bool
> +smmuv3_accel_check_hw_compatible(SMMUv3State *s,
> +                                 struct iommu_hw_info_arm_smmuv3 *info,
> +                                 Error **errp)
> +{
> +    uint32_t val;
> +
> +    /*
> +     * QEMU SMMUv3 supports both linear and 2-level stream tables.
> +     */
> +    val = FIELD_EX32(info->idr[0], IDR0, STLEVEL);
> +    if (val != FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STLEVEL, val);
> +        error_setg(errp, "Host SUMMUv3 differs in Stream Table format");
> +        return false;
> +    }
> +
> +    /* QEMU SMMUv3 supports only little-endian translation table walks */
> +    val = FIELD_EX32(info->idr[0], IDR0, TTENDIAN);
> +    if (!val && val > FIELD_EX32(s->idr[0], IDR0, TTENDIAN)) {
> +        error_setg(errp, "Host SUMMUv3 doesn't support Little-endian "
> +                   "translation table");
> +        return false;
> +    }
> +
> +    /* QEMU SMMUv3 supports only AArch64 translation table format */
> +    val = FIELD_EX32(info->idr[0], IDR0, TTF);
> +    if (val < FIELD_EX32(s->idr[0], IDR0, TTF)) {
> +        error_setg(errp, "Host SUMMUv3 deosn't support Arch64 Translation "
> +                   "table format");
> +        return false;
> +    }
> +
> +    /* QEMU SMMUv3 supports SIDSIZE 16 */
> +    val = FIELD_EX32(info->idr[1], IDR1, SIDSIZE);
> +    if (val < FIELD_EX32(s->idr[1], IDR1, SIDSIZE)) {
> +        error_setg(errp, "Host SUMMUv3 SIDSIZE not compatible");
> +        return false;
> +    }
> +
> +    /* QEMU SMMUv3 supports Range Invalidation by default */
> +    val = FIELD_EX32(info->idr[3], IDR3, RIL);
> +    if (val != FIELD_EX32(s->idr[3], IDR3, RIL)) {
> +        error_setg(errp, "Host SUMMUv3 deosn't support Range Invalidation");
> +        return false;
> +    }
> +
> +    val = FIELD_EX32(info->idr[5], IDR5, GRAN4K);
> +    if (val != FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
> +        error_setg(errp, "Host SMMUv3 doesn't support 64K translation granule");
> +        return false;
> +    }
> +    val = FIELD_EX32(info->idr[5], IDR5, GRAN16K);
> +    if (val != FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
> +        error_setg(errp, "Host SMMUv3 doesn't support 16K translation granule");
> +        return false;
> +    }
> +    val = FIELD_EX32(info->idr[5], IDR5, GRAN64K);
> +    if (val != FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
> +        error_setg(errp, "Host SMMUv3 doesn't support 16K translation granule");
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static bool
> +smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
> +                           Error **errp)
> +{
> +    struct iommu_hw_info_arm_smmuv3 info;
> +    uint32_t data_type;
> +    uint64_t caps;
> +
> +    if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
> +                                         &info, sizeof(info), &caps, errp)) {
> +        return false;
> +    }
> +
> +    if (data_type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
> +        error_setg(errp, "Wrong data type (%d) for Host SMMUv3 device info",
> +                     data_type);
> +        return false;
> +    }
> +
> +    if (!smmuv3_accel_check_hw_compatible(s, &info, errp)) {
> +        return false;
> +    }
> +    return true;
> +}
> +
>  static bool
>  smmuv3_accel_alloc_vdev(SMMUv3AccelDevice *accel_dev, int sid, Error **errp)
>  {
> @@ -363,6 +453,14 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>          return true;
>      }
>  
> +    /*
> +     * Check the host SMMUv3 associated with the dev is compatible with the
> +     * QEMU SMMUv3 accel.
> +     */
> +    if (!smmuv3_accel_hw_compatible(s, idev, errp)) {
> +        return false;
> +    }
> +
>      if (!smmuv3_accel_dev_alloc_viommu(accel_dev, idev, errp)) {
>          error_setg(errp, "Device 0x%x: Unable to alloc viommu", sid);
>          return false;
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 3963bdc87f..5830cf5a03 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1913,8 +1913,6 @@ static void smmu_reset_exit(Object *obj, ResetType type)
>      if (c->parent_phases.exit) {
>          c->parent_phases.exit(obj, type);
>      }
> -
> -    smmuv3_init_regs(s);
does that work on reset()? Besides setting idr regs, smmuv3_init_regs() also
resets the cmdq and eventq plus a bunch of dynamic registers. That needs
to happen on reset I think.

Eric
>  }
>  
>  static void smmu_realize(DeviceState *d, Error **errp)
> @@ -1945,6 +1943,8 @@ static void smmu_realize(DeviceState *d, Error **errp)
>      sysbus_init_mmio(dev, &sys->iomem);
>  
>      smmu_init_irq(s, dev);
> +
> +    smmuv3_init_regs(s);
>  }
>  
>  static const VMStateDescription vmstate_smmuv3_queue = {


