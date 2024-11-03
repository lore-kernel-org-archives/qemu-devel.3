Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600F9D11100
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 15:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7c6m-0000Iq-Eo; Sun, 03 Nov 2024 10:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t7c6A-0008BW-7E
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 10:01:03 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t7c61-0006U1-M9
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 10:01:00 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c903f5bd0eso6076162a12.3
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2024 07:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730646049; x=1731250849;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fFdNxhrULhwDyGhBdIcyvmQl4Sl2d/4QopV1f61pQXY=;
 b=MUseiFj+Hlx+ti6X0sRr62mIKGMQx0aiRhhnHnoKp40ni693zzvdHSIB2pDVJBPnKG
 SrWl1me7pdShjz6diOsa3fZke0LVB5MfHSAU91TNSsNeBBD9iAYVQrcJk1sPgDor5NX+
 IHaIaEjtHBj/r2iPh7jSm/JbyZc7hgNQMACBy0/MrO0lvxU9v+P8GyLvOj0s+Ph7IQG5
 pziQ/cOxcXbmYnwNKGQNwMjovWZExgkFRuMB656ZAIgWogoY2YRMSD8+Xa0dnU/Eh7q9
 qmAxtb5Be4UEhXzy4P5OLK/C06qzlIXDcLyiOGwGd7zyoEgTMevcJFnXNZct27Tx+jL2
 8WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730646049; x=1731250849;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fFdNxhrULhwDyGhBdIcyvmQl4Sl2d/4QopV1f61pQXY=;
 b=XmhYHSWMBkpwmi6rSS1x/N7zGNur22h+a3h0xluIVYvM+V0R1dUW1wMw8L5n3wcK/N
 kdcHleNnyCgq3uOeQcu0WO4QG0Ymgs5jm0iouOswcDTO1LfgmKtDjIU/vFLIiQZgFGlE
 wSFQZQHnVlRo9InNF87lhuHVV2OVnlFZIAG+e8v3GHVeFNOtSORGL/Jm+Ketnrnii+No
 gxHWB7rvc2D5gxk5dTbK1elaOzq9D1HZ+e/Uakn9TNpg6sXJoGn4Cdx+lX+wEHZuqxtp
 0HwyXTevVCCfbLDhk/iAWHYTKBnWNA8M3MtqrqY2I4yX1+YmhBedba42eaXzIDffZcXp
 DkEw==
X-Gm-Message-State: AOJu0YyQvOkQosFOQx6+vSTq5C+FxnQhdYT++E+mODy8c5phDuZVFPqd
 okoYogbZR/Vq/qmCNKKkRqSk4bPZ+RUjGKK10T5/6TlUiJiX7spOaxQTuqGSt+qmIiH0DQ/MDE3
 fEg==
X-Google-Smtp-Source: AGHT+IERaDSLIDm1o7PsqC30QgIcd6krGelIb1K511iS5kAY2qEqZOYQ1LNkaxmDy7PLlH0rI3fisA==
X-Received: by 2002:a17:907:97c9:b0:a9a:eca:f7c4 with SMTP id
 a640c23a62f3a-a9e50b9e2a8mr1199643566b.54.1730646048482; 
 Sun, 03 Nov 2024 07:00:48 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm431536666b.159.2024.11.03.07.00.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 03 Nov 2024 07:00:47 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v6 00/15] macOS PV Graphics and new vmapple machine type
Date: Sun,  3 Nov 2024 16:00:22 +0100
Message-Id: <20241103150037.48194-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::52c;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

This patch set introduces a new ARM and macOS HVF specific machine type
called "vmapple", as well as a family of display devices based on the
ParavirtualizedGraphics.framework in macOS. One of the display adapter
variants, apple-gfx-mmio, is required for the new machine type, while
apple-gfx-pci can be used to enable 3D graphics acceleration with x86-64
macOS guest OSes.

