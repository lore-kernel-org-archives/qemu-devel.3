Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A545CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zQi-00018f-5O; Wed, 01 Oct 2025 12:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3zQf-000152-8P
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3zQQ-0004Ct-DD
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759335079;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2bm8nZkgQRRWW96fb3Oan/JNmjtAfHhBVULcb2tTdNY=;
 b=ChCOBfBJyBIhOMp12HltYAN1xXVZKYV/6+c6G0qRaxfn5UX9B6OO7tp4fyMridQTXD3mKD
 CEhOMGNbVOHj5ijtD7860IaBXCUHeMab/PTFqt6XrQGnRjYL1IlfKOXPSYu5Y2WGYqoeZr
 /zCB/3OOYI7AkDUEq3flo8V+P6Lrm5E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-NuTd3GTTOeODiTGlnhyMXQ-1; Wed, 01 Oct 2025 12:11:18 -0400
X-MC-Unique: NuTd3GTTOeODiTGlnhyMXQ-1
X-Mimecast-MFC-AGG-ID: NuTd3GTTOeODiTGlnhyMXQ_1759335077
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e377d8c80so27282875e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 09:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759335077; x=1759939877;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2bm8nZkgQRRWW96fb3Oan/JNmjtAfHhBVULcb2tTdNY=;
 b=rDE2tQWAckcxgu4N2JxftvHg22J9f9TVzEIlfPeq/vO5rrDKZ3gWqzW9YtfB5S7SEU
 uQixrws+3qj0QqVAmhYWrYQVjy7U1rjUKjDoMPgnuuu2O/rGzTAjyGiwiwxrxX9y5stI
 QaAwaInC+qlkevr7D6wMd157KK10pKEEj9GwI3+780/Y5AvfG868+Bk6rHF4y22g4vaY
 MDoANneU51XTiCxruNWk+OyOgZnGdGswPvb5RlBoMdFlY0QuOc7Y5bcMxGP6jtNxBCKI
 8dA+VvikGA+O8UQwunujTVE6VDtEp6zH5HjeyFQlZzuk4FG3sMVPpPWWMEka3iusqWmq
 rpJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdeMsKUpFUL5G8bFM5ZSttBS8QqmtTi8dpRM5bFvKHTSiUCL9tv9BfAVaaIkZhZCrspzAqxRkZKe5X@nongnu.org
X-Gm-Message-State: AOJu0YwzTBKndyLSu8v1ndYQq8DwgYj6ozXV57NcwtLP1MgNm5bVwow0
 2gSsufIL8SjStdfmgTDvAEYubZ97fRU0ClBBMFiOjStwISF2cDMzkZJLMjDJ2YAvWg4BGtmUAsx
 COqsMheaKCS3RBGNMkbPgnUWh/maV9vxHWdlcG440i/KCypTyKQLOXBoC
X-Gm-Gg: ASbGncu7mocn1EbgJpkGoIntiC4u3D9b6V+4kdho5snjAl5kwMuAf4BgAagtuynlC9G
 OlPTcTF0SJxvbBo8ZUt9D+kdO6UP8JDtJ96INtLVLk01jFDg4TEj1m3qYK7DgY2DvwaON36AM7e
 I/RGBlbCzEuwfyGD1gNROXgrjR0igMtcny3pl0GFLsjjwlJlB+DQeZZ8lmtHXyf0OfrWL0ojZjG
 noVPbZdOMCGRZASgrFNI4sZHcl6WED/WGZ6j5hv148XPbszvDUaQCeKxubXpkmT+T6ob+1emnNp
 uLpUU686tvh2FetvlTH05FgC40TVDscmsNHhqkRMmdJ1+z5ZPBqLbbfv1k6WfkPVKHilDqE4fJg
 TJ4VhgJmKx3WzBRsC
X-Received: by 2002:a05:600c:8b71:b0:45b:868e:7f7f with SMTP id
 5b1f17b1804b1-46e612c2374mr40659365e9.17.1759335077175; 
 Wed, 01 Oct 2025 09:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgN3B+NF5BIWOsWWRI4QVZIyAuiQyr8UW/tcE/XX4myve12HKHYjK/EkEMdiXz2AUb6Kw8sA==
X-Received: by 2002:a05:600c:8b71:b0:45b:868e:7f7f with SMTP id
 5b1f17b1804b1-46e612c2374mr40659015e9.17.1759335076726; 
 Wed, 01 Oct 2025 09:11:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602efdsm29306256f8f.34.2025.10.01.09.11.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 09:11:16 -0700 (PDT)
Message-ID: <6bc5a210-2c08-47a1-b7c6-f421d99505dc@redhat.com>
Date: Wed, 1 Oct 2025 18:11:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/27] hw/arm/smmu-common:Make iommu ops part of
 SMMUState
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 shameerkolothum@gmail.com
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-5-skolothumtho@nvidia.com>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250929133643.38961-5-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 9/29/25 3:36 PM, Shameer Kolothum wrote:
> And set to the current default smmu_ops. No functional change intended.
> This will allow SMMUv3 accel implementation to set a different iommu ops
> later.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmu-common.c         | 7 +++++--
>  include/hw/arm/smmu-common.h | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 59d6147ec9..4d6516443e 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -952,6 +952,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    if (!s->iommu_ops) {
> +        s->iommu_ops = &smmu_ops;
> +    }
>      /*
>       * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
>       * root complexes to be associated with SMMU.
> @@ -971,9 +974,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>          }
>  
>          if (s->smmu_per_bus) {
> -            pci_setup_iommu_per_bus(pci_bus, &smmu_ops, s);
> +            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s);
>          } else {
> -            pci_setup_iommu(pci_bus, &smmu_ops, s);
> +            pci_setup_iommu(pci_bus, s->iommu_ops, s);
>          }
>          return;
>      }
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index c6f899e403..75b83b2b4a 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -162,6 +162,7 @@ struct SMMUState {
>      uint8_t bus_num;
>      PCIBus *primary_bus;
>      bool smmu_per_bus; /* SMMU is specific to the primary_bus */
> +    const PCIIOMMUOps *iommu_ops;
>  };
>  
>  struct SMMUBaseClass {


