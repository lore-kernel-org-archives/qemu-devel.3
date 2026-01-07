Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65AECF6C00
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 08:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdOzo-00074m-LK; Wed, 07 Jan 2026 03:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vdOzY-0006xH-Tn
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:34:12 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vdOzW-00069u-6X
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:34:07 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2a0bae9aca3so15664425ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 00:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767774844; x=1768379644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:subject:references:cc:to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0xgSkW7zAYPC0TMQuey7eG15gPMS2SP/wyH/NzUBck=;
 b=PYKmxf/R3anXSYbMRF+alujat3qCYTh0KsKVYFRA9WLPMavnTCtZvhJBh/AA249q81
 PtW89E4d+pqpCz0ZcBpGw29xZTfeB9LdzniplLESgWdwKQDGGDSvqRMTHJicda26fm7z
 qpZJZyQ/7O7Fyq0fes2NbcQK7fXye05bEoeE2VG5A+eYKqVQhw66vdhWs179dzMGugXM
 w/IJHUv2svJmX4xcjjKOeiNpJ54UZ18mfXGEDtyDgxu3OKG4B0tLOTG96O4b+W8XYyM1
 HP+gm91WQ7eHax+PK4mv8qopE6/F6QD5XnBbGZmFBywQgyuCM3kNhZFbc8XhgGaCO3RA
 i7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767774844; x=1768379644;
 h=content-transfer-encoding:in-reply-to:from:subject:references:cc:to
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L0xgSkW7zAYPC0TMQuey7eG15gPMS2SP/wyH/NzUBck=;
 b=sBPv6wJWoyZfV6j3beb/0im89pglVFeOlqvSsP0Q3rHO5yZdlXZKphDRA8t6lk/YAm
 DelxydAxDR/a6+luGQlUcr3Qr+jWu91RYt3X4ip1WYKmqeJa8kxKVFkfU3MFSu+QqjME
 +AOxAo/pMMrufVpzy8HVhA1rDr7sVi25jO4BFceq3Coea+Jt9mwfbpYmsDXhmIj0GyeA
 yZN16eC/4pDja+ODlg5iWMWIqEI+UIG5i9bJkebeuX9MvoF5KIl0ZfDzj8IdXb8YNa+0
 FDRDDxf9SQFct0IBvYmOzd7sw8UlvAv7ChEZ/ubSoXGYd/XoaTEITVOTT+bVvIETk7HV
 r+Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJFGX6S8mG+4eLXfeNGd/QMGb/aKmID/tGiLotG/taTjAIzzoSjfdW4AuyZ9Umt6EfHWPXhdICxQFJ@nongnu.org
X-Gm-Message-State: AOJu0YwQ2/ahfKk4MxaUpXZuYMST27eBeHE//0eLey0/9hyJJ9vWZseC
 Ml8zFzlMSmHFlswdZ9GkpU6no9hH1Z59hgEHtRz2y4d8uyHHhmGCnrM/
X-Gm-Gg: AY/fxX6anz/o4BZWi6OykIuvdYZlwX4bazmGkDYu0HGdVroZmI4VbVAndRokEYezZ1x
 fsZcE+eSY4Mwphy+yLIfoW+UED0hluEhbrplxPbESfJNECwI7BDLc3Krc1h+XSZU4DRMqu8cWa/
 cOpAcsAAP3Bwe4ULL1MoyKFbfMKyJgKXtKOiFcfnzhCApp+y8CJEdwjLwfS8g+peizK8gtJotY+
 rDtYZAeyiGQ3ox9oTN8W+QGwUFpX3L9xUvZ1uMtivURBlPRyMMkBM2+gIxKRjtLhoDWF1ECJXQT
 lTbtRBGSXbGRPQBUxTygKv+azSVdG3UAraFc32YGQ8/WVELC9hdMSxvVXxmxUJ0tlkN6yief32y
 KMNYJq9TyC92Ao7HkWHXeMH1RQndNuOMKYJ+joZV8cN50gKvibS6oPdmOZdHHLeug1C3MqiKbRy
 Rg6yVyPTlIxDm74yDEJYevTHy0ij97Y1eo6CZerA==
X-Google-Smtp-Source: AGHT+IGKQmRA6mS20fQTbQQ+uRhClSpP5LflFBZfRPc6gKFS/amp+2zaS/tctB+hGSHlH2WdN6LY6A==
X-Received: by 2002:a17:903:2291:b0:2a0:bb3b:4193 with SMTP id
 d9443c01a7336-2a3ee4da0f3mr18142085ad.40.1767774843723; 
 Wed, 07 Jan 2026 00:34:03 -0800 (PST)
