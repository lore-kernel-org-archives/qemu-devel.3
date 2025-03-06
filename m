Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03778C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4ZA-0003fM-JV; Thu, 06 Mar 2025 01:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq4Ys-0003IU-IQ; Thu, 06 Mar 2025 01:18:29 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq4Yp-0003eY-4H; Thu, 06 Mar 2025 01:18:26 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-523cbce071bso118472e0c.0; 
 Wed, 05 Mar 2025 22:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741241901; x=1741846701; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6BM8CTonOD41abNgTsIDQXYLsdWl2uI7cynfSO39ShQ=;
 b=TNaDpkJ5j4dGzmHFW+LYnuw7gD4FcsJ/geKqyI4H87iHgRGuvridkO1gk5udCGiNpB
 CUUyIdzmWxk0oZs4/ntK9v2JSqxJ6F53R3cTjpPxLqsLYrrjH+ztsHFgHwG0dIrpMJbA
 57laQ+BJPkQhnbTLZLH16ALxoYtX4y6PKMl8p3EsnoXeF9egsExkISRwOWHfrdQY7hjR
 AqFDg50pvqiZpKrP5P2hB0/Rnz99YJTtVZ7Bk7eEliP+aCXvl85OFa5VUPrbbwch1Yju
 GJKL2zPRQgq/cgeHrAsyDNrFuC2YCf+XnrQOFH+0SkK750MkGXaJzdYr/N65wwQHn7Xq
 pzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741241901; x=1741846701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6BM8CTonOD41abNgTsIDQXYLsdWl2uI7cynfSO39ShQ=;
 b=gvDX3ZGBDAcB+cfDDQCwn1P201GqS7o8kVLTH2F8ZZYKW4QYqYXz1tndIaNQvKXIiq
 44gujs/2fLmc/pPYroOMJ9ccWh4h8syWb2QKyLJ1i2WjBDg4qFcBmD/uqh672SZTiMUg
 zt3HnhqYtD9N3WNXenqLP2z41bMWH618ctpyjhATeK/i+tsmBacfIwZuH1ZkfwCcrp50
 kNm5PWggZPU2gw5kYOG1IChbmMg4nLRlZYxyqWP9xYaArFr4bG5motQCNBNb9z976O+Q
 Qi+YPAeVPGbNWXEOkOy+Pa74edCRVeeunWGc0auZI/Jh6o5P6hWb5B6OXHOfbtUG9IwY
 AU9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZqv+gkeGhVrSl4rPHO5Dt5mHRDNRsdiF1iNFMmPQii4NZn+R8lnvY65e7l+fPXiyCBm6Q51QjsJxu@nongnu.org
X-Gm-Message-State: AOJu0Yw8iG4Eh/srx4NQHbWSA9exHZLp5+yMoUROE215EG+BJWZNwj01
 E41Q+CNV8g0HX4fyy0g9shnd+irvduWQh7w7SFPrZdKZPuWARuT8zf/ot6RdOwjCv9uGzef3UA4
 GggD5oTahNJr2XKPQNJgCBNK8TRLqrztRe/DE6w==
X-Gm-Gg: ASbGncsAN8SrsiVYb8lsQyt64WJHLEDi00AYcYTXvPpJd+0QR3c4nkqcf/YuLV2lyqE
 t5ZwxeTILpuDX+phW7KAvd954BtJ8Davvn2NjSWPYCAWwD5n7jZ75vuXDvVhN8iryISswlbTOOV
 GcC3ltfjEyHaIq6fAwcBhDMsJH09V25K7Qm3pHixKR9a1vg/U/ma5wE781
X-Google-Smtp-Source: AGHT+IEcLQ0x6YmQ+PSfKR/iO5VuVWe8Z2M7I/U2LDAFcd4SU+ob8QdhdynQFRJQmOOEAOrUfNW1kNuuKsnafT91vnE=
X-Received: by 2002:a05:6102:1622:b0:4c1:9536:523e with SMTP id
 ada2fe7eead31-4c2e29bbf61mr4031029137.23.1741241900870; Wed, 05 Mar 2025
 22:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20250303093155.35585-1-florian.lugou@provenrun.com>
 <20250303093155.35585-3-florian.lugou@provenrun.com>
In-Reply-To: <20250303093155.35585-3-florian.lugou@provenrun.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 16:17:54 +1000
X-Gm-Features: AQ5f1JoHB4Lg3aC7I5HDC8u_AGk7xqbyBaYBgZn-89KIXZtrypW87SVjxEeU2UE
Message-ID: <CAKmqyKNUO1ruHijU2BxcBYzXQuvt=jA87L5O_b76hY5bYb1i3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/riscv: Support matching scontext in
 Sdtrig's textra CSRs
