Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EF5E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 22:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPqjU-0001wc-F3; Mon, 23 Dec 2024 17:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tPqjS-0001vH-BY
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 17:16:58 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tPqjO-0006tZ-Mw
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 17:16:58 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso45868725e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 14:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734992212; x=1735597012;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G4D1NjpzQ+svDCwSIuNLD+JPCe3ek8UqorDvZrim67o=;
 b=VEBcUz645azPBjD3iYD3sw5t2SpH0BxRe1yOpzjD/RYEi/SDuRMXu6Fhjcy8B86dZB
 4IgTym8dN0s05mCQFwkJtH9uMzeYq9l0EycNUySXHT4dR5JJhVHIL+22aUoKicJMRe75
 RxGsBSVoK1zO3D28AsUuET4TiRltEG98pet87SqDw9fg73UdM+wLeVquWKN7uOiBJMFn
 jEE+FpoRrwlooaV13oxxOLnGG5EnnKCOHd7Whqj6t+z6s9ycY4QrpyfNeTbRpTuyXIqQ
 P+6bbhgkarB6w4qCuTG4kQVnmGNseWBr7ebTIjMtIAS3T1ZG+v1QOGaT/R4AM/jBIEtg
 Xtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734992212; x=1735597012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G4D1NjpzQ+svDCwSIuNLD+JPCe3ek8UqorDvZrim67o=;
 b=Z9SY6SWD00AyB8fG3dkEaXFAbbAioPUJDz01Yv5QVP2R85IMiBC3KU7rnsjfwUFGMK
 64KvrQLjlouhbrXfkqp1m+mn1SvK5hO1ARSVwJZxpDSCb5KSh6F3womtcccfiCuwXgqq
 8tqe+vWe3pgneuSg90zpZ156HlvMXAU9mDt5M16HLwueXX7yYoRYMinwdFZn5S4DiUTL
 5NGa47FDc3flOd5BLwT/iejE3YWC7/ejqDQ4NhYSJ1a0B80AZ6Zy6rR4m+KmhW3MrQyZ
 iwwI+e/ybIcC2+GxvZl/0kz1TQ0WvZvfVAlcsUeU4DaUaLSEY0ICdcBx7rPgYAHSO4QW
 KYsQ==
X-Gm-Message-State: AOJu0YyZ+qHQaUpT7Jn3TjmwNqKnAvLIfXIJOvkBLE7JE5iCs1vMwUoZ
 UkkxRG63r7YTVRBjR+mcZymCjUU4H1B6MDETCxXNF1UId90Ne9I3eXOI5CB+tijCycFLSSUhpQS
 xrA==
X-Gm-Gg: ASbGncs2Nr+MZ54bPzO5sgmaSn4hf4sBmcjgUQ9dzGmRb3UYNKHafjh3wbmXIGZubr3
 HtJcxnw/lWZRlneJQoHhjw8aOeSPxR6aDe1nBb+kopPDXHiD4+zekKeAlEyMExo+Tor50NFg/Nv
 5UYCKtASVojjppZOIExXyOXag5Is8V7J6OOlAH0RiFD5Q4eUG8Qcneo5wTexhQnFB1/hpgT8u8l
 c22Ka4y2bptsOUZCDQxcBSMj9BU9c5fEhx/aak4MnkTYnL3krqGVBsGpqkLcC+xAyI3T/KF7Abs
 TYsUukFQfLOmtTfEkqcP99glqX25SJAZ
X-Google-Smtp-Source: AGHT+IH4hI7peZeUiyoxM+5HSdrQwzwXc5O1f7D6SSyetEhsZyTfbP53NnVvdHsw0ERC9Afetm2/mA==
X-Received: by 2002:a05:600c:45cf:b0:434:a781:f5e2 with SMTP id
 5b1f17b1804b1-43668642289mr117705175e9.8.1734992212236; 
 Mon, 23 Dec 2024 14:16:52 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611fc161sm147561075e9.10.2024.12.23.14.16.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Dec 2024 14:16:51 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu
Subject: [PATCH v16 00/14] macOS PV Graphics and new vmapple machine type
Date: Mon, 23 Dec 2024 23:16:31 +0100
Message-Id: <20241223221645.29911-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::336;
 envelope-from=phil@philjordan.eu; helo=mail-wm1-x336.google.com
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
 * Due to a quirk (bug?) in the macOS XHCI driver when MSI-X is not
   available, correct functioning of the USB controller (and thus
   keyboard/tablet) requires a small workaround in the XHCI controller
   device. This is part of another patch series:
   https://patchew.org/QEMU/20241208191646.64857-1-phil@philjordan.eu/
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

