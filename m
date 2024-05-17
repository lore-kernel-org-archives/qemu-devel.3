Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75060C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 05:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7qTf-0005Ar-9W; Fri, 17 May 2024 01:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7qTa-00055H-FE; Fri, 17 May 2024 01:49:55 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7qTT-0007Eb-LT; Fri, 17 May 2024 01:49:54 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6f0fd87da53so676711a34.2; 
 Thu, 16 May 2024 22:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715924986; x=1716529786; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iL4Y7PlFLru0WP4FWQ4mV2efiOBBC3KcYFaoIpOXn2o=;
 b=VowNkej5wdxvlykFaOHW2/8mDl3hFR8FecQDAsphrZZnqzdUHCHN2xHrOHNNdvkHVD
 qXpXY6gtT5iOSVFLeqUVEgvYob9ruiRZzxBGjkb2ISQEhEREjFSSCLf5fiu35WVTXNUd
 rYT//38KR6TuXMfqni5J3WHtlBEBpr54jk9A2ZTIAdXlCE7dq4qxOAmCoiIfKjZJcLMG
 wKHfbNDWoyjyoKJ/hDM0ABPboYaHyookF4rcexjHveVfJynURaUv+5dRlZvlAO8c3ina
 JBlVXKwjV481W1WS++STRLg1GYpS2OTK9gxQmf8euUZgaf6sIpkqxape/gEN3ls+FgaF
 blcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715924986; x=1716529786;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iL4Y7PlFLru0WP4FWQ4mV2efiOBBC3KcYFaoIpOXn2o=;
 b=q3DBe8KVH5Rze0a7z84HZaMXzC2iT4li5odaqC5W0mo7HGPnwFEIZTjfzc+tUheRN/
 BC2iFThkB+/EDmlaJemoZ/pjWHRqB7AgMBuu5Lj2DneMAtiIcObi1p+ntVQ+GYY7AOUD
 eOimnt/6LIETNsKiwT4OYQN2k4iaSp76tk1VQ9bmpj7nwg3tCo2mWEcWJcNKVKqSVH3Z
 WPlMiqrbCXaP7R2APhaIzgNHjEafA5iTXH+wmjs6OTEgYDJrACmCRKwwASEmRMDiQjKQ
 atBg8jnSENHLT8LaeKjo0sFodETpE9JiYZjGpmXb0Sgdqoj7mu/ZlYp16Ff16pTrBZ7v
 05TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj6uMYafwNQ9vigw2c5yITFJJGjvYU3695ycgzMXBLmKrxwWHBPIBpYOruqBUyAALMNsyA5FOpo2oNeRSGQQ5uS6bDu3Z4bm/ZmQEFuMvaKD9Yn6+MOAXegx8=
X-Gm-Message-State: AOJu0YxzP5RZT4gCPpNOeBOMO1EmYcTgpgdgD9XEhHbYi8bDW3dAI5cY
 ErUVN41OkDjCdWITIqfVAv1/D0pOCJryzFdzUQDYoEAaLaeEHb2G
X-Google-Smtp-Source: AGHT+IFeekaBu9iKi0E4goyHqFO3oQIzmPz5NEK1/26+u/nyPKuAisrqiBwu5SC4EHg6Mia09wraOg==
X-Received: by 2002:a05:6830:44f:b0:6f0:5a46:702c with SMTP id
 46e09a7af769-6f0e91175e3mr25143800a34.12.1715924986003; 
 Thu, 16 May 2024 22:49:46 -0700 (PDT)
Received: from localhost ([1.146.118.37]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6340c4d4a1csm14482098a12.40.2024.05.16.22.49.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 22:49:45 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 May 2024 15:49:40 +1000
Message-Id: <D1BON1PFWOVV.2459GV9YO8VK5@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v7 26/61] target/ppc/mmu_common.c: Transform
 ppc_jumbo_xlate() into ppc_6xx_xlate()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715555763.git.balaton@eik.bme.hu>
 <6409d95aec6f1300adf64224c47568d0c07cf366.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <6409d95aec6f1300adf64224c47568d0c07cf366.1715555763.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon May 13, 2024 at 9:27 AM AEST, BALATON Zoltan wrote:
> Now that only 6xx cases left in ppc_jumbo_xlate() we can change it
> to ppc_6xx_xlate() also removing get_physical_address_wtlb().
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/internal.h   |  5 +----
>  target/ppc/mmu_common.c | 38 ++++++++++++--------------------------
>  2 files changed, 13 insertions(+), 30 deletions(-)
>
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 98b41a970c..4a4f9b9ec8 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -262,10 +262,7 @@ typedef struct mmu_ctx_t mmu_ctx_t;
>  bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>                        hwaddr *raddrp, int *psizep, int *protp,
>                        int mmu_idx, bool guest_visible);
> -int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
> -                                     target_ulong eaddr,
> -                                     MMUAccessType access_type, int type=
,
> -                                     int mmu_idx);
> +
>  /* Software driven TLB helpers */
>  int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
>                                      int way, int is_code);
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index ddb014e0aa..961062bca1 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1112,22 +1112,6 @@ void dump_mmu(CPUPPCState *env)
>      }
>  }
> =20
> -int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
> -                                     target_ulong eaddr,
> -                                     MMUAccessType access_type, int type=
,
> -                                     int mmu_idx)
> -{
> -    switch (env->mmu_model) {
> -    case POWERPC_MMU_SOFT_6xx:
> -        return mmu6xx_get_physical_address(env, ctx, eaddr, access_type,=
 type);
> -    case POWERPC_MMU_SOFT_4xx:
> -        return mmu40x_get_physical_address(env, &ctx->raddr, &ctx->prot,=
 eaddr,
> -                                           access_type);
> -    default:
> -        cpu_abort(env_cpu(env), "Unknown or invalid MMU model\n");
> -    }
> -}
> -
>  static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong =
address,
>                                           MMUAccessType access_type, int =
mmu_idx)
>  {
> @@ -1326,12 +1310,10 @@ static bool ppc_40x_xlate(PowerPCCPU *cpu, vaddr =
eaddr,
>      return false;
>  }
> =20
> -/* Perform address translation */
> -/* TODO: Split this by mmu_model. */
> -static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
> -                            MMUAccessType access_type,
> -                            hwaddr *raddrp, int *psizep, int *protp,
> -                            int mmu_idx, bool guest_visible)
> +static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
> +                          MMUAccessType access_type,
> +                          hwaddr *raddrp, int *psizep, int *protp,
> +                          int mmu_idx, bool guest_visible)
>  {
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> @@ -1353,8 +1335,10 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr=
 eaddr,
>          type =3D ACCESS_INT;
>      }
> =20
> -    ret =3D get_physical_address_wtlb(env, &ctx, eaddr, access_type,
> -                                    type, mmu_idx);
> +    ctx.prot =3D 0;
> +    ctx.hash[0] =3D 0;
> +    ctx.hash[1] =3D 0;
> +    ret =3D mmu6xx_get_physical_address(env, &ctx, eaddr, access_type, t=
ype);
>      if (ret =3D=3D 0) {
>          *raddrp =3D ctx.raddr;
>          *protp =3D ctx.prot;
> @@ -1498,14 +1482,16 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUA=
ccessType access_type,
>      case POWERPC_MMU_SOFT_4xx:
>          return ppc_40x_xlate(cpu, eaddr, access_type, raddrp,
>                               psizep, protp, mmu_idx, guest_visible);
> +    case POWERPC_MMU_SOFT_6xx:
> +        return ppc_6xx_xlate(cpu, eaddr, access_type, raddrp,
> +                             psizep, protp, mmu_idx, guest_visible);
>      case POWERPC_MMU_REAL:
>          return ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psiz=
ep,
>                                     protp);
>      case POWERPC_MMU_MPC8xx:
>          cpu_abort(env_cpu(&cpu->env), "MPC8xx MMU model is not implement=
ed\n");
>      default:
> -        return ppc_jumbo_xlate(cpu, eaddr, access_type, raddrp,
> -                               psizep, protp, mmu_idx, guest_visible);
> +        cpu_abort(CPU(cpu), "Unknown or invalid MMU model\n");
>      }
>  }
> =20


