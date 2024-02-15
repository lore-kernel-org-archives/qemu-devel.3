Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA3BC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 09:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raYRy-0002r5-3R; Thu, 15 Feb 2024 04:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raYRq-0002bQ-IU; Thu, 15 Feb 2024 04:54:32 -0500
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raYRo-0001Qi-Ua; Thu, 15 Feb 2024 04:54:30 -0500
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-467e4a04086so221874137.3; 
 Thu, 15 Feb 2024 01:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707990866; x=1708595666; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UK3WtQ1qFUGeEMjDPu9dS0e8tiOTBzkH6/cmRz+LEO0=;
 b=IEgKLTpyO2SrzDUHA1wVweYvdIBfkVzlcxr9DECfikg1u7nSdNbS3qIXIYGiSntvp8
 qdRZfIChq18eKl+cUTI/cg753XnXyfSuo5ZPbTB7RP/Ml1r90C9wHn55jeX8+x5IMcLf
 ZeMJN2HOw9jQMpZiTISHe09XXB/2d9lGfCpR6KFnC+UZEG7arWgwLplBeNK7OVg1H3+E
 P+Vn9XuRX8bgtgDrTesVJCT1eu7trEg1KJkwAY/u6TSjPtOlmoSWG0XqGp7kkwWjYrlW
 WRFOE6oFuk2wEPFpHypyVs5UFyrTLUP8Hr7Kp4yPObFcpyszMCFO3qLqt3dCU3d3a+Fd
 cI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707990866; x=1708595666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UK3WtQ1qFUGeEMjDPu9dS0e8tiOTBzkH6/cmRz+LEO0=;
 b=JXV5tk+BgL7TZAGReG+0Yg3q6qrKCn5o++yeqm4HMyHhLdmUP2SDXH0fEqxDXkzhPw
 rP5m1oz2WPwyw7dp59UT7IBdewPEcrryPxVMWscfWId+R0iKmJ/0Mj0jywLkR8oJl12J
 QxQFOrsKUyfwgMYeblOEdykhVmLLpTINkkv0kGtU/LTjAx7roHFocV43FmsdsJiOzxZ3
 rA2HAYKtAAUz2Xj5sdDYMj7+B4wyC/6zsjzGsxZ0pOTnwx+MmpM2CgQx1Tte+k0hZGGG
 ycILcn8A9C8Qv3NJ38a4tuy0Li1706Bp+6UXw1rMV2IFZweM77hYDRDlxMM4IBAxd9sk
 eCAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfC7vCxbqMbdzC30n8Skupe0JEh1YWKM7S4s4URS/mSOyLgVKZUUjZoT60tc+5dTkC+nL3pLP4r266T3I7mSPYdMMOgmYD3n4Mu6UE/8BAQ9enROxVMj6jjbTiPw==
X-Gm-Message-State: AOJu0YymY1OL/WiGrMby2szaSCU5RYR5vB4wvIjPS3hKfXXEei/qBwM6
 DR0meT2/A41bmh9OqtLhnDO/hrMiTqlPSQLD5eN2nNeAINAtbXK0COCfznsx+pNG38PFCfFfxgX
 hHKikUrtL5BDjb1V0QOdx1Q9+hgc=
X-Google-Smtp-Source: AGHT+IEhKDmQXwAHkrVaV9pGWX9IxDEW8QdNh4HzmEJPa/CplRra83CklUkIZWSAWj8J6+WCo7mDzLdb3t/5VcB9DKc=
X-Received: by 2002:a67:c598:0:b0:46e:c42c:e24a with SMTP id
 h24-20020a67c598000000b0046ec42ce24amr937099vsk.14.1707990866323; Thu, 15 Feb
 2024 01:54:26 -0800 (PST)
MIME-Version: 1.0
References: <20240116010930.43433-1-jeeheng.sia@starfivetech.com>
In-Reply-To: <20240116010930.43433-1-jeeheng.sia@starfivetech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 19:54:00 +1000
Message-ID: <CAKmqyKOsX+QYRsb9+DfeYC5hkzUakOC8M1h4JCssHQPu4zG8gw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] RISC-V: ACPI: Enable SPCR
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
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

On Tue, Jan 16, 2024 at 11:11=E2=80=AFAM Sia Jee Heng
<jeeheng.sia@starfivetech.com> wrote:
>
> This series focuses on enabling the Serial Port Console Redirection (SPCR=
)
> table for the RISC-V virt platform. Considering that ARM utilizes the sam=
e
> function, the initial patch involves migrating the build_spcr function to
> common code. This consolidation ensures that RISC-V avoids duplicating th=
e
> function.
>
> The patch set is built upon Alistair's riscv-to-apply.next branch
>
> Changes in v2:
> - Renamed the build_spcr_rev2() function to spcr_setup().
> - SPCR table version is passed from spcr_setup() to the common
>   build_spcr() function.
> - Added "Reviewed-by" from Daniel for patch 2.
> - The term 'RFC' has been removed from this series, as the dependency cod=
e
>   from [1] has been merged into Alistair's riscv-to-apply.next branch. Th=
e
>   first series of this patch can be found at [2].
>
> [1] https://lore.kernel.org/qemu-devel/20231218150247.466427-1-sunilvl@ve=
ntanamicro.com/
> [2] https://lore.kernel.org/qemu-devel/20240105090608.5745-1-jeeheng.sia@=
starfivetech.com/
>
> Sia Jee Heng (2):
>   hw/arm/virt-acpi-build.c: Migrate SPCR creation to common location
>   hw/riscv/virt-acpi-build.c: Generate SPCR table

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/acpi/aml-build.c         | 51 ++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c    | 68 +++++++++++++++----------------------
>  hw/riscv/virt-acpi-build.c  | 39 +++++++++++++++++++++
>  include/hw/acpi/acpi-defs.h | 33 ++++++++++++++++++
>  include/hw/acpi/aml-build.h |  4 +++
>  5 files changed, 154 insertions(+), 41 deletions(-)
>
> --
> 2.34.1
>
>

