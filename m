Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB86FD41C20
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 11:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTeSd-0003gw-1R; Thu, 11 Dec 2025 06:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTeSP-0003ea-8Q
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:03:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTeSM-0008Ix-9v
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765451011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GGohEYELsW4lOpTe7VI/PHuPN7NfP08k+8esVMf+pN4=;
 b=dZr3qxBr344nKvQ8br7oG14ApaXVJ3B1fHOTxo3y/ffdKRzZIVnAbxAg84OBvUNG2zDp4o
 PA/ONjEXdnHytFN6wdRsh0qOp9W8M/2MQnOOLFlBmIIWO2nC7V885jZAryIff2BSndwiy6
 NyN54CqLSbu1CWKMUQCIXXl+EIAutcM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-8NBqZxK-OJSFyrpg-FCM1g-1; Thu, 11 Dec 2025 06:03:29 -0500
X-MC-Unique: 8NBqZxK-OJSFyrpg-FCM1g-1
X-Mimecast-MFC-AGG-ID: 8NBqZxK-OJSFyrpg-FCM1g_1765451009
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b5556d80bso432433f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 03:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765451009; x=1766055809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=GGohEYELsW4lOpTe7VI/PHuPN7NfP08k+8esVMf+pN4=;
 b=ocxrUAq+fcwwn9xD0SAyjmsZ62M/NbEjxJoga20qfFVpTl1Z9MxLw0849yR2uqBUoq
 Pv6wpm4nGhdBW6p8Jo7MuIVznuVEPpmg0OiNpdRLV1TRvdKFBdcE4ThlR1+qj6LkqRNS
 uiyur1AKEoy8wM0MppIzw9QQibbTz2Plrg0eUmBSeZ4IpQKtW3jKd4sg15Hs2zGfNUFB
 vr/X6Tlvt90QvePHYThbSMGIYoW51sReiiy6cCyYA14KFEWR5g+gn8itagCHe0c+Zdjs
 Yzo7T2topMT8YMusEhixlJNhvg0zRbQQOcWrA7hekJNWp7yyCNCOque5snUs24OpngOF
 XIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765451009; x=1766055809;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGohEYELsW4lOpTe7VI/PHuPN7NfP08k+8esVMf+pN4=;
 b=sh1Cql0xR7QhFCQXQT1a0Am1CcFffat+Pzjb+MXDAXeo6U3m42sQJ8hSENdGhndNny
 hJL4hTgwP/i66bOR8lidlTEqsDQwZbHysRCb+gHx/PS8mpaX+TWd5Arku2z//zzNI/Ea
 f7Q6Sq6JhxJG82wmThUJRbslvhV3W2wBn279wk5cXBye0flMyv5EuzoUYj9zW77wd/gG
 NRGkpqZMDC2kROV/oSq8qxqeYhCvO3pFQm0gtNPedawCPMZC7ln0CuCsZ3XR9uhPEi+m
 kyGVwYc8hsES+tXy4mZ/C8wSaRvzpXONukEFzHFij5ODFSzPeSg3BXedj6/F30PzBSoM
 FXiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWylxQRXXr2xDMGJxV6dImduR/ZE5fVnF6JFbLud85W+CC3e2EFHzz78mTakDahaUyGTbBdduENfIlD@nongnu.org
X-Gm-Message-State: AOJu0YzIEu04uByXVyvvzUQW5UrUG1bvaAPB3dok5oyrk0wjAcFXFFdw
 DR7xbXUAtNOKPLTOOAHbDXqWQwTCAujxdMUclHvJIYJQxJsj2eb8lgGBPaJaM4bABAJo42AYqh8
 26gdvltvNJGyrX4lPorPIOFe2RGJkKYp+OkQgKSOrykCr13C+6AVjhmcy
X-Gm-Gg: AY/fxX5Pc1r1CpBtDiszvfocsevCekaMgAaaD+Nq9M+hAIeUdN2orU0ZSpNnju0I2Qw
 pmx3tnGn18IdYS5o8+aaWvA3y9EEd1EMpF4OwD2NxHglq0f+JPM3jTZz0ksIlWQp5jYIMX6VAlk
 y3wucM9FcgYSs01s63U3zpnnO+VFELE1+ErUm4HeeyffECmlW7QHp3uckdzO2+LdmgxEZdqB/f2
 BbgVqACn8uXW3m2UjE6h0sUdAdihc9ybAB/TN8cRWoedzziT3w3Tsb39JPkh8VTSejZzwz4akrz
 BrQ50zdlMGSAAtWPVe1XiDVBkMab8BrWHHE12rY6bruZSKdWKcAeax/VbD+ZKkQCkbfcYA2kIIC
 6iZ5PgYeDF9VhC+/YPTTUTDz1i/C7mLIoD6Z8ASOyaJaF8ojP
X-Received: by 2002:a5d:64e4:0:b0:42b:36f4:cd24 with SMTP id
 ffacd0b85a97d-42fa39d3cc5mr6750214f8f.24.1765451008584; 
 Thu, 11 Dec 2025 03:03:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSHtQzXH0D7Y+Mja7Or4LGwcYDRYTnQ4htFAIhky5A5AqPCiF0pjxdMFps5aIP/BmDxbp0dQ==
X-Received: by 2002:a5d:64e4:0:b0:42b:36f4:cd24 with SMTP id
 ffacd0b85a97d-42fa39d3cc5mr6750168f8f.24.1765451008048; 
 Thu, 11 Dec 2025 03:03:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a66b97sm5168883f8f.7.2025.12.11.03.03.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 03:03:27 -0800 (PST)
Message-ID: <5d7577d0-556b-4ce0-962a-7ec21e2ea0a7@redhat.com>
Date: Thu, 11 Dec 2025 12:03:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/33] hw/arm/smmu-common: Make iommu ops part of
 SMMUState
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, ddutile@redhat.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-5-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251120132213.56581-5-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Shameer,


On 11/20/25 14:21, Shameer Kolothum wrote:
> Make iommu ops part of SMMUState and set to the current default smmu_ops.
> No functional change intended. This will allow SMMUv3 accel implementation
> to set a different iommu ops later.

Hmm, shouldn't this be a class attribute instead ? I will check the rest
of the series.

C.

> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/arm/smmu-common.c         | 7 +++++--
>   include/hw/arm/smmu-common.h | 1 +
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 59d6147ec9..4d6516443e 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -952,6 +952,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    if (!s->iommu_ops) {
> +        s->iommu_ops = &smmu_ops;
> +    }>       /*
>        * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
>        * root complexes to be associated with SMMU.
> @@ -971,9 +974,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>           }
>   
>           if (s->smmu_per_bus) {
> -            pci_setup_iommu_per_bus(pci_bus, &smmu_ops, s);
> +            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s);
>           } else {
> -            pci_setup_iommu(pci_bus, &smmu_ops, s);
> +            pci_setup_iommu(pci_bus, s->iommu_ops, s);
>           }
>           return;
>       }
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index d307ddd952..eebf2f49e2 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -162,6 +162,7 @@ struct SMMUState {
>       uint8_t bus_num;
>       PCIBus *primary_bus;
>       bool smmu_per_bus; /* SMMU is specific to the primary_bus */
> +    const PCIIOMMUOps *iommu_ops;
>   };
>   
>   struct SMMUBaseClass {


