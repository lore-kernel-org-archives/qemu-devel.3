Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A117DD6261A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 12:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjGEB-0003oy-48; Fri, 23 Jan 2026 07:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjGDy-00039V-L4
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:25:15 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjGDw-0005mw-MC
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:25:14 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B94A2337CF;
 Fri, 23 Jan 2026 12:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769171111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J9xh2Ckof6x18TbtUIrfSd4bW4SF1PyNpYpxCE1175o=;
 b=fEUegdRSkzwWHBEyD+DcP9irYmZ1AX3Qmuc6voB3vkCnAWz2nD/ICMaaVRimtrFiD8FhmP
 1rbBCbg7KsHKhWoYlZI1WEkPsdDW0roFshRYGWfAgYt2xttn8ld2Xxa2CNYP58ZTHpAUyq
 v+zgQ8akEgMZ3MZK9vG1oNcfxU056+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769171111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J9xh2Ckof6x18TbtUIrfSd4bW4SF1PyNpYpxCE1175o=;
 b=hdbkPkoNR1E7TkTa+6AptzeAp8x60WmToykEe/z6HsW8rJ8RN9PoPItxteV8GStuUEL0XA
 zm0yrcaptJMZS5CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769171110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J9xh2Ckof6x18TbtUIrfSd4bW4SF1PyNpYpxCE1175o=;
 b=I7YF+TellJ6gSR8Rz35U88/Q/GipL2qppgUZOsZoeYQ6jvtjLn1feXyvjqB1IKpNsPcv7v
 N3P/+xYJzPwAA/Nx6XvSKjY6WJD2OSjhveviCd/X+cYnJIWTMYaN+e3WLJMQn08+XCZf1U
 sIJT5T7xA7g/HWkwmToFukMGxnZ8a8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769171110;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J9xh2Ckof6x18TbtUIrfSd4bW4SF1PyNpYpxCE1175o=;
 b=OrefgE3SVCx2EXIuU5YoI0vs8kUrJoV8Yo3Jsbc4R1oJx6ziVqjPwpQInc4r7q5pPxtD0g
 N1prI1+dcC7qUeCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28FF0136AA;
 Fri, 23 Jan 2026 12:25:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EjNiNqVoc2nnKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 12:25:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com
Subject: Re: [PATCH 1/5] migration: Add a tracepoint for invoking migration
 notifiers
In-Reply-To: <20260122230331.3543312-2-peterx@redhat.com>
References: <20260122230331.3543312-1-peterx@redhat.com>
 <20260122230331.3543312-2-peterx@redhat.com>
Date: Fri, 23 Jan 2026 09:25:07 -0300
Message-ID: <87cy30jz30.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c  | 2 ++
>  migration/trace-events | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 1bcde301f7..47d9189aaf 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1706,6 +1706,8 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
>      GSList *elem, *next;
>      int ret;
>  
> +    trace_migration_call_notifiers(type);
> +
>      e.type = type;
>  
>      for (elem = migration_state_notifiers[mode]; elem; elem = next) {
> diff --git a/migration/trace-events b/migration/trace-events
> index bf11b62b17..f437f0a784 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -198,6 +198,7 @@ process_incoming_migration_co_end(int ret) "ret=%d"
>  process_incoming_migration_co_postcopy_end_main(void) ""
>  postcopy_preempt_enabled(bool value) "%d"
>  migration_precopy_complete(void) ""
> +migration_call_notifiers(int type) "type=%d"
>  
>  # migration-stats
>  migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64

Reviewed-by: Fabiano Rosas <farosas@suse.de>

