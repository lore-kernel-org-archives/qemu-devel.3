Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A877EC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2URB-000225-5m; Fri, 04 Sep 2026 09:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2UR9-00021d-64
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:58:35 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2UR6-0007c0-HN
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:58:34 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6431F22BC9;
 Fri,  4 Sep 2026 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788530306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AUpgHYyaDQ/ARga5vu0u3a5tsUK3+J2E329GTs2nP8c=;
 b=ZTI8PlWd2PXSf1O77yPM5opS+JWu5V7xvYLB4dBLH/jbuIQQkQAwGpCMr74/9zNom6pICm
 9NLtUvPqlbFGmNY/kdwKtVWlyUVLjZ4n737eHaA8+189pTNT6n71MaN8ZXL2e4GbtXKlBv
 6V5cp2mtsvL/VcebOH5yYvqhXsO0j2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788530306;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AUpgHYyaDQ/ARga5vu0u3a5tsUK3+J2E329GTs2nP8c=;
 b=RfnEAeeTlpNuKgk6lMbhPd6camHubfxhWbFbGp5PoiOOSPYcK269thQzzLnjWD8WYoYS+g
 pYXHymxEKwmkZXDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788530302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AUpgHYyaDQ/ARga5vu0u3a5tsUK3+J2E329GTs2nP8c=;
 b=jhknVo8QyWJs5w0NTQCggT4RQgfD0EbzWScrXDbna+k508kAqKp29NAaL7KxCCrADwy7iV
 B07EwnWKNJItLBrq6TJ1ZG3HCeglBRXkXwPAaQ+tv6kmAgo0cg+vcf8mpCfNxfmV5zL0kO
 dg5B76uQ4sEPLxAKDWVcITCX7R+F//I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788530302;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AUpgHYyaDQ/ARga5vu0u3a5tsUK3+J2E329GTs2nP8c=;
 b=eDW0RtpTY1si2HxUgvy1MeLut9Lf1VgSqmKlCmbpUKdLDCfU8YHEAMoiCuqp1J/q7bzNLf
 xMJbgxcRCH7kSjCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E04D013678;
 Fri,  4 Sep 2026 13:58:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v68ELH3OmmpfKQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 04 Sep 2026 13:58:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH 16/18] migration: Add capabilities into MigrationParameters
