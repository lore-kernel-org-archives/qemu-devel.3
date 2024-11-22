Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B3CD75E59
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 14:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEUst-0000NW-H5; Fri, 22 Nov 2024 09:43:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tEUsp-0000N1-40
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 09:43:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tEUsk-0000f4-5z
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 09:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732286614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3qWzLWVfpF22sdRBj1zDE9moH6YeZyEhmhpz2GGTyj8=;
 b=dxbYHJ9OviPTkmK/rcJEDxelMq+eaQDCUXwFCCIf96ji2zJjlH54z5reHZeZtG3RHDqelq
 Y/eq5bQBUSBcxhJTA2+m0DyiC1P/64vtmmWR04zYwMdXy1akbcATV6JigOnVOgpFgJCUR/
 Kc7R4ibkRmN9x2lKwKPR053RaPv62lM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-5wCUwLI-Oiar-wy5gaN99Q-1; Fri,
 22 Nov 2024 09:43:30 -0500
X-MC-Unique: 5wCUwLI-Oiar-wy5gaN99Q-1
X-Mimecast-MFC-AGG-ID: 5wCUwLI-Oiar-wy5gaN99Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B0011955F42; Fri, 22 Nov 2024 14:43:28 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.157])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E775519560A3; Fri, 22 Nov 2024 14:43:23 +0000 (UTC)
Date: Fri, 22 Nov 2024 15:43:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Jakub Jelen <jjelen@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, hreitz@redhat.com, mpitt@redhat.com
Subject: Re: [PATCH ssh] ssh: Do not switch session to non-blocking mode
Message-ID: <Z0CYiB3r8yZKw4sP@redhat.com>
References: <20241113115000.2494785-1-rjones@redhat.com>
 <0371e3cc-1ed5-4685-835a-5378dd4dfbb7@tls.msk.ru>
 <20241113130021.GA20898@redhat.com> <ZzYVgRo_l2ZHQztg@redhat.com>
 <CAHrFiA98_icSL5WqTFN1gpWN+=70d58rH=V3iJWDf4zYApSMQA@mail.gmail.com>
 <ZzY4D7t5asZZWgwN@redhat.com>
 <CAHrFiA9tURvg0xitWK6gaA9osGF1ZoHq6d1yFv+nB8FPTg7-Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHrFiA9tURvg0xitWK6gaA9osGF1ZoHq6d1yFv+nB8FPTg7-Cg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 18.11.2024 um 18:06 hat Jakub Jelen geschrieben:
> Hi Kevin,
> Sorry for the delay, my gmail filters will need some love to handle this
> high-traffic mailing lists so I can catch replies ...
> 
> On Thu, Nov 14, 2024 at 6:49 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > [...]
> > Hm, after looking some more at the code, I agree that it can't have
> > worked, for the simple reason that sftp_read() never returns SSH_AGAIN,
> > but turns it into 0. Which QEMU would have reported as an I/O error if
> > we're not at EOF.
> >
> > What I don't understand yet where in the code it would have blocked
> > before rather than returning an error. I tried to follow the code path
> > and didn't see anything like it, but obviously I'm also not familiar
> > with libssh code. I guess it also doesn't really matter as long as we
> > know it has always been broken...
> 
> I think it is the cycle in the sftp_packet_read(), which was polling
> until we got something to read here:
> 
> https://gitlab.com/libssh/libssh-mirror/-/blob/master/src/sftp_common.c?ref_type=heads#L75-L100
> 
> But I would have to retrace through the code as I already forgot where I
> was looking to.

The loop you highlighted does at most 4 reads and errors out if it
doesn't read anything, so I don't think that's it. If it blocks,
something inside of ssh_channel_read() must do that.

> > The thing that maybe misled me is that sftp_recv_response_msg() calls
> > ssh_channel_poll() first to make sure that there is even something to
> > read. So I expected it should have been non-blocking at least in some
> > cases, but if it had been, we would probably have seen I/O errors all
> > the time?
> 
> Note, that the sftp_recv_response_msg() function is new in master and
> not yet in any released versions. The 0.11 version had processing directly
> in the sftp_read() (and in each other function handling some responses).
> 
> https://gitlab.com/libssh/libssh-mirror/-/blob/stable-0.11/src/sftp.c?ref_type=heads#L1200
> 
> Also the ssh_channel_poll() is called only when the file handle is in
> non-blocking mode (whatever it means). The qemu sets the blocking mode
> here:
> 
> https://github.com/qemu/qemu/blob/master/block/ssh.c#L805C1-L805C44
> 
> This means the execution goes directly into sftp_read_and_dispatch(),
> which we discussed above as it does the blocking.

Oh, right, I was confused with blocking mode for sftp and for the ssh
session. We have sftp blocking and the session non-blocking for the most
part.

> > > > So I'm not sure if sftp_aio_*() can be combined with something else into
> > > > a working solution, and I also don't know if it's affected by the same
> > > > libssh bug.
> > >
> > > Right now, we do not have a full solution. But having SFTP working
> > > completely in nonoblocking mode is one of the things we would like to have
> > > in the long term.
> > >
> > > > Jakub, can you help with that?
> > > >
> > > > [...]
> > > >
> > > > As far as I can see, libssh sessions aren't thread safe, so we'll have
> > > > to make sure to have only one request going at the same time, but I
> > > > assume that calling ssh_read/write() from different threads sequentially
> > > > isn't a problem?
> > >
> > > My understanding is that the thread safety of libssh is limited to not
> > > sharing session between threads -- there is no synchronization if two
> > > threads would send packets at the same time:
> > >
> > > https://api.libssh.org/master/
> > >
> > > If you will make sure you will not call sftp_read()/sftp_write() at
> > > the same time from different threads, it might work, but it is
> > > untested.
> >
> > How do you feel about it? Do you think this is something libssh can
> > support, or is it something that might accidentally work today, but not
> > necessarily next year?
> 
> If we will write some test coverage for this, I think we can make sure it
> keeps working. There is really nothing that libssh would do in the background
> so the stuff should not go wrong. We will just make sure to double-check
> all the variables are a part of session and not scattered around as static
> variables or thread local ones (I hope we don't have much of these though).

Ok, that sounds good.

> > We have a thread pool readily available that we could use, but then
> > requests for the same session would come from different threads - just
> > never at the same time. If we need a single long-lived thread per
> > session instead, that might be a little more involved because we might
> > have to implement all the communication and synchronisation from
> > scratch.
> >
> > (Hmm... Or we abuse the IOThread object to create one internally and
> > just move the request coroutine to it around libssh calls. That could be
> > easy enough.)
> 
> Sorry, I don't have much experience around this to bring any useful insight
> here.
> 
> So going back to the original issue, is the proposed patch something
> that could work for you in the short term before a better solution
> will be implemented or is there something we should change?

Given that apparently it was always blocking, the patch doesn't make the
situation any worse. I'll apply it for 9.2.

Kevin


