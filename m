Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1508DCCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 17:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQZJ-0005lb-Bu; Mon, 27 Oct 2025 12:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDQZG-0005l9-Kf
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDQZ2-0001Xk-Dn
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761584358;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j41cxjkghcTMvKJC+/FgnDUTcci1yx5wmZ+6lysiwSo=;
 b=b2QEXDGNmZJObAiAFdPzxtdYZtfBFgGHXr0CehP0Y//2L1CUtqZNsJwGXdnGu8ZtzGBgOK
 NGiFLia9/JxI+9PzG4tfGK8Y1irjBlWpvfeq2d751sqBZR2WBMsNz7i2X+elkNR5LrE2If
 bjNXdzQANm+2AIGBMMBR1QjUz7vMgp0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-7OOZqNaPOg-7-bszyfprDA-1; Mon, 27 Oct 2025 12:59:17 -0400
X-MC-Unique: 7OOZqNaPOg-7-bszyfprDA-1
X-Mimecast-MFC-AGG-ID: 7OOZqNaPOg-7-bszyfprDA_1761584356
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-470fd92ad57so60307495e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 09:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761584356; x=1762189156;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j41cxjkghcTMvKJC+/FgnDUTcci1yx5wmZ+6lysiwSo=;
 b=VT89ambjdSrlSC7t3e/AWg9PTRTb4n+hMOmnu82zmAgcT5pXK5wyLppUvSp8U/2Q7a
 9Sk+3C8TZ844++W5btqWTO/yGAbo2Zno2DUprXQK+fna1CfRNDEiKb/lnyaLEpo3H/QB
 /3rJwMgEoX1lzGnEzsma04dFSwSBaVGgRDUXoi8eVoBsCSdTK4hHA+NXZvc43MCLuz2f
 AbeYHqm/uuTd0bPTGLKdo86HNRQbaCbeWGpghMPTMiKY1Hg71RBaeQxVrf2t5atk27sF
 aTeh98u+KZwroc+CDfxhGcVdySNkW7Q1Vu2cMPGpHbV191jIGs855CicP5wu1kWEbiac
 SJew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg8mSKj0dU3qB7VCLmIsvTzs+5C7ryVtZDER01SdL45jHjViRuPDCME5Y+x2Q2vPZoDRCffCch79qg@nongnu.org
X-Gm-Message-State: AOJu0YxBaaWqHUAiJyECdYV55dA56WL6blg7+/BKk0STjMPX7w68zM0V
 B14wzcZfL/Uzl4uNwo6J6Ld7DQXqQZPqUMBEhAa5p5OmH8Htt/tW3skx5PIbssB0ZtQanKZhC9Q
 N+o2WPaoWkfMQZsG3hpHDhJQ8cFaNo3hA51NxXIk7pUOKwgcqAMIALeFO
X-Gm-Gg: ASbGnctvCqbxs08wnLBhFCBmEWZt08XfcBQ2FiQkpZlLeLVq2/NlGaboPZR/sltBrDS
 ngUmYvjPujsBq1TUgThbL3/8+rgi27NyjrjqS9qJBQpzqU06PK/K97jV/xTryqu+F2LN4A7sJdo
 DO7vTAAz2O1tSdTSqhez1hWJlFizrRg4vB3pzRwchHtV5d4MTJcaKtHFphgnagmRH3Cpa9Niszh
 n6/0y5KR4gOUYwMN0zt8/go3d3Wm9j7JFe/GBPSl3i5rdXpu1f6jjsFQK2p6ppDZQ39CIjSDm5x
 qSDcogNAnWpKwv4suRQ0Ygubp6B933aDOjV8HC8hP72uhTHu3LZzKnnAJvbIObpPPxI9Y0Dj5a5
 GyWAXBph1GV5d0zpaIevnJvHlI7KMW4Fw1Ppu2SwlMxpikA==
X-Received: by 2002:a05:600c:348c:b0:471:133c:4b9a with SMTP id
 5b1f17b1804b1-47717df534dmr3882925e9.6.1761584355950; 
 Mon, 27 Oct 2025 09:59:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa96xmk/c+cDmgl1bgmjVdrVJWi31AxMsNA3pamjA94ZGvPUVzp/R9y1J7EFlqJC3oAbPLLg==
X-Received: by 2002:a05:600c:348c:b0:471:133c:4b9a with SMTP id
 5b1f17b1804b1-47717df534dmr3881855e9.6.1761584354589; 
 Mon, 27 Oct 2025 09:59:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4a5cc4sm143041055e9.11.2025.10.27.09.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 09:59:14 -0700 (PDT)
Message-ID: <26f4d9b2-75be-4913-bb60-01e647a7ec83@redhat.com>
Date: Mon, 27 Oct 2025 17:59:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
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
 <20250929133643.38961-23-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250929133643.38961-23-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
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

