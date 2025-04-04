Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01B3C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 03:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0XUf-0002j3-DC; Thu, 03 Apr 2025 23:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0XUe-0002ig-6J; Thu, 03 Apr 2025 23:13:20 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0XUc-000177-Ok; Thu, 03 Apr 2025 23:13:19 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-86fab198f8eso803586241.1; 
 Thu, 03 Apr 2025 20:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743736397; x=1744341197; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BkJeFs3c3FNz7rdOmEO17L32lm8wVWF4b5VQYEJL4Ps=;
 b=gtgaDxYqlbCqAwwqWNs48wjoKFRbp2jU2NP7VRChbU9FfTYENUl0t8qfAO6lgPbrcQ
 ez4qmlP4W+59VrFVrHzp0yS/u7lydGtVtF/glAIFc+mlfSd1PoaT9CW8p1z+0Tt6qLe4
 BOvHr0ooOabXtRw/0vffiDkwX4kwIPfcQKVraxz4wbXoLW+5RAoqBstCNFlNQKdGdpns
 qkahH6bNXLHnH3oEj+nYYoBqgIPtpfC5t6iGHec6RMXHI/QaSpieZIGSuKigvQpCvhBN
 TofAd5oYADR1mDuyQw6Mfp/1TimGgfGI0YZU4RZYrr85YOt2Aj5XImdSzFCcF+XtLFr9
 PYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743736397; x=1744341197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BkJeFs3c3FNz7rdOmEO17L32lm8wVWF4b5VQYEJL4Ps=;
 b=Xm5su3U2TTN2oFLBpZh3Dp/rhX1FkIcha2NnA/XtRjZvVYH8XUW7DoWJNtmHH7LXW8
 MWU8TYX7c3JQ7IuwwTQFOLbbTMVaFpevBXJUGlegOrtk8Dgf9cKAcn6e18mhOjmv666v
 +lsFNjAgdrD8+lGaPitpHzmmYMfStba2T8QBugsnOv0ybwoGFDyA1ZPFhbkt6yj2TNTK
 +jqhdHQfsYYF8ORc8sQSv+i2gN7JVAVsFzAry8I1u8hmvj782EC1S6bcYo1SohCo1W5C
 vUOfqKdez+IVXRaVIyeghyMIQYp2uRXn+d6Ahy84Pv0PxFlDMCZiwlCnRnnV4iB+QAD4
 XT0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWGekpoOsPFtVW2w0C4PXOQdUYXLrePh6qhQLsVhdNc8DYuKbyaVg08VZW1QVdZyIiyVTDhOJwwBs3@nongnu.org
X-Gm-Message-State: AOJu0YzIvJ2DN0uuvwV1lvsy5JVwqQxD7TFlKd9JdAaSYWtURAuBKKxa
 RcU3V8tfiipl/RM+O+v56KmXGCad1cYbR/un5BL6NditBmidUdt0gbpQoZ2X/Fq7hjKYuBfSuV0
 H4wak52oFBfS30s2uPwqZT4ioI3k=
X-Gm-Gg: ASbGncuFTycKydVImB2K6hvqfbFTrh5vdb7KjuJLIjKvKneamWYlQLVylptqmgytCp+
 cGjsX4WpazH7mlhOk6LPVsdJXhFujaoEBiVl/BLD1JI7WBgNtqYGB0KYHL2YcGutLTnzCIcTd6s
 vXAsx9I+jBMwNhQODPHpTX08hI+/ryYZvK6//Ky3EGeYZ8I5n0ozAUl4/C
X-Google-Smtp-Source: AGHT+IFFIFdSpq9BQLJdPXBKqPIO8GO1ZoSe9bxYFnaK/mu7a4nziKlU/xkgljcd0iR8Q/G5r2CFBUCxPeCmnt1J5MQ=
X-Received: by 2002:a05:6102:1528:b0:4bb:9b46:3f8a with SMTP id
 ada2fe7eead31-4c8553821b7mr1762485137.2.1743736397300; Thu, 03 Apr 2025
 20:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250319192153.28549-1-jim.shu@sifive.com>
 <20250319192153.28549-4-jim.shu@sifive.com>
In-Reply-To: <20250319192153.28549-4-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 13:12:51 +1000
X-Gm-Features: ATxdqUEchudNCT-jA5FFA_JgorlSD256ZKccd47jPDhk7w1vY4jvw0SFQ-En0tQ
Message-ID: <CAKmqyKMtOVgn7gtX3j24bkS2iHARyHF41Se1zfMnNLyoSKs9Wg@mail.gmail.com>
Subject: Re: [PATCH 3/4] target/riscv: Fix VSTIP bit in sstc extension.
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
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

On Thu, Mar 20, 2025 at 5:24=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrote:
>
> VSTIP is only writable when both [mh]envcfg.STCE is enabled, or it will
> revert it's defined behavior as if sstc extension is not implemented.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 49566d3c08..ba026dfc8e 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3630,7 +3630,14 @@ static RISCVException rmw_mip64(CPURISCVState *env=
, int csrno,
>      if (riscv_cpu_cfg(env)->ext_sstc && (env->priv =3D=3D PRV_M) &&
>          get_field(env->menvcfg, MENVCFG_STCE)) {
>          /* sstc extension forbids STIP & VSTIP to be writeable in mip */
> -        mask =3D mask & ~(MIP_STIP | MIP_VSTIP);
> +
> +        /* STIP is not writable when menvcfg.STCE is enabled. */
> +        mask =3D mask & ~MIP_STIP;
> +
> +        /* VSTIP is not writable when both [mh]envcfg.STCE are enabled. =
*/
> +        if (get_field(env->henvcfg, HENVCFG_STCE)) {
> +            mask =3D mask & ~MIP_VSTIP;
> +        }
>      }
>
>      if (mask) {
> --
> 2.17.1
>
>

