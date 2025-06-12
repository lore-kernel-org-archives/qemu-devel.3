Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4134C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 04:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPZbl-0002VO-0r; Thu, 12 Jun 2025 00:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uPZbf-0002Ud-Ik; Thu, 12 Jun 2025 00:32:03 -0400
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uPZbe-00034I-0H; Thu, 12 Jun 2025 00:32:03 -0400
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-4e79dde8511so125468137.0; 
 Wed, 11 Jun 2025 21:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749702720; x=1750307520; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1LShEKZm1q4RYeV1EjluM0mlneg+4f1R+f7XoajXd2k=;
 b=nCG10SC/IWRlPcOZnxXt8lwwGaERIlFyr/5MOIl34hAzoxHVEOCThAV1HVSbNBl/6x
 ZIz/Eej8CZ29QMXxM1Td4rVEHw5LZpEIXroz9LHPBw5xZ5meZOEmphw9xZXQUK8VbsdN
 ZTZDug65LA9FMma355OdQhZMuwFVDLUslUVFYq92R2/STUTL/a7kAReMZ+Ml7wspdSoK
 I0ZtR8J9yKTFuteRh6Edsrq/yUs735tJKnFleNPPdsZWUjBDpLtTAMIB4nEVbomkRnVj
 drpMPtkdz2GdGmKhl5FXjPwurpsciPH0WCU26A7SpjJ3BJ/zFb+7eQeQoj9C+67u1N92
 91Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749702720; x=1750307520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1LShEKZm1q4RYeV1EjluM0mlneg+4f1R+f7XoajXd2k=;
 b=GU7dqx1qS7ySLtfW0F0QiGwvXRgMaAbwemgR7ziLJXZ4vvBB8P8KGzO/bBbQe+SeZl
 BP+vXFtm0uHmi8NLA4fg0XDenv5WDd2RYeCBUk1ZJeN6cu1ReE5ozPJ7/M6+qPb2m3bA
 B+1b67XbMs+M65Grg73z02AT9YY3keyJPG+WQUPffVqVHDAsmVvMnjxIMJXoCWr7D/l8
 UnFimLptMVe3x+rW3rhbFqJ7i0aU7/R+Kgb3YDVPxPp+vb4qw//iiGZdRu3K9iz9cL5v
 BqXsujwA51XUicJ36Fz6dpn3ZDg/wVJTDM02jS7nWkf4qYEKEvWLDrI/iF8k+XK4NNOU
 EM3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvRKzXjkiLfkpJeGvcdfIRwZQmv1n4lZq9DVTAihKxxy40jdMvgZrpf8z5QLzuX9/+rzNAT8ev90Hq0g==@nongnu.org,
 AJvYcCW68pD43B/MgAq3AiEr3y6HcqhVT7Qryf8R6gexd/RUcHFAVhdkj2880VghhtnoRDqFtkunLW24enbO@nongnu.org
X-Gm-Message-State: AOJu0YyBW7d4xJAUYrf8YUAO7vldBPr68P3qSVpZc/nxzARNaQQuEnQS
 mUTY3jVPFWnWSpb4S0dM+zJzcRI4oCZJBvo7/2He1B8jXxCAyz0fk/3uhDMqCJiKaYuAEhFrdAI
 IFRyLggT79xFBOLIfmH1SdAd/9AwFCQ0=
X-Gm-Gg: ASbGnctQyh6ubA/ihNN8vSFhT3xU5GYaDjSz5j7kOv+mhCJFBzhMO+0NzjOszZLJfSi
 wUTX5ze7m4bID35oS9clzo+u1RKEO+/se5k/h7w5UPeOfm806A0ZRSXCyuQtA/f20E+ILD6233h
 UXu0dXgTTIpnFzXGpuUXanZGxuzfASOOzN1HifT8KSduG4mgYXc3/Kbyo7BFIUUEgDjXYJhyPZ2
 48XUQZgVV6s
X-Google-Smtp-Source: AGHT+IFi4BsRsdADc/JTQJpAGT6GS9cpQ873qPuI4WsWATh0ue6K88do3pzBwHWItb3dl08V84o8QDSanrEtnmwnsbk=
X-Received: by 2002:a05:6102:6f0e:b0:4e4:f503:666b with SMTP id
 ada2fe7eead31-4e7ce8578aemr850278137.3.1749702719840; Wed, 11 Jun 2025
 21:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250604025450.85327-1-joel@jms.id.au>
In-Reply-To: <20250604025450.85327-1-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Jun 2025 14:31:33 +1000
X-Gm-Features: AX0GCFv001e_oBkiXOcUA7CySpe-JZmrWRfqD3YiK5FOcWcex8XLqUrcXpnEKMk
Message-ID: <CAKmqyKOR6DW7EaUwb=2V5vsoJTC94DkE9dzOhGPpN+H07cAxuQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] hw/riscv/virt: device tree reg cleanups
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2e.google.com
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

On Wed, Jun 4, 2025 at 12:58=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote=
:
>
> v2:
>  - Rebased on master now that Daniel's changes are merged
>  - Fixed doubled up patch 1
>  - r-b tags from Alistair and Daniel added
>
> This is a set of cleanups for the riscv virt machine device tree
> generation.
>
> Using dumpdtb the old and new device trees are identical for -M virt and
> -M virt,aia=3Daplic-imsic.
>
> Joel Stanley (12):
>   hw/riscv/virt: Fix clint base address type
>   hw/riscv/virt: Use setprop_sized_cells for clint
>   hw/riscv/virt: Use setprop_sized_cells for memory
>   hw/riscv/virt: Use setprop_sized_cells for aplic
>   hw/riscv/virt: Use setprop_sized_cells for aclint
>   hw/riscv/virt: Use setprop_sized_cells for plic
>   hw/riscv/virt: Use setprop_sized_cells for virtio
>   hw/riscv/virt: Use setprop_sized_cells for reset
>   hw/riscv/virt: Use setprop_sized_cells for uart
>   hw/riscv/virt: Use setprop_sized_cells for rtc
>   hw/riscv/virt: Use setprop_sized_cells for iommu
>   hw/riscv/virt: Use setprop_sized_cells for pcie

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/riscv/virt.c | 66 ++++++++++++++++++++++++-------------------------
>  1 file changed, 32 insertions(+), 34 deletions(-)
>
> --
> 2.47.2
>
>

