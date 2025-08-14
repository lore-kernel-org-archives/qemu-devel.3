Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3419CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 15:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umZaw-00010S-5t; Thu, 14 Aug 2025 11:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umZau-0000yn-4a
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 11:10:20 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umZal-0003Wa-UT
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 11:10:19 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 695A521755;
 Thu, 14 Aug 2025 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755184206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4g7quqv37wnVy+Obx1N7uzRtgJ+WiPWqdkEbjJOBg/U=;
 b=g1W4Z9klR89iSE+Crd5rd+EJN45EPTxTlDj/pK9lPwDPA2Q273CpUPiL/2LeXE8zfh2ZJ5
 k+w4xWJC35LmLVaxRH4rTrmv2UafTt+jmTrEHtp+7cSKxz/uCeDWldJUlGTnBiAFRugP8f
 pkbmLYZtnjq4N07nKxaJH7xU3+0+14I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755184206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4g7quqv37wnVy+Obx1N7uzRtgJ+WiPWqdkEbjJOBg/U=;
 b=rHK11qApNh7zLyJzq0RA8xlN/5F4yuwiYPCr4ThhUdj5EwgXTY8pITlnGv6jq9+pwpTZOH
 5UPoFZWQ5ZZBmGCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qs7r04xO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tcDTpVlv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755184204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4g7quqv37wnVy+Obx1N7uzRtgJ+WiPWqdkEbjJOBg/U=;
 b=qs7r04xO7VQggr9WW8YEqo+bHB09aidvg+Gq4AQJ4YhML7xbVoeDJZD82W8Ne6uBiaRphN
 BABk3iI7XmENrE+8X1hZhTgb+GJ62FpnvNiIRCR870tOT+CJBMMpY+KvbuFjWF6H7cOZgx
 aeu6z/EHXt7P3GmuWLq793BvkxHA6Nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755184204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4g7quqv37wnVy+Obx1N7uzRtgJ+WiPWqdkEbjJOBg/U=;
 b=tcDTpVlvM0LQKh8Xq5GiFipBgHLpymuhOpGbhnWhAImcz7oPSdBSLfjR3WS8Tr2emFf5I9
 Npa+Tfbf67dxzkBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D43591368C;
 Thu, 14 Aug 2025 15:10:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Sf33I0v8nWgJCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 14 Aug 2025 15:10:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v2 14/24] migration: Use visitors in
 migrate_params_test_apply
