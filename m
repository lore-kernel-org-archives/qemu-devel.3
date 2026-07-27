Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C40FC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQge-0006Yq-IV; Mon, 27 Jul 2026 15:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1woQgQ-0006XE-Tf
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1woQgL-0007Vn-UB
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785179289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cw9QiKJEcDCqbqsrfebfrHfj7TpToTYGJg3XpH6yQcc=;
 b=fNh/aDjyeGwYfV3exZOp3kEETOvUsPKsg+CPnS1/vcnXPKqYvenKPmZLovkcVwIBfw0kda
 JftjNyOgP5HsdAD3PEI1bfrgCprlQJotbCWZnxJyqq5QAWCX5I7MM/EP485Yq41R2DNKX/
 v6JC4SCdPoepBi8fjhLdsDutyfbJ25s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-kR_sglepMACP-qwhZrRPrw-1; Mon,
 27 Jul 2026 15:08:03 -0400
X-MC-Unique: kR_sglepMACP-qwhZrRPrw-1
X-Mimecast-MFC-AGG-ID: kR_sglepMACP-qwhZrRPrw_1785179281
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B380D195396E; Mon, 27 Jul 2026 19:08:00 +0000 (UTC)
Received: from localhost (unknown [10.2.16.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF5841956041; Mon, 27 Jul 2026 19:07:58 +0000 (UTC)
Date: Mon, 27 Jul 2026 15:07:57 -0400
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
Subject: Re: [PATCH RFC 06/15] util/iova-tree: g_tree_foreach wrapper
Message-ID: <20260727190757.GE371693@fedora>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-6-6b97c439eb28@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qaZp+mfEdxI91Vos"
Content-Disposition: inline
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-6-6b97c439eb28@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

--qaZp+mfEdxI91Vos
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 03:30:05PM -0700, Connor Kite wrote:
> Add a wrapper to iova-tree to call g_tree_foreach.  Provies a means to

Provies -> Provides

> execute some function on each node of the iova-tree.
>=20
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>  include/qemu/iova-tree.h | 13 +++++++++++++
>  util/iova-tree.c         |  5 +++++
>  2 files changed, 18 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qaZp+mfEdxI91Vos
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpnrI0ACgkQnKSrs4Gr
c8ir3gf+OhQnbV3Foqq0Lf/GTYzHYVcXw+hQuD59mttfXx4LCtLw83jYFDEZ+WzM
AiEoJZzsE7gbEN1gdySWD8eFeVhBKlF73gYql6D92NvbmaO+a+dGb6EKOfCOUiXN
FLxV8zCxk8EKziyO2I5HTDasT1uF4fgVLKzZ+Ya2UYOn2h8jrEucRvkcwrjsChCH
uXu9SaivKmoBy8lt4UgaKfmkoxh2QBAlQ6efiA5IVjUxFYI6jxS93mHgTZ1j9bjH
rljvLlQvtK+DzUHEg0VvU4lSvMBGN9n9YH/KRW6KdZCC40gtHF51NvBMWwJ0w6Bx
SnaLhHLzzmsuU9amMYNIB/k7u4KSBQ==
=4xZZ
-----END PGP SIGNATURE-----

--qaZp+mfEdxI91Vos--


