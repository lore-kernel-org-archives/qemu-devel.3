Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D543FC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x26CA-0002lL-W0; Thu, 03 Sep 2026 08:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26C3-0002hI-Lu
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:25 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26C0-0005JF-U6
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=ZZB65Xs
 3SaYDMQisOo6zz2J24OlM2aH10ToUJLh33SMQ7F96tKJi7WMwL40AoJTodOW9/CKvqhCcl
 LfDeHggOXcSEI7677EJH07hMHbeMnImF7Kb4G0suLpLhuXswg3uInCn5eKfhhCbPDoHPpO
 D20rNQnk8VZHqlYXCPpZussaZ6lO3Fqn925xLKlEJjHIIisaaH8Fxqk3/GDZ24bBcko68X
 /ATUnMAoxKyQgQfxFGiXsqTA9GhOU+M6CyPPwjtOobSYw0FSX/oeA+OyHJSsBc8VOn4cUi
 jIxCLW6+cGTztWjZO7Z/u/UMnIxMXut6QCSvjJPjtwqKHOKfLTAWAGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=Z
 JnUKeBxHQ5UliSWU3+laBLfl4/J4RJybm0LCxvZFhQ=;
 h=date:subject:cc:to:
 from:dkim-signature:dkim-signature; d=mx.catap.net; b=n7RH3uhZXywk3mlX
 ljH7SRzPfs7ZYwIqfxCv6MVOialV83BePN0Y03suHZxhLrCIDxtlkRva9gKmo/Lr54OLKU
 z97QiAn6LKIrnTPIKV+pSQ/IDE/sAv+K8J612HV3tCjzlv1f9hrrYm5Vlp8ycaNfnjcURR
 2HO/J2GIqSowJBIkF4JhYqRRVDP/MFUUmnlAw7OcRye9I6YcaorDlB7hrbv1A0/bpwtUeg
 SKe5EoBv2xSxCUnxfgzIQHv0OPuPaIN66uXw8wRpzgPJB5d4JfGrWQ4YfHCfHE/RbbU+wX
 Pova1fLkAai6hviHe03uIWtSnCF/agQNeyXzSZqTOtsJLA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=cAfU/uSk; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=0HpNXLqv;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=ZJnUKeBx
 HQ5UliSWU3+laBLfl4/J4RJybm0LCxvZFhQ=; h=date:subject:cc:to:from;
 d=korins.ky; b=cAfU/uSkPXme5ENkLS6Wf8iNMhbcm5yTqJ8t6p1MFN/naVfKkaR4S5L
 DXg4h41aXH09N1mIUm43x/VsihQ9aPMlW64Hsxf7ToU/T5tAC2iG23C7den4aPRLWKM1N7
 TlI/yZYWZarSfNEs460/NWiEFtFrKoQH1f9KVjQfhJbobBDDI6oUqfwsveQt+fT+26gzOp
 VuOMOu1kQkk4JfCpmMp5PoqOHBhc9URCCGVGBu9wEm8NM+OSRXMX2yj9yPJCQxCYT5bHBz
 4Z9UP8aSXWp4AHaCnGT+aLfttLcJ05UnxHlOJXhIAkC/ErMhNVfUc4OqDVPSzxq152iihc
 G1SG8cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=ZJnUKeBxHQ5UliSWU3+laBLfl4/J4RJybm0LCxvZFhQ=; h=date:subject:cc:to:
 from; d=korins.ky; b=0HpNXLqvxqDjfIxheJu9s2YErRslvSpWv9JmDvOF/msVQ3fzk
 m/j3aDURjJiOOE9NaRYTXt5n0xLV/cKPRAXDA==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 18d68a94
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 3 Sep 2026 14:05:17 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id b83eecf7;
 Thu, 3 Sep 2026 14:05:15 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 0/25] hw/mips: add Octeon III EBB7304 support
Date: Thu,  3 Sep 2026 14:01:48 +0200
Message-ID: <20260903120510.34876-1-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
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

Greetings,

This is resend which includes missed maintainer.

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

The OpenBSD boot and USB stress testing requires additional patch for
xHCI which I haven't included into this series:
https://patchew.org/QEMU/20260719215455.96122-1-kirill@korins.ky/

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



