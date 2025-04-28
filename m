Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308DDC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 22:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9X6g-0000hJ-Dv; Mon, 28 Apr 2025 18:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9X6e-0000fE-6l; Mon, 28 Apr 2025 18:37:44 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9X6X-0001rw-TT; Mon, 28 Apr 2025 18:37:43 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-877c48657f9so1247968241.1; 
 Mon, 28 Apr 2025 15:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745879846; x=1746484646; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xXwSa+gw10RWSBVuFTIf/YMq30a60MmJPe7AW9WDaI=;
 b=gNGwSo+PvLMfiGK3P1ubd/IWGso/gYpE7dbFhwvONSomW61jRcskB3K4Zl0uOMkwVw
 c1JowP/DwiREEsBrzFX8plKOS4yQyDMk/iavP+iWsDEEFtTjrpcDdML/+V9k3K0Vqjq9
 uHYajUqD10haT5H9HpdsHvqcxLywQlIWm/YBssNuG1j8zmQWI/2RgwWSfJ2nqzkHxO9K
 Jye45GlEgy9kv7V3FuOTUfc4eM+CLjmlraeowPw7swtfViE+ZtkYtt5+4C3f5SAnZ9j9
 hkDz/tA0zpt2OTzBF3B4zgQhpqC30wQy44vzKbvpgbQzy3p2mr7xSqpHd0G0qtdHDJ30
 ENFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745879846; x=1746484646;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xXwSa+gw10RWSBVuFTIf/YMq30a60MmJPe7AW9WDaI=;
 b=IEX/U1a8bejKsywwgYBJtYW3mnYCwR4Axf/0eOQf8UNzo80X7NkGzU7cas8cDDikYS
 aUUYhWXEWi17qrwgwyLFYsLGruxZTfe6B2PnaiS1xX/AoKn11ov328zTw3XqjKglE2S3
 dPBI8fnofhu4zColUoi1qzEHGDpX5heFDHDZPbcO6mojEL6f/70OZ+jqZ6fo//QKC85z
 2fSyi5M4KLhjVcp/YRMRa0qhu/+mtcyzpBUMTX5A0HKqxft1w51S2KSRlEyGSffziiWR
 vbSQGGLZdXjMnwkSiUA3vapakbtaMalX7ktb79HwfzLRHgcmmyB1qPb9DfShy7xtYV6Y
 ixIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJM271wAgDs7rOwM97E2gZukTDLF/36notXtgkqyh4z8RpEJ/qahW7FsPGS4mvgyXfxeQE2O+72rSd@nongnu.org
X-Gm-Message-State: AOJu0Yybs/Z/tBFX2DIMfrGC/weOZD924oqngNrCbHXONhNmXAFGDP0d
 CJeVOdyCkiPS9dh578BdjDFtGL2TmefWmtKUB+/P1+XV9bmABUM+6/Z5jnkhpMld+z5VO/hSTQa
 5yg6GKmL5WJ77fxYG3erJQak4H1ZJIw==
X-Gm-Gg: ASbGncuqfOxnwuZFRf9jattOYwvIyTEZd4i9pxwCvOSafnpmmcYwdbrZkGvK0xM5I4H
 AXp1ygSEuR/9MIdgtVTbaMoK5pRh6HeQpPybSsePrh/ETi8fYEBsD+ysQI8OZYVDMNXq1riOzEz
 UkMvfxDlwrrQuYpRPJhqKZZO7mAwt4W6V/sJ8nCsdk/CAkdpzQpDYq
X-Google-Smtp-Source: AGHT+IGV2vAKqerYSeeEsmF6biff+2M0r4Cmr5fKh7mujET6C18uhFMGO+X2vDGNxqpahpqz5RnVPRiCo9dzPQq0u9c=
X-Received: by 2002:a05:6102:dce:b0:4c1:774b:3f7a with SMTP id
 ada2fe7eead31-4d641f618b5mr6957939137.16.1745879846270; Mon, 28 Apr 2025
 15:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250425152311.804338-1-richard.henderson@linaro.org>
 <20250425152311.804338-6-richard.henderson@linaro.org>
