Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4906BCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 01:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4UbX-0005fl-RC; Thu, 02 Oct 2025 21:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4UbV-0005fO-D8
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 21:29:01 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4UbL-0008P3-MW
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 21:29:00 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-62ec5f750f7so2681665a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 18:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759454926; x=1760059726; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nkwxz28O1WoLA/n8Tk4LlI3+YubAg4S2P97U8JEbWqw=;
 b=azvhH71YGpRjPKKHIuXETsmqgk6Bk8uSS42knAg8ZO5+chykffjFk3SBfhTzYkd7V3
 PbaoHFOqqKm9Qbhvnh+8ZIjrnhLuj9oPkpTDxjUwac1x64X6kImwzffzLA9PPHDKGVUq
 P/NqHfIH5He+fqs+RMMAig5YBwZ87nwpNKvanoXv7U6zVizkdDFqoOXUhapfkVhzW3Tb
 F27rXUNGWakEO29HI8gB5vvBSw7+3NLYBA43lT3PWgrYk+P0KQp/78ulQ4y/d4CZfkoy
 gTZlXq7nfKnABoS+U7V92aJO+aR5gRvvaDeL5/nyOne2ZZiBVE217TfvCP7FMo9rG5ng
 4bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759454926; x=1760059726;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nkwxz28O1WoLA/n8Tk4LlI3+YubAg4S2P97U8JEbWqw=;
 b=rIL8EcuCTLrfyEuykofdQZWOGXJUllS0JelKH5du5iprQsNm3JIS4hNexlAa7+Sc5y
 ip62NyBnoFdoEcDztw5mKFSl+dFKMSIQem5GxXKqJx+jtVv0tvXzKFgl/NYNjyj/2xQr
 XY6iUbbBgqnU5PvTAs+9wgC2sceHwnb7OMavZDnQgl/+Swis7QEXXe6vk+6qai8k6RXP
 mwnpdUGCEDwUm2iyV0JXCct3w2DenMX+4Jl7Q4hXCgsjCj07AmFX43rbbxJgjKVpdeQs
 qru2/Ih962/0M9cJhuo2yF28fwV08yENyuaLFXFtDy8jQ9v7aoP/VdmX1Q3XRQfw4VmA
 brTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG9LbecQ/QI3JKV9ONo0qfB+qhcERfrLLT9Mnqj68zRtyHKTyViHqfsMQ8wCNGOh9e2k61rdmk1eQn@nongnu.org
X-Gm-Message-State: AOJu0YzsJ6fEAC+8norF1ZYrN3T//xy1w2XqrZB6V3QB3US7WpHPaI7V
 sIRo+7nmNcCqZZYQPG/g6uSdO/f8F9VO8kx/VsKb8LZ8DskMrBkA8FpdgbSHlTSt1Y2QrOPEfgi
 YuT+ZaW+2bpvqrF5XnoOHfVgj0km3vXs=
X-Gm-Gg: ASbGncspOsS7Twq2iDVPhlXbubzEo9USobTW66IZziwCPETYFa7DV3o8gWcPRQVLfhu
 gTQjubznsG5NV6Y/b8XdZveR7BQTp8h0UM6sN3Qvl1uGbCCN4kRLZLezAPR03tIC1m8SzcgG0Mu
 DGmNOQzXU52xnIairqAbI4r580GASDDjMOlq4Iwa7zg2gB0HUBDPY6lmwqqTGc14SBr2nC565oq
 K4wGuSsE33f/91B68uHEfyeWlnA+s6WOeMiGDOrPBLHNAkANKENDPm856I9Mw==
X-Google-Smtp-Source: AGHT+IGg9QskivYnj/vKYs4JtAuMFr8PkvI830CY8Uh1aznK4pRvAviuVUWCw7HHeWRb23kxlefeFQP3M2TsCwxF6EU=
X-Received: by 2002:a17:907:7fa9:b0:b3f:9eaa:2bba with SMTP id
 a640c23a62f3a-b49c48a84f5mr160321766b.63.1759454925668; Thu, 02 Oct 2025
 18:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250814001452.504510-1-joel@jms.id.au>
In-Reply-To: <20250814001452.504510-1-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Oct 2025 11:28:19 +1000
X-Gm-Features: AS18NWCnJsH_fRBc_8QP834pXh-RuKN2m8f7KQcAQopPhHIxmmAjyuZD1huwS9Y
Message-ID: <CAKmqyKPTXP5jipsMt7Dcs5kH2gWrjzart_ZhjUOcGCHBRAsVNg@mail.gmail.com>
Subject: Re: [PATCH v2] docs: riscv-iommu: Update status of kernel support
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 14, 2025 at 10:17=E2=80=AFAM Joel Stanley <joel@jms.id.au> wrot=
e:
>
> The iommu Linux kernel support is now upstream. VFIO is still
> downstream at this stage.
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> v2:
>  - Fix VFIO link
>  - Fix qemu spelling
> ---
>  docs/specs/riscv-iommu.rst | 35 +++++++++++++----------------------
>  1 file changed, 13 insertions(+), 22 deletions(-)
>
> diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
> index 991d376fdc24..571a6a6cc963 100644
> --- a/docs/specs/riscv-iommu.rst
> +++ b/docs/specs/riscv-iommu.rst
> @@ -30,15 +30,15 @@ This will add a RISC-V IOMMU PCI device in the board =
following any additional
>  PCI parameters (like PCI bus address).  The behavior of the RISC-V IOMMU=
 is
