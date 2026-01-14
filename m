Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D3AD3900E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 19:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg6WU-0005Il-SW; Wed, 14 Jan 2026 14:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vg6WR-0005IE-Jy
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 14:27:15 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vg6WK-0006nG-Ik
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 14:27:13 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b8712507269so28500366b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 11:27:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768418822; cv=none;
 d=google.com; s=arc-20240605;
 b=RQpJ+1TBGnqHdRgfDp91oDknHFxv+mG2WBpHMsvCLjRXJRkcXMU9vKiBJi70DhSUNJ
 gjLUihavAtPlVBtQrHZ/1slt8eCvfgA+YIpouJ9U6C3i3slzToIVcgbk4zGvaQav7/Qc
 opFoKXsWSHyOkjz6zpfr6rjf0NiCk/i9iwPk58pkumo6/RS7Wlbm+krd6rYsPMvcOLO4
 DS6agSP5HtTF4QEVHFL+weO7AnxZ8g6Lo1xMJNvGR4V2wYJVQfqwLXzUCv3rNElscFgL
 /QDiKV+TonP19lkqHXHfN/JqlT0pwJM+AfaF0drCgC0jydNm6Nz89pVE7PHbei20rD6r
 U3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=itGWxuNUXKr4Klr3rfnGOaIQ9XzrtNIw8H2hVEZJkps=;
 fh=ajcKIrFaX/WWiPJaae3b69xSfX0Kkhvd4oW+e5d+YeQ=;
 b=GathGl/LZ0s6qjsQfFLZ/9rmNthmdG19S2J2SFMSw9ybAZZrVJ3wX/NjcL8ki4sbYE
 e7jrFVKehzFy/0IUXMN1abRW+Yj0liDQzvE7q2IfA6qhl+agbw7V8gfoqk9Jk1NsWW4M
 2vLpWU91j5VA7FG3005qie0TI80vgxYZNZDG1W8vbLNmhbAhNPqssqTWQWgrrxLUCyP4
 2WRr5yIpKRlsln0w9OyRe2aygvsvsw47twnbHsvxFZRiYh3RC4jSP51IvF1FHbpvIv2G
 UsZuY7vdXY5fOumRoQTgJqV8VEiYEzxyYP/bw3jQ5OdMEKOvJW/n5RVWeBkjfeMziWt8
 6qhw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768418822; x=1769023622; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=itGWxuNUXKr4Klr3rfnGOaIQ9XzrtNIw8H2hVEZJkps=;
 b=GfnDYErlyQlTFY2LM16BLGPqvoLPZAwau2FFvMbhZ1h/uH4/MJdmnUQ2JRftvzEhtQ
 r9X43buHfNZ1jmg/JJO5eWmtD/cVIoPMYLiLNsXB/ZXNuREPulpcAf50Cd4Ep0ZPqaV6
 rwid1GdhwfVoegHmEsiiTibY02HUdJsqCdUULgkv/Y6edviFFQw78f0hpa12c3XbeP3N
 N9MRfFSuzHfiYdsl3GlN1dkJKdkrT4L1c88kQ+WOenNjdLd9/xoPr7Lfa7FlI1eHoPU0
 J2+NjvA5qZrOYhr4DC40dl2HT8CyKTE5mHV/3fvyM6BPFKVAr1h/wfNZFyqANRy3m3NH
 aIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768418822; x=1769023622;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=itGWxuNUXKr4Klr3rfnGOaIQ9XzrtNIw8H2hVEZJkps=;
 b=ATAqJs5FmuSSg/D+v11qm2m/yoI0MJmXQ3Vi9EIKNu2iaOV5nhmjJjl79IM9ZBRBAn
 OUrfmOa/NwZyY5cKZxVcbvsAgxf8FK93ZAd9nUsXpr+dudyvVfCdE6UHUa2NSABO+1eQ
 vlGjQpEudmSl8YKnh4eDfdgPS85vzVGClYb7N/6IrNogJ1v9+TeqpDOwF0EL/i9XBCTc
 IoiBxxAT1TaPZs6wIffnop/8okd0pEhLdGqsJsoLhDPsvUp35u+dsHmEfnKTFpnZnoI0
 bq/UdnauVbMZrL53N9JekackS3roges7pq+7wWczTrfYa2Di/TeZRE5BWr6hQsvE1RsQ
 F7jg==
