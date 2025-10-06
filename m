Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FC4CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 13:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5lBi-00024w-Rf; Mon, 06 Oct 2025 09:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v5lBg-00024m-LU
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 09:23:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v5lBa-0004Ap-II
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 09:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759756999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TIdmRzslPjPpbbg/p61Ee16OHYGAkAmrVz8zvtpoWG4=;
 b=cE1qFaK5j8tBfr7XT+U9lBji60hUWHX8dJr5eWnQRCdd+fcQlsOHnOXDIe9uiFNizX3iTW
 slegNTN2HpSNBmadW9Q3HusvVJKrGDl0vCG2pyW+Me5sOJo6kUXkVB+FMPlbvZz18jUrA0
 45tlKZYTKdom/lv9ui2r7yXhnxqGT14=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-pyiSKHLXMoWhQYyhL9rh1A-1; Mon,
 06 Oct 2025 09:23:13 -0400
X-MC-Unique: pyiSKHLXMoWhQYyhL9rh1A-1
X-Mimecast-MFC-AGG-ID: pyiSKHLXMoWhQYyhL9rh1A_1759756992
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64B851800350; Mon,  6 Oct 2025 13:23:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E4553001FCA; Mon,  6 Oct 2025 13:23:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D5D7A21E6A27; Mon, 06 Oct 2025 15:23:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com,  qemu-devel@nongnu.org,  philmd@linaro.org,
 thuth@redhat.com,  eblake@redhat.com,  michael.roth@amd.com,
 farosas@suse.de,  peterx@redhat.com,  berrange@redhat.com,
 jasowang@redhat.com,  steven.sistare@oracle.com,  leiyang@redhat.com,
 davydov-max@yandex-team.ru,  yc-core@yandex-team.ru
Subject: Re: [PATCH v6 16/19] qapi: add interface for backend-transfer
 virtio-net/tap migration
In-Reply-To: <20250923100110.70862-17-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 23 Sep 2025 13:01:07 +0300")
References: <20250923100110.70862-1-vsementsov@yandex-team.ru>
 <20250923100110.70862-17-vsementsov@yandex-team.ru>
Date: Mon, 06 Oct 2025 15:23:06 +0200
Message-ID: <87v7kskvut.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> To migrate virtio-net TAP device backend (including open fds) locally,
> user should simply set migration parameter
>
>    backend-transfer = ["virtio-net-tap"]
>
> Why not simple boolean? To simplify migration to further versions,
> when more devices will support backend-transfer migration.
>
> Alternatively, we may add per-device option to disable backend-transfer
> migration, but still:
>
> 1. It's more comfortable to set same capabilities/parameters on both
> source and target QEMU, than care about each device.
>
> 2. To not break the design, that machine-type + device options +
> migration capabilities and parameters are fully define the resulting
> migration stream. We'll break this if add in future more
> backend-transfer support in devices under same backend-transfer=true
> parameter.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  include/qapi/util.h | 17 ++++++++++++++++
>  migration/options.c | 32 ++++++++++++++++++++++++++++++
>  migration/options.h |  2 ++
>  qapi/migration.json | 47 ++++++++++++++++++++++++++++++++++++---------
>  4 files changed, 89 insertions(+), 9 deletions(-)
>
> diff --git a/include/qapi/util.h b/include/qapi/util.h
> index 29bc4eb865..b953402416 100644
> --- a/include/qapi/util.h
> +++ b/include/qapi/util.h
> @@ -69,4 +69,21 @@ int parse_qapi_name(const char *name, bool complete);
>          _len;                                                       \
>      })
>  
> +/*
> + * For any GenericList @list, return true if it contains specified
> + * element.
> + */
> +#define QAPI_LIST_CONTAINS(list, el)                                \
> +    ({                                                              \
> +        bool _found = false;                                        \
> +        typeof_strip_qual(list) _tail;                              \
> +        for (_tail = list; _tail != NULL; _tail = _tail->next) {    \
> +            if (_tail->value == el) {                               \
> +                _found = true;                                      \
> +                break;                                              \
> +            }                                                       \
> +        }                                                           \
> +        _found;                                                     \
> +    })
> +

Not a fan of lengthy macros.

There's a single use below: migrate_virtio_net_tap().  I can't see
potential uses for such a search in existing code.

Open-code it in migrate_virtio_net_tap()?

