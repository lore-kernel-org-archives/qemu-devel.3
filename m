Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F62FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIERv-0006au-Q1; Wed, 29 Apr 2026 19:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIERo-0006VD-EM
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:36:04 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIERm-000262-Ii
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:36:04 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-678a1642a81so490097a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 16:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777505760; cv=none;
 d=google.com; s=arc-20240605;
 b=XMQFEtee/V54n61ri9kTS7x4Z7lQ9EdH9z9W3bDprZH6fhZ5HQXNBLSH8ftBZaBqTp
 +HPaEjqH1Dz6iEAHN6be8mwBgT3RMVeE8ldnkQ/d7p5ofa/C3r5ZRHETCOyBjDjBksSZ
 +2aMq4BghyG6i8a1XfkbeqOJNTDYczAOBzjW7CJkrHqLA4+94ce6KyRrDauJBIm+VA0N
 +Be7zyaSn+1XC/pH6rX/4RvqiZ1d477/fQmIZmsH1/PgsHy5A47fQZ2DAnAJ+S/kNivR
 2M/UkystlfHly2sUSVS2ZtsB5elumO7uNU+qEf+gpa2wvw/uQaypoF3hw1/LudCMjtu4
 Awbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Nb63jU16Pwm+F7XcD/SWPm6ecHRfhPr9kNXwEg3x55U=;
 fh=XNfgWg2XcrQDIEC1voIYLqREVck/pFMxCLbd5cVDpnE=;
 b=O0+XQchj4N0ts26Nyg02WC8yTcGDtCWThgj9YLfiEnS5FU16oDmug0b36LWxpfISnB
 SxzwTQEaYTOZkCDXWzU+lxiE0yP6XGJhEFjPZoLYjT+RGPTBvkvzimvizlqmDxEJg8Dd
 TI8Aqpfl2z73bkdsdKHIKv0bvktOzV/MaFt4SjjH+79oUG8JIyR5TO0xrkk8P9A8kw7p
 UXQpmifiZwza0zuJMDYAZB6cN4sGqIiigckXVJV0dRHPgWZLOxKn3FLdAnfvGPVHKDOm
 HWXz+iRlI9hhX0aYAnvAGDBiaru4W1xu7TyzxjfY1WALshxlycistzGiAkKOWYO0PVoL
 DR5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777505760; x=1778110560; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nb63jU16Pwm+F7XcD/SWPm6ecHRfhPr9kNXwEg3x55U=;
 b=eOKhHSoqV8ObGvdcfBQXUQAa/Um45Cx64cEIuONRkVPblLwL9DZ1bmDEDfIIvRGvhr
 9NN2ASgTDUL7V+ojV9uD0Wg3xBvFSZl5lP7XRlW2ZVXMBsLeMjKz4uMH9SiQARf/fDCD
 YLw6Ptqai7Tzy+lv/HkY/FFSQok4I41WNVT7mpqFY31/KjM1PiswTAHVt2tWQ3PzC7TE
 yDxvX/MaRKA9gAGHW7ujRLGt/9p7PK+LeQBwUwwiUrjcgeWsR98nDpTNXU+eykl6JxeO
 P+TJ474Wv+1giIO3RXsjSSk4WNDrXRTMQNAjWSHRf/N3dWvm+BAjnO4s4K/XEPKuJHYm
 1Pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777505760; x=1778110560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nb63jU16Pwm+F7XcD/SWPm6ecHRfhPr9kNXwEg3x55U=;
 b=PAwB8lHFzjN74et/jAF1nI1kIpHJPHgmfy3v+JLYxLgFGV+TaVVIMaP5UBnZ4kB8oC
 zcaqymOwI4yrUSL84BJfuBE2udpEKKcNhYNHsmgKck4OnKQjSWYTYGSs7k4gpEie5Nep
 ADXCrqj4vLb+OWupc9KbxjWIZHDJdvaOKmjCAZAT5LtNTBXMEe0qs728sduCy6CMSbua
 y07nZu1nWsf0VtOQW3/c9QM5yepx/9WbOYJDz7ltp7mcriyVXd/mVtYzR6SOfcei5Q85
 OnGU/t0Rxuj5N5uuh1k/AH8qHSGNpJkTnxHvj9Cyruaa3e50G+ESMs6B1Jsue8+UdfFC
 jVbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jmu00IyTR+nEPJxF55xh7Zr61eCgUQAnt7ZNtwwC+o0U4oVBCx9RhKj4vmK1+T2mAqtT/3kGemEY4@nongnu.org
