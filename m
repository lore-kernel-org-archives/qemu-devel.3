Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E074FC27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 14:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGfkq-0001fm-6T; Mon, 10 Jun 2024 10:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sGfko-0001eU-3z
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:12:10 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sGfkj-0002pO-LY
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:12:09 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52c819f6146so2420137e87.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718028722; x=1718633522;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ivox2W8sxS/bjywmyH03eVUmMDpwedjtsCPSqCXwe4A=;
 b=qnfN3MykhUreX0eIj6ye7foGavNHd9HJI6mcLj6SuEPxRIOHKJM062toMU9EsZH5Y9
 LcZq+dVo+BSCqytgamJdbnv+0AvnkFIRSL0nQqJPiRyNiPe/PL6nd4LfgdTS64704Br7
 NTUUdYSbrL9kFM5+f3vAT/alDfONrYD6uCEqKLvBERYAxpkVQxUUtNS0uzuPX4bbRojM
 mz5pfttRuvsVBeIauFTr0X1v0XIvePgNyWzIClJ/dZV4UBtVrG8PbBBl8NhkwamYkVMY
 dAwXAa+e9diTlJvPhDUYlDHzLvQ7LQJzKnz5I6kW3YXIBtbMZ9+qsrhLgGNDbDs7k2XV
 BZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718028722; x=1718633522;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ivox2W8sxS/bjywmyH03eVUmMDpwedjtsCPSqCXwe4A=;
 b=qn9W3+A/vKx8BhMIVfxOwqT2pWEXoiqfgqjjhSGf5raDGdLIV8HhWLDN3dKqB0cq1k
 rnEG9U11rlQ+nRo8Edb31yap1MJ1DlWds6a2j1tj5XxiY1tfNM/6SW05TntYqkw5Xjne
 dc8e+dlKG4OzJI6uvlcejqJvQ9HuYAghBCp4GWdvqHW6rBsCpZXHGIYr6LICsJ86w/ON
 RpxFy6z9NdV3wJMAlMe1VzPUKQQ++65XK+e4CyOeSDTZ87P+Qe/oX705iuDZ3sJjAaJU
 SSxUHknom7iLgjzu+ODAdfZ3tWcxL6k07FefeG8PvNd49G9epE/IT3vnM6fBFwohTlo0
 i4Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtTdJExJcy/l04VC2KZbgwD0w9EJQXYXrn4DEgjByvWGGyoTIsY6xAwtHJCtmI4pGnUC1C60jCBRaHjEjXfBVcmKOin1M=
X-Gm-Message-State: AOJu0Yx+WeAowqqubPt162+k3/EHbgfRxfGLk4yOeAtWG9+8Ch7Z7B7S
 p1ASjxXU9KxFg9Z7Q5rJIOuhiAtvAq5Kl9hYUZ+MHXgkh43nxM8mAx65Yk13JUwJXojbEaTxceN
 2Y61t9giievzETIIrmMUtJm7XP8PfqZKwfNnXVw==
X-Google-Smtp-Source: AGHT+IHzAbHctT6F0UHQF+Gm+fctISLb9TM1Ee/jylMVjHgdxkEbKd9nE2sfjmJ+E2mrM+nvI/XOQ9tF3gKus5NkpBc=
X-Received: by 2002:a05:6512:282a:b0:52c:85d1:6eb3 with SMTP id
 2adb3069b0e04-52c85d16fcdmr3823044e87.30.1718028721913; Mon, 10 Jun 2024
 07:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
 <20240529160950.132754-4-rkanwal@rivosinc.com>
 <3f3cc0f1-0a56-452a-a934-b3f770056570@sifive.com>
In-Reply-To: <3f3cc0f1-0a56-452a-a934-b3f770056570@sifive.com>
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Mon, 10 Jun 2024 15:11:50 +0100
Message-ID: <CAECbVCucQK3PF3vrgzVQbvsidPF_o9TgkjV6PxA3KN-4wt_+eA@mail.gmail.com>
Subject: Re: [PATCH 3/6] target/riscv: Add support for Control Transfer
 Records extension CSRs.
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org
Content-Type: multipart/alternative; boundary="000000000000af1fd5061a89bb96"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=rkanwal@rivosinc.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000af1fd5061a89bb96
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jason for your review.

