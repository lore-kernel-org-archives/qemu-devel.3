Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4D4CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 20:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXmG1-0000k0-FD; Thu, 11 Jun 2026 16:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXmFz-0000je-Oj
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 16:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXmFy-0006MP-6p
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 16:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781210645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TFP5LHuWA5LVKrNnDx0lXpo8afxDCZV5Rlf4d0ITUhg=;
 b=d0Am1s/Wg8BPJen7J44gMZ3mKb3WGRhRbu3M3m2ZwiOqPvnsbzO+6UCsmCKuU9DUPhMwlL
 tupPN5mde0/thmMKz6PqpPgQp2PWkUJmVunsUigqorukuIgSQD9Ke7j7HPbKT/Qwju+fqH
 tMxkIucq02l1bPg0Q1e6wI1ryxJAkzc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-wV9QdDB6NnK7RgZ2OMvUaA-1; Thu,
 11 Jun 2026 16:44:00 -0400
X-MC-Unique: wV9QdDB6NnK7RgZ2OMvUaA-1
X-Mimecast-MFC-AGG-ID: wV9QdDB6NnK7RgZ2OMvUaA_1781210637
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 839871956069; Thu, 11 Jun 2026 20:43:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.171])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A4A3C1955BE0; Thu, 11 Jun 2026 20:43:55 +0000 (UTC)
Date: Thu, 11 Jun 2026 16:43:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dorinda Bassey <dbassey@redhat.com>, Albert Esteve <aesteve@redhat.com>,
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
Message-ID: <20260611204354.GC237427@fedora>
References: <20260601151815.GC411459@fedora>
 <20260601160352-mutt-send-email-mst@kernel.org>
 <CACzuRyxedVMHNGkRf7AVyPWUTMgBMa6_DBnSHn+V6H7wN7XzWw@mail.gmail.com>
 <20260604162853.GC115597@fedora>
 <CAJSP0QXR6MyqoE1Uh-X7DzsOabbbN69TUyxf8r6ghUDCQnrP=w@mail.gmail.com>
 <CAFEAcA_Kd5_k+XyagUbB2+YVEMB0Sb0AB=oUZu6bGDot9TaFrQ@mail.gmail.com>
 <CAJSP0QVuSvVwa1szAy_3WVtWOjGK=oYAXjqAzbg5YoEvgybRjA@mail.gmail.com>
 <20260609163536-mutt-send-email-mst@kernel.org>
 <CAJSP0QWP5OnSaed4xD0FomwVSs1mN7e_U2jaM9KPFEy2bWPrVQ@mail.gmail.com>
 <aimTUHRIOFwYXvpw@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a28pE0YQ6E9QR4Wi"
Content-Disposition: inline
In-Reply-To: <aimTUHRIOFwYXvpw@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--a28pE0YQ6E9QR4Wi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 05:39:44PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jun 10, 2026 at 09:03:39AM -0400, Stefan Hajnoczi wrote:
> > On Tue, Jun 9, 2026 at 4:36=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Tue, Jun 09, 2026 at 03:44:49PM -0400, Stefan Hajnoczi wrote:
> > > > On Tue, Jun 9, 2026 at 2:51=E2=80=AFPM Peter Maydell <peter.maydell=
@linaro.org> wrote:
> > > > >
> > > > > On Tue, 9 Jun 2026 at 19:00, Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
> > > > > > I'm not sure if anyone brought up this topic on qemu-devel and =
with
> > > > > > Michael before. As I mentioned in my reply, there are ways to a=
void
> > > > > > blocking vhost-user spec changes when qemu.git is frozen:
> > > > > >
> > > > > > The simplest approach is to keep merging vhost-user.rst changes=
 during
> > > > > > freeze since it does not jeopardize the release or introduce
> > > > > > instability.
> > > > >
> > > > > I'm not enthusiastic about having "this one document is an
> > > > > exception to our freeze and release process". Because it is
> > > > > only documentation, it is in the same "we can be relatively
> > > > > relaxed about allowing in documentation changes" boat as
> > > > > most of the rest of the docs. But docs changes can break the
> > > > > build (e.g. if you mess up a rST syntax thing), so as we
> > > >
> > > > CI prevents broken rST from being merged (there are multiple jobs w=
ith
> > > > `--enable-docs`), so I'm not sure this can happen?
> > > >
> > > > > get closer to the final release we are going to get more
> > > > > strict about "is this change really necessary or can it
> > > > > wait a few weeks?", and they must at a minimum continue to obey
> > > > > the "no changes of any kind between the last RC and the final
> > > > > release" rule.
> > > >
> > > > Why is the final release candidate special?
> > > >
> > > > > And definitely if a patchseries has both
> > > > > QEMU code changes and documentation updates then that is
> > > > > going to not get applied during freeze if the code changes
> > > > > don't follow the freeze rules.
> > > >
> > > > I agree that code changes cannot be merged.
> > > >
> > > > As long as the vhost-user maintainer is confident that the spec cha=
nge
> > > > is implementable and stable, they can merge the spec change on its =
own
> > > > without code changes. If they are not confident, then the spec chan=
ge
> > > > isn't ready to be merged yet.
> > > >
> > > > Stefan
> > >
> > > I personally have been confidently wrong enough times. Maybe others k=
now
> > > how to do better.
> >=20
> > There is a risk with merging a spec change without a finished
> > implementation, so no one can get it right every time.
> >=20
> > I bring this up because a clear guideline would help implementers know
> > what to expect.
>=20
> I'd be inclined to require non-trivial spec changes to have an
> accompanying impl that is broadly feature complete, linked to by
> the contributor as a pre-req for merge.
>=20
> If an impl is not ready, then by all means send spec proposals
> for the sake of design discussions. It can evolve in parallel
> with the impl, but the spec doesn't need to merge until the impl
> is broadly complete.
>=20
> A code impl does not need to live in the same place as the spec
> though.

VIRTIO does things this way most of the time and it works well. The spec
needs to be merged before the implementations, but sending out the
implementation patches around the same time as the spec patches is
appreciated by the spec reviewers.

Stefan

--a28pE0YQ6E9QR4Wi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmorHgoACgkQnKSrs4Gr
c8imqQf/Tn+bfbqZoMdMDaqgBbnXN1SKdDqxFMsAjeUWA/WdHNiokz2dL6/+RLJp
3MC186U7dCGQaxS//n2Tff2TbX9ZXT1jN+TH+1PJVah8TImHxOeL15PsqVw5zf6j
DoPHuoNVy5KimPhn98GhNKaH4hr5rbsF/hIFY0ryMSNQ184WgW4K0XjAZ4+koGpJ
MjwkGMot1mtrhntCa8DlvFyjFChgwqwxKTZpNMAGsAHe6u/i8mo0MIrgfw1ObAhT
UH5wJBVhK7rbC+dUVoILt+WLWCNeOfDiGvLmyu9Pz/G0Y0AZwruK4epHyI/M5g4r
9Hsp6t/kIcGELT44IcZWP0Ci/Ss4+Q==
=r8/a
-----END PGP SIGNATURE-----

--a28pE0YQ6E9QR4Wi--


