Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F8BCFA460
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 19:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3h5W-0005rr-8u; Wed, 23 Oct 2024 15:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t3h5V-0005re-25
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:32:09 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t3h5S-0000F3-SW
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:32:08 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF7A421FA6;
 Wed, 23 Oct 2024 19:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729711924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EID4EuuMV5DjnBT8PPKkM71QiOQECHQSuFeIv60cB+I=;
 b=XmZSMT1HBKhDwEJ1KxnQ6vbLAlNK4i0yzKfS3exmCCe+HDbpDdv2r5I+m3qMYfFeTTUYXZ
 UeGnx9E2qOb5En9ZGhaU14uMyRAeo4f/nINo6szpLgOA7xBQLe5OEUW54gxQmt8KKWm2Ua
 x6/g6winF4Tl+Vc2SIaznndE/3wVCN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729711924;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EID4EuuMV5DjnBT8PPKkM71QiOQECHQSuFeIv60cB+I=;
 b=rJ46N71krOX/nmLHGPaR5pLL0zaDKjO6xu39sKol811qnd5pXq1zNv8KND2zHc1HdbV1pw
 xAiktBQpGhktyEDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729711924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EID4EuuMV5DjnBT8PPKkM71QiOQECHQSuFeIv60cB+I=;
 b=XmZSMT1HBKhDwEJ1KxnQ6vbLAlNK4i0yzKfS3exmCCe+HDbpDdv2r5I+m3qMYfFeTTUYXZ
 UeGnx9E2qOb5En9ZGhaU14uMyRAeo4f/nINo6szpLgOA7xBQLe5OEUW54gxQmt8KKWm2Ua
 x6/g6winF4Tl+Vc2SIaznndE/3wVCN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729711924;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EID4EuuMV5DjnBT8PPKkM71QiOQECHQSuFeIv60cB+I=;
 b=rJ46N71krOX/nmLHGPaR5pLL0zaDKjO6xu39sKol811qnd5pXq1zNv8KND2zHc1HdbV1pw
 xAiktBQpGhktyEDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3742213A63;
 Wed, 23 Oct 2024 19:32:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rDNjADRPGWclbgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 23 Oct 2024 19:32:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH v2 0/4] Migration: Make misc.h helpers available for
 whole VM lifecycle
In-Reply-To: <20241023180216.1072575-1-peterx@redhat.com>
References: <20241023180216.1072575-1-peterx@redhat.com>
Date: Wed, 23 Oct 2024 16:32:01 -0300
Message-ID: <87ed46fwem.fsf@suse.de>
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
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> This is a follow up of below patch from Avihai as a replacement:
>
> https://lore.kernel.org/qemu-devel/20241020130108.27148-3-avihaih@nvidia.com/
>
> This is v2 of the series, and it became a more generic rework on how we do
> migration object refcounts, so I skipped a changelog because most of this
> is new things.
>
> To put it simple, now I introduced another pointer to migration object, and
> here's a simple explanation for both after all change applied (copy-paste
> from one of the patch):
>
> /*
>  * We have two pointers for the global migration objects.  Both of them are
>  * initialized early during QEMU starts, but they have different lifecycles.

The very next person that needs to access one of those in migration code
will get this wrong.

>  *
>  * - current_migration
>  *
>  *   This variable reflects the whole lifecycle of the migration object
>  *   (which each QEMU can only have one).  It is valid until the migration
>  *   object is destroyed.
>  *
>  *   This is the object that internal migration so far use.  For example,
>  *   internal helper migrate_get_current() references it.
>  *
>  *   When all migration code can always pass over a MigrationState* around,
>  *   this variable can logically be dropped.  But we're not yet there.

Won't dropping it just bring us back to the situation before this patch?
I'd say we need the opposite, to stop using migrate_get_current()
everywhere in the migration code and instead expose the
current_migration via an internal header.

>  *
>  * - global_migration

Both are global, we can't prefix one of them with global_.

>  *
>  *   This is valid only until the migration object is still valid to the
>  *   outside-migration world (until migration_shutdown()).
>  *
>  *   This should normally be always set, cleared or accessed by the main
>  *   thread only, rather than the migration thread.
>  *
>  *   All the exported functions (in include/migration) should reference the
>  *   exported migration object only to avoid race conditions, as
>  *   current_migration can be freed concurrently by migration thread when
>  *   the migration thread holds the last refcount.
>  */

Have you thought of locking the migration object instead?

Having two global pointers to the same object with one having slightly
different lifecycle than the other will certainly lead to misuse.

I worry about mixing the usage of both globals due to some migration
code that needs to call these exported functions or external code
reaching into migration/ through some indirect path. Check global and
try to use current sort of scenarios (and vice-versa).

Similarly, what about when a lingering reference still exists, but
global_migration is already clear? Any migration code looking at
global_migration would do the wrong thing.

>
> It allows all misc.h exported helpers to be used for the whole VM
> lifecycle, so as to never crash QEMU with freed migration objects.

Isn't there a race with the last reference being dropped at
migration_shutdown() and global_migration still being set?

>
> Thanks,
>
> Peter Xu (4):
>   migration: Unexport dirty_bitmap_mig_init() in misc.h
>   migration: Reset current_migration properly
>   migration: Add global_migration
>   migration: Make all helpers in misc.h safe to use without migration
>
>  include/migration/misc.h | 29 ++++++++----
>  migration/migration.h    |  4 ++
>  migration/migration.c    | 99 +++++++++++++++++++++++++++++++++++-----
>  3 files changed, 113 insertions(+), 19 deletions(-)