To: Florian Lugou <florian.lugou@provenrun.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Mon, Mar 3, 2025 at 7:38=E2=80=AFPM Florian Lugou
<florian.lugou@provenrun.com> wrote:
>
> Support setting textra32.sselect or textra64.sselect to 1 (scontext).
> The trigger will only match if the content of scontext matches the value
> in svalue, after it is masked as configured in sbytemask.

I don't think this matches the 0.13 debug spec [1].

If we want to support the newly ratified 1.0 spec as well we need to
communicate that to users. Ideally we want to support both versions
and let users choose, but it might be ok to just drop 0.13, as I get
the feeling it should not have been ratified.

1: https://github.com/riscv/riscv-debug-spec/releases/tag/task_group_vote

Alistair

>
> Signed-off-by: Florian Lugou <florian.lugou@provenrun.com>
> ---
>  target/riscv/debug.c | 75 +++++++++++++++++++++++++++++++-------------
>  target/riscv/debug.h |  3 ++
>  2 files changed, 57 insertions(+), 21 deletions(-)
>
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 072593ab12..a64dadf6d6 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -219,8 +219,8 @@ static inline void warn_always_zero_bit(target_ulong =
val, target_ulong mask,
>
>  static target_ulong textra_validate(CPURISCVState *env, target_ulong tda=
ta3)
>  {
> -    target_ulong mhvalue, mhselect;
> -    target_ulong mhselect_new;
> +    target_ulong mhvalue, mhselect, sbytemask, svalue, sselect;
> +    target_ulong mhselect_new, sselect_new;
>      target_ulong textra;
>      const uint32_t mhselect_no_rvh[8] =3D { 0, 0, 0, 0, 4, 4, 4, 4 };
>
> @@ -228,25 +228,17 @@ static target_ulong textra_validate(CPURISCVState *=
env, target_ulong tdata3)
>      case MXL_RV32:
>          mhvalue  =3D get_field(tdata3, TEXTRA32_MHVALUE);
>          mhselect =3D get_field(tdata3, TEXTRA32_MHSELECT);
> -        /* Validate unimplemented (always zero) bits */
> -        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SBYTEMASK,
> -                             "sbytemask");
> -        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SVALUE,
> -                             "svalue");
> -        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SSELECT,
> -                             "sselect");
> +        sbytemask  =3D get_field(tdata3, TEXTRA32_SBYTEMASK);
> +        svalue  =3D get_field(tdata3, TEXTRA32_SVALUE);
> +        sselect =3D get_field(tdata3, TEXTRA32_SSELECT);
>          break;
>      case MXL_RV64:
>      case MXL_RV128:
>          mhvalue  =3D get_field(tdata3, TEXTRA64_MHVALUE);
>          mhselect =3D get_field(tdata3, TEXTRA64_MHSELECT);
> -        /* Validate unimplemented (always zero) bits */
> -        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SBYTEMASK,
> -                             "sbytemask");
> -        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SVALUE,
> -                             "svalue");
> -        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SSELECT,
> -                             "sselect");
> +        sbytemask  =3D get_field(tdata3, TEXTRA64_SBYTEMASK);
> +        svalue  =3D get_field(tdata3, TEXTRA64_SVALUE);
> +        sselect =3D get_field(tdata3, TEXTRA64_SSELECT);
>          break;
>      default:
>          g_assert_not_reached();
> @@ -258,17 +250,34 @@ static target_ulong textra_validate(CPURISCVState *=
env, target_ulong tdata3)
>          qemu_log_mask(LOG_UNIMP, "mhselect only supports 0 or 4 for now\=
n");
>      }
>
> +    /* Validate sselect. */
> +    switch (sselect) {
> +    case SSELECT_IGNORE:
> +    case SSELECT_SCONTEXT:
> +        sselect_new =3D sselect;
> +        break;
> +    default:
> +        sselect_new =3D 0;
> +        qemu_log_mask(LOG_UNIMP, "sselect only supports 0 or 1 for now\n=
");
> +    }
> +
>      /* Write legal values into textra */
>      textra =3D 0;
>      switch (riscv_cpu_mxl(env)) {
>      case MXL_RV32:
> -        textra =3D set_field(textra, TEXTRA32_MHVALUE,  mhvalue);
> -        textra =3D set_field(textra, TEXTRA32_MHSELECT, mhselect_new);
> +        textra =3D set_field(textra, TEXTRA32_MHVALUE,   mhvalue);
> +        textra =3D set_field(textra, TEXTRA32_MHSELECT,  mhselect_new);
> +        textra =3D set_field(textra, TEXTRA32_SBYTEMASK, sbytemask);
> +        textra =3D set_field(textra, TEXTRA32_SVALUE,    svalue);
> +        textra =3D set_field(textra, TEXTRA32_SSELECT,   sselect_new);
>          break;
>      case MXL_RV64:
>      case MXL_RV128:
> -        textra =3D set_field(textra, TEXTRA64_MHVALUE,  mhvalue);
> -        textra =3D set_field(textra, TEXTRA64_MHSELECT, mhselect_new);
> +        textra =3D set_field(textra, TEXTRA64_MHVALUE,   mhvalue);
> +        textra =3D set_field(textra, TEXTRA64_MHSELECT,  mhselect_new);
> +        textra =3D set_field(textra, TEXTRA64_SBYTEMASK, sbytemask);
> +        textra =3D set_field(textra, TEXTRA64_SVALUE,    svalue);
> +        textra =3D set_field(textra, TEXTRA64_SSELECT,   sselect_new);
>          break;
>      default:
>          g_assert_not_reached();
> @@ -368,7 +377,7 @@ static bool trigger_textra_match(CPURISCVState *env, =
trigger_type_t type,
>                                   int trigger_index)
>  {
>      target_ulong textra =3D env->tdata3[trigger_index];
> -    target_ulong mhvalue, mhselect;
> +    target_ulong mhvalue, mhselect, sbytemask, svalue, sselect;
>
>      if (type < TRIGGER_TYPE_AD_MATCH || type > TRIGGER_TYPE_AD_MATCH6) {
>          /* textra checking is only applicable when type is 2, 3, 4, 5, o=
r 6 */
> @@ -379,11 +388,17 @@ static bool trigger_textra_match(CPURISCVState *env=
, trigger_type_t type,
>      case MXL_RV32:
>          mhvalue  =3D get_field(textra, TEXTRA32_MHVALUE);
>          mhselect =3D get_field(textra, TEXTRA32_MHSELECT);
> +        sbytemask =3D get_field(textra, TEXTRA32_SBYTEMASK);
> +        svalue =3D get_field(textra, TEXTRA32_SVALUE);
> +        sselect =3D get_field(textra, TEXTRA32_SSELECT);
>          break;
>      case MXL_RV64:
>      case MXL_RV128:
>          mhvalue  =3D get_field(textra, TEXTRA64_MHVALUE);
>          mhselect =3D get_field(textra, TEXTRA64_MHSELECT);
> +        sbytemask  =3D get_field(textra, TEXTRA64_SBYTEMASK);
> +        svalue  =3D get_field(textra, TEXTRA64_SVALUE);
> +        sselect =3D get_field(textra, TEXTRA64_SSELECT);
>          break;
>      default:
>          g_assert_not_reached();
> @@ -403,6 +418,24 @@ static bool trigger_textra_match(CPURISCVState *env,=
 trigger_type_t type,
>          break;
>      }
>
> +    target_ulong svalue_mask =3D ((sbytemask & 1) * 0xFF) |
> +        ((sbytemask & 2) * 0x7F80) | ((sbytemask & 4) * 0x3FC000) |
> +        ((sbytemask & 8) * 0x1FE00000);
> +
> +    /* Check svalue and sselect. */
> +    switch (sselect) {
> +    case SSELECT_IGNORE:
> +        break;
> +    case SSELECT_SCONTEXT:
> +        /* Match if the low bits of scontext equal svalue. */
> +        if ((svalue & svalue_mask) !=3D (env->scontext & svalue_mask)) {
> +            return false;
> +        }
> +        break;
> +    default:
> +        break;
> +    }
> +
>      return true;
>  }
>
> diff --git a/target/riscv/debug.h b/target/riscv/debug.h
> index f76b8f944a..16b66441ca 100644
> --- a/target/riscv/debug.h
> +++ b/target/riscv/debug.h
> @@ -134,6 +134,9 @@ enum {
>  #define MHSELECT_IGNORE       0
>  #define MHSELECT_MCONTEXT     4
>
> +#define SSELECT_IGNORE        0
> +#define SSELECT_SCONTEXT      1
> +
>  bool tdata_available(CPURISCVState *env, int tdata_index);
>
>  target_ulong tselect_csr_read(CPURISCVState *env);
> --
> 2.43.0
>
>

