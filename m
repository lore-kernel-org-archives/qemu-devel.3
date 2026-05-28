Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89055CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSjHh-0000IV-Vc; Thu, 28 May 2026 18:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wSi1Z-0008Tg-NT
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:12:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wSi1X-00054x-2R
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:12:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490426d72f7so64708585e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 14:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780002732; x=1780607532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n/ThAg9pqjl55KzwpdqeCrAjDbuVSrXfGWiDGzPdgS4=;
 b=p2f+xPcqbEbtCN6+7YJAayYbs33sCL161lhHKFbTCmGEbzGQz7Tz7sNX10Ky4/onBZ
 Scyg6r8n78pqfOLudK12uydNvSrUdFytb0RRubH+cGcEWvFK8hXBqY3EHrbIYYsf0LOB
 eGKIFnSr5vN8z+1JpT1PF3ho0/cDYYraTf+Ls+L5ihZNpVZYP68tT3Ne88EVThefjINs
 E4kja7QD8PNG+Dh6iCCBdePRqKe+n7N+E1fWFFm8fY9+d/SfhWeCrsyJvFvDNOEarjsk
 BLsb33OyKZoXI2bakYN72pY91UolIxNUSne3mhEpZgo/SMGfDn6qf8QOKpUhozwfalFv
 T1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780002732; x=1780607532;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/ThAg9pqjl55KzwpdqeCrAjDbuVSrXfGWiDGzPdgS4=;
 b=pE1zm+DhVU9Hgeq4QSdmWYoPrD5OCIJE+gtD76PI1Woj5hGpRpFKdHT4xbX9gB3VuM
 4QUCmk4mDhkyv2D5mydJyB93WrodWkNVvvmMseWOdyooBg9ozC0ViNalPrCgBbZglWfR
 qWDgmD0kVkAIS6OfIwnWgFFJ9IoWvqbiWBs2JGtWpJnzFvFZOrv0jNsOKPhM+zWlnTHf
 JJ1uCiMQbBuV9+1EZzJ3jNGgksOUezDeJ1mMfC8ydLPX2V7nC/yyBVvX3Wg22sN/LK93
 Nh+wrguZ4oHBsi6UBzPh3Qhssp7QNtI4NeXgHd6zkwJMauBufPDX63CMzrgErDy24q+E
 GeZw==
X-Gm-Message-State: AOJu0YzTM/Xh4u48eto5QptvJv44lKjJgJHIq5yYqDYF6OSBZor7EYn6
 37a2MNCYzhVyQVriFqyFXibAAraUAqMi187oWWUQlsRovf2S/j720IurduAvpvPA
X-Gm-Gg: Acq92OHxM91FrSffinU0uJK1eKfmncMttPJeTHQHAFinM7pzKmAkgkrZhFjJJcXkqcn
 LyJwlxIWzRLEADOZCmqwajPVquPdGR/rsHmlMho89hmiYmHXmClmsaOeZDTAJsVWTridTuaUYPK
 3WgMmHD1fnuu9rKVmjjL9W/XXevtoC1eEUm5xodhGpVbkWtr6pg5kIBFj5VcjB+IWDvhK8Wr73b
 j5xscA6uQoHLNV76tvQtOcM1Qctxnoi7O1n6yvDvylk5AZUPjBo9Z21oZK9SnQYmmPBP51UPGVu
 iZoUM/o+J7TlOPKHbPiBcx/ctjU1wDiBYTuQaTa4mcphqTHoXEeH6UnRtETHsupVSNGJ8dsjqYC
 qMn9TN1NO9EBAEfQSRCdnGipoAjeyca+jeC8D2ajdbHeccovleHYN/Hgn9uFAu0nDAcdTef7ArN
 Q/KIcG4sq4sHIwgsU=
X-Received: by 2002:a05:600c:4ecc:b0:490:601f:d77b with SMTP id
 5b1f17b1804b1-4909c03c0cemr3467465e9.0.1780002732236; 
 Thu, 28 May 2026 14:12:12 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c609787sm108365e9.6.2026.05.28.14.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 14:12:11 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v0 0/2] hw/arm: Add initial TI K3 AM64x platform support
Date: Thu, 28 May 2026 23:12:08 +0200
Message-ID: <20260528211210.74266-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=wafgo01@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 28 May 2026 18:32:55 -0400
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

