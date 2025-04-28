Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF3DC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 22:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9X3P-00067g-Ek; Mon, 28 Apr 2025 18:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9X3N-00066J-VH; Mon, 28 Apr 2025 18:34:21 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9X3C-0001HH-Sf; Mon, 28 Apr 2025 18:34:19 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-51eb18130f9so2660635e0c.3; 
 Mon, 28 Apr 2025 15:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745879646; x=1746484446; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yu6Xn0AwLYHU7042kU/H4kc6Be7cgugGbtAyLrZ/McY=;
 b=Yd4tpwRpl8762tTL3yQgbx+iixmDZI5xq6W0XvjnB7sIDl1xVyCkpjHuyVBB5Pu/5B
 oNifdu0jzaG+FmvIP0Nzv6oqhOLX3Jp/o0yH/taBT5BRg3riphDAFbqVpiB5sCENhfpF
 NO/l3MWiqO0UPiYpLFgZN7jNFU99TYQh6NOK8mfdCLtm0DuSffgwmwkQnezerYVdGVSs
 ri6thjfwaDeeVqpO2Z+fEdDnI2Ge47LouvRdEQo4XMwX90SkZXfK5pZyvpA2+nBSVs3l
 oZvMhcfcbHvdIdKBdc4WJ4qt/h9H3S1RsAsufeHMFF8D95Hm2T3k3I80n9AOZ0G+Au9A
 Vjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745879646; x=1746484446;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yu6Xn0AwLYHU7042kU/H4kc6Be7cgugGbtAyLrZ/McY=;
 b=CF95YFaO18lz22QEREf1VuzlNbhkNFzn+d2HR+9DU4GOoNjJPblkXleBQk28kevEut
 WGzVcHqkaf5NlxUfxSK344RLGaUNXwxsd+Fn2LxGt9n8fZ94ETaJFR3WY/rNuxV6v4Qv
 EO4uyPhagIEaHEWWa3bFTMjfc09NwGZbE5kurdAWoENizQvHJYctg88XtsGlIGGCFNJi
 PaRVec02m4kWKk22jsf1BBbjzZTd4HTcdBgXby1xJPRjdT23duEp+GbQBZC7rxH7qtnH
 dCQYqa2qWZgKII/oepvYGSPc7c0Kzon1346/iBwiJU0DZLm0IIo+J98hN5EBoqNsOBJz
 2R3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA6zyfJstA+/4irL7QYE9XHjl1125ddmdh1Cif7deXEVH7UtQmJfBpMJeQE7XpJlLC8yKvYvnNVqE0@nongnu.org
X-Gm-Message-State: AOJu0YyGFikNFYqZer0n6mzeHssBXTZRdYPFuL65ZLQ9P9rsNvS+6QHF
 5rRP5rLvNdiXpDNe7y8beSOX79RbBIRp/tVoB308WWM2IxF7TE/Qk8ZXCjYFTrIatSSDyBT7hlX
 4ofkTAeSKoxyVLcAZ9fztdPaE7E8=
X-Gm-Gg: ASbGncs4Yll/Gs1Acdcz+B8o8ra0WFNFKvMjT+E22R199re9rJMEPLUlMD8sSonw+nC
 uUuqLuSGx869KhFKIdWqfXXWnAOM2vMs5g3c3tDbupAM6/1pK+JTuolr5901q+mnAdXltGrkRci
 7/OtPY96WvHTbYYlXjuRshq3LOu28uBcApOwoc0kkljTmS1JJa5mRJ
X-Google-Smtp-Source: AGHT+IFK8ZdgYfE9Jn6Esw7KQyrxGKBpRjPvr7YM5lcfT6dNa24e7aN7Dwpy27Qd3IVPW74hZVzgxzHyHyXAVqSPnBE=
X-Received: by 2002:a05:6122:3198:b0:527:67c7:50f with SMTP id
 71dfb90a1353d-52abf3f6333mr856254e0c.11.1745879645518; Mon, 28 Apr 2025
 15:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250425152311.804338-1-richard.henderson@linaro.org>
 <20250425152311.804338-2-richard.henderson@linaro.org>
In-Reply-To: <20250425152311.804338-2-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Apr 2025 08:33:39 +1000
X-Gm-Features: ATxdqUGb9f5Q88ptMp6M1DcpvHf_Uuo_HdWnGGY5sLQ0rBbM0n3PoVmrRc-sdH0
Message-ID: <CAKmqyKOe4hWqcPSni9faHnOCptv-zT1Y0UPi8_N8AGOaHw5dBQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] target/riscv: Pass ra to riscv_csr_write_fn
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

