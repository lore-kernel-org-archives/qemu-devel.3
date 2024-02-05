Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BC8C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 04:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWqAH-0007iy-AG; Sun, 04 Feb 2024 23:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWqAF-0007iV-9T; Sun, 04 Feb 2024 23:00:59 -0500
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWqAD-0008FB-PV; Sun, 04 Feb 2024 23:00:59 -0500
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-46cf02b9f7eso1095166137.3; 
 Sun, 04 Feb 2024 20:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707105656; x=1707710456; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X/suwuPwGd1g2S3DzQvBhl3fxFObD+zlMA46G79mvjc=;
 b=k49OmPlN1TBWKtxjmpndZbYYbjXWJNpBZLZ3/qZ/2mY9u+okKDADAVpH/7jumPoURY
 8HioOi1Wt1F3upmkheqdhh3ACAkYOvdZ8/m2nemiGzJLv7v5/JLXa0KfsxXl6FC9aARK
 LChpQeD5daik0pt/G56mXzClNchlMsXX9wxVC+OqZcNmzVUcwR/VbYa0JR9rvGCWHdDr
 ua/hpA55Nea6QZuViYappZvqQpbxGVYf9SVuFDXBHM/rczvR4YQrfDDhgKIUZBviEVkx
 kpUtI8nyGzqJe6p1rE2XPWvtzXVdFHZAUg/PU8ceivu8ETKmrizPp44n5uDMD4rQz1Kx
 i29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707105656; x=1707710456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X/suwuPwGd1g2S3DzQvBhl3fxFObD+zlMA46G79mvjc=;
 b=UaB0NEydh0YvJy9VW6rMvpU46lqu4msRQl59HygTO3vQ2+9Our+pJ+EcQmahtmNGbW
 VtZ/HnVI1EuGuujarnL59lDtNOKtkL4VRBVldSsSBM5tb1EO1UIAOW06zcGeeyUSvdwm
 D1p0EzozWN1WSSneGDrIviEKxcElKTrhrjQxSyMD2fJeffDHILZl0s3d38DUB5/ftEDU
 3nfTXUKPd7XiIyGZa6gCkGn3xa4yxwxKF6nse4JlzkHiKcit3hFKYVuZQToQesbmAZG1
 85JB7gPAkwghiQYEwXxPPkVZ/LW2LRGbB0KXGgEYiwiQFzA4/KLLqhtMlucuFvQylnwF
 /93w==
X-Gm-Message-State: AOJu0YxvA1if8yqmlf1Jbt/Wpyt45HQbmrpQgbND2Soy4Npe5kIvA2LM
 PAP0xRdICaWwed9w+aIDLGwLKVkBRbHgxSXDRRP1PS7mA1zSDE9akRg2d9KB5WuN9PmDIhqJOEM
 +6CIbT+6teIrCFAUP2R4kv9/x+UI=
X-Google-Smtp-Source: AGHT+IHW1R03u4qz0UG94fF8u5TAJywQNykGUUI0cZRF1YA5X2BHy5pIdRy08DVDvguhZAb/saLLUyBWk3C9lRem95M=
X-Received: by 2002:a05:6102:3128:b0:46d:284c:16ee with SMTP id
 f8-20020a056102312800b0046d284c16eemr1310255vsh.18.1707105656387; Sun, 04 Feb
 2024 20:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20240124-squatting-getup-a16a8499ad73@spud>
In-Reply-To: <20240124-squatting-getup-a16a8499ad73@spud>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 14:00:30 +1000
Message-ID: <CAKmqyKO6q1+Tr2wahFMCHjZ4bX1fmsLSw1WdzpLqcwjVu1o=ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] riscv: support new isa extension detection
 devicetree properties
To: Conor Dooley <conor@kernel.org>
Cc: qemu-riscv@nongnu.org, Conor Dooley <conor.dooley@microchip.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
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

On Wed, Jan 24, 2024 at 10:57=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Making it a series to keep the standalone change to riscv_isa_string()
> that Drew reported separate.
>
> Changes in v4:
> - Other than a rebase, add a helper for the mxl_max to xlen conversion
>
> Changes in v3:
> - g_free() isa_extensions too
> - use misa_mxl_max rather than the compile target for the base isa
> - add a new patch changing riscv_isa_string() to do the same
> - drop a null check that cannot be null
> - rebased on top of Alistair's next branch
>
> Changes in v2:
> - use g_strdup() for multiletter extension string copying
> - wrap stuff in #ifndef to prevent breaking the user mode build
> - rename riscv_isa_set_props() -> riscv_isa_write_fdt()
>
> CC: Alistair Francis <Alistair.Francis@wdc.com>
> CC: Bin Meng <bin.meng@windriver.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Weiwei Li <liwei1518@gmail.com>
> CC: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> CC: Andrew Jones <ajones@ventanamicro.com>
> CC: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> CC: qemu-riscv@nongnu.org
> CC: qemu-devel@nongnu.org
>
> Conor Dooley (2):
>   target/riscv: use misa_mxl_max to populate isa string rather than
>     TARGET_LONG_BITS
>   target/riscv: support new isa extension detection devicetree
>     properties

Thanks!

Applied to riscv-to-apply.next with some manual rebasing

Alistair

>
>  hw/riscv/sifive_u.c    |  7 ++---
>  hw/riscv/spike.c       |  6 ++--
>  hw/riscv/virt.c        |  6 ++--
>  target/riscv/cpu.c     | 62 +++++++++++++++++++++++++++++++++++++++++-
>  target/riscv/cpu.h     |  2 ++
>  target/riscv/gdbstub.c |  2 +-
>  6 files changed, 70 insertions(+), 15 deletions(-)
>
> --
> 2.43.0
>
>

