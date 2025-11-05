Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE2DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 10:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGaXm-0006PF-Uj; Wed, 05 Nov 2025 05:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGaXk-0006Ny-S8
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 05:15:08 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGaXi-0008JI-Qm
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 05:15:08 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-afcb7ae6ed0so1170371366b.3
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 02:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762337705; x=1762942505; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XMsgdSS4Tcr3Gxt4VgHCnYoa6pVVtT+xGEQriq95MyM=;
 b=HTgZIHEsF7Etk0wGTR/m3cxh0M6BHHGkrQnljZUwoLscJsFKobd1JF3I3RwYdvhIC3
 TEUhaHqg3mRAHCQeclF939eHpJJf9EUw0CrZQzk/UxFMpjF2cmpIyaI3xaXhF80LNwty
 TE/L57lKGsbM/xdImEQ74YYarJoVuQlzchh8uGpaVtfujhyWvYDA5yUfGMnSgfw2qTG6
 +JfOoRFegMobBZvEW8U6Ze21M+SURhynHMwPR3lKfEOa9JJ5qTaxevTKwrdKNCeMO7+P
 bLBllByV7ZYpGrGDwvWHh1pF1B1zxTeTRScxW72CDQppAlOkli9A422/i9nozJsDzwIH
 IZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762337705; x=1762942505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XMsgdSS4Tcr3Gxt4VgHCnYoa6pVVtT+xGEQriq95MyM=;
 b=FW+c+DRuSH/brFYivVYkPwHX8GNIjlfSGPYO8uS1i3r6uePlwbENgzKwc1NdiyeY7q
 +hdSXuP7bWqOMW2FcDQVLWPUyTHiZoxh5nIfDc9ysdRDZ8O725qnZKJmdBnysNO68c5G
 h3kaWFX3j2wgb+5HTp1D8l1b/o7WAhILb3yk8VFywNGKwis+WUdv/c2GQXJ9ojcQvybv
 m079hsfz2Gxzv4LNUO2X3qKUyNF6jn256Snr17k2Q40/WPJbHT/xdvZgCSmGK6vX73D3
 I3yu3GTsdwDNpfAcp7YrolImxcq0fFvblLKOMwnRwUuwsH62NV8aos+zk9Y95vt1TCI1
 D83Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7Gnk1CpH3vZ5z4kLirSbY8tfgu5MiLNo0EHor7tx+kPIH0JgxvUfAWN+lJt1cNqkuL8N3pU30VwgM@nongnu.org
X-Gm-Message-State: AOJu0YzYhJByWTWTJfcxlu0Z87WSACZSwklzn4dKrWx0nqMNYpm5I60/
 BRBdzyLOmXwnT1wq/jdx0FnmUqW0x4biqlPudSugUl2PIdtK07uYOrtp6zndjfcSpw8=
X-Gm-Gg: ASbGncsJrrXZRxlH9/AeAOShH6Lmwc5+7kEAHXfjyC8iZhkUAEMtzNhlbsdlJ+aKEgN
 VaGmYDGCjhZF4znCnWpqGWAKpq50ClDn/nkgXV4pqmkMFQ7qIINIBX+o4wbCE4zWVMyHfZa2dxw
 8lWaVZ0+CNG6MvLBnu63RotQKDzQ9rm+vsKZH/4Ykyesz2YXuW3fY8HxxPUUorDgSYzuuFjlA5y
 bgClR9khPK5gxgJb5Jbektx+1rgHy3e/u/P1H6AseZRv8G/2fbrWkUjt5j/lNvjW6Q+eAMF48bq
 ZXClmlsAdpp+7he3Okiajs+v4zvHEn7WNSlFtTmpPOB7Z/GeQKsrajVx1rI90mAptuhrUjqjqJu
 CzcUZ/ESHSsuaJ12R49DaRSjkX4Af/Gx3ZWgvF1NPyp42HEXcSLRdi38oRk0iBgcY3SAN1wPZ/X
 KTM6WP90VZLSZqGAyfqKA=
X-Google-Smtp-Source: AGHT+IFfdCZ9VfCkYK9qr19GEnfhtOyAtutFYGKArYLd/4vxgsdkycrvmoAiKGuBcyyVtRBEiCKojw==
X-Received: by 2002:a17:907:da5:b0:b3e:babd:f263 with SMTP id
 a640c23a62f3a-b7265155cffmr260747166b.3.1762337704893; 
 Wed, 05 Nov 2025 02:15:04 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723db0fd12sm445599266b.32.2025.11.05.02.15.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 02:15:04 -0800 (PST)
