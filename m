Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CB8CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 16:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCKpP-0005Ic-Os; Fri, 24 Oct 2025 12:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCKpO-0005IF-2e
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 12:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCKpL-0003b8-8i
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 12:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761323981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TAM+kEwGnc13nxGSKhY/nW5JwV9NrtpZi41A2zGVfVY=;
 b=UhKblTbBZp4yDfv2BgyHoUsdqzsAQqyi12C3RSwHmQDXQuzGyRuA38QxAiNR3j7QvmVNiR
 ijUADxR0u9nQELwIYiuwyT4zqjYiSU3u7vybU8xWS1mbUyvexQ+1sxcuxCJb1XrUNLnj47
 V4sHn2luEetgsE5c3RiaSgrLjm7Whfw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-uOJ3Tz9jN1Sso3WesdIi_A-1; Fri, 24 Oct 2025 12:39:39 -0400
X-MC-Unique: uOJ3Tz9jN1Sso3WesdIi_A-1
X-Mimecast-MFC-AGG-ID: uOJ3Tz9jN1Sso3WesdIi_A_1761323979
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4721b4f3afbso9053805e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 09:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761323979; x=1761928779;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TAM+kEwGnc13nxGSKhY/nW5JwV9NrtpZi41A2zGVfVY=;
 b=svNo7HyB9MFUQYT8fyuP9sC7VAuer01GCTlOo1iPWfjadS4XdRzbS1MbyQvoApEdAI
 4jqrgP99XAiO85Ue5SoxIhaF0Q55Gd6ls1hTptJFQYxIIj/kFG7FBY83yKGsvEIawDyY
 ms6wSk3ZYq5CVSG4h94SmW6gq7ztL9kGgnoq7Rv2mFuw6ZfYPrha1z2NQRQ7yWT2PugK
 5aGwePKpBVEXmrndi9crehboCdzWnpt2oCpo1xmJtosRHzS7wO27sYn9oSKAUwV8ALof
 O7szOlbX+nxWpfr9Gamc0cTg0/lJs7M4tgZLLXgLnvD56QGber+PQuVBDxX5DfcI0a9t
 /dCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDkI6qm5V+jmm7xJqI206Z64Pyf6pn7bRIRkG8+dkMwEplVGLnYcgflQZqrmtJUDrmhzV3impl3Pjg@nongnu.org
X-Gm-Message-State: AOJu0YyZixvOd2rIijGASf5uLkKmfEpg4JBppNq3edcoQ+b9tFtE4GLC
 rxYU7wOS75fA3azFissbpovA+7wiZC2MoyecKqrs7T8YhW/ROJPTpHww+YT3rxRUekwqs5tD8si
 8iNBx/s+dqo7eRmVh/aUuxYSRn51GJDS2ca5xdMcFuOeCWgYrUTVlCTOd
X-Gm-Gg: ASbGncsHbgBKrX7woN6SazHTIBs0GgFn3h533G5oiOWgvyqP6qRZIjpw+bQDCgODtHY
 t3pbIDMLvhl36+Plo4nH29l9Q57Kl7ssXVJH/Lr/Qz7cnkC75Xti5+wGEAJz+TGb9rm3BlGUZpJ
 9d+ays2nvkeNGv/iozECj/CnTTXj1WtFpc5ya4Y04ZW6LGlhf/YA5YBx5llJKw1QZDV/IWssWG8
 2WzLkbBunxCMLOF1EbYniDmmwJd2lF+dpfrEkqkcR97GvGvYSXN1LBrZ3+5L9DAnNaCN7vMPLUi
 afILGEFj/jU6T+rHO9IEOAXHyFsL+D5gHwVafjH5XV3K2GE/hsFciYbUxAeL9Yxtu5JDY1Uc
X-Received: by 2002:a05:600c:1546:b0:46d:ba6d:65bb with SMTP id
 5b1f17b1804b1-475d2ecb307mr27887725e9.31.1761323978653; 
 Fri, 24 Oct 2025 09:39:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkaJJJL/1FQ7xHlxOTPcdWMwpUdC3rpzdFO9RIBIrjnEaTymsAprfk0HXLJuekjPuBbbRE3w==
X-Received: by 2002:a05:600c:1546:b0:46d:ba6d:65bb with SMTP id
 5b1f17b1804b1-475d2ecb307mr27887375e9.31.1761323978174; 
 Fri, 24 Oct 2025 09:39:38 -0700 (PDT)
