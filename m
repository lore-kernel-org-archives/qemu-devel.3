Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9492CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9k3p-0007gY-47; Fri, 17 Oct 2025 08:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9k3m-0007gD-8G
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:59:54 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9k3h-0002ZK-2S
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:59:53 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-635401a8f5aso1801756d50.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760705979; x=1761310779; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QZaAGWVd+9bKOBG/oLPZuctzC2f8axpn92iPpi5vdSg=;
 b=im0s9hzLgBDTCvtM0L96M3TVr7VzqA25prkazf3GyEYN4BejtPaUaKA0OGFF+vZTwf
 XoHyzq3o6F82bblL+K/NR36LgOY8U2iMKLd+mct5BGGTOj7UKsNP2gHw44JlSrbxbPIY
 dPDmO4trU6YF06VICqhwBIIJ2ioikDeMMVorlUrwKqdB2rUrTxC7k+zKm/cl830WGWIw
 Q93Dm7jW2m/AoOJYWbhghNwmQSacmadT2XxbmoS/o8zB0mXI/FAx6IhATTVnn8S4J0pU
 50KNI5GR6sODYkbYFqTUleyvrSpO4RRINVq35k+4rmqUZEpN1JNir/awB5W2rB9C9NOJ
 hbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760705979; x=1761310779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QZaAGWVd+9bKOBG/oLPZuctzC2f8axpn92iPpi5vdSg=;
 b=l5YAgy+C2zFqWdhMKtlqb4Hg3fQmlNUZ8NJBqh4605lTpPXJHLxsTeE7L8brzeKlf1
 0q39SkG6YUIzp/dbq7PFKwqlD8wP3DZt0WF67kebKb25FpMcsggQWVuDL9SuNlcsKKVP
 bWKja4jrLcNevomS1Ln9IkFnW8TEjALwGSDCdSUSKbVWacM0Zq7zA1IoRLPt4eprOh7a
 uuhO5BO5uZsJ1YqOrXoMmw8xXSF+PY3FV8d+CScjYQFQLyTMA42LupX3wbeQNuBzs1CE
 JaDxKbntXwFBe8SV9w1YxWHdUAQlG8OeoC72clJgjlZmwXipB5G0sBCDxD7mvmYULO3U
 PYqg==
X-Gm-Message-State: AOJu0Ywohk4Y7KemqUBJ7/6JvNJCnGjGV8VwXp7vdItGUKRxEcf1I9tA
 WUjRbq2mNQ5aPJIhEaBn8N95ZYfxzqdMhB0Zf8gssLVaBcMMagFCdSvfzI9e0K6iqP/gENA/Yem
 fu0IfLIiW6FmwLKwQfmeAY3x84OFuTwssPXdDs4YweQ==
X-Gm-Gg: ASbGnct9+DmVpuS9olwxNem0e2b3ngrNfsqXZdOw2EUtg0HyMH9cMqUqj/DTPwJosWs
 xWlYJJjs+eSOky/xv4ly4NYPQvSPZqfS+JtUDgDTsjFm46/P7rbX1lwjm0deszk+ExyD0DXTImw
 R69c9VVBbqGnkDiiRT7twxIfzZOPL1d0SnB7LKbP0ModKKe0Cmap0XcSEm8ysnGNDmtn6Isbmhb
 KN6p+ve6IURAPmhnYw+2h7czFDvBeZf9SZubGO4ZSbUT7dHFBpfIRCZijTaCXq+GbA3dj9H
X-Google-Smtp-Source: AGHT+IFsp+KjJeef6nrK6RkNL7gx8edXZj5RZVdTLVRwu0i2zC6D6607prPMcRy6q3actXqDWA3spW9/yJXsxcUyw70=
X-Received: by 2002:a05:690e:4294:10b0:63c:daf9:bf21 with SMTP id
 956f58d0204a3-63e1619a19cmr2699893d50.24.1760705979239; Fri, 17 Oct 2025
 05:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-5-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Oct 2025 13:59:26 +0100
X-Gm-Features: AS18NWD2On5eeSo4suMhyMg6ES0BJX9FTt4eqzEIRBuAnFaqjNSQ_nF1rT5ESso
Message-ID: <CAFEAcA_YRU8F02wM2z_DvR-0hryUYEZYA99fy1c+H3M6xzqN0Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/37] target/arm: Asserts for ARM_CP_128BIT in
 define_one_arm_cp_reg
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 14 Oct 2025 at 21:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> 128-bit registers are aarch64 only; disallow non-zero reset values.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 8c0b8889db..3b06704963 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7805,6 +7805,22 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
>      assert(r->state == ARM_CP_STATE_AA32 || !(r->type & ARM_CP_64BIT));
>      /* AArch32 64-bit registers have only CRm and Opc1 fields. */
>      assert(!(r->type & ARM_CP_64BIT) || !(r->opc2 || r->crn));
> +    if (r->type & ARM_CP_128BIT) {
> +        /*
> +         * Only AArch64 regs are 128-bit.  There is usually an AArch32 64-bit
> +         * register aliasing the low half, which must be defined separately due
> +         * to encoding conflicts above.
> +         */
> +        assert(r->state == ARM_CP_STATE_AA64);
> +        /*
> +         * All 128-bit regs are UNKNOWN at reset, so there's no need
> +         * for either resetvalue or resetfn.  For those EL2 registers
> +         * that become CONST RES0 for EL3 with EL2 disabled, we allow
> +         * ARM_CP_CONST, but only with value 0.

We might mention that QEMU chooses to always zero the regs
at reset.

> +         */
> +        assert(r->resetvalue == 0);
> +        assert(r->resetfn == NULL);


I assume that not permitting a non-zero reset value is just
"we don't need this yet, so don't bother writing code for it" ?

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

