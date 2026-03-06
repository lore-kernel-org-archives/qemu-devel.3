Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1F6F0182F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUtl-0002Mu-PP; Fri, 06 Mar 2026 08:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vyUtj-0002MX-ND
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:07:19 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vyUth-000098-MO
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:07:19 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C67EC5BDEC;
 Fri,  6 Mar 2026 13:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772802435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OahT7wfhb1Cn/aMdjoCcI6fHZUEMeCKZ4+C1lKrf1iM=;
 b=ScjiPgikoxUGMxbwlZMLp/28ikISwiPtC+hwgtTDELiheNa+NyAuPqMjEpaQoFhLtv5ZLH
 GGdZOtToHvkvwNEkt1HC+H6O9HgYR3cdRoC98hLiR6RkcJZC2ZEehDijL52Ye0x/g10ikn
 r4pDomCYER7uEwR560e4nRay34lDZWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772802435;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OahT7wfhb1Cn/aMdjoCcI6fHZUEMeCKZ4+C1lKrf1iM=;
 b=kYa24o5Y2U29wd4sTvI1KKCkGpuj0ycEhgWcaBUcfkcv/wx6wqpPEBLgyZmvy/omEpXN7A
 BEepfrZ7DLmrqFBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ScjiPgik;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kYa24o5Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772802435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OahT7wfhb1Cn/aMdjoCcI6fHZUEMeCKZ4+C1lKrf1iM=;
 b=ScjiPgikoxUGMxbwlZMLp/28ikISwiPtC+hwgtTDELiheNa+NyAuPqMjEpaQoFhLtv5ZLH
 GGdZOtToHvkvwNEkt1HC+H6O9HgYR3cdRoC98hLiR6RkcJZC2ZEehDijL52Ye0x/g10ikn
 r4pDomCYER7uEwR560e4nRay34lDZWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772802435;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OahT7wfhb1Cn/aMdjoCcI6fHZUEMeCKZ4+C1lKrf1iM=;
 b=kYa24o5Y2U29wd4sTvI1KKCkGpuj0ycEhgWcaBUcfkcv/wx6wqpPEBLgyZmvy/omEpXN7A
 BEepfrZ7DLmrqFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D9B83EA75;
 Fri,  6 Mar 2026 13:07:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0CgmBYPRqmniYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Mar 2026 13:07:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Zhang
 Chen <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH v11 00/21] migration: Add COLO multifd support and COLO
 migration unit test
In-Reply-To: <20260306135335.5413bef0@penguin>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
 <20260306135335.5413bef0@penguin>
Date: Fri, 06 Mar 2026 10:07:12 -0300
Message-ID: <871phx2jjz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[web.de,nongnu.org];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,xfusion.com,fujitsu.com,trasno.org];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: C67EC5BDEC
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_NONE=0.001,
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

Lukas Straub <lukasstraub2@web.de> writes:

> On Mon,  2 Mar 2026 12:43:30 +0100
> Lukas Straub <lukasstraub2@web.de> wrote:
>
>> 
>> Hello everyone,
>> This has some cleanups for and adds multifd support and migration unit tests
>> for COLO migration.
>> 
>> Regards,
>> Lukas
>
> Hello Peter, Hello Fabiano,
> Will you apply this?
>

Very likely yes. I'm starting the tests on migration-next, if all goes
well I'll send the pull request later today.

