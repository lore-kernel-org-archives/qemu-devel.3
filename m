Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E40D6DDF8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 13:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBvuz-0007fN-T9; Fri, 15 Nov 2024 07:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBvuu-0007dV-Mq
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 07:59:18 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBvut-0002CD-4D
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 07:59:16 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa1e6ecd353so128458466b.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 04:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731675553; x=1732280353; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uzNKzJvzt92sdn/iXGVjikpGgnqoCCvyBSOAdEirGf8=;
 b=LpMCd1fa4lhNN04TA4KgSWkYri8goaHpbmtPuseAG9fdJd1tsgeTwK9wdml23hAyL5
 CrSmujjalfKigdz2Bg3MIJXB53gmwmUrayifJCHQ58uUOl9P/73a9b9hk2zZchEOitRZ
 CMYrelbH+hdx1Gg4UDUWmygXo7Spq314U0uY5vInmxPUqesqsJmK37El1NEw71L/J4Wf
 TZyYZkeE3kel15/LvY2a/vH4WMZHz/SXjIATklF2yB2iOK1RL/pMAiplU7xFDJlbS7AV
 AISZQETB7XHe/GGNMrkH34AJY81W7G9MlRGmtmwvGXowc60+/WdYjUOfYg49RpVi8rmq
 VWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731675553; x=1732280353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uzNKzJvzt92sdn/iXGVjikpGgnqoCCvyBSOAdEirGf8=;
 b=BxhwYmPymSGwW8lFXrsSeczukwH/kJsPKARbMBwQIDRNAbVIAcN8HcKHxA2Rh8a2KW
 gG2LLww+ylolvDRdO1pxRaG6d/oWJUFRzSs1dROGKpFaLUDlAwna3yu85DGxzXohYAJK
 x5u27bUaBUjHGIG4lWkKo4arsHHNX9vX1323usdpbtq8bo1pzvYtfmnucEUmIxadBWHY
 /wGs7JGlzLWeDmcYIgcARjcDMw+6QmLAUlrAb1PL1sZMj5CpB+aGNRbUCUEm0DL5dP8i
 lDmdgBajJfuoNxJCwAtlBHDKJFLBGvLv8ML91rcya6qVfU0Uf8R1NLAulM1y9I6Qv7oh
 qx+g==
X-Gm-Message-State: AOJu0Ywc3QYUJ/aXdL+9PShhL+wqAuQlRskNLfdNvFUx4A/eyoDOdyKg
 h71J5OkJRxX+wTEbuFPtSgXjgOwIeWBkYWyeGu0NwxYrxmQWiT6JiPiPcNVFE5eR8Aa60oGGLja
 0+Sg1loWjbwQJ3xGVxu94WraMfJGCN5MQRlWi5g==
X-Google-Smtp-Source: AGHT+IH6zCrPLNiLcFEPxfneC825aFAgl8X901j6T5glmZU6jinSQeD9Tar3ocvX96HsCerkHN9S+Uets8048RwwLOc=
X-Received: by 2002:a05:6402:2789:b0:5cb:f1d7:56ac with SMTP id
 4fb4d7f45d1cf-5cf8fc63764mr2077136a12.2.1731675553139; Fri, 15 Nov 2024
 04:59:13 -0800 (PST)
MIME-Version: 1.0
References: <20241113173622.79447-1-castet.matthieu@free.fr>
In-Reply-To: <20241113173622.79447-1-castet.matthieu@free.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 12:59:02 +0000
Message-ID: <CAFEAcA8hb9+U0ZZoA=WHscpxKsDdJxhobgMAzX0C0k939dk_UA@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Add cortex-m0+ support
To: Matthieu Castet <castet.matthieu@free.fr>
Cc: qemu-devel@nongnu.org, "open list:ARM cores" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Wed, 13 Nov 2024 at 17:36, Matthieu Castet <castet.matthieu@free.fr> wrote:
>
> Signed-off-by: Matthieu Castet<castet.matthieu@free.fr>

Hi; thanks for version 2; this looks pretty good and I just
have a couple of small nits.

Firstly, there's still no commit message body text here.
Commit messages should explain the intention of the commit
and roughly what the change is doing. If you look at
"git log" you'll see that subject-line-only commit messages
are the exception, not the norm (and are usually only for
pretty mechanical changes done as part of a whole series
that's doing the same kind of change).

> ---
>  hw/intc/armv7m_nvic.c    | 51 ++++++++++++++++++++++++++++++++++++++--
>  target/arm/cpu.c         |  5 ++--
>  target/arm/ptw.c         | 14 +++++++++--
>  target/arm/tcg/cpu-v7m.c | 17 ++++++++++++++
>  4 files changed, 81 insertions(+), 6 deletions(-)
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 98f3cf59bc..41d2b98ee4 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -1386,7 +1386,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
>          }
>          return (cpu->env.pmsav7.drbar[region] & ~0x1f) | (region & 0xf);
>      }
> -    case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */
> +    case 0xda0: /* MPU_RASR (v6M/v7M), MPU_RLAR (v8M) */
>      case 0xda8: /* MPU_RASR_A1 (v7M), MPU_RLAR_A1 (v8M) */
>      case 0xdb0: /* MPU_RASR_A2 (v7M), MPU_RLAR_A2 (v8M) */
>      case 0xdb8: /* MPU_RASR_A3 (v7M), MPU_RLAR_A3 (v8M) */
> @@ -1407,6 +1407,14 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
>              }
>              return cpu->env.pmsav8.rlar[attrs.secure][region];
>          }
> +        if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
> +            /*
> +             * armv6-m do not support A alias
> +             */
> +            if (offset != 0xda0) {
> +                goto bad_offset;
> +            }
> +        }

I think it would be neater to do the "alias registers not supported" as:

    case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */
    case 0xda8: /* MPU_RASR_A1 (v7M), MPU_RLAR_A1 (v8M) */
    case 0xdb0: /* MPU_RASR_A2 (v7M), MPU_RLAR_A2 (v8M) */
    case 0xdb8: /* MPU_RASR_A3 (v7M), MPU_RLAR_A3 (v8M) */
        if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
            /* No alias registers in v6M */
            goto bad_offset;
        }
        /* fall through */
    case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */
        [code for MPU_RASR starts here]


You're also missing the "no RBAR aliases" handling in nvic_readl().

>          if (region >= cpu->pmsav7_dregion) {
>              return 0;
> @@ -1876,6 +1884,21 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
>              return;
>          }
>
> +        if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
> +            if (offset != 0xd9c) {
> +                /*
> +                 * armv6-m do not support A alias
> +                 */
> +                goto bad_offset;
> +            }
> +
> +            /*
> +             * armv6-m do not support region address with alignement
> +             * less than 256. Force alignement.

Typos: "does not", "alignment".

> +             */
> +            value &= ~0xe0;
> +        }
> +
>          if (value & (1 << 4)) {
>              /* VALID bit means use the region number specified in this
>               * value and also update MPU_RNR.REGION with that value.

The rest of the patch looks good.

PS: there's no rush about producing a v3 -- we're currently in
freeze for the 9.2 release, so this won't be going into git
until we make the 9.2 release in late December.

thanks
-- PMM

