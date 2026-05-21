Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198A2CD5BBC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3Wm-0001eV-5G; Thu, 21 May 2026 09:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wQ3Wi-0001dJ-Hc
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:33:28 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wQ3Wg-00054H-Dx
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:33:28 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-67c2b4809baso13228476a12.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:33:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779370403; cv=none;
 d=google.com; s=arc-20240605;
 b=hwaobSRBKq0zzmvoDpKYXEfYLHrB+yV1N/BhjEvml57j/uS+kTN75YPEi8paw0+bBK
 FTQSdOCN4nx8hgqoRZtZ2oL5rpxJzSLdi64ma0NF2/5E5zx4Hjfvkh0kzyj/B1T59uB7
 x7G39xhHjdjnnv9EMyOGrY8DZOxAeqH3RChX0oDaAtHNSaxPu8p/IXcPIpPRUAb3ICva
 lWkABqupbGXmlow2amMikC4rOjBqDW6As9sKayy9GM+Bd1X9j6Ksptejah6MRZPjNieK
 2FytMQusWColo+uQD4W34W8IK+KG2fIEmEfve+xE6KtVZLlJM6iLohpcdyz0JXDJSNDY
 54fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KZTaeWiVbslJywgP7Tky/tyfokaHlwQOZ4tqToDqA/o=;
 fh=a48Yz94NrSN1VfxXFKxdHg5tRcnTkBUqJPewYKl8hN0=;
 b=RDbFgdI8kzMUeLOxei4knvcV4KOJCWSUTUvFKfP5k5w0H8TzqYj99PYqq7igHFC1J+
 LZ2bvKpEyE7ubajDCT//qrQbdgsRDkUx4kVBC1vXZybm/Eo2frWPg2D8jwHFizoe1V0h
 6bhodII1I+ZVg8VPlXw706Tc25C6kgmphEBlj1gvWLVC//in8OlM4i4F3dt7eDmD8vCJ
 Z3cajcncnD/y3RIe2vq5L+oxdVtRlfR4lFyc/vxNVT2Af15DtGwHsITlSAqFoREU9jHm
 LhXsEAppLx2HBLOIMWMQjWy9S9MlvZrIV/VEQVKDdzLQyl7spNYnRaPEGwSCH4PEY3wG
 v7hA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779370403; x=1779975203; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZTaeWiVbslJywgP7Tky/tyfokaHlwQOZ4tqToDqA/o=;
 b=qeaCdynEMhF8Zdy9emdTK1aVTIPEeTnIqwGH29x4Y1OyqF31n7je7K4dvqzzfA6XNM
 hHYx6dmL1LDjFH6sTc9M4AzjcH/M/VojDmRlCCiW6f67aWFUj3WYjUlUwnFP0E0rdwww
 tSZ5hgVVhl7TzAPPzQD7Xuou1u7MzgWZzzLDZPgYfZLbcz/1eVb2ki9pfBoeErwhSTdI
 37prNNHMsYv4WcmOv39UN3vP3AaP6HaXOPZqtXWBXElYt0rTKWYiyNmNb6S+42aLSHnV
 oMaF6oJN3EghV3NDQan9DeswjRvHrkPeThGEcXbFYaA753A79ZOSy6DvDcx8+/il2fjZ
 ylLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779370403; x=1779975203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KZTaeWiVbslJywgP7Tky/tyfokaHlwQOZ4tqToDqA/o=;
 b=D7vzacQANWYxRisD20qRn905Fl8fe2Owx6/mthXSOUcZsLP0BkzAQ1kHfxFcBghNxz
 3ih9xooQc58SvLv4dAxGXch0JJiz2AIAv0+A/IlKdYU4VQmAz0v/1V46EuHDaXAhmsa6
 5GES1/BNgH8GEWoRm7IhuCD74LpZISjUKcF3nFuGinVmLxnhfbZXx5Ssn1+Al25QIiym
 UvDBAM2DA2EoLV5BJYcunVjs/Rjy6k9PrPOwAKr3c7qc+lGHFmTqkXg+XnK5aZfx32wo
 kDEHnYS5NFV1NMuPScwiB1/8AxMP2wLnEKGdI7MubS1Z7HBiGBBtV7xZRNqg8TFwYVem
 pT+g==
