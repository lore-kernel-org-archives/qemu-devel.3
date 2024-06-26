Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33DCC2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 02:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMHMV-0000Dh-Uq; Tue, 25 Jun 2024 21:22:19 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMHMJ-0000CP-9e
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 21:22:04 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMHLa-0007N5-Af
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 21:21:51 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-80f537acbe3so1642833241.3; 
 Tue, 25 Jun 2024 18:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719364727; x=1719969527; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ulOsqEBoRq4wsE5vBZVR3s8sA5wvMKN2EKSzXkPW/w=;
 b=ZY6H2vr+sNCufNyRDyQa+IbyLRx1AKERuHSSd7WFKQUWSFALxMhRV8gyiDOH+cC93w
 FJNE1YzRQ3QZTKSoOFJzP3L1DvhT4YPEOVJdouyZLPIQqT/lStsiQ4VDjwwCjvRB9sG/
 Yf0kSKHY+exJim9WLw6Uw0q1/vauiNDbD19ylDujmJVlyOwed5UF2Hqotqe9p6/JbD27
 Lxj9Ic2YavuagQ9Epy3ds418snQcrRtB1+zEc9Igsckt8HXznKjfqpM8x979K1ff0UWY
 hwNrdALiHP/686KtmG4Q4U3dz4VzJgdzDEY550LFYG+ZPdRV9DhgE70yPjZdDJVB52ec
 7zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719364727; x=1719969527;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ulOsqEBoRq4wsE5vBZVR3s8sA5wvMKN2EKSzXkPW/w=;
 b=OrNAYh7Vpjryj9o2aTi9iSCAkOtjhgwH4XBMN8RDpR3GxBFlvrXmI2Ne2tPXEIEg14
 1PXV4/mN1cdvnne5xetxOmlIjN/Gt2BMwzCGc7XHOQckpl14gqFbo7JgBM2xskFpIz4A
 fpIU+UP5xOJtC28e6dLzg8htP91hn6HIbDg/P2wAKAXLkisV1uR4JtWaE680xiEHGySL
 56RSa8fLK+tjIhSiwDh8bAQ33A17lEgN4RUby1jOtKzKM1n2/TLXDuFs5UtpQEK0ADyU
 Tcl3YqmW7Il5UNtv0CZpBvUC721koyg/43VDhm+TEuh57oVT7f3MgWcad+rqLbt+kY5N
 u5Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV831zFDGbAB66cfpwnq88U5XCvUKIrzIPw3VLK28k7coaeUHbUcTqFWn1X6YzOIEQP700tFRoiqHunO74QU2M91Ddf7Dw=
X-Gm-Message-State: AOJu0YwTQgoJG6pSoB6SaBADM59fuBblanz0mQcsOL7Zbv/iWHE7iUa/
 WOYjGiMkqXa0JV6Vz1pB9nte49XREteBuvCr8U+4urkW5Wk8Kq+SOPD4FDWcmrnTdnWorxCmiTG
 htQH4s2G5nh6O716ElxwlMqfwyAM=
X-Google-Smtp-Source: AGHT+IEImWBt8rsBXSb38G1jYPsmNlEfHzgwSKekjTWAACAsg83/OjrFlczP0JoSXohsvGMNA+XWvhyH5gmINsDBhr0=
X-Received: by 2002:a67:f401:0:b0:48f:4261:2d4a with SMTP id
 ada2fe7eead31-48f52c3d62amr9288428137.34.1719364726719; Tue, 25 Jun 2024
 18:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
 <20240624201825.1054980-15-dbarboza@ventanamicro.com>
In-Reply-To: <20240624201825.1054980-15-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Jun 2024 11:18:20 +1000
Message-ID: <CAKmqyKM6g46UHZq=FxRrMeEw=rj-So9Q0zmvyHMfC9XFxR53fg@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] docs/specs: add riscv-iommu
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com, 
 frank.chang@sifive.com, jason.chien@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Jun 25, 2024 at 6:20=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Add a simple guideline to use the existing RISC-V IOMMU support we just
> added.
>
> This doc will be updated once we add the riscv-iommu-sys device.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  docs/specs/index.rst       |  1 +
>  docs/specs/riscv-iommu.rst | 55 ++++++++++++++++++++++++++++++++++++++
>  docs/system/riscv/virt.rst | 13 +++++++++
>  3 files changed, 69 insertions(+)
>  create mode 100644 docs/specs/riscv-iommu.rst
>
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 1484e3e760..c68cd9ae6c 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -33,3 +33,4 @@ guest hardware that is specific to QEMU.
>     virt-ctlr
>     vmcoreinfo
>     vmgenid
> +   riscv-iommu
> diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
> new file mode 100644
> index 0000000000..fa38ff7667
> --- /dev/null
> +++ b/docs/specs/riscv-iommu.rst
> @@ -0,0 +1,55 @@
> +.. _riscv-iommu:
> +
> +RISC-V IOMMU support for RISC-V machines
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU spec
> +version 1.0 [1].
> +
> +The emulation includes a PCI reference device, riscv-iommu-pci, that QEM=
U
> +RISC-V boards can use.  The 'virt' RISC-V machine is compatible with thi=
s
> +device.
> +
> +A platform device that implements the RISC-V IOMMU will be added in the
> +future.
> +
> +
> +riscv-iommu-pci reference device
> +--------------------------------
> +
> +This device implements the RISC-V IOMMU emulation as recommended by the =
section
> +"Integrating an IOMMU as a PCIe device" of [1]: a PCI device with base c=
lass 08h,
> +sub-class 06h and programming interface 00h.
> +
> +As a reference device it doesn't implement anything outside of the speci=
fication,
> +so it uses a generic default PCI ID given by QEMU: 1b36:0014.
> +
> +To include the device in the 'virt' machine:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci (...)
> +
> +As of this writing the existing Linux kernel support [2], not yet merged=
, is being
> +created as a Rivos device, i.e. it uses Rivos vendor ID.  To use the ris=
cv-iommu-pci
> +device with the existing kernel support we need to emulate a Rivos PCI I=
OMMU by
> +setting 'vendor-id' and 'device-id':
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 -M virt        \
> +     -device riscv-iommu-pci,vendor-id=3D0x1efd,device-id=3D0xedf1 (...)
> +
> +Several options are available to control the capabilities of the device,=
 namely:
> +
> +- "bus"
> +- "ioatc-limit"
> +- "intremap"
> +- "ats"
> +- "off" (Out-of-reset translation mode: 'on' for DMA disabled, 'off' for=
 'BARE' (passthrough))
> +- "s-stage"
> +- "g-stage"

These names don't jump out of the spec, so we probably want to at
least provide a sentence on what they mean/do.

Alistair

> +
> +
> +[1] https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/=
riscv-iommu.pdf
> +[2] https://lore.kernel.org/linux-riscv/cover.1718388908.git.tjeznach@ri=
vosinc.com/
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index 9a06f95a34..8e9a2e4dda 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -84,6 +84,19 @@ none``, as in
>
>  Firmware images used for pflash must be exactly 32 MiB in size.
>
> +riscv-iommu support
> +-------------------
> +
> +The board has support for the riscv-iommu-pci device by using the follow=
ing
> +command line:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci (...)
> +
> +Refer to :ref:`riscv-iommu` for more information on how the RISC-V IOMMU=
 support
> +works.
> +
>  Machine-specific options
>  ------------------------
>
> --
> 2.45.2
>
>

