Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9DFC53200
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnHcq-0006SO-TB; Fri, 24 Jul 2026 11:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1wnHcS-0006R4-R3
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:15:26 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1wnHcM-0007Eh-Fv
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:15:21 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-495c63c41ceso210424b6e.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista.com; s=google; t=1784906117; x=1785510917; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:reply-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AshYf68n/2QN/x5hVXTjf4Z0ucWZ8pmi7g4d5sLYqqo=;
 b=kofAyu3Bww/FTS1ITMVOWMicYn17uNepjtUCLXHs/dA2ngVKSpRQgkbN7rjVgx4IFp
 QodcSPkFlitQMavX0fRvTS7Kb2xvI+5Zxbvf4jnDdPSVpqxtL9IVwmUMNLGmMzYm64W6
 H6cX/x/ZIhh2pTcpM9CiuGZhEO8KCr1J6TJmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784906117; x=1785510917;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AshYf68n/2QN/x5hVXTjf4Z0ucWZ8pmi7g4d5sLYqqo=;
 b=ddsAiJ8TiKdyztMyfHxRKTyF5lqrj9HHqYcPPQAxLBHjN4uvouvVcIgmdMKVmq/oXh
 ZqnlQVsa8g/N+UUc+Aa8NL1FVnvmzkukLtUoq3NF106iHh8wU+X3RnvXGShzYl3Es6nP
 in5mFguuMpMyfbEU5t50BDFWSPmlw1dRieNwhy51D92y0vsJRs0jPKqzanOiyXCAgeQb
 /fUqpwRPJHH7gfwxyWOBEiKhHICAkqHEzsvIabtgzKfSyRB1gxc0TEFpSgDTY+fOhU6e
 HMOXg/vtScue5XLdajI4HEUhasqKuz+uXc+asr0lXlr4y9GfT3TF3IckHeZin3cDysUN
 TgWA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4uK5oiZL1v5qDVXMMSK5tGorABzaeF3crqKCdNhgVWgKYjyA23c8NoHfyeFAegrIrM0EMc0EbrEPZ@nongnu.org
X-Gm-Message-State: AOJu0YwL97PyjbDdM0MfYqXd0Msh6B54gFKsP5bCGBqWTbUACDp0iBY/
 SRBLzy6VFv0foo/9j2ZpTEU3CCVC6esRe9+BgExndhJTA8YkfP5HD/s+2tb2ig0mum0=
X-Gm-Gg: AR+sD12XYjWLeiza/fzs7eFqbiUikprIxyLkri7442Kx9lpb0ooycKEx/zR28jRZGf8
 Nf/l5RpK1nEonpaKBjdmYg1OSZW8w3ibeZ0ruoFlryfvzSIvIZ2JrvLJOl77VMo8CtCdouS8miP
 pQGzFgxEOS8i8Qx0lXJKT7Y+l3KJhEqgHUUFvA7AnTcvIfq86TeHh+lTigHUxdmB2nZEIzDLG6O
 mbVi0GygdT8J0KDD9/bsE3Rdyl2qtItmPIus4dXK2fPmcI8Z+iyHyb1HaxJ1PbQ7IZs1zGmjv/J
 g071YsncfLGto4vekjBst4fQGo39tVHXBVWFwwnuZA+ID9xxpcTlPlODAKe/bhTshhZkhgQ5J6o
 ZAhopcDbYQ7bYHequl+v+baP9D5v3LXeGG1mG0Qe0yQSxuetGt3TuvezQkCDMUsdqVXvsCbKY/H
 BTr0d5wEw=
X-Received: by 2002:a05:6808:179b:b0:493:b6b8:c8b0 with SMTP id
 5614622812f47-4ab352fc079mr4644953b6e.14.1784906116382; 
 Fri, 24 Jul 2026 08:15:16 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:552c:1516:3a9f:867])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab2cd31929sm4615717b6e.4.2026.07.24.08.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 08:15:14 -0700 (PDT)
Date: Fri, 24 Jul 2026 10:15:11 -0500
From: Corey Minyard <cminyard@mvista.com>
To: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v5] hw/i2c: Add remote I2C master with host CUSE bridge
Message-ID: <amOBf20vEO1dteit@mail.minyard.net>
References: <20260722125713.406245-1-ilya.chichkov.dev@gmail.com>
 <50c0880d-6763-4788-8c66-be6c356a2e59@redhat.com>
 <CADgQP8xZo37VqCmqA8fey1_FgJSPi-PQRbDDeuKK-1LGYixYfw@mail.gmail.com>
 <amNpErR1oDqsQknD@mail.minyard.net>
 <CADgQP8yisWh1RBbxvahf9n46_phnjDxhQeCwxUEfx8+En0LNhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha-256; boundary="qy3QQJuwiI+Ed8X6"
