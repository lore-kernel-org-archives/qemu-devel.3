Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51ECFCD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 04:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXWs5-0003dx-3R; Thu, 11 Jun 2026 00:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXWs3-0003dg-JI
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 00:18:23 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXWs1-0003jD-EC
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 00:18:23 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-68d232ed3f9so12850039a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 21:18:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781151500; cv=none;
 d=google.com; s=arc-20240605;
 b=DAQPP+FoYTkSbnlrDcEqwzoH3UbQ2s/R9+UBeW/mxsEAsmQ6MmdBTfu6i3MhuQ4UTe
 7n5AbVWQ7kXprKRN8NpxS41qR9lSRLFw0H7nzg3tkCPB7+1zzFosqs//khxYtIVrq207
 xqqBw1OApwc5D7yc+IlzH2/ajIlkWdvouWypljhIK5yAoZSNeV08P43rcqHZ8pL9xKv8
 n6Gpb2Wxl/e/NSSoy457C/cWrLd3NbIQ/rjEovR0zfI6ztM9AXWQwXDUhsgy8XLlXy6v
 R0KHIYtySRvdJg/LNTtCFIn4dBElCykVmjrbf6r+6cn+BXU0Ac3Z+RNm26a/s1w0p+L3
 Do7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wy+S6RRfCW9Ayyv0MaBvn9PEJAH1zd8qYVAPVxJvIqc=;
 fh=zJn2cj61hXzvruI5vklRykcA3fgeTEI3CkNBY5kAk2w=;
 b=hM6aW1c6ookGfaCgqvt+ApWh52FYY2sLorpZuybIrib8BxgENNHelwucGxku3JTQOm
 kMcCtiDBKyH/XTew51kWBxJPCZ3jQio0I7PSfATxIeTdmAuJ/zMBLEzivVARe0yx8KO+
 J2bjuGf//X76Fc7wrv9Whd+By9RSMi2diSGOvWnKCbSuKUyK6B2UtQUFlX1ZtgxXBA6a
 97hLIVWJAagosxX2Q5AZc+uJGd6+Ro8gkpiz0O3rHJORI7Cem8X8Z7MCxbrEpXQmxLdc
 o+SfAYr3wiAVbJGx/Jm7G99PYbWGAfXRAsdgjPH1gGEtUt/zN+QRy6Yf47nOCW70bp6Z
 J8jg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781151500; x=1781756300; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wy+S6RRfCW9Ayyv0MaBvn9PEJAH1zd8qYVAPVxJvIqc=;
 b=HFUx1xYq/0hU3vmarP1e4kuUGTS03gPyJn5h1shQhUbchGxCuSsiXeJ9GpEtcllmGf
 kTE1MECkb/GQmRu/kK2j3hPyTunwBjjLICnqzM/eun78q+2LVq5JAoew+I7UKx6mpWk+
 5T2wEc8Mmao45FuzZGLzXmYCtWMWpWQphAJutEgMDK+DiegcT53jf6oMcCqWS9AR8U8v
 WcA4GksKsvKPDFRudwSmq2twmYHZ0DDF5rj7AphqGRBL6CJTIuw9jDD2uzzhXUcuj9jE
 MKzUSGY6TT53NlU5TlZXneMzS+nqnsGiCUacCnpv515dBWKfr9As6OLKTf86NepEXa3t
 Ekbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781151500; x=1781756300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wy+S6RRfCW9Ayyv0MaBvn9PEJAH1zd8qYVAPVxJvIqc=;
 b=E7f4m9iP4/1HbkX5qmHgXYNvlCGnZt5Xjr5wOR/V5ZTUORP2TlEdpZXYKOqJWRcwSP
 Br/Dm1jO7CDI+zrRkyS432SN8V0JlciXU2swM+sKsEENk6VxtQ28Ud4o+4FvQiNx7UMA
 ANAW8cWxm5lh5IPpb4irFTgEv5hNbi6wCHDuRQPw4jvV3ERdnWkrUTBZZEq7+kK83AiV
 k3NQiZhDmDUE/VnG2bCDi6K4hfRcpJoThu1IJVPfr+L8oudM1J27EFGeXpXnNltqZO0E
 NljzABlCXj6EIkXCK338B5YgzqgPZF7gmji+SiQTq66aJrm4+lcRZler2TaYrgp7Jr/8
 mQog==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FYztd7hWVb/C5CYPJdUCQalVeH42OGQx/CXHq3ljJQMWaHalkC1qI9qkbp1eqxZyMsqKKI8AE0Y7u@nongnu.org