On Tue, Jun 4, 2024 at 11:14=E2=80=AFAM Jason Chien <jason.chien@sifive.com=
> wrote:
>
>
> Rajnesh Kanwal =E6=96=BC 2024/5/30 =E4=B8=8A=E5=8D=88 12:09 =E5=AF=AB=E9=
=81=93:
>
> This commit adds support for [m|s|vs]ctrcontrol, sctrstatus and
> sctrdepth CSRs handling.
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>  target/riscv/cpu.h     |   5 ++
>  target/riscv/cpu_cfg.h |   2 +
>  target/riscv/csr.c     | 159 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 166 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index a185e2d494..3d4d5172b8 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -263,6 +263,11 @@ struct CPUArchState {
>      target_ulong mcause;
>      target_ulong mtval;  /* since: priv-1.10.0 */
>
> +    uint64_t mctrctl;
> +    uint32_t sctrdepth;
> +    uint32_t sctrstatus;
> +    uint64_t vsctrctl;
> +
>      /* Machine and Supervisor interrupt priorities */
>      uint8_t miprio[64];
>      uint8_t siprio[64];
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index d9354dc80a..d329a65811 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -123,6 +123,8 @@ struct RISCVCPUConfig {
>      bool ext_zvfhmin;
>      bool ext_smaia;
>      bool ext_ssaia;
> +    bool ext_smctr;
> +    bool ext_ssctr;
>      bool ext_sscofpmf;
>      bool ext_smepmp;
>      bool rvv_ta_all_1s;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 2f92e4b717..888084d8e5 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -621,6 +621,61 @@ static RISCVException pointer_masking(CPURISCVState
*env, int csrno)
>      return RISCV_EXCP_ILLEGAL_INST;
>  }
>
> +/*
> + * M-mode:
> + * Without ext_smctr raise illegal inst excep.
> + * Otherwise everything is accessible to m-mode.
> + *
> + * S-mode:
> + * Without ext_ssctr or mstateen.ctr raise illegal inst excep.
> + * Otherwise everything other than mctrctl is accessible.
> + *
> + * VS-mode:
> + * Without ext_ssctr or mstateen.ctr raise illegal inst excep.
> + * Without hstateen.ctr raise virtual illegal inst excep.
> + * Otherwise allow vsctrctl, sctrstatus, 0x200-0x2ff entry range.
> + * Always raise illegal instruction exception for sctrdepth.
> + */
> +static RISCVException ctr_mmode(CPURISCVState *env, int csrno)
> +{
> +    /* Check if smctr-ext is present */
> +    if (riscv_cpu_cfg(env)->ext_smctr) {
> +        return RISCV_EXCP_NONE;
> +    }
> +
> +    return RISCV_EXCP_ILLEGAL_INST;
> +}
> +
> +static RISCVException ctr_smode(CPURISCVState *env, int csrno)
> +{
> +    if ((env->priv =3D=3D PRV_M && riscv_cpu_cfg(env)->ext_smctr) ||
> +        (env->priv =3D=3D PRV_S && !env->virt_enabled &&
> +         riscv_cpu_cfg(env)->ext_ssctr)) {
> +        return smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
> +    }
> +
> +    if (env->priv =3D=3D PRV_S && env->virt_enabled &&
> +        riscv_cpu_cfg(env)->ext_ssctr) {
> +        if (csrno =3D=3D CSR_SCTRSTATUS) {
>
> missing sctrctl?
>
> +            return smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
> +        }
> +
> +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> +    }
> +
> +    return RISCV_EXCP_ILLEGAL_INST;
> +}
>
> I think there is no need to bind M-mode with ext_smctr, S-mode with
ext_ssctr and VS-mode with ext_ssctr, since this predicate function is for
S-mode CSRs, which are defined in both smctr and ssctr, we just need to
check at least one of ext_ssctr or ext_smctr is true.
>
> The spec states that:
> Attempts to access sctrdepth from VS-mode or VU-mode raise a
virtual-instruction exception, unless CTR state enable access restrictions
apply.
>
> In my understanding, we should check the presence of smstateen extension
first, and
>
> if smstateen is implemented:
>
> for sctrctl and sctrstatus, call smstateen_acc_ok()
> for sctrdepth, call smstateen_acc_ok(), and if there is any exception
returned, always report virtual-instruction exception.

For sctrdepth, we are supposed to always return a virt-inst exception in
case of
VS-VU mode unless CTR state enable access restrictions apply.

So for sctrdepth, call smstateen_acc_ok(), and if there is no exception
returned
(mstateen.CTR=3D1 and hstateen.CTR=3D1 for virt mode), check if we are in
virtual
mode and return virtual-instruction exception otherwise return
RISCV_EXCP_NONE.
Note that if hstateen.CTR=3D0, smstateen_acc_ok() will return
virtual-instruction
exception which means regardless of the hstateen.CTR state, we will always
return virtual-instruction exception for VS/VU mode access to sctrdepth.

Basically this covers following rules for sctrdepth:

if mstateen.ctr =3D=3D 0
    return RISCV_EXCP_ILLEGAL_INST; // For all modes lower than M-mode.
else if in virt-mode // regardless of the state of hstateen.CTR
    return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
else
    return RISCV_EXCP_NONE

>
> If smstateen is not implemented:
>
> for sctrctl and sctrstatus, there is no check.
> for sctrdepth, I think the spec is ambiguous. What does "CTR state enable
access restrictions apply" mean when smstateen is not implemented?

As per my understanding, this means if mstateen.CTR=3D0 then we return an
illegal instruction exception regardless if it's virtual mode or not. This
is
the only effect of CTR state enable on sctrdepth CSR. If mstateen.CTR=3D1,
sctrdepth access from VS-mode results in virtual-instruction exception
regardless of hstateen.CTR.

Based on this, we have following model for predicate checks:

if smstateen is implemented:

for sctrctl and sctrstatus, call smstateen_acc_ok()
for sctrdepth, call smstateen_acc_ok(), and if there is no exception,
    check if we are in virtual mode and return virtual-instruction exceptio=
n
    otherwise return RISCV_EXCP_NONE.

If smstateen is not implemented:

for sctrctl and sctrstatus, there is no check.
for sctrdepth, if in VS/VU mode return virtual-instruction exception
otherwise
    no check.

Here is the code to better understand this.

static RISCVException ctr_smode(CPURISCVState *env, int csrno)
{
    const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);

    if (!cfg->ext_ssctr && !cfg->ext_smctr) {
        return RISCV_EXCP_ILLEGAL_INST;
    }

    if (riscv_cpu_cfg(env)->ext_smstateen) {
        RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
        if (ret =3D=3D RISCV_EXCP_NONE && csrno =3D=3D CSR_SCTRDEPTH &&
env->virt_enabled) {
            return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
        }
        return ret;
    } else {
        if (csrno =3D=3D CSR_SCTRDEPTH && env->virt_enabled) {
            return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
        }
    }

    return RISCV_EXCP_NONE;
}

