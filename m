Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C253DC83F34
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Jul 2025 12:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ud6vb-0005Ow-Rp; Sat, 19 Jul 2025 08:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hydrabmgo298@gmail.com>)
 id 1ud3HH-0005b4-OF
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 04:50:44 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hydrabmgo298@gmail.com>)
 id 1ud3HF-00015R-Tr
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 04:50:43 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-32b3a3a8201so24959901fa.0
 for <qemu-devel@nongnu.org>; Sat, 19 Jul 2025 01:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752915038; x=1753519838; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xsyk87tJkzYKLLnEWNiONzSVcWqzgRlDH7QAvlUWPac=;
 b=MluTPtnlR1PFuLSw4SJG+kTDxt+/W8tw8L3FWl3GezntExqDp2tVHhb7JRhRJz2BLo
 HXc6SlpICZ1SPWhx70p5rpeoTvvGcgPX7qEG4XPUAjYs3JEAg9CucvCE8W2vRcaC8Ddb
 CCNK/bb/xgB4ebefj3yrGt5M5BcN+kxPZ9lQgasSC8pDXtXxlZE5KRZGDLL4OxZ2NPdY
 nLPTts3eKsV0VU0miobQ1IyeHKH3fljMgpu+dARY8jjQEbVD0s9c+rYP4LGPekfRKcck
 KTOxcA+kCh9FG16KSK033tnWy1CLIJtHmsTiVTpkAOIDqcSZDYd/nuH9FmktCKEWo/zM
 RZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752915038; x=1753519838;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xsyk87tJkzYKLLnEWNiONzSVcWqzgRlDH7QAvlUWPac=;
 b=fHUTi4YoKURQtc5Ni0EJ5N179sAeW6CCCPfnAoBamAEuCR+3bpfP3jg8+g7fgjXk6V
 syRgZhnYyLre00tp9wOT9XPoRihgYrUpyPD4vherzFB3jzTcerC5LGxWo/8eimjdyxlk
 rd/q6F7voopv3vY7XZz8WHAw2Utq6Trv+2+Igb6+tSo2F+7+IPBWWk2JtWpyacwm9U8B
 htZBkZwMhvdTRYbhJJ4G2qGljQlNIeTSt5Q4h7NzxnhblzPorodlT1IJ3RSWzTvXyjSz
 aO7a+5Ct9YgWkkG8BOPwZ7Yu732FMhz7n7aPigo872cqdKosO5EZYfE9jQV3Z23s1c3/
 TFKQ==
X-Gm-Message-State: AOJu0YxElM07vMKKIswqYIxG8IrONZ1DDsfyA1LS/Fw9D/5ON5Mj01+U
 m9TxQSRRoHX0exUxl53VHCX4JQ7eEkKOVLwOmcVkv3vfJGGm+EocxyxcP459lhzhd0DMFrQCsmE
 lhHk802qBsZDGgKIQ0eIw8nFVIQdqHZNxVY8a+J4=
X-Gm-Gg: ASbGncuM/mkH1MkmBX1UxrX3sqWNHqUB/oxopL3FZ/7Gg+aF9hR7IK/z6eQCOSjcy4E
 1wFjdV75CxHhqiaIE1OZqukuiKAzCQEnkoXZY6J45/yXbCvORqn/tXbIi5pW5VzwHJ+fSoLy2oa
 t74OPLkguDhCgTnrzjcIpxYlkP3MJXlEuHjNEAN5X238mKbKDpa68Jzma8PFLVltyWYHNKMhaq7
 yhi+fEnl1UUqiNPxhQlWJo6qqufxWN+5pgEFp84
X-Google-Smtp-Source: AGHT+IFZnhs1FcoAtaWwN770wCWnyGHD9Lf2sHTs8/r6iEfKBiJaAGk19lxgxmBwvCtyHdYct3tDIx4vtL7jVKSDuew=
X-Received: by 2002:a05:651c:41cc:b0:32b:82bf:cc55 with SMTP id
 38308e7fff4ca-3308f61c7d1mr28865661fa.31.1752915037458; Sat, 19 Jul 2025
 01:50:37 -0700 (PDT)
