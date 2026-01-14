Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D9BD29FF7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg02S-0006iQ-DO; Wed, 14 Jan 2026 07:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vg01x-0006We-QZ
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:31:23 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vg01w-0002pQ-8s
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:31:21 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BAE4A5C3F9;
 Wed, 14 Jan 2026 12:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768393878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ur64gQc9pvA//VWm344o9jy/CbkQ/T3sUwCJur5Gt1c=;
 b=LA5WLf8dymWraWd9JJR6XlHbF0YISgwVjfG1dTbqqrLY1gIoSP2NZwW7uKeX060nCuqgTf
 m+PZy0FdNr5EEWNY93reA0oQHq0tAw71Qp/r5afyDKpHlCSZm/Evw0UXsDB7e0WHKAv4Eq
 1qtOHYkVSIKgs5hEKRqHZ+tSg/SzKM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768393878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ur64gQc9pvA//VWm344o9jy/CbkQ/T3sUwCJur5Gt1c=;
 b=Gytr2VwL0X+pzrpifmPY7kPrUp1/sxf0arESyYzxDy5tSYeZ0J6wPxRoUr/JaWsI/D2UO6
 0V/22P+EBzL5kOBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LA5WLf8d;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Gytr2VwL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768393878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ur64gQc9pvA//VWm344o9jy/CbkQ/T3sUwCJur5Gt1c=;
 b=LA5WLf8dymWraWd9JJR6XlHbF0YISgwVjfG1dTbqqrLY1gIoSP2NZwW7uKeX060nCuqgTf
 m+PZy0FdNr5EEWNY93reA0oQHq0tAw71Qp/r5afyDKpHlCSZm/Evw0UXsDB7e0WHKAv4Eq
 1qtOHYkVSIKgs5hEKRqHZ+tSg/SzKM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768393878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ur64gQc9pvA//VWm344o9jy/CbkQ/T3sUwCJur5Gt1c=;
 b=Gytr2VwL0X+pzrpifmPY7kPrUp1/sxf0arESyYzxDy5tSYeZ0J6wPxRoUr/JaWsI/D2UO6
 0V/22P+EBzL5kOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 320A83EA63;
 Wed, 14 Jan 2026 12:31:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jj90OJWMZ2kXTwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Jan 2026 12:31:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, dtalexundeer@yandex-team.ru,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: Re: [PATCH 2/5] qemu-file: qemu_file_get_fd(): fail if no expected
 fd come
In-Reply-To: <20260114064710.176268-3-vsementsov@yandex-team.ru>
References: <20260114064710.176268-1-vsementsov@yandex-team.ru>
 <20260114064710.176268-3-vsementsov@yandex-team.ru>
Date: Wed, 14 Jan 2026 09:31:15 -0300
Message-ID: <87v7h4nzos.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.51 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; BAYES_HAM(-0.00)[28.78%]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BAE4A5C3F9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> In _put() we don't actually allow send a service byte
> without fd. So on _get() it's unexpected. Let's be strict.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/qemu-file.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 4b5a409a80..02f30c1c21 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -389,28 +389,34 @@ int qemu_file_get_fd(QEMUFile *f)
>  {
>      int fd = -1;
>      FdEntry *fde;
> +    Error *err = NULL;
>  
>      if (!f->can_pass_fd) {
> -        Error *err = NULL;
>          error_setg(&err, "%s does not support fd passing", f->ioc->name);
> -        error_report_err(error_copy(err));
> -        qemu_file_set_error_obj(f, -EIO, err);
> -        goto out;
> +        goto fail;
>      }
>  
>      /* Force the dummy byte and its fd passenger to appear. */
>      qemu_peek_byte(f, 0);
>  
>      fde = QTAILQ_FIRST(&f->fds);
> -    if (fde) {
> -        qemu_get_byte(f);       /* Drop the dummy byte */
> -        fd = fde->fd;
> -        QTAILQ_REMOVE(&f->fds, fde, entry);
> -        g_free(fde);
> +    if (!fde) {
> +        error_setg(&err, "%s no FD come with service byte", f->ioc->name);
> +        goto fail;
>      }
> -out:
> +
> +    qemu_get_byte(f);       /* Drop the dummy byte */
> +    fd = fde->fd;
> +    QTAILQ_REMOVE(&f->fds, fde, entry);
> +    g_free(fde);
> +
>      trace_qemu_file_get_fd(f->ioc->name, fd);
>      return fd;
> +
> +fail:
> +    error_report_err(error_copy(err));
> +    qemu_file_set_error_obj(f, -EIO, err);
> +    return -1;
>  }
>  
>  /** Closes the file

Reviewed-by: Fabiano Rosas <farosas@suse.de>

