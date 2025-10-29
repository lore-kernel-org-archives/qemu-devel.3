Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4950CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2W4-00014H-5B; Wed, 29 Oct 2025 05:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE2W0-00013l-9T
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:30:50 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE2Vs-000725-H9
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:30:47 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b3b27b50090so1246202566b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 02:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761730237; x=1762335037; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjtERFwEfJo8YNRUSkD5XA213cdj7flN3ypYiQVDpUc=;
 b=PkBvLDmSjS8e2ioGKmbhCWV7NSZnkOlkQng7CsYzpYsHs2IxlMwidB3Xf6OiuPK/7Y
 gNvkNXjknOOPU7g+ArADq93tlc/24irw8NE+hrRqdJaXp6ZQ8hf79nT6wnQwpLL/AcJP
 tDe5s/GtXCWm5E0009yi7hiaVx9Z7JeP5DmLiri9fgdHIYyUsaEqL1nMVgl6iFE0nAUP
 +KxgR1fh7vJAZWzLSDKFfmeRhL64v7TD8tMnq60+kkNhWU38l+bEntvS3B7LYn2glia0
 yaaDxY+mEoyWy13QBTPeNyeqzWQ+u2JPFRCthZHvWqiSXAuPzL9BC3iFz0eI0kVvPUas
 RUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761730237; x=1762335037;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qjtERFwEfJo8YNRUSkD5XA213cdj7flN3ypYiQVDpUc=;
 b=e7nP18n1YfTBDozsTtBzrC1sNYqnBU5KvdQDwHjUmOsbNrDBme9Gy62qjpHguBwOPC
 gS3rlQRiyBQvF6A9epAqjIa69mgJJljDPybnJ2nx+bG/ZAQmJhHAQs+b9h3kyRP8N9oE
 86MgnAwGZF+WelVI9zYUE0RIyohZMja8M5xxjdtPwIGOugILkKhedin3Mt9Tvv7HfDAU
 ZwW/mEm2wGc36irrDRt1tbuD6D5MsEMxHdm7H1UNXZD1OaQUPDE//1knNgBxXgDeCda/
 QJqDTTzq/84ncVjInbbDZDjKbnHDYghY+HUtbPeEkXUYArRxo/H3diOPW12e+YvhdYe3
 g+Sg==
X-Gm-Message-State: AOJu0YxC4pW/UZor7cK+WA4tuMLlAHDsrWOMd2byVZIhlyjDXxeMApOC
 v7B3r0oe8JjewAedMVVTwf9zmv/Zo6VZi/IPkuiAA/DOlGK8/lNidmNrE5BKl21s3i78rvR9aqS
 KjgTS//7B0YsyLOJZelm7nRUA+XuhzvNaA04ohL4X/g==
X-Gm-Gg: ASbGnctuEhZcUk+YpImMuwuCl6k2SmPf2daugvFYjEbjFxN5YWL7EjDHXs8TWLq6Yu4
 RWdy4rq7VOpjfL0CNLo3dYSH0x3CJHS4u52ttd9640GNjAJA+5tkvla5T7+9b3A9WdnxWLMxUBf
 9pG35TQzeh3MoOJO/QoQ28d8S6T8XaAEFcK/jrGwK59QOKz5M2F69VrDrivQEUqqvtzm47sA183
 +chTb5YMbFsgyuoeX/cEKmVmhWZXgu46xS8oj/RT2dVCKKjSQE07MjzaSnf
X-Google-Smtp-Source: AGHT+IHXLVzQhdSScxV5VPonDd7eOoytaOKnujb5um20hlOL6ENQWHjhH3ra2pgziMXm+/LIzxHL1i7TogB+CL4ipXM=
X-Received: by 2002:a17:907:3e0d:b0:b6d:7ad8:23f9 with SMTP id
 a640c23a62f3a-b703d311050mr211682466b.16.1761730237133; Wed, 29 Oct 2025
 02:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250928163155.1472914-1-richard.henderson@linaro.org>
 <20250928163155.1472914-5-richard.henderson@linaro.org>