Message-ID: <a8e88aaa-02ef-406e-9737-bbe017e420d3@linaro.org>
Date: Wed, 5 Nov 2025 11:15:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 26/37] hw/misc: Add RISC-V CMGCR device implementation
Content-Language: en-US
To: alistair23@gmail.com, qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20251023043520.1777130-1-alistair.francis@wdc.com>
 <20251023043520.1777130-5-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023043520.1777130-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 23/10/25 06:35, alistair23@gmail.com wrote:
> From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
> 
> Add RISC-V implementation of the Coherent Manager Global Control
> Register (CMGCR) device. It is based on the existing MIPS CMGCR
> implementation but adapted for RISC-V systems.
> 
> The CMGCR device provides global system control for multi-core
> configurations in RISC-V systems.
> 
> This is needed for the MIPS BOSTON AIA board.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Message-ID: <20251018154522.745788-9-djordje.todorovic@htecgroup.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   include/hw/misc/riscv_cmgcr.h |  50 +++++++
>   hw/misc/riscv_cmgcr.c         | 248 ++++++++++++++++++++++++++++++++++
>   hw/misc/Kconfig               |   9 ++
>   hw/misc/meson.build           |   2 +
>   4 files changed, 309 insertions(+)
>   create mode 100644 include/hw/misc/riscv_cmgcr.h
>   create mode 100644 hw/misc/riscv_cmgcr.c


> +static inline void update_gcr_base(RISCVGCRState *gcr, uint64_t val)
> +{
> +    gcr->gcr_base = val & GCR_BASE_GCRBASE_MSK;
> +    memory_region_set_address(&gcr->iomem, gcr->gcr_base);
> +
> +    /*
> +     * For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
> +     * cpc automatically.
> +     */
> +    update_cpc_base(gcr, val + 0x8001);
> +}
> +
> +/* Read GCR registers */
> +static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    RISCVGCRState *gcr = (RISCVGCRState *) opaque;
> +
> +    switch (addr) {
> +    /* Global Control Block Register */
> +    case GCR_CONFIG_OFS:
> +        /* Set PCORES to 0 */
> +        return 0;
> +    case GCR_BASE_OFS:
> +        return gcr->gcr_base;
> +    case GCR_REV_OFS:
> +        return gcr->gcr_rev;
> +    case GCR_CPC_STATUS_OFS:
> +        return is_cpc_connected(gcr);
> +    case GCR_L2_CONFIG_OFS:
> +        /* L2 BYPASS */
> +        return GCR_L2_CONFIG_BYPASS_MSK;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Read %d bytes at GCR offset 0x%" HWADDR_PRIx
> +                      "\n", size, addr);
> +    }
> +    return 0;
> +}
> +
> +static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
> +{
> +    return vps->reset_base & GCR_CL_RESET_BASE_RESETBASE_MSK;
> +}
> +
> +/* Write GCR registers */
> +static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
> +{
> +    RISCVGCRState *gcr = (RISCVGCRState *)opaque;
> +    RISCVGCRVPState *current_vps;
> +    int cpu_index, c, h;
> +
> +    for (c = 0; c < gcr->num_core; c++) {
> +        for (h = 0; h < gcr->num_hart; h++) {
> +            if (addr == RISCV_CLCB_OFS + c * RISCV_CORE_REG_STRIDE + h * 8) {
> +                cpu_index = c * gcr->num_hart + h;
> +                current_vps = &gcr->vps[cpu_index];
> +                current_vps->reset_base = data & GCR_CL_RESET_BASE_MSK;
> +                cpu_set_exception_base(cpu_index + gcr->cluster_id *
> +                                       gcr->num_core * gcr->num_hart,
> +                                       get_exception_base(current_vps));
> +                return;
> +            }
> +        }
> +    }
> +
> +    switch (addr) {
> +    case GCR_BASE_OFS:
> +        update_gcr_base(gcr, data);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Write %d bytes at GCR offset 0x%" HWADDR_PRIx
> +                      " 0x%" PRIx64 "\n", size, addr, data);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps gcr_ops = {
> +    .read = gcr_read,
> +    .write = gcr_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,

Dubious DEVICE_NATIVE_ENDIAN use, do you mean DEVICE_LITTLE_ENDIAN?

Maybe we can alter checkpatch to no accept new DEVICE_NATIVE_ENDIAN
in our code base.

> +    .impl = {
> +        .max_access_size = 8,
> +    },
> +};

