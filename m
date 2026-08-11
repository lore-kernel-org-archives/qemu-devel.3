Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587F7C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjMJ-00010I-4Y; Tue, 11 Aug 2026 06:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilya.chichkov.dev@gmail.com>)
 id 1wtjMD-0000xM-M3
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:05:19 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilya.chichkov.dev@gmail.com>)
 id 1wtjMB-0002Cu-2o
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:05:17 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15cd3fd760so290755066b.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:05:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786442712; cv=none;
 d=google.com; s=arc-20260327;
 b=MJTWY7nzf68x9qDTLzJxAGxxL9BJkmGvqoTSgD3CtppvzPvdM9znMKkRELvu1ldEcR
 cT2cZgH3faUU1uSGCYgMzs1rCDA9vIbRc5dZGakrzrzpN61axF+r9b7KMX0Dc9OtE+BI
 o5Y19ft9ODRCC9T5WQPC/NdWjL/Z0LKPq3D++1TCUwTv1xfXV0UjxFDJoaJnGZAC8+YS
 J9RulD8ZGcxOqgo0MK9EEiKkhITPtLnNN1ryMKtTDEoKXh13qHNqJwzDrdA176Jm/3wP
 e7iZAEkHRce94eorOO2W6SeK2fDkrcISufvMYFVrkhSpj1n5xvpGFlMmvWpVpbjWpKOV
 epaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yLLCRx0djc86NfAsnt+g5q3niHAJ4oahuZeaDDe3ndw=;
 fh=E/mS9waRnEM42AK42QUTbxXUqAeZcwWfqeWNBMTg76A=;
 b=Cm6HwBXeoX+E12NB4jShWo24/fEtOpE4yxuB5q/uD29uoD3lgu0Cb3KX+VkthMdj9L
 1pfEzidcKAryIPZM+BZlUtOkKrpRA0U3b00Cai9GlFYp3BlyNT8KAHpZ4EhqU1CdIldy
 EfHYcnFAfptyYHenO/LoW2rI8YLr0+iBNRXHZMcSjoOHig1xKP9wAuhReHmxdW609JHS
 8NK9LaysSRcrXT/OE7XJC8pF+D7HZ+mysxyjKqWsNliJ3jWyNv+wb83kRZtSLL8y7HOB
 4MoL36HvJ0r3rl3AzirQdOewAi8BRVoZA6vCvJoTZSXJqmXc5tuY6mLbKchzSLzuGUoH
 u8BQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786442712; x=1787047512; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yLLCRx0djc86NfAsnt+g5q3niHAJ4oahuZeaDDe3ndw=;
 b=Xb+4o6AxknM3B30T+QQWTF0RG7myqaBwCrO/4Rxs8RVi9YbEhrYPoBwmreit5VPdVi
 /M/REMnJOG23HSKZEqp4Wt1KJ8JNfLuSXZz9GPOHm6rT19EdtMcQfkPxPrLAdksPrD36
 SBN+nC01HxoHvTcAE1M924+3JyymHer74Gxm/p4B/resBIT4MKV++Jx/MsrvdnsprCkh
 Dv2RbmH2UAsiw5Qd+ZOfUJ+ybRS/FhMsTV0LbQbaJlVrsbLwB+nkkUb0N1V9bPsdOSw+
 Vr7Z8V5VjEDxYdMhC+Sg+e4JJnmFJwxAAGQ/mVW2fNtt40XOjOdk0Kg5gNOUGswYy/LL
 guYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786442712; x=1787047512;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yLLCRx0djc86NfAsnt+g5q3niHAJ4oahuZeaDDe3ndw=;
 b=cDV4aXjeIC8m61NrxFiE5jB3v8wnM1AATmJlhCxe8sBRDuP8Y90I2FZWtg+6BpR6t7
 tNPzXKaMeTeHlzBjUPa7EwyzFqbIcKnGiJwO1KMg9+/qe6c9wQiikW7dFM0DtY2zduMl
 rLu6KJv4eSGxYTfm+B/2k9rWXmXtkHjamYw/mDCeOqH30aOKAIdpo4eDjsyUjyRXqaH+
 jkyDtYhzBpkmdDHOwCoXESIuzawWu5MMsPzmvKE1S0m8W7zERnCAbhqGedtCLOL/oouR
 nxQjJGrrNxmUCQBWGUl9pxwF8lZ0+DH2FTBdLsVgI55lEnf8E2Qr2eTHql6cfq1nRrjm
 MjXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqolTnpyuaruuFPUj4IflbmaVTAlHj+EIFsopT4T+KepnYmsk1/tCvIlZTQ0mbq2Vuqpp5ytjfqemNJ@nongnu.org
