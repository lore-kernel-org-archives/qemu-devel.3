Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B669BC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Cog-0007L7-RF; Thu, 17 Sep 2026 10:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7Cob-0007Ki-Go
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7CoY-0002z3-EZ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789654211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PoZj4T4V6HRVMAJQRXIlC8yrDYLe2rmbefWmOxNPa0w=;
 b=FmbG+ZebVNwEPTzxKivdEg7gBkCztcFxkAuWmecyBuXF2Mphd3RfXTg30zy1mIdlyMZ7Kd
 kRAVGfolqWvowHURfQH0NTxL5X/j8VUvCDOLy1BqWgqtecaehhb9px8N8jR1oMjQPeicZm
 Ke4Z1/LdwaNglUEc8Xh3MkZHBC3FncU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-T4R_PB6fMu-1VFgM_SGZZw-1; Thu,
 17 Sep 2026 10:10:07 -0400
X-MC-Unique: T4R_PB6fMu-1VFgM_SGZZw-1
X-Mimecast-MFC-AGG-ID: T4R_PB6fMu-1VFgM_SGZZw_1789654206
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAEAB1944B22; Thu, 17 Sep 2026 14:10:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE4701956086; Thu, 17 Sep 2026 14:10:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 45ABE21E6A04; Thu, 17 Sep 2026 16:10:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  "Dr . David Alan
 Gilbert" <dave@treblig.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3 19/20] migration: Set the parameters present flag
 with a clone visitor
In-Reply-To: <20260915000209.3692668-20-farosas@suse.de> (Fabiano Rosas's
 message of "Mon, 14 Sep 2026 21:02:07 -0300")
References: <20260915000209.3692668-1-farosas@suse.de>
 <20260915000209.3692668-20-farosas@suse.de>
