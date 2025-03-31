Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8804BC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 15:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzGeE-0008R8-72; Mon, 31 Mar 2025 11:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzGe9-0008Qd-9r
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 11:01:54 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzGe6-0003FR-NG
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 11:01:53 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3EC541F452;
 Mon, 31 Mar 2025 15:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743433307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vj1k/H6i1zDgj50HY2eC0c9rOivtRvYHZHIcGcwozzI=;
 b=PQv6ahiMPGPmLIElU5+ZwMc0usXqf4cK+3QjnRngzaqL2YqQ3omZjzxJBClowKDCB971Ds
 gkBQAjPY9yOu30pCzhQj9cVE93dIhsdj8CgPlCzC4WfZJj7AahSOfNJjoBaa014VGJtuul
 y1c0XNqtEDc6ohAmoLlAq8cHVRu4alc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743433307;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vj1k/H6i1zDgj50HY2eC0c9rOivtRvYHZHIcGcwozzI=;
 b=H7uFbwGKKjOtQokRmxvc87QTDSwZCOu4l3Dr8YO6KpqICtVfVsBnCsb0z81HV1tBC7dUeI
 0d2uktZVrqHH4XAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PQv6ahiM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H7uFbwGK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743433307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vj1k/H6i1zDgj50HY2eC0c9rOivtRvYHZHIcGcwozzI=;
 b=PQv6ahiMPGPmLIElU5+ZwMc0usXqf4cK+3QjnRngzaqL2YqQ3omZjzxJBClowKDCB971Ds
 gkBQAjPY9yOu30pCzhQj9cVE93dIhsdj8CgPlCzC4WfZJj7AahSOfNJjoBaa014VGJtuul
 y1c0XNqtEDc6ohAmoLlAq8cHVRu4alc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743433307;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vj1k/H6i1zDgj50HY2eC0c9rOivtRvYHZHIcGcwozzI=;
 b=H7uFbwGKKjOtQokRmxvc87QTDSwZCOu4l3Dr8YO6KpqICtVfVsBnCsb0z81HV1tBC7dUeI
 0d2uktZVrqHH4XAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABAFD139A1;
 Mon, 31 Mar 2025 15:01:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4pxyGlqu6mfQQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 31 Mar 2025 15:01:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v8 2/7] migration: Refactor channel discovery mechanism
In-Reply-To: <20250318123846.1370312-3-ppandit@redhat.com>
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <20250318123846.1370312-3-ppandit@redhat.com>
Date: Mon, 31 Mar 2025 12:01:43 -0300
Message-ID: <87y0wlkzvs.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 3EC541F452
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Prasad Pandit <ppandit@redhat.com> writes:

> From: Prasad Pandit <pjp@fedoraproject.org>
>
> The various logical migration channels don't have a
> standardized way of advertising themselves and their
> connections may be seen out of order by the migration
> destination. When a new connection arrives, the incoming
> migration currently make use of heuristics to determine
> which channel it belongs to.
>
> The next few patches will need to change how the multifd
> and postcopy capabilities interact and that affects the
> channel discovery heuristic.
>
> Refactor the channel discovery heuristic to make it less
> opaque and simplify the subsequent patches.
>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  migration/migration.c | 124 +++++++++++++++++++++++-------------------
>  1 file changed, 69 insertions(+), 55 deletions(-)
>
> v8:
>  - Separate this patch out from earlier patch-2
>
> v7:
> - https://lore.kernel.org/qemu-devel/20250228121749.553184-1-ppandit@redhat.com/T/#t
>
> diff --git a/migration/migration.c b/migration/migration.c
> index d46e776e24..f97bb2777f 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -95,6 +95,9 @@ enum mig_rp_message_type {
>      MIG_RP_MSG_MAX
>  };
>  
> +/* Migration channel types */
> +enum { CH_MAIN, CH_MULTIFD, CH_POSTCOPY };
> +
>  /* When we add fault tolerance, we could have several
>     migrations at once.  For now we don't need to add
>     dynamic creation of migration */
> @@ -985,28 +988,19 @@ void migration_fd_process_incoming(QEMUFile *f)
>      migration_incoming_process();
>  }
>  
> -/*
> - * Returns true when we want to start a new incoming migration process,
> - * false otherwise.
> - */
> -static bool migration_should_start_incoming(bool main_channel)
> +static bool migration_has_main_and_multifd_channels(void)
>  {
> -    /* Multifd doesn't start unless all channels are established */
> -    if (migrate_multifd()) {
> -        return migration_has_all_channels();
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +    if (!mis->from_src_file) {
> +        /* main channel not established */
> +        return false;
>      }
>  
> -    /* Preempt channel only starts when the main channel is created */
> -    if (migrate_postcopy_preempt()) {
> -        return main_channel;
> +    if (migrate_multifd() && !multifd_recv_all_channels_created()) {
> +        return false;
>      }
>  
> -    /*
> -     * For all the rest types of migration, we should only reach here when
> -     * it's the main channel that's being created, and we should always
> -     * proceed with this channel.
> -     */
> -    assert(main_channel);
> +    /* main and all multifd channels are established */
>      return true;
>  }
>  
> @@ -1015,59 +1009,84 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      Error *local_err = NULL;
>      QEMUFile *f;
> -    bool default_channel = true;
> +    uint8_t channel;
>      uint32_t channel_magic = 0;
>      int ret = 0;
>  
> -    if (migrate_multifd() && !migrate_mapped_ram() &&
> -        !migrate_postcopy_ram() &&
> -        qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
> -        /*
> -         * With multiple channels, it is possible that we receive channels
> -         * out of order on destination side, causing incorrect mapping of
> -         * source channels on destination side. Check channel MAGIC to
> -         * decide type of channel. Please note this is best effort, postcopy
> -         * preempt channel does not send any magic number so avoid it for
> -         * postcopy live migration. Also tls live migration already does
> -         * tls handshake while initializing main channel so with tls this
> -         * issue is not possible.
> -         */
> -        ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
> -                                          sizeof(channel_magic), errp);
> +    if (!migration_has_main_and_multifd_channels()) {
> +        if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
> +            /*
> +             * With multiple channels, it is possible that we receive channels
> +             * out of order on destination side, causing incorrect mapping of
> +             * source channels on destination side. Check channel MAGIC to
> +             * decide type of channel. Please note this is best effort,
> +             * postcopy preempt channel does not send any magic number so
> +             * avoid it for postcopy live migration. Also tls live migration
> +             * already does tls handshake while initializing main channel so
> +             * with tls this issue is not possible.
> +             */
> +            ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
> +                                              sizeof(channel_magic), errp);
> +            if (ret != 0) {
> +                return;
> +            }
>  
> -        if (ret != 0) {
> +            channel_magic = be32_to_cpu(channel_magic);
> +            if (channel_magic == QEMU_VM_FILE_MAGIC) {
> +                channel = CH_MAIN;
> +            } else if (channel_magic == MULTIFD_MAGIC) {
> +                channel = CH_MULTIFD;
> +            } else if (!mis->from_src_file &&
> +                        mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
> +                /* reconnect main channel for postcopy recovery */
> +                channel = CH_MAIN;
> +            } else {
> +                error_setg(errp, "unknown channel magic: %u", channel_magic);
> +                return;
> +            }
> +        } else if (mis->from_src_file && migrate_multifd()) {
> +            /*
> +             * Non-peekable channels like tls/file are processed as
> +             * multifd channels when multifd is enabled.
> +             */
> +            channel = CH_MULTIFD;
> +        } else if (!mis->from_src_file) {
> +            channel = CH_MAIN;
> +        } else {
> +            error_setg(errp, "non-peekable channel used without multifd");
>              return;
>          }
> -
> -        default_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
> +    } else if (mis->from_src_file) {

This is redundant.

> +        channel = CH_POSTCOPY;
>      } else {
> -        default_channel = !mis->from_src_file;
> +        channel = CH_MAIN;

And this is impossible.

>      }
>  
>      if (multifd_recv_setup(errp) != 0) {
>          return;
>      }
>  
> -    if (default_channel) {
> +    if (channel == CH_MAIN) {
>          f = qemu_file_new_input(ioc);
>          migration_incoming_setup(f);

We should probably expand migration_incoming_setup() to make it clear
that mis->from_src_file is set at this point. And
assert(!mis->from_src_file). I can send a patch on top later.

> -    } else {
> +    } else if (channel == CH_MULTIFD) {
>          /* Multiple connections */
> -        assert(migration_needs_multiple_sockets());
>          if (migrate_multifd()) {

This should be an assert.

>              multifd_recv_new_channel(ioc, &local_err);
> -        } else {
> -            assert(migrate_postcopy_preempt());
> -            f = qemu_file_new_input(ioc);
> -            postcopy_preempt_new_channel(mis, f);
>          }
>          if (local_err) {
>              error_propagate(errp, local_err);
>              return;
>          }
> +    } else if (channel == CH_POSTCOPY) {
> +        assert(migrate_postcopy_preempt());
> +        assert(!mis->postcopy_qemufile_dst);
> +        f = qemu_file_new_input(ioc);
> +        postcopy_preempt_new_channel(mis, f);
> +        return;
>      }
>  
> -    if (migration_should_start_incoming(default_channel)) {
> +    if (migration_has_main_and_multifd_channels()) {

I think there's a bug here. Excluding multifd from the picture, if only
the main channel needs to be setup, then it's possible to start postcopy
recovery twice, once when the main channel appears and another time when
the preempt channel appears.

The previous code worked differently because it did:

if (migrate_postcopy_preempt()) {
    return main_channel;

which would return false when preempt arrived after main.

We could use migration_has_all_channels() instead, that would look more
logically correct, but it would also change the current behavior that
postcopy recovery can start before the preempt channel is in place. I'm
not even sure if that's actually part of the design of the feature.

>          /* If it's a recovery, we're done */
>          if (postcopy_try_recover()) {
>              return;
> @@ -1084,20 +1103,15 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>   */
>  bool migration_has_all_channels(void)
>  {
> +    if (!migration_has_main_and_multifd_channels()) {
> +        return false;
> +    }
> +
>      MigrationIncomingState *mis = migration_incoming_get_current();
> -
> -    if (!mis->from_src_file) {
> +    if (migrate_postcopy_preempt() && !mis->postcopy_qemufile_dst) {
>          return false;
>      }
>  
> -    if (migrate_multifd()) {
> -        return multifd_recv_all_channels_created();
> -    }
> -
> -    if (migrate_postcopy_preempt()) {
> -        return mis->postcopy_qemufile_dst != NULL;
> -    }
> -
>      return true;
>  }

