Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6167CDE00B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 01:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcuxM-0001uE-2l; Thu, 25 Jun 2026 21:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcuxJ-0001sC-RW
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:02:05 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcuxH-0001RF-Td
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:02:05 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-697f6c67028so800997a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 18:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782435722; cv=none;
 d=google.com; s=arc-20260327;
 b=bu1aHC0aQhopf3XnKiaSwT0GqRfeWKb3UFx4CbYqu0HA8dAs/rJKabkuGFvkzFZ/UX
 a3jWuwzVVqYkOZMgnyPXA7AUWrnanXdoc04HttEq8ZO1gpjyD2h3YYeorEB/wzU4B7Ii
 Wt9Mv0tt/xz6o0cRzI7TvtOvGfb0NmnfKjNdKPyXUOAB1bcOgv1i6h61DLOpfLQ9prOs
 +olluos+PDF/rV9L2X9SCWJ5nTcMpTpGonynZzVDag6p5iiNhfeaWcucelM/M9ktbObi
 9tyQZmWMdZw5c3DB9JhnIvvlxM/zRt1QT/nY28/B1TnlGGYJPEJseceG5aGkodZOxdrq
 ipww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RI7Ckbf1IsnE9Auvkon4RWke/SnMwstixlQALda0Lok=;
 fh=9/4tzqKjgzJcjmYJcCvfm+LbcgW0ATp/rdwAYjKmbVo=;
 b=Ve/uTGaHuV2BjfPT1dLPszhWuJATupXEfViHc47Z8RGXffMgFHQH4wn6iquHWEQsvp
 GkBJ38v8IhdXH4VsDxMKkX8gNlxHu2QscExm2ZP9AuOQGsyriP8PW0udDtDipOVE59lM
 DoO7PkRFqsKO6JO8jpJKlvi61whIWZQ1j/o8nybz4NSUjYl0Zzf39yCyBPLAdwShspZo
 Arc6TH1pEHuUCQtru61MDONdOMbmtVWs2ow/C81KQGp3v8paIH7C1CIcCGNT4UV2lcUC
 8z61rp512vDPWHHneHOPGf7KzPW7IufXNT/SqhEUnBWPGXhGJ6FRjMpSDDpMWf5BS3yu
 0/fQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782435722; x=1783040522; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RI7Ckbf1IsnE9Auvkon4RWke/SnMwstixlQALda0Lok=;
 b=h46USnJQajKLXtHdrvq4ok34pvbCx5rXIIjEqv2/b5bcw1WvmtvlruQFPXOKFTkenp
 qQNDQH6QS7SCaSe9XrEk4+aA0FR/jbiZprsHR1Vb2iMnKImdrr8EUva9FGs9pt1RueDy
 bmKVKBFu3hK1N6xyxcUTrURD5X6vkExXCT2N77gMDZH0wk0XeETKgHLacaWIBgbQg0SG
 pVmuQ1fvae99H2cdaOKtqRY2IHdmoJWHaIs4BAqykfExKQIzBdxJTN4pUGB9XGc4a3Nz
 xp2bsOA9n6bPUY+4MxSqjDp8eZh7LAW9Ua4D5oqNP1PGzSAra9w3ECaUlp2cCR3v0ZO4
 WcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782435722; x=1783040522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RI7Ckbf1IsnE9Auvkon4RWke/SnMwstixlQALda0Lok=;
 b=Ik+c3DJiWPLeycu7CJVDlDbjGX4sLtZz9V7m9qbHadpiNRhlAiPXFBwil6yVehuz8v
 mmB5mP0KlQkbEy6ozx0TA6nKEsnfuRLF6r5ybLbVo1HuMpJWfNPvNH3c3JIBYIXyLhKm
 Me+BUAUtC1SOkr7Aqm8YDlEEpuH9ZeAEWSPkuw5Dvy0T7xoQ5g7D64SVi385VV3dq1z4
 3I0yNjIM4AOoD8zZPLarNRzkR5jOO+sw7Gmcx+Yjn3rBXdO4EEuxcm7L5lXhtSMWL0Cn
 KE07sRk9t4BtWPVWuifp+ZmJWiL5NS5WVXFO7ugMQ66WVEUKwHAd7byU63/tZ1Xzv0Xm
 2Zrg==
X-Gm-Message-State: AOJu0Yyp5SjUPEsJsLy53by2w/+bQ48J8p5vko6KmTEFvcLT0fMPp/wZ
 vqmiZOfIWp4EKysJ2E6cVUjgZHR0XcK95EpWvbbgoU4y8sGdlDLEi6lvOBAseNY0VEz4rAIQ6Fs
 MnpU4IQvsPoZAtON4MyRQBpGZv1eU52E=
X-Gm-Gg: AfdE7clfuoo7HuU5OjDi29bOma6jL/s6Pl6O4B6fDffVolfDgaPlabbys8cRdLxv4dI
 8k//Nd9eM3fZQdZmWCbLswcl9ySz8YgFu6vvpsS1tF+y4qmGI9BZgp1o4gmLMHzfwXCvEhuLUfr
 NP129cP92LnzukOzM4ri9FZztQNi13zKs8lROBVcFYIdIwV1z1qPOw0GlOcM44mYzil9Y5FMbny
 w6C2wkAUri6rnyfXMj4m//hjnof28KZX3NPl8MirTGu++EHykg5Syf22nWQXlORnPKejQQ/VVr4
 FvsOvsV74eRGCmJvepIkDpYGtk8=
X-Received: by 2002:aa7:dc09:0:b0:697:9fd4:1433 with SMTP id
 4fb4d7f45d1cf-697d42d9a94mr4138721a12.7.1782435722174; Thu, 25 Jun 2026
 18:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
 <20260624000632.2149359-11-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260624000632.2149359-11-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 11:01:36 +1000
