Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92194C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 05:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sip8Z-0000QZ-OK; Tue, 27 Aug 2024 01:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1sip8U-0000BR-Kz
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 01:52:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1sip8S-0000hc-KD
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 01:52:58 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4280c55e488so27203135e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 22:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1724737974; x=1725342774; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8m4XPACd5yESkcXA5ORMBxozyFS8iSsnsNCvxpLOWCs=;
 b=ZwxThNMCeApRTklwPtz3RZJjbJcadpMNKVZVqfxpu/MeXcb0nQAC7S2mY9RcP6W6b/
 Nglq/AAQHmlf2rJgjRgaY99/pY8Ds5yayB8D2Weeq3LDPuIBhVRy+E4y5Thou83/XhNd
 0v9v0TA/4ey5ajuAG+QRxpyARHB7ts3fbGCOYaD8hW5W3JGcs380qfO4deiwUuxQF/GP
 rXKHLQv1v0uAPLuQP2FR/fLFV9FTVtF2v58gQDsXz5otk+0FIbhmrQKPgDz95slBuH3l
 P0lJ4elKtCh3x7ePX0uylF6vDc0HRFJTjbZpr/ULKtQn03UoaJK9jg6ZCGNBYl+cLfxF
 Q45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724737974; x=1725342774;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8m4XPACd5yESkcXA5ORMBxozyFS8iSsnsNCvxpLOWCs=;
 b=pS8DtoWgkc41KiSj1moru6fvwdzcfy6HR45sq3gG66uQ4wYEz0QoamIl5AKNmV51Ah
 c/JeDB0vBtQgdjudJIvP8XXnRv6RMng/KudxGDFaMM7znu076MnFsfI9rmCwbnqxHD07
 On4m/YMEhaWwlUeW4XytrTeSgwWfjW6h0wtiPiBcHLFSkVpVhoI66gF5qYSf6nvvUYR0
 sG/e4HRQ0Pdg9fJ6C3wFoE+AShlw7E5opIBBXIL5Fau9ED5yUZp/KQdKL8dCHbpTI5ep
 QLS/dZ89Elph+zIV9G56Wf/axGm6bPSy467xkhMquhvJL3GKJt7+iuNDjEQgfRRLmd3q
 I1HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx+GBa3u8TIxynQFSyvrsNparpYYnwww8UAXxDLIZSSmWz9OGJcIHJsVt7tKlXpMAT8eN1cqavfFd8@nongnu.org
X-Gm-Message-State: AOJu0Yz+MNiio2ezw9D1CokWz1chYxCdUWeUnVvXxgS4CLC5rRtm/VsD
 Xw7au8Mngh2+HabN/3z+6mCAFpgx45agiAvjhw+rTnfgvwQItOC+l5mfB68Ez9HpmzwDG0MU0w7
 wPqB1Umj8Z/SqTM6oetyrkKmXLs/FMs+nThcUcw==
X-Google-Smtp-Source: AGHT+IHNwrA6iJE1X+7AXS9BuOS9l/ndB8i/PtQVJLWIDfJds/C2cFxdRSMC7ipG1IP1annmgmNIhabxgWAXIAIDp+E=
X-Received: by 2002:a7b:c8cc:0:b0:426:5c36:f57a with SMTP id
 5b1f17b1804b1-42b9a6674a7mr9035395e9.14.1724737973652; Mon, 26 Aug 2024
 22:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240418133916.1442471-1-cleger@rivosinc.com>
 <20240418133916.1442471-4-cleger@rivosinc.com>
