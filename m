Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D72CCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfmZ-0002Go-VS; Mon, 05 Oct 2026 06:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfm4-0002E5-RB
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:30 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfm0-0000tu-4J
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:21 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48b01c4f4daso1274617f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195498; x=1791800298; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=f47AbJC9WyThfLCVVK5eZtwGzw1GZhhu1L6TKd9diQw=;
 b=cD2ts5NtB7xSoqSEDDueBSLOdBfz8a5icS5YVpvK4EUqC7cjWXQzNQTvLuPiI3sODs
 lwXKK6dxxjIk9gDFmSduu45pr6+JgKMuDjfhimJLMs22g12q8mlGRaenRYdB689lTuIK
 zE9brRA7A4rJ9uibxhUGs+nNVtIxMbPv0NeFeMg6BB+fXWhO7oYZ5Lo1R3ddDIrPyOo7
 222p+zm5JTFpzero2qZ0nd5QhO4uB9l1MEdj3FXp7nX69XHGfP50aMoL102hsIVF/g/9
 VbeA9NCyupKQ9fSckY/NKH1Msefh+VZBfGTynJI3JvXa6/aAiryfXsxzb7bWZa11a0hw
 V4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195498; x=1791800298;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f47AbJC9WyThfLCVVK5eZtwGzw1GZhhu1L6TKd9diQw=;
 b=nBSWJB+QWcvxhGq/OzYAxtjOy6FxzoF2Olqiwz4+sggk4UZKLGSgc9NxsI0L/wpST4
 PxGpNwwDqkEEaGleAadjAalQ11gstLDh+i0iH4YYT4dA+I8yfh/5ASyCWDfPxakt4etY
 xDUfABXXJii0F8XDCfmq6LSUjVleeJhxcuJSEK3Dca0q1EnEOdRsslmwyzM4Q9aXbUPF
 Hzvq13k+Bsnh0QwkZFAIuTiUzrQ6YrIwAHx5G2rGqHFh9HhQtn7xlPq9k8wrklR0bcJq
 kxjJe33CDojt80BjIIFrkCgdZwmmUZ8wKrjzBNAxDVAB2Mfbkn5zHrXQ3Oyej7hgJg0d
 fUlQ==
X-Gm-Message-State: AFq9FYLKPlNTnRxtIY8qXH/wqHPy6fFU5It0jJ+sg/HwF/qfc0NvRYQ6
 uMruKRmihaVjeNtJN2niQ/1dPqpI26av037bmPIpV8QKhef/wai+FfoWHRucig==
X-Gm-Gg: AYBFou2B23yQ/Y+1Epq3AQwLEmSpWmMiJ0H4/l/VB7EvJ7wwc/KJ4xESrxf6/GW4NTa
 ENgID4T2LPDUcGzdCL8R6NcilLJOxjoKhBFiBtcjr5wGEGP8W61Wyl5mUt2GtXRCI8NZC4XQC8s
 ie/G7f9j2z2EUm4uTy5I477sQHOMh0R/biC3yGn8osJ9Ee4o31YX50JBzs9JUN9nZxJCmUp3m8p
 fT/opTQybCptI9nGtBzUrwE6n5FMUtZRsh25i9VMT6y/e+eNudpekJUlrNkk9L16MfkHs7CS29G
 G5uXUcfB6QEU5HweApvoCxaJL3rXlJAWM0rXakOWSNittLYSgwqr3TvtxZgEadi2c066J2lZBdt
 xDAy0lym9NwfaItk1SLCe6TO0rFS1/Ro8luDEKb7cGkw1Rwnj0JjsJTIgI3vC3D3TT6Az8PNW7q
 9EaC6iaTT1rGAIf4Psq/9101+ThnufGcV0oHwQm5lU8N+qfPDfiaYssWXn9fpZno26Yt6hyBmP9
 Aslt890odVFdjy9KiY0k7OrEsSDLPUyJZe8ZQ==
X-Received: by 2002:a05:6000:2909:b0:48a:fc9a:3765 with SMTP id
 ffacd0b85a97d-48b1273e480mr18155804f8f.46.1791195498057; 
 Mon, 05 Oct 2026 03:18:18 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:17 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 00/31] i.MX fixes and cleanup
