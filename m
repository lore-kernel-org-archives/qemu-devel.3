Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFDEC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFmC-0007hk-Es; Tue, 21 Jan 2025 10:02:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taFm8-0007hA-8L
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:02:45 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taFm6-0001WO-8A
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:02:43 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so41891875e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737471759; x=1738076559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A7w673tlZQfkr/HNxvVK7ieg4FOGYQ9t1wSf5nTnNkY=;
 b=qclwW+n6PDlg60lXlGJFTmVvWwlaUMSMYK2KwJt9t1fyFum/YMkqJVYhOz+rMwFij6
 8mmMG8Hz3KmHVZlwctly/a7QdmC0T4Xb0gKnxWwwR6dvYKHrY5Q07JBdMNBdClE5Ia6t
 VTbsmP3piqvPGITEQyD/mnCpTbb4IZ1UAb+eU1fyv/XMSSk78Kj9L1TClvJigIuyzsJh
 vvRDGpGMGHztcmgWDlQ83QmOXJSaYvK7rav/GMQRc1mgSOXh4IkcTz4kNmZ2GqE/DDv2
 OHe7EbdwMMtORznyN2yp3WhFJd5g494845IiH8q5KC/uk088H6gOhBR+rVpX6A8hBR2y
 5GSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737471759; x=1738076559;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A7w673tlZQfkr/HNxvVK7ieg4FOGYQ9t1wSf5nTnNkY=;
 b=aO2LJi1wo2ttuc2CU4xn038be9BAjg8xg90DOO2j6a3ETyRVC2sY3lRQ3iY7H4PX/I
 FVtt1N+YTN2DLYbXs2EJi+zW4i4omye4WvFvbsLemzewfgJgL1aA+rtSWXnJtMj0tb4j
 F0bU4nZnGTGyC3EUI7SiwfS1u8T9+M+KYjosNegsmeDZoCZnwUx0lauq+kWXpuVWOT/z
 NU20OmobVBSUshyPO0JUj12cNHHDmcIee1amSJIXVSZaW/VgmUONsmCCkA9kf6aNb8Y2
 E2/iSp9KILcyZEp0u7NNDEnVSeJFzmKGiAz+l3UV6+AXY+1JmwZLaNzUPX15+Peie8c3
 AwHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFW3sA1Ir657qo6I7JS3S/KCIiSuLVk7V8oPqZvPYT6Vd1HdVKvW+W9xJFZDbHC6U8gKFdbMdJu/1o@nongnu.org
X-Gm-Message-State: AOJu0YzCqkiTtj7rkRT6+/oU+VDH21F1D4YUpI8qs6uf7eqX12wliHoP
 VFGorlbCr50osE0IyB6/2kZKO28DQFGPsYKIuVn2yGhBf9PE5dzCFyhtQODZiNU=
X-Gm-Gg: ASbGncuhNFkPv1I43p6fAw2qxkpk2pZSiv061Hig421JMs/ni5tRrwsdP2pnVWhPDAi
 KdiS2xycxjQSOsWBMFLPWUNdNv8MpklEa1KQPaaOT8zL1HwAsdB4cK+kvC0zlOn+y6hP6il2nF5
 Mogh/18pf7GK+Pq6LTR55EMzYEDMdOG6WzmchW/a/Sr/XYpD4+kIy8pd6S4c5KXffe0UQq3CtV+
 hBwEDvWVkYJnXdpSVGLnMEf+vAyZY7GNTHyDw5MoOssCmhLFQfjy7yCI0VuJ7XDhzLe
X-Google-Smtp-Source: AGHT+IGjZHxwUOi4iIsc046yKzlnIDplTAhzNFFPU1tpqCYUMCJ2FUfbgbwBULHuanHOX0jw/p0ylQ==
X-Received: by 2002:a05:600c:3484:b0:434:f8e5:1bb with SMTP id
 5b1f17b1804b1-438913e48fdmr169697155e9.12.1737471757864; 
 Tue, 21 Jan 2025 07:02:37 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf321508esm13811699f8f.10.2025.01.21.07.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 07:02:37 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 48D2C5F756;
 Tue, 21 Jan 2025 15:02:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v7 4/4] qemu-options.hx: describe hub chardev and
 aggregation of several backends
In-Reply-To: <20250118164056.830721-5-r.peniaev@gmail.com> (Roman Penyaev's
 message of "Sat, 18 Jan 2025 17:40:52 +0100")
References: <20250118164056.830721-1-r.peniaev@gmail.com>
 <20250118164056.830721-5-r.peniaev@gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 21 Jan 2025 15:02:36 +0000
