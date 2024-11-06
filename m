Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5965ED3E799
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 09:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8com-0007Yx-FS; Wed, 06 Nov 2024 04:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t8coj-0007PG-0P; Wed, 06 Nov 2024 04:59:13 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t8cog-0008TH-Nx; Wed, 06 Nov 2024 04:59:12 -0500
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id B9185114012E;
 Wed,  6 Nov 2024 04:59:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 06 Nov 2024 04:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1730887146; x=
 1730973546; bh=u7TCj7/wVKBpCpyRtt7WWZEkZk80JCt2OqxBBMyXKo4=; b=i
 DJQfoqWPpuOgjDiFtMM9pk079i6ApJHHlcNYtrgERMScV31t84NJHViGW55uYyXI
 1XUQnGSSu41YmqyRJNUc0TgDyB2MndvPIpRZ/RgZsTLiTNo45MUSf7ooZUwhLouR
 AK9+p5UnBhpRji5sDmCulY9IUfNU+NxXyeiduG2jVmiigpTrjwQOEawiLCqc4QZW
 003jW2SXxLSpEbSWKJcvS0QDmdCuUa1y96wcO00kZ5atyOQaDPpAGxxtJTjDanpO
 1mhIFo/W7GVy4OQXp+4eVeZyaNFYUygt5yz4zffO0KhrwX5RGC9y4zsEqek/Yzif
 AMVZ6IkCaJ6bNvJ9z7PFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1730887146; x=1730973546; bh=u7TCj7/wVKBpCpyRtt7WWZEkZk80JCt2Oqx
 BBMyXKo4=; b=jmWnz5aXC26tsDfzx8xmdeVPsKonoke69szDlaVy6mXDwqs1cPj
 NpUe9Tni6fxpx/719jtfCVQHj2TUWa+uOdaldZeFAec8yqDQa6ktxT01+SFaYm0Q
 qbw6oZpqxypw8qIiqZv76m3IYbzFArEwws6wyMTeLtd8vnP3YhOPk+SSgfyxZ0qx
 fdog3Kl1yjtpI2KIHGW+G+K42Pd7/omgJHvwFXYIJTDgsJfodq5kgF1O5J2/Jnwn
 hsq63Zpwdl6KbqG7NuGgGGR7bhvefhjvOjaBp3ecN48zn2XJIgLWe9HKDutG/N10
 1hRdeYgC1lo6u1yLoDpO9tVMfKW4rGTyapA==
X-ME-Sender: <xms:6T0rZw7Y5jtaE4Um45SHJFLhW7ICMVPc2iF8pUXg_hb1pByJc1jn4g>
 <xme:6T0rZx6uRIBsx6C5h0ZkIAKQ9mU2gRJ1NAVRFHDLidWqQuILBljotmsLXZ3aGkyNd
 du139UFiMWVX8uC_uo>
X-ME-Received: <xmr:6T0rZ_dutdCnH8EiYnHyU6ucof7WmXJuw8YrT_dYMUDzGp0MHaNrIXSJwI8yFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecu
 hfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrug
 hkqeenucggtffrrghtthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeev
 tdduudegieegteffffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthho
 peekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjfihkohiirggtiihukhesgh
 hmrghilhdrtghomhdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhr
 tghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepqhgvmhhuqd
 gslhhotghksehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhes
 nhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrd
 gtohhmpdhrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdhorhhgpdhr
 tghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:6T0rZ1KViaHV9VzKoaZxAOp2EFo97r8gFvi9RuJEeDS6Hre9k3kKkg>
 <xmx:6T0rZ0IEmGPgXkXseYRBCTXL-3lmxovngHu9ExC0Xc_E9nQraPyqsg>
 <xmx:6T0rZ2y4S6XtG5APAfVNszTtK9yJvNe4Hgg-AGZ9hPJ53VnLKqtLRw>
 <xmx:6T0rZ4IfHIeffHCwv3YNR6RRRjqCGiKb2mJTDvXHl2tp894fBoSekQ>
 <xmx:6j0rZz8Dioj_DbgPQcnxyTvAgg4YEu7iaT3eNUgqjwHXj1HDC479REN_>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 04:59:05 -0500 (EST)
Date: Wed, 6 Nov 2024 10:59:04 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Waldek Kozaczuk <jwkozaczuk@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] hw/nvme: fix handling of over-committed queues
Message-ID: <Zys96GfvomKJ7qv3@AALNPWKJENSEN.aal.scsc.local>
References: <20241029-issue-2388-v2-1-e335658104cf@samsung.com>
 <ZykZHvL_PtMMttqX@kbusch-mbp.dhcp.thefacebook.com>
 <CAL9cFfMgQQ3ETjGWzW7_K+MNOKUa4rsf8s3X49vmm4862n5VHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HfDDUBbnUC9gvtod"
Content-Disposition: inline
In-Reply-To: <CAL9cFfMgQQ3ETjGWzW7_K+MNOKUa4rsf8s3X49vmm4862n5VHg@mail.gmail.com>
Received-SPF: pass client-ip=202.12.124.145; envelope-from=its@irrelevant.dk;
 helo=fout-b2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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


--HfDDUBbnUC9gvtod
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov  4 17:32, Waldek Kozaczuk wrote:
> I have run my tests on the OSv side with small queue sizes like 3,4,5 and=
 I
> could NOT replicate the issue. So it looks like the V2 version of this
> patch fixes the problem.
>=20

Thanks for testing Waldek!

May I add a Tested-by tag to the commit for you?

--HfDDUBbnUC9gvtod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmcrPeUACgkQTeGvMW1P
DelxSgf/W4TEgmM5+dUEyq731QG5J7pNwcSMPSeigoDZ/OV7bm2kQUxz0azVMjyW
jGwPnLL8MmivrpD3+JBiVqmlGHK8vO60qymU5qg00NP41YVXdl3UnYkqr2frvsub
TqrdKGtUhYypu3N3NUi847zlc3SMC4bYJtzAwwHwCcyfGUMZbQOGViC1jur8aqZF
jnCVoG2SLP42y3VIyQnVApSqow2Re194wAn+qd/oEM+kVQTbHSAttx+d3qOK4mX5
6K57deVYE8Hg/t1JDtk45lFHGWPL76EDDpE8i2QEJR5CB0UjIIi+5yh7/F6+CS8p
8oIgREBwNK9XynOyWPwtfKlHjewnlw==
=f1Gn
-----END PGP SIGNATURE-----

--HfDDUBbnUC9gvtod--

