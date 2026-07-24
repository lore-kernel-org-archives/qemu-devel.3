Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE55EC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnB82-0002Md-57; Fri, 24 Jul 2026 04:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilya.chichkov.dev@gmail.com>)
 id 1wnB81-0002Ki-3C
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:19:33 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilya.chichkov.dev@gmail.com>)
 id 1wnB7z-000196-2j
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:19:32 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-69e8ea2783aso194006a12.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 01:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784881169; cv=none;
 d=google.com; s=arc-20260327;
 b=WTKtO7iwhtEfn0LZw6U4bDLvArcn5lfM84X7o0njIqFuWzhIJFBo/1wILSdiat0bPn
 cZ2T4hssc0dwRbORAHelFA5+p4lMJBEAg+ybNqedhErQ1bPoQC+Ferh0Dh760T4ejUWf
 hNiyGJALQj7pRoIS3UeizBKyR6j6ECqEYvTNp/bNcs1ozb6clh5/Z0gtiMEMLqk7Xj/3
 xJNu4fC13mbqhmp9FrA26V71ddR5uZlAOa+xyZbbIRsv46twlbsrz6T4w6qo/igcIHTs
 ABZUXkjWq54izNRSLU5675I5cMhDqbuhyAApRnBUX83pGgvzRt1lIHLAxwGXQ9+y1gHZ
 7AeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hmk27xo+SM7qzJxfhIin+YKU4frwyuyy+iVbpJ5gIf0=;
 fh=CemB5rOZoBRaBvfv5LZWH5E9IKLmxmFY38Ikc56uqK8=;
 b=G8QTV1AyCD5d+0QKGDVAQK2ZpayYkQKqOU0M2MjJfo9fhtGFzyKBooplhBZZH8B1lo
 gX0ivTspNrrIvvV2GPSt8ZZjpZe4A0nYbVf4lPUATmqW7CdJ6w7ihsqZVw5v7x23B5w0
 hJq0oYCuBKRc/vAFHz8h4csRQwAaoL/ZN8tPQPzNwNWx8JWtosoCqbgpBP5pXLf0eOPW
 CvcQEwQmmeQhcstQa8svn/14MM626zMOglNZkQ6UujP8ud4GeyQDs7i8553GcqrXDgXz
 GMFoUtmq37/cuKho48vhy38D97J0o0pAN74wFxWj6XnzkkuMbgIhd4YQIntPrYbJLcx1
 F3nA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784881169; x=1785485969; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hmk27xo+SM7qzJxfhIin+YKU4frwyuyy+iVbpJ5gIf0=;
 b=C/Hm2+h4mArEd4YMk7lzlHlkEHl58o264PQI7tBAy7coadb+y6AMYji/BTsBwQAgJy
 SiYDgRUisvdvOE/BYA3AQ5lf3ZBVDR8RREYU6MzUqub9FgcVdOt3SYULV8919VDq8+8D
 ryaqzCYy98ZwEu6GI326Niowu7Q01h/AyhSkqnh24lcGIhcywxanuFxRNMTAkH+iHilR
 4BpYB+eLBCpyfrUff/OsXUxvMFcchfOIEO6lxpvkjAz4VSwj+HgrdO1hB5KBeAz4Qw2+
 bVhMw0m0VPqjcx5IxqDmXQMs0HGOrMettNqkgKbJul+OtBpD34XXcd4G68wFy6CMO0VW
 XAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784881169; x=1785485969;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hmk27xo+SM7qzJxfhIin+YKU4frwyuyy+iVbpJ5gIf0=;
 b=Vkbs/JcJ5ln9/xNiLNIn3/1TVQgU3AoJ6tXrYl3G2oP+nPaeMqKYl+UBkles1zT2gN
 GpNMXsNEui/v8C534sRyuBtA7GESdHNRQmWFUghv/B2kEam3B7p/C7+0MF/v/YL0z654
 FLwPxOBcWMMsTT1dWgSzPvHNBPmxmxY96/kM5V0/USGyN4OSL9qttCXVPxlmudci6vzK
 TT+bQWpEX57bGnx+U3nEkI8tGhiQh0L3AFuBuREMo1Br63xGLw539fObuB14difbSYOA
 yWkLbXcn5Zk9iMLuHqbcOgn7iemGqudyStX9uVk1fcg30rR/MLdgrJM0SVsHs6h3pZbE
 RPXQ==
X-Gm-Message-State: AOJu0YyIiQiGuWKxtKpx4ydMJsyhi6ekmCx+reJXYF04V7ceFnrlzKr2
 bq48y7sy4HCRGsTEaRJmmzvNm07g6/0jczqxVKviJLDlLSrgbaOFp2yQW5EwolXqZwvhk4af5CP
 aG+m0QNUFxvGDQ1btgSEjjWlycoyd0uY=