In-Reply-To: <aJzv8hm87PVIOSLj@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-15-farosas@suse.de> <aJzv8hm87PVIOSLj@x1.local>
Date: Thu, 14 Aug 2025 12:10:01 -0300
Message-ID: <871ppe0wja.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:mid, suse.de:dkim, suse.de:email]
X-Rspamd-Queue-Id: 695A521755
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> On Mon, Jun 30, 2025 at 04:59:03PM -0300, Fabiano Rosas wrote:
>> Convert the code in migrate_params_test_apply() from an open-coded
>> copy of every migration parameter to a copy using visitors. The
>> current code has conditionals for each parameter's has_* field, which
>> is exactly what the visitors do.
>> 
>> This hides the details of QAPI from the migration code and avoids the
>> need to update migrate_params_test_apply() every time a new migration
>> parameter is added. Both were very confusing and while the visitor
>> code can become a bit involved, there is no need for new contributors
>> to ever touch it.
>> 
>> Change the name of the function to a more direct reference of what it
>> does: merging the user params with the temporary copy.
>> 
>> Move the QAPI_CLONE_MEMBERS into the caller, so QAPI_CLONE can be used
>> and there's no need to allocate memory in the migration
>> code. Similarly, turn 'tmp' into a pointer so the proper qapi_free_
>> routine can be used.
>> 
>> An extra call to migrate_mark_all_params_present() is now needed
>> because the visitors update the has_ field for non-present fields, but
>> we actually want them all set so migrate_params_apply() can copy all
>> of them.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/options.c | 157 +++++++++++++++-----------------------------
>>  1 file changed, 54 insertions(+), 103 deletions(-)
>> 
>> diff --git a/migration/options.c b/migration/options.c
>> index 6619b5f21a..695bec5b8f 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -20,6 +20,10 @@
>>  #include "qapi/qapi-commands-migration.h"
>>  #include "qapi/qapi-visit-migration.h"
>>  #include "qapi/qmp/qerror.h"
>> +#include "qapi/qobject-input-visitor.h"
>> +#include "qapi/qobject-output-visitor.h"
>> +#include "qapi/visitor.h"
>> +#include "qobject/qdict.h"
>>  #include "qobject/qnull.h"
>>  #include "system/runstate.h"
>>  #include "migration/colo.h"
>> @@ -1223,120 +1227,63 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>>      return true;
>>  }
>>  
>> -static void migrate_params_test_apply(MigrationParameters *params,
>> -                                      MigrationParameters *dest)
>> +static bool migrate_params_merge(MigrationParameters *dst,
>> +                                 MigrationParameters *src, Error **errp)
>>  {
>> -    MigrationState *s = migrate_get_current();
>> +    QObject *ret_out = NULL;
>> +    Visitor *v;
>> +    bool ok;
>>  
>> -    QAPI_CLONE_MEMBERS(MigrationParameters, dest, &s->parameters);
>> -
>> -    if (params->has_throttle_trigger_threshold) {
>> -        dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
>> -    }
>> -
>> -    if (params->has_cpu_throttle_initial) {
>> -        dest->cpu_throttle_initial = params->cpu_throttle_initial;
>> -    }
>> -
>> -    if (params->has_cpu_throttle_increment) {
>> -        dest->cpu_throttle_increment = params->cpu_throttle_increment;
>> +    /* free memory from pointers that are about to be assigned */
>> +    if (src->has_block_bitmap_mapping) {
>> +        qapi_free_BitmapMigrationNodeAliasList(dst->block_bitmap_mapping);
>
> There're quite a few similar cases like this one in this series (including
> the rest below parameters below), where we free stuff but keep the dangling
> pointer around for a while (..hopefully!)..
>
> Should we still try to reset the pointers?  Am I the only one that is
> nervous with it?
>

Yeah, no worries, I can clear them all just to be sure.

>>      }
>>  
>> -    if (params->has_cpu_throttle_tailslow) {
>> -        dest->cpu_throttle_tailslow = params->cpu_throttle_tailslow;
>> +    if (src->tls_creds) {
>> +        qapi_free_StrOrNull(dst->tls_creds);
>>      }
>>  
>> -    if (params->tls_creds) {
>> -        qapi_free_StrOrNull(dest->tls_creds);
>> -        dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
>> +    if (src->tls_hostname) {
>> +        qapi_free_StrOrNull(dst->tls_hostname);
>>      }
>>  
>> -    if (params->tls_hostname) {
>> -        qapi_free_StrOrNull(dest->tls_hostname);
>> -        dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
>> +    if (src->tls_authz) {
>> +        qapi_free_StrOrNull(dst->tls_authz);
>>      }
>>  
>> -    if (params->tls_authz) {
>> -        qapi_free_StrOrNull(dest->tls_authz);
>> -        dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
>> +    /* read in from src */
>> +    v = qobject_output_visitor_new(&ret_out);
>> +    ok = visit_type_MigrationParameters(v, NULL, &src, errp);
>> +    if (!ok) {
>> +        goto out;
>>      }
>> +    visit_complete(v, &ret_out);
>> +    visit_free(v);
>>  
>> -    if (params->has_max_bandwidth) {
>> -        dest->max_bandwidth = params->max_bandwidth;
>> +    /*
>> +     * Write to dst but leave existing fields intact (except for has_*
>> +     * which will be updated according to their presence in src).
>> +     */
>> +    v = qobject_input_visitor_new(ret_out);
>> +    ok = visit_start_struct(v, NULL, NULL, 0, errp);
>> +    if (!ok) {
>> +        goto out;
>>      }
>> -
>> -    if (params->has_avail_switchover_bandwidth) {
>> -        dest->avail_switchover_bandwidth = params->avail_switchover_bandwidth;
>> +    ok = visit_type_MigrationParameters_members(v, dst, errp);
>> +    if (!ok) {
>> +        goto out;
>>      }
>> -
>> -    if (params->has_downtime_limit) {
>> -        dest->downtime_limit = params->downtime_limit;
>> +    ok = visit_check_struct(v, errp);
>> +    visit_end_struct(v, NULL);
>> +    if (!ok) {
>> +        goto out;
>>      }
>>  
>> -    if (params->has_x_checkpoint_delay) {
>> -        dest->x_checkpoint_delay = params->x_checkpoint_delay;
>> -    }
>> +out:
>> +    visit_free(v);
>> +    qobject_unref(ret_out);
>
> IIUC this is essential the trick we used to play before QAPI_CLONE, before
> commit a15fcc3cf69e.
>
> https://lore.kernel.org/all/1465490926-28625-15-git-send-email-eblake@redhat.com/
>
> Yes, looks similar..
>
> QAPI_CLONE_MEMBERS() will copy everything, which we do not want here. We
> only want to copy where has_* is set.  So it's indeed a sligntly different
> request versus the current clone API.
>
> IIUC that can be implemented using a similar qapi clone visitor, however
> instead of g_memdup() on the structs/lists first (or in the case of
> QAPI_CLONE_MEMBERS, we did *dst=*src), we lazy copy all the fields.
>
> I wished this is a generic API we could use.  I think it means we'll
> maintain this ourselves.  Maybe it's OK.
>

I'm not sure how easy it is to provide a generic API for this. I don't
think there's much space for this code to change anyway, so is fine to
keep it in migration. I'll try to implement a
QAPI_CLONE_PRESENT_MEMBERS, let's see.

>>  
>> -    if (params->has_multifd_channels) {
>> -        dest->multifd_channels = params->multifd_channels;
>> -    }
>> -    if (params->has_multifd_compression) {
>> -        dest->multifd_compression = params->multifd_compression;
>> -    }
>> -    if (params->has_multifd_qatzip_level) {
>> -        dest->multifd_qatzip_level = params->multifd_qatzip_level;
>> -    }
>> -    if (params->has_multifd_zlib_level) {
>> -        dest->multifd_zlib_level = params->multifd_zlib_level;
>> -    }
>> -    if (params->has_multifd_zstd_level) {
>> -        dest->multifd_zstd_level = params->multifd_zstd_level;
>> -    }
>> -    if (params->has_xbzrle_cache_size) {
>> -        dest->xbzrle_cache_size = params->xbzrle_cache_size;
>> -    }
>> -    if (params->has_max_postcopy_bandwidth) {
>> -        dest->max_postcopy_bandwidth = params->max_postcopy_bandwidth;
>> -    }
>> -    if (params->has_max_cpu_throttle) {
>> -        dest->max_cpu_throttle = params->max_cpu_throttle;
>> -    }
>> -    if (params->has_announce_initial) {
>> -        dest->announce_initial = params->announce_initial;
>> -    }
>> -    if (params->has_announce_max) {
>> -        dest->announce_max = params->announce_max;
>> -    }
>> -    if (params->has_announce_rounds) {
>> -        dest->announce_rounds = params->announce_rounds;
>> -    }
>> -    if (params->has_announce_step) {
>> -        dest->announce_step = params->announce_step;
>> -    }
>> -
>> -    if (params->has_block_bitmap_mapping) {
>> -        dest->block_bitmap_mapping = params->block_bitmap_mapping;
>> -    }
>> -
>> -    if (params->has_x_vcpu_dirty_limit_period) {
>> -        dest->x_vcpu_dirty_limit_period =
>> -            params->x_vcpu_dirty_limit_period;
>> -    }
>> -    if (params->has_vcpu_dirty_limit) {
>> -        dest->vcpu_dirty_limit = params->vcpu_dirty_limit;
>> -    }
>> -
>> -    if (params->has_mode) {
>> -        dest->mode = params->mode;
>> -    }
>> -
>> -    if (params->has_zero_page_detection) {
>> -        dest->zero_page_detection = params->zero_page_detection;
>> -    }
>> -
>> -    if (params->has_direct_io) {
>> -        dest->direct_io = params->direct_io;
>> -    }
>> +    return ok;
>>  }
>>  
>>  static void migrate_params_apply(MigrationParameters *params)
>> @@ -1353,7 +1300,9 @@ static void migrate_params_apply(MigrationParameters *params)
>>  
>>  void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>>  {
>> -    MigrationParameters tmp;
>> +    MigrationState *s = migrate_get_current();
>> +    g_autoptr(MigrationParameters) tmp = QAPI_CLONE(MigrationParameters,
>> +                                                    &s->parameters);
>>  
>>      /*
>>       * Convert QTYPE_QNULL and NULL to the empty string (""). Even
>> @@ -1367,7 +1316,9 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>>      tls_opt_to_str(&params->tls_hostname);
>>      tls_opt_to_str(&params->tls_authz);
>>  
>> -    migrate_params_test_apply(params, &tmp);
>> +    if (!migrate_params_merge(tmp, params, errp)) {
>> +        return;
>> +    }
>>  
>>      /*
>>       * Mark block_bitmap_mapping as present now while we have the
>> @@ -1377,10 +1328,10 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>>          migrate_get_current()->has_block_bitmap_mapping = true;
>>      }
>>  
>> -    if (migrate_params_check(&tmp, errp)) {
>> -        migrate_params_apply(&tmp);
>> +    if (migrate_params_check(tmp, errp)) {
>> +        /* mark all present, so they're all copied */
>> +        migrate_mark_all_params_present(tmp);
>
> Ah, I just asked a question in the previous patch on what happens if some
> of the fields will be present.  Looks like this line is the answer?
>

Yes, it's either here, or via migrate_param_init().

> This isn't very obvious.  Maybe some comment in migrate_params_apply()
> would slightly help (which mentions it must be used when all parameters are
> set)?  Or some way to assert it?
>

Yep, I'll add more safeguards.

>> +        migrate_params_apply(tmp);
>>          migrate_post_update_params(params, errp);
>>      }
>> -
>> -    migrate_tls_opts_free(&tmp);
>>  }
>> -- 
>> 2.35.3
>> 

