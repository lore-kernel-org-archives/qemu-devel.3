Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA80CFB449
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqGk-0008NG-OQ; Mon, 07 Oct 2024 12:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxqGf-0008M6-1B
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxqGc-0005Af-G1
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728317243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=106HeorDo4GGP188xhUMo+CnR0NRGMMMqFwjqwNPjx8=;
 b=TyniE3SS/6/wCIXFHrNTExrlU54URaIMa0fBbOsuX7KzVkamedGii3iH9jFVmYCZUByacI
 4KiGT09g2afnT8wbY0bQTvlC8X2NmG/Vnbr196RSqfqiTm7Z7m/+F4C6s1pf/Blpnd6zof
 TOcEIn+SUu56ofHDLENQxSLFLdES/9w=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-V_GfTdqPN_2bebdx-dxt6w-1; Mon, 07 Oct 2024 12:06:31 -0400
X-MC-Unique: V_GfTdqPN_2bebdx-dxt6w-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-20b4bb1edc0so39377705ad.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 09:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728317185; x=1728921985;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=106HeorDo4GGP188xhUMo+CnR0NRGMMMqFwjqwNPjx8=;
 b=h2UAJqWUPKiGSSZIfjCvvCKdDgcUMzEM3n++60FxunqDXIqIBQCjDUDvRsl1TFcsM9
 YZyNEy19oIFu9Hoo54MyLByR1PZHXMD6msAof0FCyESIpqYkCVcAelK5iujRayrLQt8W
 zMD7RE1mh8t7/9DIeF6yexmbejMcn31xxKm1QoFpbi5SH2TfRcNoZ0J8459RoaPDMJF7
 w07W0kC7C6YtMMRvAKS8BoCEADjRqlrcjB5a3U/HIfoJtv8TO4mQRawXltP3bSJfQCbI
 Xi7TvaD3L0GeAB/X+GtEOBH3+xQBZqSrvddfqsCtp8NcClLnwhpCTcFzdQpslP8NA/ht
 c6kg==
X-Gm-Message-State: AOJu0YyVvbvRXm5w96A4m09xXODg119jxu14qtEIbEVHMdNCk8LH5Si2
 65aKYnbWHFDbygowhjWUp38ZzthTKTBR0fpTzZv4FqUjJR09RLi302XXTijcyxOzPw65Ara3u7S
 U8y+cWbwvH/Qlud/2kcCcDQeAMr1yUNg18hOwgYs8zhK1nM2Gd/pA
X-Received: by 2002:a17:903:2447:b0:20b:6f02:b4e5 with SMTP id
 d9443c01a7336-20bfde5968dmr191831815ad.9.1728317185274; 
 Mon, 07 Oct 2024 09:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9WJTAy5Wctjv+RdEjrNAHMvhOuHB7DETBpTwaogR84QHrcKrL5qpXY/GNcn1rUCadHijJ7Q==
X-Received: by 2002:a17:903:2447:b0:20b:6f02:b4e5 with SMTP id
 d9443c01a7336-20bfde5968dmr191831195ad.9.1728317184636; 
 Mon, 07 Oct 2024 09:06:24 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4db6ec369fdsm1202614173.138.2024.10.07.09.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 09:06:24 -0700 (PDT)
