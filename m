Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E81C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DMA-0006wP-Rd; Thu, 03 Sep 2026 15:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2DM8-0006q9-Cq
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2DM5-0005fA-T5
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788464652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lup7rI7DgT91SY95qHwqmQZ6yLi1ldcwB0/KpzT3sQs=;
 b=LaReEf/Cb8eiNJEwxsdMjgtdzxq3FKsBwcDHZGpf1loZMwjaCbhjv/h0k0yN/mmNIm5R1+
 kg1oDoDIH3jihhwj06o88IjkQwLYVD1DACcRQrC4eyIcqgxRJhZGbK8s1QbR1VGyZ/B+5j
 uSVuA4FT866CTLb9NESfPmTADaMx7I4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-dN3GJDRlM26cL-4swg-SYw-1; Thu, 03 Sep 2026 15:44:10 -0400
X-MC-Unique: dN3GJDRlM26cL-4swg-SYw-1
X-Mimecast-MFC-AGG-ID: dN3GJDRlM26cL-4swg-SYw_1788464650
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936aa34873bso29312085a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788464650; x=1789069450; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lup7rI7DgT91SY95qHwqmQZ6yLi1ldcwB0/KpzT3sQs=;
 b=JrKqsjHTlGfXvf+f5udhnm+GIb/F7ntKwlbWQl1Wp7+jhX9v0NCmk2A7FFIF3aIq1A
 r00+yupW4e/jzeFQG8HRjqCXJ2ad7OL9pH7Einm/I7TGRzf638lzQxPag8lISiDUk77C
 LdoCzHbQsZNMqhFSjJdqTvrQ+nRwUPmrN/P33axkq5ZeY+h+5IiN25LSYa19VUmWp+/2
 lSNeQxmpgHvVeFyYaMRqO7Socv2w2l0xci8oM20BXIzJuPjVPj0GzXzYgNizmeQ8NbKK
 HYlT36sFqiRUel0wynJRlfxXsFhti9Rooq4toDvtjOjd0ZjWof+/q0hsiWa2EgSAqmMY
 iqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464650; x=1789069450;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lup7rI7DgT91SY95qHwqmQZ6yLi1ldcwB0/KpzT3sQs=;
 b=VNLHoW4UD2FGJUxpddoEbvoJtwV9E9CBxof1DEPUJyGXpqZad+OaJzbE4lSbBq5RX1
 rwo2gywnC5S+XFq6HpVB3tLEnvY6cKmdYznS2F0HviyrVj6kkWfStW7dum1ci7Yw4hNn
 h3I6ib6EHghCbHMswefleN+vi4syzwhRqMSfbcpUvtfIgCwzlduVtOOOJ4afVNZ+GDYl
 NdmFc/D2IxN8QxroeAemaqd3nX66Hka4mkLlOdGBh3+8eB0ZE1YfchGJf7HhbcZWBn57
 cXmcE1FseMMIu8ewlAQDxpjON3zZu+iyq2wfuRGO8AXdXboqYDJLebHMV1ivE6BaywxB
 R+xw==
X-Gm-Message-State: AFuF++kJVDvbR0zqM7owdyKEdbdaeNYCMKG2LoguTNfXglTAEoeXv586
 EOx2UkeMndOG6RmxWZ7Y51wLZ3rkuZjsld/fBNip+yi9eDUQT63D/Qu50sFg5gEB38ZwparylJ7
 NsDgZpA/V/PeRxMbo9ms08I2MJgltHq/dYr64HQloO/L6cSdnKb+/D8Ol
