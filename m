Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BF5CD6E55
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 01:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUELO-0004bJ-FH; Mon, 01 Jun 2026 21:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUELJ-0004aO-Pz
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 21:54:58 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUELI-0005qy-5o
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 21:54:57 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bec354815b9so190034766b.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 18:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780365294; cv=none;
 d=google.com; s=arc-20240605;
 b=VBHjocZRu2I0P9P1JNo+JehFXJFicx2QbSostzcXutXSQfGd0s4l8uhj3cXIMZiSkN
 TTbecl8HuMja033UX2mnGs1iAHPe1sMlfpqIXkUVDg7FSpHOmqvGkCX92nTFLbsQrl3J
 caKK+tHpmRpuQRzaCnkSljmREaOxC9zd6xXqTCsqa17z8ffTh79jBEZFtKQE+LG19qMs
 T0TUWnGI+U1kS7p9T7hdojg+BD1nTmAXGx/zuzr0EKcZGCHi1b0E/jjEvmNtATl320L0
 dF6I83WNUqBH61LAjIfH+p3NA9KivUJEhR/T8BA5V/4mTrMGdEJAHXHKOUq6aIBKaUIv
 4iNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GsT/zJJT04FSJ3qQSZawD94yLTY70A7Cy3wojYqgmWA=;
 fh=oXbwLIQ6D7eZBIAfdMwTNx3JbGXBw4Kr6QcethzQnTk=;
 b=UEi+825WAyV1SMYhQljpLznpaB5ZZG2v0GL9LxuhfGRjGtP25eRuXWAb3hmN31Y+o8
 qxOXrgwkQhtHeCmjMS+7HEPGIUqCPHHubSM/2raTSxHK1VSGPJLhntPDYGgsIGK6CSFm
 zQX5S2Ioc7/rlo3Q27sfJ9X98Ni02Pc9zqj6xtO7V5OhVkudZ/wFXhLrNVUeAiF1f5eO
 VFjkQdf+7qdjA+7vv0I/H+3b3WmBp5g0/eLpCjlJiShRqiqeJkXgRnsT5hNomFfu7m+H
 oQ1WzFe3T/1Nmrn9F5TMdMkZIyoD2GmbcrKoDoB2KjiWSHJjF9b91O8hG8F86IRXTKor
 AQFA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780365294; x=1780970094; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GsT/zJJT04FSJ3qQSZawD94yLTY70A7Cy3wojYqgmWA=;
 b=cy4G1/feU6NQ+T+1tafOmhQMoB+O0eEMdXE9mN62LslQgn45mADvIzc1aH6Wnav/Jz
 GCKvKXb4kLl6m+PzA+T3X618j/u3UdUydjqWJJHqwyhhfEWGkX7TMMhJtf7ZjEsD9l6Q
 myaCN5b807VZjp4G5pp4bXMnuYZEwfHO/r8n6HYpai05Y/pW1C9RBuv4SPfz8ToJJZ5e
 l0cul748R/w/hDdyDOf0S/liGyzuo7SqlK/k/16oEIsWQ2BWYETA6f5GdkFFzEQP29iY
 sOEqDnYmxaAjI37UB5o50SsqdEzCBiWjmUmeQSMHh4ofQLZdSX6X2vkJQuTfSqmX9T6x
 7eHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780365294; x=1780970094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GsT/zJJT04FSJ3qQSZawD94yLTY70A7Cy3wojYqgmWA=;
 b=c1JYcr9bLpfTW0eG10nMcePtYWJpQmvOwqfjU9/fzI5tJpYda874frg8oOB8Xg6BbI
 AaA5pyJmPUmCMp1qI/TCmChbESCxaI6JoFevmNXDKSnBn/ke9itM3la04HJd9kf4gdN6
 1lxltRJWY6Rzusd+C6LDb4UieTOs7zMfw1X5oGmaxKcdfc4J78ld9BWkwFE73ESKv4Yz
 ExouoiKB0VOfUzom6SBAdK5Okvok9fipbbeH3jaB/xbJ7ys21QWpWHiFvdxDmMUp6xMz
 yhI+SuMVZvl8HYlJXBRZM+IL0WumDpe0Ee5XlpMQ7AHCmth+vcEmGoT8IfFom6OtWG5e
 zOWg==
X-Gm-Message-State: AOJu0YzFaoV6SSQvJOHM9K1ahpr4b9Bkr2KwPFz3dMaWWa+I/s2zvKWs
 vq0EU9eRzMpVXCpgPo85nE7O5QWNs8Kcie2cOVbz04RgAEEQPHdNMkJRSUDqjY1vfsVmUSep0I5
 MyPQKJY2WK0abTiv7Rj3EyQZQIZmPPAA=
