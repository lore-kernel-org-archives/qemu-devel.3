Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7535C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 00:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzQ9S-00024s-Bb; Tue, 23 Apr 2024 20:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rzQ9N-00023L-W9
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 20:06:14 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rzQ9M-0003dR-7C
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 20:06:13 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4dac4791267so1602751e0c.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 17:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713917171; x=1714521971; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJ0APwPiQl9ZejBsVtFGRaWjF1f3F9rtWwnlfBDDCdo=;
 b=W3XiFCnQGIW77ix8UkN3WAsc5WqKF5E3tVHgKtsdi6U06GAtE6uJxanLPBnhFTbKfg
 3+mqZg2cXpitZ/HhyC/N+bba/yvlgTj2fMODG0ffZK7uytyclbarewINdaCYy8cDcoGP
 5T1+mG+knM37c0MngEJeMuFPsy+JpPKtB5usJodXBvmaRZ+ZRx/9GsiSObjYMEop3Ntq
 i9an2cSSSrNGBhRNYJjclPCQQfLOyDPWNlbJdNrf54fyjViN61n7oG9ahUn4CzNs0gFF
 7WASM1pDVwobWQ+dQk+c01QAuWbM52nJYR2wacAMI2pcgqDsJ8oIXb3gMA1f+qoZXQkl
 MsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713917171; x=1714521971;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJ0APwPiQl9ZejBsVtFGRaWjF1f3F9rtWwnlfBDDCdo=;
 b=kuOs2Ug5vdi+hAdQaugeYgWXC1KXcQMHRrf3hqmU3zJWcDlL+iEtI33SDvxNCpprjL
 dB4rSdCy6c49M2CjVEcYXodl05J+oSH5E9YvHZRGgAh6jPUoVuGS0gcWFF/kNVTiL31Q
 elg9GlE1+IUfuSB3znzn+O5CIcpisOFivjI23bF4EObbXzFI8BIO5PZEzaqTbGMyazBu
 Lg0wJkzVAI8hDJns++KjX6WnMPhfxzUJEM1Jd/bZhZ5YSTKv4CJ94G8tqqh+BeVd7GZU
 hCT/BFnj4st1o0qpZ4eGpA8ZQU1UfsjkrkoZ3e1iGYaiQNhHv/lt7cj0IvvZOhZo6UCn
 PwCg==
X-Gm-Message-State: AOJu0YzCGO+5yJBLiJgr97d5O/xtEgOwXOd340AapKk7WZYnfdbMUilP
 +VXvgOyYr5rNpeHgHhW3Vqnsa89XEDzTSXpglzjyfb20upxZpohzT7dTLDjvg3CuMRSB6VYQj5d
 xNIgEn2zabisiznFfV76yGCRStXc=
X-Google-Smtp-Source: AGHT+IFrbt75HyopuzzsGOyjFx7PqhPitXg4OKcgoQ7hVpza+INQB8NAFj09uDT9pg0ONYj+7B2ORUP7IeQ+w40UmLA=
X-Received: by 2002:a05:6122:1816:b0:4d4:16ed:3ae4 with SMTP id
 ay22-20020a056122181600b004d416ed3ae4mr1177284vkb.14.1713917170786; Tue, 23
 Apr 2024 17:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-17-pbonzini@redhat.com>
