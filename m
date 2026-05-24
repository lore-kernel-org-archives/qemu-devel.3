Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EDBCD5BB1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 21:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRGRM-0001hJ-9V; Sun, 24 May 2026 17:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRGRK-0001gx-Nm
 for qemu-devel@nongnu.org; Sun, 24 May 2026 17:32:54 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRGRI-000660-70
 for qemu-devel@nongnu.org; Sun, 24 May 2026 17:32:54 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-67b8d9c26bbso18192481a12.2
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 14:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779658371; cv=none;
 d=google.com; s=arc-20240605;
 b=Gwafzgx9m2nvn+D29560skXVat8XHJifCqV9H8pWAjLOns/lhLyHSgCep6IZe5tKQu
 2ZWvNA/HbT8akAVyybtkqFCvPAy/00IjYEfupbwlws+4OshqxK1xWflGLuJw+Rj1XXkY
 3buVIA7Qhmny+bdqftg59jMe7bLxAbHL7bvACsNOOIDhWwLhTaAvv2q3xSu3gPqL9SaR
 CO+lPPLjF6rRlvltdn+eALVMstltpwgyzt4UltHlaI9eyZ8FH8j2YcsZQmClhIO6XX+7
 v+4Y5ZRg7/hiQhrSbnAQl/UbmUYIjkT7CkoxlYsC/YvcFJWE4oKzV8GZl/7f/t+7fOIF
 HmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WTqeFF8ktZgCNMXxnLNIy6kOmr+xTc74YPWZDfevZak=;
 fh=Bs/O39LXMpVPaFJWYptzvAwwLJ57D05YckjZsBrLvz4=;
 b=QquqOp91m/lmuLZTbJ4rHmY5PTOQCiPfiWfSJW67iG/lJfN1A/aqYKT3+APuE2osTT
 yH3kcQjj996WFxg0HbHfBOqFnvomiH/lcXQdJlK6Yw7WC15xiehgBqQNZ6UP9M6kIvoP
 XYTgV2jV1ChjgGKKiZ4EKowjs9XpPuEwp9XzIFjZ7/kMqTNma8nAcqCU9Ji3WAFAjSxz
 3GBkt2TE8LNinj+sQd8H/qrRrI2fiucDjrqvLd3/HPCCJlZGaB5m5ABDDE+f+YcUnptp
 Pm7VPF1BN/rXayzJq7AOiDEQw3c0eWXxJ3DRxoWlQip4o8sUbFWpu2SHl1bGzJCGBl3l
 T8RA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779658371; x=1780263171; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WTqeFF8ktZgCNMXxnLNIy6kOmr+xTc74YPWZDfevZak=;
 b=QmJDps+CP+1ALk+ViQEQ83rVe13A0dJ3hDRqoHHtOx6RAn0Q8lDi2Xs+mE353f6QOh
 OWilNWMY557++d1iUSk30ZcR+JhILZeUu95DzKvAhDCHCsgBuhjOf/a1ft50ZmVb1Od0
 4nyyGuMPrUB9EJHJToijs0zN62pjtpXHRcA4hOLLlcvDf7pWuKFvWUDgDj1NlXLJ9aoq
 G+vDE4vQH4iB4RA8fnjfrDURsLKzIwd0roZXmIZMUfclveZjdG9H8++L0Lf4/+MYKMoa
 9CaeJg8gYnkwbqjFoHpqiHZfNK1nJXOIyHAUlPq1oRGc/K7nq1Jkg6VkhzLgMMG122J0
 6J/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779658371; x=1780263171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WTqeFF8ktZgCNMXxnLNIy6kOmr+xTc74YPWZDfevZak=;
 b=WldPZImrv9vuiWtuIqM1Us5jckx+wPx4Ht3Hb7HErC+7ptdzEnQB8lgellUi4EL4C4
 yFgHeJM7AX85ju8LDxqKaI6ZtFlNM4XWeoIwCtMZUBTU/IxQcpsLpYTUDVRROvTS/7a7
 5MbOwbSzbOdG5B8HTFZ7F5llP1zg+RQz5Hv8FFxpDOvwsTzJFCfZC1pw07ALg22sK2l8
 bYRl0JxjO+lLdPmSzTAmb3GQw3Sk3tvdDy8aUUBSAsEZsxP70lUcseNywCGJwBE8dkni
 jpY3W5J+ST50wcUpgMmtuR8v4W3bJ7wHZFqrup+gazT4qRa+DM+kGgI/2xCV4dl9yK73
 tavQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8O8OjSBROABMf1rFzykoJXHZmBDicxPj7Lkj3c3Za2jH1RGGe/0pttMhVGMt7VMUa7tux4jWyC02Di@nongnu.org