Content-Disposition: inline
In-Reply-To: <CADgQP8yisWh1RBbxvahf9n46_phnjDxhQeCwxUEfx8+En0LNhA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=cminyard@mvista.com; helo=mail-oi1-x233.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: cminyard@mvista.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--qy3QQJuwiI+Ed8X6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 05:49:02PM +0300, Ilya Chichkov wrote:
> Hi Corey, C=C3=A9dric,
>=20
> On Fri, 24 Jul 2026 08:30:58 -0500, Corey Minyard <cminyard@mvista.com> w=
rote:
> > I think what C=C3=A9dric is saying here is that if you provided a gener=
ic
> > QMP interface that allowed these sorts of operations and wrote an
> > external program that used said interface to provide a fuse interface,
> > that would be better.
>=20
> I see your point about keeping the core emulator clean and minimizing
> dependencies.
>=20
> I am willing to pivot to this architectural direction. I can drop the CUSE
> backend from this patch series and instead implement the `i2c-transfer`
> QMP command, as C=C3=A9dric originally suggested. I will handle the CUSE
> part externally.
>=20
> Before I send v6, are there any other concerns regarding the core FSM
> logic, or would replacing CUSE with a QMP backend be sufficient?

I didn't see anything, it looked clean and well written to me, but I am
not as much of a QEMU expert as others.  I kind of happened into this as
I know a lot about IPMI and I2C.

-corey

>=20
> Best regards,
> Ilya
>=20
>=20
> =D0=BF=D1=82, 24 =D0=B8=D1=8E=D0=BB. 2026=E2=80=AF=D0=B3. =D0=B2 16:31, C=
orey Minyard <cminyard@mvista.com>:
> >
> > On Fri, Jul 24, 2026 at 11:19:17AM +0300, Ilya Chichkov wrote:
> > > Hi C=C3=A9dric,
> > >
> > > On Wed, 22 Jul 2026 19:42:03 +0200, C=C3=A9dric Le Goater <clg@redhat=
=2Ecom> wrote:
> > > > I think a lighter QMP-based approach would serve the same purpose,
> > > > maybe better, and fit in better in QEMU, without the dependency and
> > > > maintenance cost:
> > >
> > > As Corey and I discussed earlier in the thread, QMP doesn't cover the=
 primary
> > > motivation for this patch: zero-code transparency for existing host s=
oftware.
> > >
> > > An `i2c-transfer` QMP command would be a great addition for custom sc=
ripts,
> > > but the main goal here is to allow native Linux user-space binaries
> > > (like i2c-tools,
> > > lm-sensors) running on the host to talk to QEMU's I2C slaves unmodifi=
ed, simply
> > > by opening /dev/i2c-N. Rewriting legacy test suites to speak QMP JSON=
 over a
> > > socket is often not feasible.
> >
> > I think what C=C3=A9dric is saying here is that if you provided a gener=
ic
> > QMP interface that allowed these sorts of operations and wrote an
> > external program that used said interface to provide a fuse interface,
> > that would be better.  It has a number of advantages:
> >
> > * You add an interface to QEMU that others can easily use to test
> >   devices.
> >
> > * You are not tied to QEMU when you want to extend the functions of
> >   the fuse interface.
> >
> > * It's one less dependency in QEMU.  QEMU has a *lot* of dependencies,
> >   and the fewer the better.
> >
> > The only disadvantage I can think of is that it's one more piece of
> > software if you are setting this up.
> >
> > This is not a big piece of software, I agree, but from experience I
> > think you will be happier with this sort of design in the long run.
> > It puts you more in control of what you are doing.
> >
> > And, of course, it makes the QEMU maintainers happier :-).
> >
> > -corey
> >
> > >
> > > > The dependency cost seems high for the use case: libfuse3 + the cuse
> > > > kernel module pulled into the system emulator build. It's also ~3K
> > > > lines of new code, three QOM types, FUSE session management, etc.
> > >
> > > Regarding dependencies, `libfuse3` is actually not new to the project=
 =E2=80=94 it has
