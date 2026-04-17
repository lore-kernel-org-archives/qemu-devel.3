Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20824F43689
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfcS-0004J0-Ce; Fri, 17 Apr 2026 05:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wDfcQ-0004Ik-E2
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:36:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wDfcO-0004n6-4r
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:36:10 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488b150559bso3950205e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 02:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776418566; x=1777023366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wln8V5vkw86wIpESTdwtYOSdtJhh5bJtSRh+wlnwG2M=;
 b=OJVyPHNJo/X/JaD7mQIifb+4RwY+RIoeiZryZwqoW3iA/+QKqAHu9O+Fwyl2IfKrpc
 Q2a3jWtdBasV77WybvTWRjjgvGnURtYNc0iVhFfag0fjO6MjjpkjZAtPtXodoBRm53VI
 EtAVYmnw/QkW8rgcIXvNA9E9pPESGw611xy6EDhuEPZaU5/cz1xNWJj9Ie08EFOqurBt
 daSK5L09EY+KGb/cKmk52Vsj/Yz0tJ9yqSCLjoOedAlwCQy4OsArMxQbchVUswTImaYy
 ZpoWyDkKhSar2zTuEpW9K0XBWmT5CATemNaKiiYqCRRUgQkOLSCCyyNufu9OhxviYOSX
 Ic+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776418566; x=1777023366;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wln8V5vkw86wIpESTdwtYOSdtJhh5bJtSRh+wlnwG2M=;
 b=LDsDpXBAJ/tFJdRzC0krxG0pHFsxsnMjRKqtS9K2350e4jBQBdjg5ic8kK6V2XSfXC
 8HqMfJY8PRpkPRph7g7HwTGwoKQf32MyW64eh5X3FLdldkvdUnhNfco9c4UANcQetHzG
 SdRrbvoUdErFy3TqyE7KmymiHoJX1C3wAlD1hPCGYljfOkqpsWIo6yaFitGXrTo5pXHq
 2qPSxJues8AQedM5ggPjT+b9vXazs09VVexoC12oOISi3GkuJAvj7OC9JVtyfs9SExFZ
 DSwQhZIkRTRKWmQ55g/YerLX7hN2ZEA5QpB7T6uhBHW6CwDk0Fg+Qb///QlBPMStGYE4
 SBhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WC8bF7OAQ1RBKrMGwntdU2mlVQ9nTOMwVTNu/ieqDUk9JYqj7oCpj0jiOC2d1wFBYwTwdUDSvYLOE@nongnu.org
X-Gm-Message-State: AOJu0Yz/IUSzqWEIOiOS9L/UJDcXhmHjoVKeb8bZKLFTDuUgMeeECDrh
 c1Jr/ZhHTP+M0xSGmIIjJw884VMPbNRF/Umez8gme9boBhSC+EwldC34
X-Gm-Gg: AeBDieuPxnKPaClvlCgmZc0qX8v7x5QooYD/QJ+ueOOSG5m54kXGKd3Vhu5aPT3Z7mx
 1UdIR36/Km4PTtjvl00SMn0q/nVUzunG/G5lGUPkJ/aqupTDNWlD/gnTwoBoMj8GApT+HN2Hu2m
 m+aLv9+6mEEFcBC7aLtxDXBm8s2IQp2c3IZgHTdqxFsY0FbubAK0qfZsBsB61zwLaDxNRjKmO3r
 VBO6nVOu7xjHwQHOTphGvav8iqD3g3KxT5N2qA9OPfUC+qryMVWaRX3v47hLesJOCGUEhm2l4NO
 M1Ju7q929RB5sUY2YARE4XlYKv05lSpIWd+FLzaGCQRrMlLCRlrztbFmErBDqQI9RTASbiDs5rM
 r5lGKwQj5BcluV+R/8IE1bJokGUCSJl/3QdOuwEchGhvReezOLDM8gDF54JkChTiEHc9upGGDeq
 BzmyCehSiDfjBI8NmX5QiJzNYY0rEAbiVWdqemXTThA+bm9HxNBUmy8y0lVJrad8+ksN9h758NA
 ExrWr5qlwbWiogmDCFfppcZ+RVg7BFhsucVBuLlr+4=
