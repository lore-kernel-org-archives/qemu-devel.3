Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAB2C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Sef-00048g-IE; Fri, 04 Sep 2026 08:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2Sec-00048Q-DT
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2SeZ-0004sw-GQ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788523457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ro0JQ3kvq5eVV2C5KSqjPiwgN2+NFEUJxB0B3sjAdx4=;
 b=XSNFzTAdOSElJrVWemexcAZzkGbnPh558fFa3K5jhQiBad2peLIyQ2PPrxdKFiQkbUpTOQ
 9qFGavR8guHe1IWt7TXcep5o/7D1cFf8gHlyt4uZ041QJpPsw1z9sZD7t3ynBHNhYLzQIc
 KT68N0jzlgcPvoeXUBIrBctU5UIxS9w=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-7cNdGZHrMkOnUQ3RkWSDpw-1; Fri, 04 Sep 2026 08:04:16 -0400
X-MC-Unique: 7cNdGZHrMkOnUQ3RkWSDpw-1
X-Mimecast-MFC-AGG-ID: 7cNdGZHrMkOnUQ3RkWSDpw_1788523456
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e820609d9so187068585a.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788523456; x=1789128256; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ro0JQ3kvq5eVV2C5KSqjPiwgN2+NFEUJxB0B3sjAdx4=;
 b=LmVscmeeBZ8ZOE8AohS/4lCzkWMZTpC6byIVHQ2JgXiwCG1L7sCgOfQYnVc3r2YlK7
 X2V7tHqgm1ZWgsQ9OREW3roDdoa4PvS0C491E+twT+dBEArGMshjAelfhazIGLEpdybG
 BMD9Cah6rUguiUtXfccUNr9aIJl1DP+jcZp+bhNPL0iQMe7V3MpOknR/BrGKe5fFayg3
 HXKxmOcledCRHEsmFTuwUg/diBpx/3e1emANqmjjW4yPbYYp2VgrKsP7PRUD0mRVzNWx
 DvrnpUIhdYCB4n7nhmTt0LdwyC4eseINpctgQH9jPWKCa8ItzwwWc/lg0sksagsib09Y
 umIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523456; x=1789128256;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ro0JQ3kvq5eVV2C5KSqjPiwgN2+NFEUJxB0B3sjAdx4=;
 b=PTwQw+KFLP1uy49MM5R+39uPmFjD2/6Z4xFOJyp+jpzVPXytKf0PwvZe/1iqPFCUI5
 3MjRSaWtdu3fGWrUCNpMGtKNshbbJMLqQ2/7vlohtehmOKJU1gNBcprdECYFb0tPisZK
 iUP2h7IoHVVaTjPmGoCkOiep8QsRKC3zuEKrRFDjNUZ4+SX+lKP6gcyrcQawL6UZw6Rh
 JDgQDDRkilRZgErsAV3vt64NbrFLyiAl2CATzTbpf1tNX+MVEBccbWCP2qCAUSfHCx9Y
 MHtPbmItrSZPuEq51KjuOgX4+FlhRG8MARgbAVIyhCndOeaj+LQwA/DrrDJBLffue4j9
 LsHQ==
X-Gm-Message-State: AFuF++ncNd57WkhxTn02o8ZpcNDL5TcLoRUAZRZzq+HZkNiMOC8YBJUN
 Hd30M/5hUW83GXO1kGxuBEy5Zb9kAKDNQh/WtKIBcN1hIfHWaSWKuzKM4A8Kvkms5X+UUo2U9RA
 O70HHw6Z95Je7v4xpobWysrpqDhzbn3D5LslDyp6qtTl3QA2bj8zGGljxOFzonV5minQ=
X-Gm-Gg: AYBFou0Yl03mC4wBjwMNl8X8xDRgG5SyO4nC7shWe+G05iQAmn1FGXIrEJPtpXfF2Sc
 oH7H1sZT38sJ5n1bID4xGHlQqXZGc6/nXHTtcpXZS6xDIhO+B00D8AK2xRvlxWBx7P7YhV8/U6f
 6rgEpH5WoeFKhPMNfAa9ERKKizs/1yHY76abmURqL0ad9zpXEV2CWnYQ4hkjj9N8NdOnO/dBPdW
 LTwk14z329Gav42jvQKtJFayL/dBBXJbHMlCjVSpwcbX25eSdrKgIOH77WcmyuCDgbiZrN/JTU1
 WF5yqzEu1yoo6dr0CuPVaQg/e3NTGJZ9g3gpilp4GONMTHT1IwSagQSqVsyrzBkOnshM
