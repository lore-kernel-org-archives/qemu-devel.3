Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49691C282C1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 14:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to1kT-0004iP-6U; Fri, 28 Feb 2025 09:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1to1kR-0004d7-LA
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 09:53:55 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1to1kP-00060Q-HA
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 09:53:55 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A1A31F38F;
 Fri, 28 Feb 2025 14:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1740754431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ipmQolsxmeKEihcr0WL8XMgK80wm4QOmjX0W1l+hYdg=;
 b=rAMdEEEGG0LLIWt+17ighzyEyanc8mISpANB+I+pCRCs4vkPrIc0MjqyD/nZOSL0RWClMD
 wqx5/0c0aI1uCh+FvBZ6Tuu5Dtw4T7mou58TXgcwVAxlFO8mziGxDz1dwbsqvq96I2hT3M
 XDrMWyioDU5q9A3wWM/en4b3BsOUWn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1740754431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ipmQolsxmeKEihcr0WL8XMgK80wm4QOmjX0W1l+hYdg=;
 b=pB0pe68dMWQgvQfpYsY9L/7sVpw0kpLDEB+6aze1E0jPzDcMEXHZ1M2/ypU1hBaRSf/49D
 FZ/BKJaNFhcDoKAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rAMdEEEG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pB0pe68d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1740754431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ipmQolsxmeKEihcr0WL8XMgK80wm4QOmjX0W1l+hYdg=;
 b=rAMdEEEGG0LLIWt+17ighzyEyanc8mISpANB+I+pCRCs4vkPrIc0MjqyD/nZOSL0RWClMD
 wqx5/0c0aI1uCh+FvBZ6Tuu5Dtw4T7mou58TXgcwVAxlFO8mziGxDz1dwbsqvq96I2hT3M
 XDrMWyioDU5q9A3wWM/en4b3BsOUWn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1740754431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ipmQolsxmeKEihcr0WL8XMgK80wm4QOmjX0W1l+hYdg=;
 b=pB0pe68dMWQgvQfpYsY9L/7sVpw0kpLDEB+6aze1E0jPzDcMEXHZ1M2/ypU1hBaRSf/49D
 FZ/BKJaNFhcDoKAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11575137AC;
 Fri, 28 Feb 2025 14:53:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D3lDMP7NwWfUPgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Feb 2025 14:53:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v7 0/5] Allow to enable multifd and postcopy migration
 together
In-Reply-To: <20250228121749.553184-1-ppandit@redhat.com>
References: <20250228121749.553184-1-ppandit@redhat.com>
Date: Fri, 28 Feb 2025 11:53:48 -0300
Message-ID: <87frjy2k8z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 9A1A31F38F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Prasad Pandit <ppandit@redhat.com> writes:

> From: Prasad Pandit <pjp@fedoraproject.org>
>
> Hello,
>
> * This series (v7) adds 'MULTIFD_RECV_SYNC' migration command. It is used
>   to notify the destination migration thread to synchronise with the Multifd
>   threads. This allows Multifd ('mig/dst/recv_x') threads on the destination
>   to receive all their data, before they are shutdown.
>
>   This series also updates the channel discovery function and qtests as
>   suggested in the previous review comments.

You forgot to split patch 2. We cannot have a commit that revamps the
channel discovery logic and enables a new feature at the same
time. Changing the channel discovery affects all the migration
use-cases, that change cannot be smuggled along with multifd+postcopy
enablement.

Similarly, the multifd+postcopy enablement is a new feature that needs
to be tested and reasoned upon in isolation, it cannot bring along a
bunch of previously existing code that was shuffled around. We need to
be able to understand clearly what is done _in preparation for_ the
feature and what is done _as part of_ the feature.

Not to mention bisect and backporting. Many people will be looking at
this code in the future without any knowledge of migration, but as part
of a bisect section or when searching for missing backports in the
distros.

I also suggested to move that logic into channel.c. The code is now
well-contained enough that we don't need to be reading it every time
someone is going over the migration flow, it becomes just a helper
function.

> ===
> 67/67 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 OK             147.84s   81 subtests passed

I see postcopy/multifd/plain hanging from time to time. Probably due to
the changes in patch 5. Please take a look.

