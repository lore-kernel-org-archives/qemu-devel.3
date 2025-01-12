Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4655E7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 21:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX55R-0004Qe-Oa; Sun, 12 Jan 2025 16:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tX55P-0004QO-Ph
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:01:31 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tX55M-0006MQ-C7
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:01:31 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso660323266b.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1736715686; x=1737320486;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bs/tHE1gHB+p/e/jwVTGCDu/rFNj5bepu/l3RM2VV5c=;
 b=lw8JaO5b1Yil0qORASAUj7E0sWUU6WjhRRPLUR19vsMGDXeWiSt1d85fBpQlYVUHYz
 S3sRjikFq3mds9Ou0BD3WT35vYR1Yi4E3yGLetB/WYn8SRcWNOhpE9VT4c5lPUJc8MB/
 WX5UB/Zn2X4SmIcljr7L4N9pHTey0zEc7o/BGzpYtOEePtUuj/XOzqmswyMqfNiZMYbk
 iSQGiltHJgHT4amuKGHyjoJgKy2BnZCY7Gyxcsair1SlUnGCQ+S9zvOYP9y+CNGD0yLD
 BwDH88AXqKYiweygNcJ3XwvnjnIChY4wYb5TECnYOck2t8D55jigp4RqsVpasV/g2PEB
 77Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736715686; x=1737320486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bs/tHE1gHB+p/e/jwVTGCDu/rFNj5bepu/l3RM2VV5c=;
 b=aTDxz/rj6QX6IY6Afy+I81Q0AzCR8ypfNBUORshSZVasridK+VQENhW40XSGLWp5ip
 yxb4Hb9x05oSXOaUOuvhg+uHIG7Avw7ElQNDktosbceaOXlycUMpKBZdmGDQ1wZQaoGt
 VmOEWNpGjsDWJe8bJdXpMtLK3yJtMaXcMjqmvKhtuPbNueH6O5UBOsas56d2LPFD6xwm
 lLlepiHJ+NB1dLWid5/DDdZLaEJ9TQtHQqQXsfBax0ebP7J5XCiyf7L3Uf6GKe+IBAeR
 zzWPBb/rZsv4lMlaN9K0SS+D9dFSYRWxFk8LGvI+ZKR45nGy50dP1mzQVNTZh+TyGQle
 TORA==
X-Gm-Message-State: AOJu0YzUfCEXOiK4cuROvOVPrqgMOdlQwG8u65ZBNrtDflnXaEDpNWsQ
 uiGhbOSuzj2roOGNcft9hTjEHZ24FiEffZYpfnwlmIvHyJ1lOXAzZKksd8u2kRSij7IT6UHvPD/
 QpA==
X-Gm-Gg: ASbGncub8vEVLRBCjWx4f9spSmwQgAnj6OSpBvcDpd4NyhfSKoFJD3wa6wnHcWUpMfZ
 G+aAOaPtfvXpdR2Q/RPLr2HzmFVf7Di6woeKhXEyFBdCXdl2dhyyeQeCMgk1fFrebnkp1owdHmS
 bHTS9LqvzqLbK2+9mGm0UnugVmG6xNhZnoXd0yI4SY+Xd0eB7ek1czNKt6fdYTXV9dP1+4lSrHc
 cvHdCxtNsDdZt5kctS/Bht6zl8/oLO9JWCOhAjx5VM1XZaaVBxHpBHuh75K8Ai9d73ZN2e+Nvqf
 IAVslZJ4W5CP1awieMxcbtScEuWhRqE8
X-Google-Smtp-Source: AGHT+IEvxK0By1em9XojBc3FVP5lzAMi2ZSxxaUSNTzj7pG5pXGT6ncAZYQBxEAqvgpPvNrYk3ZngA==
X-Received: by 2002:a17:907:72d0:b0:aa6:b473:ea4c with SMTP id
 a640c23a62f3a-ab2ab6a75aamr1770673266b.10.1736715685698; 
 Sun, 12 Jan 2025 13:01:25 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905e283sm418276666b.31.2025.01.12.13.01.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:01:25 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@linaro.org,
 eblake@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org