X-Gm-Features: AVVi8CdMEEoy-6vtAaiWe_Z0f3K03-S5Zsky5aeMSZHRHP14pgoaRTS8EwXc44I
Message-ID: <CAKmqyKPxN0-YcuO=yeYgpk2nk=0KJRdUPk6gDOwyFkQ+SFRM3g@mail.gmail.com>
Subject: Re: [PATCH v2 10/24] target/riscv: move custom_csrs logic to tcg-cpu.c
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 fritchleybohrer@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jun 24, 2026 at 10:09=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We have a couple of CPUs that has a set of custom CSRs that uses TCG
> specific APIs.  Move the related code to tcg-cpu.c and do not set
> .custom_csrs if we're not in a TCG build.
>
> What we'll end up doing, sooner or later, is punting all these CPUs to
> tcg-cpu.c since they're all TCG specific and KVM has nothing to do with
> them.  Another time.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 26 +++++---------------------
>  target/riscv/cpu.h         |  2 ++
>  target/riscv/tcg/tcg-cpu.c | 21 +++++++++++++++++++++
>  3 files changed, 28 insertions(+), 21 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 96c92de2ee..5e951ea19c 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -524,19 +524,6 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
>  }
>  #endif
>
> -#ifndef CONFIG_USER_ONLY
> -static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *cs=
r_list)
> -{
> -    for (size_t i =3D 0; csr_list[i].csr_ops.name; i++) {
> -        int csrno =3D csr_list[i].csrno;
> -        const riscv_csr_operations *csr_ops =3D &csr_list[i].csr_ops;
> -        if (!csr_list[i].insertion_test || csr_list[i].insertion_test(cp=
u)) {
> -            riscv_set_csr_ops(csrno, csr_ops);
> -        }
> -    }
> -}
> -#endif
> -
>  /* Used by csr.c and the KVM driver */
>  target_ulong riscv_new_csr_seed(target_ulong new_value,
>                                  target_ulong write_mask)
> @@ -1244,11 +1231,6 @@ static void riscv_cpu_init(Object *obj)
>      if (mcc->def->vext_spec !=3D RISCV_PROFILE_ATTR_UNUSED) {
>          cpu->env.vext_ver =3D mcc->def->vext_spec;
>      }
> -#ifndef CONFIG_USER_ONLY
> -    if (mcc->def->custom_csrs) {
> -        riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
> -    }
> -#endif
>
>      accel_cpu_instance_init(CPU(obj));
>  }
> @@ -2822,10 +2804,12 @@ static void riscv_cpu_class_base_init(ObjectClass=
 *c, const void *data)
>
>          riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
>
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>          if (def->custom_csrs) {
>              assert(!mcc->def->custom_csrs);
>              mcc->def->custom_csrs =3D def->custom_csrs;
>          }
> +#endif
>      }
>
>      if (!object_class_is_abstract(c)) {
> @@ -3178,7 +3162,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.mvendorid =3D THEAD_VENDOR_ID,
>
>          .cfg.max_satp_mode =3D VM_1_10_SV39,
> -#ifndef CONFIG_USER_ONLY
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>          .custom_csrs =3D th_csr_list,
>  #endif
>      ),
> @@ -3224,7 +3208,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>
>          .cfg.marchid =3D 0x8d143000,
>          .cfg.mvendorid =3D THEAD_VENDOR_ID,
> -#ifndef CONFIG_USER_ONLY
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>          .custom_csrs =3D th_csr_list,
>  #endif
>      ),
> @@ -3429,7 +3413,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.ext_xmipscmov =3D true,
>          .cfg.marchid =3D 0x8000000000000201,
>          .cfg.mvendorid =3D MIPS_VENDOR_ID,
> -#ifndef CONFIG_USER_ONLY
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>          .custom_csrs =3D mips_csr_list,
>  #endif
>      ),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c0e9098728..34c63a3628 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -591,7 +591,9 @@ typedef struct RISCVCPUDef {
>      int32_t vext_spec;
>      RISCVCPUConfig cfg;
>      bool bare;
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>      const RISCVCSR *custom_csrs;
> +#endif
>      /* This is just a setter for env->num_triggers.  */
>      uint32_t num_triggers;
>  } RISCVCPUDef;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index fe6350f497..fef66557c2 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -38,6 +38,7 @@
>  #include "system/tcg.h"
>  #include "exec/icount.h"
>  #include "target/riscv/tcg/debug.h"
> +#include "target/riscv/tcg/csr.h"
>  #endif
>
>  /* Hash that stores user set extensions */
> @@ -1650,10 +1651,30 @@ static bool riscv_cpu_has_max_extensions(Object *=
cpu_obj)
>      return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) !=3D NULL;
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *cs=
r_list)
> +{
> +    for (size_t i =3D 0; csr_list[i].csr_ops.name; i++) {
> +        int csrno =3D csr_list[i].csrno;
> +        const riscv_csr_operations *csr_ops =3D &csr_list[i].csr_ops;
> +        if (!csr_list[i].insertion_test || csr_list[i].insertion_test(cp=
u)) {
> +            riscv_set_csr_ops(csrno, csr_ops);
> +        }
> +    }
> +}
> +#endif
> +
>  static void riscv_tcg_cpu_instance_init(CPUState *cs)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
>      Object *obj =3D OBJECT(cpu);
> +#ifndef CONFIG_USER_ONLY
> +    RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(obj);
> +
> +    if (mcc->def->custom_csrs) {
> +        riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
> +    }
> +#endif
>
>      misa_ext_user_opts =3D g_hash_table_new(NULL, g_direct_equal);
>      multi_ext_user_opts =3D g_hash_table_new(NULL, g_direct_equal);
> --
> 2.43.0
>
>

