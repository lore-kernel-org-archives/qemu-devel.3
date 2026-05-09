Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6116FCD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 10:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLfFb-0000NA-MR; Sat, 09 May 2026 06:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLfF4-0008Mg-32; Sat, 09 May 2026 06:49:07 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLfEx-0001dy-2B; Sat, 09 May 2026 06:49:03 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 649AlY21090834
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 9 May 2026 19:47:56 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ovxDiLwATszUSIXbNJjZtgyq5rkuZWGQM63LhlHsYP8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1778323676; v=1;
 b=tLSsWsSNnjC8XkCWR8u8T5JZt9kN1gNEdia/QnYW02ddYnfkUTIvJf6WW3zlfMOK
 W1r2TSndSO6SndIbXZRN88NYACYVePCtf/hV7CjWTO7TG0/zYJGK8BUrxp6YNJGJ
 H8ZsLu1vaJIWjtmMK9Tma4lSlSddquyHNgOQ+qGgEKMTuGlkwuLCMp8W4pjJhCoI
 NzWjgIDHLrHueaOOkp91PNuKXpzrzLHPsw07HszDmBuu+DlpIlP74zdE9gg41KIm
 yPbyAMQz+QMLKBiSytdFfjtcsBGJb9JNUBdXnRGDYkJTkPDsTzBCJ238NKYKx/2P
 d0mUue9rRBpmclLCkGCpFQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH RFC 00/28] ui/input: Decouple internal and QAPI input
 events
Date: Sat, 09 May 2026 19:34:12 +0900
Message-Id: <20260509-input-v1-0-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyML3cy8gtISXcskS5M0YwvL1ERTUyWg2oKi1LTMCrA50UpBbs5KsRD
 B4tKkrNTkEpAJSrW1ADQ8cuVuAAAA
X-Change-ID: 20260428-input-9b94f389ea55
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=5387;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=2A4nLI8GQSqRf8xd8/ph1Hzv+R//RZaWsnk5gl8duCY=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ+Z/geOnFgurv+7QvlGm316sWSj5sL2hakrGPqF+V4Gvi
 jms7ds6SlkYxLgYZMUUWVKKdnNrRNd+KkyIb4GZw8oEMoSBi1MAJjJVhpFhbxBDzkyZz1P2PKhv
 qr/hVFa9iU3IrqLi9uzm8IcRHFJpjAzNj/5JTbkYK1WRo8WYuDbqe8uFX5zvrtr/W6hv0hl1OZk
 fAA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The internal input event representation has different requirements from
the QAPI representation. Using QAPI types directly spreads QAPI-specific
constraints throughout the internal input code. Keep that impact
localized by decoupling the two representations with a dedicated
conversion layer. The decoupled internal representation has the
following benefits:

- It avoids wrapper structs and pointer indirections required by QAPI.
  They are useful at the QMP boundary, but unnecessary for internal
  input events and make handlers more verbose.

