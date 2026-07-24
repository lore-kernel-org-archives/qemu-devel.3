Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D508C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnHDY-0003g8-7P; Fri, 24 Jul 2026 10:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilya.chichkov.dev@gmail.com>)
 id 1wnHDE-0003aP-J1
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 10:49:25 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilya.chichkov.dev@gmail.com>)
 id 1wnHDB-0001vW-Tz
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 10:49:19 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69a5ecbbfb2so675150a12.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 07:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784904555; cv=none;
 d=google.com; s=arc-20260327;
 b=FHq8C6r4S+jhyVx7l0cGSr4WfePI45/TZl4AfYAkD0WFrjc7w0brZNYpxD4WJY34Yz
 UswjEOGypVkyrdtT9Hb7f2pUGlv1RJrs24phrTcsere5N9kJ96MfvGpyqfEICa/ufEEk
 5oCq+0ACVWFhbKLYwjSFoCw2iSqCPcIo27rXxj/VO0d36pgwmIPEFH6dHj4LVGHTAds3
 KGMbow1Pqa9Zs7mWIOwR+Sd3BgB6oVKIIlIGZiRY5Mc9fS81N+ZJwfGDflUtQ0wVi/qE
 ZCJMevn33n0iBJEi2nSPnrCICf3bW2azMpMwRhp6YGhceLsWR1RLG60GSqH2JKD9hIvu
 tlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OOJOpWEcCrOUS7L0JcaLXLswkgEKfyD4dwJ8Z82PcqY=;
 fh=fJLcrpSUGF+SvZyLIwShggnZHZ/LKM6+EJK1hNE+FM8=;
 b=X4jhbgjl8KyLOSVi6bdBCcFS/tEcsNGYDEb8nJjlmiShIyT6+mhkUHOaKf6dMOH+8o
 c1LY8qm59oJN8s+KBrgaRAGrJt0xxOzmSFlnxUqkyQiXOlv2wHQYupdUyojdRSg+R8js
 rpV59B/8yfh7AYoT+e5+vBn1QSMbc4uiPktf2MnQ1+gDqINOhFoo2eeXOwRwm9OBXFMG
 ZbI09+IrZXPeel3eTwVgBCDTAaefdZz83CeoyOdLGPnZtwU1KYK7sXr47IfHFL2hZP6+
 /+UV4TRmLDbl78+SIR4+gLCwwYIII0pOuXWzgrXs5QlSilZ4u+bc/tXLa0SKJTlY4N4Q
 YkoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784904555; x=1785509355; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OOJOpWEcCrOUS7L0JcaLXLswkgEKfyD4dwJ8Z82PcqY=;
 b=nG87p2wIAjWsMuRV/4ERKueyo79N7ivFHAaB68Y4bHjL5L3CMcfBCGL6ueR3P1SZJP
 ie98ITV5QANdrQ+7FbmHG7RpOPOuEIw3boFggHhMw+P7p7z44kcsAT2yPg9DQtAJ/V5/
 5IDnjU6fkWY4VpXiyVdwXPe34/3YnY2vJzVeoBqywYbZ40qCdNNnrwLS/KuxJHgzt1Pt
 3g7HByvm6078RPkV5vfu/Om/Rtmf7LBpk2YLvMNqYJ+wkUwOFtHpH6odjmdVqpwMkVK/
 I43HzKT0Mmiixe6OhX81mBajxDjywAMmb5fHYgptz3B1w9B+St0lqWuwz20sZC2Hoqni
 KVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784904555; x=1785509355;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OOJOpWEcCrOUS7L0JcaLXLswkgEKfyD4dwJ8Z82PcqY=;
 b=UVoy9VTPr4WENC5dW1zn9UbK7Ko6cMj3OVNiDIgsa6M1hKDKknv2KlEmzeFCezt/e3
 J8Ee2E9iMo8Q+MS58qZ6HNpt3OlzhTx8CKiJcyhoG1rBPC3ZtyGWFH4Qa/v9n4XjZ/lH
 o+wYtX2lueLjY59NwYcu96K/FDNa8f6Qr1OPUJkZ56IA34IocKcBgRPH32J43hdQf72S
 akb1Uq/6iNO8/KGVzOkHGDt2EtMS30zIHlanwEGW/cuojGegJIroorxaCMAIKUOtvOV/
 9U01yeIo0JGbXk7SBcpceH79f/IadVPvDXvUY5y1jF5q/tHQnqSo4Ye+Rkld5nQlhQtB
 EaMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKfBy/Ctcb8jdYXIjFw+GDAQrlpJlvdr8ugqeH6O+8uCljGx8nbpuIr8Pnnt7OdBByc/5ddUW+QQAV@nongnu.org
