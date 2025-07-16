Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E7BC83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1VZ-0000hv-Te; Wed, 16 Jul 2025 08:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uc1MM-0003d6-4J
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:35:42 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uc1MC-0007Fg-P0
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:35:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4561514c7f0so28052525e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752669330; x=1753274130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hgkEupz8dpz6aqsiJSTA0hYMF2jw25CEPyow4jeMWOo=;
 b=ai5u1O+Imu71k6xCxzhvyOi8Dy/JkExdyD7DJUqVofP7VTzbvvyDAwZU0W/f+998Hx
 +2QxoadTO6pAwB2UFUsASrkk2Jfu/sXsKafxudz1vNQSr6AlHkT9reIxyEwyK3gGsGzR
 D6RJ4amTEakKS2WjbsAK3TBg13Z5onsOjz+L64u27Zk2t5f/y6q7q4AFH3CRxBzxM7LD
 dQsl0Xu7t6s8apP81mv/PWC7gsKxO5h1tdHK29BmGOr+GbSOF+Us+tedGu4vdaZhu9j9
 gj9UgCN+vxl4+lZ3CA1BZJELzTZMv1uzde8h3lscItVFEiTl7XUKJyAEoRwU/GDTjVbW
 dtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752669330; x=1753274130;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hgkEupz8dpz6aqsiJSTA0hYMF2jw25CEPyow4jeMWOo=;
 b=ZPyUQ2iEa5Uzkpao0zarJn1cRP3DWUWQGKov7BEJeyZZGe8gvHiWzLCnHnJ6fzT1Z0
 fB5ZtxvhWqrFLcqBj/dgP4JV5/ziUn9wfGBx8+VY0oZssU+C+Tmf5UKSdSJ90aaSewuc
 px3Coi5Ia1XM6plEfXsdAx1khpRIig/ddtDz+0dAT3IAkDCAAh6rvmMj2fwqMGiMANzA
 GlAZmPI9vY0+KIYgzI6hxQHYfqwpCOwkY1oilHYgvKxPEXJepyc5yO0PTmhuXc7aHFCE
 jH9LepffS67rRQtShLvZsCFKBWHjz7LgR12jORmSjTiPAoVsdsPNyrVA6khoywnofMtF
 kMPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwnoibEpv0HuE1LQ5ft+Fp77CbLEt7rp1JvgsfMaC4LRITWQRXm0rjbyJ6NWCWaQwcP/+4ULICfV6I@nongnu.org
X-Gm-Message-State: AOJu0YxTLZPLTgS+q8zVPey0xcgeP312jkCPaOD4oOTsy3Uj9hFPJ71T
 MtjZFihG+j5v9L/eU11yyUYk2gdRzvfds/ZMzlsKgmRxSoANsMmh3wVbp+8pUyqTgKjnArsu/Zx
 SOid/YgM=
X-Gm-Gg: ASbGncvAZd4PzyI7k/fzGNoiBTUJRChhT/rRelrFd2oHynOzUGR3SzaRaqE67R4tk82
 04cpxTrBD60SE6yTgH1c46j3bOAuT5kmO+bicQZMv+WPB85DMJhUgmx6Qe6L4YCHa15AllGti0h
 FwgmWOQFZfoLc6CK0UitTRBvQIeZ9lYi7ujPoeP3ErxV6/ofzIXiFWP2dYo7xLQpg99ZaTAU4cp
 xNNTIPyRBlk6+aoDMGKDyvo2wKI/h9RCiaBWPrjE9uuWgMQOEPI3WO2XEvJ9BftOgBlYf9SBgtz
 ordyLUToAUf/Ptf0YajaXalPTIWaGyi0N5X7yTBHKZ5OvOTSsHC8EbdZpY7yFtbW1xmUJwLmqci
 TwXp1NUsYnCtI73L7tS8ZcjE1ZTWA4ACOOYJlH0bPLtwq7mLJO+miiMyxbCDq+S2sVtPTZODNFx
 sjSQcQ4+2Y
X-Google-Smtp-Source: AGHT+IGy0EGDC11zYHVRBd+hqyWRXZrRE0IpYrD7gXRWq/wUD6I9jidokw1ad+FiQWIIQhvA7HFh4g==
X-Received: by 2002:a05:6000:2309:b0:3a4:dfa9:ce28 with SMTP id
 ffacd0b85a97d-3b60e4be284mr2145866f8f.5.1752669329936; 
 Wed, 16 Jul 2025 05:35:29 -0700 (PDT)
Received: from [10.132.103.213] (119.red-95-127-47.staticip.rima-tde.net.
 [95.127.47.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e285sm17515042f8f.76.2025.07.16.05.35.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 05:35:29 -0700 (PDT)
Message-ID: <199d1a19-d368-477b-9e45-8afffaffa7b8@linaro.org>
Date: Wed, 16 Jul 2025 14:35:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] hw/i386/amd_iommu: Remove unused and wrongly set
 ats_enabled field
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 eduardo@habkost.net, richard.henderson@linaro.org,
 alejandro.j.jimenez@oracle.com, Vasant Hegde <vasant.hegde@amd.com>
References: <20250716073145.915-1-sarunkod@amd.com>
 <20250716073145.915-3-sarunkod@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250716073145.915-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 16/7/25 09:31, Sairaj Kodilkar wrote:
> The ats_enabled field is set using HTTUNEN, which is wrong.
> Fix this by removing the field as it is never used.
> 
> Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>   hw/i386/amd_iommu.c | 2 --
>   hw/i386/amd_iommu.h | 1 -
>   2 files changed, 3 deletions(-)


> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index fc4d2f7a4575..62641b779ca3 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -368,7 +368,6 @@ struct AMDVIState {
>       uint64_t mmio_addr;
>   
>       bool enabled;                /* IOMMU enabled                */
> -    bool ats_enabled;            /* address translation enabled  */

Since commit 28931c2e159 ("hw/i386/amd_iommu: Allow migration when
explicitly create the AMDVI-PCI device") this field is migrated, which
patch removes it?


