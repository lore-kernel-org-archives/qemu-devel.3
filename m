Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D86C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFWs-0004Ua-8h; Thu, 04 Jul 2024 02:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFWa-0004NJ-Eh; Thu, 04 Jul 2024 02:01:02 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFWV-00038s-Ev; Thu, 04 Jul 2024 02:00:56 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70b03ffbb3aso29792b3a.0; 
 Wed, 03 Jul 2024 23:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720072849; x=1720677649; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pkEaecfA8Qa+Gntzof+nWUAJSUAfxHEjFryVxu0i/Ak=;
 b=ZyFYdJ7U9HsTnvL/EuWCVapAr0Xbtbt4Cp3Xn1PmnDyLc7/PlVl+WNUVoIKPe72X9E
 79iGeHJGkMlvyUeKshQRG9GmxfyIOJF2awaMTJ060v690EaiZNtSek8hEDyKDU51zCqd
 ++3fuXFL8LPwOejuCXWuNKruImBsqw+pvDcPQwqH3qQRO4bPV/dWnOCelTUBEKcC+NdJ
 eYI24QdDMI+mCyDspsG05JJ+muzKVx5mA5DfZ7WVM+Yjmvdyj74lqFfmWtg1TCaT2342
 rLtJVYfw+dFxRHJWRS3DOiY5AK1F/yBikklxRAgDZKtVvhCXaoN8h04yQ0Tr5aAtfdL8
 jLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720072849; x=1720677649;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pkEaecfA8Qa+Gntzof+nWUAJSUAfxHEjFryVxu0i/Ak=;
 b=SPk4hMx4rghc8ZfzY8hdonkDA6/Qu1JbxG4M642PCbrucwGzRydQTZy3SoKzTThNRU
 P2wBLT396MxEd7ghBWD7qFhN0vyVk1zN8lFRMMLfMRVCFAfYuAOYICvTyFIIZg9kxuIg
 zLpeBQejhm7644kUnT3Y5Zh1/djZkCoX5aMxJTW5CzFXfuqTCxZLkqYRhSUTTOqUXJR8
 ar61mQVGq4H3NfE2rmJZurS6x/ufbweM51ozAyGf2CPATNzY8vELo52/G6SP3fQzK0hX
 l5mfp1kdR8II/Hbl9bHO/yhwMQMHX4LV1AbgF0jtbIViaIC63nSEfKcZcfCN/5qjyae+
 PlzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2r7yUb28tM4D2UPt9ZEi/MW9v+r/RNIppeyfgTgAS2l0oYWhdFGah9YN/eArzZClcmCbzqbFFGNIs3JrCV+81OULSkbfo6EcuGLaJJI5CuDEfYcOmS0DLE2s=
X-Gm-Message-State: AOJu0YwmtGYtIMk+K9Dux8G1D7hRpmbj1kA4qLjJ3nSpaEdUMeSIOse5
 +9+i16RSS/zMItaX2kLUsagbA5OkkxDvQ3WUGo3O+mQc/RVTqTUl
X-Google-Smtp-Source: AGHT+IHkNp0tQSgQtjWm3Kq+v23paBBAky4TEvcqBLLZ9HXAm+YdF38/3fzS85HBV97zq3mOalHW4Q==
X-Received: by 2002:a05:6a00:1916:b0:705:9526:3c0d with SMTP id
 d2e1a72fcca58-70b00a905f5mr812931b3a.12.1720072849303; 
 Wed, 03 Jul 2024 23:00:49 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70804a99836sm11393211b3a.217.2024.07.03.23.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:00:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:00:44 +1000
Message-Id: <D2GIXO1OYJUA.RLAIO0SD7YHX@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 07/43] target/ppc/mmu_common.c: Return directly in
 ppc6xx_tlb_pte_check()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <5574bcdd8a8fb6a268206de61987ed40f99d79e6.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <5574bcdd8a8fb6a268206de61987ed40f99d79e6.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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
> Instead of using a local ret variable return directly and remove the
> local.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Some people probably prefer the existing style but I don't
mind early returns.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu_common.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 799d2ced9b..a5ae11394d 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -98,9 +98,6 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_=
ulong pte0,
>                                  target_ulong pte1, int pteh,
>                                  MMUAccessType access_type)
>  {
> -    int ret;
> -
> -    ret =3D -1;
>      /* Check validity and table match */
>      if (pte_is_valid(pte0) && ((pte0 >> 6) & 1) =3D=3D pteh) {
>          /* Check vsid & api */
> @@ -118,16 +115,15 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, tar=
get_ulong pte0,
>              if (check_prot_access_type(ctx->prot, access_type)) {
>                  /* Access granted */
>                  qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
> -                ret =3D 0;
> +                return 0;
>              } else {
>                  /* Access right violation */
>                  qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
> -                ret =3D -2;
> +                return -2;
>              }
>          }
>      }
> -
> -    return ret;
> +    return -1;
>  }
> =20
>  static int pte_update_flags(mmu_ctx_t *ctx, target_ulong *pte1p,


