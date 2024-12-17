Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A96E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 05:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNQCR-000868-1C; Tue, 17 Dec 2024 00:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tNQCP-00085w-JL; Tue, 17 Dec 2024 00:32:49 -0500
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tNQCN-0006hu-9D; Tue, 17 Dec 2024 00:32:49 -0500
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-4afdf096fc5so1097232137.2; 
 Mon, 16 Dec 2024 21:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734413566; x=1735018366; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c0B14DN1A+dthFCI2qIvw45RTkRxhR8p4TlvsJUaSyY=;
 b=W+7/TAmB0/fj0SLIuODf9mvOjl8ScwzsDyYm0c3roe0ug5eZWaqonoMlRBJepybNVo
 pkCX2pTe0+2jqAC6tmJGJSGd3GAXTwwHQnO8U1XdXtCMQv/6uh/DO3BnN5n+XaxIUJtW
 2qqiaElj2ON/aGyQ1BIod6ftVlbl/zEyR40AauSjEwzVZ0u5/v72g1xkAfDvE4njltUT
 3TEp7Ft2j2Vm2+3fXMB6wcShpcRk/z4udZ/8LslznmRtSpAD343ifxeuc+PoqIzWBS9k
 5eGlB9WmpDuVQpWIlLI5PFRs9lh6xRIjDFrj9Knl6VEHSe2xrDPSXkHPwThRytJpX+kG
 NZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734413566; x=1735018366;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c0B14DN1A+dthFCI2qIvw45RTkRxhR8p4TlvsJUaSyY=;
 b=Rq78HJc2S6bqLSyGaKLqZH9cRXT43S11aaR+Q0mY1um5kugs3d0BndsZ1AHsK2MWIZ
 L5cF38SHWHO+OcOYXtS+2H6/WTOtkYaKBSrS/pGVg8QmT1I1gmJ1hoTg17g693xWqJYd
 mPDR66+x3i6AErUT3/UGhgrPccQaWlYtczS1aDF6GluZXo+i6r2Jn4vUvmSrP59htOX3
 U31cSvP7llkV2ePVV0/MQnKB2JIQsrNz+cWYqlef9hValFuntnlm0QJvfWlYqanryfq7
 8PGXZNYGk/RkkTrh8W1q59l3JUJMTuotzLWMfRmpWXRwA22yIZQlBtARcZjTlJnxHdVV
 Oukg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdiUp++7D5aJfeRDBHZAvi/vE/G80LOcV5Xj6jxLfs3D8TlAZ916FAXotKUXpZ06yHpGFIu4UQ/EPT@nongnu.org,
 AJvYcCXqQX2kVz8neJLZVHcUuPauJUnIMOrrRl8JOZRUZI3bCqJvsprE4JJhNszeXC7YL85j3MajvHKCkWRouw==@nongnu.org
X-Gm-Message-State: AOJu0Yx0cJmQWGe4QXVK41RqFKeHXnos3+MUnkrGLX9sL+BcP/Ke5Lb0
 dFGmBsulSUYeYSWkaLX42uXRcQaRnhwmtwFgFrDvZms4pwKX51c+OEtex1bhSSy4Fc4TA6C9XP7
 FedhPb5eOrOuSAkehkyhQmTVzT/k=
X-Gm-Gg: ASbGncvjbn+lR2/fyWehd/Xn8P8F4YOb1vrk/vX89WqAvRjxhghe1FZIB067jQa8pUy
 WbAoi5i5KUJ7libZJLRxCTGgcredJ7ggQh2nHxSw7b1UuYw/PX8T3Q70tR6e3+ZyKG181
X-Google-Smtp-Source: AGHT+IF9uLQdLVoxTZla4gXzd+h0QqpMMlECa+9u3Z2EzEMhMfZmQXVhEJbawHDIhP9fieXAFkJ8D0QTgu4Pi3oM5lY=
X-Received: by 2002:a05:6102:2b99:b0:4b0:ccec:c9de with SMTP id
 ada2fe7eead31-4b25db5fa81mr16815614137.24.1734413565756; Mon, 16 Dec 2024
 21:32:45 -0800 (PST)
MIME-Version: 1.0
References: <20241216121907.660504-1-baturo.alexey@gmail.com>
 <20241216121907.660504-3-baturo.alexey@gmail.com>
In-Reply-To: <20241216121907.660504-3-baturo.alexey@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 17 Dec 2024 15:32:19 +1000
Message-ID: <CAKmqyKPmjNms-iZytUxNWvO4x5guyKMjZVNrsWM9kcqQZ51b_w@mail.gmail.com>
Subject: Re: [PATCH v13 2/7] target/riscv: Add new CSR fields for S{sn, mn,
 m}pm extensions as part of Zjpm v1.0
To: baturo.alexey@gmail.com
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
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

