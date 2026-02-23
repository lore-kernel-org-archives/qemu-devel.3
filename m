Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAA2EC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZK9-0001Ai-AP; Mon, 23 Feb 2026 12:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZK7-00018d-Uv
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:19 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZK4-0008Tr-TF
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:19 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-483abed83b6so14141625e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866135; x=1772470935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lkgXJFXZuKXmuat63r4N9pP/R4leNSm81JN3BlwDYMY=;
 b=Ed/2iIJOx2/m/T1Mw1JwzAEIcrTtYl8pSM7kC7qJv2GLjcSpR2Mu2eX6WExAJ7razG
 oIyTASDg0KXw3Bb57JPVLX9rWMI4mOcEEhRoQSnCt5J7rnzbPDo7B3Rp1j2+Icewjt8S
 V5UvupHLKm56NX31RzHiiCbML5BNXD+YnKtvSVyBwPV4T9RlotCzlAZYETusTHQKNEcv
 wwlOlQ0OgXXxPmaZGBtjr61een3rOqNQRlyIGdUI97YCOVqeZKDjTvX8jy68mw3Vk6fE
 gmnw4KYh2y9w/u3xMGbv/x0MIQEZj+JXolEmhJxBDcx+RJTQhuSm00B5z/Jo+/PCBo4o
 rhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866135; x=1772470935;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lkgXJFXZuKXmuat63r4N9pP/R4leNSm81JN3BlwDYMY=;
 b=eMPrkZIGG5StOCqskgTFcfY2JUT8HUWP1eSWULNTf1b7fDPS3z979FaAhPlwizyBtP
 id9pU32b2T/YdHuJ7aqRWcsJqcV50fh3MSieRU7nuL+ysA1/TO/Y8vACGLPU2B2SUo+Q
 IfNtGtXKn58pHj2BkdFYvUJBPNgILX9wl26/FOhXVrvZdYxEUEig1+1etabixXQrsybX
 0pO0QM603ShfLKza9gop9uv/+x9q8tzaPGvhoUzAt8LoQawXv0JUWXq1fYzrhjbxpT0m
 aVopzInULmyzxjeZuHRyb0tCQdQOrj3UM8Wq1MOKNxiEycs4Wkx66KUOjo76G0F4I0Q7
 oy7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrNAEAX3G7AEwmBEF1iQnd9jutiuU7HE6fhUrkhrVcDaCUgGHSG1uvHVv0/nNNoXo0575mJ3hA5Cma@nongnu.org
X-Gm-Message-State: AOJu0YxL8BVsYFmmrlyGDaVM8bQxgx9V+PJTLeaLdWCNyojm3Vhf2viY
 GYt9qUloJxxfNNePk7mC+N8GeBKn7xQmbtiaLvs4wRa/slpG7hFtTrp0rf1FioGGvzQ=
X-Gm-Gg: AZuq6aKmyedIVDHcY00zQe3PlYTxAB4BrlM3HX2sLIKXK0DGm5YtJKQnqc2ecA0gxuT
 TdQ789EtHJXXCKZNXalXCnQpLe3HQnt+9Juu/vxpvfFhCavvG0QT8C2DS4A25V4Pk7TjnldAKv/
 PZtyN6AbcgAXcJ5/zzvDYT0Mr3IRmWvyD/ZnaiScGb1At+M4tt+/R69xLLks3o656PpYBrPujAT
 6bKtEnycmZUUm4JvaLCyG++K7Ou8d7x8AydeEN5K30cE7UIOcOwLsyj7Pdr2jOWBejEwh+U+4if
 Gij8SzCrxF21Zv8QLGjqTGC8RBMyhqZnKlEBn9Bf7DW1gX1rHH2N7NhDaFoFHVFytfVj5dyUIh3
 vhpnv6KzYc54JvVQ2W90LkqmPZSRzhbGXQfMGz3RmK7C4yTGM5NPVp/5QRfCf+lpvLi85bp7Iht
 sZOqoQxpeBTNsbd8ljvnIZYJlMeTdF9tqmNSST4A9FM1KEOM9nNvGTlGdBDW+z851Bjp0ano6dr
 t+oZYEnmelcR9I78fimTlOZLrFPydM=
X-Received: by 2002:a05:600c:3b17:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-483a95b15b6mr164546535e9.7.1771866134344; 
 Mon, 23 Feb 2026 09:02:14 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/65] arm: Implement an emulation of GICv5 interrupt
 controller
Date: Mon, 23 Feb 2026 17:01:07 +0000
Message-ID: <20260223170212.441276-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
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

This patchset implements initial support of emulation of Arm's new
interrupt controller architecture, GICv5.

The most recent version of the GICv5 spec (currently 00EAC0) is at:
https://developer.arm.com/documentation/aes0070/latest/

