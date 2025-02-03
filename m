Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F2AC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 09:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tesPo-0002fG-7W; Mon, 03 Feb 2025 04:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tesPm-0002f2-Cz
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 04:06:46 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tesPi-0005qi-FG
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 04:06:44 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-30797730cbdso42785371fa.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 01:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738573600; x=1739178400; darn=nongnu.org;
 h=content-transfer-encoding:cc:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jtwq3llZmXYWtqM2FFd5+0UU5eIPPdb5GDBAzqSTPOU=;
 b=FbO4nSt7A0RfuYCHf5aklhh8fOv9pqgx4HwhJzIAFsPdLnGHbKONdMJO2itJ7mQ+ng
 CzRJjI2avtSm+nbLjNsF6HTcNUVr8s4rUc+qpXFGkAirsyrqTcL9kll1vqJftFpcuMUk
 JkouG6jqcUGbEbfOIR+eedi3HMapoOAKyX/G2n15Ox5xVuRhF0BC85MGX8TOqgJhQd3U
 a6mLBLX0WYdPx/tAOfLVUXMsHpUY9LpD+c1MncZJ6+jHITzgUWhHNJNJJxL/vkLIMnA1
 cdg9Z8JfTxemYr8A3Zmnr3YTWYW9a/Dc9WcT3agnex//u2wmoaOWDxqAKoDFGN5S+iJQ
 TWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738573600; x=1739178400;
 h=content-transfer-encoding:cc:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jtwq3llZmXYWtqM2FFd5+0UU5eIPPdb5GDBAzqSTPOU=;
 b=Y9z5aWi1mRJ+rrAg0XWCasQ1Gd3hxpXbniAXXBCpUCbYVwYh6ovhguS+xgv8i2hdgo
 Ik1HgI803mtklz8AQlMXbJf9WagAMhR9FqksPrvZNO2nWr/v/9mYpPtNX4fRnF+trj0b
 RYXBBdeDAOjkSf0t2I5/djXRuKXhp5/IE6X4zz0vXoHu/KOPY8Bq4/A7eTrT/l3A7tX0
 4zocF8FC1Nzdr5y05saT1BGqlCEd+cEIP+bz9/oXi20xMDF3p2yrSKx5Y3l1ZRRV0vr1
 fRGqlO030BoHgW8YYVgGwVFNN8gQdV2VDWho144ycDHPUzKOf1SxaDG6cWYgiNtn1IlW
 Ok3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvbJLZfx9X79ZzuHB5g96dye7BKNuF1Cp7xTNfXCa68fazZuunV2F3YRYUoABVk4OvsVNl6TTQjoXp@nongnu.org
X-Gm-Message-State: AOJu0YyFgk49pGJi4Tt39rqIV0bnA4+5w6y8ASI9TCwdAITuo/cKAdjQ
 o2O660ngtFDaG0JOJSyX+Om0m4ROiGPiEMBdkx44toGelsNJfe/+eH03dRGZprkday0R1tatKw9
 WVyLkdL0XPNpIWgbOc9FmqsOJXcE=
X-Gm-Gg: ASbGncsYDxEboF36jEZr0Ibp+9ySQOsOrvAF7cM3qYak5WrODO/9FOf9U1li/7uH3vj
 EvDAzEPssQ4XOhJN0ayhkhoWz1f0GfnK3tkhalpvyukhwKm8kZtZtYYL87QelycUjp9DLQtRk
X-Received: by 2002:a2e:be8e:0:b0:300:41a8:125b with SMTP id
 38308e7fff4ca-307968ea19dmt68614731fa.37.1738573599415; Mon, 03 Feb 2025
 01:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20250123085327.965501-1-r.peniaev@gmail.com>
In-Reply-To: <20250123085327.965501-1-r.peniaev@gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Mon, 3 Feb 2025 10:06:28 +0100
X-Gm-Features: AWEUYZl8snYeHZJhpvQPBH2NRFGceFWi2PC5GGzvSFVkFQDOcMlkseOCSmc_KrU
Message-ID: <CACZ9PQXCHyt5pmLAkuh0M6dNnZFP7fQ4vx3VZWtYss1k+oGTUA@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] chardev: implement backend chardev multiplexing
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Marc-Andre,

Do you plan to pull the latest version of this series,
or is there something which I have to address?
Please let me know.

Thanks.

--
Roman