X-Gm-Message-State: AOJu0Ywm+ro6IHOtlerQwuDoSywEtIGwDt3ezXRBCDOt86o2Gxk2G+9l
 tFEISh1kjJ0W8P1YnzhWbnCY2MN+Zu65tR4e8nK061DaxAYjq8sOnr9D1+6qjcnawMCI+A6OZug
 NEQIz4A/3tOOY3mrGXNd48RSBNB6lAHs=
X-Gm-Gg: Acq92OFFY3LpGZFy6MIQwtcFAuxYZr/EGr546KGJSQ7iEGuQ6q3jGgo2gCIvRPMzH1A
 95QHM2OpODlCvI9qbDK3eqYMXFkJukUYtSalUAyyRgvXTTxcjdZzHjgn7KA8ELGW6SoBkmM2s6O
 GbkGckowngdZQaPJkZ9YK0+v8F2MYOEsHA12295164PNITMlGVkWGD+wrF1W0htT3R8V/CzZIQr
 NocpNdaVWDlqJCaMA8fd7ZBr456anVtZXPiGqXUDXJe9frIeE9qkDXb2CoSwytcDqBLm20AJI4I
 /Hd7qdL9ZeVM7igmN7avdHdTQCzZHTkdnKRbJy4CNUCwA9auVA==
X-Received: by 2002:a05:6402:11d3:b0:679:223c:d191 with SMTP id
 4fb4d7f45d1cf-6889cc37577mr6293441a12.13.1779658370342; Sun, 24 May 2026
 14:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
 <CAJSP0QXoxZgG4Chk53upHtWXZH-+nvoU041bHe+bHwgFsg353Q@mail.gmail.com>
 <CAJ+F1CKNGvPfc0kL-7D61_Fd3Eh1HSAS_nY3FgA8yQC_WsT2Rg@mail.gmail.com>
In-Reply-To: <CAJ+F1CKNGvPfc0kL-7D61_Fd3Eh1HSAS_nY3FgA8yQC_WsT2Rg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 24 May 2026 17:32:37 -0400
X-Gm-Features: AVHnY4Lr2vkrQWNmsU_oqASYfLmbxqSovYpKEhEzReNoruPTbIiXWNL0RONl-_o
Message-ID: <CAJSP0QUaHNrjN0G9aRTuT+HLeiQACnihW3d0ws8-LzBd_SRi6A@mail.gmail.com>
Subject: Re: [PULL v2 00/38] Ui patches
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000fc637406529700dd"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000fc637406529700dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026, 17:13 Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat=
.com>
wrote:

