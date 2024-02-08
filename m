Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C22C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 12:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY3pc-0002Z2-CG; Thu, 08 Feb 2024 07:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rY3pa-0002Ys-TM
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 07:48:42 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rY3pV-0002rp-D4
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 07:48:42 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0DF811FCEB;
 Thu,  8 Feb 2024 12:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707396516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0gKpS8s6UffzZvH6c7qDzXKotViwwdS4jaRsd7zTs0g=;
 b=1iLW4tTKr2KGiRQUZzP9Dtq/Y4IDFVR9kOGQpanoLmZo7rXZk28pROOG3S7E+hBOTjMG5+
 SXPkZ2fLOfeG3HgboIK9jaxB9zFPVgcyAnKYCWFsB8x7QzosDO70jXEpOC7mMG+AfmlqQk
 Ou1tci6mkCqFhv5GG78qQhsqy8zIKxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707396516;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0gKpS8s6UffzZvH6c7qDzXKotViwwdS4jaRsd7zTs0g=;
 b=WSYrM0hD9jm9eEC9MkevbCXJwixLFw4FOkCms7j40mpoGSMJ7U8e45VA5nX99QnGMI6ZM3
 KcGr8gnOUq5OmLDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707396516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0gKpS8s6UffzZvH6c7qDzXKotViwwdS4jaRsd7zTs0g=;
 b=1iLW4tTKr2KGiRQUZzP9Dtq/Y4IDFVR9kOGQpanoLmZo7rXZk28pROOG3S7E+hBOTjMG5+
 SXPkZ2fLOfeG3HgboIK9jaxB9zFPVgcyAnKYCWFsB8x7QzosDO70jXEpOC7mMG+AfmlqQk
 Ou1tci6mkCqFhv5GG78qQhsqy8zIKxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707396516;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0gKpS8s6UffzZvH6c7qDzXKotViwwdS4jaRsd7zTs0g=;
 b=WSYrM0hD9jm9eEC9MkevbCXJwixLFw4FOkCms7j40mpoGSMJ7U8e45VA5nX99QnGMI6ZM3
 KcGr8gnOUq5OmLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D0FF1326D;
 Thu,  8 Feb 2024 12:48:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XQQSFaPNxGVATAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 08 Feb 2024 12:48:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, peterx@redhat.com, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 2/2] migration/multifd: Drop registered_yank
In-Reply-To: <20240208035126.370620-3-peterx@redhat.com>
References: <20240208035126.370620-1-peterx@redhat.com>
 <20240208035126.370620-3-peterx@redhat.com>
Date: Thu, 08 Feb 2024 09:48:33 -0300
Message-ID: <871q9nceam.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1iLW4tTK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WSYrM0hD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 0DF811FCEB
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
>
> With a clear definition of p->c protocol, where we only set it up if the
> channel is fully established (TLS or non-TLS), registered_yank boolean will
> have equal meaning of "p->c != NULL".
>
> Drop registered_yank by checking p->c instead.
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/multifd.h | 2 --
>  migration/multifd.c | 7 +++----
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 8a1cad0996..b3fe27ae93 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -78,8 +78,6 @@ typedef struct {
>      bool tls_thread_created;
>      /* communication channel */
>      QIOChannel *c;
> -    /* is the yank function registered */
> -    bool registered_yank;
>      /* packet allocated len */
>      uint32_t packet_len;
>      /* guest page size */
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 4a85a6b7b3..278453cf84 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -648,11 +648,11 @@ static int multifd_send_channel_destroy(QIOChannel *send)
>  
>  static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
>  {
> -    if (p->registered_yank) {
> +    if (p->c) {
>          migration_ioc_unregister_yank(p->c);
> +        multifd_send_channel_destroy(p->c);

At socket_send_channel_destroy the clean up of outgoing_args.saddr will
now be skipped. The failure at multifd_new_send_channel_async might have
been due to TLS, in which case all of plain socket setup will have
happened properly.

> +        p->c = NULL;
>      }
> -    multifd_send_channel_destroy(p->c);
> -    p->c = NULL;
>      qemu_sem_destroy(&p->sem);
>      qemu_sem_destroy(&p->sem_sync);
>      g_free(p->name);
> @@ -932,7 +932,6 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>      qio_channel_set_delay(ioc, false);
>  
>      migration_ioc_register_yank(ioc);
> -    p->registered_yank = true;
>      /* Setup p->c only if the channel is completely setup */
>      p->c = ioc;

