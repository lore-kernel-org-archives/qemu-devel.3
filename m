Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99385C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Jal-00086a-8Z; Tue, 07 May 2024 08:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4JaB-0007ss-GZ; Tue, 07 May 2024 08:06:14 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4Ja8-0004T9-Qn; Tue, 07 May 2024 08:06:06 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e46dcd8feaso1140224b3a.2; 
 Tue, 07 May 2024 05:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715083560; x=1715688360; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CsfLt2ELJRR5gwQ/TP98rD7J8TCR0EDnni1zic3a3OM=;
 b=eFRXz1zX+8UK/oAye52vZ2R0VsRPd66VtRZsi43/bAD01us5hf3y3rrDXmW5jIMR+q
 izPFx0e4iQRUqCdt3WvwrkQ0g8M5WMnIa57yoANPuRvTts0C6sxLESz/cLmNV3zqgVVr
 aFcWr78AOky7yzL4EsydG/KAq/65SOTe9XIHgHYn74pcRc9o1KL/kWd0p0DL0kJyzmvF
 9BvL9Aoi1dSCZDDFnhQCbsLC4N43wOGJngzOsGWdML41CJDyT7kTkbgY2SXL7H7WoQk3
 rWyobWaM9Dci0T9m4zLXWq3klqgACw4BMC0QgDY54ZfngMZ6XU0iNVoEUecMQ7euhWnL
 zjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715083560; x=1715688360;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CsfLt2ELJRR5gwQ/TP98rD7J8TCR0EDnni1zic3a3OM=;
 b=diVgZwZtLuu5pu82NTPjtZauLn0UCBuGweyw2rmVJJXqSXR2kcPAcx8ZmzGqAsyik1
 sFXyCsE+DPewgaFDCCoWUGFOKzuzo//6yQsDhHcNKRC2fLt2uRJFDFC3JJckh3eX5Iv5
 l4CJYUBhfr275hDaRQX7KJrZAItDKZa6QQMKhSnByCsklW3PiVCezCL4Ql6g3NhK3SID
 f2X8+90OAAyHDYhb4bCYtb8ynT6xoTPjPTyai7ai+uJxTv0I0cpxorY+g+qtR4QOZh2B
 iaeWEPhcQUFLQe9ownm/kaEvCFJY234p+B6hB4NUx6KERi0CduBJ2Cqre+pq4AuJKlbW
 1vzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMokZDiqkRoWvoPXO2sdeFBNLcDYLboxajHDz0f3JJXmkiXFIBLBrva9WVIXyjOUPdY1LXLQfwLqnvNjwKDi9Zfl0EDifGjAYkWVoGL+ZSb1g7t20L+dEDUKQ=
X-Gm-Message-State: AOJu0Yzy/n/FY5HCiV70HuEY87zwPNbNY9DXPMsaZiHyBtvkZiQothlh
 wroZ8udVNS6zVeCtBIn5EdMD8DwzMvhpV0XZTAdlhflB1cKffK3G
X-Google-Smtp-Source: AGHT+IFll4zGe1WRWNeqw2uG4bR4SF/vE/ZRRD5YuRe4J/sjRXFD50ebJvnHBx70s4FNHZ47ljFwpQ==
X-Received: by 2002:a05:6a00:9393:b0:6ec:ebf4:439a with SMTP id
 ka19-20020a056a00939300b006ecebf4439amr13021915pfb.5.1715083559741; 
 Tue, 07 May 2024 05:05:59 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 z8-20020aa79e48000000b006f4496ea424sm7772381pfq.122.2024.05.07.05.05.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 05:05:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 22:05:55 +1000
Message-Id: <D13EDO9E2R7L.E6416WEFSMYL@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 24/28] target/ppc/mmu_common.c: Remove BookE handling
 from get_physical_address_wtlb()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <cd05e33ea86d301cf64aa3925a6302b92249ee3c.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <cd05e33ea86d301cf64aa3925a6302b92249ee3c.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> This function is no longer called for BookE MMU model so remove parts
> related to it. This has uncovered a few may be used uninitialised
> warnings that are also fixed.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 25 +++++--------------------
>  1 file changed, 5 insertions(+), 20 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index a1f98f8de4..d61c41d8c9 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -684,12 +684,10 @@ static int mmubooke_get_physical_address(CPUPPCStat=
e *env, mmu_ctx_t *ctx,
>          ret =3D mmubooke_check_tlb(env, tlb, &raddr, &ctx->prot, address=
,
>                                   access_type, i);
>          if (ret !=3D -1) {
> -            if (ret >=3D 0) {
> -                ctx->raddr =3D raddr;
> -            }
>              break;
>          }
>      }
> +    ctx->raddr =3D raddr;
>      qemu_log_mask(CPU_LOG_MMU,
>                    "%s: access %s " TARGET_FMT_lx " =3D> " HWADDR_FMT_plx
>                    " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
> @@ -897,9 +895,6 @@ static int mmubooke206_get_physical_address(CPUPPCSta=
te *env, mmu_ctx_t *ctx,
>              ret =3D mmubooke206_check_tlb(env, tlb, &raddr, &ctx->prot, =
address,
>                                          access_type, mmu_idx);
>              if (ret !=3D -1) {
> -                if (ret >=3D 0) {
> -                    ctx->raddr =3D raddr;
> -                }
>                  goto found_tlb;
>              }
>          }
> @@ -907,6 +902,7 @@ static int mmubooke206_get_physical_address(CPUPPCSta=
te *env, mmu_ctx_t *ctx,
> =20
>  found_tlb:
> =20
> +    ctx->raddr =3D raddr;

Not sure about the uninitialized warnings here either, caller probably
should not be using ctx->raddr unless we returned 0...

>      qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " =3D> "
>                    HWADDR_FMT_plx " %d %d\n", __func__,
>                    ret < 0 ? "refused" : "granted", address, raddr,
> @@ -1163,20 +1159,9 @@ static int get_physical_address_wtlb(CPUPPCState *=
env, mmu_ctx_t *ctx,
>                                       MMUAccessType access_type, int type=
,
>                                       int mmu_idx)
>  {
> -    bool real_mode;
> -
> -    if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE) {
> -        return mmubooke_get_physical_address(env, ctx, eaddr, access_typ=
e);
> -    } else if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> -        return mmubooke206_get_physical_address(env, ctx, eaddr, access_=
type,
> -                                                mmu_idx);
> -    }

This could just go in the previous patch when you split booke xlate?

> -
> -    real_mode =3D (type =3D=3D ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR,=
 IR)
> -                                      : !FIELD_EX64(env->msr, MSR, DR);
> -    if (real_mode && (env->mmu_model =3D=3D POWERPC_MMU_SOFT_6xx ||
> -                      env->mmu_model =3D=3D POWERPC_MMU_SOFT_4xx ||
> -                      env->mmu_model =3D=3D POWERPC_MMU_REAL)) {
> +    bool real_mode =3D (type =3D=3D ACCESS_CODE) ? !FIELD_EX64(env->msr,=
 MSR, IR)
> +                                           : !FIELD_EX64(env->msr, MSR, =
DR);
> +    if (real_mode) {
>          memset(ctx, 0, sizeof(*ctx));
>          ctx->raddr =3D eaddr;
>          ctx->prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;

This still changes beahviour of MPC8xx MMU doesn't it? It's supposed
to abort always.

Thanks,
Nick

