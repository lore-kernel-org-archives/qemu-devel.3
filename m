Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AEBC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFzc-0001Vd-EK; Fri, 24 Jul 2026 09:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1wnFza-0001VN-La
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:31:10 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1wnFzX-0007J5-VF
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:31:10 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-448b69cfc6dso305366fac.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista.com; s=google; t=1784899865; x=1785504665; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:reply-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dVbB1kCLRkdJcrouZXgqMZMSBIJPMNc8eD5nlDeLho0=;
 b=f2k1/4X+ALXL0Zhs4JSKUdg8vUswHtiyxn2lVlcX2/OV4xznGdtEDrlEO7D553Zx7w
 /gBeh7U9lV/G6wNrWXlHvgRHgtRl5n/nX5H63ZKvEYUeVwpuQy88Z5f/ueTQy9FGnvTQ
 coulBVMz92plkPp08mJWj4Ol1lADxYGuIM2UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784899865; x=1785504665;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dVbB1kCLRkdJcrouZXgqMZMSBIJPMNc8eD5nlDeLho0=;
 b=HRn52/t63Px501osBx+TDWjxU+nImnqII0ppeq0mWpJKPxpn+3t+1BVkYnZqJ+Y2o0
 VbfbbUFcNjn+wbVjia+SAEuTuy/ch7yodzkRCt6OBypwfOGRSp5v/0r3Fm7hWiU89hZF
 DqrLYKBuLFA6o0/bR4KsBeMv9P371zpNUlTtbvz+R4WIuhWgW27xTUTjJR1fLTrUa0Ae
 wnObgZ2MZ9/88AuQ9b0VgzlJvHkW+tmgU6ZImOmzDH6B16Cuu8J6FluymKH1+q/zBNDj
 /lvKZRKDJrwjEMo4NopuFViAMbhmqXWRMAJWylwS2KlJqHQvEp5XC1qTRiZ1TB9UctP5
 mAzg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHVzNqqBdYOt5LzEV9YOG1FDT+mYg+7iKgbvkXnF94cWzMqEUQPy50aZB+/rKln5aoLAk4puy7E64k@nongnu.org
X-Gm-Message-State: AOJu0Yw4FJ956A7462k7kq5ArHe1Hxt03Lqx8c9Lg+/ff3qk83BX9xUV
 gtNMPbTLgM+x2r5A8ziq+vYtnqpCUuZpdwzB/CKQ+00wpVdZ6vBVKQhRmlwWHUpCePQ=
X-Gm-Gg: AR+sD12NLIL1eyHJZmD3fnbrfmZF82NIubRg1LeSR4UUaOaWYJ1Ba6jJhI7mh9vgmmL
 GVRfC3AFtBO2yNpuXVeX3Kt9EFqoF/m3GoodzYzQjCf1+EslF9bqfYCIh63e/VOZTyqGvJHjc2a
 XTnMVE3J/006pCHvaWXOYhctt2qtgmmJ8ecC2mRDelAIe67SlX7CIvo+2uE06NsaF7Qz5yNp2bX
 Giu2Q2GFzUDJkb7CfFlIq6mJEnKN1RpyIQOcGB8ekGGN1bQqVtf+lTKPjN/Z3c/JVSMPuQwErtz
 LWZXqEzmGSZir1pa3Hw8jndAM6RyLD44iGkY2vynhOj3PcXUpGWyWIoShwGklD/XYY8CMpa1NHP
 y1akm/KtHfr16MSesf6eOAsKgMzE7jqmzqscPZzBVV7a2cup9merZJP39dp8Z9ynO2Jp6Z6MegV
 7bIJ0wJaM=
X-Received: by 2002:a05:6808:3012:b0:497:dedc:605c with SMTP id
 5614622812f47-4ab352e49ecmr4269296b6e.7.1784899865091; 
 Fri, 24 Jul 2026 06:31:05 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:552c:1516:3a9f:867])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45766e7d8cdsm6424901fac.1.2026.07.24.06.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:31:02 -0700 (PDT)
Date: Fri, 24 Jul 2026 08:30:58 -0500
From: Corey Minyard <cminyard@mvista.com>
To: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v5] hw/i2c: Add remote I2C master with host CUSE bridge
Message-ID: <amNpErR1oDqsQknD@mail.minyard.net>
References: <20260722125713.406245-1-ilya.chichkov.dev@gmail.com>
 <50c0880d-6763-4788-8c66-be6c356a2e59@redhat.com>
 <CADgQP8xZo37VqCmqA8fey1_FgJSPi-PQRbDDeuKK-1LGYixYfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha-256; boundary="WErljGIo5nwvE5lT"
Content-Disposition: inline
In-Reply-To: <CADgQP8xZo37VqCmqA8fey1_FgJSPi-PQRbDDeuKK-1LGYixYfw@mail.gmail.com>
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=cminyard@mvista.com; helo=mail-oa1-x2e.google.com
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


--WErljGIo5nwvE5lT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 11:19:17AM +0300, Ilya Chichkov wrote:
> Hi C=C3=A9dric,
>=20
> On Wed, 22 Jul 2026 19:42:03 +0200, C=C3=A9dric Le Goater <clg@redhat.com=
> wrote:
> > I think a lighter QMP-based approach would serve the same purpose,
> > maybe better, and fit in better in QEMU, without the dependency and
> > maintenance cost:
>=20
> As Corey and I discussed earlier in the thread, QMP doesn't cover the pri=
mary
> motivation for this patch: zero-code transparency for existing host softw=
are.
>=20
> An `i2c-transfer` QMP command would be a great addition for custom script=
s,
> but the main goal here is to allow native Linux user-space binaries
> (like i2c-tools,
> lm-sensors) running on the host to talk to QEMU's I2C slaves unmodified, =
simply
> by opening /dev/i2c-N. Rewriting legacy test suites to speak QMP JSON ove=
r a
> socket is often not feasible.

I think what C=C3=A9dric is saying here is that if you provided a generic
QMP interface that allowed these sorts of operations and wrote an
external program that used said interface to provide a fuse interface,
that would be better.  It has a number of advantages:

* You add an interface to QEMU that others can easily use to test
  devices.

* You are not tied to QEMU when you want to extend the functions of
  the fuse interface.

* It's one less dependency in QEMU.  QEMU has a *lot* of dependencies,
  and the fewer the better.

The only disadvantage I can think of is that it's one more piece of
software if you are setting this up.

This is not a big piece of software, I agree, but from experience I
think you will be happier with this sort of design in the long run.
It puts you more in control of what you are doing.

And, of course, it makes the QEMU maintainers happier :-).

-corey

>=20
> > The dependency cost seems high for the use case: libfuse3 + the cuse
> > kernel module pulled into the system emulator build. It's also ~3K
> > lines of new code, three QOM types, FUSE session management, etc.
>=20
> Regarding dependencies, `libfuse3` is actually not new to the project =E2=
=80=94 it has
> been a supported QEMU dependency for a long time (already used by the blo=
ck
> layer in `block/export/fuse.c`). Also, just to clarify the diff: the core
> implementation is roughly ~2K lines. The remaining ~900 lines are dedicat=
ed
> entirely to qtests and RST documentation.
>=20
> However, I agree about not polluting the core emulation build with
> Linux-specific
> headers and libfuse3. The maintenance cost must be minimized. To address =
this,
> I've refactored the architecture for v6 to ensure strict isolation:
>=20
> - All Linux and FUSE-specific headers are removed from public QEMU header=
s.
>   The internal state structure is now opaque and hidden inside
> remote-i2c-cuse.c.
> - The CUSE backend is isolated behind its own
>   CONFIG_REMOTE_I2C_BACKEND_CUSE in Kconfig and meson.build, strictly
>   depending on LINUX and fuse3.
>=20
> On macOS, Windows, or minimalistic builds without libfuse, QEMU will build
> cleanly without pulling in this backend or any of its dependencies.
>=20
> Would making the CUSE transport a strictly optional, isolated Linux-only =
backend
> alleviate your concerns regarding the hardware emulation core?
>=20
> Best regards,
> Ilya
>=20
> =D1=81=D1=80, 22 =D0=B8=D1=8E=D0=BB. 2026=E2=80=AF=D0=B3. =D0=B2 20:42, C=
=C3=A9dric Le Goater <clg@redhat.com>:
> >
> > On 7/22/26 14:57, Ilya Chichkov wrote:
> > > Add a "remote-i2c-master" device that exposes a QEMU I2C bus to the
> > > host system through a FUSE/CUSE character device. This lets external
> > > host programs and standard i2c-tools interact with I2C slaves emulated
> > > inside QEMU as if they were real devices attached to the host.
> > >
> > > The implementation is split into three layers:
> > >
> > >    - A non-blocking finite state machine that drives the QEMU I2C
> > >      master. It is pumped by a QEMU Bottom Half and uses virtual time=
rs
> > >      to yield during long transfers and to model clock stretching for
> > >      asynchronous slaves, so the main loop is never blocked. The FSM
> > >      walks IDLE -> ADDR -> SEND/RECV -> WAIT_STRETCH -> END -> FINISH=
ED
> > >      and handles NACKs (ENXIO), lost arbitration (EBUSY, with optional
> > >      back-off and retry), stretch timeouts, and manual abort/reset.
> > >
> > >    - An abstract RemoteI2CBackend QOM base class that decouples the
> > >      internal I2C hardware state machine (the frontend) from any
> > >      host-specific transport, exposing on_tx_complete and on_tx_error
> > >      virtual callbacks.
> > >
> > >    - A concrete remote-i2c-backend-cuse backend implementing that
> > >      transport over CUSE. It manages the FUSE session and integrates
> > >      its file descriptors into QEMU's main AioContext event loop,
> > >      translates Linux I2C_RDWR, I2C_SMBUS and I2C_SLAVE ioctls into
> > >      generic byte streams for the FSM, and formats responses back into
> > >      Linux I2C/SMBus structures for the FUSE driver. SMBus repeated
> > >      start is supported for atomic write-then-read operations.
> > >
> > > Example usage:
> > >
> > >    -device remote-i2c-master,i2cbus=3Di2c-bus.0,devname=3Di2c-33
> > >    -object remote-i2c-backend-cuse,id=3Db0,devname=3Di2c-33
> > >
> > > This creates /dev/i2c-33 on the host, usable with i2c-tools:
> > >
> > >    i2cdetect -y -l
> > >    i2cget -y <bus_id> <addr> <reg>
> > >
> > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > Signed-off-by: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
> > > ---
> > > v2:
> > >    - docs/system/devices/remote-i2c-master.rst: Documented concurrent
> > >      bus access details and the 'raise-arbitrage-lost' property.
> > > ---
> > > v3:
> > >    - qapi/qom.json: Fix RemoteI2CBackendCuseProperties formatting and
> > >      expand member documentation (devname, fuse-opts, debug).
> > >    - tests/qtest: Add remote-i2c-cuse-test covering capabilities,
> > >      functional smoke test, synchronous sensor read/write.
> > > ---
> > > v4:
> > >   - qapi: reference the rst doc via :doc:
> > >   - qapi: fuse-opts is now ['str'] instead of a space-separated string
> > >   - qapi: drop redundant 'debug' property (pass -d via fuse-opts)
> > > ---
> > > v5:
> > >   - docs/system/device-emulation.rst: add remote-i2c-master.rst to
> > >     the toctree under "Emulated Devices"
> > >   - qapi/qom.json: move RemoteI2CBackendCuseProperties definition
> > >     before RemoteObjectProperties as requested; change "for usage
> > >     information" to "for detailed usage information"
> > > ---
> > > ---
> > >   docs/system/device-emulation.rst          |    1 +
> > >   docs/system/devices/remote-i2c-master.rst |  217 ++++
> > >   hw/i2c/Kconfig                            |    5 +
> > >   hw/i2c/meson.build                        |    6 +
> > >   hw/i2c/remote-i2c-backend.c               |   30 +
> > >   hw/i2c/remote-i2c-cuse.c                  | 1173 ++++++++++++++++++=
+++
> > >   hw/i2c/remote-i2c-fsm.c                   |  521 +++++++++
> > >   hw/i2c/remote-i2c-master.c                |  145 +++
> > >   hw/i2c/trace-events                       |   29 +
> > >   include/hw/i2c/remote-i2c-backend.h       |   70 ++
> > >   include/hw/i2c/remote-i2c-cuse.h          |   93 ++
> > >   include/hw/i2c/remote-i2c-master.h        |   77 ++
> > >   qapi/qom.json                             |   29 +
> > >   tests/qtest/meson.build                   |    2 +
> > >   tests/qtest/remote-i2c-cuse-test.c        |  326 ++++++
> > >   15 files changed, 2724 insertions(+)
> > >   create mode 100644 docs/system/devices/remote-i2c-master.rst
> > >   create mode 100644 hw/i2c/remote-i2c-backend.c
> > >   create mode 100644 hw/i2c/remote-i2c-cuse.c
> > >   create mode 100644 hw/i2c/remote-i2c-fsm.c
> > >   create mode 100644 hw/i2c/remote-i2c-master.c
> > >   create mode 100644 include/hw/i2c/remote-i2c-backend.h
> > >   create mode 100644 include/hw/i2c/remote-i2c-cuse.h
> > >   create mode 100644 include/hw/i2c/remote-i2c-master.h
> > >   create mode 100644 tests/qtest/remote-i2c-cuse-test.c
> >
> > If I understand this proposal correctly, it lets host-side i2c
> > tools talk to emulated I2C devices. The example is i2cdetect/i2cget
> > against a tmp105 on an Aspeed bus.
> >
> > QEMU already has mechanisms for this though. qtest can read/write I2C
> > registers programmatically, QMP can query device state, and the guest
> > OS itself sees the I2C bus natively.
> >
> > The dependency cost seems high for the use case: libfuse3 + the cuse
> > kernel module pulled into the system emulator build. It's also ~3K
> > lines of new code, three QOM types, FUSE session management, etc.
> > The surface area for bugs is large. It's a heavy burden for what it
> > gives.
> >
> > I think a lighter QMP-based approach would serve the same purpose,
> > maybe better, and fit in better in QEMU, without the dependency and
> > maintenance cost:
> >
> > - No host kernel dependency
> > - Works remotely (QMP over socket)
> > - Fits QEMU's existing management model
> > - Much less code
> > - Testable without root or kernel modules
> >
> > Have you considered extending QMP with an I2C transaction command
> > instead? Something like:
> >
> >    { 'command': 'i2c-transfer',
> >      'data': { 'bus': 'str',
> >                'address': 'uint8',
> >                'read': 'bool',
> >                '*data': ['uint8'],
> >                '*length': 'uint16' },
> >      'returns': { '*data': ['uint8'] } }
> >
> >
> > Thanks,
> >
> > C.
> >

--WErljGIo5nwvE5lT
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
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDcyNDEzMzA1
OFowLwYJKoZIhvcNAQkEMSIEIDzp/5scY4RBaqWVquUs6DLtfAnXc8tsNfEhA91apd8tMHkG
CSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIw
CgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0G
CCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBAChYORHNrL43M/7a7bK+EBqpURJRMERz
a126QP6PvuqNdhPCwXaXdozSErWpoxLPYOHLcJE+IQO8A35blWoQbWP7MFrWn6P1kNRD3AYO
uwmpA+3hQCL3/xUXXVKo1paAoqF6t7O8WFK0CuHDlE68eXW9X0DiFBaG/gO8IxAW/D8znFfR
IwN4bVHpHT7/USwkgkfbIkvIQIDCLo+PXhSgpJPPWkealGEC+qUW79bPnfZQuNkfvnP3jECk
Ao0oTQat3EOjWsMQK2Q3xgzxQpXuvv+kw0274ScQGNZ6J/Rp692ao7Z3c5mm8vk+RBUU5B49
uJDpwCwriJoBigGtU2GC8Iw=

--WErljGIo5nwvE5lT--

