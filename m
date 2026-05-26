Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460E7CD5BC9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 02:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRhKN-0003Ua-Rm; Mon, 25 May 2026 22:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRhKL-0003U7-Vf
 for qemu-devel@nongnu.org; Mon, 25 May 2026 22:15:29 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRhKJ-0003C7-L6
 for qemu-devel@nongnu.org; Mon, 25 May 2026 22:15:29 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-67b8d9c26bbso20305436a12.2
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 19:15:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779761725; cv=none;
 d=google.com; s=arc-20240605;
 b=MjXxZfNkXsxG8dUI4SRQho50aEE0Tf0Me7SmAmkduNlGp9R8bKuNMuw2LahkMorxSI
 j9xXvRaYwLPDOGfd4UO6HzTOHssUikItFXJ0O0eUAywT1XnNN0EPyfNEDlqwbvPM9+nU
 EbEG+B6uh6i3qtnYzqHwEfUlU48gne8tKarYwCC1N962JJH4vseWtzP23HAulqdZvHgs
 Gjn/dr6bDe/SGcxTKBbkycdMByjIwgDPSjVMfvQ4FS0VYTyOWqbmpIMKU8oC1f2ru5tO
 vrkjdI5gJC6P6HcUK1WPgJhVdGDPVxRz21hPYB3NR7IgPz77rkPeFsCiQidnB9AcKXGJ
 l82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oCDTD8lH0y6C8BeRbEgLqHJNbnDfaJ7MDj91cAjqHHc=;
 fh=TtG/iV8sfBZwdR9sl0n8UMsaUtOivjwzY4oaHz5eVkY=;
 b=IedtLbZBMU74PvF2fkHsIGOOY9HrpjIsb3aa4ywL70JKJ+SeyODLdhQwFn6UEw3fRs
 jApw9gn+tOkUQcpXzI7kfeCkhCBkLMTurC7/iBmKX2XXtpG8ajjDluSU1wgWRPBWmTFN
 viWYzi2YVx5eXs9hB2QbO/yqKBurrnqUbKaHjKj1qX6JgjJGGzUPAeRzuF0aFp8nnRoa
 KO4/jVmGBkmNOgNs/b3mxyn1BydUGgjYaUx52dA3gBL8IX24SWhOCK59+AEpdFKr9zAL
 YhaHVeiEo6Q3BCA/VCk93jeMJcwXVh2E2F2X7k4eo3ojrZQR5KL4VZj1UWOLk/jGFfzc
 omaA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779761725; x=1780366525; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oCDTD8lH0y6C8BeRbEgLqHJNbnDfaJ7MDj91cAjqHHc=;
 b=SWbT55heKpo3ZsXAjbM9Rv0w2ervEgbh3UiHPph6qkERmKAYOFb0Hs4XJHgFNX5aEq
 Id1Hza3+bmKfmDQoywN+xdkcYU3C4NPeVWduEmu20gp++vnlm9xelpSrUQ8NAlmrZOOc
 5Nq956O6DkD3loPRSWvnhieeDAqM5DIWV6FHt0Mz9jxNOTxmga09vf+egysyivZ2AgYA
 f0kAN2GO19QmQW/UvkTFjppFP5gjXqhw66+ZjS2JXiMPpq+bFlf7A8yh4hYkWgRgTZb6
 vCmVunDeCTkR5t8HNw2NvgjIeckcj9GjTyP98KWUWZn0WnPCTMxgWu6Nb8mihZkzq1Hv
 xSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779761725; x=1780366525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oCDTD8lH0y6C8BeRbEgLqHJNbnDfaJ7MDj91cAjqHHc=;
 b=XE8YtO3ZRIZas6BeZaIPOO4klQ7xPpZffrYUKfSy9vz2wCyvqRLyMQDHzn7DMIwbgA
 1qR3V5JllsGoB7Xcn4yK2dy4Lkjd3BnTKnzHuHEOLdj/Akb80ETSS+/xvoE65jcppLWB
 ZP5CaxHGd/tgOnp/I7+88kY2/sccvX98eZIft0Rai5x63NmCGVz/kzWXr4EUp7sByhVz
 rc34hYfCQ/Y7KW1Uzt/LsDNjNZNR4jrAh/+6Izv0QJE9icgoKXFoPaaGrhogRKDUqqTq
 MQFFC2K7R0fP2wQz9dbSfnIv298b859wS/b2XhHt17odfgRFQbdJ2epjvDpwSh62+8eW
 /H1w==
X-Gm-Message-State: AOJu0YyAjzXmzEv+a3guWSePq/9nKC3gS8L5CBFld6sqwZbg6oWs60/U
 rtYoNoUUe6eagMiT52UzKbIWb83Dd5EdtLQgBWNlhFc0AcgkOpqNy84EiBqc5pn3C3veaAqCOea
 dHViEqz1k9sOVbLgePz0S4SunFyNkQGxNr6OEnFPy8g==
