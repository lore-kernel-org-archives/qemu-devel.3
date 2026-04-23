Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB408FAD3E7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 02:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjQj-0006Cj-FF; Wed, 22 Apr 2026 22:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wFjQh-0006CT-Ot
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:04:35 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wFjQg-0001Ed-9L
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:04:35 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-79a60975dc5so67037077b3.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 19:04:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776909873; cv=none;
 d=google.com; s=arc-20240605;
 b=RCs8tfU24mvbHZOk58hiKguhjaMG21NiM2VUCM6ILhXUdKL920eBAwo9III5Wwuhqt
 KMubeEjjtmj04A6V7O04z1bY6/IkTC4t40Ghrk/3GaQHAZh6rXVu4Zvkb8BuKsdl9hq2
 75Un9GulQI5lylEA11+uxf3669YCDDlC6pXLsve6aQiDM94/P1CGSm7ld1a4BlGigX8O
 dV/tgZXQcsO052LICq3+wnRoAjNbM3T4MDAQ7Q0qQRjMHMTgIpKZgBuKQs2m7rLk6jvg
 HZy5blMMjRLrW8GBHR8tqGFABVP8rsAcnoOrZx5VKcOV2p8u7Hr0xNW+kKSFT41Yfo+3
 jzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5ZT0fD58MrwU3SxJiH42F2yxsdZ41STSyCU2jcYfuLw=;
 fh=xJ5/bwoDdY2h8LmEBcZRXOZjOiFoAkS85lUP67C7V7c=;
 b=ffuJ9E8e4Ok0oipBrdWsyTSTUGycIwYjYHnd3pqwQmUuRcMGC4tmUxJlrpQSgrJQBq
 OwhuyqAs0buodoYiFvz/5Y+Gynh2YvwqUUqe6mmQhbf+IgTpvfffdeCkgnOLR+MPHsDO
 nMFWN67SApt+NFbgZCA/8G55ufWIYACGaFmeWeejkbEbiXoVIDVodyd8yJX6EMulBlJA
 iM5LLCWnu2Ah1BITTwHobaLpvt5tpY19/xOwOX1C6KriCiiAU+Rs4kZ2bgYkhkNS753C
 BxkC+UMXty2b1f4jKUHFDLn6U6VKxXQVxFJMC6HfKnJGRd7PRjwwgBk2JTe588dXWDfR
 artA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1776909873; x=1777514673; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ZT0fD58MrwU3SxJiH42F2yxsdZ41STSyCU2jcYfuLw=;
 b=W2W3sqEcsDtXZk9e/soQpHyae4tpLHBEl3ZQX/sPrYoT9YIrh+/bg66s+fh9L6pwEJ
 Cy/Tf2dFlWkXRQZ9o8ZVGhfFiDFPiu7Q5iLagbuFuYrl+YrBr4VI6zKK/xbNilb2A6IH
 K6vUIm5TUPpChVeeSPrKuQceWrO2UBuB6NjVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776909873; x=1777514673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ZT0fD58MrwU3SxJiH42F2yxsdZ41STSyCU2jcYfuLw=;
 b=AzSLp3kDKCwh1ZbZyOKpEmazlhWCM6UA3Dp2AsIn/Rus2jQkwwoIEk8Ibu6+8TSXen
 DDn3W61IcGLp7M5ts/6Dx4sNCmpOasKmgjnki27lXhJ6LVu7Y3cV0j8inTFglU9ZDMAu
 r1CXbpgYBOMEYDJA4LHa1oUA4QJmSxF5m/X0Ha+GXMhekp2aTxq/hSt74HNBSPhR5k4s
 X1VAa5zv/i3W6SfVCi+DMCRAKE3JtFPzyrLXre/XdyRvQ8vd3yWxCm6XIG3vJ45hmtMq
 oplsjy1tS6LmYxJqzvbnpyPkE2uFF9ghUdEEcpZhdtLnN41jPOuBzei5t459CH9Jd8IR
 kH7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8oNUMKX4jCN2fhZ4OQTFlsa7QNobulFPz1v7NGoSzlro5WKyFMr4nuQ4RC/iNqYAbREAxEuOgR/e/2@nongnu.org
X-Gm-Message-State: AOJu0YxUWL+ISDoqDv1jZIt+VbCkAP6/YDY3AOQCkK64EuhuSBOhszlB
 2m14shA23e4BqQjPj75KenZ6xn3daggXoy8MsVeFhmnf9PXSu9Ym0lesniZXcG4bfLjCJkThB4F
 L/9/msubMFobjdiaGl87JGmcXstOHVRg=
