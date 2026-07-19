Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594DCC4451B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 15:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlTMf-0001mr-En; Sun, 19 Jul 2026 11:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlTMa-0001jI-Ok
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 11:23:32 -0400
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlTMY-0006ib-GQ
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 11:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pq.io;
 s=protonmail3; t=1784474604; x=1784733804;
 bh=FUzEYm5luKWoqbxDpvTLiy5IYCc08o8agx03l+Bm058=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=pQN+ZR6mFDjrchIIHhfgwN6gV9DI77LJWOcTg+1G7XbswzL3njOaWUFUTHmkRCpzq
 MfY/6Z5+NXaZFKyB9UU0/ajz3l6BkjcI7/4dIZZYUR/gRJ2ATfywubym5+VpADPZ+8
 y/5qg+eH8wl5vf0HCFi6CeJ8QC5aGQgO1Q0Wim/9bqq8WJFcRwIN4SZva/VOwAPb8B
 wXokQdbuaXByXx0TMLMoDth+o0yWMOH/pdTIesclZzak+3HK51xb7XQcLHYt/rJfnN
 RVi6I1REiCX0dMFyi+lAB0chQ5Fjb9WSlQk3ChVcrHLMt9LbZxk3QusazhOauIfbot
 R3oTxnzry4QXQ==
X-Pm-Submission-Id: 4h36qG1pYVz1DFgd
From: Matthew Jackson <matthew@pq.io>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH 0/2] hw/usb/dev-hid: Apple Magic Keyboard and Mighty Mouse
 emulators
Date: Sun, 19 Jul 2026 08:23:16 -0700
Message-ID: <20260719152318.69501-1-matthew@pq.io>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=85.9.206.169; envelope-from=matthew@pq.io;
 helo=mail-05.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

This series adds two new self-contained USB HID devices to
hw/usb/dev-hid.c: apple-magic-keyboard and apple-mighty-mouse,
emulating the USB-cable face of the real Apple Magic Keyboard with
Numeric Keypad (PID 0x026c) and Apple Mighty Mouse (PID 0x0304).

Why this exists
---------------

QEMU has no USB-HID device that macOS recognises as a real Apple
peripheral. With usb-kbd / usb-tablet, macOS guests:

  * Run Keyboard Setup Assistant on first boot - costs 3-5 minutes
    on interactive installs and effectively hangs headless
    (VNC / SPICE) installs.

  * Bind the generic IOUSBHostHIDDevice driver instead of the Apple
    HID driver chain (AppleUSBTopCaseHIDDriver,
    AppleDeviceManagementHIDEventService,
    AppleHIDKeyboardEventDriverV2, AppleHIDMouseEventDriver). Several
    recovery / install / multi-touch UI panels behave correctly only
    when the chain matches an Apple-VID peripheral.

The new devices ship the real wire format (descriptors, HID report
descriptors, endpoint topology) byte-identical to real hardware in
USB-cable mode. The keyboard's boot-interface report descriptor is
byte-for-byte the real Apple Magic Keyboard with Numeric Keypad
descriptor (182 bytes, four application collections), captured from
a real keyboard plugged into a Mac via the macOS IOReg dump.

Self-contained, additive only
-----------------------------

Zero existing files are modified outside the new device blocks in
hw/usb/dev-hid.c. The existing usb-kbd / usb-mouse / usb-tablet
devices and their vmstate are unchanged. Migration of existing VMs
is unaffected.

Apple-vendor identity
---------------------