In-Reply-To: <20250425152311.804338-6-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Apr 2025 08:37:00 +1000
X-Gm-Features: ATxdqUGvXAAk0GOyDpmkKNwP_IoIpg5RREVDC6n8ztucxWOEN-NjRMwYc0gSS1A
Message-ID: <CAKmqyKP3Yp6osXE=K2TmiVSjHZK+eLoT2gQydv=9mxnESdM3pQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] target/riscv: Pass ra to riscv_csrrw_i128
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Sat, Apr 26, 2025 at 1:23=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h       | 4 ++--
>  target/riscv/csr.c       | 8 ++++----
>  target/riscv/op_helper.c | 9 +++++----
>  3 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 2c0524d0be..8b84793b15 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -851,8 +851,8 @@ typedef RISCVException (*riscv_csr_op_fn)(CPURISCVSta=
te *env, int csrno,
>  RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
>                                 Int128 *ret_value);
>  RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
> -                                Int128 *ret_value,
> -                                Int128 new_value, Int128 write_mask);
> +                                Int128 *ret_value, Int128 new_value,
> +                                Int128 write_mask, uintptr_t ra);
>
>  typedef RISCVException (*riscv_csr_read128_fn)(CPURISCVState *env, int c=
srno,
>                                                 Int128 *ret_value);
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 097640e25d..a663f527a4 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5656,8 +5656,8 @@ RISCVException riscv_csrr_i128(CPURISCVState *env, =
int csrno,
>  }
>
>  RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
> -                                Int128 *ret_value,
> -                                Int128 new_value, Int128 write_mask)
> +                                Int128 *ret_value, Int128 new_value,
> +                                Int128 write_mask, uintptr_t ra)
>  {
>      RISCVException ret;
>
> @@ -5668,7 +5668,7 @@ RISCVException riscv_csrrw_i128(CPURISCVState *env,=
 int csrno,
>
>      if (csr_ops[csrno].read128) {
>          return riscv_csrrw_do128(env, csrno, ret_value,
> -                                 new_value, write_mask, 0);
> +                                 new_value, write_mask, ra);
>      }
>
>      /*
> @@ -5681,7 +5681,7 @@ RISCVException riscv_csrrw_i128(CPURISCVState *env,=
 int csrno,
>      target_ulong old_value;
>      ret =3D riscv_csrrw_do64(env, csrno, &old_value,
>                             int128_getlo(new_value),
> -                           int128_getlo(write_mask), 0);
> +                           int128_getlo(write_mask), ra);
>      if (ret =3D=3D RISCV_EXCP_NONE && ret_value) {
>          *ret_value =3D int128_make64(old_value);
>      }
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index aee16e2e3a..e3770a2655 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -108,7 +108,7 @@ void helper_csrw_i128(CPURISCVState *env, int csr,
>  {
>      RISCVException ret =3D riscv_csrrw_i128(env, csr, NULL,
>                                            int128_make128(srcl, srch),
> -                                          UINT128_MAX);
> +                                          UINT128_MAX, GETPC());
>
>      if (ret !=3D RISCV_EXCP_NONE) {
>          riscv_raise_exception(env, ret, GETPC());
> @@ -116,13 +116,14 @@ void helper_csrw_i128(CPURISCVState *env, int csr,
>  }
>
>  target_ulong helper_csrrw_i128(CPURISCVState *env, int csr,
> -                       target_ulong srcl, target_ulong srch,
> -                       target_ulong maskl, target_ulong maskh)
> +                               target_ulong srcl, target_ulong srch,
> +                               target_ulong maskl, target_ulong maskh)
>  {
>      Int128 rv =3D int128_zero();
>      RISCVException ret =3D riscv_csrrw_i128(env, csr, &rv,
>                                            int128_make128(srcl, srch),
> -                                          int128_make128(maskl, maskh));
> +                                          int128_make128(maskl, maskh),
> +                                          GETPC());
>
>      if (ret !=3D RISCV_EXCP_NONE) {
>          riscv_raise_exception(env, ret, GETPC());
> --
> 2.43.0
>
>