Given smstateen_acc_ok() returns RISCV_EXCP_NONE in case if ext_smstateen
is not
implemented, this can be further simplified to:

static RISCVException ctr_smode(CPURISCVState *env, int csrno)
{
    const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);

    if (!cfg->ext_ssctr && !cfg->ext_smctr) {
        return RISCV_EXCP_ILLEGAL_INST;
    }

    RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
    if (ret =3D=3D RISCV_EXCP_NONE && csrno =3D=3D CSR_SCTRDEPTH &&
env->virt_enabled) {
        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
    }
    return ret;
}

>
> Here is the code to better understand my description.
>
> static RISCVException ctr_smode(CPURISCVState *env, int csrno)
> {
>     const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
>
>     if (!cfg->ext_ssctr && !cfg->ext_smctr) {
>         return RISCV_EXCP_ILLEGAL_INST;
>     }
>
>     if (riscv_cpu_cfg(env)->ext_smstateen) {
>         RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
>         if (ret !=3D RISCV_EXCP_NONE) {
>             if (csrno =3D=3D CSR_SCTRDEPTH && env->virt_enabled) {
>                 return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>             }
>
>             return ret;
>         }
>     } else {
>         /* The spec is ambiguous. */
>         if (csrno =3D=3D CSR_SCTRDEPTH && env->virt_enabled) {
>             return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>         }
>     }
>
>     return RISCV_EXCP_NONE;
> }
>
> +
> +static RISCVException ctr_vsmode(CPURISCVState *env, int csrno)
> +{
> +    if (env->priv =3D=3D PRV_S && env->virt_enabled &&
> +        riscv_cpu_cfg(env)->ext_ssctr) {
> +        return smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
>
> In riscv_csrrw_check(), an virtual-instruction exception is always
reported no matter what. Do we need this check?
>
> +    }
> +
> +    return ctr_smode(env, csrno);
> +}
> +
>  static RISCVException aia_hmode(CPURISCVState *env, int csrno)
>  {
>      int ret;
> @@ -3835,6 +3890,100 @@ static RISCVException write_satp(CPURISCVState
*env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static RISCVException rmw_sctrdepth(CPURISCVState *env, int csrno,
> +                                    target_ulong *ret_val,
> +                                    target_ulong new_val, target_ulong
wr_mask)
> +{
> +    uint64_t mask =3D wr_mask & SCTRDEPTH_MASK;
> +
> +    if (ret_val) {
> +        *ret_val =3D env->sctrdepth & SCTRDEPTH_MASK;
>
> We don't need to do bitwise and with SCTRDEPTH_MASK on read accesses when
we always do bitwise and with SCTRDEPTH_MASK on write accesses.
>
> +    }
> +
> +    env->sctrdepth =3D (env->sctrdepth & ~mask) | (new_val & mask);
> +
> +    /* Correct depth. */
> +    if (wr_mask & SCTRDEPTH_MASK) {
> +        uint64_t depth =3D get_field(env->sctrdepth, SCTRDEPTH_MASK);
> +
> +        if (depth > SCTRDEPTH_MAX) {
> +            env->sctrdepth =3D
> +                set_field(env->sctrdepth, SCTRDEPTH_MASK, SCTRDEPTH_MAX)=
;
> +        }
> +
> +        /* Update sctrstatus.WRPTR with a legal value */
> +        depth =3D 16 << depth;
>
> The "depth" on the right side may exceed SCTRDEPTH_MAX.
>
> +        env->sctrstatus =3D
> +            env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (depth - 1));
> +    }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException rmw_mctrctl(CPURISCVState *env, int csrno,
> +                                    target_ulong *ret_val,
> +                                    target_ulong new_val, target_ulong
wr_mask)
> +{
> +    uint64_t mask =3D wr_mask & MCTRCTL_MASK;
> +
> +    if (ret_val) {
> +        *ret_val =3D env->mctrctl & MCTRCTL_MASK;
>
> There is no need to do bitwise and with the mask on read accesses when we
always do bitwise and with the mask on write accesses.
>
> +    }
> +
> +    env->mctrctl =3D (env->mctrctl & ~mask) | (new_val & mask);
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException rmw_sctrctl(CPURISCVState *env, int csrno,
> +                                    target_ulong *ret_val,
> +                                    target_ulong new_val, target_ulong
wr_mask)
> +{
> +    uint64_t mask =3D wr_mask & SCTRCTL_MASK;
> +    RISCVException ret;
> +
> +    ret =3D rmw_mctrctl(env, csrno, ret_val, new_val, mask);
>
> When V=3D1, vsctrctl substitutes for sctrctl.
>
> +    if (ret_val) {
> +        *ret_val &=3D SCTRCTL_MASK;
> +    }
> +
> +    return ret;
> +}
> +
> +static RISCVException rmw_sctrstatus(CPURISCVState *env, int csrno,
> +                                     target_ulong *ret_val,
> +                                     target_ulong new_val, target_ulong
wr_mask)
> +{
> +    uint32_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
> +    uint32_t mask =3D wr_mask & SCTRSTATUS_MASK;
> +
> +    if (ret_val) {
> +        *ret_val =3D env->sctrstatus & SCTRSTATUS_MASK;
>
> There is no need to do bitwise and with the mask on read accesses when we
always do bitwise and with the mask on write accesses.
>
> +    }
> +
> +    env->sctrstatus =3D (env->sctrstatus & ~mask) | (new_val & mask);
> +
> +    /* Update sctrstatus.WRPTR with a legal value */
> +    env->sctrstatus =3D env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (dep=
th
- 1));
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException rmw_vsctrctl(CPURISCVState *env, int csrno,
> +                                    target_ulong *ret_val,
> +                                    target_ulong new_val, target_ulong
wr_mask)
> +{
> +    uint64_t mask =3D wr_mask & VSCTRCTL_MASK;
> +
> +    if (ret_val) {
> +        *ret_val =3D env->vsctrctl & VSCTRCTL_MASK;
>
> There is no need to do bitwise and with the mask on read accesses when we
always do bitwise and with the mask on write accesses.
>
> +    }
> +
> +    env->vsctrctl =3D (env->vsctrctl & ~mask) | (new_val & mask);
> +
> +    return RISCV_EXCP_NONE;
> +}
>
> Is it possible to define rmw_xctrctl() instead of three individual rmw
functions and use a switch case to select the mask and the CSR for the
purpose of reducing code size?
>
> +
>  static RISCVException read_vstopi(CPURISCVState *env, int csrno,
>                                    target_ulong *val)
>  {
> @@ -5771,6 +5920,16 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>      [CSR_SPMBASE] =3D    { "spmbase", pointer_masking, read_spmbase,
>                           write_spmbase
   },
>
> +    [CSR_MCTRCTL]       =3D { "mctrctl",       ctr_mmode, NULL, NULL,
> +                                rmw_mctrctl },
>
> I think this can be one line.
>
> +    [CSR_SCTRCTL]       =3D { "sctrctl",       ctr_smode, NULL, NULL,
> +                                rmw_sctrctl },
>
> same here
>
> +    [CSR_SCTRDEPTH]       =3D { "sctrdepth",       ctr_smode, NULL, NULL=
,
> +                                rmw_sctrdepth },
>
> same here
>
> +    [CSR_SCTRSTATUS]       =3D { "sctrstatus",       ctr_smode, NULL, NU=
LL,
> +                                rmw_sctrstatus },
>
> same here
>
> +    [CSR_VSCTRCTL]      =3D { "vsctrctl",      ctr_vsmode, NULL, NULL,
> +                                rmw_vsctrctl },
>
> same here
>
>      /* Performance Counters */
>      [CSR_HPMCOUNTER3]    =3D { "hpmcounter3",    ctr,    read_hpmcounter=
 },
>      [CSR_HPMCOUNTER4]    =3D { "hpmcounter4",    ctr,    read_hpmcounter=
 },

--000000000000af1fd5061a89bb96
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>Thanks Jason for your review.<br><br>On Tue, Jun 4, 20=
24 at 11:14=E2=80=AFAM Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive=
.com">jason.chien@sifive.com</a>&gt; wrote:<br>&gt;<br>&gt;<br>&gt; Rajnesh=
 Kanwal =E6=96=BC 2024/5/30 =E4=B8=8A=E5=8D=88 12:09 =E5=AF=AB=E9=81=93:<br=
>&gt;<br>&gt; This commit adds support for [m|s|vs]ctrcontrol, sctrstatus a=
nd<br>&gt; sctrdepth CSRs handling.<br>&gt;<br>&gt; Signed-off-by: Rajnesh =
Kanwal &lt;<a href=3D"mailto:rkanwal@rivosinc.com">rkanwal@rivosinc.com</a>=
&gt;<br>&gt; ---<br>&gt; =C2=A0target/riscv/cpu.h =C2=A0 =C2=A0 | =C2=A0 5 =
++<br>&gt; =C2=A0target/riscv/cpu_cfg.h | =C2=A0 2 +<br>&gt; =C2=A0target/r=
iscv/csr.c =C2=A0 =C2=A0 | 159 +++++++++++++++++++++++++++++++++++++++++<br=
>&gt; =C2=A03 files changed, 166 insertions(+)<br>&gt;<br>&gt; diff --git a=
/target/riscv/cpu.h b/target/riscv/cpu.h<br>&gt; index a185e2d494..3d4d5172=
b8 100644<br>&gt; --- a/target/riscv/cpu.h<br>&gt; +++ b/target/riscv/cpu.h=
<br>&gt; @@ -263,6 +263,11 @@ struct CPUArchState {<br>&gt; =C2=A0 =C2=A0 =
=C2=A0target_ulong mcause;<br>&gt; =C2=A0 =C2=A0 =C2=A0target_ulong mtval; =
=C2=A0/* since: priv-1.10.0 */<br>&gt; =C2=A0<br>&gt; + =C2=A0 =C2=A0uint64=
_t mctrctl;<br>&gt; + =C2=A0 =C2=A0uint32_t sctrdepth;<br>&gt; + =C2=A0 =C2=
=A0uint32_t sctrstatus;<br>&gt; + =C2=A0 =C2=A0uint64_t vsctrctl;<br>&gt; +=
<br>&gt; =C2=A0 =C2=A0 =C2=A0/* Machine and Supervisor interrupt priorities=
 */<br>&gt; =C2=A0 =C2=A0 =C2=A0uint8_t miprio[64];<br>&gt; =C2=A0 =C2=A0 =
=C2=A0uint8_t siprio[64];<br>&gt; diff --git a/target/riscv/cpu_cfg.h b/tar=
get/riscv/cpu_cfg.h<br>&gt; index d9354dc80a..d329a65811 100644<br>&gt; ---=
 a/target/riscv/cpu_cfg.h<br>&gt; +++ b/target/riscv/cpu_cfg.h<br>&gt; @@ -=
123,6 +123,8 @@ struct RISCVCPUConfig {<br>&gt; =C2=A0 =C2=A0 =C2=A0bool ex=
t_zvfhmin;<br>&gt; =C2=A0 =C2=A0 =C2=A0bool ext_smaia;<br>&gt; =C2=A0 =C2=
=A0 =C2=A0bool ext_ssaia;<br>&gt; + =C2=A0 =C2=A0bool ext_smctr;<br>&gt; + =
=C2=A0 =C2=A0bool ext_ssctr;<br>&gt; =C2=A0 =C2=A0 =C2=A0bool ext_sscofpmf;=
<br>&gt; =C2=A0 =C2=A0 =C2=A0bool ext_smepmp;<br>&gt; =C2=A0 =C2=A0 =C2=A0b=
ool rvv_ta_all_1s;<br>&gt; diff --git a/target/riscv/csr.c b/target/riscv/c=
sr.c<br>&gt; index 2f92e4b717..888084d8e5 100644<br>&gt; --- a/target/riscv=
/csr.c<br>&gt; +++ b/target/riscv/csr.c<br>&gt; @@ -621,6 +621,61 @@ static=
 RISCVException pointer_masking(CPURISCVState *env, int csrno)<br>&gt; =C2=
=A0 =C2=A0 =C2=A0return RISCV_EXCP_ILLEGAL_INST;<br>&gt; =C2=A0}<br>&gt; =
=C2=A0<br>&gt; +/*<br>&gt; + * M-mode:<br>&gt; + * Without ext_smctr raise =
illegal inst excep.<br>&gt; + * Otherwise everything is accessible to m-mod=
e.<br>&gt; + *<br>&gt; + * S-mode:<br>&gt; + * Without ext_ssctr or mstatee=
n.ctr raise illegal inst excep.<br>&gt; + * Otherwise everything other than=
 mctrctl is accessible.<br>&gt; + *<br>&gt; + * VS-mode:<br>&gt; + * Withou=
t ext_ssctr or mstateen.ctr raise illegal inst excep.<br>&gt; + * Without h=
stateen.ctr raise virtual illegal inst excep.<br>&gt; + * Otherwise allow v=
sctrctl, sctrstatus, 0x200-0x2ff entry range.<br>&gt; + * Always raise ille=
gal instruction exception for sctrdepth.<br>&gt; + */<br>&gt; +static RISCV=
Exception ctr_mmode(CPURISCVState *env, int csrno)<br>&gt; +{<br>&gt; + =C2=
=A0 =C2=A0/* Check if smctr-ext is present */<br>&gt; + =C2=A0 =C2=A0if (ri=
scv_cpu_cfg(env)-&gt;ext_smctr) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn RISCV_EXCP_NONE;<br>&gt; + =C2=A0 =C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=
=A0return RISCV_EXCP_ILLEGAL_INST;<br>&gt; +}<br>&gt; +<br>&gt; +static RIS=
CVException ctr_smode(CPURISCVState *env, int csrno)<br>&gt; +{<br>&gt; + =
=C2=A0 =C2=A0if ((env-&gt;priv =3D=3D PRV_M &amp;&amp; riscv_cpu_cfg(env)-&=
gt;ext_smctr) ||<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0(env-&gt;priv =3D=3D =
PRV_S &amp;&amp; !env-&gt;virt_enabled &amp;&amp;<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 riscv_cpu_cfg(env)-&gt;ext_ssctr)) {<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);<br>&gt; + =C2=
=A0 =C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0if (env-&gt;priv =3D=3D PRV_S =
&amp;&amp; env-&gt;virt_enabled &amp;&amp;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0riscv_cpu_cfg(env)-&gt;ext_ssctr) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (csrno =3D=3D CSR_SCTRSTATUS) {<br>&gt;<br>&gt; missing sctrctl?<b=
r>&gt;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return smstateen_=
acc_ok(env, 0, SMSTATEEN0_CTR);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&=
gt; +<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return RISCV_EXCP_VIRT_INSTRUCTI=
ON_FAULT;<br>&gt; + =C2=A0 =C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0return =
RISCV_EXCP_ILLEGAL_INST;<br>&gt; +}<br>&gt;<br>&gt; I think there is no nee=
d to bind M-mode with ext_smctr, S-mode with ext_ssctr and VS-mode with ext=
_ssctr, since this predicate function is for S-mode CSRs, which are defined=
 in both smctr and ssctr, we just need to check at least one of ext_ssctr o=
r ext_smctr is true.<br>&gt;<br>&gt; The spec states that:<br>&gt; Attempts=
 to access sctrdepth from VS-mode or VU-mode raise a virtual-instruction ex=
ception, unless CTR state enable access restrictions apply.<br>&gt;<br>&gt;=
 In my understanding, we should check the presence of smstateen extension f=
irst, and<br>&gt;<br>&gt; if smstateen is implemented:<br>&gt;<br>&gt; for =
sctrctl and sctrstatus, call smstateen_acc_ok()<br>&gt; for sctrdepth, call=
 smstateen_acc_ok(), and if there is any exception returned, always report =
virtual-instruction exception.<br><br>For sctrdepth, we are supposed to alw=
ays return a virt-inst exception in case of<br>VS-VU mode unless CTR state =
enable access restrictions apply.<br><br>So for sctrdepth, call smstateen_a=
cc_ok(), and if there is no exception returned<br>(mstateen.CTR=3D1 and hst=
ateen.CTR=3D1 for virt mode), check if we are in virtual<br><div>mode and r=
eturn virtual-instruction exception otherwise return RISCV_EXCP_NONE.</div>=
<div>Note that if hstateen.CTR=3D0, smstateen_acc_ok() will return virtual-=
instruction</div><div>exception which means regardless of the hstateen.CTR =
state, we will always</div><div>return virtual-instruction exception for VS=
/VU mode access to sctrdepth.<br></div><br>Basically this covers following =
rules for sctrdepth:<br><br>if mstateen.ctr =3D=3D 0<br>=C2=A0 =C2=A0 retur=
n RISCV_EXCP_ILLEGAL_INST; // For all modes lower than M-mode.<br>else if i=
n virt-mode // regardless of the state of hstateen.CTR<br>=C2=A0 =C2=A0 ret=
urn RISCV_EXCP_VIRT_INSTRUCTION_FAULT;<br>else<br>=C2=A0 =C2=A0 return RISC=
V_EXCP_NONE<br><br>&gt;<br>&gt; If smstateen is not implemented:<br>&gt;<br=
>&gt; for sctrctl and sctrstatus, there is no check.<br>&gt; for sctrdepth,=
 I think the spec is ambiguous. What does &quot;CTR state enable access res=
trictions apply&quot; mean when smstateen is not implemented?<br><br>As per=
 my understanding, this means if mstateen.CTR=3D0 then we return an<br>ille=
gal instruction exception regardless if it&#39;s virtual mode or not. This =
is<br>the only effect of CTR state enable on sctrdepth CSR. If mstateen.CTR=
=3D1,<br>sctrdepth access from VS-mode results in virtual-instruction excep=
tion<br>regardless of hstateen.CTR.<br><br>Based on this, we have following=
 model for predicate checks:<br><br>if smstateen is implemented:<br><br>for=
 sctrctl and sctrstatus, call smstateen_acc_ok()<br>for sctrdepth, call sms=
tateen_acc_ok(), and if there is no exception,<br>=C2=A0 =C2=A0 check if we=
 are in virtual mode and return virtual-instruction exception<br>=C2=A0 =C2=
=A0 otherwise return RISCV_EXCP_NONE.<br><br>If smstateen is not implemente=
d:<br><br>for sctrctl and sctrstatus, there is no check.<br>for sctrdepth, =
if in VS/VU mode return virtual-instruction exception otherwise<br>=C2=A0 =
=C2=A0 no check.<br><br>Here is the code to better understand this.<br><br>=
static RISCVException ctr_smode(CPURISCVState *env, int csrno)<br>{<br>=C2=
=A0 =C2=A0 const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);<br><br>=C2=A0 =
=C2=A0 if (!cfg-&gt;ext_ssctr &amp;&amp; !cfg-&gt;ext_smctr) {<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_ILLEGAL_INST;<br>=C2=A0 =C2=A0 }<br>=
<br>=C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;ext_smstateen) {<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN=
0_CTR);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D RISCV_EXCP_NONE &amp;=
&amp; csrno =3D=3D CSR_SCTRDEPTH &amp;&amp; env-&gt;virt_enabled) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_VIRT_INSTRUCTION_F=
AULT;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 retur=
n ret;<br>=C2=A0 =C2=A0 } else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (csrno =
=3D=3D CSR_SCTRDEPTH &amp;&amp; env-&gt;virt_enabled) {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 retur=
n RISCV_EXCP_NONE;<br>}<br><br>Given smstateen_acc_ok() returns RISCV_EXCP_=
NONE in case if ext_smstateen is not<br>implemented, this can be further si=
mplified to:<br><br>static RISCVException ctr_smode(CPURISCVState *env, int=
 csrno)<br>{<br>=C2=A0 =C2=A0 const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(e=
nv);<br><br>=C2=A0 =C2=A0 if (!cfg-&gt;ext_ssctr &amp;&amp; !cfg-&gt;ext_sm=
ctr) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_ILLEGAL_INST;<br>=
=C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 RISCVException ret =3D smstateen_acc_o=
k(env, 0, SMSTATEEN0_CTR);<br>=C2=A0 =C2=A0 if (ret =3D=3D RISCV_EXCP_NONE =
&amp;&amp; csrno =3D=3D CSR_SCTRDEPTH &amp;&amp; env-&gt;virt_enabled) {<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;<br>=
=C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 return ret;<br>}<br><br>&gt;<br>&gt; Here =
is the code to better understand my description.<br>&gt;<br>&gt; static RIS=
CVException ctr_smode(CPURISCVState *env, int csrno)<br>&gt; {<br>&gt; =C2=
=A0 =C2=A0 const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);<br>&gt;<br>&gt=
; =C2=A0 =C2=A0 if (!cfg-&gt;ext_ssctr &amp;&amp; !cfg-&gt;ext_smctr) {<br>=
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_ILLEGAL_INST;<br>&gt; =
=C2=A0 =C2=A0 }<br>&gt;<br>&gt; =C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;ex=
t_smstateen) {<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCVException ret =3D s=
mstateen_acc_ok(env, 0, SMSTATEEN0_CTR);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (ret !=3D RISCV_EXCP_NONE) {<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (csrno =3D=3D CSR_SCTRDEPTH &amp;&amp; env-&gt;virt_enabled) =
{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return RI=
SCV_EXCP_VIRT_INSTRUCTION_FAULT;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
ret;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; =C2=A0 =C2=A0 } else {<b=
r>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The spec is ambiguous. */<br>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (csrno =3D=3D CSR_SCTRDEPTH &amp;&amp; env-&gt;=
virt_enabled) {<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return RI=
SCV_EXCP_VIRT_INSTRUCTION_FAULT;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&=
gt; =C2=A0 =C2=A0 }<br>&gt;<br>&gt; =C2=A0 =C2=A0 return RISCV_EXCP_NONE;<b=
r>&gt; }<br>&gt;<br>&gt; +<br>&gt; +static RISCVException ctr_vsmode(CPURIS=
CVState *env, int csrno)<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0if (env-&gt;priv=
 =3D=3D PRV_S &amp;&amp; env-&gt;virt_enabled &amp;&amp;<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0riscv_cpu_cfg(env)-&gt;ext_ssctr) {<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);<br>&gt=
;<br>&gt; In riscv_csrrw_check(), an virtual-instruction exception is alway=
s reported no matter what. Do we need this check?<br>&gt;<br>&gt; + =C2=A0 =
=C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0return ctr_smode(env, csrno);<br>&=
gt; +}<br>&gt; +<br>&gt; =C2=A0static RISCVException aia_hmode(CPURISCVStat=
e *env, int csrno)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0int ret;<br>=
&gt; @@ -3835,6 +3890,100 @@ static RISCVException write_satp(CPURISCVState=
 *env, int csrno,<br>&gt; =C2=A0 =C2=A0 =C2=A0return RISCV_EXCP_NONE;<br>&g=
t; =C2=A0}<br>&gt; =C2=A0<br>&gt; +static RISCVException rmw_sctrdepth(CPUR=
ISCVState *env, int csrno,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0target_ulong *ret_val,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0target_ulong new_val, target_ulong wr_mask)<br>&gt;=
 +{<br>&gt; + =C2=A0 =C2=A0uint64_t mask =3D wr_mask &amp; SCTRDEPTH_MASK;<=
br>&gt; +<br>&gt; + =C2=A0 =C2=A0if (ret_val) {<br>&gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*ret_val =3D env-&gt;sctrdepth &amp; SCTRDEPTH_MASK;<br>&gt;<br>&=
gt; We don&#39;t need to do bitwise and with SCTRDEPTH_MASK on read accesse=
s when we always do bitwise and with SCTRDEPTH_MASK on write accesses.<br>&=
gt;<br>&gt; + =C2=A0 =C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0env-&gt;sctrd=
epth =3D (env-&gt;sctrdepth &amp; ~mask) | (new_val &amp; mask);<br>&gt; +<=
br>&gt; + =C2=A0 =C2=A0/* Correct depth. */<br>&gt; + =C2=A0 =C2=A0if (wr_m=
ask &amp; SCTRDEPTH_MASK) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t d=
epth =3D get_field(env-&gt;sctrdepth, SCTRDEPTH_MASK);<br>&gt; +<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (depth &gt; SCTRDEPTH_MAX) {<br>&gt; + =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;sctrdepth =3D<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_field(env-&gt;sctrdepth=
, SCTRDEPTH_MASK, SCTRDEPTH_MAX);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
>&gt; +<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Update sctrstatus.WRPTR wit=
h a legal value */<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0depth =3D 16 &lt;&l=
t; depth;<br>&gt;<br>&gt; The &quot;depth&quot; on the right side may excee=
d SCTRDEPTH_MAX.<br>&gt;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;sctrs=
tatus =3D<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;sctrst=
atus &amp; (~SCTRSTATUS_WRPTR_MASK | (depth - 1));<br>&gt; + =C2=A0 =C2=A0}=
<br>&gt; +<br>&gt; + =C2=A0 =C2=A0return RISCV_EXCP_NONE;<br>&gt; +}<br>&gt=
; +<br>&gt; +static RISCVException rmw_mctrctl(CPURISCVState *env, int csrn=
o,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong=
 *ret_val,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ta=
rget_ulong new_val, target_ulong wr_mask)<br>&gt; +{<br>&gt; + =C2=A0 =C2=
=A0uint64_t mask =3D wr_mask &amp; MCTRCTL_MASK;<br>&gt; +<br>&gt; + =C2=A0=
 =C2=A0if (ret_val) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0*ret_val =3D env=
-&gt;mctrctl &amp; MCTRCTL_MASK;<br>&gt;<br>&gt; There is no need to do bit=
wise and with the mask on read accesses when we always do bitwise and with =
the mask on write accesses.<br>&gt;<br>&gt; + =C2=A0 =C2=A0}<br>&gt; +<br>&=
gt; + =C2=A0 =C2=A0env-&gt;mctrctl =3D (env-&gt;mctrctl &amp; ~mask) | (new=
_val &amp; mask);<br>&gt; +<br>&gt; + =C2=A0 =C2=A0return RISCV_EXCP_NONE;<=
br>&gt; +}<br>&gt; +<br>&gt; +static RISCVException rmw_sctrctl(CPURISCVSta=
te *env, int csrno,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0target_ulong *ret_val,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0target_ulong new_val, target_ulong wr_mask)<br>&gt; +{<br>=
&gt; + =C2=A0 =C2=A0uint64_t mask =3D wr_mask &amp; SCTRCTL_MASK;<br>&gt; +=
 =C2=A0 =C2=A0RISCVException ret;<br>&gt; +<br>&gt; + =C2=A0 =C2=A0ret =3D =
rmw_mctrctl(env, csrno, ret_val, new_val, mask);<br>&gt;<br>&gt; When V=3D1=
, vsctrctl substitutes for sctrctl.<br>&gt;<br>&gt; + =C2=A0 =C2=A0if (ret_=
val) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0*ret_val &amp;=3D SCTRCTL_MASK;=
<br>&gt; + =C2=A0 =C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0return ret;<br>&=
gt; +}<br>&gt; +<br>&gt; +static RISCVException rmw_sctrstatus(CPURISCVStat=
e *env, int csrno,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 target_ulong *ret_val,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 target_ulong new_val, target_ulong wr_mask)<br>&gt; +{<br=
>&gt; + =C2=A0 =C2=A0uint32_t depth =3D 16 &lt;&lt; get_field(env-&gt;sctrd=
epth, SCTRDEPTH_MASK);<br>&gt; + =C2=A0 =C2=A0uint32_t mask =3D wr_mask &am=
p; SCTRSTATUS_MASK;<br>&gt; +<br>&gt; + =C2=A0 =C2=A0if (ret_val) {<br>&gt;=
 + =C2=A0 =C2=A0 =C2=A0 =C2=A0*ret_val =3D env-&gt;sctrstatus &amp; SCTRSTA=
TUS_MASK;<br>&gt;<br>&gt; There is no need to do bitwise and with the mask =
on read accesses when we always do bitwise and with the mask on write acces=
ses.<br>&gt;<br>&gt; + =C2=A0 =C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0env-=
&gt;sctrstatus =3D (env-&gt;sctrstatus &amp; ~mask) | (new_val &amp; mask);=
<br>&gt; +<br>&gt; + =C2=A0 =C2=A0/* Update sctrstatus.WRPTR with a legal v=
alue */<br>&gt; + =C2=A0 =C2=A0env-&gt;sctrstatus =3D env-&gt;sctrstatus &a=
mp; (~SCTRSTATUS_WRPTR_MASK | (depth - 1));<br>&gt; +<br>&gt; + =C2=A0 =C2=
=A0return RISCV_EXCP_NONE;<br>&gt; +}<br>&gt; +<br>&gt; +static RISCVExcept=
ion rmw_vsctrctl(CPURISCVState *env, int csrno,<br>&gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong *ret_val,<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong new_val, target_u=
long wr_mask)<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0uint64_t mask =3D wr_mask &=
amp; VSCTRCTL_MASK;<br>&gt; +<br>&gt; + =C2=A0 =C2=A0if (ret_val) {<br>&gt;=
 + =C2=A0 =C2=A0 =C2=A0 =C2=A0*ret_val =3D env-&gt;vsctrctl &amp; VSCTRCTL_=
MASK;<br>&gt;<br>&gt; There is no need to do bitwise and with the mask on r=
ead accesses when we always do bitwise and with the mask on write accesses.=
<br>&gt;<br>&gt; + =C2=A0 =C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0env-&gt;=
vsctrctl =3D (env-&gt;vsctrctl &amp; ~mask) | (new_val &amp; mask);<br>&gt;=
 +<br>&gt; + =C2=A0 =C2=A0return RISCV_EXCP_NONE;<br>&gt; +}<br>&gt;<br>&gt=
; Is it possible to define rmw_xctrctl() instead of three individual rmw fu=
nctions and use a switch case to select the mask and the CSR for the purpos=
e of reducing code size?<br>&gt;<br>&gt; +<br>&gt; =C2=A0static RISCVExcept=
ion read_vstopi(CPURISCVState *env, int csrno,<br>&gt; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong *val)<br>&gt; =C2=A0{<br>&gt; @=
@ -5771,6 +5920,16 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {<br=
>&gt; =C2=A0 =C2=A0 =C2=A0[CSR_SPMBASE] =3D =C2=A0 =C2=A0{ &quot;spmbase&qu=
ot;, pointer_masking, read_spmbase,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_spmbase =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>&gt; =C2=
=A0<br>&gt; + =C2=A0 =C2=A0[CSR_MCTRCTL] =C2=A0 =C2=A0 =C2=A0 =3D { &quot;m=
ctrctl&quot;, =C2=A0 =C2=A0 =C2=A0 ctr_mmode, NULL, NULL,<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rmw_mctrctl },<br>&gt;<br>&gt; I think this =
can be one line.<br>&gt;<br>&gt; + =C2=A0 =C2=A0[CSR_SCTRCTL] =C2=A0 =C2=A0=
 =C2=A0 =3D { &quot;sctrctl&quot;, =C2=A0 =C2=A0 =C2=A0 ctr_smode, NULL, NU=
LL,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rmw_sctrctl },<br>&gt;<=
br>&gt; same here<br>&gt;<br>&gt; + =C2=A0 =C2=A0[CSR_SCTRDEPTH] =C2=A0 =C2=
=A0 =C2=A0 =3D { &quot;sctrdepth&quot;, =C2=A0 =C2=A0 =C2=A0 ctr_smode, NUL=
L, NULL,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rmw_sctrdepth },<br>=
&gt;<br>&gt; same here<br>&gt;<br>&gt; + =C2=A0 =C2=A0[CSR_SCTRSTATUS] =C2=
=A0 =C2=A0 =C2=A0 =3D { &quot;sctrstatus&quot;, =C2=A0 =C2=A0 =C2=A0 ctr_sm=
ode, NULL, NULL,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rmw_sctrstat=
us },<br>&gt;<br>&gt; same here<br>&gt;<br>&gt; + =C2=A0 =C2=A0[CSR_VSCTRCT=
L] =C2=A0 =C2=A0 =C2=A0=3D { &quot;vsctrctl&quot;, =C2=A0 =C2=A0 =C2=A0ctr_=
vsmode, NULL, NULL,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rmw_vsctr=
ctl },<br>&gt;<br>&gt; same here<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0/* Per=
formance Counters */<br>&gt; =C2=A0 =C2=A0 =C2=A0[CSR_HPMCOUNTER3] =C2=A0 =
=C2=A0=3D { &quot;hpmcounter3&quot;, =C2=A0 =C2=A0ctr, =C2=A0 =C2=A0read_hp=
mcounter },<br>&gt; =C2=A0 =C2=A0 =C2=A0[CSR_HPMCOUNTER4] =C2=A0 =C2=A0=3D =
{ &quot;hpmcounter4&quot;, =C2=A0 =C2=A0ctr, =C2=A0 =C2=A0read_hpmcounter }=
,</div>

--000000000000af1fd5061a89bb96--

