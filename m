Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B52CD98D5
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 20:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXlqk-0003iz-4O; Thu, 11 Jun 2026 16:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXlqh-0003ib-Tx
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 16:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXlqg-0002CO-7f
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 16:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781209075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tes1mbHzpzK60rwJIB8/hzJp0VwxnCd9XhGJgxFOCMk=;
 b=NsULAuboz24JLzLt6KrbypqgPbz1hJSQCRbho0BW7GeAdDZBvWHLT66bvsN0yKRBC5sVfg
 ew8klsnVvhioG+AIvjAhPPLhtLVo3X7mMHuYyOCj3dkKMN8RbXtJYCjb8mJOaWaIfkA7d7
 qK3pkEDDvbuhqYw8LkILR+eSjcQ8Pww=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-VJVNbEo2PRaQmz_M81ejhQ-1; Thu,
 11 Jun 2026 16:17:52 -0400
X-MC-Unique: VJVNbEo2PRaQmz_M81ejhQ-1
X-Mimecast-MFC-AGG-ID: VJVNbEo2PRaQmz_M81ejhQ_1781209070
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35D3F1955EB7; Thu, 11 Jun 2026 20:17:49 +0000 (UTC)
Received: from localhost (unknown [10.2.16.171])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DBDF1955BE0; Thu, 11 Jun 2026 20:17:46 +0000 (UTC)
Date: Thu, 11 Jun 2026 16:17:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
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
Message-ID: <20260611201743.GA237427@fedora>
References: <CAJSP0QV4W=5MJsSGggACv-tqxDtiieKc0YzEn8t-R=RD94KJaQ@mail.gmail.com>
 <CADSE00+ziHc8W2FqNT-aJU0Lt4sZ=NfQLc65m16vpT++pZM+xQ@mail.gmail.com>
 <20260601151815.GC411459@fedora>
 <20260601160352-mutt-send-email-mst@kernel.org>
 <CACzuRyxedVMHNGkRf7AVyPWUTMgBMa6_DBnSHn+V6H7wN7XzWw@mail.gmail.com>
 <20260604162853.GC115597@fedora>
 <CAJSP0QXR6MyqoE1Uh-X7DzsOabbbN69TUyxf8r6ghUDCQnrP=w@mail.gmail.com>
 <CAFEAcA_Kd5_k+XyagUbB2+YVEMB0Sb0AB=oUZu6bGDot9TaFrQ@mail.gmail.com>
 <CAJSP0QVuSvVwa1szAy_3WVtWOjGK=oYAXjqAzbg5YoEvgybRjA@mail.gmail.com>
 <CAFEAcA9ZkbNK5kRL5+OiqgN2hk3JAmFN8Qd3cytqyTEm9hBkvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YopUSOk/jMlhPOfV"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9ZkbNK5kRL5+OiqgN2hk3JAmFN8Qd3cytqyTEm9hBkvg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


--YopUSOk/jMlhPOfV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026 at 08:51:15PM +0100, Peter Maydell wrote:
> On Tue, 9 Jun 2026 at 20:45, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > On Tue, Jun 9, 2026 at 2:51=E2=80=AFPM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> > >
> > > On Tue, 9 Jun 2026 at 19:00, Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
> > > > I'm not sure if anyone brought up this topic on qemu-devel and with
> > > > Michael before. As I mentioned in my reply, there are ways to avoid
> > > > blocking vhost-user spec changes when qemu.git is frozen:
> > > >
> > > > The simplest approach is to keep merging vhost-user.rst changes dur=
ing
> > > > freeze since it does not jeopardize the release or introduce
> > > > instability.
> > >
> > > I'm not enthusiastic about having "this one document is an
> > > exception to our freeze and release process". Because it is
> > > only documentation, it is in the same "we can be relatively
> > > relaxed about allowing in documentation changes" boat as
> > > most of the rest of the docs. But docs changes can break the
> > > build (e.g. if you mess up a rST syntax thing), so as we
> >
> > CI prevents broken rST from being merged (there are multiple jobs with
> > `--enable-docs`), so I'm not sure this can happen?
>=20
> We've had oddball "only with some version of Sphinx" issues
> before. I agree it's not likely, which is why we're pretty
> lenient about letting in docs changes. But at the point where
> we get to "only really critical regression/bugfixes now",
> that includes "not docs changes either".
>=20
> > > get closer to the final release we are going to get more
> > > strict about "is this change really necessary or can it
> > > wait a few weeks?", and they must at a minimum continue to obey
> > > the "no changes of any kind between the last RC and the final
> > > release" rule.
> >
> > Why is the final release candidate special?
>=20
> Because we must make no changes between it and final release.
> Anything could be a cause of a regression; the week between

I don't think a vhost-user spec change can cause a regression in a QEMU
release given that there are CI jobs checking that the docs build.

In the case of old versions of sphinx, they would need to be covered by
CI jobs if QEMU still wants to support those versions (otherwise we
might not notice issues during the entire release cycle).

That said, if you prefer not to make an exception that's fine. There are
multiple solutions available.

Stefan

> last RC and release is there to catch any last minute problems,
> and if there are any then we would roll another RC and give
> it another week (or at least a few days) for that to be
> tested. We don't put in the regression fix and do the release
> without that extra RC cycle.
>=20
> This is the way we've run releases for the last decade;
> it's not a new rule.
>=20
> I tend to view the specs subsection of the docs as being
> for things where either QEMU really is the authoritative
> source (eg fw_cfg), or where the spec is for something that's
> basically moribund and has no better home. If vhost-user is
> a cross-project specification that it so active that it
> cannot live within QEMU's release process, then I think
> it deserves to have its own independent home.
>=20
> thanks
> -- PMM
>=20

--YopUSOk/jMlhPOfV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmorF+cACgkQnKSrs4Gr
c8iHpAgAjeDcj0BO5MoreTQHuHkU8yyHmYPtle0cdgoAksnSrTNpMIwv9r1PYagS
UH5AEFhIw/SVIyBQxSCx44FjpNS67aEkoHdDpdsu7Kc5lCbt/sKW5gk2SZiGXlx9
SPyDFxCWjDJjGcM7qaYJJ4Aku49uOK6Uy6YqF7XXn8I9M60UhQI1N1HDz24rJnX8
ea95jIYXSqei68X43E2d/GfXp5I1QNI+lN8vlg2lGfI4imRaqPLG5e4sK0DodsWc
/isRrS08wOt8qK1FSzgTKPmCA35mvfiZ1mkpH0hJiKocwLDGjv14v5uQNiM+Gbe6
zVqtmHpKlqoNyBnHAvkhhesOumKsDA==
=9Tqa
-----END PGP SIGNATURE-----

--YopUSOk/jMlhPOfV--


