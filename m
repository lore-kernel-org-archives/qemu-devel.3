Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D30E8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBEn-0004X7-Cs; Mon, 29 Dec 2025 06:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBEh-0004Si-CA
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:16:27 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBEf-0005Vc-Ef
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:16:27 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b727f452fffso1599899566b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767006984; x=1767611784; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjctmgzYSgSvw2TTfv2AVl7rIub0XsJ0kxy4yiBuDn0=;
 b=lQVLgnUQbzf7G5EnaHkfKtzR3oAe8glEbnrtmJHhno2i9DBEZ2Demm2oFP266sj6xH
 LzqiJWk2zEpevdKiI72SeTN1HbRxlzGkbahhQuTuTNM6cVDVsvY9efq08cGSNIxQqV/r
 Q+6L6wG57ZrbWk+UoXIFOF7OIG4yEv2sLZyA8s2TK8d9bmRn3FkHxe6HOuPKnJ9x1VZx
 e31PVBtk4oVvOIve5w5w4YkoGBsu/BK2KG9het8ECawKoQeDNLnHJnIvVFptVv6CA67E
 LDp6ItNy5qNzz7IMu6p+kepZBoIhZYVtizMHoy9wfJGTpJ0maKqkzoUlCqzOsphcQ8Bs
 v9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767006984; x=1767611784;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sjctmgzYSgSvw2TTfv2AVl7rIub0XsJ0kxy4yiBuDn0=;
 b=JnLvGbinXIBXASLovZumDGVFG81ZQOdN0Lm8r2A4f9tsrd9bfuQW7vD28MHdJE8ViG
 l4u4/+qust4I0qNlpzIVGr7NfdYMVCj4/1mG3Vua4iA1j8azVx9ySehHY0nTj64L8Eyn
 b/QYidBc3j527lstrdnCeZRifcjAwHnWem0DoULzCBl/7N7Bc7zOdJdQBB4hZulUCJGo
 qKLFcahn7uVXD7QDwRlAeObxcGGBCxv9tYFHVfBFdlHUpFyAxIvUyHr76zZ/QqL36KLm
 Cnu7jlpiugc+025olaPTngYsyT9qiAjZp4bmki8UqN34fQWs7/BBg8+kGN6r8kRBHvRP
 UNfA==
X-Gm-Message-State: AOJu0YzmLiuQRvMVgp0YPbid5P5t4QnYQ+VEg+U89QOL5fHaUPtrcugY
 Dpe3FVP5wPFey06eywzQ64Xic4f1K18v2E1guOSn1KqJ8NzyFTIw7Fi7blMqOqj2UhxoYxgkHOH
 +irNX0yfGW55klhSg2Gl0NY9+htvDGkll3PsWNghpgg==
X-Gm-Gg: AY/fxX5oJYvSPEacZROnmS7WzGSuFTrEXcw9f4M4J/fhKvITksp7nAtX/AkqfvhNDOl
 5HrD7qckx5Pl12UbJOEAxLvTBgaJIkOuY3HRPUOJipYaCcVK7yAOzWpBJ/tOC9r/IK58RVTruXi
 TIMitrwsyNO6YGK4bLLqkquGLv+P+WL8/zbgH6pQmdXL8mjiPSt7bB3oj+LexkD4V7lyO239TBf
 caG7KZYzd0PSyuTlZtVMNvIbpCvyQuXyg7h+VX7Q30OBJNf3bxRaHD9V2xFXqjpTNexQwfC6LOS
 mVBnYk/HUNoSc+QJ2hkl6qO6qL67ds4r1+gPWoU=
X-Google-Smtp-Source: AGHT+IGdTlmGcdZ7eqOwzwmOgvQKYI1s1Dpsl/NkTp+KBKFME8RFYYIZGYfC8MgqFQ0OjpKs6YOYQezzrRWE1J3DJi4=
X-Received: by 2002:a17:907:3f9f:b0:b76:3d56:f666 with SMTP id
 a640c23a62f3a-b80205ed2bdmr3382009366b.26.1767006983672; Mon, 29 Dec 2025
 03:16:23 -0800 (PST)
MIME-Version: 1.0
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-5-philmd@linaro.org>
In-Reply-To: <20251224162642.90857-5-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:15:56 +0200
X-Gm-Features: AQt7F2oATXYuv6sfJhoySLA2gR7v5TOjrA4svpmn7fyQvWvUMNzDpqxVkfR9pO4
Message-ID: <CAAjaMXYXOA68DRrbOX1yphfF6WAxg=GfM_++F0vL7eWabTSwFQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] target/sparc: Use explicit big-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x633.google.com
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