> Hi
>
> On Mon, May 25, 2026 at 12:31=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.=
com>
> wrote:
> >
> > On Thu, May 21, 2026 at 9:56=E2=80=AFAM <marcandre.lureau@redhat.com> w=
rote:
> > >
> > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > > The following changes since commit
> 3f129ea545f16e82b5e43fcc3866b134b7cc4dfc:
> > >
> > >   Merge tag 'pull-vfio-20260520' of https://github.com/legoater/qemu
> into staging (2026-05-20 16:53:28 -0400)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
> > >
> > > for you to fetch changes up to
> 95df9ffa98a785e4e9368018a72e643e77328ed1:
> > >
> > >   ui/gtk: Fix focus loss on re-attachment with single VC (2026-05-21
> 17:53:43 +0400)
> > >
> > > ----------------------------------------------------------------
> > > UI pull request
> > >
> > > - ui/input: Decouple internal and QAPI input events
> > > - VNC OOB fixes
> > > - vt100 fixes
> > > - GTK focus fix
> > >
> > > ----------------------------------------------------------------
> > >
> > > Akihiko Odaki (29):
> > >   ui/input: Introduce QemuInputEvent typedef
> > >   ui/input: Remove QAPI wrappers from QemuInputEvent
> > >   ui/input: Store QKeyCode directly in QemuInputKeyEvent
> > >   ui/input: Use Linux key codes for internal key events
> > >   ui/input: Prohibit sending KEY_RESERVED
> > >   ui/console: Add qemu_text_console_put_linux()
> > >   ui/kbd-state: Use Linux key codes
> > >   hw/arm/musicpal: Use Linux key codes
> > >   hw/char/escc: Use Linux key codes
> > >   hw/display/xenfb: Use Linux key codes
> > >   hw/input/adb-kbd: Use Linux key codes
> > >   hw/input/hid: Use Linux key codes
> > >   hw/input/ps2: Use Linux key codes
> > >   hw/input/virtio-input: Use Linux key codes
> > >   hw/m68k/next-kbd: Use Linux key codes
> > >   replay: Use Linux key codes
> >
> > Please take a look at this replay failure:
> > https://gitlab.com/qemu-project/qemu/-/jobs/14521293731#L842
> >
> > If the issue is caused by this pull request, please resend with a fix.
> >
> > If the issue is not caused by this pull request, please let me know.
> Thanks!
>
> Oh I missed it, despite running CI tests with ci.variable=3DQEMU_CI=3D2
> (https://gitlab.com/marcandre.lureau/qemu/-/pipelines/2543698396) What
> should I use instead?
>

I'm on my phone right now and can't dig into the details, but you can run
the functional-system-centos test locally to verify your branch.


> In "replay: Use Linux key codes" patch, we'd need something like:
>
> diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
> index 081aaa36c5e..ce1031b4ad4 100755
> --- a/scripts/replay-dump.py
> +++ b/scripts/replay-dump.py
> @@ -398,6 +398,9 @@ def decode_end(eid, name, dumpfile):
>  # EVENT_AUDIO_IN has changed
>  v13_event_table =3D v12_event_table
>
> +# EVENT_ASYNC_INPUT has changed
> +v14_event_table =3D v13_event_table
> +
>  def parse_arguments():
>      "Grab arguments for script"
>      parser =3D argparse.ArgumentParser()
> @@ -416,7 +419,10 @@ def decode_file(filename):
>      # see REPLAY_VERSION
>      print("HEADER: version 0x%x" % (version))
>
> -    if version =3D=3D 0xe0200d:
> +    if version =3D=3D 0xe0200e:
> +        event_decode_table =3D v14_event_table
> +        replay_state.checkpoint_start =3D 30
> +    elif version =3D=3D 0xe0200d:
>          event_decode_table =3D v13_event_table
>          replay_state.checkpoint_start =3D 30
>      elif version =3D=3D 0xe0200c:
>
> I can squash and resubmit, or does someone want to revisit it?
>

Yes, that's fine.

Stefan


> >
> > Stefan
> >
> > >   ui/cocoa: Use Linux key codes
> > >   ui/dbus: Use Linux key codes
> > >   ui/gtk: Use Linux key codes
> > >   ui/input-barrier: Use Linux key codes
> > >   ui/input-legacy: Use Linux key codes
> > >   ui/input-linux: Use Linux key codes
> > >   ui/keymaps: Use Linux key codes
> > >   ui/sdl2: Use Linux key codes
> > >   ui/spice: Use Linux key codes
> > >   ui/vnc: Use Linux key codes
> > >   qemu-keymap: Use Linux key codes
> > >   ui/console: Remove qemu_text_console_put_qcode()
> > >   ui/input: Remove unused QKeyCode helpers and keymaps
> > >
> > > Daniel P. Berrang=C3=A9 (4):
> > >   ui/vnc: fix OOB read access in VNC SASL mechname array
> > >   ui/vnc: fix OOB write in VNC stats array
> > >   ui/vnc: fix OOB write in lossy rect worker code
> > >   ui/vnc: fix OOB read updating VNC update frequency stats
> > >
> > > Dongwon Kim (1):
> > >   ui/gtk: Fix focus loss on re-attachment with single VC
> > >
> > > Heechan Kang (1):
> > >   ui: fix validation of VNC extended clipboard data length
> > >
> > > Marc-Andr=C3=A9 Lureau (1):
> > >   ui/vt100: add vt100_fini() check
> > >
> > > Peter Maydell (2):
> > >   ui/vt100: Standardize on uint8_t for "ch" byte variables
> > >   ui/vt100: Take byte as uint8_t in bh_utf8_decode()
> > >
> > >  include/qemu/typedefs.h      |   1 +
> > >  include/system/replay.h      |   2 +-
> > >  include/ui/console.h         |   3 +-
> > >  include/ui/input.h           |  92 ++++++-----
> > >  include/ui/kbd-state.h       |  12 +-
> > >  replay/replay-internal.h     |   6 +-
> > >  ui/vnc.h                     |   4 +-
> > >  ui/x_keymap.h                |   3 +-
> > >  chardev/msmouse.c            |  12 +-
> > >  chardev/wctablet.c           |  10 +-
> > >  hw/arm/musicpal.c            |  31 ++--
> > >  hw/char/escc.c               |  45 +++---
> > >  hw/display/xenfb.c           |  51 ++-----
> > >  hw/input/adb-kbd.c           | 246 +++++++++++++++--------------
> > >  hw/input/adb-mouse.c         |  22 ++-
> > >  hw/input/hid.c               |  41 +++--
> > >  hw/input/ps2.c               | 118 +++++++-------
> > >  hw/input/stellaris_gamepad.c |  11 +-
> > >  hw/input/virtio-input-hid.c  |  89 ++++++-----
> > >  hw/m68k/next-kbd.c           | 128 ++++++++--------
> > >  qemu-keymap.c                |  41 +++--
> > >  replay/replay-events.c       |   6 +-
> > >  replay/replay-input.c        | 117 +++++---------
> > >  replay/replay.c              |   2 +-
> > >  replay/stubs-system.c        |   2 +-
> > >  tools/qemu-vnc/input.c       |   9 +-
> > >  ui/console.c                 |  62 +++++---
> > >  ui/dbus-console.c            |   8 +-
> > >  ui/gtk.c                     |  55 ++++---
> > >  ui/input-barrier.c           |  26 ++--
> > >  ui/input-keymap.c            |  74 +++++----
> > >  ui/input-legacy.c            |  47 ++----
> > >  ui/input-linux.c             |   3 +-
> > >  ui/input.c                   | 214 ++++++++++++--------------
> > >  ui/kbd-state.c               |  61 ++++----
> > >  ui/keymaps.c                 |   4 +-
> > >  ui/sdl2-input.c              |  17 ++-
> > >  ui/spice-input.c             |   3 +-
> > >  ui/vdagent.c                 |  20 +--
> > >  ui/vnc-auth-sasl.c           |   2 +
> > >  ui/vnc-clipboard.c           |   9 +-
> > >  ui/vnc.c                     |  41 ++---
> > >  ui/vt100.c                   |  11 +-
> > >  ui/x_keymap.c                |  24 +--
> > >  hw/input/trace-events        |   2 +-
> > >  tools/qemu-vnc/trace-events  |   2 +-
> > >  ui/cocoa.m                   | 289 ++++++++++++++++++---------------=
--
> > >  ui/meson.build               |  29 ++--
> > >  ui/trace-events              |   5 +-
> > >  49 files changed, 1014 insertions(+), 1098 deletions(-)
> > >
> > > --
> > > 2.54.0
> > >
> >
>

--000000000000fc637406529700dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, May 24, 2026, 17:13 Marc=
-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marca=
ndre.lureau@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">Hi<br>
<br>
On Mon, May 25, 2026 at 12:31=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mai=
lto:stefanha@gmail.com" target=3D"_blank" rel=3D"noreferrer">stefanha@gmail=
.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Thu, May 21, 2026 at 9:56=E2=80=AFAM &lt;<a href=3D"mailto:marcandr=
e.lureau@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@=
redhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lure=
au@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat=
.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; The following changes since commit 3f129ea545f16e82b5e43fcc3866b1=
34b7cc4dfc:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0Merge tag &#39;pull-vfio-20260520&#39; of <a href=3D"=
https://github.com/legoater/qemu" rel=3D"noreferrer noreferrer" target=3D"_=
blank">https://github.com/legoater/qemu</a> into staging (2026-05-20 16:53:=
28 -0400)<br>
&gt; &gt;<br>
&gt; &gt; are available in the Git repository at:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0<a href=3D"https://gitlab.com/marcandre.lureau/qemu.g=
it" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/marc=
andre.lureau/qemu.git</a> tags/ui-pull-request<br>
&gt; &gt;<br>
&gt; &gt; for you to fetch changes up to 95df9ffa98a785e4e9368018a72e643e77=
328ed1:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0ui/gtk: Fix focus loss on re-attachment with single V=
C (2026-05-21 17:53:43 +0400)<br>
&gt; &gt;<br>
&gt; &gt; ----------------------------------------------------------------<=
br>
&gt; &gt; UI pull request<br>
&gt; &gt;<br>
&gt; &gt; - ui/input: Decouple internal and QAPI input events<br>
&gt; &gt; - VNC OOB fixes<br>
&gt; &gt; - vt100 fixes<br>
&gt; &gt; - GTK focus fix<br>
&gt; &gt;<br>
&gt; &gt; ----------------------------------------------------------------<=
br>
&gt; &gt;<br>
&gt; &gt; Akihiko Odaki (29):<br>
&gt; &gt;=C2=A0 =C2=A0ui/input: Introduce QemuInputEvent typedef<br>
&gt; &gt;=C2=A0 =C2=A0ui/input: Remove QAPI wrappers from QemuInputEvent<br=
>
&gt; &gt;=C2=A0 =C2=A0ui/input: Store QKeyCode directly in QemuInputKeyEven=
t<br>
&gt; &gt;=C2=A0 =C2=A0ui/input: Use Linux key codes for internal key events=
<br>
&gt; &gt;=C2=A0 =C2=A0ui/input: Prohibit sending KEY_RESERVED<br>
&gt; &gt;=C2=A0 =C2=A0ui/console: Add qemu_text_console_put_linux()<br>
&gt; &gt;=C2=A0 =C2=A0ui/kbd-state: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0hw/arm/musicpal: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0hw/char/escc: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0hw/display/xenfb: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0hw/input/adb-kbd: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0hw/input/hid: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0hw/input/ps2: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0hw/input/virtio-input: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0hw/m68k/next-kbd: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0replay: Use Linux key codes<br>
&gt;<br>
&gt; Please take a look at this replay failure:<br>
&gt; <a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/14521293731#L84=
2" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-=
project/qemu/-/jobs/14521293731#L842</a><br>
&gt;<br>
&gt; If the issue is caused by this pull request, please resend with a fix.=
<br>
&gt;<br>
&gt; If the issue is not caused by this pull request, please let me know. T=
hanks!<br>
<br>
Oh I missed it, despite running CI tests with ci.variable=3DQEMU_CI=3D2<br>
(<a href=3D"https://gitlab.com/marcandre.lureau/qemu/-/pipelines/2543698396=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/marcan=
dre.lureau/qemu/-/pipelines/2543698396</a>) What<br>
should I use instead?<br></blockquote></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">I&#39;m on my phone right now and can&#39;t dig into t=
he details, but you can run the functional-system-centos test locally to ve=
rify your branch.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<br>
In &quot;replay: Use Linux key codes&quot; patch, we&#39;d need something l=
ike:<br>
<br>
diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py<br>
index 081aaa36c5e..ce1031b4ad4 100755<br>
--- a/scripts/replay-dump.py<br>
+++ b/scripts/replay-dump.py<br>
@@ -398,6 +398,9 @@ def decode_end(eid, name, dumpfile):<br>
=C2=A0# EVENT_AUDIO_IN has changed<br>
=C2=A0v13_event_table =3D v12_event_table<br>
<br>
+# EVENT_ASYNC_INPUT has changed<br>
+v14_event_table =3D v13_event_table<br>
+<br>
=C2=A0def parse_arguments():<br>
=C2=A0 =C2=A0 =C2=A0&quot;Grab arguments for script&quot;<br>
=C2=A0 =C2=A0 =C2=A0parser =3D argparse.ArgumentParser()<br>
@@ -416,7 +419,10 @@ def decode_file(filename):<br>
=C2=A0 =C2=A0 =C2=A0# see REPLAY_VERSION<br>
=C2=A0 =C2=A0 =C2=A0print(&quot;HEADER: version 0x%x&quot; % (version))<br>
<br>
-=C2=A0 =C2=A0 if version =3D=3D 0xe0200d:<br>
+=C2=A0 =C2=A0 if version =3D=3D 0xe0200e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 event_decode_table =3D v14_event_table<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 replay_state.checkpoint_start =3D 30<br>
+=C2=A0 =C2=A0 elif version =3D=3D 0xe0200d:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event_decode_table =3D v13_event_table<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0replay_state.checkpoint_start =3D 30<br>
=C2=A0 =C2=A0 =C2=A0elif version =3D=3D 0xe0200c:<br>
<br>
I can squash and resubmit, or does someone want to revisit it?<br></blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, that&#39=
;s fine.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Stefan</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote =
gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Stefan<br>
&gt;<br>
&gt; &gt;=C2=A0 =C2=A0ui/cocoa: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0ui/dbus: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0ui/gtk: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0ui/input-barrier: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0ui/input-legacy: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0ui/input-linux: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0ui/keymaps: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0ui/sdl2: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0ui/spice: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0ui/vnc: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0qemu-keymap: Use Linux key codes<br>
&gt; &gt;=C2=A0 =C2=A0ui/console: Remove qemu_text_console_put_qcode()<br>
&gt; &gt;=C2=A0 =C2=A0ui/input: Remove unused QKeyCode helpers and keymaps<=
br>
&gt; &gt;<br>
&gt; &gt; Daniel P. Berrang=C3=A9 (4):<br>
&gt; &gt;=C2=A0 =C2=A0ui/vnc: fix OOB read access in VNC SASL mechname arra=
y<br>
&gt; &gt;=C2=A0 =C2=A0ui/vnc: fix OOB write in VNC stats array<br>
&gt; &gt;=C2=A0 =C2=A0ui/vnc: fix OOB write in lossy rect worker code<br>
&gt; &gt;=C2=A0 =C2=A0ui/vnc: fix OOB read updating VNC update frequency st=
ats<br>
&gt; &gt;<br>
&gt; &gt; Dongwon Kim (1):<br>
&gt; &gt;=C2=A0 =C2=A0ui/gtk: Fix focus loss on re-attachment with single V=
C<br>
&gt; &gt;<br>
&gt; &gt; Heechan Kang (1):<br>
&gt; &gt;=C2=A0 =C2=A0ui: fix validation of VNC extended clipboard data len=
gth<br>
&gt; &gt;<br>
&gt; &gt; Marc-Andr=C3=A9 Lureau (1):<br>
&gt; &gt;=C2=A0 =C2=A0ui/vt100: add vt100_fini() check<br>
&gt; &gt;<br>
&gt; &gt; Peter Maydell (2):<br>
&gt; &gt;=C2=A0 =C2=A0ui/vt100: Standardize on uint8_t for &quot;ch&quot; b=
yte variables<br>
&gt; &gt;=C2=A0 =C2=A0ui/vt100: Take byte as uint8_t in bh_utf8_decode()<br=
>
&gt; &gt;<br>
&gt; &gt;=C2=A0 include/qemu/typedefs.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01=
 +<br>
