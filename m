Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6943C982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7AgI-0000Si-Cl; Thu, 17 Sep 2026 07:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7AgH-0000SU-2I
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 07:53:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7AgE-0002GL-N9
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 07:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789646008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M2HQ8t9hMHeklk+IOjmhxfkPuMYwcIsEfyMMh78GZ6g=;
 b=G/FF+Q1N4uzVrIW09VTmwSPCBDLsEfxhbf7r8bk7RnmlNlvyPl9MHSiEGV/rW87jkmZa8+
 6xoRk0qSHEBmZrIw1niL+BGWYnG2hISAzQhE75k3aNUgEvZPjsg1xq82gZR9mH8qnhqfoW
 aPAe5aIAYatysxZsj5kw+qPf2adkfFo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-9cHgAllsMdmMWa66c5QsmA-1; Thu,
 17 Sep 2026 07:53:27 -0400
X-MC-Unique: 9cHgAllsMdmMWa66c5QsmA-1
X-Mimecast-MFC-AGG-ID: 9cHgAllsMdmMWa66c5QsmA_1789646006
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E959318301A7; Thu, 17 Sep 2026 11:53:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F1371800577; Thu, 17 Sep 2026 11:53:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 97F0221E6A04; Thu, 17 Sep 2026 13:53:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 14/20] migration: Use output visitor in info command
In-Reply-To: <20260915000209.3692668-15-farosas@suse.de> (Fabiano Rosas's
 message of "Mon, 14 Sep 2026 21:02:02 -0300")
References: <20260915000209.3692668-1-farosas@suse.de>
 <20260915000209.3692668-15-farosas@suse.de>
Date: Thu, 17 Sep 2026 13:53:22 +0200
Message-ID: <87zexg2ix9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> writes:

> The hmp_info_migrate_parameters function currently open-codes the
> mon_printf calls for each migration parameter. As with the set command
> in the last patch, this should not be necessary as the QAPI
> infrastructure already has generated code that takes type and struct
> member names into account, including converting _ from C into the '-'
> character as part of parameter names strings.
>
> The current code is also quite painful to rebase if a series has been
> carried for a long time while parameters have been added in master.
>
> Replace all of this with a conversion from MigrationParameters to
> QDict using an output visitor and a loop over the QDict that prints
> per-QAPI-type formatted strings.
>
> Modelled after block/qapi.c:dump_qobject, but with some changes to
> keep the migration command output formatting.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Old output of info migrate_parameters for me:

    announce-initial: 50
    announce-max: 550
    announce-rounds: 5
    announce-step: 100
    throttle-trigger-threshold: 50
    cpu-throttle-initial: 20
    cpu-throttle-increment: 10
    cpu-throttle-tailslow: off
    max-cpu-throttle: 99
    tls-creds: 
    tls-hostname: 
    tls-authz: 
    max-bandwidth: 134217728
    avail-switchover-bandwidth: 0
    max-postcopy-bandwidth: 0
    downtime-limit: 300
    x-checkpoint-delay: 20000
    multifd-channels: 2
    multifd-compression: none
    zero-page-detection: multifd
    xbzrle-cache-size: 67108864
    x-vcpu-dirty-limit-period: 1000
    vcpu-dirty-limit: 1
    mode: normal
    direct-io: off
    x-rdma-chunk-size: 1048576
    cpr-exec-command:

New output:

    cpu-throttle-tailslow: off
    xbzrle-cache-size: 67108864
    cpu-throttle-initial: 20
    announce-max: 550
    direct-io: off
    avail-switchover-bandwidth: 0
    local: off
    zero-page-detection: multifd
    multifd-qatzip-level: 1
    x-rdma-chunk-size: 1048576
    multifd-channels: 2
    mode: normal
    multifd-zstd-level: 1
    announce-initial: 50
    downtime-limit: 300
    tls-authz: 
    cpr-exec-command:

    vcpu-dirty-limit: 1
    multifd-compression: none
    announce-rounds: 5
    announce-step: 100
    tls-creds: 
    x-vcpu-dirty-limit-period: 1000
    multifd-zlib-level: 1
    max-cpu-throttle: 99
    max-postcopy-bandwidth: 0
    tls-hostname: 
    throttle-trigger-threshold: 50
    max-bandwidth: 134217728
    x-checkpoint-delay: 20000
    cpu-throttle-increment: 10