X-Gm-Gg: AYBFou0li3LJvXW4L/bIqerV1FbFUOPbmRlGG/RhZkQpXWKo/XWfs3OhXDp/5VnB+AD
 vpGFpNGMFRFmS6JMROUY3JTvu+SzMb/3GJpViDirWH7XARYPgpq07q9PdvnH2RZzUPuEiWuwXcr
 37JBQNYWZFz1CPlBOi0Vp3tpXAO+9IpodSB8RI51jsW+TW+e24fTVcXdITlVY/AQk/Z247vOhgI
 8FdI3OXVDeSv//JDAw9JNXarJecs3kb/moLDj57Q/gMFWwaNbyYcDzWAsYm2MtlpJHCWJLuz1xr
 YAmlvjMc2o9e7ePdjB9Xg/8oEroJGKUk99atoilBUh3v7bcq4iivu/EbEZgF1ZTl9gSeJnuJa0l
 fB6iXAQn+bL33OyLW6WEZHtJViUhEk8FxJnyWIA1oVPp8Iqr4Yp+p1QY35AE=
X-Received: by 2002:a05:620a:22ba:b0:936:78c8:e286 with SMTP id
 af79cd13be357-939804070aemr80007785a.25.1788464649993; 
 Thu, 03 Sep 2026 12:44:09 -0700 (PDT)
X-Received: by 2002:a05:620a:22ba:b0:936:78c8:e286 with SMTP id
 af79cd13be357-939804070aemr80003085a.25.1788464649235; 
 Thu, 03 Sep 2026 12:44:09 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397f9f151esm42982385a.6.2026.09.03.12.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:44:08 -0700 (PDT)
Date: Thu, 3 Sep 2026 15:44:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 11/18] migration: Use keyval input visitor in HMP set
 command
Message-ID: <apnOB4BfUEeOECU9@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-12-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902221547.1812481-12-farosas@suse.de>
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

On Wed, Sep 02, 2026 at 07:15:39PM -0300, Fabiano Rosas wrote:
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
> The bad part:
> 
> Some parameters accept a non-standard data format, I moved them to a
> "legacy" suffixed function in this patch as there's only 3 of them:
> 
> - "max-bandwidth" and "avail-switchover-bandwidth" take MiB instead of B for
>    a size parameter;

Ah, I think it's only because I reused max-bandwidth unit there, but
didn't reuse the same unit for max-postcopy-bandwidth at least..

IIUC, HMP ABI isn't guaranteed anyway, so I wonder if we can still remove
these non-standard settings, maybe starting with some warning messages.  Cc
Dave.

