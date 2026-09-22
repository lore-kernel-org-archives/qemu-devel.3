Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEF6C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 23:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9A13-0005r5-1j; Tue, 22 Sep 2026 19:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x9A0t-0005qg-5D
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 19:35:03 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x9A0q-0001Do-Cm
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 19:35:02 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4022E1FF51;
 Tue, 22 Sep 2026 23:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790120092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0iYZs8jOOdfWFKGJCwP9nuh2gjeObUP6twS6AHOAVDw=;
 b=kGjvIwAHSVDLPq8/VviRSmIQDsBrpXwItJv/awH1GWMHhwvaSiJPu0UtGWbh7BG0Na7i6U
 8TwuHneDVbWNSHCMOpWhKbUznhR3TNSDj3weSSayqeJrZJdNCj1HNOM977NmJLCYq7a8CK
 D8mZg9e7eLv3iS3/KQk8+jK6D4u7KeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790120092;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0iYZs8jOOdfWFKGJCwP9nuh2gjeObUP6twS6AHOAVDw=;
 b=g3O7vdWUJRABkJ4zL1aIGctrBXwA1kLFdUgkmL/6rqUvgUmVsiF8mpSGW5jkB40R+4HlWf
 bya9tZnP9DBb4dDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790120088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0iYZs8jOOdfWFKGJCwP9nuh2gjeObUP6twS6AHOAVDw=;
 b=OROdP9sLTVNOOXKbfZFSpuybjAR/NR0yRmpApeISfCwyHjsxn1hMR3NAlSwgRlReuNBGBm
 b8rprebtO7cpBl/4xLw3yDPPW2iV2Ko5jnhfeTuXdBKv+mfKBmBi+BECvaHKWOk4ZjOGwK
 gV3YGdrXX90uZzAFyoHBs3ymhhqJ/jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790120088;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0iYZs8jOOdfWFKGJCwP9nuh2gjeObUP6twS6AHOAVDw=;
 b=fT1fCXvJps6QEpidf9gRWPpeCE1qlWh4A0tVuPrKkJ6j1tqOVfSTakafl57EIUFMC+EIHj
 o5zK9r11wF4KazAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 905E9132D3;
 Tue, 22 Sep 2026 23:34:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2hr5DJcQs2pueAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 22 Sep 2026 23:34:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akash Kulhalli <akulhall@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 7/7] migration: Postpone the outgoing preempt channel
 for preempt_pre_7_2
In-Reply-To: <20260916213558.587304-8-peterx@redhat.com>
References: <20260916213558.587304-1-peterx@redhat.com>
 <20260916213558.587304-8-peterx@redhat.com>
Date: Tue, 22 Sep 2026 20:34:41 -0300
Message-ID: <87o6doami6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

Peter Xu <peterx@redhat.com> writes:

> This is the corresponding outgoing fix for the same problem mentioned in
> the previous patch.
>
> The idea is simple: either migration to an old QEMU or when TLS is enabled,
> we rely on correct ordering of channels to make it work: first main, then
> multifd, finally preempt.
>
> This patch re-orders multifd and postcopy preempt channel on outgoing side,
> but only for the old machine types where preempt_pre_7_2 set, to make it
> follow the right orders to create the channels.
>
> Keep the resume path alone because the resume path never involve multifd
> channels, even if multifd is enabled.  For that, fun fact: when multifd is
> enabled with postcopy preempt, network interruption will break all multifd
> channels, but they're never re-connected, until they got recycled at the
> end of postcopy migration.

Is this a separate bug? Do we need to add some cleanup?

> OTOH, multifd_recv_all_channels_created()
> reports true even after postcopy network down, as multifd_recv_state->count
> is never decremented.
>

Seems normal to me. We're not even trying to reconnect multifd.

> Fixes: e27418861288 ("migration: enable multifd and postcopy together")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 4cc4077a76..f8d664808f 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3733,6 +3733,20 @@ static void *migration_thread(void *opaque)
>          goto out;
>      }
>  
> +    /*
> +     * Only for old 7.1/7.2 machine types running on new binaries (that
> +     * supports multifd+postcopy+preempt).  Makes sure to initiate the
> +     * connect() after multifd channels because the old (broken) binaries
> +     * assumes the order of channels, which we cannot fix anymore.
> +     *
> +     * multifd_send_setup() will make sure all multifd channels will be
> +     * connected first, then initiate preempt channel here guarantees the
> +     * ordering to those old binaries.
> +     */

It's a bit confusing what's old binary, what's new binary here. Old/new
don't really apply I think as there are more than two cases when we look
at the global picture. There's before 7.1, before 7.2, before the
preempt_pre_7_2 flag, before the multifd+postcopy support, before this
series, etc. Specially since this code is exactly the same as the one
under if (resume), but there we're talking about a different new/old.

Also, maybe we should avoid framing the assumption on the order of
channels as "broken", that's how it always worked and is just a case of
unimaginative assumptions, i.e. not knowing multifd would ever run along
preempt. The real bug is that v10.1 added a "new" channel to the mix
without working on compatibility.

In this series you're doing both: fixing the bug that v10.1 introduced
and improving the code to not assume the order of channels.

> +    if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
> +        postcopy_preempt_setup(s);
> +    }

Don't you want to check for multifd as well and apply this fix only to
the case that can actually trigger it? To avoid inadvertently changing
the normal postcopy case.

> +
>      bql_lock();
>      qemu_savevm_state_header(s->to_dst_file);
>      bql_unlock();
> @@ -4013,16 +4027,16 @@ void migration_start_outgoing(MigrationState *s)
>          open_return_path_on_source(s);
>      }
>  
> -    /*
> -     * This needs to be done before resuming a postcopy.  Note: for newer
> -     * QEMUs we will delay the channel creation until postcopy_start(), to
> -     * avoid disorder of channel creations.
> -     */
> -    if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
> -        postcopy_preempt_setup(s);
> -    }
> -

Hm, this used to happen before qmp_migrate() returns. Now it's in the
migration thread and after multifd channels connect, there's a big
window there. We added a lot of code to ensure cleanup of multifd
happens properly and without races with TLS thread creation, etc. Have
you considered such issues?

>      if (resume) {
> +        /*
> +         * This needs to be done before resuming a postcopy.  Note: for newer
> +         * QEMUs we will delay the channel creation until postcopy_start(), to
> +         * avoid disorder of channel creations.
> +         */
> +        if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
> +            postcopy_preempt_setup(s);
> +        }
> +
>          /* Wakeup the main migration thread to do the recovery */
>          migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP,
>                            MIGRATION_STATUS_POSTCOPY_RECOVER);

