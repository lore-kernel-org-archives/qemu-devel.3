Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1447DCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 17:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2CRZ-0003Dm-L0; Fri, 26 Sep 2025 13:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v2CRM-00037a-4M
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 13:41:05 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v2CRD-00080v-S8
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 13:41:03 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9AC6025CD7;
 Fri, 26 Sep 2025 17:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758908441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ujrYxIP8ObvI0fcBgbOxP4l0Jcb+hP+dtA+e48f5054=;
 b=xtk8k/JPKkQjTKNElj30CDCSmMETULHzQfhsY/+8GMg6JGJZdHjlevu8y7O/BWPBi3qDwq
 JcJTuc7DZ3S/QlhA7R62yjffLjCDlZS2IdMn/B+5ZBOE9mbpIF3HUhtuu2F+EP5n2R2K5W
 zGtWUCXEPe37SNft5ujdCWl1CtpZ64k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758908441;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ujrYxIP8ObvI0fcBgbOxP4l0Jcb+hP+dtA+e48f5054=;
 b=4lTf5Zd0+xZJaXaqBWosBEBGXQgcqBfqcwa1fq8Jaw/OyMXXNTLo+6mc9TCI5ugnJbfmsg
 P2PCw+wNiijGKEBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="xtk8k/JP";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4lTf5Zd0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758908441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ujrYxIP8ObvI0fcBgbOxP4l0Jcb+hP+dtA+e48f5054=;
 b=xtk8k/JPKkQjTKNElj30CDCSmMETULHzQfhsY/+8GMg6JGJZdHjlevu8y7O/BWPBi3qDwq
 JcJTuc7DZ3S/QlhA7R62yjffLjCDlZS2IdMn/B+5ZBOE9mbpIF3HUhtuu2F+EP5n2R2K5W
 zGtWUCXEPe37SNft5ujdCWl1CtpZ64k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758908441;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ujrYxIP8ObvI0fcBgbOxP4l0Jcb+hP+dtA+e48f5054=;
 b=4lTf5Zd0+xZJaXaqBWosBEBGXQgcqBfqcwa1fq8Jaw/OyMXXNTLo+6mc9TCI5ugnJbfmsg
 P2PCw+wNiijGKEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1955F1386E;
 Fri, 26 Sep 2025 17:40:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ns53MxjQ1mgGKQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Sep 2025 17:40:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] migration/multifd/tls: Cleanup BYE message processing
 on sender side
In-Reply-To: <20250925201601.290546-1-peterx@redhat.com>
References: <20250925201601.290546-1-peterx@redhat.com>
Date: Fri, 26 Sep 2025 14:40:37 -0300
Message-ID: <87ikh5w1re.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 9AC6025CD7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> This patch is a trivial cleanup to the BYE messages on the multifd sender
> side.  It could also be a fix, but since we do not have a solid clue,
> taking this as a cleanup only.
>
> One trivial concern is, migration_tls_channel_end() might be unsafe to be
> invoked in the migration thread if migration is not successful, because
> when failed / cancelled we do not know whether the multifd sender threads
> can be writting to the channels, while GnuTLS library (when it's a TLS
> channel) logically doesn't support concurrent writes.
>
> When at it, cleanup on a few things.  What changed:
>
>   - Introduce a helper to do graceful shutdowns with rich comment, hiding
>     the details
>
>   - Only send bye() iff migration succeeded, skip if it failed / cancelled
>
>   - Detect TLS channel using channel type rather than thread created flags
>
>   - Move the loop into the existing one that will close the channels, but
>     do graceful shutdowns before channel shutdowns
>
>   - local_err seems to have been leaked if set, fix it along the way
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/multifd.c | 65 ++++++++++++++++++++++++---------------------
>  1 file changed, 34 insertions(+), 31 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b255778855..98873cee74 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -439,6 +439,39 @@ static void multifd_send_set_error(Error *err)
>      }
>  }
>  
> +/*
> + * Gracefully shutdown IOChannels. Only needed for successful migrations on
> + * top of TLS channels.  Otherwise it is same to qio_channel_shutdown().
> + *
> + * A successful migration also guarantees multifd sender threads are

s/also//

> + * properly flushed and halted.  It is only safe to send BYE in the
> + * migration thread here when we know there's no other thread writting to

s/writting/writing/

> + * the channel, because GnuTLS doesn't support concurrent writers.
> + */
> +static void migration_ioc_shutdown_gracefully(QIOChannel *ioc)

Reviewed-by: Fabiano Rosas <farosas@suse.de>

