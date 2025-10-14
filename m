Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7423CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 16:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8hxp-00073F-8b; Tue, 14 Oct 2025 12:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v8hxm-00072b-4b
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:33:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v8hxh-0000oG-Gl
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760459598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UMHE7MXYF21Y99GlQJPZl7/j+uw2yfZ+o4BAPPhEfl0=;
 b=X2LGKdudWplNUxPkP/bsY80Vdi2qlezt5I/rS3XxOYi0jQTrMSiSLSRVDioFvcdfxGcXaC
 K67l/ivu09og22ZAZ3rh6Ml1cmsvYgbYAm7E/im0JH7l7N47RR5FvrMj8NlBNQ+c3hXnVl
 eO9da/N1S275Y6LpJl8QIWQ5qGSaitM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-G8oNA0KxNECwfZIBed0SwA-1; Tue, 14 Oct 2025 12:33:17 -0400
X-MC-Unique: G8oNA0KxNECwfZIBed0SwA-1
X-Mimecast-MFC-AGG-ID: G8oNA0KxNECwfZIBed0SwA_1760459596
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-876ee102b44so1343226d6.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 09:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760459596; x=1761064396;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMHE7MXYF21Y99GlQJPZl7/j+uw2yfZ+o4BAPPhEfl0=;
 b=QSRgZG7uUq0oS0AbGRwEzhJMhVubKIloVDTP9FF2tYYGe30JGzzvpUxegpWiXgpv3n
 0J5XsudUb2IA7Nb2wr/v7QjHeBS5lgcfmq6Xt82pahjjWOETRyEUDI1VQUXnY2ddPrSq
 denPQmWNPUs4ijjlWl3hFceAJOe4ZBN0inWR1LEJwv3SGZ8ZlmM+EHIgEefypnPrSd90
 Llv2HawUzoZWB+da9MkccLkUVkZQ878X8KS1x4Ptpw25q/SkvBTZa0sNOsfz/B6IpeXa
 WtXkvvTZNGgQxwaZB69r0oitkbvF5brCiEYGvDmDYsKcsws2ypDYCb7UohAC5KY2p5s3
 3Q3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY+Ci86gqALtFl/plpjfmH8droorMilT1DgFmwAPVIzqvZ4ePyR6XMSiEAIyY0FsKbIOcsv7cuq2vQ@nongnu.org
X-Gm-Message-State: AOJu0Yw25NGzLqRK67ZH3imQdwiVb0r4eWS/pI7jzSDP8fUL+Gv/lGxn
 SQtX47hnhjMnJUqae7UiGB/q3OoH2CjIWKM3z1SxcDzlTW8HP0YkW2ROP4M1Z3j99NjTmQbBmA/
 iqm6+G/zR0Fec6VB+zwGo8KIGASR1ASJQpWC71q8ruFNOaCHuevTtue8/
X-Gm-Gg: ASbGncul6UeGj25nZqOtky96YbYOGmh8V3BJKdFiPk7z5Hq/sWrcrWHtMVI4De4N6eg
 priI8X6YE43VEjmOQ8+4Z1NQEgZjPOFAr3Ep2QJe3mKIcQctaTSwAf6WNxjC9nAUQti6N0YYtB1
 EBy8p9clbLUtooe81uY6Nd7yae9NKjCjALIb/Tj3zdUN4P/tXwiVFFdkfbl+gfWX9EU/TE8tLI4
 87MPEvmUwUu4X5etQtn4wYw7NGMd+/TVztzTFk9N19jXE39gyWssIVtgsOPwb2OA8N+3jyTE2BT
 6vUMT5rIgMII2Klq0CIbqFBn+Ok1rTye
X-Received: by 2002:a05:622a:15c4:b0:4e4:218b:7b10 with SMTP id
 d75a77b69052e-4e6eaf1a339mr314589631cf.0.1760459595527; 
 Tue, 14 Oct 2025 09:33:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1mrk3Kx51RhGsMvm0+hpwy16Uehs4HunmUVJDseLLX7Ghs9mWlKI/ACoLU4gTt/ruSmEOig==
X-Received: by 2002:a05:622a:15c4:b0:4e4:218b:7b10 with SMTP id
 d75a77b69052e-4e6eaf1a339mr314589021cf.0.1760459595011; 
 Tue, 14 Oct 2025 09:33:15 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e881c5943fsm1911811cf.6.2025.10.14.09.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 09:33:14 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:33:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, jasowang@redhat.com, farosas@suse.de, sw@weilnetz.de,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 philmd@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org,
 michael.roth@amd.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v7 16/19] qapi: add interface for backend-transfer
 virtio-net/tap migration
Message-ID: <aO57SKp86zX2R8mV@x1.local>
References: <20251010173957.166759-1-vsementsov@yandex-team.ru>
 <20251010173957.166759-17-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010173957.166759-17-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Oct 10, 2025 at 08:39:54PM +0300, Vladimir Sementsov-Ogievskiy wrote:
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

But it loses per-device control, right?  Say, we can have two devices, and
the admin can decide if only one of the devices will enable this feature.

> 
> 2. To not break the design, that machine-type + device options +
> migration capabilities and parameters are fully define the resulting
> migration stream. We'll break this if add in future more
> backend-transfer support in devices under same backend-transfer=true
> parameter.

Could you elaborate?

I thought last time we discussed, we planned to have both the global knob
and a per-device flag, then the feature is enabled only if both flags are
set.

If these parameters are all set the same on src/dst, would it also not
break the design when new devices start to support it (and the new device
will need to introduce its own per-device flags)?