MIME-Version: 1.0
From: Hydra <hydrabmgo298@gmail.com>
Date: Sat, 19 Jul 2025 14:20:26 +0530
X-Gm-Features: Ac12FXyZTjbznoDaH4R80lEeGsoMw8cyLlYT1LAdvrlFBOc9Qmk1HjnUXYhPMA0
Message-ID: <CA+OCQm8Dtg+CQw1Na3KvOe7Uhqe19uYV=CuQFj6uggZewTTFyw@mail.gmail.com>
Subject: Galaxy S2 in QEMU
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000002113b6063a4456e5"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=hydrabmgo298@gmail.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 19 Jul 2025 08:43:57 -0400
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

--0000000000002113b6063a4456e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

**Subject:** Add Samsung Galaxy S2 (Exynos 4210) support to QEMU

Hello QEMU developers,

I=E2=80=99m an adult exploring legacy ARM devices and interested in contrib=
uting
toward Samsung Galaxy S2 (GT-i9100) emulation in QEMU.

### Current blockers:
- **No NAND/BML support**: The Galaxy S2 uses bml partitions (e.g.,
`/dev/bml7`, `/dev/bml8`) backed by a proprietary NAND layout.
- **Missing early boot support**: Files like `SBL`, `param.lfs`, and
`modem.bin` are required to initialize TrustZone and modem hardware.
- **No Exynos 4210 SoC NAND controller emulation**: While the CPU
(dual-core Cortex-A9) is supported, NAND-specific peripherals are not.

### What=E2=80=99s already available:
- Boot/recovery images and kernel sources for GT-i9100 (Exynos) and
GT-i9100G (OMAP4430)
- Recovery and initramfs extracted; system image in `factoryfs.img` (ext4
or RFS)
- Some forks attempted partial emulation but didn=E2=80=99t reach bootloade=
r stage

### Goal:
I=E2=80=99d love guidance on whether it=E2=80=99s feasible to add:
- NAND flash controller emulation (Samsung or generic)
- Early-stage bootloader support (even just stubbing out TrustZone/modem)
- A working minimal `-M` machine model (e.g., `-M galaxy-s2` or reuse `-M
nuri`?)

I'm ready to test, contribute logs, and provide images for reproducibility.

Thank you for your time!

=E2=80=93 Hydra

--0000000000002113b6063a4456e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">**Subject:** Add Samsung Galaxy S2 (Exynos 4210) support t=
o QEMU<br><br>Hello QEMU developers,<br><br>I=E2=80=99m an adult exploring =
legacy ARM devices and interested in contributing toward Samsung Galaxy S2 =
(GT-i9100) emulation in QEMU.<br><br>### Current blockers:<br>- **No NAND/B=
ML support**: The Galaxy S2 uses bml partitions (e.g., `/dev/bml7`, `/dev/b=
ml8`) backed by a proprietary NAND layout.<br>- **Missing early boot suppor=
t**: Files like `SBL`, `param.lfs`, and `modem.bin` are required to initial=
ize TrustZone and modem hardware.<br>- **No Exynos 4210 SoC NAND controller=
 emulation**: While the CPU (dual-core Cortex-A9) is supported, NAND-specif=
ic peripherals are not.<br><br>### What=E2=80=99s already available:<br>- B=
oot/recovery images and kernel sources for GT-i9100 (Exynos) and GT-i9100G =
(OMAP4430)<br>- Recovery and initramfs extracted; system image in `factoryf=
s.img` (ext4 or RFS)<br>- Some forks attempted partial emulation but didn=
=E2=80=99t reach bootloader stage<br><br>### Goal:<br>I=E2=80=99d love guid=
ance on whether it=E2=80=99s feasible to add:<br>- NAND flash controller em=
ulation (Samsung or generic)<br>- Early-stage bootloader support (even just=
 stubbing out TrustZone/modem)<br>- A working minimal `-M` machine model (e=
.g., `-M galaxy-s2` or reuse `-M nuri`?)<br><br>I&#39;m ready to test, cont=
ribute logs, and provide images for reproducibility.<br><br>Thank you for y=
our time!<br><br>=E2=80=93 Hydra<br></div>

--0000000000002113b6063a4456e5--

