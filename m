Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C07ECD99F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5V2-0006UO-6j; Thu, 05 Feb 2026 14:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5V0-0006TV-1S
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:58:46 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5Ux-00030p-HF
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:58:45 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43591b55727so1185512f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321521; x=1770926321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=weqtnKpYm5R195OcLDLnOOsvN8RJffwM+2Llp5oG/uA=;
 b=ZzIuBo0l/fi2Q39GJTW7xV9NIzC+XTrchnnDqMONJjlU31Yt/EDxxuMiQ4CpN9uFOp
 O6t2cqku/UNr+FB3noJqjJNTkP/MMFlC8Dxg2BbRFT7LFZAhcKa0BHuUC18QNZfDSMR0
 tJqUzVfrM5ufa6Qsfiqwt9p2c3iZr1DyPsklaESfCCU6Z3Hxvw5Xh4XAZFAJ1lAKO4Wo
 DvqesaDoMeDoNx1M96UKy/zgCSOfHAxioy6aAlgos9DOUTQouArjONn7n/umREw0Jc6O
 rh+qwH51jukSFH0NBf2eE6A06tuc7PXCL7fBtPQ+bTjUJALS6qkIIYPdb+S+kzGC5JoZ
 KvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321521; x=1770926321;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=weqtnKpYm5R195OcLDLnOOsvN8RJffwM+2Llp5oG/uA=;
 b=qrt5YDrNcOTAuyJfb2exBeNobtPHXARnwctO2LOhKYc7IIqmM7wXR9bd1AW1BOWUn8
 OagG0kP0fhEUAMxpjO2cPk/3h8p2XBnHwiGHQJfZQb2dQXkp1pGmePwZM4HsvoAkdS/2
 7HJXVS4b4xas3xs2/hQsPEj0d5mg92ieFNnc19EreJlEa30Bua8BHRanZMOxRaU+iDtJ
 z7vEsWOjrD1kTiUA/yQMagUGb+xRFZPbaBadluVkd7CT6B2h/MTxnFoEP/s8cZ1Fp6ys
 vh6NylbYrRgTqoWOxBg+gLYo0Ipah0bsvJ3jv3HeV395/yuGlaiI8CgwM+63Xpv7qW65
 7s9g==
X-Gm-Message-State: AOJu0YxLs4P7/l10P9kR0+1N4DURHqHpNVh5BQdJapLmChfSmONsVGff
 yogAL/s5geFwESpDXTz8o/yesdSw7KaZXhpGA/gyxBOS9GrPyN/PwdorsnXpQznPgUY=
X-Gm-Gg: AZuq6aKN/H94X3yMYQe/BhWf9+hts3ONQFPuINZHDM30Vzu95BWsgZY11tePxpLNM/e
 zL/OLN5bbsiMD7KGUgKzv+EBuPhiRsVL1Okj2iaJ77Ren2mIYRiLLPpX6rID+fVqlyhJrQHTOpN
 t3DE4D6meU3cD3nUTb/JHac0aqlnTPL7z3nM4HuHLJp0PBnEkitacrGrGeKQlc0d5GxHZNJ+vMp
 ENgNZEbMEiOE1C19jldag4spZPkyLuKcPpzXKkhtCw4DkSRVCw7iIK6oWqOsHyxkRo88oOXp/VD
 BaJgujikQOf74y7eOxJ5MTclUNGEeD3kI3GM9Zr0+RW26sG8BKiZNH5OeSzJrJHjhlY8pSckPBu
 NFMebh9hXv9OV/b76qycVvzJEZn+svKh/h0jM9LqoHMyA9p2Nqglp4TuBaxroJyTskp8g4gfENX
 49DBllDMjOyCxIJpk8Z4A=
X-Received: by 2002:a5d:5f88:0:b0:430:fa52:9ea9 with SMTP id
 ffacd0b85a97d-436293b161amr674981f8f.62.1770321520779; 
 Thu, 05 Feb 2026 11:58:40 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:58:40 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com
Subject: [PATCH 00/29] hw/core: Introduce Remote Port Co-simulation Protocol
Date: Thu,  5 Feb 2026 20:57:55 +0100
Message-ID: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42a.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

hw/core: Introduce Remote Port Co-simulation Protocol

This patch series introduces the Remote Port (RP) subsystem, a framework designed to connect QEMU with external simulation environments (such as SystemC models or RTL simulators).

