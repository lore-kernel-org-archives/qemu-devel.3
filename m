Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A90BF9D0CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 12:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCdJR-0002NW-PY; Tue, 14 Apr 2026 08:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCdJM-0002MY-4U
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 08:56:13 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCdJK-0001pN-4e
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 08:56:11 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso1359887f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 05:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776171368; x=1776776168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cipN3wxzUuC12n9kYMrK1ldVmk7FWHJ23evv2/U0hx8=;
 b=gZ67hWltjZXk7uAClWniBmIVhTgdMgXGQw3YUeT+lIEH61dTaVHLnbxNdQ0DbnF4ct
 znwCY/JsTe//FFDuJ0ixyisXFsOenmUHdRf893LGmaj/SNL+AojOhNgd+GfHQaGgsCCl
 jmsUwpykwu8yuI/KCSAEQF9O/+h0Zz0OA1X6b8XbKskqc4CSrlZUhY+Vr3gB0rJVFApm
 yfBNuuf3b+1W1xWL/NPzpy2EU5oMKyU/xIUyU8zOZn82fUgkn5ONQxYiP791K/OtXBLv
 miJup0w/+15yI79N+U0FUjGwlbdnm02NYogH7lBK+bJCyHW3MRE3k3/OnrUHduJQRJHT
 1/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776171368; x=1776776168;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cipN3wxzUuC12n9kYMrK1ldVmk7FWHJ23evv2/U0hx8=;
 b=TWTC2m/n5Ln1rWl53A2tvq07GINWuqSTv1paxIp2DEswFKs3olAMr1vDSch5Wfz9TV
 PjF/sSSPrU7bGd+GS8C+UqeiAsc6xi1bL5z0uztpqzNDYjb7eFrKJ41x2LqtIyN/r2yy
 IMAsSvqxoYDAE05WtA2bOoZlgrpVxl3wpXEfvu6ddXPj2sYdKlfeO29w5LqkI/TwWXhZ
 vIoi7gI0Ua+vDp0lMvE/6dI15wKVykz6T3UWw6AdYenAavWEffjYyeApfVs8WnoLseW+
 RU2KQvSQ0mTbIMX/v7ehVsjkECIuB8O7EteEpGzD8dDgkPD7Gek0TLFCnnERoZw+YTzb
 GBeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VHEUtfKZ/y9TEptH/YLwB4+KmXMVEMzemD55gcyNhe4s5TpWb//gNfFk7U3+g5njeSnEcE746NrFD@nongnu.org
X-Gm-Message-State: AOJu0YwmTjdnkY+rL5WHraye9FV20QwiJE6u0mXjureXn6kjo/PT1vHN
 FhIRB1LDLGrJW3f6DdJi/k8GOSkqgc5fbgmdrAdPm3j0kbQkjPjgsAPT
X-Gm-Gg: AeBDiesnlk3NMPcgEl0BqPfDnnIJaEpi+MQBsEEEc4DZDf6jxocDhnVtNzK+sAB8yfL
 zt6BnVo4luiEjEWLoxTO2OmmmVOzszo21ufERDijurHphf/xqckCSn0XkgNsLwqkUyMYH674rHS
 I4KvZd0nmZ79sW3b7Mt2ypx9gdmXcy9hmJ715R2JYDthCotl9WLTiW+pr4mEUTQs8V9vb3bKyQt
 tgfpBW1p/yE0TaaGqC3y8E21bi6adQPWrz97j03qXkOWInOzqndEWRPMVcG2DWrJhNchY4RWD6m
 wy+jnX2qqvLvK79yh8FQCRR0nvUvhx3fghiLgaChSY4T0ytuIDOYH1T/IxX/pd+oaJ8t+IuFtWd
 1cO2Vbhqy8+b6UsOVzTZjGbL6VPV02sAC+2ZLOIAZLiqeLo53Yc1iuqVlvr0dddxufUNRngeMjk
 pRV8pmirKsZ55Bi1yV6Qpfdoui2qlmqwJ/4p+UgWUuxVjGOfUTHAANfud1Dsx+AznjAHB7t7ZqC
 lzHUK+/NmGAJocfW7Cg
X-Received: by 2002:a5d:5889:0:b0:43d:77f4:7149 with SMTP id
 ffacd0b85a97d-43d77f475d9mr12925946f8f.48.1776171368225; 
 Tue, 14 Apr 2026 05:56:08 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf1c6100004fcff454cbdf8f.dip0.t-ipconnect.de.
 [2003:fa:af1c:6100:4f:cff4:54cb:df8f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d6a1203b8sm37192387f8f.16.2026.04.14.05.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 05:56:07 -0700 (PDT)
Date: Tue, 14 Apr 2026 12:56:05 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
CC: pbonzini@redhat.com, peter.maydell@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv5_00/15=5D_Adding_comprehe?=
 =?US-ASCII?Q?nsive_support_for_i=2EMX8MM_EVK_board?=
In-Reply-To: <20260414053715.1378021-1-gaurav.sharma_7@nxp.com>
References: <20260414053715.1378021-1-gaurav.sharma_7@nxp.com>
Message-ID: <D3770294-A42E-4D24-8BF6-1E2B554DCF04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 14=2E April 2026 05:37:00 UTC schrieb Gaurav Sharma <gaurav=2Esharma_7@=
nxp=2Ecom>:
>Changes in v5:
>- Fixed SoC object reference counting by using object_new_with_props()
>  instead of object_new() + object_property_add_child()
>- Merged imx8mm-evk=2Erst documentation into imx8mp-evk=2Erst to avoid
>  duplication and updated the title accordingly
>- Added on-chip RAM (OCRAM) support to match iMX8MP dev

Checkpatch raises several errors (you may ignore its warnings)=2E Reproduc=
e in the QEMU root src dir with the following command:

  =2E/scripts/checkpatch=2Epl --branch origin/master=2E=2E

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
> MAINTAINERS                                 |  10 +
> docs/system/arm/imx8mp-evk=2Erst              |  33 +-
> docs/system/target-arm=2Erst                  |   1 +
> hw/arm/Kconfig                              |  24 +
> hw/arm/fsl-imx8mm=2Ec                         | 704 ++++++++++++++++++++
> hw/arm/imx8mm-evk=2Ec                         | 130 ++++
> hw/arm/meson=2Ebuild                          |   2 +
> hw/misc/imx8mp_analog=2Ec                     |  12 +-
> hw/timer/imx_gpt=2Ec                          |  26 +
> include/hw/arm/fsl-imx8mm=2Eh                 | 242 +++++++
> include/hw/misc/imx8mp_analog=2Eh             |   3 +
> include/hw/timer/imx_gpt=2Eh                  |   2 +
> tests/functional/aarch64/meson=2Ebuild        |   2 +
> tests/functional/aarch64/test_imx8mm_evk=2Epy |  67 ++
> 14 files changed, 1251 insertions(+), 7 deletions(-)
> create mode 100644 hw/arm/fsl-imx8mm=2Ec
> create mode 100644 hw/arm/imx8mm-evk=2Ec
> create mode 100644 include/hw/arm/fsl-imx8mm=2Eh
> create mode 100755 tests/functional/aarch64/test_imx8mm_evk=2Epy
>