&gt; &gt;=C2=A0 include/system/replay.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02=
 +-<br>
&gt; &gt;=C2=A0 include/ui/console.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A03 +-<br>
&gt; &gt;=C2=A0 include/ui/input.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 92 ++++++-----<br>
&gt; &gt;=C2=A0 include/ui/kbd-state.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 12=
 +-<br>
&gt; &gt;=C2=A0 replay/replay-internal.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06=
 +-<br>
&gt; &gt;=C2=A0 ui/vnc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt; &gt;=C2=A0 ui/x_keymap.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
&gt; &gt;=C2=A0 chardev/msmouse.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 12 +-<br>
&gt; &gt;=C2=A0 chardev/wctablet.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 10 +-<br>
&gt; &gt;=C2=A0 hw/arm/musicpal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 31 ++--<br>
&gt; &gt;=C2=A0 hw/char/escc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 45 +++---<br>
&gt; &gt;=C2=A0 hw/display/xenfb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 51 ++-----<br>
&gt; &gt;=C2=A0 hw/input/adb-kbd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 246 +++++++++++++++--------------<br>
&gt; &gt;=C2=A0 hw/input/adb-mouse.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 22 ++-<br>
&gt; &gt;=C2=A0 hw/input/hid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 41 +++--<br>
&gt; &gt;=C2=A0 hw/input/ps2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 118 +++++++-------<br>
&gt; &gt;=C2=A0 hw/input/stellaris_gamepad.c |=C2=A0 11 +-<br>
&gt; &gt;=C2=A0 hw/input/virtio-input-hid.c=C2=A0 |=C2=A0 89 ++++++-----<br=
>
&gt; &gt;=C2=A0 hw/m68k/next-kbd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 128 ++++++++--------<br>
&gt; &gt;=C2=A0 qemu-keymap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 41 +++--<br>
&gt; &gt;=C2=A0 replay/replay-events.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A06 +-<br>
&gt; &gt;=C2=A0 replay/replay-input.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 117 ++++=
+---------<br>
&gt; &gt;=C2=A0 replay/replay.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt; &gt;=C2=A0 replay/stubs-system.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A02 +-<br>
&gt; &gt;=C2=A0 tools/qemu-vnc/input.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A09 +-<br>
&gt; &gt;=C2=A0 ui/console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 62 +++++---<br>
&gt; &gt;=C2=A0 ui/dbus-console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 =C2=A08 +-<br>
&gt; &gt;=C2=A0 ui/gtk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 55 ++++---<br>
&gt; &gt;=C2=A0 ui/input-barrier.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 26 ++--<br>
&gt; &gt;=C2=A0 ui/input-keymap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 74 +++++----<br>
&gt; &gt;=C2=A0 ui/input-legacy.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 47 ++----<br>
&gt; &gt;=C2=A0 ui/input-linux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A03 +-<br>
&gt; &gt;=C2=A0 ui/input.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 214 ++++++++++++--------------<br>
&gt; &gt;=C2=A0 ui/kbd-state.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 61 ++++----<br>
&gt; &gt;=C2=A0 ui/keymaps.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt; &gt;=C2=A0 ui/sdl2-input.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 17 ++-<br>
&gt; &gt;=C2=A0 ui/spice-input.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A03 +-<br>
&gt; &gt;=C2=A0 ui/vdagent.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 20 +--<br>
&gt; &gt;=C2=A0 ui/vnc-auth-sasl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A02 +<br>
&gt; &gt;=C2=A0 ui/vnc-clipboard.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A09 +-<br>
&gt; &gt;=C2=A0 ui/vnc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 41 ++---<br>
&gt; &gt;=C2=A0 ui/vt100.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 11 +-<br>
&gt; &gt;=C2=A0 ui/x_keymap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 24 +--<br>
&gt; &gt;=C2=A0 hw/input/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A02 +-<br>
&gt; &gt;=C2=A0 tools/qemu-vnc/trace-events=C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt; &gt;=C2=A0 ui/cocoa.m=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 289 ++++++++++++++++++-----------------<br>
&gt; &gt;=C2=A0 ui/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 29 ++--<br>
&gt; &gt;=C2=A0 ui/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A05 +-<br>
&gt; &gt;=C2=A0 49 files changed, 1014 insertions(+), 1098 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; 2.54.0<br>
&gt; &gt;<br>
&gt;<br>
</blockquote></div></div></div>

--000000000000fc637406529700dd--

