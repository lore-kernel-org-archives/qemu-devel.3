Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C7ECF34DD
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 01:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swX3W-0000tg-Eg; Thu, 03 Oct 2024 21:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1swX3U-0000tC-Fo; Thu, 03 Oct 2024 21:24:28 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1swX3S-0000BR-Hg; Thu, 03 Oct 2024 21:24:28 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1swX3N-000FUM-2A; Fri, 04 Oct 2024 03:24:21 +0200
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1swX3N-000CN5-1U; Fri, 04 Oct 2024 03:24:21 +0200
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 01C69480024;
 Fri,  4 Oct 2024 03:24:21 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id NutkYs6pUrXq; Fri,  4 Oct 2024 03:24:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 91E47480175;
 Fri,  4 Oct 2024 03:24:20 +0200 (CEST)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id L8XOtu4SS9o9; Fri,  4 Oct 2024 03:24:20 +0200 (CEST)
Received: from zimbra.eb.localhost (zimbra.eb.localhost [192.168.96.204])
 by mail.embedded-brains.de (Postfix) with ESMTP id 60C99480136;
 Fri,  4 Oct 2024 03:24:20 +0200 (CEST)
Date: Fri, 4 Oct 2024 03:24:11 +0200 (CEST)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Message-ID: <1809049101.17000.1728005051804.JavaMail.zimbra@embedded-brains.de>
In-Reply-To: <CAFEAcA8Wf-PzAC-YGdma3YVETyuatLJHmvjrrb_kG2NjDSGs+Q@mail.gmail.com>
References: <20240923035632.81304-1-sebastian.huber@embedded-brains.de>
 <20240923035632.81304-2-sebastian.huber@embedded-brains.de>
 <CAFEAcA8Wf-PzAC-YGdma3YVETyuatLJHmvjrrb_kG2NjDSGs+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/arm/boot: Use hooks if PSCI is disabled
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.96.204]
X-Mailer: Zimbra 9.0.0_GA_4653 (ZimbraWebClient - FF128 (Linux)/9.0.0_GA_4653)
Thread-Topic: hw/arm/boot: Use hooks if PSCI is disabled
Thread-Index: t7Yqbd/pJnIoutZ9d7bQpaN4HrY5JA==
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 1.0.5/27416/Thu Oct  3 10:37:25 2024)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

----- Am 30. Sep 2024 um 17:16 schrieb Peter Maydell peter.maydell@linaro.o=
rg:

> On Mon, 23 Sept 2024 at 04:57, Sebastian Huber
> <sebastian.huber@embedded-brains.de> wrote:
>>
>> In arm_load_kernel(), use the secondary boot hooks provided by the
>> platform if PSCI is disabled also while booting a non-Linux kernel.
>> While booting Linux with PSCI disabled, provide default hooks if needed.
>>
>> In do_cpu_reset(), use the secondary CPU reset hook provided by the
>> platform for resetting a non-Linux kernel.
>>
>> This change allows a more accurate simulation of the platform reset
>> behaviour.
>=20
> So, the difficulty with this is that it's effectively
> introducing an extra way of booting. At the moment we
> have two boot approaches for Arm guests:
>=20
> (1) Booting Linux -- the boot.c code simulates what the BIOS,
> boot rom etc, does, both to set up the 1st CPU for the kernel
> boot entry, and to set up the secondaries in whatever way
> the bootrom does that the kernel expects to release them from.
>=20
> (2) Booting bare-metal -- boot.c assumes the guest code is going
> to do whatever the BIOS/bootrom does, so you get what you get
> for real-hardware CPU reset. (Either the secondaries start
> in power-off state and the primary will release them via some
> kind of power controller device, or else all the CPUs start at
> once at the reset vector and the bootrom is going to sort the
> secondaries out and put them in a pen.)
>=20
> What you want is a third thing:
>=20
> (3) Booting not-a-kernel but not 100% bare-metal: emulate what
> the bootrom does for primary and secondary CPUs but don't
> boot the guest binary as if it was a Linux kernel.
>=20
> The problem with adding that is that we don't have any
> way to distinguish whether the user wanted that or our
> existing type (2), because both are "user gave us a binary
> that isn't a Linux kernel". (It also has a bit of a
> "continuously expanding job" problem because the bootrom
> could do arbitrarily complicated things, like boot directly
> from SD cards, which we have historically not wanted to
> emulate within QEMU itself.)
>=20
> There are other platforms where the real hardware's bootrom
> has a particular "this is what a bare-metal-under-the-bootrom
> startup looks like" definition, notably the raspberry pi
> boards. There too we don't currently implement that, and
> instead effectively tell users "pick one of the two boot
> paradigms we do support"...

Ok, I understand your concerns. What I would like to do is running unmodifi=
ed executables on Qemu so that I can test exactly the same program which wo=
uld run on the real hardware. To properly initialize an SMP system, you hav=
e to do certain things in a proper order. Currently, when I start the Zynq =
machine it immediately executes the ELF entry on both cores. This conflicts=
 with the normal system start sequence which assumes that initially the sec=
ond core waits in an idle loop. For example, the second core is normally re=
leased after the GIC distributor is initialized.

Changing all the existing machines to use this third way is probably a bad =
idea, but would it be possible to make it configurable though the platform =
info or a command line option?

--=20
embedded brains GmbH & Co. KG
Herr Sebastian HUBER
Dornierstr. 4
82178 Puchheim
Germany
email: sebastian.huber@embedded-brains.de
phone: +49-89-18 94 741 - 16
fax:   +49-89-18 94 741 - 08

Registergericht: Amtsgericht M=C3=BCnchen
Registernummer: HRB 157899
Vertretungsberechtigte Gesch=C3=A4ftsf=C3=BChrer: Peter Rasmussen, Thomas D=
=C3=B6rfler
Unsere Datenschutzerkl=C3=A4rung finden Sie hier:
https://embedded-brains.de/datenschutzerklaerung/

