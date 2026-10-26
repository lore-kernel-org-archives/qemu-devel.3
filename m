Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B14B606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PxK64yqW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLl4-0000Sm-88; Mon, 26 Oct 2026 10:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLLky-0000S7-1Y
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 10:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLLkw-0004wZ-7s
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 10:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793025176;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lFgtAdEzpDXY9TbSXCOM+3EHKc2abrC6riAv1d5BnjE=;
 b=PxK64yqWBD3e4y3a3QXzi4aKBtj28hlgmUYX502Nj4qhC1D122L+T6T6tqKputHos373jy
 BgQ9T6aCgSZVmx0qQCuPqrCQEExqC3Y/0rEMos/r+3yzV/8/h5w9Yqapp1NQOcQf+GgqNr
 4T+SFoFi4rOoDk4Rh3Dqyr+EVPmOLKU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-Dpnqsa_gM2OkjAnnHc-w7g-1; Mon,
 26 Oct 2026 10:32:55 -0400
X-MC-Unique: Dpnqsa_gM2OkjAnnHc-w7g-1
X-Mimecast-MFC-AGG-ID: Dpnqsa_gM2OkjAnnHc-w7g_1793025174
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38D3E195395E; Mon, 26 Oct 2026 14:32:54 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C121D41B; Mon, 26 Oct 2026 14:32:52 +0000 (UTC)
Date: Mon, 26 Oct 2026 14:32:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] qtest: ensure socket_accept() return value is initialized
Message-ID: <at9kkSt9ehSVrK6w@redhat.com>
References: <20261026124043.770095-1-berrange@redhat.com>
 <87ik2od0tj.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ik2od0tj.fsf@pond.sub.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 02:54:32PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > If the very first iteration of the loop breaks early due to the
> > dead QEMU process, 'ret' is never initialized. Ensure it is set
> > to -1 to represent an invalid FD number.
> >
> > CID 1688281
> > Reported-by: Markus Armbruster <armbru@redhat.com>
> > Fixes: c12ad5378739 (qtest: fail fast when QEMU terminates early)
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  tests/qtest/libqtest.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> > index 9e7a2d43a18..899727d6d35 100644
> > --- a/tests/qtest/libqtest.c
> > +++ b/tests/qtest/libqtest.c
> > @@ -121,7 +121,7 @@ static int qtest_socket_accept(QTestState *s, int sock)
> >  {
> >      struct sockaddr_un addr;
> >      socklen_t addrlen;
> > -    int ret;
> > +    int ret = -1;
> >      size_t i;
> >  #ifndef _WIN32
> >      struct timeval timeout = { .tv_sec = 0,
> 
> Hmm, we do the same thing in several different ways:
> 
>    static int qtest_socket_accept(QTestState *s, int sock)
>    {
>        struct sockaddr_un addr;
>        socklen_t addrlen;
>        int ret;
>        size_t i;
>    #ifndef _WIN32
>        struct timeval timeout = { .tv_sec = 0,
>                                   .tv_usec = ACCEPT_TIMEOUT_MS * 1000ul };
>    #else
>        DWORD timeout = ACCEPT_TIMEOUT_MS;
>    #endif
> 
>        if (setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO,
>                       (void *)&timeout, sizeof(timeout))) {
>            fprintf(stderr, "%s failed to set SO_RCVTIMEO: %s\n",
>                    __func__, strerror(errno));
>            close(sock);
>            return -1;
> 
> (A) Free resources and return failure.
> 
>        }
> 
>        for (i = 0; i < ACCEPT_RETRIES ; i++) {
>            if (!qtest_probe_child(s)) {
>                fprintf(stderr,
>                        "child process unexpectedly exited, skipping socket accept\n");
>                goto cleanup;
> 
> (B) Jump to exit, where we free resources and return @ret.
> 
>            }
> 
>            addrlen = sizeof(addr);
>            ret = accept(sock, (struct sockaddr *)&addr, &addrlen);
>            if (ret == -1) {
>                if (errno == EINTR || errno == EAGAIN) {
>                    continue;
>                } else {
>                    fprintf(stderr, "%s failed: %s\n", __func__, strerror(errno));
>                }
>            }
> 
> (C) Return @ret.
> 
> Hmm, should we close(sock) on failure here?

Opps, yes, you are right - we should in fact fall through to
the cleanup: label, as the intention is 'sock' is closed in
all, as the caller expects socket_accept() to close the sock
in all cases. That's a second bug in my original patch.

This is pretty unpleasant semantics though - the caller owns
the socket and should own closing it.

>            return ret;
>        }
> 
>     cleanup:
>        close(sock);
> 
>        return ret;
>    }
> 
> All three ways can work fine.  But using all three next to each other I
> find somewhat grating.  Matter of taste.  I'm not demanding you change
> this.
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


