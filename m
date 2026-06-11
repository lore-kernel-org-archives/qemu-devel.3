Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306ECCD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 20:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXmBY-00080H-PF; Thu, 11 Jun 2026 16:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXmBX-0007zP-K6
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 16:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXmBV-0003X5-Mw
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 16:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781210367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ilW3ypT7QEQdnPqUn55yCn7MxtCRrIlcHCGhX4f1T0=;
 b=LZHyBnywdBF82Jviom8GfNEObEQemoOp1wuk9wAtWCN5GnxLCVMF5nPYxoai8Bi+JpGj/C
 GvuUHCt+KPqyAlenOWvdzEc75gIq69UU+ugGv2e9qsim+NeZvDp9HbS7wsz2jRGtMKgcyw
 8aGGfptviwIVF5Yb0DcmHnMhDqNHFXU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-qNtfdxu9PjWGyVmdjPYwzA-1; Thu,
 11 Jun 2026 16:39:21 -0400
X-MC-Unique: qNtfdxu9PjWGyVmdjPYwzA-1
X-Mimecast-MFC-AGG-ID: qNtfdxu9PjWGyVmdjPYwzA_1781210359
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0B411805C28; Thu, 11 Jun 2026 20:39:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.171])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 723341954128; Thu, 11 Jun 2026 20:39:16 +0000 (UTC)
Date: Thu, 11 Jun 2026 16:39:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Dorinda Bassey <dbassey@redhat.com>,
 Albert Esteve <aesteve@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev,
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Demi Marie Obenour <demi@invisiblethingslab.com>,
 Alyssa Ross <hi@alyssa.is>, Mark Burton <MBURTON@qti.qualcomm.com>,
 Matti Moell <matti@qti.qualcomm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>,
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>
Subject: Re: Where should the vhost-user specification live?
Message-ID: <20260611203915.GB237427@fedora>
References: <CADSE00+ziHc8W2FqNT-aJU0Lt4sZ=NfQLc65m16vpT++pZM+xQ@mail.gmail.com>
 <20260601151815.GC411459@fedora>
 <20260601160352-mutt-send-email-mst@kernel.org>
 <CACzuRyxedVMHNGkRf7AVyPWUTMgBMa6_DBnSHn+V6H7wN7XzWw@mail.gmail.com>
 <20260604162853.GC115597@fedora>
 <CAJSP0QXR6MyqoE1Uh-X7DzsOabbbN69TUyxf8r6ghUDCQnrP=w@mail.gmail.com>
 <CAFEAcA_Kd5_k+XyagUbB2+YVEMB0Sb0AB=oUZu6bGDot9TaFrQ@mail.gmail.com>
 <CAJSP0QVuSvVwa1szAy_3WVtWOjGK=oYAXjqAzbg5YoEvgybRjA@mail.gmail.com>
 <CAFEAcA9ZkbNK5kRL5+OiqgN2hk3JAmFN8Qd3cytqyTEm9hBkvg@mail.gmail.com>
 <aikiB90tij642pEZ@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qvfpYexFwf7TVkyW"
Content-Disposition: inline
In-Reply-To: <aikiB90tij642pEZ@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--qvfpYexFwf7TVkyW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 09:37:10AM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jun 09, 2026 at 08:51:15PM +0100, Peter Maydell wrote:
> > On Tue, 9 Jun 2026 at 20:45, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > >
> > > On Tue, Jun 9, 2026 at 2:51=E2=80=AFPM Peter Maydell <peter.maydell@l=
inaro.org> wrote:
> > > >
> > > > On Tue, 9 Jun 2026 at 19:00, Stefan Hajnoczi <stefanha@gmail.com> w=
rote:
> > > > > I'm not sure if anyone brought up this topic on qemu-devel and wi=
th
> > > > > Michael before. As I mentioned in my reply, there are ways to avo=
id
> > > > > blocking vhost-user spec changes when qemu.git is frozen:
> > > > >
> > > > > The simplest approach is to keep merging vhost-user.rst changes d=
uring
> > > > > freeze since it does not jeopardize the release or introduce
> > > > > instability.
>=20
> snip
>=20
> > I tend to view the specs subsection of the docs as being
> > for things where either QEMU really is the authoritative
> > source (eg fw_cfg), or where the spec is for something that's
> > basically moribund and has no better home. If vhost-user is
> > a cross-project specification that it so active that it
> > cannot live within QEMU's release process, then I think
> > it deserves to have its own independent home.
>=20
> Yes, the main impression I get having read through this whole thread
> is that vhost-user spec should have its own home outside QEMU.
>=20
> We can come up with all sorts of rationalizations for how to make
> things work in the context of QEMU, but they all just come across
> as excuses to avoid changing the fairly arbitrary historical use
> of qemu.git. Even if as QEMU maintainers we consider that we're a
> "neutral" home, I can understand why it might not be perceived that
> way from the outside.
>=20
> If people want agility such that we need to make exceptions for
> our rules during freeze that is one flag that it doesn't belong
> with the main qemu.git, but there are broader points that are
> pushing my view in that direction too.
>=20
>=20
> Not mentioned is that engaging with the QEMU mailing list as a
> non-regular QEMU contributor is not a very attractive task.
> While QEMU may be satisfied with email, QEMU are in a tiny
> minority these days. The rest of the OSS community has
> decided that git forges are the better way to collaborate.
>=20
> Our dev list is very high volume, with changes very easily (and
> often) lost in the noise, even from regular contributors, such
> that we have to teach people to (repeatedly) "ping" to attract
> attention.

