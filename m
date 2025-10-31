Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B512ECCF9F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 02:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEeRL-00032d-BO; Thu, 30 Oct 2025 22:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEeRI-000326-Ga
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:00:28 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEeR8-0004CL-Qh
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:00:28 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-63bdfd73e6eso5372805a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 19:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761876010; x=1762480810; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DdN7Q1HDgkc3WZecmT4/NYJYG0Sp4eQJgN0BZoB6ZA=;
 b=ZVYGqv170P6HIbYZB1kpKS4l1DUVLVLMlRur3cUIlJJrM6Vfq9r2UgqVpNfwOcqwR/
 hxIEjFqLKoAX+X42fY0ra1Zx0lOR8vhN8V/9MA4UXLuIQip7N/I6Zmqt3TQXTGhZvFg7
 Xmf+Phvrr7ANoOIOnMor7Yd7907eLtn02KPji3Te08sGHYeNEThiM3t2vMbWuRGHcGXy
 73gUbUDtvHRXS/hE+YlU0r0/EZC895grPVW702jUwAwqgtCBT3TsIT0wF9E2cjxBGewW
 LzMTUiW9W/ia6qvIO3w/09lyb/ZaB7hOdIG/iL71vsHvoNJitzypx4GMu+c8zCIX4bqL
 CR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761876010; x=1762480810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2DdN7Q1HDgkc3WZecmT4/NYJYG0Sp4eQJgN0BZoB6ZA=;
 b=Ho4g1vy1TxnKA3dg3DklKO1F85MHI3Ad1gBxrwiE56GrXn+gz6sxC5jm433WuoXDoA
 hpOw2jwFV28A/5hJxMEh5khI0dk8EHH4faawGvp5V6Iejp0vE04JwgeSP3lE9MZjxt2F
 Ip6n4xWVHh1ix7p0UHcJoRVRdNcxMJVe982Rlo7ElVMDDml7Ndx8QjosX3jfM/eRL+kn
 Cc1B0HEBanWdz+GBUgzs9sF32kiUH/+l5hRSkjYbKu2W2wN4VQm28EXMBt8ZRATO3jim
 4YaKWv56S+/eroASALksoKCIQvj4cSAxFyEMHff+QdNDop9h98Ue886K2I4B+hiYm2ol
 1u1A==
X-Gm-Message-State: AOJu0YyoyaY2/jD0DnUoS3FUiKPbRIf3aaCRZeWe/Hqka+2vVof52K0y
 ATLzot0/wR8z49k6CMKG9ODylFbbU5zIqulgdNOiT/UEgIlqlifaDqTm1F4eCdhR7/+wR8ktLvs
 toBKX+7ml0+m4rsOS+/YhkrOTil+Tr7o=
X-Gm-Gg: ASbGnctyt1CO00MgYgvCQbuzRjL/yq9BOt6KF39nauc8X9rpEq6ka5gFg3yMThdslnR
 NY/Ggm8Jsm4TQf41I6p9S5IuY6/yMMcWpegsKkqm0x188JtD/MihASe11XtFtacNKCg16TA9qiF
 zJNct3Hq0mtjb2J5Tyj7Lmio93X/BFb3k8lrH9NxdhZGho/2K4kkp7VUctIZYloZfQjytx6+zC7
 uF11qQajEizwExLnerV1J5MPJDJpvDeZjrjgDAoH8lPecxX8eP+8I3htOd8xdEqWn966Bvdy6/R
 FWddZgaSiVK6cF/BYsync64A7g==
X-Google-Smtp-Source: AGHT+IHjm5DZmS4J2XAmIZ+PCAKavjCzLkoXywBtymrsQwVWpdeFfur4NTIeg5A95LXfsNBs6u4suS5bNsyjXE8Vd0o=
X-Received: by 2002:a05:6402:510c:b0:63b:ee76:3f63 with SMTP id
 4fb4d7f45d1cf-64075334a32mr1781614a12.7.1761876009642; Thu, 30 Oct 2025
 19:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20251027181831.27016-1-anjo@rev.ng>
 <20251027181831.27016-23-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-23-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Oct 2025 11:59:43 +1000