Date: Mon,  5 Oct 2026 12:17:27 +0200
Message-ID: <20261005101800.10821-1-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:30::e;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series fixes various issues in i.MX device emulation, cleans up i.MX=0D
Kconfig handling, and improves some code. Functional console tests for the=
=0D
remaining i.MX boards are added where images are publicly available, except=
 for=0D
imx6ul which is taken care of in a different series [1]. Fixes which appear=
 safe=0D
for backporting are cc'd to qemu-stable.=0D
=0D
The series is structured as follows: Patches 1-5 fix some issues and are=0D
mostly marked for backporting. Patch 4 is a follow-up on patches 1-3 and=0D
should not be backported since it breaks migration.=0D
=0D
Patches 6-11 add and improve functional tests for i.MX devices. While at it=
,=0D
saner defaults for the amount of RAM and number of CPUs are established.=0D
=0D
Patches 12-16 turn the remaining i.MX SoC device models into SySBus devices=
=0D
which fixes their reset behavior.=0D
=0D
Patches 17-30 are Kconfig cleanups where CONFIG_IMX gets split into dedicat=
ed=0D
config items.=0D
=0D
The last commit just fixes some typos in the code.=0D
=0D
Changes in v3:=0D
* Add dedicated patch fixing write one once WCR bits, cc'd to qemu-stable (=
Bin)=0D
Done as yet another patch to tell the issues apart.=0D
* Add and fix some commit messages (Bin)=0D
* Add functional tests to 'tests_arm_system_thorough' (Bin)=0D
* Fix typo in functional tests for mcimx7d-sabre machine (Bin)=0D
* Use sysbus_realize() rather than sysbus_realize_and_unref() in case of=0D
embedded SoC struct (Bin)=0D
* Pick up R-b tags=0D
=0D
Changes in v2:=0D
* Remove patch adding `mc->ignore_memory_transaction_failures =3D true;` (P=
eter)=0D
* Rework wdt_imx2 patches (Peter)=0D
* Remove all but "hw/misc/Kconfig: Remove redundant USB_EHCI_SYSBUS from co=
nfig=0D
IMX" already queued by Phil. The preserved patch is required to remove all=
=0D
dependencies from CONFIG_IMX such that it can be removed.=0D
* Pick up R-b tags=0D
* Rebase onto latest master=0D
=0D
[1]=0D
https://lore.kernel.org/qemu-devel/20261004090500.3082641-1-bin.=0D
meng@processmission.com/=0D
=0D
base-commit: d7a65d1793d691d356a56833620f7d1e6f5d653b=0D
=0D
Bernhard Beschow (31):=0D
  hw/watchdog/wdt_imx2: Preserve own locked bits in WCR=0D
  hw/watchdog/wdt_imx2: Fix handling of write one once WCR bits=0D
  hw/watchdog/wdt_imx2: Clear WDT lock on reset=0D
  hw/watchdog/wdt_imx2: Remove redundant attributes=0D
  hw/arm/imx8mm-evk: Fix reference count of SoC object=0D
  docs, tests/functional: Drop redundant CLI arguments in imx8m*-evk=0D
    invocations=0D
  hw/arm/sabrelite: Have 4 CPUs and 1 GiB of RAM by default=0D
  tests/functional/arm: Add console test for `sabrelite` machine=0D
  hw/arm/mcimx6ul-evk: Have 512 MiB of RAM by default=0D
  hw/arm/mcimx7d-sabre: Have 2 CPUs and 2 GiB of RAM by default=0D
  tests/functional/arm: Add console test for `mcimx7d-sabre` machine=0D
  hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE=0D
  hw/arm/fsl-imx31: Derive from TYPE_SYS_BUS_DEVICE=0D
  hw/arm/fsl-imx6: Derive from TYPE_SYS_BUS_DEVICE=0D
  hw/arm/fsl-imx6ul: Derive from TYPE_SYS_BUS_DEVICE=0D
  hw/arm/fsl-imx7: Derive from TYPE_SYS_BUS_DEVICE=0D
  hw/misc/Kconfig: Remove redundant USB_EHCI_SYSBUS from config IMX=0D
  Kconfig: Extract config IMX_AVIC from config IMX=0D
  Kconfig: Extract config IMX_GPCV2 from config IMX=0D
  Kconfig: Extract config IMX_RNG from config IMX=0D
  Kconfig: Extract config FSL_IMX7_GPR from config IMX=0D
  Kconfig: Extract config FSL_IMX{6, 7}_SRC from config IMX=0D
  Kconfig: Extract config FSL_IMX7_SNVS from config IMX=0D
  Kconfig: Extract dedicated config FSL_IMXx_CCM from config IMX=0D
  Kconfig: Extract config IMX_GPT from config IMX=0D
  Kconfig: Extract config IMX_EPIT from config IMX=0D
  Kconfig: Extract config GPIO_IMX from config IMX=0D
  Kconfig: Extract config IMX_SPI from config IMX=0D
  Kconfig: Extract config IMX_SERIAL from config IMX=0D
  Kconfig: Remove config IMX=0D
  hw/arm/fsl-imx8m: Fix typo=0D
