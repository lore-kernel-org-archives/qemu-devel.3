Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BE2109E52B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5aLt-0003PQ-2P; Wed, 25 Mar 2026 22:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aLr-0003OX-Oe
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:21:39 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aLo-0001RG-Ib
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:21:38 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so91464266b.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 19:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774491694; cv=none;
 d=google.com; s=arc-20240605;
 b=Nt/+0VGSwrUQxCoXRsXVRotgyMql7H9Xx85vj2bJIElq1gTMOvNiQ24t+SyGQxXncj
 1r+zCFVXHrblKgQqVIj9SNIzN7+Co38FfmZNNwgXY0AYcCnPB1bbBWYFSPCF3UbsnZEg
 1i38mQfWZ/6RhHXThfmMf4PZqkayZ86nytOh0fhavoJNQ6JDG/f9hMJ+SNgRVRScpDmQ
 V+5+NnZFlC1U+MR4yKFBBoirY9XGKBHcPIIcIOXHk1WC2ULUIWxiASWZMCjUMy+eVKGL
 scdGQSFeWblbvzqaWEINzRUgTzypoc6V1owjLQkeIlWR1lKQm5y8qDrZEK/8bgQNP0HS
 v48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oXkuXvd7wAF+YU6RFbdM1LIpDZBJWC5FTOY4qzK9Mj0=;
 fh=0bIOm+75pw/QTN9FDs8ZhfYo0XBcsOIKWWC6mti+rTw=;
 b=VBzhkz05FCbBnOb+pSZUmECC9gMFJhStRVd/dZhf2u9gAvDG9jcVkXLKp1P9GZMmun
 +PvrPyiI1yVXBSc+PlDwKePeL3rNf9kVvZYTcyHFEgNGIt4jnl7HeYlMf1lyqD4WyciO
 aNpzz+MKAz7dKpqVabvnL/4qsWZtYt5+m5UKA6RKZ1UEsCJ8JDPF0WagzDV8jgPBF2V9
 ibxRulc2Glhri8LvFQApDNDgqCSvP9j1tZ6kz+VzfV723SfzCPOTrn/ViVUalIlKvQ9k
 jb0c94f+YzCl6w1TI5lBbBMSQPeWu9JomHgFmqmPdZsGmnPCw9ITF2jy6ZwwOaqMns7v
 s+xg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774491694; x=1775096494; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXkuXvd7wAF+YU6RFbdM1LIpDZBJWC5FTOY4qzK9Mj0=;
 b=kVNgbnTjyj1GHCVSNTeu2Vj5aM1AdqyOcKDobgNgvfPNW7tDOly+GfJR0RTuywg0hH
 B6zG6is+4TJ2Yml0iddz2x7CiaS2PIlGK7TxVqtiyXnTLXiZy7PeS03SRHz+JkG+eSNr
 CORZN1hEhmhFUsmagZsessIsnddxAcUltEQn/W6Y6ASixdBiut4myOsnbAw5gCE05t/7
 ygwO2HYcCoXhhldKF15mq0vy+JfZUBqbkyPGwpvfqsKhSSoohzaZnnsIvJtQaQpHKm5f
 EuzeBg5ZojGDQJkFXrZki4SMla6b780eGKmHcGBUuZDZhdy4O2y7zhHDyI07yUarBs0U
 6mHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774491694; x=1775096494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oXkuXvd7wAF+YU6RFbdM1LIpDZBJWC5FTOY4qzK9Mj0=;
 b=HOiLlFt5c65CRq+/6JVgkGsJQDX79NjnLQWAsVKth4RMtA02DPLIr7VBgryZAm1YYH
 1Tw2xEt7P2fkbKlxRb1GsdjEVJSjtWUb0cxK2iG69u5Sc3QHnifQFORR/bbGnZlwyB5Q
 ZIekhbOAIRtw81eUo+fBw3dVfhUDfEcF414nxpt19FU5u/iSbA0EQCOhYTpUaUTDqa+K
 Mp/FoWgitUgMPIxcBVN7WgSJjNZ89w9fyvoxTeWrh3lFCeA/hO4HqLGlT6k0oI0FBR8v
 DAZXyxd3EXnpktdg7mP5W6Tqvc9J2k0CAaP+2GabALirYM4wg8sSgaxW1zYMEfKUyIoL
 kOfA==
X-Gm-Message-State: AOJu0YyiBPFfmsbr0V/pX/3ClLbnAcAlrMpZqclTSv35RAHVSMMD+y+W
 GxGLeErPQB9lPUbAaZXFsMr8MjxkKgcYP2PMPveYt00CsUP+CpSh4hCcYqlLt3gcMambLCAzsz1
 cIEfcbaJ2OplStO5/2uK7SgBtxpUa5IE=
X-Gm-Gg: ATEYQzzezVx6oPEXFv7TFCmIL/7kzFXSfgtwfeBdA7EUgDcIjZ5LaMazyYBiISxKqfH
 R8FscBwPiTKndAoe1iAfBiUUxPHXSBjT8KXFR9RqvUpoSswnTDdbkPZcaOhxbWjlp7pRAmk7zi/
 Nl8HkqV/Q9Ur/N7lGJ0u0aGXjnRwWBQKnqJvHNfB6pXYxcfQFWSh8/w/B1AmIZ7v//PQ28ORmwe
 ASW5HtdcE2tqOCrEb/iW7bYTJqgInnpdaTIRHQi9W/gcjLY3V1BpCgzvYgl78KgccBAwCYVD9fV
 pvP10BuwP5VCual3kKIbmieMIyG+czM/TDh2xg==
X-Received: by 2002:a17:906:3759:b0:b97:f9c9:af61 with SMTP id
 a640c23a62f3a-b9a5424030dmr345267266b.45.1774491694078; Wed, 25 Mar 2026
 19:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260318103122.97244-1-philmd@linaro.org>
 <20260318103122.97244-15-philmd@linaro.org>
In-Reply-To: <20260318103122.97244-15-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Mar 2026 12:21:07 +1000
X-Gm-Features: AQROBzAiKyffz5HUllXTQ5cjCL2DH4JiRlewV9sEKJ9cWhKw8EH0lHZVA4LReaI
Message-ID: <CAKmqyKPehQ-H_Wr1numn+S1AM-vE4BcSx9S2UaimS7fHLyoKBw@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 14/16] target/riscv: Replace MO_TE -> MO_LE
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
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> We only build the RISC-V target using little endianness order,
> therefore the MO_TE definitions expand to the little endian
> one. Use the latter which is more explicit.
>
> Mechanical change running:
>
>   $ sed -i -e s/MO_TE/MO_LE/ \
>         $(git grep -wl MO_TE target/riscv/)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/internals.h | 2 +-
>  target/riscv/translate.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 860c47732b6..460346dd6de 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -71,7 +71,7 @@ static inline MemOp mo_endian_env(CPURISCVState *env)
>       *  - MSTATUS_MBE (Machine-mode)
>       * but we don't implement that yet.
>       */
> -    return MO_TE;
> +    return MO_LE;
>  }
>
>  /* share data between vector helpers and decode code */
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index cb4f4436018..6f8b8e9d19a 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -135,7 +135,7 @@ static inline MemOp mo_endian(DisasContext *ctx)
>       *  - MSTATUS_MBE (Machine-mode)
>       * but we don't implement that yet.
>       */
> -    return MO_TE;
> +    return MO_LE;
>  }
>
>  #ifdef TARGET_RISCV32
> --
> 2.53.0
>
>