Origin:
The Remote Port protocol was originally developed by Edgar E. Iglesias.
The original source code is available in the QEMU repository at AMD: https://github.com/Xilinx/qemu.

Motivation
In modern SoC and FPGA development, specialized hardware blocks are often verified using SystemC, Verilog, or VHDL long before silicon is available. While QEMU is optimized for high-performance CPU emulation and software development, it requires hardware models to be rewritten in C, which is time-consuming and duplicates effort.

The Remote Port (RP) subsystem addresses this limitation by enabling a Co-simulation environment. It allows QEMU to act as the high-performance Processing Subsystem, booting complex operating systems (e.g. Linux), while delegating specific peripheral modeling to external simulators (SystemC, RTL) via a socket connection.

The Remote Port protocol provides a socket-based interface that supports:

Memory Transactions: Bidirectional memory accesses (Master and Slave) allowing QEMU to access remote devices and vice versa.
Interrupts/GPIO: Propagation of interrupt signals between QEMU and the remote peer.
IOMMU/ATS Support: Support for Address Translation Services, allowing remote devices to operate correctly behind IOMMU.
Time Synchronization: Keeps QEMU and the external simulator in sync by advancing time in fixed steps (quantums).

Integration with SystemC Ecosystem

To connect the simulation side, the open-source libsystemctlm-soc library [1] is used. It acts as a bridge, translating Remote Port protocol packets into standard SystemC/TLM-2.0 transactions [2]. This allows users to attach existing TLM-2.0 compliant models to QEMU.

Architecture Overview

The series is structured into the following logical components:

1. Core Protocol & Infrastructure

Establishes the socket connection and handshake (Hello protocol).
Implements the packet dispatch loop and thread management.
Introduces the -sync-quantum command line option to control simulation time-steps.

2. Memory Transaction Support

RP Memory Slave: Allows the remote peer to initiate bus transactions within QEMU.
RP Memory Master: Represents a memory region in QEMU that forwards accesses to the remote peer.

3. Address Translation Services (ATS)

Implements the logic to handle ATS requests from remote masters.
Integrates with QEMU's IOMMU notifiers to manage translation caches.

4. Device Tree (FDT) & Configuration

Extends fdt-generic to automatically instantiate and wire up Remote Port devices based on Device Tree nodes.
Provides helper functions for dynamic Qdev attachment (rp-adaptor, rp-chan).

Dependencies

This patch series is based on and extends the following previously submitted series:
FDT based machine: https://mail.gnu.org/archive/html/qemu-devel/2026-01/msg05179.html
SMMU support for platform bus: https://mail.gnu.org/archive/html/qemu-devel/2025-12/msg02637.html

Validation:

The functionality presented in this series has been validated using Renesas emulated peripherals.
We are currently preparing a simplified SystemC reference IP core to serve as a functional demonstration and test case for this interface. We plan to provide this in a subsequent update.
We would welcome feedback on the preferred location for this reference SystemC project, e.g. should it be included within the QEMU source tree under contrib/, tests/ or would it be preferable to maintain it as an external repository.

Patch Summary
The series is organized as follows:

System/Global:

system/vl: Introduce -machine-path command line option
system: Introduce -sync-quantum command line option
system/memory: Introduce unified MemoryTransaction and .access callback
system/physmem: Add ats_do_translate helper

Remote Port Core:

hw/core: Add Remote Port protocol packet definition
hw/core: Add Remote Port header helpers
hw/core: Add Remote Port session state and hello protocol
hw/core: Add Remote Port object skeleton
hw/core: Setup Remote Port I/O channels
hw/core: Add Remote Port protocol thread and handshake
hw/core: Implement Remote Port packet dispatch logic
hw/core: Implement Remote Port response handling
hw/core: Implement Remote Port time synchronization
hw/core: Implement Remote Port irq, sync and ATS helpers
hw/core: Add Remote Port files to build

Memory & Bus Access:

hw/core: Implement Remote Port bus access helpers
hw/core: Add Remote Port Memory Master object skeleton
hw/core: Implement Remote Port Memory Master bus transactions
hw/core: Add Remote Port memory slave device
hw/core: Support IOMMU translation for Remote Port memory slave

ATS & Streams:

hw/core: Add Remote Port Stream device
hw/core: Add Remote Port ATS device skeleton
hw/core: Implement Remote Port ATS logic and cache management
hw/core: Add ATS support to Remote Port memory slave

FDT & GPIO:

