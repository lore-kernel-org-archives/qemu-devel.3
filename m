Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158FF103E2F5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 00:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0TWp-0003oq-RG; Wed, 11 Mar 2026 20:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0TWk-0003ns-Mr
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 20:03:46 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0TWi-0007po-5K
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 20:03:46 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so59899266b.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 17:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773273821; cv=none;
 d=google.com; s=arc-20240605;
 b=EK2zgdCvEa3DZOVc1KFPpzbaZaScsdT+JHOeSGso0G19qWnH/MoW+GW8IwZkQ8Fjrr
 5FZK0gvnve/jfGjhVC+EU2GrE1gg4ySSnWy8in9lc7ocN/ddMrhz7yZYhjEGJCGKRs8C
 6YQduGnkeMMbfUsQlCC4ag7SUEfx5tdoRv0t2x54FLGr6+qOHCLS/nsEDx+Zx9dwCFr8
 mVVCW56PyNSqhtje4cKb0mqoTRgM5BDcRV4CaU7vPdWHpnpVaxLub1byGSWKcH0DGOlc
 CeD0SsucY0AqhAZKz4EW6ogn4T5QN77gNXuBKvRtgMoW1orhnV7dnOylP2JI1pQnBZub
 BdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CpknS4WYQbQNohr+nb8OaSp17sJ/JVm1OiLHpkLBc2g=;
 fh=wXb1FGdrWTm8wdAKWZU5Dol2Y91CoZJOc78uN4ARPM0=;
 b=QLYUECUM/j8VdZAmhqst5ciaqS+d5YN2J3/6u/cjXgMnroyCvraX7gm6yCW7dCdxUG
 J+3yu7+GZILY4bOAjeUxlwQytYPKd/IT2619O8Hx5QiaI00O1w2N49Lb3yiHyD71K8CB
 JNDD5KBGjLal+K0flud//bWGJZZ9uya5O8XGoZdS7l7NH6iXTIKYWViYnLmOlZ5ve2Zc
 /T1xeNOxitnIjuXdfaMdnGKViQvleRFXOAiDnK1ZOmZPYuktW8zup+IQYBYPfotjSACr
 liBPAIktGi+a1qhzAfTrNtVHjrVMsLJ/xs6PPRYeLmDFdUctahXDjLjCBfDnC4JGtuqH
 gCFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773273821; x=1773878621; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpknS4WYQbQNohr+nb8OaSp17sJ/JVm1OiLHpkLBc2g=;
 b=BcLQ/IiCU1kGAZXa6sYPQgtNWKfdSWVs7hIG6p5+xP3UIhAaxRJG557EUPzHouoJZB
 rU9385VuKCTlvUAeiivGT4Q4KqoqYdITiHiAFCbu0zX6kkm+OanbB4En6HMkM+wptp1a
 BETuxuhWpZuKvKAil0ICo/YP40Tlb8TkkL2A5ltrPNUS/yAdoZ1xGcpQXSYzykhVcKhK
 MUGZMFDaTyykTRe6J+dNJvDB2F2xhvCwq/FTXRDptIP954SgILmlX+ogi8GRSfgQYcYB
 2K+dqethHAIJ2KY48tGYb9aBqoJXsFTtj3Hdf2iv08UIbi1hG98WFW24UMi1sbCUNbAd
 /dLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773273821; x=1773878621;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CpknS4WYQbQNohr+nb8OaSp17sJ/JVm1OiLHpkLBc2g=;
 b=TzHhkpmNSpe2f4LXpPRO/RHNGGt94jJda7v12m1JBBRl8HvTgfJDurvWslQA94RXx/
 VNMtYJXw0nQSSRKGsN1soti+LOYDTmOkKKOPvJPt93/H84D/FyUguMtFAjSS4RU8xC4D
 xtB6u568Ql+qgLcnpJFK0BSo6uHv9gU1vcjH9OWJrJ0WCj8BLg4Hu9H7ZQvU9s2QjNyn
 BdbftkUQs9ecIA7slXUE68EnZM/HMQ1949PuYIJkn7+9tf056tUVJerJxxJ/mCqheqdB
 y9UBZi+rx1Hxr7hq3HSac9OtRMfF2hxYVyEw4qqvzkemhSjkPdCMRsy/JtAHeI2LoFVD
 ixyQ==
X-Gm-Message-State: AOJu0YwZ0t7bet4q8EuwMzMLCPdvPKrYAyO3DFEc32NmOi9JUH2/aiB3
 0GEqaophw1hyWHEHHaL1Etk90tEfP2rKNjDMwIS3Z1uZbcDkCg4T/aym9UUawgwENMwkTmjX1oL
 oV6n/pdXTamxCINSKoalGzz4VxSocAEI=
