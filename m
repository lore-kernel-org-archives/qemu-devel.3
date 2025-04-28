Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F73C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 22:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9X3w-0006GZ-2h; Mon, 28 Apr 2025 18:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9X3t-0006Fc-9Q; Mon, 28 Apr 2025 18:34:53 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9X3m-0001NJ-Qe; Mon, 28 Apr 2025 18:34:52 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-51eb1a714bfso5534464e0c.3; 
 Mon, 28 Apr 2025 15:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745879680; x=1746484480; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LE3A44mNeA8mSjrMIzXaLAbGpym24rRLNlv/G4ej/EE=;
 b=G4Bh80n2zc1ZvULPMcz+DiX328UnehURPY6v+GAm1yStiyHvnnA11yiTDIzF/loV5d
 eahEtErqlPRpS7RcW2jCODvI2z7ZIE5npW2bEKR4DWwd11zb9SpIsGa528suNg9u5aSi
 fdBNFcden3EAIgstrPgvXYPlm5AZQs8wowjrQwKA7s5RDfO5ofRR2KNlGz6JLqUH7gCH
 1szBAqKPEiwyc9R3q8Qa/BqX+tjBLmeJOu3vCHN6edWsoTwAeEha8yHnL/6nJadZvG/T
 wYOHFBYW14ycEmDfzpZ2gw4XSi1x08OaEX29e8nVDwtEYbnAZOaxuwVC/1NFvNNVpei6
 iX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745879680; x=1746484480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LE3A44mNeA8mSjrMIzXaLAbGpym24rRLNlv/G4ej/EE=;
 b=g74h1j9Eyh654gMwTTkSyBwbQO47IlfxMuFCaXRrxSx9bxF/IfzmYH9JSxdcjP6neC
 /Jg+ltAuwqbr8oEXK+YpDw+GmagAFZvO/soKQARyR8QgRUxIdJiLb9X5sUgp9/i3HexS
 //6nj8QrbDUjwfgGswmNBqb7go511FRwgMtCq4nmcpL+mtA9ypUt+m0Dd4QJZdBse3g/
 Bgl6d6kV0QiBwONhGo15fVYKsEvvjc70HO9F03+1lNT+YhpSUNZCD0gc6Plr3oBl2d8s
 DSexjNJHF/gTkQTOcyMAPRiJlXMuEV+Fc5Ul9R6mBIajDOFMrtI2CqSy0/D/z/QPxp5B
 41zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH510nDLhZWELYvEn9fOvbSfRBTdp19hvFm97JzbyIK8mLEFDTSl5NG6rSoDBal7u753ZsNyGuNOku@nongnu.org
X-Gm-Message-State: AOJu0YyIp6e8bMagu/je1rYmYK4URICSf9CQ9vJaEPtPxsM5+jKy/m9K
 oF/JH6/O+rWbTQ3gtljAZvy2TFkSF07bu2jdQU/WtUAdRPTUVQsJGxpq6AvJ/23CskNwCMH25gA
 9AAJORs0Fy9TmVe4OdMnMEJpdYrU=
X-Gm-Gg: ASbGncssFfAamU+WiFhbwBIt54uEpDUvQVbbaob5p+AsybfZ+3krdGNJLEmCoOh0p/7
 kaIGk4askehvXNup6du1Z62wQBKqXaUbA1pvUbvPnpGbgxNegsfORIrgh4DQx/qyB2jP3f+yj9l
 8QOhTjiehIegckW6sAnd4UBYcFl876m5faTP8k9Ru+AbdpvN2iW9pW
X-Google-Smtp-Source: AGHT+IEB4PiQSUScybwlXjV0mTNr+2gd9UrvQcdO4fg0F/+hCo9vtQDNT/QY/aMSxVOPr4SynCfiBb0RY2+h4cuPfiQ=
X-Received: by 2002:a05:6102:152a:b0:4c5:1bb6:8165 with SMTP id
 ada2fe7eead31-4daa9332b9amr579957137.12.1745879679667; Mon, 28 Apr 2025
 15:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250425152311.804338-1-richard.henderson@linaro.org>
 <20250425152311.804338-3-richard.henderson@linaro.org>
