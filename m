Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E09BC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x544u-0002nJ-5a; Fri, 11 Sep 2026 12:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x544j-0002md-7J
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x544e-0001yf-Jw
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789143958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4q4XIxW/vwNesCg/a34TUO9RXpsXNeKwK6PzYAFAAaI=;
 b=QLnEL+oshB7lCp9ahxiJFYR0Q+zwcP2ghYQicJeNSe4gOSrmjpGno3/WA/7xlv6e79mikP
 ShBiYY9jFEKN42yYAHwVW9wSwVKyclw56lflAVv8Mstz349k5AIZNREbvD4NUDxkIJna9d
 JwnPWrtTFDRFjxCTCPHpuUqC9iEkRBI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-BbleVnsAMvOQUHwFoS9lPQ-1; Fri,
 11 Sep 2026 12:25:55 -0400
X-MC-Unique: BbleVnsAMvOQUHwFoS9lPQ-1
X-Mimecast-MFC-AGG-ID: BbleVnsAMvOQUHwFoS9lPQ_1789143952
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 551D81954B0A; Fri, 11 Sep 2026 16:25:51 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E455433; Fri, 11 Sep 2026 16:25:48 +0000 (UTC)
Date: Fri, 11 Sep 2026 12:25:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
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
 Eric Blake <eblake@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Peter Xu <peterx@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: [PATCH RFC v2 13/13] net/vhost-user: add memory isolation
Message-ID: <20260911162547.GA157639@fedora>
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-13-948aae960abb@gmail.com>
 <87lda12mhy.fsf@pond.sub.org>
 <CA+spn3qK+n+buANnmkT6J8Yu4ZbwS_CqRbisE1uOmNsn1835iw@mail.gmail.com>
 <87lda010j1.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KnjVaE+vH1BLpuM3"
Content-Disposition: inline
In-Reply-To: <87lda010j1.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--KnjVaE+vH1BLpuM3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 07:54:26AM +0200, Markus Armbruster wrote:
> Connor Kite <connorkite@gmail.com> writes:
>=20
> > On Thu, Aug 20, 2026 at 2:02=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com> wrote:
> >>
> >>
> >> Any guidance on when to enable it?
> >>
> > ...
> >
> >> Likewise.
> >>
> >
> > In both cases, you would enable this for added security.  There's
> > obviously a performance hit, but it prevents a potentially misbehaving
> > vhost-user backend from reading or modifying undesired portions of
> > guest memory, since data transfer occurs wholly via bounce buffers.
> > This may be more useful in the generic netdev vhost user case than it
> > is with the passt version, but the goal is for the mode to be
> > accessible for any vhost-user device.
>=20
> Work this into the commit message, please.
>=20
> > Do you think guidance is needed here in net.json?  I was thinking
> > that, if isolation-mode gets to a point of being merged, then
> > information like this would make sense somewhere in the online
> > documentation, but I'm happy to add something here as well.  I was
> > just trying to be similarly short and to-the-point as the other option
> > descriptions for these structs.
>=20
> I think it needs to be somewhere in the user documentation.  We have so
> many configuration options, and so little guidance on what to do with
> them.
>=20
> The doc comments in the QAPI schema are reference documentation (they go
> into the "QEMU QMP Reference Manual").  Reference documentation should
> be concise and to the point.  When you have more useful things to say
> than fit there, you need to find nother place, and maybe link to it from
> the reference docs.
>=20
> I suggest to try adding brief guidance to the doc comment, and then we
> see how we feel about it.
>=20

Here is the vhost-user documentation:
docs/system/devices/virtio/vhost-user.rst

You could add a section to this document explaining the memory isolation
feature.

Stefan

--KnjVaE+vH1BLpuM3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqkK4sACgkQnKSrs4Gr
c8iXVwf8DGpxrzx9sLiqhzx/nPuFuWno1XrNXMpuygfYefGT3kkNbrCM+7Ajf3sF
Zf+R2yKfp7zLKw4wk2fFXxr9xBC+betiNkPGzHNardyzABhHmDvbaYXsthlzeNp3
/3Tn7BcLjc8rH7h3BoE30GgnGvRBJSLsJ2iyQodjha2V6SEWq+dqF6T9KduOPXr1
6C8cIHs6FqBRNP6kPAZ0ZkjUGv3XeMhnC3UXRb9mR447T4la/TucQOXZJtp4qbo8
O/G2SmK0Kim9OXwljF4zQgXTczoZannQnx4gVgsC3vBU2glM2Bjr7LbbMCzFYkud
RjaktYz9gizD10dTMLT+tnxBNZS54Q==
=buAp
-----END PGP SIGNATURE-----

--KnjVaE+vH1BLpuM3--


