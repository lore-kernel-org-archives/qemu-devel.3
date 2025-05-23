Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CC0C54F2E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 13:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uISc6-0007Xx-I6; Fri, 23 May 2025 09:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uISbs-0007We-68
 for qemu-devel@nongnu.org; Fri, 23 May 2025 09:38:53 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uISbo-0001XN-3U
 for qemu-devel@nongnu.org; Fri, 23 May 2025 09:38:50 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB5B721204;
 Fri, 23 May 2025 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748007526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OoMtimprzdKhlGEJt44zQj0LIevZXt9VHSzYo6dBeJY=;
 b=paP5p4QrEndajAMmek8Fy55XA0JaH3Pq4EKXHIO+8lKfz2oWllk1P3SL63UZGB1h46flq4
 6AzNgjcezKnn/0mU7lA1WC8T4ql/BiJXO8cTyWnHIPgo3W6nTxfo+ZcFQAPopRAzKNBP6w
 Wa/Owetn14SaWeIjeNsNaoj0dD5A/N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748007526;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OoMtimprzdKhlGEJt44zQj0LIevZXt9VHSzYo6dBeJY=;
 b=Li/Ne8JY1AlFubHWgEaixCXQthgyOO2Q8MAVwF3eMZnYGkXq/yhLiiudYl1CLMLxcUu3rL
 71ENnk5WgJbvxaCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748007525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OoMtimprzdKhlGEJt44zQj0LIevZXt9VHSzYo6dBeJY=;
 b=mPw26S3lrn26BXE7HGte4INWOcnfw/TrM12y6XqVmC5/pkQAK/S2XTbTav0DRI5JSJKwza
 XsXs9zRtw8RLyAkR9jHnoAnim11oxi7/UQPjp4MiAr0FS5nFSjcU9U8M7PcTgsfmxXVBbP
 Z+Zqc+GSMpAE0E2qtyj8cbodeDen0Qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748007525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OoMtimprzdKhlGEJt44zQj0LIevZXt9VHSzYo6dBeJY=;
 b=DYA+udUG3tD7VYVw05VzaLYJiVzUfP6tQj1HocaVduoe01eEs1E9gC7p1pu+DZJaCgOk6/
 vVg+mtK8HyrxDJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 510841336F;
 Fri, 23 May 2025 13:38:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MSAFBGV6MGiIBwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 May 2025 13:38:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 07/13] migration: Introduce new MigrationConfig
 structure
In-Reply-To: <87jz7idk97.fsf@pond.sub.org>
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-8-farosas@suse.de> <87jz7idk97.fsf@pond.sub.org>
Date: Fri, 23 May 2025 10:38:41 -0300
Message-ID: <87ldqn5twe.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.30 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
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

Markus Armbruster <armbru@redhat.com> writes:

Markus, sorry for the delay here. I had vacations and holidays, plus a
pile of patches to review.

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Add a new migration structure to consolidate the capabilities and
>> parameters. This structure will be used in place of the s->parameters
>> and s->capabilities data structures in the next few patches.
>>
>> The QAPI migration types now look like this:
>>
>> /* options previously known as parameters */
>
> Configuration previously known as parameters less the TLS stuff.
>
>> { 'struct': 'MigrationConfigBase',
>>   'data': {
>>       <parameters>
>> } }
>>
>>
>> /* for compat with query-migrate-parameters */
>> { 'struct': 'MigrationParameters',
>>   'base': 'MigrationConfigBase',
>>   'data': {
>>       <TLS options in 'str' format>
>> } }
>>
>> /* for compat with migrate-set-parameters */
>> { 'struct': 'MigrateSetParameters',
>>   'base': 'MigrationConfigBase',
>>   'data': {
>>       <TLS options in 'StrOrNull' format>
>> } }
>
> Yes, this is the state since PATCH 05.
>
>> /* to replace MigrationParameters in the MigrationState */
>> { 'struct': 'MigrationConfig',
>>   'base': 'MigrationConfigBase'
>>   'data': {
>>     <TLS options in 'str' format>
>> } }
>
> This is new in this patch.
>
> Your description doesn't cover optionalness.  Here's my understanding:
>
> * MigrationSetParameters has optional members, because
>   migrate-set-parameters needs that.
>