On Sat, Apr 26, 2025 at 1:24=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h |   3 +-
>  target/riscv/csr.c | 226 +++++++++++++++++++++++----------------------
>  2 files changed, 118 insertions(+), 111 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 167909c89b..4d41a66d72 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -841,7 +841,8 @@ typedef RISCVException (*riscv_csr_predicate_fn)(CPUR=
ISCVState *env,
>  typedef RISCVException (*riscv_csr_read_fn)(CPURISCVState *env, int csrn=
o,
>                                              target_ulong *ret_value);
>  typedef RISCVException (*riscv_csr_write_fn)(CPURISCVState *env, int csr=
no,
> -                                             target_ulong new_value);
> +                                             target_ulong new_value,
> +                                             uintptr_t ra);
>  typedef RISCVException (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
>                                            target_ulong *ret_value,
>                                            target_ulong new_value,
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index c52c87faae..6f1f69eba6 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -830,13 +830,15 @@ static RISCVException seed(CPURISCVState *env, int =
csrno)
>  }
>
>  /* zicfiss CSR_SSP read and write */
> -static int read_ssp(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_ssp(CPURISCVState *env, int csrno,
> +                               target_ulong *val)
>  {
>      *val =3D env->ssp;
>      return RISCV_EXCP_NONE;
>  }
>
> -static int write_ssp(CPURISCVState *env, int csrno, target_ulong val)
> +static RISCVException write_ssp(CPURISCVState *env, int csrno,
> +                                target_ulong val, uintptr_t ra)
>  {
>      env->ssp =3D val;
>      return RISCV_EXCP_NONE;
> @@ -851,7 +853,7 @@ static RISCVException read_fflags(CPURISCVState *env,=
 int csrno,
>  }
>
>  static RISCVException write_fflags(CPURISCVState *env, int csrno,
> -                                   target_ulong val)
> +                                   target_ulong val, uintptr_t ra)
>  {
>  #if !defined(CONFIG_USER_ONLY)
>      if (riscv_has_ext(env, RVF)) {
> @@ -870,7 +872,7 @@ static RISCVException read_frm(CPURISCVState *env, in=
t csrno,
>  }
>
>  static RISCVException write_frm(CPURISCVState *env, int csrno,
> -                                target_ulong val)
> +                                target_ulong val, uintptr_t ra)
>  {
>  #if !defined(CONFIG_USER_ONLY)
>      if (riscv_has_ext(env, RVF)) {
> @@ -890,7 +892,7 @@ static RISCVException read_fcsr(CPURISCVState *env, i=
nt csrno,
>  }
>
>  static RISCVException write_fcsr(CPURISCVState *env, int csrno,
> -                                 target_ulong val)
> +                                 target_ulong val, uintptr_t ra)
>  {
>  #if !defined(CONFIG_USER_ONLY)
>      if (riscv_has_ext(env, RVF)) {
> @@ -942,7 +944,7 @@ static RISCVException read_vxrm(CPURISCVState *env, i=
nt csrno,
>  }
>
>  static RISCVException write_vxrm(CPURISCVState *env, int csrno,
> -                                 target_ulong val)
> +                                 target_ulong val, uintptr_t ra)
>  {
>  #if !defined(CONFIG_USER_ONLY)
>      env->mstatus |=3D MSTATUS_VS;
> @@ -959,7 +961,7 @@ static RISCVException read_vxsat(CPURISCVState *env, =
int csrno,
>  }
>
>  static RISCVException write_vxsat(CPURISCVState *env, int csrno,
> -                                  target_ulong val)
> +                                  target_ulong val, uintptr_t ra)
>  {
>  #if !defined(CONFIG_USER_ONLY)
>      env->mstatus |=3D MSTATUS_VS;
> @@ -976,7 +978,7 @@ static RISCVException read_vstart(CPURISCVState *env,=
 int csrno,
>  }
>
>  static RISCVException write_vstart(CPURISCVState *env, int csrno,
> -                                   target_ulong val)
> +                                   target_ulong val, uintptr_t ra)
>  {
>  #if !defined(CONFIG_USER_ONLY)
>      env->mstatus |=3D MSTATUS_VS;
> @@ -997,7 +999,7 @@ static RISCVException read_vcsr(CPURISCVState *env, i=
nt csrno,
>  }
>
>  static RISCVException write_vcsr(CPURISCVState *env, int csrno,
> -                                 target_ulong val)
> +                                 target_ulong val, uintptr_t ra)
>  {
>  #if !defined(CONFIG_USER_ONLY)
>      env->mstatus |=3D MSTATUS_VS;
> @@ -1055,7 +1057,7 @@ static RISCVException read_mcyclecfg(CPURISCVState =
*env, int csrno,
>  }
>
>  static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
> -                                      target_ulong val)
> +                                      target_ulong val, uintptr_t ra)
>  {
>      uint64_t inh_avail_mask;
>
> @@ -1084,7 +1086,7 @@ static RISCVException read_mcyclecfgh(CPURISCVState=
 *env, int csrno,
>  }
>
>  static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
> -                                       target_ulong val)
> +                                       target_ulong val, uintptr_t ra)
>  {
>      target_ulong inh_avail_mask =3D (target_ulong)(~MHPMEVENTH_FILTER_MA=
SK |
>                                                   MCYCLECFGH_BIT_MINH);
> @@ -1109,7 +1111,7 @@ static RISCVException read_minstretcfg(CPURISCVStat=
e *env, int csrno,
>  }
>
>  static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
> -                                        target_ulong val)
> +                                        target_ulong val, uintptr_t ra)
>  {
>      uint64_t inh_avail_mask;
>
> @@ -1136,7 +1138,7 @@ static RISCVException read_minstretcfgh(CPURISCVSta=
te *env, int csrno,
>  }
>
>  static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
> -                                         target_ulong val)
> +                                         target_ulong val, uintptr_t ra)
>  {
>      target_ulong inh_avail_mask =3D (target_ulong)(~MHPMEVENTH_FILTER_MA=
SK |
>                                                   MINSTRETCFGH_BIT_MINH);
> @@ -1163,7 +1165,7 @@ static RISCVException read_mhpmevent(CPURISCVState =
*env, int csrno,
>  }
>
>  static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
> -                                      target_ulong val)
> +                                      target_ulong val, uintptr_t ra)
>  {
>      int evt_index =3D csrno - CSR_MCOUNTINHIBIT;
>      uint64_t mhpmevt_val =3D val;
> @@ -1201,7 +1203,7 @@ static RISCVException read_mhpmeventh(CPURISCVState=
 *env, int csrno,
>  }
>
>  static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
> -                                       target_ulong val)
> +                                       target_ulong val, uintptr_t ra)
>  {
>      int evt_index =3D csrno - CSR_MHPMEVENT3H + 3;
>      uint64_t mhpmevth_val;
> @@ -1343,14 +1345,16 @@ static RISCVException riscv_pmu_write_ctrh(CPURIS=
CVState *env, target_ulong val,
>      return RISCV_EXCP_NONE;
>  }
>
> -static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong=
 val)
