Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155A7C55164
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpTJq-0004RS-M8; Thu, 30 Jul 2026 12:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wpTJf-0004QV-Pb
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:09:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wpTJd-0002cw-RH
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785427740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dsVpAu3QcfKYN17RfZrDdBsSoJyLiS2uxIUvPEK9QqU=;
 b=RjVccr9XwuXWJm7W1EP4DzedI3kf3HVtavRhvFFg8Pe2dJ5BTv+DWgt3T+5hIbn+N///KR
 bTZGLpvFj9BQ63ziWUs4++oLVvYvpBKOTY+UdzptOlTDgf80PdFeXCTXV+ytKftbMUDukp
 cMKMp1MeXcdqprn0vOgti+bX4KeB7Vc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-0ZkvAFqSNH61vdvzDvY8hQ-1; Thu,
 30 Jul 2026 12:08:56 -0400
X-MC-Unique: 0ZkvAFqSNH61vdvzDvY8hQ-1
X-Mimecast-MFC-AGG-ID: 0ZkvAFqSNH61vdvzDvY8hQ_1785427734
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DD001956080; Thu, 30 Jul 2026 16:08:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.178])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 180BC30002E9; Thu, 30 Jul 2026 16:08:50 +0000 (UTC)
Date: Thu, 30 Jul 2026 12:08:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 "Denis V. Lunev" <den@openvz.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v2 6/8] block: add missing coroutine_fn annotations
Message-ID: <20260730160849.GE1442692@fedora>
References: <20260725-co-v2-0-d3552ddb3931@redhat.com>
 <20260725-co-v2-6-d3552ddb3931@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g6ePFKhtStmVnIyL"
Content-Disposition: inline
In-Reply-To: <20260725-co-v2-6-d3552ddb3931@redhat.com>
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

--g6ePFKhtStmVnIyL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 01:48:37PM +0400, Marc-Andr=E9 Lureau wrote:
> diff --git a/block/parallels.c b/block/parallels.c
> index 7a90fb5220b9..6f96cc4e3045 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -142,8 +142,9 @@ static uint32_t host_cluster_index(BDRVParallelsState=
 *s, int64_t off)
>      return off / s->cluster_size;
>  }
> =20
> -static int64_t block_status(BDRVParallelsState *s, int64_t sector_num,
> -                            int nb_sectors, int *pnum)
> +static int64_t
> +block_status(BDRVParallelsState *s, int64_t sector_num,
> +             int nb_sectors, int *pnum)
>  {
>      int64_t start_off =3D -2, prev_end_off =3D -2;
> =20

This hunk looks like an accidental whitespace change? This function is
not a coroutine function.

> @@ -2126,7 +2128,8 @@ fail:
>      return ret;
>  }
> =20
> -static void qcow2_reopen_commit(BDRVReopenState *state)
> +static void
> +qcow2_reopen_commit(BDRVReopenState *state)

Whitespace change?

Looks good aside from these whitespace changes.

--g6ePFKhtStmVnIyL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmprdxEACgkQnKSrs4Gr
c8js3wgAnl0wOlSZnyScyNQg+Isn1t4N5afPjcm8ELinnU9anKcEJ1Sp1TkPsU9Q
NwkfxO7GkL7vXUyVnUWSUh/oNRVYEXrgxNbxGMwG1mTdM7DA/jta+ap1efLTmNbr
gK2SHM9ofCIdb1RltGF6b11gq607rjdF9dFy7vK9d3nmV6FHIqauvSiKUY5ksteR
DUsNbxgdLc6hcNNGRzhyLYBsNazRginbl9zsKTLO5lp7ovVUIqzf/QNsIOyRU3xE
wqZd8THPyZRBnkwbi/vTQjg9XBS5rm4BM/aIbYADrhLfqsX9jwHK/K5IOsK+OvuY
Xw9Th5pdJNz/Ib8OiJpSzxo4PPKiLg==
=ZGHJ
-----END PGP SIGNATURE-----

--g6ePFKhtStmVnIyL--


