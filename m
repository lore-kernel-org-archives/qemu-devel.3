Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E77C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp2Bk-00038p-FE; Wed, 29 Jul 2026 07:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wp2Bj-00038a-A6
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 07:11:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wp2Bh-00068M-8Y
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 07:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785323460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/vYkS5QDV1iNuG0FXFWsi7MwD0TdqBy22Vsne7MF9xs=;
 b=bcI1Mt1udBvyocNCB2sIMux1NYWbVZeHZOqh9dCBuSbAHv6s4vDpMks1XOQb0Y1Q/8P0Y7
 iE+15Wy0nPpIyq+BCchX0ycnEJfll01pDmGpTiOSWeUoqheKs4xBT8Bt8jnvcHwt7pDGo9
 ljcJW8PgZkvG+CkLz6WxlAIHMH7JmYM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-p2gRZgfMPlG2bvZA0XQXPg-1; Wed,
 29 Jul 2026 07:10:57 -0400
X-MC-Unique: p2gRZgfMPlG2bvZA0XQXPg-1
X-Mimecast-MFC-AGG-ID: p2gRZgfMPlG2bvZA0XQXPg_1785323455
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D628180056E; Wed, 29 Jul 2026 11:10:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEF44300019F; Wed, 29 Jul 2026 11:10:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5FA8821E6920; Wed, 29 Jul 2026 13:10:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  mst@redhat.com,  peterx@redhat.com,
 farosas@suse.de,  raphael.s.norwitz@gmail.com,  bchaney@akamai.com,
 qemu-devel@nongnu.org,  berrange@redhat.com,  pbonzini@redhat.com,
 yc-core@yandex-team.ru,  mark.caveayland@nutanix.com,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v20 09/15] qapi: add local migration parameter
In-Reply-To: <20260729091334.1863155-10-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 29 Jul 2026 12:12:47 +0300")
References: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
 <20260729091334.1863155-10-vsementsov@yandex-team.ru>
Date: Wed, 29 Jul 2026 13:10:51 +0200
Message-ID: <87se52qcec.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> We are going to implement local-migration feature: some devices will be
> able to transfer open file descriptors through migration stream (which
> must UNIX domain socket for that purpose).  This allows to transfer the
> whole backend state without reconnecting and restarting the backend
> service. For example, virtio-net will migrate its attached TAP netdev,
> together with its connected file descriptors.
>
> In this commit we introduce a migration parameter, which enables
> the feature for devices that support it (none at the moment).
>
> We can't simply auto-detect local migration by checking whether the
> migration channel is a UNIX domain socket: the UNIX socket may be only
> the first part of the transfer channel to a remote target.  Hence an
> explicit parameter is needed. More over, "local" migration parameter

Moreover

> may be useful in cpr-exec mode, when FDs are passed through exec
> instead of UNIX socket.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  include/migration/misc.h |  2 ++
>  migration/options.c      | 18 +++++++++++++++++-
>  qapi/migration.json      | 22 ++++++++++++++++++----
>  3 files changed, 37 insertions(+), 5 deletions(-)
>
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 2b2fbb59a40..019717f4cda 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -161,4 +161,6 @@ bool multifd_join_device_state_save_threads(void);
>  
>  void migration_request_switchover_ack_legacy(const char *requester);
>  
> +bool migrate_local(void);
> +
>  #endif
> diff --git a/migration/options.c b/migration/options.c
> index dfce19405d4..5c439f6d724 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -14,6 +14,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
>  #include "qemu/units.h"
> +#include "qapi/util.h"
>  #include "exec/target_page.h"
>  #include "qapi/clone-visitor.h"
>  #include "qapi/error.h"
> @@ -25,6 +26,7 @@
>  #include "migration/colo.h"
>  #include "migration/cpr.h"
>  #include "migration/misc.h"
> +#include "migration/options.h"
>  #include "migration.h"
>  #include "migration-stats.h"
>  #include "qemu-file.h"
> @@ -350,6 +352,12 @@ bool migrate_mapped_ram(void)
>      return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
>  }
>  
> +bool migrate_local(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +    return s->parameters.local;
> +}
> +
>  bool migrate_ignore_shared(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -1085,7 +1093,7 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
>          &p->has_announce_step, &p->has_block_bitmap_mapping,
>          &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
>          &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
> -        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
> +        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command, &p->has_local,
>      };
>  
>      len = ARRAY_SIZE(has_fields);
> @@ -1433,6 +1441,10 @@ static void migrate_params_test_apply(MigrationParameters *params,
>          qapi_free_strList(dest->cpr_exec_command);
>          dest->cpr_exec_command = QAPI_CLONE(strList, params->cpr_exec_command);
>      }
> +
> +    if (params->has_local) {
> +        dest->local = params->local;
> +    }
>  }
>  
>  static void migrate_params_apply(MigrationParameters *params)
> @@ -1565,6 +1577,10 @@ static void migrate_params_apply(MigrationParameters *params)
>          s->parameters.cpr_exec_command =
>              QAPI_CLONE(strList, params->cpr_exec_command);
>      }
> +
> +    if (params->has_local) {
> +        s->parameters.local = params->local;
> +    }
>  }
>  
>  void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index b1eaf7b0545..bb744f134ce 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -830,7 +830,8 @@
>             'zero-page-detection',
>             'direct-io',
>             { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
> -           'cpr-exec-command'] }
> +           'cpr-exec-command',
> +           'local'] }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1012,10 +1013,21 @@
>  #     Must be set to the same value on both source and destination
>  #     before migration starts.  (Since 11.1)
>  #
> +# @local: Permit the use of optimizations for local migration.
> +#     This must only be set when either both the source and
> +#     destination QEMU processes are directly connected with a UNIX
> +#     domain socket as the migration channel (to enable use of file
> +#     descriptor passing) or cpr-exec migration mode is enabled
> +#     (this way file descriptors are inherited by new process).
> +#     Individual device backends may need additional configuration
> +#     flags set  to enable local migration optimizations.

Extra space between "set" and "to".

> +#     This will be documented against the device
> +#     backends where it applies.  (Since 11.2)

Reflow while there:

   # @local: Permit the use of optimizations for local migration.  This
   #     must only be set when either both the source and destination
   #     QEMU processes are directly connected with a UNIX domain socket
   #     as the migration channel (to enable use of file descriptor
   #     passing) or cpr-exec migration mode is enabled (this way file
   #     descriptors are inherited by new process).  Individual device
   #     backends may need additional configuration flags set to enable
   #     local migration optimizations.  This will be documented against
   #     the device backends where it applies.  (Since 11.2)

> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
> -#     @x-vcpu-dirty-limit-period are experimental.
> +# @unstable: Members @local, @x-checkpoint-delay, @x-rdma-chunk-size,
> +#     and @x-vcpu-dirty-limit-period are experimental.
>  #
>  # Since: 2.4
>  ##
> @@ -1053,7 +1065,9 @@
>              '*direct-io': 'bool',
>              '*x-rdma-chunk-size': { 'type': 'uint64',
>                                      'features': [ 'unstable' ] },
> -            '*cpr-exec-command': [ 'str' ]} }
> +            '*cpr-exec-command': [ 'str' ],
> +            '*local': { 'type': 'bool',
> +                        'features': [ 'unstable' ] } } }
>  
>  ##
>  # @query-migrate-parameters:

With these cosmetic tweaks
Acked-by: Markus Armbruster <armbru@redhat.com>