Some of my part of this work has been sponsored by Sauce Labs Inc.

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

v5 -> v6:

 * 01/15 (main/Cocoa/runloop): Combined functions, fixed whitespace
 * 02/15 (apple-gfx): Further refinement of PVG threading: reduced some callback
   tasks from BHs to merely acquiring RCU read lock; replaced some libdispatch
   tasks with BHs; last remaining synchronous BH now uses emphemeral
   QemuSemaphore.
 * 02/15 (apple-gfx): Readability improvements and other smaller tweaks
   (see patch change notes for details)
 * 04/15 (display modes): Replaced use of alloca() with NSMutableArray.

v6 -> v7:

 * 02/15 (apple-gfx): Use g_ptr_array_find() helper function, coding style tweak
 * 03/15 (apple-gfx-pci): Removed an unused function parameter
 * 04/15 (apple-gfx display mode property): Simplified error handling in
   property parsing.
 * 10/15 (vmapple/aes): Coding style tweaks.
 * 12/15 (vmapple/cfg): Changed error messages for overrun of properties with
   fixed-length strings to be more useful to users than developers.
 * 15/15 (vmapple machine type): Tiny error handling fix, un-inlined function

v7 -> v8:

 * 02/15 (apple-gfx): Naming and type use improvements, fixes for a bug and a
   leak.
 * 04/15 (apple-gfx display mode property): Type use improvement
 * 10/15 (vmapple/aes): Guest error logging tweaks.
 * 11/15 (vmapple/bdif): Replaced uses of cpu_physical_memory_read with
   dma_memory_read, and a g_free call with g_autofree.
 * 12/15 (vmapple/cfg): Macro hygiene fix: consistently enclosing arguments in
   parens.
 * 15/15 (vmapple machine type): Use less verbose pattern for defining uuid
   property.

v8 -> v9:

 * 01/16 (ui & main loop): Set qemu_main to NULL for GTK UI as well.
 * 02/16 (apple-gfx): Pass device pointer to graphic_console_init(), various
	 non-functional changes.
 * 03/16 (apple-gfx-pci): Fixup of changed common call, whitespace and comment
   formatting tweaks.
 * 04/16 (apple-gfx display modes): Re-ordered type definitions so we can drop
   a 'struct' keyword.
 * 10/16 (vmapple/aes): Replaced a use of cpu_physical_memory_write with
   dma_memory_write, minor style tweak.
 * 11/16 (vmapple/bdif): Replaced uses of cpu_physical_memory_write with
   dma_memory_write.
 * 13/16 (vmapple/virtio-blk): Correctly specify class_size for
   VMAppleVirtIOBlkClass.
 * 15/16 (vmapple machine type): Documentation improvements, fixed variable
   name and struct field used during pvpanic device creation.
 * 16/16 (NEW/RFC vmapple/virtio-blk): Proposed change to replace type hierarchy
   with a variant property. This seems cleaner and less confusing than the
   original approach to me, but I'm not sure if it warrants creation of a new
   QAPI enum and property type definition.

v9 -> v10:

 * 01/15 (ui & main loop): Added comments to qemu_main declaration and GTK.
 * 02/15 (apple-gfx): Reworked the way frame rendering code is threaded to use
   BHs for sections requiring BQL.
 * 02/15 (apple-gfx): Fixed ./configure error on non-macOS platforms.
 * 10/15 (vmapple/aes): Code style and comment improvements.
 * 12/15 (vmapple/cfg): Slightly tidier error reporting for overlong property
   values.
 * 13/15 (vmapple/virtio-blk): Folded v9 patch 16/16 into this one, changing
   the device type design to provide a single device type with a variant
	 property instead of 2 different subtypes for aux and root volumes.
 * 15/15 (vmapple machine type): Documentation fixup for changed virtio-blk
   device type; small improvements to shell commands in documentation;
   improved propagation of errors during cfg device instantiation.

v10 -> v11:

 * 01/15 (ui & main loop): Simplified main.c, better comments & commit message
 * 02/15 (apple-gfx): Give each PV display instance a unique serial number.
 * 02 & 03/15 (apple-gfx, -pci): Formatting/style tweaks
 * 15/15 (vmapple machine type): Improvements to shell code in docs

v11 -> v12:

 * 01/15 (ui & main loop): More precise wording of code comments.
 * 02/15 (apple-gfx): Fixed memory management regressions introduced in v10;
   improved error handling; various more conmetic code adjustments
 * 09/15 (GPEX): Fixed uses of deleted GPEX_NUM_IRQS constant that have been
   added to QEMU since this patch was originally written.