X-Gm-Message-State: AOJu0YyEXbDY2d/iJMeajK7MnzWKqTGryiMV+Og/bCYI9uysEXVJVItv
 9eon8D76YVyY5CZxYQrvta/AA9EXqrEGG6XLT31aLmyJRDGI/3cLttXskSgWI5UK10Kwu/AV+6y
 pFSyMW4NSBZSG092aYTuwEBQGMVSY8kQ=
X-Gm-Gg: AR+sD12H9KK4Ibifpg3mTQML1MNOKXDrYZmhhztJKlMdhSa40sQ3k+4TSuk6aS51Mqa
 UP6LciycMzSoYWJtfyzcpsfTwT3hfdWWdbw8mGUiIUoXq9ewnYMLvW64jpvxm/qEVNXCqmoRxcV
 vLEvUPtFiGvs4EKphWn16nH0z9omlMBgxSsfbSTP7SbPZiPztYzDyUpFM02ZOnuLqyA6VsKCLk2
 QuB1uKri6/VYHHozayQZKZeyJQm5o11J9GU57FtFCfKmTMxYMaUf4Mlef3eRQ==
X-Received: by 2002:a17:907:804:b0:c15:f376:9642 with SMTP id
 a640c23a62f3a-c1c50b3e3fcmr325113166b.65.1784904554408; Fri, 24 Jul 2026
 07:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260722125713.406245-1-ilya.chichkov.dev@gmail.com>
 <50c0880d-6763-4788-8c66-be6c356a2e59@redhat.com>
 <CADgQP8xZo37VqCmqA8fey1_FgJSPi-PQRbDDeuKK-1LGYixYfw@mail.gmail.com>
 <amNpErR1oDqsQknD@mail.minyard.net>
In-Reply-To: <amNpErR1oDqsQknD@mail.minyard.net>
From: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
Date: Fri, 24 Jul 2026 17:49:02 +0300
X-Gm-Features: AUfX_myLbx0PhX0lvgiOHymlIH7GR1uTcs3WRmXw1j9J63C6x6Qdee1tjH9sLro
Message-ID: <CADgQP8yisWh1RBbxvahf9n46_phnjDxhQeCwxUEfx8+En0LNhA@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=ilya.chichkov.dev@gmail.com; helo=mail-ed1-x52b.google.com
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

Hi Corey, C=C3=A9dric,

On Fri, 24 Jul 2026 08:30:58 -0500, Corey Minyard <cminyard@mvista.com> wro=
te:
> I think what C=C3=A9dric is saying here is that if you provided a generic
> QMP interface that allowed these sorts of operations and wrote an
> external program that used said interface to provide a fuse interface,
> that would be better.

I see your point about keeping the core emulator clean and minimizing
dependencies.

I am willing to pivot to this architectural direction. I can drop the CUSE
backend from this patch series and instead implement the `i2c-transfer`
QMP command, as C=C3=A9dric originally suggested. I will handle the CUSE
part externally.

Before I send v6, are there any other concerns regarding the core FSM
logic, or would replacing CUSE with a QMP backend be sufficient?

Best regards,
Ilya