X-Gm-Message-State: AOJu0YzI75uthVB7B8HAD3e3X3KWJH3IS61tetsUYK2OqYr7QnLNQ59A
 FYa60csP+QfpWBIY+uuQ0VwERinFn4cNt0lshCRfaIeDk8BrHaP0yxq9A/Shtsy/5FknWfTJDnk
 ANj+ZZwt3zrIz2jS5OrDnbl+Om5OvSAs=
X-Gm-Gg: Acq92OGs2QkxyS0ToqlM9hxk9yFHuPZLLgh/JROs8Lk0ifiL4o+f5JdKiDR+4TZNhBc
 JBjfVRMyvCcFzl7//dx6lgbnyUVZMO5+Pjwu1QGKmYPSxuHHJVzrs5HE7+ksde5eGI4NxUpmL2M
 6rrmxfQVj7je4Dx42AgVVq/7nZgzS9Gd2bNY718Wx2vSYSf3NBQmxa/tZNMZec1PUMCbLsOmEbd
 PmShGO0zYfjdM3qX3Kl1ehhplEqhPPkTQkSqVxlsg7zOgZJCPaY0iRRXWCzDN+wnU1GMb/8A5F8
 94Wl6eQWealNoNjwb8GBgfHuzX40vh3XXY4psqut4d3TxwoQ
X-Received: by 2002:a05:6402:1d52:b0:691:956a:cf6a with SMTP id
 4fb4d7f45d1cf-6930e28a84bmr409476a12.12.1781151499601; Wed, 10 Jun 2026
 21:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778516731.git.chao.liu.zevorn@gmail.com>
