Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DE6CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 17:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDmIX-0006Gf-JA; Mon, 05 Oct 2026 13:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xDmIG-0006Fh-K6
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 13:16:13 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xDmID-0004w1-KE
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 13:16:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 84E4121ED0;
 Mon,  5 Oct 2026 17:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791220554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6RNWgaXHc1SjzXNxb3yHBcoCQXgUc9FA6C+qgxbSYsc=;
 b=OOPggiv/Wvt1wndaPj662o3/yCm6TEHgvmCdrFvt3TmRCwHoH7Lq41pwBP1WkZkZCVRve1
 kCBx+GvDr7QCFpt6r26V0gAS8q3pLPviA99B31nKkHabUEz//1SP/ZePsT3pEJd5W2OIfY
 nIFOT8trTY1Vv5z/tc5cJUe6xoxVxco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791220554;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6RNWgaXHc1SjzXNxb3yHBcoCQXgUc9FA6C+qgxbSYsc=;
 b=zX9Snw7L+s5TuW2nTZwny3iOUkfEEOIvh8OxujqziWQbEnM3mIjuGtRD1emoc27oKAaxOh
 452WoU92PuCYoZBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iymPrw6b;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pFz8kpzi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791220550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6RNWgaXHc1SjzXNxb3yHBcoCQXgUc9FA6C+qgxbSYsc=;
 b=iymPrw6bfW8WpOCJbQt1263MNi/QFKfN/ztImdI/ulVtmHbokPEMa2pYA2n1X771LafKCO
 bT/enQWV6m8iVAMQM1bP/k+SQMGabdV9NSh5zRLGvW4ic9+eYRS6Tcq80wHWhhnYntAuUv
 xiBtck7Qs5G6pzI8sLW5v27qxr64K3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791220550;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6RNWgaXHc1SjzXNxb3yHBcoCQXgUc9FA6C+qgxbSYsc=;
 b=pFz8kpziLdw4ylafbbE2n4c6qXyWzuWULHvkkJyffc6eiZx/CxM51RRVH6EGDa53nPqFmI
 tk3erMMSL/xuPrAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 029C113688;
 Mon,  5 Oct 2026 17:15:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KaxsJkXbw2onaQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Oct 2026 17:15:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] qtest: fail fast when QEMU terminates early
In-Reply-To: <20261005120434.413891-1-berrange@redhat.com>
References: <20261005120434.413891-1-berrange@redhat.com>
Date: Mon, 05 Oct 2026 14:15:47 -0300
Message-ID: <8733uk83wc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 84E4121ED0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>