New output has an unwanted blank line after "cpr-exec-command:".

New output adds @local, @multifd-qatzip-level, @multifd-zlib-level,
@multifd-zstd-level.  Commit message should point that out.

Order of parameters changes, and not for the better.  Hmm.

> ---
>  migration/migration-hmp-cmds.c | 234 +++++++++++----------------------
>  migration/options.c            |   2 +-
>  migration/options.h            |   1 +
>  3 files changed, 81 insertions(+), 156 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 7491c79a2e..00d2d310af 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -26,8 +26,12 @@
>  #include "qapi/qapi-commands-migration.h"
>  #include "qapi/qapi-visit-migration.h"
>  #include "qapi/qobject-input-visitor.h"
> +#include "qapi/qobject-output-visitor.h"
> +#include "qobject/qbool.h"
>  #include "qobject/qdict.h"
> +#include "qobject/qjson.h"
>  #include "qobject/qlist.h"
> +#include "qobject/qnum.h"
>  #include "qobject/qstring.h"
>  #include "qapi/string-input-visitor.h"
>  #include "qapi/string-output-visitor.h"
> @@ -318,171 +322,91 @@ void hmp_info_migrate_capabilities(MonitorHMP *hmp, const QDict *qdict)
>      qapi_free_MigrationCapabilityStatusList(caps);
>  }
>  
> -static void monitor_print_cpr_exec_command(MonitorHMP *hmp, strList *args)
> +static void hmp_migrate_print_qobject(MonitorHMP *hmp, const char *label,
> +                                      QObject *obj)
>  {
> -    monitor_hmp_printf(hmp, "%s:",
> -        MigrationParameter_str(MIGRATION_PARAMETER_CPR_EXEC_COMMAND));
> +    const char *sep;
>  
> -    while (args) {
> -        monitor_hmp_printf(hmp, " %s", args->value);
> -        args = args->next;
> +    if (!obj) {
> +        return;
> +    }
> +
> +    /*
> +     * Put a space after labels
> +     * foo: bar
> +     *     ^
> +     */
> +    if (label && label[0] && label[strlen(label) - 1] == ':') {
> +        sep = " ";
> +    } else {
> +        sep = "";
> +    }

Awkward.

Could simply we pass "foo: " instead of "foo"?  Hmm, see case
QTYPE_QLIST below.

> +
> +    switch (qobject_type(obj)) {
> +    case QTYPE_QNUM: {
> +        g_autofree char *str = qnum_to_string(qobject_to(QNum, obj));
> +
> +        monitor_hmp_printf(hmp, "%s%s%s", label, sep, str);
> +        break;
> +    }
> +    case QTYPE_QSTRING:
> +        monitor_hmp_printf(hmp, "%s%s%s", label, sep,
> +                           qstring_get_str(qobject_to(QString, obj)));
> +        break;
> +    case QTYPE_QDICT: {
> +        QDict *d = qobject_to(QDict, obj);
> +        const QDictEntry *e;
> +        int i = 0;
> +
> +        monitor_hmp_printf(hmp, "%s%s", label, sep);
> +
> +        for (e = qdict_first(d); e; e = qdict_next(d, e), i++) {

Printing members in alphabetic order would be much better.

> +            g_autofree char *l = g_strdup_printf("%s:", qdict_entry_key(e));
> +            if (i) {
> +                monitor_hmp_printf(hmp, " ");
> +            }
> +            hmp_migrate_print_qobject(hmp, l, qdict_entry_value(e));
> +        }
> +        break;
> +    }

dump_qobject() prints nested stuff indented.  This function doesn't.  I
fear the output will be confusing.  Can you show us some example output
with a non-empty QDict?

> +    case QTYPE_QLIST: {
> +        const QListEntry *e;
> +
> +        monitor_hmp_printf(hmp, "%s\n", label);

Here we print @label and not @sep.  Why?  Can you show us some example
output with a non-empty QList?

> +        for (e = qlist_first(qobject_to(QList, obj)); e; e = qlist_next(e)) {
> +            hmp_migrate_print_qobject(hmp, " ", e->value);
> +            monitor_hmp_printf(hmp, "\n");
> +        }
> +

Recommend to scratch the blank line.

> +        break;

This case's output ends with a newline, unlike the other cases.
hmp_info_migrate_parameters() adds another newline.  That's where the
unwanted blank line mentioned above comes from.
> +    }
> +    case QTYPE_QBOOL:
> +        monitor_hmp_printf(hmp, "%s%s%s", label, sep,
> +                           qbool_get_bool(qobject_to(QBool, obj)) ?
> +                           "on" : "off");
> +        break;
> +    case QTYPE_NONE:
> +    case QTYPE_QNULL:

I'd scratch these two lines.  Matter of taste.

> +    default:
> +        g_assert_not_reached();
> +        break;
>      }
> -    monitor_hmp_printf(hmp, "\n");
>  }
>  
>  void hmp_info_migrate_parameters(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    MigrationParameters *params;
> -    MigrationState *s = migrate_get_current();
> +    MigrationParameters *params = qmp_query_migrate_parameters(NULL);
> +    g_autoptr(QDict) d;
> +    const QDictEntry *e;
>  
> -    params = qmp_query_migrate_parameters(NULL);
> +    assert(params);
>  
> -    if (params) {
> -        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_INITIAL),
> -            params->announce_initial);
> -        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_MAX),
> -            params->announce_max);
> -        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_ROUNDS),
> -            params->announce_rounds);
> -        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_STEP),
> -            params->announce_step);
> -        assert(params->has_throttle_trigger_threshold);
> -        monitor_hmp_printf(hmp, "%s: %u\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD),
> -            params->throttle_trigger_threshold);
> -        assert(params->has_cpu_throttle_initial);
> -        monitor_hmp_printf(hmp, "%s: %u\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL),
> -            params->cpu_throttle_initial);
> -        assert(params->has_cpu_throttle_increment);
> -        monitor_hmp_printf(hmp, "%s: %u\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT),
> -            params->cpu_throttle_increment);
> -        assert(params->has_cpu_throttle_tailslow);
> -        monitor_hmp_printf(hmp, "%s: %s\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW),
> -            params->cpu_throttle_tailslow ? "on" : "off");
> -        assert(params->has_max_cpu_throttle);
> -        monitor_hmp_printf(hmp, "%s: %u\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
> -            params->max_cpu_throttle);
> -        assert(params->tls_creds);
> -        monitor_hmp_printf(hmp, "%s: %s\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
> -                       params->tls_creds->u.s);
> -        assert(params->tls_hostname);
> -        monitor_hmp_printf(hmp, "%s: %s\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
> -                       params->tls_hostname->u.s);
> -        assert(params->tls_authz);
> -        monitor_hmp_printf(hmp, "%s: %s\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
> -                       params->tls_authz->u.s);
> -        assert(params->has_max_bandwidth);
> -        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
> -            params->max_bandwidth);
> -        assert(params->has_avail_switchover_bandwidth);
> -        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH),
> -            params->avail_switchover_bandwidth);
> -        assert(params->has_max_postcopy_bandwidth);
> -        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
> -            params->max_postcopy_bandwidth);
> -        assert(params->has_downtime_limit);
> -        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
> -            params->downtime_limit);
> -        assert(params->has_x_checkpoint_delay);
> -        monitor_hmp_printf(hmp, "%s: %u\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELAY),
> -            params->x_checkpoint_delay);
> -        monitor_hmp_printf(hmp, "%s: %u\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
> -            params->multifd_channels);
> -        monitor_hmp_printf(hmp, "%s: %s\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESSION),
> -            MultiFDCompression_str(params->multifd_compression));
> -        assert(params->has_zero_page_detection);
> -        monitor_hmp_printf(hmp, "%s: %s\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_ZERO_PAGE_DETECTION),
> -            qapi_enum_lookup(&ZeroPageDetection_lookup,
> -                params->zero_page_detection));
> -        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
> -            params->xbzrle_cache_size);
> +    d = migrate_params_to_dict(params, NULL);
> +    for (e = qdict_first(d); e; e = qdict_next(d, e)) {
> +        g_autofree char *label = g_strdup_printf("%s:", qdict_entry_key(e));
>  
> -        if (s->has_block_bitmap_mapping) {
> -            BitmapMigrationNodeAliasList *nal;
> -            BitmapMigrationNodeAlias *na;
> -            BitmapMigrationBitmapAliasList *bal;
> -            BitmapMigrationBitmapAlias *ba;
> -            BitmapMigrationBitmapAliasTransform *bat;
> -
> -            monitor_hmp_printf(hmp, "%s:\n",
> -                           MigrationParameter_str(
> -                               MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING));
> -
> -            for (nal = params->block_bitmap_mapping; nal; nal = nal->next)
> -            {
> -                na = nal->value;
> -                monitor_hmp_printf(hmp, " bitmaps:\n");
> -                for (bal = na->bitmaps; bal; bal = bal->next) {
> -                    ba = bal->value;
> -                    bat = ba->transform;
> -
> -                    monitor_hmp_printf(hmp, " name: %s", ba->name);
> -                    if (bat && bat->has_persistent) {
> -                        monitor_hmp_printf(hmp, " transform:");
> -                        if (bat->persistent) {
> -                            monitor_hmp_printf(hmp, " persistent: on");
> -                        } else {
> -                            monitor_hmp_printf(hmp, " persistent: off");
> -                        }
> -                    }
> -                    monitor_hmp_printf(hmp, " alias: %s\n", ba->alias);
> -                }
> -                monitor_hmp_printf(hmp, " node-name: %s alias: %s\n",
> -                                   na->node_name, na->alias);
> -            }
> -
> -            monitor_hmp_printf(hmp, "\n");
> -        }
> -
> -        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
> -        MigrationParameter_str(MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD),
> -        params->x_vcpu_dirty_limit_period);
> -
> -        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT),
> -            params->vcpu_dirty_limit);
> -
> -        assert(params->has_mode);
> -        monitor_hmp_printf(hmp, "%s: %s\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_MODE),
> -            qapi_enum_lookup(&MigMode_lookup, params->mode));
> -
> -        if (params->has_direct_io) {
> -            monitor_hmp_printf(hmp, "%s: %s\n",
> -                               MigrationParameter_str(
> -                                   MIGRATION_PARAMETER_DIRECT_IO),
> -                               params->direct_io ? "on" : "off");
> -        }
> -
> -        if (params->has_x_rdma_chunk_size) {
> -            monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
> -                           MigrationParameter_str(
> -                               MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE),
> -                           params->x_rdma_chunk_size);
> -        }
> -
> -        assert(params->has_cpr_exec_command);
> -        monitor_print_cpr_exec_command(hmp, params->cpr_exec_command);
> +        hmp_migrate_print_qobject(hmp, label, qdict_entry_value(e));
> +        monitor_hmp_printf(hmp, "\n");
>      }

Why not something like

       hmp_migrate_print_qobject(hmp, NULL, d)

?

>  
>      qapi_free_MigrationParameters(params);
> diff --git a/migration/options.c b/migration/options.c
> index 46d040fc3f..29b96f48c1 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1097,7 +1097,7 @@ static void tls_opt_to_str(StrOrNull *opt)
>      opt->u.s = g_strdup("");
>  }
>  
> -static QDict *migrate_params_to_dict(MigrationParameters *p, Error **errp)
> +QDict *migrate_params_to_dict(MigrationParameters *p, Error **errp)
>  {
>      QObject *obj = NULL;
>      Visitor *v = qobject_output_visitor_new(&obj);
> diff --git a/migration/options.h b/migration/options.h
> index c7da2d0b5b..0d9f88c11e 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -94,4 +94,5 @@ uint64_t migrate_rdma_chunk_size(void);
>  bool migrate_params_check(MigrationParameters *params, Error **errp);
>  void migrate_params_init(MigrationParameters *params);
>  bool migrate_params_free(MigrationParameters *params, Error **errp);
> +QDict *migrate_params_to_dict(MigrationParameters *p, Error **errp);
>  #endif


