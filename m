Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127F2E6C60C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 06:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIMVN-00054L-Ul; Tue, 03 Dec 2024 01:35:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIMVL-0004zM-3l; Tue, 03 Dec 2024 01:35:27 -0500
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIMVH-0000Ul-Rt; Tue, 03 Dec 2024 01:35:26 -0500
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4af3bfbb721so1475210137.3; 
 Mon, 02 Dec 2024 22:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733207720; x=1733812520; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yf9BrlfRqGaSlUzr1jGwQcQsL8td33Mhp6K4QzBJhI=;
 b=Z++Fo1iULNQmDgGb+lND/whVMV0aMoOLE6z0Zt1Gd34G6VOgbf6dfIECAY+cdTmbCX
 wFN4VTUz17/1JP7JSvysKm6FUsFXBZ0F5aaZlN8vybPj9DNKa+txmLRj/lDhCn/P1Os+
 aPx+XiAQFvU/w7GeLMCLfsOf3dv8wmzjQKAmFfYuOqE93ONkWq4RvBrZCjbd5UZU4RuN
 2XObgf/AcWYXvDmFvSVs/Cq4fXOBwl7cPnmZx4PIC1yvpwbrjggHfWGHC9ZwM/AAsktk
 VbnCWReuqnG2puzaX3UjqBUdmqDQ19BANZbMVWwvrw+52TIZT70m21+nnK8grqSddHu+
 ifRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733207720; x=1733812520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yf9BrlfRqGaSlUzr1jGwQcQsL8td33Mhp6K4QzBJhI=;
 b=BKSL9Xpfu7VxNb1N7o/W5g3za21RmWSvYUqcoZ9phYSRe9px5Et6EPezNNP7bOWhZm
 xma1N5GESCtnss2TVufUuQIVbuhzT8XZC8R2xNGBIGNrSKS8Hls7yuJfcKqqtSnAK+zA
 Nbw4rWzKW/QfZzzKdZ1RcoulwFvGLhE+6mpWRHfMFe3XWIwrx9eXiplpbWrA5OMrB0nS
 3XsrjN9SjdNFTjoEigTY96MWFYJrF3Kg1DcLRrb4DXHcrQV2DSqT3cr0lOJInfyWpBjr
 qHzZPa3FYyqUAE9DsM7cC9fSY0IENvn8fDwktWNAgNDgNz69lIFwI7mo0c+4jEL9h3jr
 t05A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMkNAW5BXsSlembRaWp+DKmAzzQ6bZX1dYkExbcwiU+/LGrrj6LBqcNiWcU1PhEhOOmhNbkja0ODy11w==@nongnu.org,
 AJvYcCUccVSEsUpD50CUKqrwx3ikxrNbCxMAkW79sLBivcMMxDR2lsxZ/KqMobM5AZyIcfoiehqA2ood1uWg@nongnu.org
X-Gm-Message-State: AOJu0YxZ4Aix/eMA4Qh36ApiS1C5kde6Im5r93RKxmrZp7zMe1hZn4o4
 slcv2jv3BSlviLHPj7JD+Ln/Mem0jlhM3+Qn31LMzbfvXCOEq1ESHB/Y7zysvaBTeoUKYL2uzwb
 /6tfqER+SNOraQQyk4VxWpu/B+aA=
X-Gm-Gg: ASbGncs3OrV0XuXU+9Olcp7KLeiYdplGU4uatFArHfjacNMkdj4MHE95pASrKZxYMCF
 nSeQlIX1wULpNwq8ktXfLoYcoQl4EkL8x
X-Google-Smtp-Source: AGHT+IEVZuP7zTwpONNfk//+eNwjlEQxeqrce473tOGHxeVApdtCripUS9k2pOQq/HC6Dck3tgz3TxFxdibH5rservY=
X-Received: by 2002:a05:6102:a4a:b0:4af:4a71:e35 with SMTP id
 ada2fe7eead31-4af97391601mr2064585137.27.1733207720447; Mon, 02 Dec 2024
 22:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20241028015744.624943-1-jeeheng.sia@starfivetech.com>
In-Reply-To: <20241028015744.624943-1-jeeheng.sia@starfivetech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Dec 2024 15:34:54 +0900
Message-ID: <CAKmqyKMdtaK30S0OkaTKTY+6q-nMkpfNQyC0LCC05EfutBoXgQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Upgrade ACPI SPCR table to support SPCR table
 revision 4 format
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, maobibo@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
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

On Mon, Oct 28, 2024 at 10:59=E2=80=AFAM Sia Jee Heng
<jeeheng.sia@starfivetech.com> wrote:
>
> Update the SPCR table to accommodate the SPCR Table revision 4 [1].
> The SPCR table has been modified to adhere to the revision 4 format [2].
>
> Meanwhile, the virt SPCR golden reference file for RISC-V have been updat=
ed to
> accommodate the SPCR Table revision 4.
>
> [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/=
serial-port-console-redirection-table
> [2]: https://github.com/acpica/acpica/pull/931
>
> Changes in v6:
> - Added Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> - Rebase and update the build_spcr() function for the LoongArch virt mach=
ine.
>
> Changes in v5:
> - Reverted the SPCR table revision history for the ARM architecture.
> - Corrected the output of the SPCR Table diff.
>
> Changes in v4:
> - Remove the SPCR table revision 4 update for the ARM architecture.
>
> Changes in v3:
> - Rebased on the latest QEMU.
> - Added Acked-by: Alistair Francis <alistair.francis@wdc.com>
>
> Changes in v2:
> - Utilizes a three-patch approach to modify the ACPI pre-built binary
>   files required by the Bios-Table-Test.
> - Rebases and incorporates changes to support both ARM and RISC-V ACPI
>   pre-built binary files.
>
> Sia Jee Heng (3):
>   qtest: allow SPCR acpi table changes
>   hw/acpi: Upgrade ACPI SPCR table to support SPCR table revision 4
>     format
>   tests/qtest/bios-tables-test: Update virt SPCR golden reference for
>     RISC-V

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/acpi/aml-build.c               |  20 ++++++++++++++++----
>  hw/arm/virt-acpi-build.c          |   8 ++++++--
>  hw/loongarch/acpi-build.c         |   6 +++++-
>  hw/riscv/virt-acpi-build.c        |  12 +++++++++---
>  include/hw/acpi/acpi-defs.h       |   7 +++++--
>  include/hw/acpi/aml-build.h       |   2 +-
>  tests/data/acpi/riscv64/virt/SPCR | Bin 80 -> 90 bytes
>  7 files changed, 42 insertions(+), 13 deletions(-)
>
>
> base-commit: cea8ac78545a83e1f01c94d89d6f5a3f6b5c05d2
> --
> 2.43.0
>
>

