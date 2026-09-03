Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F12C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Cj6-0004nq-Se; Thu, 03 Sep 2026 15:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2Cj5-0004nK-5S
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:03:55 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2Cj2-0002Ea-W2
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:03:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 16AC61FFC6;
 Thu,  3 Sep 2026 19:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788462227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4GK0XMOe/2MteNLMqkEaIIvtNOxu4eE6fZksC5ST9x8=;
 b=1bDafyLlRkBB27ARRXeyMl3aQI7wmLobwCPDPnE2wxlz4vCBdBZTSuiAdi0gIs6ZCPU7cg
 p53c4FlDepcWD1fWvR8vXf3w97m6vZghXxHyY9RGgYsrPnY+CEiv8JGyLYY61utuXS3vcm
 Gv+CD9J33UlT9TpFxufV/BsBaiquXM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788462227;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4GK0XMOe/2MteNLMqkEaIIvtNOxu4eE6fZksC5ST9x8=;
 b=Vvub+hUKFboiPRGS4dC0tmcog40alRlju0FafXJjdml3AaQWJrPrR/ZHWCIgmE6F1YIWxy
 IAr+nP1enh7tD4Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788462223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4GK0XMOe/2MteNLMqkEaIIvtNOxu4eE6fZksC5ST9x8=;
 b=P/5cWyqPStgsmk/JydRVLdvb/CI01ZGi/57G7AQwStG13lw9gbjrEfz1wafoQuegUs20Ei
 6LDqafFoEBRRot7ujYttg/2n0lnJXIKD0rvfeNxkWA1GgNia5aVGHbUc/xzYwV2PSp5+T1
 d0MQxRK7lbOlFSDAn4MZRLYGXbrnJL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788462223;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4GK0XMOe/2MteNLMqkEaIIvtNOxu4eE6fZksC5ST9x8=;
 b=T8mYSxHig4hRouyRzixOwk+eoHJNZy34H9D5GLkriWiv14p1nCWh+y/x/xtz0UIUhq9LCY
 8wZMqlhGCol7zcCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F31913869;
 Thu,  3 Sep 2026 19:03:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZxExGI7EmWoBJQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 03 Sep 2026 19:03:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 05/18] migration: Merge parameter structs instead of
 assigning one by one