X-Gm-Message-State: AOJu0YzfU5mdremdOKwe3gZQWUn9U+Rc+CjxLK20aH3miWb5EpY1OOga
 Kc9FwSB7LO5Bdw4tx9fNW27GFe1A0/g9AQVlMhjP+f6HIJvd1Cv6yLXGQswc2HhK5ucTSliGNfG
 gRHMtWNkBH8jKgGEc4T30v4AWTuvlD7E=
X-Gm-Gg: AR+sD12yz4vuxuj4O6vcZd9XdXIuzNjem+S5pW5cAd+LDy3W6aNpE7YNrpO0/Up3Yrc
 wA11bkxUl5n3n63WHNG2fU0cZU+B2+VncpIojVCEKxJkSU/A5f4m5o1tv8AFM3KsvwbpijxDolZ
 9FZtc6uzcajbfCZyRG4EzJOooLP6DtCjFPeyCas3T9bG+t6TbfbIEiuJQFaZLESq/nKPIpeBV5j
 NWttPiUQlLbfwFgaRtKvSxmkA5ZbkM56XLr3VgIquIakRUjZJ/ZSLiXdk3/fDa+vo4+Du4zi4wR
 YtqsKs6lfV96F8EAqsz41nT9Dxwum8BKl+UXndrqc45gUg==
X-Received: by 2002:a17:907:7243:b0:c16:73a0:c4ec with SMTP id
 a640c23a62f3a-c20e621e697mr64656966b.18.1786442711993; Tue, 11 Aug 2026
 03:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260722125713.406245-1-ilya.chichkov.dev@gmail.com>
 <50c0880d-6763-4788-8c66-be6c356a2e59@redhat.com>
 <CADgQP8xZo37VqCmqA8fey1_FgJSPi-PQRbDDeuKK-1LGYixYfw@mail.gmail.com>
 <amNpErR1oDqsQknD@mail.minyard.net>
 <CADgQP8yisWh1RBbxvahf9n46_phnjDxhQeCwxUEfx8+En0LNhA@mail.gmail.com>
 <amOBf20vEO1dteit@mail.minyard.net>
In-Reply-To: <amOBf20vEO1dteit@mail.minyard.net>
From: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
Date: Tue, 11 Aug 2026 13:05:00 +0300
X-Gm-Features: AUfX_mw_RqRQdoxKB8a3ML0LcpNW_6GzuQPqwJZMwg4saEhyCssU1vbeUb1PJZE
Message-ID: <CADgQP8xY8eLSobq-Q9fiJ3mrXNyPSev18bvT75r6n5d+8uhXNg@mail.gmail.com>
Subject: Re: [PATCH v5] hw/i2c: Add remote I2C master with host CUSE bridge
To: cminyard@mvista.com
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=ilya.chichkov.dev@gmail.com; helo=mail-ej1-x629.google.com
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

Ping

Best regards, Ilya

=D0=BF=D1=82, 24 =D0=B8=D1=8E=D0=BB. 2026=E2=80=AF=D0=B3. =D0=B2 18:15, Cor=
ey Minyard <cminyard@mvista.com>:
>
> On Fri, Jul 24, 2026 at 05:49:02PM +0300, Ilya Chichkov wrote:
> > Hi Corey, C=C3=A9dric,
> >
> > On Fri, 24 Jul 2026 08:30:58 -0500, Corey Minyard <cminyard@mvista.com>=
 wrote:
