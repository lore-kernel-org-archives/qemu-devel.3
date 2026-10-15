Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B42CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHL9G-0007O7-Vo; Thu, 15 Oct 2026 09:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xHL9D-0007Nk-5L
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:05:27 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xHL9B-00032i-6I
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:05:26 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 36D9821CCD;
 Thu, 15 Oct 2026 13:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792069523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S5EHaUvK1QfPq7/DK5r0DxUAadr34MT26nAOy+M8+TY=;
 b=E8HF194ZRQs4Z4vIVJekY02A/juSf4/65xWWqVPluLfyEmysrn0MQueiau31PGOMzfJXde
 FchKnfViFfxBeBBJrFhq4MZ4AjCC90jv0Wly2ZHoSuU2Ut9oMQzr1yd6a9IVsDgnxeIG/F
 91b/cZeFcAPZ1/90h0jRIr42HO/pgFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792069523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S5EHaUvK1QfPq7/DK5r0DxUAadr34MT26nAOy+M8+TY=;
 b=v2Se2spfSVNAr83AQyGoRHasmtM0XjntmyYHAfZz5QM6Bu/sb94+/d/XodaY6SOsY40Akf
 hqfkwndpl9vfeRCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E8HF194Z;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=v2Se2spf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792069523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S5EHaUvK1QfPq7/DK5r0DxUAadr34MT26nAOy+M8+TY=;
 b=E8HF194ZRQs4Z4vIVJekY02A/juSf4/65xWWqVPluLfyEmysrn0MQueiau31PGOMzfJXde
 FchKnfViFfxBeBBJrFhq4MZ4AjCC90jv0Wly2ZHoSuU2Ut9oMQzr1yd6a9IVsDgnxeIG/F
 91b/cZeFcAPZ1/90h0jRIr42HO/pgFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792069523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S5EHaUvK1QfPq7/DK5r0DxUAadr34MT26nAOy+M8+TY=;
 b=v2Se2spfSVNAr83AQyGoRHasmtM0XjntmyYHAfZz5QM6Bu/sb94+/d/XodaY6SOsY40Akf
 hqfkwndpl9vfeRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA0FD132C9;
 Thu, 15 Oct 2026 13:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id f5kMNH3P0Go5PAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 15 Oct 2026 13:05:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin
 <jmarcin@redhat.com>
Subject: Re: [PATCH v2 4/7] migration: Split
 migration_channel_process_incoming()
In-Reply-To: <20261006182046.3767283-5-peterx@redhat.com>
References: <20261006182046.3767283-1-peterx@redhat.com>
 <20261006182046.3767283-5-peterx@redhat.com>
Date: Thu, 15 Oct 2026 10:04:34 -0300
Message-ID: <87y0bzktct.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 36D9821CCD
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> Introduce two smaller functions for it,
>
> - migration_incoming_channel_install(): peek at channels whenever possible,
>   and install the channel to one of the slots (main, multifd, preempt)
>
> - migration_incoming_error_propagate(): handling an error happened during
>   channel establish phase of an incoming migration.
>
> When at it, move the set channel tracepoint into the 1st helper, replacing
> the existing tracepoint with trace_migration_channel_process_incoming().
> So far, they should fire almost the same time if the channel peek worked.
> This fact will change in follow up refactorings.
>
> I also moved migration_ioc_register_yank() to be after identify, hopefully
> it makes more sense: we'd better be careful on registration of yank, or we
> should be prepared for explosions.  Previously it worked, my guess is when
> error happens we never unregister yank but hang dest QEMU or quit,
> depending on exit_on_error value.
>
> No real functional change intended.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/channel.c    | 57 +++++++++++++++++++++++++++++-------------
>  migration/trace-events |  1 +
>  2 files changed, 41 insertions(+), 17 deletions(-)
>
> diff --git a/migration/channel.c b/migration/channel.c
> index 266ae8f776..8407ea46cb 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -197,6 +197,42 @@ out:
>      return channel;
>  }
>  
> +static void migration_incoming_error_propagate(MigrationIncomingState *mis,
> +                                               Error *error)
> +{
> +    error_report_err(error);
> +    migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
> +    if (mis->exit_on_error) {
> +        exit(EXIT_FAILURE);
> +    }
> +}
> +
> +static bool migration_incoming_channel_install(MigrationIncomingState *mis,
> +                                               QIOChannel *ioc,
> +                                               Error **errp)
> +{
> +    MigChannelType ch = migration_channel_identify(mis, ioc, errp);
> +
> +    if (!ch) {
> +        assert(*errp);
> +        return false;
> +    }
> +
> +    trace_migration_set_incoming_channel(ioc,
> +                                         object_get_typename(OBJECT(ioc)));
> +    migration_ioc_register_yank(ioc);
> +
> +    if (migration_incoming_setup(ioc, ch, errp)) {
> +        migration_start_incoming();
> +    }
> +
> +    if (*errp) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  /**
>   * @migration_channel_process_incoming - Create new incoming migration channel
>   *
> @@ -209,31 +245,18 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      Error *local_err = NULL;
> -    MigChannelType ch;
>  
> -    trace_migration_set_incoming_channel(
> +    trace_migration_channel_process_incoming(
>          ioc, object_get_typename(OBJECT(ioc)));
>  
>      if (migrate_channel_requires_tls_upgrade(ioc)) {
>          migration_tls_channel_process_incoming(ioc, &local_err);
>      } else {
> -        migration_ioc_register_yank(ioc);
> -        ch = migration_channel_identify(mis, ioc, &local_err);
> -        if (!ch) {
> -            goto out;
> -        }
> -
> -        if (migration_incoming_setup(ioc, ch, &local_err)) {
> -            migration_start_incoming();
> -        }
> +        migration_incoming_channel_install(mis, ioc, &local_err);
>      }
> -out:
> +
>      if (local_err) {
> -        error_report_err(local_err);
> -        migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
> -        if (mis->exit_on_error) {
> -            exit(EXIT_FAILURE);
> -        }
> +        migration_incoming_error_propagate(mis, local_err);
>      }
>  }
>  
> diff --git a/migration/trace-events b/migration/trace-events
> index 68bcf12dc7..c93c9f9e75 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -207,6 +207,7 @@ migration_start_incoming(void) ""
>  migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64
>  
>  # channel.c
> +migration_channel_process_incoming(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
>  migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
>  migration_set_outgoing_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"

Reviewed-by: Fabiano Rosas <farosas@suse.de>

