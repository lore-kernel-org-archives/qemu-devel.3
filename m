Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DE8CCD185
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 03:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9EJY-0001Ov-30; Wed, 15 Oct 2025 23:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9EJW-0001Oi-5C
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 23:06:02 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9EJU-0003dV-CQ
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 23:06:01 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-631df7b2dffso445203a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 20:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760583956; x=1761188756; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8K/sJnoUYI+NqxBBWlwg0KJedojXog/kakrdP2A4L6w=;
 b=Ej4qRZRVvcyYrLchclF4O5+pvpxhXG8WtFUZ1BhKT83KUS1Q76jlcJMMCbF6pdUck3
 aNuKYVdmMAUSLM83ClzYHLJ/MAkyNKTPFO4OTED7a83mxOxxPuSQiWdXEv5JdRhmGD+T
 sY/N/3hXwlxFwfPGCmWBCQxPQVG+0TMTaES1VHbibH4RntvzTxIoADjVe2e+CON+jEyR
 FCsg+4RQfmHrgOJEhvk0WuuXDxDuKqCr2wUjxlOFggtgMZ/smsBaV0iVMxwAQHxgXXWa
 gARc8o1nXdCGpbjn5Okzsjfbz2pH8RrgY6sJAWMpZgmTwfSOLl0P8U2IBmnLzII2vj4U
 drYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760583956; x=1761188756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8K/sJnoUYI+NqxBBWlwg0KJedojXog/kakrdP2A4L6w=;
 b=O4QmBVKxh//gkNr2qJX0Fj2vmPL3H6WRp0VJMFM95Ityx1s0n/nJZFj4Lm/Oae0h7F
 k6ENh0L7cHibvVflFG29vFuqPtKYvKu0/EtF6eyNd1ND1WUZxVwSdsdZ2oEQtRVET6J2
 MUJTsI/rvouMuxA3hR1Ex1ZF5uLpTi7ugnwVYPJAhM4KBU+IoPrKSIwopi9h3qag6Xdq
 usvttsTLj938i+fb5h3uk+rDybm9osPrz5T2w+rRNcNEMv++oX9p60YLROJ1YHezllD3
 lb1Ok7RQMCqD1aNtn3HqhuYcdzPA4JiZ7qpmehXp+XctZpyXAipgvbuhShiuCQuXSJfu
 FfJA==
X-Gm-Message-State: AOJu0YwpeZmf/x8JwRAXiTA1mA+DgWIko7eVzQlW29mp/9iTy8nmOywo
 9x78SOt3NSVxX7qJTP+vV1UiWzPeywUmaLSMyvUDowK1TcGOrt9RDr/9s8H8G3mgqQ/PsZtTjpr
 qzsNlV8d+I2xUstQZcPI4T1Ni9LMn9HA=
X-Gm-Gg: ASbGncspMyUAF757/O3LTq6criA9c/S4G2DsOUiFp0M5/80wNTHOoaY3h8j20JC4YWg
 7BMFK0b3OQ8dsspKn5F8RK8a3KIKZ+22pOEoScbJU5bQvc/P3u/uuTuhQ1xV8CdCqacmnhFGxn+
 IPN9IiXT6ST9DusvqFUQ69NXMGh/5dDCYtukCW6GCZ/OlccyG8Uz+XO8MUPVChFSBondNnFQHw5
 MInBvCo//hLcvM5lnPPKG65WNAryT7Zw+r2w9rybmeBMoB1QP+YaHA8bQ/DxSANcypcUXc+do7Q
 a2fXyD902eQz7marozaZXjKewA==
X-Google-Smtp-Source: AGHT+IGBdDPWYFI6aGg8PTpe/yKju+fCIbyTDJW1EcRBd3uPfoK+uHAwMgV9Iz6gppcLf5kn/UUeZVWYvHbmMWFMTws=
X-Received: by 2002:a05:6402:3258:20b0:61a:7385:29e3 with SMTP id
 4fb4d7f45d1cf-63bfde8ce48mr2009788a12.18.1760583956299; Wed, 15 Oct 2025
 20:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-6-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-6-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Oct 2025 13:05:30 +1000
X-Gm-Features: AS18NWAZYukjR_q9BVWxC9aF7v5qOu0wOqdWltA-E1IA42lPTni2rI9EsR5_eQM
Message-ID: <CAKmqyKMo-RMufipyErO_Nz9xx99ji23Tr0XzZjbtCC_nVjS+=g@mail.gmail.com>
Subject: Re: [PATCH v3 05/34] target/riscv: Bugfix make bit 62 read-only 0 for
 sireg* cfg CSR read
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
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

On Wed, Oct 15, 2025 at 6:36=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> According to version 20250508 of the privileged specification, a read of
> cyclecfg or instretcfg through sireg* should make the MINH bit
> read-only 0, currently bit 30 is zeroed.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 657179a983..8be33d8f2c 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1542,7 +1542,7 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int c=
fg_index, target_ulong *val,
>              wr_mask &=3D ~MCYCLECFG_BIT_MINH;
>              env->mcyclecfg =3D (new_val & wr_mask) | (env->mcyclecfg & ~=
wr_mask);
>          } else {
> -            *val =3D env->mcyclecfg &=3D ~MHPMEVENTH_BIT_MINH;
> +            *val =3D env->mcyclecfg &=3D ~MHPMEVENT_BIT_MINH;
>          }
>          break;
>      case 2:             /* INSTRETCFG */
> @@ -1551,7 +1551,7 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int c=
fg_index, target_ulong *val,
>              env->minstretcfg =3D (new_val & wr_mask) |
>                                 (env->minstretcfg & ~wr_mask);
>          } else {
> -            *val =3D env->minstretcfg &=3D ~MHPMEVENTH_BIT_MINH;
> +            *val =3D env->minstretcfg &=3D ~MHPMEVENT_BIT_MINH;
>          }
>          break;
>      default:
> --
> 2.51.0
>
>