> > > I think what C=C3=A9dric is saying here is that if you provided a gen=
eric
> > > QMP interface that allowed these sorts of operations and wrote an
> > > external program that used said interface to provide a fuse interface=
,
> > > that would be better.
> >
> > I see your point about keeping the core emulator clean and minimizing
> > dependencies.
> >
> > I am willing to pivot to this architectural direction. I can drop the C=
USE
> > backend from this patch series and instead implement the `i2c-transfer`
> > QMP command, as C=C3=A9dric originally suggested. I will handle the CUS=
E
> > part externally.
> >
> > Before I send v6, are there any other concerns regarding the core FSM
> > logic, or would replacing CUSE with a QMP backend be sufficient?
>
> I didn't see anything, it looked clean and well written to me, but I am
> not as much of a QEMU expert as others.  I kind of happened into this as
> I know a lot about IPMI and I2C.
>
> -corey
>
> >
> > Best regards,
> > Ilya
> >
> >
> > =D0=BF=D1=82, 24 =D0=B8=D1=8E=D0=BB. 2026=E2=80=AF=D0=B3. =D0=B2 16:31,=
 Corey Minyard <cminyard@mvista.com>:
> > >
> > > On Fri, Jul 24, 2026 at 11:19:17AM +0300, Ilya Chichkov wrote:
> > > > Hi C=C3=A9dric,
> > > >
> > > > On Wed, 22 Jul 2026 19:42:03 +0200, C=C3=A9dric Le Goater <clg@redh=
at.com> wrote:
> > > > > I think a lighter QMP-based approach would serve the same purpose=
,
> > > > > maybe better, and fit in better in QEMU, without the dependency a=
nd
> > > > > maintenance cost:
> > > >
> > > > As Corey and I discussed earlier in the thread, QMP doesn't cover t=
he primary
> > > > motivation for this patch: zero-code transparency for existing host=
 software.
> > > >
> > > > An `i2c-transfer` QMP command would be a great addition for custom =
scripts,
> > > > but the main goal here is to allow native Linux user-space binaries
> > > > (like i2c-tools,
> > > > lm-sensors) running on the host to talk to QEMU's I2C slaves unmodi=
fied, simply
> > > > by opening /dev/i2c-N. Rewriting legacy test suites to speak QMP JS=
ON over a
> > > > socket is often not feasible.
> > >
> > > I think what C=C3=A9dric is saying here is that if you provided a gen=
eric
> > > QMP interface that allowed these sorts of operations and wrote an
> > > external program that used said interface to provide a fuse interface=
,
> > > that would be better.  It has a number of advantages:
> > >
> > > * You add an interface to QEMU that others can easily use to test
> > >   devices.
> > >
> > > * You are not tied to QEMU when you want to extend the functions of
> > >   the fuse interface.
> > >
> > > * It's one less dependency in QEMU.  QEMU has a *lot* of dependencies=
,
> > >   and the fewer the better.
> > >
> > > The only disadvantage I can think of is that it's one more piece of
> > > software if you are setting this up.
> > >
> > > This is not a big piece of software, I agree, but from experience I
> > > think you will be happier with this sort of design in the long run.
> > > It puts you more in control of what you are doing.
> > >
> > > And, of course, it makes the QEMU maintainers happier :-).
> > >
> > > -corey
> > >
> > > >
> > > > > The dependency cost seems high for the use case: libfuse3 + the c=
use
> > > > > kernel module pulled into the system emulator build. It's also ~3=
K
> > > > > lines of new code, three QOM types, FUSE session management, etc.
> > > >
> > > > Regarding dependencies, `libfuse3` is actually not new to the proje=
ct =E2=80=94 it has
> > > > been a supported QEMU dependency for a long time (already used by t=
he block
> > > > layer in `block/export/fuse.c`). Also, just to clarify the diff: th=
e core
> > > > implementation is roughly ~2K lines. The remaining ~900 lines are d=
edicated
> > > > entirely to qtests and RST documentation.
> > > >
> > > > However, I agree about not polluting the core emulation build with
> > > > Linux-specific
> > > > headers and libfuse3. The maintenance cost must be minimized. To ad=
dress this,
> > > > I've refactored the architecture for v6 to ensure strict isolation:
> > > >
> > > > - All Linux and FUSE-specific headers are removed from public QEMU =
headers.
> > > >   The internal state structure is now opaque and hidden inside
> > > > remote-i2c-cuse.c.
> > > > - The CUSE backend is isolated behind its own
> > > >   CONFIG_REMOTE_I2C_BACKEND_CUSE in Kconfig and meson.build, strict=
ly
> > > >   depending on LINUX and fuse3.
> > > >
> > > > On macOS, Windows, or minimalistic builds without libfuse, QEMU wil=
l build
> > > > cleanly without pulling in this backend or any of its dependencies.
> > > >
> > > > Would making the CUSE transport a strictly optional, isolated Linux=
-only backend
> > > > alleviate your concerns regarding the hardware emulation core?
> > > >
> > > > Best regards,
> > > > Ilya
> > > >
> > > > =D1=81=D1=80, 22 =D0=B8=D1=8E=D0=BB. 2026=E2=80=AF=D0=B3. =D0=B2 20=
:42, C=C3=A9dric Le Goater <clg@redhat.com>:
> > > > >
> > > > > On 7/22/26 14:57, Ilya Chichkov wrote:
> > > > > > Add a "remote-i2c-master" device that exposes a QEMU I2C bus to=
 the
