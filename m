Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1087C10F1A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 12:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s29BJ-0000HS-07; Wed, 01 May 2024 08:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1s29BF-0000Cc-TX; Wed, 01 May 2024 08:35:26 -0400
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1s29BD-0000sJ-Iz; Wed, 01 May 2024 08:35:25 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id 45A431380257;
 Wed,  1 May 2024 08:35:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 01 May 2024 08:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1714566920; x=
 1714653320; bh=4Uxsqqc03JuzU3QX3BGCuJDJlXqHUpBjQy72b9DKNTk=; b=j
 /amkfuADtRm83fP45Kdi48cQFE/AiglPbXOBDHpHrMyVGojROx/BlKjUChrfyTX9
 COruTPjjH3b4WQ9VDOQ9IStGBmxhG3B438QUDby/01IgfRFardxR7c0AKm4HVrVI
 MlmNU8M7VQxLMV5BPVp5RK9q6BWgnSjVtdTmISo9B6UZhbg8ul5ltAiXjj4qVpMv
 vcs9uwkUw3idRr4LAVLn7atG3WtZHql7eYiVYCdW3lVGPr4Cd7OMGGxoFKn8EEh/
 w9aVuc0E8E3BftjqRHTKLCoWvVd/+tfAX04qq1JNZr8NwZfzHNJ/2xwae7/bLx88
 QiHffUZkxVyNWJv0/coZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1714566920; x=1714653320; bh=4Uxsqqc03JuzU3QX3BGCuJDJlXqH
 UpBjQy72b9DKNTk=; b=FyIY3lfPRK9YyTMgb4leRPeMNrAEuqj3TnUi5sd0o+KR
 8a7bMneQAwDgYxcFZ0HknYRsHuIUIwIhxmswgn0sgguvnqqgtF3RU2GB+rhZaJF0
 ZM+LhcE7gqn0CaHylmgRX2ujOv5e/wf+7QO2QeXho/JN7Uq8PVLjOEU7BqzAMoSE
 ibgD04J8KWwoI7QqIw54fS92ZLAJDCAKGkXayP2RJBL6y1oRAL9fuOPF1Lq/Gg+K
 +iJQYLK5rg0pxmTfv7D43NYt0Kwuk5+Yzw1gWZA/m9Sn+DUO8R2i7Nsw2oW1C9rv
 YW4qsMywgudIB+QaStgrqJ1cjfdL3ODbvR+BgCVgGg==
X-ME-Sender: <xms:BzcyZhw-jSaiHxuUor1KRc33G9XkTxRBkLFF4zusoyULHXWPhELdqg>
 <xme:BzcyZhS2tiEZ_3At-GKg9viIJAyInDt6B5PzTW4KYcxM07Fxl7gR4vm-J90uEK9OF
 GQeV35cncDI4fA_-P4>
X-ME-Received: <xmr:BzcyZrXWMayktnXZTLEXgiGDO0O2fS-yA46SL3Of3VDjvDTEaQ5OzxuoyCVx_gsmqtFo9WPvkd6xSFa0Mgo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduhedgkeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
 erredttdejnecuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghl
 vghvrghnthdrughkqeenucggtffrrghtthgvrhhnpeejgfejfeffvdeuhfeifefhgffgue
 elhedukeevjeevtdduudegieegteffffejveenucevlhhushhtvghrufhiiigvpedtnecu
 rfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:BzcyZjh13kFKu2JC13m9ss4CJq1ZGseAlqYnFl358-FwAn9ajUpauA>
 <xmx:BzcyZjD968R6WZJWQuuTPu-rS9jVRI1j0G_BwQLVCnlNVZD1HlGE2w>
 <xmx:BzcyZsKJGmcdC2GIJPKAjeV4HPp_4b8lyDdR-MzAGukI8p94_ePhqQ>
 <xmx:BzcyZiCFhmtOTnlB_Y49jLSVa62O-NIbVBdLcGPjH04bXenw_bZI3Q>
 <xmx:CDcyZl1idjSlpJiuwN_uz8G2dCvbWqDnazps1dkwLvDKmjQbh4DzZlZf>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 May 2024 08:35:18 -0400 (EDT)
Date: Wed, 1 May 2024 14:35:12 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: "Berg, John" <jhnberg@amazon.co.uk>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "foss@defmacro.it" <foss@defmacro.it>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH] hw/nvme: Add support for setting the MQES for the NVMe
 emulation
