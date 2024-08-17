Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA1EC52D7D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 12:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfIZ5-0000sq-UZ; Sat, 17 Aug 2024 08:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>)
 id 1sfIYz-0000p7-C2; Sat, 17 Aug 2024 08:29:46 -0400
Received: from mail-4018.proton.ch ([185.70.40.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>)
 id 1sfIYw-0004LB-9B; Sat, 17 Aug 2024 08:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szczek.dev;
 s=protonmail3; t=1723897778; x=1724156978;
 bh=VEb7IkKjncx8EzhQ2wJEOaDDAHD4smtg6l0qvVLyOyM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=yr2F84nXoaKqDXYgd5TYLMxlsX2vCq+pTIRwcK2GblLwpNq/KVhKHvST2JYcx0WM3
 Z+StZ2w/WblFLkMq68yHXNXUCQNeY7C218iwvtp8i9IaHYeRW/wztuu6nja+oA3//8
 AauUN8Fwd1ENFOJsIet6eQCnlaJh3ra0ZDtDx5D8yP+EJUI6SzdNucD+rgpT43j+L8
 +7exw6kxAjakwgx835VLs3YREnkrwqkx8ftVJ6KJpXypmSjMUvWuk3xKwub9PGne3J
 436+Bi/s8DxGS3ZgvHHXw1XyvfOUfHOPJNy4xWfoGMzmrY50DvnzaqSFP5r89TKiLt
 WvWz09kBxxhXQ==
Date: Sat, 17 Aug 2024 12:29:37 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
From: =?utf-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>
Cc: Bernhard Beschow <shentey@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] hw/i386/pc: Warn about unsatisfied vmport deps
Message-ID: <0BzMR1NzkZSLBmgrjGZr0WjTV3ROxIJDCuHj9lRRBSdPofiAfsiL_QXMQDiVJ_sQjwGcpINMESPkmAvsGU-HdZ8mTkPBTvN54M6vgHDDeNw=@szczek.dev>
In-Reply-To: <20240817081845-mutt-send-email-mst@kernel.org>
References: <vsm1ly2eX009LRKgURcMp6qTYHWw1bZd3zg2GUbd4M90T91QvJRdKxiRS3rPl8PR96y2r890Am3Ajf4kQrwihn7-7hKBU9VicRPPtIRv_GI=@szczek.dev>
 <0D723368-3251-4D5E-A625-73169CBE3395@gmail.com>
 <qT_ps6medVHIOIF5hUE_tIMUtEdbHQw5wnhE2ZVauM1cpnfHXqnl9-hroGS-3due9uRtKlMR5RsREbzeIV_0Xp1-FM0w4UDFsvdo3PsIG6U=@szczek.dev>
 <20240817081845-mutt-send-email-mst@kernel.org>
Feedback-ID: 37679334:user:proton
X-Pm-Message-ID: 32a8135154d6af8b60578f0dfd900c5e65817fde
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.18; envelope-from=kamil@szczek.dev;
 helo=mail-4018.proton.ch
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

On Saturday, August 17th, 2024 at 14:19, Michael S. Tsirkin <mst@redhat.com=
> wrote:

>=20
> On Sat, Aug 17, 2024 at 08:49:05AM +0000, Kamil Szcz=C4=99k wrote:
>=20
> > On Friday, August 16th, 2024 at 15:14, Bernhard Beschow shentey@gmail.c=
om wrote:
> >=20
> > > Am 14. August 2024 11:10:16 UTC schrieb "Kamil Szcz=C4=99k" kamil@szc=
zek.dev:
> > >=20
> > > > Since commit 4ccd5fe22feb95137d325f422016a6473541fe9f ('pc: add opt=
ion
> > > > to disable PS/2 mouse/keyboard'), the vmport will not be created un=
less
> > > > the i8042 PS/2 controller is enabled. To not confuse users, let's a=
dd a
> > > > warning if vmport was explicitly requested, but the i8042 controlle=
r is
> > > > disabled. This also changes the behavior of vmport=3Dauto to take i=
8042
> > > > controller availability into account.
> > > >=20
> > > > Signed-off-by: Kamil Szcz=C4=99k kamil@szczek.dev
> > > > ---
> > > > hw/i386/pc.c | 4 ++++
> > > > hw/i386/pc_piix.c | 3 ++-
> > > > hw/i386/pc_q35.c | 2 +-
> > > > qemu-options.hx | 4 ++--
> > > > 4 files changed, 9 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > > index c74931d577..5bd8dd0350 100644
> > > > --- a/hw/i386/pc.c
> > > > +++ b/hw/i386/pc.c
> > > > @@ -1100,6 +1100,10 @@ static void pc_superio_init(ISABus *isa_bus,=
 bool create_fdctrl,
> > > > }
> > > >=20
> > > > if (!create_i8042) {
> > > > + if (!no_vmport) {
> > > > + warn_report("vmport requires the i8042 controller to be enabled")=
;
> > > > + }
> > > > +
> > > > return;
> > > > }
> > > >=20
> > > > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > > > index d9e69243b4..cf2e2e3e30 100644
> > > > --- a/hw/i386/pc_piix.c
> > > > +++ b/hw/i386/pc_piix.c
> > > > @@ -312,7 +312,8 @@ static void pc_init1(MachineState *machine, con=
st char *pci_type)
> > > >=20
> > > > assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
> > > > if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
> > > > - pcms->vmport =3D xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON=
;
> > > > + pcms->vmport =3D (xen_enabled() || !pcms->i8042_enabled)
> > > > + ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
> > > > }
> > >=20
> > > I think it makes sense to consolidate this handling into pc_basic_dev=
ices_init() before doing this change. Maybe just in front of the call to pc=
_superio_init()? The additional handling of xen_enabled() shouldn't hurt th=
ere for q35: Even though q35 doesn't (yet) support Xen there are already co=
de paths where this check is done.
> >=20
> > Makes sense technically, but since I'm new to the mailing list workflow=
 I could use some help with logistics. I've already posted a v2 of this pat=
ch which was reviewed and accepted, should I wait for it to be pulled in an=
d post a follow-up patch or post another revision of this patch?
>=20
>=20
>=20
> I rebase with now issues - that's why it's a tag, easy to drop.
> So feel free to post v3.

Good to know, will do.


