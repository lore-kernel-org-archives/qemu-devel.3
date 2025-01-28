Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E55C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxa-00022Y-Ha; Tue, 28 Jan 2025 15:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxY-00021p-An
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:20 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxW-0001Xl-4J
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:20 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so69760555e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095196; x=1738699996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CJXplQcGS66yhEIleNiGNMA//eCmIAzfBUs/cxy068s=;
 b=VTE90ecZ0cDSYlXrhUVCuycVudOAIMmnLfyI9UsVxVXTVT2Zoz56bWt2q+ocPLz/C+
 UMIwd8QNCxPRjlXOHmyptAnGjZb2Pg7MXhrCd6S0o9dq4eAK/dR3Ah424K7eBoq0ZOfY
 VJK5o8j+BzPrGgPUkOP49a0JMj5P3unq+FlI8YulrZj/cyjo8wcPZeN8u6htEdEiTR9J
 6khdQrkAggrRJNXQOEHj+BE5wNTfmAoOoY3RLJBm4kTXqoeClCNTQoRxY5SR4yBp2QE8
 FdvrkrvLTSDgTP2hGMnxSAPWxcRBPsEOJPJEcLsC4hcHWB9xaPJWKyj/P8Ke5pdee8pj
 SOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095196; x=1738699996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CJXplQcGS66yhEIleNiGNMA//eCmIAzfBUs/cxy068s=;
 b=fayj3MFDFWpt7r9EcWSPIjFPppBnKcg11Xzwmk/ZAk9LssJaZIBuOLJLB6+UH9SM5s
 SJ4zjp9PGzJz5hA/JjJ9fVorTdFYUAvdH+5aPNs4lhd5CUdespgY05NPWr2i3IvO/8Fp
 npOXBdNvg2LuJv97AHldjDajHLS8FtA/Q7LLMpnf+SZzLiNvkLqYhhvsXkChi+VAQhps
 vJ7K/N4XWMHRf4zUBEyeU468spbziVTCCltyoB1rNHZFyPFi9DGXNILUDTchiUjBtgk6
 L0qoXDzR0hYHSX8pHhsH/tluRbOFfGBaAbIWKWHlHb3en3Ncz0/cNgr38721xTxsgL4D
 YgOw==
X-Gm-Message-State: AOJu0YxH0E2K/ErPuuhLsZLhzZl8mYDHO8igz7lO56aKIcnSK9HrdXzP
 NKl8IrVnXSNoKSWJiTRloFbQhElMjqlnBLwyV+lY6Wa99unmaN1ZD5ucs62jzbRenkeTncF7gTV
 y
X-Gm-Gg: ASbGncvtNbSc2dZ9rhw0ebl3MwK+yAYO4A4OAjLUmYl3C6sDgGA3WQ3e6msfKeJ7ePj
 HYZetekpDTUyZPf62jYSMGzNhlKafz1sj1Ns23Bq2C5JsIJY5QUr34I0jInMTeH+7X/XNkidO5w
 Gug4JElFvsiYLnjBdR0WxhomCUoKFI07lB5dl6LSjj2DuZxfYJcDBMiJZwil5Jmrcocs1kxtgDj
 qiYhUBRSApWpCcgXoIdVMwcvm9WJRZl7VlfWKt1vF/ygs8sm0a/8iN7lFOIYoPbC99qwML3YSoM
 e4yXmBexdJrp1WKbGgD3Eg==
X-Google-Smtp-Source: AGHT+IGe+Axmf5bHr8xsbaCa2oa9Y8px6PQqWzB/BojSyHB/Y4sXIwifNsijORFrVa0F8tFI05pnCA==
X-Received: by 2002:a05:600c:1c1a:b0:434:f9c4:a850 with SMTP id
 5b1f17b1804b1-438dc3c4623mr2750165e9.10.1738095196095; 
 Tue, 28 Jan 2025 12:13:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/36] target-arm queue
Date: Tue, 28 Jan 2025 20:12:38 +0000
Message-Id: <20250128201314.44038-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi; here's another arm pullreq; by volume most of this is
refactoring from me, but there are also some bugfixes and
other bits and pieces here.

thanks
-- PMM

The following changes since commit ed734377ab3f3f3cc15d7aa301a87ab6370f2eed:

  Merge tag 'linux-user-fix-gupnp-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2025-01-24 14:43:07 -0500)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20250128-1

for you to fetch changes up to 664280abddcb3cacc9c6204706bb739fcc1316f7:

  hw/usb/canokey: Fix buffer overflow for OUT packet (2025-01-28 18:40:19 +0000)

----------------------------------------------------------------
target-arm queue:
 * hw/arm: Remove various uses of first_cpu global
 * hw/char/imx_serial: Fix reset value of UFCR register
 * hw/char/imx_serial: Update all state before restarting ageing timer
 * hw/pci-host/designware: Expose MSI IRQ
 * hw/arm/stellaris: refactoring, cleanup
 * hw/arm/stellaris: map both I2C controllers
 * tests/functional: Add a test for the arm microbit machine
 * target/arm: arm_reset_sve_state() should set FPSR, not FPCR
 * target/arm: refactorings preparatory to FEAT_AFP implementation
 * fpu: Rename float_flag_input_denormal to float_flag_input_denormal_flushed
 * fpu: Rename float_flag_output_denormal to float_flag_output_denormal_flushed
 * hw/usb/canokey: Fix buffer overflow for OUT packet

----------------------------------------------------------------
Bernhard Beschow (3):
      hw/char/imx_serial: Fix reset value of UFCR register
      hw/char/imx_serial: Update all state before restarting ageing timer
      hw/pci-host/designware: Expose MSI IRQ

