Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803C2CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 00:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v31z3-000720-QN; Sun, 28 Sep 2025 20:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v31z2-00071n-IO
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 20:43:16 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v31yp-0001V0-Af
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 20:43:14 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b346142c74aso774194466b.2
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 17:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759106574; x=1759711374; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzfR55nZwlpCaRCqW0aGgTV1mP1hp9/sOLvVjH7qZEo=;
 b=iCXzFwbW3ezKa8KNpDZdk2p8PVP4iHslABSpQ1HLxcz7xmhjFwAh/JKIf2TmfBY+6t
 cl+2/0h+xTp8npjBs026JozWBINq53xABYRLt6/fg0q1d09PhnIj3AnGETaCYczRoJfr
 ArYah3x5PcZ/KIN6IIQ6k05gxIJr3GOsc62NWSRzufmlQHLE0jpfcE9kMkjiPCwsHmVV
 AIddu9URj6zbdDN/ISQVGPqmGZHxycYw7Esqrw97PRFzS0gSm23yJvYJmwvh9EzxJyU8
 ivS9ND6Jab4telt3JsIdUAfAsqa5KKNKjuzAuH5vYhVabm5YvpQ0m4XcNU3YcLNdiddB
 5nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759106574; x=1759711374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yzfR55nZwlpCaRCqW0aGgTV1mP1hp9/sOLvVjH7qZEo=;
 b=ZFZ7FG3FQigYpTsTb+YcXkJGx10YzLPzKUkK/Y2CM9OQarHoaWCg+sRNrqY4D+X5QY
 gtWoRL+v2uZhsKjqNkLmBQ3xyC6lXFibv9+Wyq6CjJl/KqMlZeURGDpi9hx+VMbCTJ2q
 754RweiuH0L/RQMw/l/Fw+CvzG5upljV++5Jek3Xw9h16rm3oK2ePHmHXIvI1R+Av35J
 dtZy8Ea77t+ye061eFGFdjQ9wxAse5eV0Enb/6MdtVHwOfGWpdrvOa/ZIDelWD2iS/ae
 hNHhMCFch7gqHYq33J8iV2YwDgfajWLGdYKgNPi3G5abXImndKWeLmJ1HMrCLjWbDeth
 /iQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSLR4TEkG1QHw7A0p/ZMqVIrTUf9RSMYTGt8DGWT9LTJMQ/jSs8XVjslvtaXXkTPvHVI8XV76CGyKb@nongnu.org
X-Gm-Message-State: AOJu0YzzU9JVkcxT3pxbDlcqfa4yWjZqxYbRDJVukF/0AgmMKMxWismh
 HXcA6a2e9kLGb1q8GAqznSXaO/Dgb7HM+A1CFJJMN4weVbM3yX8VxN32PhING+Ikgxi//Og/CJn
 OmtzUi7zLhupNk+vlyXnn/Z7qZLj1UGXC0g==
X-Gm-Gg: ASbGncu+5y2d8T0uT9CNvsh3K3AB9yo1EGd50wX9jXSgMrUbYVWg3r3CjZPNtmSdlR0
 HOeOAduGYFIA69fih9EJZceZY+N9d/EcHNbOxScVXTENF7CgsN46tQkZASsuF08lQwq+nVL7dPY
 s8srfxMLLvTXMVDcV8wz+M/FTcS0NwIbhZF8yGGoK/81b2kNVC5QG9Sw8/SKJ76EVnG4PeoZJRA
 s/DG9g9BuRpWfkfo1UOtM9NQgUPBsC5yLNkLw==
X-Google-Smtp-Source: AGHT+IEmdCZNcFzNx7haxD9xm7Gk0cBQJ85p1vU/VvBAxnDNs0Osz0mXZBg3GU9CM+s24Ct5B5b5jOwLyP7vq8G45UM=
X-Received: by 2002:a17:906:c144:b0:b0e:8cd4:e2e8 with SMTP id
 a640c23a62f3a-b34b7106555mr1579477966b.17.1759106574088; Sun, 28 Sep 2025
 17:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250815140633.86920-1-vladimir.isaev@syntacore.com>
In-Reply-To: <20250815140633.86920-1-vladimir.isaev@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 10:42:27 +1000
X-Gm-Features: AS18NWDoAlJkIDc-PUbt6C7yVHX3tKsJDmlnMkRQsC0PEAmpkxTBea26rfkTQQA
Message-ID: <CAKmqyKN0Ro9nLvq7MqYHf3byFBCyMHTvy=sJf0Epqh0E4pwhdg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: do not use translator_ldl in opcode_at
To: Vladimir Isaev <vladimir.isaev@syntacore.com>
Cc: richard.henderson@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sat, Aug 16, 2025 at 12:08=E2=80=AFAM Vladimir Isaev
<vladimir.isaev@syntacore.com> wrote:
>
> opcode_at is used only in semihosting checks to match opcodes with expect=
ed pattern.
>
> This is not a translator and if we got following assert if page is not in=
 TLB:
> qemu-system-riscv64: ../accel/tcg/translator.c:363: record_save: Assertio=
n `offset =3D=3D db->record_start + db->record_len' failed.
>
> Fixes: 1f9c4462334f ("target/riscv: Use translator_ld* for everything")
> Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/translate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index b1e41cdbf1f6..980a67ea855e 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -25,6 +25,7 @@
>  #include "exec/helper-gen.h"
>
>  #include "exec/translator.h"
> +#include "exec/cpu_ldst.h"
>  #include "exec/log.h"
>  #include "semihosting/semihost.h"
>
> @@ -1143,7 +1144,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase,=
 target_ulong pc)
>      CPUState *cpu =3D ctx->cs;
>      CPURISCVState *env =3D cpu_env(cpu);
>
> -    return translator_ldl(env, &ctx->base, pc);
> +    return cpu_ldl_code(env, pc);
>  }
>
>  #define SS_MMU_INDEX(ctx) (ctx->mem_idx | MMU_IDX_SS_WRITE)
> --
> 2.50.1
>
>

