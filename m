Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B93CEACDD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveg4-0008TS-Rz; Tue, 01 Oct 2024 11:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sveg2-0008TA-K9
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:20:38 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sveg0-0003iw-9H
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:20:38 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fad6de2590so23072751fa.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 08:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727796034; x=1728400834; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aIKDcHGJPe0Y/LbyHxS8dJFRL8c0zYf8re8eWH4BQYQ=;
 b=p+3NuJPZlBBR04uEFGfCjtsfkQmCKtjuCb1poNlIpxCSKo4X0powHN57pKIB/ort73
 2OkI0zWjzNhieI5g2w/hXMpl0XugIuLYQF8m7i22G2pM7OyMqfiHtTou/8ZqqSzGngza
 1dPaqucSTknMVqPdU4cU5aSSyPfC/6H8BDwNk9e6fvkCuDyMoNC2xQzgtdhmzNSKkZRF
 rFKbhpB6dL+n15S+cB87312cwNeQZZ1AOajPYJEXb0Bnick9khCC4SZs497dz2SEbXqH
 raC8hmGEbeJTxUK8H+QggMxQGbb+M8rfPAHnZntXMrRmynvWRtaFV1GJhgKfUe7EniOL
 qjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727796034; x=1728400834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aIKDcHGJPe0Y/LbyHxS8dJFRL8c0zYf8re8eWH4BQYQ=;
 b=VdbfMAqFJ/lgMk+m2HtCFoVfaPdmNlNoKuGuVxaWUPFFnCsEx+gggvPyE0U6o2p2wT
 KbAKETjEQC1+F8gqNCZrJHrF0wBd9yNRub7dcNitCpFPP6iFqg1ehoZ6ORqH4ezbfcsv
 bM5QFVGTm/N7zNV+BvrA2WAfMQW6VO1EKMToUXNcNOQzDKhbZurLO4dx5JuaDawkQrkj
 CQJVivE45DDdthCKmQ7MLcxu3pbehs68mRclycGmtxXnDYj4HSXOetVUn7TvgDgviUwa
 mvuLhB0+M1TR5Q1F3UCmV6ia7QgPSqevjPhq0lY+JCMdGRZYQLCAdk3+7EMhzTS5QHbC
 EV+g==
X-Gm-Message-State: AOJu0YxBa0y1W4rpX7I6ziZ/Bs/m3gAYqzq4btPVyNYMv/coVA/mQZZN
 ENR/75TIDEC7ngcaORErqSpnXO1cUwKhfZ7WZQH2Ke0HehSGPmIhMWmUsjVChlIfpSPEdRDfwuE
 iZkcKH+lUEnheX+cC1xvk0znYBPBBLp4Pr9UvJ//wH8sYiDV5
X-Google-Smtp-Source: AGHT+IFA4j9NrSThkDGY3dX1osU3X4EV1DEcVJ9I5Wwu2d+et7y8XQViFDRd4EUZ8BU3IMqSMZDWFv+L5TdWufTPpf8=
X-Received: by 2002:a05:6402:42d2:b0:5c4:23a4:ad5f with SMTP id
 4fb4d7f45d1cf-5c8824cd086mr22670202a12.6.1727775352820; Tue, 01 Oct 2024
 02:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240930221205.59101-1-philmd@linaro.org>
 <20240930221205.59101-4-philmd@linaro.org>
In-Reply-To: <20240930221205.59101-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Oct 2024 10:35:41 +0100
Message-ID: <CAFEAcA8YmpEDj=imO1r9zrp+XaybtV4eJszZtBZLubHPcDLcEA@mail.gmail.com>
Subject: Re: [PATCH 3/3] hw/arm: Replace tswap32() calls by target agnostic
 stl_endian_p()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>, 
 Thomas Huth <thuth@redhat.com>, Hao Wu <wuhaotsh@google.com>, 
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>, Tyrone Ting <kfting@nuvoton.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 30 Sept 2024 at 23:12, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
>
> Replace the target-specific tswap32() calls by stl_endian_p()
> which does the same but takes the endianness as argument, thus
> is target-agnostic.
> Get the vCPU endianness calling arm_cpu_code_is_big_endian().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/boot.c        | 8 +++++---
>  hw/arm/exynos4210.c  | 7 +++----
>  hw/arm/npcm7xx.c     | 6 ++++--
>  hw/arm/xilinx_zynq.c | 5 +++--
>  4 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 6efd21f9c2..6e8dc00e6d 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -137,6 +137,7 @@ void arm_write_bootloader(const char *name,
>                            const uint32_t *fixupcontext)
>  {
>      AddressSpace *as =3D arm_boot_address_space(cpu, info);
> +    bool be =3D arm_cpu_code_is_big_endian(&cpu->env);
>      /* Fix up the specified bootloader fragment and write it into
>       * guest memory using rom_add_blob_fixed(). fixupcontext is
>       * an array giving the values to write in for the fixup types
> @@ -173,7 +174,7 @@ void arm_write_bootloader(const char *name,
>          default:
>              abort();
>          }
> -        code[i] =3D tswap32(insn);
> +        stl_endian_p(be, &code[i], insn);
>      }

This is a behaviour change. For Arm, TARGET_BIG_ENDIAN
is always false, so tswap32() is "swap to/from little endian".
But arm_cpu_code_is_big_endian() looks at the state of
the guest vCPU (specifically, its SCTLR.B bit) and so
may swap to either big or little endian.

These functions are also called before the CPU is
reset for the first time, and before do_cpu_reset()
has maybe set SCTLR_B based on the ELF file. So we
can't guarantee SCTLR.B to be set correctly here where
we're trying to use it.

Maybe we do get this wrong for the old ARMv6-and-earlier
BE32 model where SCTLR.B might be non-zero -- they're
such a niche case that I don't suppose gets tested often.
(ARMv7-and-up is BE8 and instructions are always little
endian even when data is big endian.) But we should
separate out bug fixes from refactorings.

thanks
-- PMM