v12 -> v13:

 * 15/15 (vmapple machine type): Bumped the machine type version from 9.2
   to 10.0.
 * All patches in the series now have been positively reviewed and received
   corresponding reviewed-by tags.

v13 -> v14:

 * 6/15 (hw/vmapple directory): Changed myself from reviewer
   to maintainer, as that seemed appropriate at this point.
 * 15/15 (vmapple machine type): Gate creation of XHCI and
   USB HID devices behind if (defaults_enabled()).

v14 -> v15

 * Constified property tables to match Richard Henderson's recent project-
   wide convention change. (patches 4/15, 7/15, 11/15, 12/15, & 13/15)

v15 -> v16

 * 14 patches now, as patch 8 has already been pulled. (Thanks Philippe!)
 * Fixed a bunch of conflicts with upstream code motion:
    - DEFINE_PROP_END_OF_LIST removal (4/14 - apple-gfx mode list, 7/14 -
      pvpanic-mmio, 10/14 - bdif, 11/14 - cfg device, and
      12/14 - vmapple-virtio-blk)
    - sysemu->system move/rename: (1/14 - ui/qemu-main, 2/14 - apple-gfx,
      9/14 - aes, 10/14 - bdif, 14/14 - vmapple machine type)
 * 14/14 (vmapple machine type):
    - Moved compatibility setting for removing legacy mode from virtio-pci
      to proper global property table rather than (ab)using sugar property.
    - Removed a few superfluous #includes during sysemu rename cleanup.
    - Removed machine type versioning as it's not necessary (yet?)
    - Made memory map array const

Alexander Graf (8):
  hw: Add vmapple subdir
  hw/misc/pvpanic: Add MMIO interface
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

 MAINTAINERS                         |  15 +
 contrib/vmapple/uuid.sh             |   9 +
 docs/system/arm/vmapple.rst         |  63 ++
 docs/system/target-arm.rst          |   1 +
 hw/Kconfig                          |   1 +
 hw/arm/sbsa-ref.c                   |   2 +-
 hw/arm/virt.c                       |   2 +-
 hw/block/virtio-blk.c               |  58 +-
 hw/core/qdev-properties-system.c    |   8 +
 hw/display/Kconfig                  |  13 +
 hw/display/apple-gfx-mmio.m         | 288 +++++++++
 hw/display/apple-gfx-pci.m          | 156 +++++
 hw/display/apple-gfx.h              |  77 +++
 hw/display/apple-gfx.m              | 880 ++++++++++++++++++++++++++++
 hw/display/meson.build              |   7 +
 hw/display/trace-events             |  30 +
 hw/i386/microvm.c                   |   2 +-
 hw/loongarch/virt.c                 |  12 +-
 hw/meson.build                      |   1 +
 hw/mips/loongson3_virt.c            |   2 +-
 hw/misc/Kconfig                     |   4 +
 hw/misc/meson.build                 |   1 +
 hw/misc/pvpanic-mmio.c              |  60 ++
 hw/openrisc/virt.c                  |  12 +-
 hw/pci-host/gpex.c                  |  43 +-
 hw/riscv/virt.c                     |  12 +-
 hw/vmapple/Kconfig                  |  32 +
 hw/vmapple/aes.c                    | 581 ++++++++++++++++++
 hw/vmapple/bdif.c                   | 274 +++++++++
 hw/vmapple/cfg.c                    | 195 ++++++
 hw/vmapple/meson.build              |   5 +
 hw/vmapple/trace-events             |  21 +
 hw/vmapple/trace.h                  |   1 +
 hw/vmapple/virtio-blk.c             | 204 +++++++
 hw/vmapple/vmapple.c                | 612 +++++++++++++++++++
 hw/xen/xen-pvh-common.c             |   2 +-
 hw/xtensa/virt.c                    |   2 +-
 include/hw/misc/pvpanic.h           |   1 +
 include/hw/pci-host/gpex.h          |   7 +-
 include/hw/pci/pci_ids.h            |   1 +
 include/hw/qdev-properties-system.h |   5 +
 include/hw/virtio/virtio-blk.h      |  11 +-
 include/hw/vmapple/vmapple.h        |  23 +
 include/qemu-main.h                 |  14 +-
 include/qemu/cutils.h               |  15 +
 meson.build                         |   5 +
 qapi/virtio.json                    |  14 +
 system/main.c                       |  37 +-
 ui/cocoa.m                          |  54 +-
 ui/gtk.c                            |   4 +
 ui/sdl2.c                           |   4 +
 util/hexdump.c                      |  18 +
 52 files changed, 3791 insertions(+), 110 deletions(-)
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
2.39.5 (Apple Git-154)


