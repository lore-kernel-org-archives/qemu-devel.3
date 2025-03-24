Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A15C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 02:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twXIG-0007pb-PA; Sun, 23 Mar 2025 22:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1twXIE-0007pF-Lj; Sun, 23 Mar 2025 22:11:58 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1twXIC-0005OQ-TJ; Sun, 23 Mar 2025 22:11:58 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-86b9b1def28so3833971241.3; 
 Sun, 23 Mar 2025 19:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742782314; x=1743387114; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9MAEjp7Ar9/XStKkk6SdiYAmgEQt2fog4Ffv93nY/vY=;
 b=PDciJkBqcsI3ZBOYPqYvbHS6q0fRo8h02y/fjU5AOJ4pPlpyLRjVzZ5+c6sa+YsPJE
 2ot9pEfhrWKHYQ2RMhBbhAofnwcqVxXnB3OUlcm+9ladbtn0rL9W2I7o6tdIA8lrGT+Q
 E4befwSju80Ql+qxNuDKnw1pck7DwvsxmCaNLcbZDh/PyvIH60kG2mEtKhjuL17cx+v2
 EqvD8e/XYBgD+sVCotDLEUscUWvCrP2VSsWkEFUeKRIGtmKb1fh9TDI4IBgSWuuuX+yX
 Aca/2d87wiBGYU5Edg4n1CivgRSsPVLNxAIOSX75q0tgWClM2M+HFzipMZ5/t72X/0YD
 30hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742782314; x=1743387114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9MAEjp7Ar9/XStKkk6SdiYAmgEQt2fog4Ffv93nY/vY=;
 b=FqZNoTIS/SfKh3pb93PRPKa69VAxQIxMKHSElrpXGbdo7ult5h7tl35BNuoEKJY38t
 fH3gC+jlR+x0zf0Gi2cUdzDkYWpZzrjKsLiBl/a1xniWqrzfbA7KOPrZHhU2vDl3ZIWS
 gqulGLr6S1Rffo+rmTWJjxtD3W0RjSVNxrw9SWrM9nmGtQzlCfiPl+EZxD9lm4lfRTaH
 2bqjEBA8Lh09azn7HCCWNeg1qv3SWclQkGxrIn588rosW7H4HIrLGqVpSY2JE+o0OuLj
 EXcQyvH4MQwgz9lJLdF+8H0o6ScBdPaHJdylsgBiGUHnYmpAwnIkmpfhRbCXBlekfTpS
 L8tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXELJwR0wiebE39hADw+bz2JyBom8kTebsa7JS/Z01mp4abYn9VEIUdfCMNGbEYkXbzyUQM7pwcjqZM@nongnu.org
X-Gm-Message-State: AOJu0YzqILvuQosa9G94pYPo34fzhoVEyJ4knQU81E8ZbyBTmyLFIQfy
 avaViVNEPojtY6RCdAhPqIpk3B0+BHrTiEUD6h8q/6bZF9fxkdsNchj1vEdeAuRBWoBc0jrMkiM
 WJd711bCofpbm9/w0Ys2EvAOvFyw=
X-Gm-Gg: ASbGncsPeqbtGLtpI3jzHdRXZHDGE2mCzJotDBOWcERgymwKuudFInJjQqLEhQkOqQq
 vjACr7w6M74AFezQmlcAXZvzy4oKAKp8hUjHAyX9j8j8YufAE7vWdoiAsYeoxDjPlREZ73Lqzhq
 w6xl7XfDxaecLH2xBnav0hN3njTCKO4QLPw3CGbsi0XHBrn2gSlLdPHZo=
X-Google-Smtp-Source: AGHT+IEl7r6+GXjEAz1w5ifPZmRWZ0i1wUXmIBwWDY0djVvmxZQOv8Kl2YeB6Ax5QbDFCZ4tilveEz4n4mj7pPV7WZw=
X-Received: by 2002:a05:6102:c92:b0:4bb:9b46:3f6f with SMTP id
 ada2fe7eead31-4c50d47badbmr8113151137.1.1742782314164; Sun, 23 Mar 2025
 19:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250323063404.13206-1-hemanshu.khilari.foss@gmail.com>
In-Reply-To: <20250323063404.13206-1-hemanshu.khilari.foss@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Mar 2025 12:11:28 +1000
X-Gm-Features: AQ5f1JoUu7HoJwE6QOvDYdyHSqzzqEqlDz4-XQOEGXss5EbNHrDZ2XisOIq8Omg
Message-ID: <CAKmqyKPYggbUzd2MOVhu7KwKYGgBGD3KVy31JiTSFWX2QL-_Uw@mail.gmail.com>
Subject: Re: [PATCH v3] docs/specs/riscv-iommu: Fixed broken link to external
 risv iommu document
To: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair.Francis@wdc.com, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Sun, Mar 23, 2025 at 4:36=E2=80=AFPM hemanshu.khilari.foss
<hemanshu.khilari.foss@gmail.com> wrote:
>
> The links to riscv iommu specification document are incorrect. This patch
> updates all the said link to point to correct location.
>
> Cc: qemu-riscv@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2808
> Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  docs/specs/riscv-iommu.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
> index 000c7e1f57..991d376fdc 100644
> --- a/docs/specs/riscv-iommu.rst
> +++ b/docs/specs/riscv-iommu.rst
> @@ -4,7 +4,7 @@ RISC-V IOMMU support for RISC-V machines
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU spec
> -version 1.0 `iommu1.0`_.
> +version 1.0 `iommu1.0.0`_.
>
>  The emulation includes a PCI reference device (riscv-iommu-pci) and a pl=
atform
>  bus device (riscv-iommu-sys) that QEMU RISC-V boards can use.  The 'virt=
'
> @@ -14,7 +14,7 @@ riscv-iommu-pci reference device
>  --------------------------------
>
>  This device implements the RISC-V IOMMU emulation as recommended by the =
section
> -"Integrating an IOMMU as a PCIe device" of `iommu1.0`_: a PCI device wit=
h base
> +"Integrating an IOMMU as a PCIe device" of `iommu1.0.0`_: a PCI device w=
ith base
>  class 08h, sub-class 06h and programming interface 00h.
>
>  As a reference device it doesn't implement anything outside of the speci=
fication,
> @@ -109,7 +109,7 @@ riscv-iommu options:
>  - "s-stage": enabled
>  - "g-stage": enabled
>
> -.. _iommu1.0: https://github.com/riscv-non-isa/riscv-iommu/releases/down=
load/v1.0/riscv-iommu.pdf
> +.. _iommu1.0.0: https://github.com/riscv-non-isa/riscv-iommu/releases/do=
wnload/v1.0.0/riscv-iommu.pdf
>
>  .. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git.t=
jeznach@rivosinc.com/
>
> --
> 2.42.0
>
>

