Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F679F8E4A0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 02:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZE1-0005eO-Ad; Thu, 16 Apr 2026 22:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDZDw-0005e0-2E
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 22:46:28 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDZDm-00008A-HV
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 22:46:27 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ba25fd27571so33502566b.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 19:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776393975; cv=none;
 d=google.com; s=arc-20240605;
 b=P5UlFF911w+Rs2aMYbpgpkAOcRwZpUd5mfilLeoMpEnDxztK7AOtKF/S3A4ox3EccF
 J7ev993vKTDIlxFh05WXIAzrWCBG7DijBT+E+E0EisqmaSoFhmXA2ZSX54m/7MMS3rAG
 q+qFEUCSsAthntzWSga8sgurieRQyD77e+ksLW38BS1Zn/u3mlP6zZJaQM2GexD54wpz
 pIiKgyz+3MOr3zjtGBIJpmrfPoOCJIOIYvTSJizoi+7EE1eZd6ucRkfg7REDVxsZK9BX
 3Oewol6RQTicbYN5pGwO+ZXANnOgxgJgNPcXP0zfxCFHpTxH4f4nZY/x8uELFIN8hzd7
 HPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KFNssSTcGJhFXBStICNJbKMBD0r1Y1du74vHq8GmCK0=;
 fh=yA45nsw3/GlmR4yv0X4Y623/LexEZcgSQA1vCu7Dy/k=;
 b=fI14nV+DwVeEwBFZtgKWpNk+9veqqxHT2+gGgBbfYhtozd9Gz3/VZOSrIYhz5bp/WM
 guOkLk6wigL/CLoyAL6tYoRiJNagsxO5dcCTgFN8vAQ7CWOnNtQUL8WwhQajNgU/Cdgc
 ZRkw4Gi7bO+hEqtMY7V84sq1sKAdkFEjbR1thatt4NlHtDSPFCfXnd+Jenp5I9G5oSZj
 MDWCZQuxaDW02utrx/AsXQquBip49O6QpsIQy+Y699W40fCLRRC12+mn15PKkIH4ZkB9
 3Mnc0/RWgmYy0wmQzCy1wU7FB3WDl2jMN0TjpQaomX011iEgXvdtcEqhh4Qpvp9Lhqam
 b6yA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776393975; x=1776998775; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFNssSTcGJhFXBStICNJbKMBD0r1Y1du74vHq8GmCK0=;
 b=BvhX/yobd5bi2Mfna88WVEtxlqgfmaSuhtQIT4UOi72qMeOx+blhgIUEHmzxvt4ytA
 xJOA0/EPdn5FTSkWkw75o9KhTGhnw4vRn897OR/9jECQ35ZZhOznC5Yy7/SE9HpERZXU
 DjDBJcMqDABZrQ0cJkN0PC7a6jn1dsav/T6QZYUBNEehNDsSh455Ieo62SdgoorRfON1
 xbqz5fHB6DcXkbhA+duqyfhupaA/b7Py0tKY3YlVYQukoqLJrgBIOq/hvTRZxzyOegYH
 pG/Zk57otrhEtywNVdJnxs3p0cgKSBHPEurWMDsWnd9LDgm0BNHJjSPCaIcZX6ItfWqv
 cTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776393975; x=1776998775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KFNssSTcGJhFXBStICNJbKMBD0r1Y1du74vHq8GmCK0=;
 b=BRZ3NhrgelCeJnfKWMCl7OJZZbNtwixqxt+M+bE3HXjsJSry6dFZJF++6j501SaTEc
 SA34JEHGld6a31bxRcykrLPnhapL93232zypWg3O2wfoHOIFuqrdVP19m2blM1N5NVH3
 N1zNnNCZYol/5vikC3KTUmQSvTh/v+01nOWOaPPjO2yzRNMse/G9eB78AdDplsMjqgzp
 OwTan3DGhOa2+FdZWMLLH5QWeeU9RtJCi2JpNfwLsjdxLnvfsoiez3stXyw9PI8B5UmU
 DlfMiqHp5REFxdD8VlD/eTG+VFhFnWcLnJIzMIZ2ibD9NY/HzV5Occbl3VJl1M4kwe2P
 zXKA==
