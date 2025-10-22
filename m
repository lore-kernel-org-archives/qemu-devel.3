Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CFBCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 23:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBijI-0004iF-C6; Wed, 22 Oct 2025 19:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBijB-0004fn-7Q
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 19:58:50 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBij7-0003ZA-Be
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 19:58:48 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-78485808eb3so1822427b3.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 16:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761177523; x=1761782323; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9uzGB6Y2KUsQdK7LRQHU0rGmgGqs1b/9+E+uxY6U7c=;
 b=OoOJhLzA3S87VFgDa+q9NSys4rQMRLp8LcSILIWzEwS483jQzMUXBkg7PbTLVBpOOg
 v9O2PWZx6q4B1iJ36c3pZ/NryER4OHoSh2nZJwH/ntAmPrVES8orsfYZyHP8/UIsAjeR
 aUbEet0gnTVndQniEfKcZcZYEDdUZa/4oV7rb8VRdfQg45kpIn5bmHlU1Mi/po0dg02m
 7OJd06fNd6nXFnOJDjlNhhWJ2iHwtaad0TQJrr6Z/JiR0AaNkWHs0A3GVqKTIZW8+GP3
 GandM2urmJ2pN7U6JhoKMM/AABr2FWps2Q5BSfLl+KVXI26DFRSQ05qcug71FeP27O3p
 Pjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761177523; x=1761782323;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9uzGB6Y2KUsQdK7LRQHU0rGmgGqs1b/9+E+uxY6U7c=;
 b=D/yrn8q8PlRC8p3yp/fkHB9+E4iVUh2Nzi8GyxynLDRIL58zcY+L7i45ib0cr5zatY
 hEUNrPWL/lUpFGbqjah92hyolR0Nj4mJyOxsRgOrr9/wOzCBDuDVj3TaQAdcXuSYGYCY
 6KxH2LmOUPAZhYKKwxffSpIrGvtiE03uCSgXALXnBlzpgOgNdJicUlQN6bheeEfw/rAv
 hB+riAR0MgZejvAwZ+fMNzRXEH1GDjkXJc0Uri5RBfeZO2aQPUz/Q2wSNFuQWAfc/5ns
 ru5bv7YGTkAVGUyjEr8C0OaN1jIP1QBXFEecsX6YZiY4D1/VgODv1UqyOVBym5JDFBGf
 hzmA==
X-Gm-Message-State: AOJu0Ywd5C3nMO0gfad2jwuUYQ/yQ8q6nYZTb6Y2SL/YpuWbfG4Ojxza
 YH7ZOFL5zTGyU0M0vJhsr3TqAoXsYtzJdU15wdAYV372gh1kdGCGIhxl50S6169VKFpFKDneoTF
 60oMgnQJVqY0cNYZwT0B9xeaTB2LfPDs=
X-Gm-Gg: ASbGnctlNaJNYnvPPwMCKEJBvsIoR3VBZ/xEs5PdLY6e09rjwo5OiZChl8uxJOTLTGv
 bJoIjw259Z71kRJS1doYPaYd6To/XifbTW4opuRVas1YzPePoh4xl4YSugEYaNhGrC6QfxYovc5
 ZfAqx/VX1QOu3A4IgGorU8wHnkwSonIJDvGTfdRZZKVm92O3mfB8JWYaKoCgH8Fq/aKvAmLFK6p
 sX5/3RupaPTUg8ORz3eJh9x7q9omfVbm/ZmrAyhqZPlr50wi/vp363knvev5o7ZaKMiTjyW3zkm
 p8Wqg/hiRXsMYXQ=
X-Google-Smtp-Source: AGHT+IEbtD+bNCOZiRB0RLxw3rwl9TuaA4hZUnFWW7qt2B85CAQhPR4iteZru6PeNMzZIRT3C1feTfP8wOLLKu2htxU=
X-Received: by 2002:a05:690e:11cb:b0:63b:6b56:e6af with SMTP id
 956f58d0204a3-63e161993damr15859662d50.36.1761177523490; Wed, 22 Oct 2025
 16:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251022125643.588947-1-dbarboza@ventanamicro.com>