In-Reply-To: <871pb99waz.fsf@pond.sub.org>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-17-farosas@suse.de> <871pb99waz.fsf@pond.sub.org>
Date: Fri, 04 Sep 2026 10:58:11 -0300
Message-ID: <87se3p6rv0.fsf@suse.de>
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
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Add capabilities to MigrationParameters. This structure will hold all
>> migration options. Capabilities will go away in the next patch.
>>
>> From this point on, both QMP and HMP versions of
>> migrate-set-parameters and query-migrate-parameters gain the ability
>> to work with capabilities.
>>
>> With MigrationParameters now having members for each capability, the
>> migration capabilities commands (query-migrate-capabilities,
>> migrate-set-capabilities) will soon be deprecated. Add a set of
>> helpers to convert between the old MigrationCapability representation
>> and the new representation as members of MigrationParameters.
>>
>> Acked-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/migration.c |   8 +++
>>  migration/options.c   | 127 ++++++++++++++++++++++++++++++++++++++++++
>>  migration/options.h   |   5 ++
>>  qapi/migration.json   | 118 ++++++++++++++++++++++++++++++++++++++-
>>  4 files changed, 255 insertions(+), 3 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index dab282dd2f3..c8e7e86ea05 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -4086,6 +4086,14 @@ static bool migration_object_check(MigrationState *ms, Error **errp)
>>          return false;
>>      }
>>  
>> +    /*
>> +     * FIXME: Temporarily while -global capabilties are still using
>> +     * s->capabilities. Will be gone by the end of the series.
>> +     */
>> +    for (int i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
>> +        migrate_capability_set_compat(&ms->parameters, i, ms->capabilities[i]);
>> +    }
>> +
>>      return migrate_caps_check(old_caps, ms->capabilities, errp);
>>  }
>>  
>> diff --git a/migration/options.c b/migration/options.c
>> index f988b181f0e..7c638e204a1 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -778,6 +778,108 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>>      return true;
>>  }
>>  
>> +static bool *migrate_capability_get_addr(MigrationParameters *params, int i)
>> +{
>> +    bool *cap_addr = NULL;
>> +
>> +    switch (i) {
>> +    case MIGRATION_CAPABILITY_XBZRLE:
>> +        cap_addr = &params->xbzrle;
>> +        break;
>> +    case MIGRATION_CAPABILITY_RDMA_PIN_ALL:
>> +        cap_addr = &params->rdma_pin_all;
>> +        break;
>> +    case MIGRATION_CAPABILITY_AUTO_CONVERGE:
>> +        cap_addr = &params->auto_converge;
>> +        break;
>> +    case MIGRATION_CAPABILITY_EVENTS:
>> +        cap_addr = &params->events;
>> +        break;
>> +    case MIGRATION_CAPABILITY_POSTCOPY_RAM:
>> +        cap_addr = &params->postcopy_ram;
>> +        break;
>> +    case MIGRATION_CAPABILITY_X_COLO:
>> +        cap_addr = &params->x_colo;
>> +        break;
>> +    case MIGRATION_CAPABILITY_RELEASE_RAM:
>> +        cap_addr = &params->release_ram;
>> +        break;
>> +    case MIGRATION_CAPABILITY_RETURN_PATH:
>> +        cap_addr = &params->return_path;
>> +        break;
>> +    case MIGRATION_CAPABILITY_PAUSE_BEFORE_SWITCHOVER:
>> +        cap_addr = &params->pause_before_switchover;
>> +        break;
>> +    case MIGRATION_CAPABILITY_MULTIFD:
>> +        cap_addr = &params->multifd;
>> +        break;
>> +    case MIGRATION_CAPABILITY_DIRTY_BITMAPS:
>> +        cap_addr = &params->dirty_bitmaps;
>> +        break;
>> +    case MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME:
>> +        cap_addr = &params->postcopy_blocktime;
>> +        break;
>> +    case MIGRATION_CAPABILITY_LATE_BLOCK_ACTIVATE:
>> +        cap_addr = &params->late_block_activate;
>> +        break;
>> +    case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
>> +        cap_addr = &params->x_ignore_shared;
>> +        break;
>> +    case MIGRATION_CAPABILITY_VALIDATE_UUID:
>> +        cap_addr = &params->validate_uuid;
>> +        break;
>> +    case MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT:
>> +        cap_addr = &params->background_snapshot;
>> +        break;
>> +    case MIGRATION_CAPABILITY_ZERO_COPY_SEND:
>> +        cap_addr = &params->zero_copy_send;
>> +        break;
>> +    case MIGRATION_CAPABILITY_POSTCOPY_PREEMPT:
>> +        cap_addr = &params->postcopy_preempt;
>> +        break;
>> +    case MIGRATION_CAPABILITY_SWITCHOVER_ACK:
>> +        cap_addr = &params->switchover_ack;
>> +        break;
>> +    case MIGRATION_CAPABILITY_DIRTY_LIMIT:
>> +        cap_addr = &params->dirty_limit;
>> +        break;
>> +    case MIGRATION_CAPABILITY_MAPPED_RAM:
>> +        cap_addr = &params->mapped_ram;
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>
> I'd use an array instead of a switch.  Matter of taste.
>
>> +
>> +    return cap_addr;
>> +}
>> +
>> +/* Compatibility for code that reads capabilities in a loop */
>> +bool migrate_capability_get_compat(MigrationParameters *params, int i)
>> +{
>> +    return *(migrate_capability_get_addr(params, i));
>> +}
>> +
>> +/* Compatibility for code that writes capabilities in a loop */
>> +void migrate_capability_set_compat(MigrationParameters *params, int i, bool val)
>> +{
>> +    *(migrate_capability_get_addr(params, i)) = val;
>> +}
>> +
>> +/*
>> + * Set capabilities for compatibility with the old
>> + * migrate-set-capabilities command.
>> + */
>> +void migrate_capabilities_set_compat(MigrationParameters *params,
>> +                                     MigrationCapabilityStatusList *caps)
>> +{
>> +    MigrationCapabilityStatusList *cap;
>> +
>> +    for (cap = caps; cap; cap = cap->next) {
>> +        migrate_capability_set_compat(params, cap->value->capability,
>> +                                      cap->value->state);
>> +    }
>> +}
>> +
>>  MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
>>  {
>>      MigrationCapabilityStatusList *head = NULL, **tail = &head;
>> @@ -819,6 +921,8 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
>>      for (cap = params; cap; cap = cap->next) {
>>          s->capabilities[cap->value->capability] = cap->value->state;
>>      }
>> +
>> +    migrate_capabilities_set_compat(&s->parameters, params);
>>  }
>>  
>>  /* parameters */
>> @@ -1141,6 +1245,15 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
>>          &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
>>          &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
>>          &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
>> +        &p->has_xbzrle, &p->has_rdma_pin_all,
>> +        &p->has_auto_converge, &p->has_events,
>> +        &p->has_postcopy_ram, &p->has_x_colo, &p->has_release_ram,
>> +        &p->has_return_path, &p->has_pause_before_switchover, &p->has_multifd,
>> +        &p->has_dirty_bitmaps, &p->has_postcopy_blocktime,
>> +        &p->has_late_block_activate, &p->has_x_ignore_shared,
>> +        &p->has_validate_uuid, &p->has_background_snapshot,
>> +        &p->has_zero_copy_send, &p->has_postcopy_preempt,
>> +        &p->has_switchover_ack, &p->has_dirty_limit, &p->has_mapped_ram,
>>      };
>>  
>>      for (int i = 0; i < ARRAY_SIZE(has_fields); i++) {
>> @@ -1465,6 +1578,20 @@ void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
>>      tls_opt_to_str(input->tls_hostname);
>>      tls_opt_to_str(input->tls_authz);
>>  
>> +    /*
>> +     * FIXME: Temporarily while migrate_caps_check is not
>> +     * converted to look at s->parameters. Will be gone the end of
>> +     * the series.
>> +     */
>> +    bool new_caps[MIGRATION_CAPABILITY__MAX] = { 0 };
>> +    for (int i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
>> +        new_caps[i] = migrate_capability_get_compat(cur, i);
>> +    }
>> +    if (!migrate_caps_check(migrate_get_current()->capabilities, new_caps,
>> +                            errp)) {
>> +        return;
>> +    }
>> +
>>      /* merge input on top of current */
>>      if (!migrate_params_merge(cur, input, &new, errp)) {
>>          return;
>> diff --git a/migration/options.h b/migration/options.h
>> index c7da2d0b5b0..eedd1aa1f93 100644
>> --- a/migration/options.h
>> +++ b/migration/options.h
>> @@ -94,4 +94,9 @@ uint64_t migrate_rdma_chunk_size(void);
>>  bool migrate_params_check(MigrationParameters *params, Error **errp);
>>  void migrate_params_init(MigrationParameters *params);
>>  bool migrate_params_free(MigrationParameters *params, Error **errp);
>> +bool migrate_capability_get_compat(MigrationParameters *params, int i);
>> +void migrate_capability_set_compat(MigrationParameters *params, int i,
>> +                                   bool val);
>> +void migrate_capabilities_set_compat(MigrationParameters *params,
>> +                                     MigrationCapabilityStatusList *caps);
>>  #endif
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 78c6e933cf1..7952ef44db9 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -976,10 +976,101 @@
>>  #     Must be set to the same value on both source and destination
>>  #     before migration starts.  (Since 11.1)
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
>> +# @events: Generate events for each migration state change.
>> +#     (since 2.4)
>> +#
>> +# @auto-converge: If enabled, QEMU will automatically throttle down
>> +#     the guest to speed up convergence of RAM migration.  (since 1.6)
>> +#
>> +# @postcopy-ram: Start executing on the migration target before all of
>> +#     RAM has been migrated, pulling the remaining pages along as
>> +#     needed.  The capacity must have the same setting on both source
>> +#     and target or migration will not even start.  **Note:** If the
>> +#     migration fails during postcopy the VM will fail.  (since 2.6)
>> +#
>> +# @x-colo: If enabled, migration will never end, and the state of the
>> +#     VM on the primary side will be migrated continuously to the VM
>> +#     on secondary side, this process is called COarse-Grain LOck
>> +#     Stepping (COLO) for Non-stop Service.  (since 2.8)
>> +#
>> +# @release-ram: If enabled, QEMU will free the migrated ram pages on
>> +#     the source during postcopy-ram migration.  (since 2.9)
>> +#
>> +# @return-path: If enabled, migration will use the return path even
>> +#     for precopy.  (since 2.10)
>> +#
>> +# @pause-before-switchover: Pause outgoing migration before
>> +#     serialising device state and before disabling block IO.
>> +#     (since 2.11)
>> +#
>> +# @multifd: Use more than one fd for migration.  (since 4.0)
>> +#
>> +# @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps.
>> +#     (since 2.12)
>> +#
>> +# @postcopy-blocktime: Calculate downtime for postcopy live migration.
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
>> -# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
>> -#     @x-vcpu-dirty-limit-period are experimental.
>> +# @unstable: Members @x-checkpoint-delay, @x-vcpu-dirty-limit-period,
>> +#     @x-colo, @x-ignore-shared and @x-rdma-chunk-size are
>> +#     experimental.
>
> This isn't a clean copy from MigrationCapability.  Why?
>

I blundered.

>>  #
>>  # Since: 2.4
>>  ##
>> @@ -1017,7 +1108,28 @@
>>              '*direct-io': 'bool',
>>              '*x-rdma-chunk-size': { 'type': 'uint64',
>>                                      'features': [ 'unstable' ] },
>> -            '*cpr-exec-command': [ 'str' ]} }
>> +            '*cpr-exec-command': [ 'str' ],
>> +            '*xbzrle': 'bool',
>> +            '*rdma-pin-all': 'bool',
>> +            '*auto-converge': 'bool',
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
>>  
>>  ##
>>  # @query-migrate-parameters:

