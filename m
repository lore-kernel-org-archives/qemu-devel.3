Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1A9CAC587
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 09:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvuCY-00041O-Kq; Tue, 09 Sep 2025 04:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvuCJ-0003u8-1o
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 04:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvuC8-0005CT-TV
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 04:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757408353;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=M6QthpR2EzgHPqminK6e/i3VR3CrHxpA5FFdSDcU4mU=;
 b=ROvvzhWPg/iOaFTrYFl3rKOC8MFO27WuvW5RNVr0RTpyM0JU8OPQKTzzSmjaQgTA6DEfmW
 5/HM63eM/qhBnH0NmWkQ8XXyOYa6/00FgrfwSjs8zr5Xwr8cmyGmXFnoJPJ5ppZvyONLCT
 t1dqrdT8WYPSKpEGn0MPNNMZ3s2xIGI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-RHjfvv3XNLmYQMQ0EdQ_6w-1; Tue,
 09 Sep 2025 04:59:09 -0400
X-MC-Unique: RHjfvv3XNLmYQMQ0EdQ_6w-1
X-Mimecast-MFC-AGG-ID: RHjfvv3XNLmYQMQ0EdQ_6w_1757408348
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 366EE1800378; Tue,  9 Sep 2025 08:59:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0277300070A; Tue,  9 Sep 2025 08:59:04 +0000 (UTC)
Date: Tue, 9 Sep 2025 09:59:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: Re: [PATCH 03/10] util: add qemu_set_blocking() function
Message-ID: <aL_sVVaVvHopp6up@redhat.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-4-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903094411.1029449-4-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 03, 2025 at 12:44:03PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> In generic code we have qio_channel_set_blocking(), which takes
> bool parameter, and qemu_file_set_blocking(), which as well takes
> bool parameter.
> 
> At lower fd-layer we have a mess of functions:
> 
> - enough direct calls to g_unix_set_fd_nonblocking()
> and several wrappers without bool parameter:
> 
> - qemu_scoket_set_nonblock(), which asserts success for posix (still,
>   in most cases we can handle the error in better way) and ignores
>   error for win32 realization
> 
> - qemu_socket_try_set_nonblock(), the best one

IMHO this method should not actually exist. The only reason it was
used in the net/ dir was to validate an FD received from the monitor
was indeed an open socket FD. net/socket.c later added a explicit
method 'net_socket_fd_check' to solve this, so we could have switched
away from try_set_nonblock to set_nonblock.

> 
> - qemu_socket_set_block(), which simply ignores an error, the worst
>   case
> 
> And all three lack errp argument, so we have to handle it after the
> call.

They lacked an errp on the expectation that this call should never
fail, if the FD is valid. While I understand the motivation of that
decision, IMHO, it is an undesirable optimization in the API design.

Not all callers can have such confidence. e.g. received the FD from
the monitor, where we really really really must never allow invalid
user supplied FD to result in an assert().

I'm inclined to agree that we should have an errp here, and any
caller that is *certain* their FD is valid could easily pass in
&error_abort.

> 
> So let's introduce a new socket-layer wrapper, and use it consistently
> in following commits.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  include/qemu/osdep.h |  1 +
>  util/oslib-posix.c   | 12 ++++++++++++
>  util/oslib-win32.c   | 18 ++++++++++++++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index be3460b32f..1b38cb7e45 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -687,6 +687,7 @@ ssize_t qemu_write_full(int fd, const void *buf, size_t count)
>      G_GNUC_WARN_UNUSED_RESULT;
>  
>  void qemu_set_cloexec(int fd);
> +bool qemu_set_blocking(int fd, bool block, Error **errp);
>  
>  /* Return a dynamically allocated directory path that is appropriate for storing
>   * local state.
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 4ff577e5de..e473938195 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -250,6 +250,18 @@ void qemu_anon_ram_free(void *ptr, size_t size)
>  #endif
>  }
>  
> +bool qemu_set_blocking(int fd, bool block, Error **errp)
> +{
> +    if (!g_unix_set_fd_nonblocking(fd, !block, NULL)) {
> +        error_setg_errno(errp, errno,
> +                         "Can't set file descriptor %d %s", fd,
> +                         block ? "blocking" : "non-blocking");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  void qemu_socket_set_block(int fd)
>  {
>      g_unix_set_fd_nonblocking(fd, false, NULL);
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index b7351634ec..03044f5b59 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -177,6 +177,24 @@ static int socket_error(void)
>      }
>  }
>  
> +bool qemu_set_blocking(int fd, bool block, Error **errp)
> +{
> +    unsigned long opt = block ? 0 : 1;
> +
> +    if (block) {
> +        qemu_socket_unselect(fd, NULL);
> +    }
> +
> +    if (ioctlsocket(fd, FIONBIO, &opt) != NO_ERROR) {
> +        error_setg_errno(errp, socket_error(),
> +                         "Can't set file descriptor %d %s", fd,
> +                         block ? "blocking" : "non-blocking");
> +        return false;
> +    }
> +
> +    return true;
> +}

I don't think this is a good idea - it is giving the impression that
it works on any FD, but it only supports sockets.

With our current APIs it is clear that setting non-blocking is portable
for sockets, but via use of g_unix_set_fd_nonblocking, non-portable
for non-sockets.

The API design of this method is fine, but I think we should keep 
separate 'qemu_socket_set_blocking' and 'qemu_file_set_blocking'
methods, so that we maintain a clear awareness of the difference
for Windows.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