X-Gm-Message-State: AOJu0Yy9AnM5gjv2pvO+j9/NK/gltEXkZRVzUuq/01wcA0Q6jvUWthzw
 cx8k98I+Wc9iijG2lPk7AAItbU0m0QFsYXclSjx5gQr3rb4eRxjBsEQ23LVMwEKoiQ1PF9ctYbs
 FwB8I4Kw+XdwQ+Dzvx35A1NqgK+AZFeU=
X-Gm-Gg: AeBDieuaaqmz5zm//Iag19S1fK4YS9zl0ZVf58IO3xhpxnpq8BP0kjF14vrsmMa6Cxz
 F8pWtWkhJI8fBu6oEhB81G8sRQr54qVY40mHvdRmd7fv79dwFI4TRBMPOm3TNaqGXrS30VFJyfQ
 BooSQLwJ59+H4s3c8UETCIda1IqZgI0FBIp2ukwyfsmLqiAPAoTXTb25Go4HvgUmVgJCG9Nitlv
 8JrNIW+mM93UKdb06lKeuRTfVMB+k3DegVu2ztdgI8m71endd7/J751mvrPvNVdl6N7Eol/XtsQ
 DweKDPB3qi9KppvMxwOfCkwWBXVyUpdWFLfFKUUoyaPkBpvS
X-Received: by 2002:a17:906:5181:10b0:b9d:94e4:d35e with SMTP id
 a640c23a62f3a-bbac70a8c38mr30188666b.29.1777505760387; Wed, 29 Apr 2026
 16:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-5-joel@jms.id.au>
In-Reply-To: <20260425131721.932250-5-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 30 Apr 2026 09:35:33 +1000
X-Gm-Features: AVHnY4Jvgnmo_yPkz1FQ-QZ02_5KnniSmz9rqk6UdIG40QwQ-AaeZVFAQ4b3BdU
Message-ID: <CAKmqyKNiJ9hGQVPsq8pEz8ydEWydW=umT4XwWanwk-etADgf_Q@mail.gmail.com>
Subject: Re: [PATCH v4 04/13] hw/riscv/boot: Provide a simple halting payload
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
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

On Sat, Apr 25, 2026 at 11:21=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrot=
e:
>
> From: Nicholas Piggin <npiggin@gmail.com>
>
> OpenSBI hangs before any console output if the domain init code sees the
> next stage is not in an executable region.

That's an OpenSBI bug though and needs to be fixed there and not just
hacked around in QEMU.

Alistair

>
> If no kernel payload is provided to QEMU, the next stage address is
> NULL, and the riscv virt machine memory map ends up covering the 0
> address with the catch all S-mode RWX region and so OpenSBI prints
> console messages and does not hang until the next stage boot.
>
> The soon to be added Tenstorrent Atlantis board address map has RAM
> starting at 0 and it loads OpenSBI there, so it is M-mode and not
> accessible by S-mode, tripping the early check and hang.
>
> Add a helper to set up a simple payload that gets OpenSBI messages
> to console.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v4: Make vec instructions const
> v3: MachineState argument was unused
> ---
>  include/hw/riscv/boot.h |  1 +
>  hw/riscv/boot.c         | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index b2ef64fb1d14..3dfb0e98db4c 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -78,6 +78,7 @@ void riscv_setup_rom_reset_vec(MachineState *machine, R=
ISCVHartArrayState *harts
>                                 hwaddr rom_base, hwaddr rom_size,
>                                 uint64_t kernel_entry,
>                                 uint64_t fdt_load_addr);
> +void riscv_setup_halting_payload(RISCVBootInfo *info, hwaddr addr);
>  void riscv_rom_copy_firmware_info(MachineState *machine,
>                                    RISCVHartArrayState *harts,
>                                    hwaddr rom_base,
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 4fbc778263cf..3c2501b3c721 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -518,6 +518,22 @@ void riscv_setup_rom_reset_vec(MachineState *machine=
, RISCVHartArrayState *harts
>                                   kernel_entry);
>  }
>
> +/* Simple payload so OpenSBI does not hang early with no output */
> +void riscv_setup_halting_payload(RISCVBootInfo *info, hwaddr addr)
> +{
> +    /* Store the payload vector in little_endian byte order */
> +    static const uint32_t payload_vec[] =3D {
> +        const_le32(0x10500073),         /* 1: wfi           */
> +        const_le32(0xffdff06f),         /* j       1b       */
> +    };
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