=D0=BF=D1=82, 24 =D0=B8=D1=8E=D0=BB. 2026=E2=80=AF=D0=B3. =D0=B2 16:31, Cor=
ey Minyard <cminyard@mvista.com>:
>
> On Fri, Jul 24, 2026 at 11:19:17AM +0300, Ilya Chichkov wrote:
> > Hi C=C3=A9dric,
> >
> > On Wed, 22 Jul 2026 19:42:03 +0200, C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:
> > > I think a lighter QMP-based approach would serve the same purpose,
> > > maybe better, and fit in better in QEMU, without the dependency and
> > > maintenance cost:
> >
> > As Corey and I discussed earlier in the thread, QMP doesn't cover the p=
rimary
> > motivation for this patch: zero-code transparency for existing host sof=
tware.
> >
> > An `i2c-transfer` QMP command would be a great addition for custom scri=
pts,
> > but the main goal here is to allow native Linux user-space binaries
> > (like i2c-tools,
> > lm-sensors) running on the host to talk to QEMU's I2C slaves unmodified=
, simply
> > by opening /dev/i2c-N. Rewriting legacy test suites to speak QMP JSON o=
ver a
> > socket is often not feasible.
>
> I think what C=C3=A9dric is saying here is that if you provided a generic
> QMP interface that allowed these sorts of operations and wrote an
> external program that used said interface to provide a fuse interface,
> that would be better.  It has a number of advantages:
>
> * You add an interface to QEMU that others can easily use to test
>   devices.
>
> * You are not tied to QEMU when you want to extend the functions of
>   the fuse interface.
>
> * It's one less dependency in QEMU.  QEMU has a *lot* of dependencies,
>   and the fewer the better.
>
> The only disadvantage I can think of is that it's one more piece of
> software if you are setting this up.
>
> This is not a big piece of software, I agree, but from experience I
> think you will be happier with this sort of design in the long run.
> It puts you more in control of what you are doing.
>
> And, of course, it makes the QEMU maintainers happier :-).
>
> -corey
>
> >
> > > The dependency cost seems high for the use case: libfuse3 + the cuse
> > > kernel module pulled into the system emulator build. It's also ~3K
> > > lines of new code, three QOM types, FUSE session management, etc.
> >
> > Regarding dependencies, `libfuse3` is actually not new to the project =
=E2=80=94 it has
> > been a supported QEMU dependency for a long time (already used by the b=
lock
> > layer in `block/export/fuse.c`). Also, just to clarify the diff: the co=
re
> > implementation is roughly ~2K lines. The remaining ~900 lines are dedic=
ated
> > entirely to qtests and RST documentation.
> >
> > However, I agree about not polluting the core emulation build with
> > Linux-specific
> > headers and libfuse3. The maintenance cost must be minimized. To addres=
s this,
> > I've refactored the architecture for v6 to ensure strict isolation:
> >
> > - All Linux and FUSE-specific headers are removed from public QEMU head=
ers.
> >   The internal state structure is now opaque and hidden inside
> > remote-i2c-cuse.c.
> > - The CUSE backend is isolated behind its own
> >   CONFIG_REMOTE_I2C_BACKEND_CUSE in Kconfig and meson.build, strictly
> >   depending on LINUX and fuse3.
> >
> > On macOS, Windows, or minimalistic builds without libfuse, QEMU will bu=
ild
> > cleanly without pulling in this backend or any of its dependencies.
> >
> > Would making the CUSE transport a strictly optional, isolated Linux-onl=
y backend
> > alleviate your concerns regarding the hardware emulation core?
> >
> > Best regards,
> > Ilya
> >
> > =D1=81=D1=80, 22 =D0=B8=D1=8E=D0=BB. 2026=E2=80=AF=D0=B3. =D0=B2 20:42,=
 C=C3=A9dric Le Goater <clg@redhat.com>:
> > >
> > > On 7/22/26 14:57, Ilya Chichkov wrote:
> > > > Add a "remote-i2c-master" device that exposes a QEMU I2C bus to the
> > > > host system through a FUSE/CUSE character device. This lets externa=
l
> > > > host programs and standard i2c-tools interact with I2C slaves emula=
ted
> > > > inside QEMU as if they were real devices attached to the host.
> > > >
> > > > The implementation is split into three layers:
> > > >
> > > >    - A non-blocking finite state machine that drives the QEMU I2C
> > > >      master. It is pumped by a QEMU Bottom Half and uses virtual ti=
mers
> > > >      to yield during long transfers and to model clock stretching f=
or
> > > >      asynchronous slaves, so the main loop is never blocked. The FS=
M
> > > >      walks IDLE -> ADDR -> SEND/RECV -> WAIT_STRETCH -> END -> FINI=
SHED
> > > >      and handles NACKs (ENXIO), lost arbitration (EBUSY, with optio=
nal
> > > >      back-off and retry), stretch timeouts, and manual abort/reset.
> > > >
> > > >    - An abstract RemoteI2CBackend QOM base class that decouples the
> > > >      internal I2C hardware state machine (the frontend) from any
> > > >      host-specific transport, exposing on_tx_complete and on_tx_err=
or
> > > >      virtual callbacks.
> > > >
> > > >    - A concrete remote-i2c-backend-cuse backend implementing that
> > > >      transport over CUSE. It manages the FUSE session and integrate=
s
> > > >      its file descriptors into QEMU's main AioContext event loop,
> > > >      translates Linux I2C_RDWR, I2C_SMBUS and I2C_SLAVE ioctls into
> > > >      generic byte streams for the FSM, and formats responses back i=
nto
> > > >      Linux I2C/SMBus structures for the FUSE driver. SMBus repeated
> > > >      start is supported for atomic write-then-read operations.
> > > >
> > > > Example usage:
> > > >
> > > >    -device remote-i2c-master,i2cbus=3Di2c-bus.0,devname=3Di2c-33
> > > >    -object remote-i2c-backend-cuse,id=3Db0,devname=3Di2c-33
> > > >
> > > > This creates /dev/i2c-33 on the host, usable with i2c-tools:
> > > >
> > > >    i2cdetect -y -l
> > > >    i2cget -y <bus_id> <addr> <reg>
> > > >
> > > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > > Signed-off-by: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
> > > > ---
> > > > v2:
> > > >    - docs/system/devices/remote-i2c-master.rst: Documented concurre=
nt
> > > >      bus access details and the 'raise-arbitrage-lost' property.
> > > > ---
> > > > v3:
> > > >    - qapi/qom.json: Fix RemoteI2CBackendCuseProperties formatting a=
nd
> > > >      expand member documentation (devname, fuse-opts, debug).
> > > >    - tests/qtest: Add remote-i2c-cuse-test covering capabilities,
> > > >      functional smoke test, synchronous sensor read/write.
> > > > ---
> > > > v4:
> > > >   - qapi: reference the rst doc via :doc:
> > > >   - qapi: fuse-opts is now ['str'] instead of a space-separated str=
ing
> > > >   - qapi: drop redundant 'debug' property (pass -d via fuse-opts)
> > > > ---
> > > > v5:
> > > >   - docs/system/device-emulation.rst: add remote-i2c-master.rst to
> > > >     the toctree under "Emulated Devices"
> > > >   - qapi/qom.json: move RemoteI2CBackendCuseProperties definition
> > > >     before RemoteObjectProperties as requested; change "for usage
> > > >     information" to "for detailed usage information"
> > > > ---
> > > > ---
> > > >   docs/system/device-emulation.rst          |    1 +
> > > >   docs/system/devices/remote-i2c-master.rst |  217 ++++
> > > >   hw/i2c/Kconfig                            |    5 +
> > > >   hw/i2c/meson.build                        |    6 +
> > > >   hw/i2c/remote-i2c-backend.c               |   30 +
> > > >   hw/i2c/remote-i2c-cuse.c                  | 1173 ++++++++++++++++=
+++++
> > > >   hw/i2c/remote-i2c-fsm.c                   |  521 +++++++++
> > > >   hw/i2c/remote-i2c-master.c                |  145 +++
> > > >   hw/i2c/trace-events                       |   29 +
> > > >   include/hw/i2c/remote-i2c-backend.h       |   70 ++
> > > >   include/hw/i2c/remote-i2c-cuse.h          |   93 ++
> > > >   include/hw/i2c/remote-i2c-master.h        |   77 ++
> > > >   qapi/qom.json                             |   29 +
> > > >   tests/qtest/meson.build                   |    2 +
> > > >   tests/qtest/remote-i2c-cuse-test.c        |  326 ++++++
> > > >   15 files changed, 2724 insertions(+)
> > > >   create mode 100644 docs/system/devices/remote-i2c-master.rst
> > > >   create mode 100644 hw/i2c/remote-i2c-backend.c
> > > >   create mode 100644 hw/i2c/remote-i2c-cuse.c
> > > >   create mode 100644 hw/i2c/remote-i2c-fsm.c
> > > >   create mode 100644 hw/i2c/remote-i2c-master.c
> > > >   create mode 100644 include/hw/i2c/remote-i2c-backend.h
> > > >   create mode 100644 include/hw/i2c/remote-i2c-cuse.h
> > > >   create mode 100644 include/hw/i2c/remote-i2c-master.h
> > > >   create mode 100644 tests/qtest/remote-i2c-cuse-test.c
> > >
> > > If I understand this proposal correctly, it lets host-side i2c
> > > tools talk to emulated I2C devices. The example is i2cdetect/i2cget
> > > against a tmp105 on an Aspeed bus.
> > >
> > > QEMU already has mechanisms for this though. qtest can read/write I2C
> > > registers programmatically, QMP can query device state, and the guest
> > > OS itself sees the I2C bus natively.
> > >
> > > The dependency cost seems high for the use case: libfuse3 + the cuse
> > > kernel module pulled into the system emulator build. It's also ~3K
> > > lines of new code, three QOM types, FUSE session management, etc.
> > > The surface area for bugs is large. It's a heavy burden for what it
> > > gives.
> > >
> > > I think a lighter QMP-based approach would serve the same purpose,
> > > maybe better, and fit in better in QEMU, without the dependency and
> > > maintenance cost:
> > >
> > > - No host kernel dependency
> > > - Works remotely (QMP over socket)
> > > - Fits QEMU's existing management model
> > > - Much less code
> > > - Testable without root or kernel modules
> > >
> > > Have you considered extending QMP with an I2C transaction command
> > > instead? Something like:
> > >
> > >    { 'command': 'i2c-transfer',
> > >      'data': { 'bus': 'str',
> > >                'address': 'uint8',
> > >                'read': 'bool',
> > >                '*data': ['uint8'],
> > >                '*length': 'uint16' },
> > >      'returns': { '*data': ['uint8'] } }
> > >
> > >
> > > Thanks,
> > >
> > > C.
> > >