On Thu, Jan 23, 2025 at 9:53=E2=80=AFAM Roman Penyaev <r.peniaev@gmail.com>=
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
> This work implements a new chardev backend `hub` device, which
> aggregates input from multiple backend devices and forwards it to a
> single frontend device. Additionally, `hub` device takes the output
> from the frontend device and sends it back to all the connected
> backend devices. This allows for seamless interaction between
> different backend devices and a single frontend interface.
>
> The motivation is the EVE project [2], where it would be very
> convenient to have a virtio console frontend device on the guest that
> can be controlled from multiple backend devices, namely VNC and local
> TTY emulator. The following is an example of the QEMU command line:
>
>     -chardev pty,path=3D/tmp/pty,id=3Dpty0 \
>     -chardev vc,id=3Dvc0 \
>     -chardev hub,id=3Dhub0,chardevs.0=3Dpty0,chardevs.1=3Dvc0 \
>     -device virtconsole,chardev=3Dhub0 \
>     -vnc 0.0.0.0:0
>
> Which creates two backend devices:
>
> * Text virtual console (`vc0`)
> * A pseudo TTY (`pty0`) connected to the single virtio hvc console with t=
he
>   help of a new backend aggregator (`hub0`)
>
> `vc0` renders text to an image, which can be shared over the VNC
> protocol.  `pty0` is a pseudo TTY backend which provides bidirectional
> communication to the virtio hvc console.
>
> Once QEMU starts, the VNC client and any TTY emulator can be used to
> control a single hvc console. For example, these two different
> consoles should have similar input and output due to the buffer
> aggregation:
>
>     # Start TTY emulator
>     tio /tmp/pty
>
>     # Start VNC client and switch to virtual console Ctrl-Alt-2
>     vncviewer :0
>
> 'chardevs.N' list syntax is used for the sake of compatibility with
> the representation of JSON lists in 'key=3Dval' pairs format of the
> util/keyval.c, despite the fact that modern QAPI way of parsing,
> namely qobject_input_visitor_new_str(), is not used. Choice of keeping
> QAPI list syntax may help to smoothly switch to modern parsing in the
> future.
>
> v8 .. v9:
>
> * Incorporate Reviewed-by tags
>
> v7 .. v8:
>
> * No need for a separate `->frontend` pointer in the hub device
>   structure, use `hub->parent.fe` directly.
> * Remove special handling of !EAGAIN error while serving write
>   to all backends. This should be safe, because detached backends
>   are handled by the `->be_open` flag check.
> * Combine `hub_chr_write_to_all()` and `hub_chr_write()` calls.
> * Fix docs generation: no single backtick, but double, so not
>   a `hub` but ``hub`` in qemu-options.hx
>
> v6 .. v7:
>
> After discussing v6 it was decided to:
>
> * Rename "multiplexer" to "aggregator"
> * Rename "mux-be" device type to "hub"
> * Drop all changes related to the original multiplexer implementation
>
> Code changes:
>
> * Added counting of CHR_EVENT_OPENED and CHR_EVENT_CLOSED events
> coming from backend devices. This prevents frontend devices from
> closing if one of the backend devices has been disconnected. The
> logic is simple: "the last one turns off the light".
>
> v5 .. v6:
>
> * Rebased on latest master
> * Changed how chardev is attached to a multiplexer: with version 6
> mux should specify list elements with ID of chardevs:
>
>     chardevs.0=3DID[,chardevs.N=3DID]
>
> 'chardevs.N' list syntax is used for the sake of compatibility with
> the representation of JSON lists in 'key=3Dval' pairs format of the
> util/keyval.c, despite the fact that modern QAPI way of parsing,
> namely qobject_input_visitor_new_str(), is not used. Choice of keeping
> QAPI list syntax may help to smoothly switch to modern parsing in the
> future.
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
> Reviewed-by: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Cc: qemu-devel@nongnu.org
>
> Roman Penyaev (4):
>   chardev/char-pty: send CHR_EVENT_CLOSED on disconnect
>   chardev/char-hub: implement backend chardev aggregator
>   tests/unit/test-char: add unit tests for hub chardev backend
>   qemu-options.hx: describe hub chardev and aggregation of several
>     backends
>
>  chardev/char-hub.c         | 301 ++++++++++++++++++++++++++++
>  chardev/char-pty.c         |   4 +-
>  chardev/char.c             |  23 ++-
>  chardev/chardev-internal.h |  51 ++++-
>  chardev/meson.build        |   1 +
>  include/chardev/char.h     |   1 +
>  qapi/char.json             |  27 +++
>  qemu-options.hx            |  49 ++++-
>  tests/unit/test-char.c     | 398 +++++++++++++++++++++++++++++++++++++
>  9 files changed, 847 insertions(+), 8 deletions(-)
>  create mode 100644 chardev/char-hub.c
>
> --
> 2.43.0
>

