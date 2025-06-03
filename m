Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B86C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 09:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMOHz-0008EP-DE; Tue, 03 Jun 2025 05:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uMOHw-0008Dt-4J
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 05:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uMOHt-0002EN-Sr
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 05:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748944226;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mv58T/W6RsypO84fxS5nOpnQQLugeAy7hvEtVnn7U8M=;
 b=Fc/Fi4X5nO94gCGENJBQPmJ2d7exFJIsjz/uHFfuTTpXS3X+7tpRHQZof4UI9Vj4W2iyyL
 pDENBcQER2BkBcvAwqqIN7d6vmLSPdYQmXQlZALIL7kyW7WA55TDDeMBj6gIrCcAtsv6Vv
 OatyGJshHWvmciC0yOnpwDbA28GNH6w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-HJf4kIUnN9ayXPyZeKwkJg-1; Tue, 03 Jun 2025 05:50:25 -0400
X-MC-Unique: HJf4kIUnN9ayXPyZeKwkJg-1
X-Mimecast-MFC-AGG-ID: HJf4kIUnN9ayXPyZeKwkJg_1748944224
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450cf229025so15181765e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 02:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748944224; x=1749549024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mv58T/W6RsypO84fxS5nOpnQQLugeAy7hvEtVnn7U8M=;
 b=kFl0KKOZAyfo+bX2c0K3EbNM5a3q1Xw0jSCdwE+a8Difn8IvQtBykzVbldbRg4lbxM
 AOquzUeRUDrQqa4qtgX1ovsi8oTELPtOsR4DZO9GC4/7rte36iOYGDMLBCdcdt+DEDcj
 PSYS5jHVE/PYTkQpFRhfstsFqols5lTsQg5YsG5v1gZg7b3pCrZ9B7TK1k+out+4wxsI
 7lfBmVn73Ulfwh6r2GFuz5pElLTqyRfI34HDbLdQZ++5P+K2ZL4TxzNZr+XKu9jUxFqD
 abzyawQOlT3pZqMPHygjy5bXarTpmd7fcRfD4hmBlaAbnz7vDWir8XV6JiSgqTPd7b2v
 moUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBxr4KwCk79iQx1pJsV45Fw9CNWcGtWuu4i1GnF8yN4FN3686yHBlfZ9oqnDFT8HK8HZuGdAKdbo3P@nongnu.org
X-Gm-Message-State: AOJu0Yws3lZn5W1Z96olaPT0xRJUw6fkmYcpcdEZ6apsfaDrdZS8wu7s
 SQg3xJY6Gg4k6NFxpgQ9T439ojQGRSpeV+O9BZYdYv5zhJO7HczQmNOo4qeZ6ztbF+thatjUUXd
 asesLdd3ZRcVUi+3PCL4yGFoR2YCYtBbDWIOlZqwMR7Xy7ntYVGkFSr4J
X-Gm-Gg: ASbGncudEu9mTQsX7l/w4MziIb+T3OUX5wDKZE4mxjUb+Wv+mh2mPUjhuq4UZO5pT2W
 uDlfmxx2lJYs0q3zN7gW484G2IaEX7h0rNPGRNyk9+PfPOb3eel94jnDMIA7thhJGIPp51Cftlr
 tEKFd3+b9iGMHZti0V0Gt5Avpm8E9kUs8Ya2cKwe1KoK18RTl7JiBViRgVA69RgmT46xlEkgd6t
 V0T5PkyOpTfYE2KEk0iI8TAItkp7+jplIhw1F4TDjFuf67yvehRZ1tolAsul2Q3d+pqRovPly42
 WJiZA/fBLdU/VdmvMLYSV0wGqMK9jILKQDK03QgvXeXmRMO0S9Z6/+Tis00=
X-Received: by 2002:a05:600c:6488:b0:442:f4a3:9338 with SMTP id
 5b1f17b1804b1-4511ee1215emr95955625e9.21.1748944223762; 
 Tue, 03 Jun 2025 02:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOVYPeTq8RpTOkVgEndqZNuwmfjtPkVmKaUbIGAoSgUTFFBy8yfaDsvBXWmhvQGk63ouO5wg==
X-Received: by 2002:a05:600c:6488:b0:442:f4a3:9338 with SMTP id
 5b1f17b1804b1-4511ee1215emr95955345e9.21.1748944223420; 
 Tue, 03 Jun 2025 02:50:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb0467sm155256605e9.19.2025.06.03.02.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 02:50:22 -0700 (PDT)
Message-ID: <ba4ac9e4-f8ca-4885-b2ab-6acdca51175b@redhat.com>
Date: Tue, 3 Jun 2025 11:50:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/virt: Check bypass iommu is not set for iommu-map
 DT property
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, ddutile@redhat.com,
 linuxarm@huawei.com
References: <20250602114655.42920-1-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250602114655.42920-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/2/25 1:46 PM, Shameer Kolothum wrote:
> default_bus_bypass_iommu tells us whether the bypass_iommu is set
> for the default PCIe root bus. Make sure we check that before adding
> the "iommu-map" DT property.
>
> Fixes: 6d7a85483a06 ("hw/arm/virt: Add default_bus_bypass_iommu machine option")
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Eric
> ---
>  hw/arm/virt.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9a6cd085a3..99fde5836c 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1487,9 +1487,12 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
>      qemu_fdt_setprop_cell(ms->fdt, node, "phandle", vms->iommu_phandle);
>      g_free(node);
>  
> -    qemu_fdt_setprop_cells(ms->fdt, vms->pciehb_nodename, "iommu-map",
> -                           0x0, vms->iommu_phandle, 0x0, bdf,
> -                           bdf + 1, vms->iommu_phandle, bdf + 1, 0xffff - bdf);
> +    if (!vms->default_bus_bypass_iommu) {
> +        qemu_fdt_setprop_cells(ms->fdt, vms->pciehb_nodename, "iommu-map",
> +                               0x0, vms->iommu_phandle, 0x0, bdf,
> +                               bdf + 1, vms->iommu_phandle, bdf + 1,
> +                               0xffff - bdf);
> +    }
>  }
>  
>  static void create_pcie(VirtMachineState *vms)
> @@ -1612,8 +1615,10 @@ static void create_pcie(VirtMachineState *vms)
>          switch (vms->iommu) {
>          case VIRT_IOMMU_SMMUV3:
>              create_smmu(vms, vms->bus);
> -            qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
> -                                   0x0, vms->iommu_phandle, 0x0, 0x10000);
> +            if (!vms->default_bus_bypass_iommu) {
> +                qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
> +                                       0x0, vms->iommu_phandle, 0x0, 0x10000);
> +            }
>              break;
>          default:
>              g_assert_not_reached();