X-Gm-Message-State: AOJu0YxF6nxO8DCZHXY2fodGIqf6AfVLtwMO233SCiX0uawj43XT87Iv
 6v8ue9rMYImrZQSqOvnr2HsUWSi6vU8l/B146F7Db1mewm0+FIkNGOiLoeRtsnLS/GinmsgRtga
 2iEE091giFl1tGNti+RGb5hfbIwivOME=
X-Gm-Gg: AY/fxX7QJQVlTuWYnlpCRYc67Vwqajlu5Z/r40OIInJzir5xYjGxwouv7lC9C1wm7L6
 jGnXRQXJm0AjbZ+4rNfAAKQbZY3ExnANh9Slg1H8sNVb/I9D/qhOSBq+jbAVoa5JWSsb/xgmWhU
 ScfkyQleETtNqRtRZ7uQsykZ3mTGaKTiAZWemZSR9nAzjQgF34ZbFAQXL0IGbCGorg5MTcsq+Fi
 cyKmd2SuYWnoPU177A4p0GUCPzfCRWEOXGuzherkdnsXIF4NV0Mng9ESmjyIs/CkSnRvSmhjRjY
 elsE
X-Received: by 2002:a17:907:1b07:b0:b83:32b7:21b0 with SMTP id
 a640c23a62f3a-b8761080312mr330570966b.17.1768418821609; Wed, 14 Jan 2026
 11:27:01 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
In-Reply-To: <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 14 Jan 2026 14:26:48 -0500
X-Gm-Features: AZwV_QhGt3axNkykzL3oY3gQVBo1JCpygC8YOady8GhZ2b4JvQuIJfnDtIjGlyM
Message-ID: <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 German Maglione <gmaglione@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, danpb@redhat.com, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62e.google.com
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

On Wed, Jan 14, 2026 at 1:01=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> On Tue, Jan 6, 2026 at 1:47=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
> Rather than replying to this mail, I sketched some ideas of things I have=
 in mind on the wiki directly:
>
> https://wiki.qemu.org/Internships/ProjectIdeas/RDPUSB

Excellent! This one looks ready to go because it's self-contained.

> https://wiki.qemu.org/Internships/ProjectIdeas/VFIOUSER
> https://wiki.qemu.org/Internships/ProjectIdeas/ModernHMP
> https://wiki.qemu.org/Internships/ProjectIdeas/mkosiTestAssets

These three involve additional maintainers and require consensus
before they can be listed. This way we can be confident that the
intern's work will not be held up later by design discussions from
people who are not yet on board with the idea.

> I will try to reach the various people involved in those related projects=
 to see if they are reasonable proposals.
>
> We have a lot of ideas on the wiki (https://wiki.qemu.org/Internships/Pro=
jectIdeas/), that have various status.. I wonder if they wouldn't be better=
 under qemu.git docs/ with some form, so we could send patches to discuss t=
hem instead. Arf, a QEMU Enhancement Proposal, I have too much ideas :)

For the internships, discussing them via email in this thread has
worked well in the past. For a more general QEMU Enhancement Proposal
process, that is a bigger topic for the community since there is
currently no formal process for the development of new features.

I have some thoughts about the vfio-user project idea:

> =3D=3D=3D First-Class vfio-user Device Support =3D=3D=3D
>
> '''Summary:''' Promote QEMU's experimental vfio-user device support to pr=
oduction-ready status by adding comprehensive testing, documentation, migra=
tion support, and seamless CLI integration.
>
> Since 2022, QEMU has included `x-vfio-user-server` for running emulated P=
CI devices in standalone processes using the vfio-user protocol. This enabl=
es security isolation, modular device development, and flexible deployment =
architectures.
>
> However, adoption has been limited due to:
> * '''Experimental status''' - All components use `x-` prefix indicating u=
nstable API

This is a question of whether the command-line interface is stable.
John Levon, Thanos Makatos, and C=C3=A9dric Le Goater are the maintainers
for vfio-user. I wonder what their thoughts on removing the "x-" are?

> * '''Complex CLI''' - Requires coordinating multiple components (`-machin=
e x-remote` + `-device` + `-object x-vfio-user-server`)
> * '''No live migration''' - Migration explicitly blocked

