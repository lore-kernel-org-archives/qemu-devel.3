Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F31C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2TQ-0005RL-5T; Wed, 17 Jul 2024 07:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2Sj-0001qZ-5G
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:48 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2Sa-00073K-If
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:41 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id A965C38F9CE; Wed, 17 Jul 2024 13:04:06 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, agraf@csgraf.de, pbonzini@redhat.com,
 phil@philjordan.eu, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, akihiko.odaki@daynix.com,
 peter.maydell@linaro.org
Subject: [PATCH v2 0/8] hw/display/apple-gfx: New macOS PV Graphics device
Date: Wed, 17 Jul 2024 13:03:18 +0200
Message-Id: <20240717110326.45230-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=89.104.8.17; envelope-from=phil@intel-mbp.local;
 helo=intel-mbp.local
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, KHOP_HELO_FCRDNS=0.261,
 NO_DNS_FOR_FROM=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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

This sequence of patches integrates the paravirtualised graphics device
implemented by macOS's ParavirtualizedGraphics.Framework into Qemu.
Combined with the guest drivers which ship with macOS versions 11 and up,
this allows the guest OS to use the host's GPU for hardware accelerated
3D graphics, GPGPU compute (both using the 'Metal' graphics API), and
window compositing.

Some background:
----------------

The device exposed by the ParavirtualizedGraphics.Framework's (henceforth
PVG) public API consists of a PCI device with a single memory-mapped BAR;
the VMM is expected to pass reads and writes through to the framework, and
to forward interrupts emenating from it to the guest VM.

The bulk of data exchange between host and guest occurs via shared memory,
however. For this purpose, PVG makes callbacks to VMM code for allocating,
mapping, unmapping, and deallocating "task" memory ranges. Each task
represents a contiguous host virtual address range, and PVG expects the
VMM to map specific guest system memory ranges to these host addresses via
subsequent map callbacks. Multiple tasks can exist at a time, each with
many mappings.

Data is exchanged via an undocumented, Apple-proprietary protocol. The
PVG API only acts as a facilitator for establishing the communication
mechanism. This is perhaps not ideal, and among other things means it
only works on macOS hosts, but it's the only serious option we've got for
good performance and quality graphics with macOS guests at this time.

The first iterations of this PVG integration into Qemu were developed
by Alexander Graf as part of his "vmapple" machine patch series for
supporting aarch64 macOS guests, and posted to qemu-devel in June and
August 2023:

https://lore.kernel.org/all/20230830161425.91946-1-graf@amazon.com/T/

This integration mimics the "vmapple"/"apple-gfx" variant of the PVG device
used by Apple's own VMM, Virtualization.framework. This variant does not use
PCI but acts as a direct MMIO system device; there are two MMIO ranges, one
behaving identically to the PCI BAR, while the other's functionality is
exposed by private APIs in the PVG framework. It is only available on aarch64
macOS hosts.

I had prior to this simultaneously and independently developed my own PVG
integration for Qemu using the public PCI device APIs, with x86-64 and
corresponding macOS guests and hosts as the target. After some months of
use in production, I was slowly reviewing the code and readying it for
upstreaming around the time Alexander posted his vmapple patches.

I ended up reviewing the vmapple PVG code in detail; I identified a number
of issues with it (mainly thanks to my prior trial-and-error working with
the framework) but overall I thought it a better basis for refinement
than my own version:

 - It implemented the vmapple variant of the device. I thought it better to
   port the part I understood well (PCI variant) to this than trying to port
   the part I didn't understand well (MMIO vmapple variant) to my own code.
 - The code was already tidier than my own.

It also became clear in out-of-band communication that Alexander would
probably not end up having the time to see the patch through to inclusion,
and was happy for me to start making changes and to integrate my PCI code.

It's taken a while, but I'm happy with the result and think it will be a
welcome addition for anyone running macOS VMs.

