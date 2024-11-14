Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C627FD6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 17:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBdyC-0008Hb-Ba; Thu, 14 Nov 2024 12:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tBdy6-0008Db-Hi
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:49:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tBdy3-0007m3-RF
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731606558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cuOl5uepREylhJ3Ri/taGB8n5FsPWiWiZ3gPnUNTV24=;
 b=Glm1eqtRkMrFI/Q36jns6yxaCg0qomhoRrvrKHc4Q2ncPT6zoijC5+UsHiLSC4RMch/XK4
 Wom9BnKg2IAXrhKy4QSmPaidZQwWswjMY01hDhVGT69Yu9xP7FFQ+Omos/y4RKviBwWAKz
 t4Pwl+CmSJNDQ3Cf66zhJiW6RYA70MM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-usgp107PMNuTjhKXhsEXZA-1; Thu,
 14 Nov 2024 12:49:14 -0500
X-MC-Unique: usgp107PMNuTjhKXhsEXZA-1
X-Mimecast-MFC-AGG-ID: usgp107PMNuTjhKXhsEXZA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BF081955BCF; Thu, 14 Nov 2024 17:49:12 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.6])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A0A11956089; Thu, 14 Nov 2024 17:49:07 +0000 (UTC)
Date: Thu, 14 Nov 2024 18:49:03 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Jakub Jelen <jjelen@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, hreitz@redhat.com, mpitt@redhat.com
Subject: Re: [PATCH ssh] ssh: Do not switch session to non-blocking mode
Message-ID: <ZzY4D7t5asZZWgwN@redhat.com>
References: <20241113115000.2494785-1-rjones@redhat.com>
 <0371e3cc-1ed5-4685-835a-5378dd4dfbb7@tls.msk.ru>
 <20241113130021.GA20898@redhat.com> <ZzYVgRo_l2ZHQztg@redhat.com>
 <CAHrFiA98_icSL5WqTFN1gpWN+=70d58rH=V3iJWDf4zYApSMQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHrFiA98_icSL5WqTFN1gpWN+=70d58rH=V3iJWDf4zYApSMQA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 14.11.2024 um 17:49 hat Jakub Jelen geschrieben:
> Hello,
> comments inline below.
> 
> On Thu, Nov 14, 2024 at 4:21 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > [...]
> >
> > > I'll just note that I'm only forwarding on the patch from Jakub.
> > > I didn't write it.
> > >
> > > I did lightly test it, and it seems to work.  However it seems also
> > > likely that it is causing qemu to block internally.  Probably not
> > > noticable for light use, but not something that we'd want for serious
> > > use.  However if libssh doesn't support non-blocking SFTP there's not
> > > much we can do about that in qemu.
> >
> > ...just making it blocking is not acceptable. It will potentially make
> > the guest hang while we're waiting for sftp responses.
> 
> This is the limitation of the SFTP API we have (and a reason why we
> have a new API below, but only in new 0.11.0 release so not solution
> for older systems that wont get new libssh).
> 
> > I see that there is an sftp_aio_*() API, but it looks weird. Instead of
> > allowing you to just poll the next request that is ready, you have to
> > call a (blocking) wait on a specific request.
> 
> Its more "streaming" API allowing the request and response overlap in time
> allowing better throughput on networks with large latency.
> 
> To support fully non blocking API in SFTP, there is still way to go, but this
> api should be more ready for that than the old one.

Ok, so something to possibly look into later, but not for the time
being.

> > co_yield(), which is currently used when sftp_read() returns SSH_AGAIN,
> > makes sure that we poll the socket fd, so we can know that _something_
> > new has arrived. However it's unclear to me how to know _which_ request
> > received a reply and can be completed now. It seems you have to call
> > sftp_aio_wait_*() in non-blocking mode on all requests to do that, which
> > probably is affected by the libssh bug, too.
> 
> Are you sure that with the old libssh versions you were getting SSH_AGAIN
> in non-blocking mode? Michael in the following comment found the
> change where the issue started to demonstrate:
> 
> https://gitlab.com/libssh/libssh-mirror/-/issues/280#note_2204139954
> https://gitlab.com/libssh/libssh-mirror/-/commit/2d3b7e07af3675b9a0326bc5c6253a0bbbda567b
> 
> And from what I read, it was just silently behaving as blocking
> (potentially infinitely) instead of returning SSH_AGAIN deep in libssh
> code.

Hm, after looking some more at the code, I agree that it can't have
worked, for the simple reason that sftp_read() never returns SSH_AGAIN,
but turns it into 0. Which QEMU would have reported as an I/O error if
we're not at EOF.

What I don't understand yet where in the code it would have blocked
before rather than returning an error. I tried to follow the code path
and didn't see anything like it, but obviously I'm also not familiar
with libssh code. I guess it also doesn't really matter as long as we
know it has always been broken...

The thing that maybe misled me is that sftp_recv_response_msg() calls
ssh_channel_poll() first to make sure that there is even something to
read. So I expected it should have been non-blocking at least in some
cases, but if it had been, we would probably have seen I/O errors all
the time?

> > So I'm not sure if sftp_aio_*() can be combined with something else into
> > a working solution, and I also don't know if it's affected by the same
> > libssh bug.
> 
> Right now, we do not have a full solution. But having SFTP working
> completely in nonoblocking mode is one of the things we would like to have
> in the long term.
> 
> > Jakub, can you help with that?
> >
> > [...]
> >
> > As far as I can see, libssh sessions aren't thread safe, so we'll have
> > to make sure to have only one request going at the same time, but I
> > assume that calling ssh_read/write() from different threads sequentially
> > isn't a problem?
> 
> My understanding is that the thread safety of libssh is limited to not
> sharing session between threads -- there is no synchronization if two
> threads would send packets at the same time:
> 
> https://api.libssh.org/master/
> 
> If you will make sure you will not call sftp_read()/sftp_write() at
> the same time from different threads, it might work, but it is
> untested.

How do you feel about it? Do you think this is something libssh can
support, or is it something that might accidentally work today, but not
necessarily next year?

We have a thread pool readily available that we could use, but then
requests for the same session would come from different threads - just
never at the same time. If we need a single long-lived thread per
session instead, that might be a little more involved because we might
have to implement all the communication and synchronisation from
scratch.

(Hmm... Or we abuse the IOThread object to create one internally and
just move the request coroutine to it around libssh calls. That could be
easy enough.)

Kevin