Received: from [127.0.0.1] ([218.81.29.112]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cc78c0sm43841215ad.69.2026.01.07.00.33.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 00:34:03 -0800 (PST)
Message-ID: <3593f6cc-3b71-44e6-bb64-5109cb431ff6@gmail.com>
Date: Wed, 7 Jan 2026 16:33:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: philmd@linaro.org, alistair.francis@wdc.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, palmer@dabbelt.com, pbonzini@redhat.com,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com
Cc: 1440332527@qq.com, 3160104094@zju.edu.cn,
 hust-os-kernel-patches@googlegroups.com, liwei1518@gmail.com, me@ziyao.cc,
 temashking@foxmail.com
References: <cover.1765816341.git.chao.liu.zevorn@gmail.com>
Subject: Re: [RESEND PATCH v3 0/5] Add K230 board and thead-c908 CPU support
From: Chao Liu <chao.liu.zevorn@gmail.com>
In-Reply-To: <cover.1765816341.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi, all

Gentle ping. :)

On Tue, 16 Dec 2025 01:01:13 +0800 Chao Liu wrote:
> Hi,
>
> I have updated my email address to chao.liu.zevorn@gmail.com to avoid email
> delivery failures.
>
> This patch series adds support for U-Boot + OpenSBI + standard Linux kernel on
> K230 board. Thanks to Peng Jiang, Mig Yang, Renzao Ren, Yao Zi for their help.
>
> Test command:
>
> ```
> $QEMU -M k230 -bios [OpenSBI binary] -m 2G -dtb k230_canmv.dtb -kernel [img]
> ```
>
> PATCH v3 changelog:
> - Patch 1: Align T-Head C908 CPU's RISC-V extension with XUANTIE-QEMU
> - Patch 2: Adjust PLIC and CLINT addresses to match K230 datasheet
>
> PATCH v2 changelog:
> - Patch 1: Add Svpbmt extension support for the T-Head C908 CPU
> - Patch 2: Move the k230.rst definition from MAINTAINERS to Patch 5
> - Patch 5: Apply Daniel's bugfix to build the k230 documentation successfully
> https://lore.kernel.org/qemu-devel/cover.1764830405.git.chao.liu@zevorn.cn/
>
> PATCH v1 changelog:
> - Patch1: Add T-Head C908 and C908v CPU support
> - Patch2: Add K230 board initial support(big core is not supported yet)
> - Patch3: Add Programmable Watchdog Timer (WDT) peripheral support
> - Patch4: Add QEMU test for K230 watchdog
> - Patch5: Add documentation for K230 machine
> https://lore.kernel.org/qemu-devel/cover.1764493931.git.chao.liu@zevorn.cn/T/
>
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
>
>  MAINTAINERS                    |  12 +-
>  docs/system/riscv/k230.rst     |  48 ++++
>  docs/system/target-riscv.rst   |   1 +
>  hw/riscv/Kconfig               |  11 +
>  hw/riscv/k230.c                | 501 +++++++++++++++++++++++++++++++++
>  hw/riscv/meson.build           |   2 +-
>  hw/watchdog/Kconfig            |   4 +
>  hw/watchdog/k230_wdt.c         | 307 ++++++++++++++++++++
>  hw/watchdog/meson.build        |   1 +
>  hw/watchdog/trace-events       |   9 +
>  include/hw/riscv/k230.h        | 153 ++++++++++
>  include/hw/watchdog/k230_wdt.h | 130 +++++++++
>  target/riscv/cpu-qom.h         |   2 +
>  target/riscv/cpu.c             |  51 ++++
>  target/riscv/th_csr.c          | 380 ++++++++++++++++++++++++-
>  tests/qtest/k230-wdt-test.c    | 199 +++++++++++++
>  tests/qtest/meson.build        |   3 +-
>  17 files changed, 1810 insertions(+), 4 deletions(-)
>  create mode 100644 docs/system/riscv/k230.rst
>  create mode 100644 hw/riscv/k230.c
>  create mode 100644 hw/watchdog/k230_wdt.c
>  create mode 100644 include/hw/riscv/k230.h
>  create mode 100644 include/hw/watchdog/k230_wdt.h
>  create mode 100644 tests/qtest/k230-wdt-test.c
>
> --
> 2.51.0
>

Thanks,
Chao

