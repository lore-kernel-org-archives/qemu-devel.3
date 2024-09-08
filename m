Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129C4ECE577
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 23:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snRkn-00049F-4R; Sun, 08 Sep 2024 19:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snRkl-00048l-9n
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 19:55:35 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snRkj-0005QJ-LU
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 19:55:35 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-502b6e2a0acso717915e0c.2
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 16:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725839732; x=1726444532; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09pm0Zwpxm8pIl1GG8Z0cY7g4QQ1XlAb2cIFWsFNrps=;
 b=OHA+Oe5jiZRfOuHla/xpkQC3Mo1OmMXVPtohSpNjlV5zLG2uPULSLcoTtPyKXcyrej
 2ctFlnv9YGevuzEdlvty0MxdvbVho4rIrU4CLhyCuYp/fMugi6wdGb7Zkp/8pNVHsUI1
 oAUyMccSb+syB31RPCx63GgeuudjMuM7EaokWEBnAG3z0k+uMxP7aC/QPafPsUvf5Ykv
 J1zWVmnVJk5IZGllUpGyK8oVIBTtEHD4PLjeBDeQE4kLwjKXcFrptnhJS7HQQR0opx4V
 e6NKE0gvxrANCrimx/u9regNIr/FQDHrhJYvf/uZmJEFX0JdVclhdey4OLJRF9Z6B3AZ
 HahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725839732; x=1726444532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=09pm0Zwpxm8pIl1GG8Z0cY7g4QQ1XlAb2cIFWsFNrps=;
 b=QLbPGG05UZaJfthfwGUSwNZg5N+r48sp86Id38oujZGJ4qNMcLZ9Ds84T8qAI3KSxk
 9E9dBRjJolBgtNE6szogjKdRlWGRi9NhMeuJN/R2yEy49BGrvb+mGVP3d0mQkDJI3N+n
 ZFAiWygvEUS5GJKF3rmEvOFjdvc/EtJPNpwB/m27yZXCihIjJBddXw/nkpcyAoyi8v78
 PZjTbMpweTVSRjb/ERuGIxL7Lxa37OjjjI9lwR7UaGAZyY9yU5fWmwigmJccU1T/wYF6
 VodUu/sO1KenNCW5fco7sJwpFtk4YGFFnJs2LNfZeIzbKCR5OzLA/CBQb/a5nEj0qGGD
 59Kg==
X-Gm-Message-State: AOJu0YxG9VN4Rh6RGdKUMFcGP9OkPI4ujJdgicnPzccAQgiJQD/LHE26
 PAjue/iLiMYozcJ52AdceoqqyoN4caLcfWg/bBkdH6oUmUBS7xsdfF1INgwcYHDV01zUUEW6M5B
 pbZqBILD1RdYj1fUwK0ZGKnqFrz0=
X-Google-Smtp-Source: AGHT+IGq/Fr0V1LUVnGbHjRgGHuP5HCFfHIw7MEu3q6v96IPRuGMtIEG+qh56Rqz+VnWQOo8nMbRQBEAJM418Si83/4=
X-Received: by 2002:a05:6122:4d1a:b0:502:b3a9:f40b with SMTP id
 71dfb90a1353d-502b3a9f4ffmr9419487e0c.7.1725839731488; Sun, 08 Sep 2024
 16:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240907031927.1908-1-itachis@FreeBSD.org>
In-Reply-To: <20240907031927.1908-1-itachis@FreeBSD.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Sep 2024 09:55:05 +1000
Message-ID: <CAKmqyKN7E8jfAdJ9ym2cOTRuUEiNsCVqR+fKEhTB9rPSQP1Yjg@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] bsd-user: Comprehensive RISCV Support
To: Ajeet Singh <itachis6234@gmail.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Mark Corbin <mark@dibsco.co.uk>, Ajeet Singh <itachis@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
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

On Sat, Sep 7, 2024 at 1:25=E2=80=AFPM Ajeet Singh <itachis6234@gmail.com> =
wrote:
>
> Key Changes Compared to Version 4:
> Minor formatting changes
>
> Mark Corbin (15):
>   bsd-user: Implement RISC-V CPU initialization and main loop
>   bsd-user: Add RISC-V CPU execution loop and syscall handling
>   bsd-user: Implement RISC-V CPU register cloning and reset functions
>   bsd-user: Implement RISC-V TLS register setup
>   bsd-user: Add RISC-V ELF definitions and hardware capability detection
>   bsd-user: Define RISC-V register structures and register copying
>   bsd-user: Add RISC-V signal trampoline setup function
>   bsd-user: Implement RISC-V sysarch system call emulation
>   bsd-user: Add RISC-V thread setup and initialization support
>   bsd-user: Define RISC-V VM parameters and helper functions
>   bsd-user: Define RISC-V system call structures and constants
>   bsd-user: Define RISC-V signal handling structures and constants
>   bsd-user: Implement RISC-V signal trampoline setup functions
>   bsd-user: Implement 'get_mcontext' for RISC-V
>   bsd-user: Implement set_mcontext and get_ucontext_sigreturn for RISCV
>
> Warner Losh (2):
>   bsd-user: Add generic RISC-V64 target definitions
>   bsd-user: Add RISC-V 64-bit Target Configuration and Debug XML Files
>
>  bsd-user/riscv/signal.c               | 170 ++++++++++++++++++++++++++
>  bsd-user/riscv/target.h               |  20 +++
>  bsd-user/riscv/target_arch.h          |  27 ++++
>  bsd-user/riscv/target_arch_cpu.c      |  29 +++++
>  bsd-user/riscv/target_arch_cpu.h      | 147 ++++++++++++++++++++++
>  bsd-user/riscv/target_arch_elf.h      |  42 +++++++
>  bsd-user/riscv/target_arch_reg.h      |  88 +++++++++++++
>  bsd-user/riscv/target_arch_signal.h   |  75 ++++++++++++
>  bsd-user/riscv/target_arch_sigtramp.h |  42 +++++++
>  bsd-user/riscv/target_arch_sysarch.h  |  41 +++++++
>  bsd-user/riscv/target_arch_thread.h   |  47 +++++++
>  bsd-user/riscv/target_arch_vmparam.h  |  53 ++++++++
>  bsd-user/riscv/target_syscall.h       |  38 ++++++
>  configs/targets/riscv64-bsd-user.mak  |   4 +
>  14 files changed, 823 insertions(+)
>  create mode 100644 bsd-user/riscv/signal.c
>  create mode 100644 bsd-user/riscv/target.h
>  create mode 100644 bsd-user/riscv/target_arch.h
>  create mode 100644 bsd-user/riscv/target_arch_cpu.c
>  create mode 100644 bsd-user/riscv/target_arch_cpu.h
>  create mode 100644 bsd-user/riscv/target_arch_elf.h
>  create mode 100644 bsd-user/riscv/target_arch_reg.h
>  create mode 100644 bsd-user/riscv/target_arch_signal.h
>  create mode 100644 bsd-user/riscv/target_arch_sigtramp.h
>  create mode 100644 bsd-user/riscv/target_arch_sysarch.h
>  create mode 100644 bsd-user/riscv/target_arch_thread.h
>  create mode 100644 bsd-user/riscv/target_arch_vmparam.h
>  create mode 100644 bsd-user/riscv/target_syscall.h
>  create mode 100644 configs/targets/riscv64-bsd-user.mak

Thanks!

Applied to riscv-to-apply.next

Alistair

>
> --
> 2.34.1
>
>