>  #endif
> diff --git a/migration/options.c b/migration/options.c
> index 4e923a2e07..137ca2147e 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -13,6 +13,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qapi/util.h"
>  #include "exec/target_page.h"
>  #include "qapi/clone-visitor.h"
>  #include "qapi/error.h"
> @@ -262,6 +263,14 @@ bool migrate_mapped_ram(void)
>      return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
>  }
>  
> +bool migrate_virtio_net_tap(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return QAPI_LIST_CONTAINS(s->parameters.backend_transfer,
> +                              BACKEND_TRANSFER_VIRTIO_NET_TAP);
> +}
> +
>  bool migrate_ignore_shared(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -960,6 +969,12 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->has_direct_io = true;
>      params->direct_io = s->parameters.direct_io;
>  
> +    if (s->parameters.backend_transfer) {
> +        params->has_backend_transfer = true;
> +        params->backend_transfer = QAPI_CLONE(BackendTransferList,
> +                                              s->parameters.backend_transfer);
> +    }
> +
>      return params;
>  }
>  
> @@ -993,6 +1008,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_mode = true;
>      params->has_zero_page_detection = true;
>      params->has_direct_io = true;
> +    params->has_backend_transfer = true;
>  }
>  
>  /*
> @@ -1179,6 +1195,11 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>          return false;
>      }
>  
> +    if (params->has_backend_transfer) {
> +        error_setg(errp, "Not implemented");
> +        return false;
> +    }
> +

This goes away in the next patch.  Fine, but mentioning the gap in the
commit message can save reviewer a bit of work.

>      return true;
>  }
>  
> @@ -1297,6 +1318,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_direct_io) {
>          dest->direct_io = params->direct_io;
>      }
> +
> +    if (params->has_backend_transfer) {
> +        dest->backend_transfer = params->backend_transfer;
> +    }
>  }
>  
>  static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
> @@ -1429,6 +1454,13 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_direct_io) {
>          s->parameters.direct_io = params->direct_io;
>      }
> +
> +    if (params->has_backend_transfer) {
> +        qapi_free_BackendTransferList(s->parameters.backend_transfer);
> +
> +        s->parameters.backend_transfer = QAPI_CLONE(BackendTransferList,
> +                                                    params->backend_transfer);
> +    }
>  }
>  
>  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
> diff --git a/migration/options.h b/migration/options.h
> index 82d839709e..55c0345433 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -87,6 +87,8 @@ const char *migrate_tls_hostname(void);
>  uint64_t migrate_xbzrle_cache_size(void);
>  ZeroPageDetection migrate_zero_page_detection(void);
>  
> +bool migrate_virtio_net_tap(void);
> +
>  /* parameters helpers */
>  
>  bool migrate_params_check(MigrationParameters *params, Error **errp);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 2387c21e9c..e39785dc07 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -747,6 +747,18 @@
>        '*transform': 'BitmapMigrationBitmapAliasTransform'
>    } }
>  
> +##
> +# @BackendTransfer:
> +#
> +# @virtio-net-tap: Enable backend-transfer migration for virtio-net/tap. When
> +#     enabled, TAP fds and all related state is passed to target QEMU through
> +#     migration channel (which should be unix socket).

Suggest "are passed to the destination in the migration channel" and
"should be a UNIX domain socket".

docs/devel/qapi-code-gen.rst:

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

    Separate sentences with two spaces.

> +#
> +# Since: 10.2
> +##
> +{ 'enum': 'BackendTransfer',
> +  'data': [ 'virtio-net-tap' ] }
> +
>  ##
>  # @BitmapMigrationNodeAlias:
>  #
> @@ -924,10 +936,14 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @backend-transfer: List of targets to enable backend-transfer
> +#     migration for. This requires migration channel to be a unix
> +#     socket (to pass fds through). (Since 10.2)

Elsewhere, we describe the same restriction like this:

                                          This CPR channel must support
   #     file descriptor transfer with SCM_RIGHTS, i.e. it must be a
   #     UNIX domain socket.

> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> -#     @x-vcpu-dirty-limit-period are experimental.
> +# @unstable: Members @x-checkpoint-delay,
> +#     @x-vcpu-dirty-limit-period and @backend-transfer are experimental.

List members in alphabetical order, please.

>  #
>  # Since: 2.4
>  ##
> @@ -950,7 +966,8 @@
>             'vcpu-dirty-limit',
>             'mode',
>             'zero-page-detection',
> -           'direct-io'] }
> +           'direct-io',
> +           'backend-transfer' ] }

Forgot feature 'unstable'?

>  
>  ##
>  # @MigrateSetParameters:
> @@ -1105,10 +1122,14 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @backend-transfer: List of targets to enable backend-transfer
> +#     migration for. This requires migration channel to be a unix
> +#     socket (to pass fds through). (Since 10.2)
> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> -#     @x-vcpu-dirty-limit-period are experimental.
> +# @unstable: Members @x-checkpoint-delay,
> +#     @x-vcpu-dirty-limit-period and @backend-transfer are experimental.
>  #
>  # TODO: either fuse back into `MigrationParameters`, or make
>  #     `MigrationParameters` members mandatory
> @@ -1146,7 +1167,9 @@
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
> -            '*direct-io': 'bool' } }
> +            '*direct-io': 'bool',
> +            '*backend-transfer': { 'type': [ 'BackendTransfer' ],
> +                                   'features': [ 'unstable' ] } } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1315,10 +1338,14 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @backend-transfer: List of targets to enable backend-transfer
> +#     migration for. This requires migration channel to be a unix
> +#     socket (to pass fds through). (Since 10.2)
> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> -#     @x-vcpu-dirty-limit-period are experimental.
> +# @unstable: Members @x-checkpoint-delay,
> +#     @x-vcpu-dirty-limit-period and @backend-transfer are experimental.
>  #
>  # Since: 2.4
>  ##
> @@ -1353,7 +1380,9 @@
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
> -            '*direct-io': 'bool' } }
> +            '*direct-io': 'bool',
> +            '*backend-transfer': { 'type': [ 'BackendTransfer' ],
> +                                   'features': [ 'unstable' ] } } }
>  
>  ##
>  # @query-migrate-parameters:


