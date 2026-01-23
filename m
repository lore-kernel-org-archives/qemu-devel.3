Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245E5D74EC2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 12:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjGga-0005yc-GN; Fri, 23 Jan 2026 07:54:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjGgB-0005nW-0Z
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:54:24 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjGg8-0004xF-TO
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:54:22 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 23B6E5BCCD;
 Fri, 23 Jan 2026 12:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769172858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V3OD4DI/iwuN17fdCMij0y2Oxx+4P9uWLuVdFoEBM9o=;
 b=OqXvH/AzS35sKXXcLl3sYKGqjglKQojdlN9stg/Xzs4XxaSDTlH6l3nbPW0xNNavn8eh4R
 /WvStzwuZGTCpyAOO3Y4VsroxqUELc7tdFbPeu5jdfFVeRScOs0Bz1sreBs3unAER+Juf6
 gRVr8wu56mAxDHG00AeBP5Uzu2wh6vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769172858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V3OD4DI/iwuN17fdCMij0y2Oxx+4P9uWLuVdFoEBM9o=;
 b=HY3g6zTOsGSYb7qTiTXBWA4zbegS1E5SrVcNbRiZSx2bPK/dqvQZC1KgduTKCSOKvMGkTT
 w3bnctVagtS0p4Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769172858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V3OD4DI/iwuN17fdCMij0y2Oxx+4P9uWLuVdFoEBM9o=;
 b=OqXvH/AzS35sKXXcLl3sYKGqjglKQojdlN9stg/Xzs4XxaSDTlH6l3nbPW0xNNavn8eh4R
 /WvStzwuZGTCpyAOO3Y4VsroxqUELc7tdFbPeu5jdfFVeRScOs0Bz1sreBs3unAER+Juf6
 gRVr8wu56mAxDHG00AeBP5Uzu2wh6vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769172858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V3OD4DI/iwuN17fdCMij0y2Oxx+4P9uWLuVdFoEBM9o=;
 b=HY3g6zTOsGSYb7qTiTXBWA4zbegS1E5SrVcNbRiZSx2bPK/dqvQZC1KgduTKCSOKvMGkTT
 w3bnctVagtS0p4Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87EBA136AA;
 Fri, 23 Jan 2026 12:54:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VxIREnlvc2ktSAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 12:54:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 2/5] migration: Fix double notification of DONE/FAIL for
 postcopy
In-Reply-To: <87a4y4jxtc.fsf@suse.de>
References: <20260122230331.3543312-1-peterx@redhat.com>
 <20260122230331.3543312-3-peterx@redhat.com> <87a4y4jxtc.fsf@suse.de>
Date: Fri, 23 Jan 2026 09:54:14 -0300
Message-ID: <877bt8jxqh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
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

Fabiano Rosas <farosas@suse.de> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> Migration notifiers will notify at any of three places: (1) SETUP
>> phase, (2) migration completes, (3) migration fails.
>>
>> There's actually a special case for spice: one can refer to
>> b82fc321bf ("Postcopy+spice: Pass spice migration data earlier").  It
>> doesn't need another 4th event because in commit 9d9babf78d ("migration:
>> MigrationEvent for notifiers") we merged it together with the DONE event.
>>
>> The merge makes some sense if we treat "switchover" of postcopy as "DONE=
",
>> however that also means for postcopy we'll notify DONE twice..  The other
>> one at the end of postcopy when migration_cleanup().
>>
>> In reality, the current code base will also notify FAILED for postcopy
>> twice.  It's because an (maybe accidental) change in commit
>> 4af667f87c ("migration: notifier error checking").
>>
>> First of all, we still need that notification when switchover as stated =
in
>> Dave's commit, however that's only needed for spice.  To fix it, introdu=
ce
>> POSTCOPY_START event to differenciate it from DONE.  Use that instead in
>> postcopy_start().  Then spice will need to capture this event too.
>>
>> Then we remove the extra FAILED notification in postcopy_start().
>>
>> If one wonder if other DONE users should also monitor POSTCOPY_START
>> event.. We have two more DONE users:
>>
>>   - kvm_arm_gicv3_notifier
>>   - cpr_exec_notifier
>>
>> Both of them do not need a notification for POSTCOPY_START, but only when
>> migration completed.  Actually, both of them are used in CPR, which does=
n't
>> support postcopy.
>>
>> I didn't attach Fixes: because I am not aware of any real bug on such
>> double reporting.  I'm wildly guessing the 2nd notify might be silently
>> ignored in many cases.  However this is still worth fixing.
>>
>> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Cc: Dr. David Alan Gilbert <dave@treblig.org>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>  include/migration/misc.h | 1 +
>>  migration/migration.c    | 3 +--
>>  ui/spice-core.c          | 3 ++-
>>  3 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index e26d418a6e..b002466e10 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -63,6 +63,7 @@ typedef enum MigrationEventType {
>>      MIG_EVENT_PRECOPY_SETUP,
>>      MIG_EVENT_PRECOPY_DONE,
>>      MIG_EVENT_PRECOPY_FAILED,
>> +    MIG_EVENT_POSTCOPY_START,
>>      MIG_EVENT_MAX
>>  } MigrationEventType;
>
> With the new state there's a doc text to update at
> migration_add_notifier below.
>
>>=20=20
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 47d9189aaf..91775f8472 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2857,7 +2857,7 @@ static int postcopy_start(MigrationState *ms, Erro=
r **errp)
>>       * at the transition to postcopy and after the device state; in par=
ticular
>>       * spice needs to trigger a transition now
>>       */
>> -    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE, NULL);
>> +    migration_call_notifiers(ms, MIG_EVENT_POSTCOPY_START, NULL);
>>=20=20
>>      migration_downtime_end(ms);
>>=20=20
>> @@ -2906,7 +2906,6 @@ fail:
>>          migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILE=
D);
>>      }
>>      migration_block_activate(NULL);
>> -    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
>
> Does anything consuming the FAILED event expects it to be issued before
> the vm_start() at migration_iteration_finish?
>
> migration_iteration_finish:
>
> bql_lock();
> switch (s->state) {
> case MIGRATION_STATUS_FAILED:
>     if (!migration_block_activate(&local_err)) {
>         error_free(local_err);
>         break;
>     }
>     if (runstate_is_live(s->vm_old_state)) {
>         if (!runstate_check(RUN_STATE_SHUTDOWN)) {
>             vm_start();
>         }
>     } else {
>         if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
>             runstate_set(s->vm_old_state);
>         }
>     }
>
> The extra migration_block_activate() in postcopy_start() also seems
> wrong, no?
>

Heh, nevermind...

>>      bql_unlock();
>>      return -1;
>>  }
>> diff --git a/ui/spice-core.c b/ui/spice-core.c
>> index 8a6050f4ae..ce3c2954e3 100644
>> --- a/ui/spice-core.c
>> +++ b/ui/spice-core.c
>> @@ -585,7 +585,8 @@ static int migration_state_notifier(NotifierWithRetu=
rn *notifier,
>>=20=20
>>      if (e->type =3D=3D MIG_EVENT_PRECOPY_SETUP) {
>>          spice_server_migrate_start(spice_server);
>> -    } else if (e->type =3D=3D MIG_EVENT_PRECOPY_DONE) {
>> +    } else if (e->type =3D=3D MIG_EVENT_PRECOPY_DONE ||
>> +               e->type =3D=3D MIG_EVENT_POSTCOPY_START) {
>>          spice_server_migrate_end(spice_server, true);
>>          spice_have_target_host =3D false;
>>      } else if (e->type =3D=3D MIG_EVENT_PRECOPY_FAILED) {

