Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC73CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 04:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbW2N-0002pi-Kz; Mon, 22 Jun 2026 00:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbW1r-0002ml-1N
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 00:13:13 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbW1o-0000Ay-Mw
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 00:12:58 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-697ad7f663cso714992a12.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 21:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782101575; cv=none;
 d=google.com; s=arc-20240605;
 b=S96C+R5zDQC1Bi9aXtWG/2n5K56Kl80VkLrznk8vP8Txo21KL2zOTL/i7/629FU2Mz
 5bk/LsCdSsKpyNEv4v1lB30VNooNpy6mBzQLjwl2gtVHED+iDurJ8p4Yn+n/H1ER8i+l
 FOAPoV6v/HAgiJJLPHqa2znON4QjvUhgelmm+0tPz5gv68wQTrh19ird0rU3+7rSbSlW
 +iO6FtC5LGMy+2J6vq7OnWQb9+3Z9Fi9tanYZipZYeHWLJkxGhWKKS5tyd1ZmLNRlT9b
 PbwHb3pRBJ3M9yZOTS5/fSL5dcGx6HoEmnXqGEQPtD4dFsQTrwi9WwF6KPDMiEcNIW6G
 g/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Qq/odUaXMxUN5BrCm8twid2sdR2qQJq9NaeYdQt/Gd4=;
 fh=y7YIBvsk8yjSHMSrQ/IayzBQeFDKTxtXj/T9bWeMUTQ=;
 b=RNViMZ73JSPQvCQ54sPhX+gnR1ZYioWWt+J5JSUrGaJ0BpDzy8fKrP7Bn1kQvGnkB/
 976SDZqD5Iu731ALLSIL0dJD+aOekimjmdqY4P9AHNdiaDqeXSD+LoivJXDoIi7vQlTd
 6jNPDS20jo7nsgitaN/lHl6R1RolO8vsCBFzAYLflkt8f4bzIEFQoXoeZJxoUqM9/HPw
 G6qEmsYyK87vD6ep1SOO5xX3m4Ar4vEvyHHmi00BUpsoqEyiNUfihdPh+wTnDbXiBZQ8
 vKDlkDEblyH1vFOtUth62zoW8o+JD5L17LOty7CIB2lC+2DepF6m//9oMz9Z2T3Dw7Dk
 GU1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782101575; x=1782706375; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qq/odUaXMxUN5BrCm8twid2sdR2qQJq9NaeYdQt/Gd4=;
 b=bMCZPLpMB4BQUR9gjGLNUcFojO/d69xH40pbrwZzGHcJnItP80ZVL7ATxwm4D1vjfB
 3ZpuE9eYCXD7L4wMocLDIcGLzvuyQ1ZJ0kmqy9Jm3EHH8KFjV1C/8kPm0oIy1Z1t3lme
 7TcT00mMp/pEm+XGxk+wVtjzVWaeP5dVmyikthqBbLhpMfoj7Q/xtwHK9IulziBkQYCB
 MQxSeN9ICvu5VE6uwWcAsDhrqtyrE6DxJdB9nD593wRBcsNy7ftr8iV13ez6QO2Ixq6S
 sDq97iq0rF/Ni2KMfPzDOGltONaVP4rjvVBxftVwZhOZTJam4lLIFy7qQDmSFKGLZO+j
 m8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782101575; x=1782706375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qq/odUaXMxUN5BrCm8twid2sdR2qQJq9NaeYdQt/Gd4=;
 b=sUr5RxUAijJL14VigSKcYpErqOMJGuyzYdPzaPNBU4jNH0oX5yEooXdjSO6fEUVqbd
 8yKOxjPS5cPCZbm3fp2I7w4bLorXxIuESYzPfFj8vGL7iLm17HXhpH+gpCgnmhoxDkpg
 q/SlE1uXslFDKfxHTJ6ndNbtqitJ4OyPfwmB3/ahjlHBs9UpZMEqg90dk2A9thi0vKcs
 hwGfkgXgtW5akaNW0+W8NtvpQpWUc8O1U+PoH3YXzWrsD/kKM0Fu8Uvj3LgCgYOQreCs
 wD4XKpwOUsvL8lADNWZ5mA5k+aaX+YeNQepYgr9CydxOjxytaKi7AOMNH3qGT2UY4lxv
 FstQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vRXBw0fe6TtpVR8m6oN7dioi19Bee8qY4m402RfdqrnoQp9/i65K5R2mUi98/ljO/IhOKo8f6JX4m@nongnu.org
