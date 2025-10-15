Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD0DCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v965v-0005CF-En; Wed, 15 Oct 2025 14:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v965s-0005Bn-VT
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v965o-0000Z5-LL
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760552352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QH5EkaSuNYBRPIAqTLc2ZPoCA2R94lZsVtoCuFek/fo=;
 b=ahzubIL9v22i8efeDCIS874u2GrUh0ZrLCY6L3wDDNcbmkS3d9Ons3hao14NT4iFKuVbw+
 BKpoKA6t3aOiY0ZYK3VxjEGrTi64TmvgjUuBeWnAmbIJrqhhBqTg1Xt2yvq2y3Om06ToCc
 T2REuwIVF+9NvKbqcAu6eXnBLA81vFY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-6VA3WYZkMfW6p7uQ8aHNKA-1; Wed, 15 Oct 2025 14:19:11 -0400
X-MC-Unique: 6VA3WYZkMfW6p7uQ8aHNKA-1
X-Mimecast-MFC-AGG-ID: 6VA3WYZkMfW6p7uQ8aHNKA_1760552351
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-88e2656b196so563350585a.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760552348; x=1761157148;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QH5EkaSuNYBRPIAqTLc2ZPoCA2R94lZsVtoCuFek/fo=;
 b=DaDxK82CIGi8jXmpfwo/jkn9QKF5PqiiAKfLQ4roVAfEnA1oma4CixpEl1b/zkbLq/
 SCKBs1BBZeVKNrhYQ2ZVVgbOJRLv+uh46mEHzu+dz5FFagSqiQwQZW6e4SVuZFuTJoby
 NQnx7UYeOQyLt4Xdr3YBxBYaYtDbBFKZvfdztTmxzm3MHBOYgI4Hn8A8tsWIwByMq3Jw
 lmktWlmPdfrej7RjNYwG5hXCkMJ4SXTKGHx7IhpVP1EaAus5uod1wfA7kyYQjWUTblqc
 fPdN+ZC7hTSV28pVfGRd35p2p57ZQJ/MYuyRkKvYTiAiIzThj5r5kcUAE+8akDp9T+SU
 lDtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+DdmFimezUmiJGqHLydDPft/lmxNA5YVNIZAAfcGm2cr/M4W6+5zKAPpLaz3ZO6IJhUIZnjKgEFTV@nongnu.org
X-Gm-Message-State: AOJu0Yw/2aWeitMA4Z07HVmrvg/ENVCCKW+JKWeQJ3mOKyR4Q49JhYnA
 CL2A65bMKbIArVv4vyQ6NDUH6sCncnDPEYSrXNTnluPI5p1vAinpODt0zfq5zai3CseqHxEkq4Z
 phnRfbiEtbgBNYAsmImAZFmIXKQANX6AUi82df2s2a6cKS4Ux/ZTT1/0k
X-Gm-Gg: ASbGnctJodG9YFoUQp4Zb3QJDkNVz3fEP+quxF3nj2vKhHb9W3K+e8t4yRSw3eKQ2iX
 Wkn/9EkxybetbiZuTGa17lKIVIHzkr7BxbKSFzoPyzXE0dA30q+nSEgSn7XVv0TzRtv257iLfCj
 /VyR3dEUlzmP9SuILfYq1mlzwvP+FGEaqat88ToBYZBkFWPjG3ES9K4PXNbEHC6wg2HjvqWcLAN
 uyFN8mKn9qffb30DTSBh4mTB4TUULbCYioLIP5JqANfZvpnF9/jJqXAS3MehSq2g665QXi688xp
 7rh2TWKnJxtK5o89lUwGx1TGgrCAFPSg
X-Received: by 2002:ac8:5d05:0:b0:4b7:a680:2111 with SMTP id
 d75a77b69052e-4e6eacb3007mr346407971cf.8.1760552347626; 
 Wed, 15 Oct 2025 11:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGLbvrBxMTyCkre3PXipipxjkcRKzcjdZa7MevqmHvkyVsq3ijjd+pChgeui3gZuTRS9nufA==
X-Received: by 2002:ac8:5d05:0:b0:4b7:a680:2111 with SMTP id
 d75a77b69052e-4e6eacb3007mr346407451cf.8.1760552346969; 
 Wed, 15 Oct 2025 11:19:06 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e881c55664sm22863471cf.5.2025.10.15.11.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 11:19:06 -0700 (PDT)
Date: Wed, 15 Oct 2025 14:19:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, jasowang@redhat.com, farosas@suse.de, sw@weilnetz.de,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 philmd@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org,
 michael.roth@amd.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
Message-ID: <aO_ll4Lf0bq6vgdm@x1.local>
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
 <20251015132136.1083972-17-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251015132136.1083972-17-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Wed, Oct 15, 2025 at 04:21:32PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> This parameter enables backend-transfer feature: all devices
