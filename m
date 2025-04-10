Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB398C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 19:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2xxC-0003fi-Sf; Thu, 10 Apr 2025 15:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u2xxB-0003fT-3c
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 15:52:49 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u2xx9-0006vS-47
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 15:52:48 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D2982116A;
 Thu, 10 Apr 2025 19:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744314765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5d2G4DBeuxDoXFNOhHrKGl+xmEH0uvr9hvSPkQvYZZU=;
 b=Zva2LSt/4EFC63ieeT4Dk+G2SHqBZfiBe4j5yTkT6EjrHzKB8ytVnSEfib8wlmgpyTC7Su
 Pu0B53h8hL1XE811j0PFgOvklGzlAAF+lPZNlhsrY8r/nWE70DAYW83UtZcN0leFF4P0GF
 hpZ4L/UvHxmQa/H6rjbFCQfgmmHhqKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744314765;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5d2G4DBeuxDoXFNOhHrKGl+xmEH0uvr9hvSPkQvYZZU=;
 b=ulBcRe8C/K30vTgYnOnPxU6Rqsf7BNHJMjqjfw/L/sQkBuWwZzffA5r/detI4sW1hQ5eUY
 eg7xUfIguiLt41DQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Zva2LSt/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ulBcRe8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744314765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5d2G4DBeuxDoXFNOhHrKGl+xmEH0uvr9hvSPkQvYZZU=;
 b=Zva2LSt/4EFC63ieeT4Dk+G2SHqBZfiBe4j5yTkT6EjrHzKB8ytVnSEfib8wlmgpyTC7Su
 Pu0B53h8hL1XE811j0PFgOvklGzlAAF+lPZNlhsrY8r/nWE70DAYW83UtZcN0leFF4P0GF
 hpZ4L/UvHxmQa/H6rjbFCQfgmmHhqKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744314765;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5d2G4DBeuxDoXFNOhHrKGl+xmEH0uvr9hvSPkQvYZZU=;
 b=ulBcRe8C/K30vTgYnOnPxU6Rqsf7BNHJMjqjfw/L/sQkBuWwZzffA5r/detI4sW1hQ5eUY
 eg7xUfIguiLt41DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99439132D8;
 Thu, 10 Apr 2025 19:52:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4tWiFYwh+GfPWwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Apr 2025 19:52:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Marco Cavenati <Marco.Cavenati@eurecom.fr>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>, Prasad Pandit
 <ppandit@redhat.com>
Subject: Re: [PATCH] migration: add FEATURE_SEEKABLE to QIOChannelBlock
In-Reply-To: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
Date: Thu, 10 Apr 2025 16:52:41 -0300
Message-ID: <87jz7rhjzq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 2D2982116A
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Marco Cavenati <Marco.Cavenati@eurecom.fr> writes:

> Enable the use of the mapped-ram migration feature with savevm/loadvm
> snapshots by adding the QIO_CHANNEL_FEATURE_SEEKABLE feature to
> QIOChannelBlock. Implement io_preadv and io_pwritev methods to provide
> positioned I/O capabilities that don't modify the channel's position
> pointer.

We'll need to add the infrastructure to reject multifd and direct-io
before this. The rest of the capabilities should not affect mapped-ram,
so it's fine (for now) if we don't honor them.

What about zero page handling? Mapped-ram doesn't send zero pages
because the file will always have zeroes in it and the migration
destination is guaranteed to not have been running previously. I believe
loading a snapshot in a VM that's already been running would leave stale
data in the guest's memory.

>
> Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
> ---
> Hello, 
> Please note that this depends on my previous fix [0] (which has already
> been reviewed) in order to work.
>
> The code in this patch is inspired by commit
> 0478b030fa2530cbbfc4d6432e8e39a16d06865b that adds the same feature to
> QIOChannelFile.
>
> Thank you,
> Regards
> Marco
>
> [0] [PATCH] migration: fix SEEK_CUR offset calculation in
> qio_channel_block_seek https://lore.kernel.org/all/20250326162230.3323199-1-Marco.Cavenati@eurecom.fr/t/#u
> ---
>  migration/channel-block.c | 48 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/migration/channel-block.c b/migration/channel-block.c
> index fff8d87094..741cf6f31b 100644
> --- a/migration/channel-block.c
> +++ b/migration/channel-block.c
> @@ -30,6 +30,7 @@ qio_channel_block_new(BlockDriverState *bs)
>      QIOChannelBlock *ioc;
>  
>      ioc = QIO_CHANNEL_BLOCK(object_new(TYPE_QIO_CHANNEL_BLOCK));
> +    qio_channel_set_feature(QIO_CHANNEL(ioc), QIO_CHANNEL_FEATURE_SEEKABLE);
>  
>      bdrv_ref(bs);
>      ioc->bs = bs;
> @@ -96,6 +97,49 @@ qio_channel_block_writev(QIOChannel *ioc,
>      return qiov.size;
>  }
>  
> +#ifdef CONFIG_PREADV
> +static ssize_t
> +qio_channel_block_preadv(QIOChannel *ioc,
> +                         const struct iovec *iov,
> +                         size_t niov,
> +                         off_t offset,
> +                         Error **errp)
> +{
> +    QIOChannelBlock *bioc = QIO_CHANNEL_BLOCK(ioc);
> +    QEMUIOVector qiov;
> +    int ret;
> +
> +    qemu_iovec_init_external(&qiov, (struct iovec *)iov, niov);
> +    ret = bdrv_readv_vmstate(bioc->bs, &qiov, offset);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "bdrv_readv_vmstate failed");
> +        return -1;
> +    }
> +
> +    return qiov.size;
> +}
> +
> +static ssize_t
> +qio_channel_block_pwritev(QIOChannel *ioc,
> +                          const struct iovec *iov,
> +                          size_t niov,
> +                          off_t offset,
> +                          Error **errp)
> +{
> +    QIOChannelBlock *bioc = QIO_CHANNEL_BLOCK(ioc);
> +    QEMUIOVector qiov;
> +    int ret;
> +
> +    qemu_iovec_init_external(&qiov, (struct iovec *)iov, niov);
> +    ret = bdrv_writev_vmstate(bioc->bs, &qiov, offset);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "bdrv_writev_vmstate failed");
> +        return -1;
> +    }
> +
> +    return qiov.size;
> +}
> +#endif /* CONFIG_PREADV */
>  
>  static int
>  qio_channel_block_set_blocking(QIOChannel *ioc,
> @@ -177,6 +221,10 @@ qio_channel_block_class_init(ObjectClass *klass,
>      ioc_klass->io_writev = qio_channel_block_writev;
>      ioc_klass->io_readv = qio_channel_block_readv;
>      ioc_klass->io_set_blocking = qio_channel_block_set_blocking;
> +#ifdef CONFIG_PREADV
> +    ioc_klass->io_preadv = qio_channel_block_preadv;
> +    ioc_klass->io_pwritev = qio_channel_block_pwritev;
> +#endif
>      ioc_klass->io_seek = qio_channel_block_seek;
>      ioc_klass->io_close = qio_channel_block_close;
>      ioc_klass->io_set_aio_fd_handler = qio_channel_block_set_aio_fd_handler;

