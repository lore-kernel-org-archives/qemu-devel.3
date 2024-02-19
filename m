Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E68C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 11:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc25m-0003b9-1q; Mon, 19 Feb 2024 06:45:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rc25j-0003aI-0p; Mon, 19 Feb 2024 06:45:47 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rc25g-0003Ca-IH; Mon, 19 Feb 2024 06:45:46 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 757EE4E6013;
 Mon, 19 Feb 2024 12:45:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id fuFbzYepQpRx; Mon, 19 Feb 2024 12:45:38 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8510C4E6003; Mon, 19 Feb 2024 12:45:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 83DEE7456B4;
 Mon, 19 Feb 2024 12:45:38 +0100 (CET)
Date: Mon, 19 Feb 2024 12:45:38 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH 2/7] hw/ide: Split qdev.c into ide-bus.c and ide-dev.c
In-Reply-To: <20240219104912.378211-3-thuth@redhat.com>
Message-ID: <d2bbe138-72d8-dd66-255b-d3288157dd2d@eik.bme.hu>
References: <20240219104912.378211-1-thuth@redhat.com>
 <20240219104912.378211-3-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 19 Feb 2024, Thomas Huth wrote:
> qdev.c is a mixture between IDE bus specific functions and IDE device
> functions. Let's split it up to make it more obvious which part is
> related to bus handling and which part is related to device handling.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
> hw/ide/ide-bus.c             | 111 +++++++++++++++++++++++++++++++++++
> hw/ide/{qdev.c => ide-dev.c} |  87 +--------------------------
> hw/arm/Kconfig               |   2 +
> hw/ide/Kconfig               |  30 ++++++----
> hw/ide/meson.build           |   3 +-
> 5 files changed, 134 insertions(+), 99 deletions(-)
> create mode 100644 hw/ide/ide-bus.c
> rename hw/ide/{qdev.c => ide-dev.c} (78%)
[...]
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 29abe1da29..b372b819a4 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -275,6 +275,8 @@ config SBSA_REF
>     select USB_XHCI_SYSBUS
>     select WDT_SBSA
>     select BOCHS_DISPLAY
> +    select IDE_BUS
> +    select IDE_DEV
>
> config SABRELITE
>     bool
> diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
> index b93d6743d5..6dfc5a2129 100644
> --- a/hw/ide/Kconfig
> +++ b/hw/ide/Kconfig
> @@ -1,51 +1,58 @@
> config IDE_CORE
>     bool
>
> -config IDE_QDEV
> +config IDE_BUS
>     bool
>     select IDE_CORE

Maybe we can assume if something has an IDE bus it also wants to connect 
IDE devices to it so just select IDE_DEV here and not at every place 
IDE_BUS is selected? Or is there a place that only wants IDE_BUS?

Regards,
BALATON Zoltan

> +config IDE_DEV
> +    bool
> +    depends on IDE_BUS
> +
> config IDE_PCI
>     bool
>     depends on PCI
> -    select IDE_QDEV
> +    select IDE_BUS
> +    select IDE_DEV
>
> config IDE_ISA
>     bool
>     depends on ISA_BUS
> -    select IDE_QDEV
> +    select IDE_BUS
> +    select IDE_DEV
>
> config IDE_PIIX
>     bool
>     select IDE_PCI
> -    select IDE_QDEV
>
> config IDE_CMD646
>     bool
>     select IDE_PCI
> -    select IDE_QDEV
>
> config IDE_MACIO
>     bool
> -    select IDE_QDEV
> +    select IDE_BUS
> +    select IDE_DEV
>
> config IDE_MMIO
>     bool
> -    select IDE_QDEV
> +    select IDE_BUS
> +    select IDE_DEV
>
> config IDE_VIA
>     bool
>     select IDE_PCI
> -    select IDE_QDEV
>
> config MICRODRIVE
>     bool
> -    select IDE_QDEV
> +    select IDE_BUS
> +    select IDE_DEV
>     depends on PCMCIA
>
> config AHCI
>     bool
> -    select IDE_QDEV
> +    select IDE_BUS
> +    select IDE_DEV
>
> config AHCI_ICH9
>     bool
> @@ -56,8 +63,7 @@ config AHCI_ICH9
> config IDE_SII3112
>     bool
>     select IDE_PCI
> -    select IDE_QDEV
>
> config IDE_CF
>     bool
> -    default y if IDE_QDEV
> +    default y if IDE_BUS
> diff --git a/hw/ide/meson.build b/hw/ide/meson.build
> index d2e5b45c9e..d09705cac0 100644
> --- a/hw/ide/meson.build
> +++ b/hw/ide/meson.build
> @@ -1,15 +1,16 @@
> system_ss.add(when: 'CONFIG_AHCI', if_true: files('ahci.c'))
> system_ss.add(when: 'CONFIG_AHCI_ICH9', if_true: files('ich.c'))
> system_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('ahci-allwinner.c'))
> +system_ss.add(when: 'CONFIG_IDE_BUS', if_true: files('ide-bus.c'))
> system_ss.add(when: 'CONFIG_IDE_CF', if_true: files('cf.c'))
> system_ss.add(when: 'CONFIG_IDE_CMD646', if_true: files('cmd646.c'))
> system_ss.add(when: 'CONFIG_IDE_CORE', if_true: files('core.c', 'atapi.c'))
> +system_ss.add(when: 'CONFIG_IDE_DEV', if_true: files('ide-dev.c'))
> system_ss.add(when: 'CONFIG_IDE_ISA', if_true: files('isa.c', 'ioport.c'))
> system_ss.add(when: 'CONFIG_IDE_MACIO', if_true: files('macio.c'))
> system_ss.add(when: 'CONFIG_IDE_MMIO', if_true: files('mmio.c'))
> system_ss.add(when: 'CONFIG_IDE_PCI', if_true: files('pci.c'))
> system_ss.add(when: 'CONFIG_IDE_PIIX', if_true: files('piix.c', 'ioport.c'))
> -system_ss.add(when: 'CONFIG_IDE_QDEV', if_true: files('qdev.c'))
> system_ss.add(when: 'CONFIG_IDE_SII3112', if_true: files('sii3112.c'))
> system_ss.add(when: 'CONFIG_IDE_VIA', if_true: files('via.c'))
> system_ss.add(when: 'CONFIG_MICRODRIVE', if_true: files('microdrive.c'))
>

