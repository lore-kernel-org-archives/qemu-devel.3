Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B5EC02185
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 13:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXh3x-0005JQ-1N; Tue, 14 Jan 2025 08:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXh3p-0005IH-BW
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:34:25 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXh3n-0006lf-Oq
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:34:25 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso98695595ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 05:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736861662; x=1737466462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UE4tcrE+0Se41KZVAZ2E3a444+h7pNN3pCdBdrgbCSM=;
 b=jIZkVWKbDQH55a+qV791MLR+8J1QBoCKQTtW9WeBv3c8BV5sdeUjuMqfWEsstM1Gru
 Rb2c+oa03rk+/O/dA0hEB2oFpaLwfePHcSydWwi3h3/Xdt0Wq4aGsb/sA3LIWUfDWurw
 ZXXzoJnz2XOjaLFsERzgQNR5msXaLWCaJQGwrZXPbvhS2IKKsy+f6RAB54thoyYtDloA
 M2tzRymyuL6AdxYcShPMv89lat0XfUg56fQDV5Hs9uGIhOLdhUv6ZGECUDhYHmwbm9dh
 lptv8MJoItfj02cdx6kueu7wgsFcCx1lN5wGvUdg3oCWd7LgXTVo9oBs5pR5I0xooc05
 QUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736861662; x=1737466462;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UE4tcrE+0Se41KZVAZ2E3a444+h7pNN3pCdBdrgbCSM=;
 b=GSTT7axZOM0otfgln9Qh4VGC3EijzwlJfW8DYscjVGAAVqp5JkVzWW+56VyZbUsa4G
 zepzXs40o0nCxybFO0hH1jC55y6GAtcQqw9DC8WwZuoyG3d+pi2hNxjkRK7LrwOJs8jW
 UYjUhnIeSjo5pWDQ0ERT0aLjNLwtikEQbPjSNFz58UYyXj49T39s+clgp9S/ZKvp5qD/
 WX28vozehuLmzTu97f7/SEAlAGxON9tb8NJd//ibzAzT7FWno22QDzKOMvP0ZzoFZzQD
 kick52WYzxYLk1NT0fSaCdZ29wrduFtvYw2fMAVOVt0Ube/MInxHPNywQbk4ISo9n+Vo
 iz+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJdcEx5Ld1dtdB/XZlP/4AX+7ClcAt5rf3yws1SbA5QIgB3+a0t/JbHFI44IUiXqp74ohtKGnVZ1e2@nongnu.org
X-Gm-Message-State: AOJu0YzsDIStb47yS4aRvTmHx+MTJZTZcG0FPQfmCrsQuaqafbG2G/if
 1bCkdWa2XAHvAlL5cElfqL6u26hQa9+xA8j8ywxg2LTW74ABEgkhfH7c7S69IsQ=
X-Gm-Gg: ASbGncuwXSdeQOL3w3BGskE9pSSMgO4CIvzdu7B36qanxhvWUJ5ZCarjt2SpbY95Qrq
 cLLPqMhpGbUZcfcsk4S66Zhq61kelHsq0pUcGQn8h0QUp4otMgZKn904wC1ro9zjKvDBkGdQWNS
 Fm7XluJ1jQn51srr1TWTcJW98QTsHIUtzku6mv8r7ZbupFFChIAZwi+BZR/1StcbkjnU8qhzuXn
 8GP3TPKpyiKcs92ubsvxWzsWn7kVxasyBz75x2dkClOs0IxFDtLHW5W3ldJCh16jP7Ck4/d
X-Google-Smtp-Source: AGHT+IG2Zw0Cpf5CZ6zPxrA8NNS4lG3QeqiI8Qhq8Y9d4PGArEoC8+wI24yAz8JX8/MohwdToqHD+A==
X-Received: by 2002:a17:903:1110:b0:215:7b7b:5cc9 with SMTP id
 d9443c01a7336-21a83f54bf6mr407876245ad.22.1736861662316; 
 Tue, 14 Jan 2025 05:34:22 -0800 (PST)
Received: from [192.168.68.110] ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f21e279sm67742375ad.134.2025.01.14.05.34.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 05:34:21 -0800 (PST)
Message-ID: <be611034-8b5a-47f2-9b36-4554c1563002@ventanamicro.com>
Date: Tue, 14 Jan 2025 10:34:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/riscv/riscv-iommu-bits: Remove redundant
 definitions
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250114093647.4952-1-jason.chien@sifive.com>
 <20250114093647.4952-2-jason.chien@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250114093647.4952-2-jason.chien@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 1/14/25 6:36 AM, Jason Chien wrote:
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/riscv-iommu-bits.h | 22 ++++++----------------
>   1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index 485f36b9c9..de599b80d6 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -50,8 +50,14 @@ struct riscv_iommu_pq_record {
>   #define RISCV_IOMMU_PREQ_HDR_PRIV       BIT_ULL(33)
>   #define RISCV_IOMMU_PREQ_HDR_EXEC       BIT_ULL(34)
>   #define RISCV_IOMMU_PREQ_HDR_DID        GENMASK_ULL(63, 40)
> +
>   /* Payload fields */
> +#define RISCV_IOMMU_PREQ_PAYLOAD_R      BIT_ULL(0)
> +#define RISCV_IOMMU_PREQ_PAYLOAD_W      BIT_ULL(1)
> +#define RISCV_IOMMU_PREQ_PAYLOAD_L      BIT_ULL(2)
>   #define RISCV_IOMMU_PREQ_PAYLOAD_M      GENMASK_ULL(2, 0)
> +#define RISCV_IOMMU_PREQ_PRG_INDEX      GENMASK_ULL(11, 3)
> +#define RISCV_IOMMU_PREQ_UADDR          GENMASK_ULL(63, 12)
>   
>   /* Common field positions */
>   #define RISCV_IOMMU_PPN_FIELD           GENMASK_ULL(53, 10)
> @@ -382,22 +388,6 @@ enum riscv_iommu_fq_ttypes {
>       RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ = 9,
>   };
>   
> -/* Header fields */
> -#define RISCV_IOMMU_PREQ_HDR_PID        GENMASK_ULL(31, 12)
> -#define RISCV_IOMMU_PREQ_HDR_PV         BIT_ULL(32)
> -#define RISCV_IOMMU_PREQ_HDR_PRIV       BIT_ULL(33)
> -#define RISCV_IOMMU_PREQ_HDR_EXEC       BIT_ULL(34)
> -#define RISCV_IOMMU_PREQ_HDR_DID        GENMASK_ULL(63, 40)
> -
> -/* Payload fields */
> -#define RISCV_IOMMU_PREQ_PAYLOAD_R      BIT_ULL(0)
> -#define RISCV_IOMMU_PREQ_PAYLOAD_W      BIT_ULL(1)
> -#define RISCV_IOMMU_PREQ_PAYLOAD_L      BIT_ULL(2)
> -#define RISCV_IOMMU_PREQ_PAYLOAD_M      GENMASK_ULL(2, 0)
> -#define RISCV_IOMMU_PREQ_PRG_INDEX      GENMASK_ULL(11, 3)
> -#define RISCV_IOMMU_PREQ_UADDR          GENMASK_ULL(63, 12)
> -
> -
>   /*
>    * struct riscv_iommu_msi_pte - MSI Page Table Entry
>    */


