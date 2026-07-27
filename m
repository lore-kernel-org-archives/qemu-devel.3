Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF57C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 18:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQNF-00006z-KD; Mon, 27 Jul 2026 14:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1woQND-00006F-SN
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 14:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1woQNC-0004ra-FE
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 14:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785178101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WpsSGUZlY0X4wFyUj6Sc+g+V8RjxHI71Pn+TpdujcMo=;
 b=K5zLNQZHIEmPqrO+ZhLQzjiFtgoTvE66IMTadpLrKBvcH4vALHeREypyX7lAbH7LRsm4uE
 KJiyOG9iOeKr1bYTpywzJEVx/6yZfOX2UKsSHOtooYFDVHAGMg7BKbubzTyvOyVYwEmkIH
 R3Sy2DKxE28SXc7cl7TywpF9qkFlTOQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-7h0j0K1_OA2ZPPvNoKDbeQ-1; Mon,
 27 Jul 2026 14:48:15 -0400
X-MC-Unique: 7h0j0K1_OA2ZPPvNoKDbeQ-1
X-Mimecast-MFC-AGG-ID: 7h0j0K1_OA2ZPPvNoKDbeQ_1785178093
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D4AD195607C; Mon, 27 Jul 2026 18:48:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E79EE180058F; Mon, 27 Jul 2026 18:48:09 +0000 (UTC)
Date: Mon, 27 Jul 2026 14:48:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
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
Subject: Re: [PATCH RFC 04/15] net/vhost-user: add memory isolation
Message-ID: <20260727184808.GC371693@fedora>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-4-6b97c439eb28@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1OUtWB2/rX/yB0aQ"
Content-Disposition: inline
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-4-6b97c439eb28@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

--1OUtWB2/rX/yB0aQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 03:30:03PM -0700, Connor Kite wrote:
> Add a memory-isolation property to NetdevPassOptions and
> NetDevVhostUserOptions in net.json.  This property will
> be used for vhost-user devices to disable access to guest
> memory from devices.
>=20
> It will be passed into vhost_user_init() in a future patch.
>=20
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>  net/passt.c      |  7 +++++++
>  net/vhost-user.c |  4 ++++
>  qapi/net.json    | 15 +++++++++++----
>  3 files changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/passt.c b/net/passt.c
> index 45440c399b..ce80186883 100644
> --- a/net/passt.c
> +++ b/net/passt.c
> @@ -735,6 +735,13 @@ int net_init_passt(const Netdev *netdev, const char =
*name,
>      s->pidfile =3D pidfile;
> =20
>      if (netdev->u.passt.has_vhost_user && netdev->u.passt.vhost_user) {
> +        bool memory_isolation G_GNUC_UNUSED =3D false;
> +
> +        if (netdev->u.passt.has_memory_isolation &&
> +           netdev->u.passt.memory_isolation) {
> +            memory_isolation =3D true;
> +        }

This is dead code (hence G_GNUC_UNUSED) and is harder to review because
we don't know how it will be used until later in the patch series. I
guess vhost_user_init() and net_passt_vhost_user_init() will gain a
memory_isolation argument in a future patch.

Linear reviews of the patch series are easiest for reviewers. Please
reorder this so that vhost_user_init() and net_pass_vhost_user_init()
are changed first. You can hardcode the argument to false in those
patches. This patch can be moved afterwards so that memory_isolation is
never dead code.

--1OUtWB2/rX/yB0aQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpnp+gACgkQnKSrs4Gr
c8gPOQf/XYHmejG58UtHRz8dS3h1zerjw27qrlpz+sb/VxPkff6Q/N1EFsQBjOYI
mzxUd8rmBkUdE6VtdcU9EBjyJdOFuimihT8mM+GD6fq8Iui6U1tVGVRxFNvefRo4
2lTCTqvDMCQUIIMflryfP5oVGZY2Gq3V65xOslZ7MYvilPWCVG4iIS58/1vk1VI7
qHaQoJPMpSsSyZ/PYLbb8R5JCtGprERCDaadSXXQDqpTF9iiFrAW0CQRhdmKTYXz
K5GA2i1EAO74SJzBBBd1UglZ4mwZBsmv5RBj1eopve0TfTDfMGiUzOlZAiNUvpCl
kw0n/Akh/aL6XnT5z8uReL63ALKMng==
=8TkL
-----END PGP SIGNATURE-----

--1OUtWB2/rX/yB0aQ--