> > > been a supported QEMU dependency for a long time (already used by the=
 block
> > > layer in `block/export/fuse.c`). Also, just to clarify the diff: the =
core
> > > implementation is roughly ~2K lines. The remaining ~900 lines are ded=
icated
> > > entirely to qtests and RST documentation.
> > >
> > > However, I agree about not polluting the core emulation build with
> > > Linux-specific
> > > headers and libfuse3. The maintenance cost must be minimized. To addr=
ess this,
> > > I've refactored the architecture for v6 to ensure strict isolation:
> > >
> > > - All Linux and FUSE-specific headers are removed from public QEMU he=
aders.
> > >   The internal state structure is now opaque and hidden inside
> > > remote-i2c-cuse.c.
> > > - The CUSE backend is isolated behind its own
> > >   CONFIG_REMOTE_I2C_BACKEND_CUSE in Kconfig and meson.build, strictly
> > >   depending on LINUX and fuse3.
> > >
> > > On macOS, Windows, or minimalistic builds without libfuse, QEMU will =
build
> > > cleanly without pulling in this backend or any of its dependencies.
> > >
> > > Would making the CUSE transport a strictly optional, isolated Linux-o=
nly backend
> > > alleviate your concerns regarding the hardware emulation core?
> > >
> > > Best regards,
> > > Ilya
> > >
> > > =D1=81=D1=80, 22 =D0=B8=D1=8E=D0=BB. 2026=E2=80=AF=D0=B3. =D0=B2 20:4=
2, C=C3=A9dric Le Goater <clg@redhat.com>:
> > > >
> > > > On 7/22/26 14:57, Ilya Chichkov wrote:
> > > > > Add a "remote-i2c-master" device that exposes a QEMU I2C bus to t=
he
> > > > > host system through a FUSE/CUSE character device. This lets exter=
nal
> > > > > host programs and standard i2c-tools interact with I2C slaves emu=
lated
> > > > > inside QEMU as if they were real devices attached to the host.
> > > > >
> > > > > The implementation is split into three layers:
> > > > >
> > > > >    - A non-blocking finite state machine that drives the QEMU I2C
> > > > >      master. It is pumped by a QEMU Bottom Half and uses virtual =
timers
> > > > >      to yield during long transfers and to model clock stretching=
 for
> > > > >      asynchronous slaves, so the main loop is never blocked. The =
FSM
> > > > >      walks IDLE -> ADDR -> SEND/RECV -> WAIT_STRETCH -> END -> FI=
NISHED
> > > > >      and handles NACKs (ENXIO), lost arbitration (EBUSY, with opt=
ional
> > > > >      back-off and retry), stretch timeouts, and manual abort/rese=
t.
> > > > >
> > > > >    - An abstract RemoteI2CBackend QOM base class that decouples t=
he
> > > > >      internal I2C hardware state machine (the frontend) from any
> > > > >      host-specific transport, exposing on_tx_complete and on_tx_e=
rror
> > > > >      virtual callbacks.
> > > > >
> > > > >    - A concrete remote-i2c-backend-cuse backend implementing that
> > > > >      transport over CUSE. It manages the FUSE session and integra=
tes
> > > > >      its file descriptors into QEMU's main AioContext event loop,
> > > > >      translates Linux I2C_RDWR, I2C_SMBUS and I2C_SLAVE ioctls in=
to
> > > > >      generic byte streams for the FSM, and formats responses back=
 into
> > > > >      Linux I2C/SMBus structures for the FUSE driver. SMBus repeat=
ed
> > > > >      start is supported for atomic write-then-read operations.
> > > > >
> > > > > Example usage:
> > > > >
> > > > >    -device remote-i2c-master,i2cbus=3Di2c-bus.0,devname=3Di2c-33
> > > > >    -object remote-i2c-backend-cuse,id=3Db0,devname=3Di2c-33
> > > > >
> > > > > This creates /dev/i2c-33 on the host, usable with i2c-tools:
> > > > >
> > > > >    i2cdetect -y -l
> > > > >    i2cget -y <bus_id> <addr> <reg>
> > > > >
> > > > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > > > Signed-off-by: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
> > > > > ---
> > > > > v2:
> > > > >    - docs/system/devices/remote-i2c-master.rst: Documented concur=
rent
> > > > >      bus access details and the 'raise-arbitrage-lost' property.
> > > > > ---
> > > > > v3:
> > > > >    - qapi/qom.json: Fix RemoteI2CBackendCuseProperties formatting=
 and
