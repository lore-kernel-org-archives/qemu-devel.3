Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E56FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEQY-0004pZ-38; Wed, 29 Apr 2026 19:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ericsonjoseph@gmail.com>)
 id 1wICoY-00010E-09
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:51:26 -0400
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ericsonjoseph@gmail.com>)
 id 1wICoW-0004Ce-6o
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:51:25 -0400
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-12c8ccc7755so408852c88.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777499482; x=1778104282; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fSlZP9aPepkZj5k3bftrq+rSY50ISlR4/Of+QCcyLdM=;
 b=i8Ao/h1Rf8V0fyZAy/pmg120U9i8fW6LFl26rC6dw3T+getj0mSfWEJEwYxsQszG3Y
 +zmIg2eW5OPtgaIXWCuHSGe9hp1+js+SxSb19bliJZi/MlNqJU7NFWOcSe1HViK7NDm2
 m09jKaKNNtVa28AO5R11XjeVxb6ou6QPoltl0MrvHpbE32OWvfGYU2GVUuRmWsyF01JB
 AUodVRXz6/2xdazdKTozLWsSvgvARsBXpw3zXonai3ypGkgtK8oqc2nCG/d0SAfN0A0F
 4K8talqPva1PeES+MeWCctF26+wTWlBvtKftyR6ox6Y4zsXCHB1VQ/ME9EDXfXjk4MiC
 YDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777499482; x=1778104282;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSlZP9aPepkZj5k3bftrq+rSY50ISlR4/Of+QCcyLdM=;
 b=nt2wxkbtfXAGEoFY3+E5SRoy8Fj+9/RSoNk2X32FO0unog1N0pEsgR2T9pPUuxa5Zt
 kUNwRAAGuH9gauNkk7wXXo+N14ALeMfHWlcAp8+41X0FiI+1HtqExbYKQLTBsErgf6N+
 H8f4Ir4DkIVaJMGX4Ngil3GhqDNDw3md6XZu85t/W8JcTUY0CdeHoORAY38WVGELwZ5a
 lh5q4dsISRNHiEsf1U6Z9vBMTBrNYEX3ACv0MGDZ8g5SRD5REMMhrE66vbE5mdDOBlcy
 QINenwOm8ZZTvnxnYEMvq4su0uLD2KD+fik7JS9o1Uudw2Xd92RYCmRn5IsRTbyKX9UA
 uUJA==
X-Gm-Message-State: AOJu0Yz+8LNMbCINVNaPJdg8117M/6n0uyEUBqGeDD4iRqp3ml4ERes2
 A7r+I6E0+L57hKBsVSZ3j6IyYeyWOpITUi3rVAQcsg60ecUDTD9RTft2
X-Gm-Gg: AeBDieu4Vinmj8FtR4iLuTQ2tZmlVaerxScABar0LRPLuT8BM0BSpg575UjPmZJzFnS
 zBJVNgOoamVjrSsA5khodcEABB0L4kKk6tszDssyPNxLIY7A/no186iJFk6/rQ4tBIto5e/t3/H
 i61vcLgCqZ6iWpcA840Cr2//H92flgbtYWnEF1EOPXXJPYNieNzLOxNcO4Pn/wRTH3lWcT9Z970
 l9/Ta7BO3l9nvNIthzK9iRqflo5FVuBEsPjlDcdDc94gHy5LGh7k2C13F6ySqrRLAOzi8Ff+Noo
 MIq1odL8DheyKgXdyKaA6yX19yU3AMNVT2gtK4U+0lkefqGvKYLwEuu6iGOtH7mHrcSSj451VWV
 h35zpjtOEFGLVDPtg1FxgJWDtVwR1ejwv255U3/MctIQ4fR7IzEUoTQXBxTondCRl/QPw2Nul/X
 +zoZ5fNMZC5bOHd+Nt/J+PSgfvqLQDL8o191Uei6no
X-Received: by 2002:a05:7300:4343:b0:2e2:d94d:6188 with SMTP id
 5a478bee46e88-2ed3ba11256mr65047eec.7.1777499481780; 
 Wed, 29 Apr 2026 14:51:21 -0700 (PDT)
Received: from [127.0.1.1] ([2803:9800:9001:c4f0:5d16:7dac:ff8:d8ff])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf6d315sm4353878eec.1.2026.04.29.14.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 14:51:21 -0700 (PDT)
From: Ericson Joseph <ericsonjoseph@gmail.com>
Subject: [PATCH RFC 0/3] hw/mips: add Microchip PIC32MK GPK/MCM board emulation
Date: Wed, 29 Apr 2026 18:51:16 -0300
Message-Id: <20260429-pic32mk-board-support-v1-0-1dfac14f8e2d@voltumotor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFR98mkC/yWMywrCMBAAf6Xs2YUYH0GvQj/Aq3jIY9VVbMJuK
 4XSf2/U4wzMTKAkTArHZgKhDyvnrsJ61UB8+O5OyKkyWGP3ZmsPWDhu7PuFIXtJqEMpWXrcJW8
 cOZdSiFDbInTj8fe9wLk9wfUvdQhPiv33CPO8AO5Ju0h+AAAA
X-Change-ID: 20260429-pic32mk-board-support-5da07e77ddbc
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Ericson Joseph <ericsonjoseph@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=ericsonjoseph@gmail.com; helo=mail-dl1-x1235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 19:34:44 -0400
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

This series adds board emulation for the Microchip PIC32MK GPK/MCM family
of 32-bit MIPS32 microcontrollers (microAptiv core, 120 MHz).