What doesn't work:
------------------

 * State (de-)serialisation and thus migration. There is no fundamental
   technical obstacle to this. PVG supports saving and loading device state.
   I have simply not had the resources to implement (and crucially, test it)
   it yet.
 * Setting the list of display modes via a property is currently only
   implemented on the PCI version, which is the only one readily testable
   without the out-of-tree vmapple patches. (See review notes for patch 7)
 * End-to-end GPU-only rendering. After the host GPU has rendered the guest's
   screen, the framebuffer is copied into a system memory buffer (surface).
   When using the Qemu Cocoa UI, this buffer is drawn by the CPU into a GPU
   texture used for hardware window compositing. It would be vastly more
   efficient to retain the Metal texture and pass it directly through to the
   Cocoa window. We currently have no mechanism for doing so; it would need
   to be similar to the end-to-end OpenGL rendering support, with the added
   complication that Metal textures are Objective-C types and would need to
   traverse the plain C code of the Qemu display subsystem.
 * Dirty region detection. Similarly, the whole framebuffer is marked modified
   even if there has only been a small change. This hurts network data volume
   when using VNC.
 * Multi-head support. PVG allows "connecting" more than one virtual display.
   This integration currently always uses exactly 1 display.
 * The vmapple/aarch64 variant of the device is only testable with Alexander's
   vmapple machine type patch set. I've been maintaining this out-of-tree and
   have made a few improvements, but it doesn't yet run smoothly. (Graphics
   work fine with this code, issues are with other devices.) I can push my
   current draft to a git forge if anyone wants to test with them. I'm
   definitely hoping to eventually resolve the remaining problems and submit
   a revised version of that patch set as well.


I think we can live without these for the moment, and I'd prefer to work on
them only if and when the baseline functionality has been merged.

Patch review notes:
-------------------

As requested, I have now squashed any fixes and refactorings into the
orginal commit and changed that to be marked as co-authored.

Brief meta-discussion of specific patches and groups of patches:

 01:    Alexander Graf's original patch, rebased on latest upstream and
        combined with a long list of improvements.
 02:    The PCI variant. This implements the PCI variant of the PVG device
        in addition to the original vmapple/mmio one. The PCI variant
        is intended for x86-64 macOS guests.
 03-06: Various improvements on top of the baseline functionality. I've left
        these non-squashed as I think some of them might generate more feedback
        and iteration, and thus may distract from the main task of getting the
        core merged.
 07:    QOM property for specifying the display mode list (resolutions) the
        device will report to the guest. I checked other display devices and
        found none supported this, though I personally find it very useful.
        I'm wondering whether this should be a more generic feature optionally
        usable by any display device in Qemu?
 08:    Adding myself as maintainer for the PVG code, and reviewer for HVF.

Changes since v1:
-----------------

 * Squashed most of the commits into the first one, including the
   dpy_cursor_define_supported removal as that API has now disappeared from
   upstream.
 * Added comments explaining the reasons for different MMIO write handling
   on aarch64 vs x86-64.
 * Integrated cursor image RGBA<->BGRA conversion which I'd missed in the
   v1 patch set. (This fixes the colours on non-greyscale guest cursors.)
 * Removed a stray macOS 12 availability check. (These are no longer needed
   as Qemu 9.1 removes support for macOS 11 and older hosts.)

Phil Dennis-Jordan (8):
  hw/display/apple-gfx: Introduce ParavirtualizedGraphics.Framework
    support
  hw/display/apple-gfx: Adds PCI implementation
  ui/cocoa: Adds non-app runloop on main thread mode
  hw/display/apple-gfx: Implements texture syncing for non-UMA GPUs
  hw/display/apple-gfx: Replaces magic number with queried MMIO length
  hw/display/apple-gfx: Host GPU picking improvements
  hw/display/apple-gfx: Adds configurable mode list
  MAINTAINERS: Add myself as maintainer for apple-gfx, reviewer for HVF

 MAINTAINERS                    |   7 +
 hw/display/Kconfig             |  13 +
 hw/display/apple-gfx-pci.m     | 162 ++++++++
 hw/display/apple-gfx-vmapple.m | 194 ++++++++++
 hw/display/apple-gfx.h         |  72 ++++
 hw/display/apple-gfx.m         | 681 +++++++++++++++++++++++++++++++++
 hw/display/meson.build         |   3 +
 hw/display/trace-events        |  26 ++
 include/qemu-main.h            |   2 +
 meson.build                    |   4 +
 ui/cocoa.m                     |  15 +-
 11 files changed, 1177 insertions(+), 2 deletions(-)
 create mode 100644 hw/display/apple-gfx-pci.m
 create mode 100644 hw/display/apple-gfx-vmapple.m
 create mode 100644 hw/display/apple-gfx.h
 create mode 100644 hw/display/apple-gfx.m

-- 
2.39.3 (Apple Git-146)