X-Gm-Gg: ATEYQzy+k2fb280brFCqNWOatT3K6rSGoGw5qp7b7aC4WjBF4uYM5+TjmDJ65MDWswH
 2fnOdLMObv17Xak6agbMUfMWQL+LiwTsYwhNiC7wUlntKDOLuRSeevo/2wR8qUmiIkgvhORc396
 zE5KhoBlpKcX6SOF2vw0Xt6zw6fY43xDYv/pXw+oA3jz5TbycTvgu+mUlfe1O3SgbP2oiDd9ZIf
 xCF1XA9YPFPGLhcXKr3dsPIU9RZSvkdpvLAoK6omV2PmUO4Cef8vu16vWGs9PCTK9o8GGAZ8naP
 aKOC7KW1SXgG5cvDxtyugJyGfkoqBLQ74HB0ORs47ypqVUR7
X-Received: by 2002:a17:906:9c84:b0:b96:fcf1:ede6 with SMTP id
 a640c23a62f3a-b972e19e367mr239580966b.13.1773273820658; Wed, 11 Mar 2026
 17:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260305034429.74739-1-jay.chang@sifive.com>
In-Reply-To: <20260305034429.74739-1-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Mar 2026 10:03:14 +1000
X-Gm-Features: AaiRm52Nmi5dU-6wQaQTphl4YBNY8BHLisvGicNlvTx388sN0an_9u8ObnwX29Y
Message-ID: <CAKmqyKMXRA9cd2KsxmyGk_8kmPsgqfy9ED0aJpN_oo=SaA_H-w@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv: Support Smpmpmt extension
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Mar 5, 2026 at 1:45=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wro=
te:
>
> The Smpmpmt extension provides a mechanism to control memory attributes
> at the granularity of PMP (Physical Memory Protection) registers, similar
> to how Svpbmt controls memory attributes at the page level.
>
> Version 0.6
> https://github.com/riscv/riscv-isa-manual/blob/smpmpmt/src/smpmpmt.adoc#s=
vpbmt
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
> v2:
>     Place smpmpmt in the correct riscv,isa order.
> v3:
>     Add note comment in pmp_hart_has_privs() explaining that MT field
>     is stored but not acted upon during access checks.
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> ---
>  target/riscv/cpu.c                |  2 ++
>  target/riscv/cpu_cfg_fields.h.inc |  1 +
>  target/riscv/pmp.c                | 16 ++++++++++++++++
>  target/riscv/pmp.h                |  1 +
>  4 files changed, 20 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 9be79622f4..8ac935ac06 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -223,6 +223,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
>      ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> +    ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
>      ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>      ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
>      ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
> @@ -1276,6 +1277,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
>      MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
>      MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
> +    MULTI_EXT_CFG_BOOL("smpmpmt", ext_smpmpmt, false),
>      MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
>      MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
>      MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index 70ec650abf..cd1a5ec56b 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -59,6 +59,7 @@ BOOL_FIELD(ext_svadu)
>  BOOL_FIELD(ext_svinval)
>  BOOL_FIELD(ext_svnapot)
>  BOOL_FIELD(ext_svpbmt)
> +BOOL_FIELD(ext_smpmpmt)
>  BOOL_FIELD(ext_svrsw60t59b)
>  BOOL_FIELD(ext_svvptc)
>  BOOL_FIELD(ext_svukte)
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 3ef62d26ad..5391caa59c 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -165,6 +165,18 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32=
_t pmp_index, uint8_t val)
>                            "ignoring pmpcfg write - invalid\n");
>          } else {
>              uint8_t a_field =3D pmp_get_a_field(val);
> +
> +            if (!riscv_cpu_cfg(env)->ext_smpmpmt) {
> +                /* If smpmpmt not supported, clear the MTMATCH bit */
> +                val &=3D ~PMP_MTMATCH;
> +            } else if ((val & PMP_MTMATCH) =3D=3D PMP_MTMATCH) {
> +                /*
> +                 * If trying to set reserved value (0x3) for MT field,
> +                 * preserve the original MT field from current config.
> +                 */
> +                val =3D (val & ~PMP_MTMATCH) |
> +                    (env->pmp_state.pmp[pmp_index].cfg_reg & PMP_MTMATCH=
);
> +            }
>              /*
>               * When granularity g >=3D 1 (i.e., granularity > 4 bytes),
>               * the NA4 (Naturally Aligned 4-byte) mode is not selectable
> @@ -355,6 +367,10 @@ static bool pmp_hart_has_privs_default(CPURISCVState=
 *env, pmp_priv_t privs,
>   * Check if the address has required RWX privs to complete desired opera=
tion
>   * Return true if a pmp rule match or default match
>   * Return false if no match
> + *
> + * Note: The MT (Memory Type) field from Smpmpmt extension is stored in
> + * pmpcfg but is not acted upon during access checks. Cache attributes
> + * have no functional impact in QEMU emulation.
>   */
>  bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
>                          target_ulong size, pmp_priv_t privs,
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index 271cf24169..467fb6b4b1 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -29,6 +29,7 @@ typedef enum {
>      PMP_WRITE =3D 1 << 1,
>      PMP_EXEC  =3D 1 << 2,
>      PMP_AMATCH =3D (3 << 3),
> +    PMP_MTMATCH =3D (3 << 5),
>      PMP_LOCK  =3D 1 << 7
>  } pmp_priv_t;
>
> --
> 2.48.1
>
>

