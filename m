Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D83CFC5FD
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 19:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syyjZ-0005DB-MA; Thu, 10 Oct 2024 15:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1syyjW-0005CI-SX; Thu, 10 Oct 2024 15:21:59 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1syyjU-0006ig-PC; Thu, 10 Oct 2024 15:21:58 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A22991F801;
 Thu, 10 Oct 2024 19:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728588113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCRwW9OgqwOAwc2gvQv0btZul7s20OMJiskeOOghx4Y=;
 b=y/EojXG5kFS+Sknad/+IH2tKHXLFmuOCAaDP70oC6pxu1JuMuctumqHLFsD8H9Fy1NR4pG
 SX5G4PmRTIBIvAy5dBfloBwsqN4GKg2wOabQpQZ6qGuWo4/juc5kvLKTl6Js8fFHOekmBs
 L4LliBc9o+pbmgmfyRVB+/QM74QqYfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728588113;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCRwW9OgqwOAwc2gvQv0btZul7s20OMJiskeOOghx4Y=;
 b=zDISf6ILNA2w9Hh+wN4W0+Gs8pNxYMQplkWNBGfXpHZShDS9vyhvZ6TdZXFQ2TanqkvKzp
 VtPCvctQdQQBY2BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="y/EojXG5";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zDISf6IL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728588113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCRwW9OgqwOAwc2gvQv0btZul7s20OMJiskeOOghx4Y=;
 b=y/EojXG5kFS+Sknad/+IH2tKHXLFmuOCAaDP70oC6pxu1JuMuctumqHLFsD8H9Fy1NR4pG
 SX5G4PmRTIBIvAy5dBfloBwsqN4GKg2wOabQpQZ6qGuWo4/juc5kvLKTl6Js8fFHOekmBs
 L4LliBc9o+pbmgmfyRVB+/QM74QqYfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728588113;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCRwW9OgqwOAwc2gvQv0btZul7s20OMJiskeOOghx4Y=;
 b=zDISf6ILNA2w9Hh+wN4W0+Gs8pNxYMQplkWNBGfXpHZShDS9vyhvZ6TdZXFQ2TanqkvKzp
 VtPCvctQdQQBY2BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AB2B13A6E;
 Thu, 10 Oct 2024 19:21:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eMWnOFApCGcvQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Oct 2024 19:21:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Andrey
 Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eesposit@redhat.com, den@virtuozzo.com, Peter Xu <peterx@redhat.com>
Subject: Re: [Bug Report][RFC PATCH 1/1] block: fix failing assert on paused
 VM migration
In-Reply-To: <a2a13861-ed60-4fc7-b57b-51028179406c@yandex-team.ru>
References: <20240924125611.664315-1-andrey.drobyshev@virtuozzo.com>
 <20240924125611.664315-2-andrey.drobyshev@virtuozzo.com>
 <6fb3340a-f685-422f-acaf-ad968e854847@yandex-team.ru>
 <0faf2b77-0cda-4823-8c3f-986be7d6964c@virtuozzo.com>
 <29cd78e2-be26-41a4-92c4-a327efe76177@yandex-team.ru>
 <87set5roao.fsf@suse.de>
 <17d7959e-d643-4fd2-9e57-81de2728fa3e@yandex-team.ru>
 <87msjcrpxa.fsf@suse.de>
 <a2a13861-ed60-4fc7-b57b-51028179406c@yandex-team.ru>
