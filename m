Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1F0EFCD8A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 10:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzXty-0005wV-M2; Mon, 09 Mar 2026 06:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzXtj-0005vR-94
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzXte-0006T2-Nr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773052293;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsfuLPjL7R2VeAaDZOW9eIiFoe68uuih/4a9T+dUmlQ=;
 b=J8S7vL8XB9zeYR94IRB3sDV0+vBKZ8KX/hyEon9c1jMrp+dOslVMI82tTVWlUTu9F5MPiP
 YkXefqJIHn7nnAGgi7x9AvEIrCkalfu5AB1ahsIG4bGSbhAXFyzqZJkOfdIw5q8KUhWBeJ
 aVgeJceZ2r3wahd9Mk1eiHPQcqxQao0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-ZHG6n3sxPleiEfYY5DhYow-1; Mon, 09 Mar 2026 06:31:31 -0400
X-MC-Unique: ZHG6n3sxPleiEfYY5DhYow-1
X-Mimecast-MFC-AGG-ID: ZHG6n3sxPleiEfYY5DhYow_1773052290
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439beddef55so6081311f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 03:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773052290; x=1773657090;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsfuLPjL7R2VeAaDZOW9eIiFoe68uuih/4a9T+dUmlQ=;
 b=u7t7cN2dd3EUlBjPqIhdrarXIaOq1tw7bdM2MVD3tzQrtAHkRA0C/rHHlbXor5CIid
 DCTN/lMbRtxloZz9mh2pih8NotRC1/HcfecYJOmjFBKKZK1zwMXS3Mv/mQKJwChRoreC
 16W7/FuOKVLcXDKT1MvzG6Y0mrxKd7ZnOMESbRDgajoTddM+ksi/e3qUSugnMYLN/VnR
 bCusuF1xwy1K+/qZ2zgYclPlcULRJ3sZFxV+xz1YvjL/drJJ700N/v/ejXvDzvvCBbUs
 fuegynDat0fzRmX2d3lgLz9JFsdjltfkai76AtVEtMOI1JsAxvzTGT3GGl3mZHAgYs6G
 ml2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8vetYtsJILd6HZxx/Uzfg8AntzqTpB0Br+dMIC9vu9/fMT3rrAByPIdPRwkXanTOYm6wv4zbuU4ws@nongnu.org
X-Gm-Message-State: AOJu0YzEphxgBTWlVDJ4bh75PO1ZuIZJ4ACR+ZLGKl/ZLMnFfGmvHIcg
 Tn9ezXdfNLarTBhwc5WPXFDSLPSykPc29XM3tXlPpMb2+s15LOtbN/fwlDtMdlYz3nF8OIhVWbS
 Na/7UHzz3yhQCS1yKl93e7N88qTt4IXdnmnvD7V7uII+Wsy3C1iyYloy0
X-Gm-Gg: ATEYQzwDOMsgNMIjos0M755g0fcp4GfpwFRp6sP9lvSTujTVDUnNBu/cRTyh7x8FIzZ
 iM7XfMf/KAdcmlIK0D/8Jwgj1GJ/0JIe70Xmtn5tEkg6Hpm89K2JGNvoRIizpoC2zFCneR+LQhO
 xrhvGbtCHa284ycGVwRkTj90SIGmjU9BW0F5IaLxeaRF+mumfdBG/wL83Cmrl9BwosnsTmgB5j7
 T55JeMxjA2B0wXdLEGf8rTnItHgN/2ZVjTETsrdM0ppJSLFp1vgScAKZP+GmarYeIS5HyyXm+NZ
 QmhpTAW08ASEGyRJ0OcCkelPPsO49yN67OxFKJFx+FL+xMmnQl7bRoqd+t8WjnaVZoVl+vyTm+p
 oJn7TFydEDKy/SOoB0cxJ1Ohik0RiT51zLVxkQ3ecUJ22rjBqqf4Q3XkmsoEbtJq9KE/BBg==
