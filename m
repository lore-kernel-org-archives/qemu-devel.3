Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A96CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 09:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDfiQ-0002rY-S5; Tue, 28 Oct 2025 05:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vDfiL-0002r2-I3
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 05:10:01 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vDfi9-0000pZ-Kz
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 05:10:01 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-61feb87fe26so9755732a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 02:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761642585; x=1762247385; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+ioTo/kftZYIHGeZIzymdf7bNMKH6pnXAtV38BIoRc=;
 b=ZhrHV+tBQ97axHxwQlEI/hggdZdYNqoawPBdQ+MffF7q6Bvh6xRkPc/prszDUhuXIb
 1RYE6Aye7O/y4XnwVCZGyv5F0R+TF8B/r9sZ80LCCva9qTbgJf+PjvnjzpbWe1jiJ0yX
 Ur8aiw41Ers32OJZvjNbumcYwm1kSTN+yMUMJg5rK/i4RzlMF6XRBAKX1FGrWJ8B4GOH
 lI4xVwrxS5ueAcGj9AJbMxV8iPdkCS1JAuFpGiL1bgPDVThsZJxAsAoCuAcQHoAJgQNk
 Yb3CdH15WR7AEfhjnbT91nrwRl1fElKWh5ItK84uKD+wb+uzBYCub4vW0NbFwoFg9qSn
 LcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761642585; x=1762247385;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+ioTo/kftZYIHGeZIzymdf7bNMKH6pnXAtV38BIoRc=;
 b=W4soaj3hjtQd8yfpytO3iAttCWDeWLFZpi/QOQVtxBx7Zj5k0AUoGMpALkOeOQooEG
 vsK2rxix1AJJ2giuiOWicARSqhgKlETHddQ7h3r9jozrKByrFfp7JHXKxKToLVZhRa3z
 RJ1PNTTgSIa6KSGuRCrXGaf6tM6fm5KC8V99hffnd+fg54jTX1zy0nhbxj30fzNAB0Jh
 X/9FPwe/KEmAra0jGcAi4zwazWk3LtqGMACCOlay/GARLG9XALng09mB/qZYM2gykwbL
 gLL1LR7VNcXTILcub9hA0OvO3oESgBSnTBdY22kl62Fbfkmt2lJXx1HNGZCr7SdsLg4Y
 35HQ==
X-Gm-Message-State: AOJu0YxZ8acl94u3MqfuSk/5HFzlArFwxur4+oHMweE+o2y71nWTAOrP
 sRKrA0Ba2vGR4H167nsKTKvIvlRASCLZuRL5OT09QHvpiL0xpMCK/B2bSCuz10tAS+cVKEYTN2H
 8XIR2ThnycavtZEgNo9AFRMfigogiTgwAMXWQQV30djtxuWY4n7YC
X-Gm-Gg: ASbGncuOwpblK4ks5k9XQcFYM8ugHbmJ3Zzemd7AViSy2tv6/QCFk/iAO+kk/BV2N8h
 K2sd7QLmDZ+CLhWhULCgeKU8veddNryEf/tr4PcBqhYjZvkrVaJsEEqNRqFG2srcgXT8SUwRQGM
 5rNMl7wF8MewI7mC3MTrA+P9IhGu9zTSAfJ2pMX8/mz+rfO+4puN9tDN7N9UgP4L00Ao22sAWZG
 PoNzCI4x0PsEW/o+nWlZvmt5RGIv8j1COkB8fQSKnB0C/6KepWujT1Q3b1HpZ4=
X-Google-Smtp-Source: AGHT+IF/EHt6NK2xPRT3uKc8+ON41QLe6lZuxFUUwKT/ZCrzOpZc16h2mXjv9Z+tImIenwNRfihkp87E5QKixBwu4IM=
X-Received: by 2002:a05:6402:5193:b0:63c:4537:75a7 with SMTP id
 4fb4d7f45d1cf-63ed8260199mr2324290a12.28.1761642585082; Tue, 28 Oct 2025
 02:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20251028085032.2053569-1-frank.chang@sifive.com>
In-Reply-To: <20251028085032.2053569-1-frank.chang@sifive.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Tue, 28 Oct 2025 17:09:34 +0800
X-Gm-Features: AWmQ_blFUtxeAx73CGEjglFh7vGE9P3eAO-2_7oSUhBtC7X2W1TfCixD1EwriGk
Message-ID: <CALw707qcytHujijUg=QmK7Tf3L26_0gzjs-uyGc_-_G6CSHUYw@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: riscv-iommu: Don't look up DDT cache in Off and
 Bare modes
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Jim Shu <jim.shu@sifive.com>

- Jim



On Tue, Oct 28, 2025 at 4:51=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> According to the RISC-V IOMMU specification:
>
> * When ddtp.iommu_mode is set to Off, there is no DDT look-up, and an "Al=
l
>   inbound transactions disallowed" fault (cause =3D 256) is reported for =
any
>   inbound transaction.
>
> * When ddtp.iommu_mode is set to Bare, there is no DDT look-up, and the
>   translated address is the same as the IOVA, unless the transaction type
>   is disallowed (cause =3D 260).
>
> In the current implementation, the DDT cache is incorrectly looked up
> even when ddtp.iommu_mode is set to Off or Bare. This may result in
> unintended cache hits.
>
> Therefore, the DDT cache must not be looked up when ddtp.iommu_mode is
> set to Off or Bare. For other modes, software is required to issue cache
> invalidation commands before any inbound transactions.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  hw/riscv/riscv-iommu.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index b33c7fe3259..95db811f125 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1290,13 +1290,18 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIO=
MMUState *s,
>          .devid =3D devid,
>          .process_id =3D process_id,
>      };
> +    unsigned mode =3D get_field(s->ddtp, RISCV_IOMMU_DDTP_MODE);
>
>      ctx_cache =3D g_hash_table_ref(s->ctx_cache);
> -    ctx =3D g_hash_table_lookup(ctx_cache, &key);
>
> -    if (ctx && (ctx->tc & RISCV_IOMMU_DC_TC_V)) {
> -        *ref =3D ctx_cache;
> -        return ctx;
> +    if (mode !=3D RISCV_IOMMU_DDTP_MODE_OFF &&
> +        mode !=3D RISCV_IOMMU_DDTP_MODE_BARE) {
> +        ctx =3D g_hash_table_lookup(ctx_cache, &key);
> +
> +        if (ctx && (ctx->tc & RISCV_IOMMU_DC_TC_V)) {
> +            *ref =3D ctx_cache;
> +            return ctx;
> +        }
>      }
>
>      ctx =3D g_new0(RISCVIOMMUContext, 1);
> --
> 2.43.0
>
>