> Best regards,
> Lukas Straub
>
>> 
>> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
>> ---
>> Changes in v11:
>> - Use colo with return-path capability
>> - Link to v10: https://lore.kernel.org/qemu-devel/20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de
>> 
>> Changes in v10:
>> - multifd: always kick the main thread
>> - always open the return path socket on source
>> - Link to v9: https://lore.kernel.org/qemu-devel/20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de
>> 
>> Changes in v9:
>> - Rebase onto master
>> - Fix two rare bugs discovered during sresstesting the colo unit test
>> - Link to v8: https://lore.kernel.org/qemu-devel/20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de
>> 
>> Changes in v8:
>> - Fix peter's review comments
>> - Link to v7: https://lore.kernel.org/qemu-devel/20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de
>> 
>> Changes in v7:
>> - Fix peter's review comments
>> - Link to v6: https://lore.kernel.org/qemu-devel/20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de
>> 
>> Changes in v6:
>> - Fix the crash when running COLO with TCG accel.
>> - Link to v5: https://lore.kernel.org/qemu-devel/20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de
>> 
>> Changes in v5:
>> - Remove unused inmports from multifd-colo.c
>> - Mention the checkpoint overhead of reset to the Q35 fix
>> - Link to v4: https://lore.kernel.org/qemu-devel/20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de
>> 
>> Changes in v4:
>> - Add cleanup patches to remove migration_incoming_colo_enabled() and MIG_CMD_ENABLE_COLO
>> - Add more comments to the colo unit test
>> - Call colo_release_ram_cache() after multifd threads terminate
>> - Link to v3: https://lore.kernel.org/qemu-devel/20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de
>> 
>> Changes in v3:
>> - Fix peter's review comments.
>> - Fix COLO with Q35 machine
>> - Link to v2: https://lore.kernel.org/qemu-devel/20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de
>> 
>> Changes in v2:
>> - Fix review comments
>> - Hide stderr in colo migration test since the logged errors are expected
>> - Add benchmarking data for multifd
>> - Add myself as maintainer for COLO migration framework
>> - Link to v1: https://lore.kernel.org/qemu-devel/20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de
>> 
>> ---
>> Lukas Straub (21):
>>       MAINTAINERS: Add myself as maintainer for COLO migration framework
>>       MAINTAINERS: Remove Hailiang Zhang from COLO migration framework
>>       colo: Setup ram cache in normal migration path
>>       colo: Replace migration_incoming_colo_enabled() with migrate_colo()
>>       colo: Remove ENABLE_COLO savevm command and mark it as deprecated
>>       ram: Remove colo special-casing
>>       multifd: Move ram state receive into multifd_ram_state_recv()
>>       multifd: Add COLO support
>>       Call colo_release_ram_cache() after multifd threads terminate
>>       colo: Fix crash during device vmstate load
>>       colo: Hold the BQL while sending ram state
>>       colo: Do not hold the BQL while receiving ram state.
>>       migration-test: Add COLO migration unit test
>>       Convert colo main documentation to restructuredText
>>       qemu-colo.rst: Miscellaneous changes
>>       qemu-colo.rst: Add my copyright
>>       qemu-colo.rst: Simplify the block replication setup
>>       multifd: Fix hang if send thread errors during sync
>>       colo: Use file lock in primary_vm_do_failover()
>>       migration: Keep s->rp_state.from_dst_file open until migration ends
>>       colo: Reuse the return path from migration on primary and secondary side
>> 
>>  MAINTAINERS                        |   6 +-
>>  docs/COLO-FT.txt                   | 334 ----------------------------------
>>  docs/system/index.rst              |   1 +
>>  docs/system/qemu-colo.rst          | 362 +++++++++++++++++++++++++++++++++++++
>>  include/migration/colo.h           |   3 -
>>  migration/colo.c                   |  59 +++---
>>  migration/meson.build              |   2 +-
>>  migration/migration.c              |  80 ++++----
>>  migration/multifd-colo.c           |  44 +++++
>>  migration/multifd-colo.h           |  26 +++
>>  migration/multifd-nocomp.c         |  10 +-
>>  migration/multifd.c                |  26 ++-
>>  migration/multifd.h                |   5 +-
>>  migration/options.c                |  10 +-
>>  migration/ram.c                    |  12 +-
>>  migration/savevm.c                 |  37 +---
>>  migration/savevm.h                 |   1 -
>>  migration/trace-events             |   1 -
>>  tests/qtest/meson.build            |   7 +-
>>  tests/qtest/migration-test.c       |   1 +
>>  tests/qtest/migration/colo-tests.c | 199 ++++++++++++++++++++
>>  tests/qtest/migration/framework.c  |  13 ++
>>  tests/qtest/migration/framework.h  |   5 +
>>  23 files changed, 777 insertions(+), 467 deletions(-)
>> ---
>> base-commit: d8a9d97317d03190b34498741f98f22e2a9afe3e
>> change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46
>> 
>> Best regards,

