Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C399F433D0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 00:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDAHA-0000jj-Et; Wed, 15 Apr 2026 20:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDAH9-0000jD-5d
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:08:07 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDAH7-0007ww-J0
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:08:06 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64eaf8aa893so6306104d50.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 17:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776298084; cv=none;
 d=google.com; s=arc-20240605;
 b=WitQ0PzthpPf41t+30nR9bosDile2d1WopQuAfr+EcDs+zEzVx5hOXHt8/VSL0P8VU
 x95zFWhUa/rDcOJyZb60GsAVMCCYF8SQOiuFFI0yq0AXaoOQo3N2q7Lue9dXet2wAgtS
 xxUHWpDmMwl9/WlPhvWipDNhTe+R/gJdamNP4yFBldLBlIyVh3IA+hMFn2JdOu/IhFlP
 BSLKEsSfibW9SdD6nOqFqtfqgi1617G1ixywlXIYWK5XVPL0GStag+Hmshx1Z8fdl0GH
 x0iIUjhC2f2FxuHlPLhzZ8O67oOw189k7bjtOn3IvFF18CAaH1Df10QdWnGlfFR+H9gf
 pptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ALXJDhGoGm2ecKUcLFHHfFLWkNA5qeY5vpMn4UEbSMw=;
 fh=qfLCg9wuugiodPfFFzOc0aeevq00y/QWyEwgPIS5ii0=;
 b=hNTc+evtr+dp7rPDF9Q79KLysumpUlj5H+wL/zEyZWFkBZLfhNtaWV6Yt275QepJ74
 mXiPV6Jhwfw02VfvxK4oLZ2WkZWGeXHtHBCZ4LBH4zXVcYbzWJv5xrPhkwbKmEFcd2K7
 sq0KSx2pT2nDxQPTRrv96S31DAnVkRiCzG1YJvP642CKxuT9DXiZZvOpCqB/Lg9WpnNv
 EVogyEmLZQCFTUvoM83WzleuxN+5uyJJbCRNJDZFHjSpoJEN7RQI9OWrdlfw0QsdD/v5
 qCbZzMrcrBrAm0gmHOPOaQOGWWb+0BPnCZf+Zg0ljHeMWO0IDSqBMUbFs/OPZ37OsexE
 e5wA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776298084; x=1776902884; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALXJDhGoGm2ecKUcLFHHfFLWkNA5qeY5vpMn4UEbSMw=;
 b=jJtBys8Sr050v4UdGi2jpeQCRiUjadzKgUQekX4sVy0xZjUe+DYc3olASSWAtZlN7b
 m6lLEAWtCPreu18KDD1Y+vnqyd4Vmc8g5hEyWv5W/LK0NkMo5H2LH5mdoSiIauh8lYvI
 jFCHHrHBxz2SYbEKP93hEkcJY0i2EjXscWLwnXRV31UnS/JtmoF3/9tinm7n62Yh8+yo
 nkieIhDxm5873aJI4QHS6WQsES9tVO6uTyHhE6gJRTswECixl+nqDsr86RWuY2+Uol/w
 3BlohNarMd9aoweHgP8XTkBEbV/G6oGZvNv+S+Kb3U91GsWD+4NjIlyHgBsScmTUhlMa
 QrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776298084; x=1776902884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ALXJDhGoGm2ecKUcLFHHfFLWkNA5qeY5vpMn4UEbSMw=;
 b=btGBJTbT3M+SqaQ1J9yJdDVehV6apYtUoWylpN74IvdtmW/0olaNRZO2nBm0NLnmAy
 5nAbqA7ujxOEYCal677PbUHn1v98E+DyrwLKDTvkMcPOYrdYH89jeOLUTaWfXLWVQAEc
 8t00Ft0AAwYQbEO/WIgZw3Ssdo6Sn8Vhfw1I7DePrehjOGgXMsUYeuRhC8076LpuLLLG
 oy7/vU1/c94BHLV9pB+dpvBl3qM8I4+XYdbFDnaF2pWtqOGhGrYvqyUvlEcJpCkehbiX
 Xi/NPvk/XOeJCEZMIpym036eM12+0DrgxVUfcc1xv9sVC4ko4bSmdZdXpqO+QSTJfG8x
 9weQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rfFuo2HTNxLG3Y9eg536il5emleYZ3DQQ4EnE4eYummDSZIq0MlxyKrRzYqppkSHTq5GQlsVdAIQh@nongnu.org
X-Gm-Message-State: AOJu0YwGyyhObnTSGCTWYn+NltWMAc9IKaR2jF4HUFiZ6fhYwaERAY7R
 NF5/h2xIrT0igME6k3VviNKuJmviG8kvhABj9BxXN+gF2jWH0Majm8AqTVSPvlyKfjl+71kVnnb
 lcyTGsJYi6pdshV9me09fuTL+oqIpvq4=