In-Reply-To: <20250928163155.1472914-5-richard.henderson@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 29 Oct 2025 11:30:10 +0200
X-Gm-Features: AWmQ_bnYISAIcDMA16SE5whJ89w--mSUqwgsJDFKjAQNo39mIiatKO-ozM4Tyh0
Message-ID: <CAAjaMXab1HbSQgB8txAat657efNDpXpQ-XmOH8FwX6Sow-79uw@mail.gmail.com>
Subject: Re: [PATCH 4/5] tcg: Expand missing rotri with extract2
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sun, Sep 28, 2025 at 7:33=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use extract2 to implement rotri.  To make this easier,
> redefine rotli in terms of rotri, rather than the reverse.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op.c | 70 ++++++++++++++++++++++++++++++----------------------
>  1 file changed, 41 insertions(+), 29 deletions(-)
>
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 4caf77da1e..3e10a3ad16 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -834,23 +834,12 @@ void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, =
TCGv_i32 arg2)
>  void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>  {
>      tcg_debug_assert(arg2 >=3D 0 && arg2 < 32);
> -    /* some cases can be optimized here */
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i32(ret, arg1);
>      } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
> -        TCGv_i32 t0 =3D tcg_constant_i32(arg2);
> -        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, t0);
> -    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
> -        TCGv_i32 t0 =3D tcg_constant_i32(32 - arg2);
> -        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, t0);
> +        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(arg2)=
);
>      } else {
> -        TCGv_i32 t0 =3D tcg_temp_ebb_new_i32();
> -        TCGv_i32 t1 =3D tcg_temp_ebb_new_i32();
> -        tcg_gen_shli_i32(t0, arg1, arg2);
> -        tcg_gen_shri_i32(t1, arg1, 32 - arg2);
> -        tcg_gen_or_i32(ret, t0, t1);
> -        tcg_temp_free_i32(t0);
> -        tcg_temp_free_i32(t1);
> +        tcg_gen_rotri_i32(ret, arg1, -arg2 & 31);
>      }
>  }
>
> @@ -878,7 +867,16 @@ void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, T=
CGv_i32 arg2)
>  void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>  {
>      tcg_debug_assert(arg2 >=3D 0 && arg2 < 32);
> -    tcg_gen_rotli_i32(ret, arg1, -arg2 & 31);
> +    if (arg2 =3D=3D 0) {
> +        tcg_gen_mov_i32(ret, arg1);
> +    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
> +        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, tcg_constant_i32(arg2)=
);
> +    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
> +        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(32 - =
arg2));
> +    } else {
> +        /* Do not recurse with the rotri simplification. */
> +        tcg_gen_op4i_i32(INDEX_op_extract2, ret, arg1, arg1, arg2);
> +    }
>  }
>
>  void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
> @@ -2417,23 +2415,12 @@ void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1=
, TCGv_i64 arg2)
>  void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>  {
>      tcg_debug_assert(arg2 >=3D 0 && arg2 < 64);
> -    /* some cases can be optimized here */
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i64(ret, arg1);
> -    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
> -        TCGv_i64 t0 =3D tcg_constant_i64(arg2);
> -        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, t0);
> -    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
> -        TCGv_i64 t0 =3D tcg_constant_i64(64 - arg2);
> -        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, t0);
> +    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {

Shouldn't this be:

s/TCG_TYPE_I32/TCG_TYPE_I64

?

> +        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(arg2)=
);
>      } else {
> -        TCGv_i64 t0 =3D tcg_temp_ebb_new_i64();
> -        TCGv_i64 t1 =3D tcg_temp_ebb_new_i64();
> -        tcg_gen_shli_i64(t0, arg1, arg2);
> -        tcg_gen_shri_i64(t1, arg1, 64 - arg2);
> -        tcg_gen_or_i64(ret, t0, t1);
> -        tcg_temp_free_i64(t0);
> -        tcg_temp_free_i64(t1);
> +        tcg_gen_rotri_i64(ret, arg1, -arg2 & 63);
>      }
>  }
>
> @@ -2461,7 +2448,32 @@ void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1,=
 TCGv_i64 arg2)
>  void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>  {
>      tcg_debug_assert(arg2 >=3D 0 && arg2 < 64);
> -    tcg_gen_rotli_i64(ret, arg1, -arg2 & 63);
> +    if (arg2 =3D=3D 0) {
> +        tcg_gen_mov_i64(ret, arg1);
> +    } else if (TCG_TARGET_REG_BITS =3D=3D 32) {
> +        TCGv_i32 rl =3D tcg_temp_ebb_new_i32();
> +        TCGv_i32 rh =3D TCGV_HIGH(ret);
> +        TCGv_i32 t0, t1;
> +
> +        if (arg2 & 32) {
> +            t0 =3D TCGV_HIGH(arg1);
> +            t1 =3D TCGV_LOW(arg1);
> +        } else {
> +            t0 =3D TCGV_LOW(arg1);
> +            t1 =3D TCGV_HIGH(arg1);
> +        }
> +        tcg_gen_extract2_i32(rl, t0, t1, arg2 & 31);
> +        tcg_gen_extract2_i32(rh, t1, t0, arg2 & 31);
> +        tcg_gen_mov_i32(TCGV_LOW(ret), rl);
> +        tcg_temp_free_i32(rl);
> +    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
> +        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, tcg_constant_i64(arg2)=
);
> +    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
> +        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(64 - =
arg2));
> +    } else {
> +        /* Do not recurse with the rotri simplification. */
> +        tcg_gen_op4i_i64(INDEX_op_extract2, ret, arg1, arg1, arg2);
> +    }
>  }
>
>  void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
> --
> 2.43.0
>
>

