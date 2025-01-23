Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C785C0218C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 08:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tasy0-0007aw-N5; Thu, 23 Jan 2025 03:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tasxy-0007ac-46
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 03:53:34 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tasxw-0000XF-5G
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 03:53:33 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d647d5df90so1197195a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 00:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737622410; x=1738227210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u3t9qYp7y9UIBPlzEdK41DDV4Og6cSGDhqy6Ti71kpE=;
 b=IlkgyjnkxJZYC+AxgwF98lXKNxW1u7tZING91dOM5DF/HBwmyMCoRd6JgTRYYjYOpy
 ATPFGZbbu77fsfWUUVY85U8Me2Vqz+twm1EAfGSgj6W57+QmbWsFBFZNvruEMCcyHhKz
 8xIJvuU1zcjIQ2E9lBcJIFS5SNKEOfb75eFHFJDykpQvelCzZCwf2sJND04JMnEirqQA
 g9f8YhdZs0k+xm6CfzdoLS2JoyCNto7aS/bc2cvpuXV5gCGz/SwySZPJRUi+xwu963lf
 yh7xqLWfDUh+S0Xc0llF6uGLt9G2hX0ldQrkyLKqzPIVnjGvwXqUiLCxQVr/lzFzuUdu
 GiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737622410; x=1738227210;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u3t9qYp7y9UIBPlzEdK41DDV4Og6cSGDhqy6Ti71kpE=;
 b=gYKDAFtXS+SpRaAWEZBuTNqM5k8sRhtqSdXhUnCybcTxps1xD34uX5wdktDhNAEaJU
 1+0gcdy5Yw31K5HPq1mw9J2O90OSODk1imLpGJFgFmn8G+KGdwEA79EjD/Sptj11jazV
 JdAKhhi93AE4yHVLF9OeGbLqKv+uz6pGzcpjtsjOTig8bGpuOE8GUEP0VF2LXr/qC+su
 QJ4FLZs8sPXgfrz4p9Lq7LSYQr8xD4tGzGA6drRkVNucrU4rsjKPgtkDXUvZoEg9d7Ch
 1J5rCXGFj3dkoFNLWUicwz60o5h1tCgdjrRJbLSAq93gvMb+sX6izKw+MauISMT0N/sI
 PtXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlBosBmzlbL28a36r9lxVAQudXIlLP7zr88NHtOUb6rXK33Azn8idbV5ghW+7+usvBS1Xtz0i2UyfN@nongnu.org
X-Gm-Message-State: AOJu0YypCORpUj4yr8AyJC+UqvPRlHYuatdDSVrPvVibRi7c6UnClypL
 tom/qETDe6AJ4a1Ra7Ij5B0cr6xTVqQKwkH5X/6BhvMewRucqlcz
X-Gm-Gg: ASbGncuNjNcjJkEp3MgmuZtHOXZ+ywLb/rGXSrvqZm+91GuL1gd8B+/lKxz9raBi2UG
 hRzjdEIvKItIq7nZ4FV8fiM5zz+lsZc9z+1B64zmlaFPHkIgCE8zEt8vNETmHFE7MPRwpvYAw3D
 s3a4yyeDNqR6sd5yRigtMxC0f/TDCJzNiGJu4kOU+lE0v4Ot03H3FaDkaFnsfg6vd1yh0NzJHNR
 i+GcLWQlJ3CV48tHTfCqxRuQG6T5d/eVv5XeVyeA+7GqGOoD8PYx7j8coqtMmQWjw8h272tojgp
 UjpQhoFZy9AqOSWoN7CbnE2h2mWw
X-Google-Smtp-Source: AGHT+IEIk2R6+3wvAC7UV7Ya95Fpb3bJJ0ig+uBm6mXi6ZXmIXh2Jiz3nCWmVdz8caU5xu2W28nuvQ==
X-Received: by 2002:a05:6402:2110:b0:5d3:ba42:ea03 with SMTP id
 4fb4d7f45d1cf-5db7d2f8135mr17874307a12.8.1737622410127; 
 Thu, 23 Jan 2025 00:53:30 -0800 (PST)
Received: from think.fkb.profitbricks.net
 ([2a02:8109:8384:1400:b763:14a0:8818:4012])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dbcfb8ff37sm4424676a12.72.2025.01.23.00.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 00:53:29 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v9 0/4] chardev: implement backend chardev multiplexing
Date: Thu, 23 Jan 2025 09:53:20 +0100
Message-ID: <20250123085327.965501-1-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x530.google.com
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

Mux is a character backend (host side) device, which multiplexes
multiple frontends with one backend device. The following is a
few lines from the QEMU manpage [1]:

  A multiplexer is a "1:N" device, and here the "1" end is your
  specified chardev backend, and the "N" end is the various parts
  of QEMU that can talk to a chardev.

But sadly multiple backends are not supported.

This work implements a new chardev backend `hub` device, which
aggregates input from multiple backend devices and forwards it to a
single frontend device. Additionally, `hub` device takes the output
from the frontend device and sends it back to all the connected
backend devices. This allows for seamless interaction between
different backend devices and a single frontend interface.