> > > > >      expand member documentation (devname, fuse-opts, debug).
> > > > >    - tests/qtest: Add remote-i2c-cuse-test covering capabilities,
> > > > >      functional smoke test, synchronous sensor read/write.
> > > > > ---
> > > > > v4:
> > > > >   - qapi: reference the rst doc via :doc:
> > > > >   - qapi: fuse-opts is now ['str'] instead of a space-separated s=
tring
> > > > >   - qapi: drop redundant 'debug' property (pass -d via fuse-opts)
> > > > > ---
> > > > > v5:
> > > > >   - docs/system/device-emulation.rst: add remote-i2c-master.rst to
> > > > >     the toctree under "Emulated Devices"
> > > > >   - qapi/qom.json: move RemoteI2CBackendCuseProperties definition
> > > > >     before RemoteObjectProperties as requested; change "for usage
> > > > >     information" to "for detailed usage information"
> > > > > ---
> > > > > ---
> > > > >   docs/system/device-emulation.rst          |    1 +
> > > > >   docs/system/devices/remote-i2c-master.rst |  217 ++++
> > > > >   hw/i2c/Kconfig                            |    5 +
> > > > >   hw/i2c/meson.build                        |    6 +
> > > > >   hw/i2c/remote-i2c-backend.c               |   30 +
> > > > >   hw/i2c/remote-i2c-cuse.c                  | 1173 ++++++++++++++=
+++++++
> > > > >   hw/i2c/remote-i2c-fsm.c                   |  521 +++++++++
> > > > >   hw/i2c/remote-i2c-master.c                |  145 +++
> > > > >   hw/i2c/trace-events                       |   29 +
> > > > >   include/hw/i2c/remote-i2c-backend.h       |   70 ++
> > > > >   include/hw/i2c/remote-i2c-cuse.h          |   93 ++
> > > > >   include/hw/i2c/remote-i2c-master.h        |   77 ++
> > > > >   qapi/qom.json                             |   29 +
> > > > >   tests/qtest/meson.build                   |    2 +
> > > > >   tests/qtest/remote-i2c-cuse-test.c        |  326 ++++++
> > > > >   15 files changed, 2724 insertions(+)
> > > > >   create mode 100644 docs/system/devices/remote-i2c-master.rst
> > > > >   create mode 100644 hw/i2c/remote-i2c-backend.c
> > > > >   create mode 100644 hw/i2c/remote-i2c-cuse.c
> > > > >   create mode 100644 hw/i2c/remote-i2c-fsm.c
> > > > >   create mode 100644 hw/i2c/remote-i2c-master.c
> > > > >   create mode 100644 include/hw/i2c/remote-i2c-backend.h
> > > > >   create mode 100644 include/hw/i2c/remote-i2c-cuse.h
> > > > >   create mode 100644 include/hw/i2c/remote-i2c-master.h
> > > > >   create mode 100644 tests/qtest/remote-i2c-cuse-test.c
> > > >
> > > > If I understand this proposal correctly, it lets host-side i2c
> > > > tools talk to emulated I2C devices. The example is i2cdetect/i2cget
> > > > against a tmp105 on an Aspeed bus.
> > > >
> > > > QEMU already has mechanisms for this though. qtest can read/write I=
2C
> > > > registers programmatically, QMP can query device state, and the gue=
st
> > > > OS itself sees the I2C bus natively.
> > > >
> > > > The dependency cost seems high for the use case: libfuse3 + the cuse
> > > > kernel module pulled into the system emulator build. It's also ~3K
> > > > lines of new code, three QOM types, FUSE session management, etc.
> > > > The surface area for bugs is large. It's a heavy burden for what it
> > > > gives.
> > > >
> > > > I think a lighter QMP-based approach would serve the same purpose,
> > > > maybe better, and fit in better in QEMU, without the dependency and
> > > > maintenance cost:
> > > >
> > > > - No host kernel dependency
> > > > - Works remotely (QMP over socket)
> > > > - Fits QEMU's existing management model
> > > > - Much less code
> > > > - Testable without root or kernel modules
> > > >
> > > > Have you considered extending QMP with an I2C transaction command
> > > > instead? Something like:
> > > >
> > > >    { 'command': 'i2c-transfer',
> > > >      'data': { 'bus': 'str',
> > > >                'address': 'uint8',
> > > >                'read': 'bool',
> > > >                '*data': ['uint8'],
> > > >                '*length': 'uint16' },
> > > >      'returns': { '*data': ['uint8'] } }
> > > >
> > > >
> > > > Thanks,
> > > >
> > > > C.
> > > >