X-Gm-Gg: AeBDievMYbMEkBGXUTiQn5ibmw28LFmwnX3/fSX4iwX8DwHujfkQM3yFFKVPHCOJL32
 bZMp91oux65Ay7OUYpf4jooWeaLadXyM1zP6uXMPws4pIr1n8trp6NglNDZ4kUdRrCIDVh+nnQB
 aGu2N62SloFHK9J/4AWEe25nTdtI+p+JYrdfPge1kV86xzGxdmgWx/bGWfgmKPSObMgWhwut5xF
 cMeDPGKlsLYUIViFVVyQUd2tFvOto0u/tHMkHifpPOmd/Zqrwb+S5TnBXAhA5wA8sXmn3NCRK0X
 yLH23l/zKPQgyTYyLadOY3jtcYHmafZrVwQMBA==
X-Received: by 2002:a53:db50:0:b0:64e:8748:38a1 with SMTP id
 956f58d0204a3-65198c0e535mr16752764d50.66.1776298084233; Wed, 15 Apr 2026
 17:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260415064838.652297-1-joel@jms.id.au>
 <20260415064838.652297-5-joel@jms.id.au>
In-Reply-To: <20260415064838.652297-5-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Apr 2026 10:07:35 +1000
X-Gm-Features: AQROBzCW8dBcAsMfWD7bEGxxLt9aaTLgdiQ_ksRAhI52m84iojiEsGUv3NCoBc0
Message-ID: <CAKmqyKNSHENKy0fRfo3vNE8q1M6qELtxYkNPCdkyumLbTX7jrg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] hw/riscv/boot: Provide a simple halting payload
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Nick Piggin <npiggin@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=alistair23@gmail.com; helo=mail-yx1-xb133.google.com
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

On Wed, Apr 15, 2026 at 4:50=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote=
:
>
> From: Nicholas Piggin <npiggin@gmail.com>
>
> OpenSBI hangs before any console output if the domain init code sees the
> next stage is not in an executable region.
>
> If no kernel payload is provided to QEMU, the next stage address is
> NULL, and the riscv virt machine memory map ends up covering the 0
> address with the catch all S-mode RWX region and so OpenSBI prints
> console messages and does not hang until the next stage boot.
>
> The soon to be added Tenstorrent Atlantis board address map has RAM
> starting at 0 and it loads OpenSBI there, so it is M-mode and not
> accessible by S-mode, tripping the early check and hang.

That sounds like an OpenSBI bug more than a hardware/QEMU issue.

>
> Add a helper to set up a simple payload that gets OpenSBI messages
> to console.

Where do we load this payload? What happens if the user loads
something there as well, so we clobber their binary?

This seems like something that should be fixed in OpenSBI instead of
hacked around in QEMU

>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2: Update commit message to clarfiy that Atlantis isn't in the tree yet
>
>  include/hw/riscv/boot.h |  2 ++
>  hw/riscv/boot.c         | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index fb90bf12399e..d1d7258a2179 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -78,6 +78,8 @@ void riscv_setup_rom_reset_vec(MachineState *machine, R=
ISCVHartArrayState *harts
>                                 hwaddr rom_base, hwaddr rom_size,
>                                 uint64_t kernel_entry,
>                                 uint64_t fdt_load_addr);
> +void riscv_setup_halting_payload(MachineState *machine,
> +                                 RISCVBootInfo *info, hwaddr addr);
>  void riscv_rom_copy_firmware_info(MachineState *machine,
>                                    RISCVHartArrayState *harts,
>                                    hwaddr rom_base,
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 3ea95c175c14..fc8a39a8d913 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -518,6 +518,27 @@ void riscv_setup_rom_reset_vec(MachineState *machine=
, RISCVHartArrayState *harts
>                                   kernel_entry);
>  }
>
> +/* Simple payload so OpenSBI does not hang early with no output */
> +void riscv_setup_halting_payload(MachineState *machine,
> +                                 RISCVBootInfo *info, hwaddr addr)

This function is currently unused as well

Alistair

> +{
> +    int i;
> +    uint32_t payload_vec[] =3D {
> +        0x10500073,                     /* 1: wfi           */
> +        0xffdff06f,                     /* j       1b       */
> +    };
> +    /* copy in the payload vector in little_endian byte order */
> +    for (i =3D 0; i < ARRAY_SIZE(payload_vec); i++) {
> +        payload_vec[i] =3D cpu_to_le32(payload_vec[i]);
> +    }
> +    rom_add_blob_fixed_as("mrom.payload", payload_vec, sizeof(payload_ve=
c),
> +                          addr, &address_space_memory);
> +
> +    info->kernel_size =3D sizeof(payload_vec);
> +    info->image_low_addr =3D addr;
> +    info->image_high_addr =3D info->image_low_addr + info->kernel_size;
> +}
> +
>  void riscv_setup_direct_kernel(hwaddr kernel_addr, hwaddr fdt_addr)
>  {
>      CPUState *cs;
> --
> 2.47.3
>
>

