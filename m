Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D4EC19F32
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 00:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1totYE-0007bE-H5; Sun, 02 Mar 2025 19:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1totYA-0007Vr-0H; Sun, 02 Mar 2025 19:20:50 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1totY7-0003Wm-El; Sun, 02 Mar 2025 19:20:49 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-5236d34a37fso595835e0c.3; 
 Sun, 02 Mar 2025 16:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740961244; x=1741566044; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KPwCWdcoMhh3y5danql1RTaIbOlgclZJ9bSTtKH/Pb4=;
 b=M0ux6ftgIifzaGoqAZn1dnLb2NOs0fnTK89ShP0zG1PpQkXNKqbxuRr3wfR8Q5imWI
 tS9C3t8Dje47smTCP4DEVA5DOWJMnLyhuNJSfdt9XjMNa6LYGlbHFPR1lmxZO8pXYI/d
 vg/9ZPrnb/PKOFywdpcm0uFR71/7g6sGqnTC/ox0JBK8GWviSwBL2actlnHB50vbMbR9
 qf7nfNWA98k+FK3yC9KGSo7b1iPHMTKCpcleSySZTQtGzCENEW0QUW6Qf4LGy7CQ3goa
 O1JGFDSSJtOSPv1cYoBz5xATBuRWxGuH0Mj9/m8HtXqupgoENfMBontC6njv4jPxdM+N
 lkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740961244; x=1741566044;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KPwCWdcoMhh3y5danql1RTaIbOlgclZJ9bSTtKH/Pb4=;
 b=CE78C8lgmkXfTlg0Uz6JFItooH4hthckcFmYUd1su618w1KqgFi54oumQvSuHtC83i
 Ikmr87MRyZA7+go/1Lmg20ZeOzDE1Bf9q0WTiKDxxvi2HUJ/anZwyETqC+dsQyNYKP0h
 3Be8cvlGHRZ5LB8f/fMS8h9Omk6qgwbOZt+4t9E08WoAL14qZfX0DHz/qjHBvpIrRTAl
 dPK31CrGzwvb0fPbAcq0DNw5i4hdQP5m9Fsu8y8OSx8LBF5QYa7quynbZunqVEVIUNI0
 7NPchFpRNKxeLQk1hKTkaRo3oi22ZeMFBNmIwQ/FgZTG9aJztutQGDmH0N7DBCsdZQ7a
 vdgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFHfQpbfvC19uKOE1OUZ8fnz/PET35HMS9NRMKrPtG9cysw0MlUqSIcYOxBRKgzPhWZxydyiiuyp35@nongnu.org
X-Gm-Message-State: AOJu0YyfHs7V+RcsVb1EQ/OwrUlbT5OhBrx6wlpyhLPU3t/kKYWJjq9m
 L5KvHkGY0ofj7O5eQyyNw0/1xfjpUcDombo5/7T7E+jCQXkq2ohqT08MW0+jbjnHWkA0QBx/HZd
 lBSKUaD2OpJgFLVDYoByYGj0WVdk=
X-Gm-Gg: ASbGncsjH6ubBk5ZF6ILyllH8/50s+TYDCXJgER9kLW7/Dqfb0NEnUcMVs4lcOJCSfO
 /XlbrGRgPC1Cc5gYq/18OxAvjYYwRGd3YH4/q9fqDEKQYS7xCjD7ijRjhwpulUEFHdfKpFNxlqZ
 WZ1uNu53kKBgB97FGW0hPwTEmqcJumQxUXflSd7lt3D6jRoQXMMIdAbOIV
X-Google-Smtp-Source: AGHT+IGsptj714yteR5swNprcpFr886k+nknQaCQBcvnOMgZXlW+NiuVqDOZ1EGU2qwyDyKoZ/bNrewWRMGGHQ41HLI=
X-Received: by 2002:a05:6122:3382:b0:51f:3e67:75df with SMTP id
 71dfb90a1353d-5235b8cc4d0mr6843744e0c.10.1740961244645; Sun, 02 Mar 2025
 16:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20250302130618.25688-2-hemanshu.khilari.foss@gmail.com>
In-Reply-To: <20250302130618.25688-2-hemanshu.khilari.foss@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Mar 2025 10:20:18 +1000
X-Gm-Features: AQ5f1Jp_PT7CTlAGk9rMaurQOwjteouGJyKBqiF4armMBq8b3zH2SAgOQz60O40
Message-ID: <CAKmqyKPyTRNTb92D7GLsWmYdkapo4ev88u3k_xtH9XALRZi-8A@mail.gmail.com>
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

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

