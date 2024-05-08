Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475B2C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4hBj-0005tA-9E; Wed, 08 May 2024 09:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4hBO-0005np-7V; Wed, 08 May 2024 09:18:07 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4hBK-0002XN-H5; Wed, 08 May 2024 09:18:05 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1edf506b216so23689285ad.2; 
 Wed, 08 May 2024 06:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715174278; x=1715779078; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ig4eN1BpKH6nCDo4aALwl+5py7Hm+Oporkfqz7XA5LQ=;
 b=jQaZALDplGUkA3oSaN3/DvfekW7kfKYHW+RgT0T4XlVO4MZgRhZOK8bPeDecPYDLXF
 JiiiiopGsIvUgfM5hWFv7ZebJ6m+Q3bjLYLwNgt9xD8QAr8foYI+5oJkC1UUtFDRHsHO
 1IRzBdZbB2fSAKI01bVw7J7TeYodhnQeMKxbf8hapOVruCDiqZb+kflmCX5chM4xCLsY
 ugLtRIOOPlSq2o0dliWwQtA65jb7S0aATdeb4RRxN6vy7+lyR7oSz31oEQv/u5xoaS8v
 fPb8kNhgaF2MuyqbeFWph6DCRK7EApMMnmaCVUSMTv2xtDhcWxMhmGNjxJqKnF/kND98
 IsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715174278; x=1715779078;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ig4eN1BpKH6nCDo4aALwl+5py7Hm+Oporkfqz7XA5LQ=;
 b=V02lb90apIRCrY7sXccWfbn4wYBITin36F9zCdfU8hORN860Tp9yeSS3SgwKQrFWuN
 r9SAxEjY4uawsUlowzM5XpKdh7ewBMYC16Iv53bV4NvVo7Ch4mGdOcGic7Eq8iPAvkRs
 dIpwRpkoNJLJkkCv58nW4EyAVglXDZm1XFyQYbZpxttJwM+BOHhXM6sn30E35XHPbS1B
 vS2zZDeiRq8o+jBWnJ4jlpRHSQe56Wp7tTQGrXIJyzghXekKOL9ijG+avv0w8qjdyGqR
 7blgyVEIblHYVfQx8NMOf+J2JVtq3nnHnSOq2qffVVOVThbXoi/1rgsbyxZsJvnwPe7y
 Ki5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT2Q6014zzDEgcqYHk3HgUvL8wx2ZeHL2zqHhevM46mEaAFTsrgjzAeDz8j3sDlp9dXm/6EH6aZUUeOABG8Km4NhLxkFh1JVYNQ02iUeEvDl+juP8rMoIOvXg=
X-Gm-Message-State: AOJu0YyikppZdZpirGCjG93H5bdJFNcB/xGk70Rw9GhElBh2xAJjT3X+
 ZpsqdXtUaoktAEovt/lss7ZRHhkEudo9OFvngGFXhkkjFGYaHAzq
X-Google-Smtp-Source: AGHT+IFHvk5szkRoyea0HY4cDSZKJpY1+ztM1offnBFhJNoozYA9Ulw4m2bfj2e+5lnpVbqpqmqWkg==
X-Received: by 2002:a17:902:db09:b0:1e4:4ade:f504 with SMTP id
 d9443c01a7336-1eeb0998a2fmr30176535ad.46.1715174278051; 
 Wed, 08 May 2024 06:17:58 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 lb5-20020a170902fa4500b001dd69aca213sm11752374plb.270.2024.05.08.06.17.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 06:17:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 23:17:52 +1000
Message-Id: <D14AJB3VXJL0.18D5ZU7FZFOLN@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 26/33] target/ppc/mmu_common.c: Simplify
 ppc_booke_xlate() part 1
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <5074c129ebfea0e1dfc22ef4691d8b62038d59b2.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <5074c129ebfea0e1dfc22ef4691d8b62038d59b2.1715125376.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

On Wed May 8, 2024 at 10:15 AM AEST, BALATON Zoltan wrote:
> Move setting error_code that appears in every case out in front and
> hoist the common fall through case for BOOKE206 as well which allows
> removing the nested switches.
>
=20
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 41 ++++++++++++-----------------------------
>  1 file changed, 12 insertions(+), 29 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 788e2bebd5..c725a7932f 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1205,58 +1205,41 @@ static bool ppc_booke_xlate(PowerPCCPU *cpu, vadd=
r eaddr,
>      }
> =20
>      log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
> +    env->error_code =3D 0;
> +    if (ret =3D=3D -1) {
> +        if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> +            booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_id=
x);
> +        }
> +    }
>      if (access_type =3D=3D MMU_INST_FETCH) {
>          switch (ret) {
>          case -1:
>              /* No matches in page tables or TLB */
> -            switch (env->mmu_model) {
> -            case POWERPC_MMU_BOOKE206:
> -                booke206_update_mas_tlb_miss(env, eaddr, access_type, mm=
u_idx);
> -                /* fall through */
> -            case POWERPC_MMU_BOOKE:
> -                cs->exception_index =3D POWERPC_EXCP_ITLB;
> -                env->error_code =3D 0;
> -                env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -                env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, acc=
ess_type);
> -                break;
> -            default:
> -                g_assert_not_reached();
> -            }
> +            cs->exception_index =3D POWERPC_EXCP_ITLB;
> +            env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +            env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
>              break;
>          case -2:
>              /* Access rights violation */
>              cs->exception_index =3D POWERPC_EXCP_ISI;
> -            env->error_code =3D 0;
>              break;
>          case -3:
>              /* No execute protection violation */
>              cs->exception_index =3D POWERPC_EXCP_ISI;
>              env->spr[SPR_BOOKE_ESR] =3D 0;

I don't know BookE well but AFAIKS it says ESR if not set explicitly
is generally cleared to 0 by interrupts which I guess is the case here.
I don't see why the same would not apply to the -2 case either. That
would reduce special cases.

Although that's a behaviour change. It's possible current beahviour is
deliberate or matches some particular CPU. Not something for this
series.

Thanks,
Nick

> -            env->error_code =3D 0;
>              break;
>          }
>      } else {
>          switch (ret) {
>          case -1:
>              /* No matches in page tables or TLB */
> -            switch (env->mmu_model) {
> -            case POWERPC_MMU_BOOKE206:
> -                booke206_update_mas_tlb_miss(env, eaddr, access_type, mm=
u_idx);
> -                /* fall through */
> -            case POWERPC_MMU_BOOKE:
> -                cs->exception_index =3D POWERPC_EXCP_DTLB;
> -                env->error_code =3D 0;
> -                env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -                env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, acc=
ess_type);
> -                break;
> -            default:
> -                g_assert_not_reached();
> -            }
> +            cs->exception_index =3D POWERPC_EXCP_DTLB;
> +            env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +            env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
>              break;
>          case -2:
>              /* Access rights violation */
>              cs->exception_index =3D POWERPC_EXCP_DSI;
> -            env->error_code =3D 0;
>              env->spr[SPR_BOOKE_DEAR] =3D eaddr;
>              env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
>              break;


