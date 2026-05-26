Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8023BCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 18:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRwpz-00037S-3d; Tue, 26 May 2026 14:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRwpw-00036y-PW
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRwpu-0004Wk-4u
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779821344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oAlxdl4eyya0a/SQVD+VmpQt0sy/ZDm2um8uJpSaQSc=;
 b=Q/1R4/rBra2t5BZBoOrpt9ygfgk0FONLPd0G7YUAAJueikHFmoWCl4C6gKTQsmXufdZnOB
 r8kGzErNtf0ZFx7humo0aN/PSKEO3nc+GK3iJg3DVTiI0W2yAj3rLjq957RGN3TUcsGDNq
 KP22Bnv5KFJDIWwIIQ2bGlIBa6n9mms=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-3-GuWBDfPRaYg3gNOa00wQ-1; Tue,
 26 May 2026 14:49:02 -0400
X-MC-Unique: 3-GuWBDfPRaYg3gNOa00wQ-1
X-Mimecast-MFC-AGG-ID: 3-GuWBDfPRaYg3gNOa00wQ_1779821341
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E9C4195608C; Tue, 26 May 2026 18:48:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.201])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAA3619560A3; Tue, 26 May 2026 18:48:56 +0000 (UTC)
Date: Tue, 26 May 2026 14:48:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Raphael Norwitz <rnorwitz@nvidia.com>
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Milan Zamazal <mzamazal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, zhenwei pi <zhenwei.pi@linux.dev>,
 Hanna Reitz <hreitz@redhat.com>, virtio-fs@lists.linux.dev,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v3 5/5] vhost-user: add skip_drain param to GET_VRING_BASE
Message-ID: <20260526184855.GA1762453@fedora>
References: <20260330095226.158386-1-dtalexundeer@yandex-team.ru>
 <20260330095226.158386-6-dtalexundeer@yandex-team.ru>
 <613f140f-de27-4f83-8a02-5370833dd659@nvidia.com>
 <965db8ae-b44a-4b29-b006-56e8474d52b5@yandex-team.ru>
 <c9082536-6b4b-4e9a-a6ff-764dbbf649c9@nvidia.com>
 <19b0aa2e-90dc-4467-acc8-adc0bec7c388@yandex-team.ru>
 <1c6af04b-9efd-4d07-ab5c-e6d616818c2c@nvidia.com>
 <9fb43ec4-7825-4382-991f-a2cc17142138@yandex-team.ru>
 <be99a7b5-1575-4da0-93dd-8460a77ddf77@yandex-team.ru>
 <7fc11fc4-4bc7-46b3-8d83-1ab5a8198cda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G2V4MdiFmcwLQ/A7"
Content-Disposition: inline
In-Reply-To: <7fc11fc4-4bc7-46b3-8d83-1ab5a8198cda@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--G2V4MdiFmcwLQ/A7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 05:34:37PM -0400, Raphael Norwitz wrote:
> Apologies for the late reply.
>=20
> On 5/12/26 1:55 AM, Alexandr Moshkov wrote:
> > Gentle ping :)
> >=20
>=20
> [...]
>=20
> > > > > > On 4/16/26 5:26 AM, Alexandr Moshkov wrote:
> > > > > > > Greetings! Thanks for reply!
> > > > > > >=20
> > > > > > >=20
> > > > > > > On 4/15/26 20:21, Raphael Norwitz wrote:
> > > > > > > > I=E2=80=99m not sure I like using the num field in
> > > > > > > > vhost_vring_state to set magic values which
> > > > > > > > affect protocol behavior for GET_VRING_BASE. It
> > > > > > > > feels like a hack to me. I would think the
> > > > > > > > proper solution if we want to support migration
> > > > > > > > from new to old would be to have new use a
> > > > > > > > different new message entirely. Can we do that?
> > > > > > >=20
> > > > > > > I think we can, but I thought at first that this
> > > > > > > will be almost a complete copy of GET_VRING_BASE
> > > > > > > message, with the exception of waiting for drain of
> > > > > > > requests, so I choose to expand existing message.
> > > > > > >=20
> > > > > >=20
> > > > > > I think a new message would be cleaner. Anyone else have though=
ts?
> > > > > >=20
> > > > > > > If this is not an appropriate approach, is it better
> > > > > > > to make a new message like GET_VRING_BASE or a
> > > > > > > separate message used together with default
> > > > > > > GET_VRING_BASE message (for example, message for
> > > > > > > setting some kind of status on the server)? What
> > > > > > > should I name this new message?
> > > > > > >=20
> > > > > >=20
> > > > > > Maybe GET_VRING_BASE_SKIP_DRAIN? How would a separate
> > > > > > message used together with default GET_VRING_BASE
> > > > > > message work?
> > > > >=20
> > > > > I was thinking about a message something like
> > > > > SET_VRING_ENABLE - for example SET_SKIP_DRAIN_ENABLE, that
> > > > > would enable/disable some state (skip_drain) in the backend.
> > > >=20
> > > > I'd need to see the flow in more detail but sounds promising.
> > >=20
> > > On migration vhost-user-blk firstly send SET_SKIP_DRAIN_ENABLE with
> > > num =3D 1 message if `inflight-migration` device parameter
> > > and=C2=A0VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT enabled. Then =
send
> > > GET_VRING_BASE and continue work as usual.
> > >=20
> > > On SET_SKIP_DRAIN_ENABLE backend sets inner state (skip_drain) so
> > > when GET_VRING_BASE is called and skip_drain is true the drain will
> > > skipped.
> > >=20
> > > What do you think?
> > >=20
>=20
> I'm happy with that in theory but would like more clarity on the details.=
 In
> particular, I'm not sure what you mean by "vhost-user-blk firstly send
> SET_SKIP_DRAIN_ENABLE". To add a new message I would think we would have =
to
> do a vhost-user protocol feature negotiation to gate it.
>=20
> Also what are the precise semantics for SET_SKIP_DRAIN_ENABLE? Would it be
> sent on backend connect or when we're about to migrate?
>=20
> I was hoping others would comment but at this point I'd suggest drafting =
the
> code and then we can re-review.

Adding a new GET_VRING_BASE_SKIP_DRAIN message seems simpler to me than
a stateful SET_SKIP_DRAIN_ENABLE where the back-end needs to stash the
enable_skip_drain state and the front-end would have to toggle the state
if it switches between skip drain and classic behavior.

Stefan

--G2V4MdiFmcwLQ/A7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoV6xcACgkQnKSrs4Gr
c8gO5QgAgA3dv5wURe71crXnlRC9xGXeM1mgFfgbXQxAHQPyeVbmGMoilz8NyqqH
lIzGb3uLNi5Sa6Zsnp0bWYZ6VF7AB3oDKUrRT/mqE7fG0MZBj3NQu2MgftOb4zk5
Vlt4phkUNBsPePj32pRkxY9+vHvxoyAGBMQd6H0QNW6HZP3x8aYMuqDCGlXYCO7R
7B1oRrvhcvVobpWNQqWLYT3nVUdRULbOML/V5VMPm3LHizNE+Dx1hzJJJ8+IS9Xd
9NefbVhUGlvEtq8mXvWTZakko7xL9I1lrMId7RTmEcscgwOfI5SfGItex5c4yM/z
2GMkooROV2GEUxkzzItRe6rhPmdjOA==
=hmVh
-----END PGP SIGNATURE-----

--G2V4MdiFmcwLQ/A7--