--qy3QQJuwiI+Ed8X6
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIINIQYJKoZIhvcNAQcCoIINEjCCDQ4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgggpVMIIFXzCCBEegAwIBAgIQD/rh8xorQzw9muFtZDtYizANBgkqhkiG9w0BAQsFADBl
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGln
aWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVkIElEIFJvb3QgRzIwHhcNMTkw
OTIzMTIyNTMyWhcNMzQwOTIzMTIyNTMyWjBqMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGln
aUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSkwJwYDVQQDEyBEaWdpQ2Vy
dCBBc3N1cmVkIElEIENsaWVudCBDQSBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAOqxRa06rLwKBvrDb/qQ8RtXfeKA9o0A42oZbLF4GYr4Xdt9JE8r3PJRIOUZD1U3mEln
4S/aZoS54Q+5Ecs3q2GGT/Z82VeAPLeGvJoT0LS5t/zXeUcbMuDFWgyj33kiesnuusnOWvpI
SoxN+oBH4oo0+oUiHI65mMjMAlb93x6sabh9kKvHQvHC4x2u7wYv5+NXjnbOhJS/1NjGq+ug
LMXeldFMz0O5qFIDpn3aQGU0htyJQ2SZyxEqlUrgunsrYj9wgfW7XuhAi2j0y5d9oMT0SuVe
KFFnQhTEk5B3fq+OBOW0AU2JdW1r929UtRbAr8RpLt05WI2G2RNVVlHYaU0CAwEAAaOCAgQw
ggIAMB0GA1UdDgQWBBSlYiBQ3LtbV5etI4814lRsqX75TjAfBgNVHSMEGDAWgBTOw0q5mVXy
uNtgv6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwTAYDVR0lBEUwQwYIKwYBBQUHAwIGCCsG
AQUFBwMEBgorBgEEAYI3CgMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMMBgkqhkiG9y8BAQUw
EgYDVR0TAQH/BAgwBgEB/wIBADA0BggrBgEFBQcBAQQoMCYwJAYIKwYBBQUHMAGGGGh0dHA6
Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8vY3JsMy5kaWdp
Y2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290RzIuY3JsMIHOBgNVHSAEgcYwgcMwgcAG
BFUdIAAwgbcwKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwgYoG
CCsGAQUFBwICMH4MfEFueSB1c2Ugb2YgdGhpcyBDZXJ0aWZpY2F0ZSBjb25zdGl0dXRlcyBh
Y2NlcHRhbmNlIG9mIHRoZSBSZWx5aW5nIFBhcnR5IEFncmVlbWVudCBsb2NhdGVkIGF0IGh0
dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9ycGEtdWEwDQYJKoZIhvcNAQELBQADggEBAHZrbCQC
o3MAIqR0kekGYrC70EAGRDRq11COufNEXhcpv3YH6BMhUoVinPPNgfo5HPrZAFrLK/KPXYdJ
dgkASGsINabAfY2ljUaJwKlpIewwjS6KuGEn59MgidaAUPh6lbetIoRsLhCqCzAnX1aL99fj
CMf4NMWLUC8TqotnnrKNuw4JSjx4fcQs+U5T1bbgnyDx+8ybONuIEDvinHdKDu2VjoECzez2
y/1IVTPlh57zBfjHJQFqLWzHdou8M+ucdJtr2swXII6s3nkq4pfEn7KnbzMS9quFSuyOGILc
g/3qVwaHNLM5R+8nB5gPI5+u5Uh56w1i+9Ds1pjYAiTHdeUwggTuMIID1qADAgECAhAImztE
U4o9odkEsuVgiJc8MA0GCSqGSIb3DQEBCwUAMGoxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxE
aWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xKTAnBgNVBAMTIERpZ2lD
ZXJ0IEFzc3VyZWQgSUQgQ2xpZW50IENBIEcyMB4XDTI0MDUwMzAwMDAwMFoXDTI2MDUwNjIz
NTk1OVowQjEcMBoGA1UEAwwTY21pbnlhcmRAbXZpc3RhLmNvbTEiMCAGCSqGSIb3DQEJARYT
Y21pbnlhcmRAbXZpc3RhLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJm1
ZE9brEiQnF7EKiV+aYzHyqPFJ+z1wwdJ4wvNiwUCgXJejBxFj04Z7A62Yx6Sp59vfjbo05eA
IOyaLOFp3vbMBQAe8Qe4XrFv7wPcKZxwS+sgCuBvNs4NVGKYGjiKZW8WPq9ZcEl5BM8BLMrl
rchAUHJJcMdcEJUsed6rIB//EtnGOe74/vR1Tz3sN1WzC1Wa9COvcbLgVvWC/o4WysUfC9+f
9/5JzAiib7U7S/iRigkmEahibZgYKB7y6F1v9hxUwHxfa7GtJ8cv6LtRcPLhAO86GgXMfpgq
k3fxzQu8uwACpINbmQNLcRzg6mHFDYRK3mFp4puUnHO5EUJ8RgUCAwEAAaOCAbYwggGyMB8G
A1UdIwQYMBaAFKViIFDcu1tXl60jjzXiVGypfvlOMB0GA1UdDgQWBBQiHrUOKuj1vJe3OXAz
gOP5Qbl2FTAeBgNVHREEFzAVgRNjbWlueWFyZEBtdmlzdGEuY29tMBQGA1UdIAQNMAswCQYH
Z4EMAQUBATAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwME
MIGLBgNVHR8EgYMwgYAwPqA8oDqGOGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2Vy
dEFzc3VyZWRJRENsaWVudENBRzIuY3JsMD6gPKA6hjhodHRwOi8vY3JsNC5kaWdpY2VydC5j
b20vRGlnaUNlcnRBc3N1cmVkSURDbGllbnRDQUcyLmNybDB9BggrBgEFBQcBAQRxMG8wJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBHBggrBgEFBQcwAoY7aHR0cDov
L2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEQ2xpZW50Q0FHMi5jcnQw
DQYJKoZIhvcNAQELBQADggEBADkBdRyx41eUGmsYXBXt3WCsYeDr26rJL7lbx2PvqaZyRCJm
J9CN2TljF0YHsXSPU+un1RfUlYz+PtcNFIqNuSf3N5fGU0bEpSzXozd/nZ32yWFLkd5CzYyN
F1xrpbyP2a87jKM0uqEHXZFl7NPiAfEchjFCddciHTOXjN66L+kJ/ZsOoNJLG8yFN401EGew
Nk8z/hJjWqR7DG0/YWn9h7jQ5SmqkqyhLwTO9s6KoByacWuKpKWSc/DaOuWmROlROrOA1hD8
0sKqC6jGeLxNpiYzSwBy8qKF0weZdhcHUeO1HOm1csrvWl1UghnlR7SLir3bb5LiesTVvSuR
Q3aDywAxggKQMIICjAIBATB+MGoxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJ
bmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xKTAnBgNVBAMTIERpZ2lDZXJ0IEFzc3Vy
ZWQgSUQgQ2xpZW50IENBIEcyAhAImztEU4o9odkEsuVgiJc8MA0GCWCGSAFlAwQCAQUAoIHk
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDcyNDE1MTUx
MVowLwYJKoZIhvcNAQkEMSIEINC9kNd/cphPMOWpRAEbc+gl5aCxjwiO1aLPJhE1jr7CMHkG
CSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIw
CgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0G
CCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBAG02Byu8oSxiVgu22AKp4fvXzgQ6qA1O
TeKF2/Jwf4BujfaBmECXhhuoI9w42zt+hJChcwbqOvfB9FLjV/mQtGohh7PEcMpvD5K35fM4
is7pzt9+Oiyeqys8EOgHCrFBbYrUZ6hhboBcwtHfE39fVfLcn4eUzHdKIR276c8/nMhXtTe2
yE3tdDKWljNUCKw7PBtkRx22SbXhIY7Q2wWFv7qh39KXgE67/Hg0dhJTssJbEfyrUluutF/t
s+OAxFDl89Zg0AcCYm2TbJPJvxJv7zu+bdGiCUgM9P2bWjbN01b44Z2nitAJ2D/ZnPszHdHi
vf4rF1vmPLUpK1s5BkMX+f4=

--qy3QQJuwiI+Ed8X6--

