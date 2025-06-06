Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1F0C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 15:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNZDt-0006Jz-08; Fri, 06 Jun 2025 11:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uNZDr-0006JV-FK
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:43:11 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uNZDp-00024A-ET
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:43:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6E6DC21C69;
 Fri,  6 Jun 2025 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749224587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=psOQSBnpmWFgUTPFlh07mKlwElm74FP6T/hGdTexxJM=;
 b=sAnNrttwmPhWSTrr2hv399XKzbhLjCktInYxvnG7QMl8Zy4pIZF+okZJTIl+9wl2bD2Mnu
 4jBtPQBR+heps45F4E6az6t+Eww2pCbbGyAdKqFKDUhDLfFQF1j6Ipci+UtDchC6iQW2hX
 OP0mNQdnKKASzCEe1+KtmMlh6nhQ8kQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749224587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=psOQSBnpmWFgUTPFlh07mKlwElm74FP6T/hGdTexxJM=;
 b=eoY6IT9MJgFhe/5w67LLYYY3/yt9lAYietejxNpySqk9/EhNTnMYVtPmIwrp63bZQkXtbP
 ncI725Q6S8JUllDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sAnNrttw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eoY6IT9M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749224587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=psOQSBnpmWFgUTPFlh07mKlwElm74FP6T/hGdTexxJM=;
 b=sAnNrttwmPhWSTrr2hv399XKzbhLjCktInYxvnG7QMl8Zy4pIZF+okZJTIl+9wl2bD2Mnu
 4jBtPQBR+heps45F4E6az6t+Eww2pCbbGyAdKqFKDUhDLfFQF1j6Ipci+UtDchC6iQW2hX
 OP0mNQdnKKASzCEe1+KtmMlh6nhQ8kQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749224587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=psOQSBnpmWFgUTPFlh07mKlwElm74FP6T/hGdTexxJM=;
 b=eoY6IT9MJgFhe/5w67LLYYY3/yt9lAYietejxNpySqk9/EhNTnMYVtPmIwrp63bZQkXtbP
 ncI725Q6S8JUllDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE1DC1336F;
 Fri,  6 Jun 2025 15:43:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CvpOJ4oMQ2joLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Jun 2025 15:43:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 05/21] migration: Add a flag to track
 block-bitmap-mapping input
