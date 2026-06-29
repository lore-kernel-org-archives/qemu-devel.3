Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92160C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 00:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdzgT-0003po-1K; Sun, 28 Jun 2026 20:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wdzgR-0003pJ-N0
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:17:07 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wdzgQ-0007Qy-2O
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:17:07 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69532288224so5481039a12.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 17:17:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782692224; cv=none;
 d=google.com; s=arc-20260327;
 b=K4SCstthpVbc12f0IynLMv5V+S0GrEZG4fRSspmvuB2hXBUzEnSxVouv0H19ZBeF23
 UTs/pyBM9i9fbLHa1xCGXhl7qubw1PeHhEuTnSEpBCHZP4ZCP2G1RtWxwZgQSjDf7CqF
 T8B26wHOx7kAIQUR54PcNWds2XWNsbywiHtXvztz/UnlhKTHo9aJLgta5i4iu1KVZjCf
 PiRafyOMBdaJNPhVgJ1mki5Xnwf7sNLnDjAh+GB+CgMYN+DB899FDVG4TvM2vXl6P+8I
 +5At7/9lIOAnWlCEqKSxBOkUCmsruAz0ZSUxPlY97J7tLd1l1nHnKjXcybBkSew/40JB
 vUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TRyPeXcr6E5hSqOSHx3f/68BnkoL+hzcMTZ5s76Hkbo=;
 fh=SNhkNF4TzNS9JejW984Ib5u0+vj+P94zb4ExHRqkKio=;
 b=EKZ1O7+C5ssuyvQHfKu9MHWeC+KeK53xGrAwAgfye7mn96brcJdRYtK+8qJ7vcgrB/
 62bhFQz8oZc6/qbUFT50yB5W77rxHcxNTODrtsi7DCOtUKXKoeWmw1OLF37A8peP7qU1
 FgZNgvLiVFlkzEfN0l3uEGp2xqBKWJd7SE2JdY+XU55t0+mOiHJWbA4rWwO4aA1tUA+G
 caQPHNEzM3bc0dvsuWf5Elp1ugKU8zHRFGhrTUS02V1lu5ZccsEwRfxRchvyoR3GEljc
 5U2udM/smbXe8Utzef2unsKz6bCziTV28Mvzx+uKsa+T/XzFq4qkE8fu/Gh7urXqlb0/
 zySw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782692224; x=1783297024; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRyPeXcr6E5hSqOSHx3f/68BnkoL+hzcMTZ5s76Hkbo=;
 b=NPNn4d+8050LUIdUOCA+QjvShaGxTVlGkBtqrnZxg+0yXE+a+IM/kkH0RBpgHzTlIG
 JDAfOXiqSw4bT8CN3aSAHeGcHqf9ncu6aJ/r4ume3PonYEh6RZzGHXrrSlP6uBhAwx2T
 WE/a3JUHF0p5jL/NDiBCx/yksOjkZFVhcUmDL14/cnuAMHdFMuzx5U5nQ0KsQFjb6kRV
 jCXYIwYj3XZDBJjodt/J290sSbDCbFDGJ5jVRKQgPjAUASzC/1oJgEL4Wc9jdxi2mnpk
 BCPo0ajL5UiF/hHKWNILF9AvqFaftL2WawO6bF7ptsyx2dzNX3nUUm6X9D1UzN721m3m
 8l6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782692224; x=1783297024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TRyPeXcr6E5hSqOSHx3f/68BnkoL+hzcMTZ5s76Hkbo=;
 b=eXFA/eXVixLxp7NvK/Y5C6swp4bi1jZ44yqz/gVB79cDfioArko6Dr1m5VJpG0NyGt
 1P4Zr9BcszOc2/0eay5MENZvglL7KasS85Z1ar90QizFFsOiLTNjUZ1AngwptmIDi5fa
 zfGvJgkwl6VC58+oVFGaOjG3/myapJoAQpc6M6TIqXxX2FWGmcl562RlRv59SLCLo4z1
 rKosZuhYwEHEK46zVG9g1GWGLCLJrjkv5zZajnMXIEBHgS7MvzCjJpWK3ZAWlF3DC2d9
 dPXRUnTI+hNtbQKNytPB/q5SDPPUiFapos67rMhf9RxKyry8nr1nmnwCs964vw7V4ZOQ
 P0Nw==
X-Gm-Message-State: AOJu0Yzm7e9m6zRWi6UoZ4BpmvqT/rgGRxHFc9jL8wlbXfOkAIY++svX
 A1SyvET/cJdT20T9nM7bHBXwv3+hTUXXkCD3xnX4HRb60Czs2klCI/3DkzN/4Xng3Ska29J5Paz
 clpeHoF12S3vH1wU5ndEAigS6+JnL6ek=
