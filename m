Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E7EC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7E6j-0008En-Lj; Wed, 15 May 2024 08:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s7E6d-0008C5-Gn
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:51:40 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s7E6a-0000P2-NM
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:51:39 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 46A3F33B66;
 Wed, 15 May 2024 12:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715777495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TRH6Sy3SrzzmsahQIZ9irQOyDIkKnhQ4q45eVCgcnAw=;
 b=svJzNdxSjjHnoVsP0sbIguyGz3oNtF+mNR8d1rT+JSptFpLzkW7qndw0bhsiNDLhjo/WHF
 mZNPkV97tZBq0Ke5H2liUAuL+Qu93WCCmEXAis/FWDa2KT6HqhOpydFflBi/coHMsSKiaw
 l2e/2/MBTix5OFCUEhfr0OHXCmRBaY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715777495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TRH6Sy3SrzzmsahQIZ9irQOyDIkKnhQ4q45eVCgcnAw=;
 b=fI6Q/frPEVXPR2TfP95WHRl1aKRTyAY0gz6BvOJJNGcgMxb1Ueu4frXn4+8vjycaSkbenE
 J90VdrMpxcv6c8AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715777495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TRH6Sy3SrzzmsahQIZ9irQOyDIkKnhQ4q45eVCgcnAw=;
 b=svJzNdxSjjHnoVsP0sbIguyGz3oNtF+mNR8d1rT+JSptFpLzkW7qndw0bhsiNDLhjo/WHF
 mZNPkV97tZBq0Ke5H2liUAuL+Qu93WCCmEXAis/FWDa2KT6HqhOpydFflBi/coHMsSKiaw
 l2e/2/MBTix5OFCUEhfr0OHXCmRBaY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715777495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TRH6Sy3SrzzmsahQIZ9irQOyDIkKnhQ4q45eVCgcnAw=;
 b=fI6Q/frPEVXPR2TfP95WHRl1aKRTyAY0gz6BvOJJNGcgMxb1Ueu4frXn4+8vjycaSkbenE
 J90VdrMpxcv6c8AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4666136A8;
 Wed, 15 May 2024 12:51:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pPCwItavRGYWeQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 15 May 2024 12:51:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, Claudio Fontana <cfontana@suse.de>, Jim Fehlig
 <jfehlig@suse.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 4/9] migration: Add direct-io parameter
In-Reply-To: <87v83fwnlp.fsf@pond.sub.org>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-5-farosas@suse.de> <ZjUnghSvdy-wWtnN@x1n>
 <871q6ioc2r.fsf@suse.de> <ZjVUKCafjreLtLmm@x1n>
 <87ttj0zdp0.fsf@pond.sub.org> <87r0e4e0ox.fsf@suse.de>
 <87v83fwnlp.fsf@pond.sub.org>