X-Received: by 2002:a05:6000:24ca:b0:43e:a70d:7632 with SMTP id
 ffacd0b85a97d-43fe3e0b463mr3112889f8f.25.1776418566152; 
 Fri, 17 Apr 2026 02:36:06 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf1c6100c87fe1c3d3c00c97.dip0.t-ipconnect.de.
 [2003:fa:af1c:6100:c87f:e1c3:d3c0:c97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc375dsm2910047f8f.14.2026.04.17.02.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 02:36:05 -0700 (PDT)
Date: Fri, 17 Apr 2026 09:36:03 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
CC: pbonzini@redhat.com, peter.maydell@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv6_00/15=5D_Adding_comprehe?=
 =?US-ASCII?Q?nsive_support_for_i=2EMX8MM_EVK_board?=
In-Reply-To: <20260414182313.1691519-1-gaurav.sharma_7@nxp.com>
References: <20260414182313.1691519-1-gaurav.sharma_7@nxp.com>
Message-ID: <90624B7D-1B69-48C0-A159-4837ED9A1CBA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 14=2E April 2026 18:22:58 UTC schrieb Gaurav Sharma <gaurav=2Esharma_7@=
nxp=2Ecom>:
>Changes in v6:
>- Fixed checkpatch errors
>- Moved maintainer entry of test_imx8mm_evk=2Epy to the patch 0015
>- Renamed imx8mp-evk=2Erst document name to imx8m=2Erst
>- Fixed warnings that are generated while building documentation
>
>Changes in v5:
>- Fixed SoC object reference counting by using object_new_with_props()
>  instead of object_new() + object_property_add_child()
>- Merged imx8mm-evk=2Erst documentation into imx8mp-evk=2Erst to avoid
>  duplication and updated the title accordingly
>- Added on-chip RAM (OCRAM) support to match iMX8MP dev

Please keep my R-b tags from v5=2E You can conveniently add them to all pa=
tches in the series using b4:

  b4 trailers -u -F 20260414182313=2E1691519-1-gaurav=2Esharma_7@nxp=2Ecom

where the last argument is the message ID of the cover letter of v5=2E See=
 <https://www=2Eqemu=2Eorg/docs/master/devel/submitting-a-patch=2Ehtml#use-=
b4> how to set up b4=2E

Best regards,
Bernhard

>
>Changes in v4:
>- Update Maintainers file
>- Re-used iMX8MP CCM and Analog IP for iMX8MM by introducing a variant
>  specific property
>- Split up the patch that enabled CCM and Analog in the previous
>  revision=2E Now we have 3 patches to enable CCM and Analog in iMX8MM
>- Updated copyrights
>- Removed '|| KVM' from hw/arm/Kconfig to prevent 'make check' failures
>
>Changes in v3:
>- Minor documentation change - Added KVM Acceleration section in docs/sys=
tem/arm/imx8mm-evk=2Erst
>
>Changes in v2:
>- Fixed the DTB offset in functional testing script test_imx8mm_evk=2Epy
>  and preserved alphabetical order of machine names in tests/functional/a=
arch64/meson=2Ebuild
>- Fixed a typo and updated the documentation
>- Modified structures type to static const in fsl-imx8mm=2Ec wherever
>  applicable=2E
>- Added CSI and DSI nodes to the nodes_to_remove list in imx8mm-evk=2Ec=
=2E This
>  is needed because the default DTB in the iMX LF BSP images have CSI
>  and DSI enabled=2E Developers/Hobbyists using these BSP images will
>  observe CSI and DSI crash logs on the console since these are unimpleme=
nted=2E
>  With this change, both debian and iMX LF images will boot up without an=
y issues=2E
>
>Changes in v1:
>
>This patch series adds support for the NXP i=2EMX8MM EVK (Evaluation Kit)
>board to QEMU, enabling emulation of this ARM Cortex-A53 based developmen=
t
>platform=2E
>
>The series includes:
>
>1=2E Core peripheral support (CCM clock controller, Analog module)
>2=2E GPT(General Purpose Timer) and WDT(Watchdog Timer) Emulation support
>3=2E GPIO,I2C,SPI,USDHC and USB Emulation support
>4=2E PCIe and ENET Controller Emulation support
>5=2E Documentation and functional test included
>
>Key features ported:
>- Basic boot support with Linux
>- UART console for serial communication
>- Interrupt handling
>- Clock and power management infrastructure
>
>Testing:
>- Linux kernel boots to console
>
>Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>=20
>
>
>Gaurav Sharma (15):
>  hw/arm: Add the i=2EMX 8MM EVK(Evaluation Kit) board
>  hw/misc/imx8mp_analog: Add property to analog device
>  hw/arm/fsl-imx8mm: Add Analog device IP to iMX8MM SOC
>  hw/arm/fsl-imx8mm: Add Clock Control Module IP to iMX8MM
>  hw/arm/fsl-imx8mm: Implemented support for SNVS
>  hw/arm/fsl-imx8mm: Adding support for USDHC storage controllers
>  hw/arm/fsl-imx8mm: Add PCIe support
>  hw/arm/fsl-imx8mm: Add GPIO controllers
>  hw/arm/fsl-imx8mm: Adding support for I2C emulation
>  hw/arm/fsl-imx8mm: Adding support for SPI controller
>  hw/arm/fsl-imx8mm: Adding support for Watchdog Timers
>  hw/arm/fsl-imx8mm: Adding support for General Purpose Timers
>  hw/arm/fsl-imx8mm: Adding support for ENET ethernet controller
>  hw/arm/fsl-imx8mm: Adding support for USB controller
>  hw/arm/fsl-imx8mm: Adding functional testing of iMX8MM emulation
>
> MAINTAINERS                                   |  12 +-
> docs/system/arm/{imx8mp-evk=2Erst =3D> imx8m=2Erst} |  35 +-
> docs/system/target-arm=2Erst                    |   2 +-
> hw/arm/Kconfig                                |  24 +
> hw/arm/fsl-imx8mm=2Ec                           | 704 ++++++++++++++++++
> hw/arm/imx8mm-evk=2Ec                           | 130 ++++
> hw/arm/meson=2Ebuild                            |   2 +
> hw/misc/imx8mp_analog=2Ec                       |  12 +-
> hw/timer/imx_gpt=2Ec                            |  26 +
> include/hw/arm/fsl-imx8mm=2Eh                   | 242 ++++++
> include/hw/misc/imx8mp_analog=2Eh               |   3 +
> include/hw/timer/imx_gpt=2Eh                    |   2 +
> tests/functional/aarch64/meson=2Ebuild          |   2 +
> tests/functional/aarch64/test_imx8mm_evk=2Epy   |  67 ++
> 14 files changed, 1253 insertions(+), 10 deletions(-)
> rename docs/system/arm/{imx8mp-evk=2Erst =3D> imx8m=2Erst} (68%)
> create mode 100644 hw/arm/fsl-imx8mm=2Ec
> create mode 100644 hw/arm/imx8mm-evk=2Ec
> create mode 100644 include/hw/arm/fsl-imx8mm=2Eh
> create mode 100755 tests/functional/aarch64/test_imx8mm_evk=2Epy
>

