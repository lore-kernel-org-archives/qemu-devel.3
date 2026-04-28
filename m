Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F01FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHl4S-00008R-SC; Tue, 28 Apr 2026 12:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHl4P-000082-Ln
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:13:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHl4N-0005ry-5W
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777392833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZEp0RILUpdWq1YgQXOxJiAGQb9sHlcU4JxXGtqWzzSE=;
 b=YNeEiVwn96B/yrh/zMbvXCmOrdgHb2zExbWybV3N0AQB+eAjsSNwvTybVmPmUeNrN+f0Ij
 Zb6/G6/W6XSc9gLQKV3Bzi7ml0gncQqq/+vYwFGvE8NKRoTORKz92u3+rOIvI4SOsb6HQ6
 9ctWJJ537XFIvW0H5Dg3ywpqU3WxT0o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-_9IZn6-uMYiG8X7TDGfJaQ-1; Tue,
 28 Apr 2026 12:13:49 -0400
X-MC-Unique: _9IZn6-uMYiG8X7TDGfJaQ-1
X-Mimecast-MFC-AGG-ID: _9IZn6-uMYiG8X7TDGfJaQ_1777392822
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75E741805A01; Tue, 28 Apr 2026 16:13:40 +0000 (UTC)
Received: from localhost (unknown [10.44.33.158])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90B891800349; Tue, 28 Apr 2026 16:13:37 +0000 (UTC)
Date: Tue, 28 Apr 2026 12:13:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@stgraber.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <its@irrelevant.dk>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Keith Busch <kbusch@kernel.org>,
 Peter Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v6 8/8] tests/qtest/nvme-test: add migration test with
 full CQ
Message-ID: <20260428161334.GA278591@fedora>
References: <20260419130139.15554-1-alexander@mihalicyn.com>
 <20260419130139.15554-9-alexander@mihalicyn.com>
 <20260427200004.GF218226@fedora>
 <CAJqdLro_fUh0-yEjum0z6c2FvNsLjr95MMaA7EX810dqm+=upg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="erGKl80A3EXx33fp"
Content-Disposition: inline
In-Reply-To: <CAJqdLro_fUh0-yEjum0z6c2FvNsLjr95MMaA7EX810dqm+=upg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--erGKl80A3EXx33fp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 05:55:12PM +0200, Alexander Mikhalitsyn wrote:
> Am Mo., 27. Apr. 2026 um 22:00 Uhr schrieb Stefan Hajnoczi
> > On Sun, Apr 19, 2026 at 03:01:39PM +0200, Alexander Mikhalitsyn wrote:
> > > +
> > > +        #define GUEST_MEM_READB(field) \
> > > +                            qtest_readb(ctrl->pdev->bus->qts, (uint6=
4_t)&(field))
> > > +
> > > +        g_assert_cmpint(GUEST_MEM_READB(reqs[i].phys_identify->ieee[=
0]), =3D=3D, 0x0);
> >
> > I was trying to figure out why phys_identify has a pointer type although
> > it is a guest memory address that cannot be dereferenced in C code. I
> > guess the reason is so that the GUEST_MEM_READB() macro can use the
> > address-of operator instead of explicitly calculating the offset of
> > ieee[0], ieee[1], etc? I found this confusing and potentially dangerous
> > (the compiler won't stop the pointer from being dereferenced if someone
> > does it by mistake).
>=20
> Exactly, that was my intention, to be able to use address-of operation
> in conjunction
> with structure-dereference operator. To prevent accidental mistakes, I
> used "phys_"
> prefix in structure member names (like "cq->phys_cqe" or
> "reqs[i].phys_identify").
>=20
> >
> > It took more time to review the pointer trick than the straightforward
> > approach would have taken. I'd avoid it, but it's a question of coding
> > style and up to you.
>=20
> No problem, I think the fact that this code confused you means that my id=
ea
> wasn't that good as I thought ;-) I think I should then change a type for
> phys_identify and phys_cqe to u64 and then add explicit address arithmetic
> or continue to use "arrow" operator but in a special macro like
> GUEST_MEM_READ_SOMETHING(...).
> WDYT?

Encapsulating the address-of operator trick inside a macro would be a
nice solution. By localizing the pointer type just within the macro,
it's more obvious what the intention is and the rest of the program uses
the uint64_t type.

--erGKl80A3EXx33fp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnw3K4ACgkQnKSrs4Gr
c8hL8QgApKvXcyRWihDivJgSbLU7uBa7PuaFU0iryrmb8efYOoRJIb14+rKdxiQ6
+EpzfsvwOTa5GyrYpvOTXlAlC9RNN+U3iGjhpfQxOEhOF8L2kLB/XyIUVr1nfYdb
ndizM7JgQcgzrbaDT/1dxzrlHH3W3R/hSW4RjHAwNd3S9cZq8eQEyq3a90LQGsXn
IPFwgUzoftA3fBl99hG3ZbWoGLWyrH17Qen9+1lP8esQB5lXKsD8MT2OetX/TAum
01AkpT0YTVo/X4josWiAj3rf5WoIGre9YwrNN+COuqrEywHxLGaeyUL3D/r/Ijtz
0StMpbWLJnLcSaxewxuFvxQkryCVjw==
=8HZj
-----END PGP SIGNATURE-----

--erGKl80A3EXx33fp--


