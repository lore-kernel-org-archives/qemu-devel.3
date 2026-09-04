Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AD7C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2UAm-00064H-Ib; Fri, 04 Sep 2026 09:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2UAk-00063w-J5
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:41:38 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2UAi-0003pq-30
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:41:38 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DD21C1F79E;
 Fri,  4 Sep 2026 13:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788529289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hbLCHgGxmw96/GCDg75qnAJr1+Ywjrtye1H0BkhHhHo=;
 b=ZELbbRTIEz8TnVbds9SHyyAoY7Nd7IAh244KKuE61YM5Tz9tcH+fCtP9L0Rgt19kk8WVzv
 f9+Q795KGLuEnYugEmpshve0eZ4X5mfE42ZabKRj7vc0YxfmqrT5/+PnTB2h2afYjzAFmM
 K9epDi1JkWeMvc7TWJ+2Ht30WO1rw8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788529289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hbLCHgGxmw96/GCDg75qnAJr1+Ywjrtye1H0BkhHhHo=;
 b=9H2RowSr7EgbTbLB5TMnXFCpba9RDh4dRBfJydfVxWlSjYQ/NK1yQr4EohIbGSm0PFiBs7
 BD6h/HNcoNfjcEDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788529284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hbLCHgGxmw96/GCDg75qnAJr1+Ywjrtye1H0BkhHhHo=;
 b=cgN1hnViwm6lC0PILqe3pRbiN1TictbxoaRxWLwCZwhmxirDZ/m/svzDysQEvicMgfrm/S
 /JbhSraeja8cCrNHhrZYTeUUofMKTdRNpNbBK5Rnxp8085HnT9ZA47Fkq79UprnpeXFGhT
 /W0gpKjrzv2+OVsVriidIL0ueG6VDEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788529284;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hbLCHgGxmw96/GCDg75qnAJr1+Ywjrtye1H0BkhHhHo=;
 b=L9JPIWL9OzQmbNTEV0PFJQnaSnssJaraMhLeFwD8g579aacKheVT2yYa5xoshZyWddAa+P
 s/jWKQXtxzzoDUAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE46F13678;
 Fri,  4 Sep 2026 13:41:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lzyKI4PKmmo1GAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 04 Sep 2026 13:41:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 13/18] migration: Use output visitor in info command
In-Reply-To: <apqzsh7pIkmKTYYg@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-14-farosas@suse.de> <apqzsh7pIkmKTYYg@x1.local>
Date: Fri, 04 Sep 2026 10:41:21 -0300
Message-ID: <87zexx6sn2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

> On Wed, Sep 02, 2026 at 07:15:41PM -0300, Fabiano Rosas wrote:
>> The hmp_info_migrate_parameters function currently open-codes the
>> mon_printf calls for each migration parameter. As with the set command
>> in the last patch, this should not be necessary as the QAPI
>> infrastructure already has generated code that takes type and struct
>> member names into account, including converting _ from C into the '-'
>> character as part of parameter names strings.
>> 
>> The current code is also quite painful to rebase if a series has been
>> carried for a long time while parameters have been added in master.
>> 
>> Replace all of this with a conversion from MigrationParameters to
>> QDict using an output visitor and a loop over the QDict that prints
>> per-QAPI-type formatted strings.
>> 
>> Modelled after block/qapi.c:dump_qobject, but with some changes to
>> keep the migration command output formatting.
>> 
>> Note that this was not a for-free improvement, the HMP command format
>> output was changed incompatibly in a previous patch. It doesn't output
>> units anymore.
>
> IIUC both qlist and qdict are only used in BitmapMigrationNodeAlias only.
> It would be nice to attach an example of HMP dump before/after the change
> of these two patches, either in previous patch or here (assuming the layout
> changed once).  In case HMP has some suggestion in general, I suggest copy
> Dave when repost in case he has something to say.
>

Will do.

