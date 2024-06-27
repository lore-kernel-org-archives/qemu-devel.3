Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E92AC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 07:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMjmX-0006qT-0Q; Thu, 27 Jun 2024 03:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sMjmS-0006ol-Gf
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:42:57 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sMjmQ-00030w-Bc
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:42:56 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ec3f875e68so83956221fa.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1719474171; x=1720078971; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPA72iFt6LSCWamT70aYHGyxDE234T1gCoIVZuw4Sj4=;
 b=g8E3Jegh6eNRReVJp1GsNVtDkUJ25QK9PtaPMLZqdLDdrC1nnM0x5NBgp5ARvGQmzV
 kocs6HIiL1rM9FxrpdsH2IPEMYUP9N23ffvAOadDoQzy3zWLGCOhvq4PZ3FTI1Ql/fAK
 q5dpxEl6p3NFpayg7VTbxdoGu3clUcJEddlwhkOfP8rkJKzIbLpHVG8bos2mVHAQMCiJ
 pKh/Gii77JNPhJo77/VKHIjtsCE5bVPUAJOPb5gdW0gJc7/kDgLrymr5x3TG0kc/LuTa
 wg+5SVQfYoeIP1ZEDHcrdoZGrRHobILtysJNBtsz6c5+RjIq0ByLu8bN9G1Yd+MmK9Kz
 bf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719474171; x=1720078971;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPA72iFt6LSCWamT70aYHGyxDE234T1gCoIVZuw4Sj4=;
 b=qXhVQ2Wc1lYw3NvspAKHWpwy3D/JxbvHZbL5HXpMgbbuKpBYlCzYB3G4hFypMyIxft
 GUexDTgqbyE1QMNw78oeaOJeEfCGITfpJP/pNswSGTeMXbyeAS/n/scYyrlUiR1JPiET
 tUlF2VKnUb3wL5lwv3ArHtNr4U/eea4ODXHlPzoMCfVI22U7R2T1wl4YQiUxAU0hegHD
 puv4ZlmYzyDZXNMZA2R+xjr09LLraymdQWzQIdFqoQaOBTpHpxN0nsxwD5UPmUuQ23T1
 Mbg2OgukN00Ixk/Nm/Hn79yeTaeegE66qld4WeEMfRUolLvFpnEBqYPg3iVRuUL+hitK
 EY/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/aCtQ39O4q827YjWymgn3Oi4eMUxsqvKB072k7kn3574HwklD3uXdXEQAZt4bjD6dx5DVrYeitoy5nzkOHvtv97Uic2A=
X-Gm-Message-State: AOJu0YytwEOGbGD9ONl27ff330HPrEAan+VOhN4LwAD7Yxwd8P5H0Wop
 aZ4S4qUgVU/gfJulBUb4ic41OTgGIhGLyWwkiBt9M6gt82ufWwirXj2VSTLLOmITJ6evNDz/QAP
 fXCz17pMcUEiW+yJuYiFJPamxMBwOtT6WoQcDyjGHUZFHE1yQ5x1ofLa5/6gXI/R16pYBSSN6qs
 GzBnWQ45IbPLmktPm7XQp78Nl6GVW97b1lCMHdeuvK3g==
X-Google-Smtp-Source: AGHT+IEIno+TW5ASrbXOJ7VXmuYN5oE7h90SEedLonXMunUa43RFQ29EMsO0AEoQRm/wp1D99Wt+vg==
X-Received: by 2002:a2e:bc19:0:b0:2ec:617b:4757 with SMTP id
 38308e7fff4ca-2ec617b47a6mr80678661fa.13.1719474171343; 
 Thu, 27 Jun 2024 00:42:51 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com.
 [209.85.167.50]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ee4a34f66fsm1493061fa.30.2024.06.27.00.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 00:42:51 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5295e488248so8969582e87.2; 
 Thu, 27 Jun 2024 00:42:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWHz5OqsvP7aLCfTQuqSt7CcgyKuip4qQJlxegIFyhWfdjmXH5dKDhgLV1xB4MwWv1pIBh+oeoelexif06InfWS3cwbiFeb7Qpk0y+B691P5QJKFdSwSd9bYm/v0Q==
X-Received: by 2002:ac2:596e:0:b0:52c:de91:590c with SMTP id
 2adb3069b0e04-52ce18358edmr7480690e87.24.1719474170745; Thu, 27 Jun 2024
 00:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240511101053.1875596-1-me@deliversmonkey.space>
 <20240511101053.1875596-3-me@deliversmonkey.space>
In-Reply-To: <20240511101053.1875596-3-me@deliversmonkey.space>
From: Frank Chang <frank.chang@sifive.com>
Date: Thu, 27 Jun 2024 15:42:39 +0800
X-Gmail-Original-Message-ID: <CANzO1D13X_ybOueTWY8C36xSvtVLh=vwhZT+_Z9Q=R91YZsAow@mail.gmail.com>
Message-ID: <CANzO1D13X_ybOueTWY8C36xSvtVLh=vwhZT+_Z9Q=R91YZsAow@mail.gmail.com>
Subject: Re: [PATCH v9 2/6] target/riscv: Add new CSR fields for S{sn, mn,
 m}pm extensions as part of Zjpm v0.8
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, space.monkey.delivers@gmail.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=frank.chang@sifive.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Alexey Baturo <baturo.alexey@gmail.com> =E6=96=BC 2024=E5=B9=B45=E6=9C=8811=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=886:12=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h      |  8 ++++++++
>  target/riscv/cpu_bits.h |  3 +++
>  target/riscv/cpu_cfg.h  |  3 +++
>  target/riscv/csr.c      | 11 +++++++++++
>  target/riscv/machine.c  | 10 +++++++---
>  target/riscv/pmp.c      | 13 ++++++++++---
>  target/riscv/pmp.h      | 11 ++++++-----
>  7 files changed, 48 insertions(+), 11 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 232521bb87..52b6ba73c8 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -121,6 +121,14 @@ typedef enum {
>      EXT_STATUS_DIRTY,
>  } RISCVExtStatus;
>
> +/* Enum holds PMM field values for Zjpm v0.8 extension */
> +typedef enum {
> +    PMM_FIELD_DISABLED =3D 0,
> +    PMM_FIELD_RESERVED =3D 1,
> +    PMM_FIELD_PMLEN7   =3D 2,
> +    PMM_FIELD_PMLEN16  =3D 3,
> +} RISCVPmPmm;
> +
>  #define MMU_USER_IDX 3
>
>  #define MAX_RISCV_PMPS (16)
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index da16ba236a..13ce2218d1 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -708,6 +708,7 @@ typedef enum RISCVException {
>  #define MENVCFG_CBIE                       (3UL << 4)
>  #define MENVCFG_CBCFE                      BIT(6)
>  #define MENVCFG_CBZE                       BIT(7)
> +#define MENVCFG_PMM                        (3ULL << 32)
>  #define MENVCFG_ADUE                       (1ULL << 61)
>  #define MENVCFG_PBMTE                      (1ULL << 62)
>  #define MENVCFG_STCE                       (1ULL << 63)
> @@ -721,11 +722,13 @@ typedef enum RISCVException {
>  #define SENVCFG_CBIE                       MENVCFG_CBIE
>  #define SENVCFG_CBCFE                      MENVCFG_CBCFE
>  #define SENVCFG_CBZE                       MENVCFG_CBZE
> +#define SENVCFG_PMM                        MENVCFG_PMM
>
>  #define HENVCFG_FIOM                       MENVCFG_FIOM
>  #define HENVCFG_CBIE                       MENVCFG_CBIE
>  #define HENVCFG_CBCFE                      MENVCFG_CBCFE
>  #define HENVCFG_CBZE                       MENVCFG_CBZE
> +#define HENVCFG_PMM                        MENVCFG_PMM
>  #define HENVCFG_ADUE                       MENVCFG_ADUE
>  #define HENVCFG_PBMTE                      MENVCFG_PBMTE
>  #define HENVCFG_STCE                       MENVCFG_STCE
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index e1e4f32698..9ecdc792c5 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -120,6 +120,9 @@ struct RISCVCPUConfig {
>      bool ext_ssaia;
>      bool ext_sscofpmf;
>      bool ext_smepmp;
> +    bool ext_ssnpm;
> +    bool ext_smnpm;
> +    bool ext_smmpm;
>      bool rvv_ta_all_1s;
>      bool rvv_ma_all_1s;
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 4b2c932564..45b548eb0b 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -530,6 +530,9 @@ static RISCVException have_mseccfg(CPURISCVState *env=
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
> @@ -2083,6 +2086,10 @@ static RISCVException write_menvcfg(CPURISCVState =
*env, int csrno,
>                  (cfg->ext_sstc ? MENVCFG_STCE : 0) |
>                  (cfg->ext_svadu ? MENVCFG_ADUE : 0);
>      }
> +    /* Update PMM field only if the value is valid according to Zjpm v0.=
8 */
> +    if (((val & MENVCFG_PMM) >> 32) !=3D PMM_FIELD_RESERVED) {

It's also possible that val is 32-bit for RV32 QEMU.
Right shifting more than 31 bits would generate the error:
'error: right shift count >=3D width of type [-Werror=3Dshift-count-overflo=
w]'

Regards,
Frank Chang

> +        mask |=3D MENVCFG_PMM;
> +    }
>      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
>
>      return RISCV_EXCP_NONE;
> @@ -2127,6 +2134,10 @@ static RISCVException write_senvcfg(CPURISCVState =
*env, int csrno,
>                                      target_ulong val)
>  {
>      uint64_t mask =3D SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE | SENV=
CFG_CBZE;
> +    /* Update PMM field only if the value is valid according to Zjpm v0.=
8 */
> +    if (((val & SENVCFG_PMM) >> 32) !=3D PMM_FIELD_RESERVED) {
> +        mask |=3D SENVCFG_PMM;
> +    }
>      RISCVException ret;
>
>      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 64ab66e332..bbbb28f373 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -152,15 +152,19 @@ static const VMStateDescription vmstate_vector =3D =
{
>
>  static bool pointermasking_needed(void *opaque)
>  {
> -    return false;
> +    RISCVCPU *cpu =3D opaque;
> +    return cpu->cfg.ext_ssnpm || cpu->cfg.ext_smnpm || cpu->cfg.ext_smmp=
m;
>  }
>
>  static const VMStateDescription vmstate_pointermasking =3D {
>      .name =3D "cpu/pointer_masking",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .needed =3D pointermasking_needed,
>      .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINTTL(env.mseccfg, RISCVCPU),
> +        VMSTATE_UINTTL(env.senvcfg, RISCVCPU),
> +        VMSTATE_UINTTL(env.menvcfg, RISCVCPU),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 2a76b611a0..7ddb9dbf0b 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -574,6 +574,12 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, ui=
nt32_t addr_index)
>  void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
>  {
>      int i;
> +    uint64_t mask =3D MSECCFG_MMWP | MSECCFG_MML;
> +
> +    /* Update PMM field only if the value is valid according to Zjpm v0.=
8 */
> +    if (((val & MSECCFG_PMM) >> 32) !=3D PMM_FIELD_RESERVED) {
> +        mask |=3D MSECCFG_PMM;
> +    }
>
>      trace_mseccfg_csr_write(env->mhartid, val);
>
> @@ -589,12 +595,13 @@ void mseccfg_csr_write(CPURISCVState *env, target_u=
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
>      env->mseccfg =3D val;
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index f5c10ce85c..ccff0eb9b6 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -40,11 +40,12 @@ typedef enum {
>  } pmp_am_t;
>
>  typedef enum {
> -    MSECCFG_MML   =3D 1 << 0,
> -    MSECCFG_MMWP  =3D 1 << 1,
> -    MSECCFG_RLB   =3D 1 << 2,
> -    MSECCFG_USEED =3D 1 << 8,
> -    MSECCFG_SSEED =3D 1 << 9
> +    MSECCFG_MML       =3D 1 << 0,
> +    MSECCFG_MMWP      =3D 1 << 1,
> +    MSECCFG_RLB       =3D 1 << 2,
> +    MSECCFG_USEED     =3D 1 << 8,
> +    MSECCFG_SSEED     =3D 1 << 9,
> +    MSECCFG_PMM       =3D 3UL << 32,
>  } mseccfg_field_t;
>
>  typedef struct {
> --
> 2.34.1
>
>

