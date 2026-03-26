Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC8B109E53C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5aDo-0008Gk-F6; Wed, 25 Mar 2026 22:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aDf-0008GL-Kd
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:13:12 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aDc-0008RU-OJ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:13:10 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so781473a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 19:13:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774491187; cv=none;
 d=google.com; s=arc-20240605;
 b=JGLCelkPT3AZ7ZjhDdBdWlhRjEWJb95ZiN8BsxDC3xz1DhJ8PjwTHG8KOUWReLUhA+
 qxGYkvXDkqzpp1R/AAi4ynm4ZS+0RejReiU/MZ2kAsHzO8T6x9otfnugeHFXbDb4n0M+
 M1ZISf7dha9Yl/kMMVBASV08u8iNwcZ4CDblIdpynb8JRdVQtQFEPjfoS49N45NDYDwD
 AZfIbIt5IMgD2nGaXdqhh9TRmx70D8Xkdx6QVC2w7k3jr78Ibqbfl1mVp44AAmGcJO5J
 nKkI/n70LCwYOFsyqv2ivgL6veAVK4PThgMxMxHbV/CDYK8fPngLmm60dNOYCwwyvTA6
 sdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J6dTgU0vMGl/012DdcuBv+gl2ig8/GCvDaik9y2zfTI=;
 fh=0bIOm+75pw/QTN9FDs8ZhfYo0XBcsOIKWWC6mti+rTw=;
 b=HFnVK7AdLC0msLZbG1Wr4R0/UCekTQ71sjx+mdNwVVBNWyIt1Z3bFNmIQDlauEcyyg
 jDa1wTpz6nwU1JQoeIyJ8D6WCgXUFDDBp7i55mZz5O7nLOYrhzPauYkFw7qYpVRsCUzp
 FjiAR8NnYoDH5DS1cgb5PLEX50SFnkZlJmJR63dh0eWAR4Q/s2yWKFCKR9eigFOUCgmy
 0Xnw7DVx5pMBVkXVqnD3WDTgK9MqNTnVynwe/KThEhsa2jVZVYhfxm7nh4Js4IdJOCdt
 XRjRw0JQBmEKxLIO32WnH0bbSeIi+J6xc+5BKGOiwFNIF3VO+pQ6wlktIOSWmhokCMeq
 fzRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774491187; x=1775095987; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6dTgU0vMGl/012DdcuBv+gl2ig8/GCvDaik9y2zfTI=;
 b=f32V8qcC5StjG28WC3t0lzppqBVsfsALBJm+UJxml7znFqdPxTxQMbfVaiuYm2j4c+
 c1V8QH68ptW9pX6YtvaXCQEfyhV87YdKDKcz2Qc/pI8if3EvUe8gt638QySPgUf5PxjH
 cO80laRZaHk3DX/bVirAkejlCCe9NFQbySAHzgDbHctvZffilYftmy5Xwz45KhG4PTt+
 Dioht9qR9x6SWud27GjiBCJONOrbVJ4dC+YieYM/A4yiI8Z2/dePbP7wFxuZXLmLNaX5
 hJQuSiizyrwHJ/dqJ3aZilxIPd5aoUXWcMieu6MHjqfFqTuxH3TnIMw7/JNUHFvnUkm5
 qrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774491187; x=1775095987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J6dTgU0vMGl/012DdcuBv+gl2ig8/GCvDaik9y2zfTI=;
 b=L/N/wczYtEJEuP88TfZMbPlD3r4NarBSQtsfjVy/McQhnAQCobEHSncuq9fAD65fX/
 ik4JPz5DV8tFQSMPouj6YNnw3YpsOa/T32xLUkYrlUXG92oE4QXShhMvdYHg5e0o0DZ0
 zYa8gEmF2TcHlVRJtsaesuiZy5CnJwUqBbhWqd1staAJ9zMf1vNIFSCzz7m6QveCe1WL
 UMQvJLxjA4mC3r37KkUYj6gcsjJ6PWDT2l2PG847nIfMbCqLj4+uLZIpR7+CRAl19IxW
 HvexG6LNjl3JBpj3WkLbG/HVP4vSwGUxCZUBiMinZYrSiGqe4NjVSNfqQ2DSg2VSC6N3
 YKnw==
