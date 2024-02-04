Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F77C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 23:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWm8q-000093-EI; Sun, 04 Feb 2024 18:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWm8n-00008Y-29; Sun, 04 Feb 2024 18:43:13 -0500
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWm8k-0004wC-On; Sun, 04 Feb 2024 18:43:12 -0500
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe5844so1619803241.0; 
 Sun, 04 Feb 2024 15:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707090187; x=1707694987; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0QCIMKSpSZbJRdMFqQA6BD69SxK1FJPtGRGuU6qLMHA=;
 b=iOdRsMuA97VHtu1tTvOrT6aOOOw5mvV60MH7sVx6MQ3zGmywAP0IA5TlZFFtADOdgj
 yt6LpaKa/7FlHCsPy8u5jkhRTI8gNmiB3+k0A5EfrctGKHAxSqobj5j8XvHXkgyB5sz3
 +zOw2N+15W2NnUrmPcz5Y2YFDsY3ad0cgVDq9Ok2E2LMhwnEwu0DPcK3l35YNFUzhfBc
 8PoV0eCYh+VWC3OYqKWsdkUuVL+XZ/YyU4fwmTSzJx/T0mi470ZDpgyyJWbxxuW+9gKf
 Jg1NMt3Cp87L3zJrqCKH2+dIEnTuV9+nw8U4pCOFeJ3mNXU4YedLYSUgxbfFERKh5KCY
 XfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707090187; x=1707694987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0QCIMKSpSZbJRdMFqQA6BD69SxK1FJPtGRGuU6qLMHA=;
 b=DdTiTmKl4ZakPAOZchno/oEr0A5P/dLzOs8MRIsp28+Kb6TZzVjD1CLbvI0bqFTLFr
 1Vf607pqwaEMv5bSB+yHEdZ9oPg8boZuZaQ4NWZdokiHYXaOvSF/QJ6Zsjf15iHIiN62
 Pd/h7Wm4TkSvrvjp5cWcwLUWyPzbRHfOtG2RJShVzy1zEKNamHxab/8glbFVebvRBmHN
 LpNmVBGcrW5sDYa0yeBuZTMLONIjUDKOuFKnr5M7kxb8dS6ogB5HSpD7FoZXByiMaBHn
 xAxcDpmFAxm0qcw/Mdq/1vhiD7XWDBILLp4Cs2C82nlaPOdfWqjE5mQbUPbZ7f87/lK7
 r4Og==
X-Gm-Message-State: AOJu0YydpJN/wFraWYHJNR6lyj37dp3acorUjTQgiALTq8MqXKMTPz7I
 U8gfD+PG31g2WW1cSNO0AO5OR6OkIbPTce3ulAy3cibIiSyOGplnOryQH/DzCzJj+eCpFKg6T/V
 ZY/uaQJR7rIDiERnhS1/ptUbUvZw=
X-Google-Smtp-Source: AGHT+IH8Vntj7QoeBjjWd08aqAxkydYea8JxkF/DJ1iqCUG/KmrRpKS0hMCOzmZisrZUC91VzoBHdIF5EKmcN0FJ17s=
X-Received: by 2002:a05:6102:3975:b0:46d:2d23:f500 with SMTP id
 ho21-20020a056102397500b0046d2d23f500mr759395vsb.18.1707090187633; Sun, 04
 Feb 2024 15:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20240203-riscv-v11-0-a23f4848a628@daynix.com>
In-Reply-To: <20240203-riscv-v11-0-a23f4848a628@daynix.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 09:42:41 +1000
Message-ID: <CAKmqyKNTcAyZVmCOVLryZg6Q5fZEpFwQBjiMypJVmn5RSVC6kQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/3] gdbstub and TCG plugin improvements
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov <a.anenkov@yadro.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Andrew Jones <ajones@ventanamicro.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Feb 3, 2024 at 8:12=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> This series extracts fixes and refactorings that can be applied
> independently from "[PATCH v9 00/23] plugins: Allow to read registers".
>
> The patch "target/riscv: Move MISA limits to class" was replaced with
> patch "target/riscv: Move misa_mxl_max to class" since I found instances
> may have different misa_ext_mask.
>
> V6 -> V7:
>   Rebased.
>
> V5 -> V6:
>   Added patch "default-configs: Add TARGET_XML_FILES definition".
>   Rebased.
>
> V4 -> V5:
>   Added patch "hw/riscv: Use misa_mxl instead of misa_mxl_max".
>
> V3 -> V4:
>   Added patch "gdbstub: Check if gdb_regs is NULL".
>
> V2 -> V3:
>   Restored patch sets from the previous version.
>   Rebased to commit 800485762e6564e04e2ab315132d477069562d91.
>
> V1 -> V2:
>   Added patch "target/riscv: Do not allow MXL_RV32 for TARGET_RISCV64".
>   Added patch "target/riscv: Initialize gdb_core_xml_file only once".
>   Dropped patch "target/riscv: Remove misa_mxl validation".
>   Dropped patch "target/riscv: Move misa_mxl_max to class".
>   Dropped patch "target/riscv: Validate misa_mxl_max only once".
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v11:
> - Rebased on: https://github.com/alistair23/qemu/tree/riscv-to-apply.next
> - Link to v10: https://lore.kernel.org/r/20240128-riscv-v10-0-fdbe593976e=
9@daynix.com
>
> Changes in v10:
> - Dropped patch "hw/riscv: Use misa_mxl instead of misa_mxl_max" due to
>   invalid assumption that the relevant code is only used for kernel
>   loading.
> - Link to v9: https://lore.kernel.org/r/20240115-riscv-v9-0-ff171e1aedc8@=
daynix.com
>
> Changes in v9:
> - Rebased to commit 977542ded7e6b28d2bc077bcda24568c716e393c.
> - Link to v8: https://lore.kernel.org/r/20231218-riscv-v8-0-c9bf2b1582d7@=
daynix.com
>
> Changes in v8:
> - Added a more detailed explanation for patch "hw/riscv: Use misa_mxl
>   instead of misa_mxl_max". (Alistair Francis)
> - Link to v7: https://lore.kernel.org/r/20231213-riscv-v7-0-a760156a337f@=
daynix.com
>
> ---
> Akihiko Odaki (3):
>       target/riscv: Remove misa_mxl validation
>       target/riscv: Move misa_mxl_max to class
>       target/riscv: Validate misa_mxl_max only once

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.h         |   4 +-
>  hw/riscv/boot.c            |   3 +-
>  target/riscv/cpu.c         | 181 ++++++++++++++++++++++++++-------------=
------
>  target/riscv/gdbstub.c     |  12 ++-
>  target/riscv/kvm/kvm-cpu.c |  10 +--
>  target/riscv/machine.c     |   7 +-
>  target/riscv/tcg/tcg-cpu.c |  44 ++---------
>  target/riscv/translate.c   |   3 +-
>  8 files changed, 133 insertions(+), 131 deletions(-)
> ---
> base-commit: 0c9d286cf791cdda76fd57e4562e2cb18d4a79e2
> change-id: 20231213-riscv-fcc9640986cf
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>

