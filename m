Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162EECAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 20:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyz9D-0000cp-Hn; Wed, 17 Sep 2025 16:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyz9C-0000ca-6g
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:53:02 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyz9A-0007Qo-Dy
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:53:01 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F4F51FB99;
 Wed, 17 Sep 2025 20:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758142378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+TL7t0zK4ikN54XVfZJVpcKiw55lLeF4FgzIVn14gEM=;
 b=Pipc6XDHXlgNS9nfb0gVo74iN0+RVYeEDvD50e56RwG/OTpYXUMdS50RByGLTDoM7PcS4a
 4X4eVvjKKelmya3IhV9LcmQJBtUXbah86HLIH7V/DYALZMAfUYiBIPcOsVjL1OzjxpvgQe
 tK95Yv/7PgUyjO7eeHz31YyJiaUNfF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758142378;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+TL7t0zK4ikN54XVfZJVpcKiw55lLeF4FgzIVn14gEM=;
 b=5H4FwWKxuq7OYuca0m95f8R8HVmgvnau76hkkUu7D1/rpcu21mjd7XfeNrKoTOgPZwx6/S
 4/ELd/3qA5fCyoAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758142378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+TL7t0zK4ikN54XVfZJVpcKiw55lLeF4FgzIVn14gEM=;
 b=Pipc6XDHXlgNS9nfb0gVo74iN0+RVYeEDvD50e56RwG/OTpYXUMdS50RByGLTDoM7PcS4a
 4X4eVvjKKelmya3IhV9LcmQJBtUXbah86HLIH7V/DYALZMAfUYiBIPcOsVjL1OzjxpvgQe
 tK95Yv/7PgUyjO7eeHz31YyJiaUNfF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758142378;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+TL7t0zK4ikN54XVfZJVpcKiw55lLeF4FgzIVn14gEM=;
 b=5H4FwWKxuq7OYuca0m95f8R8HVmgvnau76hkkUu7D1/rpcu21mjd7XfeNrKoTOgPZwx6/S
 4/ELd/3qA5fCyoAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C84101368D;
 Wed, 17 Sep 2025 20:52:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ynfdIKkfy2gafQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Sep 2025 20:52:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 2/3] migration: Make migration_has_failed() work even
 for CANCELLING
In-Reply-To: <20250910160144.1762894-3-peterx@redhat.com>
References: <20250910160144.1762894-1-peterx@redhat.com>
 <20250910160144.1762894-3-peterx@redhat.com>
Date: Wed, 17 Sep 2025 17:52:54 -0300
Message-ID: <87wm5wvm1l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> We set CANCELLED very late, it means migration_has_failed() may not work
> correctly if it's invoked before updating CANCELLING to CANCELLED.
>

The prophecy is fulfilled.

https://wiki.qemu.org/ToDo/LiveMigration#Migration_cancel_concurrency

I'm not sure I'm convinced, for instance, CANCELLING is part of
migration_is_running(), while FAILED is not. This doesn't seem
right. Another point is that CANCELLING is not a final state, so we're
prone to later need a migration_has_finished_failing_now() helper. =)

My mental model is that CANCELLING is a transitional, ongoing state
where we shouldn't really be making assumptions. Once FAILED is reached,
then we're sure in which general state everything is.

How did you catch this? It was one of the cancel tests that failed? I
just noticed that multifd_send_shutdown() is called from
migration_cleanup() before it changes the state to CANCELLED. So current
code also has whatever issue you detected here.

> Allow that state will make migration_has_failed() working as expected even
> if it's invoked slightly earlier.
>
> One current user is the multifd code for the TLS graceful termination,
> where it's before updating to CANCELLED.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 7015c2b5e0..397917b1b3 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1723,7 +1723,8 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
>  
>  bool migration_has_failed(MigrationState *s)
>  {
> -    return (s->state == MIGRATION_STATUS_CANCELLED ||
> +    return (s->state == MIGRATION_STATUS_CANCELLING ||
> +            s->state == MIGRATION_STATUS_CANCELLED ||
>              s->state == MIGRATION_STATUS_FAILED);
>  }