The emulation is at an "experimental" level, both because the GICv5
specification is still at an early-access level and minor changes are
possible, and also because this emulation is missing some
functionality which I plan to add later but which would have made this
initial patchset even larger and later. To quote the docs patch:

    - guest-visible behaviour may change when the final version of
      the specification is released and QEMU implements it
    - migration support is not yet implemented
    - the GICv5 is not exposed to the guest via ACPI tables, only via DTB
    - the way the interrupt controller is exposed to the guest and the
      command line syntax for enabling it may change

    The current implementation supports only an EL1 guest (no EL2 or
    EL3 and no Realm support), and does not implement the ITS (no
    MSI support).

The GICv5 is supported by the "virt" board, and can be enabled with
"-machine gic-version=x-5" (the 'x' standing for "experimental").

Like the GICv3/v4, the GICv5 has both a system component part (the
Interrupt Routing Service, IRS), and a part in the CPU itself (the CPU
interface). Our GICv3 model puts both of these into code in hw/intc/,
and has the cpuif part install itself into an existing CPU object by
adding new system registers there. This works, but in retrospect I
feel that it's a bit awkward and we would have done better to make our
design a bit closer to the hardware setup, where the CPU interface is
really part of the CPU and talks to the system component over an
architected protocol. So for GICv5 I have taken that route: the IRS is
in hw/intc/arm_gicv5.c, and the CPU interface is in
target/arm/tcg/gicv5-cpuif.c. They communicate via a set of functions
which loosely match the "stream protocol" defined in the GICv5
architecture spec (with some simplifications that result from QEMU
being strictly synchronous because we always hold the BQL when
executing any GICv5 emulation code; the hardware has to handle the IRS
and the CPU executing in parallel and the communications channel not
being instantaneous transmission).

Although the EL2/EL3/Realm functionality is not present in this
patchset, I have implemented some of the foundations for it where I
thought it made sense, to avoid having to refactor it later.
Similarly, the class structure makes the usual "common baseclass + TCG
subclass" split, as we are going to want a KVM subclass when we add
KVM support.

In a few places I have noted possible opportunities for performance
optimisation; these are probably best left until we've done some
analysis that shows them to be necessary.

This patchset is sufficient to be able to boot a Linux guest at EL1
(directly via -kernel): all the kernel support for GICv5 is upstream
as of Linux 6.19.

One or two of the patches in here have appeared on list separately;
I've put in the Reviewed-by tags in those cases.

I'm optimistic that we can get this into the upcoming 11.0
release, but that will depend on how code review goes :-)

thanks
-- PMM