Subject: [PATCH v17 00/11] New vmapple machine type and xhci fixes
Date: Sun, 12 Jan 2025 22:00:45 +0100
Message-Id: <20250112210056.16658-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::631;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x631.google.com
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
called "vmapple". There are also some patches for fixing XHCI spec
compliance issues and adding a workaround to a quirk in the macOS guest's
XHCI driver.

The vmapple machine type approximates the configuration in macOS's own
Virtualization.framework when running arm64 macOS guests. In addition to
generic components such as a GICv3 and an XHCI USB controller, it
includes nonstandard extensions to the virtio block device, a special
"hardware" aes engine, a configuration device, a pvpanic variant, a
"backdoor" interface, and of course the apple-gfx paravirtualised display
adapter.


The macOS guest initially did not work well with QEMU's XHCI controller,
which required some investigation, bug fixing, and a work-around.

Essentially, the macOS driver attempts to use XHCI event rings 1 and 2
even when there is only a single pin-based interrupt available. The
interrupts for rings 1 and 2 are dropped, and so events are only handled
after a timeout. The driver appears to expect the device to act as if
interrupter mapping was not supported - the spec only mentions that
interrupter mapping should be disabled if only one interrupter is
enabled, not one interrupt, although there is potential ambiguity in
the spec's wording around enabling and disabling interrupters.

In any case, this investigation has led to 3 changes:

 * The spec requires that modulo arithmetic be used for selecting
   the MSI vector to notify from the interrupter/event ring index.
   (Patch 1)
 * The spec requires that all events be directed at ring 0 if
   interrupter mapping is not available; the condition for this
   mentioned in the spec is when there is only 1 interrupter
   available. (Patch 2)
 * A property is added to the PCI XHCI controller classes to disable
   interrupter mapping when using pin-based interrupts. This makes
   the macOS guest drivers work. (Patch 9) This is enabled in the
   vmapple machine type, which does not offer MSI(-X) support.

There are currently a few limitations to the vmapple machine. These
aren't intrinsic, just imperfect emulation of the VZF, but it's good
enough to be just about usable for some purposes:

 * macOS 12 guests only. Versions 13+ currently fail during early boot.
 * macOS 11+ arm64 hosts only, with hvf accel. (Perhaps some differences
   between Apple M series CPUs and TCG's aarch64 implementation? macOS
   hosts only because ParavirtualizedGraphics.framework is a black box
   implementing most of the logic behind the apple-gfx device.)
 * The guest OS must first be provisioned using Virtualization.framework;
   the disk images can subsequently be used in Qemu. (See docs.)


Previous versions of this series also included the macOS PV graphics
device ("apple-gfx"); those patches have already been merged, so
the title has been changed. Previous iteration:
https://patchew.org/QEMU/20241223221645.29911-1-phil@philjordan.eu/

Furthermore, the XHCI fixes and workaround were previously submitted
as a separate patch set, of which a few patches have also been merged.
"hw/usb/hcd-xhci: Fixes, improvements and macOS workaround"
https://patchew.org/QEMU/20241227121336.25838-1-phil@philjordan.eu/

Finally, I've included one of Philippe Mathieu-Daudé's GICv3 patches
which arose out of the discovery that the software GICv3 dependency
was missing when building v16 and earlier versions of this series
in a HVF-only configuration.
https://patchew.org/QEMU/20241227202435.48055-1-philmd@linaro.org/

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

XHCI RFC -> v1:

 * Gated conditional interrupter mapping support behind a property, enabled
   that property in the VMApple machine type.
 * Added patch to fix the MSI vector assertion failure.
 * Moved msi and msix properties from NEC XHCI controller to generic xhci-pci
   superclass as that also seems useful.
 * Broke the workaround up into 2 patches, one for mapping disabling required
   by the standard, and one for the conditional disabling workaround.

XHCI v1 -> v2:

 * 1/6: Switch to modulo arithmetic for MSI vector number, as per spec.
 * 6/6: Set the "conditional-intr-mapping" property via compat_props.
 * Commit message tweaks

