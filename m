Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB478CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 21:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo7Lh-0005a2-Gn; Mon, 18 Aug 2025 17:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1uo7Lf-0005Zg-AQ
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 17:24:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1uo7Lc-0001jc-M2
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 17:24:59 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-459fbca0c95so23455e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 14:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1755552295; x=1756157095; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kuP53TaA81+kYFD2070C8DdUddCzXBJmYlDKc2vkzPA=;
 b=J9N0SSHIgHDABS9Ba3YwhZFOiO7J5Iyphg/Ael8PHmaGWe81pAXbR4VNutilFXbfba
 dQMRTxJDdlsexmkQFsTq4L0C2uhRMEN4zhkb1ErNjjcJ3fGUp6XHGEx7IVsNo6aEe5Tc
 m7MVmtSK5kwNGnWslUjj/3lDoDJz+GrRW5yV4ZKqcKlOy8ky+qmsEA22g+LSnwwumI6i
 0u7pLq5vQnirBMMg5KKBWh+VlAv8hG0BtDesBqxMCJNOdJkKYsHQolNtFE/ejM9J4dhl
 XcSGsccREpRFurm03m6i4NX0fmW6H+/gq/JkHX3bb1s0y1i4tBl1wwX8kIBJZKfRRoyW
 ZCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755552295; x=1756157095;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kuP53TaA81+kYFD2070C8DdUddCzXBJmYlDKc2vkzPA=;
 b=EnKAIUWM6MWivP80WIaLicsxYen/ayJYRGBtx1ViU3jNyAkJjtOcSGdwJlgt/YiL0k
 //Hz3vlilcJSrY/yb0U4Dxc3womsIG5Lav+JaVyqMOWSBqvVEwMfDeR+H2bJBrJBdgOE
 0WpjrUaL/DJEgyTLHj6s8SxzWSv8TfsfEZubhi2QAEkdhr7YRKPsfpy7xutbh+yjCcVh
 aLmy/czkJ25hFGvpDsQE5zwe7TI49ncjMoFHjUSV+F7FmxpNTgE14aEtYSNbyojutaoH
 Gebxdjxs/T47ca8ZzGUV075Cq4TQevU7fMhnDGWfRx1b2x4b1dqKi9Xt48dCcwDJ6rAj
 YV7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDKIBzkZHF8fw06ZaGit8pmzp4BhLakdjZn6hbSmR1g+uhgL0s8Xa8ADc/Ff3maPzz+kGox54HsmTD@nongnu.org
X-Gm-Message-State: AOJu0YzAgn169ExSktihOYzJ/wYhkwK/HOGPk4S5iLqx4MAbvMumF3wk
 BF98VbYwZCLYMr4onzScv3fMyQCTDoC+9IQ6uxdTojwErPr7KtCwkmp244skAzxA+kkx29Cp2B2
 wwaL5cw==
X-Gm-Gg: ASbGnct9fn3hY6kzu+hiXLhcrNUbYPG59C0ioEWFQQUVc2z2H8oNghcQ2D0gMnLB7E/
 VWkN/8fLByIII3ahMn/R6iCYcrGp3B6+NCVVCHZDh+gWJmmQBCKe6Mls1q7LAM+bT2rhsP2glcP
 IdHFJqKnPbgZI4Ge4B2VbjyUyKJ2KhG92Aa5XbgRCdsq12yxNq1dOc0C5erG5f6qySro3wbBqUB
 CbKNsuNnfXLs3fKM55iMkA10Ml+6PCwsxncgulWh7ISn6Lf3mbeeAOxGdEi5iBweNiS8GmCcz6O
 pLUTAqeVnNhnzj3nQVhZ9QUggPtBv0AboCqXA54RBS4XErHrKDHsxZYlwOxm9SHXC9ZMxFQot4B
 zNHw091qInh3p9nykrPi/sSviN9gdp3tHdTB9YwTlRWtMje5OtOwsnKTjUSakRZAnWCQ9Rp4trc
 FdA7dns64=
X-Google-Smtp-Source: AGHT+IGu4MuNUiD77ez3itZiowR44Ocz1Dm7EQmIfr4OpKFJdwXm+6UtNb1I5OcPuUBO99aey9ufCQ==
X-Received: by 2002:a05:600c:3f05:b0:453:79c3:91d6 with SMTP id
 5b1f17b1804b1-45b43d4eb3cmr54845e9.1.1755552294577; 
 Mon, 18 Aug 2025 14:24:54 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com.
 [146.148.121.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c07521368esm895473f8f.29.2025.08.18.14.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 14:24:53 -0700 (PDT)
Date: Mon, 18 Aug 2025 21:24:49 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>
Subject: Re: [RFC 02/11] hw/arm/smmuv3: Implement read/write logic for secure
 registers
Message-ID: <aKOaIcPp26kbS3Nn@google.com>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-3-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250806151134.365755-3-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=smostafa@google.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 06, 2025 at 11:11:25PM +0800, Tao Tang wrote:
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
>  hw/arm/smmuv3-internal.h |   5 +
>  hw/arm/smmuv3.c          | 451 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 456 insertions(+)
> 
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 483aaa915e..1a8b1cb204 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -122,6 +122,11 @@ REG32(CR0,                 0x20)
>  
>  #define SMMU_CR0_RESERVED 0xFFFFFC20
>  
> +/*
> + * BIT1 and BIT4 are RES0 in SMMU_S_CRO
> + */
> +#define SMMU_S_CR0_RESERVED 0xFFFFFC12
> +
>  REG32(CR0ACK,              0x24)
>  REG32(CR1,                 0x28)
>  REG32(CR2,                 0x2c)
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index ab67972353..619180d204 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -317,6 +317,18 @@ static void smmuv3_init_regs(SMMUv3State *s)
>      s->gerrorn = 0;
>      s->statusr = 0;
>      s->gbpa = SMMU_GBPA_RESET_VAL;
> +
> +    /* Initialize secure state */
> +    memset(s->secure_idr, 0, sizeof(s->secure_idr));
> +    /* Secure EL2 and Secure stage 2 support */
> +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1, SEL2, 1);
AFAIU, this is wrong, SEL2 means that the SMMU has dual stage-2,
one for secure (S_S2TTB) and one for non-secure IPAs(S2TTB).
Which is not implemented in this series.

