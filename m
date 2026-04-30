Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD719FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITQ0-00043G-9a; Thu, 30 Apr 2026 11:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wITPs-0003v5-Ql
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:35:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wITPn-0000cM-D1
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:35:02 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so18102425e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777563298; x=1778168098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7AOZwZ8ehmzur+SFeNrWcyUnUtxnku69rfkYQCu0ERY=;
 b=i2ppP2L0OfAeNBoIOWowVO+6q1GQkEI6oDctl89t2QjnVp7gBwbEJqNy5PeWAFOJsd
 jtAS25ARpeuUoATzFI3+bXSeSx3ecCnV+jgfv3YBqOIED3S5B80uhqK9nQYiTGKj9Pq0
 AMCeHm7la6hB18F1EivNHdmrXCJUcKdNUTNamDH9EcGu0nivI4p7o70wN5gXQB3Y06IT
 +LdwcqPFZpb86cq/xmRgcVFVs7shTfPiMaJ1QMFebLO+5L6oHQxLKTUoZTMjzXLL8/OD
 mn/cxuZXpYJSzb33+TGfRcL582UD3TWR6qjWnZEEmTNHBAYUXSXU6aw+uurzrnlr8PdP
 J/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777563298; x=1778168098;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7AOZwZ8ehmzur+SFeNrWcyUnUtxnku69rfkYQCu0ERY=;
 b=tPKE929TJickv6eP8hNPM7aMoIN4zHZCwCrkv01eMcNynEMMqL6kJ1OhzYMSU3vi0U
 K62QyGyrz7OXEqYjFjagXYtSvVCwDdv6YHskn5ALq1sgp34wBu6p/6H6vH5Wr3gCU6sX
 R40xNIBOHKfkLf4AYnB237mDgWy2VO1rtOcjTrzeXH/4R65N4aeauVltace/NrJ9g8yX
 v+l0x8gTSIluEPegspE/LBt715rNw5/sR009mm84YRekdB48Fbxp/1RLarfYgmEAUwy/
 nGUo1ttg5QDR+H0FIH0P6R0NXD8dgrb+IiovbrZvr38v4Hp7g9CreeiE2H6YgYRO40CD
 zxgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9a5hdGdH4yz2wnLO2vnPvYINyEIGCCB77wYjO339YNZFSkPiK51uz4ynPb78HWVmTZH6Z1kZPHP7B6@nongnu.org
X-Gm-Message-State: AOJu0YwOs2MtY8Xa0DuWUH9LaEb1R4pJ9Amp89YgubUdW98GVkk3qncb
 01HDrcGbeOzgM+ua0JJa7T4mDTwF0NWNNrKCAVIBb/khhJQjQAZxaQ8YtLaOQwiwwYA=
X-Gm-Gg: AeBDiev8vR4CN1F3hJz/lvzng4R9yCRBQqUMfsJ1EwAXzm6OE94JasAwZo1FhlwTyYU
 m2IjpIYioM49Gs03GRN/clJh5vovEAh4VlrgNrUWlyX3rRSH0rQNZ+6+TJYtJ0sbFIFj7/diYsT
 HC+x1YMn3+7LicIkxA3NRSSM9nOXWmaC1b4acni1lgLMyENfE2fDvLjIB1KM1MiF5qp4boNaku3
 HfRIBlRt/EwGJW2Xh0m6aNfbcip4KzY102iXs1LVQl/CDLsQkwftdgN/n1snlV8OGr1LOWPoSOg
 r+XOij5uB0drLi7e9vVn4E/8K5D+BnTxWZIOKNaoRWVU2DQ7YQbnC80dWliMmzUB08PArQ8+5Md
 jSJdG4Y1haSibKm0OtepIamv//oLSfYSo4dalLAFDckGwoD9A5rs1Ck1GjeH5zpncsydaduqEag
 +02RpsD5Ty8MRzgOdp0AMy9K4Km8IKu5jqzXHOX/QGpmdlCua4M1z62xXI4jotMSYTcA8CDvSbq
 q6H
X-Received: by 2002:a05:600c:3e8d:b0:48a:53ea:140b with SMTP id
 5b1f17b1804b1-48a844a4728mr58673855e9.28.1777563297493; 
 Thu, 30 Apr 2026 08:34:57 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c317336sm44572745e9.26.2026.04.30.08.34.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 08:34:56 -0700 (PDT)