X-Gm-Gg: AfdE7cndWX6gihSZnZ3lwkdJyctWdmqNWlPRiwuayBq5cuhhc1F27yryMzivnSL6BJn
 vsyq13K+Ef9aT/dLkO6vl5FDE16Cg7mHa0CN9JzzAu1/CnWZ0/Vzp6WSaC5F+7M7lTGZTQCqoYo
 Pz25VYshtYEw1mJMPQTaKGh6Qe0guAXFqIfaiNvrqxynPL5xaZPxTRlBVWKi4U2BN7O22jEjjML
 T0KpTzZ4T+YXLlHO9JyxjZTHBIz1+DEDrotLirh2kn+kN+FgfFYITfwcRW50K9K1GrRCvfzqH4c
 eM6h4P7C/usAcn9d6U+w+6BvLT+n+XeCA9RxMg==
X-Received: by 2002:aa7:c755:0:b0:698:3b7c:7e46 with SMTP id
 4fb4d7f45d1cf-6983b7c8059mr2210342a12.38.1782692224258; Sun, 28 Jun 2026
 17:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260625081521.595683-1-suunj1331@gmail.com>
In-Reply-To: <20260625081521.595683-1-suunj1331@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 10:16:38 +1000
X-Gm-Features: AVVi8Cf0G-T8EZwZHAfFiuLCOgI65AVLwf9ASqzRBHoxQ1dCoITUQIRo6ZeqvrM
Message-ID: <CAKmqyKPgZxELoTpm32D5i_Q4egzP64UmF0RqKu=1yoSVmz2Jew@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Apply UXL WARL handling to vsstatus
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Jun 25, 2026 at 6:17=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.com>=
 wrote:
>
> write_mstatus() already handles the reserved UXL value by writing a
> legal value instead.
>
> Apply the same handling when writing vsstatus so that reserved UXL
> values follow the same WARL behavior.
>
> Factor the common logic into a local helper riscv_write_uxl() and use
> it for both mstatus and vsstatus.
>
> Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Fixes: f310df58bd2 ("target/riscv: Enable uxl field write")
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/csr.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index dd9726fcf4..12f1ce5180 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2012,6 +2012,20 @@ static target_ulong legalize_mpp(CPURISCVState *en=
v, target_ulong old_mpp,
>      return val;
>  }
>
> +static uint64_t riscv_write_uxl(CPURISCVState *env, uint64_t val,
> +                                uint64_t field)
> +{
> +    RISCVMXL xl =3D riscv_cpu_mxl(env);
> +    uint64_t uxl =3D get_field(val, field);
> +
> +    if (uxl =3D=3D MXL_RV128) {
> +        uxl =3D xl =3D=3D MXL_RV128 ? MXL_RV64 : xl;
> +        val =3D set_field(val, field, uxl);
> +    }
> +
> +    return val;
> +}
> +
>  static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>                                      target_ulong val, uintptr_t ra)
>  {
> @@ -2058,17 +2072,8 @@ static RISCVException write_mstatus(CPURISCVState =
*env, int csrno,
>
>      if (xl !=3D MXL_RV32 || env->debugger) {
>          if ((val & MSTATUS64_UXL) !=3D 0) {
> -            uint64_t uxl =3D val & MSTATUS64_UXL >> 32;
>              mask |=3D MSTATUS64_UXL;
> -
> -            /*
> -             * uxl =3D 3 is reserved so write the current xl instead.
> -             * In case xl =3D MXL_RV128 (3) write MXL_RV64.
> -             */
> -            if (uxl =3D=3D 3) {
> -                uxl =3D xl =3D=3D MXL_RV128 ? MXL_RV64 : xl;
> -                val =3D deposit64(val, 32, 2, uxl);
> -            }
> +            val =3D riscv_write_uxl(env, val, MSTATUS64_UXL);
>          }
>      }
>
> @@ -5226,6 +5231,8 @@ static RISCVException write_vsstatus(CPURISCVState =
*env, int csrno,
>      uint64_t mask =3D (target_ulong)-1;
>      if ((val & VSSTATUS64_UXL) =3D=3D 0) {
>          mask &=3D ~VSSTATUS64_UXL;
> +    } else {
> +        val =3D riscv_write_uxl(env, val, VSSTATUS64_UXL);
>      }
>      if ((env->henvcfg & HENVCFG_DTE)) {
>          if ((val & SSTATUS_SDT) !=3D 0) {
> --
> 2.52.0
>
>

