Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A877EFAD3EE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 01:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjKw-0004eG-MD; Wed, 22 Apr 2026 21:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wFjKt-0004d8-Gj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 21:58:36 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wFjKr-0007fD-FO
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 21:58:35 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-651bc8f864fso3486982d50.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 18:58:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776909512; cv=none;
 d=google.com; s=arc-20240605;
 b=SRW2Heq0nj+OtJNuMM2RnwW4z/Kzw91U0UkChNCWWqIWwCsB/uitOJ1hGUMolOHhCd
 AdDMA4vqv/4cq7uitWOknO5e49gMB/roCYZvw33CAlLBv5PTFTV+qX6xF3qg5PJMRmHi
 ESt34pb0cdpwokSVKb6EUZSbGT8Zk4/xk4rEeZ46NVhx3alz/Kw2/02+9C46FLokQck3
 oDUtJlBsV9FKsC/8BWab+1WFLjIFMiH8EU7Sl8E/Q03zWr7gKnv4zD8jSmL9NY450oZL
 oP53uDQGhhQZs5XUIaqnvK8X0P+LPC83bBm1XzHc8FeIbP7BGzuHg7H/prF3QRmiyKVg
 w8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4FzGvuQkv7aoV9mw0vtOGf/8CED12S3/SxbmpRr3BsA=;
 fh=IeuJXmQOw1NbL14JLaDd/LlJP4XoqBMxzDfvdW8hIf4=;
 b=BwLPQWn3pjTZSgS29u85t7QBMsK2JmOXz5HJsI1eDKgbA1gGy4PpjYdZ9RbLtHiI3+
 ZiACyO0uskfP8b1hJgXmU//01QqgKJkazzLEn6VeJrupkBCO8X2usrsRBsVYqEWzftEC
 0hYWnhZFR9X3RIkYYZ1SvhLvtHn0DWgglaDhWhIdisoy1Ntas29NqYerUftMN4cy8Vt1
 cH4NQpK6+seYupFe4ghgGf2MHX0UzAwPjPox3OV8e2KaKhmArcKghdyvCbJt1U9uRxLI
 ixOy37Btq3tsvotJXfaxMD03q9mIwCWtD7seivJ2uH8Os/T3W5awrdfIjf4SX1PRZGIp
 ZRqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1776909512; x=1777514312; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FzGvuQkv7aoV9mw0vtOGf/8CED12S3/SxbmpRr3BsA=;
 b=ItCyFO5I+ZMmCcsBSI4MXtWw9jI2V1r4J1J0ZhciJxPzDH9ezzPEi1kd1l6jrqyCZT
 GO1JzA/X5X8YD1FOgHnGW3yOQraRal31QEoAu12gfw4L1qCCgmf7CvfBTTDPMJo7/RHZ
 iICW19Wjy9ST617MdDl2QWPtO3argL8CD6HjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776909512; x=1777514312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4FzGvuQkv7aoV9mw0vtOGf/8CED12S3/SxbmpRr3BsA=;
 b=TpDStMns2hW3bviSYtPfDk8pMxnfbbCChYZJm2bttxZdP23MqijVB13flRbcuN7Y2d
 sf+GcB4n4OZBPyh0f6ut5s4anp9F7dMlOGsYMpIsc08mJ8o/VvWp6ocQZob/rQ6jr6X2
 q1dww1b9cXPghJ31qjWkAt9RBhxITDqD2lI4FMjTPOqdbOqXhqW+wuVw6wF6StJdZirK
 PkdBuHf976vDrkx5kt7DSGHTrZtXdKWW+45gwfmNGy9Y+EQkZOVNn9Cz3f6HrhfNeEe7
 gDYuK7ibgCIsGbdboQ9Jjd4STigJYguTmgOd4PNAEFyhWnKY6f2RhllACKNEVqThJw25
 SGwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uP9BvYgirJmg6kLdgJV1Q2MEbmgPCCxbCoXlkfdmJP7L6duV0sEKHdTSZzRM0D0h9U0ieP5hYVk8C@nongnu.org
X-Gm-Message-State: AOJu0YwtSrJjnTro42nynCXFwIeIy8HAN4x4qyWliPG9cSkttv05364H
 gNPtssyWKdk6bGNdTwRlMHsAJVwTQI+ffvZL6yvhEvSE6o6ICcUhTgAWjGYjIrcpzy5vq0nl4BF
 A3ajsme5XUGjkgRhlE9/2Taca4dOvVuM=
