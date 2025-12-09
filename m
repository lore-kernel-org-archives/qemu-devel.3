Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B3ED3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 08:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSsrd-0006L5-KJ; Tue, 09 Dec 2025 03:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSsrb-0006KX-Kj
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 03:14:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSsrZ-000071-CO
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 03:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765268064;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oYfa0UDnS0lV5xcHcWZumTuzpUW7nmszinDfabwdNxA=;
 b=EYP/10UUelpfsi5SlvvOFDRZFbz+cB8q/B45mi6yHwqGsUcvvLd4OgHtfrhosHYevHlcBb
 DTb7rRqHS8R6HJQZvdSeaKaNCj38UrgnnKxwL07hNqUxihTAZHCFSFD5I0RLdKzYaZmCLV
 oEtBJyGmmUAOVRVYC0+9sGi/MWwaawI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-blMbxV49P62HSGpavUYCuA-1; Tue, 09 Dec 2025 03:14:22 -0500
X-MC-Unique: blMbxV49P62HSGpavUYCuA-1
X-Mimecast-MFC-AGG-ID: blMbxV49P62HSGpavUYCuA_1765268062
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-bc09a8454b9so12071173a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 00:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765268062; x=1765872862;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oYfa0UDnS0lV5xcHcWZumTuzpUW7nmszinDfabwdNxA=;
 b=on0SoUC1nuw2RzlUI/G9G7AVPHbYv9OcLIymQA/IoTFFUh+Tx0IVbPpvJJ6qG8WTN7
 vQr5w0QzHpBIgOtCdEHfNx2PSAxPw9uZvwN+Ub10XtMJPJAj0NvTQOlHkV2rCpawkeT7
 ugwk1ayqnpempnxhG0C1q5xXKWLXt9tl2PQtbIODcSFlTCLNYaR+IJDTUH7Hbyxag/Lu
 odviOngcMrasLVshgv8lJGTzdjqzD4cm+yMzp/D3C0YDVGE14QlXS51OEoGh3vCyIYup
 1NNvY+AYJf+n/Qqb8IMIBShXCuyJg1NDBX5S2qIYOCmuY4vhx96nC4OyuUjMlLrvi7Rb
 ZJmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtQTjPuAW3Q1cHqLlVOywsCH/Lg7zzxm7E9fmQ3NMcMm975D2R1xEpHeDjDOAQd6CNJoPYkeQPdY+0@nongnu.org
X-Gm-Message-State: AOJu0Yz47mTCl6X31RxlEJYndjmvn+Ic7sSay7z7/OrdUE0fnPTShQHb
 UsjOwD+duPh3WcklJl5cx3Y5R3lm1MH1AhxiRLN4rgqq8vhdRTiLJ7ja1Fq3WzdWDGApXOzLumU
 khntv5rXfbhX9bXpFFESNxMFWOpv5Ma/IbIZLbr1Hi3XnJb9z1J1E3tPS
X-Gm-Gg: ASbGncs4ycGLUpyAOa9pZK2of2EFaiyNR+C06dPI8vxQDo8poVy5D0Y0za6L5adLd0j
 +Qp1KAmUvYYNuvr9buVApO4ecH3SupUEmVPDYgDoFZ/Uh0CJsDSFl0S2lgcCDmdRDoPaxKcJizM
 WFhFhM3v64B8SfuYoakyAm3yM/0IYfw9NeSlSZl8sZdT5rxCTodH43Iph1D5a6qEOFkn6C0K827
 9HpjD0EkTKf5jWcDVPqa5BRuT26BXFkADVYsfkzOjUcDwUiMnMQSjbJp10sP9LOCnOYhfS9ripo
 uq/2BmrZtNXE/czaOB8PW9Z5r28m9c5O8C9Nip0JuxeR4XmsFfcNp7JjFuMrldJGzxWPa4SWNRT
 G7rOLKbvkEl6wQ7lPB1pudrQzDmGHJ2ncmhl8tTPs1c9iKoMvgow3wMt8Pg==
X-Received: by 2002:a05:7022:4582:b0:11b:9386:7ed2 with SMTP id
 a92af1059eb24-11e032d4193mr8052386c88.47.1765268061565; 
 Tue, 09 Dec 2025 00:14:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF74oO2RQDBwdp/OeXNcj7gV3prYtQQhQU/ZQiXzXyE/RsabOLWccU2YulVs0f6ri2I4K/ScA==
X-Received: by 2002:a05:7022:4582:b0:11b:9386:7ed2 with SMTP id
 a92af1059eb24-11e032d4193mr8052356c88.47.1765268060959; 
 Tue, 09 Dec 2025 00:14:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11df7703bd7sm70475024c88.10.2025.12.09.00.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 00:14:20 -0800 (PST)
Message-ID: <9f338aa0-efc6-4fa7-add6-fdfaf39ca954@redhat.com>
Date: Tue, 9 Dec 2025 09:14:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/33] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-15-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251120132213.56581-15-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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



On 11/20/25 2:21 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> A device placed behind a vSMMU instance must have corresponding vSTEs
> (bypass, abort, or translate) installed. The bypass and abort proxy nested
> HWPTs are pre-allocated.
>
> For translate HWPT, a vDEVICE object is allocated and associated with the
> vIOMMU for each guest device. This allows the host kernel to establish a
> virtual SID to physical SID mapping, which is required for handling
> invalidations and event reporting.
>
> The translate HWPT is allocated based on the guest STE configuration and
> attached to the device when the guest issues SMMU_CMD_CFGI_STE or
> SMMU_CMD_CFGI_STE_RANGE, provided the STE enables S1 translation.
>
> If the guest STE is invalid or S1 translation is disabled, the device is
> attached to one of the pre-allocated ABORT or BYPASS HWPTs instead.
>
> While at it, export smmu_find_ste() for use here.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c    | 197 +++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h    |  22 +++++
>  hw/arm/smmuv3-internal.h |  20 ++++
>  hw/arm/smmuv3.c          |  11 ++-
>  hw/arm/trace-events      |   2 +
>  5 files changed, 250 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 4dd56a8e65..2e42d2d484 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -51,6 +51,188 @@ static uint32_t smmuv3_accel_gbpa_hwpt(SMMUv3State *s, SMMUv3AccelState *accel)
>             accel->abort_hwpt_id : accel->bypass_hwpt_id;
>  }
>  
> +static bool
> +smmuv3_accel_alloc_vdev(SMMUv3AccelDevice *accel_dev, int sid, Error **errp)
> +{
> +    SMMUv3AccelState *accel = accel_dev->s_accel;
> +    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
> +    IOMMUFDVdev *vdev = accel_dev->vdev;
> +    uint32_t vdevice_id;
> +
> +    if (!idev || vdev) {
> +        return true;
> +    }
> +
> +    if (!iommufd_backend_alloc_vdev(idev->iommufd, idev->devid,
> +                                    accel->viommu.viommu_id, sid,
> +                                    &vdevice_id, errp)) {
> +            return false;
> +    }
> +
> +    vdev = g_new(IOMMUFDVdev, 1);
> +    vdev->vdevice_id = vdevice_id;
> +    vdev->virt_id = sid;
> +    accel_dev->vdev = vdev;
> +    return true;
> +}
> +
> +static SMMUS1Hwpt *
> +smmuv3_accel_dev_alloc_translate(SMMUv3AccelDevice *accel_dev, STE *ste,
> +                                 Error **errp)
> +{
> +    uint64_t ste_0 = (uint64_t)ste->word[0] | (uint64_t)ste->word[1] << 32;
> +    uint64_t ste_1 = (uint64_t)ste->word[2] | (uint64_t)ste->word[3] << 32;
> +    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
> +    SMMUv3AccelState *accel = accel_dev->s_accel;
> +    struct iommu_hwpt_arm_smmuv3 nested_data = {
> +        .ste = {
> +            cpu_to_le64(ste_0 & STE0_MASK),
> +            cpu_to_le64(ste_1 & STE1_MASK),
> +        },
> +    };
> +    uint32_t hwpt_id = 0, flags = 0;
> +    SMMUS1Hwpt *s1_hwpt;
> +
> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                                    accel->viommu.viommu_id, flags,
> +                                    IOMMU_HWPT_DATA_ARM_SMMUV3,
> +                                    sizeof(nested_data), &nested_data,
> +                                    &hwpt_id, errp)) {
> +            return NULL;
> +    }
> +
> +    s1_hwpt = g_new0(SMMUS1Hwpt, 1);
> +    s1_hwpt->hwpt_id = hwpt_id;
> +    trace_smmuv3_accel_translate_ste(accel_dev->vdev->virt_id, hwpt_id,
> +                                     nested_data.ste[1], nested_data.ste[0]);
> +    return s1_hwpt;
> +}
> +
> +bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
> +                              Error **errp)
> +{
> +    SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid,
> +                           .inval_ste_allowed = true};
> +    SMMUv3AccelState *accel = s->s_accel;
> +    SMMUv3AccelDevice *accel_dev;
> +    HostIOMMUDeviceIOMMUFD *idev;
> +    uint32_t config, hwpt_id = 0;
> +    SMMUS1Hwpt *s1_hwpt = NULL;
> +    const char *type;
> +    STE ste;
> +
> +    if (!accel) {
> +        return true;
> +    }
> +
> +    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
> +    if (!accel_dev->s_accel) {
> +        return true;
> +    }
> +
> +    idev = accel_dev->idev;
> +    if (!smmuv3_accel_alloc_vdev(accel_dev, sid, errp)) {
> +        return false;
> +    }
> +
> +    if (smmu_find_ste(sdev->smmu, sid, &ste, &event)) {
> +        /* No STE found, nothing to install */
> +        return true;
> +    }
> +
> +    /*
> +     * Install the STE based on SMMU enabled/config:
> +     * - attach a pre-allocated HWPT for abort/bypass
> +     * - or a new HWPT for translate STE
> +     *
> +     * Note: The vdev remains associated with accel_dev even if HWPT
> +     * attach/alloc fails, since the Guest-Host SID mapping stays
> +     * valid as long as the device is behind the accelerated SMMUv3.
> +     */
> +    if (!smmu_enabled(s)) {
> +        hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
> +    } else {
> +        config = STE_CONFIG(&ste);
> +
> +        if (!STE_VALID(&ste) || STE_CFG_ABORT(config)) {
> +            hwpt_id = accel->abort_hwpt_id;
> +        } else if (STE_CFG_BYPASS(config)) {
> +            hwpt_id = accel->bypass_hwpt_id;
> +        } else if (STE_CFG_S1_TRANSLATE(config)) {
> +            s1_hwpt = smmuv3_accel_dev_alloc_translate(accel_dev, &ste, errp);
> +            if (!s1_hwpt) {
> +                return false;
> +            }
> +            hwpt_id = s1_hwpt->hwpt_id;
> +       }
> +    }
> +
> +    if (!hwpt_id) {
> +        error_setg(errp, "Invalid STE config for sid 0x%x",
> +                   smmu_get_sid(&accel_dev->sdev));
> +        return false;
> +    }
> +
> +    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
> +        if (s1_hwpt) {
> +            iommufd_backend_free_id(idev->iommufd, s1_hwpt->hwpt_id);
> +            g_free(s1_hwpt);
> +        }
> +        return false;
> +    }
> +
> +    /* Free the previous s1_hwpt */
> +    if (accel_dev->s1_hwpt) {
> +        iommufd_backend_free_id(idev->iommufd, accel_dev->s1_hwpt->hwpt_id);
> +        g_free(accel_dev->s1_hwpt);
> +    }
> +
> +    accel_dev->s1_hwpt = s1_hwpt;
> +    if (hwpt_id == accel->abort_hwpt_id) {
> +        type = "abort";
> +    } else if (hwpt_id == accel->bypass_hwpt_id) {
> +        type = "bypass";
> +    } else {
> +        type = "translate";
> +    }
> +
> +    trace_smmuv3_accel_install_ste(sid, type, hwpt_id);
> +    return true;
> +}
> +
> +bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
> +                                    Error **errp)
> +{
> +    SMMUv3AccelState *accel = s->s_accel;
> +    SMMUv3AccelDevice *accel_dev;
> +    Error *local_err = NULL;
> +    bool all_ok = true;
> +
> +    if (!accel) {
> +        return true;
> +    }
> +
> +    QLIST_FOREACH(accel_dev, &accel->device_list, next) {
> +        uint32_t sid = smmu_get_sid(&accel_dev->sdev);
> +
> +        if (sid >= range->start && sid <= range->end) {
> +            if (!smmuv3_accel_install_ste(s, &accel_dev->sdev,
> +                                          sid, &local_err)) {
> +                error_append_hint(&local_err, "Device 0x%x: Failed to install "
> +                                  "STE\n", sid);
> +                error_report_err(local_err);
> +                local_err = NULL;
> +                all_ok = false;
> +            }
> +        }
> +    }
> +
> +    if (!all_ok) {
> +        error_setg(errp, "Failed to install all STEs properly");
> +    }
> +    return all_ok;
> +}
> +
>  static bool
>  smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>                            Error **errp)
> @@ -161,6 +343,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>      HostIOMMUDeviceIOMMUFD *idev;
>      SMMUv3AccelDevice *accel_dev;
>      SMMUv3AccelState *accel;
> +    IOMMUFDVdev *vdev;
>      SMMUDevice *sdev;
>  
>      if (!sbus) {
> @@ -181,6 +364,20 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>                       "0x%x", idev->devid);
>      }
>  
> +    if (accel_dev->s1_hwpt) {
> +        iommufd_backend_free_id(accel_dev->idev->iommufd,
> +                                accel_dev->s1_hwpt->hwpt_id);
> +        g_free(accel_dev->s1_hwpt);
> +        accel_dev->s1_hwpt = NULL;
> +    }
> +
> +    vdev = accel_dev->vdev;
> +    if (vdev) {
> +        iommufd_backend_free_id(accel->viommu.iommufd, vdev->vdevice_id);
> +        g_free(vdev);
> +        accel_dev->vdev = NULL;
> +    }
> +
>      accel_dev->idev = NULL;
>      accel_dev->s_accel = NULL;
>      QLIST_REMOVE(accel_dev, next);
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index c72605caab..ae896cfa8b 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -25,19 +25,41 @@ typedef struct SMMUv3AccelState {
>      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
>  } SMMUv3AccelState;
>  
> +typedef struct SMMUS1Hwpt {
> +    uint32_t hwpt_id;
> +} SMMUS1Hwpt;
> +
>  typedef struct SMMUv3AccelDevice {
>      SMMUDevice sdev;
>      HostIOMMUDeviceIOMMUFD *idev;
> +    SMMUS1Hwpt *s1_hwpt;
> +    IOMMUFDVdev *vdev;
>      QLIST_ENTRY(SMMUv3AccelDevice) next;
>      SMMUv3AccelState *s_accel;
>  } SMMUv3AccelDevice;
>  
>  #ifdef CONFIG_ARM_SMMUV3_ACCEL
>  void smmuv3_accel_init(SMMUv3State *s);
> +bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
> +                              Error **errp);
> +bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
> +                                    Error **errp);
>  #else
>  static inline void smmuv3_accel_init(SMMUv3State *s)
>  {
>  }
> +static inline bool
> +smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
> +                         Error **errp)
> +{
> +    return true;
> +}
> +static inline bool
> +smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
> +                               Error **errp)
> +{
> +    return true;
> +}
>  #endif
>  
>  #endif /* HW_ARM_SMMUV3_ACCEL_H */
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 81212a58f1..a76e4e2484 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -547,6 +547,8 @@ typedef struct CD {
>      uint32_t word[16];
>  } CD;
>  
> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event);
> +
>  /* STE fields */
>  
>  #define STE_VALID(x)   extract32((x)->word[0], 0, 1)
> @@ -556,6 +558,7 @@ typedef struct CD {
>  #define STE_CFG_S2_ENABLED(config) (config & 0x2)
>  #define STE_CFG_ABORT(config)      (!(config & 0x4))
>  #define STE_CFG_BYPASS(config)     (config == 0x4)
> +#define STE_CFG_S1_TRANSLATE(config)  (config == 0x5)
>  
>  #define STE_S1FMT(x)       extract32((x)->word[0], 4 , 2)
>  #define STE_S1CDMAX(x)     extract32((x)->word[1], 27, 5)
> @@ -586,6 +589,23 @@ typedef struct CD {
>  #define SMMU_STE_VALID      (1ULL << 0)
>  #define SMMU_STE_CFG_BYPASS (1ULL << 3)
>  
> +#define STE0_V       MAKE_64BIT_MASK(0, 1)
> +#define STE0_CONFIG  MAKE_64BIT_MASK(1, 3)
> +#define STE0_S1FMT   MAKE_64BIT_MASK(4, 2)
> +#define STE0_CTXPTR  MAKE_64BIT_MASK(6, 50)
> +#define STE0_S1CDMAX MAKE_64BIT_MASK(59, 5)
> +#define STE0_MASK    (STE0_S1CDMAX | STE0_CTXPTR | STE0_S1FMT | STE0_CONFIG | \
> +                      STE0_V)
> +
> +#define STE1_S1DSS    MAKE_64BIT_MASK(0, 2)
> +#define STE1_S1CIR    MAKE_64BIT_MASK(2, 2)
> +#define STE1_S1COR    MAKE_64BIT_MASK(4, 2)
> +#define STE1_S1CSH    MAKE_64BIT_MASK(6, 2)
> +#define STE1_S1STALLD MAKE_64BIT_MASK(27, 1)
> +#define STE1_EATS     MAKE_64BIT_MASK(28, 2)
> +#define STE1_MASK     (STE1_EATS | STE1_S1STALLD | STE1_S1CSH | STE1_S1COR | \
> +                       STE1_S1CIR | STE1_S1DSS)
> +
>  static inline int oas2bits(int oas_field)
>  {
>      switch (oas_field) {
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 374ae08baa..bfb41b8866 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -630,8 +630,7 @@ bad_ste:
>   * Supports linear and 2-level stream table
>   * Return 0 on success, -EINVAL otherwise
>   */
> -static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
> -                         SMMUEventInfo *event)
> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
>  {
>      dma_addr_t addr, strtab_base;
>      uint32_t log2size;
> @@ -1341,6 +1340,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>              }
>  
>              trace_smmuv3_cmdq_cfgi_ste(sid);
> +            if (!smmuv3_accel_install_ste(s, sdev, sid, errp)) {
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
>              smmuv3_flush_config(sdev);
>  
>              break;
> @@ -1361,6 +1364,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>              sid_range.end = sid_range.start + mask;
>  
>              trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
> +            if (!smmuv3_accel_install_ste_range(s, &sid_range, errp)) {
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
>              smmu_configs_inv_sid_range(bs, sid_range);
>              break;
>          }
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 2aaa0c40c7..8135c0c734 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -69,6 +69,8 @@ smmu_reset_exit(void) ""
>  #smmuv3-accel.c
>  smmuv3_accel_set_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev devid=0x%x)"
>  smmuv3_accel_unset_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev devid=0x%x)"
> +smmuv3_accel_translate_ste(uint32_t vsid, uint32_t hwpt_id, uint64_t ste_1, uint64_t ste_0) "vSID=0x%x hwpt_id=0x%x ste=%"PRIx64":%"PRIx64
> +smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vSID=0x%x ste type=%s hwpt_id=0x%x"
>  
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


