Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5F606A33A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=nGXyCgwR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrjN-0001bw-5H; Fri, 13 Nov 2026 08:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRntR-0004JU-1u; Fri, 13 Nov 2026 04:48:25 -0500
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net ([206.189.79.184])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRntO-00071U-41; Fri, 13 Nov 2026 04:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=2OuYu
 wDSIVfTPlLHBFplT3Fsykaz6y/ZYTd6iGyKIGg=; b=nGXyCgwRjuIHlCaeQN6cX
 FlXdq91QhupNrkVwOA3HymR+DC8pH99QZqscmzu2fXf7UQLcsqDDR1Sm0AlfG09R
 h+bZbZUhAFwY4EvOBD3+EUI33pGsdwRMR04gCmDiF2nVwglVOzSs6CGcSLabTKNy
 7c/RmlzRHj93AFsAUj1DNU=
Received: from ubuntu (unknown [101.5.154.165])
 by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S2;
 Fri, 13 Nov 2026 17:48:12 +0800 (CST)
From: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
To: qemu-devel@nongnu.org
Cc: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 bin.meng@processmission.com, tangtao1634@phytium.com.cn
Subject: [RFC PATCH 00/20] hw/arm: Add initial RK3588 and ROCK 5B support
Date: Fri, 13 Nov 2026 17:47:34 +0800
Message-ID: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: yAQGZQA3qzvR3PZqgA5CAg--.9318S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4kuF4kCr15uF18AF1fZwb_yoW5KFWfpa
 n5Arn8Krs7Gay3XrWSvFnrJF4Sv3WkWrWjkw1xXrW7AFWaqF40krnrK3Z09FyfJFWfXF13
 CFn2qryrGw47ZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
 648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
 AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6mhrU
 UUUU=
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/
Received-SPF: pass client-ip=206.189.79.184;
 envelope-from=w-yf22@mails.tsinghua.edu.cn;
 helo=zg8tmja2lje4os43os4xodqa.icoremail.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 08:53:52 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series adds initial support for the Rockchip RK3588 SoC and the
Radxa ROCK 5B board. It supports booting Linux through U-Boot SPL and
U-Boot from SPI NOR flash, as well as direct kernel boot.

The implementation includes the eight Cortex-A55/A76 CPUs, GICv3,
architectural timers, SRAM, UARTs, and the Rockchip SPI flash controller.
It also models the CRU, OTP, and HPTIMER registers needed by the boot
software.

Patches 1-5 extend DW8250 and ARM SMC support and add the XTX XT25F128
flash device. Patches 6-15 add the RK3588 SoC and its devices. Patches
16-18 add the ROCK 5B board and firmware boot support. Patch 19 adds
functional boot tests, and patch 20 adds documentation.

Both boot paths have been tested with Linux 6.12.4, with U-Boot 2025.01
used for the firmware boot path. The included functional tests cover
booting to a Buildroot shell, reboot, and poweroff.

Comments and suggestions are welcome.

Thanks,
Yifan

Chao Liu (20):
  hw/char/dw8250: implement the UART status register
  hw/char/dw8250: expose the baudbase property
  target/arm: report SMCCC v1.1 support
  target/arm: allow machines to handle SMC calls
  hw/block/m25p80: add the XTX XT25F128 SPI NOR flash
  hw/arm: add the Rockchip RK3588 SoC
  hw/timer: add Rockchip HPTIMER boot control
  hw/arm/rk3588: add the unimplemented device map
  hw/arm/rk3588: add the GICv3 interrupt controller
  hw/arm/rk3588: add the UARTs
  hw/misc: add the RK3588 clock and reset unit
  hw/misc: add the RK3588 OTP controller
  hw/ssi: add the Rockchip SPI flash controller
  hw/misc: add RK3588 SCMI server
  hw/arm/rk3588: wire up the SCMI server
  hw/arm: add Radxa ROCK 5B board
  hw/arm/rock-5b: connect the XTX XT25F128 SPI NOR flash
  hw/arm/rock-5b: add firmware booting
  tests/functional: add ROCK 5B boot tests
  docs/system/arm: document the Radxa ROCK 5B machine

 MAINTAINERS                              |  19 +
 docs/system/arm/rock-5b.rst              |  86 ++++
 docs/system/target-arm.rst               |   1 +
 hw/arm/Kconfig                           |  16 +
 hw/arm/meson.build                       |   3 +
 hw/arm/rk3588.c                          | 452 +++++++++++++++++
 hw/arm/rock-5b.c                         | 297 ++++++++++++
 hw/block/m25p80.c                        |  20 +
 hw/char/dw8250.c                         |  45 ++
 hw/misc/meson.build                      |   5 +
 hw/misc/rk3588-scmci.c                   | 589 +++++++++++++++++++++++
 hw/misc/rockchip_cru.c                   | 233 +++++++++
 hw/misc/rockchip_otp.c                   | 146 ++++++
 hw/ssi/Kconfig                           |   5 +
 hw/ssi/meson.build                       |   1 +
 hw/ssi/rockchip_sfc.c                    | 439 +++++++++++++++++
 hw/timer/meson.build                     |   1 +
 hw/timer/rockchip-hptimer.c              | 115 +++++
 include/hw/arm/arm-smc.h                 |  31 ++
 include/hw/arm/rk3588.h                  |  64 +++
 include/hw/misc/rk3588-scmci.h           |  25 +
 include/hw/timer/rockchip-hptimer.h      |  20 +
 target/arm/helper.c                      |  80 +++
 target/arm/internals.h                   |   3 +
 target/arm/kvm-consts.h                  |   5 +
 target/arm/tcg/psci.c                    |  15 +
 tests/functional/aarch64/meson.build     |   2 +
 tests/functional/aarch64/test_rock_5b.py | 118 +++++
 28 files changed, 2836 insertions(+)
 create mode 100644 docs/system/arm/rock-5b.rst
 create mode 100644 hw/arm/rk3588.c
 create mode 100644 hw/arm/rock-5b.c
 create mode 100644 hw/misc/rk3588-scmci.c
 create mode 100644 hw/misc/rockchip_cru.c
 create mode 100644 hw/misc/rockchip_otp.c
 create mode 100644 hw/ssi/rockchip_sfc.c
 create mode 100644 hw/timer/rockchip-hptimer.c
 create mode 100644 include/hw/arm/arm-smc.h
 create mode 100644 include/hw/arm/rk3588.h
 create mode 100644 include/hw/misc/rk3588-scmci.h
 create mode 100644 include/hw/timer/rockchip-hptimer.h
 create mode 100755 tests/functional/aarch64/test_rock_5b.py


base-commit: 49559567804523cb28cad002aa8e97f444e23ad7
-- 
2.53.0


