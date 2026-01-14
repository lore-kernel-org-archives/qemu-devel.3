Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A9CD3901E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 21:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg8Zx-0006vc-Ow; Wed, 14 Jan 2026 16:39:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vg8ZT-0006qG-7m
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 16:38:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vg8ZR-0005os-Nn
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 16:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768426707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JPx9uJw4wQmF8PUhN2KKTU9qO0xqstrOMTkwEsCbpVM=;
 b=StazULHcVGMf4BuoUlToZSz0Ooh1Y4utn8m5hUOehiMFKC2Fw0FCapJCieqSioDqaq14d9
 f1pwUx3+8BYyyjREN5yxCuQeveBq5IZUHClPOgj+swWuroNXPCerf29FS6uAKsFENRHytz
 bvhBtaLJ3s4yK6D1Tg6IGtfPezD51FM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-eLEcRTmEMTGcoXSAktue6Q-1; Wed,
 14 Jan 2026 16:38:23 -0500
X-MC-Unique: eLEcRTmEMTGcoXSAktue6Q-1
X-Mimecast-MFC-AGG-ID: eLEcRTmEMTGcoXSAktue6Q_1768426702
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF6911956094; Wed, 14 Jan 2026 21:38:20 +0000 (UTC)
Received: from localhost (unknown [10.2.17.85])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ADFA330002D8; Wed, 14 Jan 2026 21:38:18 +0000 (UTC)
Date: Wed, 14 Jan 2026 16:38:17 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 mzamazal@redhat.com, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, virtio-fs@lists.linux.dev,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 4/5] vhost: add vmstate for inflight region with inner
 buffer
Message-ID: <20260114213817.GA622013@fedora>
References: <20260113095813.134810-1-dtalexundeer@yandex-team.ru>
 <20260113095813.134810-5-dtalexundeer@yandex-team.ru>
 <aWfrT6JOMm9MGoIw@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2bB6VCgR7K7AjZez"
Content-Disposition: inline
In-Reply-To: <aWfrT6JOMm9MGoIw@x1.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--2bB6VCgR7K7AjZez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 02:15:27PM -0500, Peter Xu wrote:
> On Tue, Jan 13, 2026 at 02:58:17PM +0500, Alexandr Moshkov wrote:
> > Prepare for future inflight region migration for vhost-user-blk.
> > We need to migrate size, queue_size, and inner buffer.
> >=20
> > So firstly it migrate size and queue_size fields, then allocate memory =
for buffer with
> > migrated size, then migrate inner buffer itself.
> >=20
> > Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> > ---
> >  hw/virtio/vhost.c         | 57 +++++++++++++++++++++++++++++++++++++++
> >  include/hw/virtio/vhost.h |  6 +++++
> >  2 files changed, 63 insertions(+)
> >=20
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index c46203eb9c..f655c53b67 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -2028,6 +2028,63 @@ const VMStateDescription vmstate_backend_transfe=
r_vhost_inflight =3D {
> >      }
> >  };
> > =20
> > +static int vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
> > +{
> > +    info_report("vhost_inflight_region_buffer_pre_load");
> > +    struct vhost_inflight *inflight =3D opaque;
> > +
> > +    int fd =3D -1;
> > +    void *addr =3D qemu_memfd_alloc("vhost-inflight", inflight->size,
> > +                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL=
_SEAL,
> > +                                  &fd, errp);
> > +    if (*errp) {
> > +        return -ENOMEM;
> > +    }
> > +
> > +    inflight->offset =3D 0;
> > +    inflight->addr =3D addr;
> > +    inflight->fd =3D fd;
> > +
> > +    return 0;
> > +}
> > +
> > +const VMStateDescription vmstate_vhost_inflight_region_buffer =3D {
> > +    .name =3D "vhost-inflight-region/buffer",
> > +    .pre_load_errp =3D vhost_inflight_buffer_pre_load,
> > +    .fields =3D (const VMStateField[]) {
> > +        VMSTATE_VBUFFER_UINT64(addr, struct vhost_inflight, 0, NULL, s=
ize),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static int vhost_inflight_region_post_load(void *opaque,
> > +                                           int version_id,
> > +                                           Error **errp)
> > +{
> > +    struct vhost_inflight *inflight =3D opaque;
> > +
> > +    if (inflight->addr =3D=3D NULL) {
>=20
> IIUC this can never happen because pre_load() must trigger before
> post_load(), and when reaching post_load() it means pre_load() must have
> succeeded..
>=20
> So, IIUC we can drop this post_load() completely (or assert addr in
> pre_load instead).

I asked for this input validation check. If the migration stream is
inconsistent (e.g. broken or malicious source QEMU), then the subsection
might be missing but size could be non-zero. The destination QEMU should
fail cleanly and not run into undefined behavior.

Stefan

--2bB6VCgR7K7AjZez
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmloDMkACgkQnKSrs4Gr
c8hbPgf+JtCqYyM/8FZOLpH5UQkkWwKV8n+FMsFmGk9Gkvt7330GJrKEK1GMIAET
gB8d9CJIr1ndEs8iEolaou4YY0yNm8OTFJ0mkv3W+9yDV6ULsY0ydYkAU9eEbFNt
wJjZMuUQAHL5W4w5+8CpPr37LZCcgrlwlWSUw9dhvY1KhOKeLMfSIrbIxQOO3BAO
P/QHJXL/dg8b5PQqkiTPH8+hfWWfRGRCUnPFibOEph+2G3gbbkk9SLTkInIbgWR2
FmMw6SIuaoNEo0yYawA74r0CuJ16x0Z1NLQpAzlyLGNwEuLWub4h8hDcI7OjrtqV
7ObFpwOGg7FbcWV4dsyaJL9C003jVQ==
=xwdv
-----END PGP SIGNATURE-----

--2bB6VCgR7K7AjZez--


