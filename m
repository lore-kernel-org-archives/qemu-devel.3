Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8B0C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 13:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVtJB-00069x-9Y; Mon, 22 Jul 2024 09:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVtJ6-000691-EX
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:42:29 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVtJ4-0004RW-OA
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:42:28 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 115611FB6B;
 Mon, 22 Jul 2024 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721655744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5RXhkjT7sbCb8cmHoYzvXj9LvAdqjiPHDjQoDQ/87yk=;
 b=UB4yfN3W4KOfoTE7F//oZGHPH9TPd5pyFWjqoCJmObyeslbl2JdAe4W5+xk46nsyVrdqz8
 i1JBZCJFjrdReFzXZ01ta3YR/uc1bCv+B8SOsLci0A068/f4LUKcwbetwgp06cpCf9HZ1c
 ZnJ8DBWcm1IObdvkYWcXxtApx3zSRQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721655744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5RXhkjT7sbCb8cmHoYzvXj9LvAdqjiPHDjQoDQ/87yk=;
 b=JoKv3f+MrLQf3KsJt3suWlvPoxJ7VitV8JZq0wny3qs8uNc8hGQ6KVORrdIEKMR/oFhYOS
 K8bLeuLO5d555lBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721655744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5RXhkjT7sbCb8cmHoYzvXj9LvAdqjiPHDjQoDQ/87yk=;
 b=UB4yfN3W4KOfoTE7F//oZGHPH9TPd5pyFWjqoCJmObyeslbl2JdAe4W5+xk46nsyVrdqz8
 i1JBZCJFjrdReFzXZ01ta3YR/uc1bCv+B8SOsLci0A068/f4LUKcwbetwgp06cpCf9HZ1c
 ZnJ8DBWcm1IObdvkYWcXxtApx3zSRQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721655744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5RXhkjT7sbCb8cmHoYzvXj9LvAdqjiPHDjQoDQ/87yk=;
 b=JoKv3f+MrLQf3KsJt3suWlvPoxJ7VitV8JZq0wny3qs8uNc8hGQ6KVORrdIEKMR/oFhYOS
 K8bLeuLO5d555lBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85F9E138A7;
 Mon, 22 Jul 2024 13:42:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ntsoE79hnmbWPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Jul 2024 13:42:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 04/11] migration: stop vm earlier for cpr
In-Reply-To: <0d1e8314-cc14-4bd2-8d80-93f6291ada1f@oracle.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-5-git-send-email-steven.sistare@oracle.com>
 <87sew726b9.fsf@suse.de> <0d1e8314-cc14-4bd2-8d80-93f6291ada1f@oracle.com>
Date: Mon, 22 Jul 2024 10:42:21 -0300
Message-ID: <87v80xzgoy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.60 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 TAGGED_RCPT(0.00)[]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[10];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,habkost.net,linaro.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, oracle.com:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 7/17/2024 2:59 PM, Fabiano Rosas wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>> 
>>> Stop the vm earlier for cpr, to guarantee consistent device state when
>>> CPR state is saved.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   migration/migration.c | 22 +++++++++++++---------
>>>   1 file changed, 13 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 0f47765..8a8e927 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -2077,6 +2077,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>>>       MigrationState *s = migrate_get_current();
>>>       g_autoptr(MigrationChannel) channel = NULL;
>>>       MigrationAddress *addr = NULL;
>>> +    bool stopped = false;
>>>   
>>>       /*
>>>        * Having preliminary checks for uri and channel
>>> @@ -2120,6 +2121,15 @@ void qmp_migrate(const char *uri, bool has_channels,
>>>           }
>>>       }
>>>   
>>> +    if (migrate_mode_is_cpr(s)) {
>>> +        int ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>>> +        if (ret < 0) {
>>> +            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
>>> +            goto out;
>>> +        }
>>> +        stopped = true;
>>> +    }
>>> +
>>>       if (cpr_state_save(&local_err)) {
>>>           goto out;
>>>       }
>>> @@ -2155,6 +2165,9 @@ out:
>>>           }
>>>           migrate_fd_error(s, local_err);
>>>           error_propagate(errp, local_err);
>>> +        if (stopped && runstate_is_live(s->vm_old_state)) {
>>> +            vm_start();
>>> +        }
>> 
>> What about non-live states? Shouldn't this be:
>> 
>> if (stopped) {
>>     vm_resume();
>> }
>
> Not quite.  vm_old_state may be a stopped state, so we don't want to resume.
> However, I should probably restore the old stopped state here.  I'll try some more
> error recovery scenarios.

AIUI vm_resume() does the right thing already:

void vm_resume(RunState state)
{
    if (runstate_is_live(state)) {
        vm_start();
    } else {
        runstate_set(state);
    }
}

>
> - Steve
>
>> 
>>>           return;
>>>       }
>>>   }
>>> @@ -3738,7 +3751,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>>       Error *local_err = NULL;
>>>       uint64_t rate_limit;
>>>       bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
>>> -    int ret;
>>>   
>>>       /*
>>>        * If there's a previous error, free it and prepare for another one.
>>> @@ -3810,14 +3822,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>>           return;
>>>       }
>>>   
>>> -    if (migrate_mode_is_cpr(s)) {
>>> -        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>>> -        if (ret < 0) {
>>> -            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
>>> -            goto fail;
>>> -        }
>>> -    }
>>> -
>>>       if (migrate_background_snapshot()) {
>>>           qemu_thread_create(&s->thread, "mig/snapshot",
>>>                   bg_migration_thread, s, QEMU_THREAD_JOINABLE);