> 
> - "cpr-exec-command" takes the strList type which needs to be built
>   manually.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration-hmp-cmds.c     | 203 +++++++++--------------------
>  tests/qtest/migration/misc-tests.c |   2 +-
>  2 files changed, 59 insertions(+), 146 deletions(-)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index ad68fa23aa4..220ac28b5e3 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -24,7 +24,9 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-migration.h"
>  #include "qapi/qapi-visit-migration.h"
> +#include "qapi/qobject-input-visitor.h"
>  #include "qobject/qdict.h"
> +#include "qobject/qstring.h"
>  #include "qapi/string-input-visitor.h"
>  #include "qapi/string-output-visitor.h"
>  #include "qemu/cutils.h"
> @@ -589,59 +591,16 @@ end:
>      hmp_handle_error(mon, err);
>  }
>  
> -void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
> +static void hmp_migrate_set_parameter_legacy(Monitor *mon, const QDict *qdict)
>  {
>      const char *param = qdict_get_str(qdict, "parameter");
>      const char *valuestr = qdict_get_str(qdict, "value");
> -    Visitor *v = string_input_visitor_new(valuestr);
>      MigrationParameters *p = g_new0(MigrationParameters, 1);
>      uint64_t valuebw = 0;
> -    uint64_t cache_size;
>      Error *err = NULL;
> -    int val, ret;
> +    int ret;
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
> +    if (g_str_equal(param, "max-bandwidth")) {
>          p->has_max_bandwidth = true;
>          /*
>           * Can't use visit_type_size() here, because it
> @@ -651,109 +610,21 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          if (ret < 0 || valuebw > INT64_MAX
>              || (size_t)valuebw != valuebw) {
>              error_setg(&err, "Invalid size %s", valuestr);
> -            break;
> +            return;

This may leak @err and @p?

>          }
>          p->max_bandwidth = valuebw;
> -        break;
> -    case MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH:
> +
> +    } else if (g_str_equal(param, "avail-switchover-bandwidth")) {
>          p->has_avail_switchover_bandwidth = true;
>          ret = qemu_strtosz_MiB(valuestr, NULL, &valuebw);
>          if (ret < 0 || valuebw > INT64_MAX
>              || (size_t)valuebw != valuebw) {
>              error_setg(&err, "Invalid size %s", valuestr);
> -            break;
> +            return;

Same.

>          }
>          p->avail_switchover_bandwidth = valuebw;
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
> +
> +    } else if (g_str_equal(param, "cpr-exec-command")) {
>          /*
>           * NOTE: g_autofree will only auto g_free() the strv array when
>           * needed, it will not free the strings within the array. It's
> @@ -766,15 +637,14 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>  
>          if (!g_shell_parse_argv(valuestr, NULL, &strv, &gerr)) {
>              error_setg(&err, "%s", gerr->message);
> -            break;
> +            return;

Same.

>          }
>          for (int i = 0; strv[i]; i++) {
>              QAPI_LIST_APPEND(tail, strv[i]);
>          }
>          p->has_cpr_exec_command = true;
> -        break;
> -    }
> -    default:
> +
> +    } else {
>          g_assert_not_reached();
>      }
>  
> @@ -784,12 +654,55 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>  
>      qmp_migrate_set_parameters(p, &err);
>  
> - cleanup:
> +cleanup:
>      qapi_free_MigrationParameters(p);
> +    hmp_handle_error(mon, err);
> +}
> +
> +static void hmp_migrate_set_parameter_qapi(Monitor *mon, const QDict *qdict)
> +{
> +    const char *param = qdict_get_str(qdict, "parameter");
> +    const char *valuestr = qdict_get_str(qdict, "value");
> +    g_autoptr(QDict) input = qdict_new();
> +    g_autoptr(MigrationParameters) p = NULL;
> +    Visitor *v;
> +    Error *err = NULL;
> +
> +    /* the same as keyval_parse(), but here there's no need to parse */
> +    qdict_put_obj(input, param, QOBJECT(qstring_from_str(valuestr)));
> +
> +    v = qobject_input_visitor_new_keyval(QOBJECT(input));
> +    if (visit_type_MigrationParameters(v, NULL, &p, &err)) {
> +        qmp_migrate_set_parameters(p, &err);
> +    }
> +
>      visit_free(v);
>      hmp_handle_error(mon, err);
>  }
>  
> +void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
> +{
> +    const char *param = qdict_get_str(qdict, "parameter");
> +
> +    if (g_str_equal(param, "block-bitmap-mapping")) {
> +        Error *err = NULL;
> +
> +        error_setg(&err, "The %s parameter can only be set through QMP", param);
> +        hmp_handle_error(mon, err);
> +        return;
> +    }
> +
> +    /* these have non-standard setters */
> +    if (g_str_equal(param, "max-bandwidth") ||
> +        g_str_equal(param, "avail-switchover-bandwidth") ||
> +        g_str_equal(param, "cpr-exec-command")) {
> +
> +        return hmp_migrate_set_parameter_legacy(mon, qdict);
> +    }
> +
> +    hmp_migrate_set_parameter_qapi(mon, qdict);
> +}
> +
>  void hmp_migrate_start_postcopy(Monitor *mon, const QDict *qdict)
>  {
>      Error *err = NULL;
> diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
> index 3554900b758..ba8183978b3 100644
> --- a/tests/qtest/migration/misc-tests.c
> +++ b/tests/qtest/migration/misc-tests.c
> @@ -48,7 +48,7 @@ typedef struct HMPTestData {
>  HMPTestData test_cases[] = {
>      TEST("", "", "migrate_set_parameter: string expected"),
>      TEST("foo", "", "migrate_set_parameter: string expected"),
> -    TEST("foo", "on", "Error: invalid parameter value: foo"),
> +    TEST("foo", "on", "Error: Parameter 'foo' is unexpected"),
>  
>      /* bool */
>      TEST("cpu-throttle-tailslow", "on", "on"),
> -- 
> 2.53.0
> 

-- 
Peter Xu