X-Gm-Gg: AR+sD11ROl2ZE63WsNTZInR6Z7S/Mlv2ej48O0dnBx+cGKNL/dBGWpFO+nwhHn5qK1v
 Beovo032MQMRdachrcKCnryBqkmsskATmyHm2avGyEsM9KOLEUqgbof+uo17oUtTpFmlx4QH4RA
 hHl+SFrPvT0z9Tgc0IyQY8cUEPmBMJe7XechPRjQiVAO2h4778lARCZZBNR9VZ36IfblAMThBKL
 Ft8In0phvqas2DVdqrJnCty3Y7A9ubcxqNzm+9fZjVoSkkbT2HikgLtbDG7zg==
X-Received: by 2002:a17:907:1b1c:b0:c16:84dc:9607 with SMTP id
 a640c23a62f3a-c1c50b919a8mr268006266b.19.1784881168655; Fri, 24 Jul 2026
 01:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260722125713.406245-1-ilya.chichkov.dev@gmail.com>
 <50c0880d-6763-4788-8c66-be6c356a2e59@redhat.com>
In-Reply-To: <50c0880d-6763-4788-8c66-be6c356a2e59@redhat.com>
From: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
Date: Fri, 24 Jul 2026 11:19:17 +0300
X-Gm-Features: AUfX_myNXORUQcCX7jzJ2uh0d7rLoKeaR2vvTesnTRvHsSeJ5_hT4txKSviG4eI
Message-ID: <CADgQP8xZo37VqCmqA8fey1_FgJSPi-PQRbDDeuKK-1LGYixYfw@mail.gmail.com>
Subject: Re: [PATCH v5] hw/i2c: Add remote I2C master with host CUSE bridge
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Corey Minyard <cminyard@mvista.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=ilya.chichkov.dev@gmail.com; helo=mail-ed1-x52e.google.com
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

Hi C=C3=A9dric,

On Wed, 22 Jul 2026 19:42:03 +0200, C=C3=A9dric Le Goater <clg@redhat.com> =
wrote:
> I think a lighter QMP-based approach would serve the same purpose,
> maybe better, and fit in better in QEMU, without the dependency and
> maintenance cost:

As Corey and I discussed earlier in the thread, QMP doesn't cover the prima=
ry
motivation for this patch: zero-code transparency for existing host softwar=
e.

An `i2c-transfer` QMP command would be a great addition for custom scripts,
but the main goal here is to allow native Linux user-space binaries
(like i2c-tools,
lm-sensors) running on the host to talk to QEMU's I2C slaves unmodified, si=
mply
by opening /dev/i2c-N. Rewriting legacy test suites to speak QMP JSON over =
a
socket is often not feasible.

> The dependency cost seems high for the use case: libfuse3 + the cuse
> kernel module pulled into the system emulator build. It's also ~3K
> lines of new code, three QOM types, FUSE session management, etc.

Regarding dependencies, `libfuse3` is actually not new to the project =E2=
=80=94 it has
been a supported QEMU dependency for a long time (already used by the block
layer in `block/export/fuse.c`). Also, just to clarify the diff: the core
implementation is roughly ~2K lines. The remaining ~900 lines are dedicated
entirely to qtests and RST documentation.

However, I agree about not polluting the core emulation build with
Linux-specific
headers and libfuse3. The maintenance cost must be minimized. To address th=
is,
I've refactored the architecture for v6 to ensure strict isolation:

- All Linux and FUSE-specific headers are removed from public QEMU headers.
  The internal state structure is now opaque and hidden inside
remote-i2c-cuse.c.
- The CUSE backend is isolated behind its own
  CONFIG_REMOTE_I2C_BACKEND_CUSE in Kconfig and meson.build, strictly
  depending on LINUX and fuse3.

On macOS, Windows, or minimalistic builds without libfuse, QEMU will build
cleanly without pulling in this backend or any of its dependencies.

Would making the CUSE transport a strictly optional, isolated Linux-only ba=
ckend
alleviate your concerns regarding the hardware emulation core?

Best regards,
Ilya

