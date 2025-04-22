Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E9CC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7EAY-0005nP-Ni; Tue, 22 Apr 2025 10:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7EAL-0005er-8b
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7EAG-0006JU-5B
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745330393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OMtwXvaheTlkiqC0k82+nnlb5B0oIlbejhg9K2ePGgM=;
 b=b1+fQID91lyi3n0CD0nUOLk+di6Yo7PXe+0E9CZXhu18JN8wKHS/ZsXs5B2EUgHl10V2pc
 ixOe7EUUz45Am6WRj9RWk73GytsibpW0hKrkIBVJibWtK4sz12VFuydzC0t6VPaAtpGCMl
 6NwR/MeP4OdSEtB+/Qvdpp2UaI703Lk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-X05eMDwIPniIGH4XwKwm2g-1; Tue,
 22 Apr 2025 09:59:49 -0400
X-MC-Unique: X05eMDwIPniIGH4XwKwm2g-1
X-Mimecast-MFC-AGG-ID: X05eMDwIPniIGH4XwKwm2g_1745330386
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C709E19560A5; Tue, 22 Apr 2025 13:59:43 +0000 (UTC)
Received: from localhost (unknown [10.2.16.110])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39459180010A; Tue, 22 Apr 2025 13:59:39 +0000 (UTC)
Date: Tue, 22 Apr 2025 09:59:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH v2 17/20] util: Add coroutine backend for emscripten
Message-ID: <20250422135938.GB301197@fedora>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
 <82afa4d287a16f89fa59f08cba14fb06e017ea83.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DltiIdaNA3nWqmR9"
Content-Disposition: inline
In-Reply-To: <82afa4d287a16f89fa59f08cba14fb06e017ea83.1745295397.git.ktokunaga.mail@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--DltiIdaNA3nWqmR9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 02:27:21PM +0900, Kohei Tokunaga wrote:
> Emscripten does not support couroutine methods currently used by QEMU but
> provides a coroutine implementation called "fiber". This commit introduce=
s a
> coroutine backend using fiber. Note that fiber does not support submitting
> coroutines to other threads.
>=20
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>  MAINTAINERS           |   1 +
>  util/coroutine-wasm.c | 127 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 128 insertions(+)
>  create mode 100644 util/coroutine-wasm.c
>=20
> V2:
> - Split the MAINTAINERS file change that adds coroutine-wasm.c from the
>   previous 19th patch into this commit.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--DltiIdaNA3nWqmR9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgHoMoACgkQnKSrs4Gr
c8gBeQgAkKJs5uspGEuKmK1DsHRilGp+8iPwo09eOxS9265IAygkr6XEk0f6JQbQ
ATJgJFl7qVMhPDalRx+jsRrIbfrvQ/RzTbqszy1pCLXuBOLkWYEgXXClGHtBTZtn
dAKpesc0EaoV/3r70TgNHVDsRGZeeALaJ8oksWtC3dj3lX2CRJUdf6wDFxL8R39x
+at+I4lXSmXKVS5lSDYl0D/+RjWncJzwv9X8WK1gCXGWzSdjm6ZvC3d5rqWV2jfL
m0PMcwq99AX3ohiE1f6F8Cxn3roPqeM5vmvF7586JAe7/X4U0dvtS0B6hhyfWB8C
SGDpKDSpoos4LUj2MQ0otrEBfH+EgA==
=1x7V
-----END PGP SIGNATURE-----

--DltiIdaNA3nWqmR9--