Message-ID: <ZjI3AOEZ4GzFdKTg@cormorant.local>
References: <20240404120418.1611513-1-jhnberg@amazon.co.uk>
 <Zg6kmPGVZOVhfDbo@cormorant.local>
 <cecde5a0e57f4551872969798049f29fe28b3fb6.camel@amazon.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dWm52+v5vRuCnNVj"
Content-Disposition: inline
In-Reply-To: <cecde5a0e57f4551872969798049f29fe28b3fb6.camel@amazon.co.uk>
Received-SPF: pass client-ip=103.168.172.144; envelope-from=its@irrelevant.dk;
 helo=fout1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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


--dWm52+v5vRuCnNVj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May  1 12:27, Berg, John wrote:
> On Thu, 2024-04-04 at 15:01 +0200, Klaus Jensen wrote:
> > On Apr=C2=A0 4 13:04, John Berg wrote:
> > > From: John Berg <jhnberg@amazon.com>
> > >=20
> > > The MQES field in the CAP register describes the Maximum Queue
> > > Entries
> > > Supported for the IO queues of an NVMe controller. Adding a +1 to
> > > the
> > > value in this field results in the total queue size. A full queue
> > > is
> > > when a queue of size N contains N - 1 entries, and the minimum
> > > queue
> > > size is 2. Thus the lowest MQES value is 1.
> > >=20
> > > This patch adds the new mqes property to the NVMe emulation which
> > > allows
> > > a user to specify the maximum queue size by setting this property.
> > > This
> > > is useful as it enables testing of NVMe controller where the MQES
> > > is
> > > relatively small. The smallest NVMe queue size supported in NVMe is
> > > 2
> > > submission and completion entries, which means that the smallest
> > > legal
> > > mqes value is 1.
> > >=20
> > > The following example shows how the mqes can be set for a the NVMe
> > > emulation:
> > >=20
> > > -drive id=3Dnvme0,if=3Dnone,file=3Dnvme.img,format=3Draw
> > > -device nvme,drive=3Dnvme0,serial=3Dfoo,mqes=3D1
> > >=20
> > > If the mqes property is not provided then the default mqes will
> > > still be
> > > 0x7ff (the queue size is 2048 entries).
> > >=20
> > > Signed-off-by: John Berg <jhnberg@amazon.co.uk>
> > > ---
> > > =C2=A0hw/nvme/ctrl.c | 9 ++++++++-
> > > =C2=A0hw/nvme/nvme.h | 1 +
> > > =C2=A02 files changed, 9 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > > index 127c3d2383..86cda9bc73 100644
> > > --- a/hw/nvme/ctrl.c
> > > +++ b/hw/nvme/ctrl.c
> > > @@ -7805,6 +7805,12 @@ static bool nvme_check_params(NvmeCtrl *n,
> > > Error **errp)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0
> > > +=C2=A0=C2=A0=C2=A0 if (params->mqes < 1)
> > > +=C2=A0=C2=A0=C2=A0 {
> >=20
> > Please keep the `{` on the same line as the `if`. I think
> > checkpatch.pl
> > should catch this.
> >=20
> > No need to send a v2, I'll fix it up when I apply it to nvme-next :)
> >=20
> > Thanks!
>=20
>=20
> Hello
>=20
> Sorry for chasing. I was just wondering when this patch will be
> applied. I can send a second revision if that helps.
>=20

No need for the sorry. My apologies. It feel off my radar, so thanks for
the bump.

I've queued this on nvme-next, will send a pull for master ASAP.

--dWm52+v5vRuCnNVj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmYyNv8ACgkQTeGvMW1P
DemfDAf/TVUsVC/JaQuNMIDkVeBgVhdY9AEU2a0AfNKDia0qwIY5J6nzltwFWaRw
ptUa4k6xCQhgp21v74+LUnAgr4y3wq+1PxBbZTiPq98SzX5o9QpQezMMWdxKep1k
9HrZQn7K5K5s8buijipFXvx2pA0Jhd6TQmLZxs3iS2G8zZiVuk0ZYkQYXpwM6IFm
ETEaVCVjvCNR+SQ6BpANsjPB2xUeoq6Od5gkRaSSAHwkWpexddDrRDMvf0j9aEic
zF1Np7P2rJxiu+X7gpEMi9/fVOw9MMciAw5hxJpAPgsEYRioSlNMJNBJcZf8GN0Z
T/I++JBObitL3cOS1jihfhkLT5JIUA==
=OGiP
-----END PGP SIGNATURE-----

--dWm52+v5vRuCnNVj--