Previous versions of this patch set were submitted semi-separately:
the original vmapple patch set by Alexander Graf included a monolithic
implementation of apple-gfx-mmio. I subsequently reviewed and reworked
the latter to support the PCI variant of the device as well and submitted
the result in isolation. As requested in subsequent review, I have now
recombined this with the original vmapple patch set, which I have updated
and improved in a few ways as well.

The vmapple machine type approximates the configuration in macOS's own
Virtualization.framework when running arm64 macOS guests. In addition to
generic components such as a GICv3 and an XHCI USB controller, it
includes nonstandard extensions to the virtio block device, a special
"hardware" aes engine, a configuration device, a pvpanic variant, a
"backdoor" interface, and of course the apple-gfx paravirtualised display
adapter.

There are currently a few limitations to this which aren't intrinsic,
just imperfect emulation of the VZF, but it's good enough to be just
about usable for some purposes:

 * macOS 12 guests only. Versions 13+ currently fail during early boot.
 * macOS 11+ arm64 hosts only, with hvf accel. (Perhaps some differences
   between Apple M series CPUs and TCG's aarch64 implementation? macOS
   hosts only because ParavirtualizedGraphics.framework is a black box
   implementing most of the logic behind the apple-gfx device.)
 * PCI devices use legacy IRQs, not MSI/MSI-X. As far as I can tell,
   we'd need to include the GICv3 ITS, but it's unclear to me what
   exactly needs wiring up.
 * Due to lack of MSI(-X), event delivery from USB devices to the guest
   macOS isn't working correctly. My current conclusion is that the
   OS's XHCI driver simply was never designed to work with legacy IRQs.
   The upshot is that keyboard and mouse/tablet input is very laggy.
   The solution would be to implement MSI(-X) support or figure out how
   to make hcd-xhci-sysbus work with the macOS guest, if at all possible.
   (EHCI and UHCI/OHCI controllers are not an option as the VMAPPLE
   guest kernel does not include drivers for these.)
 * The guest OS must first be provisioned using Virtualization.framework;
   the disk images can subsequently be used in Qemu. (See docs.)

The apple-gfx device can be used independently from the vmapple machine
type, at least in the PCI variant. It mainly targets x86-64 macOS guests
from version 11 on, but also includes a UEFI bootrom for basic
framebuffer mode. macOS 11 is also required on the host side, as well
as a GPU that supports the Metal API. On the guest side, this provides
3D acceleration/GPGPU support with a baseline Metal feature set,
irrespective of the host GPU's feature set. A few limitations in the
current integration:

 * Although it works fine with TCG, it does not work correctly
   cross-architecture: x86-64 guests on arm64 hosts appear to make
   some boot progress, but rendering is corrupted. I suspect
   incompatible texture memory layouts; I have no idea if this is
   fixable.
 * ParavirtualizedGraphics.framework and the guest driver support
   multi-headed configurations. The current Qemu integration always
   connects precisely 1 display.
 * State serialisation and deserialisation is currently not
   implemented, though supported in principle by the framework.
   Both apple-gfx variants thus set up a migration blocker.
 * Rendering efficiency could be better. The GPU-rendered guest
   framebuffer is copied to system memory and uses Qemu's usual
   CPU-based drawing. For maximum efficiency, the Metal texture
   containing the guest framebuffer could be drawn directly to
   a Metal view in the host window, staying on the GPU. (Similar
   to the OpenGL/virgl render path on other platforms.)

My part of this work has been sponsored by Sauce Labs Inc.

---

v2 -> v3:

 * Merged the apple-gfx and vmapple patchsets.
 * Squashed a bunch of later apple-gfx patches into the main one.
   (dGPU support, queried MMIO area size, host GPU picking logic.)
 * Rebased on latest upstream, fixing any breakages due to internal
   Qemu API changes.
 * apple-gfx: Switched to re-entrant MMIO. This is supported by the
   underlying framework and simplifies the MMIO forwarding code which
   was previously different on x86-64 vs aarch64.
 * vmapple: Fixes for minor bugs and comments from the last round of
   review.
 * vmapple aes, conf, apple-gfx: Switched reset methods to implement
   the ResettableClass base's interface.
 * vmapple: switched from virtio-hid to an XHCI USB controller and
   USB mouse and tablet devices. macOS does not provide drivers for
   virtio HID devices, at least not in version 12's vmapple kernel.
   So input now sort of works (interrupt issues) rather than not
   at all. Use network-based remote access to the guest OS as a
   work-around.

