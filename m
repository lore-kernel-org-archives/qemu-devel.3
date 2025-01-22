Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DF7C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taV6y-000065-DT; Wed, 22 Jan 2025 02:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1taV6T-0008VP-9H
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:24:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1taV6R-0002ny-9i
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737530681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=akIPPqBWM6Bq8GFy6oNtk9A07uf5S3nPnINB7ecrreE=;
 b=hBOMALx6khcbn5k4Ux3bSGnIJHnYPwChTS2xuoDAtYmsuFf8JdzCAt0VcrEJ4AybIi8g7j
 TtfhGwbzSosxRRtsts1b7Yi9LgN0tsrVbWzTlcACy0qWkaVQo1Xw+39o4tOckO1fEhj5CD
 25LFQnqOCz4Qcs8t6zIRXVUl5oj2pzY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-FYKz-9hrPsm43kN1946wcg-1; Wed, 22 Jan 2025 02:24:38 -0500
X-MC-Unique: FYKz-9hrPsm43kN1946wcg-1
X-Mimecast-MFC-AGG-ID: FYKz-9hrPsm43kN1946wcg
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-467975eabdaso9658391cf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 23:24:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737530678; x=1738135478;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=akIPPqBWM6Bq8GFy6oNtk9A07uf5S3nPnINB7ecrreE=;
 b=ndd6VTWQb3wOal4OKLLGP1qZmZ0NNBNSUt38xGvx7zgjoqNJWliNcTfmI+MKvZTzuD
 PmqgP+8X2yUeygQEd+QIpgnKIXeQxlgo1LoKEVAJFCx6/ePaWU/bitZLkN3SsE/+8xNQ
 lLd2dRj7WSpFlV8PPf8VzOZ+alSeKBByXPDFYtVoGHBYBVsakfmR5Yln20owHM7KKACf
 L6PDJcYWaPg7PAUT8razfA6fNdH5Rk4VgA+H5PBqOPWd5lsRnuge6Cl0bYj0ByCmWPQm
 YrVOdeu+trYN7JqdT4PLXy5FyZxDu/LmGJqyDW/6dW2rLPNBP1Mnmdp7xGvlM4jdyQ9S
 0PeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ2Rz4c84EbuEbQFipYFzvtIhc0yr707Cr5MXDFadkkjrMykCVLsexWyFk8NDM0sFYd3/1vzX3u5sE@nongnu.org
X-Gm-Message-State: AOJu0YxeaFp+YJsPuEEMo8ZNOkbDRTLBjS/sNVSWvXFbgJ58rUy+73Pb
 jiy77j4MJzdAmmm2EOqkQrI8Dtw17UQxslQdOb+lRYXy1Na/6pi0zM3JdGbsNArO+CDIHkLzspg
 T7wrkyGqq7O8MjDEI5aoyrHmmASBSsGjdHwdnS89mCu1xdByvG5ZFUYclBRIPhgi2nrkG+xHt2E
 FZAtG+6ls1fP+cmmH1w7bdmumteBI=
X-Gm-Gg: ASbGncu13vJXOvGyGqH38vO0Jv1matjrTOI9wPmJAnE2iwFzlrKhTMMKR0e8ZgXikou
 ZFzrnXVthnbnxfadlqxEI6IhRWMJF/ztv59A4i07iykwmX+ReOvVWTT51MMzvE6lWeCnquDA6fp
 A9D9eQZ7+g
X-Received: by 2002:a05:622a:148b:b0:462:ea1d:9e2 with SMTP id
 d75a77b69052e-46df579741bmr443078611cf.16.1737530678059; 
 Tue, 21 Jan 2025 23:24:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu3ZjZKXQ9yXV6xtCqGb4fFkPuk+rkXpXjEudMF9/9xHVfRbr0pb+z3CpvUl1AdMh6TqwJIQhX6V4Z/vc9USg=
X-Received: by 2002:a05:622a:148b:b0:462:ea1d:9e2 with SMTP id
 d75a77b69052e-46df579741bmr443078391cf.16.1737530677714; Tue, 21 Jan 2025
 23:24:37 -0800 (PST)
MIME-Version: 1.0
References: <20250121184746.920841-1-r.peniaev@gmail.com>
In-Reply-To: <20250121184746.920841-1-r.peniaev@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 22 Jan 2025 11:24:26 +0400
X-Gm-Features: AbW1kvZnv9MngMrgK8K2ORTLFkOnh_FDUHR8bxomQmUAIok_QXH4HRHhlINurec
Message-ID: <CAMxuvazsif1AWMTT_Wcm5oPBDnzEd-XkU6wAj4htu1WYaJq6jQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] chardev: implement backend chardev multiplexing
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Tue, Jan 21, 2025 at 10:47=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com=
> wrote:
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
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Cc: qemu-devel@nongnu.org

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
>  qemu-options.hx            |  48 ++++-
>  tests/unit/test-char.c     | 398 +++++++++++++++++++++++++++++++++++++
>  9 files changed, 846 insertions(+), 8 deletions(-)
>  create mode 100644 chardev/char-hub.c
>
> --
> 2.43.0
>


