Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5F3C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 00:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcwNW-0002R3-DR; Tue, 28 Jan 2025 19:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwNU-0002Qr-0I; Tue, 28 Jan 2025 19:56:24 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwNR-0003pj-J4; Tue, 28 Jan 2025 19:56:23 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-518a861612eso116042e0c.1; 
 Tue, 28 Jan 2025 16:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738112180; x=1738716980; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nBFkE1nNnJlq7Gg+P7bjrYGnRFF0iRorpLyAEfOmwQ=;
 b=Gx1fvC21HI2MfZ1yI2hros26///pBkk/yntqCij+EJQcglCDD6T+2oZfzl33hR3IqT
 0pYbotekq2aKfC5WrUebwELkHm++GVxlu9B8HOWrKXJDTi+aB93aPqsrngJnemepWqXX
 KU4uvXBaHJs3upt2nMJsSNsPULP+mklBdmCG4lQzSkj5KuZCGifgy8f5Dmh6Fg3ZAwEd
 +0P0t94wFvEGR8lmcaBNS9YVbar6hx7UyDR/bcV/PdGFR9QuFGYb9lm8qXER4CDwfG41
 lDeG134qDHajXRn7HMdvJB1JjVq628bccLj9GFsIn2hXWbB2GPLBrDcU9ywda6xWmAmT
 E0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738112180; x=1738716980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/nBFkE1nNnJlq7Gg+P7bjrYGnRFF0iRorpLyAEfOmwQ=;
 b=WVRbwRSme2Q1adYwnAxaD/uBmR7JI39gAyRim1cVQ54ZBMldXShRygMMm8jZA42W8H
 HtfyyeJD9NQg8kd3LQmrP53+Z4sKkt6PES588xqV3sor6/k8x+9Bs43cP3uO0Udu20pB
 dYu78hVOdO992P8zvvqCS3UmCA4byYPh+KnlhL6WQu+clFj4Us8P0/EtjsTPgjYvOloV
 LAIGesV4y6+jtfhMFzW14Sf9F9ZN6WBOCQAIHolgLAaU5uVQ+MsT594XO8g/OCqIRyqf
 KDUW6m9ikT6FLJFIpB2hMD4tLrnVseNq6zMCwDNGjp2Lb9F2mQZk+ibYQtLWyodBkb0u
 jfQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUff1fm4OOGb4LM8jyHW+uK0WW9aHl3G3Kv6+XTRL9xaDWmy5TEVWjB2T+GBlS/zVrMoZfoBR9Atojo@nongnu.org
X-Gm-Message-State: AOJu0YzAa254ELTEkxySbnH90NiKMLhBwAfadNhqb03nOeJhR8CDdaHn
 8VlS9+a4ZABJhfsZyvAUGlRRP0KCrfclCevKw5sfxIxBQsWPQapSwXRGcbL/tLZ6r+qKv+6s9Er
 VVYbgAvHT/Vwl565eeqLn2K1yH/K2xw==
X-Gm-Gg: ASbGnctbPkXx2yIehJ9v+KxQWptfwS+KDECsamOmU2zFyjI3ChaMo9+1gZtBzJPhYlJ
 plRfL1J5sxX3WxQLGq1D33bz8mO9y+XH9rFtMSGXkAYWYWFk0S6Ll74PdNmAWIEQJ1U/dsZzO6t
 G48O3VuXkNu2Ph/1qmML9VX2utBQ==
X-Google-Smtp-Source: AGHT+IHc9reZOS9H3jHcpokT/76RktNj7M/4G3KRZSjQBD2NF6sSfSnimqivdKUuzalPRMb+wRwGnMeApFtmsl/4WXk=
X-Received: by 2002:a05:6122:3c42:b0:518:7d3a:dd13 with SMTP id
 71dfb90a1353d-51e9e459d82mr1437847e0c.7.1738112180109; Tue, 28 Jan 2025
 16:56:20 -0800 (PST)
MIME-Version: 1.0
References: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
 <20250121184847.2109128-3-dbarboza@ventanamicro.com>
In-Reply-To: <20250121184847.2109128-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 10:55:54 +1000
X-Gm-Features: AWEUYZmjiOn06WBqKW031fSxKesWHrq-q_o6VgJ5gWwjHPsp5s9HtVzF6LhAWjQ
Message-ID: <CAKmqyKOgWJwe+LXe4X8Y0gbVU52Qmjwhf6gOcs9je8Qjxy+9Eg@mail.gmail.com>
Subject: Re: [PATCH 2/5] target/riscv/csr.c: fix 'ret' deadcode in rmw_xireg()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 22, 2025 at 4:50=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Coverity found a second DEADCODE issue in rmw_xireg() claiming that we ca=
n't
> reach 'RISCV_EXCP_NONE' at the 'done' label:
>
>  > 2706     done:
>  > 2707         if (ret) {
>  > 2708             return (env->virt_enabled && virt) ?
>  > 2709                    RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP=
_ILLEGAL_INST;
>  > 2710         }
>  >>>>      CID 1590356:  Control flow issues  (DEADCODE)
>  >>>>      Execution cannot reach this statement: "return RISCV_EXCP_NONE=
;".
>  > 2711         return RISCV_EXCP_NONE;
>
> Our label is now reduced after fixing another deadcode in the previous
> patch but the problem reported here still remains:
>
>  done:
>     if (ret) {
>         return RISCV_EXCP_ILLEGAL_INST;
>     }
>     return RISCV_EXCP_NONE;
>
> This happens because 'ret' changes only once at the start of the
> function:
>
>     ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
>     if (ret !=3D RISCV_EXCP_NONE) {
>         return ret;
>     }
>
> So it's a guarantee that ret will be RISCV_EXCP_NONE (-1) if we ever
> reach the label, i.e. "if (ret)" will always be true, and  the label can
> be even further reduced to:
>
> done:
>     return RISCV_EXCP_ILLEGAL_INST;
>
> To make a better use of the label, remove the 'else' from the
> xiselect_aia_range() chain and let it fall-through to the 'done' label
> since they are now both returning RISCV_EXCP_ILLEGAL_INST.
>
> Resolves: Coverity CID 1590356
> Fixes: dc0280723d ("target/riscv: Decouple AIA processing from xiselect a=
nd xireg")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index ab209d0cda..0e83c3b045 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2697,15 +2697,10 @@ static RISCVException rmw_xireg(CPURISCVState *en=
v, int csrno,
>      } else if (riscv_cpu_cfg(env)->ext_smcsrind ||
>                 riscv_cpu_cfg(env)->ext_sscsrind) {
>          return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask)=
;
> -    } else {
> -        return RISCV_EXCP_ILLEGAL_INST;
>      }
>
>  done:
> -    if (ret) {
> -        return RISCV_EXCP_ILLEGAL_INST;
> -    }
> -    return RISCV_EXCP_NONE;
> +    return RISCV_EXCP_ILLEGAL_INST;
>  }
>
>  static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
> --
> 2.47.1
>
>

