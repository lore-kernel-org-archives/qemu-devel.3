Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E708D44C53
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 14:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgOCj-00017y-TS; Thu, 15 Jan 2026 09:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vgOCi-00017V-QS
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:20:04 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vgOCg-0003Lp-Gg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:20:03 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D8715BD43;
 Thu, 15 Jan 2026 14:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768486797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s9sLZwr6RbuiekgW6Zz33YGkel03GvnXs7QJpQMnsss=;
 b=OAKsMVHtO7l4+EZ0rL6s8qPuuJWhsusxJE+hN4OR+DujQBPNth9Y6sE5sWTKf6pxpIQqBG
 t0ddQ622hbmCaCI1luXsECWvP2hnHiN5vyRcszZYBsHmj09NHGw+PupFES7FfQxF0uyCuA
 Opd5AxJySjodpX2UNbOC/VrEXnH6mcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768486797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s9sLZwr6RbuiekgW6Zz33YGkel03GvnXs7QJpQMnsss=;
 b=dyyGuyEXqh9MAoEBMVmBNslxhCytYE9NI+kADNnRAznbe016Z5eKh+WRX3AOBf8bJe0yyB
 pbccNNl0w6QG8TBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768486797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s9sLZwr6RbuiekgW6Zz33YGkel03GvnXs7QJpQMnsss=;
 b=OAKsMVHtO7l4+EZ0rL6s8qPuuJWhsusxJE+hN4OR+DujQBPNth9Y6sE5sWTKf6pxpIQqBG
 t0ddQ622hbmCaCI1luXsECWvP2hnHiN5vyRcszZYBsHmj09NHGw+PupFES7FfQxF0uyCuA
 Opd5AxJySjodpX2UNbOC/VrEXnH6mcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768486797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s9sLZwr6RbuiekgW6Zz33YGkel03GvnXs7QJpQMnsss=;
 b=dyyGuyEXqh9MAoEBMVmBNslxhCytYE9NI+kADNnRAznbe016Z5eKh+WRX3AOBf8bJe0yyB
 pbccNNl0w6QG8TBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CD433EA63;
 Thu, 15 Jan 2026 14:19:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eZhQL4z3aGmeXgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 15 Jan 2026 14:19:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 0/2] tests/migration-test: Small cleanup series on
 postcopy tests
In-Reply-To: <20260114153751.2427172-1-peterx@redhat.com>
References: <20260114153751.2427172-1-peterx@redhat.com>
Date: Thu, 15 Jan 2026 11:19:53 -0300
Message-ID: <87a4yfnek6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[web.de,redhat.com];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

> v2:
> - add one sentence to commit message of patch 2
>
> This series removes two unnecessary fields in MigrateCommon that was only
> for postcopy tests.
>
> Comments welcomed, thanks.
>
> Peter Xu (2):
>   tests/migration-test: Remove postcopy_data from MigrateCommon
>   tests/migration-test: Remove postcopy_recovery_fail_stage from
>     MigrateCommon
>
>  tests/qtest/migration/framework.h      |  7 ++-----
>  tests/qtest/migration/framework.c      | 25 ++++++++++++++-----------
>  tests/qtest/migration/postcopy-tests.c | 12 ++++--------
>  tests/qtest/migration/tls-tests.c      |  8 ++++----
>  4 files changed, 24 insertions(+), 28 deletions(-)

Queued, thanks