In-Reply-To: <20251022125643.588947-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 23 Oct 2025 09:58:15 +1000
X-Gm-Features: AS18NWAIQNHQCh5Mp94JgHsjlcQ18pwwA-U8wkyMHM2VL46LfaHW-8rU6YMk-dk
Message-ID: <CAKmqyKMHUeL+ScaBJKdgPmM=onS5qnNNR4Z0qWYf3c9zfOkbbg@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv/riscv-qmp-cmds.c: coverity-related fixes
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=alistair23@gmail.com; helo=mail-yw1-x112e.google.com
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

On Wed, Oct 22, 2025 at 10:57=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Coverity CID 1641401 reports that, in reg_is_ulong_integer(), we're
> dereferencing a NULL pointer in "reg1" when using it in strcasecmp()
> call. A similar case is reported with CID 1641393.
>
> In theory that will never happen - it's guaranteed that both "reg1" and
> "reg2" is non-NULL because we're retrieving them in compile-time from
> static arrays. Coverity doesn't know that though.
>
> To make Coverity happier and add a bit more clarity in the code,
> g_assert() each token to make it clear that those 2 values aren't
> supposed to be NULL ever. Do that in both reg_is_ulong_integer() and
> reg_is_u64_fpu().
>
> We're also taking the opportunity to implement suggestions made by Peter
> in [1] in both functions:
>
> - use g_strsplit() instead of strtok();
> - use g_ascii_strcasecmp() instead of strcasecmp().
>
> [1] https://lore.kernel.org/qemu-devel/CAFEAcA_y4bwd9GANbXnpTy2mv80Vg_jp+=
A-VkQS5V6f0+BFRAA@mail.gmail.com/
>
> Coverity: CID 1641393, 1641401
> Fixes: e06d209aa6 ("target/riscv: implement MonitorDef HMP API")
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>
> Changes from v1:
> - use g_auto(GStrv) instead of g_autofree
> - v1 link: https://lore.kernel.org/qemu-riscv/20251022110524.483588-1-dba=
rboza@ventanamicro.com/
>
>
>  target/riscv/riscv-qmp-cmds.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.=
c
> index c499f9b9a7..d5e9bec0f8 100644
> --- a/target/riscv/riscv-qmp-cmds.c
> +++ b/target/riscv/riscv-qmp-cmds.c
> @@ -273,12 +273,13 @@ static bool reg_is_ulong_integer(CPURISCVState *env=
, const char *name,
>      }
>
>      for (int i =3D 0; i < 32; i++) {
> -        g_autofree char *reg_name =3D g_strdup(reg_names[i]);
> -        char *reg1 =3D strtok(reg_name, "/");
> -        char *reg2 =3D strtok(NULL, "/");
> +        g_auto(GStrv) reg_name =3D g_strsplit(reg_names[i], "/", 2);
>
> -        if (strcasecmp(reg1, name) =3D=3D 0 ||
> -            (reg2 && strcasecmp(reg2, name) =3D=3D 0)) {
> +        g_assert(reg_name[0]);
> +        g_assert(reg_name[1]);
> +
> +        if (g_ascii_strcasecmp(reg_name[0], name) =3D=3D 0 ||
> +            g_ascii_strcasecmp(reg_name[1], name) =3D=3D 0) {
>              *val =3D vals[i];
>              return true;
>          }
> @@ -294,12 +295,13 @@ static bool reg_is_u64_fpu(CPURISCVState *env, cons=
t char *name, uint64_t *val)
>      }
>
>      for (int i =3D 0; i < 32; i++) {
> -        g_autofree char *reg_name =3D g_strdup(riscv_fpr_regnames[i]);
> -        char *reg1 =3D strtok(reg_name, "/");
> -        char *reg2 =3D strtok(NULL, "/");
> +        g_auto(GStrv) reg_name =3D g_strsplit(riscv_fpr_regnames[i], "/"=
, 2);
> +
> +        g_assert(reg_name[0]);
> +        g_assert(reg_name[1]);
>
> -        if (strcasecmp(reg1, name) =3D=3D 0 ||
> -            (reg2 && strcasecmp(reg2, name) =3D=3D 0)) {
> +        if (g_ascii_strcasecmp(reg_name[0], name) =3D=3D 0 ||
> +            g_ascii_strcasecmp(reg_name[1], name) =3D=3D 0) {
>              *val =3D env->fpr[i];
>              return true;
>          }
> --
> 2.51.0
>
>

