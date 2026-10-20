Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD58606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ei86YJtG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3w7-0003TW-GB; Tue, 20 Oct 2026 03:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJ3w6-0003TJ-Ai
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 03:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJ3w4-0002OF-FX
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 03:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792480019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMBy3ZqnwnKsoTao9/63VXmjBeAydSJL58wI84nppGM=;
 b=ei86YJtGMOskFLSLeMOQTDou8pJ+Gdh9VZdFnPuvuz49qrHBElS1SIOdjN5HP1ZYO/Xycj
 agxuye/g1V0JDc5/61AMdPZEyUrrHXkqcGu4G556PYXU9XrstUiOfIot0KYWJNnX3JuuRR
 nhJDiYNCLN3y037CDWupStNRGVuGgt4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-99uPHFX3NJysVL3laUaTBg-1; Tue,
 20 Oct 2026 07:06:57 +0000
X-MC-Unique: 99uPHFX3NJysVL3laUaTBg-1
X-Mimecast-MFC-AGG-ID: 99uPHFX3NJysVL3laUaTBg_1792480017
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF5D818005B8; Tue, 20 Oct 2026 07:06:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DF8330000E7; Tue, 20 Oct 2026 07:06:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BB1EC21E6A04; Tue, 20 Oct 2026 09:06:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] qtest: fail fast when QEMU terminates early
In-Reply-To: <20261005120434.413891-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 5 Oct 2026 13:04:34
 +0100")
References: <20261005120434.413891-1-berrange@redhat.com>
Date: Tue, 20 Oct 2026 09:06:53 +0200
Message-ID: <87fqy0rgtu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

> If QEMU fails to start, or crashes early, before libqtest has opened
> its qtest and QMP sockets, we'll get into an 'accept()' call with a
> 50 second timeout waiting for a connection that the zombie QEMU
> process will never initiate.
>
> Use a short 250ms timeout with accept(), but loop 200 times instead,
> checking whether the process is alive on each iteration. With this
> qtest detects dead QEMU immediately.
>
> socket_accept is renamed to qtest_socket_accept to reflect that it
> now requires QTestState.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/qtest/libqtest.c | 45 ++++++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 17 deletions(-)
>
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 05d88476154..9e7a2d43a18 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -44,13 +44,14 @@
>=20=20
>  #define MAX_IRQ 256
>=20=20
> +#define ACCEPT_TIMEOUT_MS 250
> +#define ACCEPT_RETRIES (4 * 50)
> +
>  #ifndef _WIN32
> -# define SOCKET_TIMEOUT 50
>  # define CMD_EXEC   "exec "
>  # define DEV_STDERR "/dev/fd/2"
>  # define DEV_NULL   "/dev/null"
>  #else
> -# define SOCKET_TIMEOUT 50000
>  # define CMD_EXEC   ""
>  # define DEV_STDERR "2"
>  # define DEV_NULL   "nul"
> @@ -116,20 +117,17 @@ static int init_socket(const char *socket_path)
>      return sock;
>  }
>=20=20
> -static int socket_accept(int sock)
> +static int qtest_socket_accept(QTestState *s, int sock)
>  {
>      struct sockaddr_un addr;
>      socklen_t addrlen;
>      int ret;
> -    /*
> -     * timeout unit of blocking receive calls is different among platfor=
ms.
> -     * It's in seconds on non-Windows platforms but milliseconds on Wind=
ows.
> -     */
> +    size_t i;
>  #ifndef _WIN32
> -    struct timeval timeout =3D { .tv_sec =3D SOCKET_TIMEOUT,
> -                               .tv_usec =3D 0 };
> +    struct timeval timeout =3D { .tv_sec =3D 0,
> +                               .tv_usec =3D ACCEPT_TIMEOUT_MS * 1000ul };
>  #else
> -    DWORD timeout =3D SOCKET_TIMEOUT;
> +    DWORD timeout =3D ACCEPT_TIMEOUT_MS;
>  #endif
>=20=20
>      if (setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO,
> @@ -140,13 +138,26 @@ static int socket_accept(int sock)
>          return -1;
>      }
>=20=20
> -    do {
> +    for (i =3D 0; i < ACCEPT_RETRIES ; i++) {
> +        if (!qtest_probe_child(s)) {
> +            fprintf(stderr,
> +                    "child process unexpectedly exited, skipping socket =
accept\n");
> +            goto cleanup;

I'm afraid this leads to ...

> +        }
> +
>          addrlen =3D sizeof(addr);
>          ret =3D accept(sock, (struct sockaddr *)&addr, &addrlen);
> -    } while (ret =3D=3D -1 && errno =3D=3D EINTR);
> -    if (ret =3D=3D -1) {
> -        fprintf(stderr, "%s failed: %s\n", __func__, strerror(errno));
> +        if (ret =3D=3D -1) {
> +            if (errno =3D=3D EINTR || errno =3D=3D EAGAIN) {
> +                continue;
> +            } else {
> +                fprintf(stderr, "%s failed: %s\n", __func__, strerror(er=
rno));
> +            }
> +        }

...    CID 1688281:         Uninitialized variables  (UNINIT)
       Using uninitialized value "ret".

> +        return ret;
>      }
> +
> + cleanup:
>      close(sock);
>=20=20
>      return ret;
> @@ -549,9 +560,9 @@ void qtest_connect(QTestState *s)
>      g_autofree gchar *qmp_socket_path =3D qtest_socket_path("qmp");
>=20=20
>      g_assert(s->sock >=3D 0 && s->qmpsock >=3D 0);
> -    s->fd =3D socket_accept(s->sock);
> +    s->fd =3D qtest_socket_accept(s, s->sock);
>      if (s->fd >=3D 0) {
> -        s->qmp_fd =3D socket_accept(s->qmpsock);
> +        s->qmp_fd =3D qtest_socket_accept(s, s->qmpsock);
>      }
>      unlink(socket_path);
>      unlink(qmp_socket_path);
> @@ -663,7 +674,7 @@ QTestState *qtest_init_with_serial(const char *extra_=
args, int *sock_fd)
>      qts =3D qtest_initf("-chardev socket,id=3Ds0,path=3D%s -serial chard=
ev:s0 %s",
>                        sock_path, extra_args);
>=20=20
> -    *sock_fd =3D socket_accept(sock_fd_init);
> +    *sock_fd =3D qtest_socket_accept(qts, sock_fd_init);
>=20=20
>      unlink(sock_path);
>      g_free(sock_path);


