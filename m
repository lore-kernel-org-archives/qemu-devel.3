Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4BFC87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 21:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujm5B-0005Nr-5p; Wed, 06 Aug 2025 17:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujm58-0005Kz-4q
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 17:53:58 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujm55-0006Ju-Cy
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 17:53:57 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76aea119891so1495510b3a.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 14:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754517232; x=1755122032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oNSkxRvq0MRuSHc7kc1i51Je6sJbVMbp2NS/VO8tLcw=;
 b=kWU395R4ECKyUM5Gm4BubjTxUjUhq5ANUrDcaYlykNzIYsuO57tznLTSmWFhcb/V4X
 GYoLLlYehGviX6r0muLxvz85rokjhHK6HPtxB6YCPrf50pFQZEViAwQci/Md7PycE69G
 EO1oMGyYAov4Ox+EbMOvauVj8ve7BywyHfEjDKOxL0nVU5PKlZ1CfN1cBtCILg0PbXsy
 jU5Fna4GPMFwMDh8PkjGgdtQQ62/IjfZ7JQrRD5XJbG1E58KGT5WNyw6PzuOd+HbfJcm
 2FR/+NSGCuC4ibA5i4EVK8NrBiwrt2DTh587S2++5vlSMIu+nNcgGcU/d30kxvWAiDdG
 shqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754517232; x=1755122032;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oNSkxRvq0MRuSHc7kc1i51Je6sJbVMbp2NS/VO8tLcw=;
 b=oJ1SPX+X1CdA1Vchbl9IZgObb1rnBzbZG4CZGpbe6x6EpmiLeSOKIxTGAM82UHlhUP
 HuxO2uEcJ+Pj4FK+GmL07YkNAdTz4WwCC/oem/noADL1xNWxhIb6dopnmxQbHfwgRG+g
 ASlWPZcDNN21D17fgflr3ESJQp3NVmH2FjdE0uHOj0W38c3XnWdDm2ekOdE4tf8QtauF
 hbzZeIkqLH98bxNfht1WjLMqn7jVbLfCmsh1KSeHX+Xf+nK/A7xo5RiDkyJ5j7bDmK03
 nwU1VcUcI0jKyfdXsLKaBKDnmDC0EiXwpenSOGxYdBHjAP+p+crMB3UfCEnot53uCHwn
 Nedw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyudG5+E1mQvxf4q83uqCtVA4fDsuh4CllBisCNWx4oD7zMry9WMvHIC/SdepsXCIaixlKxY1le1tz@nongnu.org
X-Gm-Message-State: AOJu0YyLAlhmmpq3QWSvOdA/4xik8OzJFYbf0UH+12NCHJAVSXncHJCy
 WGTCAItdR5tEUN9jwnHHxwvsqr0TlgHAgc6c131JMT9yfwTaPrraiellWcPVI/PoCPg=
X-Gm-Gg: ASbGnctmYxMo/oMAztXEm1Y45pbT4T24IE5ZgFNlBHOmAMhUEEHKOt/vCWuYAYq6bmJ
 nO1Swl149RYBXkBRsOs1ArKs5KLC+cbqRz/mDr9vUKdJn7TTBEK1uDkwMC4wN7yL/uEJrB6E3lx
 gd1sh441lyDou4e5n6IoGRCiOmJHk8qOrZpOSbleKlGfwMtS6VVya8xLZK5MCH6L8jF+P+QO+ql
 rrbloBm/K2mzT7hiFrTIV4bRygLXuukd3fO0RSc4d7Dxx9sp3DB3VLas29dDSawADbDBbekJaWS
 kvymf1EgiqfrY5u2kIwoPDlw+TiVPCZD6BYiztfjhZxaOPnig7+BdFkRUEU58fvjMASkq9hdgsT
 F8a0xfzBNF0N20qRRgqkdSof9Wy0vnb5WH4FOpxAx/GqVDA==
X-Google-Smtp-Source: AGHT+IEgEtByEaGZpCyn3hPK3Ue/9XYr2oSR3IUGWyn4OQs9SdekthhzPBks3EYx0OtwAEMa2TrymQ==
X-Received: by 2002:a05:6a21:998d:b0:23d:7a30:a82d with SMTP id
 adf61e73a8af0-240411e0b29mr1615735637.5.1754517232253; 
 Wed, 06 Aug 2025 14:53:52 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bdd2725c9sm14115581b3a.6.2025.08.06.14.53.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 14:53:51 -0700 (PDT)