Date: Mon, 7 Oct 2024 12:06:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 07/13] migration: SCM_RIGHTS for QEMUFile
Message-ID: <ZwQG_dvmTFFA2Xom@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-8-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1727725244-105198-8-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 30, 2024 at 12:40:38PM -0700, Steve Sistare wrote:
> Define functions to put/get file descriptors to/from a QEMUFile, for qio
> channels that support SCM_RIGHTS.  Maintain ordering such that
>   put(A), put(fd), put(B)
> followed by
>   get(A), get(fd), get(B)
> always succeeds.  Other get orderings may succeed but are not guaranteed.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  migration/qemu-file.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++---
>  migration/qemu-file.h  |  2 ++
>  migration/trace-events |  2 ++
>  3 files changed, 83 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index b6d2f58..7f951ab 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -37,6 +37,11 @@
>  #define IO_BUF_SIZE 32768
>  #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
>  
> +typedef struct FdEntry {
> +    QTAILQ_ENTRY(FdEntry) entry;
> +    int fd;
> +} FdEntry;
> +
>  struct QEMUFile {
>      QIOChannel *ioc;
>      bool is_writable;
> @@ -51,6 +56,9 @@ struct QEMUFile {
>  
>      int last_error;
>      Error *last_error_obj;
> +
> +    bool fd_pass;
> +    QTAILQ_HEAD(, FdEntry) fds;
>  };
>  
>  /*
> @@ -109,6 +117,8 @@ static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
>      object_ref(ioc);
>      f->ioc = ioc;
>      f->is_writable = is_writable;
> +    f->fd_pass = qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS);
> +    QTAILQ_INIT(&f->fds);
>  
>      return f;
>  }
> @@ -310,6 +320,10 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>      int len;
>      int pending;
>      Error *local_error = NULL;
> +    g_autofree int *fds = NULL;
> +    size_t nfd = 0;
> +    int **pfds = f->fd_pass ? &fds : NULL;
> +    size_t *pnfd = f->fd_pass ? &nfd : NULL;
>  
>      assert(!qemu_file_is_writable(f));
>  
> @@ -325,10 +339,9 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>      }
>  
>      do {
> -        len = qio_channel_read(f->ioc,
> -                               (char *)f->buf + pending,
> -                               IO_BUF_SIZE - pending,
> -                               &local_error);
> +        struct iovec iov = { f->buf + pending, IO_BUF_SIZE - pending };
> +        len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
> +                                     &local_error);
>          if (len == QIO_CHANNEL_ERR_BLOCK) {
>              if (qemu_in_coroutine()) {
>                  qio_channel_yield(f->ioc, G_IO_IN);
> @@ -348,9 +361,65 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>          qemu_file_set_error_obj(f, len, local_error);
>      }
>  
> +    for (int i = 0; i < nfd; i++) {
> +        FdEntry *fde = g_new0(FdEntry, 1);
> +        fde->fd = fds[i];
> +        QTAILQ_INSERT_TAIL(&f->fds, fde, entry);
> +    }
> +
>      return len;
>  }
>  
> +int qemu_file_put_fd(QEMUFile *f, int fd)
> +{
> +    int ret = 0;
> +    QIOChannel *ioc = qemu_file_get_ioc(f);
> +    Error *err = NULL;
> +    struct iovec iov = { (void *)" ", 1 };
> +
> +    /*
> +     * Send a dummy byte so qemu_fill_buffer on the receiving side does not
> +     * fail with a len=0 error.  Flush first to maintain ordering wrt other
> +     * data.
> +     */
> +
> +    qemu_fflush(f);
> +    if (qio_channel_writev_full(ioc, &iov, 1, &fd, 1, 0, &err) < 1) {
> +        error_report_err(error_copy(err));
> +        qemu_file_set_error_obj(f, -EIO, err);
> +        ret = -1;
> +    }
> +    trace_qemu_file_put_fd(f->ioc->name, fd, ret);
> +    return ret;
> +}
> +
> +int qemu_file_get_fd(QEMUFile *f)
> +{
> +    int fd = -1;
> +    FdEntry *fde;
> +
> +    if (!f->fd_pass) {
> +        Error *err = NULL;
> +        error_setg(&err, "%s does not support fd passing", f->ioc->name);
> +        error_report_err(error_copy(err));
> +        qemu_file_set_error_obj(f, -EIO, err);
> +        goto out;
> +    }
> +
> +    /* Force the dummy byte and its fd passenger to appear. */
> +    qemu_peek_byte(f, 0);
> +
> +    fde = QTAILQ_FIRST(&f->fds);
> +    if (fde) {
> +        qemu_get_byte(f);       /* Drop the dummy byte */

Can we still try to get rid of this magical byte?

Ideally this function should check for no byte but f->fds bening non-empty,
if it is it could invoke qemu_fill_buffer(). OTOH, qemu_fill_buffer() needs
to take len==0&&nfds!=0 as legal.  Would that work?

> +        fd = fde->fd;
> +        QTAILQ_REMOVE(&f->fds, fde, entry);
> +    }
> +out:
> +    trace_qemu_file_get_fd(f->ioc->name, fd);
> +    return fd;
> +}
> +
>  /** Closes the file
>   *
>   * Returns negative error value if any error happened on previous operations or
> @@ -361,11 +430,17 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>   */
>  int qemu_fclose(QEMUFile *f)
>  {
> +    FdEntry *fde, *next;
>      int ret = qemu_fflush(f);
>      int ret2 = qio_channel_close(f->ioc, NULL);
>      if (ret >= 0) {
>          ret = ret2;
>      }
> +    QTAILQ_FOREACH_SAFE(fde, &f->fds, entry, next) {
> +        warn_report("qemu_fclose: received fd %d was never claimed", fde->fd);
> +        close(fde->fd);
> +        g_free(fde);
> +    }
>      g_clear_pointer(&f->ioc, object_unref);
>      error_free(f->last_error_obj);
>      g_free(f);
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index 11c2120..3e47a20 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -79,5 +79,7 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
>                            off_t pos);
>  
>  QIOChannel *qemu_file_get_ioc(QEMUFile *file);
> +int qemu_file_put_fd(QEMUFile *f, int fd);
> +int qemu_file_get_fd(QEMUFile *f);
>  
>  #endif
> diff --git a/migration/trace-events b/migration/trace-events
> index 5356fb5..345506b 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -88,6 +88,8 @@ put_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
>  
>  # qemu-file.c
>  qemu_file_fclose(void) ""
> +qemu_file_put_fd(const char *name, int fd, int ret) "ioc %s, fd %d -> status %d"
> +qemu_file_get_fd(const char *name, int fd) "ioc %s -> fd %d"
>  
>  # ram.c
>  get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