PIC32MK is widely used in automotive, industrial, and motor-control
applications. The emulation targets the PIC32MK1024MCM100 variant
(1 MB Flash, 256 KB RAM), reference datasheet DS60001519E.

# What is implemented

The following peripherals are modelled:

 - CPU: MIPS32 microAptiv (M4K-derived), little-endian
 - Memory: 256 KB SRAM, 1 MB Flash (NVM) with DataEEPROM emulation
 - EVIC: vectored interrupt controller with 8-level priority
 - UART1-6: 16-byte TX/RX FIFOs, baud-rate divisor, interrupt support
 - Timer1-9: 16/32-bit, prescaler, period register, interrupt
 - GPIO: ports A-G, ANSEL/TRIS/PORT/LAT/ODC, CN mismatch interrupt
 - SPI1-6: master and slave modes, 8/16/32-bit frames
 - I2C1-5: master/slave, 7/10-bit addressing
 - DMA: 8 channels, cell-triggered transfers
 - CAN FD: 4 instances, hardware FIFO, TX object, SocketCAN backend
 - USB: CDC-ACM class, chardev backend for host connectivity
 - OC1-16: Output Compare (PWM mode detection, diagnostic event stream)
 - IC1-16: Input Capture (stub, register model)
 - ADCHS: 12-bit ADC with 43 channels, software trigger
 - CRU: Clock and Reset Unit (software reset, PBCLK divisor)
 - WDT: Watchdog Timer (clear register, timeout reset)
 - CFG: Configuration bit registers (DEVCFG0-3)

# What is NOT implemented

 - PWM actual waveform generation (OC emits diagnostic events only)
 - Input Capture signal measurement (IC is a register stub)
 - DMA linked-list (pattern match) transfers
 - USB isochronous / bulk / HID endpoints
 - PPS (peripheral pin select) remapping

# Testing

A minimal MIPS32 assembly firmware is included
(tests/functional/mipsel/pic32mk_test_fw.S) that initialises the CPU,
writes a known string to UART1, and halts. The functional test asserts
that QEMU serial output matches the expected string.

Four qtest cases cover UART register behaviour, GPIO SET/CLR/INV
sub-registers, and CAN FD loopback.

Build and run:

  mkdir build && cd build
  ../configure --target-list=mipsel-softmmu
  make -j$(nproc)
  ./qemu-system-mipsel -M pic32mk -nographic -serial stdio \
      -kernel tests/functional/mipsel/pic32mk_test_fw.elf

The datasheet (DS60001519E) is publicly available from Microchip's
website and is not included in this series.

Signed-off-by: Ericson Joseph <ericsonjoseph@gmail.com>
---
Ericson Joseph (3):
      hw/mips: add Microchip PIC32MK GPK/MCM board
      tests: add PIC32MK functional and qtest coverage
      docs: document the PIC32MK machine in target-mips.rst

 MAINTAINERS                                |    9 +
 configs/targets/mipsel-softmmu.mak         |    1 +
 docs/system/target-mips.rst                |   52 ++
 hw/mips/Kconfig                            |    8 +
 hw/mips/meson.build                        |   21 +
 hw/mips/pic32mk.c                          |  815 ++++++++++++++++++++
 hw/mips/pic32mk_adchs.c                    |  583 ++++++++++++++
 hw/mips/pic32mk_canfd.c                    | 1143 ++++++++++++++++++++++++++++
 hw/mips/pic32mk_cfg.c                      |  247 ++++++
 hw/mips/pic32mk_cru.c                      |  375 +++++++++
 hw/mips/pic32mk_dataee.c                   |  463 +++++++++++
 hw/mips/pic32mk_dma.c                      |  255 +++++++
 hw/mips/pic32mk_evic.c                     |  399 ++++++++++
 hw/mips/pic32mk_gpio.c                     |  418 ++++++++++
 hw/mips/pic32mk_i2c.c                      |  184 +++++
 hw/mips/pic32mk_ic.c                       |  384 ++++++++++
 hw/mips/pic32mk_nvm.c                      |  572 ++++++++++++++
 hw/mips/pic32mk_oc.c                       |  293 +++++++
 hw/mips/pic32mk_spi.c                      |  532 +++++++++++++
 hw/mips/pic32mk_timer.c                    |  294 +++++++
 hw/mips/pic32mk_uart.c                     |  334 ++++++++
 hw/mips/pic32mk_usb.c                      | 1033 +++++++++++++++++++++++++
 hw/mips/pic32mk_wdt.c                      |  230 ++++++
 include/hw/mips/pic32mk.h                  |  952 +++++++++++++++++++++++
 include/hw/mips/pic32mk_adchs.h            |   87 +++
 include/hw/mips/pic32mk_canfd.h            |  210 +++++
 include/hw/mips/pic32mk_evic.h             |   45 ++
 include/hw/mips/pic32mk_usb.h              |  181 +++++
 tests/functional/mipsel/meson.build        |   28 +
 tests/functional/mipsel/pic32mk_test_fw.S  |   64 ++
 tests/functional/mipsel/pic32mk_test_fw.ld |   20 +
 tests/functional/mipsel/test_pic32mk.py    |   57 ++
 tests/qtest/meson.build                    |    4 +-
 tests/qtest/pic32mk-canfd-test.c           |  411 ++++++++++
 tests/qtest/pic32mk-test.c                 |  457 +++++++++++
 35 files changed, 11160 insertions(+), 1 deletion(-)
---
base-commit: 759c456b1d22fe4083c8b384da27d3f56fd53f82
change-id: 20260429-pic32mk-board-support-5da07e77ddbc

Best regards,
--  
Ericson Joseph <ejoseph@voltumotor.com>


