Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4400E77198
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 03:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUdLp-00063u-68; Sun, 05 Jan 2025 22:00:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUdLj-00061c-Hx; Sun, 05 Jan 2025 22:00:15 -0500
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUdLg-0006wX-5b; Sun, 05 Jan 2025 22:00:14 -0500
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-85c4e74e2baso2534381241.0; 
 Sun, 05 Jan 2025 19:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736132410; x=1736737210; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71AT9v5ryC4w49mdYeE3uFi6eFVKJxxuDRG2Nsb5Jwk=;
 b=BV58w3qe+VWq2P6CAwDgzS4K9M7Nfg22Wzp8CVlG+AYpNGjhOuHg2WhkATgdOxvHIk
 ClA38BXuSyDAGCI5H2UJlO4kdZWUDc7Y2nf3yjt0L8LN19TxPhKr4NBPNXj/RftM1EeM
 nDDAigtUHn2sezJfi3fQGFFtd1HPdAstsn9jcNKR+YLyajV+tgxBFkGYeGXa2fgSc3sY
 PTLQsGt9EJYB7lXP5WVXxGOxUMxzZgRVfLdLz8v+wRCiG6H+OudXtmDSW6Rkz7XXivrQ
 1KgILEGBfdEK3i/OL5ODegDq3sEh/lXhrYnZ1z/4QHerdFRn/X5q8Jxsvym0M4WbBj/d
 YG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736132410; x=1736737210;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=71AT9v5ryC4w49mdYeE3uFi6eFVKJxxuDRG2Nsb5Jwk=;
 b=Jj0Yf72FkBX0SW0pJxaOIO2Xxe9HpcjRAQL4zT1/5u39wLTTqFm1AUGhyp0NhpJy1B
 jBCIEu9YcHPVYXM0AAbdzP4ksRRvB6ykzCVverhuQ5/Rs05/vZMimwS5rRdpFZ2Ui0od
 1FvL8paQ+p4AerZwwENlY/lTw/plBOWAsWCAAE5eHrEPIiuSB4vtVpIl/sw3bQMGIiYv
 fl+3ZUZh78pkiZI55wxLauiN7VD0ydE8e1Utl9jfugKu2UDuE8f07qhKVGAGCOuvcM4R
 FlQ9jlmqJM8U63HH7ci1RWD6zVv29reSfV+y1Q4+1c8Nks8oM6tEuXPhYrutChNG2imR
 aCNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR5mY4HwS0QdlWKfD/+LKKxmjpKo0pjPaBVfaZgrLyugb/4czj2I6X5E6KvRwHGd7xyehKZI+Y2XlU@nongnu.org
X-Gm-Message-State: AOJu0YyvwHeMGp3729xo3faP/TvuNyOBBiuTkruiH3/yr803VYg2mJW1
 ZmLlAIq9Cn+lWJ8JXyOyfzrJxXvf4Gcz9aE2VL+QPx+EWyQc9s1Bb9+wJphxm2xXZY0W3e/tvGD
 KV8ENPoPz//QRMBcqK6T4PnyDWHY=
X-Gm-Gg: ASbGncvWGPbXAcvBzV5CWjUIR2dLijH6RElQIOlpLr0PGl6XJLpITBeNdBdi2JCWbd7
 3KjG/MwF3TJIvItKVC0cgGJivpE34vYSAIXwBgXSRhLb4QMgnOnb+C7ZXMo447lo0qzA=
X-Google-Smtp-Source: AGHT+IGK/1nQkTW2abU/LaA68SPpMY5eSrzek68HbyVKgjnD3i0mKfBR+NQYgKlqcFfrioa/fpD7LYza58u3OjNrh/s=
X-Received: by 2002:a05:6102:5684:b0:4b1:24c0:4272 with SMTP id
 ada2fe7eead31-4b2cc380443mr45742568137.12.1736132410457; Sun, 05 Jan 2025
 19:00:10 -0800 (PST)
MIME-Version: 1.0
References: <20241219174657.1988767-1-dbarboza@ventanamicro.com>
 <20241219174657.1988767-2-dbarboza@ventanamicro.com>
In-Reply-To: <20241219174657.1988767-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 12:59:44 +1000
Message-ID: <CAKmqyKMo-PZQd6VpFv9eW3DAoaOjoABm=FtLqqg5PeKKjoMuYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: use RISCVException enum in exception
 helpers
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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

On Fri, Dec 20, 2024 at 3:49=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Do a cosmetic change in riscv_raise_exception() to change 'exception'
> type from uint32_t to RISCVException, making it a bit clear that the
> arg is directly correlated to the RISCVException enum.
>
> As a side effect, change 'excp' type from int to RISCVException in
> generate_exception() to guarantee that all callers of
> riscv_raise_exception() will use the enum.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h       | 3 ++-
>  target/riscv/op_helper.c | 3 ++-
>  target/riscv/translate.c | 2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 284b112821..2b85e558f7 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -603,7 +603,8 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ul=
ong newpriv, bool virt_en);
>
>  void riscv_translate_init(void);
>  G_NORETURN void riscv_raise_exception(CPURISCVState *env,
> -                                      uint32_t exception, uintptr_t pc);
> +                                      RISCVException exception,
> +                                      uintptr_t pc);
>
>  target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
>  void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index eddedacf4b..29c104bc23 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -27,7 +27,8 @@
>
>  /* Exceptions processing helpers */
>  G_NORETURN void riscv_raise_exception(CPURISCVState *env,
> -                                      uint32_t exception, uintptr_t pc)
> +                                      RISCVException exception,
> +                                      uintptr_t pc)
>  {
>      CPUState *cs =3D env_cpu(env);
>      cs->exception_index =3D exception;
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index bccaf8e89a..ebae1807a4 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -244,7 +244,7 @@ static void gen_update_pc(DisasContext *ctx, target_l=
ong diff)
>      ctx->pc_save =3D ctx->base.pc_next + diff;
>  }
>
> -static void generate_exception(DisasContext *ctx, int excp)
> +static void generate_exception(DisasContext *ctx, RISCVException excp)
>  {
>      gen_update_pc(ctx, 0);
>      gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));
> --
> 2.47.1
>
>