X-Gm-Message-State: AOJu0YzNDEAiWt4GmOwO0wu9ELDtWyzR2mZaRuhIBYBGTcU+Bsmo/NjL
 BF9031uaggA1l77T6/uPBEX1jhDGPoxQxhtd6axsscga/yqhOzF92fDouPE6HsyOrBRR6QednLI
 5fDQnQalcFHCR3xajYccfJeHMCTUgHJU=
X-Gm-Gg: ATEYQzwI76n7kU0RYrt3f34R0WKjWerVmw3D/NZSuaGVYiKc2CPbK3geJZIjCsAL3qJ
 SA3lwoUDfnWZZI2ebkW0MQQnoK1VC9zn9efOm2Kmwxtu6K508Yl2lz1GOh5KVuT3M5yBBBKDbs3
 pIuNcQ9wD3mZ96vgSCfuLk2JFfzc9ifg4EdjmKcVjLsf3ZkQXrD81KdMAI9gROvpbZ1dDL3wJL9
 ZDo+6+UBTr5jOw4SYRdLyiWRL6cyQ9aLJd4YkbdeK1L3Km/5paEkF8VhNKQNiVKkRhrdPWzEmtQ
 6yUYWQdBBv+aUzygF55vd8HxHji4XQe1p016QRDCaTU/bKlx
X-Received: by 2002:a17:907:e11c:b0:b98:4d8f:d968 with SMTP id
 a640c23a62f3a-b9a3f1718dbmr311866366b.12.1774491186917; Wed, 25 Mar 2026
 19:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260318103122.97244-1-philmd@linaro.org>
 <20260318103122.97244-9-philmd@linaro.org>
In-Reply-To: <20260318103122.97244-9-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Mar 2026 12:12:39 +1000
X-Gm-Features: AQROBzCSXwvx5sTs4n9wCzIbk6AJxGlunDdEcIQzQYS7OM2BxqlOXDrkXxS3nHI
Message-ID: <CAKmqyKPGSWcLxPo-ROyD9qfhP7SmpZ0bgHB9hLORXuqQEYVf5g@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 08/16] target/riscv: Simplify
 riscv_cpu_gdb_write_register()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?= <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
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

On Wed, Mar 18, 2026 at 8:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Use a single ldn() call, sign-extend once.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Note I'm skeptical about 128-bit registers path, but this
> would be a pre-existing issue.
> ---
>  target/riscv/gdbstub.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
>
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index be42566bcc8..a5c12638782 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -84,33 +84,20 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_=
t *mem_buf, int n)
>      RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(cs);
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
>      CPURISCVState *env =3D &cpu->env;
> -    int length =3D 0;
> -    uint64_t tmp;
> +    const size_t regsize =3D mcc->def->misa_mxl_max =3D=3D MXL_RV32 ? 4 =
: 8;
> +    uint64_t tmp =3D ldn(env, mem_buf, regsize);
>
> -    switch (mcc->def->misa_mxl_max) {
> -    case MXL_RV32:
> -        tmp =3D (int32_t)ldn(env, mem_buf, 4);
> -        length =3D 4;
> -        break;
> -    case MXL_RV64:
> -    case MXL_RV128:
> -        if (env->xl < MXL_RV64) {
> -            tmp =3D (int32_t)ldn(env, mem_buf, 8);
> -        } else {
> -            tmp =3D ldn(env, mem_buf, 8);
> -        }
> -        length =3D 8;
> -        break;
> -    default:
> -        g_assert_not_reached();
> +    if (env->xl < MXL_RV64) {
> +        tmp =3D (int32_t)tmp;
>      }
> +
>      if (n > 0 && n < 32) {
>          env->gpr[n] =3D tmp;
>      } else if (n =3D=3D 32) {
>          env->pc =3D tmp;
>      }
>
> -    return length;
> +    return regsize;
>  }
>
>  static int riscv_gdb_get_fpu(CPUState *cs, GByteArray *buf, int n)
> --
> 2.53.0
>
>