> which support it will migrate their backends (for example a TAP
> device, by passing open file descriptor to migration channel).
> 
> Currently no such devices, so the new parameter is a noop.
> 
> Next commit will add support for virtio-net, to migrate its
> TAP backend.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/options.c | 18 ++++++++++++++++++
>  migration/options.h |  2 ++
>  qapi/migration.json | 38 ++++++++++++++++++++++++++++++++------
>  3 files changed, 52 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 5183112775..a461b07b54 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -262,6 +262,12 @@ bool migrate_mapped_ram(void)
>      return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
>  }
>  
> +bool migrate_backend_transfer(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +    return s->parameters.backend_transfer;
> +}
> +
>  bool migrate_ignore_shared(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -963,6 +969,9 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->cpr_exec_command = QAPI_CLONE(strList,
>                                            s->parameters.cpr_exec_command);
>  
> +    params->has_backend_transfer = true;
> +    params->backend_transfer = s->parameters.backend_transfer;
> +
>      return params;
>  }
>  
> @@ -997,6 +1006,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_zero_page_detection = true;
>      params->has_direct_io = true;
>      params->has_cpr_exec_command = true;
> +    params->has_backend_transfer = true;
>  }
>  
>  /*
> @@ -1305,6 +1315,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
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
> @@ -1443,6 +1457,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>          s->parameters.cpr_exec_command =
>              QAPI_CLONE(strList, params->cpr_exec_command);
>      }
> +
> +    if (params->has_backend_transfer) {
> +        s->parameters.backend_transfer = params->backend_transfer;
> +    }
>  }
>  
>  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
> diff --git a/migration/options.h b/migration/options.h
> index 82d839709e..755ba1c024 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -87,6 +87,8 @@ const char *migrate_tls_hostname(void);
>  uint64_t migrate_xbzrle_cache_size(void);
>  ZeroPageDetection migrate_zero_page_detection(void);
>  
> +bool migrate_backend_transfer(void);
> +
>  /* parameters helpers */
>  
>  bool migrate_params_check(MigrationParameters *params, Error **errp);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index be0f3fcc12..35601a1f87 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -951,9 +951,16 @@
>  #     is @cpr-exec.  The first list element is the program's filename,
>  #     the remainder its arguments.  (Since 10.2)
>  #
> +# @backend-transfer: Enable backend-transfer feature for devices that
> +#     supports it. In general that means that backend state and its
> +#     file descriptors are passed to the destination in the migraton
> +#     channel (which must be a UNIX socket). Individual devices
> +#     declare the support for backend-transfer by per-device
> +#     backend-transfer option. (Since 10.2)

Thanks.

I still prefer the name "fd-passing" or anything more explicit than
"backend-transfer". Maybe the current name is fine for TAP, only because
TAP doesn't have its own VMSD to transfer?

Consider a device that would be a backend that supports VMSDs already to be
migrated, then if it starts to allow fd-passing, this name will stop being
suitable there, because it used to "transfer backend" already, now it's
just started to "fd-passing".

Meanwhile, consider another example - what if a device is not a backend at
all (e.g. vfio?), has its own VMSD, then want to do fd-passing?

In general, I think "fd" is really a core concept of this whole thing.  One
thing to complement that idea is, IMHO this patch misses one important
change, that migration framework should actually explicitly fail the
migration if this feature is enabled but it's not a unix socket protocol
(aka, fd-passing REQUIRES scm rights).  Would that look more reliable?
Otherwise IIUC it'll throw weird errors when e.g. when we enabled this
feature and trying to migrate via either TCP or to a file..

> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> +# @unstable: Members @backend-transfer, @x-checkpoint-delay and
>  #     @x-vcpu-dirty-limit-period are experimental.
>  #
>  # Since: 2.4
> @@ -978,7 +985,8 @@
>             'mode',
>             'zero-page-detection',
>             'direct-io',
> -           'cpr-exec-command'] }
> +           'cpr-exec-command',
> +           { 'name': 'backend-transfer', 'features': ['unstable'] } ] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -1137,9 +1145,16 @@
>  #     is @cpr-exec.  The first list element is the program's filename,
>  #     the remainder its arguments.  (Since 10.2)
>  #
> +# @backend-transfer: Enable backend-transfer feature for devices that
> +#     supports it. In general that means that backend state and its
> +#     file descriptors are passed to the destination in the migraton
> +#     channel (which must be a UNIX socket). Individual devices
> +#     declare the support for backend-transfer by per-device
> +#     backend-transfer option. (Since 10.2)
> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> +# @unstable: Members @backend-transfer, @x-checkpoint-delay and
>  #     @x-vcpu-dirty-limit-period are experimental.
>  #
>  # TODO: either fuse back into `MigrationParameters`, or make
> @@ -1179,7 +1194,9 @@
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
>              '*direct-io': 'bool',
> -            '*cpr-exec-command': [ 'str' ]} }
> +            '*cpr-exec-command': [ 'str' ],
> +            '*backend-transfer': { 'type': 'bool',
> +                                   'features': [ 'unstable' ] } } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1352,9 +1369,16 @@
>  #     is @cpr-exec.  The first list element is the program's filename,
>  #     the remainder its arguments.  (Since 10.2)
>  #
> +# @backend-transfer: Enable backend-transfer feature for devices that
> +#     supports it. In general that means that backend state and its
> +#     file descriptors are passed to the destination in the migraton
> +#     channel (which must be a UNIX socket). Individual devices
> +#     declare the support for backend-transfer by per-device
> +#     backend-transfer option. (Since 10.2)
> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> +# @unstable: Members @backend-transfer, @x-checkpoint-delay and
>  #     @x-vcpu-dirty-limit-period are experimental.
>  #
>  # Since: 2.4
> @@ -1391,7 +1415,9 @@
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
>              '*direct-io': 'bool',
> -            '*cpr-exec-command': [ 'str' ]} }
> +            '*cpr-exec-command': [ 'str' ],
> +            '*backend-transfer': { 'type': 'bool',
> +                                   'features': [ 'unstable' ] } } }
>  
>  ##
>  # @query-migrate-parameters:
> -- 
> 2.48.1
> 

-- 
Peter Xu


