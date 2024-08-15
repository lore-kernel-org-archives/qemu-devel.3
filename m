Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E364AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 18:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sef7F-0000CT-Gl; Thu, 15 Aug 2024 14:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sef7D-0000BB-Oz
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 14:22:27 -0400
Received: from mail-40136.proton.ch ([185.70.40.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sef7B-0008Cx-8L
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 14:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szczek.dev;
 s=protonmail3; t=1723746140; x=1724005340;
 bh=bYolgXZLJ87b8G/nLyJICaHwNIwA72sBjzumNO3Ihb8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=O8e6A5A9R8Ir11zCGlGzcknoK7K0Mta8HqpD56j6y4ro1bwVIew0ADiqMCvjYIrCn
 CzdG0yS8vyQdFsH0RzjzCqAZmwKcqHOzvM/DxtkwTSxfWcYkXGpch6lSOo3aF0lYvq
 iqSecRH9iVdaGXPsGs4nXgzz/X5bVZy1NxtF7DD6DtBZv1wLxGIHPTx2/fn/Gg82Hd
 d4WXwSPBXNH6F04puJv41Q218LZnuB4fnWfwO0V0gOf5dc/QH399KIWql0AlsM5uBo
 bAcJgQ5UoCAhRMFh77AXQkZayxNw7M4s7q5dsfO3rGkSKhnmLtlyWz86koVOGX1H4h
 kjkMhs8Ew0yew==
Date: Thu, 15 Aug 2024 18:22:16 +0000
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: =?utf-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Joelle van Dyne <j@getutm.app>, Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-for-9.1] hw/i386/pc: Warn about unsatisfied vmport deps
Message-ID: <ghPjnPAU8FvuVvcKbO9wNpQPgm4ZwkjL1j5Vh-voSnVI8EE4tCUKDqmBj7LGXv2cc7Yt7IWlMvnbvA-I6QxR7iS6xDyfIwvpuKtEMVbxHIo=@szczek.dev>
In-Reply-To: <e7c17260-41d7-4749-aca9-da344517c772@linaro.org>
References: <vsm1ly2eX009LRKgURcMp6qTYHWw1bZd3zg2GUbd4M90T91QvJRdKxiRS3rPl8PR96y2r890Am3Ajf4kQrwihn7-7hKBU9VicRPPtIRv_GI=@szczek.dev>
 <e7c17260-41d7-4749-aca9-da344517c772@linaro.org>
Feedback-ID: 37679334:user:proton
X-Pm-Message-ID: d4c4ec556afb60c2e53ceb6273c95af8710d922a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.136; envelope-from=kamil@szczek.dev;
 helo=mail-40136.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Philippe and sorry for the delay!

On Wednesday, August 14th, 2024 at 16:02, Philippe Mathieu-Daud=C3=A9 <phil=
md@linaro.org> wrote:

>=20
>=20
> Hi Kamil,
>=20
> On 14/8/24 13:10, Kamil Szcz=C4=99k wrote:
>=20
> > Since commit 4ccd5fe22feb95137d325f422016a6473541fe9f ('pc: add option
> > to disable PS/2 mouse/keyboard'), the vmport will not be created unless
> > the i8042 PS/2 controller is enabled. To not confuse users, let's add a
> > warning if vmport was explicitly requested, but the i8042 controller is
> > disabled. This also changes the behavior of vmport=3Dauto to take i8042
> > controller availability into account.
> >=20
> > Signed-off-by: Kamil Szcz=C4=99k kamil@szczek.dev
> > ---
> > hw/i386/pc.c | 4 ++++
> > hw/i386/pc_piix.c | 3 ++-
> > hw/i386/pc_q35.c | 2 +-
> > qemu-options.hx | 4 ++--
> > 4 files changed, 9 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index c74931d577..5bd8dd0350 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1100,6 +1100,10 @@ static void pc_superio_init(ISABus *isa_bus, boo=
l create_fdctrl,
> > }
> >=20
> > if (!create_i8042) {
> > + if (!no_vmport) {
> > + warn_report("vmport requires the i8042 controller to be enabled");
>=20
>=20
> Should we fail instead?

I think failing would be preferrable over a warning, but I opted for the la=
tter to maintain backward compatibility in this specific configuration.

But now that I think about it, this explicit configuration (vmport=3Don,i80=
42=3Doff) is probably very rare in the real world, if it is exercised at al=
l. So failing may not be as big of a breaking change as I first thought.

If you're fine with introducing this "breaking" change, then I'm down for i=
t too. Let me know if I should post v2.

>=20
> > + }
> > +
> > return;
> > }
> >=20
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index d9e69243b4..cf2e2e3e30 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -312,7 +312,8 @@ static void pc_init1(MachineState *machine, const c=
har *pci_type)
> >=20
> > assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
> > if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
> > - pcms->vmport =3D xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
> > + pcms->vmport =3D (xen_enabled() || !pcms->i8042_enabled)
> > + ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
> > }
> >=20
> > /* init basic PC hardware */
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index 9d108b194e..6c112d804d 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -278,7 +278,7 @@ static void pc_q35_init(MachineState *machine)
> >=20
> > assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
> > if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
> > - pcms->vmport =3D ON_OFF_AUTO_ON;
> > + pcms->vmport =3D pcms->i8042_enabled ? ON_OFF_AUTO_ON : ON_OFF_AUTO_O=
FF;
> > }
> >=20
> > /* init basic PC hardware */
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index cee0da2014..0bc780a669 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -68,8 +68,8 @@ SRST
> >=20
> > `vmport=3Don|off|auto`
> > Enables emulation of VMWare IO port, for vmmouse etc. auto says
> > - to select the value based on accel. For accel=3Dxen the default is
> > - off otherwise the default is on.
> > + to select the value based on accel and i8042. For accel=3Dxen
> > + and/or i8042=3Doff the default is off otherwise the default is on.
> >=20
> > `dump-guest-core=3Don|off`
> > Include guest memory in a core dump. The default is on.

