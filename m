Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23D5C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ECX-0008Ds-VV; Tue, 22 Apr 2025 10:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7ECR-00081W-Bb
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7ECN-0006hR-7y
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745330525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7oUOK46QlawTR7PzRa1h2tAuDsOpWCOm7vEMBMH4LoM=;
 b=ClZ2E7W34Ft4Ry6bycfxH7nPNbsmuDk3fnzH5P0Y53tHfjbLxvJuli9zFoMK20cbkCv506
 6FQhksZsA0TLYLYjGwDznYP3e1+cok23X0ogZMwGsgRDarz6rRe0iw7Z3xqCkCLlkOddFh
 ZGmGA3nYx5jLYMhb/GmirCnK+AEzYd8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-lKdadMvSOC--cVrGngmKBQ-1; Tue,
 22 Apr 2025 10:02:02 -0400
X-MC-Unique: lKdadMvSOC--cVrGngmKBQ-1
X-Mimecast-MFC-AGG-ID: lKdadMvSOC--cVrGngmKBQ_1745330519
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F189519560BC; Tue, 22 Apr 2025 14:01:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.110])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C639195608D; Tue, 22 Apr 2025 14:01:56 +0000 (UTC)
Date: Tue, 22 Apr 2025 10:01:55 -0400
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
Subject: Re: [PATCH v2 13/20] block: Fix type confict of the copy_file_range
 stub
Message-ID: <20250422140155.GC301197@fedora>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
 <ce34a721a5283fce854f417baf7b1c8f5c48c028.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BVTxInpCVWgS3hFa"
Content-Disposition: inline
In-Reply-To: <ce34a721a5283fce854f417baf7b1c8f5c48c028.1745295397.git.ktokunaga.mail@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--BVTxInpCVWgS3hFa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 02:27:17PM +0900, Kohei Tokunaga wrote:
> Emscripten doesn't provide copy_file_range implementation but it declares
> this function in its headers. Meson correctly detects the missing
> implementation and unsets HAVE_COPY_FILE_RANGE. However, the stub defined=
 in
> file-posix.c causes a type conflict with the declaration from Emscripten
> during compilation.
>=20
> To fix this error, this commit updates the stub implementation in
> file-posix.c to exactly match the declaration in Emscripten's headers. The
> manpage also aligns with this signature.
>=20
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>  block/file-posix.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> V2:
> - Removed the Emscripten-specific stub of copy_file_range in
>   stubs/emscripten.c. Instead, updated the type of the existing
>   copy_file_range stub in block/file-posix.c to match the declaration in =
the
>   Emscripten headers and avoid a compilation error.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--BVTxInpCVWgS3hFa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgHoVMACgkQnKSrs4Gr
c8jZQQf+OZEX0gEXf1Wt2j51SCBn+i89pfpm/Mg+bo3EwrgfC7ebEI9B2KihRbE2
0UgrgQoe5WLwKiDt4aR0wuMlmTrng+8t5AT9QCOSAxclJ83z8WLVcMl/g/48IPWI
hEnsoDS9EgpPCjoIb+lmFnj6zyfUpLYS3arQwj7sjhAbrrGNwILwtrIe8bqqqhZR
8w1UGF8qR+NV2U57qxexRH0Mvpxp7QhBBCZ1Z7BpCuVUjKb/4xGSqAFktNHY0EHY
CbnbRrFQ4RrUjj9hiZQpbNkkeraBrAbYdZpPk/hp354VXj3s3DamrmqDSNI0f66y
lvyTOwAISkjbSu19Len0U+JNeqlZYQ==
=3eI6
-----END PGP SIGNATURE-----

--BVTxInpCVWgS3hFa--


