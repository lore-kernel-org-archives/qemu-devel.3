Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CAFE77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZVV-0001v0-41; Fri, 06 Dec 2024 09:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJZVT-0001uq-Jy
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:40:35 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJZVR-0005eb-SM
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:40:35 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 08D37210EE;
 Fri,  6 Dec 2024 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733496031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WSZyBS6dexqOYOgjdV++B1+w/x0w0WKhhGs+Fm0LvUE=;
 b=Jhr5r1VXtF293d05RifjAKj0+Zlh7vgh/afLNQXBW180sXOuSioWYvwBoMOh6Xo+PEC9qZ
 mq8Vj94F7D37gmxufezmjBaDFVgADowaNI//fU91OEyDfNm6HfCtMa/bjB2V2sUTdsKk5f
 IfFq0BCyanH0WsRlqdvFCaONupqsIUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733496031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WSZyBS6dexqOYOgjdV++B1+w/x0w0WKhhGs+Fm0LvUE=;
 b=eXi1XSr9W8dHdmHqY6fDGYk7X53VVpXL0QU5VjYVY4k8TIkPjC+IPZcMzl+arCLVuFgN+Y
 HYoEICvC9oPAi1Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733496031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WSZyBS6dexqOYOgjdV++B1+w/x0w0WKhhGs+Fm0LvUE=;
 b=Jhr5r1VXtF293d05RifjAKj0+Zlh7vgh/afLNQXBW180sXOuSioWYvwBoMOh6Xo+PEC9qZ
 mq8Vj94F7D37gmxufezmjBaDFVgADowaNI//fU91OEyDfNm6HfCtMa/bjB2V2sUTdsKk5f
 IfFq0BCyanH0WsRlqdvFCaONupqsIUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733496031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WSZyBS6dexqOYOgjdV++B1+w/x0w0WKhhGs+Fm0LvUE=;
 b=eXi1XSr9W8dHdmHqY6fDGYk7X53VVpXL0QU5VjYVY4k8TIkPjC+IPZcMzl+arCLVuFgN+Y
 HYoEICvC9oPAi1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 859B7138A7;
 Fri,  6 Dec 2024 14:40:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S9sYE94MU2dHbQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Dec 2024 14:40:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, peterx@redhat.com,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, Alex
 Williamson <alex.williamson@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 7/7] migration/multifd: Document the reason to sync
 for save_setup()
In-Reply-To: <20241206005834.1050905-8-peterx@redhat.com>
References: <20241206005834.1050905-1-peterx@redhat.com>
 <20241206005834.1050905-8-peterx@redhat.com>
Date: Fri, 06 Dec 2024 11:40:27 -0300
Message-ID: <87r06kc1t0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> It's not straightforward to see why src QEMU needs to sync multifd during
> setup() phase.  After all, there's no page queued at that point.
>
> For old QEMUs, there's a solid reason: EOS requires it to work.  While it's
> clueless on the new QEMUs which do not take EOS message as sync requests.
>
> One will figure that out only when this is conditionally removed.  In fact,
> the author did try it out.  Logically we could still avoid doing this on
> new machine types, however that needs a separate compat field and that can
> be an overkill in some trivial overhead in setup() phase.
>
> Let's instead document it completely, to avoid someone else tries this
> again and do the debug one more time, or anyone confused on why this ever
> existed.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/ram.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 5d4bdefe69..ddee703585 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3036,6 +3036,33 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>          migration_ops->ram_save_target_page = ram_save_target_page_legacy;
>      }
>  
> +    /*
> +     * This operation is unfortunate..
> +     *
> +     * For legacy QEMUs using per-section sync
> +     * =======================================
> +     *
> +     * This must exist because the EOS below requires the SYNC messages
> +     * per-channel to work.
> +     *
> +     * For modern QEMUs using per-round sync
> +     * =====================================
> +     *
> +     * Logically this sync is not needed (because we know there's nothing
> +     * in the multifd queue yet!).

This is a bit misleading because even today we could split the
multifd_ram_flush_and_sync() into _flush and _sync (haven't I seen a
patch doing this somewhere? Maybe from Maciej...) and call just the
_sync here, which is unrelated to any multifd queue.

I think we shouldn't tie "sync" with "wait for multifd threads to finish
sending their data (a kind of flush)" as this implies. The sync is as
much making sure the threads are ready to receive as it is making sure
the data is received in order with relation to ram scanning rounds.

IOW, the local sync is what ensures multifd send threads are flushed
while this code deals with the sync of src&dst threads, which is "just"
a synchronization point between the two QEMUs.

> However as a side effect, this makes
> +     * sure the dest side won't receive any data before it properly reaches
> +     * ram_load_precopy().

I'm not sure it's a side-effect. It seems deliberate to me, seeing that
multifd usually does its own synchronization. For instance, on the send
side we also need some sync to make sure ram.c doesn't send data to
multifd send threads that are not ready yet (i.e. the wait on
channels_ready at the start of multifd_send()).

> +     *
> +     * Without this sync, src QEMU can send data too soon so that dest may
> +     * not have been ready to receive it (e.g., rb->receivedmap may be
> +     * uninitialized, for example).
> +     *
> +     * Logically "wait for recv setup ready" shouldn't need to involve src
> +     * QEMU at all, however to be compatible with old QEMUs, let's stick

I don't understand this statement, you're saying that QEMU src could
just start dumping data on the channel without a remote end? Certainly
for file migrations, but socket as well?

> +     * with this.  Fortunately the overhead is low to sync during setup
> +     * because the VM is running, so at least it's not accounted as part of
> +     * downtime.
> +     */
>      bql_unlock();
>      ret = multifd_ram_flush_and_sync(f);
>      bql_lock();

