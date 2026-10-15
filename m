Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04BACC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHLXL-0005N0-Qh; Thu, 15 Oct 2026 09:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xHLXI-0005Ku-MZ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:30:20 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xHLX7-0006lb-0q
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:30:15 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0609A1FCD3;
 Thu, 15 Oct 2026 13:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792071006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=spw9xaAq5xTeBYm69pYAoK8PAwA6c/lfdQ/SnN0wqck=;
 b=eaR8CSc9mzWP6SuHhDHskyPXILK3IQ16UTiIhG9FZHcQfWp//mfntw2ajGvePmWR7v02yb
 3TuaG+zmADdkDCE5oVMnwuSGhsKHaSG4GEQDWpI82NtFri2gmXeGbno/Ge4hnO2R7bMxgV
 VgRsuDU4j92E2CevcO4BhTCEz/8JdnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792071006;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=spw9xaAq5xTeBYm69pYAoK8PAwA6c/lfdQ/SnN0wqck=;
 b=Fo2KU46PMRVP1fh6i2k02RHYUjZg/nRS65cLebDAxRs5Fj68gevAdLgtLEnyu4MVcyOnjp
 TJh4LUooyG9bdgAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792071006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=spw9xaAq5xTeBYm69pYAoK8PAwA6c/lfdQ/SnN0wqck=;
 b=eaR8CSc9mzWP6SuHhDHskyPXILK3IQ16UTiIhG9FZHcQfWp//mfntw2ajGvePmWR7v02yb
 3TuaG+zmADdkDCE5oVMnwuSGhsKHaSG4GEQDWpI82NtFri2gmXeGbno/Ge4hnO2R7bMxgV
 VgRsuDU4j92E2CevcO4BhTCEz/8JdnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792071006;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=spw9xaAq5xTeBYm69pYAoK8PAwA6c/lfdQ/SnN0wqck=;
 b=Fo2KU46PMRVP1fh6i2k02RHYUjZg/nRS65cLebDAxRs5Fj68gevAdLgtLEnyu4MVcyOnjp
 TJh4LUooyG9bdgAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A377132C9;
 Thu, 15 Oct 2026 13:30:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JhrcK1zV0Gp1UgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 15 Oct 2026 13:30:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin
 <jmarcin@redhat.com>
Subject: Re: [PATCH v2 7/7] migration: Postpone the outgoing preempt channel
 for preempt_pre_7_2
In-Reply-To: <20261006182046.3767283-8-peterx@redhat.com>
References: <20261006182046.3767283-1-peterx@redhat.com>
 <20261006182046.3767283-8-peterx@redhat.com>
Date: Thu, 15 Oct 2026 10:30:02 -0300
Message-ID: <87pkxbks6d.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
> end of postcopy migration.  OTOH, multifd_recv_all_channels_created()
> reports true even after postcopy network down, as multifd_recv_state->count
> is never decremented.
>
> NOTE: this will move the preempt channel connection no matter multifd is
> enabled or not.  It should fix multifd's case, but should have zero impact
> on when multifd is not enabled.
>
> Fixes: e27418861288 ("migration: enable multifd and postcopy together")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index b140fb6950..53cb6d3821 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3729,6 +3729,21 @@ static void *migration_thread(void *opaque)
>          goto out;
>      }
>  
> +    /*
> +     * Only for old 7.1/7.2 machine types (preempt mode supported since
> +     * 7.1).  Connect the preempt channel only after multifd channels,
> +     * because some QEMU versions (v10.1 to v11.1) will assume the order of
> +     * channels to be: (1) main, then (2) multifd channels, then (3)
> +     * preempt channel.  IOW, (3) must be after (2).
> +     *
> +     * multifd_send_setup() makes sure all multifd channels be connected
> +     * first, then initiate preempt channel here guarantees the ordering to
> +     * those QEMU binaries.
> +     */
> +    if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
> +        postcopy_preempt_setup(s);
> +    }
> +
>      bql_lock();
>      qemu_savevm_state_header(s->to_dst_file);
>      bql_unlock();
> @@ -4009,16 +4024,16 @@ void migration_start_outgoing(MigrationState *s)
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>