Yes.

> * MigrationParameters would ideally have these members non-optional,
>   because query-migrate-parameters wants that.
>

Yes.

> * But to enable sharing via common base type MigrationConfigBase, we
>   accept unwanted optional in MigrationParameters and thus
>   query-migrate-parameters.
>

Yes.

> * This doesn't apply to the non-shared members of MigrationParameters,
>   so you made them non-optional.  These are @tls-creds, @tls-hostname,
>   @tls-authz.
>

Yes.

> * But in MigrationConfig they're optional again, because "empty string
>   means absent" is silly; we want "NULL means absent".
>

Yes. But mostly because MigrationConfig will become the type for the new
'*config' argument to migrate/migrate_incoming (patches 12 & 13) and we
want to keep all members optional. Otherwise the user would have to pass
all ~50 migration options in every migrate command, which is bad IMO.

> Correct?
>
> Up to here, this enables cleanup of some "empty string means absent"
> silliness in later patches.
>
> The remainder is about unifying capabilities into parameters.  I'd split
> the patch (but I'm a compulsive patch splitter).
>
>> The above keeps the query/set-parameters commands stable. For the
>> capabilities as well as the options added in the future, we have a
>> choice of where to put them:
>>
>> 1) In MigrationConfigBase, this means that the existing
>>    query/set-parameters commands will be updated to deal with
>>    capabilities/new options.
>>
>>   { 'struct': 'MigrationConfigBase',
>>     'data': {
>>       <parameters>
>>       <capabilities>
>>       <new opts>
>>   } }
>>
>>   { 'struct': 'MigrationConfig',
>>     'base': 'MigrationConfigBase'
>>     'data': {
>>       <TLS options in 'str' format>
>>   } }
>>
>> 2) In MigrationConfig, this means that the existing commands will be
>>    frozen in time.
>>
>>   { 'struct': 'MigrationConfigBase',
>>     'data': {
>>       <parameters>
>>   } }
>>
>>   { 'struct': 'MigrationConfig',
>>     'base': 'MigrationConfigBase'
>>     'data': {
>>       <TLS options in 'str' format>
>>       <capabilities>
>>       <new opts>
>>   } }
>>
>> For now, I've chosen the option 1, all capabilities and new options go
>> into MigrationConfigBase. This gives the option to keep the existing
>> commands for as long as we'd like.
>
> Perhaps this would be slightly easier to digest for the reader if you
> talked just about capabilities at first.  Once that's understood,
> mention we have the same choice for new configuration bits.
>

Ok, I'll reorganize, along with the other comments you've made.

>> Note that the query/set capabilities commands will have to go, we can
>> treat parameters as generic configuration options, but capabilities
>> are just too different.
>
> I think the argument is that migration capabilities are a pointless
> interface complication.  One mechanism (parameters) is better than two
> (parameters and capabilities).
>

Yes, that's the main point indeed.

