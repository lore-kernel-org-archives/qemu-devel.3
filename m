Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7C7109E53C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5aEP-0000K5-Gv; Wed, 25 Mar 2026 22:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aEO-0000IN-BJ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:13:56 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aEM-0008Uq-3j
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:13:55 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-65c4152313fso573604a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 19:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774491233; cv=none;
 d=google.com; s=arc-20240605;
 b=Th1RVuvbFZ8o2QAssDUC0ESLIAasfj4LSu8DnUsOfEq2+RwiySXzed7+OjnlCRwicL
 rwj0IhjkxhftceqAkF79l7qKKrdL1Tudz8bUn1b30HwFPzRrTj6xWrTGfhWODe6jIDgW
 b6+USRJ/T4gJWz1wksMTHK2MQB7EmVsQqjjWb4Imr2oYIMNTT5ngrV9iiCMvsZzDoMx0
 FF0BSGA04KfQ5rpz1ITn0N08RaSryh11iIpI/k0aNhHctoI7kgF7MTJleUMWkaR2xyPK
 LfUoZDef+Li6HHiixMMFZa2au5ALV/VoQCMagfWK7MkvnQ5Z9leW+qu+OsWIy9jDd8VS
 URog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cs84IbrIglVRkkFhPUbDAuyX4OlIb6qVjd5qMqnby7Y=;
 fh=0bIOm+75pw/QTN9FDs8ZhfYo0XBcsOIKWWC6mti+rTw=;
 b=VqFzOJWWjHkBOzu30PeARfC42tVKA3lkkxNLdh9Y1EjF/EDUc9GGUuo+Yhgxqnnjdg
 iAVzZHk3cPZcrJeOVPG8ZPr/gdkTnx4DhvtlTn1ny6XGrwzfHB7+jqnR153WCCFYF7L7
 vCn6HPSJax8JHiBysTBH2O1T/c4Zrb/lRAtozEvxsJ+nS72Ip9Eru/JTtSH1p/r5uAdj
 AVfDzFiWG71sroaUgfd6Tce3BvBT8ecXRZ85NANSGcT/espFNFGQBpLC4gMq1VC8e/6k
 4St97WfnlNZFE1ghwv4P0c/fmPx5IkLk2aWX93Vh8hQsJDJvnYHmRDxkc8iuAvOb7zAR
 x3DQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774491233; x=1775096033; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cs84IbrIglVRkkFhPUbDAuyX4OlIb6qVjd5qMqnby7Y=;
 b=RmsndxvA8ZYzopMe8oe26f4qkvGxUTXJJ8gmJw1+dlg/C1y2rpUnIKVxt8zR7gsy+5
 8CZTIYIK+6hwz+fzWQwhbWFK9IeGLNIu8a+mEW7pKn0pw0zFwrroRVq4IphqjLstbahd
 smjdCkP0JFLUt8F/y3oTZFAkutyceC7hsFKPQOJN5VQvvqoO+RZtsyh2Au5MwkDuZ3Js
 RPC2C+ij/2hPl8DHXoedy8oTTxqaCGz5MbwNuqW48E/2nhuHWBxEduyYNTWdMLByMkRl
 M7LWFretHhx6gmxVtSh0KRocsbhel4Autjx7PgWm/MEaIedGkFtx27l2K9C/PWFOJlP9
 7APQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774491233; x=1775096033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cs84IbrIglVRkkFhPUbDAuyX4OlIb6qVjd5qMqnby7Y=;
 b=glY7be1WmrpYaPpuvRhSlm8rFdtGQaVOIIQSTQDtRZJZ/jrj3j6lJyklnJUCVCxSmq
 IBrNWwfsdi3sWTLaXEo8+wQVgp3MiQaB/2Hj6vKDsZBTUTN1Q7DiEmDjfmk238/+rA6J
 yjI60BBNCxNXnUHhoaTfTlQcXnJfdIV4ytEywx5hRgjXcC76oB9MTgLPgmtuuiHn/shi
 KEpHDYpk6g2sm4UiTg7BfKxxnvYpMYRrbL3KG/2ZmchHNmrya7ZenuEHJ708ThFPU1Mr
 PLPp9AejzkkqYNB6PHOMzf5iS3l6vhTjTTO+ZeESIk8xU0PsWY5UZnpEKsM+DBq9+F9O
 bK9A==