XHCI v2 -> v3:

 * 2/6: In line with recent upstream changes, the property table is now
   const and no longer carries an end-of-list marker.
 * The indentation fix (previously 5/6) has already been merged, so is no
   longer included.
 * Added patch fixing up logging of certain unhandled MMIO cases. (4/6)
 * 6/6: Moved the compat global property table into vmapple patch set -v16;
   we now just add the conditional-intr-mapping property to it in this
   patch. We also set the property on any device implementing the abstract
   TYPE_XHCI_PCI rather than only the TYPE_QEMU_XHCI device specifically.

v16 -> v17

 * Rebased on latest upstream (with minor conflict fixes)
 * apple-gfx, GPEX, and ui/cocoa patches dropped as they have been merged.
 * Unmerged patches from xhci series v3 combined into this series.
 * vmapple machine type: Explicitly depend on software GICv3.
 * vmapple machine type: Enable the new XHCI PCI conditional-intr-mapping
   property via the machine type's global compat property table.
 * Integrated Philippe's patch on renaming the GICv3's confusing config name,
   and removing its TCG dependency. (It's needed with HVF too.)
 * vmapple machine type: Dropped Tested-by tag because of above changes


Alexander Graf (7):
  hw: Add vmapple subdir
  hw/misc/pvpanic: Add MMIO interface
  hw/vmapple/aes: Introduce aes engine
  hw/vmapple/bdif: Introduce vmapple backdoor interface
  hw/vmapple/cfg: Introduce vmapple cfg region
  hw/vmapple/virtio-blk: Add support for apple virtio-blk
  hw/vmapple/vmapple: Add vmapple machine type

Phil Dennis-Jordan (3):
  hw/usb/hcd-xhci-pci: Use modulo to select MSI vector as per spec
  hw/usb/hcd-xhci-pci: Use event ring 0 if mapping unsupported
  hw/usb/hcd-xhci-pci: Adds property for disabling mapping in IRQ mode

Philippe Mathieu-Daudé (1):
  hw/intc: Remove TCG dependency on ARM_GICV3

 MAINTAINERS                         |   8 +
 contrib/vmapple/uuid.sh             |   9 +
 docs/system/arm/vmapple.rst         |  63 +++
 docs/system/target-arm.rst          |   1 +
 hw/Kconfig                          |   1 +
 hw/block/virtio-blk.c               |  19 +-
 hw/core/qdev-properties-system.c    |   8 +
 hw/intc/Kconfig                     |   6 +-
 hw/intc/meson.build                 |   4 +-
 hw/meson.build                      |   1 +
 hw/misc/Kconfig                     |   4 +
 hw/misc/meson.build                 |   1 +
 hw/misc/pvpanic-mmio.c              |  60 +++
 hw/usb/hcd-xhci-pci.c               |  25 ++
 hw/usb/hcd-xhci-pci.h               |   1 +
 hw/usb/hcd-xhci.c                   |   5 +
 hw/usb/hcd-xhci.h                   |   5 +
 hw/vmapple/Kconfig                  |  32 ++
 hw/vmapple/aes.c                    | 581 ++++++++++++++++++++++++++
 hw/vmapple/bdif.c                   | 274 ++++++++++++
 hw/vmapple/cfg.c                    | 195 +++++++++
 hw/vmapple/meson.build              |   5 +
 hw/vmapple/trace-events             |  21 +
 hw/vmapple/trace.h                  |   1 +
 hw/vmapple/virtio-blk.c             | 204 +++++++++
 hw/vmapple/vmapple.c                | 618 ++++++++++++++++++++++++++++
 include/hw/misc/pvpanic.h           |   1 +
 include/hw/pci/pci_ids.h            |   1 +
 include/hw/qdev-properties-system.h |   5 +
 include/hw/virtio/virtio-blk.h      |  11 +-
 include/hw/vmapple/vmapple.h        |  23 ++
 include/qemu/cutils.h               |  15 +
 meson.build                         |   1 +
 qapi/virtio.json                    |  14 +
 util/hexdump.c                      |  18 +
 35 files changed, 2231 insertions(+), 10 deletions(-)
 create mode 100755 contrib/vmapple/uuid.sh
 create mode 100644 docs/system/arm/vmapple.rst
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


