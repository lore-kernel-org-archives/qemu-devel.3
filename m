Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD78CC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoVZ-0003v6-Sp; Wed, 21 Feb 2024 10:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcoNK-0001hh-Vl
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:19:11 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcnr2-0005R2-Ec
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 09:45:49 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 712681FB65;
 Wed, 21 Feb 2024 14:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708526746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkmy2d2nkEn/+CcMopn+6oqlSq3tTk9T0gcrkl8pQhk=;
 b=gaE8mhxkyWoKLFgvgHA8aZNfH0qu+5yh59SxMoZbvHcSQvidrUtRN6Mibdb6eh997jxgt9
 qN7LsC1UhzOxC2ePxD05AGXvLt2fHX5MnbFydEFfFBkwiFe+kXNstCl8B51JHbyuDsndMo
 ZAYbbPT0wrKteurLBjWqMRIqeKQ095s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708526746;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkmy2d2nkEn/+CcMopn+6oqlSq3tTk9T0gcrkl8pQhk=;
 b=vQUKOALnUGw7hbXpIKv7a4o55nRvK5KAhEd1NameIPQolaf4PELpwc/u/PiJy6IIyEXI2b
 eLPIkkznOdPZ8mAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708526745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkmy2d2nkEn/+CcMopn+6oqlSq3tTk9T0gcrkl8pQhk=;
 b=OdnvxJMtq8Otgjy/tvldiEP4pEUUwln1xmeDlZmclbD7X1TtxubILOrkjELPTDbrQ1SthV
 BLs1RdH42B/0m7IGwaY/nyadK2WE19QwC1CRqhDUCWaqYOl6vVcQ9eyD6geq1QeS7qnPPx
 d4KPsQjRqMatYX3PEkdvko9MyawpIkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708526745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkmy2d2nkEn/+CcMopn+6oqlSq3tTk9T0gcrkl8pQhk=;
 b=OxjQHvY4RWCXL9fI+NHbwF6yvlsXfCBGZUGnh9ATxXfiJpLX6DeyuikGzHnurcdGVDsjLw
 J07Wo1YiVREwmKAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDA75139D0;
 Wed, 21 Feb 2024 14:45:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5qVdLJgM1mWZBwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 21 Feb 2024 14:45:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Roman Khapov <rkhapov@yandex-team.ru>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, armbru@redhat.com,
 yc-core@yandex-team.ru, Roman Khapov <rkhapov@yandex-team.ru>
Subject: Re: [PATCH v2 0/2] Field 'reason' for MIGRATION event
In-Reply-To: <20240215122759.1438581-1-rkhapov@yandex-team.ru>
References: <20240215122759.1438581-1-rkhapov@yandex-team.ru>
Date: Wed, 21 Feb 2024 11:45:42 -0300
Message-ID: <87jzmxc1ux.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OdnvxJMt;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OxjQHvY4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 712681FB65
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Roman Khapov <rkhapov@yandex-team.ru> writes:

Hi Roman,

> This is resending of series 20240215082659.1378342-1-rkhapov@yandex-team.=
ru,
> where patch subjects numbers were broken in patch 2/2.
>
> Sometimes, when migration fails, it is hard to find out
> the cause of the problems: you have to grep qemu logs.
> At the same time, there is MIGRATION event, which looks like
> suitable place to hold such error descriptions.

query-migrate after the event is received should be enough for giving
you the failure reason. We have that in error-desc. See commit
c94143e587 ("migration: Display error in query-migrate irrelevant of
status").

>
> To handle situation like this (maybe one day it will be useful
> for other MIGRATION statuses to have additional 'reason' strings),

I find it unlikely. There's no "reason" for making progress except
that's how things work. Only the exceptional (i.e. failure) statuses
would have a reason. Today that's FAILED only, maybe also
POSTCOPY_PAUSED.

> the general optional field 'reason' can be added.
>
> The series proposes next changes:
>
> 1. Adding optional 'reason' field of type str into
>    qapi/migration.json MIGRATION event
>
> 2. Passing some error description as reason for every place, which
>    sets migration state to MIGRATION_STATUS_FAILED
>
> After the series, MIGRATION event will looks like this:
> {"execute": "qmp_capabilities"}
> {"return": {}}
> {"event": "MIGRATION", "data": {"status": "setup"}}
> {"event": "MIGRATION", "data": {"status": "failed", "reason": "Failed to =
connect to '/tmp/sock.sock': No such file or directory"}}
>
> Roman Khapov (2):
>   qapi/migration.json: add reason to MIGRATION event
>   migration: add error reason for failed MIGRATION events
>
>  migration/colo.c      |   6 +-
>  migration/migration.c | 128 ++++++++++++++++++++++++++++--------------
>  migration/migration.h |   5 +-
>  migration/multifd.c   |  10 ++--
>  migration/savevm.c    |  24 ++++----
>  qapi/migration.json   |   3 +-
>  6 files changed, 112 insertions(+), 64 deletions(-)

Please remember to run make check:

380/383 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test ERROR
104.77s killed by signal 6 SIGABRT
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr: Broken pipe ../tests/qtest/libqtest.c:204: kill_qemu() detected
QEMU death from signal 11 (Segmentation fault) (core dumped)


Most likely one of the new error_setg has broken postcopy recovery. Some
of those paths are not intended to trigger cleanup.

