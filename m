Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11424C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x79yU-0004G6-QU; Thu, 17 Sep 2026 07:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x79yT-0004Fp-4N
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 07:08:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x79yQ-0004MO-L7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 07:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789643292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PcYzNRvTMExy8Dp2y8pASvMijzNudiZb9YIVTIZeQ7o=;
 b=iw5FeL/V6VsRntSRUsYd8Zv5dnXIgEObZTwP/mTUgQQvuMB9+sZotcGGhQ9sDat4zJXsse
 oKAyBYG+vQTJLLuby4F7wdqx2c7pZoWx+/lllzN/54qfsDw1e+wnAnXtdS6y7l0ejfDH6a
 ceYs9KlSZATuD8KNyOvIOdHJQShWvAQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-MlX5git3Ogqu-jxN19EM6g-1; Thu,
 17 Sep 2026 07:08:09 -0400
X-MC-Unique: MlX5git3Ogqu-jxN19EM6g-1
X-Mimecast-MFC-AGG-ID: MlX5git3Ogqu-jxN19EM6g_1789643288
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26A32180B5C4; Thu, 17 Sep 2026 11:08:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 840DE1800579; Thu, 17 Sep 2026 11:08:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F377321E6A04; Thu, 17 Sep 2026 13:08:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  "Dr . David Alan
 Gilbert" <dave@treblig.org>,  Laurent Vivier <lvivier@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 13/20] migration: Use keyval input visitor in HMP set
 command
In-Reply-To: <20260915000209.3692668-14-farosas@suse.de> (Fabiano Rosas's
 message of "Mon, 14 Sep 2026 21:02:01 -0300")
References: <20260915000209.3692668-1-farosas@suse.de>
 <20260915000209.3692668-14-farosas@suse.de>
