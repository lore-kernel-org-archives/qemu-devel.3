Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51086606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W3PcCXG7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLL9v-0004sg-5l; Mon, 26 Oct 2026 09:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLL9s-0004sO-Sv
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLL9r-00089p-5D
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793022877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lcyni0OXTYhTLgjsj3NAVvznN8SdJ98aPhuSlcP9Guo=;
 b=W3PcCXG7r7gX6FOGFGeRtjNrEgkZHp2Qe8FJECgv6VaAkMm7HUPXLmZryqIz5MKGcoSUEZ
 0lWIF/Lp4VwU2CgZoDKOw4BDL9quLVXggUaihyEaPYIQO3EJk04xAIAlNAj4JvV9/bU1XV
 afdQ1DKgSgAQAJpc4rp3oW3NQM1kwdM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-AuNYaujpOR2EaHm_Mu49ZQ-1; Mon,
 26 Oct 2026 09:54:36 -0400
X-MC-Unique: AuNYaujpOR2EaHm_Mu49ZQ-1
X-Mimecast-MFC-AGG-ID: AuNYaujpOR2EaHm_Mu49ZQ_1793022875
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D7E5195D002; Mon, 26 Oct 2026 13:54:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AF2D300019F; Mon, 26 Oct 2026 13:54:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8B46521E6A04; Mon, 26 Oct 2026 14:54:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] qtest: ensure socket_accept() return value is initialized
In-Reply-To: <20261026124043.770095-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 26 Oct 2026 12:40:43
 +0000")
References: <20261026124043.770095-1-berrange@redhat.com>
Date: Mon, 26 Oct 2026 14:54:32 +0100
Message-ID: <87ik2od0tj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

> If the very first iteration of the loop breaks early due to the
> dead QEMU process, 'ret' is never initialized. Ensure it is set
> to -1 to represent an invalid FD number.
>
> CID 1688281
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Fixes: c12ad5378739 (qtest: fail fast when QEMU terminates early)
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/qtest/libqtest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 9e7a2d43a18..899727d6d35 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -121,7 +121,7 @@ static int qtest_socket_accept(QTestState *s, int soc=
k)
>  {
>      struct sockaddr_un addr;
>      socklen_t addrlen;
> -    int ret;
> +    int ret =3D -1;
>      size_t i;
>  #ifndef _WIN32
>      struct timeval timeout =3D { .tv_sec =3D 0,

Hmm, we do the same thing in several different ways:

   static int qtest_socket_accept(QTestState *s, int sock)
   {
       struct sockaddr_un addr;
       socklen_t addrlen;
       int ret;
       size_t i;
   #ifndef _WIN32
       struct timeval timeout =3D { .tv_sec =3D 0,
                                  .tv_usec =3D ACCEPT_TIMEOUT_MS * 1000ul };
   #else
       DWORD timeout =3D ACCEPT_TIMEOUT_MS;
   #endif

       if (setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO,
                      (void *)&timeout, sizeof(timeout))) {
           fprintf(stderr, "%s failed to set SO_RCVTIMEO: %s\n",
                   __func__, strerror(errno));
           close(sock);
           return -1;

(A) Free resources and return failure.

       }

       for (i =3D 0; i < ACCEPT_RETRIES ; i++) {
           if (!qtest_probe_child(s)) {
               fprintf(stderr,
                       "child process unexpectedly exited, skipping socket =
accept\n");
               goto cleanup;

(B) Jump to exit, where we free resources and return @ret.

           }

           addrlen =3D sizeof(addr);
           ret =3D accept(sock, (struct sockaddr *)&addr, &addrlen);
           if (ret =3D=3D -1) {
               if (errno =3D=3D EINTR || errno =3D=3D EAGAIN) {
                   continue;
               } else {
                   fprintf(stderr, "%s failed: %s\n", __func__, strerror(er=
rno));
               }
           }

(C) Return @ret.

Hmm, should we close(sock) on failure here?

           return ret;
       }

    cleanup:
       close(sock);

       return ret;
   }

All three ways can work fine.  But using all three next to each other I
find somewhat grating.  Matter of taste.  I'm not demanding you change
this.