X-Received: by 2002:a05:620a:6089:b0:938:d7e4:7fe with SMTP id
 af79cd13be357-939804536d0mr563702085a.37.1788523455378; 
 Fri, 04 Sep 2026 05:04:15 -0700 (PDT)
X-Received: by 2002:a05:620a:6089:b0:938:d7e4:7fe with SMTP id
 af79cd13be357-939804536d0mr563689785a.37.1788523454545; 
 Fri, 04 Sep 2026 05:04:14 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939865a424dsm97187785a.27.2026.09.04.05.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:04:13 -0700 (PDT)
Date: Fri, 4 Sep 2026 08:04:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 13/18] migration: Use output visitor in info command
Message-ID: <apqzsh7pIkmKTYYg@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-14-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902221547.1812481-14-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Sep 02, 2026 at 07:15:41PM -0300, Fabiano Rosas wrote:
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
> Note that this was not a for-free improvement, the HMP command format
> output was changed incompatibly in a previous patch. It doesn't output
> units anymore.

IIUC both qlist and qdict are only used in BitmapMigrationNodeAlias only.
It would be nice to attach an example of HMP dump before/after the change
of these two patches, either in previous patch or here (assuming the layout
changed once).  In case HMP has some suggestion in general, I suggest copy
Dave when repost in case he has something to say.

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration-hmp-cmds.c | 243 ++++++++++++++-------------------
>  1 file changed, 100 insertions(+), 143 deletions(-)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 089c6d4ff46..dff69650a0c 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -25,7 +25,12 @@
>  #include "qapi/qapi-commands-migration.h"
>  #include "qapi/qapi-visit-migration.h"
>  #include "qapi/qobject-input-visitor.h"
> +#include "qapi/qobject-output-visitor.h"
> +#include "qobject/qbool.h"
>  #include "qobject/qdict.h"
> +#include "qobject/qjson.h"
> +#include "qobject/qlist.h"
> +#include "qobject/qnum.h"
>  #include "qobject/qstring.h"
>  #include "qapi/string-input-visitor.h"
>  #include "qapi/string-output-visitor.h"
> @@ -316,170 +321,122 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
>      qapi_free_MigrationCapabilityStatusList(caps);
>  }
>  
> -static void monitor_print_cpr_exec_command(Monitor *mon, strList *args)
> +static QDict *migrate_params_to_dict(MigrationParameters *p, Error **errp)
>  {
> -    monitor_printf(mon, "%s:",
> -        MigrationParameter_str(MIGRATION_PARAMETER_CPR_EXEC_COMMAND));
> +    QObject *obj = NULL;
> +    Visitor *v = qobject_output_visitor_new(&obj);
>  
> -    while (args) {
> -        monitor_printf(mon, " %s", args->value);
> -        args = args->next;
> +    if (visit_type_MigrationParameters(v, NULL, &p, errp)) {
> +        visit_complete(v, &obj);
>      }
> -    monitor_printf(mon, "\n");
> +    visit_free(v);
> +    return qobject_to(QDict, obj);
>  }

This exact function also exists in options.c (with the same name and
impl).  Can reuse.

>  
> -void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
> +static void hmp_migrate_print_qobject(Monitor *mon, const char *label,
> +                                      QObject *obj)
>  {
> -    MigrationParameters *params;
> -    MigrationState *s = migrate_get_current();
> +    const char *sep;
>  
> -    params = qmp_query_migrate_parameters(NULL);
> +    if (!obj) {
> +        return;
> +    }
>  
> -    if (params) {
> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_INITIAL),
> -            params->announce_initial);
> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_MAX),
> -            params->announce_max);
> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_ROUNDS),
> -            params->announce_rounds);
> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_STEP),
> -            params->announce_step);
> -        assert(params->has_throttle_trigger_threshold);
> -        monitor_printf(mon, "%s: %u\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD),
> -            params->throttle_trigger_threshold);
> -        assert(params->has_cpu_throttle_initial);
> -        monitor_printf(mon, "%s: %u\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL),
> -            params->cpu_throttle_initial);
> -        assert(params->has_cpu_throttle_increment);
> -        monitor_printf(mon, "%s: %u\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT),
> -            params->cpu_throttle_increment);
> -        assert(params->has_cpu_throttle_tailslow);
> -        monitor_printf(mon, "%s: %s\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW),
> -            params->cpu_throttle_tailslow ? "on" : "off");
> -        assert(params->has_max_cpu_throttle);
> -        monitor_printf(mon, "%s: %u\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
> -            params->max_cpu_throttle);
> -        assert(params->tls_creds);
> -        monitor_printf(mon, "%s: %s\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
> -                       params->tls_creds->u.s);
> -        assert(params->tls_hostname);
> -        monitor_printf(mon, "%s: %s\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
> -                       params->tls_hostname->u.s);
> -        assert(params->tls_authz);
> -        monitor_printf(mon, "%s: %s\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
> -                       params->tls_authz->u.s);
> -        assert(params->has_max_bandwidth);
> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
> -            params->max_bandwidth);
> -        assert(params->has_avail_switchover_bandwidth);
> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH),
> -            params->avail_switchover_bandwidth);
> -        assert(params->has_max_postcopy_bandwidth);
> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
> -            params->max_postcopy_bandwidth);
> -        assert(params->has_downtime_limit);
> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
> -            params->downtime_limit);
> -        assert(params->has_x_checkpoint_delay);
> -        monitor_printf(mon, "%s: %u\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELAY),
> -            params->x_checkpoint_delay);
> -        monitor_printf(mon, "%s: %u\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
> -            params->multifd_channels);
> -        monitor_printf(mon, "%s: %s\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESSION),
> -            MultiFDCompression_str(params->multifd_compression));
> -        assert(params->has_zero_page_detection);
> -        monitor_printf(mon, "%s: %s\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_ZERO_PAGE_DETECTION),
> -            qapi_enum_lookup(&ZeroPageDetection_lookup,
> -                params->zero_page_detection));
> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
> -            params->xbzrle_cache_size);
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
>  
> -        if (s->has_block_bitmap_mapping) {
> -            BitmapMigrationNodeAliasList *nal;
> -            BitmapMigrationNodeAlias *na;
> -            BitmapMigrationBitmapAliasList *bal;
> -            BitmapMigrationBitmapAlias *ba;
> -            BitmapMigrationBitmapAliasTransform *bat;
> +    switch (qobject_type(obj)) {
> +    case QTYPE_NONE:
> +        g_assert_not_reached();
> +    case QTYPE_QNULL:
> +        break;

Shall we assert too if we don't expect it?

> +    case QTYPE_QNUM: {
> +        int64_t i64;
>  
> -            monitor_printf(mon, "%s:",
> -                           MigrationParameter_str(
> -                               MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING));
> +        if (qnum_get_try_int(qobject_to(QNum, obj), &i64)) {
> +            monitor_printf(mon, "%s%s%" PRId64, label, sep, i64);

Should we use qnum_to_string() like what dump_qobject() does?

Logically any size/u64 parameter (which may not be a normal use case..) can
be set larger than INT64_MAX, so qnum_get_try_int() may return false? Here
skipping to print anything is benign if it only happens with a malicious
monitor client, but I think we should try to capture all cases.

> +        }
> +        break;
> +    }
> +    case QTYPE_QSTRING: {
> +        QString *str = qobject_to(QString, obj);
>  
> -            for (nal = params->block_bitmap_mapping; nal; nal = nal->next)
> -            {
> -                na = nal->value;
> -                monitor_printf(mon, " bitmaps:");
> -                for (bal = na->bitmaps; bal; bal = bal->next) {
> -                    ba = bal->value;
> -                    bat = ba->transform;
> +        if (str) {

Any chance str==NULL here?

> +            monitor_printf(mon, "%s%s%s", label, sep, qstring_get_str(str));
> +        }
> +        break;
> +    }
> +    case QTYPE_QDICT: {
> +        QDict *d = qobject_to(QDict, obj);
> +        const QDictEntry *e;
> +        int i = 0;
>  
> -                    monitor_printf(mon, " name: %s", ba->name);
> -                    if (bat && bat->has_persistent) {
> -                        if (bat->persistent) {
> -                            monitor_printf(mon, " persistent: on");
> -                        } else {
> -                            monitor_printf(mon, " persistent: off");
> -                        }
> -                    }
> -                    monitor_printf(mon, " alias: %s", ba->alias);
> +        if (d) {
> +            for (e = qdict_first(d); e; e = qdict_next(d, e), i++) {
> +                g_autofree char *l = g_strdup_printf("%s:", qdict_entry_key(e));
> +                if (i) {
> +                    monitor_printf(mon, " ");
>                  }
> -                monitor_printf(mon, " node-name: %s alias: %s",
> -                               na->node_name, na->alias);
> +                hmp_migrate_print_qobject(mon, l, qdict_entry_value(e));
>              }
> -
> -            monitor_printf(mon, "\n");
>          }
> +        break;
> +    }
> +    case QTYPE_QLIST: {
> +        QList *l = qobject_to(QList, obj);
> +        const QListEntry *e;
>  
> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
> -        MigrationParameter_str(MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD),
> -        params->x_vcpu_dirty_limit_period);
> +        if (l) {
> +            monitor_printf(mon, "%s", label);
>  
> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT),
> -            params->vcpu_dirty_limit);
> +            for (e = qlist_first(l); e; e = qlist_next(e)) {
> +                /*
> +                 * In the first iteration, this is the space after the
> +                 * colon, otherwise it's the space between list
> +                 * elements.
> +                 */
> +                monitor_printf(mon, " ");
> +                hmp_migrate_print_qobject(mon, "", e->value);
> +            }
> +        }
> +        break;
> +    }
> +    case QTYPE_QBOOL: {
> +        QBool *b = qobject_to(QBool, obj);
> +        if (b) {

Similarly, I'd drop "if" if it will always happen, making qbool_get_bool()
assert itself by deref.

> +            monitor_printf(mon, "%s%s%s", label, sep,
> +                           qbool_get_bool(b) ? "on" : "off");
> +        }
> +        break;
> +    }
> +    default:
> +        g_assert_not_reached();
> +        break;
> +    }
> +}
>  
> -        assert(params->has_mode);
> -        monitor_printf(mon, "%s: %s\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_MODE),
> -            qapi_enum_lookup(&MigMode_lookup, params->mode));
> +void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
> +{
> +    MigrationParameters *params = qmp_query_migrate_parameters(NULL);
> +    g_autoptr(QDict) d;
> +    const QDictEntry *e;
>  
> -        if (params->has_direct_io) {
> -            monitor_printf(mon, "%s: %s\n",
> -                           MigrationParameter_str(
> -                               MIGRATION_PARAMETER_DIRECT_IO),
> -                           params->direct_io ? "on" : "off");
> -        }
> +    assert(params);
>  
> -        if (params->has_x_rdma_chunk_size) {
> -            monitor_printf(mon, "%s: %" PRIu64 "\n",
> -                           MigrationParameter_str(
> -                               MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE),
> -                           params->x_rdma_chunk_size);
> -        }
> +    d = migrate_params_to_dict(params, NULL);
> +    for (e = qdict_first(d); e; e = qdict_next(d, e)) {
> +        g_autofree char *label = g_strdup_printf("%s:", qdict_entry_key(e));
>  
> -        assert(params->has_cpr_exec_command);
> -        monitor_print_cpr_exec_command(mon, params->cpr_exec_command);
> +        hmp_migrate_print_qobject(mon, label, qdict_entry_value(e));
> +        monitor_printf(mon, "\n");
>      }
>  
>      qapi_free_MigrationParameters(params);
> -- 
> 2.53.0
> 

-- 
Peter Xu


