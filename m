Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D403C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 15:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNZMY-00024B-J7; Fri, 06 Jun 2025 11:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uNZMU-00022J-Mc
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:52:08 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uNZMS-0003Do-LX
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:52:06 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 17A1F211B8;
 Fri,  6 Jun 2025 15:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749225122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TnJoEFZfS6KEI5B0ojtrZ6dMHEwolt17H57Oe0CWYzc=;
 b=k8v2GNEIy7/HwhR2D9s3dg7e6Du2jTfdIla11g0BYkSlz6B4PFD60WUsE0on+amGI/kkpw
 N0VjwQc2PxsvhgiGCl7SodDaBXKvZAAEW9/xnsSmSyfEQgZKTIn+KsIctp4yCXRZSCc+9B
 dE/90QkmdGo8wTIVmv0FdUYNyn3hlv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749225122;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TnJoEFZfS6KEI5B0ojtrZ6dMHEwolt17H57Oe0CWYzc=;
 b=6qtfwcVjj44LnvFca2WovVbYeS06cr5LDafkzUFz/Et179iAZACrkQkHnOuD075iT8arYc
 fkk4fI4dNGGkk5DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749225122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TnJoEFZfS6KEI5B0ojtrZ6dMHEwolt17H57Oe0CWYzc=;
 b=k8v2GNEIy7/HwhR2D9s3dg7e6Du2jTfdIla11g0BYkSlz6B4PFD60WUsE0on+amGI/kkpw
 N0VjwQc2PxsvhgiGCl7SodDaBXKvZAAEW9/xnsSmSyfEQgZKTIn+KsIctp4yCXRZSCc+9B
 dE/90QkmdGo8wTIVmv0FdUYNyn3hlv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749225122;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TnJoEFZfS6KEI5B0ojtrZ6dMHEwolt17H57Oe0CWYzc=;
 b=6qtfwcVjj44LnvFca2WovVbYeS06cr5LDafkzUFz/Et179iAZACrkQkHnOuD075iT8arYc
 fkk4fI4dNGGkk5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EE861336F;
 Fri,  6 Jun 2025 15:52:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FXqOD6EOQ2jmMgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Jun 2025 15:52:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 09/21] migration: Extract code to mark all parameters as
 present
In-Reply-To: <aEMIkKbRsmW_DEMM@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-10-farosas@suse.de> <aEMIkKbRsmW_DEMM@x1.local>
Date: Fri, 06 Jun 2025 12:51:58 -0300
Message-ID: <87cybgx3z5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
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

> On Mon, Jun 02, 2025 at 10:37:58PM -0300, Fabiano Rosas wrote:
>> MigrationParameters needs to have all of its has_* fields marked as
>> true when used as the return of query_migrate_parameters because the
>> corresponding QMP command has all of its members non-optional by
>> design, despite them being marked as optional in migration.json.
>> 
>> Extract this code into a function and make it assert if any field is
>> missing. With this we ensure future changes will not inadvertently
>> leave any parameters missing.
>> 
>> Also assert that s->parameters _does not_ have any of its has_* fields
>> set. This structure is internal to the migration code and it should
>> not rely on the QAPI-generate has_* fields. We might want to store
>> migration parameters differently in the future.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/options.c | 74 ++++++++++++++++++++++++++++-----------------
>>  1 file changed, 46 insertions(+), 28 deletions(-)
>> 
>> diff --git a/migration/options.c b/migration/options.c
>> index e2e3ab717f..dd62e726cb 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -936,6 +936,40 @@ static void tls_option_set_str(StrOrNull **dstp, StrOrNull *src)
>>      }
>>  }
>>  
>> +static void migrate_mark_all_params_present(MigrationParameters *p)
>> +{
>> +    int len, n_str_args = 3; /* tls-creds, tls-hostname, tls-authz */
>
> Could you remind me why we don't set has_*=true for these three?
>

I doesn't exist. These are StrOrNull so their presence is supposed to be
determined by checking against NULL pointer.

>> +    bool *has_fields[] = {
>> +        &p->has_throttle_trigger_threshold, &p->has_cpu_throttle_initial,
>> +        &p->has_cpu_throttle_increment, &p->has_cpu_throttle_tailslow,
>> +        &p->has_max_bandwidth, &p->has_avail_switchover_bandwidth,
>> +        &p->has_downtime_limit, &p->has_x_checkpoint_delay,
>> +        &p->has_multifd_channels, &p->has_multifd_compression,
>> +        &p->has_multifd_zlib_level, &p->has_multifd_qatzip_level,
>> +        &p->has_multifd_zstd_level, &p->has_xbzrle_cache_size,
>> +        &p->has_max_postcopy_bandwidth, &p->has_max_cpu_throttle,
>> +        &p->has_announce_initial, &p->has_announce_max, &p->has_announce_rounds,
>> +        &p->has_announce_step, &p->has_block_bitmap_mapping,
>> +        &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
>> +        &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
>> +    };
>> +
>> +    /*
>> +     * The has_* fields of MigrationParameters are used by QAPI to
>> +     * inform whether an optional struct member is present. Keep this
>> +     * decoupled from the internal usage (not QAPI) by leaving the
>> +     * has_* fields of s->parameters unused.
>> +     */
>> +    assert(p != &(migrate_get_current())->parameters);
>
> This is OK, I'm not sure whether we're over-cautious though.. but..
>

Hopefully after this series the code will be encapsulated enough that we
don't need to think about this, but before this series the situation is
definitely confusing enough that we need to know which fields are used
for what.

I don't want to see people passing s->parameters into here thinking it's
all the same, because it isn't. The has_* fields should be used only for
QAPI stuff, user input validation, etc, while s->parameters is the thing
that stores all that after validation and there's not reason to be
messing with has_* since we know that's just an consequence of the fact
that we're choosing to use the same QAPI type for user input/output and
internal storage.

I guess what I'm trying to do is take the pain points where I got
confused while working on the current code and introduce some hard rules
to it.

>> +
>> +    len = ARRAY_SIZE(has_fields);
>> +    assert(len + n_str_args == MIGRATION_PARAMETER__MAX);
>
> .. I definitely like this assert.
>

Yep, we can't at the moment get rid of the enum because HMP needs it, so
let's put it to good use. I think this is specially useful for new
contributors, so they don't need to guess what needs to be changed when
adding a new parameter.