X-Gm-Message-State: AOJu0YzjttlFY3CMY8vMHv1jKeSHPF3v22HKI6QLJrOn9K92hWztL8nI
 b4MnNe3OQjO89DJl+4at1MBZ5HYpUuip1IiMwmGKPT49BRfrN6dmKlns4Bm+3WvbIyECsPaV4Sv
 m29Qf3lyuiKbwcJMjmV7xLS4KF8Z/rbEohiY9PIw=
X-Gm-Gg: Acq92OFgA5nng2dC017+FZoj/40bHr5AePVaHXlqhhoOWaL9bcQxmH8CjutrX1l7D4k
 KPNV1D8NncJtz/Te/cqoDNxjfKNrAhvRNaACk+YiYgx2sMQOP7l970ET3vAKyDNMWLg7uv4Qm2Q
 6gyRMMyFpw9AEV6NefXzzrika1crEDaIQblRHoZ7L6JBfxhVYeeWxmUMOXhhtEmVg998Jv54laJ
 x26UBFvrMMGcavuswgbAoAa25YgOYFbp2vQzs6dj+RDiAUhrMAnKmxcLc0p8zijYzwNH2mWDKIl
 kqKvp0O3jFLjdZsv0WRK2LFZ+CgISP/BTGeyBuHTqQ==
X-Received: by 2002:a05:6402:40d2:b0:683:93a2:dfb9 with SMTP id
 4fb4d7f45d1cf-68835ee8475mr1445321a12.1.1779370403166; Thu, 21 May 2026
 06:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 21 May 2026 09:33:10 -0400