> +static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
> +                                        target_ulong val, uintptr_t ra)
>  {
>      int ctr_idx =3D csrno - CSR_MCYCLE;
>
>      return riscv_pmu_write_ctr(env, val, ctr_idx);
>  }
>
> -static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ulon=
g val)
> +static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
> +                                         target_ulong val, uintptr_t ra)
>  {
>      int ctr_idx =3D csrno - CSR_MCYCLEH;
>
> @@ -1661,7 +1665,7 @@ static RISCVException read_vstimecmph(CPURISCVState=
 *env, int csrno,
>  }
>
>  static RISCVException write_vstimecmp(CPURISCVState *env, int csrno,
> -                                      target_ulong val)
> +                                      target_ulong val, uintptr_t ra)
>  {
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
>          env->vstimecmp =3D deposit64(env->vstimecmp, 0, 32, (uint64_t)va=
l);
> @@ -1676,7 +1680,7 @@ static RISCVException write_vstimecmp(CPURISCVState=
 *env, int csrno,
>  }
>
>  static RISCVException write_vstimecmph(CPURISCVState *env, int csrno,
> -                                       target_ulong val)
> +                                       target_ulong val, uintptr_t ra)
>  {
>      env->vstimecmp =3D deposit64(env->vstimecmp, 32, 32, (uint64_t)val);
>      riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
> @@ -1710,13 +1714,13 @@ static RISCVException read_stimecmph(CPURISCVStat=
e *env, int csrno,
>  }
>
>  static RISCVException write_stimecmp(CPURISCVState *env, int csrno,
> -                                     target_ulong val)
> +                                     target_ulong val, uintptr_t ra)
>  {
>      if (env->virt_enabled) {
>          if (env->hvictl & HVICTL_VTI) {
>              return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>          }
> -        return write_vstimecmp(env, csrno, val);
> +        return write_vstimecmp(env, csrno, val, ra);
>      }
>
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> @@ -1731,13 +1735,13 @@ static RISCVException write_stimecmp(CPURISCVStat=
e *env, int csrno,
>  }
>
>  static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
> -                                      target_ulong val)
> +                                      target_ulong val, uintptr_t ra)
>  {
>      if (env->virt_enabled) {
>          if (env->hvictl & HVICTL_VTI) {
>              return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>          }
> -        return write_vstimecmph(env, csrno, val);
> +        return write_vstimecmph(env, csrno, val, ra);
>      }
>
>      env->stimecmp =3D deposit64(env->stimecmp, 32, 32, (uint64_t)val);
> @@ -1842,7 +1846,7 @@ static RISCVException read_zero(CPURISCVState *env,=
 int csrno,
>  }
>
>  static RISCVException write_ignore(CPURISCVState *env, int csrno,
> -                                   target_ulong val)
> +                                   target_ulong val, uintptr_t ra)
>  {
>      return RISCV_EXCP_NONE;
>  }
> @@ -1963,7 +1967,7 @@ static target_ulong legalize_mpp(CPURISCVState *env=
, target_ulong old_mpp,
>  }
>
>  static RISCVException write_mstatus(CPURISCVState *env, int csrno,
> -                                    target_ulong val)
> +                                    target_ulong val, uintptr_t ra)
>  {
>      uint64_t mstatus =3D env->mstatus;
>      uint64_t mask =3D 0;
> @@ -2042,7 +2046,7 @@ static RISCVException read_mstatush(CPURISCVState *=
env, int csrno,
>  }
>
>  static RISCVException write_mstatush(CPURISCVState *env, int csrno,
> -                                     target_ulong val)
> +                                     target_ulong val, uintptr_t ra)
>  {
>      uint64_t valh =3D (uint64_t)val << 32;
>      uint64_t mask =3D riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GV=
A : 0;
> @@ -2096,7 +2100,7 @@ static RISCVException read_misa(CPURISCVState *env,=
 int csrno,
>  }
>
>  static RISCVException write_misa(CPURISCVState *env, int csrno,
> -                                 target_ulong val)
> +                                 target_ulong val, uintptr_t ra)
>  {
>      RISCVCPU *cpu =3D env_archcpu(env);
>      uint32_t orig_misa_ext =3D env->misa_ext;
> @@ -2160,7 +2164,7 @@ static RISCVException read_medeleg(CPURISCVState *e=
nv, int csrno,
>  }
>
>  static RISCVException write_medeleg(CPURISCVState *env, int csrno,
> -                                    target_ulong val)
> +                                    target_ulong val, uintptr_t ra)
>  {
>      env->medeleg =3D (env->medeleg & ~DELEGABLE_EXCPS) | (val & DELEGABL=
E_EXCPS);
>      return RISCV_EXCP_NONE;
> @@ -2955,7 +2959,7 @@ static RISCVException read_mtvec(CPURISCVState *env=
, int csrno,
>  }
>
>  static RISCVException write_mtvec(CPURISCVState *env, int csrno,
> -                                  target_ulong val)
> +                                  target_ulong val, uintptr_t ra)
>  {
>      /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D rese=
rved */
>      if ((val & 3) < 2) {
> @@ -2974,7 +2978,7 @@ static RISCVException read_mcountinhibit(CPURISCVSt=
ate *env, int csrno,
>  }
>
>  static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
> -                                          target_ulong val)
> +                                          target_ulong val, uintptr_t ra=
)
>  {
>      int cidx;
>      PMUCTRState *counter;
> @@ -3049,10 +3053,9 @@ static RISCVException read_scountinhibit(CPURISCVS=
tate *env, int csrno,
>  }
>
>  static RISCVException write_scountinhibit(CPURISCVState *env, int csrno,
> -                                          target_ulong val)
> +                                          target_ulong val, uintptr_t ra=
)
>  {
> -    write_mcountinhibit(env, csrno, val & env->mcounteren);
> -    return RISCV_EXCP_NONE;
> +    return write_mcountinhibit(env, csrno, val & env->mcounteren, ra);
>  }
>
>  static RISCVException read_mcounteren(CPURISCVState *env, int csrno,
> @@ -3063,7 +3066,7 @@ static RISCVException read_mcounteren(CPURISCVState=
 *env, int csrno,
>  }
>
>  static RISCVException write_mcounteren(CPURISCVState *env, int csrno,
> -                                       target_ulong val)
> +                                       target_ulong val, uintptr_t ra)
>  {
>      RISCVCPU *cpu =3D env_archcpu(env);
>
> @@ -3097,7 +3100,7 @@ static RISCVException read_mscratch(CPURISCVState *=
env, int csrno,
>  }
>
>  static RISCVException write_mscratch(CPURISCVState *env, int csrno,
> -                                     target_ulong val)
> +                                     target_ulong val, uintptr_t ra)
>  {
>      env->mscratch =3D val;
>      return RISCV_EXCP_NONE;
> @@ -3111,7 +3114,7 @@ static RISCVException read_mepc(CPURISCVState *env,=
 int csrno,
>  }
>
>  static RISCVException write_mepc(CPURISCVState *env, int csrno,
> -                                 target_ulong val)
> +                                 target_ulong val, uintptr_t ra)
>  {
>      env->mepc =3D val;
>      return RISCV_EXCP_NONE;
> @@ -3125,7 +3128,7 @@ static RISCVException read_mcause(CPURISCVState *en=
v, int csrno,
>  }
>
>  static RISCVException write_mcause(CPURISCVState *env, int csrno,
> -                                   target_ulong val)
> +                                   target_ulong val, uintptr_t ra)
>  {
>      env->mcause =3D val;
>      return RISCV_EXCP_NONE;
> @@ -3139,7 +3142,7 @@ static RISCVException read_mtval(CPURISCVState *env=
, int csrno,
>  }
>
>  static RISCVException write_mtval(CPURISCVState *env, int csrno,
> -                                  target_ulong val)
> +                                  target_ulong val, uintptr_t ra)
>  {
>      env->mtval =3D val;
>      return RISCV_EXCP_NONE;
> @@ -3154,9 +3157,9 @@ static RISCVException read_menvcfg(CPURISCVState *e=
nv, int csrno,
>  }
>
>  static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
> -                                    target_ulong val);
> +                                    target_ulong val, uintptr_t ra);
>  static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
> -                                    target_ulong val)
> +                                    target_ulong val, uintptr_t ra)
>  {
>      const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
>      uint64_t mask =3D MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
> @@ -3188,9 +3191,7 @@ static RISCVException write_menvcfg(CPURISCVState *=
env, int csrno,
>          }
>      }
>      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
> -    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
> -
> -    return RISCV_EXCP_NONE;
> +    return write_henvcfg(env, CSR_HENVCFG, env->henvcfg, ra);
>  }
>
>  static RISCVException read_menvcfgh(CPURISCVState *env, int csrno,
> @@ -3201,9 +3202,9 @@ static RISCVException read_menvcfgh(CPURISCVState *=
env, int csrno,
>  }
>
>  static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
> -                                    target_ulong val);
> +                                     target_ulong val, uintptr_t ra);
>  static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
> -                                     target_ulong val)
> +                                     target_ulong val, uintptr_t ra)
>  {
>      const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
>      uint64_t mask =3D (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
> @@ -3218,9 +3219,7 @@ static RISCVException write_menvcfgh(CPURISCVState =
*env, int csrno,
>      }
>
>      env->menvcfg =3D (env->menvcfg & ~mask) | (valh & mask);
> -    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
> -
> -    return RISCV_EXCP_NONE;
> +    return write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32, ra);
>  }
>
>  static RISCVException read_senvcfg(CPURISCVState *env, int csrno,
> @@ -3238,7 +3237,7 @@ static RISCVException read_senvcfg(CPURISCVState *e=
nv, int csrno,
>  }
>
>  static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
> -                                    target_ulong val)
> +                                    target_ulong val, uintptr_t ra)
>  {
>      uint64_t mask =3D SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE | SENV=
CFG_CBZE;
>      RISCVException ret;
> @@ -3295,7 +3294,7 @@ static RISCVException read_henvcfg(CPURISCVState *e=
nv, int csrno,
>  }
>
>  static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
> -                                    target_ulong val)
> +                                    target_ulong val, uintptr_t ra)
>  {
>      uint64_t mask =3D HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENV=
CFG_CBZE;
>      RISCVException ret;
> @@ -3350,7 +3349,7 @@ static RISCVException read_henvcfgh(CPURISCVState *=
env, int csrno,
>  }
>
>  static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
> -                                     target_ulong val)
> +                                     target_ulong val, uintptr_t ra)
>  {
>      uint64_t mask =3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
>                                      HENVCFG_ADUE | HENVCFG_DTE);
> @@ -3388,7 +3387,7 @@ static RISCVException write_mstateen(CPURISCVState =
*env, int csrno,
>  }
>
>  static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
> -                                      target_ulong new_val)
> +                                      target_ulong new_val, uintptr_t ra=
)
>  {
>      uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
>      if (!riscv_has_ext(env, RVF)) {
> @@ -3420,7 +3419,7 @@ static RISCVException write_mstateen0(CPURISCVState=
 *env, int csrno,
>  }
>
>  static RISCVException write_mstateen_1_3(CPURISCVState *env, int csrno,
> -                                         target_ulong new_val)
> +                                         target_ulong new_val, uintptr_t=
 ra)
>  {
>      return write_mstateen(env, csrno, SMSTATEEN_STATEEN, new_val);
>  }
> @@ -3447,7 +3446,7 @@ static RISCVException write_mstateenh(CPURISCVState=
 *env, int csrno,
>  }
>
>  static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
> -                                       target_ulong new_val)
> +                                       target_ulong new_val, uintptr_t r=
a)
>  {
>      uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
>
> @@ -3463,7 +3462,7 @@ static RISCVException write_mstateen0h(CPURISCVStat=
e *env, int csrno,
>  }
>
>  static RISCVException write_mstateenh_1_3(CPURISCVState *env, int csrno,
> -                                          target_ulong new_val)
> +                                          target_ulong new_val, uintptr_=
t ra)
>  {
>      return write_mstateenh(env, csrno, SMSTATEEN_STATEEN, new_val);
>  }
> @@ -3492,7 +3491,7 @@ static RISCVException write_hstateen(CPURISCVState =
*env, int csrno,
>  }
>
>  static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
> -                                      target_ulong new_val)
> +                                      target_ulong new_val, uintptr_t ra=
)
>  {
>      uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
>
> @@ -3521,7 +3520,7 @@ static RISCVException write_hstateen0(CPURISCVState=
 *env, int csrno,
>  }
>
>  static RISCVException write_hstateen_1_3(CPURISCVState *env, int csrno,
> -                                         target_ulong new_val)
> +                                         target_ulong new_val, uintptr_t=
 ra)
