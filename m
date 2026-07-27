Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82873C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 18:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQIU-0007Re-7V; Mon, 27 Jul 2026 14:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1woQIN-0007Qu-RC
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 14:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1woQIM-0004AO-Dn
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 14:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785177801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vv2vAxkyJsstkbuLMBlczqwE+kvJD6rbHIf1vCAI7nQ=;
 b=HIqqifBDbZkLvCjZ3CeZu3YzR2PMYQfiTSu4c+Rkh1v8oohE0QmjQIk+x87vOVRjPoEWYC
 kA0cg/skbsInwyLiedxetGR2UIRo7gpatEsgY2eyPclPXJfMNCYHe+ErMOgJRB78o33+J6
 +yRxi2mnbaEa7Bli0qVqvSavvLerXtI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-LJXkFmDhM_Gcj7PmxiWvcw-1; Mon,
 27 Jul 2026 14:43:16 -0400
X-MC-Unique: LJXkFmDhM_Gcj7PmxiWvcw-1
X-Mimecast-MFC-AGG-ID: LJXkFmDhM_Gcj7PmxiWvcw_1785177794
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C60A51955F28; Mon, 27 Jul 2026 18:43:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C56318001E3; Mon, 27 Jul 2026 18:43:08 +0000 (UTC)
Date: Mon, 27 Jul 2026 14:43:05 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org,
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
Subject: Re: [PATCH RFC 03/15] backends/cryptodev-vhost-user: add memory
 isolation bool
Message-ID: <20260727184305.GB371693@fedora>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-3-6b97c439eb28@gmail.com>
 <87fr18diqb.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gY0jI/gfOQgW8+h2"
Content-Disposition: inline
In-Reply-To: <87fr18diqb.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

--gY0jI/gfOQgW8+h2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 08:06:36AM +0200, Markus Armbruster wrote:
> Connor Kite <connorkite@gmail.com> writes:
>    # @memory-isolation: disable access from cryptodev to guest memory.
>    #     (default: false) (since 11.2)
>=20
> Pardon my ignorance...  What exactly is "cryptodev" here?  Is it code
> running in another process?
>=20
> Should the description answer my question?  Perhaps like this:
>=20
>   # @memory-isolation: isolate guest memory.  Isolated guest memory
>   #     cannot be accessed from uh, what exactly?
>=20
> Fill in the blank.

Maybe it's clearer to mention the potentially untrusted vhost-user
backend process rather than cryptodev (the virtio-crypto vhost-user
device)?

Stefan

--gY0jI/gfOQgW8+h2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpnprkACgkQnKSrs4Gr
c8hfjwgAsUY5rQK5VxV+u2eBHIXa6bJmd0kuVddy2fYB8K4GFM/E7Cd7jMEPNhmL
WpVMMyTYqRcamqsSs8gXJYdXTXf7K6nO3zQW8n4vr6osXq9Ph/QRt+IkQd7RW2Rw
gzYRf/pVUWBhMf14Ds2Ak8s11TsxEngt8ACu5SqrHQR9tvOT1GJ8WrLaljpuyfEP
tTWPNSYXmUF//lXgopDaHni6khrALLfGgFTtT5/EEQlm8A8Bm7q5bNRGxdODz4DE
89UTlZ+cXmv8u9x2jyOXpvL0WtbTej/QhoNZYTetYlOkDE18/5CEFiFU/+sfeRfK
pB4iLbwCio+f3owLNiHykyBb14H2ig==
=k1yY
-----END PGP SIGNATURE-----

--gY0jI/gfOQgW8+h2--