=D1=81=D1=80, 22 =D0=B8=D1=8E=D0=BB. 2026=E2=80=AF=D0=B3. =D0=B2 20:42, C=
=C3=A9dric Le Goater <clg@redhat.com>:
>
> On 7/22/26 14:57, Ilya Chichkov wrote:
> > Add a "remote-i2c-master" device that exposes a QEMU I2C bus to the
> > host system through a FUSE/CUSE character device. This lets external
> > host programs and standard i2c-tools interact with I2C slaves emulated
> > inside QEMU as if they were real devices attached to the host.
> >
> > The implementation is split into three layers:
> >
> >    - A non-blocking finite state machine that drives the QEMU I2C
> >      master. It is pumped by a QEMU Bottom Half and uses virtual timers
> >      to yield during long transfers and to model clock stretching for
> >      asynchronous slaves, so the main loop is never blocked. The FSM
> >      walks IDLE -> ADDR -> SEND/RECV -> WAIT_STRETCH -> END -> FINISHED
> >      and handles NACKs (ENXIO), lost arbitration (EBUSY, with optional
> >      back-off and retry), stretch timeouts, and manual abort/reset.
> >
> >    - An abstract RemoteI2CBackend QOM base class that decouples the
> >      internal I2C hardware state machine (the frontend) from any
> >      host-specific transport, exposing on_tx_complete and on_tx_error
> >      virtual callbacks.
> >
> >    - A concrete remote-i2c-backend-cuse backend implementing that
> >      transport over CUSE. It manages the FUSE session and integrates
> >      its file descriptors into QEMU's main AioContext event loop,
> >      translates Linux I2C_RDWR, I2C_SMBUS and I2C_SLAVE ioctls into
> >      generic byte streams for the FSM, and formats responses back into
> >      Linux I2C/SMBus structures for the FUSE driver. SMBus repeated
> >      start is supported for atomic write-then-read operations.
> >
> > Example usage:
> >
> >    -device remote-i2c-master,i2cbus=3Di2c-bus.0,devname=3Di2c-33
> >    -object remote-i2c-backend-cuse,id=3Db0,devname=3Di2c-33
> >
> > This creates /dev/i2c-33 on the host, usable with i2c-tools:
> >
> >    i2cdetect -y -l
> >    i2cget -y <bus_id> <addr> <reg>
> >
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
> > ---
> > v2:
> >    - docs/system/devices/remote-i2c-master.rst: Documented concurrent
> >      bus access details and the 'raise-arbitrage-lost' property.
> > ---
> > v3:
> >    - qapi/qom.json: Fix RemoteI2CBackendCuseProperties formatting and
> >      expand member documentation (devname, fuse-opts, debug).
> >    - tests/qtest: Add remote-i2c-cuse-test covering capabilities,
> >      functional smoke test, synchronous sensor read/write.
> > ---
> > v4:
> >   - qapi: reference the rst doc via :doc:
> >   - qapi: fuse-opts is now ['str'] instead of a space-separated string
> >   - qapi: drop redundant 'debug' property (pass -d via fuse-opts)
> > ---
> > v5:
> >   - docs/system/device-emulation.rst: add remote-i2c-master.rst to
> >     the toctree under "Emulated Devices"
> >   - qapi/qom.json: move RemoteI2CBackendCuseProperties definition
> >     before RemoteObjectProperties as requested; change "for usage
> >     information" to "for detailed usage information"
> > ---
> > ---
> >   docs/system/device-emulation.rst          |    1 +
> >   docs/system/devices/remote-i2c-master.rst |  217 ++++
> >   hw/i2c/Kconfig                            |    5 +
> >   hw/i2c/meson.build                        |    6 +
> >   hw/i2c/remote-i2c-backend.c               |   30 +
> >   hw/i2c/remote-i2c-cuse.c                  | 1173 ++++++++++++++++++++=
+
> >   hw/i2c/remote-i2c-fsm.c                   |  521 +++++++++
> >   hw/i2c/remote-i2c-master.c                |  145 +++
> >   hw/i2c/trace-events                       |   29 +
> >   include/hw/i2c/remote-i2c-backend.h       |   70 ++
> >   include/hw/i2c/remote-i2c-cuse.h          |   93 ++
> >   include/hw/i2c/remote-i2c-master.h        |   77 ++
> >   qapi/qom.json                             |   29 +
> >   tests/qtest/meson.build                   |    2 +
> >   tests/qtest/remote-i2c-cuse-test.c        |  326 ++++++
> >   15 files changed, 2724 insertions(+)
> >   create mode 100644 docs/system/devices/remote-i2c-master.rst
> >   create mode 100644 hw/i2c/remote-i2c-backend.c
> >   create mode 100644 hw/i2c/remote-i2c-cuse.c
> >   create mode 100644 hw/i2c/remote-i2c-fsm.c
> >   create mode 100644 hw/i2c/remote-i2c-master.c
> >   create mode 100644 include/hw/i2c/remote-i2c-backend.h
> >   create mode 100644 include/hw/i2c/remote-i2c-cuse.h
> >   create mode 100644 include/hw/i2c/remote-i2c-master.h
> >   create mode 100644 tests/qtest/remote-i2c-cuse-test.c
>
> If I understand this proposal correctly, it lets host-side i2c
> tools talk to emulated I2C devices. The example is i2cdetect/i2cget
> against a tmp105 on an Aspeed bus.
>
> QEMU already has mechanisms for this though. qtest can read/write I2C
> registers programmatically, QMP can query device state, and the guest
> OS itself sees the I2C bus natively.
>
> The dependency cost seems high for the use case: libfuse3 + the cuse
> kernel module pulled into the system emulator build. It's also ~3K
> lines of new code, three QOM types, FUSE session management, etc.
> The surface area for bugs is large. It's a heavy burden for what it
> gives.
>
> I think a lighter QMP-based approach would serve the same purpose,
> maybe better, and fit in better in QEMU, without the dependency and
> maintenance cost:
>
> - No host kernel dependency
> - Works remotely (QMP over socket)
> - Fits QEMU's existing management model
> - Much less code
> - Testable without root or kernel modules
>
> Have you considered extending QMP with an I2C transaction command
> instead? Something like:
>
>    { 'command': 'i2c-transfer',
>      'data': { 'bus': 'str',
>                'address': 'uint8',
>                'read': 'bool',
>                '*data': ['uint8'],
>                '*length': 'uint16' },
>      'returns': { '*data': ['uint8'] } }
>
>
> Thanks,
>
> C.
>

