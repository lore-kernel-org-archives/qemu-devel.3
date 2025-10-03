Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429D9CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 00:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4TJG-0000aB-M8; Thu, 02 Oct 2025 20:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4TJ8-0000Z7-JS
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 20:05:59 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4TJ0-0000A3-Ay
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 20:05:57 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-639102bba31so133808a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 17:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759449940; x=1760054740; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTe+LUorf9LNR+vkn5k/y0M2mYefvNFT9dhW3DWMrCE=;
 b=gbRdj2YdrxqfuZRsx3Qw/DgOvMBmqZJPOyfnSCjoIgDizETYSNhROri9MHowloKzCi
 ov57Dmm73sk8HjSrfvCTopwJlwFwZowbIEHLT5U1wHg/AM3+u9O9aQNdskz/D6pkiGKj
 t/dA+FLyqC0FATcIBkb6ebOrgaf+Hn8/G1wW8nGY6/BeUZmMj9VLZPDdXH82pwOY8qXr
 GZFK2ToMxt9sKrDypf1O4+z8aHOrFPRcMpsxW183OE2BbQDit+nH+GA7dA5NRdDwjsAD
 nftJPJb8CC5ckwPNBklNFLn2/S2di9kvUaekzkrzDq7fY7jB8y0bJV/CMM3naMDk6M0U
 2QVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759449940; x=1760054740;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QTe+LUorf9LNR+vkn5k/y0M2mYefvNFT9dhW3DWMrCE=;
 b=bIiU6V5tP1UUk7sSx5AnYU3aslet3HfS3/gS5JSzAmhGESIdfoqtTP8CnfQks6Qvi6
 JrQMN/ajuEtGggpHfDruiNqZ6LHiDiCA4owxYutbLfFUmSE9+m1ivAoa2Zfgh3Uwl6nP
 ZMGWg8zBlkl6+zcBq7ChoQXKw3yhKNzVU7kSP2+k9e/QV0nuzhxK6IQ9zh+Vwe9K0CWx
 ohdYG6PkxMCrA5T0LGcpb+ssWvHvjVJvQoiDRyLNNSruwObkXLC+BZbeZ4lXIkx760FD
 qEpdyTSZkIHs8YSgBNTWZZ4IDtncmcSSEWq/K9AceodPHaeEq7ruILrwaYG2lh76X69c
 4Uhg==
X-Gm-Message-State: AOJu0YxKmDdaETQNyp3Jf9f/uhG4kLu8yCXpIX4wLqSPLdOZ7VWv1fr1
 UGBs7zanbDTr5J4bm/cJoQXlJC3NzjzRzUhPE+q9vZ+6/cL0QZZrMPR70tKxwRGuELC/kn1GUA2
 WFgoFy2BEAwrM+ccxiS04T+2kI8ZMXUOpfw==
X-Gm-Gg: ASbGncvhKBXljwrFVr7G8JCIKT2d4vC/SyX3YdR6MiWwrfto6dQVC9WEITBPuFPthLl
 M2VpXR0YyW4AaVgUWvinysf1ge8S+f/9Eop+h3HbNlYRri2OILfibR7js6MCCPKKNrO1IsVLwp9
 445Xg18Km9d8Qrsmx1G9/KCmOAcvWksF4PtWkjMiJyHpwn3hnJNJPhqaU7iDsEYpbsAGYknhXOG
 1nmqCBxt7GTtQPje93NwwAc8SZGck2qXKfhqvBTLaezmxEhCxqdpoew66/FBg==
X-Google-Smtp-Source: AGHT+IGq9DDuuXRw9GnvhCoKsRoxDdW3PqQvdVl74Ysyb6KEtWF0s12+HcJ04HW3+j3hrEgmpu+DvAej/9aN1D2BAVY=
X-Received: by 2002:a17:907:26c8:b0:b3d:98fa:b3fe with SMTP id
 a640c23a62f3a-b49c344524cmr141665966b.63.1759449939407; Thu, 02 Oct 2025
 17:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-7-anjo@rev.ng>
In-Reply-To: <20251001073306.28573-7-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Oct 2025 10:05:13 +1000
X-Gm-Features: AS18NWD7r6420fTysJwCNe_B-6DSDOvjSA3hlcrbZKRMmq_gpPjOhDnsMA0Zx9A
Message-ID: <CAKmqyKPOhrFQc0WSgarBwNyGivV7eqZ4btzkz5mrX7n4wutPZg@mail.gmail.com>
Subject: Re: [PATCH v2 06/33] target/riscv: Combine mcyclecfg and mcyclecfgh
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
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