>  defined by the spec but its operation is OS dependent.
>
> -As of this writing the existing Linux kernel support `linux-v8`_, not ye=
t merged,
> -does not have support for features like VFIO passthrough.  The IOMMU emu=
lation
> -was tested using a public Ventana Micro Systems kernel repository in
> -`ventana-linux`_.  This kernel is based on `linux-v8`_ with additional p=
atches that
> -enable features like KVM VFIO passthrough with irqbypass.  Until the ker=
nel support
> -is feature complete feel free to use the kernel available in the Ventana=
 Micro Systems
> -mirror.
> -
> -The current Linux kernel support will use the IOMMU device to create IOM=
MU groups
> +Linux kernel iommu support was merged in v6.13. QEMU IOMMU emulation can=
 be
> +used with mainline kernels for simple IOMMU PCIe support.
> +
> +As of v6.17, it does not have support for features like VFIO passthrough=
.
> +There is a `VFIO`_ RFC series that is not yet merged. The public Ventana=
 Micro
> +Systems kernel repository in `ventana-linux`_ can be used for testing th=
e VFIO
> +functions.
> +
> +The v6.13+ Linux kernel support uses the IOMMU device to create IOMMU gr=
oups
>  with any eligible cards available in the system, regardless of factors s=
uch as the
>  order in which the devices are added in the command line.
>
> @@ -49,7 +49,7 @@ IOMMU kernel driver behaves:
>
>    $ qemu-system-riscv64 \
>          -M virt,aia=3Daplic-imsic,aia-guests=3D5 \
> -        -device riscv-iommu-pci,addr=3D1.0,vendor-id=3D0x1efd,device-id=
=3D0xedf1 \
> +        -device riscv-iommu-pci,addr=3D1.0 \
>          -device e1000e,netdev=3Dnet1 -netdev user,id=3Dnet1,net=3D192.16=
8.0.0/24 \
>          -device e1000e,netdev=3Dnet2 -netdev user,id=3Dnet2,net=3D192.16=
8.200.0/24 \
>          (...)
> @@ -58,21 +58,11 @@ IOMMU kernel driver behaves:
>          -M virt,aia=3Daplic-imsic,aia-guests=3D5 \
>          -device e1000e,netdev=3Dnet1 -netdev user,id=3Dnet1,net=3D192.16=
8.0.0/24 \
>          -device e1000e,netdev=3Dnet2 -netdev user,id=3Dnet2,net=3D192.16=
8.200.0/24 \
> -        -device riscv-iommu-pci,addr=3D1.0,vendor-id=3D0x1efd,device-id=
=3D0xedf1 \
> +        -device riscv-iommu-pci,addr=3D3.0 \
>          (...)
>
>  Both will create iommu groups for the two e1000e cards.
>
> -Another thing to notice on `linux-v8`_ and `ventana-linux`_ is that the =
kernel driver
> -considers an IOMMU identified as a Rivos device, i.e. it uses Rivos vend=
or ID.  To
> -use the riscv-iommu-pci device with the existing kernel support we need =
to emulate
> -a Rivos PCI IOMMU by setting 'vendor-id' and 'device-id':
> -
> -.. code-block:: bash
> -
> -  $ qemu-system-riscv64 -M virt        \
> -     -device riscv-iommu-pci,vendor-id=3D0x1efd,device-id=3D0xedf1 (...)
> -
>  Several options are available to control the capabilities of the device,=
 namely:
>
>  - "bus": the bus that the IOMMU device uses
> @@ -84,6 +74,7 @@ Several options are available to control the capabiliti=
es of the device, namely:
>  - "g-stage": enable g-stage support
>  - "hpm-counters": number of hardware performance counters available. Max=
imum value is 31.
>    Default value is 31. Use 0 (zero) to disable HPM support
> +- "vendor-id"/"device-id": pci device ID. Defaults to 1b36:0014 (Redhat)
>
>  riscv-iommu-sys device
>  ----------------------
> @@ -111,6 +102,6 @@ riscv-iommu options:
>
>  .. _iommu1.0.0: https://github.com/riscv-non-isa/riscv-iommu/releases/do=
wnload/v1.0.0/riscv-iommu.pdf
>
> -.. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git.t=
jeznach@rivosinc.com/
> +.. _VFIO: https://lore.kernel.org/linux-riscv/20241114161845.502027-17-a=
jones@ventanamicro.com/
>
>  .. _ventana-linux: https://github.com/ventanamicro/linux/tree/dev-upstre=
am
> --
> 2.47.2
>
>