Date: Thu, 10 Oct 2024 16:21:50 -0300
Message-ID: <87a5fbsr01.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: A22991F801
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 10.10.24 17:30, Fabiano Rosas wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> On 09.10.24 23:53, Fabiano Rosas wrote:
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>>
>>>>> On 30.09.24 17:07, Andrey Drobyshev wrote:
>>>>>> On 9/30/24 12:25 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> [add migration maintainers]
>>>>>>>
>>>>>>> On 24.09.24 15:56, Andrey Drobyshev wrote:
>>>>>>>> [...]
>>>>>>>
>>>>>>> I doubt that this a correct way to go.
>>>>>>>
>>>>>>> As far as I understand, "inactive" actually means that "storage is not
>>>>>>> belong to qemu, but to someone else (another qemu process for example),
>>>>>>> and may be changed transparently". In turn this means that Qemu should
>>>>>>> do nothing with inactive disks. So the problem is that nobody called
>>>>>>> bdrv_activate_all on target, and we shouldn't ignore that.
>>>>>>>
>>>>>>> Hmm, I see in process_incoming_migration_bh() we do call
>>>>>>> bdrv_activate_all(), but only in some scenarios. May be, the condition
>>>>>>> should be less strict here.
>>>>>>>
>>>>>>> Why we need any condition here at all? Don't we want to activate
>>>>>>> block-layer on target after migration anyway?
>>>>>>>
>>>>>>
>>>>>> Hmm I'm not sure about the unconditional activation, since we at least
>>>>>> have to honor LATE_BLOCK_ACTIVATE cap if it's set (and probably delay it
>>>>>> in such a case).  In current libvirt upstream I see such code:
>>>>>>
>>>>>>> /* Migration capabilities which should always be enabled as long as they
>>>>>>>     * are supported by QEMU. If the capability is supposed to be enabled on both
>>>>>>>     * sides of migration, it won't be enabled unless both sides support it.
>>>>>>>     */
>>>>>>> static const qemuMigrationParamsAlwaysOnItem qemuMigrationParamsAlwaysOn[] = {
>>>>>>>        {QEMU_MIGRATION_CAP_PAUSE_BEFORE_SWITCHOVER,
>>>>>>>         QEMU_MIGRATION_SOURCE},
>>>>>>>                                                                                    
>>>>>>>        {QEMU_MIGRATION_CAP_LATE_BLOCK_ACTIVATE,
>>>>>>>         QEMU_MIGRATION_DESTINATION},
>>>>>>> };
>>>>>>
>>>>>> which means that libvirt always wants LATE_BLOCK_ACTIVATE to be set.
>>>>>>
>>>>>> The code from process_incoming_migration_bh() you're referring to:
>>>>>>
>>>>>>>        /* If capability late_block_activate is set:
>>>>>>>         * Only fire up the block code now if we're going to restart the
>>>>>>>         * VM, else 'cont' will do it.
>>>>>>>         * This causes file locking to happen; so we don't want it to happen
>>>>>>>         * unless we really are starting the VM.
>>>>>>>         */
>>>>>>>        if (!migrate_late_block_activate() ||
>>>>>>>             (autostart && (!global_state_received() ||
>>>>>>>                runstate_is_live(global_state_get_runstate())))) {
>>>>>>>            /* Make sure all file formats throw away their mutable metadata.
>>>>>>>             * If we get an error here, just don't restart the VM yet. */
>>>>>>>            bdrv_activate_all(&local_err);
>>>>>>>            if (local_err) {
>>>>>>>                error_report_err(local_err);
>>>>>>>                local_err = NULL;
>>>>>>>                autostart = false;
>>>>>>>            }
>>>>>>>        }
>>>>>>
>>>>>> It states explicitly that we're either going to start VM right at this
>>>>>> point if (autostart == true), or we wait till "cont" command happens.
>>>>>> None of this is going to happen if we start another migration while
>>>>>> still being in PAUSED state.  So I think it seems reasonable to take
>>>>>> such case into account.  For instance, this patch does prevent the crash:
>>>>>>
>>>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>>>> index ae2be31557..3222f6745b 100644
>>>>>>> --- a/migration/migration.c
>>>>>>> +++ b/migration/migration.c
>>>>>>> @@ -733,7 +733,8 @@ static void process_incoming_migration_bh(void *opaque)
>>>>>>>          */
>>>>>>>         if (!migrate_late_block_activate() ||
>>>>>>>              (autostart && (!global_state_received() ||
>>>>>>> -            runstate_is_live(global_state_get_runstate())))) {
>>>>>>> +            runstate_is_live(global_state_get_runstate()))) ||
>>>>>>> +         (!autostart && global_state_get_runstate() == RUN_STATE_PAUSED)) {
>>>>>>>             /* Make sure all file formats throw away their mutable metadata.
>>>>>>>              * If we get an error here, just don't restart the VM yet. */
>>>>>>>             bdrv_activate_all(&local_err);
>>>>>>
>>>>>> What are your thoughts on it?
>>>>>>
>>>>
>>>> This bug is the same as https://gitlab.com/qemu-project/qemu/-/issues/2395
>>>>
>>>>>
>>>>> Hmmm... Don't we violate "late-block-activate" contract by this?
>>>>>
>>>>> Me go and check:
>>>>>
>>>>> # @late-block-activate: If enabled, the destination will not activate
>>>>> #     block devices (and thus take locks) immediately at the end of
>>>>> #     migration.  (since 3.0)
>>>>>
>>>>> Yes, we'll violate it by this patch. So, for now the only exception is
>>>>> when autostart is enabled, but libvirt correctly use
>>>>> late-block-activate + !autostart.
>>>>>
>>>>> Interesting, when block layer is assumed to be activated.. Aha, only in qmp_cont().
>>>>>
>>>>>
>>>>> So, what to do with this all:
>>>>>
>>>>> Either libvirt should not use late-block-activate for migration of
>>>>> stopped vm. This way target would be automatically activated
>>>>>
>>>>> Or if libvirt still need postponed activation (I assume, for correctly
>>>>> switching shared disks, etc), Libvirt should do some additional QMP
>>>>> call. It can't be "cont", if we don't want to run the VM. So,
>>>>> probably, we need additional "block-activate" QMP command for this.
>>>>
>>>> A third option might be to unconditionally activate in qmp_migrate:
>>>
>>> Yes. But is migration the only operation with vm which requires block
>>> layer be activated? I think actually a lot of operation require
>>> that.. Any block-layer releated qmp command actually. And do automatic
>>> activation in all of them I think is a wrong way.
>> 
>> Yes, good point. I don't know how other commands behave in this
>> situation. It would be good to have an unified solution. I'll check.
>> 
>>>
>>> Moreover, if we have explicit possibility to "postpone activation", we
>>> should provide a way to "activate by hand".
>> 
>> Maybe, but it doesn't really follows. We have been activating
>> automatically until now, after all (from qmp_cont). Also, having to go
>> change libvirt code just for this is not ideal.
>> 
>>>
>>> So I still think correct fix is reporting error from qmp_migrate when
>>> block-layer is inactive, and add some possibility to activate through
>>> QMP.
>> 
>> Unfortunately, for migration that's bad user experience: we allow the
>> first migration of a paused VM with no issues, then on the second one we
>> error out asking for a command to be run, which only does a
>> bdrv_activate_all() that QEMU could very well do itself.
>> 
>
> Hmm. Now I tend to agree that it's OK to activate block-layer on "migrate" command automatically.
>
> Full solution should consider also another block-layer related qmp
> commands, but that would require a lot more work.

So far, only bdrv_co_write_req_prepare() seems to have a problem. All
other asserts are due to the process of activation/inactivation itself.

I can only assume that paths checking the flag and doing some operation
based on it are still going to work as expected.

@Andrey, do you want to send a patch with the migration fix? I can work
on the block layer stuff.