Received: from [10.54.0.145] ([147.135.244.229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4342368sm164507145e9.9.2025.10.24.09.39.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 09:39:36 -0700 (PDT)
Message-ID: <deafd3cd-481d-429d-a658-670886010f71@redhat.com>
Date: Fri, 24 Oct 2025 18:39:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/23] intel_iommu: Add some macros and inline functions
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-13-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251024084349.102322-13-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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
> Add some macros and inline functions that will be used by following
> patch.
> 
> This patch also make a cleanup to change macro VTD_SM_PASID_ENTRY_DID
> and VTD_SM_PASID_ENTRY_FSPM to use extract64() just like what smmu does,
> because they are either used in following patches or used indirectly by
> new introduced inline functions. But we doesn't aim to change the huge
> amount of bit mask style macro definitions in this patch, that should be
> in a separate patch.
> 
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  8 +++++--
>   hw/i386/intel_iommu.c          | 38 +++++++++++++++++++++++++++-------
>   2 files changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 09edba81e2..df80af839d 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -642,10 +642,14 @@ typedef struct VTDPASIDCacheInfo {
>   #define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
>   
>   #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
> -#define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
> +#define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
>   
> -#define VTD_SM_PASID_ENTRY_FSPM          3ULL
>   #define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
> +#define VTD_SM_PASID_ENTRY_SRE_BIT(x)    extract64((x)->val[2], 0, 1)
> +/* 00: 4-level paging, 01: 5-level paging, 10-11: Reserved */
> +#define VTD_SM_PASID_ENTRY_FSPM(x)       extract64((x)->val[2], 2, 2)
> +#define VTD_SM_PASID_ENTRY_WPE_BIT(x)    extract64((x)->val[2], 4, 1)
> +#define VTD_SM_PASID_ENTRY_EAFE_BIT(x)   extract64((x)->val[2], 7, 1)
>   
>   /* First Stage Paging Structure */
>   /* Masks for First Stage Paging Entry */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 56abbb991d..871e6aad19 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -52,8 +52,7 @@
>   
>   /* pe operations */
>   #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
> -#define VTD_PE_GET_FS_LEVEL(pe) \
> -    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FSPM))
> +#define VTD_PE_GET_FS_LEVEL(pe) (VTD_SM_PASID_ENTRY_FSPM(pe) + 4)
>   #define VTD_PE_GET_SS_LEVEL(pe) \
>       (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
>   
> @@ -837,6 +836,31 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>       }
>   }
>   
> +static inline dma_addr_t vtd_pe_get_fspt_base(VTDPASIDEntry *pe)
> +{
> +    return pe->val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
> +}
> +
> +/*
> + * First stage IOVA address width: 48 bits for 4-level paging(FSPM=00)
> + *                                 57 bits for 5-level paging(FSPM=01)
> + */
> +static inline uint32_t vtd_pe_get_fs_aw(VTDPASIDEntry *pe)
> +{
> +    return 48 + VTD_SM_PASID_ENTRY_FSPM(pe) * 9;


Can't we use VTD_HOST_AW_48BIT here ?


Thanks,

C.


> +}
> +
> +static inline bool vtd_pe_pgtt_is_pt(VTDPASIDEntry *pe)
> +{
> +    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_PT);
> +}
> +
> +/* check if pgtt is first stage translation */
> +static inline bool vtd_pe_pgtt_is_fst(VTDPASIDEntry *pe)
> +{
> +    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_FST);
> +}
> +
>   static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
>   {
>       return pdire->val & 1;
> @@ -1625,7 +1649,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
>   
>       if (s->root_scalable) {
>           vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
> -        return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
> +        return VTD_SM_PASID_ENTRY_DID(&pe);
>       }
>   
>       return VTD_CONTEXT_ENTRY_DID(ce->hi);
> @@ -1707,7 +1731,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>                */
>               return false;
>           }
> -        return (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_PT);
> +        return vtd_pe_pgtt_is_pt(&pe);
>       }
>   
>       return (vtd_ce_get_type(ce) == VTD_CONTEXT_TT_PASS_THROUGH);
> @@ -3146,9 +3170,9 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>           /* Fall through */
>       case VTD_INV_DESC_PASIDC_G_DSI:
>           if (pc_entry->valid) {
> -            did = VTD_SM_PASID_ENTRY_DID(pc_entry->pasid_entry.val[1]);
> +            did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
>           } else {
> -            did = VTD_SM_PASID_ENTRY_DID(pe.val[1]);
> +            did = VTD_SM_PASID_ENTRY_DID(&pe);
>           }
>           if (pc_info->did != did) {
>               return;
> @@ -5267,7 +5291,7 @@ static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
>           return -EINVAL;
>       }
>       pgtt = VTD_PE_GET_TYPE(&pe);
> -    domain_id = VTD_SM_PASID_ENTRY_DID(pe.val[1]);
> +    domain_id = VTD_SM_PASID_ENTRY_DID(&pe);
>       ret = 0;
>       switch (pgtt) {
>       case VTD_SM_PASID_ENTRY_FST:


