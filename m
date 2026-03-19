Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2ECFB5EAA
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 03:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w34Fw-0005li-6Z; Wed, 18 Mar 2026 23:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w34Fs-0005kr-Fn
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 23:41:05 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w34Fq-0004rg-D5
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 23:41:04 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b97905516faso59250866b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 20:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773891661; cv=none;
 d=google.com; s=arc-20240605;
 b=k04w3+NXfWnsquNS+Tu2KQHe+W+cuqSLi1BsjcBWoO6GwRCzvVXw09euA3iAVDZ4UU
 b0cMmyjZ7BNWocYuOgE2pTI557l+hXBFCTZQhBKLX2Q6z76jo7mxBN/Gc57vRSRdpzGB
 yNuJkOR7aSOEpXKvrd/3XHADl944noLYl5S/u1SE+R0h1dVcjYu8aHUm01I9o+RNFeI/
 LcY7KNtgVMN2284zHzBSeBe/qfOU2g/sj0l1Z8T/TYlzXel08/z29h/HfmAirJ0N1LhS
 tuLGH5nHZut0zGOZy1buIPOAOk8g6mG1pjOiPo2gI/E0rvVuYXze9hcnfdeQP4lw1ABg
 Wd9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DFYmK6ITmeuaRM2WaLu+ZgV79ZlZniogYry9/F4mCJ8=;
 fh=rBjBKsEzs1JIYGyQCUy7R8m0YYLVbZbBPtXybSKKRhw=;
 b=XUHzKkF0SUiL41oXolk+JcRUBZlxGcjNXzAIQgBPwf8qL8s2MH5v6ivNkkHWJ8M5bw
 zZuXsotRs4y18JlCef6P7lV4LOfyaPgOZ/up7Nw2lruUwntyBU6G0ukoczJAa50mZpjN
 vOF+1m9jS70AZGGUUQavnnAJ7dFCnMbxP27LSjjwEK1DtzB8/+z6dRTlUQDK1S3AqBOb
 Zx0Xlvo4sBS5RLMRXowEv/dOMJSi3t+KGKSgb/l8y7iRjpzBlQNkkdy/zlZ/YU6YR/0x
 HuwbbeXMeC8pxyQJ3uS0RfcggMqWAj2v5YaX5mqxsnB8eWkIi05RvQxw+evlirLv/f1p
 LGNQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773891661; x=1774496461; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFYmK6ITmeuaRM2WaLu+ZgV79ZlZniogYry9/F4mCJ8=;
 b=QRxlZAxQc57f3raAm5rrNVZveUcoehECs3gCQx5RWknouL8GhviOAo+V4BN4gfjPMT
 gwD1ALu5a13rsELzzM7LClOsuMfVOk8q6JbwD8Es7bcjzJTG6QrRkmEJkaxH/C/5vF5x
 McrMtulF4gNRprTWu4e+pg6K+/GqHIvAC1nXvIULa15CqNRiJXZtzAPOUp/0qDuZZ5iU
 bywjFT56mvQ4g2FZIvOCyI1ea5SLacE2k9ZTsaI1HR+WNdehh9TGcvCUqnv4ICThXAHl
 ZwqgY4cuqQEgZ/+ABFDaiJ33+tN05VoxhRubTKe58FfcDMOsy+4owWuGs9zy0rCZf/dR
 Fy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773891661; x=1774496461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DFYmK6ITmeuaRM2WaLu+ZgV79ZlZniogYry9/F4mCJ8=;
 b=Vt5xLZwmw4u98Dml4TvGhNoAtb/ZuTGR4vCTTunTkFGK4lbqNAOvV8RjjWTCb4WSX6
 s8T5xQ3fr8Rp87/rsVbHEcGsza8q1tsgW3KL9S/jMROmPvr5q742hEx1p6nPwtrBeTCF
 tQtTY1dPAdD2iSZAAhEo1ZK708xwSo8a/6ecsBqQyT4Ma7f63WC4+Rl/mgHVoUoOunYO
 MfrY7qr2EqCf7B/Uko7Vf8f+A8tySh7MKLJzHwT3W9O2YlRW7xbkV4QvPzbJWxVpB1yf
 t31Kapk4A2oytxfodxxsUSIT6+N19cM6+LM7kMPS6XhmnsXbgt8BU5ILuQyfl36Dd5Yi
 jlZg==
X-Gm-Message-State: AOJu0YxioUhDjnuZ6lpDWVpvhKXN1wBWMxEDETS4FojcOyVNR++N29r9
 cLwiCon63DI8y3UEjF4FtEBRvlIjVpN5eX6gubHmxyt7kx4G9yNb430UfAVvvzc+N8OU6uNKfCT
 mzZElOJyRjKsixQtu9lRWM9hPyQNTdEo=
X-Gm-Gg: ATEYQzy1tHpXuWLUX2jaGtxAOItXtavQau4zyXpfkIfo1clJmwsIHX/eA0aT85MoyQd
 OZi14uOezFsVCITFv/WFbmZ6dg8vMsW05U+2zZa2gq9wR5yfQIUGgtTJrIK9D50qBdb4f+xv6ZW
 hY4hWexuRI71E24HaRywusceF7GkFsOWtxZK1ho51WLFMjveU+iIhaPDRN+zioLYeI6fGZL5NUS
 a/+2pAuCMmvXVhorEm4IxDd7IBU4LpZlPeK8DtgdU1tw6ZpLsqF3/7xk3rwr1GE161SY+IqS3p/
 4f2g7zNIRxlcH1uCADPlHRlskz5/uF6u4SRaFg==
X-Received: by 2002:a17:907:268c:b0:b87:7485:b4a8 with SMTP id
 a640c23a62f3a-b97f437c5e0mr368077666b.0.1773891660505; Wed, 18 Mar 2026
 20:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260318024234.2772480-1-jim.shu@sifive.com>
In-Reply-To: <20260318024234.2772480-1-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Mar 2026 13:40:31 +1000
X-Gm-Features: AaiRm53VfYW_ethorKXxec_Ei3fshstYLFZ04unhl_Ws9UiLN2Ymvt75fzsJgUY
Message-ID: <CAKmqyKP-n6-RP_kExrQv7NeT1EBKgeaG_fj=-V2+sydncX4dqQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix scountovf CSR behavior in VS-mode and
 M-mode
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
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

On Wed, Mar 18, 2026 at 12:44=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote=
:
>
> From Sscofpmf spec [1]:
> - In M-mode, scountovf bit X is always readable.
> - in VS mode, scountovf bit X is readable when mcounteren bit X and
>   hcounteren bit X are both set, and otherwise reads as zero.
>
> [1] https://github.com/riscv/riscv-isa-manual/blob/main/src/sscofpmf.adoc
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/csr.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5064483917..a75281539b 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1599,6 +1599,7 @@ static RISCVException read_scountovf(CPURISCVState =
*env, int csrno,
>      int mhpmevt_start =3D CSR_MHPMEVENT3 - CSR_MCOUNTINHIBIT;
>      int i;
>      *val =3D 0;
> +    bool virt =3D env->virt_enabled;
>
>      /* Virtualize scountovf for counter delegation */
>      if (riscv_cpu_cfg(env)->ext_sscofpmf &&
> @@ -1609,8 +1610,19 @@ static RISCVException read_scountovf(CPURISCVState=
 *env, int csrno,
>      }
>
>      for (i =3D mhpmevt_start; i < RV_MAX_MHPMEVENTS; i++) {
> -        if ((get_field(env->mcounteren, BIT(i))) &&
> -            (env->mhpmevent_val[i] & MHPMEVENT_BIT_OF)) {
> +        if (env->priv < PRV_M) {
> +            if (!get_field(env->mcounteren, BIT(i))) {
> +                /* no mcounteren in S/HS-mode */
> +                continue;
> +            }
> +
> +            if (virt && !get_field(env->hcounteren, BIT(i))) {
> +                /* no hcounteren in VS-mode */
> +                continue;
> +            }
> +        }
> +
> +        if (env->mhpmevent_val[i] & MHPMEVENT_BIT_OF) {
>              *val |=3D BIT(i);
>          }
>      }
> --
> 2.43.0
>
>