X-Gm-Gg: Acq92OGJFYPjPPGGars1enbxeSuQNiNiR/stCKEhcj7Hf5rZhXfjD49JBxWllQaAnIr
 V9n+MJXTfDbq+nOa9ex9/sazMQCTMdGJJ8ZaQInX7fPZrYOmUIxsBXoxsPjEHPo3jsMZzQ6F3Yr
 jy1P/rT2zpQsFtgNhAONx+q7GDbFXIY93oSsfGz6dvwujA2BpzUO66g6YmtPL6Qng++WQffvwB+
 KnH/SCUtFTnxLKImFwNwDAwBT/Kf3Ozu+41wpF+EhvW+NzltqwB9mvTu4VaqRmHdk81A+6fpza9
 RHmNS+OIfSGgF1xJ3uMwgfwNOsOyfSTNgQwwGQ==
X-Received: by 2002:a17:907:3f13:b0:bc5:1329:a1c8 with SMTP id
 a640c23a62f3a-bdd25ce8c6bmr846524866b.31.1779761724858; Mon, 25 May 2026
 19:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260522000324.23255-1-alistair.francis@wdc.com>
 <76440da5-9f2a-4536-babc-082359812713@tls.msk.ru>
In-Reply-To: <76440da5-9f2a-4536-babc-082359812713@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2026 12:14:58 +1000
X-Gm-Features: AVHnY4J0Cu_aoPDqmqUd3WJJOEDz4rpipF0xuS1VDAOUH094gipveH5cP8qbKg8
Message-ID: <CAKmqyKN2N0pJGvazDTfnxLhy9d5LUhjEgq-Kq11wNX2-Ajyvzw@mail.gmail.com>
Subject: Re: [PULL 00/48] riscv-to-apply queue
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 qemu-stable <qemu-stable@nongnu.org>
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

