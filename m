Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD3E10F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYKN-0003hp-Me; Wed, 08 Apr 2026 15:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wAYJP-0008Ao-FE
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wARNq-0004N5-E0
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 07:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775648865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7I1QUcH3UikR9Rm2FQyqfNpxu8ZqMH83puydFTp2Zxk=;
 b=eTWBjaWjHgZRcd/gQWGxo68EPQQAsVO6MC1HuKIfxtrQCG62hfxf8AICQthV/X1518vxlx
 pwkOyrrGQSS/nvqzSsJ7leiV32sPC6XICuju28hy28ryJN3CLkHnKgHC3oB6+a1DVXWMso
 N9jUjyIXms5588rxmYPkfRDNL81oWmo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-x0tGKLfpONydSvfKOo0MFw-1; Wed,
 08 Apr 2026 07:47:40 -0400
X-MC-Unique: x0tGKLfpONydSvfKOo0MFw-1
X-Mimecast-MFC-AGG-ID: x0tGKLfpONydSvfKOo0MFw_1775648858
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0C9919560B4; Wed,  8 Apr 2026 11:47:36 +0000 (UTC)
Received: from localhost (unknown [10.44.48.31])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C2D918002A6; Wed,  8 Apr 2026 11:47:33 +0000 (UTC)
Date: Wed, 8 Apr 2026 07:47:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jesper Devantier <foss@defmacro.it>,
 =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@stgraber.org>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v5 5/8] hw/nvme: add migration blockers for non-supported
 cases
Message-ID: <20260408114731.GA289215@fedora>
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-6-alexander@mihalicyn.com>
 <20260407153426.GA238768@fedora>
 <CAJqdLrpzZjs0Zf52sB0R149D6hCVYEDqAW36BYAaPW+uhK=g6A@mail.gmail.com>
 <adX2hv2WOpt9ZFzJ@AALNPWKJENSEN.aal.scsc.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gL/mPpV6+5jkOSlT"
Content-Disposition: inline
In-Reply-To: <adX2hv2WOpt9ZFzJ@AALNPWKJENSEN.aal.scsc.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--gL/mPpV6+5jkOSlT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026 at 08:32:38AM +0200, Klaus Jensen wrote:
> On Apr  7 20:39, Alexander Mikhalitsyn wrote:
> > Am Di., 7. Apr. 2026 um 17:34 Uhr schrieb Stefan Hajnoczi <stefanha@red=
hat.com>:
> > >
> > > On Tue, Mar 17, 2026 at 11:27:05AM +0100, Alexander Mikhalitsyn wrote:
> > > > +static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pc=
i_dev, Error **errp)
> > > > +{
> > > > +    uint64_t unsupported_cap, cap =3D ldq_le_p(&n->bar.cap);
> > > > +    char blocker_features[BLOCKER_FEATURES_MAX_LEN] =3D "";
> > > > +    bool adm_cmd_security_checked =3D false;
> > > > +    bool cmd_io_mgmt_checked =3D false;
> > > > +    bool cmd_zone_checked =3D false;
> > > > +
> > > > +    /*
> > > > +     * Idea of this function is simple, we iterate over all Comman=
d Sets and
> > > > +     * for each supported command we provide a special handling lo=
gic to
> > > > +     * determine if we should block migration or not.
> > > > +     *
> > > > +     * For instance, we have NVME_ADM_CMD_NS_ATTACHMENT and it is =
always
> > > > +     * available to the guest, but if there is only 1 namespace, t=
hen it is
> > > > +     * safe to allow migration, but if there are more, then we nee=
d to block
> > > > +     * migration because we don't handle this in migration code ye=
t.
> > >
> >=20
> > Hi Stefan,
> >=20
> > first of all thank you for looking into my patchset.
> >=20
> > > What would be required to migrate multiple namespaces?
> >=20
> > It should not be very complex, and starting from v4 I've added
> > VMStateDescription for nvme_ns, but I'm trying
> > to be extremely careful here, and keep patchset as small as possible
> > (and easy to review), because I it is my first
> > contribution to QEMU and I'm newbie with NVMe protocol. I wanted to
> > avoid any non-absolutely-required features
> > on the first approach and then add all extras after and on-demand.
> >=20
> > My current understanding is that to support multiple namespaces we need:
> > - VMStateDescription for nvme_ns [ done ]
> > - add logic to handle (NvmeCtrl)->namespaces field and save info about
> > attached namespaces
> >   to some temporary field (use VMSTATE_WITH_TMP?)
> > - on restore we should iterate over namespaces attached and call
> > nvme_attach_ns(n, .)
> >=20
> > Feels like this is it, but I can miss something. Please, let me know
> > if you believe that implementing this is absolutely
> > required and I'll look closer and add this in v6.
> >=20
>=20
> I do not think multi-ns support is a hard requirement. Multi namespace
> support is among the features that are mainly used for driver/host
> test and verification purposes.

Adding it incrementally is fine as long as it can be done in a
compatible way. Most of the time that is possible, although adding
something in a compatible way can be more complicated than implementing
it from the start.

In this case it sounds like the extra state can be added as a subsection
and it won't be too complicated.

Thanks,
Stefan

--gL/mPpV6+5jkOSlT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnWQFMACgkQnKSrs4Gr
c8iWWAgAjYEMdxKTXLF8i49145SpoDpepDCT41gsiVSiYszclmg44O0E5II9iTQd
Z8u788uezMhKCLbXjI6JJX+Sre6BjXzo1qfWM7rFWFOt0VdS6stpZqjXvcBXaEm0
07DaPqm+V9T5whjpfI/XynIL6pIfZE8SOIQ641F2OSETZVJH3Jv12nMskl7KxMKQ
+cIh+dL701QtYrhNFcN+zanilrNMXjfr/+TMwiOlvueYjSNbAoRcHEYDqO4zUAiV
nRr4pxEuOsI1nBE6kFxIQoaYFX3NyG5VCAdBJsc6ntijcfRhZfcRU+h8Z5CJMW9g
aUgiOMFfx3bA/YvwUPCTLSfto+qdcA==
=11H0
-----END PGP SIGNATURE-----

--gL/mPpV6+5jkOSlT--