X-Gm-Message-State: AOJu0YyJDMgv0o6VysAvhD4x5zlLcMGW1XTeFPPaiABVHnWS9efrn7wd
 7GPZfn2gB6zt1nK94JSjhko/hyFaOttSf305ZUmVtd9H2o3euQUdsWFWrSiZR6qROkFqI8DWT28
 hdweg/CjgwW9GmQXiYzZawghXT/WQrQI=
X-Gm-Gg: ATEYQzyHhNs64Ke3fIELpTP22GsZ5Z7Aw9cDnBseNiVi27DwmPNBrKbN6ubFKTVYmfM
 M+qzmqNgAdGSYEqoURRNnGQcelcolyLSILNgcd3Wfxc11IozjuryqOO1HS7iEqmCk1QqwitDSrB
 PoGtU29H6nUZOHM5OTknXXFJvdy4zF5HIiClMDj2/VWA9osxuOTW5tCDORXAzXXbqtENyKd4PeF
 H+wX66Lqm2PFsIHpZwxusBP1OLYZwM6qaLlIWua6pwygaQ7Xqm/Iz2c1upn7GgAP5wA1flCrFu/
 93nrxDJfk31UQImSIATTSHmiO6Opguuzr8PtGw==
X-Received: by 2002:a17:906:1909:b0:b98:32c1:2452 with SMTP id
 a640c23a62f3a-b9a543c00a4mr324830766b.48.1774491232560; Wed, 25 Mar 2026
 19:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260318103122.97244-1-philmd@linaro.org>
 <20260318103122.97244-10-philmd@linaro.org>
In-Reply-To: <20260318103122.97244-10-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Mar 2026 12:13:25 +1000
X-Gm-Features: AQROBzC0upxUJaZQ9mGPpTwtr8spkF0CAPvQ4RmxrRT8OZrVqCSZLa7yS0hqhp4
Message-ID: <CAKmqyKONNZaWKDYx8D9wUsHGbG=92W8D1RAB_bj2fsnbWqF7Aw@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 09/16] target/riscv: Expose mo_endian_env()
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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
> Move mo_endian_env() definition to "internals.h" for re-use.
> Do not restrict to system emulation only because this will
> also be used by user emulation code.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/internals.h | 12 ++++++++++++
>  target/riscv/op_helper.c | 14 --------------
>  2 files changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 35b923c4bf5..860c47732b6 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -62,6 +62,18 @@ static inline bool mmuidx_2stage(int mmu_idx)
>      return mmu_idx & MMU_2STAGE_BIT;
>  }
>
> +static inline MemOp mo_endian_env(CPURISCVState *env)
> +{
> +    /*
> +     * A couple of bits in MSTATUS set the endianness:
> +     *  - MSTATUS_UBE (User-mode),
> +     *  - MSTATUS_SBE (Supervisor-mode),
> +     *  - MSTATUS_MBE (Machine-mode)
> +     * but we don't implement that yet.
> +     */
> +    return MO_TE;
> +}
> +
>  /* share data between vector helpers and decode code */
>  FIELD(VDATA, VM, 0, 1)
>  FIELD(VDATA, LMUL, 1, 3)
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 6ccc127c304..dde40a55493 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -28,20 +28,6 @@
>  #include "exec/tlb-flags.h"
>  #include "trace.h"
>
> -#ifndef CONFIG_USER_ONLY
> -static inline MemOp mo_endian_env(CPURISCVState *env)
> -{
> -    /*
> -     * A couple of bits in MSTATUS set the endianness:
> -     *  - MSTATUS_UBE (User-mode),
> -     *  - MSTATUS_SBE (Supervisor-mode),
> -     *  - MSTATUS_MBE (Machine-mode)
> -     * but we don't implement that yet.
> -     */
> -    return MO_TE;
> -}
> -#endif
> -
>  /* Exceptions processing helpers */
>  G_NORETURN void riscv_raise_exception(CPURISCVState *env,
>                                        RISCVException exception,
> --
> 2.53.0
>
>