In-Reply-To: <cover.1778516731.git.chao.liu.zevorn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 11 Jun 2026 14:17:53 +1000
X-Gm-Features: AVVi8CcAQajcjNwT7j5gxtDMrfqhYAUoUovU2yeoFkGRStNK6om151TRmZSGtIw
Message-ID: <CAKmqyKMU+hMjaevvKLNve3=wnWJXRGMasy4BThnfZ6o0CizTNA@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Add support for K230 board
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Tue, May 12, 2026 at 2:32=E2=80=AFAM Chao Liu <chao.liu.zevorn@gmail.com=
> wrote:
>
> This patch series adds support for U-Boot + OpenSBI + standard Linux kern=
el on
> K230 board. Thanks to Peng Jiang, Mig Yang, Renzao Ren, Yao Zi for their =
help.
>
> The current patchset fixes some bug and tag errors, Thanks to Alistair an=
d
> Conor for the review.
>
> Test command with the direct Linux boot:
>
> ```
> $QEMU -M k230 \
>       -kernel [Image] \
>       -dtb [k230-qemu.dtb] \
>       -initrd [rootfs.cpio.gz] \
>       -nographic
> ```
>
> The k230-boot-assets repo [1] provides K230 Linux kernel images built wit=
h
> k230-sdk and Yocto.
>
> For more information, see docs/system/riscv/k230.rst.
>
> The GitLab CI result [2] passed all cases.
>
> PATCH v7 changelog:
> - Patchset: Removed invalid tags for patchset.
> - Patchset: Updated the K230 datasheet link in the patchset comment heade=
r.
> - Patch 2: Removed the unnecessary changes to MAINTAINERS.
> - Patch 2: Fixed an Oops caused by accesses to an unimpl UART MMIO addres=
s.
> - Patch 2: Adjusted the K230 machine hart count to 1.
> - Patch 2: Supported direct boot linux with `-kernel`.
> - Patch 3: Aligned the WDT interrupt number with the K230 datasheet.
> - Patch 5: Updated k230.rst Linux boot docs.
>
> PATCH v6 changelog:
> - Patchset: Rebased on the latest Alistair's riscv-to-apply.next branch [=
3].
> - Patch 4: Picked up Fabiano's Acked-by.
>
> PATCH v5 changelog:
> - Patchset: Rebased on Alistair's riscv-to-apply.next branch.
> - Patch 2: Fixed reset vector ROM jump to trap-handler bug.
>
> PATCH v4 changelog:
> - Patchset: Rebased on the latest master branch.
> - Patchset: No functional changes from v3.
>
> PATCH v3 changelog:
> - Patch 1: Align T-Head C908 CPU's RISC-V extension with XUANTIE-QEMU.
> - Patch 2: Adjust PLIC and CLINT addresses to match K230 datasheet.
>
> PATCH v2 changelog:
> - Patch 1: Add Svpbmt extension support for the T-Head C908 CPU.
> - Patch 2: Move the k230.rst definition from MAINTAINERS to Patch 5.
> - Patch 5: Apply Daniel's bugfix to build the k230 documentation successf=
ully.
>
> PATCH v1 changelog:
> - Patch 1: Add T-Head C908 and C908v CPU support.
> - Patch 2: Add K230 board initial support(big core is not supported yet).
> - Patch 3: Add Programmable Watchdog Timer (WDT) peripheral support.
> - Patch 4: Add QEMU test for K230 watchdog.
> - Patch 5: Add documentation for K230 machine.
>
> ---
>
> Link:
> [1] https://github.com/zevorn/k230-boot-assets
> [2] https://gitlab.com/chao23.liu/qemu/-/pipelines/2515556858
> [3] https://github.com/alistair23/qemu/tree/riscv-to-apply.next
>
> Thanks,
> Chao
>
> Chao Liu (5):
>   target/riscv: add thead-c908 cpu support
>   hw/riscv: add k230 board initial support
>   hw/watchdog: add k230 watchdog initial support
>   tests/qtest: add test for K230 watchdog
>   docs/system/riscv: add documentation for k230 machine

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  MAINTAINERS                    |  11 +
>  docs/system/riscv/k230.rst     | 113 +++++++
>  docs/system/target-riscv.rst   |   1 +
>  hw/riscv/Kconfig               |  11 +
>  hw/riscv/k230.c                | 524 +++++++++++++++++++++++++++++++++
>  hw/riscv/meson.build           |   2 +-
>  hw/watchdog/Kconfig            |   4 +
>  hw/watchdog/k230_wdt.c         | 296 +++++++++++++++++++
>  hw/watchdog/meson.build        |   1 +
>  hw/watchdog/trace-events       |   9 +
>  include/hw/riscv/k230.h        | 149 ++++++++++
>  include/hw/watchdog/k230_wdt.h | 121 ++++++++
>  target/riscv/cpu-qom.h         |   2 +
>  target/riscv/cpu.c             |  51 ++++
>  target/riscv/th_csr.c          | 380 +++++++++++++++++++++++-
>  tests/qtest/k230-wdt-test.c    | 189 ++++++++++++
>  tests/qtest/meson.build        |   3 +-
>  17 files changed, 1864 insertions(+), 3 deletions(-)
>  create mode 100644 docs/system/riscv/k230.rst
>  create mode 100644 hw/riscv/k230.c
>  create mode 100644 hw/watchdog/k230_wdt.c
>  create mode 100644 include/hw/riscv/k230.h
>  create mode 100644 include/hw/watchdog/k230_wdt.h
>  create mode 100644 tests/qtest/k230-wdt-test.c
>
>

