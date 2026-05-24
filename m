Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA36CD5BB1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 20:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRFTJ-00018S-4D; Sun, 24 May 2026 16:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRFTI-00018G-Bc
 for qemu-devel@nongnu.org; Sun, 24 May 2026 16:30:52 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRFTG-0003p3-8L
 for qemu-devel@nongnu.org; Sun, 24 May 2026 16:30:52 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-68852b58d87so5792799a12.3
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 13:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779654647; cv=none;
 d=google.com; s=arc-20240605;
 b=fdowZrpSaYLVsccrwrjL4zHQw9IGFA9Dk78dVzdUFBwETCCLEk56kUE6EGH+kUw81+
 vcK1WUpjKxEJjBheAGKSQS12AP9EIgBHxCv/lki5IKOw+ZjhXHAcGJs7rWf2i8faXgUH
 Jk+wQCQfL/WAanvfTZldtQWokmVxMJsJz+9DdVFgUvi6JaqcbjVatqaCL7D/twByoxmV
 KHxZB3wggXhBmLktIjmoPOn0Sw16UduM3ylQsX7lGjXBRW4yk3ekhiAvJyUySEX4DBNp
 UuYMKSkDsELKTRDmNC1rvAjJpTiBjrOVtMqCgvfq7Fb2Ay/i6OObVY1XCRIorUMszchI
 L2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wM2AtakQVCsDH9XUeLnDd3aq68KNXs0AeQAFmZPyh/Q=;
 fh=a48Yz94NrSN1VfxXFKxdHg5tRcnTkBUqJPewYKl8hN0=;
 b=hOLRJyqIqQ9GUV1LW/gjCZPuc1hMwUMrBZEhIR6SZv7Nm+Y7jrSiwZsL0RvuybjiDi
 QrQ87V3x3AzCu1dPFqwb52q2RvtQVhgGLApnT7cZvELFQkGbQ0jx9JqmNKfjztTVaej0
 xiD2kDWhopGlctj/jT//votOKA1smXFitfNmroKHA9RVaLRJvwDLmYPAwThz5ZGVxZ4J
 /8Ysz7heLLDDGFe9VVgfLKdooy5KRe1qCapXqHuD8ka9XmRLdOcYkRRM6h/kcUnrFbAe
 eCCIxMXr6mbjbqDafRuXwZsJJhJq/xdKZqyeEB4ahkC6431hYUUqBZQTbG5x0Fri2gZK
 j85Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779654647; x=1780259447; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wM2AtakQVCsDH9XUeLnDd3aq68KNXs0AeQAFmZPyh/Q=;
 b=mCtQTOltnqjIhRybQSdjrBR0xgPeHHgqpT5vUsmPjfclelydo2QKk0Oi/fRRaESdV3
 oI66Iz/yc0aXgxhpzYLJCDfH5ridgKzI0KCkvy7rdrhTd1X3UVVR6x1CzgjiLXBdR+2u
 3OZIzYSvimh0Af+k2M7AmXd3efdhoCH2ZwKDY4WlNa/HfrCGAQhZji/96PKpUJswSf49
 hqllfkDYFMOBizJr7kzySNQQH0iCzDrkkTrLOsopBBaytNtiL5DPu/7+bGkP9Unkrxwm
 1YD1cxtPNpPygwBd9qgtZ/qimUU00ycaquxZ/aWSZvwQsib/Xxwvvw+HbqfHy9YenM95
 Ct1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779654647; x=1780259447;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wM2AtakQVCsDH9XUeLnDd3aq68KNXs0AeQAFmZPyh/Q=;
 b=hd295MD8VAEn4Nk+oJPbRArGagQiF/jk/u0VaObx8vIg6oR37E6/N10ZJRkD0YTHnD
 qFGp0X4myhydkt6AieW0dotaicKf1jHmyFsOGnrL23SoXuE6UeZ2E92lCcJkCuJimof2
 VX9cve4qB7YDYbQixuKb5c5/yj2COQRxJyrupErEXt2AcGy4qusVLny4VnQW2L1I07s0
 VB5sTQqtvfPqvDR4FB+SZMdUaOj+DbZ/BhwQI9ZwgXrkw3JCBgVWyRBjDgmx4TAeKolN
 gTN6e6iRYnPh7wyax4Hs1XYbJCr2gnaJ2tXDhI43e1yh9/F5C3hacGS4+BjoauOVBF9q
 cbkg==
X-Gm-Message-State: AOJu0YzrBtqQaxXGNW/isLoUfZS87CC+R9g9NICMZ9+RbK+hWKaalOYc
 MTzc/9aDlCRueMycs2jonkUKhgD7iWoLjeTJCFl0UwG+Z31eptMkJWmTV9EH8SCE2ib3O4neTT4
 FnNHwK4tlbyr/8lrQ7PY47UDgp1fNpGI=
X-Gm-Gg: Acq92OE3nE0gUUzY9Shu4Y0pk22W5Qpb3w+nCyf3M2ZEinOxT4FFcpCKYZhPodCfQOJ
 Y3/gi4rwjB/kS/vPupZZpw/97ijVHYw1UIqZQgBdYVuOKx7N040HEkFGdAndLeILBwwYXMzqfDS
 s3MsioZEyAUz67bEayofXLCeLpcGHuPU3dMwwK9W8f2QOu9PCpXC6ccmnlTL4UzZK8Iy60Xm+Mf
 57/pRsGimxheuZ1RuISao0J094Q+Js0Vtx3j3pekt7da6ttQz9A3XK1shnKCt+FWJn20lzM6+s2
 GK7j2PoOKkQMe7o107tyiZ2oDIubUmb1v3MmYQc8tMGjrFDMFn7T8eLHhxwS3uc=
X-Received: by 2002:a17:907:c05:b0:bd4:d6d6:b4bc with SMTP id
 a640c23a62f3a-bdd2580be6emr695127066b.27.1779654646743; Sun, 24 May 2026
 13:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 24 May 2026 16:30:33 -0400
X-Gm-Features: AVHnY4IcWjyc9OXgbcToXW3B5LIIpRmVP-Qdw4xvI1ecq8qhJ5GnZeUsoO0hysE
Message-ID: <CAJSP0QXoxZgG4Chk53upHtWXZH-+nvoU041bHe+bHwgFsg353Q@mail.gmail.com>
Subject: Re: [PULL v2 00/38] Ui patches
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
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

On Thu, May 21, 2026 at 9:56=E2=80=AFAM <marcandre.lureau@redhat.com> wrote=
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
> for you to fetch changes up to 95df9ffa98a785e4e9368018a72e643e77328ed1:
>
>   ui/gtk: Fix focus loss on re-attachment with single VC (2026-05-21 17:5=
3:43 +0400)
>
> ----------------------------------------------------------------
> UI pull request
>
> - ui/input: Decouple internal and QAPI input events
> - VNC OOB fixes
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

Please take a look at this replay failure:
https://gitlab.com/qemu-project/qemu/-/jobs/14521293731#L842

If the issue is caused by this pull request, please resend with a fix.

If the issue is not caused by this pull request, please let me know. Thanks=
!

Stefan

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