X-Gm-Features: AVHnY4K5QV4nqSveDLzvLR0UQqSVoHyRms9yua9tfIKtZRyJQqzCC2Rax2FjjFY
Message-ID: <CAJSP0QWKstRSGUC6gKTUNWC-gdX11v5OLZUVwp3YJE+gbJB5ig@mail.gmail.com>
Subject: Re: [PULL 00/38] Ui patches
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, May 21, 2026 at 7:57=E2=80=AFAM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit 3f129ea545f16e82b5e43fcc3866b134b7cc4d=
fc:
>
>   Merge tag 'pull-vfio-20260520' of https://github.com/legoater/qemu into=
 staging (2026-05-20 16:53:28 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
>
> for you to fetch changes up to 64abff825b6fab9366b582f4d54eb2d12985c0b7:
>
>   ui/gtk: Fix focus loss on re-attachment with single VC (2026-05-21 15:2=
9:58 +0400)
>
> ----------------------------------------------------------------
> UI pull request
>
> - ui/input: Decouple internal and QAPI input events
> - VNC OOB fixes

This fails to build:

../ui/vnc.c:2989:5: error: called object type 'void' is not a function
or function pointer
2988 | assert(h <=3D VNC_STAT_ROWS)
| ~~~~~~~~~~~~~~~~~~~~~~~~~~
2989 | assert(w <=3D VNC_STAT_COLS)
| ^

https://gitlab.com/qemu-project/qemu/-/jobs/14485414396

Please take a look and send a v2. Thanks!

Stefan

> - vt100 fixes
> - GTK focus fix
>
> ----------------------------------------------------------------
>
> Akihiko Odaki (29):
>   ui/input: Introduce QemuInputEvent typedef
>   ui/input: Remove QAPI wrappers from QemuInputEvent
>   ui/input: Store QKeyCode directly in QemuInputKeyEvent
>   ui/input: Use Linux key codes for internal key events
>   ui/input: Prohibit sending KEY_RESERVED
>   ui/console: Add qemu_text_console_put_linux()
>   ui/kbd-state: Use Linux key codes
>   hw/arm/musicpal: Use Linux key codes
>   hw/char/escc: Use Linux key codes
>   hw/display/xenfb: Use Linux key codes
>   hw/input/adb-kbd: Use Linux key codes
>   hw/input/hid: Use Linux key codes
>   hw/input/ps2: Use Linux key codes
>   hw/input/virtio-input: Use Linux key codes
>   hw/m68k/next-kbd: Use Linux key codes
>   replay: Use Linux key codes
>   ui/cocoa: Use Linux key codes
>   ui/dbus: Use Linux key codes
>   ui/gtk: Use Linux key codes
>   ui/input-barrier: Use Linux key codes
>   ui/input-legacy: Use Linux key codes
>   ui/input-linux: Use Linux key codes
>   ui/keymaps: Use Linux key codes
>   ui/sdl2: Use Linux key codes
>   ui/spice: Use Linux key codes
>   ui/vnc: Use Linux key codes
>   qemu-keymap: Use Linux key codes
>   ui/console: Remove qemu_text_console_put_qcode()
>   ui/input: Remove unused QKeyCode helpers and keymaps
>
> Daniel P. Berrang=C3=A9 (4):
>   ui/vnc: fix OOB read access in VNC SASL mechname array
>   ui/vnc: fix OOB write in VNC stats array
>   ui/vnc: fix OOB write in lossy rect worker code
>   ui/vnc: fix OOB read updating VNC update frequency stats
>
> Dongwon Kim (1):
>   ui/gtk: Fix focus loss on re-attachment with single VC
>
> Heechan Kang (1):
>   ui: fix validation of VNC extended clipboard data length
>
> Marc-Andr=C3=A9 Lureau (1):
>   ui/vt100: add vt100_fini() check
>
> Peter Maydell (2):
>   ui/vt100: Standardize on uint8_t for "ch" byte variables
>   ui/vt100: Take byte as uint8_t in bh_utf8_decode()
>
>  include/qemu/typedefs.h      |   1 +
>  include/system/replay.h      |   2 +-
>  include/ui/console.h         |   3 +-
>  include/ui/input.h           |  92 ++++++-----
>  include/ui/kbd-state.h       |  12 +-
>  replay/replay-internal.h     |   6 +-
>  ui/vnc.h                     |   4 +-
>  ui/x_keymap.h                |   3 +-
>  chardev/msmouse.c            |  12 +-
>  chardev/wctablet.c           |  10 +-
>  hw/arm/musicpal.c            |  31 ++--
>  hw/char/escc.c               |  45 +++---
>  hw/display/xenfb.c           |  51 ++-----
>  hw/input/adb-kbd.c           | 246 +++++++++++++++--------------
>  hw/input/adb-mouse.c         |  22 ++-
>  hw/input/hid.c               |  41 +++--
>  hw/input/ps2.c               | 118 +++++++-------
>  hw/input/stellaris_gamepad.c |  11 +-
>  hw/input/virtio-input-hid.c  |  89 ++++++-----
>  hw/m68k/next-kbd.c           | 128 ++++++++--------
>  qemu-keymap.c                |  41 +++--
>  replay/replay-events.c       |   6 +-
>  replay/replay-input.c        | 117 +++++---------
>  replay/replay.c              |   2 +-
>  replay/stubs-system.c        |   2 +-
>  tools/qemu-vnc/input.c       |   9 +-
>  ui/console.c                 |  62 +++++---
>  ui/dbus-console.c            |   8 +-
>  ui/gtk.c                     |  55 ++++---
>  ui/input-barrier.c           |  26 ++--
>  ui/input-keymap.c            |  74 +++++----
>  ui/input-legacy.c            |  47 ++----
>  ui/input-linux.c             |   3 +-
>  ui/input.c                   | 214 ++++++++++++--------------
>  ui/kbd-state.c               |  61 ++++----
>  ui/keymaps.c                 |   4 +-
>  ui/sdl2-input.c              |  17 ++-
>  ui/spice-input.c             |   3 +-
>  ui/vdagent.c                 |  20 +--
>  ui/vnc-auth-sasl.c           |   2 +
>  ui/vnc-clipboard.c           |   9 +-
>  ui/vnc.c                     |  41 ++---
>  ui/vt100.c                   |  11 +-
>  ui/x_keymap.c                |  24 +--
>  hw/input/trace-events        |   2 +-
>  tools/qemu-vnc/trace-events  |   2 +-
>  ui/cocoa.m                   | 289 ++++++++++++++++++-----------------
>  ui/meson.build               |  29 ++--
>  ui/trace-events              |   5 +-
>  49 files changed, 1014 insertions(+), 1098 deletions(-)
>
> --
> 2.54.0
>

