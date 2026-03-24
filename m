Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B18EE9A765
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4zMp-0007BU-M9; Tue, 24 Mar 2026 06:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w4zMk-0007B8-O0
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 06:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w4zMi-0000kn-44
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 06:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774349523;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L6FtIEg1LkTUlE+Bdn2zLfFhWfZZlAd5B8njJFVB1ds=;
 b=J2Wzg2zCepN3zO2/VaQmygN+i7cTdLvvrLFR5GfdoGQLe1IoYXNjh4pi3ZzNw5eO9evjve
 Qqxq/3oSMbIdXFyREQAquBdyQZTJ/6m73R/3579yfsuKZ1T8BfjLl3fbC/srSPqRdFLtpB
 ZsjAMsjIdm++2v7BI+j+K6vrg095wE4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-olsOyhnPNoWtuL8z9Rk3_g-1; Tue,
 24 Mar 2026 06:51:59 -0400
X-MC-Unique: olsOyhnPNoWtuL8z9Rk3_g-1
X-Mimecast-MFC-AGG-ID: olsOyhnPNoWtuL8z9Rk3_g_1774349519
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5B4D195608B; Tue, 24 Mar 2026 10:51:58 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4C7B1800767; Tue, 24 Mar 2026 10:51:56 +0000 (UTC)
Date: Tue, 24 Mar 2026 10:51:53 +0000
To: Junjie Cao <junjie.cao@intel.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de
Subject: Re: [PATCH v2 1/3] io/channel: introduce qio_channel_pread{v, }_all()
 and preadv_all_eof()
Message-ID: <acJsyXqcMfzjHz58@redhat.com>
References: <20260318140113.434-1-junjie.cao@intel.com>
 <20260318140113.434-2-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318140113.434-2-junjie.cao@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
X-ACL-Warn: ,  Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
From:  Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 18, 2026 at 10:01:11PM +0800, Junjie Cao wrote:
> qio_channel_pread() and qio_channel_preadv() perform a single read
> and may return a short result.  Callers that need all bytes currently
> have to open-code a retry loop or simply treat a short read as an
> error.
> 
> Introduce three new helpers following the existing read_all / readv_all
> pattern:
> 
>   qio_channel_preadv_all_eof()  – retry loop; returns 1 on success,
>                                    0 on clean EOF, -1 on error.
>   qio_channel_preadv_all()      – wraps _eof; treats early EOF as
>                                    error; returns 0 / -1.
>   qio_channel_pread_all()       – single-buffer convenience wrapper
>                                    around preadv_all().
> 
> These advance the file offset internally after each partial read, so
> callers only need a single call.  All three are marked
> coroutine_mixed_fn, consistent with the existing _all helpers.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>  include/io/channel.h | 63 ++++++++++++++++++++++++++++++++
>  io/channel.c         | 85 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 148 insertions(+)

So currently we have:

   qio_channel_read
   qio_channel_read_all
   qio_channel_read_all_eof

   qio_channel_readv
   qio_channel_readv_all
   qio_channel_readv_all_eof

   qio_channel_readv_full
   qio_channel_readv_full_all
   qio_channel_readv_full_all_eof

   qio_channel_pread
   qio_channel_preadv

The obvious gaps in this API design pattern are

   qio_channel_pread_all
   qio_channel_pread_all_eof
   qio_channel_preadv_all
   qio_channel_preadv_all_eof

Your patch is fixing 3 of those 4 gaps. Can you also ensure
it adds qio_channel_pread_all_eof so we complete the set.


On the write side we have

   qio_channel_write
   qio_channel_write_all

   qio_channel_writev
   qio_channel_writev_all

   qio_channel_writev_full
   qio_channel_writev_full_all

   qio_channel_pwrite
   qio_channel_pwritev

Thus we're missing

   qio_channel_pwrite_all
   qio_channel_pwritev_all

Your patch only adds read variants, can you add the corresponding
write variants too.

The write variants can be a separate commit from the read
variants.

