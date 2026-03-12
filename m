Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22390103E2F0
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 00:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0TcY-0004jn-Or; Wed, 11 Mar 2026 20:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0TcW-0004jW-Rp
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 20:09:45 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0TcT-0001mN-1r
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 20:09:43 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so565374a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 17:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773274177; cv=none;
 d=google.com; s=arc-20240605;
 b=T0s/0clzq+mAVb0yyC5R7yyGag9DmGS/UcN7/PP3grjProwXns/FZtg+ds6DYHQeyk
 +APScTZWYtzX4InicpYESOuPjCtJoTTfJ/+ks1MELnmSMzzL+3eGnVqjevXeewFKPX4A
 YgUexN6DLl9S5HOu1MuWGEWCWLLfnWuSwLJTMWdaX3Fxwkb1iUtAG9KNvwovQmFeFnHi
 drt2tEZRXgJitjn1YjtXtpARDZbISPSPWPHSzOlaSVZlJIqQj9nx9q5Gv2qFAb6MDFvX
 Xu/vZiSWde8sp8cfzLqPEPGMhqBnAyoTPr/u1WIeSR4e7vYpzDh/GBabQBiAC8YuVnwF
 kZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4dLoxCBOpVBpr3TlpPBGzEGVsSlqNoYhBYZAtiJbCcQ=;
 fh=wXb1FGdrWTm8wdAKWZU5Dol2Y91CoZJOc78uN4ARPM0=;
 b=fLryKq4Q0TW1XFGhPsOkx6vPAGCdFNj4OXPLJu8MMHNtuxxVsgvI8ifGL54DuYJGoE
 Oovl6RY38PWTjNiWw0b6IgttjNelJp/4Q63x3N2uVnUSqG1mRz/7c4GUCkEPfVKCgi0C
 kR6GobwdTcnCvpdNgQ65QHOv1h+B0Kxh7H7cimj0xfcyj2Lo9cIoYEeBW2+4RYTiJaag
 GLfBb7RuPruKEg6ldXyGX5SJWabwHYUF6KFeggffD31lCkt1cPDO/BRFb6vzKqsEUMTE
 Q5Rk8xnzzfhm5YBZ1rDqJsx5JFOxGTU37PEGmhdfZl0U8PMTRfqZT9kwM1cc8Q3Xxc92
 bBLg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773274177; x=1773878977; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4dLoxCBOpVBpr3TlpPBGzEGVsSlqNoYhBYZAtiJbCcQ=;
 b=Ycu7oVEC3nUO53hrk9PwRCPWnMG/+I8G3qz/8PbnzM7B4pUMEQYaT7lwywhzJzyODL
 ayoIt2BnPkusaeaJEWQCJkrfQxtfyLDomtcm6wpyaITRLLubq9cb6jXw2zOWsOj4RSrp
 vQusm0fDr2eMqk4+uFhHnW6HBOP6GSkx26IDFqQY25hnnukk9KxwstuA6DsAgGyaSdtD
 4G0ULxy7JM6+eFlBjYAEhlZJSxQEFYC7/M70knB85/nGKouM/xpdQCzczDSS1E7BIR9T
 ezNfCIvupBs1FGlg6HW5Zuk21WwQgiXBjN2wm2ao7E6SNO0tTffartE8AdjZM2ZCwiQ7
 d62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773274177; x=1773878977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4dLoxCBOpVBpr3TlpPBGzEGVsSlqNoYhBYZAtiJbCcQ=;
 b=MuWCekW8vlASKvlk2NzOQEwpHcz3eBBgyQNi2SSbDtC3bERGY3J0yRldCfVG0P8Q3W
 WZE3/a1YGiinv5+Lv04KvCyiMJE7Ypkuk7d6NTi3PV/ADJ+kuqk5DeZtWxJ4KSceDD+v
 4PrpQZtSbRpGYyVZS59dNbsxo9Bve/QLWGB88sOf9vV6snsjp/zyWUl2lp4ZMcsJbPT2
 WkYtI8W2bz0HFRJPQIX1xZbY8ddguxYvk3Xo1SzBf/BdDl3GOrsTxytMiPHuIvGPjrl4
 q8gH8LpOHGaBN6kVqPQydKktF79sI3mbVuRLN9CjPi9P11EtBnjfzH/eTZ+wZ7ZJn5Gv
 CRzg==
X-Gm-Message-State: AOJu0YyHf+9JB2dFOnTyNgM1AbBo4XT83UGWwOKiTQ4Xp5DxDF7LHJo8
 1e/aKuQtG2HDgyVHeXvAkNKD176ey8PVyGDmPN73G7+hBXCb/Sh2upz8IJxoF4dzRF/Xnal7Qqa
 VEv8qwD4BbAARPrhQ/8gWMkaOoK0pkFs=