>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/migration-hmp-cmds.c | 243 ++++++++++++++-------------------
>>  1 file changed, 100 insertions(+), 143 deletions(-)
>> 
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> index 089c6d4ff46..dff69650a0c 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -25,7 +25,12 @@
>>  #include "qapi/qapi-commands-migration.h"
>>  #include "qapi/qapi-visit-migration.h"
>>  #include "qapi/qobject-input-visitor.h"
>> +#include "qapi/qobject-output-visitor.h"
>> +#include "qobject/qbool.h"
>>  #include "qobject/qdict.h"
>> +#include "qobject/qjson.h"
>> +#include "qobject/qlist.h"
>> +#include "qobject/qnum.h"
>>  #include "qobject/qstring.h"
>>  #include "qapi/string-input-visitor.h"
>>  #include "qapi/string-output-visitor.h"
>> @@ -316,170 +321,122 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
>>      qapi_free_MigrationCapabilityStatusList(caps);
>>  }
>>  
>> -static void monitor_print_cpr_exec_command(Monitor *mon, strList *args)
>> +static QDict *migrate_params_to_dict(MigrationParameters *p, Error **errp)
>>  {
>> -    monitor_printf(mon, "%s:",
>> -        MigrationParameter_str(MIGRATION_PARAMETER_CPR_EXEC_COMMAND));
>> +    QObject *obj = NULL;
>> +    Visitor *v = qobject_output_visitor_new(&obj);
>>  
>> -    while (args) {
>> -        monitor_printf(mon, " %s", args->value);
>> -        args = args->next;
>> +    if (visit_type_MigrationParameters(v, NULL, &p, errp)) {
>> +        visit_complete(v, &obj);
>>      }
>> -    monitor_printf(mon, "\n");
>> +    visit_free(v);
>> +    return qobject_to(QDict, obj);
>>  }
>
> This exact function also exists in options.c (with the same name and
> impl).  Can reuse.
>

Of course! I just forgot to do it. Thanks.

>>  
>> -void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>> +static void hmp_migrate_print_qobject(Monitor *mon, const char *label,
>> +                                      QObject *obj)
>>  {
>> -    MigrationParameters *params;
>> -    MigrationState *s = migrate_get_current();
>> +    const char *sep;
>>  
>> -    params = qmp_query_migrate_parameters(NULL);
>> +    if (!obj) {
>> +        return;
>> +    }
>>  
>> -    if (params) {
>> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_INITIAL),
>> -            params->announce_initial);
>> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_MAX),
>> -            params->announce_max);
>> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_ROUNDS),
>> -            params->announce_rounds);
>> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_STEP),
>> -            params->announce_step);
>> -        assert(params->has_throttle_trigger_threshold);
>> -        monitor_printf(mon, "%s: %u\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD),
>> -            params->throttle_trigger_threshold);
>> -        assert(params->has_cpu_throttle_initial);
>> -        monitor_printf(mon, "%s: %u\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL),
>> -            params->cpu_throttle_initial);
>> -        assert(params->has_cpu_throttle_increment);
>> -        monitor_printf(mon, "%s: %u\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT),
>> -            params->cpu_throttle_increment);
>> -        assert(params->has_cpu_throttle_tailslow);
>> -        monitor_printf(mon, "%s: %s\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW),
>> -            params->cpu_throttle_tailslow ? "on" : "off");
>> -        assert(params->has_max_cpu_throttle);
>> -        monitor_printf(mon, "%s: %u\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
>> -            params->max_cpu_throttle);
>> -        assert(params->tls_creds);
>> -        monitor_printf(mon, "%s: %s\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
>> -                       params->tls_creds->u.s);
>> -        assert(params->tls_hostname);
>> -        monitor_printf(mon, "%s: %s\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
>> -                       params->tls_hostname->u.s);
>> -        assert(params->tls_authz);
>> -        monitor_printf(mon, "%s: %s\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
>> -                       params->tls_authz->u.s);
>> -        assert(params->has_max_bandwidth);
>> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
>> -            params->max_bandwidth);
>> -        assert(params->has_avail_switchover_bandwidth);
>> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH),
>> -            params->avail_switchover_bandwidth);
>> -        assert(params->has_max_postcopy_bandwidth);
>> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
>> -            params->max_postcopy_bandwidth);
>> -        assert(params->has_downtime_limit);
>> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
>> -            params->downtime_limit);
>> -        assert(params->has_x_checkpoint_delay);
>> -        monitor_printf(mon, "%s: %u\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELAY),
>> -            params->x_checkpoint_delay);
>> -        monitor_printf(mon, "%s: %u\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
>> -            params->multifd_channels);
>> -        monitor_printf(mon, "%s: %s\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESSION),
>> -            MultiFDCompression_str(params->multifd_compression));
>> -        assert(params->has_zero_page_detection);
>> -        monitor_printf(mon, "%s: %s\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_ZERO_PAGE_DETECTION),
>> -            qapi_enum_lookup(&ZeroPageDetection_lookup,
>> -                params->zero_page_detection));
>> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
>> -            params->xbzrle_cache_size);
>> +    /*
>> +     * Put a space after labels
>> +     * foo: bar
>> +     *     ^
>> +     */
>> +    if (label && label[0] && label[strlen(label) - 1] == ':') {
>> +        sep = " ";
>> +    } else {
>> +        sep = "";
>> +    }
>>  
>> -        if (s->has_block_bitmap_mapping) {
>> -            BitmapMigrationNodeAliasList *nal;
>> -            BitmapMigrationNodeAlias *na;
>> -            BitmapMigrationBitmapAliasList *bal;
>> -            BitmapMigrationBitmapAlias *ba;
>> -            BitmapMigrationBitmapAliasTransform *bat;
>> +    switch (qobject_type(obj)) {
>> +    case QTYPE_NONE:
>> +        g_assert_not_reached();
>> +    case QTYPE_QNULL:
>> +        break;
>
> Shall we assert too if we don't expect it?
>

Could be, I'll check.

>> +    case QTYPE_QNUM: {
>> +        int64_t i64;
>>  
>> -            monitor_printf(mon, "%s:",
>> -                           MigrationParameter_str(
>> -                               MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING));
>> +        if (qnum_get_try_int(qobject_to(QNum, obj), &i64)) {
>> +            monitor_printf(mon, "%s%s%" PRId64, label, sep, i64);
>
> Should we use qnum_to_string() like what dump_qobject() does?
>

I missed that helper, let me see.

> Logically any size/u64 parameter (which may not be a normal use case..) can
> be set larger than INT64_MAX, so qnum_get_try_int() may return false? Here
> skipping to print anything is benign if it only happens with a malicious
> monitor client, but I think we should try to capture all cases.
>

Yeah, makes sense.

>> +        }
>> +        break;
>> +    }
>> +    case QTYPE_QSTRING: {
>> +        QString *str = qobject_to(QString, obj);
>>  
>> -            for (nal = params->block_bitmap_mapping; nal; nal = nal->next)
>> -            {
>> -                na = nal->value;
>> -                monitor_printf(mon, " bitmaps:");
>> -                for (bal = na->bitmaps; bal; bal = bal->next) {
>> -                    ba = bal->value;
>> -                    bat = ba->transform;
>> +        if (str) {
>
> Any chance str==NULL here?
>

Yes. But I get your point, see below.

>> +            monitor_printf(mon, "%s%s%s", label, sep, qstring_get_str(str));
>> +        }
>> +        break;
>> +    }
>> +    case QTYPE_QDICT: {
>> +        QDict *d = qobject_to(QDict, obj);
>> +        const QDictEntry *e;
>> +        int i = 0;
>>  
>> -                    monitor_printf(mon, " name: %s", ba->name);
>> -                    if (bat && bat->has_persistent) {
>> -                        if (bat->persistent) {
>> -                            monitor_printf(mon, " persistent: on");
>> -                        } else {
>> -                            monitor_printf(mon, " persistent: off");
>> -                        }
>> -                    }
>> -                    monitor_printf(mon, " alias: %s", ba->alias);
>> +        if (d) {
>> +            for (e = qdict_first(d); e; e = qdict_next(d, e), i++) {
>> +                g_autofree char *l = g_strdup_printf("%s:", qdict_entry_key(e));
>> +                if (i) {
>> +                    monitor_printf(mon, " ");
>>                  }
>> -                monitor_printf(mon, " node-name: %s alias: %s",
>> -                               na->node_name, na->alias);
>> +                hmp_migrate_print_qobject(mon, l, qdict_entry_value(e));
>>              }
>> -
>> -            monitor_printf(mon, "\n");
>>          }
>> +        break;
>> +    }
>> +    case QTYPE_QLIST: {
>> +        QList *l = qobject_to(QList, obj);
>> +        const QListEntry *e;
>>  
>> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
>> -        MigrationParameter_str(MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD),
>> -        params->x_vcpu_dirty_limit_period);
>> +        if (l) {
>> +            monitor_printf(mon, "%s", label);
>>  
>> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT),
>> -            params->vcpu_dirty_limit);
>> +            for (e = qlist_first(l); e; e = qlist_next(e)) {
>> +                /*
>> +                 * In the first iteration, this is the space after the
>> +                 * colon, otherwise it's the space between list
>> +                 * elements.
>> +                 */
>> +                monitor_printf(mon, " ");
>> +                hmp_migrate_print_qobject(mon, "", e->value);
>> +            }
>> +        }
>> +        break;
>> +    }
>> +    case QTYPE_QBOOL: {
>> +        QBool *b = qobject_to(QBool, obj);
>> +        if (b) {
>
> Similarly, I'd drop "if" if it will always happen, making qbool_get_bool()
> assert itself by deref.
>

I'd rather not have such asserts in user-facing code. Even with testing,
it's hard to ensure this 'obj' will reach here in integrity.

>> +            monitor_printf(mon, "%s%s%s", label, sep,
>> +                           qbool_get_bool(b) ? "on" : "off");
>> +        }
>> +        break;
>> +    }
>> +    default:
>> +        g_assert_not_reached();
>> +        break;
>> +    }
>> +}
>>  
>> -        assert(params->has_mode);
>> -        monitor_printf(mon, "%s: %s\n",
>> -            MigrationParameter_str(MIGRATION_PARAMETER_MODE),
>> -            qapi_enum_lookup(&MigMode_lookup, params->mode));
>> +void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>> +{
>> +    MigrationParameters *params = qmp_query_migrate_parameters(NULL);
>> +    g_autoptr(QDict) d;
>> +    const QDictEntry *e;
>>  
>> -        if (params->has_direct_io) {
>> -            monitor_printf(mon, "%s: %s\n",
>> -                           MigrationParameter_str(
>> -                               MIGRATION_PARAMETER_DIRECT_IO),
>> -                           params->direct_io ? "on" : "off");
>> -        }
>> +    assert(params);
>>  
>> -        if (params->has_x_rdma_chunk_size) {
>> -            monitor_printf(mon, "%s: %" PRIu64 "\n",
>> -                           MigrationParameter_str(
>> -                               MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE),
>> -                           params->x_rdma_chunk_size);
>> -        }
>> +    d = migrate_params_to_dict(params, NULL);
>> +    for (e = qdict_first(d); e; e = qdict_next(d, e)) {
>> +        g_autofree char *label = g_strdup_printf("%s:", qdict_entry_key(e));
>>  
>> -        assert(params->has_cpr_exec_command);
>> -        monitor_print_cpr_exec_command(mon, params->cpr_exec_command);
>> +        hmp_migrate_print_qobject(mon, label, qdict_entry_value(e));
>> +        monitor_printf(mon, "\n");
>>      }
>>  
>>      qapi_free_MigrationParameters(params);
>> -- 
>> 2.53.0
>> 