> > > > > > host system through a FUSE/CUSE character device. This lets ext=
ernal
> > > > > > host programs and standard i2c-tools interact with I2C slaves e=
mulated
> > > > > > inside QEMU as if they were real devices attached to the host.
> > > > > >
> > > > > > The implementation is split into three layers:
> > > > > >
> > > > > >    - A non-blocking finite state machine that drives the QEMU I=
2C
> > > > > >      master. It is pumped by a QEMU Bottom Half and uses virtua=
l timers
> > > > > >      to yield during long transfers and to model clock stretchi=
ng for
> > > > > >      asynchronous slaves, so the main loop is never blocked. Th=
e FSM
> > > > > >      walks IDLE -> ADDR -> SEND/RECV -> WAIT_STRETCH -> END -> =
FINISHED
> > > > > >      and handles NACKs (ENXIO), lost arbitration (EBUSY, with o=
ptional
> > > > > >      back-off and retry), stretch timeouts, and manual abort/re=
set.
> > > > > >
> > > > > >    - An abstract RemoteI2CBackend QOM base class that decouples=
 the
> > > > > >      internal I2C hardware state machine (the frontend) from an=
y
> > > > > >      host-specific transport, exposing on_tx_complete and on_tx=
_error
> > > > > >      virtual callbacks.
> > > > > >
> > > > > >    - A concrete remote-i2c-backend-cuse backend implementing th=
at
> > > > > >      transport over CUSE. It manages the FUSE session and integ=
rates
> > > > > >      its file descriptors into QEMU's main AioContext event loo=
p,
> > > > > >      translates Linux I2C_RDWR, I2C_SMBUS and I2C_SLAVE ioctls =
into
> > > > > >      generic byte streams for the FSM, and formats responses ba=
ck into
> > > > > >      Linux I2C/SMBus structures for the FUSE driver. SMBus repe=
ated
> > > > > >      start is supported for atomic write-then-read operations.
> > > > > >
> > > > > > Example usage:
> > > > > >
> > > > > >    -device remote-i2c-master,i2cbus=3Di2c-bus.0,devname=3Di2c-3=
3
> > > > > >    -object remote-i2c-backend-cuse,id=3Db0,devname=3Di2c-33
> > > > > >
> > > > > > This creates /dev/i2c-33 on the host, usable with i2c-tools:
> > > > > >
> > > > > >    i2cdetect -y -l
> > > > > >    i2cget -y <bus_id> <addr> <reg>
> > > > > >
> > > > > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > > > > Signed-off-by: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
> > > > > > ---
> > > > > > v2:
> > > > > >    - docs/system/devices/remote-i2c-master.rst: Documented conc=
urrent
> > > > > >      bus access details and the 'raise-arbitrage-lost' property=
.
> > > > > > ---
> > > > > > v3:
> > > > > >    - qapi/qom.json: Fix RemoteI2CBackendCuseProperties formatti=
ng and
> > > > > >      expand member documentation (devname, fuse-opts, debug).
> > > > > >    - tests/qtest: Add remote-i2c-cuse-test covering capabilitie=
s,
> > > > > >      functional smoke test, synchronous sensor read/write.
> > > > > > ---
> > > > > > v4:
> > > > > >   - qapi: reference the rst doc via :doc:
> > > > > >   - qapi: fuse-opts is now ['str'] instead of a space-separated=
 string
> > > > > >   - qapi: drop redundant 'debug' property (pass -d via fuse-opt=
s)
> > > > > > ---
> > > > > > v5:
> > > > > >   - docs/system/device-emulation.rst: add remote-i2c-master.rst=
 to
