Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389DBCD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 21:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRG8C-0006cb-CT; Sun, 24 May 2026 17:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wRG8A-0006cK-PG
 for qemu-devel@nongnu.org; Sun, 24 May 2026 17:13:06 -0400
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wRG88-0002a5-Rh
 for qemu-devel@nongnu.org; Sun, 24 May 2026 17:13:06 -0400
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-2f0d3e07e30so30464797eec.0
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 14:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779657183; cv=none;
 d=google.com; s=arc-20240605;
 b=Dv/u0UZy9dJG2XoUOUfu03HmH6l7Tfy5u/w8VfLHDTaJAER6L+aaJJjsLXKppxWCZi
 S76LfQrpgmSKHysYXXV3Z6vxfyXwg2a4XLRhuc9/6IWdnWROM0QHt0Tw3Z7W5vVdPbYF
 GwLG4XInfCZKfkgm0es0k7jP8Szu3ZcKHAyktFNp5FmYa6K2mhcrlLseHKdgiy2BFMBr
 aQJWsgO2vBr+ZPYSHVVho4jrQ7FVtJE2ecbgbnhFRcIQaCp4Gy36G8PTIpV+H/ZMDooW
 0Q85Keb3oNHvnV87tjGx6oZ9rCuzLEn+1P6era9OhzF54Jp/eifcm1KzY08rVGOT0ne0
 eOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B2Kdwl8IkZrxf2BPKu4/jozmNvNdE9vqjC0xkQptOMo=;
 fh=XmZ0L7Z5w9e/3F1/bfXy/1q6v8r+2isR/9DsPajNzYw=;
 b=R2PdqZ6xGqzmSY1uynDySEZPlyMMQz4TYH9QOFIHYCuCJ/cum3D/pCxMOESuwBe+GB
 kudRax/ZeX71ChIcz85Uu7rp0DRtc1nFg9podadYHbZhPxvnf4z/Xuq0cu5gmTS706Wq
 UR2nZq+RNdPeKBoPJ3CJ/oCH/xMmIneE7H2TGDLW1EtwUlo8CTx4gKOgxu5tL04yxN0T
 7351IxkWYAlunsAOHnLe9ipwV16TMtqnNUFJ4IzslrwDHQXRLQcTyV/RLjDRJhBA35ug
 vIThAP8hH+azMxPWGwfkoKK+KyO3UipXECbMLYCzM9IuBu0PsYygnXC8Xpz0ZHDzlEyN
 VQug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779657183; x=1780261983; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2Kdwl8IkZrxf2BPKu4/jozmNvNdE9vqjC0xkQptOMo=;
 b=i36XcKk+tEpwhwvFBUqGsa4UVK1Izcf5YIClTuayqfm8NU1p7fmL4oIId6UGHOAclN
 xE0/GWIqmUh7Be1B6z5YLPDqLY+Ssr/1T668xxVcPq2SebUoMK5nu6+zigl2qjAZHZgT
 UVbd3wgIBI0h3DHieUkQ6+DlGjwidHbSxrZUcyE+pV0LJXbTF0MZbgXGu88wc1CHrgN7
 Vwy3m9Oiq+iFjSvyTYb/OlhK3szkFQRyMZ8/yMf6jag+9Wi2IxF+1cpM6/p8pkSK0JcA
 RvXVqAjHTJG3LTSVHheNuqa80xRsXV/KqR9fA+HUlciPxM3Nc39Y3TPUG4+1U6xm86bF
 9gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779657183; x=1780261983;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B2Kdwl8IkZrxf2BPKu4/jozmNvNdE9vqjC0xkQptOMo=;
 b=K44dxiGYX/CrFZnUEIx5EJiJ0IFoLGh3LRc9uzo48A9G4QJ9Letk9MNomtscxLzF2Q
 wZM96z4OgBhq7N/chvXXmlD9qjndegCGe9xYss+N4FWg3DjLzxRD31Y1VKdB12nKyLkM
 f8etNuCx9Y5cuwsLnGLdK7pscodn5OAx7xwjTu83n8xs8Ay0uO9daID5v+/g/btqldv0
 ASMgul/PrYx1RNM4IgLFVpMgiRj4Z9+8mHJ0h+wCCj7oWvLcF3slWYldsf6zr7MWGAUp
 0vCkAIJJRvkJZ4oIYomvYL1/qwPv7ljPtTZLxIN5lXBcO7OzgfIAjAvBppKoFm/pFxEv
 pDrw==
X-Gm-Message-State: AOJu0YzLji2PD1YHhDjd5ieDgOsTBFSEw0FCg672DV+hVS0f3urPEbMp
 mRaQiz9CF/aq24LGcRJ2e1/7ootMEORbi4gNR9QRrFkxK0rRt2cPpNI2pIKipv45ra0Prn/P+ek
 Zpv84fBbR0OPhXkjxHF5FJrvjUdzB9FA=
