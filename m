Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4201C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPhw-00020v-Ft; Fri, 07 Feb 2025 09:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tgPhu-00020b-2r
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:51:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tgPhr-0000HM-Iy
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738939905;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=I/J7l0SX+3pUJHflm2MnNu7lzpQZKryiJivHnfEHvTg=;
 b=IP7WSOfU1Q1pid8wBVSajdD/aiUxwTFH+EGLI1FzoADFatdFXCB6X6VY7cUukAQUZdxqyT
 Q2ooKQ+/H5xSV4or4yLrwS1Zny/Yi01mZYXioSawCD7mWD5oDmZ5cITFu+Oz8g6izvOmGs
 WWHRUUqZx7HcsDy7NB2757V/4qXs+Gg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-ggwYGK1cPDWVsjm39VDapw-1; Fri,
 07 Feb 2025 09:51:41 -0500
X-MC-Unique: ggwYGK1cPDWVsjm39VDapw-1
X-Mimecast-MFC-AGG-ID: ggwYGK1cPDWVsjm39VDapw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 005161956050; Fri,  7 Feb 2025 14:51:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 372FD1800360; Fri,  7 Feb 2025 14:51:35 +0000 (UTC)
Date: Fri, 7 Feb 2025 14:51:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Coiby Xu <Coiby.Xu@gmail.com>
Subject: Re: [RFC PATCH v2 6/8] io: Plumb read flags into
 qio_channel_read_all_eof
Message-ID: <Z6Yd9MY0IEZ7Jkf1@redhat.com>
References: <20250207142758.6936-1-farosas@suse.de>
 <20250207142758.6936-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250207142758.6936-7-farosas@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Feb 07, 2025 at 11:27:56AM -0300, Fabiano Rosas wrote:
> We want to pass flags into qio_channel_tls_readv() but some functions
> along the way don't take a flags argument. Plumb the flags through.
> 
> No functional change.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---

> diff --git a/include/io/channel.h b/include/io/channel.h
> index bdf0bca92a..6110f0ffe9 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -298,6 +298,7 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
>   * @ioc: the channel object
>   * @iov: the array of memory regions to read data into
>   * @niov: the length of the @iov array
> + * @flags: read flags (QIO_CHANNEL_READ_FLAG_*)
>   * @errp: pointer to a NULL-initialized error object
>   *
>   * Read data from the IO channel, storing it in the
> @@ -321,6 +322,7 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
>  int coroutine_mixed_fn qio_channel_readv_all_eof(QIOChannel *ioc,
>                                                   const struct iovec *iov,
>                                                   size_t niov,
> +                                                 int flags,
>                                                   Error **errp);
>  
>  /**
> @@ -442,6 +444,7 @@ ssize_t qio_channel_write(QIOChannel *ioc,
>   * @ioc: the channel object
>   * @buf: the memory region to read data into
>   * @buflen: the number of bytes to @buf
> + * @flags: read flags (QIO_CHANNEL_READ_FLAG_*)
>   * @errp: pointer to a NULL-initialized error object
>   *
>   * Reads @buflen bytes into @buf, possibly blocking or (if the
> @@ -457,6 +460,7 @@ ssize_t qio_channel_write(QIOChannel *ioc,
>  int coroutine_mixed_fn qio_channel_read_all_eof(QIOChannel *ioc,
>                                                  char *buf,
>                                                  size_t buflen,
> +                                                int flags,
>                                                  Error **errp);
>

The 'int flags' parameter is intended to only be added to the
"_full" method variants since it is niche usage, so these two
shouldn't be changed.

>  /**
> @@ -885,6 +889,7 @@ void qio_channel_set_aio_fd_handler(QIOChannel *ioc,
>   * @niov: the length of the @iov array
>   * @fds: an array of file handles to read
>   * @nfds: number of file handles in @fds
> + * @flags: read flags (QIO_CHANNEL_READ_FLAG_*)
>   * @errp: pointer to a NULL-initialized error object
>   *
>   *
> @@ -903,6 +908,7 @@ int coroutine_mixed_fn qio_channel_readv_full_all_eof(QIOChannel *ioc,
>                                                        const struct iovec *iov,
>                                                        size_t niov,
>                                                        int **fds, size_t *nfds,
> +                                                      int flags,
>                                                        Error **errp);

This is ok, and migration code should switch to calling this
method instead of qio_channel_readv_all_eof to make use of flags.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


