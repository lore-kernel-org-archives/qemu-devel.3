Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79182C44522
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 12:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viXdo-0000iI-D1; Wed, 21 Jan 2026 07:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1viXXu-0003nw-S4
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:42:55 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1viXXs-0000dU-K8
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:42:50 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4A3DE33694;
 Wed, 21 Jan 2026 12:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768999365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TEaVS0Ph3Ub45z+siO3gxs5VV9yMq1w+Elygbddmz+o=;
 b=ToyQIoNOXbTsUUgqUqSAgse69luoVP8GsnKyvcUYJf3R+2kt0LwzQiWQU16ztaGhaltSl2
 LFfnmAFVAa2HVLduDHISAph+58uvyGV9W1O6qVuGF8CsYAfEXxTY3FzPZcIMVHZg2dt04R
 V9KPWnyDIEPBn+l86R7SxSkXszGH3Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768999365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TEaVS0Ph3Ub45z+siO3gxs5VV9yMq1w+Elygbddmz+o=;
 b=kCeKS8MxWehWiAcVk7hP3RJDyVrcguxYc7AGM/p8Cz2tTzs4UIicdXBJ/+wvaLWnNmG6zJ
 jUsYmfF6b1QBGDDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ToyQIoNO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kCeKS8Mx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768999365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TEaVS0Ph3Ub45z+siO3gxs5VV9yMq1w+Elygbddmz+o=;
 b=ToyQIoNOXbTsUUgqUqSAgse69luoVP8GsnKyvcUYJf3R+2kt0LwzQiWQU16ztaGhaltSl2
 LFfnmAFVAa2HVLduDHISAph+58uvyGV9W1O6qVuGF8CsYAfEXxTY3FzPZcIMVHZg2dt04R
 V9KPWnyDIEPBn+l86R7SxSkXszGH3Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768999365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TEaVS0Ph3Ub45z+siO3gxs5VV9yMq1w+Elygbddmz+o=;
 b=kCeKS8MxWehWiAcVk7hP3RJDyVrcguxYc7AGM/p8Cz2tTzs4UIicdXBJ/+wvaLWnNmG6zJ
 jUsYmfF6b1QBGDDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C48E03EA63;
 Wed, 21 Jan 2026 12:42:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rYkLIsTJcGk7fwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 21 Jan 2026 12:42:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, armbru@redhat.com
Subject: Re: [PATCH 2/5] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_apply
In-Reply-To: <CAE8KmOx-HbzqDGt12mMxNHcTocq2rWSrksgrns-PdHWCPDJacg@mail.gmail.com>
References: <20260114132309.5832-1-farosas@suse.de>
 <20260114132309.5832-3-farosas@suse.de>
 <CAE8KmOx-HbzqDGt12mMxNHcTocq2rWSrksgrns-PdHWCPDJacg@mail.gmail.com>
Date: Wed, 21 Jan 2026 09:42:42 -0300
Message-ID: <87a4y7kugt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4A3DE33694
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Wed, 14 Jan 2026 at 18:55, Fabiano Rosas <farosas@suse.de> wrote:
>> Instead of setting parameters one by one, use the temporary object,
>> which already contains the current migration parameters plus the new
>> ones and was just validated by migration_params_check(). Use cloning
>> to overwrite it.
>>
>> This avoids the need to alter this function every time a new parameter
>> is added.
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/options.c | 134 ++++----------------------------------------
>>  1 file changed, 12 insertions(+), 122 deletions(-)
>>
>> diff --git a/migration/options.c b/migration/options.c
>> index 994e1cc5ac..7a16119ff8 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -13,6 +13,7 @@
>>
>>  #include "qemu/osdep.h"
>>  #include "qemu/error-report.h"
>> +#include "qemu/main-loop.h"
>>  #include "exec/target_page.h"
>>  #include "qapi/clone-visitor.h"
>>  #include "qapi/error.h"
>> @@ -1384,132 +1385,21 @@ static void migrate_params_test_apply(MigrationParameters *params,
>>      }
>>  }
>>
>> +/*
>> + * Caller must ensure all has_* fields of @params are true to ensure
>> + * all fields get copied and the pointer members don't dangle.
>> + */
>
> * Maybe skip initial -> Caller must ensure - to avoid double usage of  'ensure'
>      "All has_* fields of @params must be true to ensure that they are
> copied ..."
>

ack

>>  static void migrate_params_apply(MigrationParameters *params)
>>  {
>>      MigrationState *s = migrate_get_current();
>> +    MigrationParameters *cur = &s->parameters;
>>
>> -    /* TODO use QAPI_CLONE() instead of duplicating it inline */
>> +    assert(bql_locked());
>
> * Why are we confirming that bql_lock is taken? Is it because we are
> updating a global MigrationState field (s->parameters)? IIUC
> 'migrate_params_apply' is called via QMP_ call, which is handled by
> the main thread, we don't generally update/write these parameters in
> any other threads (multifd, postcopy etc.).  
>

In general, I think that whenever we determine what protects a data
structure from concurrent access we should make it obvious. For the BQL
specifically, it's a known issue that it's an overloaded lock and the
places that need it are poorly documented.

So this assert is here to provide _some_ assurance that this routine is
protected. I don't think it is, btw, because I don't see anything
proving that migration_is_running() & friends are not succeptible to
TOCTOU bugs.

> /* I'm thinking if it was
> not checked before, why do we need it now? We are including the
> main-loop.h header for this as well. */

What happens is that smart people write code they can prove is correct
in their head and later other smart people - not living inside the first
person's head - change the code and establish their own correctness
proof inside their own heads. =)

