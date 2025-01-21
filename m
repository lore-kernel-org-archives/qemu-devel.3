Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BE7C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taJIs-0003ZR-K8; Tue, 21 Jan 2025 13:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1taJI9-00036f-Aw
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:48:10 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1taJI2-000557-3i
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:47:58 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab2aea81cd8so1012577166b.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737485268; x=1738090068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JWvBODdmVz7r2kwSa+IEyaWfmbbqsXUrE/btmahSrog=;
 b=Z1oyXtmOega0EwsSjCW8XctMMP9KjKxZCNJuiqvK14BTqjHdGKtSeRRfPY7DWOMoNK
 h0MvP+t39G4zi49p+3Q6qkU49aC5T20Rg7/1/tozH7tKhfUNxAf5GqKE8Zixgz5owxX5
 WynXDpXJsXkIT2tXE2z02yyN4ew4xayEBLftel/xecK6+hhOJJHTOUi34wr9z7Tvpkri
 MoLVUCggwz373Z2y2OnFv2agPtUPEkUb+V2YVALFNH5NbJ3TnP9oc+QPfERJsG1DEioc
 k5Cm4FuEZ1Quqz+bEYUeTwJa2zlOMYYQFhiF3ej8WzCUCJiST32RV1HqBSWt7NY5ZQe5
 1OFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737485268; x=1738090068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JWvBODdmVz7r2kwSa+IEyaWfmbbqsXUrE/btmahSrog=;
 b=A/A0P9z9OtNBqSOZHRTRPfvWilao5oLRticD1ydyancwAqUPJGOBAWAQ7RazfFJNQl
 QvVLSvlP0jWJaLFNIotFXnb8eR0Ij04LWGEKg5SMHSBuDSs/H9w+/N3/u/9drO+VJsUL
 qZZq0WsSLOvOU9Ic3275vUTZhozGIzzydfpoZHsdo62NaO0kzqpulFFvKxbEjRwHJ/2k
 UHH6ihMqaduFRgrkP3R9fOktgGiYlrKWDYsgRNbyaByQJ0CdODvkpJJCpF+AYQCyp09J
 5powHrw0an8DLhUuBAE06q3X48bn7pIU7q7hwMHH0E/USyp6ZVEitNZqUOWiLMDmNN61
 BmlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYoYBPmbqSoxj+LPbacnBV+HATAqGHMOBW1zJiTvmQiGiV1/rldyI9m5sMlt7yCOZtL7UWHP/qYGWi@nongnu.org
X-Gm-Message-State: AOJu0Yyh43BYcrMQ6iIVAwCJVrOBx583Vqh1jZp74e9OYTneifl1SHpO
 eUFf+Su8tOnzTmtX5Nvuz1NP3xgaK8sj2Y5sF79xJsUUCa54WinkODejQtB4
X-Gm-Gg: ASbGncvvZKnYrNa4oaCxce+ktHxeRcc6zhywaKp+AiI77EYvXw+e0f75IrOl52DVq3t
 tBWOTRnMjnod7ex0Itjc6u38cmGAEWm26RgL5/OJqOnOv+MgeOU9Kk+bgPmRCnvG4jKPfb7fhBu
 VdXlcL/edyjxSRkOPoxji/m3IyWKdxM65ovxAvrUY+1jt0D997n/abcIj75frkQdFvp6IfplCyp
 LbLkTDvka2YH7Yrb2sIWuiYWTIRJsLkhhwHwJSSIiKW2ByKBFe+sNQhCXedJNihHmnKeNHn4Ts=
X-Google-Smtp-Source: AGHT+IF2LcdgyRlgk6Qv2x+Xn8DTOiJXA4ziIylrsKWbHjSym9MazLN/SbarBTxmaqgzePJKm5bYsw==
X-Received: by 2002:a17:907:1ca8:b0:aaf:ab71:bf79 with SMTP id
 a640c23a62f3a-ab38b11281cmr1533526766b.19.1737485268052; 
 Tue, 21 Jan 2025 10:47:48 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:381c:a1:b53:524d])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f223e7sm785745166b.111.2025.01.21.10.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 10:47:47 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v8 0/4] chardev: implement backend chardev multiplexing
Date: Tue, 21 Jan 2025 19:47:40 +0100
Message-ID: <20250121184746.920841-1-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x62f.google.com
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
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
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
 qemu-options.hx            |  48 ++++-
 tests/unit/test-char.c     | 398 +++++++++++++++++++++++++++++++++++++
 9 files changed, 846 insertions(+), 8 deletions(-)
 create mode 100644 chardev/char-hub.c

-- 
2.43.0