Date: Thu, 17 Sep 2026 13:08:04 +0200
Message-ID: <87h5jo3zl7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Change the hmp_migrate_set_parameter command to use a keyval input
> visitor.
>
> Currently a string visitor is used and due to limitations of that
> particular visitor's implementation it's necessary to consult the QAPI
> type enum (MigrationParameter_lookup) and call each visit_type_*
> function individually. Which makes using a visitor pointless.
>
> Since there are other visitors implemented properly and generated code
> to iterate the QAPI object, prefer using one of those. The keyval
> input visitor is adequate because HMP provides basically one key and
> one value for each migrate_set_parameter command.
>
> To switch from string_input_visitor to keyval_input_visitor simply put
> the parameter name and value into a dict and invoke
> visit_type_MigrationParameters().
>
> Note that it's not necessary to go through any of the keyval_* code
> because due to the nature of HMP, there's no parsing to do (no '=', no
> ',', etc).
>
> With this the migrate_set_parameters HMP commands will be
> automatically updated anytime a new migration parameter is added.
>
> Note that one parameter, "cpr-exec-command", takes the strList type so
> the HMP string needs to be first converted to a QList.
>
> A small side-effect improvement of this change is that by not using
> the MigrationParameter enum as a means to verify whether the
> user-provided key is a valid parameter name, the message when an
> invalid parameter is given now changes from "invalid value x" to
> "parameter x is unexpected", which is more accurate.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration-hmp-cmds.c     | 187 ++++-------------------------
>  tests/qtest/migration/misc-tests.c |   2 +-
>  2 files changed, 26 insertions(+), 163 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index b3422b848a..7491c79a2e 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -25,7 +25,10 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-migration.h"
>  #include "qapi/qapi-visit-migration.h"
> +#include "qapi/qobject-input-visitor.h"
>  #include "qobject/qdict.h"
> +#include "qobject/qlist.h"
> +#include "qobject/qstring.h"
>  #include "qapi/string-input-visitor.h"
>  #include "qapi/string-output-visitor.h"
>  #include "qemu/cutils.h"
> @@ -605,183 +608,43 @@ void hmp_migrate_set_parameter(MonitorHMP *hmp, const QDict *qdict)
>  {
>      const char *param = qdict_get_str(qdict, "parameter");
>      const char *valuestr = qdict_get_str(qdict, "value");
> -    Visitor *v = string_input_visitor_new(valuestr);
> -    MigrationParameters *p = g_new0(MigrationParameters, 1);
> -    uint64_t cache_size;
> +    g_autoptr(QDict) input = qdict_new();
> +    g_autoptr(MigrationParameters) p = NULL;
> +    QObject *value;
> +    Visitor *v;
>      Error *err = NULL;
> -    int val;
>  
> -    val = qapi_enum_parse(&MigrationParameter_lookup, param, -1, &err);
> -    if (val < 0) {
> -        goto cleanup;
> -    }
> -
> -    switch (val) {
> -    case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
> -        p->has_throttle_trigger_threshold = true;
> -        visit_type_uint8(v, param, &p->throttle_trigger_threshold, &err);
> -        break;
> -    case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
> -        p->has_cpu_throttle_initial = true;
> -        visit_type_uint8(v, param, &p->cpu_throttle_initial, &err);
> -        break;
> -    case MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT:
> -        p->has_cpu_throttle_increment = true;
> -        visit_type_uint8(v, param, &p->cpu_throttle_increment, &err);
> -        break;
> -    case MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW:
> -        p->has_cpu_throttle_tailslow = true;
> -        visit_type_bool(v, param, &p->cpu_throttle_tailslow, &err);
> -        break;
> -    case MIGRATION_PARAMETER_MAX_CPU_THROTTLE:
> -        p->has_max_cpu_throttle = true;
> -        visit_type_uint8(v, param, &p->max_cpu_throttle, &err);
> -        break;
> -    case MIGRATION_PARAMETER_TLS_CREDS:
> -        p->tls_creds = g_new0(StrOrNull, 1);
> -        p->tls_creds->type = QTYPE_QSTRING;
> -        visit_type_str(v, param, &p->tls_creds->u.s, &err);
> -        break;
> -    case MIGRATION_PARAMETER_TLS_HOSTNAME:
> -        p->tls_hostname = g_new0(StrOrNull, 1);
> -        p->tls_hostname->type = QTYPE_QSTRING;
> -        visit_type_str(v, param, &p->tls_hostname->u.s, &err);
> -        break;
> -    case MIGRATION_PARAMETER_TLS_AUTHZ:
> -        p->tls_authz = g_new0(StrOrNull, 1);
> -        p->tls_authz->type = QTYPE_QSTRING;
> -        visit_type_str(v, param, &p->tls_authz->u.s, &err);
> -        break;
> -    case MIGRATION_PARAMETER_MAX_BANDWIDTH:
> -        p->has_max_bandwidth = true;
> -        visit_type_size(v, param, &p->max_bandwidth, &err);
> -        break;
> -    case MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH:
> -        p->has_avail_switchover_bandwidth = true;
> -        visit_type_size(v, param, &p->avail_switchover_bandwidth, &err);
> -        break;
> -    case MIGRATION_PARAMETER_DOWNTIME_LIMIT:
> -        p->has_downtime_limit = true;
> -        visit_type_size(v, param, &p->downtime_limit, &err);
> -        break;
> -    case MIGRATION_PARAMETER_X_CHECKPOINT_DELAY:
> -        p->has_x_checkpoint_delay = true;
> -        visit_type_uint32(v, param, &p->x_checkpoint_delay, &err);
> -        break;
> -    case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
> -        p->has_multifd_channels = true;
> -        visit_type_uint8(v, param, &p->multifd_channels, &err);
> -        break;
> -    case MIGRATION_PARAMETER_MULTIFD_COMPRESSION:
> -        p->has_multifd_compression = true;
> -        visit_type_MultiFDCompression(v, param, &p->multifd_compression,
> -                                      &err);
> -        break;
> -    case MIGRATION_PARAMETER_MULTIFD_ZLIB_LEVEL:
> -        p->has_multifd_zlib_level = true;
> -        visit_type_uint8(v, param, &p->multifd_zlib_level, &err);
> -        break;
> -    case MIGRATION_PARAMETER_MULTIFD_QATZIP_LEVEL:
> -        p->has_multifd_qatzip_level = true;
> -        visit_type_uint8(v, param, &p->multifd_qatzip_level, &err);
> -        break;
> -    case MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL:
> -        p->has_multifd_zstd_level = true;
> -        visit_type_uint8(v, param, &p->multifd_zstd_level, &err);
> -        break;
> -    case MIGRATION_PARAMETER_ZERO_PAGE_DETECTION:
> -        p->has_zero_page_detection = true;
> -        visit_type_ZeroPageDetection(v, param, &p->zero_page_detection, &err);
> -        break;
> -    case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
> -        p->has_xbzrle_cache_size = true;
> -        if (!visit_type_size(v, param, &cache_size, &err)) {
> -            break;
> -        }
> -        if (cache_size > INT64_MAX || (size_t)cache_size != cache_size) {
> -            error_setg(&err, "Invalid size %s", valuestr);
> -            break;
> -        }
> -        p->xbzrle_cache_size = cache_size;
> -        break;
> -    case MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH:
> -        p->has_max_postcopy_bandwidth = true;
> -        visit_type_size(v, param, &p->max_postcopy_bandwidth, &err);
> -        break;
> -    case MIGRATION_PARAMETER_ANNOUNCE_INITIAL:
> -        p->has_announce_initial = true;
> -        visit_type_size(v, param, &p->announce_initial, &err);
> -        break;
> -    case MIGRATION_PARAMETER_ANNOUNCE_MAX:
> -        p->has_announce_max = true;
> -        visit_type_size(v, param, &p->announce_max, &err);
> -        break;
> -    case MIGRATION_PARAMETER_ANNOUNCE_ROUNDS:
> -        p->has_announce_rounds = true;
> -        visit_type_size(v, param, &p->announce_rounds, &err);
> -        break;
> -    case MIGRATION_PARAMETER_ANNOUNCE_STEP:
> -        p->has_announce_step = true;
> -        visit_type_size(v, param, &p->announce_step, &err);
> -        break;
> -    case MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING:
> -        error_setg(&err, "The block-bitmap-mapping parameter can only be set "
> -                   "through QMP");
> -        break;
> -    case MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD:
> -        p->has_x_vcpu_dirty_limit_period = true;
> -        visit_type_size(v, param, &p->x_vcpu_dirty_limit_period, &err);
> -        break;
> -    case MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT:
> -        p->has_vcpu_dirty_limit = true;
> -        visit_type_size(v, param, &p->vcpu_dirty_limit, &err);
> -        break;
> -    case MIGRATION_PARAMETER_MODE:
> -        p->has_mode = true;
> -        visit_type_MigMode(v, param, &p->mode, &err);
> -        break;
> -    case MIGRATION_PARAMETER_DIRECT_IO:
> -        p->has_direct_io = true;
> -        visit_type_bool(v, param, &p->direct_io, &err);
> -        break;
> -    case MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE:
> -        p->has_x_rdma_chunk_size = true;
> -        visit_type_size(v, param, &p->x_rdma_chunk_size, &err);
> -        break;
> -    case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
> -        /*
> -         * NOTE: g_autofree will only auto g_free() the strv array when
> -         * needed, it will not free the strings within the array. It's
> -         * intentional: when strv is set, the ownership of the strings will
> -         * always be passed to p->cpr_exec_command via QAPI_LIST_APPEND().
> -         */
> +    if (g_str_equal(param, "block-bitmap-mapping")) {
> +        error_setg(&err, "The %s parameter can only be set through QMP", param);
> +        goto err;
> +    } else if (g_str_equal(param, "cpr-exec-command")) {
>          g_autofree char **strv = NULL;

Not this patch's doing: initialization looks superfluous.

>          g_autoptr(GError) gerr = NULL;
> -        strList **tail = &p->cpr_exec_command;
> +        QList *list;
>  
>          if (!g_shell_parse_argv(valuestr, NULL, &strv, &gerr)) {
>              error_setg(&err, "%s", gerr->message);
> -            break;
> +            goto err;
>          }
> +
> +        list = qlist_new();
>          for (int i = 0; strv[i]; i++) {
> -            QAPI_LIST_APPEND(tail, strv[i]);
> +            qlist_append_str(list, strv[i]);
> +            g_free(strv[i]);
>          }
> -        p->has_cpr_exec_command = true;
> -        break;
> -    }
> -    default:
> -        g_assert_not_reached();
> +        value = QOBJECT(list);
> +    } else {
> +        value = QOBJECT(qstring_from_str(valuestr));
>      }
>  
> -    if (err) {
> -        goto cleanup;
> +    qdict_put_obj(input, param, value);
> +    v = qobject_input_visitor_new_keyval(QOBJECT(input));
> +    if (visit_type_MigrationParameters(v, NULL, &p, &err)) {
> +        qmp_migrate_set_parameters(p, &err);
>      }
>  
> -    qmp_migrate_set_parameters(p, &err);
> -
> - cleanup:
> -    qapi_free_MigrationParameters(p);
>      visit_free(v);
> +err:
>      hmp_handle_error(hmp, err);
>  }
>  
> diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
> index 182a8518a9..49280e5bc9 100644
> --- a/tests/qtest/migration/misc-tests.c
> +++ b/tests/qtest/migration/misc-tests.c
> @@ -148,7 +148,7 @@ static void test_hmp_migration_parameters(char *name, MigrateCommon *args)
>      HMPTestData test_cases[] = {
>          TEST("", "", "migrate_set_parameter: string expected"),
>          TEST("foo", "", "migrate_set_parameter: string expected"),
> -        TEST("foo", "on", "Error: invalid parameter value: foo"),
> +        TEST("foo", "on", "Error: Parameter 'foo' is unexpected"),
>  
>          /* bool */
>          TEST("cpu-throttle-tailslow", "on", "on"),

Reviewed-by: Markus Armbruster <armbru@redhat.com>


