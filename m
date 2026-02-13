Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E31CEDF176
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvLV-0000mj-NL; Fri, 13 Feb 2026 10:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phrdina@redhat.com>)
 id 1vqvLR-0000m8-U6
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:44:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phrdina@redhat.com>)
 id 1vqvLN-0006Ym-Oo
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770997471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sDtU67X8wI5oiArjRWjTIJ9AGqL5uiXw5++B/vg06bw=;
 b=FcGi6TmAKSBVYsSkuS3LeGxMLjeIbEeHnnuwYWLlGc6TPQ8PwKN6cd3Kts0Qn0Gk/kGvt9
 DHQCY5ZrK3nlMBItlMCx8W48gsEMdW5LrslUDhZ/vQVQYe5bJ9spg/ZYy85O6e2wxx3ikR
 9VBGSkowVMwacPSDtMCh9h9nfTIk71g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-MKm97Ru-MNSbbhpErMNfqQ-1; Fri,
 13 Feb 2026 10:44:27 -0500
X-MC-Unique: MKm97Ru-MNSbbhpErMNfqQ-1
X-Mimecast-MFC-AGG-ID: MKm97Ru-MNSbbhpErMNfqQ_1770997465
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 950FD1956066; Fri, 13 Feb 2026 15:44:24 +0000 (UTC)
Received: from antique-laptop (unknown [10.44.22.34])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C4D91955D85; Fri, 13 Feb 2026 15:44:18 +0000 (UTC)
Date: Fri, 13 Feb 2026 16:44:15 +0100
From: Pavel Hrdina <phrdina@redhat.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v2 24/24] hw/arm/smmuv3: Add tegra241-cmdqv property for
 SMMUv3 device
Message-ID: <aY9GzzllxyiW-zs6@antique-laptop>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-25-skolothumtho@nvidia.com>
 <aY8RIXzUVqcTiCkd@antique-laptop>
 <IA0PR12MB7555AD8A591B65CE1F0081ADAB61A@IA0PR12MB7555.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rTL7UEISyZsy4M/9"
Content-Disposition: inline
In-Reply-To: <IA0PR12MB7555AD8A591B65CE1F0081ADAB61A@IA0PR12MB7555.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=phrdina@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--rTL7UEISyZsy4M/9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 01:39:50PM +0000, Shameer Kolothum Thodi wrote:
>=20
>=20
> > -----Original Message-----
> > From: Pavel Hrdina <phrdina@redhat.com>
> > Sent: 13 February 2026 11:55
> > To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org; clg@redhat.com;
> > alex@shazbot.org; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
> > <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jiandi An
> > <jan@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>;
> > jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
> > zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>
> > Subject: Re: [PATCH v2 24/24] hw/arm/smmuv3: Add tegra241-cmdqv
> > property for SMMUv3 device
> >=20
> > On Fri, Feb 06, 2026 at 02:48:23PM +0000, Shameer Kolothum wrote:
> > > Introduce a =E2=80=9Ctegra241-cmdqv=E2=80=9D property to enable Tegra=
241 CMDQV
> > > support. This is only enabled for accelerated SMMUv3 devices.
> >=20
> > Hi, do we expect that in the future there will be some other option
> > named `{newplatform}-cmdqv`?
> >=20
> > I'm asking mainly from libvirt PoV where current RFC patch exports this
> > option only as `cmdqv`.
>=20
> Yes, with the current design each implementation would expose its own
> xxx-cmdqv property.
>=20
> However, please see the discussion:
> https://lore.kernel.org/qemu-devel/CH3PR12MB75484A150D6DCD9D3C3C66F3AB60A=
@CH3PR12MB7548.namprd12.prod.outlook.com/
>=20
> I am looking into whether we can instead have a single cmdqv property
> and probe the kernel to determine the specific implementation type.

Thanks for the details, yeah that looks better.

I was also thinking about using cmdqv=3Dtegra241 in addition to 'off' and
'auto' if it would be possible for host to support multiple
implementations at the same time. Libvirt would probably prefer setting
specific implementation instead of using 'auto' to make sure that the VM
will not change.

Pavel

--rTL7UEISyZsy4M/9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAmmPRs8ACgkQUi1kczAH
4YzUGA/6Ag628m2V8Lqp0Q+aUoXk/iLI9rMh8oorQbDI4GXw9J4jYOMNVs6xRfEN
hVZIS4E/loP9NQO+Kl8eu8XyR9Y1GiWTqctb6ua8CQraG0FMDNM1Xsy7Z/f21Tdt
dwXXMJcFXpTd5jCdZ/Jl0i4i/EnWGwVX5F9ZhHE+eEaWqpyquXf7y77oMx45ZnBY
wXhmM3qiZ9MQAyxd3u67OC0CGiXHMYjGiB+foM01HjLuoGIZAtxQIPqufZvdNAYM
sAzji3KmQv4hm+5pm6OvEj+6d/M3Yem+vz8iY3tkSdIhmjqxGyA2pqnvyS4av1Jv
BomFThrujRKMRaJmpmJSUMzUZ/6/CDuIpAWXYNUJZ5SJWzn2DxX3uESP/hA6WB/2
6aSZXQ9iIo9qll22axzakHJ+dgZrTPVsBW2QBpV2ZfFry/XL/EvIc+nW9ppvslI2
RhOyN27itXzZaVZeeFTr43fJ2EdRhpu/1c57u5PN0esOx650NB4ySU7fEACmnPNP
ak/gMNSblWb03h++rQw1tbKnXMYNzHBlDWOJeVw8SllWeDyyoKCDTH/hj4YrzdBI
PtWmuuYTK4KKj9olvErBNse0HI/tfLEMsHQDQ93UnVyuvq6JLvGuP3EJcLz5K9Hv
P6C2Zu6vyR48oGPMfTFNQ1OamKAd00vhzM4bKdgNxB1rL1H4QbQ=
=ejf4
-----END PGP SIGNATURE-----

--rTL7UEISyZsy4M/9--