X-Gm-Message-State: AOJu0YzVNG8wyGKGtkj5Y1eXZIZj9Z10M55FzvcUP18wvFUlwhLyKSGv
 o1w1ZLIj3YowuQ6oc+VTpzbpXOxWz/r+1sH3XiDS+QBHjxJs23abZkou3kmWyrL0IejZhg6Kksi
 5fiGZZBntwQYf96zOiwRCzA7juWUWQWI=
X-Gm-Gg: AeBDietnlG13CFVKprQw9y43a33ffuoWjerMaCmyFkrJljHPqD0UM+mpueymNPnBt75
 cBfVsXvDSr9jQH8dc03OAD5flBzPOwRlPCOCUty8u5JUmOdClW7aFEzGgVwx6OumkiIRokQ2PqB
 GvuPc8fEz30Twus4bny3JrpIhpmluJilvxPfT++4w5r9/yRr46TnHuoyur1VLrY/wVAoDrJ37Rm
 K9FzKSwyKL/L0ekVuGSBQ8KICqaf8CeC+Kwr7Y4Z2FmzO8ftK0bGtr4okJXYW8SEEJv3UXnhuuY
 FT08dN7FIqM70bLItN+5i6XxjgZPe8F8/Wz2W05CjeHlmKcF
X-Received: by 2002:a17:906:5190:20b0:b96:d6cd:29e6 with SMTP id
 a640c23a62f3a-ba418983026mr33446566b.2.1776393974649; Thu, 16 Apr 2026
 19:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260409155344.2849233-1-bruno.vilaca.sa@gmail.com>
 <20260410110928.1014170-1-bruno.vilaca.sa@gmail.com>
In-Reply-To: <20260410110928.1014170-1-bruno.vilaca.sa@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2026 12:45:48 +1000
X-Gm-Features: AQROBzCx73K_tanJWabzt9SvNF7iJutdvPof7wMjuEZPNi8LXdIXiefIAqpXyjs
Message-ID: <CAKmqyKOQsQw2snBhjh4u+5M4=X81+Vyw3cg49pra4idUW7bW+w@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: fix RV32 stateen CSR handling
To: Bruno Sa <bruno.vilaca.sa@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
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