>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  qapi/migration.json | 163 +++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 160 insertions(+), 3 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 5a4d5a2d3e..5e39f21adc 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1063,10 +1063,108 @@
>>  #     @tls-creds, @tls-hostname are mandatory and a valid string is
>>  #     expected. (Since 10.1)
>>  #
>> +# @xbzrle: Migration supports xbzrle (Xor Based Zero Run Length
>> +#     Encoding).  This feature allows us to minimize migration traffic
>> +#     for certain work loads, by sending compressed difference of the
>> +#     pages
>> +#
>> +# @rdma-pin-all: Controls whether or not the entire VM memory
>> +#     footprint is mlock()'d on demand or all at once.  Refer to
>> +#     docs/rdma.txt for usage.  Disabled by default.  (since 2.0)
>> +#
>> +# @zero-blocks: During storage migration encode blocks of zeroes
>> +#     efficiently.  This essentially saves 1MB of zeroes per block on
>> +#     the wire.  Enabling requires source and target VM to support
>> +#     this feature.  To enable it is sufficient to enable the
>> +#     capability on the source VM.  The feature is disabled by
>> +#     default.  (since 1.6)
>> +#
>> +# @events: generate events for each migration state change (since 2.4)
>> +#
>> +# @auto-converge: If enabled, QEMU will automatically throttle down
>> +#     the guest to speed up convergence of RAM migration.  (since 1.6)
>> +#
>> +# @postcopy-ram: Start executing on the migration target before all of
>> +#     RAM has been migrated, pulling the remaining pages along as
>> +#     needed.  The capacity must have the same setting on both source
>> +#     and target or migration will not even start.  NOTE: If the
>> +#     migration fails during postcopy the VM will fail.  (since 2.6)
>> +#
>> +# @x-colo: If enabled, migration will never end, and the state of the
>> +#     VM on the primary side will be migrated continuously to the VM
>> +#     on secondary side, this process is called COarse-Grain LOck
>> +#     Stepping (COLO) for Non-stop Service.  (since 2.8)
>> +#
>> +# @release-ram: if enabled, qemu will free the migrated ram pages on
>> +#     the source during postcopy-ram migration.  (since 2.9)
>> +#
>> +# @return-path: If enabled, migration will use the return path even
>> +#     for precopy.  (since 2.10)
>> +#
>> +# @pause-before-switchover: Pause outgoing migration before
>> +#     serialising device state and before disabling block IO (since
>> +#     2.11)
>> +#
>> +# @multifd: Use more than one fd for migration (since 4.0)
>> +#
>> +# @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps.
>> +#     (since 2.12)
>> +#
>> +# @postcopy-blocktime: Calculate downtime for postcopy live migration
>> +#     (since 3.0)
>> +#
>> +# @late-block-activate: If enabled, the destination will not activate
>> +#     block devices (and thus take locks) immediately at the end of
>> +#     migration.  (since 3.0)
>> +#
>> +# @x-ignore-shared: If enabled, QEMU will not migrate shared memory
>> +#     that is accessible on the destination machine.  (since 4.0)
>> +#
>> +# @validate-uuid: Send the UUID of the source to allow the destination
>> +#     to ensure it is the same.  (since 4.2)
>> +#
>> +# @background-snapshot: If enabled, the migration stream will be a
>> +#     snapshot of the VM exactly at the point when the migration
>> +#     procedure starts.  The VM RAM is saved with running VM.
>> +#     (since 6.0)
>> +#
>> +# @zero-copy-send: Controls behavior on sending memory pages on
>> +#     migration.  When true, enables a zero-copy mechanism for sending
>> +#     memory pages, if host supports it.  Requires that QEMU be
>> +#     permitted to use locked memory for guest RAM pages.  (since 7.1)
>> +#
>> +# @postcopy-preempt: If enabled, the migration process will allow
>> +#     postcopy requests to preempt precopy stream, so postcopy
>> +#     requests will be handled faster.  This is a performance feature
>> +#     and should not affect the correctness of postcopy migration.
>> +#     (since 7.1)
>> +#
>> +# @switchover-ack: If enabled, migration will not stop the source VM
>> +#     and complete the migration until an ACK is received from the
>> +#     destination that it's OK to do so.  Exactly when this ACK is
>> +#     sent depends on the migrated devices that use this feature.  For
>> +#     example, a device can use it to make sure some of its data is
>> +#     sent and loaded in the destination before doing switchover.
>> +#     This can reduce downtime if devices that support this capability
>> +#     are present.  'return-path' capability must be enabled to use
>> +#     it.  (since 8.1)
>> +#
>> +# @dirty-limit: If enabled, migration will throttle vCPUs as needed to
>> +#     keep their dirty page rate within @vcpu-dirty-limit.  This can
>> +#     improve responsiveness of large guests during live migration,
>> +#     and can result in more stable read performance.  Requires KVM
>> +#     with accelerator property "dirty-ring-size" set.  (Since 8.1)
>> +#
>> +# @mapped-ram: Migrate using fixed offsets in the migration file for
>> +#     each RAM page.  Requires a migration URI that supports seeking,
>> +#     such as a file.  (since 9.0)
>> +#
>>  # Features:
>>  #
>> -# @unstable: Members @x-checkpoint-delay and
>> -#     @x-vcpu-dirty-limit-period are experimental.
>> +# @unstable: Members @x-checkpoint-delay, @x-vcpu-dirty-limit-period,
>> +#     @x-colo and @x-ignore-shared are experimental.
>> +# @deprecated: Member @zero-blocks is deprecated as being part of
>> +#     block migration which was already removed.
>>  #
>>  # Since: 10.1
>>  ##
>> @@ -1099,7 +1197,29 @@
>>              '*mode': 'MigMode',
>>              '*zero-page-detection': 'ZeroPageDetection',
>>              '*direct-io': 'bool',
>> -            '*tls': 'bool' } }
>> +            '*tls': 'bool',
>> +            '*xbzrle': 'bool',
>> +            '*rdma-pin-all': 'bool',
>> +            '*auto-converge': 'bool',
>> +            '*zero-blocks': { 'type': 'bool', 'features': [ 'deprecated' ] },
>> +            '*events': 'bool',
>> +            '*postcopy-ram': 'bool',
>> +            '*x-colo': { 'type': 'bool', 'features': [ 'unstable' ] },
>> +            '*release-ram': 'bool',
>> +            '*return-path': 'bool',
>> +            '*pause-before-switchover': 'bool',
>> +            '*multifd': 'bool',
>> +            '*dirty-bitmaps': 'bool',
>> +            '*postcopy-blocktime': 'bool',
>> +            '*late-block-activate': 'bool',
>> +            '*x-ignore-shared': { 'type': 'bool', 'features': [ 'unstable' ] },
>> +            '*validate-uuid': 'bool',
>> +            '*background-snapshot': 'bool',
>> +            '*zero-copy-send': 'bool',
>> +            '*postcopy-preempt': 'bool',
>> +            '*switchover-ack': 'bool',
>> +            '*dirty-limit': 'bool',
>> +            '*mapped-ram': 'bool' } }
>
> This is part 2 "unify capabilities into parameters".
>
> Missing in your series: deprecate migrate-set-capabilities and
> query-migrate-capabilities.
>