> ===
>
>
> v6: https://lore.kernel.org/qemu-devel/20250215123119.814345-1-ppandit@redhat.com/T/#t
> * This series (v6) shuts down Multifd threads before starting Postcopy
>   migration. It helps to avoid an issue of multifd pages arriving late
>   at the destination during Postcopy phase and corrupting the vCPU
>   state. It also reorders the qtest patches and does some refactoring
>   changes as suggested in previous review.
> ===
> 67/67 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 OK             161.35s   73 subtests passed
> ===
>
>
> v5: https://lore.kernel.org/qemu-devel/20250205122712.229151-1-ppandit@redhat.com/T/#t
> * This series (v5) consolidates migration capabilities setting in one
>   'set_migration_capabilities()' function, thus simplifying test sources.
>   It passes all migration tests.
> ===
> 66/66 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 OK             143.66s   71 subtests passed
> ===
>
>
> v4: https://lore.kernel.org/qemu-devel/20250127120823.144949-1-ppandit@redhat.com/T/#t
> * This series (v4) adds more 'multifd+postcopy' qtests which test
>   Precopy migration with 'postcopy-ram' attribute set. And run
>   Postcopy migrations with 'multifd' channels enabled.
> ===
> $ ../qtest/migration-test --tap -k -r '/x86_64/migration/multifd+postcopy' | grep -i 'slow test'
> # slow test /x86_64/migration/multifd+postcopy/plain executed in 1.29 secs
> # slow test /x86_64/migration/multifd+postcopy/recovery/tls/psk executed in 2.48 secs
> # slow test /x86_64/migration/multifd+postcopy/preempt/plain executed in 1.49 secs
> # slow test /x86_64/migration/multifd+postcopy/preempt/recovery/tls/psk executed in 2.52 secs
> # slow test /x86_64/migration/multifd+postcopy/tcp/tls/psk/match executed in 3.62 secs
> # slow test /x86_64/migration/multifd+postcopy/tcp/plain/zstd executed in 1.34 secs
> # slow test /x86_64/migration/multifd+postcopy/tcp/plain/cancel executed in 2.24 secs
> ...
> 66/66 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 OK             148.41s   71 subtests passed
> ===
>
>
> v3: https://lore.kernel.org/qemu-devel/20250121131032.1611245-1-ppandit@redhat.com/T/#t
> * This series (v3) passes all existing 'tests/qtest/migration/*' tests
>   and adds a new one to enable multifd channels with postcopy migration.
>
>
> v2: https://lore.kernel.org/qemu-devel/20241129122256.96778-1-ppandit@redhat.com/T/#u
> * This series (v2) further refactors the 'ram_save_target_page'
>   function to make it independent of the multifd & postcopy change.
>
>
> v1: https://lore.kernel.org/qemu-devel/20241126115748.118683-1-ppandit@redhat.com/T/#u
> * This series removes magic value (4-bytes) introduced in the
>   previous series for the Postcopy channel.
>
>
> v0: https://lore.kernel.org/qemu-devel/20241029150908.1136894-1-ppandit@redhat.com/T/#u
> * Currently Multifd and Postcopy migration can not be used together.
>   QEMU shows "Postcopy is not yet compatible with multifd" message.
>
>   When migrating guests with large (100's GB) RAM, Multifd threads
>   help to accelerate migration, but inability to use it with the
>   Postcopy mode delays guest start up on the destination side.
>
> * This patch series allows to enable both Multifd and Postcopy
>   migration together. Precopy and Multifd threads work during
>   the initial guest (RAM) transfer. When migration moves to the
>   Postcopy phase, Multifd threads are restrained and the Postcopy
>   threads start to request pages from the source side.
>
> * This series introduces magic value (4-bytes) to be sent on the
>   Postcopy channel. It helps to differentiate channels and properly
>   setup incoming connections on the destination side.
>
>
> Thank you.
> ---
> Prasad Pandit (5):
>   migration/multifd: move macros to multifd header
>   migration: enable multifd and postcopy together
>   tests/qtest/migration: consolidate set capabilities
>   tests/qtest/migration: add postcopy tests with multifd
>   migration: add MULTIFD_RECV_SYNC migration command
>
>  migration/migration.c                     | 136 +++++++++++++---------
>  migration/multifd-nocomp.c                |  28 +++--
>  migration/multifd.c                       |  17 +--
>  migration/multifd.h                       |   6 +
>  migration/options.c                       |   5 -
>  migration/ram.c                           |   7 +-
>  migration/savevm.c                        |  13 +++
>  migration/savevm.h                        |   1 +
>  tests/qtest/migration/compression-tests.c |  37 +++++-
>  tests/qtest/migration/cpr-tests.c         |   6 +-
>  tests/qtest/migration/file-tests.c        |  58 +++++----
>  tests/qtest/migration/framework.c         |  76 ++++++++----
>  tests/qtest/migration/framework.h         |   9 +-
>  tests/qtest/migration/misc-tests.c        |   4 +-
>  tests/qtest/migration/postcopy-tests.c    |  35 +++++-
>  tests/qtest/migration/precopy-tests.c     |  48 +++++---
>  tests/qtest/migration/tls-tests.c         |  69 ++++++++++-
>  17 files changed, 388 insertions(+), 167 deletions(-)

