Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07E7C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 18:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrJny-0005B9-P8; Tue, 04 Aug 2026 14:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrJnv-0005A8-EJ
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 14:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrJnt-0003rt-Uw
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 14:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785867831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CZ8lBujjWrc5y4lCIZPM3Uitc7JJUzSDMce1+2OU1wA=;
 b=fuU/+aNE5y/ZSq+MqlZRBpo70SwWz+Dau+8r8wHevqy72V0g66WthcVBHSETi5RPwQRIR+
 MdnrsZt7iXyGpBNCWkAN4UrLV4+jALqa1ma3EURsBkYf237x5v9HkVs4dti0Qqx7tjYjIU
 WYMcQkdC8BoKshoYCS/WhBXwVcziaHM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-jojoeV5vPmGfF_0Q7mUeWg-1; Tue,
 04 Aug 2026 14:23:48 -0400
X-MC-Unique: jojoeV5vPmGfF_0Q7mUeWg-1
X-Mimecast-MFC-AGG-ID: jojoeV5vPmGfF_0Q7mUeWg_1785867825
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC67B19560AF; Tue,  4 Aug 2026 18:23:44 +0000 (UTC)
Received: from localhost (unknown [10.2.16.106])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0015D1800480; Tue,  4 Aug 2026 18:23:41 +0000 (UTC)
Date: Tue, 4 Aug 2026 14:23:40 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 qemu-block@nongnu.org, virtio-fs@lists.linux.dev,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: [PATCH RFC 11/15] hw/virtio/vhost-user: create isolation region
Message-ID: <20260804182340.GC488200@fedora>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-11-6b97c439eb28@gmail.com>
 <b6bc052c-1bf5-449b-85d0-e1c4624a5d99@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CWOrdgAWWAIAjtaa"
Content-Disposition: inline
In-Reply-To: <b6bc052c-1bf5-449b-85d0-e1c4624a5d99@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--CWOrdgAWWAIAjtaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2026 at 03:25:19PM +0200, Hanna Czenczek wrote:
> > +    for (int i =3D 0; i < buffer_regions->len; i++) {
> > +        map =3D &g_array_index(buffer_regions, DMAMap, i);
>=20
> God, I *really*, *really* hate this, and find it really disgusting that t=
he
> documentation actually recommends doing this (`&g_array_index()`) instead=
 of
> just offering a separate macro to get a reference.
>=20
> And existing qemu code does it all over the place, too.
>=20
> So I cannot really fault you for it.
>=20
> Still. Too ugly for me to keep completely silent about it.
>=20
> </rant>

Do we need GArray here, maybe just allocate a C array with g_new()
instead?

The reason I didn't say anything was because I expected GArray to
perform bounds checking. Plain C arrays don't offer that. After reading
your comment and looking at the glib source, I realized it does not.
There is no way to handle an error and glib does not abort() when the
index is invalid.

GArray still has the advantage of allowing elements to be added
dynamically, but in this case we know the number of elements ahead of
time and don't need that feature.

Stefan

--CWOrdgAWWAIAjtaa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpyLiwACgkQnKSrs4Gr
c8gIjAf/bWvIGvU8QOFTvoP5yduRhibeAdDknAZ7yqOXXJvqKNwlBL4MFvHRO/rR
q4VuL2xLwtRwMLW9ZJyeq/AOYuUES5kjmvNshLG3oF460s0ugAcV2XRkpqKi57c3
LpPiIHIvDniX80YbCBwRlmlowQCtAdfBgkULDm9RyBLVq/2+ZvXnXhOi8ANMT095
fVzwkAOpn/ed5t/pxumK+jaPmmONDPa+LkhSJkyyEnkd5zruhXPOr+4syIGECbVZ
NH2pyGNpmBgvTac1nrkI2d8suFucB4F4Y++QvgsDaYM+CIcimeIyj19Vld92ErJ3
mJ6yj4LGhaJgSeJu/V0DYujBJaTiTw==
=B/By
-----END PGP SIGNATURE-----

--CWOrdgAWWAIAjtaa--


