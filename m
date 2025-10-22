Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13315CCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 23:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBiPi-0002b8-5R; Wed, 22 Oct 2025 19:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBiPf-0002an-W8
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 19:38:40 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBiPd-0001nY-1F
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 19:38:38 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-63b9da57cecso251650a12.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 16:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761176315; x=1761781115; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wcd3GKf4iO/YvwvpEcTaeZS7OOZnj+rYcVkGI6Xlh/Q=;
 b=IBzuBZ4+yGGzFu62WLPmylddvHJt4IrOrOJ26hIxIFWkZkJiWWHfLZRZBpXrGCapZv
 uvU9Gqv0JiGElKTSLcu+rAggXYjOfou2Dq3qnM1HZzfWi3T5pPfoCj8bJvuYtDR5/O9U
 8NPOIp4ajS17UPRNo9g+IIwsUByWIQQf/5uHd05fUXAfkof5V7+V/uIqGcUoafqppTxF
 mByMvg/2YU27yDZkjOySA/rgf4EtzRjUU5pdLqCG8Ot42RJItZLOAPa9KLfUwPFhxJ+5
 7YF2q199bj1aUVcwtn23hEIBKsF18hQCufw9PkBrDO5Re/mCVqnFF6GBkIM0nvMO24JC
 WPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761176315; x=1761781115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wcd3GKf4iO/YvwvpEcTaeZS7OOZnj+rYcVkGI6Xlh/Q=;
 b=aZSkmmtQ27OXOYku2dlouM2mbqQ0E847BgjqE684rXsYddVUNlGC4dCzwngP3K2scS
 wbts0nr0sCXkjFFncw6wb0b6995oEwx98+wWQdwQGGrDGmf5WVb94W/sfgl6GdRj4k10
 O1nWS389Wh0DoTFfFuMb7b6V8jZ7ydxrWRAGLO7yhRUHzkZN4OjW75O3Mk7IFyyVvE/7
 gVv6WxzLY7m3xdJmUVhXVfxvioW0X8JxBdcOH8f1m9gfotNacOoCvk0h6T2K0vLKfe1p
 VU+qdyPVJVtSyOxBu28YyqUuzs/OWgRpWKRLVZT02xz3fvqMh78pKfXT1GZxxEG2Dn7I
 ySnw==
X-Gm-Message-State: AOJu0Yzz7UiyXfVpJE7gHc/STVWPqYWbfTcs9EapGsK4Bt2miq0/h8A+
 vltVJS0MhGDiaVcrr8xuXik23k9F9dbQZ4R+LIgvgqUoDDzD2NJwlMB4bG27nMW/fBU0PXBfTvb
 8Hj6IJod8YJU3cMWXdWh+eFoVFBOwi0Q=
X-Gm-Gg: ASbGncs46eWigN8d6921uLXFtSzU1RbYqH+fyM91heMqMpt7DKYXg4MP0cJccD4ABGc
 znzFgHRdYOoVgqtf0lkZbaPXba3+bcOzdVFb2h7m2WBcZnwKa1l84i84WXAPMqdKA3wnEsu609G
 Lowuw+Nt9iSWZ7pl4dwjTzL+ApDQx7K+DNepeD2bNXbDru4x36ndn89/PgaYC3BtQGKTYTEWe0t
 0tNkyV0oavdIgRNSJmqahufr36pqKl8iNdnMnhDacT+6/I0H2FOQn1dCLHBGto/IzVqICUO+tmP
 ZfeMsvtDUoCyuUnvn7wu+FpJ8g==
X-Google-Smtp-Source: AGHT+IHPoQbc1gW9VLLebbxrz4HlyBqcHbdgkYwcmYCJsfxilU9p5kNTheUvO2dSUUISWaNKyB+L1mRyerydV29wd70=
X-Received: by 2002:a05:6402:13ca:b0:637:f07d:e80f with SMTP id
 4fb4d7f45d1cf-63c1f58c0d3mr22311254a12.0.1761176314655; Wed, 22 Oct 2025
 16:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251022124340.493358-1-dbarboza@ventanamicro.com>
In-Reply-To: <20251022124340.493358-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 23 Oct 2025 09:38:08 +1000
X-Gm-Features: AS18NWD2rxiXMvn89dmoiGVB_TcRbiBjhcCiPJqYF0XNmoupxZRsi_96k4qLrdw
Message-ID: <CAKmqyKN+8mh8cv4GVMzmS+kcu+C4z7FAHsx-6aQS3U9=sWAAjw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: fix riscv_cpu_sirq_pending() mask
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
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

On Wed, Oct 22, 2025 at 10:45=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We're filtering out (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP) from S-mode
> pending interrupts without apparent reason. There's no special treatment
> for these ints as far as the spec goes, and this filtering is causing
> read_stopi() to miss those VS interrupts [1].
>
> We shouldn't return delegated VS interrupts in S-mode though, so change
> the current mask with "~env->hideleg". Note that this is the same
> handling we're doing in riscv_cpu_mirq_pending() and env->mideleg.
>
> [1] https://gitlab.com/qemu-project/qemu/-/issues/2820
>
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2820
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 3479a62cc7..360db133e2 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -443,8 +443,7 @@ int riscv_cpu_mirq_pending(CPURISCVState *env)
>
>  int riscv_cpu_sirq_pending(CPURISCVState *env)
>  {
> -    uint64_t irqs =3D riscv_cpu_all_pending(env) & env->mideleg &
> -                    ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
> +    uint64_t irqs =3D riscv_cpu_all_pending(env) & env->mideleg & ~env->=
hideleg;
>      uint64_t irqs_f =3D env->mvip & env->mvien & ~env->mideleg & env->si=
e;
>
>      return riscv_cpu_pending_to_irq(env, IRQ_S_EXT, IPRIO_DEFAULT_S,
> --
> 2.51.0
>
>

