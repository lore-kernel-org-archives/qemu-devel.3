Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CABC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2TM-000537-1F; Wed, 17 Jul 2024 07:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SP-0000ZG-3o
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:29 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SM-0006zM-RU
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:24 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id A366D3795FD; Mon, 15 Jul 2024 23:07:35 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: 
Date: Mon, 15 Jul 2024 23:06:39 +0200
Message-Id: <20240715210705.32365-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
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

Date: Mon, 15 Jul 2024 21:07:12 +0200
Subject: [PATCH 00/26] hw/display/apple-gfx: New macOS PV Graphics device
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
   without the out-of-tree vmapple patches. (See review notes for patch 24)
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

I have aimed to submit the patches roughly in order of descending importance
and increasing debatability. From patch 18 it becomes usable and useful in
practice without further modification. Patches 19-23 fix issues that only occur
in certain host configurations or that can otherwise be worked around. Patch
24 is more of an RFC; patch 26 is needed if recently submitted Cocoa UI patches
end up being merged.

Brief meta-discussion of specific patches and groups of patches:

 01:    I have retained Alexander Graf's original patch intact as far as
        possible as patch 01. My only modifications are those required for
        fixing rebase conflicts.
 02:    Resolves build errors caused by upstream API changes since original
        patch submission.
 03:    This moves the device code to hw/display from its original hw/vmapple.
        With the PCI variant added later, it doesn't make much sense to put
        this inside a machine type directory.
 04-13: These patches address issues identified during code review in the
        original e-mail threads as well as my own review.
 14-15: These patches split the monolithic source file into a common core and
        vmapple/mmio specific parts.
        NOTE: checkpatch.pl complains about #ifdef __OBJC__ in the header file.
        This is needed for allowing the file to be #included from pure C.
        Ensuring that isn't currently critical, but I expect it to be useful
        in future.
 16-17: Preparation for x86-64. The x86-64 variant of PVG seems to behave
        slightly differently than the aarch64 version in terms of threading
        and control flow edge cases. We need to do some things asynchronously
        to avoid deadlock and performance problems.
 18:    The PCI variant. This builds on the split from 14/15 and the async
        changes to create the PVG PCI device which works with x86-64 macOS
        guests.
 19-23: Fixes for various additional problems and limitations. Without these
        the PVG device will only work with the Cocoa UI, on Macs which
        have an integrated (shared memory) GPU only, and mouse cursors will
        be slightly off, for example.
 24:    QOM property for specifying the display mode list (resolutions) the
        device will report to the guest. I checked other display devices and
        found none supported this, though I personally find it very useful.
        I'm wondering whether this should be a more generic feature optionally
        usable by any display device in Qemu?
 25:    Adding myself as maintainer for the PVG code, and reviewer for HVF.
 26:    Required if/when Akihiko Odaki's pending patch for removing
        dpy_cursor_define_supported is merged.

I don't know if it's useful/wise to keep these all as separate patches.
I'm happy to squash any number or groups of them. Personally, I find
smaller patches easier to review, and the git blame history acts as
a sort of documentation, so I've kept them for now.

Alexander Graf (1):
  hw/vmapple/apple-gfx: Introduce ParavirtualizedGraphics.Framework
    support

Phil Dennis-Jordan (25):
  hw/vmapple/apple-gfx: BQL renaming update
  hw/display/apple-gfx: Moved from hw/vmapple/
  hw/display/apple-gfx: uses DEFINE_TYPES macro
  hw/display/apple-gfx: native -> little endian memory ops
  hw/display/apple-gfx: Removes dead/superfluous code
  hw/display/apple-gfx: Makes set_mode thread & memory safe
  hw/display/apple-gfx: Adds migration blocker
  hw/display/apple-gfx: Wraps ObjC autorelease code in pool
  hw/display/apple-gfx: Fixes ObjC new/init misuse, plugs leaks
  hw/display/apple-gfx: Uses ObjC category extension for private
    property
  hw/display/apple-gfx: Task memory mapping cleanup
  hw/display/apple-gfx: Defines PGTask_s struct instead of casting
  hw/display/apple-gfx: Refactoring of realize function
  hw/display/apple-gfx: Separates generic & vmapple-specific
    functionality
  hw/display/apple-gfx: Asynchronous MMIO writes on x86-64
  hw/display/apple-gfx: Asynchronous rendering and graphics update
  hw/display/apple-gfx: Adds PCI implementation
  ui/cocoa: Adds non-app runloop on main thread mode
  hw/display/apple-gfx: Fixes cursor hotspot handling
  hw/display/apple-gfx: Implements texture syncing for non-UMA GPUs
  hw/display/apple-gfx: Replaces magic number with queried MMIO length
  hw/display/apple-gfx: Host GPU picking improvements
  hw/display/apple-gfx: Adds configurable mode list
  MAINTAINERS: Add myself as maintainer for apple-gfx, reviewer for HVF
  hw/display/apple-gfx: Removes UI pointer support check

 MAINTAINERS                    |   7 +
 hw/display/Kconfig             |  13 +
 hw/display/apple-gfx-pci.m     | 166 +++++++++
 hw/display/apple-gfx-vmapple.m | 194 ++++++++++
 hw/display/apple-gfx.h         |  72 ++++
 hw/display/apple-gfx.m         | 659 +++++++++++++++++++++++++++++++++
 hw/display/meson.build         |   3 +
 hw/display/trace-events        |  26 ++
 include/qemu-main.h            |   2 +
 meson.build                    |   4 +
 ui/cocoa.m                     |  15 +-
 11 files changed, 1159 insertions(+), 2 deletions(-)
 create mode 100644 hw/display/apple-gfx-pci.m
 create mode 100644 hw/display/apple-gfx-vmapple.m
 create mode 100644 hw/display/apple-gfx.h
 create mode 100644 hw/display/apple-gfx.m

-- 
2.39.3 (Apple Git-146)


