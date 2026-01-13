Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCAFD2D0FE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 13:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfeOn-0003ei-No; Tue, 13 Jan 2026 08:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vfeOj-0003dJ-9o
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:25:25 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vfeOg-0004y0-GJ
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:25:24 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 74C805BCC1;
 Tue, 13 Jan 2026 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768310718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQEqe7qNNpBTyf8hVvGzhHFUC6nXZ6tKbH9CFDzFp1U=;
 b=n4MZ52qus9c4cz4Q/eIO/m4JS22qDuGtvdVYLU8PMRJRor9HFByOkhsF9jCNRZP86MXQsU
 J4eWdGc1VLYLyVlgkDf+H+PWGAFF+mJENvZB4rAfs1rvm0HDD+mbH8ehZKmN8QmtVTXM/c
 uXmvWwDnC6qQfcogW98agkMQzWwlSW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768310718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQEqe7qNNpBTyf8hVvGzhHFUC6nXZ6tKbH9CFDzFp1U=;
 b=xWpkTCpga89+dsWupGj5POv88T4bq6k/oxTK+Ldao3J09zMdhU2CRBpsxzTGlNDnY9gTgD
 iKMwW1kmyJ9qGdCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=n4MZ52qu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xWpkTCpg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768310718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQEqe7qNNpBTyf8hVvGzhHFUC6nXZ6tKbH9CFDzFp1U=;
 b=n4MZ52qus9c4cz4Q/eIO/m4JS22qDuGtvdVYLU8PMRJRor9HFByOkhsF9jCNRZP86MXQsU
 J4eWdGc1VLYLyVlgkDf+H+PWGAFF+mJENvZB4rAfs1rvm0HDD+mbH8ehZKmN8QmtVTXM/c
 uXmvWwDnC6qQfcogW98agkMQzWwlSW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768310718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQEqe7qNNpBTyf8hVvGzhHFUC6nXZ6tKbH9CFDzFp1U=;
 b=xWpkTCpga89+dsWupGj5POv88T4bq6k/oxTK+Ldao3J09zMdhU2CRBpsxzTGlNDnY9gTgD
 iKMwW1kmyJ9qGdCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E771A3EA63;
 Tue, 13 Jan 2026 13:25:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9K91Kb1HZmmTDgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 13 Jan 2026 13:25:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v3 01/25] migration: Remove redundant state change
In-Reply-To: <CAE8KmOwVC=ncz3mriwrwXT_AAxxCBbkR2gYLskBNCKN12x71Xw@mail.gmail.com>
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-2-farosas@suse.de>
 <CAE8KmOwVC=ncz3mriwrwXT_AAxxCBbkR2gYLskBNCKN12x71Xw@mail.gmail.com>
Date: Tue, 13 Jan 2026 10:25:15 -0300
Message-ID: <87cy3dprus.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 74C805BCC1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Fri, 9 Jan 2026 at 18:11, Fabiano Rosas <farosas@suse.de> wrote:
>> If local_err is set, migration_connect_error_propagate() will be
>> called and that function already has a state transtion from SETUP to
>> FAILED.
>
> * transtion -> transition.
>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 9d1bf5d276..c45393f40e 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2326,8 +2326,6 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
>>          file_start_outgoing_migration(s, &addr->u.file, &local_err);
>>      } else {
>>          error_setg(&local_err, "uri is not a valid migration protocol");
>> -        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>> -                          MIGRATION_STATUS_FAILED);
>>      }
>
> * Maybe we could remove this last '} else {' block altogether? The
> 'addr->transport == ' check could be moved to the
> migrate_transport_compatible() function (OR near there), which is
> called after addr = channel->addr.
>

This needs to be here (i.e. in two parts) because of the CPR transfer
flow.

> * Saying that - "uri is invalid" - in qmp_migrate_finish() raises a
> question - how did we reach till _migrate_finish() if uri was invalid?

The split in qmp_migrate/qmp_migrate_finish is so that the connection
and migration-start steps can be separated by the CPR transfer hangup
signal. For regular migration it's still as if this were a single
routine.

> Is qmp_migrate_finish() called by libvirtd(8) OR external users via
> QMP? If not, if it is an internal only function to just start
> migration, it could be renamed appropriately without qmp_ prefix -
> migrate_start() OR begin_migration() something to the effect that says
> it starts migration, rather than finish it. migrate_finish() function
> calling  *_start_outgoing_migration() reads contradictory/opposite.
>

Yes, patch 24 at the end of the series takes care of this. I first need
to put some things in place so that we can reuse the connection code for
both the regular migration and cpr-transfer.

> (I'm going through the rest of the patches in this series.)
>
> Thank you.
> ---
>   - Prasad

