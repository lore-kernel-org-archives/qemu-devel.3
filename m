Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CF6C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 18:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woPzH-0003tf-0K; Mon, 27 Jul 2026 14:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1woPzF-0003t0-KL
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 14:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1woPzE-0001Dz-7s
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 14:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785176615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXDlJ8n3xPDBjhT4EY3xq+fK/7i5VAnTGhoZVp2UdkA=;
 b=IjTQOBE9Wx5HnHfdk0Tc+vu2UILsL/Zu1VhlYV0mSsZaRaTEkn5DzF2OCuPx/1uNhDydef
 AW+1SWTyWYC27/P/X5sVeDLSiP2GwN/8LnorqRSFSkiwkfJDO2R1rBuRSCqMqFOH7EAC22
 pvusbyZAbzT0PRUAM6S1V928np6vM+k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-LVGBbTrvN66hTohZ7yIYHQ-1; Mon,
 27 Jul 2026 14:23:32 -0400
X-MC-Unique: LVGBbTrvN66hTohZ7yIYHQ-1
X-Mimecast-MFC-AGG-ID: LVGBbTrvN66hTohZ7yIYHQ_1785176609
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AE5A195E909; Mon, 27 Jul 2026 18:23:28 +0000 (UTC)
Received: from localhost (unknown [10.2.16.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7A5530010D0; Mon, 27 Jul 2026 18:23:25 +0000 (UTC)
Date: Mon, 27 Jul 2026 14:23:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: ConKite <connorkite@gmail.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 qemu-block@nongnu.org, virtio-fs@lists.linux.dev,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: [PATCH RFC 00/15] vhost-user: isolated memory
Message-ID: <20260727182324.GA371693@fedora>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <a45f108c-f897-40b7-a996-9e55150c09c8@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7gZyb6NXvQiWaoF9"
Content-Disposition: inline
In-Reply-To: <a45f108c-f897-40b7-a996-9e55150c09c8@rsg.ci.i.u-tokyo.ac.jp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

--7gZyb6NXvQiWaoF9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 12:45:08PM +0900, Akihiko Odaki wrote:
> I also hope this could fix vhost-user for TCG:
> https://gitlab.com/qemu-project/qemu/-/work_items/2092
>=20
> Perhaps the memory isolation should be enabled by default for TCG.

If I understand the bug correctly, TCG needs the dirty bitmap to be
up-to-date and vhost-user's dirty logging mechanism does not suffice.
Memory isolation would keep the dirty bitmap up-to-date but copying data
between guest RAM and the isolated memory would add overhead.

For the TCG use case it should be possible to use just
vhost-shadow-virtqueue.c without isolated memory so that
vhost_svq_flush() -> virtqueue_fill() -> virtqueue_unmap_sg() ->
dma_memory_unmap() keeps the dirty bitmap updated. There is still an
overhead because the virtqueue kick/call is intercepted by QEMU, but
there is no memcpy.

The TCG use case is something that could be tackled once memory
isolation is finished. If no one has time to implement the pure svq
solution for TCG, then memory isolation could be used in any case.

Stefan

--7gZyb6NXvQiWaoF9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpnohwACgkQnKSrs4Gr
c8jIxQgAuhwfSxCzUAdPtmkhQFxI+8GOr3btP712SYvxsAHGWWd4zJ53QTx8uue5
ElpE2sc3AGz1CX++E+AcyrOI2Ut1wnsiAF42M3Zx5eHfpi7X4MEjf2uDUcxcAiEb
RMjgfDl7gOBll5xnICbtouc3N+5PL9KyFXhLV4/kVsS8EamcCfO+X+N82jDxVhFG
gDUUuBWNk2kqla8RffqOO63ccVkWTDwUYnfWWBAC+urVi8E+QGh8RgnW6NS0hXPU
ElgGeB0pRrbfow60Rbd8tQxeF3mLifE3dd9AJTonR7Ivf3CrSvhv7EgdOCiczEQr
Sx+vK5c7gHAJizeupduM8aZCfV9S2g==
=3WQy
-----END PGP SIGNATURE-----

--7gZyb6NXvQiWaoF9--


