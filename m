Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F96ECCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 16:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFxqR-0004JZ-5G; Mon, 03 Nov 2025 11:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFxqP-0004Is-CN
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 11:55:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFxpy-0004v1-4f
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 11:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762188919;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X2cAERQ/ID0qu6QDCSNNv+8p4SV0o7TWZjUbVHbwT8c=;
 b=AQUJDGG8TRWIbYar6AOXUJkgEn465Nnpgo4T1SZvRwkeu7gzmYAmtR/9E8y8E4hgEcaNjI
 rTygzImsqkXzA43dM8TI8QvXZVnypTDf5bUb/m7Dzr40MQSrAkG0XKZqqwVmcn+vNY0NO/
 Au5upcqoMRBiI/xTn5KOKWVZA8P76WY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-S0xxf0GLOy-PtzbzcJxm3A-1; Mon, 03 Nov 2025 11:55:17 -0500
X-MC-Unique: S0xxf0GLOy-PtzbzcJxm3A-1
X-Mimecast-MFC-AGG-ID: S0xxf0GLOy-PtzbzcJxm3A_1762188917
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47717c2737bso18080105e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 08:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188916; x=1762793716;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X2cAERQ/ID0qu6QDCSNNv+8p4SV0o7TWZjUbVHbwT8c=;
 b=RkbYC+69iyP4dry7hK6w9HopHm67aQCdrssL1O0BaTqER73NYcKHb4CgzEFezxpeeb
 vXf1LarBAiSrqMSSj3EcfD9BfkiZzw7yZ7xUfsnJO7RYO0YpDWsyZOp8vPWNnWtMyJhx
 p9I9e1FzKQqJc8C7C7Gtcss7IBLlPnng/k0ib5Om6PBQ6ZfM3VrILTWLo+sDsqWhJfaK
 QraNcfcpGBHhVpx2wh/tjFTNqVkf/ZI1HDx884xln1/olXOC4dER8jRG25HhQkWAGljA
 ow0RdG8q1UVmyhxGN88SaGzgCWhtfluzZeI+vPNb2v7HvovCRhfWPSilb4APOp54TliQ
 hSug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcuxNa3s+e+0AW+uvuLYkNhjzw8HcxYodvEL7xT/AMU28bSAPxIxLemydAELx7CetRioQG/dLQrLpL@nongnu.org
X-Gm-Message-State: AOJu0Yw3OftHkJkIzCG+nhL6BIZRMwEuDY2LqRq2HPbs6SHCWVXGnq19
 eqJC7YjFQU1570sddXcP670liaFp4PVok1umrI/JT/rXSWgzpiCDdHf3LWPdDSbxso4mrvIaBWM
 BVb8HjPQtuP+hDkM/PmWUHOg8aGaeTAKqaPIKpRn2LF/o94q1daL7j+qf
X-Gm-Gg: ASbGncuEsFdbv1pbrytxnkQM5+UIRE9uem0lL5833wqiIxwS3olheTZTgBKjJoMrE9S
 5qglyB/8PhAW5g1XrLr6QZNk6TkTYs1Nt9r01ZBeIaeKgjbmQSSqwXrASlGzAq9EQ6mMigM7IYb
 NV4au9HN9FmLLDxLbaCNhmoW1xiH0rZXk65YrgOb3rb980WkwcN5Hk1Bc/bAMsSawb5cPuS/osU
 MNLFMcNlGP6Ln8T2lN5z8UiQaz27T9olWLsxQ+EDpMC5DRQInhkj8W8oH9H8+WMivQPiT6+uiIy
 JvVjSYonU9AdFnPXdyGBQKW2vOCB2sUvsJEo4w6u/yWJRczsLmdx4fp47hst7fJlFtkO3JUJXF3
 NZHGXq0ZdxGsvLJZZn2IhUEXU36feyw4yfcChpsfjjfp+/g==
X-Received: by 2002:a05:600c:3b1f:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-477308a8988mr125449765e9.37.1762188916520; 
 Mon, 03 Nov 2025 08:55:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLkZKXJF91fq0KhnKiOtjkk4yg6GJ3EqFHSdGAzmmLnM1fzJTnZ+QK4fvUPTNFCqs1tT+LXg==
X-Received: by 2002:a05:600c:3b1f:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-477308a8988mr125449515e9.37.1762188916094; 
 Mon, 03 Nov 2025 08:55:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772fabe2fbsm96917235e9.0.2025.11.03.08.55.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 08:55:15 -0800 (PST)
Message-ID: <118d572b-e19d-4762-bcdc-f0e8204be4ea@redhat.com>
Date: Mon, 3 Nov 2025 17:55:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/32] hw/arm/smmuv3: Implement get_viommu_cap()
 callback
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
 <20251031105005.24618-12-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251031105005.24618-12-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/31/25 11:49 AM, Shameer Kolothum wrote:
> For accelerated SMMUv3, we need nested parent domain creation. Add the
> callback support so that VFIO can create a nested parent.
>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3-accel.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 550a0496fe..a1d672208f 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -10,6 +10,7 @@
>  #include "qemu/error-report.h"
>  
>  #include "hw/arm/smmuv3.h"
> +#include "hw/iommu.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/vfio/pci.h"
> @@ -119,9 +120,21 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
>      }
>  }
>  
> +static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
> +{
> +    /*
> +     * We return VIOMMU_FLAG_WANT_NESTING_PARENT to inform VFIO core to create a
> +     * nesting parent which is required for accelerated SMMUv3 support.
> +     * The real HW nested support should be reported from host SMMUv3 and if
> +     * it doesn't, the nesting parent allocation will fail anyway in VFIO core.
> +     */
> +    return VIOMMU_FLAG_WANT_NESTING_PARENT;
> +}
> +
>  static const PCIIOMMUOps smmuv3_accel_ops = {
>      .supports_address_space = smmuv3_accel_supports_as,
>      .get_address_space = smmuv3_accel_find_add_as,
> +    .get_viommu_flags = smmuv3_accel_get_viommu_flags,
>  };
>  
>  static void smmuv3_accel_as_init(SMMUv3State *s)


