Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA3DCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 13:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUlhA-0008Ih-6K; Wed, 03 Jun 2026 09:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wUlgz-0008Hh-Dz
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 09:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wUlgw-00032i-Eb
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 09:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780493487;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NClKrh1w7sQfgBR0erzztR5juE216bC7a2pQEV9Eg1k=;
 b=XabPAHPSZamasCK14hCSCMnThHNN7YWNBUam6FvyNjufzSy07J9n/IhHyblNVP3jYsA97Y
 +4opbtqA0fWrjkuzoz65nn+poHWbOB7fjs0emqAB4t5vBrWiC3HTx0LOwBNZ6z/adDLxlA
 u8k7yw0bBp0X8M8ZUcKyGVUBq4sP58U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-9yFuNyu1NOKEJgadAsyEpA-1; Wed, 03 Jun 2026 09:31:24 -0400
X-MC-Unique: 9yFuNyu1NOKEJgadAsyEpA-1
X-Mimecast-MFC-AGG-ID: 9yFuNyu1NOKEJgadAsyEpA_1780493483
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-bec405b1c6fso324805366b.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 06:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780493483; x=1781098283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NClKrh1w7sQfgBR0erzztR5juE216bC7a2pQEV9Eg1k=;
 b=sfz5Mwcq9sxlptnvUHdFZOF9snkCc/o1llrbSzCrspnRBChQK06fHG5f7BLjvKyl6T
 rX3z7ulTNEzZYxSfm6QYR30G12tf20MWpGVOLuSwdmSRAcF5q1YMIOyCdRVG5WS8KgM7
 QO3oFdzoXehb+ouQi0XXQfEFGmxVBztiuTi/CbJ/imrdN56CQHRQl68upPfyVYOpd/BZ
 imqvEjrVjYAot6PIU5YS5q4qF8RRuJpHgYev8fxrnoPtBNk2vQ/fyzpjfPC5mWKnLMZY
 z/wrxViMBhHhkph7YakItLDksqWSX1ruy1zPlGnAPVWs45oh1/PAw0ObhBNv1UBEdKB8
 j19A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IH2SiUYHkSNeGZQvBppFNUMDISFTUo8p3ETIFkH4EUteIrEimRaePQO+ooHIuLzIowKtjxUNct0an@nongnu.org
X-Gm-Message-State: AOJu0YwF80LsDbCPyS6R3UDzTfysaWBnysIpHv/H7gEIbC0QFBSfAQRN
 4OtHRhw5GbUm1JppFqdrbslxFfBswtn5WdxJZCIEJBFujfuauXhuA7PiMb8WHP416lsO5i8vftN
 Wx0qfkjI/wUHo8JAkJP4oj7aHGVAb0mL7v0XpUsUtySZ0m6TlbhRUF2Du
X-Gm-Gg: Acq92OE/zyGD4uIOYfTsk3QrrFW43TwZ3O1aqbNnePjyJBzUm12NAyldxacC5fJzFfv
 nwgUEWQMY8V4Qyypul4Jozs25siqpWsTcAYhQWrYBS5u97YB/o4fh3kOCFvWuxsi9xcm6TP0suG
 4MP2X2nolWk16f8MD4Uxaqa80r5uzgIRLwWb/WxSfVJnRoq+g5jOYHY13B1aodsvTiiiTFVDWm9
 yRf5SGGuNOa5/DeJcg1jueLIJTAIITMGI1NJWQ2XxN5UlKosbeTwAiBA2czvUjHnSS3qdv/CBok
 UcbciTfVhlzkLC8R7s7qoho7RyhkBq43get0DDonp54a9+MxxKRnpDWgZWBMb2kRpolNhDzDeVE
 ruKxlD1ci3oxb09iBaVb/qrnfZBSqHkqFOj8HfjcX7n8xdrJPmWph2HF1G7rxpmODZpPlQ+Cqr3
 4RR6sY
X-Received: by 2002:a17:906:730f:b0:bec:fa92:d36c with SMTP id
 a640c23a62f3a-bf0b36a4e53mr178667566b.38.1780493482687; 
 Wed, 03 Jun 2026 06:31:22 -0700 (PDT)
X-Received: by 2002:a17:906:730f:b0:bec:fa92:d36c with SMTP id
 a640c23a62f3a-bf0b36a4e53mr178662966b.38.1780493482217; 
 Wed, 03 Jun 2026 06:31:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf055307aacsm157525466b.47.2026.06.03.06.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 06:31:21 -0700 (PDT)
Message-ID: <b737a849-258f-455a-af1a-8eb61a2500e8@redhat.com>
Date: Wed, 3 Jun 2026 15:31:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/31] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
 <20260601114221.457995-7-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260601114221.457995-7-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 6/1/26 1:41 PM, Shameer Kolothum wrote:
> Command Queue Virtualization (CMDQV) is a hardware extension available
> on certain platforms that allows the SMMUv3 command queue to be
> virtualized and passed through to a VM, improving performance.
>
> For example, NVIDIA Tegra241 implements CMDQV to support virtualization
> of multiple command queues (VCMDQs).
>
> The term CMDQV is used here generically to refer to any platform that
> provides hardware support to virtualize the SMMUv3 command queue.
>
> CMDQV support is a specialization of the IOMMUFD-backed accelerated
> SMMUv3 path. Introduce an ops interface to factor out CMDQV-specific
> probe, initialization, and vIOMMU allocation logic from the base
> implementation. The ops pointer and associated state are stored in
> the accelerated SMMUv3 state.
>
> This provides an extensible design to support future vendor-specific
> CMDQV implementations.
>
> No functional change.
>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/arm/smmuv3-accel.h | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 87fecb5c68..b45f25ad03 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -10,11 +10,44 @@
>  #define HW_ARM_SMMUV3_ACCEL_H
>  
>  #include "hw/arm/smmu-common.h"
> +#include "hw/arm/smmuv3.h"
>  #include "system/iommufd.h"
>  #ifdef CONFIG_LINUX
>  #include <linux/iommufd.h>
>  #endif
>  
> +/*
> + * CMDQ-Virtualization (CMDQV) hardware support, extends the SMMUv3 to
> + * support multiple VCMDQs with virtualization capabilities.
> + * CMDQV specific behavior is factored behind this ops interface.
> + */
> +typedef struct SMMUv3AccelCmdqvOps {
> +    /**
> +     * @probe: Mandatory. Vendor-specific device probing.
> +     */
> +    bool (*probe)(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev, Error **errp);
> +    /**
> +     * @init: Optional callback. Initialize CMDQV hardware.
> +     */
> +    bool (*init)(SMMUv3State *s, Error **errp);
> +    /**
> +     * @alloc_viommu: Mandatory. Allocate CMDQV viommu resources.
> +     */
> +    bool (*alloc_viommu)(SMMUv3State *s,
> +                         HostIOMMUDeviceIOMMUFD *idev,
> +                         uint32_t *out_viommu_id,
> +                         Error **errp);
> +    /**
> +     * @free_viommu: Optional callback. Free CMDQV viommu resources.
> +     * If NULL, the viommu_id is freed directly via iommufd_backend_free_id().
> +     */
> +    void (*free_viommu)(SMMUv3State *s);
> +    /**
> +     * @reset: Optional callback. Reset CMDQV state.
> +     */
> +    void (*reset)(SMMUv3State *s);
> +} SMMUv3AccelCmdqvOps;
> +
>  /*
>   * Represents an accelerated SMMU instance backed by an iommufd vIOMMU object.
>   * Holds bypass and abort proxy HWPT IDs used for device attachment.
> @@ -27,6 +60,7 @@ typedef struct SMMUv3AccelState {
>      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
>      bool auto_mode;
>      bool auto_finalised;
> +    const SMMUv3AccelCmdqvOps *cmdqv_ops;
>  } SMMUv3AccelState;
>  
>  typedef struct SMMUS1Hwpt {