Hello QEMU community,

This RFC introduces an initial support for the TI K3 AM64x SoC family
("Sitara AM64x"). Currently there exists no support for any TI K3 SoC
in upstream QEMU; the goal of this series is to start that
conversation, rather than to land a fully-fledged platform in one
single drop.

The two patches in this series are intentionally minimal:

  1. hw/arm: Add minimal TI K3 AM64x SoC model
       Cortex-A53 cluster (1-2 cores), GIC-400, two MAIN-domain
       16550-style UARTs.

  2. hw/arm: Add AM64-virt machine
       Wraps the SoC and prepares it to boot a Linux kernel on the
       A53 cluster (-kernel / user-supplied -dtb).

Together: ~350 lines. The intent is to make the *direction*
reviewable, not to ship the full stack in one go.


Why this is being sent as RFC
=============================

The real motivation behind this work is asymmetric multi-processing
(AMP) debugging on K3: a Linux kernel running on the A53 cluster, a
small RTOS running on the Cortex-M4F MCU, and being able to debug
the M4F firmware from its reset vector while the Linux side is held
in its rpmsg/remoteproc driver. The TI K3 platform is built around
exactly this use case in real hardware, but no QEMU model exists.

Already a considerably more complete prototype exists on GitHub:

    https://github.com/wafgo/qemu/tree/wafgo/am64-amp-prototype

That prototype currently:

  * Boots Linux SMP on the A53 cluster.
  * Brings up the Cortex-M4F core via the standard K3 TISCI protocol
    issued from the Linux ti-sci driver.
  * Models enough of the TI Secure Proxy and Mailbox IPs that
    the in-tree Linux rpmsg/remoteproc drivers come up.
  * Boots a FreeRTOS / MCU+ SDK image on the M4F and exchanges
    messages with Linux via the in-tree IPC rpmsg demo.
  * Allows full reset-vector debugging of the M4F firmware from gdb
    while the Linux side is held in the rpmsg driver -- the actual
    use case that motivated all of this.

Note up front: I am not really proud of the prototype's code
quality. Or rather -- I am proud of what it does, but the code
itself is more of a "run away while you still can" kind. That is
exactly why this is an RFC and not a v1: I would like architectural
feedback now, before I clean the prototype up into upstreamable
patches in the possibly wrong direction.

The prototype contains a number of design choices I am explicitly
not sure if they are the right shape for upstream. Instead of
spending further weeks polishing patches in a direction where the
community possibly pushes back, I would like to get early feedback
to those decisions first.

Who would benefit from this in upstream QEMU
--------------------------------------------

  * Linux K3-driver developers who do not own a TI dev board can
    iterate against a free, mainline emulator.
  * Firmware developers (M4F / R5F) can debug from the reset vector
    without a JTAG probe, which is exactly the use case that drove
    this work.
  * Anyone running automated CI against K3 platforms gains an
    option that does not require physical hardware in the loop.

The headline questions are these:

    a) Is there interest in TI K3 / AM64x support in upstream QEMU
       at all?

    b) Is "DMSC modelled as a firmware-service QOM device behind a
       real Secure Proxy" (question 1 below) the right architectural
       shape, or do you want the actual Cortex-M3 + SYSFW blob
       instead?

In case of yes, the more specific (secondary) design questions
follow afterwards.


Design decisions I'd like feedback on
=====================================

Two headline questions and four secondary ones. The first two
shape the whole follow-up plan, the rest can be relitigated later.

Headline
--------

