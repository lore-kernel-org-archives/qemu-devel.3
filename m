Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2959BC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 08:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8yog-0007GH-4R; Mon, 20 May 2024 04:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s8ynW-000781-Qz
 for qemu-devel@nongnu.org; Mon, 20 May 2024 04:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s8ynP-0005LA-So
 for qemu-devel@nongnu.org; Mon, 20 May 2024 04:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716195302;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=i4wSriD7WOCYJeEN6ENDnFoP3uXDfNH7EEjMNnjA0yc=;
 b=dq1rKuNQtl6+eVSYVFVfd/30mRrmHNYwYpl4ZrPrZ0qnCBE8X6z8HVxgOEUtQyGKCzHxvL
 ktOwDVMuvjWlT6tiMl4I+7X05aY/u/sl5XfPMp/qARX+1CvDggp15O84ETTuO5EIagorzS
 N48Uw/0zgY2OP53/UK8Rm4yJs0L0zqQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-MfwonOeqP4WApJk0qwFoMA-1; Mon, 20 May 2024 04:54:58 -0400
X-MC-Unique: MfwonOeqP4WApJk0qwFoMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38345185A783;
 Mon, 20 May 2024 08:54:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4429B5618;
 Mon, 20 May 2024 08:54:55 +0000 (UTC)
Date: Mon, 20 May 2024 09:54:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com,
 qemu-stable@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 2/2] iotests: test NBD+TLS+iothread
Message-ID: <ZksP3IwzdqzVVg1o@redhat.com>
References: <20240518025246.791593-4-eblake@redhat.com>
 <20240518025246.791593-6-eblake@redhat.com>
 <iv4tyqsi5bwojgh5hcpr4jfmlw2xvatpgqroxe2dvp27qzbhea@bitj4i5zb5po>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <iv4tyqsi5bwojgh5hcpr4jfmlw2xvatpgqroxe2dvp27qzbhea@bitj4i5zb5po>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 17, 2024 at 10:08:08PM -0500, Eric Blake wrote:
> Adding a bit of self-review (in case you want to amend this before
> pushing, instead of waiting for me to get back online),
> 
> On Fri, May 17, 2024 at 09:50:15PM GMT, Eric Blake wrote:
> > Prevent regressions when using NBD with TLS in the presence of
> > iothreads, adding coverage the fix to qio channels made in the
> > previous patch.
> > 
> > CC: qemu-stable@nongnu.org
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >  tests/qemu-iotests/tests/nbd-tls-iothread     | 170 ++++++++++++++++++
> >  tests/qemu-iotests/tests/nbd-tls-iothread.out |  54 ++++++
> >  2 files changed, 224 insertions(+)
> >  create mode 100755 tests/qemu-iotests/tests/nbd-tls-iothread
> >  create mode 100644 tests/qemu-iotests/tests/nbd-tls-iothread.out

> > +
> > +# pick_unused_port
> > +# Copied from nbdkit/tests/functions.sh.in with compatible 2-clause BSD license
> 
> I'm not sure if I have to include the license text verbatim in this
> file, and/or have this function moved to a helper utility file.  The
> original source file that I borrowed pick_unused_port from has:
> 
> # Copyright Red Hat

I checked most of the relevant history, and this Copyright statement
does indeed appear correct - the code was all written by Richard.

Thus, you could invoke Red Hat's right to re-license and just declare
this copy to be under QEMU's normal GPL license, avoiding the question
of copying the license text.


> > +#
> > +# Picks and returns an "unused" port, setting the global variable
> > +# $port.
> > +#
> > +# This is inherently racy, but we need it because qemu does not currently
> > +# permit NBD+TLS over a Unix domain socket
> > +pick_unused_port ()
> > +{
> > +    if ! (ss --version) >/dev/null 2>&1; then
> > +        _notrun "ss utility required, skipped this test"
> > +    fi
> > +
> > +    # Start at a random port to make it less likely that two parallel
> > +    # tests will conflict.
> > +    port=$(( 50000 + (RANDOM%15000) ))
> > +    while ss -ltn | grep -sqE ":$port\b"; do
> > +        ((port++))
> > +        if [ $port -eq 65000 ]; then port=50000; fi
> 
> Also, common.nbd only probes:
>     for ((port = 10809; port <= 10909; port++))
> and nbdkit's choice of starting with a random offset is interesting.

Yes, a random offset is a nice idea, massively reducing risk of
clashes through (un)lucky concurrent execution.



> > +echo
> > +echo === Cleaning up ===
> > +echo
> > +
> > +_send_qemu_cmd $h1 '{"execute":"quit"}' ''
> > +_send_qemu_cmd $h2 '{"execute":"quit"}' ''
> 
> Since the bug was exposed by this point, I didn't bother to do a clean
> shutdown of the mirror job or NBD export.  As is, testing that we shut
> down cleanly despite abandoning a job is probably not a bad idea.

Yeah, perhaps worthwhile, if you can get something that works reliably.
A reliable partial test is better than an unreliable full test, as we'll
just end up  killing the latter.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