Message-ID: <4c84da2c-eefd-45b3-88ed-cc5070e5c421@linaro.org>
Date: Wed, 6 Aug 2025 14:53:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/11] hw/arm/smmuv3: Implement read/write logic for secure
 registers
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-3-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250806151134.365755-3-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 8/6/25 8:11 AM, Tao Tang wrote:
> This patch builds upon the previous introduction of secure register
> definitions by providing the functional implementation for their access.
> 
> The availability of the secure programming interface is now correctly
> gated by the S_IDR1.SECURE_IMPL bit. When this bit indicates that
> secure functionality is enabled, the I/O handlers (smmuv3_read and
> smmuv3_write) will correctly dispatch accesses to the secure
> register space.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/arm/smmuv3-internal.h |   5 +
>   hw/arm/smmuv3.c          | 451 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 456 insertions(+)
> 
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 483aaa915e..1a8b1cb204 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -122,6 +122,11 @@ REG32(CR0,                 0x20)
>   
>   #define SMMU_CR0_RESERVED 0xFFFFFC20
>   
> +/*
> + * BIT1 and BIT4 are RES0 in SMMU_S_CRO
> + */
> +#define SMMU_S_CR0_RESERVED 0xFFFFFC12
> +
>   REG32(CR0ACK,              0x24)
>   REG32(CR1,                 0x28)
>   REG32(CR2,                 0x2c)
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index ab67972353..619180d204 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -317,6 +317,18 @@ static void smmuv3_init_regs(SMMUv3State *s)
>       s->gerrorn = 0;
>       s->statusr = 0;
>       s->gbpa = SMMU_GBPA_RESET_VAL;
> +
> +    /* Initialize secure state */
> +    memset(s->secure_idr, 0, sizeof(s->secure_idr));
> +    /* Secure EL2 and Secure stage 2 support */
> +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1, SEL2, 1);
> +    /* Secure state implemented */
> +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1,
> +        SECURE_IMPL, 1);
> +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1,
> +        S_SIDSIZE, SMMU_IDR1_SIDSIZE);
> +
> +    s->secure_gbpa = SMMU_GBPA_RESET_VAL;
>   }
>  

Should we wait for the end of the series to enable this support, as not 
everything is implemented yet?

>   static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
> @@ -1278,6 +1290,12 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>       }
>   }
>   
> +/* Check if the SMMU hardware itself implements secure state features */
> +static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
> +{
> +    return FIELD_EX32(s->secure_idr[1], S_IDR1, SECURE_IMPL);
> +}
> +
>   static int smmuv3_cmdq_consume(SMMUv3State *s)
>   {
>       SMMUState *bs = ARM_SMMU(s);
> @@ -1508,9 +1526,91 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>       return 0;
>   }
>   
> +/* Helper function for secure register write validation */
> +static bool smmu_validate_secure_write(MemTxAttrs attrs, bool secure_impl,
> +                                       hwaddr offset, const char *reg_name)
> +{
> +    if (!attrs.secure || !secure_impl) {
> +        const char *reason = !attrs.secure ?
> +            "Non-secure write attempt" :
> +            "SMMU didn't implement Security State";
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: %s at offset 0x%" PRIx64 " (%s, WI)\n",
> +                      __func__, reason, offset, reg_name);
> +        return false;
> +    }
> +    return true;
> +}
> +
> +/* Helper function for secure register read validation */
> +static bool smmu_validate_secure_read(MemTxAttrs attrs, bool secure_impl,
> +                                      hwaddr offset, const char *reg_name,
> +                                      uint64_t *data)
> +{
> +    if (!attrs.secure || !secure_impl) {
> +        const char *reason = !attrs.secure ?
> +            "Non-secure read attempt" :
> +            "SMMU didn't implement Security State";
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: %s at offset 0x%" PRIx64 " (%s, RAZ)\n",
> +                      __func__, reason, offset, reg_name);
> +        *data = 0; /* RAZ */
> +        return false;
> +    }
> +    return true;
> +}
> +
> +/* Macro for secure write validation - returns early if validation fails */
> +#define SMMU_CHECK_SECURE_WRITE(reg_name) \
> +    do { \
> +        if (!smmu_validate_secure_write(attrs, secure_impl, offset, \
> +                                        reg_name)) { \
> +            return MEMTX_OK; \
> +        } \
> +    } while (0)
> +
> +/* Macro for attrs.secure only validation */
> +#define SMMU_CHECK_ATTRS_SECURE(reg_name) \
> +    do { \
> +        if (!attrs.secure) { \
> +            qemu_log_mask(LOG_GUEST_ERROR, \
> +                          "%s: Non-secure write attempt at offset " \
> +                          "0x%" PRIx64 " (%s, WI)\n", \
> +                          __func__, offset, reg_name); \
> +            return MEMTX_OK; \
> +        } \
> +    } while (0)
> +
> +/* Macro for secure read validation - returns RAZ if validation fails */
> +#define SMMU_CHECK_SECURE_READ(reg_name) \
> +    do { \
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset, \
> +                                       reg_name, data)) { \
> +            return MEMTX_OK; \
> +        } \
> +    } while (0)
> +

