Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97129C52D7D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 08:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfF7v-0004G3-CQ; Sat, 17 Aug 2024 04:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sfF7o-0004DN-U4
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 04:49:28 -0400
Received: from mail-4022.proton.ch ([185.70.40.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sfF7g-0007VC-IM
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 04:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szczek.dev;
 s=protonmail3; t=1723884550; x=1724143750;
 bh=tkL+j2AuaQd3rWS/sFgiD96I3hY5MbiXOZryxix19wY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=nnTyNXh7Y4CuahGZTzXrbQU59NbZ4TOHvEu+WNsDmyvc4vEk//OGkPCGM5gnWb+w5
 7fxy1Fwaef1Wf5hZq3hlad3Az6RhFzWLaiGDkZFCK+kmjMu8YGqOCU34LNXDBYn1vH
 tjRktTHRQRBmVIGgA9DjselW2D+28BDAf793j4vpg5IcTxHzHWp+zWCzjLO7hegwAP
 Z3c9ywt99Bh7uj7IG2iM0smWxBvFF7IAHJRXUFbjk12YKxP7IFqRF5qgHTr+ZtvTbZ
 +aPj2BMpnSHvX9Iahs+ci4PGS7XQtcjznpm/2bTwW4bqjIbpHgp6AdLCniEvHohpvV
 E1RhWpcRMKk7A==
Date: Sat, 17 Aug 2024 08:49:05 +0000
To: Bernhard Beschow <shentey@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: =?utf-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] hw/i386/pc: Warn about unsatisfied vmport deps
Message-ID: <qT_ps6medVHIOIF5hUE_tIMUtEdbHQw5wnhE2ZVauM1cpnfHXqnl9-hroGS-3due9uRtKlMR5RsREbzeIV_0Xp1-FM0w4UDFsvdo3PsIG6U=@szczek.dev>
In-Reply-To: <0D723368-3251-4D5E-A625-73169CBE3395@gmail.com>
References: <vsm1ly2eX009LRKgURcMp6qTYHWw1bZd3zg2GUbd4M90T91QvJRdKxiRS3rPl8PR96y2r890Am3Ajf4kQrwihn7-7hKBU9VicRPPtIRv_GI=@szczek.dev>
 <0D723368-3251-4D5E-A625-73169CBE3395@gmail.com>
Feedback-ID: 37679334:user:proton
X-Pm-Message-ID: c1a6bcafa1b93b2b6ed742e983777258883b9490
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.22; envelope-from=kamil@szczek.dev;
 helo=mail-4022.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Friday, August 16th, 2024 at 15:14, Bernhard Beschow <shentey@gmail.com>=
 wrote:

>
> Am 14. August 2024 11:10:16 UTC schrieb "Kamil Szcz=C4=99k" kamil@szczek.=
dev:
>
> > Since commit 4ccd5fe22feb95137d325f422016a6473541fe9f ('pc: add option
> > to disable PS/2 mouse/keyboard'), the vmport will not be created unless
> > the i8042 PS/2 controller is enabled. To not confuse users, let's add a
> > warning if vmport was explicitly requested, but the i8042 controller is
> > disabled. This also changes the behavior of vmport=3Dauto to take i8042
> > controller availability into account.
> >
> > Signed-off-by: Kamil Szcz=C4=99k kamil@szczek.dev
> > ---
> > hw/i386/pc.c | 4 ++++
> > hw/i386/pc_piix.c | 3 ++-
> > hw/i386/pc_q35.c | 2 +-
> > qemu-options.hx | 4 ++--
> > 4 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index c74931d577..5bd8dd0350 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1100,6 +1100,10 @@ static void pc_superio_init(ISABus *isa_bus, boo=
l create_fdctrl,
> > }
> >
> > if (!create_i8042) {
> > + if (!no_vmport) {
> > + warn_report("vmport requires the i8042 controller to be enabled");
> > + }
> > +
> > return;
> > }
> >
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index d9e69243b4..cf2e2e3e30 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -312,7 +312,8 @@ static void pc_init1(MachineState *machine, const c=
har *pci_type)
> >
> > assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
> > if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
> > - pcms->vmport =3D xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
> > + pcms->vmport =3D (xen_enabled() || !pcms->i8042_enabled)
> > + ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
> > }
>
>
> I think it makes sense to consolidate this handling into pc_basic_devices=
_init() before doing this change. Maybe just in front of the call to pc_sup=
erio_init()? The additional handling of xen_enabled() shouldn't hurt there =
for q35: Even though q35 doesn't (yet) support Xen there are already code p=
aths where this check is done.

Makes sense technically, but since I'm new to the mailing list workflow I c=
ould use some help with logistics. I've already posted a v2 of this patch w=
hich was reviewed and accepted, should I wait for it to be pulled in and po=
st a follow-up patch or post another revision of this patch?

>
> > /* init basic PC hardware */
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index 9d108b194e..6c112d804d 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -278,7 +278,7 @@ static void pc_q35_init(MachineState *machine)
> >
> > assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
> > if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
> > - pcms->vmport =3D ON_OFF_AUTO_ON;
> > + pcms->vmport =3D pcms->i8042_enabled ? ON_OFF_AUTO_ON : ON_OFF_AUTO_O=
FF;
> > }
> >
> > /* init basic PC hardware */
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index cee0da2014..0bc780a669 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -68,8 +68,8 @@ SRST
> >
> > `vmport=3Don|off|auto`
> > Enables emulation of VMWare IO port, for vmmouse etc. auto says
> > - to select the value based on accel. For accel=3Dxen the default is
> > - off otherwise the default is on.
> > + to select the value based on accel and i8042. For accel=3Dxen
> > + and/or i8042=3Doff the default is off otherwise the default is on.
>
>
> I'd do s#and/or#or# for readability.
>
> Best regards,
> Bernhard
>
> > `dump-guest-core=3Don|off`
> > Include guest memory in a core dump. The default is on.