X-Gm-Gg: ATEYQzwXY3VUwi4r8wEiZ0FwtFysAD2JnMD3S75fgzC3rSM5+cqBjrgmGVvtoEvVL+4
 crTlG+zNo0qnQNgiwpyVo2PjZ5W9AGaDd8UkyN/HoqyAEvtxiLZgvI+RGKvX5yFMrftJYWJfOI3
 Fp6XMgZ9iVC+adq3kdF0oGibCcpXwPBYJLKmI6bPLnSAEQw+N3FsaqJkJp22e3MqzJz46AS6Zl3
 DZeXtnIwimeXjOdGzn3z7CEzoJymy+6qZuxIitkRen63V2hD2AxDtN5AQ2SmEadiG7oS/9sJfvo
 cae8Ef1FaD9qH/iHl0zfXUN/OWIFhfYEGTLTs82V76AGUY1e
X-Received: by 2002:a05:6402:354f:b0:662:9f1c:8023 with SMTP id
 4fb4d7f45d1cf-66319dcf75bmr2310586a12.21.1773274176887; Wed, 11 Mar 2026
 17:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260305034429.74739-1-jay.chang@sifive.com>
In-Reply-To: <20260305034429.74739-1-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Mar 2026 10:09:10 +1000
X-Gm-Features: AaiRm51vkjxxTXAdHSZMDeyxiaAcLuZqwHQoogsQj-RZ8INEq7iux7sWIg1b4GM
Message-ID: <CAKmqyKPM_pw+b4cE=2JLmvLDGfZpcdPe6Xhn3+qGaYmbDYtdLQ@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv: Support Smpmpmt extension
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
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

On Thu, Mar 5, 2026 at 1:45=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wro=
te:
>
> The Smpmpmt extension provides a mechanism to control memory attributes
> at the granularity of PMP (Physical Memory Protection) registers, similar
> to how Svpbmt controls memory attributes at the page level.
>
> Version 0.6
> https://github.com/riscv/riscv-isa-manual/blob/smpmpmt/src/smpmpmt.adoc#s=
vpbmt
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

>
> ---
> v2:
>     Place smpmpmt in the correct riscv,isa order.
> v3:
>     Add note comment in pmp_hart_has_privs() explaining that MT field
>     is stored but not acted upon during access checks.
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> ---
>  target/riscv/cpu.c                |  2 ++
>  target/riscv/cpu_cfg_fields.h.inc |  1 +
>  target/riscv/pmp.c                | 16 ++++++++++++++++
>  target/riscv/pmp.h                |  1 +
>  4 files changed, 20 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 9be79622f4..8ac935ac06 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -223,6 +223,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
>      ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> +    ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
>      ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>      ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
>      ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
> @@ -1276,6 +1277,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
>      MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
>      MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
> +    MULTI_EXT_CFG_BOOL("smpmpmt", ext_smpmpmt, false),
>      MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
>      MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
>      MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index 70ec650abf..cd1a5ec56b 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -59,6 +59,7 @@ BOOL_FIELD(ext_svadu)
>  BOOL_FIELD(ext_svinval)
>  BOOL_FIELD(ext_svnapot)
>  BOOL_FIELD(ext_svpbmt)
> +BOOL_FIELD(ext_smpmpmt)
>  BOOL_FIELD(ext_svrsw60t59b)
>  BOOL_FIELD(ext_svvptc)
>  BOOL_FIELD(ext_svukte)
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 3ef62d26ad..5391caa59c 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -165,6 +165,18 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32=
_t pmp_index, uint8_t val)
>                            "ignoring pmpcfg write - invalid\n");
>          } else {
>              uint8_t a_field =3D pmp_get_a_field(val);
> +
> +            if (!riscv_cpu_cfg(env)->ext_smpmpmt) {
> +                /* If smpmpmt not supported, clear the MTMATCH bit */
> +                val &=3D ~PMP_MTMATCH;
> +            } else if ((val & PMP_MTMATCH) =3D=3D PMP_MTMATCH) {
> +                /*
> +                 * If trying to set reserved value (0x3) for MT field,
> +                 * preserve the original MT field from current config.
> +                 */
> +                val =3D (val & ~PMP_MTMATCH) |
> +                    (env->pmp_state.pmp[pmp_index].cfg_reg & PMP_MTMATCH=
);
> +            }
>              /*
>               * When granularity g >=3D 1 (i.e., granularity > 4 bytes),
>               * the NA4 (Naturally Aligned 4-byte) mode is not selectable
> @@ -355,6 +367,10 @@ static bool pmp_hart_has_privs_default(CPURISCVState=
 *env, pmp_priv_t privs,
>   * Check if the address has required RWX privs to complete desired opera=
tion
>   * Return true if a pmp rule match or default match
>   * Return false if no match
> + *
> + * Note: The MT (Memory Type) field from Smpmpmt extension is stored in
> + * pmpcfg but is not acted upon during access checks. Cache attributes
> + * have no functional impact in QEMU emulation.
>   */
>  bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
>                          target_ulong size, pmp_priv_t privs,
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index 271cf24169..467fb6b4b1 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -29,6 +29,7 @@ typedef enum {
>      PMP_WRITE =3D 1 << 1,
>      PMP_EXEC  =3D 1 << 2,
>      PMP_AMATCH =3D (3 << 3),
> +    PMP_MTMATCH =3D (3 << 5),
>      PMP_LOCK  =3D 1 << 7
>  } pmp_priv_t;
>
> --
> 2.48.1
>
>

