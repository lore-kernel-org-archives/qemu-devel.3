Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D01C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWwZ-0001hO-Md; Fri, 07 Mar 2025 07:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tqWvx-0001P7-FS
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:36:13 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tqWvu-0006kQ-N8
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:36:09 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2feae794508so2835389a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 04:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741350964; x=1741955764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RNNog7InIYgZ7eOdFGZdeQRTpkIbBJDqKrFkhMapT24=;
 b=I35fj/xS1n6Y3pUnDN3QOTjU8awAAT5ovXRlL1GKG1V1YZEkjQNVzKF9nRjQAPFXDl
 4DLH8+9WD70WG3E+PMR/mO5PjoacoFiFjfW1jAxCl87cYt046WIPlVqrsrhlzRuSL1Tq
 OBvKpv2bPsV5cdpunHSWzK/wnz++XnKtrccnnGRfxh/NbWp2a0RpS18TMIT4tQ5zWuGK
 UQ3zMFwV3YJHmxTBgU5qc9XLnP+twaNxj/L6LmqWj6nA6+Y10z5dXTWVQcxk3ekKV80U
 PbScAMKyqnwBh1io/2yS1Y/Ej34jk99Vd45mb197debXUw2VaKPQDddUIPDR8ojrzE5M
 djrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741350964; x=1741955764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RNNog7InIYgZ7eOdFGZdeQRTpkIbBJDqKrFkhMapT24=;
 b=KXQ0oGFeKOKAEI9NnhpvIjOOPgLTqKrJV4TZ26qMBzwrTm4oQHLQvo6m377/FNUDii
 TKqAuxlSMvgNIMBMFMgt61mqZAWxbfHFpF31icbxreakSXUS/kKEiYMkaRM31Y2B9UPz
 Vn8uy5T0/w9IKuadYva9dRUL9JvIdZEa08yG23D+9kLWXvS4qL4R7zjL4JL+FaKNc3Kh
 pXXBz3paRZK0ZN9SduzaaKoZnZRBtOc7ID3X9e07x7k6bwjE7uiL1ZWBPdchdp5PHurQ
 RMTu1jiG7TPLNnFkRBvghtqr+0E7vU+TDHWloIhsVxv5BZyrOKwbmLIuK5SRK89FhMQO
 esww==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1jKVZN+vzsFKpeqiyfJY3RtudmUwaOZ6DUujxvWCCK7/03KSR0aAQpXPaXXPxZBtuxmzf97HW5QKp@nongnu.org
X-Gm-Message-State: AOJu0Yxotxqr+0xuCAGjCrjI/oERwe95DlRJjATxLV7FXckGvMU5C8nj
 IvK/4F6k5X83mYef3y1eL1ty82GbQWRqBFiGdo2t3SYvE2VdxoiZ3X9gymFWqLA=
X-Gm-Gg: ASbGnctU3qTSWZaEGfzuxdufWx0nrfx0iaQzBTTPJ7bl2ATOjcJEKBENZGwwzJM6/+x
 Y7Gph1KT62v5Uqlaf9xIvjyDHcLOyBjMGOA6AVSJC2msfC0c7AWY+em3iqHFfET4JqBags7U/AG
 3RxcVoSV7iovI8OmNLsD84HGuBKy7myXEVvEUZ8aRRKjNKmq0EH4frHNv7OiGia6DxuQOhj7U3s
 2Cv2PPho9pD0SRyfTEjXUQNSwtOr3YgfNUFRmcFqFdZA5LeXpCgQ9S9TlHyeIFSmb4s650qIIjB
 +f7Ll8u2yrv4gHOGymmZxycaPbP037KaOGF8jVBdK9z8LyotHxfJDDnGlVo=
X-Google-Smtp-Source: AGHT+IH2Nu5YkUwOB7ctQ4dpeXx/1gx6ebwK2+nUFOrnDyTt8WrT4dCBiH+1sVQB0jWnLr7w4whkRw==
X-Received: by 2002:a17:90a:e7c2:b0:2ff:693a:758d with SMTP id
 98e67ed59e1d1-2ff7ceef0famr4960427a91.27.1741350963836; 
 Fri, 07 Mar 2025 04:36:03 -0800 (PST)
Received: from [192.168.68.110] ([177.170.118.40])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693f6bd8sm2929537a91.41.2025.03.07.04.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 04:36:03 -0800 (PST)
Message-ID: <b98349a3-18ce-4aa4-a88f-1c8ebf1f082a@ventanamicro.com>
Date: Fri, 7 Mar 2025 09:35:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/riscv/riscv-iommu: Obtain Device IDs from Memory
 Attributes
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250302091209.20063-1-jason.chien@sifive.com>
 <20250302091209.20063-3-jason.chien@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250302091209.20063-3-jason.chien@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1030.google.com
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



On 3/2/25 6:12 AM, Jason Chien wrote:
> The bus number of a PCIe endpoint may change after PCIe re-enumeration,
> potentially causing the device ID stored in RISCVIOMMUSpace to become
> outdated. This can lead to an incorrect Device Directory Table walk.
> 
> This commit ensures that the IOMMU dynamically retrieves the latest device
> IDs from the memory attributes of the requester devices, ensuring accuracy.
> 
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/riscv-iommu.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index d46beb2d64..b72ce8e6d0 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2644,7 +2644,13 @@ void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>   static int riscv_iommu_memory_region_index(IOMMUMemoryRegion *iommu_mr,
>       MemTxAttrs attrs)
>   {
> -    return attrs.unspecified ? RISCV_IOMMU_NOPROCID : (int)attrs.pid;
> +    RISCVIOMMUSpace *as = container_of(iommu_mr, RISCVIOMMUSpace, iova_mr);
> +
> +    /* Requesters must attach its device ID. */
> +    g_assert(attrs.unspecified == 0);
> +
> +    as->devid = attrs.requester_id;
> +    return attrs.pid;
>   }
>   
>   static int riscv_iommu_memory_region_index_len(IOMMUMemoryRegion *iommu_mr)