On Wed, Dec 24, 2025 at 6:27=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The SPARC architecture uses big endianness. Directly use
> the big-endian LD/ST API.
>
> Mechanical change running:
>
>   $ for a in uw w l q; do \
>       sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
>         $(git grep -wlE '(ld|st)u?[wlq]_p' target/sparc/);
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/sparc/ldst_helper.c | 36 ++++++++++++++++++------------------
>  target/sparc/mmu_helper.c  | 32 +++++++++++++++++---------------
>  2 files changed, 35 insertions(+), 33 deletions(-)
>
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index a87a0b3eee0..9892c8f61c6 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -707,17 +707,17 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_u=
long addr,
>                                       MEMTXATTRS_UNSPECIFIED, &result);
>              break;
>          case 2:
> -            ret =3D address_space_lduw(cs->as, access_addr,
> -                                     MEMTXATTRS_UNSPECIFIED, &result);
> +            ret =3D address_space_lduw_be(cs->as, access_addr,
> +                                        MEMTXATTRS_UNSPECIFIED, &result)=
;
>              break;
>          default:
>          case 4:
> -            ret =3D address_space_ldl(cs->as, access_addr,
> -                                    MEMTXATTRS_UNSPECIFIED, &result);
> +            ret =3D address_space_ldl_be(cs->as, access_addr,
> +                                       MEMTXATTRS_UNSPECIFIED, &result);
>              break;
>          case 8:
> -            ret =3D address_space_ldq(cs->as, access_addr,
> -                                    MEMTXATTRS_UNSPECIFIED, &result);
> +            ret =3D address_space_ldq_be(cs->as, access_addr,
> +                                       MEMTXATTRS_UNSPECIFIED, &result);
>              break;
>          }
>
> @@ -878,10 +878,10 @@ void helper_st_asi(CPUSPARCState *env, target_ulong=
 addr, uint64_t val,
>                  MemTxResult result;
>                  hwaddr access_addr =3D (env->mxccregs[0] & 0xffffffffULL=
) + 8 * i;
>
> -                env->mxccdata[i] =3D address_space_ldq(cs->as,
> -                                                     access_addr,
> -                                                     MEMTXATTRS_UNSPECIF=
IED,
> -                                                     &result);
> +                env->mxccdata[i] =3D address_space_ldq_be(cs->as,
> +                                                        access_addr,
> +                                                        MEMTXATTRS_UNSPE=
CIFIED,
> +                                                        &result);
>                  if (result !=3D MEMTX_OK) {
>                      /* TODO: investigate whether this is the right behav=
iour */
>                      sparc_raise_mmu_fault(cs, access_addr, false, false,
> @@ -906,8 +906,8 @@ void helper_st_asi(CPUSPARCState *env, target_ulong a=
ddr, uint64_t val,
>                  MemTxResult result;
>                  hwaddr access_addr =3D (env->mxccregs[1] & 0xffffffffULL=
) + 8 * i;
>
> -                address_space_stq(cs->as, access_addr, env->mxccdata[i],
> -                                  MEMTXATTRS_UNSPECIFIED, &result);
> +                address_space_stq_be(cs->as, access_addr, env->mxccdata[=
i],
> +                                     MEMTXATTRS_UNSPECIFIED, &result);
>
>                  if (result !=3D MEMTX_OK) {
>                      /* TODO: investigate whether this is the right behav=
iour */
> @@ -1072,17 +1072,17 @@ void helper_st_asi(CPUSPARCState *env, target_ulo=
ng addr, uint64_t val,
>                                    MEMTXATTRS_UNSPECIFIED, &result);
>                  break;
>              case 2:
> -                address_space_stw(cs->as, access_addr, val,
> -                                  MEMTXATTRS_UNSPECIFIED, &result);
> +                address_space_stw_be(cs->as, access_addr, val,
> +                                     MEMTXATTRS_UNSPECIFIED, &result);
>                  break;
>              case 4:
>              default:
> -                address_space_stl(cs->as, access_addr, val,
> -                                  MEMTXATTRS_UNSPECIFIED, &result);
> +                address_space_stl_be(cs->as, access_addr, val,
> +                                     MEMTXATTRS_UNSPECIFIED, &result);
>                  break;
>              case 8:
> -                address_space_stq(cs->as, access_addr, val,
> -                                  MEMTXATTRS_UNSPECIFIED, &result);
> +                address_space_stq_be(cs->as, access_addr, val,
> +                                     MEMTXATTRS_UNSPECIFIED, &result);
>                  break;
>              }
>              if (result !=3D MEMTX_OK) {
> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> index 46bf500ea83..5a58239d65e 100644
> --- a/target/sparc/mmu_helper.c
> +++ b/target/sparc/mmu_helper.c
> @@ -102,7 +102,8 @@ static int get_physical_address(CPUSPARCState *env, C=
PUTLBEntryFull *full,
>      /* SPARC reference MMU table walk: Context table->L1->L2->PTE */
>      /* Context base + context number */
>      pde_ptr =3D (env->mmuregs[1] << 4) + (env->mmuregs[2] << 2);
> -    pde =3D address_space_ldl(cs->as, pde_ptr, MEMTXATTRS_UNSPECIFIED, &=
result);
> +    pde =3D address_space_ldl_be(cs->as, pde_ptr,
> +                               MEMTXATTRS_UNSPECIFIED, &result);
>      if (result !=3D MEMTX_OK) {
>          return 4 << 2; /* Translation fault, L =3D 0 */
>      }
> @@ -117,8 +118,8 @@ static int get_physical_address(CPUSPARCState *env, C=
PUTLBEntryFull *full,
>          return 4 << 2;
>      case 1: /* L0 PDE */
>          pde_ptr =3D ((address >> 22) & ~3) + ((pde & ~3) << 4);
> -        pde =3D address_space_ldl(cs->as, pde_ptr,
> -                                MEMTXATTRS_UNSPECIFIED, &result);
> +        pde =3D address_space_ldl_be(cs->as, pde_ptr,
> +                                   MEMTXATTRS_UNSPECIFIED, &result);
>          if (result !=3D MEMTX_OK) {
>              return (1 << 8) | (4 << 2); /* Translation fault, L =3D 1 */
>          }
> @@ -131,8 +132,8 @@ static int get_physical_address(CPUSPARCState *env, C=
PUTLBEntryFull *full,
>              return (1 << 8) | (4 << 2);
>          case 1: /* L1 PDE */
>              pde_ptr =3D ((address & 0xfc0000) >> 16) + ((pde & ~3) << 4)=
;
> -            pde =3D address_space_ldl(cs->as, pde_ptr,
> -                                    MEMTXATTRS_UNSPECIFIED, &result);
> +            pde =3D address_space_ldl_be(cs->as, pde_ptr,
> +                                       MEMTXATTRS_UNSPECIFIED, &result);
>              if (result !=3D MEMTX_OK) {
>                  return (2 << 8) | (4 << 2); /* Translation fault, L =3D =
2 */
>              }
> @@ -145,8 +146,8 @@ static int get_physical_address(CPUSPARCState *env, C=
PUTLBEntryFull *full,
>                  return (2 << 8) | (4 << 2);
>              case 1: /* L2 PDE */
>                  pde_ptr =3D ((address & 0x3f000) >> 10) + ((pde & ~3) <<=
 4);
> -                pde =3D address_space_ldl(cs->as, pde_ptr,
> -                                        MEMTXATTRS_UNSPECIFIED, &result)=
;
> +                pde =3D address_space_ldl_be(cs->as, pde_ptr,
> +                                           MEMTXATTRS_UNSPECIFIED, &resu=
lt);
>                  if (result !=3D MEMTX_OK) {
>                      return (3 << 8) | (4 << 2); /* Translation fault, L =
=3D 3 */
>                  }
> @@ -189,7 +190,7 @@ static int get_physical_address(CPUSPARCState *env, C=
PUTLBEntryFull *full,
>          if (is_dirty) {
>              pde |=3D PG_MODIFIED_MASK;
>          }
> -        stl_phys(cs->as, pde_ptr, pde);
> +        stl_be_phys(cs->as, pde_ptr, pde);
>      }
>
>      /* the page can be put in the TLB */
> @@ -276,7 +277,8 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulo=
ng address, int mmulev)
>      /* Context base + context number */
>      pde_ptr =3D (hwaddr)(env->mmuregs[1] << 4) +
>          (env->mmuregs[2] << 2);
> -    pde =3D address_space_ldl(cs->as, pde_ptr, MEMTXATTRS_UNSPECIFIED, &=
result);
> +    pde =3D address_space_ldl_be(cs->as, pde_ptr,
> +                               MEMTXATTRS_UNSPECIFIED, &result);
>      if (result !=3D MEMTX_OK) {
>          return 0;
>      }
> @@ -292,8 +294,8 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulo=
ng address, int mmulev)
>              return pde;
>          }
>          pde_ptr =3D ((address >> 22) & ~3) + ((pde & ~3) << 4);
> -        pde =3D address_space_ldl(cs->as, pde_ptr,
> -                                MEMTXATTRS_UNSPECIFIED, &result);
> +        pde =3D address_space_ldl_be(cs->as, pde_ptr,
> +                                   MEMTXATTRS_UNSPECIFIED, &result);
>          if (result !=3D MEMTX_OK) {
>              return 0;
>          }
> @@ -310,8 +312,8 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulo=
ng address, int mmulev)
>                  return pde;
>              }
>              pde_ptr =3D ((address & 0xfc0000) >> 16) + ((pde & ~3) << 4)=
;
> -            pde =3D address_space_ldl(cs->as, pde_ptr,
> -                                    MEMTXATTRS_UNSPECIFIED, &result);
> +            pde =3D address_space_ldl_be(cs->as, pde_ptr,
> +                                       MEMTXATTRS_UNSPECIFIED, &result);
>              if (result !=3D MEMTX_OK) {
>                  return 0;
>              }
> @@ -328,8 +330,8 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulo=
ng address, int mmulev)
>                      return pde;
>                  }
>                  pde_ptr =3D ((address & 0x3f000) >> 10) + ((pde & ~3) <<=
 4);
> -                pde =3D address_space_ldl(cs->as, pde_ptr,
> -                                        MEMTXATTRS_UNSPECIFIED, &result)=
;
> +                pde =3D address_space_ldl_be(cs->as, pde_ptr,
> +                                           MEMTXATTRS_UNSPECIFIED, &resu=
lt);
>                  if (result !=3D MEMTX_OK) {
>                      return 0;
>                  }
> --
> 2.52.0
>

