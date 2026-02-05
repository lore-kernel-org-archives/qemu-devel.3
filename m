Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCF5EC1E92
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 10:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnx3x-0000zB-Jv; Thu, 05 Feb 2026 05:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnx3u-0000yf-DQ
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 05:58:14 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnx3s-00006P-J4
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 05:58:14 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-790b7b3e594so8014247b3.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 02:58:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770289091; cv=none;
 d=google.com; s=arc-20240605;
 b=QBYb4crK90DFbZGCbfpKDQKMe8uMfxSAwN8vWc38zJYkEOQ5hc2B8qKiGxLizN7pwH
 +Z0QvxpvCnfGsQDBsL0H9Sk4lXi5yscQrsPKG846LX7ont8JksjJ2MmmwCwPeImOkY4Y
 iPScQO7bcZcUErnmOCN3haqLzmmxfnXl/ztcVqzrytECklj9TgznkoCxs7aaEXsO6FLU
 WcjT8qEUg81XyNH5sfR8KtOgufLENk0VCmFA+/1cX2aKNb2Vqeb9eo2P07aXOB69YJME
 VzCkRkPv+5fE3isgWtYv5PG2zr7d4qXhLyFnwcLz4Sys61T5vfRkoTYykBHoBwznT4Eu
 8UHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Xi1iokQkGw8GZF0xxDEjxZdLtwNuhyZxehAKTgy2E8s=;
 fh=/H3IPXbHkfJ7U92CFkuy7ATs0nyti9jVtYEI7Xvu9DI=;
 b=ad/1INVOB+OvJI1fqch2g07XuZ/pfMITBxIFMTMYmpFPHPEb0eEEnUSFsVH7+mhjBG
 IOpL0njCZb5qzlWuEG9WJFzJ60slDU7wLoKojeARQu4z8GShT/9kgr+EfLXaN9Qewt96
 y9iSzDptzrx6Tw1qrLpMHhfLdi+3noBBR+B3p9Ahj8Su00XeDGSrnaK4Q0MTgiM9ysSU
 bon219Q1rRQVPRYJ2CtfHy48n3kFblhFCva0fT2n7qarQkRvNzDypvjUFs8+Zt3xhyPg
 jSN7Xd4ZgCIWdwNMo8H4E1zghcNxi/RKpoEx7CT7m/FOdgXBiDMWj8aCZE93H1BdOWYF
 CJsQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770289091; x=1770893891; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xi1iokQkGw8GZF0xxDEjxZdLtwNuhyZxehAKTgy2E8s=;
 b=mUwArEEr1fvp1njk9EMru50pWNlAtzg5fWPc7n/sMeYceYYycocio1oXYWKEwTYSKn
 zIc2TV3XYMZweuso9UGiyBRRbrIXwMIgaO040CV2UPCGoRhgRWVlVfeql6Jl6VRq2jPo
 kqRVcect9DqsPajswvlsfn0ry+q1aDl4pk0P7vrnbVGVlKtSjNS8fnKvYTBAPY2+J1ps
 7J3MMRmcZ0UCZxGuZIU5mQhnj6CJxOVQukWHUT3+ivr3cLYsdDj+Y1cAkBthuSf29HH6
 MyjDv+u0Wbet/4pStjxgxWucE0xtk1qjTz81thpnCvypUz2NrbbVWgIzbMspU67n0y5E
 qG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770289091; x=1770893891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xi1iokQkGw8GZF0xxDEjxZdLtwNuhyZxehAKTgy2E8s=;
 b=XUE8tUuLYxMsmMJtH70YuhI6jRgPc0U+wnWm8HJ567OEuqru8fH2tdxQ/5Zyso9xN4
 pY76+i1Suew84FShoGA1PkaRubsk4nvx/S1A/DDYIEz0B8Ykdm9NGrH7xC7WG3WpY3s/
 57OcXdDQBryCJnoBRgdBYF/LoVBn4nevkgI/Loy/aRsRnLnZTWOgkxysi5MMNaht00is
 fYttzIQEXl70uEWDlurkBorIRLdjvJnn5oB9gtPGOE28drpy1lYQDNX+q7iY7CPOsqlE
 fYqNjryUtGlRkY0ep5cilOCThS+prsJJXaOlRV+o6lw0bs7NiqB67q+MZ7Fe5TfOsLmy
 7D2A==
X-Gm-Message-State: AOJu0YyDrtF8clPBU9v3nTXh++//bdzq6hYo9glHSqrZ/CVvqmCNKnr7
 FlhaNR0No+mpRmrL6EGAtpt26rktvvlIB3k+aHRE7TKepW5jgex2XtrH/+QYcLWPqx23ruvlQS9
 ZpCLgYsaDP6ksVTMDox84DieIcAuO2LQ9PzMR42gJIg==
X-Gm-Gg: AZuq6aLdbCvTfpO3Jq7xGvv41v+o29WUWDmyFXJ3uBLkIrNbodwSPQqLCN7s5yzZw24
 6yoKP5tziVf3NHzGVMS+7fBwlxXx4j0LShbrY1BgCR5pAcKlBfW+h0k/Ch8LN0kXxRlnJnfV1M+
 8055NTME68Nz9ACj7PNjnYvJgWwKCSJpgtcqplPiA9UI9WOMbfTSpz5Mx5j2hU1Sp4zP/F2ZSLe
 gQ4Sb4EKvO7OqZSLaRwBp4/LJhFMziyzo9lEydNRFWuWdECTZ9r2RyrX3SM2V/t7r/KtHpHjM52
 Oqjs