>  {
>      return write_hstateen(env, csrno, SMSTATEEN_STATEEN, new_val);
>  }
> @@ -3552,7 +3551,7 @@ static RISCVException write_hstateenh(CPURISCVState=
 *env, int csrno,
>  }
>
>  static RISCVException write_hstateen0h(CPURISCVState *env, int csrno,
> -                                       target_ulong new_val)
> +                                       target_ulong new_val, uintptr_t r=
a)
>  {
>      uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
>
> @@ -3564,7 +3563,7 @@ static RISCVException write_hstateen0h(CPURISCVStat=
e *env, int csrno,
>  }
>
>  static RISCVException write_hstateenh_1_3(CPURISCVState *env, int csrno,
> -                                          target_ulong new_val)
> +                                          target_ulong new_val, uintptr_=
t ra)
>  {
>      return write_hstateenh(env, csrno, SMSTATEEN_STATEEN, new_val);
>  }
> @@ -3603,7 +3602,7 @@ static RISCVException write_sstateen(CPURISCVState =
*env, int csrno,
>  }
>
>  static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
> -                                      target_ulong new_val)
> +                                      target_ulong new_val, uintptr_t ra=
)
>  {
>      uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
>
> @@ -3615,7 +3614,7 @@ static RISCVException write_sstateen0(CPURISCVState=
 *env, int csrno,
>  }
>
>  static RISCVException write_sstateen_1_3(CPURISCVState *env, int csrno,
> -                                      target_ulong new_val)
> +                                         target_ulong new_val, uintptr_t=
 ra)
