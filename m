Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0BFC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 11:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1visvC-0004bI-4c; Thu, 22 Jan 2026 06:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1visum-0004a5-CL
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:31:54 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1visuk-0007Wg-6f
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:31:52 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64471fcdef0so915558d50.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 03:31:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769081509; cv=none;
 d=google.com; s=arc-20240605;
 b=FjafjOeymbrtnVEHBQEO4tyP0WmHI+Ng0wyMmQhiITtrffRpzyGPAqwra5S2pouGy6
 nxQoeP2IObxEy0tr9K27YEEbyFEFSo3v5ACrawM4qBsxnoBBRFSA4ScUct/nrkUAd8d6
 CqOQbpZt3LLJl+A10ZodrYK2qEs9pQUs44LXCADygo8Jtv+AkrW/oHVJAF/7uTLFkWil
 sRg3WwLRq4MUsN6Cw/bIiQGE/6MAkiGosvDx6ltcjpCgcpfcvyQFhpvNC5mz76caOsk1
 zDwOUfLlLsWiuQnQnPOIPtCR/FN1LCDjDuMK/zzvm+EkAHqZsu9cFkUA3maPhpSPhmml
 i2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZoIC6va/3cQgSH2eFyktj7RW0CONziEpklpiJPgaDbU=;
 fh=/H3IPXbHkfJ7U92CFkuy7ATs0nyti9jVtYEI7Xvu9DI=;
 b=WO9GZu7QS0hHZX9e26F++nSBMIn+RppTCyRD5nNaSYtYciCba56SRbJcfc+e45c+7r
 MC3z1qfcN0zNHTD+Oz1TpYtB59p8+XKgP0t/zjdIFRlsnHS0URHhNdtWLX/Y8YWXsZ2f
 ZhQEz3c2jYR+SJilMJvWAiDqYbR21fecoUVXOWv9twk7sWv5D6dE5KkwSfvgjCM+8dUJ
 6ChOdfLo5Bv38PbBXguMxGorA4djlR/LRXmsW1a5xMXF2LhvRLOdb+sM7bi2fR/JDwoJ
 4i+fIysnHFHOF3Z2SHzokKTaj1vi/ybythJnDqeGiMm0/8fhNhQViZilJtdSio5SFibc
 2zSQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769081509; x=1769686309; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZoIC6va/3cQgSH2eFyktj7RW0CONziEpklpiJPgaDbU=;
 b=rpDZEbu/T6M9vWlmITb9ZsCHIPdDzu8O79Oe5L3UyzIA9Hj+eZDoHPAa10Lf07kEcy
 9y8cYy/+FiqXrqVL0NFgpnsLwsIAh3sDP6SR5JKK61ahQwqmENR73vLI1hEf9vVIyhTI
 5HHEwBCWC4/g73G9ECP5zmOUNXahUGkwEGzAyfOJ9GCrmSiB1bUYeTwHT3osD6GkypGH
 sbqMYBZ3vlDtC49FDU+xCaXZelev1OuejIWUj/KO9cpEHTFx77dwvTYTnEZm6tIOYfmJ
 3DYO/qZ53PDIp8M8P7PT7cLYTNuL/3+PHF9L9gUk3luG+tOG/moNvS5R2O7Xzj9UJswf
 cxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769081509; x=1769686309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZoIC6va/3cQgSH2eFyktj7RW0CONziEpklpiJPgaDbU=;
 b=CImLmdJr/Xy0VGVuBCcK7vZWYI2BkNn4WQeQi26kfFm5LVLcS4vd2tN0fV1dyGiwRX
 z8x2JtcPAbunYMHZeTVvxm/ujfdBC/iXruDnjbrMNnDHvheiQW1UoewyZbUavWWRZNlm
 Q/yKQc7OTLAGqnsw5jEuLbuHWhPdusE+7oNRk18lLFP+WHC1a6hgXMuMYP/GjpQrFGsJ
 7CYvPg26CaE5lpYri3HmbUEjwyQ5N7U1OCeueRZGzN2u9gRygCHqxA2LVStFOAJ0B148
 qOOLM4t4yTGiL/qCjkRBNS79xZ8R1h/qsz/IdbvUmrIXlqn4h9iP+XbAxkReF0bg32yO
 rFuw==
X-Gm-Message-State: AOJu0YzmEBRAFj60XPLv7uLBs0J+KeaUNd/QPP+L5APv2Pz4Q2rpXGiU
 VeKW3l/5tZjMBUwqmrJ2DnTFUKB57jlgnVskBfhQesKMqMRnWaAm1BrXKVL8Jn2v4flWJzLpzGa
 3JrCzboFg2/bbiEUy60+BA7J3c6+qZjX4mW6b2zT8uQ==
X-Gm-Gg: AZuq6aIGTHXVHgtjQkbCA5EIImcu1PJ/h2uNiPj3zE3md/5q4+iJg0N7i3AyScwut29
 pw48+gicxEHUfF3GfpvRmMUvPdqxgKXQHxnzXzDSrvv0ALvBStvWn08PBaeIrn5km3AS9zuFQIC
 YAGA3bSq3Lh0cR3ZEbw9COVBZDHaSBlfbajTZ0Tk1WmgrfUj+dygvm/FijZR68a8JD3Jh6BkYbJ
 4m4voXHrj/u8AgNGALB6YRAjc1Z8hepSbPntHbNjcGH9RLS7w5GxgmwJmhLfxCYh9E4xw==
