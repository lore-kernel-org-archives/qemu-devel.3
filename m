Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BD0606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QpkcYjYp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLfnW-0001a4-5B; Tue, 27 Oct 2026 07:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLfnV-0001XL-0M
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLfnT-0007Rg-Ez
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793102214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c66nqhdHMZ34RV4o6XfzKjcy04cAhnn+iOiRnlHUXOI=;
 b=QpkcYjYpO0rvVUaQgnX1M0kVdMubhn/qgWC1SffAK1zNXWG8KyofX1DPcgphDpqrbcvNg2
 BQyl4qijyu3sdO0STi65if7XWUu8cu1rl4+2uD+aG3QktiakDvMeUiEywGrhd++0tx7W1b
 gO8kqY22veMBEhxvL8wiodr5tPGgw48=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-Bmc7nNpeOICUNvFhfCSFOQ-1; Tue,
 27 Oct 2026 07:56:51 -0400
X-MC-Unique: Bmc7nNpeOICUNvFhfCSFOQ-1
X-Mimecast-MFC-AGG-ID: Bmc7nNpeOICUNvFhfCSFOQ_1793102210
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0888E1955D57; Tue, 27 Oct 2026 11:56:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBA137D6; Tue, 27 Oct 2026 11:56:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6F08A21E6A04; Tue, 27 Oct 2026 12:56:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/2] qtest: don't close listener socket in
 qtest_socket_accept
In-Reply-To: <20261026163849.1045894-3-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 26 Oct 2026 16:38:49
 +0000")
References: <20261026163849.1045894-1-berrange@redhat.com>
 <20261026163849.1045894-3-berrange@redhat.com>
Date: Tue, 27 Oct 2026 12:56:47 +0100
Message-ID: <87wlr373wg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The listener FD passed into qtest_socket_accept should be
> considered owned by the caller, and thus is is inappropriate
> and unusual to close it in the method.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/qtest/libqtest.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 50487739ef9..0f701679745 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -134,7 +134,6 @@ static int qtest_socket_accept(QTestState *s, int soc=
k)
>                     (void *)&timeout, sizeof(timeout))) {
>          fprintf(stderr, "%s failed to set SO_RCVTIMEO: %s\n",
>                  __func__, strerror(errno));
> -        close(sock);
>          return -1;
>      }
>=20=20
> @@ -142,7 +141,7 @@ static int qtest_socket_accept(QTestState *s, int soc=
k)
>          if (!qtest_probe_child(s)) {
>              fprintf(stderr,
>                      "child process unexpectedly exited, skipping socket =
accept\n");
> -            goto cleanup;
> +            return -1;

This removes the need for initializing @ret.  Observation, not a demand.

>          }
>=20=20
>          addrlen =3D sizeof(addr);
> @@ -156,9 +155,6 @@ static int qtest_socket_accept(QTestState *s, int soc=
k)
>          fprintf(stderr, "%s failed: %s\n", __func__, strerror(errno));
>      }
>=20=20
> - cleanup:
> -    close(sock);
> -
>      return ret;
>  }
>=20=20
> @@ -566,6 +562,8 @@ void qtest_connect(QTestState *s)
>      unlink(socket_path);
>      unlink(qmp_socket_path);
>      g_assert(s->fd >=3D 0 && s->qmp_fd >=3D 0);
> +    close(s->sock);
> +    close(s->qmpsock);
>      s->sock =3D s->qmpsock =3D -1;
>      /* ask endianness of the target */
>      s->big_endian =3D qtest_query_target_endianness(s);
> @@ -675,6 +673,7 @@ QTestState *qtest_init_with_serial(const char *extra_=
args, int *sock_fd)
>=20=20
>      *sock_fd =3D qtest_socket_accept(qts, sock_fd_init);
>=20=20
> +    close(sock_fd_init);
>      unlink(sock_path);
>      g_free(sock_path);
>      rmdir(sock_dir);

Reviewed-by: Markus Armbruster <armbru@redhat.com>