On Fri, Apr 10, 2026 at 9:10=E2=80=AFPM Bruno Sa <bruno.vilaca.sa@gmail.com=
> wrote:
>
> The RV32 stateen CSRs are split between the low-half CSR and the
> corresponding xH CSR, but the current implementation still handles some
> upper-half bits through the low-half write paths and also accepts the
> xH CSRs on RV64.
>
> Fix this by:
> - rejecting mstateen*h and hstateen*h accesses on RV64
> - keeping the RV64-only writable bits in the low-half write paths
> - handling the RV32 upper-half writable bits in write_mstateen0h() and
>   write_hstateen0h()
> - dropping unsupported writable bits from write_sstateen0()
>
> Signed-off-by: Bruno Sa <bruno.vilaca.sa@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> v2:
> - rebase on riscv-to-apply.next
> - resend only patch 2 after patch 1 was applied
> - wrap the AIA comment text to keep checkpatch clean
>
>  target/riscv/csr.c | 117 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 83 insertions(+), 34 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index cfd076b368..80727aa81e 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -502,6 +502,15 @@ static RISCVException mstateen(CPURISCVState *env, i=
nt csrno)
>      return any(env, csrno);
>  }
>
> +static RISCVException mstateen_32(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_cpu_mxl(env) !=3D MXL_RV32) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return mstateen(env, csrno);
> +}
> +
>  static RISCVException hstateen_pred(CPURISCVState *env, int csrno, int b=
ase)
>  {
>      if (!riscv_cpu_cfg(env)->ext_smstateen) {
> @@ -533,6 +542,10 @@ static RISCVException hstateen(CPURISCVState *env, i=
nt csrno)
>
>  static RISCVException hstateenh(CPURISCVState *env, int csrno)
>  {
> +    if (riscv_cpu_mxl(env) !=3D MXL_RV32) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
>      return hstateen_pred(env, csrno, CSR_HSTATEEN0H);
>  }
>
> @@ -3447,25 +3460,29 @@ static RISCVException write_mstateen0(CPURISCVSta=
te *env, int csrno,
>          wr_mask |=3D SMSTATEEN0_FCSR;
>      }
>
> -    if (env->priv_ver >=3D PRIV_VERSION_1_13_0) {
> -        wr_mask |=3D SMSTATEEN0_P1P13;
> -    }
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> +        if (env->priv_ver >=3D PRIV_VERSION_1_13_0) {
> +            wr_mask |=3D SMSTATEEN0_P1P13;
> +        }
>
> -    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrin=
d) {
> -        wr_mask |=3D SMSTATEEN0_SVSLCT;
> -    }
> +        if (riscv_cpu_cfg(env)->ext_smaia ||
> +            riscv_cpu_cfg(env)->ext_smcsrind) {
> +            wr_mask |=3D SMSTATEEN0_SVSLCT;
> +        }
>
> -    /*
> -     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if I=
MSIC is
> -     * implemented. However, that information is with MachineState and w=
e can't
> -     * figure that out in csr.c. Just enable if Smaia is available.
> -     */
> -    if (riscv_cpu_cfg(env)->ext_smaia) {
> -        wr_mask |=3D (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
> -    }
> +        /*
> +         * As per the AIA specification, SMSTATEEN0_IMSIC is valid
> +         * only if IMSIC is implemented. However, that information is
> +         * with MachineState and we can't figure that out in csr.c.
> +         * Just enable if Smaia is available.
> +         */
> +        if (riscv_cpu_cfg(env)->ext_smaia) {
> +            wr_mask |=3D (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
> +        }
>
> -    if (riscv_cpu_cfg(env)->ext_ssctr) {
> -        wr_mask |=3D SMSTATEEN0_CTR;
> +        if (riscv_cpu_cfg(env)->ext_ssctr) {
> +            wr_mask |=3D SMSTATEEN0_CTR;
> +        }
>      }
>
>      return write_mstateen(env, csrno, wr_mask, new_val);
> @@ -3507,6 +3524,20 @@ static RISCVException write_mstateen0h(CPURISCVSta=
te *env, int csrno,
>          wr_mask |=3D SMSTATEEN0_P1P13;
>      }
>
> +    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrin=
d) {
> +        wr_mask |=3D SMSTATEEN0_SVSLCT;
> +    }
> +
> +    /*
> +     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if
> +     * IMSIC is implemented. However, that information is with
> +     * MachineState and we can't figure that out in csr.c. Just enable
> +     * if Smaia is available.
> +     */
> +    if (riscv_cpu_cfg(env)->ext_smaia) {
> +        wr_mask |=3D (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
> +    }
> +
>      if (riscv_cpu_cfg(env)->ext_ssctr) {
>          wr_mask |=3D SMSTATEEN0_CTR;
>      }
> @@ -3552,21 +3583,25 @@ static RISCVException write_hstateen0(CPURISCVSta=
te *env, int csrno,
>          wr_mask |=3D SMSTATEEN0_FCSR;
>      }
>
> -    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrin=
d) {
> -        wr_mask |=3D SMSTATEEN0_SVSLCT;
> -    }
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> +        if (riscv_cpu_cfg(env)->ext_ssaia ||
> +            riscv_cpu_cfg(env)->ext_sscsrind) {
> +            wr_mask |=3D SMSTATEEN0_SVSLCT;
> +        }
>
> -    /*
> -     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if I=
MSIC is
> -     * implemented. However, that information is with MachineState and w=
e can't
> -     * figure that out in csr.c. Just enable if Ssaia is available.
> -     */
> -    if (riscv_cpu_cfg(env)->ext_ssaia) {
> -        wr_mask |=3D (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
> -    }
> +        /*
> +         * As per the AIA specification, SMSTATEEN0_IMSIC is valid
> +         * only if IMSIC is implemented. However, that information is
> +         * with MachineState and we can't figure that out in csr.c.
> +         * Just enable if Ssaia is available.
> +         */
> +        if (riscv_cpu_cfg(env)->ext_ssaia) {
> +            wr_mask |=3D (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
> +        }
>
> -    if (riscv_cpu_cfg(env)->ext_ssctr) {
> -        wr_mask |=3D SMSTATEEN0_CTR;
> +        if (riscv_cpu_cfg(env)->ext_ssctr) {
> +            wr_mask |=3D SMSTATEEN0_CTR;
> +        }
>      }
>
>      return write_hstateen(env, csrno, wr_mask, new_val);
> @@ -3608,6 +3643,20 @@ static RISCVException write_hstateen0h(CPURISCVSta=
te *env, int csrno,
>  {
>      uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
>
> +    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrin=
d) {
> +        wr_mask |=3D SMSTATEEN0_SVSLCT;
> +    }
> +
> +    /*
> +     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if
> +     * IMSIC is implemented. However, that information is with
> +     * MachineState and we can't figure that out in csr.c. Just enable
> +     * if Ssaia is available.
> +     */
> +    if (riscv_cpu_cfg(env)->ext_ssaia) {
> +        wr_mask |=3D (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
> +    }
> +
>      if (riscv_cpu_cfg(env)->ext_ssctr) {
>          wr_mask |=3D SMSTATEEN0_CTR;
>      }
> @@ -3657,7 +3706,7 @@ static RISCVException write_sstateen(CPURISCVState =
*env, int csrno,
>  static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
>                                        target_ulong new_val, uintptr_t ra=
)
>  {
> -    uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
> +    uint64_t wr_mask =3D 0;
>
>      if (!riscv_has_ext(env, RVF)) {
>          wr_mask |=3D SMSTATEEN0_FCSR;
> @@ -5937,25 +5986,25 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D =
{
>      /* Smstateen extension CSRs */
>      [CSR_MSTATEEN0] =3D { "mstateen0", mstateen, read_mstateen, write_ms=
tateen0,
>                          .min_priv_ver =3D PRIV_VERSION_1_12_0 },
> -    [CSR_MSTATEEN0H] =3D { "mstateen0h", mstateen, read_mstateenh,
> +    [CSR_MSTATEEN0H] =3D { "mstateen0h", mstateen_32, read_mstateenh,
>                            write_mstateen0h,
>                           .min_priv_ver =3D PRIV_VERSION_1_12_0 },
>      [CSR_MSTATEEN1] =3D { "mstateen1", mstateen, read_mstateen,
>                          write_mstateen_1_3,
>                          .min_priv_ver =3D PRIV_VERSION_1_12_0 },
> -    [CSR_MSTATEEN1H] =3D { "mstateen1h", mstateen, read_mstateenh,
> +    [CSR_MSTATEEN1H] =3D { "mstateen1h", mstateen_32, read_mstateenh,
>                           write_mstateenh_1_3,
>                           .min_priv_ver =3D PRIV_VERSION_1_12_0 },
>      [CSR_MSTATEEN2] =3D { "mstateen2", mstateen, read_mstateen,
>                          write_mstateen_1_3,
>                          .min_priv_ver =3D PRIV_VERSION_1_12_0 },
> -    [CSR_MSTATEEN2H] =3D { "mstateen2h", mstateen, read_mstateenh,
> +    [CSR_MSTATEEN2H] =3D { "mstateen2h", mstateen_32, read_mstateenh,
>                           write_mstateenh_1_3,
>                           .min_priv_ver =3D PRIV_VERSION_1_12_0 },
>      [CSR_MSTATEEN3] =3D { "mstateen3", mstateen, read_mstateen,
>                          write_mstateen_1_3,
>                          .min_priv_ver =3D PRIV_VERSION_1_12_0 },
> -    [CSR_MSTATEEN3H] =3D { "mstateen3h", mstateen, read_mstateenh,
> +    [CSR_MSTATEEN3H] =3D { "mstateen3h", mstateen_32, read_mstateenh,
>                           write_mstateenh_1_3,
>                           .min_priv_ver =3D PRIV_VERSION_1_12_0 },
>      [CSR_HSTATEEN0] =3D { "hstateen0", hstateen, read_hstateen, write_hs=
tateen0,
> --
> 2.43.0
> Rebased on riscv-to-apply.next as requested.
>
> Patch 1 was already applied, so this v2 resends only patch 2.
>
> Thanks,
> Bruno
>

