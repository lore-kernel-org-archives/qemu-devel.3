Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C6DE68974
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 11:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6T5f-0005Q6-BM; Thu, 31 Oct 2024 07:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t6T5S-0005Kr-Me
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 07:11:34 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t6T5Q-0003Yv-NW
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 07:11:34 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539f4d8ef84so1028763e87.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 04:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730373090; x=1730977890; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Akj3cIQJJohptA+ixAnzPlQ1QYu7yfnHtV2Ht8J8iDI=;
 b=U1qNDvV9YdDIMB6XQKHZ/cIGmr3quFdVAgG1GQ/fX8mKJzqzAOpUy/zKLWg+5M5dTE
 8o87dBzACYZ3Z50Y03O23Z9kX5tFVaJz3z1QbWBhl+K2V8V5MOcScWKddyaLCzbydy+a
 Df41zRd6+zVeafjwFMpPpgiNaI2u9VF30ZH7yfzKq7PKBTHpI+73HUQpo0nkI4GEqIye
 kS3RrFtUJFpmdOPI3b0HnYA4Y58HYXMUio+f/o6K2iQLp98TRrWRAZ4lIXzf+jqe9dej
 DB8ReDG3DFHPp2TXa9hZOKrECCzIlExh9SPOsKF5H0/AP+GL1HuHJBieTmRHMkyVri7g
 mFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730373090; x=1730977890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Akj3cIQJJohptA+ixAnzPlQ1QYu7yfnHtV2Ht8J8iDI=;
 b=e9T2eoqiIbS/mspIyK7Qt/oxf0NnUimH3d2qW7Nb1sikfX4VLw7jBJaU365PCTZg1I
 jD0rGEUuV/quq83GFiT69J6rYOGG571enk8RIoEmEuHwy6IL/unwNsnI7vvFdf9w8aI7
 6g0SxaRviS9bqqiT2lBGeO2m6tkl06wANKyHuop57xgZDCuNxCSPQwhi8yttmfjcppaq
 VKOf2gFn0ih9cOwg5lCqiFrm7z8ZCnJlkUK015GvFb2of0XOCG5sWUIsNcTGD9FmmuyN
 TBc8noA/zKp6OFqnzXUrOUHPjRHHVCfa38vfZw9PlahMuzgawmum7crr2/7mjJmB/+sI
 wB4Q==
X-Gm-Message-State: AOJu0YxdR6rdc5dMQpfgD8Md/wdedsiaoek0FVfTiwnHFIHYHR1D7nXj
 gQXpZWJXCGHwMCOyzOqwRhfIP5xDAzeGRH9CRQ+rUginzrhhSnldsnLlVfsu+8C+iihFWXMw1IE
 ICvggkPJ9FAnfVzLhcqVf8ghxxAkeAylHLlg0jA==
X-Google-Smtp-Source: AGHT+IFjoqVXZ62UiELHx3A+tPelEZcM0FUxLXVgEhM4oidJkCbZ/llZssjiQZCwVEGBASLhXcRoXNxQ+K/oiVdJug8=
X-Received: by 2002:a05:6512:138e:b0:536:53f0:2f8e with SMTP id
 2adb3069b0e04-53c79e8ecbdmr1337539e87.37.1730373090124; Thu, 31 Oct 2024
 04:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20241017144316.517709-1-r.peniaev@gmail.com>
In-Reply-To: <20241017144316.517709-1-r.peniaev@gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Thu, 31 Oct 2024 12:09:09 +0100
Message-ID: <CACZ9PQXT9xxuX40u_4J22d66hP73x4r8gUunPsMzhMS=MMTn9Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] chardev: implement backend chardev multiplexing
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x12b.google.com
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

Hi Marc-Andr=C3=A9,

In this 5th version of the mux-be series it seems I addressed all the
comments and concerns. Could you please take a look once again?

--
Roman

On Thu, Oct 17, 2024 at 4:45=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
 wrote:
>
> Mux is a character backend (host side) device, which multiplexes
> multiple frontends with one backend device. The following is a
> few lines from the QEMU manpage [1]:
>
>   A multiplexer is a "1:N" device, and here the "1" end is your
>   specified chardev backend, and the "N" end is the various parts
>   of QEMU that can talk to a chardev.
>
> But sadly multiple backends are not supported.
>
> This work implements multiplexing capability of several backend
> devices, which opens up an opportunity to use a single frontend
> device on the guest, which can be manipulated from several
> backend devices.
>
> The motivation is the EVE project [2], where it would be very
> convenient to have a virtio console frontend device on the guest that
> can be controlled from multiple backend devices, namely VNC and local
> TTY emulator. The following is an example of the QEMU command line:
>
>    -chardev mux-be,id=3Dmux0 \
>    -chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0,mux=
-be-id=3Dmux0 \
>    -chardev vc,id=3Dvc0,mux-be-id=3Dmux0 \
>    -device virtconsole,chardev=3Dmux0 \
>    -vnc 0.0.0.0:0
>
> Which creates two backend devices:
>
> * Text virtual console (`vc0`)
> * A socket (`sock0`) connected to the single virtio hvc console with the
>   help of the backend multiplexer (`mux0`)
>
> `vc0` renders text to an image, which can be shared over the VNC protocol=
.
> `sock0` is a socket backend which provides bidirectional communication to
> the virtio hvc console.
>
> Once QEMU starts, the VNC client and any TTY emulator can be used to
> control a single hvc console. For example, these two different
> consoles should have similar input and output due to the buffer
> multiplexing:
>
>    # VNC client
>    vncviewer :0
>
>    # TTY emulator
>    socat unix-connect:/tmp/sock pty,link=3D/tmp/pty
>    tio /tmp/pty
>
> v4 .. v5:
>
> * Spelling fixes in qemu-options description
> * Memory leaks fixes in mux-be tests
> * Add sanity checks to chardev to avoid stacking of mux devices
> * Add corresponding unit test case to cover the creation of stacked
>   muxers: `-chardev mux-be,mux-id-be=3DID`, which is forbidden
> * Reflect the fact that stacking is not supported in the documentation
>
> v3 .. v4:
>
> * Rebase on latest chardev changes
> * Add unit tests which test corner cases:
>    * Inability to remove mux with active frontend
>    * Inability to add more chardevs to a mux than `MUX_MAX`
>    * Inability to mix mux-fe and mux-be for the same chardev
>
> v2 .. v3:
>
> * Split frontend and backend multiplexer implementations and
>   move them to separate files: char-mux-fe.c and char-mux-be.c
>
> v1 .. v2:
>
> * Separate type for the backend multiplexer `mux-be`
> * Handle EAGAIN on write to the backend device
> * Support of watch of previously failed backend device
> * Proper json support of the `mux-be-id` option
> * Unit test for the `mux-be` multiplexer
>
> [1] https://www.qemu.org/docs/master/system/qemu-manpage.html#hxtool-6
> [2] https://github.com/lf-edge/eve
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: qemu-devel@nongnu.org
>
> Roman Penyaev (8):
>   chardev/char: rename `MuxChardev` struct to `MuxFeChardev`
>   chardev/char: rename `char-mux.c` to `char-mux-fe.c`
>   chardev/char: move away mux suspend/resume calls
>   chardev/char: rename frontend mux calls
>   chardev/char: introduce `mux-be-id=3DID` option
>   chardev/char-mux: implement backend chardev multiplexing
>   tests/unit/test-char: add unit test for the `mux-be` multiplexer
>   qemu-options.hx: describe multiplexing of several backend devices
>
>  chardev/char-fe.c                     |  25 +-
>  chardev/char-mux-be.c                 | 290 +++++++++++++++++++++++
>  chardev/{char-mux.c =3D> char-mux-fe.c} | 157 ++++---------
>  chardev/char.c                        | 139 +++++++++--
>  chardev/chardev-internal.h            |  55 ++++-
>  chardev/meson.build                   |   3 +-
>  include/chardev/char.h                |   8 +-
>  qapi/char.json                        |  31 ++-
>  qemu-options.hx                       |  80 +++++--
>  system/vl.c                           |   4 +-
>  tests/unit/test-char.c                | 323 +++++++++++++++++++++++++-
>  11 files changed, 947 insertions(+), 168 deletions(-)
>  create mode 100644 chardev/char-mux-be.c
>  rename chardev/{char-mux.c =3D> char-mux-fe.c} (71%)
>
> --
> 2.34.1
>