X-Gm-Features: AWmQ_bmSCvfiIz61FgjMjJuv4PcQi9aY1X4lqrDohmyAdL40yzdiMldMyIIcaw8
Message-ID: <CAKmqyKPzGyDVkgHO+1t_G=zqMivadfNNcnj1WpAuCQq4eZz=MA@mail.gmail.com>
Subject: Re: [PATCH v4 22/33] target/riscv: Fix size of [m|s|vs]iselect fields
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Oct 28, 2025 at 4:23=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> [m|s|vs]iselect are defined in version 20250508 of the privileged
> specification to be XLEN in size, however QEMU only ever uses at most
> 16 bits of these fields, so fix them to 16.  Update relevant function
> arguments.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h     |  6 +++---
>  target/riscv/csr.c     | 32 ++++++++++++++++----------------
>  target/riscv/machine.c |  6 +++---
>  3 files changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 5f051796f4..b35851cf4f 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -343,8 +343,8 @@ struct CPUArchState {
>      uint8_t siprio[64];
>
>      /* AIA CSRs */
> -    target_ulong miselect;
> -    target_ulong siselect;
> +    uint16_t miselect;
> +    uint16_t siselect;
>      uint64_t mvien;
>      uint64_t mvip;
>
> @@ -390,7 +390,7 @@ struct CPUArchState {
>      uint64_t vsatp;
>
>      /* AIA VS-mode CSRs */
> -    target_ulong vsiselect;
> +    uint16_t vsiselect;
>
>      uint64_t mtval2;
>      uint64_t mtinst;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5ba1fe4168..ebdb955869 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2405,7 +2405,7 @@ static RISCVException rmw_xiselect(CPURISCVState *e=
nv, int csrno,
>                                     target_ulong *val, target_ulong new_v=
al,
>                                     target_ulong wr_mask)
>  {
> -    target_ulong *iselect;
> +    uint16_t *iselect;
>      int ret;
>
>      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
> @@ -2448,18 +2448,18 @@ static RISCVException rmw_xiselect(CPURISCVState =
*env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> -static bool xiselect_aia_range(target_ulong isel)
> +static bool xiselect_aia_range(uint16_t isel)
>  {
>      return (ISELECT_IPRIO0 <=3D isel && isel <=3D ISELECT_IPRIO15) ||
>             (ISELECT_IMSIC_FIRST <=3D isel && isel <=3D ISELECT_IMSIC_LAS=
T);
>  }
>
> -static bool xiselect_cd_range(target_ulong isel)
> +static bool xiselect_cd_range(uint16_t isel)
>  {
>      return (ISELECT_CD_FIRST <=3D isel && isel <=3D ISELECT_CD_LAST);
>  }
>
> -static bool xiselect_ctr_range(int csrno, target_ulong isel)
> +static bool xiselect_ctr_range(int csrno, uint16_t isel)
>  {
>      /* MIREG-MIREG6 for the range 0x200-0x2ff are not used by CTR. */
>      return CTR_ENTRIES_FIRST <=3D isel && isel <=3D CTR_ENTRIES_LAST &&
> @@ -2467,7 +2467,7 @@ static bool xiselect_ctr_range(int csrno, target_ul=
ong isel)
>  }
>
>  static int rmw_iprio(target_ulong xlen,
> -                     target_ulong iselect, uint8_t *iprio,
> +                     uint16_t iselect, uint8_t *iprio,
>                       target_ulong *val, target_ulong new_val,
>                       target_ulong wr_mask, int ext_irq_no)
>  {
> @@ -2511,7 +2511,7 @@ static int rmw_iprio(target_ulong xlen,
>      return 0;
>  }
>
> -static int rmw_ctrsource(CPURISCVState *env, int isel, target_ulong *val=
,
> +static int rmw_ctrsource(CPURISCVState *env, uint16_t isel, target_ulong=
 *val,
>                            target_ulong new_val, target_ulong wr_mask)
>  {
>      /*
> @@ -2550,7 +2550,7 @@ static int rmw_ctrsource(CPURISCVState *env, int is=
el, target_ulong *val,
>      return 0;
>  }
>
> -static int rmw_ctrtarget(CPURISCVState *env, int isel, target_ulong *val=
,
> +static int rmw_ctrtarget(CPURISCVState *env, uint16_t isel, target_ulong=
 *val,
>                            target_ulong new_val, target_ulong wr_mask)
>  {
>      /*
> @@ -2589,7 +2589,7 @@ static int rmw_ctrtarget(CPURISCVState *env, int is=
el, target_ulong *val,
>      return 0;
>  }
>
> -static int rmw_ctrdata(CPURISCVState *env, int isel, target_ulong *val,
> +static int rmw_ctrdata(CPURISCVState *env, uint16_t isel, target_ulong *=
val,
>                          target_ulong new_val, target_ulong wr_mask)
>  {
>      /*
> @@ -2630,7 +2630,7 @@ static int rmw_ctrdata(CPURISCVState *env, int isel=
, target_ulong *val,
>  }
>
>  static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
> -                         target_ulong isel, target_ulong *val,
> +                         uint16_t isel, target_ulong *val,
>                           target_ulong new_val, target_ulong wr_mask)
>  {
>      bool virt =3D false, isel_reserved =3D false;
> @@ -2710,12 +2710,12 @@ done:
>  }
>
>  static int rmw_xireg_cd(CPURISCVState *env, int csrno,
> -                        target_ulong isel, target_ulong *val,
> +                        uint16_t isel, target_ulong *val,
>                          target_ulong new_val, target_ulong wr_mask)
>  {
>      int ret =3D -EINVAL;
> -    int ctr_index =3D isel - ISELECT_CD_FIRST;
> -    int isel_hpm_start =3D ISELECT_CD_FIRST + 3;
> +    uint16_t ctr_index =3D isel - ISELECT_CD_FIRST;
> +    uint16_t isel_hpm_start =3D ISELECT_CD_FIRST + 3;
>
>      if (!riscv_cpu_cfg(env)->ext_smcdeleg || !riscv_cpu_cfg(env)->ext_ss=
ccfg) {
>          ret =3D RISCV_EXCP_ILLEGAL_INST;
> @@ -2782,7 +2782,7 @@ done:
>  }
>
>  static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
> -                        target_ulong isel, target_ulong *val,
> +                        uint16_t isel, target_ulong *val,
>                          target_ulong new_val, target_ulong wr_mask)
>  {
>      if (!riscv_cpu_cfg(env)->ext_smctr && !riscv_cpu_cfg(env)->ext_ssctr=
) {
> @@ -2810,7 +2810,7 @@ static int rmw_xireg_ctr(CPURISCVState *env, int cs=
rno,
>   * extension using csrind should be implemented here.
>   */
>  static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
> -                              target_ulong isel, target_ulong *val,
> +                              uint16_t isel, target_ulong *val,
>                                target_ulong new_val, target_ulong wr_mask=
)
>  {
>      bool virt =3D csrno =3D=3D CSR_VSIREG ? true : false;
> @@ -2840,7 +2840,7 @@ static int rmw_xiregi(CPURISCVState *env, int csrno=
, target_ulong *val,
>                        target_ulong new_val, target_ulong wr_mask)
>  {
>      int ret =3D -EINVAL;
> -    target_ulong isel;
> +    uint16_t isel;
>
>      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
>      if (ret !=3D RISCV_EXCP_NONE) {
> @@ -2871,7 +2871,7 @@ static RISCVException rmw_xireg(CPURISCVState *env,=
 int csrno,
>                                  target_ulong wr_mask)
>  {
>      int ret =3D -EINVAL;
> -    target_ulong isel;
> +    uint16_t isel;
>
>      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
>      if (ret !=3D RISCV_EXCP_NONE) {
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 8a8f5be8d6..376075b2bd 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -108,7 +108,7 @@ static const VMStateDescription vmstate_hyper =3D {
>          VMSTATE_UINT64(env.vscause, RISCVCPU),
>          VMSTATE_UINT64(env.vstval, RISCVCPU),
>          VMSTATE_UINT64(env.vsatp, RISCVCPU),
> -        VMSTATE_UINTTL(env.vsiselect, RISCVCPU),
> +        VMSTATE_UINT16(env.vsiselect, RISCVCPU),
>          VMSTATE_UINT64(env.vsie, RISCVCPU),
>
>          VMSTATE_UINT64(env.mtval2, RISCVCPU),
> @@ -467,8 +467,8 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          VMSTATE_UINT64(env.mepc, RISCVCPU),
>          VMSTATE_UINT64(env.mcause, RISCVCPU),
>          VMSTATE_UINT64(env.mtval, RISCVCPU),
> -        VMSTATE_UINTTL(env.miselect, RISCVCPU),
> -        VMSTATE_UINTTL(env.siselect, RISCVCPU),
> +        VMSTATE_UINT16(env.miselect, RISCVCPU),
> +        VMSTATE_UINT16(env.siselect, RISCVCPU),
>          VMSTATE_UINT32(env.scounteren, RISCVCPU),
>          VMSTATE_UINT32(env.mcounteren, RISCVCPU),
>          VMSTATE_UINT32(env.scountinhibit, RISCVCPU),
> --
> 2.51.0
>
>

