Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F16C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8zrk-0006bz-H7; Tue, 22 Sep 2026 08:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x8zrh-0006bk-3C
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:44:53 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x8zrf-0002GK-4u
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:44:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 71C1C21ADA;
 Tue, 22 Sep 2026 12:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790081085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IYJ3itNh6Ep9Gi0seuKgRx4pMSf544LfUHzCCtTD/0w=;
 b=I//ixbykZ32//9LZ3KkoFgVwI1CygjnXi3PDapHd6WoH3F9pFfOls+Kz0tLnsomOf5wWYq
 EVdksjccUhSQWL3sIf1qF8G0MHaE03bLbK1BHRa5UUd77cZdmbrf0OVYmzHzCSBDkKcTHs
 IQd9gcZBFtJHDKUZYqgGfPuCmCXGuyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790081085;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IYJ3itNh6Ep9Gi0seuKgRx4pMSf544LfUHzCCtTD/0w=;
 b=LjUSqWsSsoQxDKUWgRhBSxwEA9qeffgXArZBePk58vTiKHWVwa3sgksuAEEF4qZUw8yZGr
 RZ4NZRqrDthrgVBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eWGHD1Ou;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gLe56Bp7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790081081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IYJ3itNh6Ep9Gi0seuKgRx4pMSf544LfUHzCCtTD/0w=;
 b=eWGHD1Ou4xhwaFspNlvxI9PvlyU2fsdQG9W0gMScmpeE4Ucn9OAGpY0U72pX0yoWlCAFvz
 aMlKEDStepoZ2qnfvudG9aGNRDfc0uNArrPsmyKVgkVPhMgRCCpeKUq1ZRzlV+HrBIXGX3
 vvMwi/KxKr7fvfcz9yiIAtIlpizKwtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790081081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IYJ3itNh6Ep9Gi0seuKgRx4pMSf544LfUHzCCtTD/0w=;
 b=gLe56Bp7CQ5YBqM/4vUJGzOWgkdtDTcsDpPj2BJbwL6dCbWefqYRHQM7IrLmt9TI/CR4zB
 kEHhLIJHiA2C3dDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93AFC13A01;
 Tue, 22 Sep 2026 12:44:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lidBDjh4smohRAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 22 Sep 2026 12:44:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr
 . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 00/20] migration: MigrationParameters changes
In-Reply-To: <20260915000209.3692668-1-farosas@suse.de>
References: <20260915000209.3692668-1-farosas@suse.de>
Date: Tue, 22 Sep 2026 09:44:38 -0300
Message-ID: <87y0cta215.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 71C1C21ADA
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
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> since v2:
>
> - Better handling the cpr-exec-command special case by converting the
>   string input to a QList.
>
> - New clone visitor to replace the manual setting of has_* fields. It
>   now happens once at instance_init before s->parameters is even
>   available to the rest of the code.
>
> - Removed MigrationParameter.
>
> - Added some line breaks and spacing to the block-bitmap-mapping
>   output (and lists in general).
>
> - Simplified the completion test by using g_ptr_array.
>
> - Updated the parameters test to call query-migrate since there's no
>   MigrateParameter_lookup to list the parameters names anymore.
>
> - Rebased on master and picked-up the new 'local' parameter.
>
> (apologies if I might have missed some r-bs, my 'b4 trailers' is
> broken at the moment)
>
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2848741815
>
> v2:
> https://lore.kernel.org/r/20260909214509.237309-1-farosas@suse.de
> v1:
> https://lore.kernel.org/r/20260902221547.1812481-1-farosas@suse.de
>
> Fabiano Rosas (20):
>   checkpatch: Fix checking of newlines in error messages
>   migration/options.c: Don't export migrate_tls_opts_free
>   migration: Rename variables in qmp_migrate_set_parameters
>   migration: Use QAPI_CLONE_MEMBERS in migrate_params_apply
>   migration: Merge parameter structs instead of assigning one by one
>   migration: Open code migrate_params_apply
>   migration: Stop freeing s->parameters members individually
>   migration: Use migrate_params_free during finalize
>   tests/qtest/migration: Add a test for HMP
>   tests/qtest/migration: Add a test for HMP completion
>   migration: HMP: Change bandwidth parameters expected input unit
>   migration: Change HMP 'info migrate_parameters' output
>   migration: Use keyval input visitor in HMP set command
>   migration: Use output visitor in info command
>   migration: Rewrite migrate_set_parameter_completion using QDict
>   migration: Add capabilities into MigrationParameters
>   migration: Remove s->capabilities
>   qapi/migration: Deprecate capabilities commands
>   migration: Set the parameters present flag with a clone visitor
>   qapi: Remove MigrationParameter
>
>  docs/about/deprecated.rst          |  13 +
>  include/qapi/clone-visitor.h       |   1 +
>  migration/migration-hmp-cmds.c     | 445 +++++-----------
>  migration/migration.c              |  19 +-
>  migration/migration.h              |   2 +-
>  migration/options.c                | 789 +++++++++++------------------
>  migration/options.h                |  29 +-
>  migration/savevm.c                 |   8 +-
>  qapi/migration.json                | 168 ++++--
>  qapi/qapi-clone-visitor.c          |  13 +
>  scripts/checkpatch.pl              |  11 +-
>  tests/qemu-iotests/300             |  20 +-
>  tests/qtest/migration/misc-tests.c | 560 ++++++++++++++++++++
>  13 files changed, 1173 insertions(+), 905 deletions(-)

I queued patches 2-8 for the next pull request. I'll leave
migration-next to marinate for a day or two. If anyone needs more time
with those patches, let me know and I can drop them no problem.

Thanks