Hongren Zheng (1):
      hw/usb/canokey: Fix buffer overflow for OUT packet

Peter Maydell (22):
      target/arm: arm_reset_sve_state() should set FPSR, not FPCR
      target/arm: Use FPSR_ constants in vfp_exceptbits_from_host()
      target/arm: Use uint32_t in vfp_exceptbits_from_host()
      target/arm: Define new fp_status_a32 and fp_status_a64
      target/arm: Use vfp.fp_status_a64 in A64-only helper functions
      target/arm: Use fp_status_a64 or fp_status_a32 in is_ebf()
      target/arm: Use fp_status_a32 in vjvct helper
      target/arm: Use fp_status_a32 in vfp_cmp helpers
      target/arm: Use FPST_A32 in A32 decoder
      target/arm: Use FPST_A64 in A64 decoder
      target/arm: Remove now-unused vfp.fp_status and FPST_FPCR
      target/arm: Define new fp_status_f16_a32 and fp_status_f16_a64
      target/arm: Use fp_status_f16_a32 in AArch32-only helpers
      target/arm: Use fp_status_f16_a64 in AArch64-only helpers
      target/arm: Use FPST_A32_F16 in A32 decoder
      target/arm: Use FPST_A64_F16 in A64 decoder
      target/arm: Remove now-unused vfp.fp_status_f16 and FPST_FPCR_F16
      fpu: Rename float_flag_input_denormal to float_flag_input_denormal_flushed
      fpu: Rename float_flag_output_denormal to float_flag_output_denormal_flushed
      fpu: Fix a comment in softfloat-types.h
      target/arm: Remove redundant advsimd float16 helpers
      target/arm: Use FPST_A64_F16 for halfprec-to-other conversions

Philippe Mathieu-Daudé (9):
      hw/arm/nrf51: Rename ARMv7MState 'cpu' -> 'armv7m'
      hw/arm/stellaris: Add 'armv7m' local variable
      hw/arm/v7m: Remove use of &first_cpu in machine_init()
      hw/arm/stellaris: Link each board schematic
      hw/arm/stellaris: Constify read-only arrays
      hw/arm/stellaris: Remove incorrect unimplemented i2c-0 at 0x40002000
      hw/arm/stellaris: Replace magic numbers by definitions
      hw/arm/stellaris: Use DEVCAP macro to access DeviceCapability registers
      hw/arm/stellaris: Map both I2C controllers

Thomas Huth (1):
      tests/functional: Add a test for the arm microbit machine

 MAINTAINERS                           |   1 +
 hw/usb/canokey.h                      |   4 --
 include/fpu/softfloat-types.h         |  10 +--
 include/hw/arm/fsl-imx6.h             |   4 +-
 include/hw/arm/fsl-imx7.h             |   4 +-
 include/hw/arm/nrf51_soc.h            |   2 +-
 include/hw/char/imx_serial.h          |   2 +-
 include/hw/pci-host/designware.h      |   1 +
 target/arm/cpu.h                      |  12 ++--
 target/arm/tcg/helper-a64.h           |   8 ---
 target/arm/tcg/translate.h            |  32 ++++++---
 fpu/softfloat.c                       |   6 +-
 hw/arm/b-l475e-iot01a.c               |   2 +-
 hw/arm/fsl-imx6.c                     |  13 +++-
 hw/arm/fsl-imx7.c                     |  13 +++-
 hw/arm/microbit.c                     |   2 +-
 hw/arm/mps2-tz.c                      |   2 +-
 hw/arm/mps2.c                         |   2 +-
 hw/arm/msf2-som.c                     |   2 +-
 hw/arm/musca.c                        |   2 +-
 hw/arm/netduino2.c                    |   2 +-
 hw/arm/netduinoplus2.c                |   2 +-
 hw/arm/nrf51_soc.c                    |  18 ++---
 hw/arm/olimex-stm32-h405.c            |   2 +-
 hw/arm/stellaris.c                    | 118 +++++++++++++++++++-----------
 hw/arm/stm32vldiscovery.c             |   2 +-
 hw/char/imx_serial.c                  |   7 +-
 hw/pci-host/designware.c              |   7 +-
 hw/usb/canokey.c                      |   6 +-
 target/arm/cpu.c                      |   6 +-
 target/arm/helper.c                   |   2 +-
 target/arm/tcg/helper-a64.c           |   9 ---
 target/arm/tcg/sme_helper.c           |   6 +-
 target/arm/tcg/sve_helper.c           |   6 +-
 target/arm/tcg/translate-a64.c        | 103 ++++++++++++++-------------
 target/arm/tcg/translate-sme.c        |   4 +-
 target/arm/tcg/translate-sve.c        | 130 +++++++++++++++++-----------------
 target/arm/tcg/translate-vfp.c        |  78 ++++++++++----------
 target/arm/tcg/vec_helper.c           |  22 +++---
 target/arm/vfp_helper.c               |  73 +++++++++++--------
 target/i386/tcg/fpu_helper.c          |   8 +--
 target/m68k/fpu_helper.c              |   2 +-
 target/mips/tcg/msa_helper.c          |   4 +-
 target/rx/op_helper.c                 |   4 +-
 target/tricore/fpu_helper.c           |   6 +-
 fpu/softfloat-parts.c.inc             |   4 +-
 hw/arm/Kconfig                        |   2 +
 tests/functional/meson.build          |   1 +
 tests/functional/test_arm_microbit.py |  31 ++++++++
 49 files changed, 452 insertions(+), 337 deletions(-)
 create mode 100755 tests/functional/test_arm_microbit.py