A separate repo in a git forge definitely has the advantage of making
communication easier to follow for anyone interested only in the
vhost-user protocol.

> If we want agility though, IMHO it is best to stay away from the
> bureucracy of the OASIS virtio spec / committee, which is a big
> turn off IME.

Yes, OASIS adds overhead.

The downside is that vhost-user suffers from being outside the VIRTIO
spec umbrella. It's really a VIRTIO Transport and would benefit from the
discipline of actually being part of the spec as such. At the moment
vhost-user is not really bound to VIRTIO through any interface (i.e.
VIRTIO Transport) or device lifecycle that is guaranteed to align with
the VIRTIO spec. This has led to both design problems and bugs that
would be prevented by making it a VIRTIO Transport.

In addition to the OASIS overhead you mentioned, the other issue is that
moving vhost-user into the VIRTIO spec would require reconciling the
the vhost-user protocol with the VIRITO Transport's interface and also
rewriting parts of the vhost-user spec that are not up to the level
(e.g. adding conformance clauses, eliminating some informal language,
etc).

In other words, it's a bunch of work. Although from a purist perspective
I think it's the right place for vhost-user, I think it would be an
unpopular solution.

> If we're considering a move of the spec, we should probably consider
> the best home for some of the related code parts too:
>=20
>   subprojects/libvhost-user/
>   contrib/vhost-user-blk/
>   contrib/vhost-user-bridge/
>   contrib/vhost-user-gpu/
>   contrib/vhost-user-input/
>   contrib/vhost-user-scsi/
>=20
> IIUC, the subprojects is fully standalone code with no dependency
> on QEMU. It remained within QEMU for "convenience" allowing us to
> consume them from the impls under contrib/. While the contrib code
> has some depedencies on QEMU, overall they appear pretty light and
> so likely easily detached
>=20
>   $ git grep '#include "' vhost-user-* | awk '{print $2}' | sort | uniq
>   "hw/virtio/virtio-gpu-bswap.h"
>   "hw/virtio/virtio-gpu-pixman.h"
>   "libvhost-user-glib.h"
>   "libvhost-user.h"
>   "qapi/error.h"
>   "qemu/atomic.h"
>   "qemu/bswap.h"
>   "qemu/ctype.h"
>   "qemu/drm.h"
>   "qemu/iov.h"
>   "qemu/osdep.h"
>   "qemu/queue.h"
>   "qemu/sockets.h"
>   "standard-headers/linux/input.h"
>   "standard-headers/linux/virtio_blk.h"
>   "standard-headers/linux/virtio_gpu.h"
>   "standard-headers/linux/virtio_input.h"
>   "standard-headers/linux/virtio_net.h"
>   "standard-headers/linux/virtio_scsi.h"
>   "virgl.h"
>   "vugbm.h"
>   "vugpu.h"
>=20
>=20
> We have a often repeated desire to eliminate the "contrib" tree
> as a concept, since it is currently effectively a "dumping ground"
> for things which are either unmaintained or didn't have a better
> home yet. This might be a chance to provide a better home for a
> big part of it.
>=20
> IMHO this suggests it is worth creating a new top level gitlab project
> for it all to live in and form a dedicated team around it, rather than
> trying to pick any existing location.

Some vhost-user back-ends in the contrib/ directory are used by QEMU's
test suite. An alternative way of integrating them into the tests could
be found, but I wanted to mention that dependency.

Stefan

--qvfpYexFwf7TVkyW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmorHPMACgkQnKSrs4Gr
c8ioTgf9HCe8SudpuvZI/ECQCsZCNqoDK8UcuO3QE0Eglajbskm9qx76JdaY+ujM
nKqtUJiUTPxzbSbFwUaatttGlc48BkJXlPQEZoXcf7mqp38EUROnQASMW+rN3Afk
cK3zKkORSj1sdIO2ewqvO/o3iPYFzzC4JvkJb9HtDs9rQyZdbVdUxtHLmiWuwttu
zCRW1Ri12nT/Dd+zX8x2D0KwV8Tjg6NaESK0TiFEalppjju0n0tFmD3u2nJPdAi0
doXCCWaaXXmC6K8iqgBGnZTMtGcj3ZKCx3hGg1sJvHKNn/AIwBdlGWazyDwTWKqx
hnxDScpm5GmHUHoAKemBRuakaUpHtA==
=mSHC
-----END PGP SIGNATURE-----

--qvfpYexFwf7TVkyW--


