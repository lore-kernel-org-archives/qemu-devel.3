Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE58BF9D0D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCg5e-0003zN-Ad; Tue, 14 Apr 2026 11:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wCg5c-0003zF-RV
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:54:12 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wCg5b-00007F-20
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:54:12 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 291AF5BD63;
 Tue, 14 Apr 2026 15:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776182049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x0JI6Yi1cNU64aP7T/QtmVs8UEH86dtaFxrBG6njszo=;
 b=zK0brRpgH6fsL8YnGH/iCtRmTpjYSbSqAvJU0JsYVhFWoHRAevZ2atE8aeePIQLt+DmtXY
 QsX6pXKKcyvpF+oFHFVJSFQk9wmooYuzBYJ70l4OFPQqq0dtrDQsSXndbq3YoYFY97TZip
 QT4chq//vVf5M8y6ZW9SHbmlsJKyzOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776182049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x0JI6Yi1cNU64aP7T/QtmVs8UEH86dtaFxrBG6njszo=;
 b=Xz+Iyeoa77XGRJAD8UMd5yW9dfVsviBCVRnUJIE3qMIo1xAIYBxNEceKcN4OwRGjqk4lzw
 8QHweVeMo8Tb9DDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zK0brRpg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Xz+Iyeoa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776182049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x0JI6Yi1cNU64aP7T/QtmVs8UEH86dtaFxrBG6njszo=;
 b=zK0brRpgH6fsL8YnGH/iCtRmTpjYSbSqAvJU0JsYVhFWoHRAevZ2atE8aeePIQLt+DmtXY
 QsX6pXKKcyvpF+oFHFVJSFQk9wmooYuzBYJ70l4OFPQqq0dtrDQsSXndbq3YoYFY97TZip
 QT4chq//vVf5M8y6ZW9SHbmlsJKyzOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776182049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x0JI6Yi1cNU64aP7T/QtmVs8UEH86dtaFxrBG6njszo=;
 b=Xz+Iyeoa77XGRJAD8UMd5yW9dfVsviBCVRnUJIE3qMIo1xAIYBxNEceKcN4OwRGjqk4lzw
 8QHweVeMo8Tb9DDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B92424B512;
 Tue, 14 Apr 2026 15:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1VgfIiBj3mmaUgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 14 Apr 2026 15:54:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com, junjie.cao@intel.com
Subject: Re: [PATCH v3 2/4] io/channel: introduce qio_channel_pwrite{v, }_all()
In-Reply-To: <20260413214549.926435-3-junjie.cao@intel.com>
References: <20260413214549.926435-1-junjie.cao@intel.com>
 <20260413214549.926435-3-junjie.cao@intel.com>
Date: Tue, 14 Apr 2026 12:54:06 -0300
Message-ID: <87eckhzgf5.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email,intel.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 291AF5BD63
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> Add positioned write helpers that retry on short writes, matching
> the pread_all family from the previous patch.
>
>   qio_channel_pwritev_all()  -- retry loop; returns 0 on success,
>                                  -1 on error.
>   qio_channel_pwrite_all()   -- single-buffer convenience wrapper.
>
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>  include/io/channel.h | 41 +++++++++++++++++++++++++++++++++++++
>  io/channel.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
>
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 47af409ede..287d10cd6f 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -598,6 +598,47 @@ ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
>  ssize_t qio_channel_pwrite(QIOChannel *ioc, void *buf, size_t buflen,
>                             off_t offset, Error **errp);
>  
> +/**
> + * qio_channel_pwritev_all:
> + * @ioc: the channel object
> + * @iov: the array of memory regions to write data from
> + * @niov: the length of the @iov array
> + * @offset: the starting offset in the channel to write to
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Writes @iov, possibly blocking or (if the channel is non-blocking)
> + * yielding from the current coroutine multiple times until the entire
> + * content is written.  Otherwise behaves as qio_channel_pwritev().
> + *
> + * Returns: 0 if all bytes were written, or -1 on error
> + */
> +int coroutine_mixed_fn qio_channel_pwritev_all(QIOChannel *ioc,
> +                                               const struct iovec *iov,
> +                                               size_t niov,
> +                                               off_t offset,
> +                                               Error **errp);
> +
> +/**
> + * qio_channel_pwrite_all:
> + * @ioc: the channel object
> + * @buf: the memory region to write data from
> + * @buflen: the number of bytes to write from @buf
> + * @offset: the starting offset in the channel to write to
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Writes @buflen bytes from @buf, possibly blocking or (if the
> + * channel is non-blocking) yielding from the current coroutine
> + * multiple times until the entire content is written.  Otherwise
> + * behaves as qio_channel_pwrite().
> + *
> + * Returns: 0 if all bytes were written, or -1 on error
> + */
> +int coroutine_mixed_fn qio_channel_pwrite_all(QIOChannel *ioc,
> +                                              const void *buf,
> +                                              size_t buflen,
> +                                              off_t offset,
> +                                              Error **errp);
> +
>  /**
>   * qio_channel_preadv
>   * @ioc: the channel object
> diff --git a/io/channel.c b/io/channel.c
> index 52c1abfcbc..2853dadb68 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -478,6 +478,54 @@ ssize_t qio_channel_pwrite(QIOChannel *ioc, void *buf, size_t buflen,
>      return qio_channel_pwritev(ioc, &iov, 1, offset, errp);
>  }
>  
> +int coroutine_mixed_fn qio_channel_pwritev_all(QIOChannel *ioc,
> +                                               const struct iovec *iov,
> +                                               size_t niov,
> +                                               off_t offset,
> +                                               Error **errp)
> +{
> +    int ret = -1;
> +    struct iovec *local_iov = g_new(struct iovec, niov);
> +    struct iovec *local_iov_head = local_iov;
> +    unsigned int nlocal_iov = niov;
> +
> +    nlocal_iov = iov_copy(local_iov, nlocal_iov,
> +                          iov, niov,
> +                          0, iov_size(iov, niov));
> +
> +    while (nlocal_iov > 0) {
> +        ssize_t len;
> +
> +        len = qio_channel_pwritev(ioc, local_iov, nlocal_iov, offset, errp);
> +
> +        if (len == QIO_CHANNEL_ERR_BLOCK) {
> +            qio_channel_wait_cond(ioc, G_IO_OUT);
> +            continue;
> +        }
> +        if (len < 0) {
> +            goto cleanup;
> +        }
> +
> +        offset += len;
> +        iov_discard_front(&local_iov, &nlocal_iov, len);
> +    }
> +
> +    ret = 0;
> + cleanup:
> +    g_free(local_iov_head);
> +    return ret;
> +}
> +
> +int coroutine_mixed_fn qio_channel_pwrite_all(QIOChannel *ioc,
> +                                              const void *buf,
> +                                              size_t buflen,
> +                                              off_t offset,
> +                                              Error **errp)
> +{
> +    struct iovec iov = { .iov_base = (char *)buf, .iov_len = buflen };
> +    return qio_channel_pwritev_all(ioc, &iov, 1, offset, errp);
> +}
> +
>  ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
>                             size_t niov, off_t offset, Error **errp)
>  {

Reviewed-by: Fabiano Rosas <farosas@suse.de>

