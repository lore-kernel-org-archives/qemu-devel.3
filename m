Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6ADCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 23:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9WyI-0006Va-Vo; Thu, 16 Oct 2025 19:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9WyE-0006Pt-QU
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:01:20 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9WyB-0006Sd-NL
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:01:18 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b5b823b4f3dso211061266b.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 16:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760655672; x=1761260472; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmwzeFYJww1IYHu4c0usXb9MSkExW7sj0fDjnN4RCmY=;
 b=a8gXu5Gc0fQ3th76jThWg3nX9p80arHca11njjAvs74TrLJf3TZAxeFES23YjAZ+Ij
 uwTEyA/bOc5Tm/fmLC/LwZEEcMW/R+21Lnb38KCOXiq/A4etfEoNfvOSmAkrufx8Z/gb
 kgxBYq4Pmdfytfuec1j6v6ynbYws11GJ18hlb+8V0eEb19Lxn8CyCeLDRZvA/UWgYW//
 2PrsxFO/x5b322RqHNy1AGv8t17uWh1dE+cjEHx35zIKHeuTFii5tcQ/30Khk0xY7bGy
 o6LgZI3kisDWhz9fG4i1oK42e/D7GphJX10L7MjYLY4vDGK43RUY1xzQlpcTGmGO2pD/
 XomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760655672; x=1761260472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmwzeFYJww1IYHu4c0usXb9MSkExW7sj0fDjnN4RCmY=;
 b=WkIiQUj9pW4J59zd2rd6u4NgzWLnuRNlWEo+U83bnEufx1Q6HKF/QlsHa0AcyWCfPb
 WoPfCWPvY4lmq4FZNdWfLDMkiCh0OUFW8D+FC44VwxkjWts2bqa+TRkcx7PvCvhCUo4T
 0YQakgFvsXZXMyZknoshJ6H/F2Kkk3IsfDG9zbqC2J770APZEfk/YghFTQdmKmNpZKjK
 n9RgHW/znkNfSwMjUOKtmuLKGjytpv7HUp975Q2N9130omO4pnurkCYBmdtcvU/dxw22
 eo8BOYIU83DAef7rcjFvfhD3hZr8jMosJVy45j5ksYPGr09pwjo9OwSjAPnNQTPNWWni
 hbvw==
X-Gm-Message-State: AOJu0YwfIDLtkylkNao/0s2wj6Fbj3reCvv78x4uLEXM52HrZXNwLh8A
 QVjwqB0FrB8JBy71MPd0pRvw5IEVW0G+Kl+YDBrNWGsP9HSHge1KEORi8XDb+5EcVHU8yUC/iC3
 KA68y5QsjGeB2jylHwjdKTR0ucqrYuBM07g==
X-Gm-Gg: ASbGncuDwCh/nEJn4N8TOX7sMxAd3GORFf17RAGxRjxDUgfsdxplC8tzOGdJHCkuGpe
 LIgQoLuxhkVAOfAptX+PICSysxTAqYU9DibJbLhM51rrLs5HpWw0nBIgEagjUtLDfR+BEgL30De
 hBf6WuvzhRGTvXPB5fWekojtp5gJQlkZytPjvhxZKbsaXcLExjPnCQUbL1+G94PyzQlqJI7XflW
 9igPxBBXpKgsgvxOQuPxDx08jOTaQMfRfh8356cyGs0tpKst+2k1MCzFcWhX4wpEMvJB6De8Bqf
 tyaUEezqKvsn4P+qbwFmgjwS3g==
X-Google-Smtp-Source: AGHT+IFr+b3tOPUZJPFvA+BzaMDn7FV4Iy0jW4L7sLWUmdEcc0HbPmatRtfFHNrd/35CxjgYO6dvRH8OAR6p3C3ETN8=
X-Received: by 2002:a17:907:3d91:b0:b30:2f6b:448f with SMTP id
 a640c23a62f3a-b6473245877mr199029066b.25.1760655671996; Thu, 16 Oct 2025
 16:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-22-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-22-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Oct 2025 09:00:45 +1000
X-Gm-Features: AS18NWArH3K35mSXzLz_DSM87Lkih2No393M0pgrw7Qa2qyNAYgdZMIAMeRIe4I
Message-ID: <CAKmqyKOYXki2mk-2yeqXyks8rctRGvb-+=AACuYngB4zPes-Fg@mail.gmail.com>
Subject: Re: [PATCH v3 21/34] target/riscv: Fix size of priv
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
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