In-Reply-To: <20250425152311.804338-3-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Apr 2025 08:34:13 +1000
X-Gm-Features: ATxdqUFMrprqmejQxY6jcMyjt3L6LKP-4f6a5eRyqR8FlJiq_Rm9IRtAZnASVEs
Message-ID: <CAKmqyKNr0-su0dOvs+OQPMGsoyh61d4e4Kdb=Wayakh-FCz6nA@mail.gmail.com>
Subject: Re: [PATCH 2/7] target/riscv: Pass ra to riscv_csrrw_do64
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
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

On Sat, Apr 26, 2025 at 1:25=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 6f1f69eba6..e9c2f95b6e 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5516,7 +5516,8 @@ static inline RISCVException riscv_csrrw_check(CPUR=
ISCVState *env,
>  static RISCVException riscv_csrrw_do64(CPURISCVState *env, int csrno,
>                                         target_ulong *ret_value,
>                                         target_ulong new_value,
> -                                       target_ulong write_mask)
> +                                       target_ulong write_mask,
> +                                       uintptr_t ra)
>  {
>      RISCVException ret;
>      target_ulong old_value =3D 0;
> @@ -5546,7 +5547,7 @@ static RISCVException riscv_csrrw_do64(CPURISCVStat=
e *env, int csrno,
>      if (write_mask) {
>          new_value =3D (old_value & ~write_mask) | (new_value & write_mas=
k);
>          if (csr_ops[csrno].write) {
> -            ret =3D csr_ops[csrno].write(env, csrno, new_value, 0);
> +            ret =3D csr_ops[csrno].write(env, csrno, new_value, ra);
>              if (ret !=3D RISCV_EXCP_NONE) {
>                  return ret;
>              }
> @@ -5569,7 +5570,7 @@ RISCVException riscv_csrr(CPURISCVState *env, int c=
srno,
>          return ret;
>      }
>
> -    return riscv_csrrw_do64(env, csrno, ret_value, 0, 0);
> +    return riscv_csrrw_do64(env, csrno, ret_value, 0, 0, 0);
>  }
>
>  RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
> @@ -5581,7 +5582,7 @@ RISCVException riscv_csrrw(CPURISCVState *env, int =
csrno,
>          return ret;
>      }
>
> -    return riscv_csrrw_do64(env, csrno, ret_value, new_value, write_mask=
);
> +    return riscv_csrrw_do64(env, csrno, ret_value, new_value, write_mask=
, 0);
>  }
>
>  static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
> @@ -5647,9 +5648,7 @@ RISCVException riscv_csrr_i128(CPURISCVState *env, =
int csrno,
>       * accesses
>       */
>      target_ulong old_value;
> -    ret =3D riscv_csrrw_do64(env, csrno, &old_value,
> -                           (target_ulong)0,
> -                           (target_ulong)0);
> +    ret =3D riscv_csrrw_do64(env, csrno, &old_value, 0, 0, 0);
>      if (ret =3D=3D RISCV_EXCP_NONE && ret_value) {
>          *ret_value =3D int128_make64(old_value);
>      }
> @@ -5681,7 +5680,7 @@ RISCVException riscv_csrrw_i128(CPURISCVState *env,=
 int csrno,
>      target_ulong old_value;
>      ret =3D riscv_csrrw_do64(env, csrno, &old_value,
>                             int128_getlo(new_value),
> -                           int128_getlo(write_mask));
> +                           int128_getlo(write_mask), 0);
>      if (ret =3D=3D RISCV_EXCP_NONE && ret_value) {
>          *ret_value =3D int128_make64(old_value);
>      }
> --
> 2.43.0
>
>