v3 -> v4:

 * Complete rework of the mechanism for handling runloop/libdispatch
   events on the main thread. PV graphics now work with the SDL UI.
 * Renamed 'apple-gfx-vmapple' device to 'apple-gfx-mmio'
 * hw/display/apple-gfx: threading model overhaul to be more consistent,
   safer, and more QEMU-idiomatic.
 * display-modes property on the apple-gfx devices now uses the
   native array property mechanism and works on both device variants.
 * hw/vmapple/aes: Improvements to logging and error handling.
 * hw/vmapple/cfg: Bug fixes around device property default values.
 * hw/vmapple/{aes,cfg,virtio-blk/vmapple}: Most header code moved into
   .c files, only a single vmapple.h now contains the #defines for the
   vmapple machine model-specific device type names.
 * hw/block/virtio-blk: New patch for replacing virtio_blk_free_request
   with g_free. (Optional)
 * Various smaller changes following comments in v3 code review in
   apple-gfx, aes, cfg, bdif, virtio-blk-vmapple, and the vmapple
   machine type itself. See patch-specific v4 change notes for details.

v4 -> v5:

 * Simplified the main thread runloop mechanism. Back to setting
	 qemu_main directly, but narrowing the scope of what it needs to do,
	 and it can now be NULL. (Meaning run the QEMU main event loop on
	 the main thread as is traditional.)
 * hw/display/apple-gfx: Further improvements to the BH based job code bridging
   the libdispatch & QEMU thread synchronisation impedance mismatch.
 * hw/display/apple-gfx: Thread safety and object lifetime improvements.
 * hw/display/apple-gfx-*: Better buffer and error handling in display mode
   property setters and getters.
 * hw/vmapple/aes: More consistent and safer logging/tracing
 * hw/vmapple/cfg: Better error reporting on overlong property strings.
 * hw/vmapple/virtio-blk: Fixed theoretically-unaligned write to config buffer.
 * vmapple machine type: Moved ecam region into machine state, improved device
   property setting error handling, improved ECID/UUID extraction script and
   docs.
 * Various smaller fixes in apple-gfx/-mmio, apple-gfx-pci, vmapple/aes,
   vmapple/cfg, vmapple/virtio-blk, and vmapple machine type.
 * Added SPDX license identifiers where they were missing.

v5 -> v6

 * 01/15 (main/Cocoa/runloop): Combined functions, fixed whitespace
 * 02/15 (apple-gfx): Further refinement of PVG threading: reduced some callback
   tasks from BHs to merely acquiring RCU read lock; replaced some libdispatch
   tasks with BHs; last remaining synchronous BH now uses emphemeral
   QemuSemaphore.
 * 02/15 (apple-gfx): Readability improvements and other smaller tweaks
   (see patch change notes for details)
 * 04/15 (display modes): Replaced use of alloca() with NSMutableArray.

Alexander Graf (9):
  hw: Add vmapple subdir
  hw/misc/pvpanic: Add MMIO interface
  hvf: arm: Ignore writes to CNTP_CTL_EL0
  gpex: Allow more than 4 legacy IRQs
  hw/vmapple/aes: Introduce aes engine
  hw/vmapple/bdif: Introduce vmapple backdoor interface
  hw/vmapple/cfg: Introduce vmapple cfg region
  hw/vmapple/virtio-blk: Add support for apple virtio-blk
  hw/vmapple/vmapple: Add vmapple machine type

