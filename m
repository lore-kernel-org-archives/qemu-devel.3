Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB18FC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFY7-0005Lk-IQ; Thu, 04 Jul 2024 02:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFXv-0005KZ-RX; Thu, 04 Jul 2024 02:02:20 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFXt-0003Fx-7N; Thu, 04 Jul 2024 02:02:19 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-706b53ee183so995402b3a.1; 
 Wed, 03 Jul 2024 23:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720072935; x=1720677735; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDyJuQ4P0eX+LF/UbrDrid6G+w3QO+gGenYBAObnc44=;
 b=V1JjjkJLG+7C95a/VpK6EPdnq6XHddL8rRG/uI6BSwjw/7kambHcRq8lbgwAvTY6M5
 g9ZX3hrWPWb8pGzx6tYtiWFbo5huEKwFmQ8fpB59UHG0ju1yFGOY/Mv8a1M4mNam9VG/
 be+pGsZ2cf561ewpHUHmHD+3a5YTROWB4sA8siRi/wILMRCk7jLCpKpQC4GaSlyxmMwO
 xqLkyBBGphYA4cOLWNuOJ/lNVZ3AdYTMz0e/pfG9RbiwsX2ooAZeRcfhcnC8X39RHBvf
 8O4AuP2hZtVZS6Z8k+cZSMz369yrTDVamJ+bZvat5bKAvifcRSNCkp3gb9u7tGSBVVBQ
 mxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720072935; x=1720677735;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TDyJuQ4P0eX+LF/UbrDrid6G+w3QO+gGenYBAObnc44=;
 b=EkESd5hvoetuJi0sU3BRolvTQLXkZrmbHwbCAUAF7kxONRF+bqT2ct6Saofw62xuRn
 xa5GMphZEvda/Q/oeeO1h+f8UVZ2LdbyJXGAaXvXJ1nXmAcOdxdyU74rIFZTRx8duH+k
 kWgaGT+1H+t0YIYcXEiQq4PleGMxK3jfLZp7jaZ9KFZARzlmFaa2dqFAY4GmEmSYvJQ9
 KiH1H4WCmz+56rXaGeY/84pu8jSSiwN5Vncp5mz43mwAItM1nIdL9V74tMYEtD3YHAwU
 MEECzY1zpJLrZJeOL2Fk8+c/RE8bO5wknt9DuYx0qEpJF1IsWgg9ODP0W0d9Y2bIH2OG
 k7EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQcJhNKfS0ercl1Pu7T48jZY+R9UwrIQkn/QTcgpFHnaCOtlD7NjW2+2E2A9WB2XLBRtVUiOhwp/bxPy3bRPVR+pWqVkuQkADCK585BPCYTEbgX6rplcoFr5U=
X-Gm-Message-State: AOJu0YyeADhdMIpA6C1ICMHpHc76SGdhEQ69qW04XYlGqS6Zc7+eY2/D
 wz1Jt0rbEAIcoPJywAY/PJHzWDeDHdi4IWtRMAHC5+KDYi92jkQR
X-Google-Smtp-Source: AGHT+IFb1cgUD+22a/847ixOJihYrj4spfLNnTDZgn1nJ0/3yN3EabyAGPuAsFTMLmnlg/ax8Y90og==
X-Received: by 2002:a05:6a21:1191:b0:1be:c4bb:6f38 with SMTP id
 adf61e73a8af0-1c0cd1c50c6mr709005637.16.1720072935173; 
 Wed, 03 Jul 2024 23:02:15 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080256d3c5sm11431679b3a.83.2024.07.03.23.02.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:02:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:02:10 +1000
Message-Id: <D2GIYRFQNLW5.1XEFLOTI5A17U@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 08/43] target/ppc/mmu_common.c: Simplify
 ppc6xx_tlb_pte_check()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <3c507fa202f01f913c40fab7a53ef9f68c446e4f.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <3c507fa202f01f913c40fab7a53ef9f68c446e4f.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon May 27, 2024 at 9:12 AM AEST, BALATON Zoltan wrote:
> Invert conditions to avoid deep nested ifs and return early instead.
> Remove some obvious comments that don't add more clarity.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 43 ++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index a5ae11394d..28adb3ca10 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -99,31 +99,26 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, targe=
t_ulong pte0,
>                                  MMUAccessType access_type)
>  {
>      /* Check validity and table match */
> -    if (pte_is_valid(pte0) && ((pte0 >> 6) & 1) =3D=3D pteh) {
> -        /* Check vsid & api */
> -        if ((pte0 & PTE_PTEM_MASK) =3D=3D ctx->ptem) {
> -            if (ctx->raddr !=3D (hwaddr)-1ULL) {
> -                /* all matches should have equal RPN, WIMG & PP */
> -                if ((ctx->raddr & PTE_CHECK_MASK) !=3D (pte1 & PTE_CHECK=
_MASK)) {
> -                    qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
> -                    return -3;
> -                }
> -            }
> -            /* Keep the matching PTE information */
> -            ctx->raddr =3D pte1;
> -            ctx->prot =3D ppc_hash32_prot(ctx->key, pte1 & HPTE32_R_PP, =
ctx->nx);
> -            if (check_prot_access_type(ctx->prot, access_type)) {
> -                /* Access granted */
> -                qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
> -                return 0;
> -            } else {
> -                /* Access right violation */
> -                qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
> -                return -2;
> -            }
> -        }
> +    if (!pte_is_valid(pte0) || ((pte0 >> 6) & 1) !=3D pteh ||
> +        (pte0 & PTE_PTEM_MASK) !=3D ctx->ptem) {
> +        return -1;
> +    }
> +    /* all matches should have equal RPN, WIMG & PP */
> +    if (ctx->raddr !=3D (hwaddr)-1ULL &&
> +        (ctx->raddr & PTE_CHECK_MASK) !=3D (pte1 & PTE_CHECK_MASK)) {
> +        qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
> +        return -3;
> +    }
> +    /* Keep the matching PTE information */
> +    ctx->raddr =3D pte1;
> +    ctx->prot =3D ppc_hash32_prot(ctx->key, pte1 & HPTE32_R_PP, ctx->nx)=
;
> +    if (check_prot_access_type(ctx->prot, access_type)) {
> +        qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
> +        return 0;
> +    } else {
> +        qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
> +        return -2;
>      }
> -    return -1;
>  }
> =20
>  static int pte_update_flags(mmu_ctx_t *ctx, target_ulong *pte1p,