I'll add when repost.

>>  
>>  ##
>>  # @MigrationParameters:
>> @@ -2395,3 +2515,40 @@
>>    'data': { 'job-id': 'str',
>>              'tag': 'str',
>>              'devices': ['str'] } }
>> +
>> +##
>> +# @MigrationConfig:
>> +#
>> +# Migration configuration options
>> +#
>> +# @tls-creds: ID of the 'tls-creds' object that provides credentials
>> +#     for establishing a TLS connection over the migration data
>> +#     channel.  On the outgoing side of the migration, the credentials
>> +#     must be for a 'client' endpoint, while for the incoming side the
>> +#     credentials must be for a 'server' endpoint.  Setting this to a
>> +#     non-empty string enables TLS for all migrations.  An empty
>> +#     string means that QEMU will use plain text mode for migration,
>> +#     rather than TLS.  (Since 2.7)
>
> Is "empty string" expected to occur here?
>

Yes. Up until this point I'm keeping everything compatible, only
switching to use MigrationConfig internally. Come patch 12, when we
expose this type externally, it will be time to decide whether to
declare that the new way of setting migration configuration options
treats the empty string as invalid. I haven't made the call yet because
I wanted some feedback on the new commands, backward compatibility, etc.

>> +#
>> +# @tls-hostname: migration target's hostname for validating the
>> +#     server's x509 certificate identity.  If empty, QEMU will use the
>> +#     hostname from the migration URI, if any.  A non-empty value is
>> +#     required when using x509 based TLS credentials and the migration
>> +#     URI does not include a hostname, such as fd: or exec: based
>> +#     migration.  (Since 2.7)
>> +#
>> +#     Note: empty value works only since 2.9.
>
> Likewise.
>

Same here.

>> +#
>> +# @tls-authz: ID of the 'authz' object subclass that provides access
>> +#     control checking of the TLS x509 certificate distinguished name.
>> +#     This object is only resolved at time of use, so can be deleted
>> +#     and recreated on the fly while the migration server is active.
>> +#     If missing, it will default to denying access (Since 4.0)
>> +#
>> +# Since: 10.1
>> +##
>> +{ 'struct': 'MigrationConfig',
>> +  'base': 'MigrationConfigBase',
>> +  'data': { '*tls-creds': 'str',
>> +            '*tls-hostname': 'str',
>> +            '*tls-authz': 'str' } }
>
> This is part 1 "enable cleanup".

Ok.

Thanks for the review!