Date: Thu, 17 Sep 2026 16:10:02 +0200
Message-ID: <87bj9wrmth.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> The MigrationParameters object is defined by the QAPI. It is also used
> by the migration code as its internal store of parameters.
>
> Due to a historic coupling of the migration code with qdev properties,
> when a migration parameter has its initial value set by qdev, the QAPI
> present flag for that parameter is kept unset. This is fine as long as
> the MigrationParameters object is not used to interact with the QAPI
> (e.g. as input to query-migrate) or the visitors infrastructure
> (e.g. using QAPI_CLONE to duplicate an object).
>
> Recent changes have removed code duplication and complexity in the
> aforementioned interactions by adding a helper that attempts to ensure
> consistency by setting all of the present flags for a (manually kept)
> list of parameters. See commit f55f4ef632 ("migration: Extract code to
> mark all parameters as present").
>
> There are still some drawbacks to this scheme such as the need to keep
> the list of parameters updated.
>
> Replace the logic with a walk from a custom visitor that force sets
> each present flag and dispenses with all manual updates as it uses the
> QAPI generated code and will not become out of sync with
> MigrationParameters.
>
> This also allows the removal in the next patch of the
> MigrationParameter enum which is the last place where migration
> parameter names need to be replicated.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

I think this is better than manually setting all the has_FOO.  It's not
without footguns, though.

> ---
>  include/qapi/clone-visitor.h |  1 +
>  migration/migration.c        |  2 +-
>  migration/options.c          | 77 ++++++++++++------------------------
>  migration/options.h          |  2 +-
>  qapi/qapi-clone-visitor.c    | 13 ++++++
>  5 files changed, 41 insertions(+), 54 deletions(-)
>
> diff --git a/include/qapi/clone-visitor.h b/include/qapi/clone-visitor.h
> index ebc182b034..04cd1a88d1 100644
> --- a/include/qapi/clone-visitor.h
> +++ b/include/qapi/clone-visitor.h
> @@ -22,6 +22,7 @@
>  typedef struct QapiCloneVisitor QapiCloneVisitor;
>  
>  Visitor *qapi_clone_visitor_new(void);
> +Visitor *qapi_clone_visitor_new_all(void);
>  Visitor *qapi_clone_members_visitor_new(void);
>  
>  /*
> diff --git a/migration/migration.c b/migration/migration.c
> index fcfb82ad57..f92d13234f 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -4076,7 +4076,7 @@ static void migration_instance_init(Object *obj)
>      qemu_event_init(&ms->pause_event, false);
>      qemu_mutex_init(&ms->error_mutex);
>  
> -    migrate_params_init(&ms->parameters);
> +    migrate_params_init(ms);
>  
>      qemu_sem_init(&ms->postcopy_pause_sem, 0);
>      qemu_sem_init(&ms->rp_state.rp_sem, 0);
> diff --git a/migration/options.c b/migration/options.c
> index 02b9c64ae6..8d869209ee 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -233,6 +233,31 @@ const Property migration_properties[] = {
>  };
>  const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
>  
> +/*
> + * After qdev sets the defaults for the migration parameters using the
> + * migration_properties above, s->parameters is left inconsistent from
> + * QAPI point of view because the parameters' present flag is not
> + * set. Use the custom-built qapi_clone_visitor_all() to copy
> + * s->parameters back to itself while setting all present flags. The
> + * resulting object is fit to be used with QAPI and the visitor
> + * infrastructure.
> + *
> + * WARNING: missing entries in the migration_properties array in
> + * respect to MigrationParameters will still have their corresponding
> + * struct member marked as present.
> + */
> +void migrate_params_init(MigrationState *s)
> +{
> +    Visitor *v = qapi_clone_visitor_new_all();

This is a variation of the clone visitor.

The clone visitor replaces all allocated member values by deep copies of
themselves.  The variation additionally makes all optional members
present.  I'll discuss this in more detail at the end.  You might want
to jump there now, and then back here.

The comment in clone-visitor advises "The clone visitor is for direct
use only by the QAPI_CLONE() macro".  We're ignoring that here.  Hmm.

> +    g_autoptr(MigrationParameters) p = &s->parameters;

Arrange to call qapi_free_MigrationParameters(&s->parameters) on return
from this function.  But &s->parameters does not point to a
heap-allocated object, it points *into* a struct MigrationState!  You'll
change it shortly to point to a heap-allocated object, but this is
super-confusing.

Anyway, @p points to s->parameters now.  Returning from the function
would be catastrophic.

> +
> +    visit_type_MigrationParameters(v, NULL, &p, &error_abort);

Replace @p by a deep clone.  Returning from the function is safe again.

> +    visit_free(v);
> +    migrate_params_free(&s->parameters, &error_abort);

Free all the members of s->parameters.

> +    QAPI_CLONE_MEMBERS(MigrationParameters, &s->parameters, p);

Copy deep clones of the members of @p to s->parameters.

Free @p on return.

> +}

Please avoid the confusing g_autoptr() in this function.

All the cloning is useless.  Could we reduce that?  Idea at the end.

> +
> +
>  static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
>                            void *opaque, Error **errp)
>  {
> @@ -1121,53 +1146,6 @@ static MigrationParameters *migrate_params_from_dict(QDict *d, Error **errp)
>      return tmp;
>  }
>  
> -/*
> - * query-migrate-parameters expects all members of MigrationParameters
> - * to be present, but we cannot mark them non-optional in QAPI because
> - * the structure is also used for migrate-set-parameters, which needs
> - * the optionality. Force all parameters to be seen as present
> - * now. Note that this depends on some form of default being set for
> - * every member of MigrationParameters, currently done during qdev
> - * init using migration_properties defined in this file. The TLS
> - * options are a special case because they don't have a default and
> - * need to be normalized before use.
> - */
> -static void migrate_mark_all_params_present(MigrationParameters *p)
> -{
> -    int len, n_str_args = 3; /* tls-creds, tls-hostname, tls-authz */
> -    bool *has_fields[] = {
> -        &p->has_throttle_trigger_threshold, &p->has_cpu_throttle_initial,
> -        &p->has_cpu_throttle_increment, &p->has_cpu_throttle_tailslow,
> -        &p->has_max_bandwidth, &p->has_avail_switchover_bandwidth,
> -        &p->has_downtime_limit, &p->has_x_checkpoint_delay,
> -        &p->has_multifd_channels, &p->has_multifd_compression,
> -        &p->has_multifd_zlib_level, &p->has_multifd_qatzip_level,
> -        &p->has_multifd_zstd_level, &p->has_xbzrle_cache_size,
> -        &p->has_max_postcopy_bandwidth, &p->has_max_cpu_throttle,
> -        &p->has_announce_initial, &p->has_announce_max, &p->has_announce_rounds,
> -        &p->has_announce_step, &p->has_block_bitmap_mapping,
> -        &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
> -        &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
> -        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command, &p->has_local,
> -        &p->has_xbzrle, &p->has_rdma_pin_all,
> -        &p->has_auto_converge, &p->has_events,
> -        &p->has_postcopy_ram, &p->has_x_colo, &p->has_release_ram,
> -        &p->has_return_path, &p->has_pause_before_switchover, &p->has_multifd,
> -        &p->has_dirty_bitmaps, &p->has_postcopy_blocktime,
> -        &p->has_late_block_activate, &p->has_x_ignore_shared,
> -        &p->has_validate_uuid, &p->has_background_snapshot,
> -        &p->has_zero_copy_send, &p->has_postcopy_preempt,
> -        &p->has_switchover_ack, &p->has_dirty_limit, &p->has_mapped_ram,
> -    };
> -
> -    len = ARRAY_SIZE(has_fields);
> -    assert(len + n_str_args == MIGRATION_PARAMETER__MAX);
> -
> -    for (int i = 0; i < len; i++) {
> -        *has_fields[i] = true;
> -    }
> -}
> -
>  MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -1188,11 +1166,6 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      return params;
>  }
>  
> -void migrate_params_init(MigrationParameters *params)
> -{
> -    migrate_mark_all_params_present(params);
> -}
> -
>  static void migrate_post_update_params(MigrationParameters *new, Error **errp)
>  {
>      MigrationState *s = migrate_get_current();
> diff --git a/migration/options.h b/migration/options.h
> index 28cf762ace..7abd527610 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -78,7 +78,7 @@ ZeroPageDetection migrate_zero_page_detection(void);
>  uint64_t migrate_rdma_chunk_size(void);
>  
>  bool migrate_params_check(MigrationParameters *params, Error **errp);
> -void migrate_params_init(MigrationParameters *params);
> +void migrate_params_init(MigrationState *s);
>  bool migrate_params_free(MigrationParameters *params, Error **errp);
>  QDict *migrate_params_to_dict(MigrationParameters *p, Error **errp);
>  bool migrate_capability_get_compat(MigrationParameters *params, int i);
> diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
> index 30997638de..8e2135b78e 100644
> --- a/qapi/qapi-clone-visitor.c
> +++ b/qapi/qapi-clone-visitor.c
> @@ -174,6 +174,19 @@ Visitor *qapi_clone_visitor_new(void)
>      return &v->visitor;
>  }
>  
> +static void qapi_clone_optional_all(Visitor *v, const char *name, bool *present)
> +{
> +    *present = true;
> +}