On Wed, Oct 1, 2025 at 5:36=E2=80=AFPM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> According to version 20250508 of the privileged specification, mcyclecfg
> is a 64-bit register and mcyclecfgh refers to the top 32 bits of this
> register when XLEN =3D=3D 32.  No real advantage is gained by keeping
> them separate, and combining them allows for slight simplification.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h |  3 +--
>  target/riscv/csr.c | 28 +++++++++++++++++-----------
>  2 files changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 64b9964028..60f7611c00 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -419,8 +419,7 @@ struct CPUArchState {
>      uint32_t mcountinhibit;
>
>      /* PMU cycle & instret privilege mode filtering */
> -    target_ulong mcyclecfg;
> -    target_ulong mcyclecfgh;
> +    uint64_t mcyclecfg;
>      target_ulong minstretcfg;
>      target_ulong minstretcfgh;
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 2d8916ee40..77d0bd7bca 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1060,7 +1060,8 @@ static RISCVException read_hpmcounterh(CPURISCVStat=
e *env, int csrno,
>  static RISCVException read_mcyclecfg(CPURISCVState *env, int csrno,
>                                       target_ulong *val)
>  {
> -    *val =3D env->mcyclecfg;
> +    bool rv32 =3D riscv_cpu_mxl(env) =3D=3D MXL_RV32;
> +    *val =3D extract64(env->mcyclecfg, 0, rv32 ? 32 : 64);
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -1070,7 +1071,7 @@ static RISCVException write_mcyclecfg(CPURISCVState=
 *env, int csrno,
>      uint64_t inh_avail_mask;
>
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> -        env->mcyclecfg =3D val;
> +        env->mcyclecfg =3D deposit64(env->mcyclecfg, 0, 32, val);
>      } else {
>          /* Set xINH fields if priv mode supported */
>          inh_avail_mask =3D ~MHPMEVENT_FILTER_MASK | MCYCLECFG_BIT_MINH;
> @@ -1089,7 +1090,7 @@ static RISCVException write_mcyclecfg(CPURISCVState=
 *env, int csrno,
>  static RISCVException read_mcyclecfgh(CPURISCVState *env, int csrno,
>                                        target_ulong *val)
>  {
> -    *val =3D env->mcyclecfgh;
> +    *val =3D extract64(env->mcyclecfg, 32, 32);
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -1107,7 +1108,7 @@ static RISCVException write_mcyclecfgh(CPURISCVStat=
e *env, int csrno,
>      inh_avail_mask |=3D (riscv_has_ext(env, RVH) &&
>                         riscv_has_ext(env, RVS)) ? MCYCLECFGH_BIT_VSINH :=
 0;
>
> -    env->mcyclecfgh =3D val & inh_avail_mask;
> +    env->mcyclecfg =3D deposit64(env->mcyclecfg, 32, 32, val & inh_avail=
_mask);
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -1246,8 +1247,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counter=
s_val(CPURISCVState *env,
>      g_assert(rv32 || !upper_half);
>
>      if (counter_idx =3D=3D 0) {
> -        cfg_val =3D rv32 ? ((uint64_t)env->mcyclecfgh << 32) :
> -                  env->mcyclecfg;
> +        cfg_val =3D env->mcyclecfg;
>      } else if (counter_idx =3D=3D 2) {
>          cfg_val =3D rv32 ? ((uint64_t)env->minstretcfgh << 32) :
>                    env->minstretcfg;
> @@ -1521,8 +1521,12 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, i=
nt evt_index,
>  }
>
>  static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulon=
g *val,
> -                            target_ulong new_val, target_ulong wr_mask)
> +                          target_ulong new_val, uint64_t wr_mask)
>  {
> +    /*
> +     * wr_mask is 64-bit so upper 32 bits of mcyclecfg and minstretcfg
> +     * are retained.
> +     */
>      switch (cfg_index) {
>      case 0:             /* CYCLECFG */
>          if (wr_mask) {
> @@ -1548,8 +1552,9 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int c=
fg_index, target_ulong *val,
>  }
>
>  static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulo=
ng *val,
> -                            target_ulong new_val, target_ulong wr_mask)
> +                           target_ulong new_val, target_ulong wr_mask)
>  {
> +    uint64_t cfgh;
>
>      if (riscv_cpu_mxl(env) !=3D MXL_RV32) {
>          return RISCV_EXCP_ILLEGAL_INST;
> @@ -1557,12 +1562,13 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, in=
t cfg_index, target_ulong *val,
>
>      switch (cfg_index) {
>      case 0:         /* CYCLECFGH */
> +        cfgh =3D extract64(env->mcyclecfg, 32, 32);
>          if (wr_mask) {
>              wr_mask &=3D ~MCYCLECFGH_BIT_MINH;
> -            env->mcyclecfgh =3D (new_val & wr_mask) |
> -                              (env->mcyclecfgh & ~wr_mask);
> +            cfgh =3D (new_val & wr_mask) | (cfgh & ~wr_mask);
> +            env->mcyclecfg =3D deposit64(env->mcyclecfg, 32, 32, cfgh);
>          } else {
> -            *val =3D env->mcyclecfgh;
> +            *val =3D cfgh;
>          }
>          break;
>      case 2:          /* INSTRETCFGH */
> --
> 2.51.0
>
>