On Tue, May 26, 2026 at 3:43=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 22.05.2026 03:02, alistair23@gmail.com wrote:
>
> > RISC-V PR for 11.1.
> >
> > * Remove spike as default machine
> > * Deprecate the shakti_c machine
> > * Set MISA.[C|X] based on the selected extensions
> > * Update Maintainers for OpenSBI Firmware
> > * Update OpenSBI to v1.8.1
> > * Avoid RISCVCPU copy in PMU FDT setup
> > * A collection of specification compliance improvements
> > * Fix Svnapot 64KB pages
> > * Handle source overlap of vector widening reduction instructions
> > * Check interrupt in SiFive UART after txctrl register is written
> > * Fix medeleg[11] read-only zero bit for M-mode ECALL
> > * Fix tail handling for vmv.s.x and vfmv.s.f
> > * Update the local AIA interrupt mask
> > * Add KVM support for Zicbop and BFloat16 extensions
> > * Fix the IOMMU FSC SV32 capability check
> > * Avoid caching PCI device IDs in the IOMMU
> > * Implement Microchip mpfs ioscb PLLs and sysreg clock dividers
> > * Remove the internal CPU riscv_cpu_* arrays
> > * Fix IOCOUNTINH.CY toggle detection
> > * Fix the read of pmpaddr(0-63) CSRs
> > * Make hpmcounterh return the upper 32-bits
> > * Minor fixes and enhancements of RISC-V AIA devices
> > * Re-process IOMMU command queue after clearing CMD_ILL
> >
> > ----------------------------------------------------------------
> > Abhigyan Kumar (1):
> >        target/riscv: Fix medeleg[11] read-only zero bit for M-mode ECAL=
L
> >
> > Alistair Francis (4):
> >        target/riscv: Remove spike as default machine
> >        target/riscv: Deprecate the shakti_c machine
> >        MAINTAINERS: Maintain OpenSBI Firmware
> >        target/riscv: Update the local interrupt mask
> >
> > Andrew Jones (1):
> >        hw/riscv/riscv-iommu: Fix Svnapot 64KB pages
> >
> > Anton Blanchard (1):
> >        target/riscv: rvv: Handle source overlap of vector widening redu=
ction instructions
> >
> > Chengbo Gao (1):
> >        hw/riscv/riscv-iommu: Avoid caching PCI device IDs
> >
> > Daniel Henrique Barboza (16):
> >        roms/opensbi: Update to v1.8.1
> >        target/riscv/cpu.c: add xlrbr isa_edata_arr[] entry
> >        target/riscv/cpu.c: fix smctr/ssctr isa_edata_arr[] order
> >        target/riscv: make riscv-qmp-cmds use isa_data_arr[]
> >        target/riscv/tcg: treat all exts equally in cpu_disable_priv_spe=
c_isa_exts
> >        target/riscv/tcg: use only isa_edata_arr[] in cpu_cfg_ext_get_na=
me()
> >        target/riscv/cpu.c: remove riscv_cpu_enable_named_feat()
> >        target/riscv: remove riscv_cpu_named_features[]
> >        target/riscv/tcg: use isa_edata_arr[] in riscv_cpu_update_misa_x=
()
> >        target/riscv/kvm: use isa_edata_arr[] for unavailable props
> >        target/riscv/tcg: use isa_edata_arr[] to enable max exts
> >        target/riscv/tcg: use cfg_offset as cpu_set_multi_ext cb opaque
> >        target/riscv: do not set defaults in cpu prop callback
> >        target/riscv/tcg: use isa_edata_arr[] to create user props
> >        target/riscv/cpu: remove riscv_cpu_* arrays
> >        target/riscv/csr.c: fix read of pmpaddr(0-63) CSRs
> >
> > Fangyu Yu (1):
> >        hw/riscv/riscv-iommu: Fix IOCOUNTINH.CY toggle detection
> >
> > Frank Chang (3):
> >        target/riscv: Update MISA.C for Zc* extensions
> >        target/riscv: Update MISA.X for non-standard extensions
> >        hw/char: Check interrupt after txctrl register is written
> >
> > Guenter Roeck (1):
> >        hw: misc: Implement Microchip mpfs ioscb PLLs and sysreg clock d=
ividers
> >
> > Jay Chang (1):
> >        hw/riscv: riscv-iommu: Re-process command queue after clearing C=
MD_ILL
> >
> > Jim Shu (4):
> >        hw/intc: riscv_aplic: Fix level trigger IRQ in direct delivery m=
ode
> >        hw/intc: riscv_aplic: Add reset API to APLIC
> >        hw/intc: riscv_imsic: Add reset API to IMSIC
> >        hw/intc: riscv_aplic: add trace events of APLIC read/write funct=
ion
> >
> > Mohamed Ayman (1):
> >        riscv: virt: avoid RISCVCPU copy in PMU FDT setup
> >
> > Portia Stephens (1):
> >        target/riscv: Make hpmcounterh return the upper 32-bits
> >
> > Zishun Yi (9):
> >        target/riscv: Allow mseccfg access based on ext_zicfilp
> >        target/riscv: add Zvknha as an implied extension for Zvknhb
> >        target/riscv: Remove unconditional MENVCFG_CDE from mask
> >        target/riscv: Fix missing CDE check for scountinhibit
> >        target/riscv/pmp: Fix integer overflow in TOR and NA4 address co=
mputation
> >        target/riscv: Add mseccfg to VMStateDescription
> >        target/riscv: clear mseccfg on reset for all dependent extension=
s
> >        hw/riscv/riscv-iommu: fix FSC SV32 capability check
> >        hw/riscv/virt-acpi-build: Fix off-by-one error in RIMT ID mappin=
g
> >
> > Zongmin Zhou (2):
> >        target/riscv/kvm: add KVM support for Zicbop extension
> >        target/riscv/kvm: Add BFloat16 extensions support
> >
> > chen.zhongyao@zte.com.cn (1):
> >        target/riscv: Fix tail handling for vmv.s.x and vfmv.s.f
>
> It looks like this pull request includes quite a number of patches which
> are qemu-stable material, some small and/or unimportant, some more
> visible.  Examples:
>
>   target/riscv: Fix medeleg[11] read-only zero bit for M-mode ECALL
>   target/riscv: Update the local interrupt mask
>
> but knowing nothing about riscv, I don't have expertise to choose which
> of them to pick up.  Should we pick sometihng to currently active stable
> branches, which are 10.0 (lts), 10.2 and 11.0?

Yeah, we should. Again I forgot to go through them and CC stable.

These commits should be backported to any branches they apply to (if
they don't apply don't worry):

53cc9747ed target/riscv/csr.c: fix read of pmpaddr(0-63) CSRs (by
Daniel Henrique Barboza 12 days ago)
8158a74f0a target/riscv: clear mseccfg on reset for all dependent
extensions (by Zishun Yi 2 weeks ago)
27f9566dcd target/riscv: Update the local interrupt mask (by Alistair
Francis 13 days ago)
eccb1d6940 target/riscv: Add mseccfg to VMStateDescription (by Zishun
Yi 2 weeks ago)
612f22c19d target/riscv/pmp: Fix integer overflow in TOR and NA4
address computation (by Zishun Yi 2 weeks ago)
a0946caf1d target/riscv: Fix medeleg[11] read-only zero bit for M-mode
ECALL (by Abhigyan Kumar 4 weeks ago)
e07077a766 hw/char: Check interrupt after txctrl register is written
(by Frank Chang 13 days ago)
caf3bef5f0 target/riscv: rvv: Handle source overlap of vector widening
reduction instructions (by Anton Blanchard 6 weeks ago)
2494836232 target/riscv: Allow mseccfg access based on ext_zicfilp (by
Zishun Yi 2 weeks ago)
613bb1949f target/riscv: Update MISA.X for non-standard extensions (by
Frank Chang 5 weeks ago)
f0433a8bc4 target/riscv: Update MISA.C for Zc* extensions (by Frank
Chang 5 weeks ago)

Plus the ones that already CC qemu-stable.

Alistair

>
> Thanks,
>
> /mjt

