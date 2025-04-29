Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E333C3ABA9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 10:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9iDa-0005X1-C4; Tue, 29 Apr 2025 06:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=207e857d8=Conor.Dooley@microchip.com>)
 id 1u9iDX-0005OI-4s; Tue, 29 Apr 2025 06:29:35 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=207e857d8=Conor.Dooley@microchip.com>)
 id 1u9iDU-0006nX-1c; Tue, 29 Apr 2025 06:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1745922572; x=1777458572;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=2L111cUMUqGui8Fl98+XIAo/sLYJ08jdrumgOj04yME=;
 b=pyEGRgT0EX9rvgl3PgogtNIyWHWr449JMy+xn2ZW8V291i9drRbDF76i
 +0r6fJGik9k5gWf/daDjQX2JY9RUzwdxN+0kJeWXhvaN3jT3sUn2K5aCZ
 Zpyfd+LwDRK4ulBNJ8WLMrMHb9nvG14Nb/r3aB6/mETpP0bKPhMFE0UdO
 cyyNrYTddh+xHZSyW4VXItSatpPK7yhDBRXfN799TLoWpDJ2kx2QNURIl
 Rsq4S1Ki3rYEKG8UsmK9JisY9r41fdxpUtJi9Dg6ty0rq6BI69p3aQVNn
 +Tvast8sPSbOLy0MLFTZPQJtVjWcA3/4cdsD4GrhMj+5o9gg6PO9YlSW+ g==;
X-CSE-ConnectionGUID: ZrcFWR+oTB2sWAO1m7RPDg==
X-CSE-MsgGUID: WeRNPDHBSjGjuzy2gCVBqg==
X-IronPort-AV: E=Sophos;i="6.15,248,1739862000"; 
 d="asc'?scan'208";a="272377144"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 29 Apr 2025 03:29:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 29 Apr 2025 03:28:54 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44 via Frontend
 Transport; Tue, 29 Apr 2025 03:28:52 -0700
Date: Tue, 29 Apr 2025 11:27:55 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Joel Stanley <joel@jms.id.au>
CC: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, <alistair.francis@wdc.com>, 
 <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>, <palmer@rivosinc.com>, 
 Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH 1/9] hw/riscv/virt.c: enforce s->memmap use in
 machine_init()
Message-ID: <20250429-lend-voucher-2c02499dcb59@wendy>
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
 <20250423110630.2249904-2-dbarboza@ventanamicro.com>
 <CACPK8XfF74wHqdBBz=qPLefAD8pKT-0C8e=kfFtTeMH+teF-7A@mail.gmail.com>
 <7d5181de-eb42-44b0-80cb-b2f8a3aed47c@ventanamicro.com>
 <CACPK8Xc5Av4QnHwcfe5JhcHUYmdLxm6P+vDh=_zze7UvbaaJ8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qBVCxkIib9Ir8MMb"
Content-Disposition: inline
In-Reply-To: <CACPK8Xc5Av4QnHwcfe5JhcHUYmdLxm6P+vDh=_zze7UvbaaJ8w@mail.gmail.com>
Received-SPF: pass client-ip=68.232.153.233;
 envelope-from=prvs=207e857d8=Conor.Dooley@microchip.com;
 helo=esa.microchip.iphmx.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--qBVCxkIib9Ir8MMb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Tue, Apr 29, 2025 at 02:55:44PM +0930, Joel Stanley wrote:
> On Fri, 25 Apr 2025 at 21:23, Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
> > On 4/24/25 6:51 AM, Joel Stanley wrote:
> > > On Wed, 23 Apr 2025 at 20:37, Daniel Henrique Barboza
> > > <dbarboza@ventanamicro.com> wrote:
> > >>
> > >> Throughout the code we're accessing the board memmap, most of the ti=
me,
> > >> by accessing it statically via 'virt_memmap'. This static map is also
> > >> assigned in the machine state in s->memmap.
> > >>
> > >> We're also passing it as a variable to some fdt functions, which is
> > >> unorthodox since we can spare a function argument by accessing it
> > >> statically or via the machine state.
> > >>
> > >> All the current forms are valid but not all of the are scalable. In =
the
> > >> future we will version this board, and then all this code will need
> > >> rework because it should point to the updated memmap. In this case,
> > >> we'll want to assign the adequate versioned memmap once during init,
> > >> in s->memmap like it is being done today, and the rest of the code
> > >> will access the updated map via s->memmap.
> > >
> > > I was writing a patch for a machine and came across the same
> > > inconsistencies. Nice clean up.
> > >
> > > Some of the device initlisation code could be refactored out to be
> > > shared by other machines within the riscv directory. Related, parts of
> > > the device tree creation could belong to the model, instead of to the
> > > machine, as the properties are a property (!) of the device.
> >
> > Yes, delegating the FDT creation to the device, instead of having each =
machine
> > to create the (mostly) same FDT code over and over again, is something =
that
> > I've considering for awhile.
> >
> > I keep postponing it mainly because I would like to verify with the DT =
folks if
> > there's a guarantee that a given device/CPU DT is always the same, i.e.=
 a device
> > DT is always the same regardless of the machine. I have a guess that th=
at this is
> > indeed the case but a confirmation would be nice .... Conor, care to co=
mment?

Uhm, if the device node was always the same, regardless of "machine"
then there'd be no need for any properties other than
compatible/reg/links to provider nodes! But unfortunately that's not what
properties are limited to, there's properties for a whole host of other
elements of device configuration.

Generally speaking, properties will be fixed for a given "machine"/board,
but some could change depending on things like AMP affecting which
mailbox channel you're permitted to use or using a different firmware
(or version of said firmware) can change a node. For example, the
extensions supported by a CPU can change based on what version of OpenSBI
you're running. The latter might not affect QEMU, because you're providing
a DT for the firmware to edit, but from the OS point of view there's
different, but valid and complete, descriptions for the same physical
hardware.

Also, on the same machine you might have variation between two instances
of the same IP, other than just the reg/provider links changing, for
example if there's two different dwmac ethernet controllers configured
to provide different maximum speeds.

So yeah, I can't give you any assurance that even one specific IP/CPU on
a specific SoC on a specific machine/board will have the same device
node unfortunately.

> My understanding is bindings strive to specify the hardware
> independent of the machine it's part of. We have bindings in the
> kernel tree, and associated drivers that use those bindings, that work
> fine on different machines. The litex peripherals are an extreme case
> of this; peripherals defined in python that are attached to soft cores
> often running on a FPGA.

Yeah, FPGA stuff is an extreme case, but a great thing to use as a test
for the idea, since you could have properties that change from
compilation to compilation. Take a look at something like snps,dwmac.yaml
where there's about seven thousand different properties, many of which
could be varied if it were in an FPGA design rather than an ASIC..

The other kinda extreme case in variability is the stuff that's on a
board rather than an SoC, for example the same mmc/sd card controller
on an SoC can have different device nodes depending on how a board has
been designed. What Linux calls "IIO" devices are also impacted
massively by how a board is configured or use-case, since they're often
measurement devices with different analogue circuitry connected to them.

I'm not 100% sure how all that translates to a machine in QEMU, dunno if
running a different AMP context would require a different machine etc,
but I hope that gives a general impression of what could potentially
vary? LMK if not.
Conor.

> At a practical level generating the device tree for a given device
> does need to take into account specifics of the machine.
>=20
> Things like interrupt properties depend on the interrupt device you're
> delivering to (some have two cells to provide a 'flags' parameter
> alongside the irq number). In general anything that contains phandles
> could end up being machine specific. Another case is the number of
> cells in reg properties, which depend on the bus the device is
> described to be on.

>=20

--qBVCxkIib9Ir8MMb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaBCpmwAKCRB4tDGHoIJi
0vv1AQDwLR5prT12xcT35XPHv12hQ9x5o0pSWqAVXHwAdPR7JQEA6VLKvgB60p9k
iLa3Fp3T7Q9pV5FST/+qqrDTjruOVwk=
=fshN
-----END PGP SIGNATURE-----

--qBVCxkIib9Ir8MMb--