X-Received: by 2002:a05:690c:ec2:b0:792:6980:36df with SMTP id
 00721157ae682-7940a0e6fdcmr163020747b3.6.1769081508931; Thu, 22 Jan 2026
 03:31:48 -0800 (PST)
MIME-Version: 1.0
References: <CGME20260121132716epcas5p1cab4021fbcd469b95d13ef4b4adc757f@epcas5p1.samsung.com>
 <20260121132421.2220928-1-ashish.a6@samsung.com>
In-Reply-To: <20260121132421.2220928-1-ashish.a6@samsung.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jan 2026 11:31:37 +0000
X-Gm-Features: AZwV_QjoLqvHF6D-uCiLDuYZPj2COvdDKLSisRRv5dl_OfsJAfAL5xesCMv0iw0
Message-ID: <CAFEAcA_-DBkPbb_47vqeOhtPrdHq5dOkbtBmQgVRj8aBP1kyhQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Implement WFE,
 SEV and SEVONPEND for Cortex-M
To: Ashish Anand <ashish.a6@samsung.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, saurabh@samsung.com, 
 vishwa.mg@samsung.com, y.kaushal@samsung.com, ashish.anand202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Wed, 21 Jan 2026 at 13:27, Ashish Anand <ashish.a6@samsung.com> wrote:
>
> Currently, QEMU implements the 'Wait For Event' (WFE) instruction as a
> simple yield. This causes high host CPU usage because guest
> RTOS idle loops effectively become busy-wait loops.
>
> To improve efficiency, this patch transitions WFE to use the architectural
> 'Halt' state (EXCP_HLT) for M-profile CPUs. This allows the host thread
> to sleep when the guest is idle.
>
> To support this transition, we implement the full architectural behavior
> required for WFE, specifically the 'Event Register', 'SEVONPEND' logic,
> and 'R_BPBR' exception handling requirements defined in the ARM
> Architecture Reference Manual.
>
> This patch enables resource-efficient idle emulation for Cortex-M.
>
> Signed-off-by: Ashish Anand <ashish.a6@samsung.com>
> ---
> Changes in v2:
> 1. Added R_BPBR handling as required by the Armv8-M architecture.
> 2. Unified pending-state updates to detect interrupt transitions for SEVONPEND.
> 3. Moved the Event Register to the top-level ARM CPU state, since it is
>    architecturally shared between A-profile and M-profile CPUs.
> 4. Updated migration handling to be profile-agnostic so the state can be
>    reused if A-profile WFE support is implemented in the future.
> 5. Added CONFIG_USER_ONLY handling for WFE/SEV and tightened profile checks.
> 6. Addressed review comments and fixes raised during v1 discussion.
>
> Link to v1 - https://lore.kernel.org/qemu-devel/20251223120012.541777-1-ashish.a6@samsung.com/
>
>
>  hw/intc/armv7m_nvic.c      | 85 ++++++++++++++++++++++++++++++--------
>  target/arm/cpu.c           |  6 +++
>  target/arm/cpu.h           |  7 ++++
>  target/arm/machine.c       | 19 +++++++++
>  target/arm/tcg/helper.h    |  1 +
>  target/arm/tcg/m_helper.c  |  5 +++
>  target/arm/tcg/op_helper.c | 56 +++++++++++++++++++++----
>  target/arm/tcg/t16.decode  |  5 ++-
>  target/arm/tcg/t32.decode  |  5 ++-
>  target/arm/tcg/translate.c | 29 +++++++++++--
>  10 files changed, 185 insertions(+), 33 deletions(-)
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 3a31eb56f3..854d27e413 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -221,6 +221,40 @@ static int exc_group_prio(NVICState *s, int rawprio, bool targets_secure)
>      return rawprio;
>  }
>
> +/*
> + * Update the pending state of an exception vector.
> + * This is the central function for all updates to vec->pending.
> + * Handles SEVONPEND: if this is a 0->1 transition on an external interrupt
> + * and SEVONPEND is set in the appropriate SCR, sets the event register.
> + */
> +static void nvic_update_pending_state(NVICState *s, int irq, bool secure,
> +                                      uint8_t next_pending_val)
> +{
> +    VecInfo *vec;
> +    int scr_bank;
> +    uint8_t prev_pending_val;
> +
> +    if (secure && exc_is_banked(irq)) {
> +        vec = &s->sec_vectors[irq];
> +        scr_bank = M_REG_S;
> +    } else {
> +        vec = &s->vectors[irq];
> +        scr_bank = M_REG_NS;
> +    }

You already have the VecInfo pointer at all the callsites,
so I think it would be better to pass it to this function
rather than recalculating it from the irq number etc.

I agree with Alex about using a bool for the event_register
struct field.

Otherwise I think this looks good!

thanks
-- PMM

