Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3D2E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 05:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN3m4-0007G5-08; Mon, 16 Dec 2024 00:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tN3m1-0007F9-G5; Mon, 16 Dec 2024 00:36:05 -0500
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tN3lz-0000Q5-Ui; Mon, 16 Dec 2024 00:36:05 -0500
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4b10dd44c8bso647574137.3; 
 Sun, 15 Dec 2024 21:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734327362; x=1734932162; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1tbmBiLrQEo0aRwmdZeClIAM8Yoa18M7B3FLTJwOhU=;
 b=SG2McaK/qbbjn2Pohk9yuDqQ1uPanZ17RAiClJNATrxxJGeasqNkTASEtMc7DgOUvS
 aQQI41zX7XmOOdgylKRY7Wpxm0MZXf3icDZOWrE+2zgGIeSK4cw+mu1j81mT0tK0J1J9
 k1U/4tr1dut+rOfeo0fyrzUOtSJ1T1G6MMZbVMQIUzCo5y/RfLeM41RANgpMrR1Y5gEL
 VkBdv7RZf9dPvIgRJGGJ/QUt/pMDl5EFpyT029GlQfBY9AsDVGNwlt1L/Gc809d3bkRY
 2c0EfgZoistlbbcnWZz72Hp2uybegQhgQKCJTtMfgR+VQ8M09wM9UuuHx8+aKlrLl8Bc
 e4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734327362; x=1734932162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1tbmBiLrQEo0aRwmdZeClIAM8Yoa18M7B3FLTJwOhU=;
 b=UJFtNI+jnwzqQGQpiOPmdLgOsbhAFrV48h/8G03SDCTDKEtGk+qKBqluZMp5VR0Xk6
 PKdrnTF7JhqwzuZZMF2dW3fRqlrQ21uW+/cB/mVaTdvS1G/BW7z8+t4ONMohSMfoCqUE
 EEBY3/fPL4Fs5pDymaouQ7sX0pT+c490sOhygOYtPcUBzeCJbm/WHHXMhbfDEqXHlcO7
 0wvP69mcrT0d5hBDUbCxU43xQtGKVNeWKLCkfoWmHjy7G/DITOIWejG9KAGcWVJZGE4q
 VB0pCplJJxFLnSlDEO5N1i9+G6wr8LF5ov6MZRo1w/d9RwczNq6mSCyZmqKQ98UEtZ+T
 OPJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULkMWIsrwZIyg5dCV34bE5CfYGFmzoPz7H61mQj0E2g1MUjpJRcmnk3q4UOSh2gk8JRFmHW+vgPWfn@nongnu.org
X-Gm-Message-State: AOJu0Yxx03+X8Xdas+IwpOI5YiDoEqUFRX2nDaVxJzb0bzZRYyeWfF3J
 OEG4xkbyw+kkEGJCwIQjdfjaFsS/HKurZpQfDxQY8GVe+DwBJ0FPe5c/ysf6EVj42BXEeCU8Jtu
 rdYMmgubggbvmciJBccwRIfBiZRo=
X-Gm-Gg: ASbGncs/eZmv5rMJ8p9WK+SeTqAsFs7CJHqx4a0Eg2sxVO+4ZoB2svpk9551qUeN0vr
 egHd9QiEETYzCuXFJ6z6//DOVQ5Vg/h+NKpmuKMtmLmP/4xz4+XJcA851k2XE5KVp67xS
X-Google-Smtp-Source: AGHT+IFBiZ3VI2WSmDKrtXeLM4ZBJiSsq7B70UJldfrBYj3smozmWt3t/TVe7qyaOd2ukGNyx0lZRQQ9E6+IOi/kczc=
X-Received: by 2002:a05:6102:48:b0:4b2:73f7:5ad9 with SMTP id
 ada2fe7eead31-4b273f75c74mr3961676137.2.1734327362197; Sun, 15 Dec 2024
 21:36:02 -0800 (PST)
MIME-Version: 1.0
References: <20241128141230.284320-1-cleger@rivosinc.com>
 <20241128141230.284320-2-cleger@rivosinc.com>
In-Reply-To: <20241128141230.284320-2-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Dec 2024 15:35:36 +1000
Message-ID: <CAKmqyKPNY=R8MFd1Wai5pznMjDD=nQCVyBK90+6aaWYM5AqW_Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] target/riscv: fix henvcfg potentially containing
 stale bits
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org, 
 Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
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

On Fri, Nov 29, 2024 at 12:15=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> With the current implementation, if we had the following scenario:
> - Set bit x in menvcfg
> - Set bit x in henvcfg
> - Clear bit x in menvcfg
> then, the internal variable env->henvcfg would still contain bit x due
> to both a wrong menvcfg mask used in write_henvcfg() as well as a
> missing update of henvcfg upon menvcfg update.
> This can lead to some wrong interpretation of the context. In order to
> update henvcfg upon menvcfg writing, call write_henvcfg() after writing
> menvcfg. Clearing henvcfg upon writing the new value is also needed in
> write_henvcfg() as well as clearing henvcfg upper part when writing it
> with write_henvcfgh().
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5d8d0d7514..98c683df60 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2383,6 +2383,8 @@ static RISCVException read_menvcfg(CPURISCVState *e=
nv, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
> +                                    target_ulong val);
>  static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>                                      target_ulong val)
>  {
> @@ -2403,6 +2405,7 @@ static RISCVException write_menvcfg(CPURISCVState *=
env, int csrno,
>          }
>      }
>      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
> +    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
>
>      return RISCV_EXCP_NONE;
>  }
> @@ -2414,6 +2417,8 @@ static RISCVException read_menvcfgh(CPURISCVState *=
env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
> +                                    target_ulong val);
>  static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>                                       target_ulong val)
>  {
> @@ -2424,6 +2429,7 @@ static RISCVException write_menvcfgh(CPURISCVState =
*env, int csrno,
>      uint64_t valh =3D (uint64_t)val << 32;
>
>      env->menvcfg =3D (env->menvcfg & ~mask) | (valh & mask);
> +    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
>
>      return RISCV_EXCP_NONE;
>  }
> @@ -2513,7 +2519,7 @@ static RISCVException write_henvcfg(CPURISCVState *=
env, int csrno,
>          }
>      }
>
> -    env->henvcfg =3D (env->henvcfg & ~mask) | (val & mask);
> +    env->henvcfg =3D val & mask;
>
>      return RISCV_EXCP_NONE;
>  }
> @@ -2546,7 +2552,7 @@ static RISCVException write_henvcfgh(CPURISCVState =
*env, int csrno,
>          return ret;
>      }
>
> -    env->henvcfg =3D (env->henvcfg & ~mask) | (valh & mask);
> +    env->henvcfg =3D (env->henvcfg & 0xFFFFFFFF) | (valh & mask);
>      return RISCV_EXCP_NONE;
>  }
>
> --
> 2.45.2
>
>