On Mon, Dec 16, 2024 at 10:19=E2=80=AFPM <baturo.alexey@gmail.com> wrote:
>
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

You shouldn't include a newline here

>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h      |  8 ++++++++
>  target/riscv/cpu_bits.h |  4 ++++
>  target/riscv/cpu_cfg.h  |  3 +++
>  target/riscv/csr.c      | 31 ++++++++++++++++++++++++++++++-
>  target/riscv/pmp.c      | 14 +++++++++++---
>  target/riscv/pmp.h      |  1 +
>  6 files changed, 57 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index e11264231d..417ff45544 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -128,6 +128,14 @@ typedef enum {
>      EXT_STATUS_DIRTY,
>  } RISCVExtStatus;
>
> +/* Enum holds PMM field values for Zjpm v1.0 extension */
> +typedef enum {
> +    PMM_FIELD_DISABLED =3D 0,
> +    PMM_FIELD_RESERVED =3D 1,
> +    PMM_FIELD_PMLEN7   =3D 2,
> +    PMM_FIELD_PMLEN16  =3D 3,
> +} RISCVPmPmm;
> +
>  typedef struct riscv_cpu_implied_exts_rule {
>  #ifndef CONFIG_USER_ONLY
>      /*
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 2a6aff63ed..d8f9bc68e3 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -574,6 +574,7 @@ typedef enum {
>  #define HSTATUS_VTW          0x00200000
>  #define HSTATUS_VTSR         0x00400000
>  #define HSTATUS_VSXL         0x300000000
> +#define HSTATUS_HUPMM        0x3000000000000
>
>  #define HSTATUS32_WPRI       0xFF8FF87E
>  #define HSTATUS64_WPRI       0xFFFFFFFFFF8FF87EULL
> @@ -734,6 +735,7 @@ typedef enum RISCVException {
>  #define MENVCFG_CBIE                       (3UL << 4)
>  #define MENVCFG_CBCFE                      BIT(6)
>  #define MENVCFG_CBZE                       BIT(7)
> +#define MENVCFG_PMM                        (3ULL << 32)
>  #define MENVCFG_ADUE                       (1ULL << 61)
>  #define MENVCFG_PBMTE                      (1ULL << 62)
>  #define MENVCFG_STCE                       (1ULL << 63)
> @@ -749,6 +751,7 @@ typedef enum RISCVException {
>  #define SENVCFG_CBIE                       MENVCFG_CBIE
>  #define SENVCFG_CBCFE                      MENVCFG_CBCFE
>  #define SENVCFG_CBZE                       MENVCFG_CBZE
> +#define SENVCFG_PMM                        MENVCFG_PMM
>
>  #define HENVCFG_FIOM                       MENVCFG_FIOM
>  #define HENVCFG_LPE                        MENVCFG_LPE
> @@ -756,6 +759,7 @@ typedef enum RISCVException {
>  #define HENVCFG_CBIE                       MENVCFG_CBIE
>  #define HENVCFG_CBCFE                      MENVCFG_CBCFE
>  #define HENVCFG_CBZE                       MENVCFG_CBZE
> +#define HENVCFG_PMM                        MENVCFG_PMM
>  #define HENVCFG_ADUE                       MENVCFG_ADUE
>  #define HENVCFG_PBMTE                      MENVCFG_PBMTE
>  #define HENVCFG_STCE                       MENVCFG_STCE
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 59d6fc445d..79a114eb07 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -128,6 +128,9 @@ struct RISCVCPUConfig {
>      bool ext_ssaia;
>      bool ext_sscofpmf;
>      bool ext_smepmp;
> +    bool ext_ssnpm;
> +    bool ext_smnpm;
> +    bool ext_smmpm;
>      bool rvv_ta_all_1s;
>      bool rvv_ma_all_1s;
>      bool rvv_vl_half_avl;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 941c9691da..5389ccb983 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -575,6 +575,9 @@ static RISCVException have_mseccfg(CPURISCVState *env=
, int csrno)
>      if (riscv_cpu_cfg(env)->ext_zkr) {
>          return RISCV_EXCP_NONE;
>      }
> +    if (riscv_cpu_cfg(env)->ext_smmpm) {
> +        return RISCV_EXCP_NONE;
> +    }
>
>      return RISCV_EXCP_ILLEGAL_INST;
>  }
> @@ -2379,6 +2382,12 @@ static RISCVException write_menvcfg(CPURISCVState =
*env, int csrno,
>          if (env_archcpu(env)->cfg.ext_zicfiss) {
>              mask |=3D MENVCFG_SSE;
>          }
> +
> +        /* Update PMM field only if the value is valid according to Zjpm=
 v1.0 */
> +        if (env_archcpu(env)->cfg.ext_smnpm &&
> +            get_field(val, MENVCFG_PMM) !=3D PMM_FIELD_RESERVED) {
> +            mask |=3D MENVCFG_PMM;
> +        }
>      }
>      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
>
> @@ -2425,6 +2434,12 @@ static RISCVException write_senvcfg(CPURISCVState =
*env, int csrno,
>  {
>      uint64_t mask =3D SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE | SENV=
CFG_CBZE;
>      RISCVException ret;
> +    /* Update PMM field only if the value is valid according to Zjpm v1.=
0 */
> +    if (env_archcpu(env)->cfg.ext_ssnpm &&
> +        riscv_cpu_mxl(env) =3D=3D MXL_RV64 &&
> +        get_field(val, SENVCFG_PMM) !=3D PMM_FIELD_RESERVED) {
> +        mask |=3D SENVCFG_PMM;
> +    }
>
>      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
>      if (ret !=3D RISCV_EXCP_NONE) {
> @@ -2489,6 +2504,12 @@ static RISCVException write_henvcfg(CPURISCVState =
*env, int csrno,
>              get_field(env->menvcfg, MENVCFG_SSE)) {
>              mask |=3D HENVCFG_SSE;
>          }
> +
> +        /* Update PMM field only if the value is valid according to Zjpm=
 v1.0 */
> +        if (env_archcpu(env)->cfg.ext_ssnpm &&
> +            get_field(val, HENVCFG_PMM) !=3D PMM_FIELD_RESERVED) {
> +            mask |=3D HENVCFG_PMM;
> +        }
>      }
>
>      env->henvcfg =3D (env->henvcfg & ~mask) | (val & mask);
> @@ -3525,7 +3546,15 @@ static RISCVException read_hstatus(CPURISCVState *=
env, int csrno,
>  static RISCVException write_hstatus(CPURISCVState *env, int csrno,
>                                      target_ulong val)
>  {
> -    env->hstatus =3D val;
> +    uint64_t mask =3D (target_ulong)-1;
> +    /* Update PMM field only if the value is valid according to Zjpm v1.=
0 */
> +    if (!env_archcpu(env)->cfg.ext_ssnpm ||
> +        riscv_cpu_mxl(env) !=3D MXL_RV64 ||
> +        get_field(val, HSTATUS_HUPMM) =3D=3D PMM_FIELD_RESERVED) {
> +        mask &=3D ~HSTATUS_HUPMM;
> +    }
> +    env->hstatus =3D (env->hstatus & ~mask) | (val & mask);
> +
>      if (riscv_cpu_mxl(env) !=3D MXL_RV32 && get_field(val, HSTATUS_VSXL)=
 !=3D 2) {
>          qemu_log_mask(LOG_UNIMP,
>                        "QEMU does not support mixed HSXLEN options.");
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index a1b36664fc..a185c246d6 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -575,6 +575,13 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, ui=
nt32_t addr_index)
>  void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
>  {
>      int i;
> +    uint64_t mask =3D MSECCFG_MMWP | MSECCFG_MML;
> +    /* Update PMM field only if the value is valid according to Zjpm v1.=
0 */
> +    if (riscv_cpu_cfg(env)->ext_smmpm &&
> +        riscv_cpu_mxl(env) =3D=3D MXL_RV64 &&
> +        get_field(val, MSECCFG_PMM) !=3D PMM_FIELD_RESERVED) {
> +        mask |=3D MSECCFG_PMM;
> +    }
>
>      trace_mseccfg_csr_write(env->mhartid, val);
>
> @@ -590,12 +597,13 @@ void mseccfg_csr_write(CPURISCVState *env, target_u=
long val)
>
>      if (riscv_cpu_cfg(env)->ext_smepmp) {
>          /* Sticky bits */
> -        val |=3D (env->mseccfg & (MSECCFG_MMWP | MSECCFG_MML));
> -        if ((val ^ env->mseccfg) & (MSECCFG_MMWP | MSECCFG_MML)) {
> +        val |=3D (env->mseccfg & mask);
> +        if ((val ^ env->mseccfg) & mask) {
>              tlb_flush(env_cpu(env));
>          }
>      } else {
> -        val &=3D ~(MSECCFG_MMWP | MSECCFG_MML | MSECCFG_RLB);
> +        mask |=3D MSECCFG_RLB;
> +        val &=3D ~(mask);
>      }
>
>      /* M-mode forward cfi to be enabled if cfi extension is implemented =
*/
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index e0530a17a3..271cf24169 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -46,6 +46,7 @@ typedef enum {
>      MSECCFG_USEED =3D 1 << 8,
>      MSECCFG_SSEED =3D 1 << 9,
>      MSECCFG_MLPE =3D  1 << 10,
> +    MSECCFG_PMM =3D 3ULL << 32,
>  } mseccfg_field_t;
>
>  typedef struct {
> --
> 2.39.5
>

