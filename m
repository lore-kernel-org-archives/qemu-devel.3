Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DA2C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 23:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ueI-0006Ju-QY; Tue, 29 Apr 2025 19:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9ueE-0006JG-I4; Tue, 29 Apr 2025 19:45:58 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9ueD-00052I-2W; Tue, 29 Apr 2025 19:45:58 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-51eb1818d4fso8790613e0c.1; 
 Tue, 29 Apr 2025 16:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745970355; x=1746575155; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRLavPxkSoe6Nb/0Zag6RIEZESR7OLmiKGVGue8Ye24=;
 b=BCX4etTO9Y98NTXEetdvS7fSucujoRJL369ssW29GsZpOLWIDHXipsEQLDpdXbukHL
 pcejIh6y+tkgI74w6b67dKgLuDaifK4RoFZ4xWD3yKAaZhJ2XdtvHfC0b8hFTgor154t
 38J3VcjoWLSDLpskkQDzkpO7BBkZdcUg4FcPiat4ygdMAS3QHHBjhglJLYIbPTsPNf/Z
 xj0fnZ29SiqFWCc5JA7Pls8Bc543o3Q0ohTpsqluJd7KrFqsebFkQIIwjBoiBPzk1Ok+
 9GTWQAEWXOxWmJzDOtpd39EkWAWpYX5OpfLU4e12oSmcAE/3GmAAj+HH9NCKllpH1z5O
 K3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745970355; x=1746575155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRLavPxkSoe6Nb/0Zag6RIEZESR7OLmiKGVGue8Ye24=;
 b=by/Lw8VvhLutMXwzvtiNZdAbB77a/IQsAbv71HrYK3fV+SMeIV0JbpRYtT5xopTZoF
 U8jkLWHHnAzIr9cqge1b6BSkZlW1956j5stSjQHYLqK1Q/CAj3JIyt8szuo/hIJuzofB
 mA51MPHsiLQwKHUbVecOB4MHCIQkLCUnu3bj5rDYwWpV2iGTdPGAhqsWjnhcV0qlETLY
 roJc9qja8+1qQkb8ZJP0xP7D9iJ/f/pK+ZZDBomvaxOVJtN4/+aimSqANAHoEYQd/h7a
 BJ03zKux46B7m5JI4RIrFPK+DzovhBX5c+fdcX0Xhmjs9uK5VV5FjurriULle7fFhwgT
 quwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGaQbWMmo//SzCQJ/ZnFxI7Qe3v9yxNDoiwBqrPri3LWfOCyGYD626zGerZzt5uCEDv6OBKo5V0Tq4@nongnu.org,
 AJvYcCXqb5euryAsHNpBiyYzzxveHCY4hoLjFwQhdPUKNEIPj87zmfw4Ommqn6yTDyUUv2ew5GkrFG3fi7k9HA==@nongnu.org
X-Gm-Message-State: AOJu0YyLD/1mQmEsxi/kYvCsv0fUJONl+K/fXJ+ZETXhreQgAGoZ0ZXg
 UcwnWvuod3Bq2G+uQ6ImxK2CgHlctv20j5DJYY2sAkWSbdHEeIX6c5yRIII5Yv22ojA1b3IkXvm
 Ov8u3FxmLIBAaxO8vutTdddnraRo=
X-Gm-Gg: ASbGncsWZX7Ze676gANgRSfBJ5roSTJGtIpWMuv+RR8uh5PHPihS7Mpg6NLCQvJ/SMB
 SZdiQg7u/VVPPaQC1QVICqaPZc143l3SGq3JzYu2pXRHgFX9sxB98RauOlpqTUP/3Qe4yh77JsI
 KqNgbQZuOezI6qNABZj0pvMCMGukpLvy9Rp/EqtMLe0LCVDtR/9pKi
X-Google-Smtp-Source: AGHT+IG5MaykAhFC22dDBnyRMgLwyYZx0a7hYQAQb8RPS9eIK9wj9vkPcQoyZlk+KFVwD8r6EMTMNUvaoZKJ2GtWf9M=
X-Received: by 2002:a05:6122:2a07:b0:520:98ec:b25c with SMTP id
 71dfb90a1353d-52acd733ac7mr1042674e0c.1.1745970355265; Tue, 29 Apr 2025
 16:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250429061223.1457166-1-joel@jms.id.au>
In-Reply-To: <20250429061223.1457166-1-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Apr 2025 09:45:28 +1000
X-Gm-Features: ATxdqUFh3dFHlcT9qzlhZ0sWopCsrry78b6s_gRU4EFtU-Eq2xZF6yBqPYc5H9s
Message-ID: <CAKmqyKPro6xM3UW+CwyEy1xr+CBW_CffJ7J-i7_BCTF0ECAWww@mail.gmail.com>
Subject: Re: [PATCH 00/13] hw/riscv/virt: device tree reg cleanups
To: Joel Stanley <joel@jms.id.au>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

On Tue, Apr 29, 2025 at 4:20=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote=
:
>
> This is a set of cleanups for the riscv virt machine device tree
> generation that apply on top of Daniel's recent series.
>
> Using dumpdtb the old and new device trees are identical for -M virt and
> -M virt,aia=3Daplic-imsic.
>
> The final patch is not meant for merging, but demonstrates bugs in the
> existing code when the reg property describes an address > 4GB.
>
> Based-on: 20250423110630.2249904-1-dbarboza@ventanamicro.com
>
> Joel Stanley (13):
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
>   NOMERGE: virt: Adjust devices so everything is > 4G

Thanks, for the series

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Can you send a v2 without patch 13 and not with two patch 1's?

Alistair

>
>  hw/riscv/virt.c | 108 ++++++++++++++++++++++++------------------------
>  1 file changed, 53 insertions(+), 55 deletions(-)
>
> --
> 2.47.2
>
>