In-Reply-To: <aEMDTl7yaDGSv33I@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-6-farosas@suse.de> <aEMDTl7yaDGSv33I@x1.local>
Date: Fri, 06 Jun 2025 12:43:04 -0300
Message-ID: <87frgcx4dz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 6E6DC21C69
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Jun 02, 2025 at 10:37:54PM -0300, Fabiano Rosas wrote:
>> The QAPI converts an empty list on the block-bitmap-mapping input into
>> a NULL BitmapMigrationNodeAliasList. The empty list is a valid input
>> for the block-bitmap-mapping option, so commit 3cba22c9ad ("migration:
>> Fix block_bitmap_mapping migration") started using the
>> s->parameters.has_block_bitmap_mapping field to tell when the user has
>> passed in an empty list vs. when no list has been passed at all.
>> 
>> However, using the has_block_bitmap_mapping field of s->parameters is
>> only possible because MigrationParameters has had its members made
>> optional due to historical reasons.
>> 
>> In order to make improvements to the way configuration options are set
>> for a migration, we'd like to reduce the usage of the has_* fields of
>> the global configuration object (s->parameters).
>> 
>> Add a separate boolean to track the status of the block_bitmap_mapping
>> option.
>> 
>> (this was verified to not regress iotest 300, which is the test that
>> 3cba22c9ad refers to)
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/migration.h | 7 +++++++
>>  migration/options.c   | 6 +++---
>>  2 files changed, 10 insertions(+), 3 deletions(-)
>> 
>> diff --git a/migration/migration.h b/migration/migration.h
>> index d53f7cad84..ab797540b0 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -510,6 +510,13 @@ struct MigrationState {
>>      bool rdma_migration;
>>  
>>      GSource *hup_source;
>> +
>> +    /*
>> +     * The block-bitmap-mapping option is allowed to be an emtpy list,
>> +     * therefore we need a way to know wheter the user has given
>> +     * anything as input.
>> +     */
>> +    bool has_block_bitmap_mapping;
>>  };
>>  
>>  void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>> diff --git a/migration/options.c b/migration/options.c
>> index f64e141394..cf77826204 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -685,7 +685,7 @@ bool migrate_has_block_bitmap_mapping(void)
>>  {
>>      MigrationState *s = migrate_get_current();
>>  
>> -    return s->parameters.has_block_bitmap_mapping;
>> +    return s->has_block_bitmap_mapping;
>>  }
>>  
>>  uint32_t migrate_checkpoint_delay(void)
>> @@ -989,7 +989,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>>      params->has_announce_step = true;
>>      params->announce_step = s->parameters.announce_step;
>>  
>> -    if (s->parameters.has_block_bitmap_mapping) {
>> +    if (s->has_block_bitmap_mapping) {
>>          params->has_block_bitmap_mapping = true;
>>          params->block_bitmap_mapping =
>>              QAPI_CLONE(BitmapMigrationNodeAliasList,
>> @@ -1469,7 +1469,7 @@ static void migrate_params_apply(MigrationParameters *params)
>>          qapi_free_BitmapMigrationNodeAliasList(
>>              s->parameters.block_bitmap_mapping);
>>  
>> -        s->parameters.has_block_bitmap_mapping = true;
>> +        s->has_block_bitmap_mapping = true;
>>          s->parameters.block_bitmap_mapping =
>>              QAPI_CLONE(BitmapMigrationNodeAliasList,
>>                         params->block_bitmap_mapping);
>> -- 
>> 2.35.3
>> 
>
> This is definitely unfortunate, and I'm still scratching my head on
> understanding why it's necessary.
>
> E.g. I tried to revert this patch manually and iotest 300 passed, with:

This (mine) patch is not needed per-se. I want it so we stop using
s->parameters.has_* altogether. If we think we need a flag to track
whether the user has passed some value or not, then we add one to some
migration specific state, say MigrationState.

This decouples the migration internal usage from the QAPI. Today we use
MigrationParameters as defined by the QAPI, we might in the future want
something else. And that something else might not come with has_*
fields. So it's simple enough now to add this one flag to the
MigrationState and be able to me completely independent from the
QAPI-generated has_ fields.

>
> ===8<===
> From a952479805d8bdfe532ad4e0c0092f758991af08 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Fri, 6 Jun 2025 10:44:37 -0400
> Subject: [PATCH] Revert "migration: Add a flag to track block-bitmap-mapping
>  input"
>
> This reverts commit fd755a53c0e4ce9739d20d7cdd69400b2a37102c.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.h | 7 -------
>  migration/options.c   | 4 ++--
>  2 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/migration/migration.h b/migration/migration.h
> index 49761f4699..e710c421f8 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -510,13 +510,6 @@ struct MigrationState {
>      bool rdma_migration;
>  
>      GSource *hup_source;
> -
> -    /*
> -     * The block-bitmap-mapping option is allowed to be an emtpy list,
> -     * therefore we need a way to know wheter the user has given
> -     * anything as input.
> -     */
> -    bool has_block_bitmap_mapping;
>  };
>  
>  void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
> diff --git a/migration/options.c b/migration/options.c
> index dd2288187d..e71a57764d 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -765,7 +765,7 @@ bool migrate_has_block_bitmap_mapping(void)
>  {
>      MigrationState *s = migrate_get_current();
>  
> -    return s->has_block_bitmap_mapping;
> +    return s->parameters.has_block_bitmap_mapping;
>  }
>  
>  uint32_t migrate_checkpoint_delay(void)
> @@ -1376,7 +1376,7 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>       * params structure with the user input around.
>       */
>      if (params->has_block_bitmap_mapping) {
> -        migrate_get_current()->has_block_bitmap_mapping = true;
> +        migrate_get_current()->parameters.has_block_bitmap_mapping = true;
>      }
>  
>      if (migrate_params_check(tmp, errp)) {
> -- 
> 2.49.0
> ===8<===
>
> I'm staring at commit 3cba22c9ad now, looks like what it wants to do is
> making sure construct_alias_map() will be invoked even if the block bitmap
> mapping is NULL itself.  But then right below the code, it has:
>
> static int init_dirty_bitmap_migration(DBMSaveState *s, Error **errp)
> {
>     ...
>     if (migrate_has_block_bitmap_mapping()) {
>         alias_map = construct_alias_map(migrate_block_bitmap_mapping(), true,
>                                         &error_abort);
>     }
>     ...
>     if (!alias_map) {
>     ...
>     }
> }
>
> Looks like it's also ready for !alias_map anyway.  I'm definitely puzzled
> by this code.
>
> Even if so, IIUC the question can still be asked on whether we can always
> assume has_block_bitmap_mapping to be always true, then here instead of:
>
>     if (migrate_has_block_bitmap_mapping()) {
>         alias_map = construct_alias_map(migrate_block_bitmap_mapping(), true,
>                                         &error_abort);
>     }
>
> We do:
>
>     alias_map = construct_alias_map(migrate_block_bitmap_mapping(), true,
>                                     &error_abort);
>
> After all it looks like construct_alias_map() takes NULL too..

The point is that construct_alias_map always returns a hashtable. It
might be empty if the user passes [], and that's ok according to
3cba22c9ad. So they needed some flag to say: "the user has tried to use
block-bitmap-mapping".

I don't know why it needs to be like that and I honestly don't want to
go into details of block migration just to be able to do a
refactoring. All I want is that this code stop using s->parameters.has_*
so we can do nice tricks with QAPI_CLONE later on and not bother about
this.

I fully support we chase this, but keep in mind this patch (mine) is
just gingerly moving the problem to the side so we can make progress
with this series.