X-Received: by 2002:a05:690c:c190:b0:794:8853:53f7 with SMTP id
 00721157ae682-794fe84fc60mr56277547b3.69.1770289091115; Thu, 05 Feb 2026
 02:58:11 -0800 (PST)
MIME-Version: 1.0
References: <CGME20260203130603epcas5p4dfde087764b1131e855c39ac9ceb0326@epcas5p4.samsung.com>
 <20260203130257.3263336-1-ashish.a6@samsung.com>
In-Reply-To: <20260203130257.3263336-1-ashish.a6@samsung.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Feb 2026 10:57:58 +0000
X-Gm-Features: AZwV_Qh8xYUWFFL590jYYEvEnv-pkCUAabxE_KpJP4kNfDiKiIDUC2N_0xUoxqc
Message-ID: <CAFEAcA-kV4JmjwmbByYAf5ws7No0HP372cjRWsnH6mbZwvouRw@mail.gmail.com>
Subject: Re: [PATCH v3] target/arm: Implement WFE,
 SEV and SEVONPEND for Cortex-M
To: Ashish Anand <ashish.a6@samsung.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, saurabh@samsung.com, 
 vishwa.mg@samsung.com, y.kaushal@samsung.com, ashish.anand202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Tue, 3 Feb 2026 at 13:06, Ashish Anand <ashish.a6@samsung.com> wrote:
>
> Currently, QEMU implements the 'Wait For Event' (WFE) instruction as a
> simple yield. This causes high host CPU usage because guest
> RTOS idle loops effectively become busy-wait loops.
>
> To improve efficiency, this patch transitions WFE to use the architectura=
l
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
>
> Changes in v3:
> 1. Changed event_register from uint32_t to bool, as it's architecturally
>    a single-bit register. (Alex Benn=C3=A9e)
> 2. Refactored nvic_update_pending_state() to accept VecInfo* and scr_bank
>    as parameters instead of recalculating them from irq/secure. (Peter Ma=
ydell)
>
> Link to v2 - https://lore.kernel.org/qemu-devel/20260121132421.2220928-1-=
ashish.a6@samsung.com
>
>
>  hw/intc/armv7m_nvic.c      | 114 ++++++++++++++++++++++++++++++-------
>  target/arm/cpu.c           |   6 ++
>  target/arm/cpu.h           |   7 +++
>  target/arm/machine.c       |  19 +++++++
>  target/arm/tcg/helper.h    |   1 +
>  target/arm/tcg/m_helper.c  |   5 ++
>  target/arm/tcg/op_helper.c |  56 +++++++++++++++---
>  target/arm/tcg/t16.decode  |   5 +-
>  target/arm/tcg/t32.decode  |   5 +-
>  target/arm/tcg/translate.c |  29 ++++++++--
>  10 files changed, 212 insertions(+), 35 deletions(-)
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 28b34e9944..0be8facb8e 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -221,6 +221,29 @@ static int exc_group_prio(NVICState *s, int rawprio,=
 bool targets_secure)
>      return rawprio;
>  }
>
> +/*
> + * Update the pending state of an exception vector.
> + * This is the central function for all updates to vec->pending.
> + * Handles SEVONPEND: if this is a 0->1 transition on an external interr=
upt
> + * and SEVONPEND is set in the appropriate SCR, sets the event register.
> + */
> +static void nvic_update_pending_state(NVICState *s, VecInfo *vec,
> +                                      int irq, int scr_bank,
> +                                      uint8_t next_pending_val)
> +{
> +    uint8_t prev_pending_val =3D vec->pending;
> +    vec->pending =3D next_pending_val;
> +
> +    /* Check for 0->1 transition on interrupts (>=3D NVIC_FIRST_IRQ) onl=
y */
> +    if (!prev_pending_val && next_pending_val && irq >=3D NVIC_FIRST_IRQ=
) {
> +        /* SEVONPEND: interrupt going to pending is a WFE wakeup event *=
/
> +        if (s->cpu->env.v7m.scr[scr_bank] & R_V7M_SCR_SEVONPEND_MASK) {
> +            s->cpu->env.event_register =3D true;
> +            qemu_cpu_kick(CPU(s->cpu));
> +        }
> +    }

I looked a bit more closely at the SEVONPEND language in the Arm ARM,
and it says

# When SCR.SEVONPEND bit associated with a security state is one, interrupt=
s
# transitioning from the inactive to the pending state that target that
# security state are wakeup events.

So the thing that determines whether we are looking at the S or the NS
SCR.SEVONPEND is "does this interrupt target S or NS security state?".
We have a function for that:
 exc_targets_secure(s, irq)

So we can determine which SCR to look at in this nvic_update_pending_state(=
)
function and we don't need the callers to pass in scr_bank to us.

exc_targets_secure() requires it to be called only for a non-banked
exception, but we can call it only inside the irq >=3D NVIC_FIRST_IRQ
condition, as all interrupts are non-banked.

This should simplify the changes you're making at the callsites.

thanks
-- PMM