On Wed, Oct 15, 2025 at 6:37=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> The priv field of CPUArchState only stores values in the range [0,3],
> fix to 8 bits in size and update relevant function arguments.  Introduce
> a new privilege_mode_t typedef for passing around the privilege mode.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        | 15 +++++++++++----
>  target/riscv/cpu_helper.c | 12 +++++++-----
>  target/riscv/machine.c    |  2 +-
>  3 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 37035a9541..1d5d74f11b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -109,6 +109,12 @@ typedef struct riscv_cpu_profile {
>
>  extern RISCVCPUProfile *riscv_profiles[];
>
> +/*
> + * Type large enough to hold all PRV_* fields, update CPUArchState::priv
> + * migration field if changing this type.
> + */
> +typedef uint8_t privilege_mode_t;
> +
>  /* Privileged specification version */
>  #define PRIV_VER_1_10_0_STR "v1.10.0"
>  #define PRIV_VER_1_11_0_STR "v1.11.0"
> @@ -264,7 +270,7 @@ struct CPUArchState {
>      uint32_t elf_flags;
>  #endif
>
> -    target_ulong priv;
> +    privilege_mode_t priv;
>      /* CSRs for execution environment configuration */
>      uint64_t menvcfg;
>      uint64_t senvcfg;
> @@ -650,10 +656,11 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *e=
nv, uint32_t priv,
>  RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t =
bit);
>  #endif /* !CONFIG_USER_ONLY */
>
> -void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool v=
irt_en);
> +void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
> +                        bool virt_en);
>
>  void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_lon=
g dst,
> -    enum CTRType type, target_ulong prev_priv, bool prev_virt);
> +    enum CTRType type, privilege_mode_t prev_priv, bool prev_virt);
>  void riscv_ctr_clear(CPURISCVState *env);
>
>  void riscv_translate_init(void);
> @@ -724,7 +731,7 @@ static inline int cpu_address_mode(CPURISCVState *env=
)
>      return mode;
>  }
>
> -static inline RISCVMXL cpu_get_xl(CPURISCVState *env, target_ulong mode)
> +static inline RISCVMXL cpu_get_xl(CPURISCVState *env, privilege_mode_t m=
ode)
>  {
>      RISCVMXL xl =3D env->misa_mxl;
>      /*
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 7790244d93..26c3c846a5 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -799,7 +799,7 @@ void riscv_ctr_clear(CPURISCVState *env)
>      memset(env->ctr_data, 0x0, sizeof(env->ctr_data));
>  }
>
> -static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
> +static uint64_t riscv_ctr_priv_to_mask(privilege_mode_t priv, bool virt)
>  {
>      switch (priv) {
>      case PRV_M:
> @@ -819,7 +819,8 @@ static uint64_t riscv_ctr_priv_to_mask(target_ulong p=
riv, bool virt)
>      g_assert_not_reached();
>  }
>
> -static uint64_t riscv_ctr_get_control(CPURISCVState *env, target_long pr=
iv,
> +static uint64_t riscv_ctr_get_control(CPURISCVState *env,
> +                                      privilege_mode_t priv,
>                                        bool virt)
>  {
>      switch (priv) {
> @@ -841,7 +842,8 @@ static uint64_t riscv_ctr_get_control(CPURISCVState *=
env, target_long priv,
>   * and src privilege is less than target privilege. This includes the vi=
rtual
>   * state as well.
>   */
> -static bool riscv_ctr_check_xte(CPURISCVState *env, target_long src_prv,
> +static bool riscv_ctr_check_xte(CPURISCVState *env,
> +                                privilege_mode_t src_prv,
>                                  bool src_virt)
>  {
>      target_long tgt_prv =3D env->priv;
> @@ -930,7 +932,7 @@ static bool riscv_ctr_check_xte(CPURISCVState *env, t=
arget_long src_prv,
>   *    idx =3D (sctrstatus.WRPTR - entry - 1) & (depth - 1);
>   */
>  void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_lon=
g dst,
> -    enum CTRType type, target_ulong src_priv, bool src_virt)
> +    enum CTRType type, privilege_mode_t src_priv, bool src_virt)
>  {
>      bool tgt_virt =3D env->virt_enabled;
>      uint64_t src_mask =3D riscv_ctr_priv_to_mask(src_priv, src_virt);
> @@ -1028,7 +1030,7 @@ void riscv_ctr_add_entry(CPURISCVState *env, target=
_long src, target_long dst,
>      env->sctrstatus =3D set_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK=
, head);
>  }
>
> -void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool v=
irt_en)
> +void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv, bo=
ol virt_en)
>  {
>      g_assert(newpriv <=3D PRV_M && newpriv !=3D PRV_RESERVED);
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index c55794c554..ce5e44325d 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -445,7 +445,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          VMSTATE_UINT32(env.misa_ext, RISCVCPU),
>          VMSTATE_UNUSED(4),
>          VMSTATE_UINT32(env.misa_ext_mask, RISCVCPU),
> -        VMSTATE_UINTTL(env.priv, RISCVCPU),
> +        VMSTATE_UINT8(env.priv, RISCVCPU),
>          VMSTATE_BOOL(env.virt_enabled, RISCVCPU),
>          VMSTATE_UINT64(env.resetvec, RISCVCPU),
>          VMSTATE_UINT64(env.mhartid, RISCVCPU),
> --
> 2.51.0
>
>