In-Reply-To: <apm6h1ueJOL5zHyD@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-6-farosas@suse.de> <apm6h1ueJOL5zHyD@x1.local>
Date: Thu, 03 Sep 2026 16:03:35 -0300
Message-ID: <875x0m88e0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Sep 02, 2026 at 07:15:33PM -0300, Fabiano Rosas wrote:
>> Convert the code in migrate_params_test_apply() from an open-coded
>> copy of every migration parameter to a merge operation using QAPI
>> visitors and QDict.
>> 
>> The purpose of that routine is to update a temporary structure
>> (pre-populated with the current migration parameters), with the values
>> received from the user via QAPI. As a result, the temporary structure
>> will then contain the "to be applied" parameters and it's validated
>> before being used to overwrite the parameters currently in use.
>> 
>> The update is currently done as follows:
>> 
>> where 'params' is the user input from QAPI,
>> for each parameter:
>> 
>>   a) check if the option is present
>>      params->has_<name> == true
>>      params-><name> != NULL // for strings
>> 
>>   b) if the parameter is a pointer, free the to-be-assigned member and
>>      allocate memory for the copy from params
>> 
>>   c) assign the user provided value to the temporary structure.
>> 
>> Step (a) is the same in principle as what the QAPI visitors do at
>> visit_type_MigrationParameters_members().
>> 
>> Steps (b) and (c) are roughly the same as what the QDict
>> implementation does when qdict_del() and qdict_put_obj() are combined.
>> 
>> Therefore, replace the open-coded function with
>> migrate_params_merge(), which achieves the same goal, but uses
>> visitors and QDict. This hides the details of QAPI (has_*) from the
>> migration code and avoids the need to update
>> migrate_params_test_apply() every time a new migration parameter is
>> added.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Nice,
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> Nitpicks only, inline,
>
>> ---
>>  migration/options.c | 201 +++++++++++++++-----------------------------
>>  1 file changed, 66 insertions(+), 135 deletions(-)
>> 
>> diff --git a/migration/options.c b/migration/options.c
>> index 6b787950808..de091d2eee3 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -20,6 +20,9 @@
>>  #include "qapi/qapi-commands-migration.h"
>>  #include "qapi/qapi-visit-migration.h"
>>  #include "qapi/qmp/qerror.h"
>> +#include "qapi/qobject-input-visitor.h"
>> +#include "qapi/qobject-output-visitor.h"
>> +#include "qobject/qdict.h"
>>  #include "qobject/qnull.h"
>>  #include "system/runstate.h"
>>  #include "migration/colo.h"
>> @@ -1074,6 +1077,28 @@ static void tls_opt_to_str(StrOrNull *opt)
>>      opt->u.s = g_strdup("");
>>  }
>>  
>> +static QDict *migrate_params_to_dict(MigrationParameters *p, Error **errp)
>> +{
>> +    QObject *obj = NULL;
>> +    Visitor *v = qobject_output_visitor_new(&obj);
>> +
>> +    if (visit_type_MigrationParameters(v, NULL, &p, errp)) {
>> +        visit_complete(v, &obj);
>> +    }
>> +    visit_free(v);
>> +    return qobject_to(QDict, obj);
>> +}
>> +
>> +static MigrationParameters *migrate_params_from_dict(QDict *d, Error **errp)
>> +{
>> +    Visitor *v = qobject_input_visitor_new(QOBJECT(d));
>> +    MigrationParameters *tmp = NULL;
>> +
>> +    visit_type_MigrationParameters(v, NULL, &tmp, errp);
>> +    visit_free(v);
>> +    return tmp;
>> +}
>> +
>>  /*
>>   * query-migrate-parameters expects all members of MigrationParameters
>>   * to be present, but we cannot mark them non-optional in QAPI because
>> @@ -1166,6 +1191,39 @@ static void migrate_post_update_params(MigrationParameters *new, Error **errp)
>>      }
>>  }
>>  
>> +static bool migrate_params_merge(MigrationParameters *in1,
>> +                                 MigrationParameters *in2,
>
> Perhaps rename in1/in2/d1/d2 similarly with "cur" / "new" / ..?  As in1 and
> in2 are not equal: when merge it only overwrites in1 with in2, not vice
> versa.
>

Hm, let me google around, there might be some terms that fit here. Like
'base' and ... something else.

>> +                                 MigrationParameters **out,
>> +                                 Error **errp)
>> +{
>> +    g_autoptr(QDict) d1 = NULL;
>> +    g_autoptr(QDict) d2 = NULL;
>> +    const QDictEntry *e;
>> +
>> +    d1 = migrate_params_to_dict(in1, errp);
>> +    if (!d1) {
>> +        return false;
>> +    }
>> +
>> +    d2 = migrate_params_to_dict(in2, errp);
>> +    if (!d2) {
>> +        return false;
>> +    }
>> +
>> +    for (e = qdict_first(d2); e; e = qdict_next(d2, e)) {
>> +        const char *key = qdict_entry_key(e);
>> +        QObject *value = qdict_entry_value(e);
>> +
>> +        qdict_del(d1, key);
>
> IIUC this line can be dropped due to a smart enough qdict_put_obj().
>

There is a very obvious reason to keep it. I just don't remember what it
is. I'll check.

>> +        qobject_ref(value);
>> +        qdict_put_obj(d1, key, value);
>> +    }
>> +
>> +    *out = migrate_params_from_dict(d1, errp);
>> +
>> +    return !!*out;
>> +}
>> +
>>  /*
>>   * Check whether the parameters are valid. Error will be put into errp
>>   * (if provided). Return true if valid, otherwise false.
>> @@ -1328,133 +1386,6 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>>      return true;
>>  }
>>  
>> -static void migrate_params_test_apply(MigrationParameters *params,
>> -                                      MigrationParameters *dest)
>> -{
>> -    MigrationState *s = migrate_get_current();
>> -
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
>> -    }
>> -
>> -    if (params->has_cpu_throttle_tailslow) {
>> -        dest->cpu_throttle_tailslow = params->cpu_throttle_tailslow;
>> -    }
>> -
>> -    if (params->tls_creds) {
>> -        qapi_free_StrOrNull(dest->tls_creds);
>> -        dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
>> -    }
>> -
>> -    if (params->tls_hostname) {
>> -        qapi_free_StrOrNull(dest->tls_hostname);
>> -        dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
>> -    }
>> -
>> -    if (params->tls_authz) {
>> -        qapi_free_StrOrNull(dest->tls_authz);
>> -        dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
>> -    }
>> -
>> -    if (params->has_max_bandwidth) {
>> -        dest->max_bandwidth = params->max_bandwidth;
>> -    }
>> -
>> -    if (params->has_avail_switchover_bandwidth) {
>> -        dest->avail_switchover_bandwidth = params->avail_switchover_bandwidth;
>> -    }
>> -
>> -    if (params->has_downtime_limit) {
>> -        dest->downtime_limit = params->downtime_limit;
>> -    }
>> -
>> -    if (params->has_x_checkpoint_delay) {
>> -        dest->x_checkpoint_delay = params->x_checkpoint_delay;
>> -    }
>> -
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
>> -        qapi_free_BitmapMigrationNodeAliasList(dest->block_bitmap_mapping);
>> -        dest->block_bitmap_mapping = QAPI_CLONE(BitmapMigrationNodeAliasList,
>> -                                                params->block_bitmap_mapping);
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
>> -
>> -    if (params->has_x_rdma_chunk_size) {
>> -        dest->x_rdma_chunk_size = params->x_rdma_chunk_size;
>> -    }
>> -
>> -    if (params->has_cpr_exec_command) {
>> -        qapi_free_strList(dest->cpr_exec_command);
>> -        dest->cpr_exec_command = QAPI_CLONE(strList, params->cpr_exec_command);
>> -    }
>> -}
>> -
>>  /*
>>   * Caller must ensure the has_* fields of @params are true so they all
>>   * get copied and the pointer members don't dangle.
>> @@ -1472,7 +1403,8 @@ static void migrate_params_apply(MigrationParameters *params)
>>  
>>  void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
>>  {
>> -    MigrationParameters new;
>> +    MigrationParameters *cur = &migrate_get_current()->parameters;
>> +    g_autoptr(MigrationParameters) new = NULL;
>>  
>>      /*
>>       * Convert QTYPE_QNULL and NULL to the empty string (""). Even
>> @@ -1486,14 +1418,13 @@ void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
>>      tls_opt_to_str(input->tls_hostname);
>>      tls_opt_to_str(input->tls_authz);
>>  
>> -    migrate_params_test_apply(input, &new);
>> +    /* merge input on top of current */
>> +    if (!migrate_params_merge(cur, input, &new, errp)) {
>> +        return;
>> +    }
>>  
>> -    if (migrate_params_check(&new, errp)) {
>> -        migrate_params_apply(&new);
>> +    if (migrate_params_check(new, errp)) {
>> +        migrate_params_apply(new);
>>          migrate_post_update_params(input, errp);
>>      }
>> -
>> -    migrate_tls_opts_free(&new);
>> -    qapi_free_BitmapMigrationNodeAliasList(new.block_bitmap_mapping);
>> -    qapi_free_strList(new.cpr_exec_command);
>>  }
>> -- 
>> 2.53.0
>> 

