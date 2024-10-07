Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C19CFB449
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqiL-0008J1-Ny; Mon, 07 Oct 2024 12:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxqiC-0008ID-5N
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxqi7-0000OV-PP
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728318950;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kHD3iE/R0F7OoFYcOqlWl6V6vI5EzHdLStBeQNp5F3U=;
 b=Yl3CBcz11mzBYZCEDkCvZmK4bVzyKiTE+7EATbOrmDt2yCjhELZVjgbZKcgrHVLe5jM/Tb
 Wht6kOVXD5xbyrjOQhA1jji2QWZvMnFVVEFvyYmL09FlsS0pyJh/RJIEqRCQFDPU8LoGfc
 +GorebxHfc24If3nd8Ls3n4wWDNPiXg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-D3ceVTUVN9eeUCnhKQPLYg-1; Mon,
 07 Oct 2024 12:35:46 -0400
X-MC-Unique: D3ceVTUVN9eeUCnhKQPLYg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1222A1955D47; Mon,  7 Oct 2024 16:35:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF9A71956088; Mon,  7 Oct 2024 16:35:41 +0000 (UTC)
Date: Mon, 7 Oct 2024 17:35:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 07/13] migration: SCM_RIGHTS for QEMUFile
Message-ID: <ZwQN2YoMWNTMdop3@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-8-git-send-email-steven.sistare@oracle.com>
 <ZwQG_dvmTFFA2Xom@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwQG_dvmTFFA2Xom@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Oct 07, 2024 at 12:06:21PM -0400, Peter Xu wrote:
> On Mon, Sep 30, 2024 at 12:40:38PM -0700, Steve Sistare wrote:
> > Define functions to put/get file descriptors to/from a QEMUFile, for qio
> > channels that support SCM_RIGHTS.  Maintain ordering such that
> >   put(A), put(fd), put(B)
> > followed by
> >   get(A), get(fd), get(B)
> > always succeeds.  Other get orderings may succeed but are not guaranteed.
> > 
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > ---
> >  migration/qemu-file.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++---
> >  migration/qemu-file.h  |  2 ++
> >  migration/trace-events |  2 ++
> >  3 files changed, 83 insertions(+), 4 deletions(-)
> > 
> > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> > index b6d2f58..7f951ab 100644
> > --- a/migration/qemu-file.c
> > +++ b/migration/qemu-file.c
> > @@ -37,6 +37,11 @@
> >  #define IO_BUF_SIZE 32768
> >  #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
> >  
> > +typedef struct FdEntry {
> > +    QTAILQ_ENTRY(FdEntry) entry;
> > +    int fd;
> > +} FdEntry;
> > +
> >  struct QEMUFile {
> >      QIOChannel *ioc;
> >      bool is_writable;
> > @@ -51,6 +56,9 @@ struct QEMUFile {
> >  
> >      int last_error;
> >      Error *last_error_obj;
> > +
> > +    bool fd_pass;
> > +    QTAILQ_HEAD(, FdEntry) fds;
> >  };
> >  
> >  /*
> > @@ -109,6 +117,8 @@ static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
> >      object_ref(ioc);
> >      f->ioc = ioc;
> >      f->is_writable = is_writable;
> > +    f->fd_pass = qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS);
> > +    QTAILQ_INIT(&f->fds);
> >  
> >      return f;
> >  }
> > @@ -310,6 +320,10 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
> >      int len;
> >      int pending;
> >      Error *local_error = NULL;
> > +    g_autofree int *fds = NULL;
> > +    size_t nfd = 0;
> > +    int **pfds = f->fd_pass ? &fds : NULL;
> > +    size_t *pnfd = f->fd_pass ? &nfd : NULL;
> >  
> >      assert(!qemu_file_is_writable(f));
> >  
> > @@ -325,10 +339,9 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
> >      }
> >  
> >      do {
> > -        len = qio_channel_read(f->ioc,
> > -                               (char *)f->buf + pending,
> > -                               IO_BUF_SIZE - pending,
> > -                               &local_error);
> > +        struct iovec iov = { f->buf + pending, IO_BUF_SIZE - pending };
> > +        len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
> > +                                     &local_error);
> >          if (len == QIO_CHANNEL_ERR_BLOCK) {
> >              if (qemu_in_coroutine()) {
> >                  qio_channel_yield(f->ioc, G_IO_IN);
> > @@ -348,9 +361,65 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
> >          qemu_file_set_error_obj(f, len, local_error);
> >      }
> >  
> > +    for (int i = 0; i < nfd; i++) {
> > +        FdEntry *fde = g_new0(FdEntry, 1);
> > +        fde->fd = fds[i];
> > +        QTAILQ_INSERT_TAIL(&f->fds, fde, entry);
> > +    }
> > +
> >      return len;
> >  }
> >  
> > +int qemu_file_put_fd(QEMUFile *f, int fd)
> > +{
> > +    int ret = 0;
> > +    QIOChannel *ioc = qemu_file_get_ioc(f);
> > +    Error *err = NULL;
> > +    struct iovec iov = { (void *)" ", 1 };
> > +
> > +    /*
> > +     * Send a dummy byte so qemu_fill_buffer on the receiving side does not
> > +     * fail with a len=0 error.  Flush first to maintain ordering wrt other
> > +     * data.
> > +     */
> > +
> > +    qemu_fflush(f);
> > +    if (qio_channel_writev_full(ioc, &iov, 1, &fd, 1, 0, &err) < 1) {
> > +        error_report_err(error_copy(err));
> > +        qemu_file_set_error_obj(f, -EIO, err);
> > +        ret = -1;
> > +    }
> > +    trace_qemu_file_put_fd(f->ioc->name, fd, ret);
> > +    return ret;
> > +}
> > +
> > +int qemu_file_get_fd(QEMUFile *f)
> > +{
> > +    int fd = -1;
> > +    FdEntry *fde;
> > +
> > +    if (!f->fd_pass) {
> > +        Error *err = NULL;
> > +        error_setg(&err, "%s does not support fd passing", f->ioc->name);
> > +        error_report_err(error_copy(err));
> > +        qemu_file_set_error_obj(f, -EIO, err);
> > +        goto out;
> > +    }
> > +
> > +    /* Force the dummy byte and its fd passenger to appear. */
> > +    qemu_peek_byte(f, 0);
> > +
> > +    fde = QTAILQ_FIRST(&f->fds);
> > +    if (fde) {
> > +        qemu_get_byte(f);       /* Drop the dummy byte */
> 
> Can we still try to get rid of this magical byte?
> 
> Ideally this function should check for no byte but f->fds bening non-empty,
> if it is it could invoke qemu_fill_buffer(). OTOH, qemu_fill_buffer() needs
> to take len==0&&nfds!=0 as legal.  Would that work?

When passing ancilliary data with sendmsg/recvmsg, on Linux at least,
it is required that there is at least 1 byte of data present.

See 'man 7 unix':

[quote]
   At  least  one  byte  of real data should be sent when
   sending ancillary data.  On Linux, this is required to
   successfully send ancillary data over  a  UNIX  domain
   stream  socket.   When  sending  ancillary data over a
   UNIX domain datagram socket, it is  not  necessary  on
   Linux  to  send  any accompanying real data.  However,
   portable applications should also include at least one
   byte of real data when sending ancillary data  over  a
   datagram socket.
[/quote]

So if your protocol doesn't already have a convenient bit of real data to
attach the SCM_RIGHTS data to, it is common practice to send a single dummy
data byte that is discarded.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


