Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108DEC27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 19:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGkNI-0001nz-9G; Mon, 10 Jun 2024 15:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGkNH-0001nY-Jp
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 15:08:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGkND-00074F-U8
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 15:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718046486;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BogPAMJxRrpSIqb30+ld6BpU4nS4eFShKMdFyMqQlbI=;
 b=HHhTT5NE03SNDUgyMQBbMz6UXtACCgTJTgk8MSbmOUFe6mONu7LQGT6LLNUoi9Lrrnjjm3
 g8OFyYBooSRuldexl1UMNVCWHtPz5kOonkawG6H7DT9znguQcKUr2l8mbH4rnmOYC9OqYX
 OdFUgl4cXD4kd8WzRuqL6S+dJuI2v34=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-WF_dbRgjN7azvG6UQS7sUg-1; Mon,
 10 Jun 2024 15:08:00 -0400
X-MC-Unique: WF_dbRgjN7azvG6UQS7sUg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E78919560B8; Mon, 10 Jun 2024 19:07:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C6173000224; Mon, 10 Jun 2024 19:07:54 +0000 (UTC)
Date: Mon, 10 Jun 2024 20:07:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Claudio Fontana <cfontana@suse.de>,
 Jim Fehlig <jfehlig@suse.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/18] migration/ram: Add direct-io support to precopy
 file migration
Message-ID: <ZmdPByLWV-LKA72Z@redhat.com>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-19-farosas@suse.de> <Zl9_ZiC6-743ZosG@x1n>
 <87y17gwq5g.fsf@suse.de> <ZmclVQw0x7KKLxmF@x1n>
 <87r0d4wv1q.fsf@suse.de> <ZmdNstq2bONG-7M7@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmdNstq2bONG-7M7@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Jun 10, 2024 at 03:02:10PM -0400, Peter Xu wrote:
> On Mon, Jun 10, 2024 at 02:45:53PM -0300, Fabiano Rosas wrote:
> > >> AIUI, the issue here that users are already allowed to specify in
> > >> libvirt the equivalent to direct-io and multifd independent of each
> > >> other (bypass-cache, parallel). To start requiring both together now in
> > >> some situations would be a regression. I confess I don't know libvirt
> > >> code to know whether this can be worked around somehow, but as I said,
> > >> it's a relatively simple change from the QEMU side.
> > >
> > > Firstly, I definitely want to already avoid all the calls to either
> > > migration_direct_io_start() or *_finish(), now we already need to
> > > explicitly call them in three paths, and that's not intuitive and less
> > > readable, just like the hard coded rdma codes.
> > 
> > Right, but that's just a side-effect of how the code is structured and
> > the fact that writes to the stream happen in small chunks. Setting
> > O_DIRECT needs to happen around aligned IO. We could move the calls
> > further down into qemu_put_buffer_at(), but that would be four fcntl()
> > calls for every page.
> 
> Hmm.. why we need four fcntl()s instead of two?
> 
> > 
> > A tangent:
> >  one thing that occured to me now is that we may be able to restrict
> >  calls to qemu_fflush() to internal code like add_to_iovec() and maybe
> >  use that function to gather the correct amount of data before writing,
> >  making sure it disables O_DIRECT in case alignment is about to be
> >  broken?
> 
> IIUC dio doesn't require alignment if we don't care about perf?  I meant it
> should be legal to write(fd, buffer, 5) even if O_DIRECT?

No, we must assume  that O_DIRECT requires alignment both of the userspace
memory buffers, and the file offset on disk:

[quote man(open)]
  O_DIRECT
       The O_DIRECT flag may impose alignment restrictions  on  the  length
       and  address  of user-space buffers and the file offset of I/Os.  In
       Linux alignment restrictions vary by filesystem and  kernel  version
       and  might  be absent entirely.  The handling of misaligned O_DIRECT
       I/Os also varies; they can either fail with EINVAL or fall  back  to
       buffered I/O.
[/quote]

Given QEMU's code base, it is only safe for us to use O_DIRECT with RAM
blocks where we have predictable in-memory alignment, and have defined
a good on-disk offset alignment too.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


