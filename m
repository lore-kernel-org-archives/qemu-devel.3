Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2E8CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 04:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Fhp-0006uQ-Vl; Thu, 16 Oct 2025 00:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Fhp-0006tQ-3B
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 00:35:13 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Fhn-0005WL-5Z
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 00:35:12 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-639e1e8c8c8so461462a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 21:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760589307; x=1761194107; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVWmQwr6kknTJKPCbbKpWG71I5QLSQFJt7ln0Ef8caY=;
 b=kYxpQKXpmLoyTmA4i8RjwXdLhfOIYs7CfGW8O3Nzg/rEiVIBVnilJSD7VmRDShYeRu
 orL1Gay+D/hOvIRyOm+6s3UDUPKwtQhE4mhShXg//c/jZHuuaXqyNLdQdlZAGRree5zK
 aHpRjqgdiGH3EKRTx/oZBNAbd5TdwtgZLQGJd46B4d6csHB36d5rbESdY8nWcwCcgPg7
 edmkoY2d3WgX9yX/cI/niiQioXxA1Sj2zoM0uPUsg1xKDPLeGOcagTeF4QylFiiqShM3
 D/Y3MAm6WYP3oh4kYNhKyj97gtT2pjYFOfbYU8NoswCv6yOfAUT1xFQlzrDSU+I67ESc
 2ghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760589307; x=1761194107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NVWmQwr6kknTJKPCbbKpWG71I5QLSQFJt7ln0Ef8caY=;
 b=QG7t8mdMO7Yoyka6ug1aWA1lextIM/zITK3DZXYUBlr4adhAJl1i4t5hbVLbv8ey/J
 c0i280x+nKItzfErhqoFpSxNXfVbVSBlpTjP1CY/gFHzrjiQJkzjU2vRl6wTtSuLVcXT
 q4+Jm5HVcWBRF5fsch790PFcfjciAS/8gf+c3UugU0OTc3ku1fNfbWr3u62NzDmIOuLF
 8qegcKeUbNyt4Ygrkf3w3I1PHghesbPtssk0mzekEER7GjDy/y7zuS9mCcrslNLNLHqD
 6plEM8EE8gCKjUdlgfAlZ66xwILGDJXY79vgUdz9cWUDe7uqo9eweQC3GmT0gW/rj5B6
 jibg==
X-Gm-Message-State: AOJu0YwH9GFyie+6Udcadfw6VhTMFoTvAk9j5DOztrnppZofXKN+c9N+
 PPDSenk7QTqv6Pgt2yUwAAslka/CXE4lSF97kpq9F+qCBg/WNndpzoUiQSWWA2ao7IYbjUaUT22
 2YPO871Y4ZKIeV7tZW7cecUnZ1/bW+6Y=
X-Gm-Gg: ASbGncsfWVsaYtwxflS/GXLqO+LrmL4yKNzJcJ9iiQDnrVQaNUfc+JGzqk6xZSp9UQB
 6HrXSzEeVB76JgDNge2xya1Nl0yPMrktaB02mqFCg+vORkyHUQpcJEQVV2ZJQPADu9La7FQAkPS
 TowNPrh1NokTQf5w+i38W6T4t8R8+lkSAOUcAgtCoSUyaCzeVxGOOdKW3MZbyUF5lRtw59QJXed
 Q+wtRt43qP5t1Xc+hDEbkXseXRLj4MxRX5T+tmQy/YA5x8dyq1JXf3kFyggHiNfBos672hq+9B/
 xiY9uJaAPQvBY5zC06ULkDH1mg==
X-Google-Smtp-Source: AGHT+IFNWX0ijlgiwfK4jb6GzFI+C9MDxDq4b3/1UruokQ0Y3BXGyjVFeF9MJIbJLtXPoXxHbykDcWY03zBc7GuelkI=
X-Received: by 2002:a05:6402:26c5:b0:63b:fbb7:88bc with SMTP id
 4fb4d7f45d1cf-63bfbb78ab2mr2709839a12.5.1760589307190; Wed, 15 Oct 2025
 21:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-14-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-14-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Oct 2025 14:34:40 +1000
