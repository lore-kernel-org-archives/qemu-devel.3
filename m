Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6F8C28B2E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 22:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trPMK-0005nu-U2; Sun, 09 Mar 2025 18:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trPMI-0005nX-Cl; Sun, 09 Mar 2025 18:42:58 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trPMG-0000GD-KB; Sun, 09 Mar 2025 18:42:58 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-86d42f08135so941662241.0; 
 Sun, 09 Mar 2025 15:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741560175; x=1742164975; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbSmkDKLAOpBxTdZyiY5SkGxR5TU6K4rKLFsF80AAiY=;
 b=VaQeGHd/VfwKl7VQJb1nh9BG0BmMJWhiBzF9gJcKzn1e0+72TfJQoagqivOlYZzBrB
 cl+FAIc6QNnx6KKrwsQaPiVijoSzldIV9fDp/MjClrjkx1uth6qktKAck0o9jkBJQc1L
 lfM4h1Qf80ZiQsQKoiXc1iTCCkViz1ieiaK3yfIMUA3mZyvEl0Xchov4EH3y9KO3YXDr
 /0fF2h16kcfZtyBPyNuDS0n5oOxksYdrYPycpYsWFCnJJ38AsfcxfDCUYGFgW6OVqdId
 iao4/qYTA7tlifzCAE9vktxhKAyyd5Ae+4UxBlbFNR+dW7zTjWCGAa5+YfIpgJSqKZZr
 gVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741560175; x=1742164975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WbSmkDKLAOpBxTdZyiY5SkGxR5TU6K4rKLFsF80AAiY=;
 b=qVtEm/WojT9XtGGfNj3cKU/RpLYvJYYCCF+1rdlnEaO5gYmY2G3kScPGATZDcvhuvD
 9AdYOxkQPJL+/GqCjp1FWZF7hRppBbL0hNQ7y/LIJ3CUuKVFukba7qrbBJiNrwiwAg6S
 mVL+x1BjzePJBTPKOaIBcR9fYD1inamFU/dsQkOD77swRjbAZOksf3YlRe7c+zZauU55
 K9fUSE4bzIg459oE4uQl1ULcY8Lftu8umWwkbcV5cQhuSjCgzsOdjsl36JKMU0JBGN4+
 gzxgI8fvVBN4YU0J7f0d25hbA8LHaYGaW1KcWW+JWOZqvzWDiQYv2Z+C6k/FYnEq8rku
 7RuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0OUHz3m/mzAwKdVppkj65eC9pvW1p6yXBZoFHUXjQkwTAnd1na6mLltMfPptBjTFa8aSPvJ2V7uP7@nongnu.org
X-Gm-Message-State: AOJu0YyZWlNSVv0rVzE1T1GXubiXdTaU53LJmn4wCPSwn3fwsGVwbvQW
 RktqNmuuoh8TSyBoeJ1ln2yRrhkKOJypqqlqb8epWVIc8Ypfuwpl/HLSFwcnhuX07TcNZUYJUbq
 vnp0PaWebl4BL2y+zzW8PiHHAN2SBOQ==
X-Gm-Gg: ASbGncvahm0hUuXCwFsSvDia2x+XHUud+W4zURq1wavr6t1ya/bgfnYg+c3ePGsuPiS
 cu4mirKByPBe2gJXUZL+yEHDDK4uUFgnzD7JeLaYQkkxZ1CweNRyjYP42zIQnHOgk8moxK9Hezb
 3//Hx9NW2e5gDgE0LQKb3x/a6oxkSONYHhwpjarOxtjqQiK8GYfX3U/03YhCF7H3Wbhw==
X-Google-Smtp-Source: AGHT+IGv9nwGuX+iuaf8IZjetxoqFin5b1t+/ES3vurP5Bj9xfrJ+Wj0ye5H04Sdu5YYDeYjgWs9F7LrBuMApSOegao=
X-Received: by 2002:a05:6102:578f:b0:4bb:4c52:6730 with SMTP id
 ada2fe7eead31-4c30a5ec045mr7494389137.12.1741560174773; Sun, 09 Mar 2025
 15:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250307124602.1905754-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250307124602.1905754-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Mar 2025 08:42:28 +1000
X-Gm-Features: AQ5f1Jrm9PDNhjBcANOE-Zo0CoXOUchSfPmXSh1UXQwM28XGAk-ieowExCidbYk
Message-ID: <CAKmqyKMbX4EH9-GcKz2nSCC_v3EGWH8Ezkjik68cLd5o-Cp8cQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/csr.c: fix OVERFLOW_BEFORE_WIDEN in
 rmw_sctrdepth()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
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

On Fri, Mar 7, 2025 at 10:47=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Coverity found the following issue:
>
>   >>>     CID 1593156:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>   >>>     Potentially overflowing expression "0x10 << depth" with type
>   "int" (32 bits, signed) is evaluated using 32-bit arithmetic, and then
>   used in a context that expects an expression of type "uint64_t" (64
>   bits, unsigned).
>   4299             depth =3D 16 << depth;
>
> Fix it by forcing the expression to be 64 bits wide by using '16ULL'.
>
> Resolves: Coverity CID 1593156
> Fixes: c48bd18eae ("target/riscv: Add support for Control Transfer Record=
s extension CSRs.")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/csr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 0ebcca4597..e832ff3ca9 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -4296,7 +4296,7 @@ static RISCVException rmw_sctrdepth(CPURISCVState *=
env, int csrno,
>          }
>
>          /* Update sctrstatus.WRPTR with a legal value */
> -        depth =3D 16 << depth;
> +        depth =3D 16ULL << depth;
>          env->sctrstatus =3D
>              env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (depth - 1));
>      }
> --
> 2.48.1
>
>