X-Gm-Gg: Acq92OHZh4KROvAyjztQnHFptsqAhU0nYKAXMMoqS2iqzKUtXqZHykQK1p8dEu/uWFU
 QSE8Rqh+TY7g6Kne8Mh/5DUPWnaj/pamY27XY3z3vCs8T7Dme6aaKJ01rOucBcXSWsFUF/9SlSH
 MtgPJczVKFcrBrt2RBKPeLM6UKN4Bue/lox2pmY1ml8mfyDkFGZ1Wxhq+zbNArmhHXZ/50OeCB/
 AVijzaiwZkGMN84FzqamwjMN7Zxi2VOci3isgQQH6NhCz4244QcIC9IdUxeGeoPzMXhUP/EdlJt
 i/YdXcVIuQzWddEOtjiefTbqHnonUQlfbk1LfecaojBHOuSsiQ==
X-Received: by 2002:a05:7300:ec11:b0:2da:44ac:6d0d with SMTP id
 5a478bee46e88-30449101b3emr5773428eec.20.1779657182452; Sun, 24 May 2026
 14:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
 <CAJSP0QXoxZgG4Chk53upHtWXZH-+nvoU041bHe+bHwgFsg353Q@mail.gmail.com>
In-Reply-To: <CAJSP0QXoxZgG4Chk53upHtWXZH-+nvoU041bHe+bHwgFsg353Q@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 25 May 2026 01:12:50 +0400
X-Gm-Features: AVHnY4LysIW-tPncnvUUrBjzTpB3GzXiVXqIlCmKwKffrQLGF-Hk-AwCTb0oLJU
Message-ID: <CAJ+F1CKNGvPfc0kL-7D61_Fd3Eh1HSAS_nY3FgA8yQC_WsT2Rg@mail.gmail.com>
Subject: Re: [PULL v2 00/38] Ui patches
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1331.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Mon, May 25, 2026 at 12:31=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
>
> On Thu, May 21, 2026 at 9:56=E2=80=AFAM <marcandre.lureau@redhat.com> wro=
te:
> >
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > The following changes since commit 3f129ea545f16e82b5e43fcc3866b134b7cc=
4dfc:
> >
> >   Merge tag 'pull-vfio-20260520' of https://github.com/legoater/qemu in=
to staging (2026-05-20 16:53:28 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
> >
> > for you to fetch changes up to 95df9ffa98a785e4e9368018a72e643e77328ed1=
:
> >
> >   ui/gtk: Fix focus loss on re-attachment with single VC (2026-05-21 17=
:53:43 +0400)
> >
> > ----------------------------------------------------------------
> > UI pull request
> >
> > - ui/input: Decouple internal and QAPI input events
> > - VNC OOB fixes
> > - vt100 fixes
> > - GTK focus fix
> >
> > ----------------------------------------------------------------
> >
> > Akihiko Odaki (29):
> >   ui/input: Introduce QemuInputEvent typedef
> >   ui/input: Remove QAPI wrappers from QemuInputEvent
> >   ui/input: Store QKeyCode directly in QemuInputKeyEvent
> >   ui/input: Use Linux key codes for internal key events
> >   ui/input: Prohibit sending KEY_RESERVED
> >   ui/console: Add qemu_text_console_put_linux()
> >   ui/kbd-state: Use Linux key codes
> >   hw/arm/musicpal: Use Linux key codes
> >   hw/char/escc: Use Linux key codes
> >   hw/display/xenfb: Use Linux key codes
> >   hw/input/adb-kbd: Use Linux key codes
> >   hw/input/hid: Use Linux key codes
> >   hw/input/ps2: Use Linux key codes
> >   hw/input/virtio-input: Use Linux key codes
> >   hw/m68k/next-kbd: Use Linux key codes
> >   replay: Use Linux key codes
>
> Please take a look at this replay failure:
> https://gitlab.com/qemu-project/qemu/-/jobs/14521293731#L842
>
> If the issue is caused by this pull request, please resend with a fix.
>
> If the issue is not caused by this pull request, please let me know. Than=
ks!

Oh I missed it, despite running CI tests with ci.variable=3DQEMU_CI=3D2
(https://gitlab.com/marcandre.lureau/qemu/-/pipelines/2543698396) What
should I use instead?

In "replay: Use Linux key codes" patch, we'd need something like:

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 081aaa36c5e..ce1031b4ad4 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -398,6 +398,9 @@ def decode_end(eid, name, dumpfile):
 # EVENT_AUDIO_IN has changed
 v13_event_table =3D v12_event_table

+# EVENT_ASYNC_INPUT has changed
+v14_event_table =3D v13_event_table
+
 def parse_arguments():
     "Grab arguments for script"
     parser =3D argparse.ArgumentParser()
@@ -416,7 +419,10 @@ def decode_file(filename):
     # see REPLAY_VERSION
     print("HEADER: version 0x%x" % (version))

-    if version =3D=3D 0xe0200d:
+    if version =3D=3D 0xe0200e:
+        event_decode_table =3D v14_event_table
+        replay_state.checkpoint_start =3D 30
+    elif version =3D=3D 0xe0200d:
         event_decode_table =3D v13_event_table
         replay_state.checkpoint_start =3D 30
     elif version =3D=3D 0xe0200c:

I can squash and resubmit, or does someone want to revisit it?

>
> Stefan
>
> >   ui/cocoa: Use Linux key codes
> >   ui/dbus: Use Linux key codes
> >   ui/gtk: Use Linux key codes
> >   ui/input-barrier: Use Linux key codes
> >   ui/input-legacy: Use Linux key codes
> >   ui/input-linux: Use Linux key codes
> >   ui/keymaps: Use Linux key codes
> >   ui/sdl2: Use Linux key codes
> >   ui/spice: Use Linux key codes
> >   ui/vnc: Use Linux key codes
> >   qemu-keymap: Use Linux key codes
> >   ui/console: Remove qemu_text_console_put_qcode()
> >   ui/input: Remove unused QKeyCode helpers and keymaps
> >
> > Daniel P. Berrang=C3=A9 (4):
> >   ui/vnc: fix OOB read access in VNC SASL mechname array
> >   ui/vnc: fix OOB write in VNC stats array
> >   ui/vnc: fix OOB write in lossy rect worker code
> >   ui/vnc: fix OOB read updating VNC update frequency stats
> >
> > Dongwon Kim (1):
> >   ui/gtk: Fix focus loss on re-attachment with single VC
> >
> > Heechan Kang (1):
> >   ui: fix validation of VNC extended clipboard data length
> >
> > Marc-Andr=C3=A9 Lureau (1):
> >   ui/vt100: add vt100_fini() check
> >
> > Peter Maydell (2):
> >   ui/vt100: Standardize on uint8_t for "ch" byte variables
> >   ui/vt100: Take byte as uint8_t in bh_utf8_decode()
> >
> >  include/qemu/typedefs.h      |   1 +
> >  include/system/replay.h      |   2 +-
> >  include/ui/console.h         |   3 +-
> >  include/ui/input.h           |  92 ++++++-----
> >  include/ui/kbd-state.h       |  12 +-
> >  replay/replay-internal.h     |   6 +-
> >  ui/vnc.h                     |   4 +-
> >  ui/x_keymap.h                |   3 +-
> >  chardev/msmouse.c            |  12 +-
> >  chardev/wctablet.c           |  10 +-
> >  hw/arm/musicpal.c            |  31 ++--
> >  hw/char/escc.c               |  45 +++---
> >  hw/display/xenfb.c           |  51 ++-----
> >  hw/input/adb-kbd.c           | 246 +++++++++++++++--------------
> >  hw/input/adb-mouse.c         |  22 ++-
> >  hw/input/hid.c               |  41 +++--
> >  hw/input/ps2.c               | 118 +++++++-------
> >  hw/input/stellaris_gamepad.c |  11 +-
> >  hw/input/virtio-input-hid.c  |  89 ++++++-----
> >  hw/m68k/next-kbd.c           | 128 ++++++++--------
> >  qemu-keymap.c                |  41 +++--
> >  replay/replay-events.c       |   6 +-
> >  replay/replay-input.c        | 117 +++++---------
> >  replay/replay.c              |   2 +-
> >  replay/stubs-system.c        |   2 +-
> >  tools/qemu-vnc/input.c       |   9 +-
> >  ui/console.c                 |  62 +++++---
> >  ui/dbus-console.c            |   8 +-
> >  ui/gtk.c                     |  55 ++++---
> >  ui/input-barrier.c           |  26 ++--
> >  ui/input-keymap.c            |  74 +++++----
> >  ui/input-legacy.c            |  47 ++----
> >  ui/input-linux.c             |   3 +-
> >  ui/input.c                   | 214 ++++++++++++--------------
> >  ui/kbd-state.c               |  61 ++++----
> >  ui/keymaps.c                 |   4 +-
> >  ui/sdl2-input.c              |  17 ++-
> >  ui/spice-input.c             |   3 +-
> >  ui/vdagent.c                 |  20 +--
> >  ui/vnc-auth-sasl.c           |   2 +
> >  ui/vnc-clipboard.c           |   9 +-
> >  ui/vnc.c                     |  41 ++---
> >  ui/vt100.c                   |  11 +-
> >  ui/x_keymap.c                |  24 +--
> >  hw/input/trace-events        |   2 +-
> >  tools/qemu-vnc/trace-events  |   2 +-
> >  ui/cocoa.m                   | 289 ++++++++++++++++++-----------------
> >  ui/meson.build               |  29 ++--
> >  ui/trace-events              |   5 +-
> >  49 files changed, 1014 insertions(+), 1098 deletions(-)
> >
> > --
> > 2.54.0
> >
>