Phil Dennis-Jordan (6):
  ui & main loop: Redesign of system-specific main thread event handling
  hw/display/apple-gfx: Introduce ParavirtualizedGraphics.Framework
    support
  hw/display/apple-gfx: Adds PCI implementation
  hw/display/apple-gfx: Adds configurable mode list
  MAINTAINERS: Add myself as maintainer for apple-gfx, reviewer for HVF
  hw/block/virtio-blk: Replaces request free function with g_free

 MAINTAINERS                    |  15 +
 contrib/vmapple/uuid.sh        |   9 +
 docs/system/arm/vmapple.rst    |  60 +++
 docs/system/target-arm.rst     |   1 +
 hw/Kconfig                     |   1 +
 hw/arm/sbsa-ref.c              |   2 +-
 hw/arm/virt.c                  |   2 +-
 hw/block/virtio-blk.c          |  58 ++-
 hw/display/Kconfig             |  13 +
 hw/display/apple-gfx-mmio.m    | 289 +++++++++++
 hw/display/apple-gfx-pci.m     | 156 ++++++
 hw/display/apple-gfx.h         |  77 +++
 hw/display/apple-gfx.m         | 872 +++++++++++++++++++++++++++++++++
 hw/display/meson.build         |   5 +
 hw/display/trace-events        |  30 ++
 hw/i386/microvm.c              |   2 +-
 hw/loongarch/virt.c            |   2 +-
 hw/meson.build                 |   1 +
 hw/mips/loongson3_virt.c       |   2 +-
 hw/misc/Kconfig                |   4 +
 hw/misc/meson.build            |   1 +
 hw/misc/pvpanic-mmio.c         |  61 +++
 hw/openrisc/virt.c             |  12 +-
 hw/pci-host/gpex.c             |  43 +-
 hw/riscv/virt.c                |  12 +-
 hw/vmapple/Kconfig             |  32 ++
 hw/vmapple/aes.c               | 578 ++++++++++++++++++++++
 hw/vmapple/bdif.c              | 261 ++++++++++
 hw/vmapple/cfg.c               | 203 ++++++++
 hw/vmapple/meson.build         |   5 +
 hw/vmapple/trace-events        |  21 +
 hw/vmapple/trace.h             |   1 +
 hw/vmapple/virtio-blk.c        | 226 +++++++++
 hw/vmapple/vmapple.c           | 659 +++++++++++++++++++++++++
 hw/xtensa/virt.c               |   2 +-
 include/hw/misc/pvpanic.h      |   1 +
 include/hw/pci-host/gpex.h     |   7 +-
 include/hw/pci/pci_ids.h       |   1 +
 include/hw/virtio/virtio-blk.h |  11 +-
 include/hw/vmapple/vmapple.h   |  25 +
 include/qemu-main.h            |   3 +-
 include/qemu/cutils.h          |  15 +
 include/qemu/typedefs.h        |   1 +
 meson.build                    |   5 +
 system/main.c                  |  50 +-
 target/arm/hvf/hvf.c           |   9 +
 ui/cocoa.m                     |  54 +-
 ui/sdl2.c                      |   4 +
 util/hexdump.c                 |  18 +
 49 files changed, 3816 insertions(+), 106 deletions(-)
 create mode 100755 contrib/vmapple/uuid.sh
 create mode 100644 docs/system/arm/vmapple.rst
 create mode 100644 hw/display/apple-gfx-mmio.m
 create mode 100644 hw/display/apple-gfx-pci.m
 create mode 100644 hw/display/apple-gfx.h
 create mode 100644 hw/display/apple-gfx.m
 create mode 100644 hw/misc/pvpanic-mmio.c
 create mode 100644 hw/vmapple/Kconfig
 create mode 100644 hw/vmapple/aes.c
 create mode 100644 hw/vmapple/bdif.c
 create mode 100644 hw/vmapple/cfg.c
 create mode 100644 hw/vmapple/meson.build
 create mode 100644 hw/vmapple/trace-events
 create mode 100644 hw/vmapple/trace.h
 create mode 100644 hw/vmapple/virtio-blk.c
 create mode 100644 hw/vmapple/vmapple.c
 create mode 100644 include/hw/vmapple/vmapple.h

-- 
2.39.3 (Apple Git-145)


