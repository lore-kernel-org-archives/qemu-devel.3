Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAACC28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 00:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twW3A-0000I5-7J; Sun, 23 Mar 2025 20:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1twW36-0000Hd-GY; Sun, 23 Mar 2025 20:52:16 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1twW31-0005Sx-CE; Sun, 23 Mar 2025 20:52:16 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-86b9ea43955so1576052241.2; 
 Sun, 23 Mar 2025 17:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742777529; x=1743382329; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bRBrjICzUKokzpBwfM0s32ZosPWSbjdMNiE0A0wO+GI=;
 b=Dq7arJRwJWSVovc4tq/sCfPs1L6MeI1N7DYYfsz5PzMbF8QL2UZue2ghwnJYUvD3S7
 qPOgiGXdT0+KGUiBH48/fbOCNuWJnsrz6A/POUwIVIITDFIBEqas59Vpf+Db6co4uYtH
 aDBIepbW1y/UMdegcLRjxAfJv/wNi0H+hPD0v4aT1vvnPJs0IGzzAV6mc2Ukr0sC9hjY
 MZ+6ILGRiufo97IWdawj5aBgFFVta+c/F2drqt+mM3oLZGb2kHz2qlOCfVQTcZ3rgtUI
 N8TBri/O12uiKgNnNG8WG12MPSn4NQfkQTn9zFm6HnjN8PlQaaXICNsKH/orrAM+7yhz
 46Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742777529; x=1743382329;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bRBrjICzUKokzpBwfM0s32ZosPWSbjdMNiE0A0wO+GI=;
 b=eKiTMwhYqYciRtA3nGUw+HgOoJ7P7A0D6Yi9CCfeik5kGmLXT95Sx4fDsCUba8eoXm
 jPdqe9Q/7hCNLPArntq8y9WQCqW0Djr73V3rUhTzql5uAeLJKxYvJBjNFwPGvfoBL0a6
 tyyek+aLwG+p+LyMtyWskGb5eamvLKKgevKcno6FjKJrUAuzg3d0M+0Ipkp8bOumX9xd
 fsRPctQ4sb/oId5ZRaHqTXpajq+27NQvTOU0kw1UeRveXuQ02Cs1hcEbP8mYZ3cKImu6
 VdoknfMZ2kr1AZZUhTnkSL2S/DCliDXGk0LWcxq9++BSMb7sko7BhfJv7pRcmOLqMz7/
 9krg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfFKxgKq9MdDyVWe5GK/zuAud1yfmACC33kWQkuqClfwME6Yx97RYYB/XdYW04ErYGIea5cmKvQ7AH@nongnu.org
X-Gm-Message-State: AOJu0YzmakyY3O7oeNK9lUvBRkqlB4C3nOW2gJDGcXB7qJmritAsVyIY
 tn1eOkWzc09MBntJb6K5MlvGDaeicjtsWHelJBydDQkCN9cNZtbxTsmxHk60YfN3HIhQ1LrftJh
 Zvz522ZSbX0gvgZ0YohIkJ9HoeSM=
X-Gm-Gg: ASbGncsu4U6ZXRFs0hdl45iBCDIrONDDKXbb5FemVIWUoehMaClYnmYytvJZUR9VhHD
 7NYBesN28ngSS/agCPtRlrgAhokp0PDOUhjj0Oh8KD6BCnQ3LOfcd/xkTWvYJZ22+Sy7nFqdj0C
 eAQpJGoIldGfZX4bvOvPFAqxM8ZSUxbNJAW4MSohpC98E9Afbk62gWNZc=
X-Google-Smtp-Source: AGHT+IFnQdwBolhfwx8vwvWn/wOnFCLdAzwZ4AQGz76vlYk8ig+3k0PNa9Dvwy/fUSauEvA/Y8AwbNQmJdKweaAj3xQ=
X-Received: by 2002:a05:6102:5093:b0:4c3:64bd:93ba with SMTP id
 ada2fe7eead31-4c50d511b7cmr8387765137.11.1742777529383; Sun, 23 Mar 2025
 17:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250323140151.9994-1-hemanshu.khilari.foss@gmail.com>
In-Reply-To: <20250323140151.9994-1-hemanshu.khilari.foss@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Mar 2025 10:51:43 +1000
X-Gm-Features: AQ5f1JrdIx4Z5vlXqD2IKnaN9KHIBM1Um79HSHLHE-xu3emzsi9AN4saMZLeimM
Message-ID: <CAKmqyKOmbA3Tmm=G42-oSJfmevtVhyWR8FNc7=wwrG2P9hmckQ@mail.gmail.com>
Subject: Re: [PATCH] docs: Added docs/specs/riscv-iommu.rst in MAINTAINERS
 file.
To: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair.Francis@wdc.com, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 24, 2025 at 12:03=E2=80=AFAM hemanshu.khilari.foss
<hemanshu.khilari.foss@gmail.com> wrote:
>
> Added docs/specs/riscv-iommu.rst under `RISC-V TCG CPUs` section in
> in MAINTAINERS file since
> `scripts/get_maintainer.pl -f docs/specs/riscv-iommu.rst` doesn't list an=
y
> maintainers.
>
> Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f470a1c9b..27f2cfd833 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -319,6 +319,7 @@ L: qemu-riscv@nongnu.org
>  S: Supported
>  F: configs/targets/riscv*
>  F: docs/system/target-riscv.rst
> +F: docs/specs/riscv-iommu.rst
>  F: target/riscv/
>  F: hw/char/riscv_htif.c
>  F: hw/riscv/
> --
> 2.42.0
>
>

