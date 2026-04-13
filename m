Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF07DF34C52
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCHNo-0002zR-2n; Mon, 13 Apr 2026 09:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCHNj-0002z8-Q7
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:31:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCHNh-0008Rh-Hy
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:31:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488ad135063so42270845e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776087070; x=1776691870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5vcOHHKDRYP3xxw2rBt6Qey87y53kpywFzjN+QVxGM=;
 b=KYqzGyNjmRWZB+TvL5Kzi0j9QYwaOCc9zmjBglbdZqUBwlk2oSAqr/PlKoXxglqgHf
 JL8hPu4/qB86Bl5wE8o/EFy6jouM7rbtYyz6M6pTtH3REfgn41ZhmEaFtHVDgu3Ue97b
 FaSvEBUBRl2ZmPC2L6g/uAOzhy8i2neUumRcv0uLffiD55zU20X2t1EUbMzQDCb9bO/J
 dVCDVY0Y5smhRI5OzceMFRC8B2RGEq9zAyBpoZpo+3wTnLrJWL53mXjvu0zRTysPLxTW
 I2FgvSapg4Sl6Tp+8v5uOVKJ/UXFQY0xDoJZqjPCBwtrmVEgv5kptr5Uy0c1KVsFglZe
 FJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776087070; x=1776691870;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t5vcOHHKDRYP3xxw2rBt6Qey87y53kpywFzjN+QVxGM=;
 b=Jy34+pDiOkVUMvLq41itaWRoT9JSTISm/+DUL8GyQbnqusTBU0Q+Ds1cFv/ma/Qbd4
 UP5IIMWmmTGpeb/rfjjBCsx5jAgg8vHIam5u2noysGdr9Ixrnf20lZMjd1MZgyb+5sav
 jk7FlIsEsw6ITJ3DSHKK4sq8/aCnV9J5AWIDKc0qjIGUPKr4UMhca8wi0hrJ+7ZYSsC1
 LKbGaXWDUlcQzLBFblDBLx1dFO/zH41f9If/lLVs5WBnn5naGFqKPbzumBovHmd9KBSH
 unQ4mMrDbHiLss0cdPRKjnfQ5eogsx8qluRhn1+pQ8RLumhBVJPet0F2cKK6/zO/t3K3
 B4BA==
X-Gm-Message-State: AOJu0YwEQvAjanm5rwKUthco0c+NTWYjFKKykFbOWWOEi5Ta7jS+djRi
 tcly09mZWWN5spkpQLQc32KEhxM6F2FxGOYcXuFcshUUR+cFUhZIb0hUliyAeg==
X-Gm-Gg: AeBDietfdd+ERtqg+hKoR+1mzfBzxrhPy/R2OacMfoow2JK5v9Qal2ZRuxykn2p+Dhq
 vRMjqr0hzWwpvLK8TfehqttwZMM5ZtjzLRKer4dmrWHB5EZmh14k8iFfM6T3uY8+Gf2v+sStt9X
 kqu/FUC4SKFy5ZE3DATOMwI33hWHkPpFQWj13Ij3vrBLpSw/ukHnFbebAT0fbrStls9LVGTEjsS
 IDIewaUjLHOagLk7+Q+2Pte79O4fvDxip7E6NW2ksDfncjP2QWHzoMhVjAg/G/7Q9sfIfMpphYd
 Pzhv707JmJJr84Hgq3k796zppIsqUIWAF4FDBKZ7zyzpotW03M7+u2JyzL/1+F3LwVbLe2NLIvR
 /9n2E/0tmIvQeP9157djPukwKWBRKRO+AfBlrDz2p/64utAl7t5TknONkKtEjKSbpKeZTZQrb9T
 fNF0+GdthABTb69RI+BEnCqmf2TWuCJaWKuZlRIoVbUn52HksN03KDAVq7P36M0bR6MTgjS4FWQ
 EwB8Ypu/T5fPNUITxdk
X-Received: by 2002:a05:600c:8b27:b0:488:af7f:775f with SMTP id
 5b1f17b1804b1-488d68766c7mr169263335e9.18.1776087069877; 
 Mon, 13 Apr 2026 06:31:09 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf1c6100004fcff454cbdf8f.dip0.t-ipconnect.de.
 [2003:fa:af1c:6100:4f:cff4:54cb:df8f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d6839981sm96475135e9.21.2026.04.13.06.31.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 06:31:09 -0700 (PDT)
Date: Mon, 13 Apr 2026 13:31:06 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>
CC: pbonzini@redhat.com, peter.maydell@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv5_00/15=5D_Adding_comprehe?=
 =?US-ASCII?Q?nsive_support_for_i=2EMX8MM_EVK_board?=
In-Reply-To: <20260413073737.986219-1-gaurav.sharma_7@nxp.com>
References: <20260413073737.986219-1-gaurav.sharma_7@nxp.com>
Message-ID: <9BF9D1F9-DA94-41AE-8C81-2226B17E096A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
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



Am 13=2E April 2026 07:37:22 UTC schrieb Gaurav Sharma <gaurav=2Esharma_7@=
nxp=2Ecom>:

Hi Gurav,

>Changes in v5:
>- Fixed SoC object reference counting by using object_new_with_props()
>  instead of object_new() + object_property_add_child()
>- Merged imx8mm-evk=2Erst documentation into imx8mp-evk=2Erst to avoid
>  duplication and updated the title accordingly
>- Added on-chip RAM (OCRAM) support to match iMX8MP dev

I tried to apply v5 but I'm hitting the same issues as Patchew: <https://p=
atchew=2Eorg/QEMU/20260413073737=2E986219-1-gaurav=2Esharma=2E_5F7@nxp=2Eco=
m/> Mind resending a version rebased onto master?

Moreover, you may keep my R-b tags which I've given during v4=2E

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
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
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