X-Gm-Gg: Acq92OGLl/l+WKMNDfAt+2wG0Ma5XnyF9t6kw5fv8Af1gHPHSlaDF4h/LFmI3L4HUC6
 0MhUXB52hVNwxcS7jROKqJP001YSTgiPEQWCDHLFX4LNaRJlMMFkYzR9ZyUBsOpKaoISGtI2ao+
 00lJhJHuecL5Fx0Kee5uGjHgLTXDzDAuEegNLtOZmr3REz7sUvk3jXmM2rHCRP3Stb0f1LZ5rEg
 Vi3+wgm9TrG/qbdF1UKXZ516WrMgKb8mDnYHwW5TpIIMtRWkZIssPoRCsTLOPntQHL8SAPgGjuh
 VtWn+Jd2EOsbLFlgbaz6Z1l2gDZwNgnVE6y0y2R3gi3RyY+l
X-Received: by 2002:a17:907:1c8f:b0:bc2:70ca:c41e with SMTP id
 a640c23a62f3a-beab6bc5386mr740979066b.25.1780365293292; Mon, 01 Jun 2026
 18:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260527201348.29511-1-philmd@linaro.org>
In-Reply-To: <20260527201348.29511-1-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 2 Jun 2026 11:54:26 +1000
X-Gm-Features: AVHnY4KdbUpeQHRHHIagqkU6Omh4yKouC1cZ9AO-wzbepkcWIap8pGwqvr3Ubb4
Message-ID: <CAKmqyKMt8GEzXTyVGnTvr4zOkkpS8S3Bep3QD4KFzy1FEH_6eA@mail.gmail.com>
Subject: Re: [PATCH v11 00/12] Add RISC-V big-endian target support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-riscv@nongnu.org, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
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

On Thu, May 28, 2026 at 6:14=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> v11:
> - rewrite some patches while reviewing for mainstream integration
>
> v10 cover from Djordje:
>
> Hi all,
>
> This series adds big-endian data support for RISC-V system emulation.
>
> Following the discussion on previous versions, this series models
> fixed-endian harts, not a mixed-endian implementation where software can
> toggle MBE/SBE/UBE at runtime. The reset value of MBE/SBE/UBE is selected
> from the CPU configuration. These bits remain outside the
> mstatus/mstatush/sstatus writable masks, so they are effectively hardwire=
d
> to 0 for the default little-endian CPUs and to 1 when `big-endian=3Don`.
>
> The user-visible `big-endian` CPU property is exposed only after the data
> path, boot path, and page-table walk support are in place, so the series
> remains bisectable.
>
> Djordje Todorovic (6):
>   target/riscv: Implement runtime data endianness via MSTATUS bits
>   target/riscv: Fix page table walk endianness for big-endian harts
>   target/riscv: Add big-endian CPU configuration field and reset logic
>   hw/riscv/boot: Honour data endianness
>   target/riscv: Expose and document the CPU 'big-endian' property
>   tests/functional: Add RISC-V endianness test
>
> Philippe Mathieu-Daud=C3=A9 (6):
>   target/riscv: Initialize DisasContext::mo_endian once
>   target/riscv: Assert PTE.N/PBMT bits are not expected on RV32
>   target/riscv: De-indent some code in get_physical_address()
>   target/riscv: Remove target_ulong use in get_physical_address()
>   hw/riscv/boot: Rewrite setup_rom_reset_vec() using load/store API
>   hw/riscv/boot: Replace cpu_to_le32() -> const_le32()

Thanks!

Applied to riscv-to-apply.next with patch 3 dropped

Alistair

>
>  docs/system/target-riscv.rst                  | 29 ++++++
>  target/riscv/cpu.h                            |  1 +
>  target/riscv/internals.h                      | 29 ++++--
>  target/riscv/cpu_cfg_fields.h.inc             |  1 +
>  hw/riscv/boot.c                               | 93 ++++++++++---------
>  target/riscv/cpu.c                            | 15 ++-
>  target/riscv/cpu_helper.c                     | 44 +++++----
>  target/riscv/tcg/tcg-cpu.c                    |  2 +
>  target/riscv/translate.c                      | 22 ++---
>  target/riscv/insn_trans/trans_rva.c.inc       |  4 +-
>  target/riscv/insn_trans/trans_rvd.c.inc       |  4 +-
>  target/riscv/insn_trans/trans_rvf.c.inc       |  4 +-
>  target/riscv/insn_trans/trans_rvi.c.inc       |  8 +-
>  target/riscv/insn_trans/trans_rvzacas.c.inc   |  4 +-
>  target/riscv/insn_trans/trans_rvzalasr.c.inc  |  4 +-
>  target/riscv/insn_trans/trans_rvzce.c.inc     |  4 +-
>  target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 +-
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 +-
>  target/riscv/insn_trans/trans_xmips.c.inc     |  8 +-
>  target/riscv/insn_trans/trans_xthead.c.inc    | 16 ++--
>  target/riscv/insn_trans/trans_zilsd.c.inc     |  4 +-
>  tests/functional/riscv64/meson.build          |  1 +
>  tests/functional/riscv64/test_endianness.py   | 57 ++++++++++++
>  23 files changed, 240 insertions(+), 122 deletions(-)
>  create mode 100644 tests/functional/riscv64/test_endianness.py
>
> --
> 2.53.0
>
>