> 
> The commit only brings the interface, the realization will come in later
> commit. That's why we add a temporary not-implemented error in
> migrate_params_check().
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/options.c | 39 +++++++++++++++++++++++++++++++++++++++
>  migration/options.h |  2 ++
>  qapi/migration.json | 42 ++++++++++++++++++++++++++++++++++++------
>  3 files changed, 77 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 5183112775..76709af3ab 100644
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
> @@ -262,6 +263,20 @@ bool migrate_mapped_ram(void)
>      return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
>  }
>  
> +bool migrate_virtio_net_tap(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +    BackendTransferList *el = s->parameters.backend_transfer;
> +
> +    for ( ; el; el = el->next) {
> +        if (el->value == BACKEND_TRANSFER_VIRTIO_NET_TAP) {

So this is also something I want to avoid.  The hope is we don't
necessarily need to invent new device names into qapi/migration.json.
OTOH, we can export a helper in migration/misc.h so that devices can query
wehther the global feature is enabled or not, using that to AND the
per-device flag.

Thanks,

> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
>  bool migrate_ignore_shared(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -963,6 +978,12 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->cpr_exec_command = QAPI_CLONE(strList,
>                                            s->parameters.cpr_exec_command);
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
> @@ -997,6 +1018,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_zero_page_detection = true;
>      params->has_direct_io = true;
>      params->has_cpr_exec_command = true;
> +    params->has_backend_transfer = true;
>  }
>  
>  /*
> @@ -1183,6 +1205,12 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>          return false;
>      }
>  
> +    /* TODO: implement backend-transfer and remove this check */
> +    if (params->has_backend_transfer) {
> +        error_setg(errp, "Not implemented");
> +        return false;
> +    }
> +
>      return true;
>  }
>  
> @@ -1305,6 +1333,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_cpr_exec_command) {
>          dest->cpr_exec_command = params->cpr_exec_command;
>      }
> +
> +    if (params->has_backend_transfer) {
> +        dest->backend_transfer = params->backend_transfer;
> +    }
>  }
>  
>  static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
> @@ -1443,6 +1475,13 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>          s->parameters.cpr_exec_command =
>              QAPI_CLONE(strList, params->cpr_exec_command);
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
> index be0f3fcc12..1bfe7df191 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -770,6 +770,19 @@
>        '*transform': 'BitmapMigrationBitmapAliasTransform'
>    } }
>  
> +##
> +# @BackendTransfer:
> +#
> +# @virtio-net-tap: Enable backend-transfer migration for
> +#     virtio-net/tap. When enabled, TAP fds and all related state are
> +#     passed to the destination in the migration channel (which must
> +#     be a UNIX domain socket).
> +#
> +# Since: 10.2
> +##
> +{ 'enum': 'BackendTransfer',
> +  'data': [ 'virtio-net-tap' ] }
> +
>  ##
>  # @BitmapMigrationNodeAlias:
>  #
> @@ -951,9 +964,13 @@
>  #     is @cpr-exec.  The first list element is the program's filename,
>  #     the remainder its arguments.  (Since 10.2)
>  #
> +# @backend-transfer: List of targets for backend-transfer migration.
> +#     See description in `BackendTransfer`.  Default is no
> +#     backend-transfer migration (Since 10.2)
> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> +# @unstable: Members @backend-transfer, @x-checkpoint-delay and
>  #     @x-vcpu-dirty-limit-period are experimental.
>  #
>  # Since: 2.4
> @@ -978,7 +995,8 @@
>             'mode',
>             'zero-page-detection',
>             'direct-io',
> -           'cpr-exec-command'] }
> +           'cpr-exec-command',
> +           { 'name': 'backend-transfer', 'features': ['unstable'] } ] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -1137,9 +1155,13 @@
>  #     is @cpr-exec.  The first list element is the program's filename,
>  #     the remainder its arguments.  (Since 10.2)
>  #
> +# @backend-transfer: List of targets for backend-transfer migration.
> +#     See description in `BackendTransfer`.  Default is no
> +#     backend-transfer migration (Since 10.2)
> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> +# @unstable: Members @backend-transfer, @x-checkpoint-delay and
>  #     @x-vcpu-dirty-limit-period are experimental.
>  #
>  # TODO: either fuse back into `MigrationParameters`, or make
> @@ -1179,7 +1201,9 @@
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
>              '*direct-io': 'bool',
> -            '*cpr-exec-command': [ 'str' ]} }
> +            '*cpr-exec-command': [ 'str' ],
> +            '*backend-transfer': { 'type': [ 'BackendTransfer' ],
> +                                   'features': [ 'unstable' ] } } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1352,9 +1376,13 @@
>  #     is @cpr-exec.  The first list element is the program's filename,
>  #     the remainder its arguments.  (Since 10.2)
>  #
> +# @backend-transfer: List of targets for backend-transfer migration.
> +#     See description in `BackendTransfer`.  Default is no
> +#     backend-transfer migration (Since 10.2)
> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> +# @unstable: Members @backend-transfer, @x-checkpoint-delay and
>  #     @x-vcpu-dirty-limit-period are experimental.
>  #
>  # Since: 2.4
> @@ -1391,7 +1419,9 @@
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
>              '*direct-io': 'bool',
> -            '*cpr-exec-command': [ 'str' ]} }
> +            '*cpr-exec-command': [ 'str' ],
> +            '*backend-transfer': { 'type': [ 'BackendTransfer' ],
> +                                   'features': [ 'unstable' ] } } }
>  
>  ##
>  # @query-migrate-parameters:
> -- 
> 2.48.1
> 

-- 
Peter Xu