In-Reply-To: <20240423131612.28362-17-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 24 Apr 2024 10:05:44 +1000
Message-ID: <CAKmqyKPCHqNs0VEhH0A52R7YN8ULF0Wpwbc3Oj_HKpF-szsS0Q@mail.gmail.com>
Subject: Re: [PATCH 16/22] riscv: switch boards to "default y"
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, farosas@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Tue, Apr 23, 2024 at 11:20=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> Some targets use "default y" for boards to filter out those that require
> TCG.  For consistency we are switching all other targets to do the same.
> Continue with RISC-V.
>
> No changes to generated config-devices.mak file.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  configs/devices/riscv32-softmmu/default.mak | 13 ++++++-------
>  configs/devices/riscv64-softmmu/default.mak | 15 +++++++--------
>  hw/riscv/Kconfig                            | 14 ++++++++++++++
>  3 files changed, 27 insertions(+), 15 deletions(-)
>
> diff --git a/configs/devices/riscv32-softmmu/default.mak b/configs/device=
s/riscv32-softmmu/default.mak
> index 07e4fd26df3..c2cd86ce05f 100644
> --- a/configs/devices/riscv32-softmmu/default.mak
> +++ b/configs/devices/riscv32-softmmu/default.mak
> @@ -4,10 +4,9 @@
>  # CONFIG_PCI_DEVICES=3Dn
>  # CONFIG_TEST_DEVICES=3Dn
>
> -# Boards:
> -#
> -CONFIG_SPIKE=3Dy
> -CONFIG_SIFIVE_E=3Dy
> -CONFIG_SIFIVE_U=3Dy
> -CONFIG_RISCV_VIRT=3Dy
> -CONFIG_OPENTITAN=3Dy
> +# Boards are selected by default, uncomment to keep out of the build.
> +# CONFIG_SPIKE=3Dn
> +# CONFIG_SIFIVE_E=3Dn
> +# CONFIG_SIFIVE_U=3Dn
> +# CONFIG_RISCV_VIRT=3Dn
> +# CONFIG_OPENTITAN=3Dn
> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/device=
s/riscv64-softmmu/default.mak
> index 221963d4c5c..39ed3a0061a 100644
> --- a/configs/devices/riscv64-softmmu/default.mak
> +++ b/configs/devices/riscv64-softmmu/default.mak
> @@ -4,11 +4,10 @@
>  # CONFIG_PCI_DEVICES=3Dn
>  # CONFIG_TEST_DEVICES=3Dn
>
> -# Boards:
> -#
> -CONFIG_SPIKE=3Dy
> -CONFIG_SIFIVE_E=3Dy
> -CONFIG_SIFIVE_U=3Dy
> -CONFIG_RISCV_VIRT=3Dy
> -CONFIG_MICROCHIP_PFSOC=3Dy
> -CONFIG_SHAKTI_C=3Dy
> +# Boards are selected by default, uncomment to keep out of the build.
> +# CONFIG_SPIKE=3Dn
> +# CONFIG_SIFIVE_E=3Dn
> +# CONFIG_SIFIVE_U=3Dn
> +# CONFIG_RISCV_VIRT=3Dn
> +# CONFIG_MICROCHIP_PFSOC=3Dn
> +# CONFIG_SHAKTI_C=3Dn
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 5d644eb7b16..b2955a8ae77 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -8,6 +8,8 @@ config IBEX
>
>  config MICROCHIP_PFSOC
>      bool
> +    default y
> +    depends on RISCV64
>      select CADENCE_SDHCI
>      select MCHP_PFSOC_DMC
>      select MCHP_PFSOC_IOSCB
> @@ -20,12 +22,16 @@ config MICROCHIP_PFSOC
>
>  config OPENTITAN
>      bool
> +    default y
> +    depends on RISCV32
>      select IBEX
>      select SIFIVE_PLIC
>      select UNIMP
>
>  config RISCV_VIRT
>      bool
> +    default y
> +    depends on RISCV32 || RISCV64
>      imply PCI_DEVICES
>      imply VIRTIO_VGA
>      imply TEST_DEVICES
> @@ -50,6 +56,8 @@ config RISCV_VIRT
>
>  config SHAKTI_C
>      bool
> +    default y
> +    depends on RISCV64
>      select RISCV_ACLINT
>      select SHAKTI_UART
>      select SIFIVE_PLIC
> @@ -57,6 +65,8 @@ config SHAKTI_C
>
>  config SIFIVE_E
>      bool
> +    default y
> +    depends on RISCV32 || RISCV64
>      select RISCV_ACLINT
>      select SIFIVE_GPIO
>      select SIFIVE_PLIC
> @@ -67,6 +77,8 @@ config SIFIVE_E
>
>  config SIFIVE_U
>      bool
> +    default y
> +    depends on RISCV32 || RISCV64
>      select CADENCE
>      select RISCV_ACLINT
>      select SIFIVE_GPIO
> @@ -83,6 +95,8 @@ config SIFIVE_U
>
>  config SPIKE
>      bool
> +    default y
> +    depends on RISCV32 || RISCV64
>      select RISCV_NUMA
>      select HTIF
>      select RISCV_ACLINT
> --
> 2.44.0
>
>