hw/core: Add Remote Port GPIO/Interrupt bridge
hw/core: Add FDT support to Remote Port GPIO
hw/core: Add FDT support to Remote Port memory master
hw/core: Add Remote Port connection support to fdt-generic
hw/core: Add Remote Port attachment helpers

Links:
[1] libsystemctlm library: https://github.com/Xilinx/libsystemctlm-soc

[2] SystemC TLM description: https://systemc.org/overview/systemc-tlm/

Mirsad Ostrakovic (3):
  hw/core: Support IOMMU translation for Remote Port memory slave
  hw/core: Add Remote Port attachment helpers
  hw/core: Add ATS support to Remote Port memory slave

Ruslan Ruslichenko (26):
  hw/core: Add Remote Port protocol packet definition
  hw/core: Add Remote Port header helpers
  hw/core: Add Remote Port session state and hello protocol
  hw/core: Implement Remote Port bus access helpers
  hw/core: Implement Remote Port irq, sync and ATS helpers
  system/vl: Introduce -machine-path command line option
  hw/core: Add Remote Port object skeleton
  hw/core: Setup Remote Port I/O channels
  hw/core: Add Remote Port protocol thread and handshake
  hw/core: Implement Remote Port packet dispatch logic
  hw/core: Implement Remote Port response handling
  hw/core: Implement Remote Port time synchronization
  system/memory: Introduce unified MemoryTransaction and .access
    callback
  hw/core: Add Remote Port Memory Master object skeleton
  hw/core: Implement Remote Port Memory Master bus transactions
  system/physmem: Add ats_do_translate helper
  hw/core: Add Remote Port ATS device skeleton
  hw/core: Implement Remote Port ATS logic and cache management
  hw/core: Add Remote Port memory slave device
  hw/core: Add Remote Port GPIO/Interrupt bridge
  hw/core: Add Remote Port Stream device
  hw/core: Add Remote Port files to build
  system: Introduce -sync-quantum command line option
  hw/core: Add FDT support to Remote Port GPIO
  hw/core: Add FDT support to Remote Port memory master
  hw/core: Add Remote Port connection support to fdt-generic

 hw/core/Kconfig                             |   4 +
 hw/core/fdt_generic_util.c                  | 130 ++-
 hw/core/meson.build                         |  11 +
 hw/core/remote-port-ats.c                   | 503 ++++++++++
 hw/core/remote-port-gpio.c                  | 206 ++++
 hw/core/remote-port-memory-master.c         | 348 +++++++
 hw/core/remote-port-memory-slave.c          | 326 +++++++
 hw/core/remote-port-proto.c                 | 466 +++++++++
 hw/core/remote-port-qdev.c                  | 181 ++++
 hw/core/remote-port-stream.c                | 239 +++++
 hw/core/remote-port.c                       | 985 ++++++++++++++++++++
 hw/core/trace-events                        |  16 +
 include/hw/core/remote-port-ats.h           |  78 ++
 include/hw/core/remote-port-gpio.h          |  33 +
 include/hw/core/remote-port-memory-master.h |  59 ++
 include/hw/core/remote-port-memory-slave.h  |  39 +
 include/hw/core/remote-port-proto.h         | 547 +++++++++++
 include/hw/core/remote-port.h               | 194 ++++
 include/system/memory.h                     |  31 +
 include/system/system.h                     |   4 +
 qemu-options.hx                             |  21 +
 system/memory.c                             |  66 +-
 system/physmem.c                            |  53 ++
 system/vl.c                                 |  12 +
 24 files changed, 4537 insertions(+), 15 deletions(-)
 create mode 100644 hw/core/remote-port-ats.c
 create mode 100644 hw/core/remote-port-gpio.c
 create mode 100644 hw/core/remote-port-memory-master.c
 create mode 100644 hw/core/remote-port-memory-slave.c
 create mode 100644 hw/core/remote-port-proto.c
 create mode 100644 hw/core/remote-port-qdev.c
 create mode 100644 hw/core/remote-port-stream.c
 create mode 100644 hw/core/remote-port.c
 create mode 100644 include/hw/core/remote-port-ats.h
 create mode 100644 include/hw/core/remote-port-gpio.h
 create mode 100644 include/hw/core/remote-port-memory-master.h
 create mode 100644 include/hw/core/remote-port-memory-slave.h
 create mode 100644 include/hw/core/remote-port-proto.h
 create mode 100644 include/hw/core/remote-port.h

-- 
2.43.0