X-Gm-Gg: AeBDiesL4DpThq7LsbtxgCrDowtK2hlfVgwb0nzgnLCrqTbXP9mEaVgmk2lWvbxS0yw
 pnUZ0cbHeE89vXfWayzSg8P6cD6ll7BtPmsC50vCVjoFxvs9bidBfvj+ODdY6Aa/+hARe6oom/y
 HHi6WY/RBC4LvJflnWUV0n4sAjj9Ph4MOQ06JKDoa1N1rJ9NFdRiPUcQklCSCWx262565T/JXUV
 LauPuqQcJyHJXVq6rMY7FOoNyKZuLHTU1Hlao5ZKKi4qI/h/xUMnyH9H8JN9v9B5Fyaxeo3NFTo
 OXt/4iI6+xGHSSm1j4Vca4a8BwDMuRgfdBj4sU5YTsDH67EKOU1N4YxG16zOT8Ad6T2pKQy/vbf
 v
X-Received: by 2002:a05:690c:110:b0:7b8:57ba:2cce with SMTP id
 00721157ae682-7b9ecf98049mr267556097b3.29.1776909873089; Wed, 22 Apr 2026
 19:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-5-joel@jms.id.au>
 <71de5fac-7d75-4640-ad16-2707520c53b7@linaro.org>
In-Reply-To: <71de5fac-7d75-4640-ad16-2707520c53b7@linaro.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 23 Apr 2026 12:04:21 +1000
X-Gm-Features: AQROBzAFEKnXeic1kDkjmfeADlvQ6dzJBOw1uL_BYKkPaZzTTYWhN8A02PZx3zI
Message-ID: <CACPK8Xd6+8Fw_rhPJhZ8jY7yiEp6CjnnDH2T5hkEUaYd+TNXiQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/13] hw/riscv/boot: Provide a simple halting payload
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=joel.stan@gmail.com; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

On Tue, 21 Apr 2026 at 15:48, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 21/4/26 07:31, Joel Stanley wrote:
> > From: Nicholas Piggin <npiggin@gmail.com>
> >
> > OpenSBI hangs before any console output if the domain init code sees th=
e
> > next stage is not in an executable region.
> >
> > If no kernel payload is provided to QEMU, the next stage address is
> > NULL, and the riscv virt machine memory map ends up covering the 0
> > address with the catch all S-mode RWX region and so OpenSBI prints
> > console messages and does not hang until the next stage boot.
> >
> > The soon to be added Tenstorrent Atlantis board address map has RAM
> > starting at 0 and it loads OpenSBI there, so it is M-mode and not
> > accessible by S-mode, tripping the early check and hang.
> >
> > Add a helper to set up a simple payload that gets OpenSBI messages
> > to console.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > v3: MachineState argument was unused
> > ---
> >   include/hw/riscv/boot.h |  1 +
> >   hw/riscv/boot.c         | 20 ++++++++++++++++++++
> >   2 files changed, 21 insertions(+)
> >
> > diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> > index fb90bf12399e..a1eb377474b9 100644
> > --- a/include/hw/riscv/boot.h
> > +++ b/include/hw/riscv/boot.h
> > @@ -78,6 +78,7 @@ void riscv_setup_rom_reset_vec(MachineState *machine,=
 RISCVHartArrayState *harts
> >                                  hwaddr rom_base, hwaddr rom_size,
> >                                  uint64_t kernel_entry,
> >                                  uint64_t fdt_load_addr);
> > +void riscv_setup_halting_payload(RISCVBootInfo *info, hwaddr addr);
> >   void riscv_rom_copy_firmware_info(MachineState *machine,
> >                                     RISCVHartArrayState *harts,
> >                                     hwaddr rom_base,
> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > index 3ea95c175c14..3a97fd1441f7 100644
> > --- a/hw/riscv/boot.c
> > +++ b/hw/riscv/boot.c
> > @@ -518,6 +518,26 @@ void riscv_setup_rom_reset_vec(MachineState *machi=
ne, RISCVHartArrayState *harts
> >                                    kernel_entry);
> >   }
> >
> > +/* Simple payload so OpenSBI does not hang early with no output */
> > +void riscv_setup_halting_payload(RISCVBootInfo *info, hwaddr addr)
> > +{
> > +    int i;
> > +    uint32_t payload_vec[] =3D {
>
> static const?

This gets written to below, but I think we can do this:

static const uint32_t payload_vec[] =3D {
  const_le32(0x10500073),
  const_le32(0xffdff06f)
};

>
> > +        0x10500073,                     /* 1: wfi           */
> > +        0xffdff06f,                     /* j       1b       */
> > +    };
> > +    /* copy in the payload vector in little_endian byte order */
> > +    for (i =3D 0; i < ARRAY_SIZE(payload_vec); i++) {
> > +        payload_vec[i] =3D cpu_to_le32(payload_vec[i]);
> > +    }
> > +    rom_add_blob_fixed_as("mrom.payload", payload_vec, sizeof(payload_=
vec),
> > +                          addr, &address_space_memory);
> > +
> > +    info->kernel_size =3D sizeof(payload_vec);
> > +    info->image_low_addr =3D addr;
> > +    info->image_high_addr =3D info->image_low_addr + info->kernel_size=
;
> > +}
>

