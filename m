Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B41EB1054
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyBv-0003az-O5; Tue, 10 Mar 2026 10:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzyBt-0003Zq-2h
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:36:09 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzyBr-0004e3-BA
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:36:08 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 02C255BCFF;
 Tue, 10 Mar 2026 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773153366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LHJZKUqw06PIb4H0al74xLxV8x2U7EYuxDpE8ji74SA=;
 b=xYJG8bgfUh91JkuyVp9Crg8MgvW8P7BqKhmAKHcSOyty+4ItRzmFAz0HZ75da3mAYJjKlm
 fm+27UN2E0rj4WLlXXx4SI4MOvNQY5eqtdCBj6DRFfsFt1K0p+Qd6y2aDhXb+oGWLb5mkz
 G3WwSZouZmwOhxT+nmmnZh8DfxCdVKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773153366;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LHJZKUqw06PIb4H0al74xLxV8x2U7EYuxDpE8ji74SA=;
 b=ucFWuYea+57RlGBEO5i5+GEylbJBcXJZcb1hoV6txaoVEWODCP+lgpHSjg1OoeKCWJrauF
 sGzj5z5YCQ7jhfCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773153365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LHJZKUqw06PIb4H0al74xLxV8x2U7EYuxDpE8ji74SA=;
 b=QMckKSxPTbhvoJwUH71Kehc1X0GhmzeK5YT35Clmr0CitMOS13BFUFIounlkG0MAlDoK+v
 by7sUiv61oe4I7VKL503xXr5Jdb3L9EyJllRB0SoWzObZEdzvbkK9CrtJJD+uqJDqcjv2F
 1lJpE5kkYoJ03I3p/rwun3iBQ1rkkkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773153365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LHJZKUqw06PIb4H0al74xLxV8x2U7EYuxDpE8ji74SA=;
 b=6LRbzL1QN4Ok7bcjF0GlbGdlmZZOeJxWXNJf8B2g6jINqBKusJrK4zy1WFsAIKQAWyPO7I
 WR2C/lEdrCCgm6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 831803F4DC;
 Tue, 10 Mar 2026 14:36:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UiqVElQssGkgHgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Mar 2026 14:36:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 0/8] migration-test: Plumbing
In-Reply-To: <20260310142134.15137-1-farosas@suse.de>
References: <20260310142134.15137-1-farosas@suse.de>
Date: Tue, 10 Mar 2026 11:36:02 -0300
Message-ID: <87eclr21m5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Fabiano Rosas <farosas@suse.de> writes:

> Fix leaks. A couple of normal ones and a few that happen due to a test
> expecting failure in the destination side, but exit-on-error=true so
> the coroutine just exits the entire process while a few resources are
> still allocated, but outside of the scope of the migration code.
>
> I brought a couple of cleanup patches from another in-flight series to
> be able to force-set exit-on-error=false for the tests that are
> causing leaks, that way we don't need to complicate the migration
> cleanup code trying to reach into other subsystems to free memory when
> QEMU is already exiting.
>
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2375586934
>
> --enable-asan --enable-ubsan build is clean for x86_64 migration-test --full
>
> Fabiano Rosas (8):
>   tests/qtest/migration: Fix leak of migration tests data
>   tests/qtest/migration: Change validate_uuid test to not trigger
>     exit(1)
>   tests/qtest/migration: Fix misuse of listen_uri
>   tests/qtest/migration: Stop invoking migrate_incoming from hooks
>   tests/qtest/migration: Force exit-on-error=false when appropriate
>   io: Fix TLS bye task leak
>   tests/qtest/migration: Fix leak in CPR exec test
>   migration/multifd: Fix leaks of TLS error objects
>
>  io/channel-tls.c                          |  4 ++-
>  migration/migration.c                     |  5 +++
>  migration/multifd.c                       | 27 +++++++--------
>  tests/qtest/migration/colo-tests.c        |  8 ++++-
>  tests/qtest/migration/compression-tests.c | 18 ++++++----
>  tests/qtest/migration/cpr-tests.c         | 25 +++++++++-----
>  tests/qtest/migration/file-tests.c        | 41 ++++++++++++++++-------
>  tests/qtest/migration/framework.c         | 31 ++++++++++++-----
>  tests/qtest/migration/framework.h         |  7 ++++
>  tests/qtest/migration/migration-util.c    | 19 ++++++++---
>  tests/qtest/migration/migration-util.h    |  2 +-
>  tests/qtest/migration/misc-tests.c        |  8 ++---
>  tests/qtest/migration/precopy-tests.c     | 21 +++++++-----
>  tests/qtest/migration/tls-tests.c         | 30 +++++++++++------
>  14 files changed, 165 insertions(+), 81 deletions(-)

Sorry if this breaks the thread, but I left the cover letter behind by
mistake.

Rest of the series is:

[PATCH 1/8] tests/qtest/migration: Fix leak of migration tests data
20260310135540.8679-1-farosas@suse.de
https://lore.kernel.org/r/20260310135540.8679-1-farosas@suse.de

