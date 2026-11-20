Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EA4606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 05:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=YpWZLXBj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUH4b-0002db-LU; Fri, 20 Nov 2026 00:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xUH4Y-0002dN-0d
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 00:22:06 -0500
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xUH4V-0005xD-6G
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 00:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795152111; bh=ZsHDOXj6icPoCvXSQ1Z0guVNHWWAUzgqmRdRbyaxAS0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=YpWZLXBjToTsKgwhLN06BqIibABdZcnsHF9A5JbPzC2g/QYoCzoXlf3hwNar6XA+W
 kb/MZ6ux188x/qzreiIklVZph5M/mpufFVyNAps2wIzIZ3iBRylfUDmgyGt1dwlRK4
 ADk/WB5Krby1Y1YKh+uv+rws3zej1r3uljTgzX3E=
Received: from blackfin.pond.sub.org (p4fd045cf.dip0.t-ipconnect.de
 [79.208.69.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 0874320479;
 Fri, 20 Nov 2026 06:21:50 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B107D21E6A04; Fri, 20 Nov 2026 06:21:57 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Jag Raman <jag.raman@oracle.com>,  Elena Ufimtseva
 <elena.ufimtseva@oracle.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: x-remote-object breaks QOM introspection
In-Reply-To: <av8i7zkyTMX91FZs@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 19 Nov 2026 16:25:19 +0000")
References: <87jymbjyia.fsf@pond.sub.org>
 <E30ADD82-0779-4294-B235-D27FD379C9D6@oracle.com>
 <877bi9e4mi.fsf@pond.sub.org>
 <C03B480F-3701-4DEB-A9DD-6C0F80A62568@oracle.com>
 <av8i7zkyTMX91FZs@redhat.com>
Date: Fri, 20 Nov 2026 06:21:57 +0100
Message-ID: <87mrr484cq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Nov 19, 2026 at 04:13:31PM +0000, Jag Raman wrote:
>>=20
>>=20
>> > On Nov 19, 2026, at 1:07=E2=80=AFAM, Markus Armbruster <armbru@pond.su=
b.org> wrote:
>> >=20
>> > This Message Is From a New Sender
>> > You have not previously corresponded with the sender of this message.
>> > Report Suspicious
>> > Jag Raman <jag.raman@oracle.com> writes:
>> >=20
>> > >> On Nov 17, 2026, at 9:58=E2=80=AFAM, Markus Armbruster <armbru@pond=
.sub.org> wrote:
>> > >>=20
>> > >> Watch this:
>> > >>=20
>> > >> $ qemu-system-x86_64 -S -nodefaults -display none -qmp stdio
>> > >> {"QMP": {"version": {"qemu": {"micro": 90, "minor": 1, "major": 11}=
, "package": "v11.2.0-rc0-3-g38171f59ccb-dirty"}, "capabilities": ["oob"]}}
>> > >> {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
>> > >> {"return": {}}
>> > >> {"execute": "qom-list-properties", "arguments": {"typename": "x-rem=
ote-object"}}
>> > >> --> qemu-system-x86_64: (null) is not a PCI device
>> > >> {"return": [{"name": "type", "type": "string", "qapi-type": "str"},=
 {"name": "devid", "type": "string", "qapi-type": "str"}, {"name": "fd", "t=
ype": "string", "qapi-type": "str"}]}
>> > >>=20
>> > >> The error message is suspicious. Origin:
>> > >>=20
>> > >> static void remote_object_machine_done(Notifier *notifier, void *da=
ta)
>> > >> {
>> > >> RemoteObject *o =3D container_of(notifier, RemoteObject, machine_do=
ne);
>> > >> DeviceState *dev =3D NULL;
>> > >> QIOChannel *ioc =3D NULL;
>> > >> Coroutine *co =3D NULL;
>> > >> RemoteCommDev *comdev =3D NULL;
>> > >> Error *err =3D NULL;
>> > >>=20
>> > >> dev =3D qdev_find_recursive(sysbus_get_default(), o->devid);
>> > >> if (!dev || !object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> > >> error_report("%s is not a PCI device", o->devid);
>> > >> return;
>> > >> }
>> > >>=20
>> > >> o->devid is null, dev is null.
>> > >>=20
>> > >> Glibc's %s shows null pointer as "(null)". There are libcs that sim=
ply
>> > >> crash.
>> > >>=20
>> > >> Stack backtrace:
>> > >>=20
>> > >> #0 remote_object_machine_done (notifier=3D0x5555587d17e8, data=3D0x=
0)
>> > >> at ../hw/remote/remote-obj.c:93
>> > >> #1 0x000055555578700e in qemu_add_machine_init_done_notifier
>> > >> (notify=3D0x5555587d17e8) at ../hw/core/machine.c:1721
>> > >> #2 0x00005555556f26dd in remote_object_init (obj=3D0x5555587d17c0)
>> > >> at ../hw/remote/remote-obj.c:149
>> > >> #3 0x0000555555cbda2d in object_init_with_type
>> > >> (obj=3D0x5555587d17c0, ti=3D0x5555577c02d0) at ../qom/object.c:430
>> > >> #4 0x0000555555cbde2c in object_initialize_with_type
>> > >> (obj=3D0x5555587d17c0, size=3D136, type=3D0x5555577c02d0) at ../qom=
/object.c:512
>> > >> #5 0x0000555555cbe6fa in object_new_with_type (type=3D0x5555577c02d=
0)
>> > >> at ../qom/object.c:710
>> > >> #6 0x0000555555cbe784 in object_new
>> > >> (typename=3D0x555558356a10 "x-remote-object") at ../qom/object.c:726
>> > >> #7 0x0000555555e2d6be in qmp_qom_list_properties
>> > >> (typename=3D0x555558356a10 "x-remote-object", errp=3D0x7fffffffd888)
>> > >> at ../qom/qom-qmp-cmds.c:290
>> > >> [...]
>> > >>=20
>> > >> I believe using qemu_add_machine_init_done_notifier() is wrong here.
>> > >> Could we use UserCreatableClass method complete()?
>> > >
>> > > Hi Markus,
>> > >
>> > > The remote_object_machine_done() notifier exists so qdev_find_recurs=
ive()
>> > > has a chance to find o->devid. We could setup this notifier UserCrea=
tableClass
>> > > method complete() if you prefer.
>> >=20
>> > I guess that unbreaks QOM introspection, because complete() doesn't run
>> > there.
>> >=20
>> > Can you explain why you need to defer code to machine init done?
>>=20
>> When x-remote-object is instantiated, the PCI device identified by o->de=
vid may not
>> yet exist because it appears later in QEMU=E2=80=99s command-line option=
s. As a result,
>> qdev_find_recursive() may fail to find it. Deferring the lookup until ma=
chine init done
>> ensures that all devices have been instantiated and can be found using q=
dev_find_recursive().
>
> We've already got hacks to process different -object classes at
> different phases of command line processing. It sounds like
> x-remote-object needs to be set to be processed after -device.
>
> ie we need a new object_create_very_late() to be run after
> qemu_create_cli_devices()

Many devices interact with supporting objects.  We have a common
frontend / backend pattern:

* The device (frontend) has a property identifying the object (backend).
  The property setter resolves the property value to an object of the
  required type, and fails if it can't.  This also fails device
  creation.

  CLI works, because we execute -object before -device.

  Monitor works as long as users object_add before device_add.

* Ideally, the device can work with any object of the required kind.
  When it can't, which isn't rare, its .realize() checks the object is
  suitable, and fails if it isn't.  This also fails device creation.

Why isn't this workable here?