1. DMSC modelled as a "firmware service" QOM device, no MMIO of
   its own.
   On real K3 hardware, the DMSC ("Device Management and Security
   Controller") runs the proprietary TI SYSFW image on a Cortex-M3
   inside the SoC. The host-facing interface to that firmware is
   the TI Secure Proxy, which is a separate MMIO IP block.

   The prototype keeps the Secure Proxy as the MMIO entry point
   (modelled as its own QOM device, see question 2) and replaces
   only the SYSFW image: instead of modelling the M3 core and
   running a real SYSFW blob on it, the request-handling logic
   lives in a separate QOM device with no MMIO of its own. That
   device is linked to the Secure Proxy via a QOM link and
   registers callbacks for inbound TISCI threads; the Secure
   Proxy invokes those callbacks when the guest completes a
   message in the data window.

   The "service device" route is dramatically simpler, avoids the
   binary blob, and is enough to drive the upstream Linux ti-sci
   driver. Is that approach acceptable upstream, or do you want the
   real M3 + firmware path?

   (Comparable existing approaches I am aware of: Xilinx PMU/PSM-style
   management firmware in xlnx-versal respectively xlnx-zynqmp.)

Secondary
---------

2. Secure Proxy with a callback registry into DMSC.
   The Secure Proxy is modelled as MMIO. When the guest writes the
   last word of a message into the data window, the transport
   invokes a registered callback so the DMSC service device can
   react asynchronously (via a QEMUBH). Is that transport-vs-service
   split sensible, or should Secure Proxy + DMSC collapse into one
   device?

3. RAT (Region Address Translation) as a MemoryRegion alias
   container.
   The M4F's view of address space is reshaped via 16 software-
   programmable translation windows. The prototype models RAT as a
   parent container MemoryRegion in the M4 address space, with each
   entry as a MemoryRegion alias into the system memory. Enable /
   disable corresponds to add_subregion / del_subregion at runtime.
   Is that the idiomatic shape, or should this look more like an
   IOMMU?

4. GIC revision.
   Real AM64x uses a GIC-500 (GICv3). This v0 and the full prototype
   use GIC-400 (GICv2), since it is mechanically simpler and already
   boots Linux. Shall the initial upstream version go directly to
   GICv3?

5. Cortex-M4F bring-up using arm_set_cpu_on_and_reset().
   The prototype triggers M4F start/stop by calling
   arm_set_cpu_on_and_reset() / arm_set_cpu_off() from the DMSC
   service device, addressed by a CPU-index property. That feels
   fragile. Is there a more idiomatic way to expose "reset and
   start CPU X" to a non-power-controller device?

6. "am64-virt" naming and scope.
   The machine deliberately deviates from any real AM64x board: no
   flash, no PCIe yet, no built-in device tree. The reason for the
   "-virt" cut is practical: real AM64x reference boards (SK-AM64,
   AM64x-EVM) pull in DT references to every sub-IP -- INTC routers,
   ringacc, BCDMA, SerDes, sysfw, etc. -- and without those devices
   the K3 driver-probe sequence in mainline Linux fails early. A
   "-virt" derivative lets us prove the SoC scaffolding without
   having to model the entire chip on day one.

   That said -- is the "<soc>-virt" pattern acceptable for first
   upstream landing, or do you want the first machine to model a
   real reference board, so that mainline Linux device trees can be
   used directly? The full prototype's "-virt" choice has been
   driven by the M4F debug use case (which doesn't care about the
   board details); a real-board variant would be added later in
   either case.


Proposed roadmap (subject to feedback)
======================================

In case the community is interested and the design above is roughly
acceptable, follow-up series would bring (in this order):

  * Add VMState / reset / trace events to the SoC model
    (intentionally deferred for v0 to keep the diff small)
  * tests/functional/arm/test_am64_virt.py boot-smoketest
  * docs/system/arm/am64-virt.rst
  * TI K3 RAT model           (small, self-contained)
  * TI K3 Mailbox model       (also reusable on AM62x)
  * TI K3 Secure Proxy model
  * TI K3 DMSC / TISCI service model
  * AM64x M4F bring-up wired into the SoC
  * Dynamic device tree generation for am64-virt
  * (later) AM64x R5F cluster
  * (later) Move GIC-400 -> GIC-500 (GICv3)
  * (later) AM64x reference-board variant (SK-AM64 or AM64x-EVM)
    using mainline Linux device trees


Testing
=======

Build: `--target-list=aarch64-softmmu`, no warnings. scripts/checkpatch.pl
is clean on patch 1; patch 2 emits one MAINTAINERS hint that is a
false positive (the MAINTAINERS coverage for hw/arm/am64-virt.c is
added by patch 1 already; checkpatch only looks at the current
patch's diff).

Linux boot: this v0 boots an arm64 Linux 6.6 kernel through full
SMP bring-up and complete subsystem init to the standard
"VFS: Unable to mount root fs" panic, using the minimal device
tree appended at the end of this cover letter (~60 lines, describes
only what the v0 actually models: A53 SMP, GIC-400, ttyS0 backed
by MAIN_UART0, DDR @ 0x80000000).

Representative boot log (sysclk = QEMU virtual clock, kernel built
with arm64 defconfig-style):

    [    0.000000] Booting Linux on physical CPU 0x0000000000
    [    0.000000] Machine model: QEMU AM64 virt (v0 minimal)
    [    0.000000] earlycon: ns16550a0 at MMIO32 0x0000000002800000
    [    0.082815] CPU1: Booted secondary processor 0x0000000001
    [    0.090939] SMP: Total of 2 processors activated.
    [    0.267805] VFS: Disk quotas dquot_6.6.0
    ...
    [    1.179709] VFS: Cannot open root device "" -- expected, no rootfs supplied
    [    1.181988] Kernel panic - not syncing: VFS: Unable to mount root fs

Reproduce with:

    qemu-system-aarch64 -M am64-virt -m 1G -smp 2 -nographic \
        -kernel Image -dtb am64-virt-minimal.dtb


Repository
==========

  RFC v0 branch:
    https://github.com/wafgo/qemu/tree/upstream/am64-rfc-v0
  Full AMP prototype (what's described above):
    https://github.com/wafgo/qemu/tree/wafgo/am64-amp-prototype


Appendix: minimal device tree used for the boot test
====================================================

This DTS describes only what the v0 SoC model exposes. Compile with
`dtc -I dts -O dtb -o am64-virt-minimal.dtb am64-virt-minimal.dts`.

    /dts-v1/;
    / {
        #address-cells = <2>;
        #size-cells = <2>;
        interrupt-parent = <&gic>;
        compatible = "qemu,am64-virt";
        model = "QEMU AM64 virt (v0 minimal)";

        chosen {
            bootargs = "earlycon=ns16550a,mmio32,0x02800000,115200n8 console=ttyS0,115200 mem=1024M";
            stdout-path = "serial0:115200n8";
        };

        aliases { serial0 = &uart0; };

        psci {
            compatible = "arm,psci-1.0", "arm,psci-0.2", "arm,psci";
            method = "smc";
            cpu_suspend = <0xc4000001>;
            cpu_off    = <0x84000002>;
            cpu_on     = <0xc4000003>;
            migrate    = <0xc4000005>;
        };

        cpus {
            #address-cells = <2>;
            #size-cells = <0>;
            cpu0: cpu@0 {
                device_type = "cpu";
                compatible = "arm,cortex-a53";
                reg = <0x0 0x0>;
                enable-method = "psci";
            };
            cpu1: cpu@1 {
                device_type = "cpu";
                compatible = "arm,cortex-a53";
                reg = <0x0 0x1>;
                enable-method = "psci";
            };
        };

        timer {
            compatible = "arm,armv8-timer";
            interrupts = <1 13 0xf08>, <1 14 0xf08>,
                         <1 11 0xf08>, <1 10 0xf08>;
        };

        memory@80000000 {
            device_type = "memory";
            reg = <0x0 0x80000000 0x0 0x40000000>;
        };

        gic: interrupt-controller@1800000 {
            compatible = "arm,gic-400";
            #interrupt-cells = <3>;
            interrupt-controller;
            reg = <0x0 0x01800000 0x0 0x10000>,
                  <0x0 0x01810000 0x0 0x10000>;
        };

        uart0: serial@2800000 {
            compatible = "ns16550a";
            reg = <0x0 0x02800000 0x0 0x100>;
            reg-shift = <2>;
            reg-io-width = <4>;
            clock-frequency = <48000000>;
            interrupts = <0 146 4>;
        };
    };


Wadim Mueller (2):
  hw/arm: Add minimal TI K3 AM64x SoC model
  hw/arm: Add AM64-virt machine

 MAINTAINERS               |   8 ++
 hw/arm/Kconfig            |  12 +++
 hw/arm/am64-virt.c        |  80 ++++++++++++++
 hw/arm/meson.build        |   2 +
 hw/arm/ti-am64x.c         | 212 ++++++++++++++++++++++++++++++++++++++
 include/hw/arm/ti-am64x.h |  36 +++++++
 6 files changed, 350 insertions(+)
 create mode 100644 hw/arm/am64-virt.c
 create mode 100644 hw/arm/ti-am64x.c
 create mode 100644 include/hw/arm/ti-am64x.h

-- 
2.52.0