>  {
>      return write_sstateen(env, csrno, SMSTATEEN_STATEEN, new_val);
>  }
> @@ -3866,7 +3865,7 @@ static RISCVException read_sstatus(CPURISCVState *e=
nv, int csrno,
>  }
>
>  static RISCVException write_sstatus(CPURISCVState *env, int csrno,
> -                                    target_ulong val)
> +                                    target_ulong val, uintptr_t ra)
>  {
>      target_ulong mask =3D (sstatus_v1_10_mask);
>
> @@ -3883,7 +3882,7 @@ static RISCVException write_sstatus(CPURISCVState *=
env, int csrno,
>          mask |=3D SSTATUS_SDT;
>      }
>      target_ulong newval =3D (env->mstatus & ~mask) | (val & mask);
> -    return write_mstatus(env, CSR_MSTATUS, newval);
> +    return write_mstatus(env, CSR_MSTATUS, newval, ra);
>  }
>
>  static RISCVException rmw_vsie64(CPURISCVState *env, int csrno,
> @@ -4035,7 +4034,7 @@ static RISCVException read_stvec(CPURISCVState *env=
, int csrno,
>  }
>
>  static RISCVException write_stvec(CPURISCVState *env, int csrno,
> -                                  target_ulong val)
> +                                  target_ulong val, uintptr_t ra)
>  {
>      /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D rese=
rved */
>      if ((val & 3) < 2) {
> @@ -4054,7 +4053,7 @@ static RISCVException read_scounteren(CPURISCVState=
 *env, int csrno,
>  }
>
>  static RISCVException write_scounteren(CPURISCVState *env, int csrno,
> -                                       target_ulong val)
> +                                       target_ulong val, uintptr_t ra)
>  {
>      RISCVCPU *cpu =3D env_archcpu(env);
>
> @@ -4088,7 +4087,7 @@ static RISCVException read_sscratch(CPURISCVState *=
env, int csrno,
>  }
>
>  static RISCVException write_sscratch(CPURISCVState *env, int csrno,
> -                                     target_ulong val)
> +                                     target_ulong val, uintptr_t ra)
>  {
>      env->sscratch =3D val;
>      return RISCV_EXCP_NONE;
> @@ -4102,7 +4101,7 @@ static RISCVException read_sepc(CPURISCVState *env,=
 int csrno,
>  }
>
>  static RISCVException write_sepc(CPURISCVState *env, int csrno,
> -                                 target_ulong val)
> +                                 target_ulong val, uintptr_t ra)
>  {
>      env->sepc =3D val;
>      return RISCV_EXCP_NONE;
> @@ -4116,7 +4115,7 @@ static RISCVException read_scause(CPURISCVState *en=
v, int csrno,
>  }
>
>  static RISCVException write_scause(CPURISCVState *env, int csrno,
> -                                   target_ulong val)
> +                                   target_ulong val, uintptr_t ra)
>  {
>      env->scause =3D val;
>      return RISCV_EXCP_NONE;
> @@ -4130,7 +4129,7 @@ static RISCVException read_stval(CPURISCVState *env=
, int csrno,
>  }
>
>  static RISCVException write_stval(CPURISCVState *env, int csrno,
> -                                  target_ulong val)
> +                                  target_ulong val, uintptr_t ra)
>  {
>      env->stval =3D val;
>      return RISCV_EXCP_NONE;
> @@ -4270,7 +4269,7 @@ static RISCVException read_satp(CPURISCVState *env,=
 int csrno,
>  }
>
>  static RISCVException write_satp(CPURISCVState *env, int csrno,
> -                                 target_ulong val)
> +                                 target_ulong val, uintptr_t ra)
>  {
>      if (!riscv_cpu_cfg(env)->mmu) {
>          return RISCV_EXCP_NONE;
> @@ -4492,7 +4491,7 @@ static RISCVException read_hstatus(CPURISCVState *e=
nv, int csrno,
>  }
>
>  static RISCVException write_hstatus(CPURISCVState *env, int csrno,
> -                                    target_ulong val)
> +                                    target_ulong val, uintptr_t ra)
>  {
>      uint64_t mask =3D (target_ulong)-1;
>      if (!env_archcpu(env)->cfg.ext_svukte) {
> @@ -4524,7 +4523,7 @@ static RISCVException read_hedeleg(CPURISCVState *e=
nv, int csrno,
>  }
>
>  static RISCVException write_hedeleg(CPURISCVState *env, int csrno,
> -                                    target_ulong val)
> +                                    target_ulong val, uintptr_t ra)
>  {
>      env->hedeleg =3D val & vs_delegable_excps;
>      return RISCV_EXCP_NONE;
> @@ -4545,7 +4544,7 @@ static RISCVException read_hedelegh(CPURISCVState *=
env, int csrno,
>  }
>
>  static RISCVException write_hedelegh(CPURISCVState *env, int csrno,
> -                                    target_ulong val)
> +                                     target_ulong val, uintptr_t ra)
>  {
>      RISCVException ret;
>      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
> @@ -4808,7 +4807,7 @@ static RISCVException read_hcounteren(CPURISCVState=
 *env, int csrno,
>  }
>
>  static RISCVException write_hcounteren(CPURISCVState *env, int csrno,
> -                                       target_ulong val)
> +                                       target_ulong val, uintptr_t ra)
>  {
>      RISCVCPU *cpu =3D env_archcpu(env);
>
> @@ -4828,7 +4827,7 @@ static RISCVException read_hgeie(CPURISCVState *env=
, int csrno,
>  }
>
>  static RISCVException write_hgeie(CPURISCVState *env, int csrno,
> -                                  target_ulong val)
> +                                  target_ulong val, uintptr_t ra)
>  {
>      /* Only GEILEN:1 bits implemented and BIT0 is never implemented */
>      val &=3D ((((target_ulong)1) << env->geilen) - 1) << 1;
> @@ -4847,7 +4846,7 @@ static RISCVException read_htval(CPURISCVState *env=
, int csrno,
>  }
>
>  static RISCVException write_htval(CPURISCVState *env, int csrno,
> -                                  target_ulong val)
> +                                  target_ulong val, uintptr_t ra)
>  {
>      env->htval =3D val;
>      return RISCV_EXCP_NONE;
> @@ -4861,7 +4860,7 @@ static RISCVException read_htinst(CPURISCVState *en=
v, int csrno,
>  }
>
>  static RISCVException write_htinst(CPURISCVState *env, int csrno,
> -                                   target_ulong val)
> +                                   target_ulong val, uintptr_t ra)
>  {
>      return RISCV_EXCP_NONE;
>  }
> @@ -4883,7 +4882,7 @@ static RISCVException read_hgatp(CPURISCVState *env=
, int csrno,
>  }
>
>  static RISCVException write_hgatp(CPURISCVState *env, int csrno,
> -                                  target_ulong val)
> +                                  target_ulong val, uintptr_t ra)
>  {
>      env->hgatp =3D legalize_xatp(env, env->hgatp, val);
>      return RISCV_EXCP_NONE;
> @@ -4901,7 +4900,7 @@ static RISCVException read_htimedelta(CPURISCVState=
 *env, int csrno,
>  }
>
>  static RISCVException write_htimedelta(CPURISCVState *env, int csrno,
> -                                       target_ulong val)
> +                                       target_ulong val, uintptr_t ra)
>  {
>      if (!env->rdtime_fn) {
>          return RISCV_EXCP_ILLEGAL_INST;
> @@ -4933,7 +4932,7 @@ static RISCVException read_htimedeltah(CPURISCVStat=
e *env, int csrno,
>  }
>
>  static RISCVException write_htimedeltah(CPURISCVState *env, int csrno,
> -                                        target_ulong val)
> +                                        target_ulong val, uintptr_t ra)
>  {
>      if (!env->rdtime_fn) {
>          return RISCV_EXCP_ILLEGAL_INST;
> @@ -4957,7 +4956,7 @@ static RISCVException read_hvictl(CPURISCVState *en=
v, int csrno,
>  }
>
>  static RISCVException write_hvictl(CPURISCVState *env, int csrno,
> -                                   target_ulong val)
> +                                   target_ulong val, uintptr_t ra)
>  {
>      env->hvictl =3D val & HVICTL_VALID_MASK;
>      return RISCV_EXCP_NONE;
> @@ -5022,7 +5021,7 @@ static RISCVException read_hviprio1(CPURISCVState *=
env, int csrno,
>  }
>
>  static RISCVException write_hviprio1(CPURISCVState *env, int csrno,
> -                                     target_ulong val)
> +                                     target_ulong val, uintptr_t ra)
>  {
>      return write_hvipriox(env, 0, env->hviprio, val);
>  }
> @@ -5034,7 +5033,7 @@ static RISCVException read_hviprio1h(CPURISCVState =
*env, int csrno,
>  }
>
>  static RISCVException write_hviprio1h(CPURISCVState *env, int csrno,
> -                                      target_ulong val)
> +                                      target_ulong val, uintptr_t ra)
>  {
>      return write_hvipriox(env, 4, env->hviprio, val);
>  }
> @@ -5046,7 +5045,7 @@ static RISCVException read_hviprio2(CPURISCVState *=
env, int csrno,
>  }
>
>  static RISCVException write_hviprio2(CPURISCVState *env, int csrno,
> -                                     target_ulong val)
> +                                     target_ulong val, uintptr_t ra)
>  {
>      return write_hvipriox(env, 8, env->hviprio, val);
>  }
> @@ -5058,7 +5057,7 @@ static RISCVException read_hviprio2h(CPURISCVState =
*env, int csrno,
>  }
>
>  static RISCVException write_hviprio2h(CPURISCVState *env, int csrno,
> -                                      target_ulong val)
> +                                      target_ulong val, uintptr_t ra)
>  {
>      return write_hvipriox(env, 12, env->hviprio, val);
>  }
> @@ -5072,7 +5071,7 @@ static RISCVException read_vsstatus(CPURISCVState *=
env, int csrno,
>  }
>
>  static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
> -                                     target_ulong val)
> +                                     target_ulong val, uintptr_t ra)
>  {
>      uint64_t mask =3D (target_ulong)-1;
>      if ((val & VSSTATUS64_UXL) =3D=3D 0) {
> @@ -5097,7 +5096,7 @@ static RISCVException read_vstvec(CPURISCVState *en=
v, int csrno,
>  }
>
>  static RISCVException write_vstvec(CPURISCVState *env, int csrno,
> -                                   target_ulong val)
> +                                   target_ulong val, uintptr_t ra)
>  {
>      /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D rese=
rved */
>      if ((val & 3) < 2) {
> @@ -5116,7 +5115,7 @@ static RISCVException read_vsscratch(CPURISCVState =
*env, int csrno,
>  }
>
>  static RISCVException write_vsscratch(CPURISCVState *env, int csrno,
> -                                      target_ulong val)
> +                                      target_ulong val, uintptr_t ra)
>  {
>      env->vsscratch =3D val;
>      return RISCV_EXCP_NONE;
> @@ -5130,7 +5129,7 @@ static RISCVException read_vsepc(CPURISCVState *env=
, int csrno,
>  }
>
>  static RISCVException write_vsepc(CPURISCVState *env, int csrno,
> -                                  target_ulong val)
> +                                  target_ulong val, uintptr_t ra)
>  {
>      env->vsepc =3D val;
>      return RISCV_EXCP_NONE;
> @@ -5144,7 +5143,7 @@ static RISCVException read_vscause(CPURISCVState *e=
nv, int csrno,
>  }
>
>  static RISCVException write_vscause(CPURISCVState *env, int csrno,
> -                                    target_ulong val)
> +                                    target_ulong val, uintptr_t ra)
>  {
>      env->vscause =3D val;
>      return RISCV_EXCP_NONE;
> @@ -5158,7 +5157,7 @@ static RISCVException read_vstval(CPURISCVState *en=
v, int csrno,
>  }
>
>  static RISCVException write_vstval(CPURISCVState *env, int csrno,
> -                                   target_ulong val)
> +                                   target_ulong val, uintptr_t ra)
>  {
>      env->vstval =3D val;
>      return RISCV_EXCP_NONE;
> @@ -5172,7 +5171,7 @@ static RISCVException read_vsatp(CPURISCVState *env=
, int csrno,
>  }
>
>  static RISCVException write_vsatp(CPURISCVState *env, int csrno,
> -                                  target_ulong val)
> +                                  target_ulong val, uintptr_t ra)
>  {
>      env->vsatp =3D legalize_xatp(env, env->vsatp, val);
>      return RISCV_EXCP_NONE;
> @@ -5186,7 +5185,7 @@ static RISCVException read_mtval2(CPURISCVState *en=
v, int csrno,
>  }
>
>  static RISCVException write_mtval2(CPURISCVState *env, int csrno,
> -                                   target_ulong val)
> +                                   target_ulong val, uintptr_t ra)
>  {
>      env->mtval2 =3D val;
>      return RISCV_EXCP_NONE;
> @@ -5200,7 +5199,7 @@ static RISCVException read_mtinst(CPURISCVState *en=
v, int csrno,
>  }
>
>  static RISCVException write_mtinst(CPURISCVState *env, int csrno,
> -                                   target_ulong val)
> +                                   target_ulong val, uintptr_t ra)
>  {
>      env->mtinst =3D val;
>      return RISCV_EXCP_NONE;
> @@ -5215,7 +5214,7 @@ static RISCVException read_mseccfg(CPURISCVState *e=
nv, int csrno,
>  }
>
>  static RISCVException write_mseccfg(CPURISCVState *env, int csrno,
> -                                    target_ulong val)
> +                                    target_ulong val, uintptr_t ra)
>  {
>      mseccfg_csr_write(env, val);
>      return RISCV_EXCP_NONE;
> @@ -5231,7 +5230,7 @@ static RISCVException read_pmpcfg(CPURISCVState *en=
v, int csrno,
>  }
>
>  static RISCVException write_pmpcfg(CPURISCVState *env, int csrno,
> -                                   target_ulong val)
> +                                   target_ulong val, uintptr_t ra)
>  {
>      uint32_t reg_index =3D csrno - CSR_PMPCFG0;
>
> @@ -5247,7 +5246,7 @@ static RISCVException read_pmpaddr(CPURISCVState *e=
nv, int csrno,
>  }
>
>  static RISCVException write_pmpaddr(CPURISCVState *env, int csrno,
> -                                    target_ulong val)
> +                                    target_ulong val, uintptr_t ra)
>  {
>      pmpaddr_csr_write(env, csrno - CSR_PMPADDR0, val);
>      return RISCV_EXCP_NONE;
> @@ -5261,7 +5260,7 @@ static RISCVException read_tselect(CPURISCVState *e=
nv, int csrno,
>  }
>
>  static RISCVException write_tselect(CPURISCVState *env, int csrno,
> -                                    target_ulong val)
> +                                    target_ulong val, uintptr_t ra)
>  {
>      tselect_csr_write(env, val);
>      return RISCV_EXCP_NONE;
> @@ -5285,7 +5284,7 @@ static RISCVException read_tdata(CPURISCVState *env=
, int csrno,
>  }
>
>  static RISCVException write_tdata(CPURISCVState *env, int csrno,
> -                                  target_ulong val)
> +                                  target_ulong val, uintptr_t ra)
>  {
>      if (!tdata_available(env, csrno - CSR_TDATA1)) {
>          return RISCV_EXCP_ILLEGAL_INST;
> @@ -5310,7 +5309,7 @@ static RISCVException read_mcontext(CPURISCVState *=
env, int csrno,
>  }
>
>  static RISCVException write_mcontext(CPURISCVState *env, int csrno,
> -                                     target_ulong val)
> +                                     target_ulong val, uintptr_t ra)
>  {
>      bool rv32 =3D riscv_cpu_mxl(env) =3D=3D MXL_RV32 ? true : false;
>      int32_t mask;
> @@ -5334,43 +5333,50 @@ static RISCVException read_mnscratch(CPURISCVStat=
e *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> -static int write_mnscratch(CPURISCVState *env, int csrno, target_ulong v=
al)
> +static RISCVException write_mnscratch(CPURISCVState *env, int csrno,
> +                                      target_ulong val, uintptr_t ra)
>  {
>      env->mnscratch =3D val;
>      return RISCV_EXCP_NONE;
>  }
>
> -static int read_mnepc(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_mnepc(CPURISCVState *env, int csrno,
> +                                 target_ulong *val)
>  {
>      *val =3D env->mnepc;
>      return RISCV_EXCP_NONE;
>  }
>
> -static int write_mnepc(CPURISCVState *env, int csrno, target_ulong val)
> +static RISCVException write_mnepc(CPURISCVState *env, int csrno,
> +                                  target_ulong val, uintptr_t ra)
>  {
>      env->mnepc =3D val;
>      return RISCV_EXCP_NONE;
>  }
>
> -static int read_mncause(CPURISCVState *env, int csrno, target_ulong *val=
)
> +static RISCVException read_mncause(CPURISCVState *env, int csrno,
> +                                   target_ulong *val)
>  {
>      *val =3D env->mncause;
>      return RISCV_EXCP_NONE;
>  }
>
> -static int write_mncause(CPURISCVState *env, int csrno, target_ulong val=
)
> +static RISCVException write_mncause(CPURISCVState *env, int csrno,
> +                                    target_ulong val, uintptr_t ra)
>  {
>      env->mncause =3D val;
>      return RISCV_EXCP_NONE;
>  }
>
> -static int read_mnstatus(CPURISCVState *env, int csrno, target_ulong *va=
l)
> +static RISCVException read_mnstatus(CPURISCVState *env, int csrno,
> +                                    target_ulong *val)
>  {
>      *val =3D env->mnstatus;
>      return RISCV_EXCP_NONE;
>  }
>
> -static int write_mnstatus(CPURISCVState *env, int csrno, target_ulong va=
l)
> +static RISCVException write_mnstatus(CPURISCVState *env, int csrno,
> +                                     target_ulong val, uintptr_t ra)
>  {
>      target_ulong mask =3D (MNSTATUS_NMIE | MNSTATUS_MNPP);
>
> @@ -5540,7 +5546,7 @@ static RISCVException riscv_csrrw_do64(CPURISCVStat=
e *env, int csrno,
>      if (write_mask) {
>          new_value =3D (old_value & ~write_mask) | (new_value & write_mas=
k);
>          if (csr_ops[csrno].write) {
> -            ret =3D csr_ops[csrno].write(env, csrno, new_value);
> +            ret =3D csr_ops[csrno].write(env, csrno, new_value, 0);
>              if (ret !=3D RISCV_EXCP_NONE) {
>                  return ret;
>              }
> @@ -5603,7 +5609,7 @@ static RISCVException riscv_csrrw_do128(CPURISCVSta=
te *env, int csrno,
>              }
>          } else if (csr_ops[csrno].write) {
>              /* avoids having to write wrappers for all registers */
> -            ret =3D csr_ops[csrno].write(env, csrno, int128_getlo(new_va=
lue));
> +            ret =3D csr_ops[csrno].write(env, csrno, int128_getlo(new_va=
lue), 0);
>              if (ret !=3D RISCV_EXCP_NONE) {
>                  return ret;
>              }
> @@ -5714,7 +5720,7 @@ static RISCVException read_jvt(CPURISCVState *env, =
int csrno,
>  }
>
>  static RISCVException write_jvt(CPURISCVState *env, int csrno,
> -                                target_ulong val)
> +                                target_ulong val, uintptr_t ra)
>  {
>      env->jvt =3D val;
>      return RISCV_EXCP_NONE;
> --
> 2.43.0
>
>