>>
>> -    if (params->has_throttle_trigger_threshold) {
>> -        s->parameters.throttle_trigger_threshold = params->throttle_trigger_threshold;
>> -    }
>> -
>> -    if (params->has_cpu_throttle_initial) {
>> -        s->parameters.cpu_throttle_initial = params->cpu_throttle_initial;
>> -    }
>> -
>> -    if (params->has_cpu_throttle_increment) {
>> -        s->parameters.cpu_throttle_increment = params->cpu_throttle_increment;
>> -    }
>> -
>> -    if (params->has_cpu_throttle_tailslow) {
>> -        s->parameters.cpu_throttle_tailslow = params->cpu_throttle_tailslow;
>> -    }
>> -
>> -    if (params->tls_creds) {
>> -        qapi_free_StrOrNull(s->parameters.tls_creds);
>> -        s->parameters.tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
>> -    }
>> -
>> -    if (params->tls_hostname) {
>> -        qapi_free_StrOrNull(s->parameters.tls_hostname);
>> -        s->parameters.tls_hostname = QAPI_CLONE(StrOrNull,
>> -                                                params->tls_hostname);
>> -    }
>> -
>> -    if (params->tls_authz) {
>> -        qapi_free_StrOrNull(s->parameters.tls_authz);
>> -        s->parameters.tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
>> -    }
>> -
>> -    if (params->has_max_bandwidth) {
>> -        s->parameters.max_bandwidth = params->max_bandwidth;
>> -    }
>> -
>> -    if (params->has_avail_switchover_bandwidth) {
>> -        s->parameters.avail_switchover_bandwidth = params->avail_switchover_bandwidth;
>> -    }
>> -
>> -    if (params->has_downtime_limit) {
>> -        s->parameters.downtime_limit = params->downtime_limit;
>> -    }
>> -
>> -    if (params->has_x_checkpoint_delay) {
>> -        s->parameters.x_checkpoint_delay = params->x_checkpoint_delay;
>> -    }
>> -
>> -    if (params->has_multifd_channels) {
>> -        s->parameters.multifd_channels = params->multifd_channels;
>> -    }
>> -    if (params->has_multifd_compression) {
>> -        s->parameters.multifd_compression = params->multifd_compression;
>> -    }
>> -    if (params->has_multifd_qatzip_level) {
>> -        s->parameters.multifd_qatzip_level = params->multifd_qatzip_level;
>> -    }
>> -    if (params->has_multifd_zlib_level) {
>> -        s->parameters.multifd_zlib_level = params->multifd_zlib_level;
>> -    }
>> -    if (params->has_multifd_zstd_level) {
>> -        s->parameters.multifd_zstd_level = params->multifd_zstd_level;
>> -    }
>> -    if (params->has_xbzrle_cache_size) {
>> -        s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
>> -    }
>> -    if (params->has_max_postcopy_bandwidth) {
>> -        s->parameters.max_postcopy_bandwidth = params->max_postcopy_bandwidth;
>> -    }
>> -    if (params->has_max_cpu_throttle) {
>> -        s->parameters.max_cpu_throttle = params->max_cpu_throttle;
>> -    }
>> -    if (params->has_announce_initial) {
>> -        s->parameters.announce_initial = params->announce_initial;
>> -    }
>> -    if (params->has_announce_max) {
>> -        s->parameters.announce_max = params->announce_max;
>> -    }
>> -    if (params->has_announce_rounds) {
>> -        s->parameters.announce_rounds = params->announce_rounds;
>> -    }
>> -    if (params->has_announce_step) {
>> -        s->parameters.announce_step = params->announce_step;
>> -    }
>> -
>> -    if (params->has_block_bitmap_mapping) {
>> -        qapi_free_BitmapMigrationNodeAliasList(
>> -            s->parameters.block_bitmap_mapping);
>> -
>> -        s->has_block_bitmap_mapping = true;
>> -        s->parameters.block_bitmap_mapping =
>> -            QAPI_CLONE(BitmapMigrationNodeAliasList,
>> -                       params->block_bitmap_mapping);
>> -    }
>> -
>> -    if (params->has_x_vcpu_dirty_limit_period) {
>> -        s->parameters.x_vcpu_dirty_limit_period =
>> -            params->x_vcpu_dirty_limit_period;
>> -    }
>> -    if (params->has_vcpu_dirty_limit) {
>> -        s->parameters.vcpu_dirty_limit = params->vcpu_dirty_limit;
>> -    }
>> -
>> -    if (params->has_mode) {
>> -        s->parameters.mode = params->mode;
>> -    }
>> -
>> -    if (params->has_zero_page_detection) {
>> -        s->parameters.zero_page_detection = params->zero_page_detection;
>> -    }
>> -
>> -    if (params->has_direct_io) {
>> -        s->parameters.direct_io = params->direct_io;
>> -    }
>> -
>> -    if (params->has_cpr_exec_command) {
>> -        qapi_free_strList(s->parameters.cpr_exec_command);
>> -        s->parameters.cpr_exec_command =
>> -            QAPI_CLONE(strList, params->cpr_exec_command);
>> -    }
>> +    migrate_tls_opts_free(cur);
>> +    qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);
>> +    qapi_free_strList(cur->cpr_exec_command);
>> +    QAPI_CLONE_MEMBERS(MigrationParameters, cur, params);
>>  }
>>
>>  void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>> @@ -1539,7 +1429,7 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>>              migrate_get_current()->has_block_bitmap_mapping = true;
>>          }
>>
>> -        migrate_params_apply(params);
>> +        migrate_params_apply(&tmp);
>>          migrate_post_update_params(params, errp);
>>      }
>>
>> --
>
> * Change looks okay.
> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
>
> Thank you.
> ---
>   - Prasad