X-Gm-Gg: AeBDieuNjDdjZtbXN1zghsIotVCZMyEz/O7xeRD1WabU286gjNbfqViRD1uV03jgeSU
 BvsSCEPjytFyvnSAG/vAIB9CtJrO8je412nT6SK95hRTRHNf3eozagzS3rNQU0425c6FvM/3xaE
 KMkO2orGB6Uqmk3LB5Dxq8eJNYu8KLUfAy8ywFS02C+r0BQ3vRxSEvmz0GcukziIEWJCgCbx5Vn
 dRkHz0UYc0n06A+3JvlaonTFlv57OLV3+11Dg25Iq/7sVc/z6pIZGmAXv6xbQQLKWMRdf90D80R
 A5Wa49eUNmMPqRG2QgkaVQQz3tnaSuVnAxCSgNejByGxzR/1TfRdHbCLw3RK6op4lmJYucqwQ42
 LyahuFJZ+Gao=
X-Received: by 2002:a53:ac91:0:b0:654:acd4:9c1a with SMTP id
 956f58d0204a3-654acd4abbemr111841d50.13.1776909512065; Wed, 22 Apr 2026
 18:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-4-joel@jms.id.au>
 <9dde1635-ea18-4abd-8ce5-24ac73f21198@linaro.org>
In-Reply-To: <9dde1635-ea18-4abd-8ce5-24ac73f21198@linaro.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 23 Apr 2026 11:58:20 +1000
X-Gm-Features: AQROBzBKVXabbNvZagiiWyO6vIyGYjYdwt_jQeEHHH3f36qlIM1jwtpbgjcCV9U
Message-ID: <CACPK8Xd-nFZi2_MYQMv+vrNyQdU=bhE4Wri10OohE-Fm3TWM+A@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] hw/riscv/boot: Account for discontiguous memory
 when loading firmware
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb131.google.com
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
> > This loads firmware into the first (low) memory range,
> > accounting for machines having discontiguous memory regions.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > v3: Call riscv_boot_info_init before riscv_find_and_load_firmware in
> >      sifive_u
> > ---
> >   include/hw/riscv/boot.h    |  5 ++++-
> >   hw/riscv/boot.c            | 18 ++++++++++++------
> >   hw/riscv/microchip_pfsoc.c |  6 ++++--
> >   hw/riscv/opentitan.c       |  6 ++++--
> >   hw/riscv/shakti_c.c        |  6 +++++-
> >   hw/riscv/sifive_u.c        |  6 ++++--
> >   hw/riscv/spike.c           |  6 ++++--
> >   hw/riscv/virt.c            |  7 ++++---
> >   hw/riscv/xiangshan_kmh.c   |  6 +++++-
> >   9 files changed, 46 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> > index 115e3222174f..fb90bf12399e 100644
> > --- a/include/hw/riscv/boot.h
> > +++ b/include/hw/riscv/boot.h
> > @@ -53,13 +53,16 @@ void riscv_boot_info_init_discontig_mem(RISCVBootIn=
fo *info,
> >   vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
> >                                      hwaddr firmware_end_addr);
> >   hwaddr riscv_find_and_load_firmware(MachineState *machine,
> > +                                    RISCVBootInfo *info,
> >                                       const char *default_machine_firmw=
are,
> >                                       hwaddr *firmware_load_addr,
> >                                       symbol_fn_t sym_cb);
> >   const char *riscv_default_firmware_name(RISCVHartArrayState *harts);
> >   char *riscv_find_firmware(const char *firmware_filename,
> >                             const char *default_machine_firmware);
> > -hwaddr riscv_load_firmware(const char *firmware_filename,
> > +hwaddr riscv_load_firmware(MachineState *machine,
> > +                           RISCVBootInfo *info,
> > +                           const char *firmware_filename,
> >                              hwaddr *firmware_load_addr,
> >                              symbol_fn_t sym_cb);
>
> Except in _init(), this structure should be const, so preferably
> 'const RISCVBootInfo *info'. Can be done on a cleanup patch of
> course.

This was easy enough to fold in.

A future cleanup could make all of the riscv_load_ functions take a const *=
.