Both devices declare idVendor 0x05ac (Apple) and the real PIDs.
Precedent: isa-applesmc ships the verbatim Apple OSK string; mac99
emulates real Apple PowerPC hardware; apple-gfx.m (Phil Dennis-Jordan,
2024) emulates Apple's host paravirt GPU. The Apple PnP IDs are
public identifiers (linux-usb's usb.ids database) and emulating them
does not bypass any Apple licensing check beyond what isa-applesmc
already requires.

If reviewers prefer the Apple PID/VID gated behind an
apple-id=on/off device property (default off), a v2 patch is prepared
addressing that. The v1 carries the Apple IDs unconditionally,
matching the precedent set by sibling devices.

Why Mighty Mouse, not Magic Trackpad
------------------------------------

An earlier draft of this series shipped apple-magic-tablet emulating
Apple Magic Trackpad 2 (PID 0x0265). Magic Trackpad 2 binds
AppleMultitouchTrackpadHIDEventDriver in macOS, which gates cursor on
a 1387-byte vendor-multitouch frame format we do not have ground-truth
wire bytes for. Guessing the wire layout produced AppleHIDStack hangs
during recovery boots that wasted multiple debug cycles.

Apple Mighty Mouse (PID 0x0304) is Apple's wired ball mouse, M9087,
released 2005. It binds the generic AppleHIDMouseEventDriver /
IOHIDPointing chain natively — handles standard 5-byte boot mouse
reports (3-bit button mask + signed int8 dX/dY + signed int8 vWheel +
signed int8 hWheel) without any vendor-specific protocol. Same
"Apple-VID-or-fail" property the Apple HID stack checks for; cursor +
click + scroll all work unconditionally. v1 of this series ships this
device.

For backward compatibility with downstream consumers using the earlier
draft's name (which exists in some out-of-tree downstream forks),
patch 0002 also registers a TypeInfo legacy alias `apple-magic-tablet`
inheriting from the canonical `apple-mighty-mouse` type — both
`-device` strings resolve to the same implementation. The alias has
no permanent place in upstream and can be dropped any time after
in-tree consumers move to the canonical name.

Tested
------

Tested on macOS 15.7.5 against a stock retail installer, mos-docker
test rig (privileged container, network_mode=host, --device /dev/kvm,
QEMU 11.0.0 patched binary).

  * Phase 2 regression (patched QEMU + macOS HD + isa-applesmc + ICH9
    globals + generic usb-kbd / usb-tablet) — boot to login PASS,
    visual gold-image diff well under 2% threshold.

  * Phase 3 regression (+ apple-magic-keyboard + apple-mighty-mouse
    swap) — boot to login PASS, visual gold-image diff well under 2%
    threshold. macOS' AppleUSBTopCaseHIDDriver +
    AppleHIDKeyboardEventDriverV2 bind on the keyboard;
    AppleHIDMouseEventDriver / IOHIDPointing binds on the mouse.

  * HID delivery verified via a second screendump after driving a
    deterministic input sequence (QMP send-key for 'a','b','c' →
    three password dots in the loginwindow field; QMP
    input-send-event with absolute pointer to centre coords → cursor
    visible at centre). Gold-image diff against
    phase-3-input-gold.png passes — proves keyboard and mouse
    delivery, not just enumeration.

  * Linux-guest descriptor walk (xHCI + libusb) — descriptors and HID
    report descriptors decode cleanly. PID/VID/strings as expected.

  * Visible keystroke proof — QMP send-key Return advances macOS
    recovery's language-picker UI; cursor moves on QMP
    input-send-event abs-pointer.

  * Migration smoke test — VM saves + restores without device
    breakage on both new types.

Per-patch summary
-----------------

  0001 — apple-magic-keyboard: composite USB device, two HID
    interfaces. Interface 0 carries the Apple-vendor descriptor (182
    bytes, byte-for-byte real device) with vendor reports 0xe0 / 0x9a
    / 0x90 the Apple driver chain probes. Interface 1 carries the
    Magic Keyboard boot-keyboard descriptor (boot kbd Report 0x01 +
    Consumer Eject + Vendor 0xff Usage 0x03; consumer multimedia
    Report 0x52; system control feature Report 0x09; vendor Report
    0x3f 64-byte feature blob). Wired to the QEMU input subsystem via
    qemu_input_handler_register(). STALLs on GET_REPORT for undeclared
    report IDs (matches real-device USB HID behaviour — returning
    zero-fill there causes macOS' HID parser to wedge during
    IOHIDInterface::start). SET_REPORT sets actual_length so the host
    doesn't retry indefinitely.

  0002 — apple-mighty-mouse: single HID interface, single IN endpoint,
    standard boot mouse + scroll Report Descriptor (5-byte report —
    3-bit button mask + dX + dY + vWheel + hWheel). Wired to QEMU's
    input subsystem accepting REL motion + ABS motion + BTN events.
    ABS events (from VNC) are converted to REL via a last_abs_x/y
    delta tracker. Bounded queue (depth 64) drains accumulated motion
    across multiple reports per input sync so cursor movement stays
    responsive under large pointer deltas. Includes the
    `apple-magic-tablet` legacy TypeInfo alias as described above.

Series root
-----------

Generated against qemu.git v11.0.0. Each patch applies cleanly and
`make check` is green on x86_64.

  git fetch origin master
  git checkout -b apple-magic-hid origin/master
  git am 0001-*.patch
  git am 0002-*.patch

Matthew Jackson (2):
  hw/usb/dev-hid: add apple-magic-keyboard
  hw/usb/dev-hid: add apple-mighty-mouse

 hw/usb/dev-hid.c | 1411 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1411 insertions(+)

--
2.50.1 (Apple Git-155)

