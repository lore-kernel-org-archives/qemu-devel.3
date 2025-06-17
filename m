Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55551C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 02:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRMD4-0006v5-K1; Mon, 16 Jun 2025 22:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uRMD2-0006uk-QM; Mon, 16 Jun 2025 22:38:00 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uRMD1-0001HG-4W; Mon, 16 Jun 2025 22:38:00 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4e7f7d0f7baso1982287137.0; 
 Mon, 16 Jun 2025 19:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750127877; x=1750732677; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O6URteAf+pRhF1OQuwj3gK8Bsv5VVcghBrlBh6BG360=;
 b=ZcTV4B/x+BnOxqsaeWe7pANxq5+sdT+gz9Zhza5pmh7y+FXm1EopcUACpDBDy530gi
 UHodrNw6SD2T/XDt3BY+X9w9ffb+QvhnuMEK1y8Kom/4V3VyrgmxcRFJp+VFg5urDLsX
 8lmuYobmF3Nqnc/NbfJnQ6bAJSXYdRoCnvIiS7btMRfse+rZEC1+HKK3q/Xc1BRfi+I1
 c4C+nA/9/dDNbTNd1Yjbo4U0w1iMO41GrYLa3YizcKR7D/C1duk9QQ2bnzo6YbWJH6JL
 vk+qGyIgGBC1aJ2r5NxLEbYJdIGWwGamw6Kgdjmgg7gOxpl+2zR1+WcvTqz5D1c7+rl1
 p5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750127877; x=1750732677;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O6URteAf+pRhF1OQuwj3gK8Bsv5VVcghBrlBh6BG360=;
 b=uu9o9h3CnCpsu0Q3TfeVWsFmty949pZ3dS97z0JyCr+6WU+I2GamPjObzNhOYFrIZ2
 DQ0RAODMQ2fxO40xpGBxxCoupx0PCcUaws8Sjz7dKTjdCJBBTf/LamY1f63iIaPFRhDH
 4VwvHNN2GVos28C8w2hSOivlNEIS34QXtwRlo/dqHaRz96Apyn7Zm/XDYYnaJZTBO958
 QbOBPwJ5IysbwFbJ+aV/Yb8/m0tZInPRkl1u/2gs685W6mXpy6gKpJXy8xCpa+KwKCFz
 Xl+5hh9FOLG6zry8a77euiCaPStZeDS8Ad1xarkhn75xm4+JIYhxbUyMKOsuBxpXOSOn
 qywA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0AIcjouY0ed8gcmIN4LReibTQuVkXxjLwIhIXcUi8T3FiUmOd2RcaXnXrqhVba0wPy2smE3q3xFsFLQ==@nongnu.org,
 AJvYcCXRGEt+Cf6jqJExdXiJ+3ovH2EiGHHxXMPt/ZFhoUay0xPpg8ktDo3mL9Z9449txuAAVmGzBzsBalD7@nongnu.org
X-Gm-Message-State: AOJu0Yx1SnNRR+ga+OIV9JDGZaDaGuurKpOoevFOdqzUcPAwxIYK3yQ5
 DGJUUqx+UZBaW4g7RENn930N54pOG79C7Zw7wnob9cGq82MxMHktTQyrN9t3XbGX21vxs2FtTiP
 36dGXz/bzLHwZceCWMJtq9VK3Hufe2/E=
X-Gm-Gg: ASbGncvCZeHC6UWECzTlisn0M8DBT72Tta/UqI3nr6Uu+iqiC8AsV9GWxQYBCVYfUev
 C3wX47ePXYfjD59vx/r1XFkaCM2bQkSVYP7NUqZNe9OHmUYqsjqZnhRXAjWNLGTNUcAtaiWBF2w
 eT5J6X7v3PqtXwrbT9ljUBKUd9JTBD35HN2eagnUXyZpa65HNwIib4mE3eAVwe+8iVE65yDugVW
 A==
X-Google-Smtp-Source: AGHT+IESNDl3l5C1jpCQ1GzmEABrFaXWKjL3Omy5wBJi5BTtd5EBB1JdIU1gfTAhKNsg+XbNDPl8Keu6LFgG7NTCpDA=
X-Received: by 2002:a05:6102:5a8f:b0:4e4:5a1f:1414 with SMTP id
 ada2fe7eead31-4e977ce0a76mr476644137.12.1750127877179; Mon, 16 Jun 2025
 19:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250425121750.311-1-wangran@bosc.ac.cn>
In-Reply-To: <20250425121750.311-1-wangran@bosc.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 17 Jun 2025 12:37:31 +1000
X-Gm-Features: AX0GCFvCHbC0xUhJxkzhnQRSPm26fw_7o17WTifseu708xYoNQAbN43WsruQzmg
Message-ID: <CAKmqyKP9yaT_raamZEevP04QkjMyA3BkagbyDVFKPzm0_tgVEw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] riscv: Add Kunminghu CPU and platform
To: Ran Wang <wangran@bosc.ac.cn>
Cc: 3543977024@qq.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
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

On Fri, Apr 25, 2025 at 10:18=E2=80=AFPM Ran Wang <wangran@bosc.ac.cn> wrot=
e:
>
> This serial adds Xiangshan Kunminghu CPU and its FPGA prototype
> platform, which include UART, CLINT, IMSIC, and APLIC
> devices.
>
> More details can be found at
> https://github.com/OpenXiangShan/XiangShan
>
> Patches based on alistair/riscv-to-apply.next
>
> Huang Borong (2):
>   target/riscv: Add BOSC's Xiangshan Kunminghu CPU
>   hw/riscv: Initial support for BOSC's Xiangshan Kunminghu FPGA
>     prototype

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  MAINTAINERS                                 |   7 +
>  configs/devices/riscv64-softmmu/default.mak |   1 +
>  docs/system/riscv/xiangshan-kunminghu.rst   |  39 ++++
>  docs/system/target-riscv.rst                |   1 +
>  hw/riscv/Kconfig                            |   9 +
>  hw/riscv/meson.build                        |   1 +
>  hw/riscv/xiangshan_kmh.c                    | 220 ++++++++++++++++++++
>  include/hw/riscv/xiangshan_kmh.h            |  78 +++++++
>  target/riscv/cpu-qom.h                      |   1 +
>  target/riscv/cpu.c                          |  64 ++++++
>  10 files changed, 421 insertions(+)
>  create mode 100644 docs/system/riscv/xiangshan-kunminghu.rst
>  create mode 100644 hw/riscv/xiangshan_kmh.c
>  create mode 100644 include/hw/riscv/xiangshan_kmh.h
>
> --
> 2.34.1
>

