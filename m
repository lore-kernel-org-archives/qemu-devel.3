Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C9FC61DB2
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 05:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOUea-0002Qt-QX; Mon, 09 Jun 2025 01:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOUeB-0002NA-6g; Mon, 09 Jun 2025 01:02:11 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOUe9-00055l-Of; Mon, 09 Jun 2025 01:02:10 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-60727e46168so6865504a12.0; 
 Sun, 08 Jun 2025 22:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749445328; x=1750050128; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pVCgp3TbWPn1gDZNN0WPV4n/+krSke7/puauQ3yPOaw=;
 b=fxfOgxDEZaDvXbWnf/3iBV9wSd8ygKLi6olhj08/5/adQeedAjuhziPGRYmPX/IJJ8
 c0pUudUn9E7vdDWuRdH5qqDGOpelEP62TO32rDa/GWgE6D6h1Z1QZ/NFtbPZyYxyAusR
 aDBXAfSSck27oWMTIPTx2O+vsqUMyvRuA2UDQAT0XA8AobdkLTfqNADxT870867Lq3eo
 uYdcKLJDUM82Kj9Eke1r1zUIVbVo7HoPjqLUzHKJFJAZ1pUgnsWaC6U48zXt47yZrJbB
 immtI4TX401wF7KPpfQ4txGHvJVCwPb7BKmxQVrd1Z0wtl1rUVpCSdGV/lm1XAY5JKkR
 OjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749445328; x=1750050128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pVCgp3TbWPn1gDZNN0WPV4n/+krSke7/puauQ3yPOaw=;
 b=T03L8aZOqKkbj4GHrv10nbVBmK0fnipNNN2ywWkJIZOqQPP43qXUw6EobMoJnziraw
 17f52SCiZkYcnEg/2oFSW9ixcbgb4KxxAmA/rcfaS1yEDhqRxTu5SARvWVT5V1RQ0s6R
 9I1rXJHGM/eFQUgpGUWwzDi4iwu7UTurxQl1U4IigUCjxBkzk2unBL8z7Ywe9Iv72/Ja
 gxJoQ3dCWa+wdRFjwzPqGcdtnWHHxMl2dbtJHTRd1Nu3s/vhTy3dES8gcpy2fKEciNo+
 FuNSFzuJpsIZcNwwlm+V05uJ1dCxmoSdcXxSgZQOiJwHwkZfzmeI0KwQF/131mqJDxab
 69Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM0sroELYhyocuutfKcQnjqLuXX7hC+pvftrZ7nHpfJC6npFEQgy2DWSAM7Fnh+rqJ3eU4dNqHqOy7@nongnu.org
X-Gm-Message-State: AOJu0YymlWJjGxV/wTk4PWe3k7EONEFplcMvtp5oBaSz+3v3eqFnt9Te
 /5WRMuRTNMu3NvuwCkfROhmyLaTe0vf6jWzficN9k8kWyScaofEUqfVgyPxCGFZ1T+58n9LZ9a0
 xhm5epVTnRUxQr8nxqqIddKXfdonwJ+o=
X-Gm-Gg: ASbGncsDIsnKiyrBZITLzLoVm15rxEi/QZZG7+rOJ5/7xfbvKePT+yxaUyYNqcqbVxH
 OeZD4uOMn69/XKrUiE5ufYsd+8tnB65lTKPFpw/Mu18TwGjw3jktkBoiypahnPYZqlEc4GhCODk
 OT5AfUizCsQ2P4368zFgwHoXqW0qI472lnYCXqPdcm8bxbaruku4qYWnboI+y+GNg=
X-Google-Smtp-Source: AGHT+IHKm1Cj7WF+dsCEJ9LUxQOrkyy4M5fxy8X9E/lFvJPxA92+Vozd2A8bb35eq9l7dz5CiOIHv4SPc0gOLlqKtbM=
X-Received: by 2002:a17:906:f58c:b0:ad4:d00f:b4ca with SMTP id
 a640c23a62f3a-ade1ab3259dmr1013584766b.50.1749445327684; Sun, 08 Jun 2025
 22:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250501114253.594887-1-antonb@tenstorrent.com>
In-Reply-To: <20250501114253.594887-1-antonb@tenstorrent.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Jun 2025 15:01:40 +1000
X-Gm-Features: AX0GCFssWeLJxjU5v41vgs3or4zV1znVssJ7qRezshZd9H7pHfRzpEBHNvSadnA
Message-ID: <CAKmqyKPN6CMyA7n=hNZ9GHacAgHpqYsW5Zpojfeo=FjwqckkMg@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Fix fcvt.s.bf16 NaN box checking
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
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

On Thu, May 1, 2025 at 9:44=E2=80=AFPM Anton Blanchard <antonb@tenstorrent.=
com> wrote:
>
> fcvt.s.bf16 uses the FP16 check_nanbox_h() which returns an FP16
> quiet NaN. Add check_nanbox_bf16() which returns a BF16 quiet NaN.
>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/fpu_helper.c |  2 +-
>  target/riscv/internals.h  | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index 91b1a56d10..31c17399fc 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -756,6 +756,6 @@ uint64_t helper_fcvt_bf16_s(CPURISCVState *env, uint6=
4_t rs1)
>
>  uint64_t helper_fcvt_s_bf16(CPURISCVState *env, uint64_t rs1)
>  {
> -    float16 frs1 =3D check_nanbox_h(env, rs1);
> +    float16 frs1 =3D check_nanbox_bf16(env, rs1);
>      return nanbox_s(env, bfloat16_to_float32(frs1, &env->fp_status));
>  }
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 213aff31d8..794c81bf7c 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -142,6 +142,22 @@ static inline float16 check_nanbox_h(CPURISCVState *=
env, uint64_t f)
>      }
>  }
>
> +static inline float16 check_nanbox_bf16(CPURISCVState *env, uint64_t f)
> +{
> +    /* Disable nanbox check when enable zfinx */
> +    if (env_archcpu(env)->cfg.ext_zfinx) {
> +        return (uint16_t)f;
> +    }
> +
> +    uint64_t mask =3D MAKE_64BIT_MASK(16, 48);
> +
> +    if (likely((f & mask) =3D=3D mask)) {
> +        return (uint16_t)f;
> +    } else {
> +        return 0x7FC0u; /* default qnan */
> +    }
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>  /* Our implementation of SysemuCPUOps::has_work */
>  bool riscv_cpu_has_work(CPUState *cs);
> --
> 2.34.1
>
>