From visit_optional()'s contract:

 * Input visitors set *@present according to input; other visitors
 * leave it unchanged.  In either case, return *@present for
 * convenience.

This is a clone visitor, so it's supposed to leave *present unchanged.
It doesn't.

> +
> +Visitor *qapi_clone_visitor_new_all(void)
> +{
> +   Visitor *v = qapi_clone_visitor_new();
> +
> +   v->optional = qapi_clone_optional_all;
> +   return v;
> +}
> +
>  Visitor *qapi_clone_members_visitor_new(void)
>  {
>      Visitor *v = qapi_clone_visitor_new();

Let's have closer look at how this contraption works.

The ordinary clone visitor only visits members that are present.  This
visitor visits all members, thanks to its peculiar optional() method.
What could go wrong?  Let's see:

* A member M of numeric of bool type T is encoded as

    bool has_M;
    T M;

  We set has_M to true and visit M.  The visit does nothing (see
  qapi_clone_type_int64() & friends).  Okay.

* A member M of type array of T is encoded as

    bool has_M;
    MList *M;

  We set has_M to true and visit M.  The visit replaces the value of M
  by a deep copy, which does nothing when the array is empty.  Okay.

* A member M of type str is encoded as

    char *M;

  We visit M.  The visit replaces the value of M by a copy, except it
  replaces null by "" (see qapi_clone_type_str()).  Okay, sort of.

* A member M of object or alternate type T is encoded as

    T *M;

  We visit M.  The visit replaces a non-null value by a deep copy.  What
  about null value?

    static bool qapi_clone_start_struct(Visitor *v, const char *name, void **obj,
                                        size_t size, Error **errp)
    {
        QapiCloneVisitor *qcv = to_qcv(v);

        if (!obj) {
--->        assert(qcv->depth);
            /* Only possible when visiting an alternate's object
             * branch. Nothing further to do here, since the earlier
             * visit_start_alternate() already copied memory. */
            return true;
        }

        *obj = g_memdup(*obj, size);
        qcv->depth++;
        return true;
    }

  We're messing with design assumptions here.

I guess shit can't happen the way you use this thing:
MigrationParameters has sensible values before you pass it to
visit_type_MigrationParameters().

Hmm, does it?  Old migrate_mark_all_params_present() sets the has_M that
are directly in MigrationParameters.  It doesn't recurse into M..  This
clone visitor does.  What if it runs into nested absent values?  Will
they have sensible values?

Should we make qapi_clone_optional_all() check v->depth?

I think this beast needs scary comments.  Hiding it in migration/ seems
advisable.


Is it wise to shanghai the clone visitor for this purpose?  What about a
new visitor that does pretty much nothing, just sets *present in
optional() when v->depth is 1?


