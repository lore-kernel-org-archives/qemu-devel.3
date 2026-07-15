Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1E0C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjzuN-0005P8-Fg; Wed, 15 Jul 2026 09:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzuK-0005Od-SY
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:44:16 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzuI-0007rK-RD
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:44:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=X3pybR2
 Yc+mCc2JbXe6dBNpB4cjvNDgiYi3ZHhoBF4YRpRT076MekMve+EyjANmBCIfn41IOrzVQx
 kJ1nhiort4UmHTiTPV5Yu+lHUi/tXkkAwd9rveXZBjl8k3oCqKvjdLenEQxPR+VWxohVg/
 b2TJ6cc8Ccui0No3MQhxtiaIXU8PwOQ1/ueZLAjqunfoXC1vRkoeKKnHZMouEOOD1ACPnh
 KfAZqdOYZRemWlwPCbo3KLR+HYDMwCY/BpT2jLRAzxjQE17d+i8I50jrwKKyV4CWKZSuRw
 m6RFLCZo39dkI1sq9UzLQEO5M5iLvrBozW/7w/sgCYCl2SP1zuRSRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=r
 5frVbXduqQs4YTnefratMLxz1laxjgZKx3ET7Ix/mQ=;
 h=date:subject:to:from:
 dkim-signature:dkim-signature; d=mx.catap.net; b=SualkKjZcQGTtcrBh9kTu
 dTDTb+/fl7GAZ5Sv7stLO2dZOh64N7pDo7gPiZUv6kAbTQTH7AK+2Ni/LTJWX7CRQdkWcx
 jgADDFDBZPeQimOyZnwY+bcxEOd0BWURiHWT/zIaSahBFOhMFs6dc5HzUxADoJ9IuiW0Gh
 ISrLhM/j8bqeWLDTYUSRma+IC3cg5Nez46XLNoNm+Yg5ZN6Zpqr6jHfXWtDRMHwjedqcA4
 yyopFr056gcOXvfxit9NeoEFrobYKkyqLuYmnSjivHiNZac9yGapgAdzvHQn77OqHUUlRX
 uBR0Lp/+UwMj6Srf0eJl1PyHfLGxjQyPAth8wXGIw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=wuDzxNRF; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=wrFBFEgy;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=r5frVbXd
 uqQs4YTnefratMLxz1laxjgZKx3ET7Ix/mQ=; h=date:subject:to:from; 
 d=korins.ky;
 b=wuDzxNRF0YifVscsPiO1T+QDYkhJXD/AlbiIjMiyFgvdvoKb18Lw4Xq
 +5FtwOK05/Pt+2CxhPc6/WqX3srIluuOWPq8vRi/aR5mFjmGctFgQaNrLw7GKJFd0jc9xR
 700cQFxBo+Nmi+UQXI/74b88BF13+ROuAqkqZ31MJlxQGRkjzHYEZoUz4YsB66TBOX6K48
 AkfcgCLNh1yVnrYRBRSrhbIOtD1tsNJdkuGrmPUG7XjAa0LTGiUvAAacUi2K/0DFCa0JWa
 TVrikU5ucH9WrGZfuOnb/F1hDSBkRp7hFUgH3e5Vl7WGElrs0vlnYBZAjhQrk74QDfCJkF
 ybU/eQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=r5frVbXduqQs4YTnefratMLxz1laxjgZKx3ET7Ix/mQ=; h=date:subject:to:
 from; d=korins.ky; b=wrFBFEgyUdT0QiZyENJQjeWtxurAZ0DpcbfEWmzxRYadBKGcD
 OgXaLLyjY4mw7knq/j09kKs6C6ZVvQpbVkTAA==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id b4cd0c34
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) for <qemu-devel@nongnu.org>;
 Wed, 15 Jul 2026 15:44:10 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id e80f8281
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 15:44:08 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/25] hw/mips: add Octeon III EBB7304 support
Date: Wed, 15 Jul 2026 15:42:13 +0200
Message-ID: <20260715134351.82007-1-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

This series adds enough Cavium Octeon III CN73xx and EBB7304 board
support for upstream U-Boot 2026.04 to boot OpenBSD/octeon from USB
storage or through PCI e1000 and TFTP; the same machine also reaches
the prompt of the vendor U-Boot 2013.07 image from the Ubiquiti
EdgeRouter Infinity ER-8-XG recovery set. The model intentionally
covers the hardware exercised by these firmware and operating system
paths.

The vendor recovery image is U-Boot 2013.07, UBNT build
e1000_002_ef3a9; it reaches:

    Octeon ubnt_e1000(Failsafe)#

This is the expected command prompt of the recovery U-Boot environment;
"Failsafe" describes the recovery image and does not indicate an
emulation or boot failure.

Early Octeon investigation used Amir Mehmood's original Octeon
host.patch as a behavioral reference; the basic machine approach and
several hardware model ideas come from that work. No code from that
patch remains in this implementation.

