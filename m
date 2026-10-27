Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1FF606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NiufvKKO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLfnD-0001S9-Ce; Tue, 27 Oct 2026 07:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLfnB-0001Rm-Ts
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLfnA-0007RD-62
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793102195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFowQfm9ennC4Xh/OB/3ifrdWd6dhaG5zD0lkkILLiw=;
 b=NiufvKKOLn1tMi8Ehp54UQgulXREPhQeorZqe96UClD3oBeqeROitzrmXaNESHAVPUQVwu
 LGDKUpiogLc2GPOas/s/VWW3rNZwm5zvsWo3vyaMxIyiWjWS1aD1QFF+EYFuxdhC0vz9cA
 k/An0mtB1jIz96mMs8QlUNZyjjIVqv4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-Wq4cog4aOPuB_yNFP6eB8Q-1; Tue,
 27 Oct 2026 07:56:33 -0400
X-MC-Unique: Wq4cog4aOPuB_yNFP6eB8Q-1
X-Mimecast-MFC-AGG-ID: Wq4cog4aOPuB_yNFP6eB8Q_1793102192
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97A66180132C; Tue, 27 Oct 2026 11:56:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A26F7D5; Tue, 27 Oct 2026 11:56:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D1D6121E6A04; Tue, 27 Oct 2026 12:56:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/2] qtest: multiple fixes to socket_accept()
In-Reply-To: <20261026163849.1045894-2-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 26 Oct 2026 16:38:48
 +0000")
References: <20261026163849.1045894-1-berrange@redhat.com>
 <20261026163849.1045894-2-berrange@redhat.com>
Date: Tue, 27 Oct 2026 12:56:29 +0100
Message-ID: <87y0bj73wy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> If the very first iteration of the loop breaks early due to the
> dead QEMU process, 'ret' is never initialized. Furthermore the
> listener socket is not closed on success and there is no error
> message printed if timing out after all iterations are complete.
> These problems were introduced by the recent refactoring to check
> QEMU is alive.
>
> CID 1688281
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Fixes: c12ad5378739 ("qtest: fail fast when QEMU terminates early")
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/qtest/libqtest.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 9e7a2d43a18..50487739ef9 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -121,7 +121,7 @@ static int qtest_socket_accept(QTestState *s, int soc=
k)
>  {
>      struct sockaddr_un addr;
>      socklen_t addrlen;
> -    int ret;
> +    int ret =3D -1;

You need this to make [*] work.

>      size_t i;
>  #ifndef _WIN32
>      struct timeval timeout =3D { .tv_sec =3D 0,
> @@ -147,14 +147,13 @@ static int qtest_socket_accept(QTestState *s, int s=
ock)
       for (i =3D 0; i < ACCEPT_RETRIES ; i++) {
           if (!qtest_probe_child(s)) {
               fprintf(stderr,
                       "child process unexpectedly exited, skipping socket =
accept\n");

[*] @ret comes from the initialization above in the first iteration
only.  In later iterations, it comes from assignment [**] below.

               goto cleanup;
           }
>=20=20
>          addrlen =3D sizeof(addr);
>          ret =3D accept(sock, (struct sockaddr *)&addr, &addrlen);

[**]

> -        if (ret =3D=3D -1) {
> -            if (errno =3D=3D EINTR || errno =3D=3D EAGAIN) {
> -                continue;
> -            } else {
> -                fprintf(stderr, "%s failed: %s\n", __func__, strerror(er=
rno));
> -            }
> +        if (ret =3D=3D -1 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN)=
) {
> +            continue;
>          }
> -        return ret;
> +        break;
> +    }
> +    if (ret =3D=3D -1) {

@ret comes from [**], because the loop runs at least once
(ACCEPT_RETRIES is positive).

> +        fprintf(stderr, "%s failed: %s\n", __func__, strerror(errno));
>      }
>=20=20
>   cleanup:

Reviewed-by: Markus Armbruster <armbru@redhat.com>