X-Gm-Features: AS18NWDg2iME_4vmFIhBuzAg-weBTbnhIvW8uKq8CkuasFytWtfwy9j1ec_fDhY
Message-ID: <CAKmqyKN6sP9NHmkx-OpBm6A1=dyz-CwVZRh=Yf5GVC8Q+F2w=A@mail.gmail.com>
Subject: Re: [PATCH v3 13/34] target/riscv: Fix size of frm and fflags
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
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

On Wed, Oct 15, 2025 at 6:35=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> According to version 20250508 of the unprivileged specification the frm
> field of fcsr is 3-bits in size, fix it to 8-bits.  Similarly fflags is
> 5 bits, fix to 8.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        | 6 +++---
>  target/riscv/csr.c        | 4 ++++
>  target/riscv/fpu_helper.c | 6 +++---
>  target/riscv/machine.c    | 2 +-
>  4 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index a25c75ca64..f2378d0b67 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -230,7 +230,7 @@ struct CPUArchState {
>
>      /* Floating-Point state */
>      uint64_t fpr[32]; /* assume both F and D extensions */
> -    target_ulong frm;
> +    uint8_t frm;
>      float_status fp_status;
>
>      target_ulong badaddr;
> @@ -664,8 +664,8 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *=
env,
>                                        RISCVException exception,
>                                        uintptr_t pc);
>
> -target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
> -void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
> +uint8_t riscv_cpu_get_fflags(CPURISCVState *env);
> +void riscv_cpu_set_fflags(CPURISCVState *env, uint8_t);
>
>  FIELD(TB_FLAGS, MEM_IDX, 0, 3)
>  FIELD(TB_FLAGS, FS, 3, 2)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 65b6469395..5ba1fe4168 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -896,6 +896,10 @@ static RISCVException write_frm(CPURISCVState *env, =
int csrno,
>  static RISCVException read_fcsr(CPURISCVState *env, int csrno,
>                                  target_ulong *val)
>  {
> +    /*
> +     * This is an 8-bit operation, fflags make up the lower 5 bits and
> +     * frm the upper 3 bits of fcsr.
> +     */
>      *val =3D (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
>          | (env->frm << FSR_RD_SHIFT);
>      return RISCV_EXCP_NONE;
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index af40561b31..db64fca622 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -23,10 +23,10 @@
>  #include "fpu/softfloat.h"
>  #include "internals.h"
>
> -target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
> +uint8_t riscv_cpu_get_fflags(CPURISCVState *env)
>  {
>      int soft =3D get_float_exception_flags(&env->fp_status);
> -    target_ulong hard =3D 0;
> +    uint8_t hard =3D 0;
>
>      hard |=3D (soft & float_flag_inexact) ? FPEXC_NX : 0;
>      hard |=3D (soft & float_flag_underflow) ? FPEXC_UF : 0;
> @@ -37,7 +37,7 @@ target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
>      return hard;
>  }
>
> -void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong hard)
> +void riscv_cpu_set_fflags(CPURISCVState *env, uint8_t hard)
>  {
>      int soft =3D 0;
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 66ed3f6504..07995fb303 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -436,7 +436,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          VMSTATE_UINT64(env.pc, RISCVCPU),
>          VMSTATE_UINT64(env.load_res, RISCVCPU),
>          VMSTATE_UINT64(env.load_val, RISCVCPU),
> -        VMSTATE_UINTTL(env.frm, RISCVCPU),
> +        VMSTATE_UINT8(env.frm, RISCVCPU),
>          VMSTATE_UINTTL(env.badaddr, RISCVCPU),
>          VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
>          VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
> --
> 2.51.0
>
>