The series starts with three generic MIPS correctness fixes for MTTCG
interrupt state, MIPS64 segment checks, and architectural tlbwr
replacement semantics. It then adds Octeon CP0 state, the CN73xx CPU
model, PageMask handling, and unaligned accesses before introducing an
empty EBB7304 machine. The remaining patches add the machine state and
peripherals incrementally, followed by the functional test.

The machine currently models:

* the EBB7304 RAM layout, boot flash aliases, and boot-local RAM;
* CN73xx CPUs, Octeon CP0 state, CVMSEG, and configurable clocks;
* reset control, legacy CIU and CIU3 interrupt routing, mailboxes, and
  secondary CPU release;
* UART, two TWSI controllers, synthesized DDR4 SPD, four LMC register
  banks, fuses, RNG, POW, and the firmware probes used during platform
  initialization;
* the EMM registers needed for firmware MMC initialization;
* two UCTL-wrapped DWC3 controllers, sufficient for U-Boot USB storage;
* a minimal PCIe host bridge, sufficient for a PCI e1000 device.

The functional test starts upstream U-Boot with four CPUs, enumerates
PCI, obtains a DHCP lease, downloads bsd.rd through user mode TFTP, and
boots the OpenBSD/octeon 7.9 installer.

The OpenBSD boot and USB stress testing used Philippe Mathieu-Daudé's
suggested xHCI change which clears ERDP_EHB after a successful interrupt
callback: https://marc.info/?l=qemu-devel&m=178402329968274&w=2

That one-line change is kept in the development branch and is not part
of this series. With it applied, a full cvs -Q checkout of the OpenBSD
ports tree to USB storage completed without a stall.

Each submitted commit was built in sequence and given the meaningful
smoke test available at that point. The final tree was tested with:

    ninja -C build qemu-system-mips64
    gmake -C build check-qtest-mips64
    gmake -C build check-functional-mips64

The qtest suite reported 14 passes, 2 empty suite skips, and no
failures. The functional suite reported 7 passes, 2 expected skips,
and no failures; its Octeon case reached the OpenBSD installer prompt.

Before the final rebase, the machine also completed a GCC build inside
OpenBSD/octeon using:

    -m 16G -smp 4 -accel tcg,thread=multi

That workload ran for several days.

Known limitations are:

* native Octeon Ethernet is not modelled; the OpenBSD test uses PCI
  e1000;
* EMM implements the firmware initialization path, not a complete MMC
  data path;
* direct kernel boot through -kernel is not implemented;
* the newly modelled board and peripheral state lacks VMState
  descriptions; migration and savevm are not expected to preserve the
  complete machine state.

Changes since v1:

* split the single machine patch into the empty machine, CPU and memory,
  controller, peripheral, wiring, and test changes;
* moved the TWSI, USB, and PCI host models to hw/i2c, hw/usb, and
  hw/pci-bridge respectively;
* replaced DEVICE_NATIVE_ENDIAN with explicit MMIO endianness;
* moved mutable peripheral state into its owning device and converted
  reset handling to the Resettable interface;
* dropped the xHCI interrupt reassertion patch from the submitted
  series.

Patches 1 through 3 are generic MIPS correctness fixes. Patches 4
through 7 add Octeon target support. Patch 8 adds the empty machine;
patches 9 through 24 add CPUs, memory, controllers, and peripherals.
Patch 25 adds the functional test.

The series is based on
499039798cdad7d86b787fec0eaf1da4151c0f05, which already contains the
Octeon COP2 implementation.

Patch layout:

  1. target/mips: make CP0 interrupt state atomic
  2. target/mips: fix MIPS64 segment access checks
  3. target/mips: drop hidden TLB shadowing for tlbwr
  4. target/mips: add Octeon CP0 register state
  5. target/mips: add Octeon CN73xx CPU model
  6. target/mips: accept Octeon PageMask encodings
  7. target/mips: allow Octeon unaligned accesses
  8. hw/mips: add empty Octeon III machine
  9. hw/mips: add Octeon CPUs and boot memory
 10. hw/mips: add Octeon reset controller
 11. hw/mips: add Octeon CIU3 CPU control
 12. hw/mips: add Octeon CIU3 interrupt routing
 13. hw/mips: add Octeon legacy CIU
 14. hw/mips: add Octeon CSR window
 15. hw/mips: expose Octeon reset CSRs
 16. hw/mips: add Octeon MIO boot support
 17. hw/mips: wire the Octeon UART
 18. hw/i2c: add Octeon TWSI controller
 19. hw/mips: add Octeon EMM controller
 20. hw/mips: add Octeon LMC controllers
 21. hw/mips: add Octeon boot support registers
 22. hw/usb: add Octeon USB controller
 23. hw/pci-bridge: add Octeon PCI host bridge
 24. hw/pci-bridge: add Octeon PCI memory window
 25. tests/functional: test Octeon III boot

Thanks,
Kirill