For this, and previous macros, shouldn't we return MEMTX_ERROR instead?

> +/* Macro for attrs.secure only validation (read) */
> +#define SMMU_CHECK_ATTRS_SECURE_READ(reg_name) \
> +    do { \
> +        if (!attrs.secure) { \
> +            qemu_log_mask(LOG_GUEST_ERROR, \
> +                          "%s: Non-secure read attempt at offset " \
> +                          "0x%" PRIx64 " (%s, RAZ)\n", \
> +                          __func__, offset, reg_name); \
> +            *data = 0; \
> +            return MEMTX_OK; \
> +        } \
> +    } while (0)
> +

A simple style detail, but it's more readable to keep all backslashes on 
same column (after the longest line).

#define SMMU_CHECK_SECURE_READ(reg_name)                       \
do {                                                           \
     if (!smmu_validate_secure_read(attrs, secure_impl, offset, \
                                    reg_name, data)) {          \
         return MEMTX_OK;                                       \
     } \
} while (0)

>   static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>                                  uint64_t data, MemTxAttrs attrs)
>   {
> +    bool secure_impl = false;
> +    if (offset >= SMMU_SECURE_BASE_OFFSET) {
> +        secure_impl = smmu_hw_secure_implemented(s);
> +    }
> +
>       switch (offset) {
>       case A_GERROR_IRQ_CFG0:
>           s->gerror_irq_cfg0 = data;
> @@ -1535,6 +1635,41 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>       case A_EVENTQ_IRQ_CFG0:
>           s->eventq_irq_cfg0 = data;
>           return MEMTX_OK;
> +    case A_S_GERROR_IRQ_CFG0:
> +        /* No need to check secure_impl here */
> +        SMMU_CHECK_ATTRS_SECURE("S_GERROR_IRQ_CFG0");
> +        s->secure_gerror_irq_cfg0 = data;
> +        return MEMTX_OK;
> +    case A_S_STRTAB_BASE:
> +        if (!smmu_validate_secure_write(attrs, secure_impl, offset,
> +                                        "S_STRTAB_BASE")) {
> +            return MEMTX_OK;
> +        }
> +        s->secure_strtab_base = data;
> +        return MEMTX_OK;
> +    case A_S_CMDQ_BASE:
> +        SMMU_CHECK_SECURE_WRITE("S_CMDQ_BASE");
> +        s->secure_cmdq.base = data;
> +        s->secure_cmdq.log2size = extract64(s->secure_cmdq.base, 0, 5);
> +        if (s->secure_cmdq.log2size > SMMU_CMDQS) {
> +            s->secure_cmdq.log2size = SMMU_CMDQS;
> +        }
> +        return MEMTX_OK;
> +    case A_S_EVENTQ_BASE:
> +        SMMU_CHECK_SECURE_WRITE("S_EVENTQ_BASE");
> +        s->secure_eventq.base = data;
> +        s->secure_eventq.log2size = extract64(s->secure_eventq.base, 0, 5);
> +        if (s->secure_eventq.log2size > SMMU_EVENTQS) {
> +            s->secure_eventq.log2size = SMMU_EVENTQS;
> +        }
> +        return MEMTX_OK;
> +    case A_S_EVENTQ_IRQ_CFG0:
> +        if (!smmu_validate_secure_write(attrs, secure_impl, offset,
> +                                        "S_EVENTQ_IRQ_CFG0")) {
> +            return MEMTX_OK;
> +        }
> +        s->secure_eventq_irq_cfg0 = data;
> +        return MEMTX_OK;
>       default:
>           qemu_log_mask(LOG_UNIMP,
>                         "%s Unexpected 64-bit access to 0x%"PRIx64" (WI)\n",
> @@ -1546,6 +1681,11 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>   static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>                                  uint64_t data, MemTxAttrs attrs)
>   {
> +    bool secure_impl = false;
> +    if (offset >= SMMU_SECURE_BASE_OFFSET) {
> +        secure_impl = smmu_hw_secure_implemented(s);
> +    }
> +
>       switch (offset) {
>       case A_CR0:
>           s->cr[0] = data;
> @@ -1650,6 +1790,137 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>       case A_EVENTQ_IRQ_CFG2:
>           s->eventq_irq_cfg2 = data;
>           return MEMTX_OK;
> +    case A_S_CR0:
> +        SMMU_CHECK_SECURE_WRITE("S_CR0");
> +        s->secure_cr[0] = data;
> +        /* clear reserved bits */
> +        s->secure_cr0ack = data & ~SMMU_S_CR0_RESERVED;
> +        smmuv3_cmdq_consume(s);
> +        return MEMTX_OK;
> +    case A_S_CR1:
> +        if (!smmu_validate_secure_write(attrs, secure_impl, offset,
> +                                        "S_CR1")) {
> +            return MEMTX_OK;
> +        }
> +        s->secure_cr[1] = data;
> +        return MEMTX_OK;
> +    case A_S_CR2:
> +        if (!smmu_validate_secure_write(attrs, secure_impl, offset,
> +                                        "S_CR2")) {
> +            return MEMTX_OK;
> +        }
> +        s->secure_cr[2] = data;
> +        return MEMTX_OK;
> +    case A_S_IRQ_CTRL:
> +        if (!smmu_validate_secure_write(attrs, secure_impl, offset,
> +                                        "S_IRQ_CTRL")) {
> +            return MEMTX_OK;
> +        }
> +        s->secure_irq_ctrl = data;
> +        return MEMTX_OK;
> +    case A_S_GERRORN:
> +        SMMU_CHECK_SECURE_WRITE("S_GERRORN");
> +        smmuv3_write_gerrorn(s, data);
> +        smmuv3_cmdq_consume(s);
> +        return MEMTX_OK;
> +    case A_S_GERROR_IRQ_CFG0:
> +        SMMU_CHECK_ATTRS_SECURE("S_GERROR_IRQ_CFG0");
> +        s->secure_gerror_irq_cfg0 = data;
> +        return MEMTX_OK;
> +    case A_S_GERROR_IRQ_CFG0 + 4:
> +        SMMU_CHECK_ATTRS_SECURE("S_GERROR_IRQ_CFG0");
> +        s->secure_gerror_irq_cfg0 = deposit64(s->secure_gerror_irq_cfg0,
> +                                              32, 32, data);
> +        return MEMTX_OK;
> +    case A_S_GERROR_IRQ_CFG1:
> +        SMMU_CHECK_ATTRS_SECURE("S_GERROR_IRQ_CFG1");
> +        s->secure_gerror_irq_cfg1 = data;
> +        return MEMTX_OK;
> +    case A_S_GERROR_IRQ_CFG2:
> +        SMMU_CHECK_ATTRS_SECURE("S_GERROR_IRQ_CFG2");
> +        s->secure_gerror_irq_cfg2 = data;
> +        return MEMTX_OK;
> +    case A_S_GBPA:
> +        SMMU_CHECK_SECURE_WRITE("S_GBPA");
> +        if (data & R_S_GBPA_UPDATE_MASK) {
> +            s->secure_gbpa = data & ~R_S_GBPA_UPDATE_MASK;
> +        }
> +        return MEMTX_OK;
> +    case A_S_STRTAB_BASE:
> +        SMMU_CHECK_SECURE_WRITE("S_STRTAB_BASE");
> +        s->secure_strtab_base = deposit64(s->secure_strtab_base, 0, 32, data);
> +        return MEMTX_OK;
> +    case A_S_STRTAB_BASE + 4:
> +        SMMU_CHECK_SECURE_WRITE("S_STRTAB_BASE");
> +        s->secure_strtab_base = deposit64(s->secure_strtab_base, 32, 32, data);
> +        return MEMTX_OK;
> +    case A_S_STRTAB_BASE_CFG:
> +        SMMU_CHECK_SECURE_WRITE("S_STRTAB_BASE_CFG");
> +        s->secure_strtab_base_cfg = data;
> +        if (FIELD_EX32(data, S_STRTAB_BASE_CFG, FMT) == 1) {
> +            s->secure_sid_split = FIELD_EX32(data, S_STRTAB_BASE_CFG, SPLIT);
> +            s->secure_features |= SMMU_FEATURE_2LVL_STE;
> +        }
> +        return MEMTX_OK;
> +    case A_S_CMDQ_BASE:
> +        SMMU_CHECK_SECURE_WRITE("S_CMDQ_BASE");
> +        s->secure_cmdq.base = deposit64(s->secure_cmdq.base, 0, 32, data);
> +        s->secure_cmdq.log2size = extract64(s->secure_cmdq.base, 0, 5);
> +        if (s->secure_cmdq.log2size > SMMU_CMDQS) {
> +            s->secure_cmdq.log2size = SMMU_CMDQS;
> +        }
> +        return MEMTX_OK;
> +    case A_S_CMDQ_BASE + 4:
> +        SMMU_CHECK_SECURE_WRITE("S_CMDQ_BASE");
> +        s->secure_cmdq.base = deposit64(s->secure_cmdq.base, 32, 32, data);
> +        return MEMTX_OK;
> +    case A_S_CMDQ_PROD:
> +        SMMU_CHECK_SECURE_WRITE("S_CMDQ_PROD");
> +        s->secure_cmdq.prod = data;
> +        smmuv3_cmdq_consume(s);
> +        return MEMTX_OK;
> +    case A_S_CMDQ_CONS:
> +        SMMU_CHECK_SECURE_WRITE("S_CMDQ_CONS");
> +        s->secure_cmdq.cons = data;
> +        return MEMTX_OK;
> +    case A_S_EVENTQ_BASE:
> +        SMMU_CHECK_SECURE_WRITE("S_EVENTQ_BASE");
> +        s->secure_eventq.base = deposit64(s->secure_eventq.base, 0, 32, data);
> +        s->secure_eventq.log2size = extract64(s->secure_eventq.base, 0, 5);
> +        if (s->secure_eventq.log2size > SMMU_EVENTQS) {
> +            s->secure_eventq.log2size = SMMU_EVENTQS;
> +        }
> +        return MEMTX_OK;
> +    case A_S_EVENTQ_BASE + 4:
> +        SMMU_CHECK_SECURE_WRITE("S_EVENTQ_BASE");
> +        s->secure_eventq.base = deposit64(s->secure_eventq.base, 32, 32, data);
> +        return MEMTX_OK;
> +    case A_S_EVENTQ_PROD:
> +        SMMU_CHECK_SECURE_WRITE("S_EVENTQ_PROD");
> +        s->secure_eventq.prod = data;
> +        return MEMTX_OK;
> +    case A_S_EVENTQ_CONS:
> +        SMMU_CHECK_SECURE_WRITE("S_EVENTQ_CONS");
> +        s->secure_eventq.cons = data;
> +        return MEMTX_OK;
> +    case A_S_EVENTQ_IRQ_CFG0:
> +        SMMU_CHECK_SECURE_WRITE("S_EVENTQ_IRQ_CFG0");
> +        s->secure_eventq_irq_cfg0 = deposit64(s->secure_eventq_irq_cfg0,
> +                                              0, 32, data);
> +        return MEMTX_OK;
> +    case A_S_EVENTQ_IRQ_CFG0 + 4:
> +        SMMU_CHECK_ATTRS_SECURE("S_EVENTQ_IRQ_CFG0");
> +        s->secure_eventq_irq_cfg0 = deposit64(s->secure_eventq_irq_cfg0,
> +                                              32, 32, data);
> +        return MEMTX_OK;
> +    case A_S_EVENTQ_IRQ_CFG1:
> +        SMMU_CHECK_ATTRS_SECURE("S_EVENTQ_IRQ_CFG1");
> +        s->secure_eventq_irq_cfg1 = data;
> +        return MEMTX_OK;
> +    case A_S_EVENTQ_IRQ_CFG2:
> +        SMMU_CHECK_ATTRS_SECURE("S_EVENTQ_IRQ_CFG2");
> +        s->secure_eventq_irq_cfg2 = data;
> +        return MEMTX_OK;
>       default:
>           qemu_log_mask(LOG_UNIMP,
>                         "%s Unexpected 32-bit access to 0x%"PRIx64" (WI)\n",
> @@ -1687,6 +1958,11 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
>   static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
>                                  uint64_t *data, MemTxAttrs attrs)
>   {
> +    bool secure_impl = false;
> +    if (offset >= SMMU_SECURE_BASE_OFFSET) {
> +        secure_impl = smmu_hw_secure_implemented(s);
> +    }
> +
>       switch (offset) {
>       case A_GERROR_IRQ_CFG0:
>           *data = s->gerror_irq_cfg0;
> @@ -1700,6 +1976,31 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
>       case A_EVENTQ_BASE:
>           *data = s->eventq.base;
>           return MEMTX_OK;
> +    case A_S_GERROR_IRQ_CFG0:
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       "S_GERROR_IRQ_CFG0", data)) {
> +            return MEMTX_OK;
> +        }
> +        *data = s->secure_gerror_irq_cfg0;
> +        return MEMTX_OK;
> +    case A_S_STRTAB_BASE:
> +        SMMU_CHECK_ATTRS_SECURE_READ("S_STRTAB_BASE");
> +        *data = s->secure_strtab_base;
> +        return MEMTX_OK;
> +    case A_S_CMDQ_BASE:
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       "S_CMDQ_BASE", data)) {
> +            return MEMTX_OK;
> +        }
> +        *data = s->secure_cmdq.base;
> +        return MEMTX_OK;
> +    case A_S_EVENTQ_BASE:
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       "S_EVENTQ_BASE", data)) {
> +            return MEMTX_OK;
> +        }