The vfio-user protocol has adopted the kernel VFIO interface's device
state migration features. In theory the protocol supports migration,
but I don't see QEMU code that implements the protocol features. If my
understanding is correct, then there is a (sub-)project here to
implement live migration protocol features in --device vfio-user-pci
(the proxy) as well as in --object x-vfio-user-server (QEMU's server)?

> * '''Limited testing''' - Only one functional smoke test exists
> * '''Documentation''' - No usage guide or troubleshooting docs
>
> This project aims to make vfio-user a first-class QEMU feature.
>
> '''Goal:''' Enable out-of-process device emulation with a single CLI opti=
on.
>
> '''Current (complex):'''
> <pre>
> # Server process (full QEMU instance):
> qemu-system-x86_64 -machine x-remote,vfio-user=3Don \
>   -device pci-serial,id=3Dserial0 \
>   -object x-vfio-user-server,id=3Dvfu0,type=3Dunix,path=3D/tmp/serial.soc=
k,device=3Dserial0
>
> # Client process (main VM):
> qemu-system-x86_64 ... -device vfio-user-pci,socket=3D/tmp/serial.sock
> </pre>
>
> '''Proposed:'''
> <pre>
> # Single option spawns all capable devices out-of-process automatically
> qemu-system-x86_64 -vfio-user \
>   -device pci-serial \
>   -device virtio-net-pci \
>   -device pvpanic-pci \

At first I thought this was about launching third-party vfio-user
device servers from the QEMU command-line, but later I realized it's
only about running QEMU's PCI device emulation in separate processes.

>   ...
> # QEMU automatically:
> # - Identifies vfio-user capable devices
> # - Spawns device server processes
> # - Connects via vfio-user protocol
> # - Manages lifecycle (startup, shutdown, crash recovery)
> </pre>
>
> '''Implementation:'''
> * Add global `-vfio-user` CLI option
> * Identify devices capable of out-of-process emulation (all PCI devices i=
nitially)
> * Automatically spawn server process for each capable device
> * Create internal socket connections (e.g., `/tmp/qemu-vfio-user-<pid>-<d=
evice>.sock`)
> * Replace device with `vfio-user-pci` client transparently
> * Handle process lifecycle: spawn, health monitoring, graceful shutdown, =
crash recovery
> * Optional: `-vfio-user=3D<device-list>` to select specific devices

Monitor commands don't work as expected in this mode since the main
VM's QMP server is unaware of the vfio-user device server's QMP
servers. How should QMP work for automatically spawned devices? I
think approaches that try to aggregate query-* command results or make
it appear that the devices are part of QEMU become complex quickly.

Users choosing vfio-user for process isolation (security) need to
launch vfio-user device servers before launching QEMU in order to
achieve principle of least privilege (e.g. pass file descriptors only
to the server and not to the main VM process).

> '''Goal:''' Add test suite covering more vfio-user devices and functional=
ities
>
> Currently, a single smoke test (`tests/functional/x86_64/test_vfio_user_c=
lient.py`)
>
> '''Test devices:'''
> * `pvpanic-pci` - Minimal device, no interrupts
> * `pci-serial` - Simple with INTx interrupt
> * `virtio-*` - More complex devices with DMA

Nice.

> '''Goal:''' Documentation for users and developers
>
> ** Quick start examples
> ** CLI reference
> ** Common use cases (security isolation, modular development)
> ** Troubleshooting guide
> ** When to use vfio-user
> ** Comparison with other solutions (vhost-user, usbredir, cacard, swtpm..=
.)
> ** Performance considerations

Yes!

> =3D=3D Stretch goals =3D=3D
>
> * Migration support
> * Hot-plug support
> * Support for non-PCI devices
>
> '''Links:'''
> * https://www.qemu.org/docs/master/interop/vfio-user.html - vfio-user pro=
tocol specification
> * https://github.com/nutanix/libvfio-user - libvfio-user library
>
> '''Details:'''
> * Skill level: advanced
> * Language: C
> * Mentor: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> (elmarco o=
n IRC)
> * VFIO-USER maintainers?
> * Suggested by: Marc-Andr=C3=A9 Lureau

Stefan

