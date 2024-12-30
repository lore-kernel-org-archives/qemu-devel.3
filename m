Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F205E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 11:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSE3o-000177-2I; Mon, 30 Dec 2024 06:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tSE3l-00016S-Rq
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 06:35:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tSE3j-0007Jf-LP
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 06:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735558539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/hQjACM4WLBZPOjF5QpR1mPWczeKkS8vq7skZoLMOGY=;
 b=R6/u5EgqIDk/gTzmSboKm0leSh+bfbWopIta5hF36I8JAHzZ29/TBh2exZXD15YyjWE5Dy
 IcxXSCKVhFEPLnMHnoJxjWXgOL3kVbaswuW/oBbDkjOU1V3Q+Uk67c93EExn8HjgXu56MQ
 A8tCMsdquvlCbImDrgEMA4blAV8VjS8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-sRD71FViMtCrYrVGAHDgKg-1; Mon, 30 Dec 2024 06:35:35 -0500
X-MC-Unique: sRD71FViMtCrYrVGAHDgKg-1
X-Mimecast-MFC-AGG-ID: sRD71FViMtCrYrVGAHDgKg
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-467948b2902so191037871cf.1
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 03:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735558535; x=1736163335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/hQjACM4WLBZPOjF5QpR1mPWczeKkS8vq7skZoLMOGY=;
 b=sS16MMPSaO5vF+rjU04z/xQOjKPFl9G9U3zRLjnWWefkF/ucHILY3vA39NiN2Ugnec
 7Wq/xI4NRCprBEGhZ5BvjNVtBRi9anFeKLmyE4Yk1en8334zw1/Ni815TnbhCx+q9xuB
 NC3FVQir6GG8ppM5t7dON7DOc24jWhRxdkWC9v9qqYB5RoiQ0fS1Ou1jcffHxsosrA4L
 rvKpoG+El59nGdNYxzslxFIbiugob3CMDFwT63tY53NQ4BMwVjVSceEdZJUwc8cC8LYc
 9qrCN2vfiZ2d2UYPRzBogKlwkQ1eM6g9tFks0hMs1j+ixiPYXEblZ5mojTk9sGrzdI89
 9WTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwii3Cpxm71YQ1RSSEzkOr/z2Dnc6saUFZPGV5kODiERup+fKw7WSDR5fMKcRoOejh7XYv7YQG9KXU@nongnu.org
X-Gm-Message-State: AOJu0YwRSUJeBnJ8FkmuG0nBNn+s56d8F7s+VBs3GRLMpxB7/9K4WnfP
 Q6OpNcaSbBocOB5cYgY+Vr0VSaR9ZXI9nZ0v4+/z+iFgVhXykTOisNe+B4Jx2VRZrdtePnpCIFn
 mYGmPkxgB0FDxx20LZImvCO4OSo9Yr52hmXs4rsRKpAfoEiZkyREcY0xTbBRRpYibcyynU8LK1Y
 Eb2loAlZM3tzR1JtTx5n5VU2U9D2E=
X-Gm-Gg: ASbGnctCe8hd8eTsEmQaHB0vDiRhAf46bisFcULnOGSfr3I8Z4o7jTeHD/XFj5cllXT
 8amVK8LiEHMNt5di2BrCiISkKn+JobbGZO+Zn7zU=
X-Received: by 2002:ac8:5e12:0:b0:466:9ab3:c2c7 with SMTP id
 d75a77b69052e-46a4b13d766mr504629761cf.14.1735558535216; 
 Mon, 30 Dec 2024 03:35:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc+hrnb53OkFkXtnyvZH9rI1zTzOvt6dlaC8kdGonDExSyUFiwzA89N4MIfNUPh7kKTSI3zZ1eezInDyLISc8=
X-Received: by 2002:ac8:5e12:0:b0:466:9ab3:c2c7 with SMTP id
 d75a77b69052e-46a4b13d766mr504629591cf.14.1735558534892; Mon, 30 Dec 2024
 03:35:34 -0800 (PST)
MIME-Version: 1.0
References: <20241223132355.1417356-1-r.peniaev@gmail.com>
In-Reply-To: <20241223132355.1417356-1-r.peniaev@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Dec 2024 15:35:23 +0400
Message-ID: <CAMxuvawN_=oPYVy5ZkWV1q514ZXV-MHVoQvdExFAZ34_s4X2UA@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] chardev: implement backend chardev multiplexing
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.187,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Dec 23, 2024 at 5:29=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
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
>     -chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0 \
>     -chardev vc,id=3Dvc0 \
>     -chardev mux-be,id=3Dmux0,chardevs.0=3Dsock0,chardevs.1=3Dvc0 \
>     -device virtconsole,chardev=3Dmux0 \
>     -vnc 0.0.0.0:0
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
>     # Start TTY emulator
>     socat unix-connect:/tmp/sock pty,link=3D/tmp/pty & \
>     tio /tmp/pty
>
>     # Start VNC client and switch to virtual console Ctrl-Alt-2
>     vncviewer :0
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
> QAPI list sytax may help to smoothly switch to modern parsing in the
> future.
>

That looks like a good compromise to me, thanks. Markus, wdyt?

In your patches, please change version 9.3 for 10.0 (next release).

btw, for some reason your series is not caught by patchew or
patchwork.. it's a bit annoying

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
> Cc: qemu-devel@nongnu.org
>
> Roman Penyaev (8):
>   chardev/char: rename `MuxChardev` struct to `MuxFeChardev`
>   chardev/char: rename `char-mux.c` to `char-mux-fe.c`
>   chardev/char: move away mux suspend/resume calls
>   chardev/char: rename frontend mux calls
>   chardev/char: rename `bid` to `mux_fe_id`
>   chardev/char-mux: implement backend chardev multiplexing
>   tests/unit/test-char: add unit test for the `mux-be` multiplexer
>   qemu-options.hx: describe multiplexing of several backend devices
>
>  chardev/char-fe.c                     |  25 +-
>  chardev/char-mux-be.c                 | 321 ++++++++++++++++++++
>  chardev/{char-mux.c =3D> char-mux-fe.c} | 157 ++++------
>  chardev/char.c                        | 117 +++++++-
>  chardev/chardev-internal.h            |  59 +++-
>  chardev/meson.build                   |   3 +-
>  include/chardev/char.h                |   8 +-
>  qapi/char.json                        |  27 ++
>  qemu-options.hx                       |  48 ++-
>  system/vl.c                           |   4 +-
>  tests/unit/test-char.c                | 403 +++++++++++++++++++++++++-
>  11 files changed, 1023 insertions(+), 149 deletions(-)
>  create mode 100644 chardev/char-mux-be.c
>  rename chardev/{char-mux.c =3D> char-mux-fe.c} (71%)
>
> --
> 2.34.1
>