- It enforces a single key code set while QAPI input events allow key
  codes to be stored either as qnum or qcode. Having two code sets is
  useful for QMP compatibility, but complicates internal input handling.
  Commit af07e5ff02ae ("ui: convert key events to QKeyCodes
  immediately") made qcode the only key code set used internally, but
  the QAPI type does not enforce that and accessing the key code is
  still tedious.

- It uses Linux key codes. They cover all keys represented by qcodes,
  include additional keys, and allow QEMU to pass codes through from
  Linux hosts to Linux guests. This also simplifies the code by avoiding
  qcode aliases and matches the approach used by virtio and Xen. Since
  this is an internal representation, QEMU can extend the key code set
  if a QEMU-specific need arises.

Only the switch to Linux key codes is intended to change functional
behavior. The interfaces that require QKeyCode are still preserved and
QKeyCode_str() is still used to query key names. Changing QAPI to accept
Linux key codes is possible, but out of scope for this series.

This series is organized as follows:
Patches 1-6 convert the internal interfaces.
Patches 7-26 convert their users.
Patches 27-28 remove the old internal interfaces.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

---
Akihiko Odaki (28):
      ui/input: Introduce QemuInputEvent typedef
      ui/input: Remove QAPI wrappers from QemuInputEvent
      ui/input: Store QKeyCode directly in QemuInputKeyEvent
      ui/input: Use Linux key codes for internal key events
      ui/console: Add qemu_text_console_put_linux()
      ui/kbd-state: Use Linux key codes
      hw/arm/musicpal: Use Linux key codes
      hw/char/escc: Use Linux key codes
      hw/display/xenfb: Use Linux key codes
      hw/input/adb-kbd: Use Linux key codes
      hw/input/hid: Use Linux key codes
      hw/input/ps2: Use Linux key codes
      hw/input/virtio-input: Use Linux key codes
      hw/m68k/next-kbd: Use Linux key codes
      replay: Use Linux key codes
      ui/cocoa: Use Linux key codes
      ui/dbus: Use Linux key codes
      ui/gtk: Use Linux key codes
      ui/input-barrier: Use Linux key codes
      ui/input-legacy: Use Linux key codes
      ui/input-linux: Use Linux key codes
      ui/keymaps: Use Linux key codes
      ui/sdl2: Use Linux key codes
      ui/spice: Use Linux key codes
      ui/vnc: Use Linux key codes
      qemu-keymap: Use Linux key codes
      ui/console: Remove qemu_text_console_put_qcode()
      ui/input: Remove unused QKeyCode helpers and keymaps

 include/qemu/typedefs.h      |   1 +
 include/system/replay.h      |   2 +-
 include/ui/console.h         |   3 +-
 include/ui/input.h           |  92 ++++++++------
 include/ui/kbd-state.h       |   8 +-
 replay/replay-internal.h     |   6 +-
 ui/x_keymap.h                |   3 +-
 chardev/msmouse.c            |  12 +-
 chardev/wctablet.c           |  10 +-
 hw/arm/musicpal.c            |  31 +++--
 hw/char/escc.c               |  45 +++----
 hw/display/xenfb.c           |  51 +++-----
 hw/input/adb-kbd.c           | 246 ++++++++++++++++++-------------------
 hw/input/adb-mouse.c         |  22 ++--
 hw/input/hid.c               |  41 +++----
 hw/input/ps2.c               | 116 +++++++++--------
 hw/input/stellaris_gamepad.c |  11 +-
 hw/input/virtio-input-hid.c  |  89 +++++++-------
 hw/m68k/next-kbd.c           | 128 +++++++++----------
 qemu-keymap.c                |  41 +++----
 replay/replay-events.c       |   6 +-
 replay/replay-input.c        | 117 ++++++------------
 replay/replay.c              |   2 +-
 replay/stubs-system.c        |   2 +-
 ui/console.c                 |  62 ++++++----
 ui/dbus-console.c            |   8 +-
 ui/gtk.c                     |  49 ++++----
 ui/input-barrier.c           |  26 ++--
 ui/input-keymap.c            |  74 +++++------
 ui/input-legacy.c            |  47 +++----
 ui/input-linux.c             |   3 +-
 ui/input.c                   | 229 ++++++++++++++--------------------
 ui/kbd-state.c               |  55 +++++----
 ui/keymaps.c                 |   4 +-
 ui/sdl2-input.c              |  17 +--
 ui/spice-input.c             |   3 +-
 ui/vdagent.c                 |  20 ++-
 ui/vnc.c                     |  25 ++--
 ui/x_keymap.c                |  24 ++--
 hw/input/trace-events        |   2 +-
 ui/cocoa.m                   | 287 ++++++++++++++++++++++---------------------
 ui/meson.build               |  29 +++--
 ui/trace-events              |   3 +-
 43 files changed, 962 insertions(+), 1090 deletions(-)
---
base-commit: 759c456b1d22fe4083c8b384da27d3f56fd53f82
change-id: 20260428-input-9b94f389ea55

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