> +    /* Secure state implemented */
> +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1,
> +        SECURE_IMPL, 1);
> +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1,
> +        S_SIDSIZE, SMMU_IDR1_SIDSIZE);
> +
> +    s->secure_gbpa = SMMU_GBPA_RESET_VAL;
>  }
>  
>  static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
> @@ -1278,6 +1290,12 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>      }
>  }
>  
> +/* Check if the SMMU hardware itself implements secure state features */
> +static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
> +{
> +    return FIELD_EX32(s->secure_idr[1], S_IDR1, SECURE_IMPL);
> +}
> +
I see that the secure SMMU support is unconditional. So, is this always true?
Also, how that looks with migration?


>  static int smmuv3_cmdq_consume(SMMUv3State *s)
>  {
>      SMMUState *bs = ARM_SMMU(s);
> @@ -1508,9 +1526,91 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>      return 0;
>  }
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
>

Can’t we just have one check? If the access > SMMU_SECURE_BASE_OFFSET, just
check the security state?

And then based on banking, many of those switches will be common with
non secure cases.

Thanks,
Mostafa

>  static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>                                 uint64_t data, MemTxAttrs attrs)
>  {
> +    bool secure_impl = false;
> +    if (offset >= SMMU_SECURE_BASE_OFFSET) {
> +        secure_impl = smmu_hw_secure_implemented(s);
> +    }
> +
>      switch (offset) {
>      case A_GERROR_IRQ_CFG0:
>          s->gerror_irq_cfg0 = data;
> @@ -1535,6 +1635,41 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>      case A_EVENTQ_IRQ_CFG0:
>          s->eventq_irq_cfg0 = data;
>          return MEMTX_OK;
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
>      default:
>          qemu_log_mask(LOG_UNIMP,
>                        "%s Unexpected 64-bit access to 0x%"PRIx64" (WI)\n",
> @@ -1546,6 +1681,11 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>  static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>                                 uint64_t data, MemTxAttrs attrs)
>  {
> +    bool secure_impl = false;
> +    if (offset >= SMMU_SECURE_BASE_OFFSET) {
> +        secure_impl = smmu_hw_secure_implemented(s);
> +    }
> +
>      switch (offset) {
>      case A_CR0:
>          s->cr[0] = data;
> @@ -1650,6 +1790,137 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>      case A_EVENTQ_IRQ_CFG2:
>          s->eventq_irq_cfg2 = data;
>          return MEMTX_OK;
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
>      default:
>          qemu_log_mask(LOG_UNIMP,
>                        "%s Unexpected 32-bit access to 0x%"PRIx64" (WI)\n",
> @@ -1687,6 +1958,11 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
>  static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
>                                 uint64_t *data, MemTxAttrs attrs)
>  {
> +    bool secure_impl = false;
> +    if (offset >= SMMU_SECURE_BASE_OFFSET) {
> +        secure_impl = smmu_hw_secure_implemented(s);
> +    }
> +
>      switch (offset) {
>      case A_GERROR_IRQ_CFG0:
>          *data = s->gerror_irq_cfg0;
> @@ -1700,6 +1976,31 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
>      case A_EVENTQ_BASE:
>          *data = s->eventq.base;
>          return MEMTX_OK;
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
> +        *data = s->secure_eventq.base;
> +        return MEMTX_OK;
>      default:
>          *data = 0;
>          qemu_log_mask(LOG_UNIMP,
> @@ -1712,6 +2013,11 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
>  static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>                                uint64_t *data, MemTxAttrs attrs)
>  {
> +    bool secure_impl = false;
> +    if (offset >= SMMU_SECURE_BASE_OFFSET) {
> +        secure_impl = smmu_hw_secure_implemented(s);
> +    }
> +
>      switch (offset) {
>      case A_IDREGS ... A_IDREGS + 0x2f:
>          *data = smmuv3_idreg(offset - A_IDREGS);
> @@ -1798,6 +2104,151 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>      case A_EVENTQ_CONS:
>          *data = s->eventq.cons;
>          return MEMTX_OK;
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
>      default:
>          *data = 0;
>          qemu_log_mask(LOG_UNIMP,
> -- 
> 2.34.1
> 
> 