The motivation is the EVE project [2], where it would be very
convenient to have a virtio console frontend device on the guest that
can be controlled from multiple backend devices, namely VNC and local
TTY emulator. The following is an example of the QEMU command line:

    -chardev pty,path=/tmp/pty,id=pty0 \
    -chardev vc,id=vc0 \
    -chardev hub,id=hub0,chardevs.0=pty0,chardevs.1=vc0 \
    -device virtconsole,chardev=hub0 \
    -vnc 0.0.0.0:0

Which creates two backend devices:

* Text virtual console (`vc0`)
* A pseudo TTY (`pty0`) connected to the single virtio hvc console with the
  help of a new backend aggregator (`hub0`)

`vc0` renders text to an image, which can be shared over the VNC
protocol.  `pty0` is a pseudo TTY backend which provides bidirectional
communication to the virtio hvc console.

Once QEMU starts, the VNC client and any TTY emulator can be used to
control a single hvc console. For example, these two different
consoles should have similar input and output due to the buffer
aggregation:

    # Start TTY emulator
    tio /tmp/pty

    # Start VNC client and switch to virtual console Ctrl-Alt-2
    vncviewer :0

'chardevs.N' list syntax is used for the sake of compatibility with
the representation of JSON lists in 'key=val' pairs format of the
util/keyval.c, despite the fact that modern QAPI way of parsing,
namely qobject_input_visitor_new_str(), is not used. Choice of keeping
QAPI list syntax may help to smoothly switch to modern parsing in the
future.

v8 .. v9:

* Incorporate Reviewed-by tags

v7 .. v8:

* No need for a separate `->frontend` pointer in the hub device
  structure, use `hub->parent.fe` directly.
* Remove special handling of !EAGAIN error while serving write
  to all backends. This should be safe, because detached backends
  are handled by the `->be_open` flag check.
* Combine `hub_chr_write_to_all()` and `hub_chr_write()` calls.
* Fix docs generation: no single backtick, but double, so not
  a `hub` but ``hub`` in qemu-options.hx

v6 .. v7:

After discussing v6 it was decided to:

* Rename "multiplexer" to "aggregator"
* Rename "mux-be" device type to "hub"
* Drop all changes related to the original multiplexer implementation

Code changes:

* Added counting of CHR_EVENT_OPENED and CHR_EVENT_CLOSED events
coming from backend devices. This prevents frontend devices from
closing if one of the backend devices has been disconnected. The
logic is simple: "the last one turns off the light".

v5 .. v6:

* Rebased on latest master
* Changed how chardev is attached to a multiplexer: with version 6
mux should specify list elements with ID of chardevs:

    chardevs.0=ID[,chardevs.N=ID]

'chardevs.N' list syntax is used for the sake of compatibility with
the representation of JSON lists in 'key=val' pairs format of the
util/keyval.c, despite the fact that modern QAPI way of parsing,
namely qobject_input_visitor_new_str(), is not used. Choice of keeping
QAPI list syntax may help to smoothly switch to modern parsing in the
future.

v4 .. v5:

* Spelling fixes in qemu-options description
* Memory leaks fixes in mux-be tests
* Add sanity checks to chardev to avoid stacking of mux devices
* Add corresponding unit test case to cover the creation of stacked
  muxers: `-chardev mux-be,mux-id-be=ID`, which is forbidden
* Reflect the fact that stacking is not supported in the documentation

v3 .. v4:

* Rebase on latest chardev changes
* Add unit tests which test corner cases:
   * Inability to remove mux with active frontend
   * Inability to add more chardevs to a mux than `MUX_MAX`
   * Inability to mix mux-fe and mux-be for the same chardev

v2 .. v3:

* Split frontend and backend multiplexer implementations and
  move them to separate files: char-mux-fe.c and char-mux-be.c

v1 .. v2:

* Separate type for the backend multiplexer `mux-be`
* Handle EAGAIN on write to the backend device
* Support of watch of previously failed backend device
* Proper json support of the `mux-be-id` option
* Unit test for the `mux-be` multiplexer

[1] https://www.qemu.org/docs/master/system/qemu-manpage.html#hxtool-6
[2] https://github.com/lf-edge/eve

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Reviewed-by: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

Roman Penyaev (4):
  chardev/char-pty: send CHR_EVENT_CLOSED on disconnect
  chardev/char-hub: implement backend chardev aggregator
  tests/unit/test-char: add unit tests for hub chardev backend
  qemu-options.hx: describe hub chardev and aggregation of several
    backends

 chardev/char-hub.c         | 301 ++++++++++++++++++++++++++++
 chardev/char-pty.c         |   4 +-
 chardev/char.c             |  23 ++-
 chardev/chardev-internal.h |  51 ++++-
 chardev/meson.build        |   1 +
 include/chardev/char.h     |   1 +
 qapi/char.json             |  27 +++
 qemu-options.hx            |  49 ++++-
 tests/unit/test-char.c     | 398 +++++++++++++++++++++++++++++++++++++
 9 files changed, 847 insertions(+), 8 deletions(-)
 create mode 100644 chardev/char-hub.c

-- 
2.43.0