> diff --git a/include/io/channel.h b/include/io/channel.h
> index 1b02350437..d5b14c8c77 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -634,6 +634,69 @@ ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
>  ssize_t qio_channel_pread(QIOChannel *ioc, void *buf, size_t buflen,
>                            off_t offset, Error **errp);
>  
> +/**
> + * qio_channel_preadv_all_eof:
> + * @ioc: the channel object
> + * @iov: the array of memory regions to read data into
> + * @niov: the length of the @iov array
> + * @offset: the starting offset in the channel to read from
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Reads data contiguously from the channel into @iov starting at
> + * @offset, retrying on short reads until all requested bytes have
> + * been read.  The offset is advanced internally after each partial
> + * read.
> + *
> + * Returns: 1 if all bytes were read, 0 if no data could be read
> + *          before encountering end-of-file, or -1 on error

Keep the descriptive text matching the other APIs as closely
as possible. eg

 * Reads @iov, possibly blocking or (if the channel is non-blocking)
 * yielding from the current coroutine multiple times until the entire
 * content is read. If end-of-file occurs immediately it is not an
 * error, but if it occurs after data has been read it will return
 * an error rather than a short-read. Otherwise behaves as
 * qio_channel_preadv().
 *
 * Returns: 1 if all bytes were read, 0 if end-of-file occurs
 *          without data, or -1 on error


And similarly copy the docs for the other APIs as closely
as possible.

> + */
> +int coroutine_mixed_fn qio_channel_preadv_all_eof(QIOChannel *ioc,
> +                                                  const struct iovec *iov,
> +                                                  size_t niov,
> +                                                  off_t offset,
> +                                                  Error **errp);
> +
> +/**
> + * qio_channel_preadv_all:
> + * @ioc: the channel object
> + * @iov: the array of memory regions to read data into
> + * @niov: the length of the @iov array
> + * @offset: the starting offset in the channel to read from
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Reads data contiguously from the channel into @iov starting at
> + * @offset, retrying on short reads until all requested bytes have
> + * been read.  Unlike qio_channel_preadv_all_eof(), end-of-file
> + * before all data has been read is treated as an error.
> + *
> + * Returns: 0 if all bytes were read, or -1 on error
> + */
> +int coroutine_mixed_fn qio_channel_preadv_all(QIOChannel *ioc,
> +                                              const struct iovec *iov,
> +                                              size_t niov,
> +                                              off_t offset,
> +                                              Error **errp);
> +
> +/**
> + * qio_channel_pread_all:
> + * @ioc: the channel object
> + * @buf: the memory region to read data into
> + * @buflen: the number of bytes to read into @buf
> + * @offset: the starting offset in the channel to read from
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Reads @buflen bytes contiguously from the channel at @offset
> + * into @buf, retrying on short reads.  End-of-file before all data
> + * has been read is treated as an error.
> + *
> + * Returns: 0 if all bytes were read, or -1 on error
> + */
> +int coroutine_mixed_fn qio_channel_pread_all(QIOChannel *ioc,
> +                                             void *buf,
> +                                             size_t buflen,
> +                                             off_t offset,
> +                                             Error **errp);
> +
>  /**
>   * qio_channel_shutdown:
>   * @ioc: the channel object
> diff --git a/io/channel.c b/io/channel.c
> index cc02d997a4..e18c40aa0b 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -507,6 +507,91 @@ ssize_t qio_channel_pread(QIOChannel *ioc, void *buf, size_t buflen,
>      return qio_channel_preadv(ioc, &iov, 1, offset, errp);
>  }
>  
> +int coroutine_mixed_fn qio_channel_preadv_all_eof(QIOChannel *ioc,
> +                                                  const struct iovec *iov,
> +                                                  size_t niov,
> +                                                  off_t offset,
> +                                                  Error **errp)
> +{
> +    int ret = -1;
> +    struct iovec *local_iov = g_new(struct iovec, niov);
> +    struct iovec *local_iov_head = local_iov;
> +    unsigned int nlocal_iov = niov;
> +    bool partial = false;
> +
> +    nlocal_iov = iov_copy(local_iov, nlocal_iov,
> +                          iov, niov,
> +                          0, iov_size(iov, niov));
> +
> +    while (nlocal_iov > 0) {
> +        ssize_t len;
> +        len = qio_channel_preadv(ioc, local_iov, nlocal_iov, offset, errp);
> +
> +        if (len == QIO_CHANNEL_ERR_BLOCK) {
> +            qio_channel_wait_cond(ioc, G_IO_IN);
> +            continue;
> +        }
> +
> +        if (len == 0) {
> +            if (!partial) {
> +                ret = 0;
> +                goto cleanup;
> +            }
> +            error_setg(errp,
> +                       "Unexpected end-of-file before all data were read");
> +            goto cleanup;
> +        }
> +
> +        if (len < 0) {
> +            goto cleanup;
> +        }
> +
> +        partial = true;
> +        offset += len;
> +        iov_discard_front(&local_iov, &nlocal_iov, len);
> +    }
> +
> +    ret = 1;
> +
> + cleanup:
> +    g_free(local_iov_head);
> +    return ret;
> +}
> +
> +int coroutine_mixed_fn qio_channel_preadv_all(QIOChannel *ioc,
> +                                              const struct iovec *iov,
> +                                              size_t niov,
> +                                              off_t offset,
> +                                              Error **errp)
> +{
> +    int ret = qio_channel_preadv_all_eof(ioc, iov, niov, offset, errp);
> +
> +    if (ret == 0) {
> +        error_setg(errp,
> +                   "Unexpected end-of-file before all data were read");
> +        return -1;
> +    }
> +    if (ret == 1) {
> +        return 0;
> +    }
> +
> +    return ret;
> +}
> +
> +int coroutine_mixed_fn qio_channel_pread_all(QIOChannel *ioc,
> +                                             void *buf,
> +                                             size_t buflen,
> +                                             off_t offset,
> +                                             Error **errp)
> +{
> +    struct iovec iov = {
> +        .iov_base = buf,
> +        .iov_len = buflen
> +    };
> +
> +    return qio_channel_preadv_all(ioc, &iov, 1, offset, errp);
> +}
> +
>  int qio_channel_shutdown(QIOChannel *ioc,
>                           QIOChannelShutdown how,
>                           Error **errp)
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