Peter Maydell (65):
  hw/core: Permit devices to define an array of link properties
  hw/intc: Skeleton of GICv5 IRS classes
  hw/arm/Kconfig: select ARM_GICV5 for ARM_VIRT board
  hw/intc/arm_gicv5: Implement skeleton code for IRS register frames
  hw/intc/arm_gicv5: Add migration blocker
  hw/intc/arm_gicv5: Create and validate QOM properties
  hw/intc/arm_gicv5: Create inbound GPIO lines for SPIs
  hw/intc/arm_gicv5: Define macros for config frame registers
  hw/intc/arm_gicv5: Implement IRS ID regs
  hw/intc/arm_gicv5: Add link property for MemoryRegion for DMA
  hw/intc/arm_gicv5: Implement gicv5_class_name()
  hw/intc/arm_gicv5: Add defines for GICv5 architected PPIs
  target/arm: GICv5 cpuif: Initial skeleton and GSB barrier insns
  target/arm: Set up pointer to GICv5 in each CPU
  hw/intc/arm_gicv5: Implement IRS_IST_{BASER, STATUSR, CFGR}
  hw/intc/arm_gicv5: Cache LPI IST config in a struct
  hw/intc/arm_gicv5: Implement gicv5_set_priority()
  target/arm: GICv5 cpuif: Implement the GIC CDPRI instruction
  hw/intc/arm_gicv5: Implement IRS_MAP_L2_ISTR
  hw/intc/arm_gicv5: Implement remaining set-config functions
  target/arm: GICv5 cpuif: Implement GIC CD* insns for setting config
  hw/intc/arm_gicv5: Create backing state for SPIs
  hw/intc/arm_gicv5: Make gicv5_set_* update SPI state
  hw/intc/arm_gicv5: Implement gicv5_request_config()
  target/arm: GICv5 cpuif: Implement GIC CDRCFG and ICC_ICSR_EL1
  hw/intc/arm_gicv5: Implement IRS_SPI_{SELR,STATUSR,CFGR,DOMAINR}
  hw/intc/arm_gicv5: Update SPI state for CLEAR/SET events
  hw/intc/arm_gicv5: Implement IRS_CR0 and IRS_CR1
  hw/intc/arm_gicv5: Implement IRS_SYNCR and IRS_SYNC_STATUSR
  hw/intc/arm_gicv5: Implement IRS_PE_{CR0,SELR,STATUSR}
  hw/intc/arm_gicv5: Implement CoreSight ID registers
  hw/intc/arm_gicv5: Cache pending LPIs in a hash table
  target/arm: GICv5 cpuif: Implement ICC_IAFFIDR_EL1
  target/arm: GICv5 cpuif: Implement ICC_IDR0_EL1
  target/arm: GICv5 cpuif: Implement GICv5 PPI active set/clear
    registers
  target/arm: GICv5 cpuif: Implement PPI handling mode register
  target/arm: GICv5 cpuif: Implement PPI pending status registers
  target/arm: GICv5 cpuif: Implement PPI enable register
  target/arm: GICv5 cpuif: Implement PPI priority registers
  target/arm: GICv5 cpuif: Implement ICC_APR_EL1 and ICC_HAPR_EL1
  target/arm: GICv5 cpuif: Calculate the highest priority PPI
  hw/intc/arm_gicv5: Calculate HPPI in the IRS
  target/arm: GICv5 cpuif: Implement ICC_CR0_EL1
  target/arm: GICv5 cpuif: Implement ICC_PCR_EL1
  target/arm: GICv5 cpuif: Implement ICC_HPPIR_EL1
  hw/intc/arm_gicv5: Implement Activate command
  target/arm: GICv5 cpuif: Implement GICR CDIA command
  target/arm: GICv5 cpuif: Implement GIC CDEOI
  hw/intc/arm_gicv5: Implement Deactivate command
  target/arm: GICv5 cpuif: Implement GIC CDDI
  target/arm: GICv5 cpuif: Signal IRQ or FIQ
  target/arm: Connect internal interrupt sources up as GICv5 PPIs
  target/arm: Add has_gcie property to enable FEAT_GCIE
  hw/intc/arm_gicv3_cpuif: Don't allow GICv3 if CPU has GICv5 cpuif
  hw/arm/virt: Update error message for bad gic-version option
  hw/arm/virt: Remember CPU phandles rather than looking them up by name
  hw/arm/virt: Move MSI controller creation out of create_gic()
  hw/arm/virt: Pull "wire CPU interrupts" out of create_gic()
  hw/arm/virt: Split GICv2 and GICv3/4 creation
  hw/arm/virt: Create and connect GICv5
  hw/arm/virt: Advertise GICv5 in the DTB
  hw/arm/virt: Handle GICv5 in interrupt bindings for PPIs
  hw/arm/virt: Use correct interrupt type for GICv5 SPIs in the DTB
  hw/arm/virt: Enable GICv5 CPU interface when using GICv5
  hw/arm/virt: Allow user to select GICv5

 docs/system/arm/virt.rst           |   19 +
 hw/arm/Kconfig                     |    1 +
 hw/arm/virt.c                      |  524 ++++++--
 hw/core/qdev-properties.c          |   78 ++
 hw/intc/Kconfig                    |    4 +
 hw/intc/arm_gicv3.c                |    2 +-
 hw/intc/arm_gicv3_cpuif.c          |   14 +-
 hw/intc/arm_gicv5.c                | 1933 ++++++++++++++++++++++++++++
 hw/intc/arm_gicv5_common.c         |  227 ++++
 hw/intc/gicv3_internal.h           |    2 +-
 hw/intc/meson.build                |    4 +
 hw/intc/trace-events               |   23 +
 include/hw/arm/fdt.h               |   10 +
 include/hw/arm/virt.h              |   15 +
 include/hw/core/qdev-properties.h  |   40 +
 include/hw/intc/arm_gicv5.h        |   51 +
 include/hw/intc/arm_gicv5_common.h |  238 ++++
 include/hw/intc/arm_gicv5_stream.h |  229 ++++
 include/hw/intc/arm_gicv5_types.h  |  111 ++
 include/qom/object.h               |   19 +
 meson.build                        |    1 +
 qom/object.c                       |   42 +-
 target/arm/cpregs-pmu.c            |    9 +-
 target/arm/cpu-features.h          |   11 +
 target/arm/cpu.c                   |   62 +
 target/arm/cpu.h                   |   28 +
 target/arm/helper.c                |   21 +
 target/arm/internals.h             |    9 +
 target/arm/tcg/gicv5-cpuif.c       |  958 ++++++++++++++
 target/arm/tcg/meson.build         |    1 +
 target/arm/tcg/trace-events        |   11 +
 target/arm/tcg/trace.h             |    1 +
 32 files changed, 4542 insertions(+), 156 deletions(-)
 create mode 100644 hw/intc/arm_gicv5.c
 create mode 100644 hw/intc/arm_gicv5_common.c
 create mode 100644 include/hw/intc/arm_gicv5.h
 create mode 100644 include/hw/intc/arm_gicv5_common.h
 create mode 100644 include/hw/intc/arm_gicv5_stream.h
 create mode 100644 include/hw/intc/arm_gicv5_types.h
 create mode 100644 target/arm/tcg/gicv5-cpuif.c
 create mode 100644 target/arm/tcg/trace-events
 create mode 100644 target/arm/tcg/trace.h

-- 
2.43.0