X-Received: by 2002:a05:600c:3b8e:b0:485:35a4:939c with SMTP id
 5b1f17b1804b1-48535a4a188mr84759145e9.29.1773052290395; 
 Mon, 09 Mar 2026 03:31:30 -0700 (PDT)
X-Received: by 2002:a05:600c:3b8e:b0:485:35a4:939c with SMTP id
 5b1f17b1804b1-48535a4a188mr84758615e9.29.1773052289961; 
 Mon, 09 Mar 2026 03:31:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852470a654sm83147495e9.29.2026.03.09.03.31.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 03:31:29 -0700 (PDT)
Message-ID: <b3627b0d-5e21-46de-adba-1c9ec84fb602@redhat.com>
Date: Mon, 9 Mar 2026 11:31:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/32] hw/arm/tegra241-cmdqv: Probe host Tegra241 CMDQV
 support
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com, phrdina@redhat.com
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-11-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260226105056.897-11-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 2/26/26 11:50 AM, Shameer Kolothum wrote:
> Use IOMMU_GET_HW_INFO to check whether the host supports Tegra241 CMDQV.
>
> Validate the returned data type, version, number of vCMDQs and SIDs per
> VM. Fail the probe if the host does not meet the expected requirements.

Can you explain why it is important to check 

number of vCMDQs and SIDs per VM? 

>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.h |  5 +++++
>  hw/arm/tegra241-cmdqv.c | 32 ++++++++++++++++++++++++++++++--
>  2 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index 07e10e86ee..312064a081 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -10,6 +10,11 @@
>  #ifndef HW_ARM_TEGRA241_CMDQV_H
>  #define HW_ARM_TEGRA241_CMDQV_H
>  
> +#define TEGRA241_CMDQV_VERSION             1
> +#define TEGRA241_CMDQV_NUM_CMDQ_LOG2       1
> +#define TEGRA241_CMDQV_MAX_CMDQ            (1U << TEGRA241_CMDQV_NUM_CMDQ_LOG2)
> +#define TEGRA241_CMDQV_NUM_SID_PER_VM_LOG2 4
> +
>  const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
>  
>  #endif /* HW_ARM_TEGRA241_CMDQV_H */
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index ad5a0d4611..a270fa7ce4 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -38,8 +38,36 @@ static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
>  static bool tegra241_cmdqv_probe(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>                                   Error **errp)
>  {
> -    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
> -    return false;
> +    uint32_t data_type = IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV;
> +    struct iommu_hw_info_tegra241_cmdqv cmdqv_info;
> +    uint64_t caps;
> +
> +    if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
> +                                         &cmdqv_info, sizeof(cmdqv_info), &caps,
> +                                         NULL, errp)) {
> +        return false;
> +    }
> +    if (data_type != IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV) {
> +        error_setg(errp, "Host CMDQV: unexpected data type %u (expected %u)",
> +                   data_type, IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV);
> +        return false;
> +    }
> +    if (cmdqv_info.version != TEGRA241_CMDQV_VERSION) {
> +        error_setg(errp, "Host CMDQV: unsupported version %u (expected %u)",
> +                   cmdqv_info.version, TEGRA241_CMDQV_VERSION);
> +        return false;
> +    }
> +    if (cmdqv_info.log2vcmdqs < TEGRA241_CMDQV_NUM_CMDQ_LOG2) {
> +        error_setg(errp, "Host CMDQV: insufficient vCMDQs log2=%u (need >= %u)",
> +                   cmdqv_info.log2vcmdqs, TEGRA241_CMDQV_NUM_CMDQ_LOG2);
> +        return false;
> +    }
> +    if (cmdqv_info.log2vsids < TEGRA241_CMDQV_NUM_SID_PER_VM_LOG2) {
> +        error_setg(errp, "Host CMDQV: insufficient SIDs log2=%u (need >= %u)",
> +                   cmdqv_info.log2vsids, TEGRA241_CMDQV_NUM_SID_PER_VM_LOG2);
> +        return false;
> +    }
> +    return true;
>  }
>  
>  static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops = {
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric


