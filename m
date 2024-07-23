Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D1AC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 23:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWOyi-0006mb-KL; Tue, 23 Jul 2024 19:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOyg-0006aT-Oe
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:31:30 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOyd-00085P-U3
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:31:30 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52efd530a4eso5199188e87.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 16:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721777486; x=1722382286;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cKrQYig+jGbMxG6M4I8fB3HEZJa8YxMj+QF3cxradAs=;
 b=CdZ0PdK8SXO9LSKUpEOe52RojXKOKENkCP3rN1V5aRES4bnIkbuZ6k9HVyd02KejYX
 a0K8/261OW3+xEvYkmKbh5Xe7cCbSdWWbtsTrn4lLnijBHRTCxmv+XjnzYzDY51x18s+
 5cqPuhjBuF/I9kscKSp9z3xbEN0INqJsh3qBPhp+wOcTy9Bn0SfjVjxjIn0KBFxqfIZm
 uor5h9r3nMmioA/R8YWP70Q5ZCcOnshy/Ve9KEtpAxqnH/aCJ8aA/EEUC0jQCh0Y/5Ft
 mNuC2LGkdDaxA4dfVnwKUUV+Z2voaYR5Y/xLcVu/jSnWjE7S6u5CnFr+9LrwHM3TKxy/
 Oa7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721777486; x=1722382286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cKrQYig+jGbMxG6M4I8fB3HEZJa8YxMj+QF3cxradAs=;
 b=P1Cq5lq00njpzOmhiYL364qbP80l9Rmunm0AQzbawQymECEDU5tD0iPV8doDsqKsVN
 tzfPPmAVQItdgTm8rKBipen0XHtk1XOJC/yFb/mhhNfaOj5+C/qEGfnAm2PgE4Zavp8s
 B2CfONgD4jS24DjzplLWGrS/Ntm9kOKjCfSB+CgPs9hd41PZJScKsTX3RcrvYihJDPH1
 EiUk2u/Sm2+0iPL7+a7jC/luFK89wYkpiYakS+X07VuopkrnXvXePyBfYKYbu1jxaaZm
 e4oC4ozYmwClqA7w5TMDmn7cwhrKg75yF6kiWheybjmCLKvcqVSghb/4fLxmIN3RFUvr
 oTsA==
X-Gm-Message-State: AOJu0YyZgBFj/DqrDZdkUuhgNZsSSesRDZEcqy+Lf1WP7wO9b149VSI/
 8RnxSayg8e39SwjiK6L9Tlx03T0U+eeiQBitgdgffFApUnL7BWDNF1jvJbdf1HWb3q+rnqgIgpS
 4IYni331DqLqMHnxHSGgvKS5Ow6gBIMEK3drtPzVkwpModwhM
X-Google-Smtp-Source: AGHT+IGvup6uiQE3JP0Wkb7FJ8DpT79FHQCBtHptSdgaAmlRdUTEqIQKkAHTu1qlobFLvY6QJa5BIIaMYIN6GZQPxqc=
X-Received: by 2002:a05:6512:3a90:b0:52e:95dd:a8ef with SMTP id
 2adb3069b0e04-52fc404c6a8mr3286174e87.27.1721777485708; Tue, 23 Jul 2024
 16:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240217000134.3634191-1-atishp@rivosinc.com>
 <20240217000134.3634191-5-atishp@rivosinc.com>
 <072c16a6-2f06-4b57-aac9-7651ddb578ce@sifive.com>
In-Reply-To: <072c16a6-2f06-4b57-aac9-7651ddb578ce@sifive.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Tue, 23 Jul 2024 16:31:14 -0700
Message-ID: <CAHBxVyH5TFMf3ch5A3A0OexZSkuwEYUs7qDDOSDzptFbqWhr4Q@mail.gmail.com>
Subject: Re: [PATCH RFC 4/8] target/riscv: Support generic CSR indirect access
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=atishp@rivosinc.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Jun 5, 2024 at 4:49=E2=80=AFAM Jason Chien <jason.chien@sifive.com>=
 wrote:
>
> The predicate functions should contain the access control by the
> state-enable CSRs, which is not presented in this patch. Do you mind
> that I take over the indirect CSR access control part? The Signed-off-by
> will be kept.
>
> Atish Patra =E6=96=BC 2024/2/17 =E4=B8=8A=E5=8D=88 08:01 =E5=AF=AB=E9=81=
=93:
> > From: Kaiwen Xue <kaiwenx@rivosinc.com>
> >
> > This adds the indirect access registers required by sscsrind/smcsrind
> > and the operations on them. Note that xiselect and xireg are used for
> > both AIA and sxcsrind, and the behavior of accessing them depends on
> > whether each extension is enabled and the value stored in xiselect.
> >
> > Co-developed-by: Atish Patra <atishp@rivosinc.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> > ---
> >   target/riscv/cpu_bits.h |  28 +++++++-
> >   target/riscv/csr.c      | 146 +++++++++++++++++++++++++++++++++++++++=
-
> >   2 files changed, 169 insertions(+), 5 deletions(-)
> >
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index 0ee91e502e8f..3a66f83009b5 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -176,6 +176,13 @@
> >   #define CSR_MISELECT        0x350
> >   #define CSR_MIREG           0x351
> >
> > +/* Machine Indirect Register Alias */
> > +#define CSR_MIREG2          0x352
> > +#define CSR_MIREG3          0x353
> > +#define CSR_MIREG4          0x355
> > +#define CSR_MIREG5          0x356
> > +#define CSR_MIREG6          0x357
> > +
> >   /* Machine-Level Interrupts (AIA) */
> >   #define CSR_MTOPEI          0x35c
> >   #define CSR_MTOPI           0xfb0
> > @@ -225,6 +232,13 @@
> >   #define CSR_SISELECT        0x150
> >   #define CSR_SIREG           0x151
> >
> > +/* Supervisor Indirect Register Alias */
> > +#define CSR_SIREG2          0x152
> > +#define CSR_SIREG3          0x153
> > +#define CSR_SIREG4          0x155
> > +#define CSR_SIREG5          0x156
> > +#define CSR_SIREG6          0x157
> > +
> >   /* Supervisor-Level Interrupts (AIA) */
> >   #define CSR_STOPEI          0x15c
> >   #define CSR_STOPI           0xdb0
> > @@ -291,6 +305,13 @@
> >   #define CSR_VSISELECT       0x250
> >   #define CSR_VSIREG          0x251
> >
> > +/* Virtual Supervisor Indirect Alias */
> > +#define CSR_VSIREG2         0x252
> > +#define CSR_VSIREG3         0x253
> > +#define CSR_VSIREG4         0x255
> > +#define CSR_VSIREG5         0x256
> > +#define CSR_VSIREG6         0x257
> > +
> >   /* VS-Level Interrupts (H-extension with AIA) */
> >   #define CSR_VSTOPEI         0x25c
> >   #define CSR_VSTOPI          0xeb0
> > @@ -847,10 +868,13 @@ typedef enum RISCVException {
> >   #define ISELECT_IMSIC_EIE63                0xff
> >   #define ISELECT_IMSIC_FIRST                ISELECT_IMSIC_EIDELIVERY
> >   #define ISELECT_IMSIC_LAST                 ISELECT_IMSIC_EIE63
> > -#define ISELECT_MASK                       0x1ff
> > +#define ISELECT_MASK_AIA                   0x1ff
> > +
> > +/* MISELECT, SISELECT, and VSISELECT bits (AIA) */
> > +#define ISELECT_MASK_SXCSRIND              0xfff
> Could you rename ISELECT_MASK_SXCSRIND to ISELECT_MASK_CSRIND to keep
> the naming consistency with ISELECT_MASK_AIA?
> >
> >   /* Dummy [M|S|VS]ISELECT value for emulating [M|S|VS]TOPEI CSRs */
> > -#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK + 1)
> > +#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK_AIA + 1)
> >
> >   /* IMSIC bits (AIA) */
> >   #define IMSIC_TOPEI_IID_SHIFT              16
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 89a1325a02a5..a1c10f1d010a 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -287,6 +287,17 @@ static int aia_any32(CPURISCVState *env, int csrno=
)
> >       return any32(env, csrno);
> >   }
> >
> > +static RISCVException sxcsrind_any(CPURISCVState *env, int csrno)
> Could you rename sxcsrind_any() to csrind_any() to keep naming
> consistency with aia_any()?
> > +{
> > +    RISCVCPU *cpu =3D env_archcpu(env);
> > +
> > +    if (!cpu->cfg.ext_smcsrind) {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    }
> > +
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> >   static int sxcsrind_or_aia_any(CPURISCVState *env, int csrno)
> >   {
> >       if (!riscv_cpu_cfg(env)->ext_smaia && !riscv_cpu_cfg(env)->ext_sm=
csrind) {
> > @@ -355,6 +366,17 @@ static int aia_smode32(CPURISCVState *env, int csr=
no)
> >       return smode32(env, csrno);
> >   }
> >
> > +static RISCVException sxcsrind_smode(CPURISCVState *env, int csrno)
> Could you rename sxcsrind_smode() to csrind_smode() to keep naming
> consistency with aia_smode()?
> > +{
> > +    RISCVCPU *cpu =3D env_archcpu(env);
> > +
> > +    if (!cpu->cfg.ext_sscsrind) {
> S-mode CSRs are defined in Smcsrind as well. If both Smcsrind and
> Sscsrind are disabled, return RISCV_EXCP_ILLEGAL_INST.
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    }
> > +
> A virtual instruction exception should be raised here for attempts from
> VU-mode to access siselect or sireg*.

That should be covered in riscv_csrrw_check.

> > +    return smode(env, csrno);
> > +}
> > +
> >   static int sxcsrind_or_aia_smode(CPURISCVState *env, int csrno)
> >   {
> >       if (!riscv_cpu_cfg(env)->ext_ssaia && !riscv_cpu_cfg(env)->ext_ss=
csrind) {
> > @@ -383,6 +405,17 @@ static RISCVException hmode32(CPURISCVState *env, =
int csrno)
> >
> >   }
> >
> > +static RISCVException sxcsrind_hmode(CPURISCVState *env, int csrno)
> Could you rename sxcsrind_hmode() to csrind_hmode() to keep naming
> consistency with aia_hmode()?
> > +{
> > +    RISCVCPU *cpu =3D env_archcpu(env);
> > +
> > +    if (!cpu->cfg.ext_sscsrind) {
> VS-mode CSRs are defined in Smcsrind as well. If both Smcsrind and
> Sscsrind are disabled, return RISCV_EXCP_ILLEGAL_INST.
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    }
> > +
> > +    return hmode(env, csrno);
> > +}
> > +
> >   static int sxcsrind_or_aia_hmode(CPURISCVState *env, int csrno)
> >   {
> >       if (!riscv_cpu_cfg(env)->ext_ssaia && !riscv_cpu_cfg(env)->ext_ss=
csrind) {
> > @@ -1926,7 +1959,12 @@ static int rmw_xiselect(CPURISCVState *env, int =
csrno, target_ulong *val,
> >           *val =3D *iselect;
> >       }
> >
> > -    wr_mask &=3D ISELECT_MASK;
> > +    if (riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext_ss=
csrind) {
> > +        wr_mask &=3D ISELECT_MASK_SXCSRIND;
> > +    } else {
> > +        wr_mask &=3D ISELECT_MASK_AIA;
> > +    }
> > +
> >       if (wr_mask) {
> >           *iselect =3D (*iselect & ~wr_mask) | (new_val & wr_mask);
> >       }
> > @@ -2065,6 +2103,59 @@ done:
> >       return RISCV_EXCP_NONE;
> >   }
> >
> > +/*
> > + * rmw_xireg_sxcsrind: Perform indirect access to xireg and xireg2-xir=
eg6
> > + *
> > + * Perform indirect access to xireg and xireg2-xireg6.
> > + * This is a generic interface for all xireg CSRs. Apart from AIA, all=
 other
> > + * extension using sxcsrind should be implemented here.
> > + */
> > +static int rmw_xireg_sxcsrind(CPURISCVState *env, int csrno,
> > +                              target_ulong isel, target_ulong *val,
> > +                              target_ulong new_val, target_ulong wr_ma=
sk)
> Could you rename rmw_xireg_sxcsrind() to rmw_xireg_csrind() to keep the
> naming consistency with rmw_xireg_aia()?
> > +{
> > +    return -EINVAL;
> > +}
> > +
> > +static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val=
,
> > +                      target_ulong new_val, target_ulong wr_mask)
> > +{
> > +    bool virt =3D false;
> > +    int ret =3D -EINVAL;
> > +    target_ulong isel;
> > +
> > +    ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
> > +    if (ret !=3D RISCV_EXCP_NONE) {
> > +        return ret;
> > +    }
> > +
> > +    /* Translate CSR number for VS-mode */
> > +    csrno =3D sxcsrind_xlate_vs_csrno(env, csrno);
> > +
> > +    if (CSR_MIREG <=3D csrno && csrno <=3D CSR_MIREG6 &&
> > +        csrno !=3D CSR_MIREG4 - 1) {
> > +        isel =3D env->miselect;
> > +    } else if (CSR_SIREG <=3D csrno && csrno <=3D CSR_SIREG6 &&
> > +               csrno !=3D CSR_SIREG4 - 1) {
> > +        isel =3D env->siselect;
> > +    } else if (CSR_VSIREG <=3D csrno && csrno <=3D CSR_VSIREG6 &&
> > +               csrno !=3D CSR_VSIREG4 - 1) {
> > +        isel =3D env->vsiselect;
> > +        virt =3D true;
> > +    } else {
> > +        goto done;
> > +    }
> > +
> > +    return rmw_xireg_sxcsrind(env, csrno, isel, val, new_val, wr_mask)=
;
> > +
> > +done:
> > +    if (ret) {
> > +        return (env->virt_enabled && virt) ?
> A virtual instruction exception is raised for attempts from VS-mode or
> VU-mode to directly access vsiselect or vsireg* in riscv_csrrw_check(),
> we don't need to check again here.

The check is for invalid value while accessing siregi variants.

Thanks for the review. Addressed all other suggestions in v2.

> > +               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_=
INST;
> > +    }
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> >   static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val=
,
> >                        target_ulong new_val, target_ulong wr_mask)
> >   {
> > @@ -2096,8 +2187,21 @@ static int rmw_xireg(CPURISCVState *env, int csr=
no, target_ulong *val,
> >            goto done;
> >       };
> >
> > +    /*
> > +     * Use the xiselect range to determine actual op on xireg.
> > +     *
> > +     * Since we only checked the existence of AIA or Indirect Access i=
n the
> > +     * predicate, we should check the existence of the exact extension=
 when
> > +     * we get to a specific range and return illegal instruction excep=
tion even
> > +     * in VS-mode.
> > +     */
> >       if (xiselect_aia_range(isel)) {
> >           return rmw_xireg_aia(env, csrno, isel, val, new_val, wr_mask)=
;
> > +    } else if (riscv_cpu_cfg(env)->ext_smcsrind ||
> > +               riscv_cpu_cfg(env)->ext_sscsrind) {
> > +        return rmw_xireg_sxcsrind(env, csrno, isel, val, new_val, wr_m=
ask);
> > +    } else {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> >       }
> >
> >   done:
> > @@ -2480,7 +2584,7 @@ static RISCVException write_mstateen0(CPURISCVSta=
te *env, int csrno,
> >        * TODO: Do we need to check ssaia as well ? Can we enable ssaia =
without
> >        * smaia ?
> >        */
> > -    if (riscv_cpu_cfg(env)->ext_smaia) {
> > +    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsr=
ind) {
> >           wr_mask |=3D SMSTATEEN0_SVSLCT;
> >       }
> >
> > @@ -2569,7 +2673,7 @@ static RISCVException write_hstateen0(CPURISCVSta=
te *env, int csrno,
> >           wr_mask |=3D SMSTATEEN0_FCSR;
> >       }
> >
> > -    if (riscv_cpu_cfg(env)->ext_ssaia) {
> > +    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsr=
ind) {
> >           wr_mask |=3D SMSTATEEN0_SVSLCT;
> >       }
> >
> > @@ -4866,6 +4970,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {
> >       [CSR_MIREG]    =3D { "mireg",    sxcsrind_or_aia_any,   NULL, NUL=
L,
> >                          rmw_xireg                                     =
  },
> >
> > +    /* Machine Indirect Register Alias */
> > +    [CSR_MIREG2]   =3D { "mireg2", sxcsrind_any, NULL, NULL, rmw_xireg=
i,
> > +                       .min_priv_ver =3D PRIV_VERSION_1_12_0          =
},
> > +    [CSR_MIREG3]   =3D { "mireg3", sxcsrind_any, NULL, NULL, rmw_xireg=
i,
> > +                       .min_priv_ver =3D PRIV_VERSION_1_12_0          =
},
> > +    [CSR_MIREG4]   =3D { "mireg4", sxcsrind_any, NULL, NULL, rmw_xireg=
i,
> > +                       .min_priv_ver =3D PRIV_VERSION_1_12_0          =
},
> > +    [CSR_MIREG5]   =3D { "mireg5", sxcsrind_any, NULL, NULL, rmw_xireg=
i,
> > +                       .min_priv_ver =3D PRIV_VERSION_1_12_0          =
},
> > +    [CSR_MIREG6]   =3D { "mireg6", sxcsrind_any, NULL, NULL, rmw_xireg=
i,
> > +                       .min_priv_ver =3D PRIV_VERSION_1_12_0          =
},
> > +
> >       /* Machine-Level Interrupts (AIA) */
> >       [CSR_MTOPEI]   =3D { "mtopei",   aia_any, NULL, NULL, rmw_xtopei =
},
> >       [CSR_MTOPI]    =3D { "mtopi",    aia_any, read_mtopi },
> > @@ -4987,6 +5103,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {
> >       [CSR_SIREG]      =3D { "sireg",      sxcsrind_or_aia_smode, NULL,=
 NULL,
> >                            rmw_xireg                                   =
       },
> >
> > +    /* Supervisor Indirect Register Alias */
> > +    [CSR_SIREG2]      =3D { "sireg2", sxcsrind_smode, NULL, NULL, rmw_=
xiregi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +    [CSR_SIREG3]      =3D { "sireg3", sxcsrind_smode, NULL, NULL, rmw_=
xiregi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +    [CSR_SIREG4]      =3D { "sireg4", sxcsrind_smode, NULL, NULL, rmw_=
xiregi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +    [CSR_SIREG5]      =3D { "sireg5", sxcsrind_smode, NULL, NULL, rmw_=
xiregi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +    [CSR_SIREG6]      =3D { "sireg6", sxcsrind_smode, NULL, NULL, rmw_=
xiregi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +
> >       /* Supervisor-Level Interrupts (AIA) */
> >       [CSR_STOPEI]     =3D { "stopei",     aia_smode, NULL, NULL, rmw_x=
topei },
> >       [CSR_STOPI]      =3D { "stopi",      aia_smode, read_stopi },
> > @@ -5069,6 +5197,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {
> >       [CSR_VSIREG]      =3D { "vsireg",      sxcsrind_or_aia_hmode, NUL=
L, NULL,
> >                             rmw_xireg                                  =
       },
> >
> > +    /* Virtual Supervisor Indirect Alias */
> > +    [CSR_VSIREG2]     =3D { "vsireg2", sxcsrind_hmode, NULL, NULL, rmw=
_xiregi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +    [CSR_VSIREG3]     =3D { "vsireg3", sxcsrind_hmode, NULL, NULL, rmw=
_xiregi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +    [CSR_VSIREG4]     =3D { "vsireg4", sxcsrind_hmode, NULL, NULL, rmw=
_xiregi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +    [CSR_VSIREG5]     =3D { "vsireg5", sxcsrind_hmode, NULL, NULL, rmw=
_xiregi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +    [CSR_VSIREG6]     =3D { "vsireg6", sxcsrind_hmode, NULL, NULL, rmw=
_xiregi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +
> >       /* VS-Level Interrupts (H-extension with AIA) */
> >       [CSR_VSTOPEI]     =3D { "vstopei",     aia_hmode, NULL, NULL, rmw=
_xtopei },
> >       [CSR_VSTOPI]      =3D { "vstopi",      aia_hmode, read_vstopi },