Why we don't reuse SMMU_CHECK_SECURE_READ for this and all other similar 
if below?

> +        *data = s->secure_eventq.base;
> +        return MEMTX_OK;
>       default:
>           *data = 0;
>           qemu_log_mask(LOG_UNIMP,
> @@ -1712,6 +2013,11 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
>   static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>                                 uint64_t *data, MemTxAttrs attrs)
>   {
> +    bool secure_impl = false;
> +    if (offset >= SMMU_SECURE_BASE_OFFSET) {
> +        secure_impl = smmu_hw_secure_implemented(s);
> +    }
> +
>       switch (offset) {
>       case A_IDREGS ... A_IDREGS + 0x2f:
>           *data = smmuv3_idreg(offset - A_IDREGS);
> @@ -1798,6 +2104,151 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>       case A_EVENTQ_CONS:
>           *data = s->eventq.cons;
>           return MEMTX_OK;
> +    case A_S_IDR0 ... A_S_IDR4:
> +        int idr_idx = (offset - A_S_IDR0) / 4;
> +        g_assert(idr_idx >= 0 && idr_idx <= 4);
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       g_strdup_printf("S_IDR%d", idr_idx),
> +                                       data)) {
> +            return MEMTX_OK;
> +        }
> +        *data = s->secure_idr[idr_idx];
> +        return MEMTX_OK;
> +    case A_S_CR0:
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       "S_CR0", data)) {
> +            return MEMTX_OK;
> +        }
> +        *data = s->secure_cr[0];
> +        return MEMTX_OK;
> +    case A_S_CR0ACK:
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       "S_CR0ACK", data)) {
> +            return MEMTX_OK;
> +        }
> +        *data = s->secure_cr0ack;
> +        return MEMTX_OK;
> +    case A_S_CR1:
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       "S_CR1", data)) {
> +            return MEMTX_OK;
> +        }
> +        *data = s->secure_cr[1];
> +        return MEMTX_OK;
> +    case A_S_CR2:
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       "S_CR2", data)) {
> +            return MEMTX_OK;
> +        }
> +        *data = s->secure_cr[2];
> +        return MEMTX_OK;
> +    case A_S_GBPA:
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       "S_GBPA", data)) {
> +            return MEMTX_OK;
> +        }
> +        *data = s->secure_gbpa;
> +        return MEMTX_OK;
> +    case A_S_IRQ_CTRL:
> +    case A_S_IRQ_CTRLACK:
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       "S_IRQ_CTRL", data)) {
> +            return MEMTX_OK;
> +        }
> +        *data = s->secure_irq_ctrl;
> +        return MEMTX_OK;
> +    case A_S_GERROR:
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       "S_GERROR", data)) {
> +            return MEMTX_OK;
> +        }
> +        *data = s->secure_gerror;
> +        return MEMTX_OK;
> +    case A_S_GERRORN:
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       "S_GERRORN", data)) {
> +            return MEMTX_OK;
> +        }
> +        *data = s->secure_gerrorn;
> +        return MEMTX_OK;
> +    case A_S_GERROR_IRQ_CFG0:
> +        SMMU_CHECK_SECURE_READ("S_GERROR_IRQ_CFG0");
> +        *data = extract64(s->secure_gerror_irq_cfg0, 0, 32);
> +        return MEMTX_OK;
> +    case A_S_GERROR_IRQ_CFG0 + 4:
> +        SMMU_CHECK_SECURE_READ("S_GERROR_IRQ_CFG0+4");
> +        *data = extract64(s->secure_gerror_irq_cfg0, 32, 32);
> +        return MEMTX_OK;
> +    case A_S_GERROR_IRQ_CFG1:
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       "S_GERROR_IRQ_CFG1", data)) {
> +            return MEMTX_OK;
> +        }
> +        *data = s->secure_gerror_irq_cfg1;
> +        return MEMTX_OK;
> +    case A_S_GERROR_IRQ_CFG2:
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       "S_GERROR_IRQ_CFG2", data)) {
> +            return MEMTX_OK;
> +        }
> +        *data = s->secure_gerror_irq_cfg2;
> +        return MEMTX_OK;
> +    case A_S_STRTAB_BASE:
> +        SMMU_CHECK_ATTRS_SECURE_READ("S_STRTAB_BASE");
> +        *data = extract64(s->secure_strtab_base, 0, 32);
> +        return MEMTX_OK;
> +    case A_S_STRTAB_BASE + 4:
> +        SMMU_CHECK_ATTRS_SECURE_READ("S_STRTAB_BASE+4");
> +        *data = extract64(s->secure_strtab_base, 32, 32);
> +        return MEMTX_OK;
> +    case A_S_STRTAB_BASE_CFG:
> +        SMMU_CHECK_ATTRS_SECURE_READ("S_STRTAB_BASE_CFG");
> +        *data = s->secure_strtab_base_cfg;
> +        return MEMTX_OK;
> +    case A_S_CMDQ_BASE:
> +        SMMU_CHECK_SECURE_READ("S_CMDQ_BASE");
> +        *data = extract64(s->secure_cmdq.base, 0, 32);
> +        return MEMTX_OK;
> +    case A_S_CMDQ_BASE + 4:
> +        SMMU_CHECK_SECURE_READ("S_CMDQ_BASE");
> +        *data = extract64(s->secure_cmdq.base, 32, 32);
> +        return MEMTX_OK;
> +    case A_S_CMDQ_PROD:
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       "S_CMDQ_PROD", data)) {
> +            return MEMTX_OK;
> +        }
> +        *data = s->secure_cmdq.prod;
> +        return MEMTX_OK;
> +    case A_S_CMDQ_CONS:
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       "S_CMDQ_CONS", data)) {
> +            return MEMTX_OK;
> +        }
> +        *data = s->secure_cmdq.cons;
> +        return MEMTX_OK;
> +    case A_S_EVENTQ_BASE:
> +        SMMU_CHECK_SECURE_READ("S_EVENTQ_BASE");
> +        *data = extract64(s->secure_eventq.base, 0, 32);
> +        return MEMTX_OK;
> +    case A_S_EVENTQ_BASE + 4:
> +        SMMU_CHECK_SECURE_READ("S_EVENTQ_BASE");
> +        *data = extract64(s->secure_eventq.base, 32, 32);
> +        return MEMTX_OK;
> +    case A_S_EVENTQ_PROD:
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       "S_EVENTQ_PROD", data)) {
> +            return MEMTX_OK;
> +        }
> +        *data = s->secure_eventq.prod;
> +        return MEMTX_OK;
> +    case A_S_EVENTQ_CONS:
> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
> +                                       "S_EVENTQ_CONS", data)) {
> +            return MEMTX_OK;
> +        }
> +        *data = s->secure_eventq.cons;
> +        return MEMTX_OK;
>       default:
>           *data = 0;
>           qemu_log_mask(LOG_UNIMP,