X-Gm-Message-State: AOJu0Yz/1rxocHmWhbAjt9+DUX+xH++NHtXoMokInd0p4nvqMQY5ejf+
 nWF1N1r14fmN0vX9jnNDcznlYusxJSAjp3XqdLn5U0Arigz7aXgf6GQaP9UITXHRKRJkMbJeIT7
 e+7euwWU9Z2git8u242UE3NnFZj2hrHI=
X-Gm-Gg: AfdE7cnJ6/+den8q2w7o4EKqBicB++yoR/XpswTUZ6IQS17q0FcF9NU4g7lAn4nsRYg
 T7h9KQzx+8ysmyEzCg7Rhs0vQ9Ji39+WjTwonwtw50woZSV3huQyi4uPs6QzRgCEHNfhjMhbU60
 pEl1Ks8K506McVeEhu7EiyjP44sP3qsh5qG0AzhdZUp0FwJG9B8iJQbLm9Hnz7j7Zlpl7oCtKPW
 eDwVpO7MIUJhVDVy64CFBkNQZIfyv3AUyspWWFM1mUluFHnODQRRm6+ri9Oe8ZnIWBwh8JjhoYv
 oF0nUKzVUXENgJ33Mjc+gJfpYbI=
X-Received: by 2002:a05:6402:2812:b0:697:818a:2109 with SMTP id
 4fb4d7f45d1cf-697818a3199mr2674909a12.27.1782101575063; Sun, 21 Jun 2026
 21:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260511083105.641907-1-inochiama@gmail.com>
In-Reply-To: <20260511083105.641907-1-inochiama@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 14:12:28 +1000
X-Gm-Features: AVVi8Cf0RYAV3dgqvATNtpo5eO721X7_VxzcOinjPvxyLwtnZFKOQGm3eebRad0
Message-ID: <CAKmqyKO=bNBy447j_nxBLG+djeVGUKRfEmNmvS1T5nX2UgC4DQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Check PMP before updating PTE
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
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

On Mon, May 11, 2026 at 10:55=E2=80=AFPM Inochi Amaoto <inochiama@gmail.com=
> wrote:
>
> According to the RISC-V spec, the PTE update is a supervisor write
> operations, and it should also follow the CPU PMP configuration like
> the PTE read.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Logic looks good

> ---
>  target/riscv/cpu_helper.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 39c3486ae0..6edce36138 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1604,6 +1604,14 @@ static int get_physical_address(CPURISCVState *env=
, hwaddr *physical,
>              return TRANSLATE_FAIL;
>          }
>
> +        int pmp_prot;
> +        int pmp_ret =3D get_physical_address_pmp(env, &pmp_prot, pte_add=
r,
> +                                               sxlen_bytes,
> +                                               MMU_DATA_STORE, PRV_S);

Please don't mix code statements and declarations inside a block:
https://qemu-project.gitlab.io/qemu/devel/style.html#declarations

./scripts/checkpatch.pl should catch these type of errors

Alistair

> +        if (pmp_ret !=3D TRANSLATE_SUCCESS) {
> +            return TRANSLATE_PMP_FAIL;
> +        }
> +
>          /*
>           * - if accessed or dirty bits need updating, and the PTE is
>           *   in RAM, then we do so atomically with a compare and swap.
> --
> 2.54.0
>
>

