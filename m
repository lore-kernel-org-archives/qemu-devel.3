Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF272F9D0D6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCg1I-0002kv-TL; Tue, 14 Apr 2026 11:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wCg1H-0002kj-WD
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:49:44 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wCg1F-0007LR-RG
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:49:43 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4F2636A914;
 Tue, 14 Apr 2026 15:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776181780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JuABFH/YdCvraeXYX7tHVSOPi3HjUeD7bFQHpxxpxHY=;
 b=rsgtrsHUAmtcwudAueO7svWVe9uSUiq2NofZ4nsrcHc8jGw/4xE7fBs5LiTt4E7DGaasn2
 8ZrlIKHFHcKLZ5QMTvZXYXN4f2EXcxS3maXvvMen1/0mwujorJx53LfhLKMmf+D0+FCq1W
 +4u2XfEML6xdTHqICoLMSj+4F6E3ntE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776181780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JuABFH/YdCvraeXYX7tHVSOPi3HjUeD7bFQHpxxpxHY=;
 b=NX3AbKL9Y/TUvjfKphFncrlzU6XTdd3ahJiuMla1dIgYlUwQyeE26MUDYBhc1J8rtBmiWQ
 byd4YCK/I2nTVcCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hOrhlE5i;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+XeVD1zS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776181779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JuABFH/YdCvraeXYX7tHVSOPi3HjUeD7bFQHpxxpxHY=;
 b=hOrhlE5ioBTmBV+nWb3XLDG9xfFTUeX2QObDbFTuehPsr5ym8R/4Fk35DgxvG+p4sj1RwU
 oxk0JnpPMWpaAv7ahM/ySk0RG/ZvETRBsxFZUAH2wasFBOAtaYcIPASnZYZ40I+i1Bw9Uc
 BbKHp0TK7GufV8aX6ua15ahq+lhtA2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776181779;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JuABFH/YdCvraeXYX7tHVSOPi3HjUeD7bFQHpxxpxHY=;
 b=+XeVD1zSlU1gvvACw6G1QMMWNSbNpvQevRIMr7qEuvJirohysTyQ2PRJkTrUKYfvKOnHq1
 QtrZTKecqMlR0QDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1F074B50C;
 Tue, 14 Apr 2026 15:49:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aBIqLBJi3mkpTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 14 Apr 2026 15:49:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com, junjie.cao@intel.com
Subject: Re: [PATCH v3 1/4] io/channel: introduce qio_channel_pread{v,
 }_all{, _eof}()
In-Reply-To: <20260413214549.926435-2-junjie.cao@intel.com>
References: <20260413214549.926435-1-junjie.cao@intel.com>
 <20260413214549.926435-2-junjie.cao@intel.com>
Date: Tue, 14 Apr 2026 12:49:36 -0300
Message-ID: <87h5pdzgmn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4F2636A914
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Junjie Cao <junjie.cao@intel.com> writes:

> qio_channel_pread() and qio_channel_preadv() perform a single
> positioned read and may return a short result.  Callers that need all
> bytes currently have to open-code a retry loop or simply treat a short
> read as an error.
>
> Introduce four new helpers following the existing read_all / readv_all
> pattern:
>
>   qio_channel_preadv_all_eof()  -- retry loop; returns 1 on success,
>                                     0 on clean EOF, -1 on error.
>   qio_channel_preadv_all()      -- wraps _eof; treats early EOF as
>                                     error; returns 0 / -1.
>   qio_channel_pread_all_eof()   -- single-buffer convenience wrapper
>                                     around preadv_all_eof().
>   qio_channel_pread_all()       -- single-buffer convenience wrapper
>                                     around preadv_all().
>
> These advance the file offset internally after each partial read.
> All four are marked coroutine_mixed_fn, consistent with the existing
> _all helpers.
>
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>  include/io/channel.h | 92 ++++++++++++++++++++++++++++++++++++++++++++
>  io/channel.c         | 91 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 183 insertions(+)
>
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 1b02350437..47af409ede 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -634,6 +634,98 @@ ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
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
> + * Reads @iov, possibly blocking or (if the channel is non-blocking)
> + * yielding from the current coroutine multiple times until the entire
> + * content is read.  If end-of-file occurs immediately it is not an
> + * error, but if it occurs after data has been read it will return
> + * an error rather than a short-read.  Otherwise behaves as
> + * qio_channel_preadv().
> + *
> + * Returns: 1 if all bytes were read, 0 if end-of-file occurs
> + *          without data, or -1 on error
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
> + * Reads @iov, possibly blocking or (if the channel is non-blocking)
> + * yielding from the current coroutine multiple times until the entire
> + * content is read.  If end-of-file occurs before all requested data
> + * has been read, an error will be reported.  Otherwise behaves as
> + * qio_channel_preadv().
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
> + * qio_channel_pread_all_eof:
> + * @ioc: the channel object
> + * @buf: the memory region to read data into
> + * @buflen: the number of bytes to read into @buf
> + * @offset: the starting offset in the channel to read from
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Reads @buflen bytes, possibly blocking or (if the channel is
> + * non-blocking) yielding from the current coroutine multiple times
> + * until the entire content is read.  If end-of-file occurs
> + * immediately it is not an error, but if it occurs after data has
> + * been read it will return an error rather than a short-read.
> + * Otherwise behaves as qio_channel_pread().
> + *
> + * Returns: 1 if all bytes were read, 0 if end-of-file occurs
> + *          without data, or -1 on error
> + */
> +int coroutine_mixed_fn qio_channel_pread_all_eof(QIOChannel *ioc,
> +                                                 void *buf,
> +                                                 size_t buflen,
> +                                                 off_t offset,
> +                                                 Error **errp);
> +
> +/**
> + * qio_channel_pread_all:
> + * @ioc: the channel object
> + * @buf: the memory region to read data into
> + * @buflen: the number of bytes to read into @buf
> + * @offset: the starting offset in the channel to read from
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Reads @buflen bytes, possibly blocking or (if the channel is
> + * non-blocking) yielding from the current coroutine multiple times
> + * until the entire content is read.  If end-of-file occurs before
> + * all requested data has been read, an error will be reported.
> + * Otherwise behaves as qio_channel_pread().
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
> index cc02d997a4..52c1abfcbc 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -507,6 +507,97 @@ ssize_t qio_channel_pread(QIOChannel *ioc, void *buf, size_t buflen,
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
> +int coroutine_mixed_fn qio_channel_pread_all_eof(QIOChannel *ioc,
> +                                                 void *buf,
> +                                                 size_t buflen,
> +                                                 off_t offset,
> +                                                 Error **errp)
> +{
> +    struct iovec iov = { .iov_base = buf, .iov_len = buflen };
> +    return qio_channel_preadv_all_eof(ioc, &iov, 1, offset, errp);
> +}
> +
> +int coroutine_mixed_fn qio_channel_pread_all(QIOChannel *ioc,
> +                                             void *buf,
> +                                             size_t buflen,
> +                                             off_t offset,
> +                                             Error **errp)
> +{
> +    struct iovec iov = { .iov_base = buf, .iov_len = buflen };
> +    return qio_channel_preadv_all(ioc, &iov, 1, offset, errp);
> +}
> +
>  int qio_channel_shutdown(QIOChannel *ioc,
>                           QIOChannelShutdown how,
>                           Error **errp)

Reviewed-by: Fabiano Rosas <farosas@suse.de>