In-Reply-To: <20240418133916.1442471-4-cleger@rivosinc.com>
From: Tommy Wu <tommy.wu@sifive.com>
Date: Tue, 27 Aug 2024 13:52:42 +0800
Message-ID: <CANj3q_kOENmzbpJU_ycPmaWf_mRWz9MThaJVMj-9K=O4cZPcSA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] target/riscv: add Smdbltrp extension support
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=tommy.wu@sifive.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Apr 18, 2024 at 9:40=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> The Smdbltrp extension allows to generate M-mode targeted double trap
> exceptions [1]. Such exceptions are generated if a trap is taken while
> mstatus.sdt is set to 1. The specification states that if the Smnrmi
> extension is implemented, then the hart enters a critical-error state
> and generate a critical-error signal. Since there is no Smrnmi support,
> the implementation generates a cpu abort.
>
> Link: https://github.com/riscv/riscv-double-trap/releases/download/v0.56/=
riscv-double-trap.pdf [1]
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  target/riscv/cpu.c        |  5 +++++
>  target/riscv/cpu_bits.h   |  1 +
>  target/riscv/cpu_cfg.h    |  1 +
>  target/riscv/cpu_helper.c |  6 ++++++
>  target/riscv/csr.c        | 12 ++++++++++++
>  target/riscv/op_helper.c  |  3 +++
>  6 files changed, 28 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d159b0c6b6..98f04ecb8c 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -176,6 +176,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
> +    ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_12_0, ext_smdbltrp),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
> @@ -954,6 +955,9 @@ static void riscv_cpu_reset_hold(Object *obj)
>              env->mstatus_hs =3D set_field(env->mstatus_hs,
>                                          MSTATUS64_UXL, env->misa_mxl);
>          }
> +        if (riscv_cpu_cfg(env)->ext_smdbltrp) {
> +            env->mstatus =3D set_field(env->mstatus, MSTATUS_MDT, 1);
> +        }
>      }
>      env->mcause =3D 0;
>      env->miclaim =3D MIP_SGEIP;
> @@ -1574,6 +1578,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[=
] =3D {
>  /* These are experimental so mark with 'x-' */
>  const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] =3D {
>      MULTI_EXT_CFG_BOOL("x-ssdbltrp", ext_ssdbltrp, false),
> +    MULTI_EXT_CFG_BOOL("x-smdbltrp", ext_smdbltrp, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 494a036f6e..660f2eed5b 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -545,6 +545,7 @@
>  #define MSTATUS_SDT         0x01000000 /* Ssdbltrp extension */
>  #define MSTATUS_GVA         0x4000000000ULL
>  #define MSTATUS_MPV         0x8000000000ULL
> +#define MSTATUS_MDT         0x200000000000ULL /* Smdbltrp extension */

The M-mode-disable-trap (MDT) bit is at bit 42.

Regards,
Tommy Wu

>
>  #define MSTATUS64_UXL       0x0000000300000000ULL
>  #define MSTATUS64_SXL       0x0000000C00000000ULL
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index a149c08167..cf6a802502 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -75,6 +75,7 @@ struct RISCVCPUConfig {
>      bool ext_smstateen;
>      bool ext_sstc;
>      bool ext_ssdbltrp;
> +    bool ext_smdbltrp;
>      bool ext_svadu;
>      bool ext_svinval;
>      bool ext_svnapot;
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 3d747e5bfc..5ce0982f2f 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1862,6 +1862,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          s =3D set_field(s, MSTATUS_MPIE, get_field(s, MSTATUS_MIE));
>          s =3D set_field(s, MSTATUS_MPP, env->priv);
>          s =3D set_field(s, MSTATUS_MIE, 0);
> +        if (riscv_cpu_cfg(env)->ext_smdbltrp) {
> +            if (env->mstatus & MSTATUS_MDT)
> +                cpu_abort(CPU(cpu), "M-mode double trap\n");
> +
> +            s =3D set_field(s, MSTATUS_MDT, 1);
> +        }
>          env->mstatus =3D s;
>          env->mcause =3D cause | ~(((target_ulong)-1) >> async);
>          if (smode_double_trap) {
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 1a2e739947..200b06e320 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1363,6 +1363,7 @@ static target_ulong legalize_mpp(CPURISCVState *env=
, target_ulong old_mpp,
>  static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>                                      target_ulong val)
>  {
> +    const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
>      uint64_t mstatus =3D env->mstatus;
>      uint64_t mask =3D 0;
>      RISCVMXL xl =3D riscv_cpu_mxl(env);
> @@ -1396,6 +1397,12 @@ static RISCVException write_mstatus(CPURISCVState =
*env, int csrno,
>          }
>      }
>
> +    if (cfg->ext_smdbltrp) {
> +        mask |=3D MSTATUS_MDT;
> +        if ((val & MSTATUS_MDT) !=3D 0)
> +            mask &=3D ~MSTATUS_MIE;
> +    }
> +
>      if (xl !=3D MXL_RV32 || env->debugger) {
>          if (riscv_has_ext(env, RVH)) {
>              mask |=3D MSTATUS_MPV | MSTATUS_GVA;
> @@ -1434,6 +1441,11 @@ static RISCVException write_mstatush(CPURISCVState=
 *env, int csrno,
>      uint64_t valh =3D (uint64_t)val << 32;
>      uint64_t mask =3D riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GV=
A : 0;
>
> +    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
> +        mask |=3D MSTATUS_MDT;
> +        if ((val & MSTATUS_MDT) !=3D 0)
> +            mask |=3D MSTATUS_MIE;
> +    }
>      env->mstatus =3D (env->mstatus & ~mask) | (valh & mask);
>
>      return RISCV_EXCP_NONE;
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 468ee58a00..d289d14237 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -354,6 +354,9 @@ target_ulong helper_mret(CPURISCVState *env)
>      mstatus =3D set_field(mstatus, MSTATUS_MPP,
>                          riscv_has_ext(env, RVU) ? PRV_U : PRV_M);
>      mstatus =3D set_field(mstatus, MSTATUS_MPV, 0);
> +    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
> +        mstatus =3D set_field(mstatus, MSTATUS_MDT, 0);
> +    }
>      if ((env->priv_ver >=3D PRIV_VERSION_1_12_0) && (prev_priv !=3D PRV_=
M)) {
>          mstatus =3D set_field(mstatus, MSTATUS_MPRV, 0);
>      }
> --
> 2.43.0
>
>