=0D
 MAINTAINERS                                 |  2 +=0D
 docs/system/arm/imx8m.rst                   |  2 +-=0D
 docs/system/arm/sabrelite.rst               |  4 +-=0D
 include/hw/arm/fsl-imx25.h                  |  5 +-=0D
 include/hw/arm/fsl-imx31.h                  |  5 +-=0D
 include/hw/arm/fsl-imx6.h                   |  5 +-=0D
 include/hw/arm/fsl-imx6ul.h                 |  5 +-=0D
 include/hw/arm/fsl-imx7.h                   |  5 +-=0D
 include/hw/arm/fsl-imx8mm.h                 |  4 +-=0D
 include/hw/arm/fsl-imx8mp.h                 |  4 +-=0D
 include/hw/watchdog/wdt_imx2.h              |  2 -=0D
 hw/arm/fsl-imx25.c                          |  7 +--=0D
 hw/arm/fsl-imx31.c                          |  7 +--=0D
 hw/arm/fsl-imx6.c                           |  4 +-=0D
 hw/arm/fsl-imx6ul.c                         |  4 +-=0D
 hw/arm/fsl-imx7.c                           |  5 +-=0D
 hw/arm/fsl-imx8mm.c                         |  2 +-=0D
 hw/arm/fsl-imx8mp.c                         |  2 +-=0D
 hw/arm/imx25_pdk.c                          |  2 +-=0D
 hw/arm/imx8mm-evk.c                         |  4 +-=0D
 hw/arm/kzm.c                                |  2 +-=0D
 hw/arm/mcimx6ul-evk.c                       |  3 +-=0D
 hw/arm/mcimx7d-sabre.c                      |  4 +-=0D
 hw/arm/sabrelite.c                          |  5 +-=0D
 hw/watchdog/wdt_imx2.c                      | 22 ++------=0D
 hw/arm/Kconfig                              | 56 ++++++++++++++++++---=0D
 hw/char/Kconfig                             |  3 ++=0D
 hw/char/meson.build                         |  2 +-=0D
 hw/gpio/Kconfig                             |  3 ++=0D
 hw/gpio/meson.build                         |  2 +-=0D
 hw/intc/Kconfig                             |  6 +++=0D
 hw/intc/meson.build                         |  3 +-=0D
 hw/misc/Kconfig                             | 41 +++++++++++++--=0D
 hw/misc/meson.build                         | 24 ++++-----=0D
 hw/net/Kconfig                              |  2 +-=0D
 hw/ssi/Kconfig                              |  4 ++=0D
 hw/ssi/meson.build                          |  2 +-=0D
 hw/timer/Kconfig                            | 10 ++++=0D
 hw/timer/meson.build                        |  4 +-=0D
 tests/functional/aarch64/test_imx8mm_evk.py |  4 +-=0D
 tests/functional/aarch64/test_imx8mp_evk.py |  4 +-=0D
 tests/functional/arm/meson.build            |  4 ++=0D
 tests/functional/arm/test_mcimx7d_sabre.py  | 46 +++++++++++++++++=0D
 tests/functional/arm/test_sabrelite.py      | 46 +++++++++++++++++=0D
 44 files changed, 273 insertions(+), 109 deletions(-)=0D
 create mode 100755 tests/functional/arm/test_mcimx7d_sabre.py=0D
 create mode 100755 tests/functional/arm/test_sabrelite.py=0D
=0D
-- =0D
2.56.0=0D
=0D

