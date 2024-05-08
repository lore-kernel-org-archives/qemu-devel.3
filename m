Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D64EC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4hEe-0007a4-03; Wed, 08 May 2024 09:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4hEc-0007ZJ-Ge; Wed, 08 May 2024 09:21:26 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4hEY-0003EA-C5; Wed, 08 May 2024 09:21:25 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e9ffd3f96eso34107475ad.3; 
 Wed, 08 May 2024 06:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715174480; x=1715779280; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Imkkr7JpvmRW+jBNd4fwuNNIxf8RdheBdj+6HFjFxY=;
 b=hmBnWA6pJMJSNwut1l6930bzEo8LmWvErhJ5FmqjF+y8dOQBPK2anb7JAPvIcDB6BJ
 PxKttD/3Azw6lpBfsSD/F5MzaJvs2M/K2mrXGou25xPnwsJcA/YoXhtMCnOglj+VdLEp
 BULBY7x+0anoRK+h2malGRAPe94CQyT59cYEeWYch5kaA7ZIu93/2LT0IGIFhtcbvRK7
 mD5LcCTMUpVMae8VW6ZTSdQZj3GIm7ThzvwT/QGKIaxZSYMYUCgmtiZsP3ZHnq1R28gn
 XvDqXYk8KbyMxTo2wJGQb+D6Q+9szMMCDkJTsjQ0nD1VTq4sCLuQTu+GXzB/I0UgZQ7y
 pIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715174480; x=1715779280;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4Imkkr7JpvmRW+jBNd4fwuNNIxf8RdheBdj+6HFjFxY=;
 b=uEgzIV2BD3to8y1kMWVs8jNriHBB7vFo1bMBLDezJ+ObH41NMVQ9QXtkbV6VhYWAHA
 5p+9+FNVZGLoY2DOyy0e1qSOfv3m7Fyf16NvVvWvde5ISRplMrTP3bsdaBhiSclR/6m+
 MdhzMN5wONeMMxCE/6L6FZrq0C64m0GoNtYAJCihUU0DXqR+wj9E4RwNoKQDdfJfl3TK
 xgmtaoFIlqBS9wMiNirUibhMBxRo4SynDI4LyJWI6aQ9r6iysGTM71leqY0efltiAKwj
 gWgvyfHZfRo6Cdy8lka9QjK1RNfRZeJPngOblQjTpKGxg91Dwu7gTygx7rQWGnYM8LW2
 Bgqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgW3bq7CAIEMXMtPQo+TNH0nRVxTVjjj4bdksXEqzm7m3u5ouzw+ZBmklIbFgB4uNUpfhYmhQT89nJr4HlckXEhhdNLrpvbrCDYyp00MkMD07Hs80tLs4EOG4=
X-Gm-Message-State: AOJu0Yzu5M1rmD6re6ZLe2Hp0KgtXNpSKKaJPjzhoNT9v34QBPeymDNj
 lNAVT09rivQjZ0dmQvTwEzipjlHYThIM/bRttoY7/JlwSZ9LXoaT
X-Google-Smtp-Source: AGHT+IG1lTUyKeX5X7Hj/DAYkMhS2zgEArxmFI8orGXv51Caa6I6FGrihLVO6kU5KqLavVaNiSacPw==
X-Received: by 2002:a17:902:db06:b0:1e3:cfc5:589e with SMTP id
 d9443c01a7336-1eeb07973e4mr32505705ad.64.1715174480014; 
 Wed, 08 May 2024 06:21:20 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 z14-20020a170903018e00b001ec5cbd4af5sm11794153plg.305.2024.05.08.06.21.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 06:21:19 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 23:21:13 +1000
Message-Id: <D14ALVLA6XNQ.3LZVVSWJFFC5P@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 27/33] target/ppc/mmu_common.c: Simplify
 ppc_booke_xlate() part 2
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <491e06ba9f350c9c2843d92b25800dcda191e604.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <491e06ba9f350c9c2843d92b25800dcda191e604.1715125376.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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
> Merge the code fetch and data access cases in a common switch.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 50 +++++++++++++++++------------------------
>  1 file changed, 20 insertions(+), 30 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index c725a7932f..04e5ad661d 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1206,45 +1206,35 @@ static bool ppc_booke_xlate(PowerPCCPU *cpu, vadd=
r eaddr,
> =20
>      log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
>      env->error_code =3D 0;
> -    if (ret =3D=3D -1) {
> +    switch (ret) {
> +    case -1:
> +        /* No matches in page tables or TLB */
>          if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
>              booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_id=
x);
>          }
> -    }
> -    if (access_type =3D=3D MMU_INST_FETCH) {
> -        switch (ret) {
> -        case -1:
> -            /* No matches in page tables or TLB */
> -            cs->exception_index =3D POWERPC_EXCP_ITLB;
> +        cs->exception_index =3D (access_type =3D=3D MMU_INST_FETCH) ?
> +                              POWERPC_EXCP_ITLB : POWERPC_EXCP_DTLB;
> +        env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +        env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_type=
);
> +        break;
> +    case -2:
> +        /* Access rights violation */
> +        cs->exception_index =3D (access_type =3D=3D MMU_INST_FETCH) ?
> +                              POWERPC_EXCP_ISI : POWERPC_EXCP_DSI;
> +        if (access_type !=3D MMU_INST_FETCH) {
>              env->spr[SPR_BOOKE_DEAR] =3D eaddr;
>              env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
> -            break;
> -        case -2:
> -            /* Access rights violation */
> -            cs->exception_index =3D POWERPC_EXCP_ISI;
> -            break;
> -        case -3:
> -            /* No execute protection violation */
> +        }
> +        break;
> +    case -3:
> +        /* No execute protection violation */
> +        if (access_type =3D=3D MMU_INST_FETCH) {

-3 can't be a data access I think, so if is not required.

Thanks,
Nick

>              cs->exception_index =3D POWERPC_EXCP_ISI;
>              env->spr[SPR_BOOKE_ESR] =3D 0;
> -            break;
> -        }
> -    } else {
> -        switch (ret) {
> -        case -1:
> -            /* No matches in page tables or TLB */
> -            cs->exception_index =3D POWERPC_EXCP_DTLB;
> -            env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -            env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
> -            break;
> -        case -2:
> -            /* Access rights violation */
> -            cs->exception_index =3D POWERPC_EXCP_DSI;
> -            env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -            env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
> -            break;
>          }
> +        break;
>      }
> +
>      return false;
>  }
> =20