> > > > > >     the toctree under "Emulated Devices"
> > > > > >   - qapi/qom.json: move RemoteI2CBackendCuseProperties definiti=
on
> > > > > >     before RemoteObjectProperties as requested; change "for usa=
ge
> > > > > >     information" to "for detailed usage information"
> > > > > > ---
> > > > > > ---
> > > > > >   docs/system/device-emulation.rst          |    1 +
> > > > > >   docs/system/devices/remote-i2c-master.rst |  217 ++++
> > > > > >   hw/i2c/Kconfig                            |    5 +
> > > > > >   hw/i2c/meson.build                        |    6 +
> > > > > >   hw/i2c/remote-i2c-backend.c               |   30 +
> > > > > >   hw/i2c/remote-i2c-cuse.c                  | 1173 ++++++++++++=
+++++++++
> > > > > >   hw/i2c/remote-i2c-fsm.c                   |  521 +++++++++
> > > > > >   hw/i2c/remote-i2c-master.c                |  145 +++
> > > > > >   hw/i2c/trace-events                       |   29 +
> > > > > >   include/hw/i2c/remote-i2c-backend.h       |   70 ++
> > > > > >   include/hw/i2c/remote-i2c-cuse.h          |   93 ++
> > > > > >   include/hw/i2c/remote-i2c-master.h        |   77 ++
> > > > > >   qapi/qom.json                             |   29 +
> > > > > >   tests/qtest/meson.build                   |    2 +
> > > > > >   tests/qtest/remote-i2c-cuse-test.c        |  326 ++++++
> > > > > >   15 files changed, 2724 insertions(+)
> > > > > >   create mode 100644 docs/system/devices/remote-i2c-master.rst
> > > > > >   create mode 100644 hw/i2c/remote-i2c-backend.c
> > > > > >   create mode 100644 hw/i2c/remote-i2c-cuse.c
> > > > > >   create mode 100644 hw/i2c/remote-i2c-fsm.c
> > > > > >   create mode 100644 hw/i2c/remote-i2c-master.c
> > > > > >   create mode 100644 include/hw/i2c/remote-i2c-backend.h
> > > > > >   create mode 100644 include/hw/i2c/remote-i2c-cuse.h
> > > > > >   create mode 100644 include/hw/i2c/remote-i2c-master.h
> > > > > >   create mode 100644 tests/qtest/remote-i2c-cuse-test.c
> > > > >
> > > > > If I understand this proposal correctly, it lets host-side i2c
> > > > > tools talk to emulated I2C devices. The example is i2cdetect/i2cg=
et
> > > > > against a tmp105 on an Aspeed bus.
> > > > >
> > > > > QEMU already has mechanisms for this though. qtest can read/write=
 I2C
> > > > > registers programmatically, QMP can query device state, and the g=
uest
> > > > > OS itself sees the I2C bus natively.
> > > > >
> > > > > The dependency cost seems high for the use case: libfuse3 + the c=
use
> > > > > kernel module pulled into the system emulator build. It's also ~3=
K
> > > > > lines of new code, three QOM types, FUSE session management, etc.
> > > > > The surface area for bugs is large. It's a heavy burden for what =
it
> > > > > gives.
> > > > >
> > > > > I think a lighter QMP-based approach would serve the same purpose=
,
> > > > > maybe better, and fit in better in QEMU, without the dependency a=
nd
> > > > > maintenance cost:
> > > > >
> > > > > - No host kernel dependency
> > > > > - Works remotely (QMP over socket)
> > > > > - Fits QEMU's existing management model
> > > > > - Much less code
> > > > > - Testable without root or kernel modules
> > > > >
> > > > > Have you considered extending QMP with an I2C transaction command
> > > > > instead? Something like:
> > > > >
> > > > >    { 'command': 'i2c-transfer',
> > > > >      'data': { 'bus': 'str',
> > > > >                'address': 'uint8',
> > > > >                'read': 'bool',
> > > > >                '*data': ['uint8'],
> > > > >                '*length': 'uint16' },
> > > > >      'returns': { '*data': ['uint8'] } }
> > > > >
> > > > >
> > > > > Thanks,
> > > > >
> > > > > C.
> > > > >

