Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCA3CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 17:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCLcC-0005mn-Uz; Fri, 24 Oct 2025 13:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCLcB-0005mC-OQ
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 13:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCLc8-0001iM-8z
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 13:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761327006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Po0ZsHIuTfh9BHcobWkcqoztS2FY/PTjO9p9Kh1tBzk=;
 b=LcTsGUxmd5RipoxRiQL1owuy2YDbrIZQtxnnjqlHBApPKObGL3FLy7xosY10/CAWFPixI9
 cNcdRGG0jxUQ0Zqqu1GwzswqRHuX0qXx0WnXSkfcvQk/Hf1I4ZIQ5esI3unORLxKo9bFMi
 V5Evpz75Jiv4I6UvfUR541YNuqHlmB0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-_a0nYsixNE6gUfD89hxzGA-1; Fri, 24 Oct 2025 13:30:04 -0400
X-MC-Unique: _a0nYsixNE6gUfD89hxzGA-1
X-Mimecast-MFC-AGG-ID: _a0nYsixNE6gUfD89hxzGA_1761327003
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42851b6a659so2149603f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 10:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761327003; x=1761931803;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Po0ZsHIuTfh9BHcobWkcqoztS2FY/PTjO9p9Kh1tBzk=;
 b=EaqlrL+/sM1GARQQaQFB+dkBOIbOA+GeFAOKSuztncAihM8uN3XdIItl0BLksb6Vom
 qpG3Xd6A31QygSyY3N7Xi4+vyu/PPrOG6+vxi2cM3ij45JDlcG6HCuL5YtO0D44x+NWK
 IJN+Rl/TeSvxe1vCVmJ2RAK4C5uhQrUpXniF6HpWx/cuiepy/+38rdEFZU6/vCL6ZR+8
 twwmynScXBqP/R9phmX8yceqpnE2bJftBcHCAccBUkbqrb68nacPvc9d05WrmEXz1kWZ
 XNGEpzU7ve24u0Z77x43N4Vn7oHsgKooavZ8DkYaJamAzhoHSOIV7LTfIT6iaUnijPw3
 Gagg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2EM/1ESL71rzhdf6ILcb89wLWKpD4cE9kz+esm0wBiSycSPgO8bfHVQzGvchHglPocgxtZYI0jdV3@nongnu.org
X-Gm-Message-State: AOJu0YzodZLn0FBnsIOr7j7XtIrPhKMsgFR+YnOxyJ4DKk2RUBANVAx+
 xrEEnp2PtWzupdUEVdziqt2e/BDyj1h7O0ClxyEcwE5Z+8qEsSph9p/ZX3pdIvvXbB+rA2Ebcbd
 s9ZLTV3YoEwc4eY0tjEzr4A1OSPuQPshczyKKNIM37HgwVixD7lGy0lZC
X-Gm-Gg: ASbGncuW80wJ7bjjuTabVOiKPWCDL8DEFjSCWs/UAptPEsaQUQIYJpDNCCHEmDtMNSo
 XuOgbUpdCcasFho4TK6tHzBDGvI5xY+GYYsPFul6zodX1OzLz67ghorEuvuCsIuRtUYzfWzvR/I
 Co96g4Z5ZNq4cgU2OGT31bbqGnNhwKaXcBPeWUe4RVSpEUyxqhEzNcZHR+0vkzTdEuRklFwS6bV
 pY9fLsfBszmjofeZcKQzS3oRgnFa/ZyidwPXiavvmhFocuThAeXuEX5my2ig9yBkGOCrAV86R45
 x4SdE8ZDooK8f1Qc4buHJejKe4z5gDs2hZvlKGSrapGM5DEnC+CdIUTzhOQ5T6KuTDLuzgZc
X-Received: by 2002:a5d:5d81:0:b0:429:58f:400 with SMTP id
 ffacd0b85a97d-429058f0432mr5699614f8f.50.1761327002623; 
 Fri, 24 Oct 2025 10:30:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7cqC6khD8aPDZyTjWFqh1BX/hfWngITkMfCEo/VdfYEoz5XZ5znMwLmzusPWvkAzAS+cifA==
X-Received: by 2002:a5d:5d81:0:b0:429:58f:400 with SMTP id
 ffacd0b85a97d-429058f0432mr5699586f8f.50.1761327002164; 
 Fri, 24 Oct 2025 10:30:02 -0700 (PDT)
Received: from [10.54.0.145] ([147.135.244.229])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4298da9af42sm6177350f8f.40.2025.10.24.10.29.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 10:30:01 -0700 (PDT)
Message-ID: <75c219b7-a778-4697-bc8f-fd5ebc5b04a8@redhat.com>
Date: Fri, 24 Oct 2025 19:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/23] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-11-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251024084349.102322-11-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/24/25 10:43, Zhenzhong Duan wrote:
> When vIOMMU is configured x-flts=on in scalable mode, first stage page table
> is passed to host to construct nested page table for passthrough devices.
> 
> We need to check compatibility of some critical IOMMU capabilities between
> vIOMMU and host IOMMU to ensure guest first stage page table could be used by
> host.
> 
> For instance, vIOMMU supports first stage 1GB large page mapping, but host does
> not, then this IOMMUFD backed device should fail.
> 
> Even of the checks pass, for now we willingly reject the association because
> all the bits are not there yet, it will be relaxed in the end of this series.
> 
> Note vIOMMU has exposed IOMMU_HWPT_ALLOC_NEST_PARENT flag to force VFIO core to
> create nesting parent HWPT, if host doesn't support nested translation, the
> creation will fail. So no need to check nested capability here.
> 
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index ce4c54165e..7d908cdb58 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4636,8 +4636,31 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>           return true;
>       }
>   
> +#ifdef CONFIG_IOMMUFD


Before using CONFIG_IOMMUFD, '#include CONFIG_DEVICES' should be done
first. But as said earlier, this is something we wanted to avoid in the
intel-iommu model which can have different host IOMMU backends.

At first glance, it seems to me that these changes take the fast path
and avoid an abstract layer. Is it too complex to keep on using
HostIOMMUDeviceClass ?


Thanks,

C.





> +    struct HostIOMMUDeviceCaps *caps = &hiod->caps;
> +    struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
> +
> +    /* Remaining checks are all first stage translation specific */
> +    if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> +        error_setg(errp, "Need IOMMUFD backend when x-flts=on");
> +        return false;
> +    }
> +
> +    if (caps->type != IOMMU_HW_INFO_TYPE_INTEL_VTD) {
> +        error_setg(errp, "Incompatible host platform IOMMU type %d",
> +                   caps->type);
> +        return false;
> +    }
> +
> +    if (s->fs1gp && !(vtd->cap_reg & VTD_CAP_FS1GP)) {
> +        error_setg(errp,
> +                   "First stage 1GB large page is unsupported by host IOMMU");
> +        return false;
> +    }
> +#endif
> +
>       error_setg(errp,
> -               "host device is uncompatible with first stage translation");
> +               "host IOMMU is incompatible with guest first stage translation");
>       return false;
>   }
>   


