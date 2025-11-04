Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85027CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGHwR-0005sQ-Qf; Tue, 04 Nov 2025 09:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGHw5-0005cM-Au
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 09:23:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGHw3-0006mW-BO
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 09:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762266178;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dRORFH5yIw9rK94yAAv2DYRI6VYvYD416/F1YBVupU=;
 b=imRI3e2zMCdK/mFQEq5diMTfngHkE7Oqw/x6SeZDQ5UBUzI8FAwZNeJVu+FU0cUluHnVM+
 bJwlrQd/tioBDRc/bJxiUBu27EF3D/F8K5aOisqvySbpfU9f7OB0AGg70s851kkvH1PcNa
 W4YvOhfx+dd6Q6KP4fxnOA0v5deg8gc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-VgiidEXAOn6EpteP2JWzCw-1; Tue, 04 Nov 2025 09:22:56 -0500
X-MC-Unique: VgiidEXAOn6EpteP2JWzCw-1
X-Mimecast-MFC-AGG-ID: VgiidEXAOn6EpteP2JWzCw_1762266174
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-475de0566adso47466665e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 06:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762266174; x=1762870974;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+dRORFH5yIw9rK94yAAv2DYRI6VYvYD416/F1YBVupU=;
 b=ZAzCGij/T391edVkzLOBnsLMNelD4+CGAya5/u2KZP1DlrjERCavy31blK1fEpi2Y0
 pUBy6h9OtjZulE9cLSYyTNWbF+7AzKP669rYNmFtpHcfRF6cWq30B0y6xskWGd/prYV+
 KrUSrCqmSmsf6vE+tB9+fMXco4BwytQf7lLPRnG4cuxCurQYkQPD1QWq9ksIhbgAjXwt
 JO2DOD5+RwjtOZM0sZ4lrdyOEo9Wv90e2RbLBqUNsXDRZ6nBEE1le33EIrGVrEwxnY9n
 gI0jCwsh/d+bYwPBZ772Zmei2L20jHtPly32/PX9CxkdpekXdPrYtXbjNcf6b9jgSkqB
 w/Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkACnsQHP9OJKhI9AE8wCYOsfD1a3ujwRHBOdAaaBdKJubbgnELfsuZEcjnUHAhooQCdImZl3K/37C@nongnu.org
X-Gm-Message-State: AOJu0YyAQtU8vddO0Vlc8ur6RJG2TGScH+AYk5FNNcLVqUMhBUn15Bhx
 YNMWdou/32XqcWYh90Q7xu1KTs6O69DytHxP0Zey/Z7h6q69uCmlYIYSoKhah7/u8I4rUBhAd3L
 JRt+mbqCpBGYAlEZP5rFlZE+6Zx6uieuu6PfNpdAkwDcYvzIUfAOgLNCv
X-Gm-Gg: ASbGncsKnaBkCEuo61GBPp0utIyE8wLiEkj6DEk8sxh6+pAcXsAF4UiybpVehdsfDLM
 JvfGqiODmBv3ErCWzEwQWLK3P8yDiZeQIBtiMQEP1yP4XM4WnUEH/QZ6zjGa7gWHyLHhfpiFce3
 ouoWbGePV5DWObiVlvWuuKDfiOHkp/WN3KXP4PxkTa99ekwL7IfCDP1LpXNcOZynTxnt36rDlsX
 Y/F8G7aCucdIUY/fQOm9dXsS0e/hI2DcukQBvGsxjaKe9swZ3WhQXNhc51jxnsPdgXDbozRCVFh
 AeWninnCiQm7TvQUVP2lMvaFJMyMDvf46Pqsg1b44vpVRCypA2KEGmMQJ2gXxxsbgiNpBjXbReV
 LZdg5Ik0dWB19cDwtdZjrZ4DLZZSlM4Szstk+peq066YXag==
X-Received: by 2002:a05:600c:45d3:b0:475:dde5:d91b with SMTP id
 5b1f17b1804b1-47730813642mr150558525e9.17.1762266174378; 
 Tue, 04 Nov 2025 06:22:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbD3TMFJQKgkLjHbam2qm1zXiYPF6AVaXYdmUn+R8gpSGwIlX7n217OVfY0OZuzNSDWeVYhA==
X-Received: by 2002:a05:600c:45d3:b0:475:dde5:d91b with SMTP id
 5b1f17b1804b1-47730813642mr150558265e9.17.1762266173913; 
 Tue, 04 Nov 2025 06:22:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47755f92274sm38873855e9.9.2025.11.04.06.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 06:22:53 -0800 (PST)
Message-ID: <2a4a1246-4515-4e98-b5dc-e1ff0e9f0003@redhat.com>
Date: Tue, 4 Nov 2025 15:22:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 27/32] hw/arm/smmuv3-accel: Add support for ATS
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-28-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251031105005.24618-28-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
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



On 10/31/25 11:50 AM, Shameer Kolothum wrote:
> QEMU SMMUv3 does not enable ATS (Address Translation Services) by default.
> When accelerated mode is enabled and the host SMMUv3 supports ATS, it can
> be useful to report ATS capability to the guest so it can take advantage
> of it if the device also supports ATS.
>
> Note: ATS support cannot be reliably detected from the host SMMUv3 IDR
> registers alone, as firmware ACPI IORT tables may override them. The
> user must therefore ensure the support before enabling it.

