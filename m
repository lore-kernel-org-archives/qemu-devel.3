Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCBD1093176
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 01:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5DRE-0007zJ-Is; Tue, 24 Mar 2026 21:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5DRC-0007yb-8o
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 21:53:38 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5DRA-0002nb-R6
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 21:53:38 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64c9707fc11so3210895d50.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 18:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774403616; cv=none;
 d=google.com; s=arc-20240605;
 b=AO9/7DLG1aMyuoRx6wnEg6dDEMKLLB/2YC8E5VcJSgVj04se9tPsFVdW2ThhET4+Pa
 Qja3TRWC0+oPofOihh58VebMZVA91cDlWH5JqD/3zG59CD6b6RlYA6695o8sZNBzfgFG
 0oCbOyrB/l3CE+oBFR0N9Ty54vw0R5O55ntowAO5ywXOJOL3NIziDlctPe1t5BlVijdq
 MqpEJjKnEv7cVnJLXYeDzxuGFmlAY6qgjcZqoMaIx5t0oP1bNn/pdSvzn2XmmRp5VLux
 ofNWuVASqYsF/fq+eGMCzGuhbY024H4zuF/6lRu9wdE4D3CPqp3j5r+8wOgXtIVT+Pqa
 KJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w+p177SavoSzvVeh1sZWyjUTuc5OkIu3fZgPQr01xRY=;
 fh=04Aqt4bNN/xsjKQvKOyyozru0WPtRu+YUQhfE35VRn8=;
 b=VKJzmJnoeK+4IemUyFNsVhIC9sYU/uHLSR7gzxVzS4W0jYtzZlCNFYdEFxRoyGmkNc
 t0PzNObdn1l/P1fTFUUOmcGXQETGiKz247M4Ln7Dc4UP7b4pk3OyU2ks9NDgKRDhy/Zq
 mB0tIeWuTqWFr+bYcY1XGN13bc1mOn+UBfWeB8jFe4A/bYYPqdt2lzsN14MrdIBSbYgI
 R9NeZxIGkw9lxfpKcvSfpP2VJClrTbRgPYUqdA4mwDvfBuOBBbaZ3SyHDvZ+/UZSc5D1
 pm2TgRHDGo9lX+LpmsrGbw0tEYQltCy2OeVejKQjR0G0Vt19VSx8DZB8oZSfbJSV84/y
 mCNw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774403616; x=1775008416; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+p177SavoSzvVeh1sZWyjUTuc5OkIu3fZgPQr01xRY=;
 b=IPYjMUe1rgJO4SQjI6+mcVSDM310nymwf6b30XtQtiRmUPZ7FuXiy9ZW2OR8sETGJX
 TnrujVKTQyY5Uh3JPnf5OACJs8s9iWOpImOsTkkqbXaqGDqHxWqM9o1aEBGsq2mzirzu
 XC8e93weKENvwFP0fQebazQcEf3Hj4Amj/Gd3g66uXmuNz8HSyojOR5k+2PnGXj6+DTg
 Z41/lNsJYXVewF5rbIu2OsXX58wyzowhV0gHuQMt4CO9rchtO3Oacy/20Gv8ArSjzfo2
 mIgALPunWILsYMaaCPV6Kv4Zr/9hlx6iKo7+0iBzDigXzcfMJ2Icf/LoZY+Pli6sH0SZ
 Y+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774403616; x=1775008416;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w+p177SavoSzvVeh1sZWyjUTuc5OkIu3fZgPQr01xRY=;
 b=LH3XRNJ0iEzAb+tv80iT4PNug6DQbn7MD5eL1YuGUWQnylzC9aNmCks3CxrPwD1yZB
 CGX/g/Ol7+6uFYmjIbLKno3xNOzRpAdAvNpWXCI2KtpRWcklmnihKtY3f+CI0t3V/0uj
 VFwM3Lf1WpRvLqhMn1aRKnD28ytsuzTMZrf47xu0R0l4qZXSES0Cq/EJTfBGUXlYFOeS
 P9x9+/VLf2pn3rhiKzkPeeNSlMmxE0zee522ZfwsBvH9k40C4e5x0maWtOTm2u9wTtvv
 ZgR1GudTS8RzRHq6jffaicuAwEoGUtrjh7fvFJ8akhHetgYLEtoDb2Dtxa9wSbvuaXy5
 8RsA==
X-Gm-Message-State: AOJu0Yw+XHD4KRDv0wJohKneO0OdEpdDMoJ+cKxiNqc7aYctqLQbAFUv
 Y+DfYScEGXISrS45eNlQ0ebnZGIVc3GO11RgmaXbi18el9xZhhVpraSqtSpm3rULqIG5/uEEp48
 MIZIdXasEjUBXME4wa1L+Riaf8SttudA=
X-Gm-Gg: ATEYQzzDaHA+WhXzLFa/O0OjMLPuMP92GLaKXWPHSo9/Xfys+OtwILaw4LIWl6S698K
 TFvvswZsomlbGXagpYhrXlRliXN8ucXEBs1crq31ZfK3T3/PZ5bEMDp5ddYRrfaphWgoMdAZ2DP
 mQXJv9XYSHQroATqxJUnli3pBdGxeG4jLkkAUUeME56pPEo7owdodsi14wBl4JCv69sgY2Wc260
 yqUKl7Wabr1dO1fVMwyOjL4o9Caom2X4+BxcFhduzK5Vd2mjvvCAFyCg8BZ1M3Kuws33zboKcYm
 nLKm6T52lWPOGmtcG79Jvf6X5q5hYDKqJ52qjw==
X-Received: by 2002:a53:d017:0:b0:64d:6193:a755 with SMTP id
 956f58d0204a3-64ee60d2da6mr1448338d50.30.1774403615667; Tue, 24 Mar 2026
 18:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260321004836.500390-1-npiggin@gmail.com>
 <20260321004836.500390-4-npiggin@gmail.com>
In-Reply-To: <20260321004836.500390-4-npiggin@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2026 11:53:07 +1000
X-Gm-Features: AaiRm50erc7Y4wrdOHoD_Xg_r-AWYRZ_g76XFom706MofSycf4cWGhg_NW4hDgU
Message-ID: <CAKmqyKOHsMfkzb530Kp1LyrC5ZF8d_oRDaqKN-BVPW51nv-OgQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] linux-user: riscv: Fix signal frame user mapping
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=alistair23@gmail.com; helo=mail-yx1-xb12c.google.com
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

On Sat, Mar 21, 2026 at 10:50=E2=80=AFAM Nicholas Piggin <npiggin@gmail.com=
> wrote:
>
> riscv signal frame setup is missing unlock_user_struct().
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  linux-user/riscv/signal.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
> index 358fa1d82d..22b1b8149f 100644
> --- a/linux-user/riscv/signal.c
> +++ b/linux-user/riscv/signal.c
> @@ -126,6 +126,7 @@ void setup_rt_frame(int sig, struct target_sigaction =
*ka,
>
>      setup_ucontext(&frame->uc, env, set);
>      frame->info =3D *info;
> +    unlock_user_struct(frame, frame_addr, 1);
>
>      env->pc =3D ka->_sa_handler;
>      env->gpr[xSP] =3D frame_addr;
> --
> 2.51.0
>
>