Date: Wed, 15 May 2024 09:51:32 -0300
Message-ID: <87o797dyqz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> Peter Xu <peterx@redhat.com> writes:
>>>
>>>> On Fri, May 03, 2024 at 05:49:32PM -0300, Fabiano Rosas wrote:
>>>>> Peter Xu <peterx@redhat.com> writes:
>>>>> 
>>>>> > On Fri, Apr 26, 2024 at 11:20:37AM -0300, Fabiano Rosas wrote:
>>>>> >> Add the direct-io migration parameter that tells the migration code to
>>>>> >> use O_DIRECT when opening the migration stream file whenever possible.
>>>>> >> 
>>>>> >> This is currently only used with the mapped-ram migration that has a
>>>>> >> clear window guaranteed to perform aligned writes.
>>>>> >> 
>>>>> >> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>>>> >> ---
>>>>> >>  include/qemu/osdep.h           |  2 ++
>>>>> >>  migration/migration-hmp-cmds.c | 11 +++++++++++
>>>>> >>  migration/options.c            | 30 ++++++++++++++++++++++++++++++
>>>>> >>  migration/options.h            |  1 +
>>>>> >>  qapi/migration.json            | 18 +++++++++++++++---
>>>>> >>  util/osdep.c                   |  9 +++++++++
>>>>> >>  6 files changed, 68 insertions(+), 3 deletions(-)
>>>>> >> 
>>>>> >> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>>>>> >> index c7053cdc2b..645c14a65d 100644
>>>>> >> --- a/include/qemu/osdep.h
>>>>> >> +++ b/include/qemu/osdep.h
>>>>> >> @@ -612,6 +612,8 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
>>>>> >>  bool qemu_has_ofd_lock(void);
>>>>> >>  #endif
>>>>> >>  
>>>>> >> +bool qemu_has_direct_io(void);
>>>>> >> +
>>>>> >>  #if defined(__HAIKU__) && defined(__i386__)
>>>>> >>  #define FMT_pid "%ld"
>>>>> >>  #elif defined(WIN64)
>>>>> >> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>>>>> >> index 7e96ae6ffd..8496a2b34e 100644
>>>>> >> --- a/migration/migration-hmp-cmds.c
>>>>> >> +++ b/migration/migration-hmp-cmds.c
>>>>> >> @@ -397,6 +397,13 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>>>> >>          monitor_printf(mon, "%s: %s\n",
>>>>> >>              MigrationParameter_str(MIGRATION_PARAMETER_MODE),
>>>>> >>              qapi_enum_lookup(&MigMode_lookup, params->mode));
>>>>> >> +
>>>>> >> +        if (params->has_direct_io) {
>>>>> >> +            monitor_printf(mon, "%s: %s\n",
>>>>> >> +                           MigrationParameter_str(
>>>>> >> +                               MIGRATION_PARAMETER_DIRECT_IO),
>>>>> >> +                           params->direct_io ? "on" : "off");
>>>>> >> +        }
>>>>> >
>>>>> > This will be the first parameter to optionally display here.  I think it's
>>>>> > a sign of misuse of has_direct_io field..
>>>
>>> Yes.  For similar existing parameters, we do
>>>
>>>                assert(params->has_FOO);
>>>                monitor_printf(mon, "%s: '%s'\n",
>>>                               MigrationParameter_str(MIGRATION_PARAMETER_FOO),
>>>                               ... params->FOO as string ...)
>>>
>>>>> > IMHO has_direct_io should be best to be kept as "whether direct_io field is
>>>>> > valid" and that's all of it.  It hopefully shouldn't contain more
>>>>> > information than that, or otherwise it'll be another small challenge we
>>>>> > need to overcome when we can remove all these has_* fields, and can also be
>>>>> > easily overlooked.
>>>>> 
>>>>> I don't think I understand why we have those has_* fields. I thought my
>>>>> usage of 'params->has_direct_io = qemu_has_direct_io()' was the correct
>>>>> one, i.e. checking whether QEMU has any support for that parameter. Can
>>>>> you help me out here?
>>>>
>>>> Here params is the pointer to "struct MigrationParameters", which is
>>>> defined in qapi/migration.json.  And we have had "has_*" only because we
>>>> allow optional fields with asterisks:
>>>>
>>>>   { 'struct': 'MigrationParameters',
>>>>     'data': { '*announce-initial': 'size',
>>>>               ...
>>>>               } }
>>>>
>>>> So that's why it better only means "whether this field existed", because
>>>> it's how it is defined.
>>>>
>>>> IIRC we (or say, Markus) used to have some attempts deduplicates those
>>>> *MigrationParameter* things, and if success we have chance to drop has_*
>>>> fields (in which case we simply always have them; that "has_" makes more
>>>> sense only if in a QMP session to allow user only specify one or more
>>>> things if not all).
>>>
>>> qapi/migration.json:
>>>
>>>     ##
>>>     # @MigrationParameters:
>>>     #
>>> --> # The optional members aren't actually optional.
>>>     #
>>>
>>> In other words, the has_FOO generated for the members of
>>> MigrationParameters must all be true.
>>>
>>> These members became optional when we attempted to de-duplicate
>>> MigrationParameters and MigrateSetParameters, but failed (see commit
>>> de63ab61241 "migrate: Share common MigrationParameters struct" and
>>> commit 1bda8b3c695 "migration: Unshare MigrationParameters struct for
>>> now").
>>
>> So what's the blocker for merging MigrationSetParameters and
>> MigrationParameters? Just the tls_* options?
>
> I believe the latest attempt was Peter's "[PATCH v3 0/4] qapi/migration:
> Dedup migration parameter objects and fix tls-authz crash" last
> September.

I had a vague memory of this, thanks for bringing it up. I'll go over
that series and see what can be done.

>
> I can't recall offhand what exactly blocked its merge.  Suggest you read
> the review thread[*], and if that leads to questions, ask them either in
> replies to the old thread, or right here.
>
> One additional issue hasn't been discussed much so far, I think: merging
> the two copies of the doc comments.  They are big and quite similar
> (that's why we want to deduplicate), but they're not identical.  In
> particular, MigrationSetParameters' doc comment talks more about
> defaults.  That's because talking about defaults makes no sense
> whatsoever for MigrationParameters (we do it anyway, of course, just
> less).  Merging the two will require some careful word-smithing, and
> perhaps some compromises on doc quality.
>

I was playing with this yesterday and it occurred to me as well that the
docs are not quite the same. Maybe we can have a general description
common for both use-cases and a few extra words for what happens
differently when writing vs. reading.

>
>
> [*] https://lore.kernel.org/qemu-devel/20230905162335.235619-1-peterx@redhat.com/