Please add a note that this is a partial ATS support, made possible because
emulated devices can be pluugged onto accel SMMU (ie. we do not support
ATS translation requests for instance)
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c    |  4 ++++
>  hw/arm/smmuv3.c          | 25 ++++++++++++++++++++++++-
>  hw/arm/virt-acpi-build.c | 10 ++++++++--
>  include/hw/arm/smmuv3.h  |  1 +
>  4 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 35298350cb..5b0ef3804a 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -645,6 +645,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>      if (!s->ril) {
>          s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 0);
>      }
> +    /* QEMU SMMUv3 has no ATS. Update IDR0 if user has enabled it */
"advertise ats if opt-on by property?"
> +    if (s->ats) {
> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1); /* ATS */
use s->ats directly?
> +    }
>  }
>  
>  /* Based on SMUUv3 GBPA configuration, attach a corresponding HWPT */
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index b9d96f5762..d95279a733 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1517,13 +1517,28 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>               */
>              smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
>              break;
> +        case SMMU_CMD_ATC_INV:
> +        {
> +            SMMUDevice *sdev = smmu_find_sdev(bs, CMD_SID(&cmd));
> +            Error *local_err = NULL;
> +
> +            if (!sdev) {
> +                break;
> +            }
> +
> +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, &local_err)) {
> +                error_report_err(local_err);
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
> +            break;
> +        }
>          case SMMU_CMD_TLBI_EL3_ALL:
>          case SMMU_CMD_TLBI_EL3_VA:
>          case SMMU_CMD_TLBI_EL2_ALL:
>          case SMMU_CMD_TLBI_EL2_ASID:
>          case SMMU_CMD_TLBI_EL2_VA:
>          case SMMU_CMD_TLBI_EL2_VAA:
> -        case SMMU_CMD_ATC_INV:
>          case SMMU_CMD_PRI_RESP:
>          case SMMU_CMD_RESUME:
>          case SMMU_CMD_STALL_TERM:
> @@ -1942,6 +1957,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>              error_setg(errp, "ril can only be disabled if accel=on");
>              return false;
>          }
> +        if (s->ats) {
> +            error_setg(errp, "ats can only be enabled if accel=on");
> +            return false;
> +        }
>          return false;
>      }
>      return true;
> @@ -2067,6 +2086,7 @@ static const Property smmuv3_properties[] = {
>      DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
>      /* RIL can be turned off for accel cases */
>      DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
> +    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
>  };
>  
>  static void smmuv3_instance_init(Object *obj)
> @@ -2096,6 +2116,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>                                            "in nested mode for vfio-pci dev assignment");
>      object_class_property_set_description(klass, "ril",
>          "Disable range invalidation support (for accel=on)");
> +    object_class_property_set_description(klass, "ats",
> +        "Enable/disable ATS support (for accel=on). Please ensure host "
> +        "platform has ATS support before enabling this");
>  }
>  
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 6106ad1b6e..1b0d0a2029 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -345,6 +345,7 @@ typedef struct AcpiIortSMMUv3Dev {
>      /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
>      size_t offset;
>      bool accel;
> +    bool ats;
>  } AcpiIortSMMUv3Dev;
>  
>  /*
> @@ -400,6 +401,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
>  
>      bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
>      sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
> +    sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
>      pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
>      sbdev = SYS_BUS_DEVICE(obj);
>      sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> @@ -544,6 +546,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      int i, nb_nodes, rc_mapping_count;
>      AcpiIortSMMUv3Dev *sdev;
>      size_t node_size;
> +    bool ats_needed = false;
>      int num_smmus = 0;
>      uint32_t id = 0;
>      int rc_smmu_idmaps_len = 0;
> @@ -579,6 +582,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          /* Calculate RMR nodes required. One per SMMUv3 with accelerated mode */
>          for (i = 0; i < num_smmus; i++) {
>              sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +            if (sdev->ats) {
> +                ats_needed = true;
> +            }
>              if (sdev->accel) {
>                  nb_nodes++;
>              }
> @@ -678,8 +684,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      build_append_int_noprefix(table_data, 0, 2); /* Reserved */
>      /* Table 15 Memory Access Flags */
>      build_append_int_noprefix(table_data, 0x3 /* CCA = CPM = DACS = 1 */, 1);
> -
> -    build_append_int_noprefix(table_data, 0, 4); /* ATS Attribute */
> +    /* ATS Attribute */
> +    build_append_int_noprefix(table_data, (ats_needed ? 1 : 0), 4);
can't you use ats_needed directly?
>      /* MCFG pci_segment */
>      build_append_int_noprefix(table_data, 0, 4); /* PCI Segment number */
>  
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 95202c2757..5fd5ec7b49 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -69,6 +69,7 @@ struct SMMUv3State {
>      struct SMMUv3AccelState *s_accel;
>      Error *migration_blocker;
>      bool ril;
> +    bool ats;
>  };
>  
>  typedef enum {
Eric


