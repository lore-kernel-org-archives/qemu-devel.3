Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7579C282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 00:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1totxv-00041g-RE; Sun, 02 Mar 2025 19:47:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1totxq-00040X-Cw; Sun, 02 Mar 2025 19:47:22 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1totxo-0000ZD-9D; Sun, 02 Mar 2025 19:47:22 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-5235db99207so1122395e0c.2; 
 Sun, 02 Mar 2025 16:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740962838; x=1741567638; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43/oH12xfHwc93u0Ay1nV8mrz2l2kWNWL16TGiUGCgE=;
 b=iSd+kD6jcw8AMTUeH5hDJ8BSEJhPtuEeV4c4JNfmGGRx2f3JnV9DFqfwKMeA61tgDM
 ePYXCQkm2giCnLct4qPoQVkAHEUwDokWiW9akr16zRhatI0C3G+ymf6D1LamW2TMasXU
 PV+4o+Q71EXQU/jNLtoW2X5+rP8kqevlZq1q2DR54YJX1rDlqit9jSHvwDD2881ZHbM3
 pJ9qpC2uK3vamruMZUJmcofUJR45uBJAN3fUyjyDygQj2pplovKQRNcymmA5wCZ01IlX
 lGbWTWv13t/SYNZV6Lj/M0jMN47tSmj1tl0jJUkEPy77YYxFmACFESW4Zgad81LMClVR
 evug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740962838; x=1741567638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=43/oH12xfHwc93u0Ay1nV8mrz2l2kWNWL16TGiUGCgE=;
 b=sMm6XI4TjSWe19w1V/vkSXqXiHM7kTiLbgyaWoCNTqabhRyWOfXefIEq9DlYx7y/+q
 t9QZz35ZwVXZX8YNL3J92cSD0Q12qZiZ2eWAHeRn2UOHYCR4LAnSmFAjrqk8+jCQAhxs
 4Yxydax5urq+HNy3qj+iHr/1QAMryuR02zEYpUhiEsj1s4lhm9lany8RXODWeHCmsXgW
 bZrDPH+tdbVB05hAFDcOGVeFeWWr0WjvGNfoQdiY83OT0+ABvpGPNBVGAYI0IN4RBgVG
 kpZdBK46ZrRL+DX7rciTldEpc2DKgUZ752N4F7KPu3Z00eYB2664X7Zn1k9bDAi8STD6
 f4jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvnVgleXC4QZlFYyNZljWF34EuTe/Gn43+tf8cKScwkLVUxhOS+C3bAii7r3BbDv7N94DrdiaCAtYv@nongnu.org
X-Gm-Message-State: AOJu0YyLEMZNXBBAh+WmQQcecqkhl2dPLKQHmwypj06t/xLQwz9gs9Q7
 lc5O7L85+QccRyTcOxlCltFjHnO6OfGhqQorZlJEZm8Fo4/HKwQbrwhNq9htyn2wpZ37O9nfq4E
 dwwZpg37kfgrRU4oAsAl3Z27qbWc=
X-Gm-Gg: ASbGnctC1Ryi2ezd0fXudlHFOUwcuiC6lItiBzbjZgqGAXR67u+wl0YVHhE+vffWnHU
 FpK1Qu+AjbbgbPJDOyQgXxAtvV+bVMhhjjBJmE9OXgKYIEMPyqnMPxMma6Yti5jb5ilRPeIK8jp
 FgzaknaOHcmWLFjxsgChT2/blp2H+xPWl3u+Rlxj6h6EjA/ZtJKin4VR3O
X-Google-Smtp-Source: AGHT+IHtJ2sjaamUx9vfw0i/2i+scuA+nV18mQxuVm3f+txLDd3VslDYOku16kPmyJ5fVH7QIQo8S6t6zpxRKnpWWLw=
X-Received: by 2002:a05:6102:6e89:b0:4c1:9526:a635 with SMTP id
 ada2fe7eead31-4c19526b1b1mr883697137.17.1740962837961; Sun, 02 Mar 2025
 16:47:17 -0800 (PST)
MIME-Version: 1.0
References: <20250302130618.25688-2-hemanshu.khilari.foss@gmail.com>
In-Reply-To: <20250302130618.25688-2-hemanshu.khilari.foss@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Mar 2025 10:46:52 +1000
X-Gm-Features: AQ5f1Jpgdp5pyvijX2CIfgj25NFvfPvRz9YeZweCBx709X5tW3P6JniDWi0dmhY
Message-ID: <CAKmqyKNFzHeVhWm4=fa_VEMaThR7hS1M4QK0wi2Vx4M4KGnwRQ@mail.gmail.com>
Subject: Re: [PATCH v2] docs/specs/riscv-iommu: Fixed broken link to external
 risv iommu document
To: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair.Francis@wdc.com, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Sun, Mar 2, 2025 at 11:07=E2=80=AFPM hemanshu.khilari.foss
<hemanshu.khilari.foss@gmail.com> wrote:
>
> The link to riscv iommu specification document is incorrect. This patch
> updates the said link to point to correct location.
>
> Cc: qemu-riscv@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2808
> Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  docs/specs/riscv-iommu.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
> index b1538c9ead..772145e8d7 100644
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
> @@ -107,7 +107,7 @@ riscv-iommu options:
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

