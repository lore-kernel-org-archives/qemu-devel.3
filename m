Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DF1CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tEj-0003BM-An; Thu, 09 Oct 2025 12:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6tEh-0003Aa-A3
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:11:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6tEc-0008Ff-PT
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760026273;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cpDa/q1pe1iO87V8H9arzEKH/n4NOnRyPV16pUFX7dY=;
 b=bhmI+FSirr1+lUsP7mqTa7JyBn27Jl7b/XQgNCA6cGi+Hj9Om1DltvUuxfQIhUxRNUTquH
 aE8X1L0EoFKB/NEZH6X5AGy+XC3nQNCphw1Wdk5VwM57ava2VG11YBQARhOwNniXQWp/Rk
 4Bf+5zbMP5axJRMvxIXtkeJmkjl0Lkg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-NMqwt7sSOUOqpAXtMEHtEg-1; Thu,
 09 Oct 2025 12:11:04 -0400
X-MC-Unique: NMqwt7sSOUOqpAXtMEHtEg-1
X-Mimecast-MFC-AGG-ID: NMqwt7sSOUOqpAXtMEHtEg_1760026263
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEF2B1955D72; Thu,  9 Oct 2025 16:11:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.196])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85B7F1955F21; Thu,  9 Oct 2025 16:11:00 +0000 (UTC)
Date: Thu, 9 Oct 2025 17:10:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Manish Mishra <manish.mishra@nutanix.com>
Subject: Re: [PATCH v5 3/3] QIOChannelSocket: flush zerocopy socket error
 queue on sendmsg failure due to ENOBUF
Message-ID: <aOfejwB5ZjSv444I@redhat.com>
References: <20251009101420.3048487-1-tejus.gk@nutanix.com>
 <20251009101420.3048487-4-tejus.gk@nutanix.com>
 <aOePR-Jd5UX5DXAA@redhat.com>
 <16F108E5-79A7-4940-B3AB-BDB34EC4CA93@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16F108E5-79A7-4940-B3AB-BDB34EC4CA93@nutanix.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 09, 2025 at 11:51:51AM +0000, Tejus GK wrote:
> 
> 
> > On 9 Oct 2025, at 4:02 PM, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Thu, Oct 09, 2025 at 10:14:18AM +0000, Tejus GK wrote:
> >> From: Manish Mishra <manish.mishra@nutanix.com>
> >> 
> >> The kernel allocates extra metadata SKBs in case of a zerocopy send,
> >> eventually used for zerocopy's notification mechanism. This metadata
> >> memory is accounted for in the OPTMEM limit. The kernel queues
> >> completion notifications on the socket error queue and this error queue
> >> is freed when userspace reads it.
> >> 
> >> Usually, in the case of in-order processing, the kernel will batch the
> >> notifications and merge the metadata into a single SKB and free the
> >> rest. As a result, it never exceeds the OPTMEM limit. However, if there
> >> is any out-of-order processing or intermittent zerocopy failures, this
> >> error chain can grow significantly, exhausting the OPTMEM limit. As a
> >> result, all new sendmsg requests fail to allocate any new SKB, leading
> >> to an ENOBUF error. Depending on the amount of data queued before the
> >> flush (i.e., large live migration iterations), even large OPTMEM limits
> >> are prone to failure.
> >> 
> >> To work around this, if we encounter an ENOBUF error with a zerocopy
> >> sendmsg, flush the error queue and retry once more.
> >> 
> >> Co-authored-by: Manish Mishra <manish.mishra@nutanix.com>
> >> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
> >> ---
> >> include/io/channel-socket.h |  5 +++
> >> io/channel-socket.c         | 78 ++++++++++++++++++++++++++++++-------
> >> migration/multifd-nocomp.c  |  3 +-
> >> migration/multifd.c         |  3 +-
> >> 4 files changed, 72 insertions(+), 17 deletions(-)
> >> 
> >> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> >> index 26319fa98b..fcfd489c6c 100644
> >> --- a/include/io/channel-socket.h
> >> +++ b/include/io/channel-socket.h
> >> @@ -50,6 +50,11 @@ struct QIOChannelSocket {
> >>     ssize_t zero_copy_queued;
> >>     ssize_t zero_copy_sent;
> >>     bool blocking;
> >> +    /**
> >> +     * This flag indicates whether any new data was successfully sent with
> >> +     * zerocopy since the last qio_channel_socket_flush() call.
> >> +     */
> >> +    bool new_zero_copy_sent_success;
> >> };
> >> 
> >> 
> >> diff --git a/io/channel-socket.c b/io/channel-socket.c
> >> index 8b30d5b7f7..22d59cd3cf 100644
> >> --- a/io/channel-socket.c
> >> +++ b/io/channel-socket.c
> >> @@ -37,6 +37,12 @@
> >> 
> >> #define SOCKET_MAX_FDS 16
> >> 
> >> +#ifdef QEMU_MSG_ZEROCOPY
> >> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> >> +                                             bool block,
> >> +                                             Error **errp);
> >> +#endif
> >> +
> >> SocketAddress *
> >> qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
> >>                                      Error **errp)
> >> @@ -66,6 +72,7 @@ qio_channel_socket_new(void)
> >>     sioc->zero_copy_queued = 0;
> >>     sioc->zero_copy_sent = 0;
> >>     sioc->blocking = false;
> >> +    sioc->new_zero_copy_sent_success = FALSE;
> >> 
> >>     ioc = QIO_CHANNEL(sioc);
> >>     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
> >> @@ -618,6 +625,8 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
> >>     size_t fdsize = sizeof(int) * nfds;
> >>     struct cmsghdr *cmsg;
> >>     int sflags = 0;
> >> +    bool blocking = sioc->blocking;
> >> +    bool zerocopy_flushed_once = false;
> >> 
> >>     memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
> >> 
> >> @@ -663,10 +672,26 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
> >>         case EINTR:
> >>             goto retry;
> >>         case ENOBUFS:
> >> -            if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
> >> -                error_setg_errno(errp, errno,
> >> -                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
> >> -                return -1;
> >> +            if (flags & (QIO_CHANNEL_WRITE_FLAG_ZERO_COPY |
> >> +                QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE)) {
> > 
> > 
> > There are only two callers where this patch has added use of
> > QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE.
> > 
> > Both of them already sett QIO_CHANNEL_WRITE_FLAG_ZERO_COPY, so
> > this code branch was already being taken
> > 
> > IOW, this new QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE looks
> > pointless.
> 
> The intention on adding QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE
> was to let callers decide if they want QEMU to silently flush
> and not throw an ENOBUFS.

This doesn't make any sense. sendmsg man page says that ENOBUFS
is never returned on Linux ordinarily. So AFAICT, the only time
we'll see ENOBUFS is if we used MSG_ZEROCOPY in the sendmsg
input. The MSG_ZEROCOPY flag for sendmsg is only set if we have
QIO_CHANNEL_WRITE_FLAG_ZERO_COPY flag set in the qio_channel_write
call. So again QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE appears
to serve no functional purpose.

> Right now it fits for the migration use-case, since migration is
> the only caller using MSG_ZEROCOPY in the first place, but in case
> someone else decides to use MSG_ZEROCOPY, and wants the regular
> semantics of a write, i.e, expecting an ENOBUFS on a socket error
> queue pileup, they may choose not to pass the flag, rather than
> letting QEMU doing it unconditionally.

This patch was previously addressing a functional bug in the current
code.  Satisfying any new use case should be a completly separate
patch with justification in the commit message, as any single commit
should only address 1 problem at a time.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