Message-ID: <87wmeonrar.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Roman Penyaev <r.peniaev@gmail.com> writes:

> This adds a few lines describing `hub` aggregator configuration
> for aggregation of several backend devices with a single frontend
> device.
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  qemu-options.hx | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 7090d59f6f10..fdc46f7e68b3 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3720,7 +3720,7 @@ SRST
>  The general form of a character device option is:
>=20=20
>  ``-chardev backend,id=3Did[,mux=3Don|off][,options]``
> -    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``,
> +    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``, ``hub=
``,
>      ``vc``, ``ringbuf``, ``file``, ``pipe``, ``console``, ``serial``,
>      ``pty``, ``stdio``, ``braille``, ``parallel``,
>      ``spicevmc``, ``spiceport``. The specific backend will determine the
> @@ -3777,9 +3777,10 @@ The general form of a character device option is:
>      the QEMU monitor, and ``-nographic`` also multiplexes the console
>      and the monitor to stdio.
>=20=20
> -    There is currently no support for multiplexing in the other
> -    direction (where a single QEMU front end takes input and output from
> -    multiple chardevs).
> +    If you need to aggregate data in the opposite direction (where one
> +    QEMU frontend interface receives input and output from multiple
> +    backend chardev devices), please refer to the paragraph below
> +    regarding chardev ``hub`` aggregator device configuration.
>=20=20
>      Every backend supports the ``logfile`` option, which supplies the
>      path to a file to record all data transmitted via the backend. The
> @@ -3879,6 +3880,45 @@ The available backends are:
>      Forward QEMU's emulated msmouse events to the guest. ``msmouse``
>      does not take any options.
>=20=20
> +``-chardev hub,id=3Did,chardevs.0=3Did[,chardevs.N=3Did]`` Explicitly cr=
eate
> +    chardev backend hub device with the possibility to aggregate input
> +    from multiple backend devices and forward it to a single frontend
> +    device. Additionally, `hub` device takes the output from the
> +    frontend device and sends it back to all the connected backend
> +    devices. This allows for seamless interaction between different
> +    backend devices and a single frontend interface. Aggregation
> +    supported for up to 4 chardev devices. (Since 10.0)
> +
> +    For example, the following is a use case of 2 backend devices:
> +    virtual console ``vc0`` and a pseudo TTY ``pty0`` connected to
> +    a single virtio hvc console frontend device with a hub ``hub0``
> +    help. Virtual console renders text to an image, which can be
> +    shared over the VNC protocol. In turn, pty backend provides
> +    bidirectional communication to the virtio hvc console over the
> +    pseudo TTY file. The example configuration can be as follows:
> +
> +    ::
> +
> +       -chardev pty,path=3D/tmp/pty,id=3Dpty0 \
> +       -chardev vc,id=3Dvc0 \
> +       -chardev hub,id=3Dhub0,chardevs.0=3Dpty0,chardevs.1=3Dvc0 \
> +       -device virtconsole,chardev=3Dhub0 \
> +       -vnc 0.0.0.0:0
> +
> +    Once QEMU starts VNC client and any TTY emulator can be used to
> +    control a single hvc console:
> +
> +    ::
> +
> +       # Start TTY emulator
> +       tio /tmp/pty
> +
> +       # Start VNC client and switch to virtual console Ctrl-Alt-2
> +       vncviewer :0
> +
> +    Several frontend devices is not supported. Stacking of multiplexers
> +    and hub devices is not supported as well.
> +

Not sure why this breaks but I'm seeing:

  FAILED: docs/docs.stamp=20
  /usr/bin/env CONFDIR=3Detc/qemu /home/alex/lsrc/qemu.git/builds/all/pyven=
v/bin/sphinx-build -q -W -Dkerneldoc_werror=3D1 -j auto -Dversion=3D9.2.50 =
-Drelease=3D -Ddepfile=3Ddocs/docs.d -Ddepfile_stamp=3Ddocs/docs.stamp -b h=
tml -d /home/alex/lsrc/qemu.git/builds/all/docs/manual.p /home/alex/lsrc/qe=
mu.git/docs /home/alex/lsrc/qemu.git/builds/all/docs/manual

  Warning, treated as error:
  /home/alex/lsrc/qemu.git/qemu-options.hx:3884:'any' reference target not =
found: hub


>  ``-chardev vc,id=3Did[[,width=3Dwidth][,height=3Dheight]][[,cols=3Dcols]=
[,rows=3Drows]]``
>      Connect to a QEMU text console. ``vc`` may optionally be given a
>      specific size.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