Hi Shameer,
On 9/29/25 3:36 PM, Shameer Kolothum wrote:
> QEMU SMMUv3 does not enable ATS (Address Translation Services) by default.
> When accelerated mode is enabled and the host SMMUv3 supports ATS, it can
> be useful to report ATS capability to the guest so it can take advantage
> of it if the device also supports ATS.
>
> Note: ATS support cannot be reliably detected from the host SMMUv3 IDR
> registers alone, as firmware ACPI IORT tables may override them. The
> user must therefore ensure the support before enabling it.
This looks incomplete to me. ATS is a big topic in itself. I would
prefer we do not advertise it until we do not have full support for it
(including emulation). Comparing to
c049bf5bb9dd ("intel_iommu: Add support for ATS") which was recently
contributed we miss at least translation request implementations
(PCIIOMMUOps ats_request_translation callback implementation).

See:
https://lore.kernel.org/all/20250628180226.133285-11-clement.mathieu--drif@eviden.com/#r

Also in SMMU spec I see other stuff like STE.EATS, ATS skipping stage 1,
... Here I only see  SMMU_CMD_ATC_INV and this is only implemented for
accel. I think I would rather stick to the minimum in this series, ie.
reject in case of ATS mismatch (for testing purpose you will just need a
small hack until we get ATS support), work on ATS enablement in parallel
. Thanks Eric
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c    |  4 ++++
>  hw/arm/smmuv3.c          | 25 ++++++++++++++++++++++++-
>  hw/arm/virt-acpi-build.c | 10 ++++++++--
>  include/hw/arm/smmuv3.h  |  1 +
>  4 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index e8607b253e..eee54316bf 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -644,6 +644,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>      if (!s->ril) {
>          s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 0);
>      }
> +    /* QEMU SMMUv3 has no ATS. Update IDR0 if user has enabled it */
> +    if (s->ats) {
> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1); /* ATS */
> +    }
>  }
>  
>  /*
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 0f3a61646a..77d46a9cd6 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1510,13 +1510,28 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
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
> @@ -1934,6 +1949,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>          error_setg(errp, "ril can only be disabled if accel=on");
>          return false;
>      }
> +    if (s->ats) {
> +        error_setg(errp, "ats can only be enabled if accel=on");
> +        return false;
> +    }
>      return true;
>  }
>  
> @@ -2058,6 +2077,7 @@ static const Property smmuv3_properties[] = {
>      DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
>      /* RIL can be turned off for accel cases */
>      DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
> +    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
>  };
>  
>  static void smmuv3_instance_init(Object *obj)
> @@ -2087,6 +2107,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>                                            "in nested mode for vfio-pci dev assignment");
>      object_class_property_set_description(klass, "ril",
>          "Enable/disable range invalidation support");
> +    object_class_property_set_description(klass, "ats",
> +        "Enable/disable ATS support. Please ensure host platform has ATS "
> +        "support before enabling this");
>  }
>  
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index d0c1e10019..a53f0229b8 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -322,6 +322,7 @@ typedef struct AcpiIortSMMUv3Dev {
>      /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
>      size_t offset;
>      bool accel;
> +    bool ats;
>  } AcpiIortSMMUv3Dev;
>  
>  /*
> @@ -377,6 +378,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
>  
>      bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
>      sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
> +    sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
>      pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
>      sbdev = SYS_BUS_DEVICE(obj);
>      sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> @@ -511,6 +513,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      int i, nb_nodes, rc_mapping_count;
>      AcpiIortSMMUv3Dev *sdev;
>      size_t node_size;
> +    bool ats_needed = false;
>      int num_smmus = 0;
>      uint32_t id = 0;
>      int rc_smmu_idmaps_len = 0;
> @@ -546,6 +549,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          /* Calculate RMR nodes required. One per SMMUv3 with accelerated mode */
>          for (i = 0; i < num_smmus; i++) {
>              sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +            if (sdev->ats) {
> +                ats_needed = true;
> +            }
>              if (sdev->accel) {
>                  nb_nodes++;
>              }
> @@ -645,8 +651,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      build_append_int_noprefix(table_data, 0, 2); /* Reserved */
>      /* Table 15 Memory Access Flags */
>      build_append_int_noprefix(table_data, 0x3 /* CCA = CPM = DACS = 1 */, 1);
> -
> -    build_append_int_noprefix(table_data, 0, 4); /* ATS Attribute */
> +    /* ATS Attribute */
> +    build_append_int_noprefix(table_data, (ats_needed ? 1 : 0), 4);
>      /* MCFG pci_segment */
>      build_append_int_noprefix(table_data, 0, 4); /* PCI Segment number */
>  
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index c555ea684e..6f07baa144 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -69,6 +69,7 @@ struct SMMUv3State {
>      struct SMMUv3AccelState  *s_accel;
>      Error  *migration_blocker;
>      bool ril;
> +    bool ats;
>  };
>  
>  typedef enum {