Message-ID: <a69b335b-03f5-4a25-89cf-13e185eb2c4b@linaro.org>
Date: Thu, 30 Apr 2026 17:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/65] hw/intc/arm_gicv5: Implement
 gicv5_request_config()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-26-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327111700.795099-26-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo, could you review this single patch?

On 27/3/26 12:16, Peter Maydell wrote:
> Implement the gicv5_request_config() function, which corresponds to
> the RequestConfig command and its RequestConfigAck reply.
> 
> We provide read_l2_iste() as a separate function to keep the "access
> the in-guest-memory data structure" layer separate from the "operate
> on the L2_ISTE values" layer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c                | 102 +++++++++++++++++++++++++++++
>   hw/intc/trace-events               |   1 +
>   include/hw/intc/arm_gicv5_stream.h |  24 +++++++
>   3 files changed, 127 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index 9ca1826253..04d4391ae5 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c
> @@ -297,6 +297,19 @@ FIELD(L2_ISTE, HWU, 9, 2)
>   FIELD(L2_ISTE, PRIORITY, 11, 5)
>   FIELD(L2_ISTE, IAFFID, 16, 16)
>   
> +/*
> + * Format used for gicv5_request_config() return value, which matches
> + * the ICC_ICSR_EL1 bit layout.
> + */
> +FIELD(ICSR, F, 0, 1)
> +FIELD(ICSR, ENABLED, 1, 1)
> +FIELD(ICSR, PENDING, 2, 1)
> +FIELD(ICSR, IRM, 3, 1)
> +FIELD(ICSR, ACTIVE, 4, 1)
> +FIELD(ICSR, HM, 5, 1)
> +FIELD(ICSR, PRIORITY, 11, 5)
> +FIELD(ICSR, IAFFID, 32, 16)
> +
>   static MemTxAttrs irs_txattrs(GICv5Common *cs, GICv5Domain domain)
>   {
>       /*
> @@ -713,6 +726,95 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
>       }
>   }
>   
> +static uint64_t l2_iste_to_icsr(GICv5Common *cs, const GICv5ISTConfig *cfg,
> +                                uint32_t id)
> +{
> +    uint64_t icsr = 0;
> +    const uint32_t *l2_iste_p;
> +    L2_ISTE_Handle h;
> +
> +    l2_iste_p = get_l2_iste(cs, cfg, id, &h);
> +    if (!l2_iste_p) {
> +        return R_ICSR_F_MASK;
> +    }
> +
> +    /*
> +     * The field locations in the L2 ISTE do not line up with the
> +     * corresponding fields in the ICC_ICSR_EL1 register, so we need
> +     * to extract and deposit them individually.
> +     */
> +    icsr = FIELD_DP64(icsr, ICSR, F, 0);
> +    icsr = FIELD_DP64(icsr, ICSR, ENABLED, FIELD_EX32(*l2_iste_p, L2_ISTE, ENABLE));
> +    icsr = FIELD_DP64(icsr, ICSR, PENDING, FIELD_EX32(*l2_iste_p, L2_ISTE, PENDING));
> +    icsr = FIELD_DP64(icsr, ICSR, IRM, FIELD_EX32(*l2_iste_p, L2_ISTE, IRM));
> +    icsr = FIELD_DP64(icsr, ICSR, ACTIVE, FIELD_EX32(*l2_iste_p, L2_ISTE, ACTIVE));
> +    icsr = FIELD_DP64(icsr, ICSR, HM, FIELD_EX32(*l2_iste_p, L2_ISTE, HM));
> +    icsr = FIELD_DP64(icsr, ICSR, PRIORITY, FIELD_EX32(*l2_iste_p, L2_ISTE, PRIORITY));
> +    icsr = FIELD_DP64(icsr, ICSR, IAFFID, FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID));
> +
> +    return icsr;
> +}
> +
> +static uint64_t spi_state_to_icsr(GICv5SPIState *spi)
> +{
> +    uint64_t icsr = 0;
> +
> +    icsr = FIELD_DP64(icsr, ICSR, F, 0);
> +    icsr = FIELD_DP64(icsr, ICSR, ENABLED, spi->enabled);
> +    icsr = FIELD_DP64(icsr, ICSR, PENDING, spi->pending);
> +    icsr = FIELD_DP64(icsr, ICSR, IRM, spi->irm);
> +    icsr = FIELD_DP64(icsr, ICSR, ACTIVE, spi->active);
> +    icsr = FIELD_DP64(icsr, ICSR, HM, spi->hm);
> +    icsr = FIELD_DP64(icsr, ICSR, PRIORITY, spi->priority);
> +    icsr = FIELD_DP64(icsr, ICSR, IAFFID, spi->iaffid);
> +
> +    return icsr;
> +}
> +
> +uint64_t gicv5_request_config(GICv5Common *cs, uint32_t id, GICv5Domain domain,
> +                              GICv5IntType type, bool virtual)
> +{
> +    GICv5 *s = ARM_GICV5(cs);
> +    uint64_t icsr;
> +
> +    if (virtual) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_request_config: tried to "
> +                      "read config of a virtual interrupt\n");
> +        return R_ICSR_F_MASK;
> +    }
> +
> +    switch (type) {
> +    case GICV5_LPI:
> +    {
> +        const GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
> +
> +        icsr = l2_iste_to_icsr(cs, cfg, id);
> +        trace_gicv5_request_config(domain_name[domain], inttype_name(type),
> +                                   virtual, id, icsr);
> +        return icsr;
> +    }
> +    case GICV5_SPI:
> +    {
> +        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
> +
> +        if (!spi) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_request_config: tried to "
> +                          "read config of unreachable SPI %d\n", id);
> +            return R_ICSR_F_MASK;
> +        }
> +
> +        icsr = spi_state_to_icsr(spi);
> +        trace_gicv5_request_config(domain_name[domain], inttype_name(type),
> +                                   virtual, id, icsr);
> +        return icsr;
> +    }
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_request_config: tried to "
> +                      "read config of bad interrupt type %d\n", type);
> +        return R_ICSR_F_MASK;
> +    }
> +}
> +
>   static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
>   {
>       GICv5Common *cs = ARM_GICV5_COMMON(s);
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index 37ca6e8e12..409935e15a 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -240,6 +240,7 @@ gicv5_set_enabled(const char *domain, const char *type, bool virtual, uint32_t i
>   gicv5_set_pending(const char *domain, const char *type, bool virtual, uint32_t id, bool pending) "GICv5 IRS SetPending %s %s virtual:%d ID %u pending %d"
>   gicv5_set_handling(const char *domain, const char *type, bool virtual, uint32_t id, int handling) "GICv5 IRS SetHandling %s %s virtual:%d ID %u handling %d"
>   gicv5_set_target(const char *domain, const char *type, bool virtual, uint32_t id, uint32_t iaffid, int irm) "GICv5 IRS SetTarget %s %s virtual:%d ID %u IAFFID %u routingmode %d"
> +gicv5_request_config(const char *domain, const char *type, bool virtual, uint32_t id, uint64_t icsr) "GICv5 IRS RequestConfig %s %s virtual:%d ID %u ICSR 0x%" PRIx64
>   
>   # arm_gicv5_common.c
>   gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
> diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
> index af2e1851c2..670423fdad 100644
> --- a/include/hw/intc/arm_gicv5_stream.h
> +++ b/include/hw/intc/arm_gicv5_stream.h
> @@ -126,4 +126,28 @@ void gicv5_set_handling(GICv5Common *cs, uint32_t id,
>   void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
>                         GICv5RoutingMode irm, GICv5Domain domain,
>                         GICv5IntType type, bool virtual);
> +
> +/**
> + * gicv5_request_config
> + * @cs: GIC IRS to send command to
> + * @id: interrupt ID
> + * @domain: interrupt domain to act on
> + * @type: interrupt type (LPI or SPI)
> + * @virtual: true if this is a virtual interrupt
> + *
> + * Query the current configuration of an interrupt; matches stream
> + * interface RequestConfig command from CPUIF to IRS and the
> + * RequestConfigAck reply to it.
> + *
> + * In the real stream protocol, the RequestConfigAck packet has the
> + * same information as the register but in a different order; we use
> + * the register order, not the packet order, so we don't need to
> + * unpack and repack in the cpuif.
> + *
> + * Returns: the config of the interrupt, in the format used by
> + * ICC_ICSR_EL1.
> + */
> +uint64_t gicv5_request_config(GICv5Common *cs, uint32_t id, GICv5Domain domain,
> +                              GICv5IntType type, bool virtual);
> +
>   #endif


