Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5020DC36001
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 04:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twZWh-0004GL-2a; Mon, 24 Mar 2025 00:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1twZL9-0002Rp-4s; Mon, 24 Mar 2025 00:23:18 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1twZL7-0005gf-GU; Mon, 24 Mar 2025 00:23:06 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-867129fdb0aso3726165241.1; 
 Sun, 23 Mar 2025 21:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742790184; x=1743394984; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IvSWp42Duoa5RTnudxQAgvBWWalfprx+TOQXJ0kOMlI=;
 b=Qkvy0ufiv08c72mmOuez4DeaLAT8Tar3hj1Kfau+xZYRi0EdFq81+mJUmpunB+mUOA
 +ocYZ/h6oQxm1cPl1UkOL9Pa7qlvuP12cn/oA1+g3UttqY+5LeiQLFxrfMZEtrborsz3
 ZVSvcAi6Zz9R+6LtQyvvDkpm9aIKa9X6F268xEsZuoligUPGM+5snGGBWcagK2buQsfR
 v58vMrH6JpoQL6ubYwUnYsUQxLU1ccR8kDuYIseNfY7jc7RnmBTB+XrAkTRjebwASNL9
 kwkI5vVcST64LpsfROg8XM2QVJBCSpLkN5pnDdeFRAMe0TehvWrvrFT2119amsNmu5Qv
 cxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742790184; x=1743394984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IvSWp42Duoa5RTnudxQAgvBWWalfprx+TOQXJ0kOMlI=;
 b=Qzb+ctJgnUciuEJPJCudinQkcytJTNEsT5SLK2Ybryl3E8I8rQD9oE/YPVgMCA99zQ
 ECkceQFa+XyKlxzIwNEANZ/Biaq/b7z03Ak+qNv6nug5P8jcA0/jcH54w4sBCPI6yAz5
 O93Km+WBb0Ba5hW8x6jwScOTtFQMH8BOFDHOJptOebFkA8/hocZW1RMnS0Y3Mg/6tXpB
 SzgnapHLHB5H2dbTa2ZtrxquraJ8JZVoyalqI5qKw15Nb/Gy8HqFbXZn6+YjABrYsT7v
 C79Kmo9+4wBA6C0Z6r9Wi9kFLtuoRumNpF+vYzbkAXgfbWGUiS9aBx2lJrv07ekLNKjT
 ozEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVbjnnn9HyOvQWsgx0ZkamD7GoJZ5z9Heks/bueVYXEH6a+7o2o2hE0Adf0WLH2+eQpbiUxNZj/yoO@nongnu.org
X-Gm-Message-State: AOJu0YxhRM3XszjfbgneXIJ6JlRZlHL/0qsTFPgmLprG9iYXj0EZ4knN
 IHXhkyJUr0IC+dNZesANJ5N32DFNduOW/LigbUFvQRmQ/0bGMy7GYPutMN2GRe8MQWHev9tkjRA
 cKrjKdE2QMAajfs9+PTXQgr3x99U=
X-Gm-Gg: ASbGncuQoTjZX3J+91F1IFUI8UrfA/6FiKsHgCgs722lqj4Fb+EDzNUmgiZ/SdnUYnI
 SzfdRdrU0kUMdKc6xOs6vGQwp8tu+zbtGYh/IGVIWWGju836Iy49qJ+HAEuexs3z8p7aYrpChaK
 z5LB4zSr+NHmLL8/tLZDbwbQLHQOZ74/39F0vx59tYv/NSy54++NlWPMU=
X-Google-Smtp-Source: AGHT+IFCIV3Qnjbt7WezaHzy6plCdsFNXti/YYp06mOrrxxg+9gW1DnXuof08tI66tXgDFG+gngIT9oNqgzlhft1R0Y=
X-Received: by 2002:a05:6102:c92:b0:4bb:9b46:3f6f with SMTP id
 ada2fe7eead31-4c50d47badbmr8189062137.1.1742790183891; Sun, 23 Mar 2025
 21:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250322043139.2003479-1-sunilvl@ventanamicro.com>
In-Reply-To: <20250322043139.2003479-1-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Mar 2025 14:22:37 +1000
X-Gm-Features: AQ5f1Jo6lKoQs7ybgi9Ad_VnZH0O_PWMbKYwmT2tVGX4sZbcuFaiKfMu5P7CdUg
Message-ID: <CAKmqyKOW7LScbMByr5VtQ4js+Li-Q_tUgsEO6KnL_ehY-mxnWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] RISC-V: ACPI: Add support for RIMT
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>, 
 Anup Patel <apatel@ventanamicro.com>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Sat, Mar 22, 2025 at 2:32=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> RISC-V IO Mapping Table (RIMT) is a new static ACPI table used to
> communicate IOMMU and topology information to the OS. Add support for
> creating this table when the IOMMU is present. The specification is
> frozen and available at [1].
>
> [1] - https://github.com/riscv-non-isa/riscv-acpi-rimt/releases/download/=
v0.99/rimt-spec.pdf
>
> Changes since v1:
>         1) Used g_autoptr as per Daniel's suggestion.
>         2) Added R-b tag from Daniel.
>
> Sunil V L (2):
>   hw/riscv/virt: Add the BDF of IOMMU to RISCVVirtState structure
>   hw/riscv/virt-acpi-build: Add support for RIMT

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/riscv/virt-acpi-build.c | 215 +++++++++++++++++++++++++++++++++++++
>  hw/riscv/virt.c            |   1 +
>  include/hw/riscv/virt.h    |   1 +
>  3 files changed, 217 insertions(+)
>
> --
> 2.43.0
>
>

