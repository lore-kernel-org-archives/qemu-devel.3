Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7357D68BC1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 14:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBxNT-0000qL-5p; Fri, 15 Nov 2024 09:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1tBxNP-0000px-Ej
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 09:32:48 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1tBxNL-0002NM-5d
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 09:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=D8z5Ou++Gj8rV1/lJskorNGZjR8exIyno+BMTeSACfU=; b=IrR9C+fhLCjBglUb
 HuGm0p+9O/HroFJrrOsimaB7BAQ3SA9/hkxIZDTwbm1TtDAZsZe3HEB/EG9KPf0QKdxhmYCRzqo7v
 vlUqcTkvcUcJ1ocUxIQbY2FWTA47DVixyiwT9RKdc5Hf0PZGWATMosL2loHtkr4w2hiWUdmcBNln8
 Q8jNFuPpD/thxGDUkFPobwo0Ybk6AFBNPrASOxX4CvvTFQ7uAHI7eHzUJYezE/3X/7kEDI/4OFOjL
 Kj5DF21HA64oYcMkTibS12OEw8SizBk2f6XQ73JsmdIVSD+guc+9yT7nzLF1c3QicGvutExCs4t+Z
 FmSBGCaI3pMzV+7czg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1tBxNC-0008Yj-0v;
 Fri, 15 Nov 2024 14:32:34 +0000
Date: Fri, 15 Nov 2024 14:32:34 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [PATCH v7 08/12] migration/multifd: Add new migration option for
 multifd DSA offloading.
Message-ID: <ZzdbgiubYDYrXB7A@gallifrey>
References: <20241114220132.27399-1-yichen.wang@bytedance.com>
 <20241114220132.27399-9-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241114220132.27399-9-yichen.wang@bytedance.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:31:56 up 191 days,  1:45,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Yichen Wang (yichen.wang@bytedance.com) wrote:
> From: Hao Xiang <hao.xiang@linux.dev>
> 
> Intel DSA offloading is an optional feature that turns on if
> proper hardware and software stack is available. To turn on
> DSA offloading in multifd live migration by setting:
> 
> zero-page-detection=dsa-accel
> dsa-accel-path="dsa:<dsa_dev_path1> dsa:[dsa_dev_path2] ..."

  ^^^^
oops, commit message needs updating, but other than that,
for HMP:

Acked-by: Dr. David Alan Gilbert <dave@treblig.org>

Thanks for making the changes,

Dave

> This feature is turned off by default.
> 
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> ---
>  hmp-commands.hx                |  2 +-
>  include/qemu/dsa.h             | 13 +++++++++++++
>  migration/migration-hmp-cmds.c | 19 ++++++++++++++++++-
>  migration/options.c            | 30 ++++++++++++++++++++++++++++++
>  migration/options.h            |  1 +
>  qapi/migration.json            | 32 ++++++++++++++++++++++++++++----
>  util/dsa.c                     | 31 +++++++++++++++++++++++++++++++
>  7 files changed, 122 insertions(+), 6 deletions(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 06746f0afc..0e04eac7c7 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1009,7 +1009,7 @@ ERST
>  
>      {
>          .name       = "migrate_set_parameter",
> -        .args_type  = "parameter:s,value:s",
> +        .args_type  = "parameter:s,value:S",
>          .params     = "parameter value",
>          .help       = "Set the parameter for migration",
>          .cmd        = hmp_migrate_set_parameter,
> diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> index 8284804a32..258860bd20 100644
> --- a/include/qemu/dsa.h
> +++ b/include/qemu/dsa.h
> @@ -100,6 +100,13 @@ void qemu_dsa_stop(void);
>   */
>  void qemu_dsa_cleanup(void);
>  
> +/**
> + * @brief Check if DSA is supported.
> + *
> + * @return True if DSA is supported, otherwise false.
> + */
> +bool qemu_dsa_is_supported(void);
> +
>  /**
>   * @brief Check if DSA is running.
>   *
> @@ -141,6 +148,12 @@ buffer_is_zero_dsa_batch_sync(QemuDsaBatchTask *batch_task,
>  
>  typedef struct QemuDsaBatchTask {} QemuDsaBatchTask;
>  
> +static inline bool qemu_dsa_is_supported(void)
> +{
> +    return false;
> +}
> +
> +
>  static inline bool qemu_dsa_is_running(void)
>  {
>      return false;
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 20d1a6e219..01c528b80a 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -312,7 +312,16 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: '%s'\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
>              params->tls_authz);
> -
> +        if (params->has_accel_path) {
> +            strList *accel_path = params->accel_path;
> +            monitor_printf(mon, "%s:",
> +                MigrationParameter_str(MIGRATION_PARAMETER_ACCEL_PATH));
> +            while (accel_path) {
> +                monitor_printf(mon, " '%s'", accel_path->value);
> +                accel_path = accel_path->next;
> +            }
> +            monitor_printf(mon, "\n");
> +        }
>          if (params->has_block_bitmap_mapping) {
>              const BitmapMigrationNodeAliasList *bmnal;
>  
> @@ -563,6 +572,14 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_x_checkpoint_delay = true;
>          visit_type_uint32(v, param, &p->x_checkpoint_delay, &err);
>          break;
> +    case MIGRATION_PARAMETER_ACCEL_PATH:
> +        p->has_accel_path = true;
> +        g_autofree char **strv = g_strsplit(valuestr ? : "", " ", -1);
> +        strList **tail = &p->accel_path;
> +        for (int i = 0; strv[i]; i++) {
> +            QAPI_LIST_APPEND(tail, strv[i]);
> +        }
> +        break;
>      case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
>          p->has_multifd_channels = true;
>          visit_type_uint8(v, param, &p->multifd_channels, &err);
> diff --git a/migration/options.c b/migration/options.c
> index ad8d6989a8..ca89fdc4f4 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -13,6 +13,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qemu/dsa.h"
>  #include "exec/target_page.h"
>  #include "qapi/clone-visitor.h"
>  #include "qapi/error.h"
> @@ -809,6 +810,13 @@ const char *migrate_tls_creds(void)
>      return s->parameters.tls_creds;
>  }
>  
> +const strList *migrate_accel_path(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->parameters.accel_path;
> +}
> +
>  const char *migrate_tls_hostname(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -922,6 +930,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->zero_page_detection = s->parameters.zero_page_detection;
>      params->has_direct_io = true;
>      params->direct_io = s->parameters.direct_io;
> +    params->has_accel_path = true;
> +    params->accel_path = QAPI_CLONE(strList, s->parameters.accel_path);
>  
>      return params;
>  }
> @@ -930,6 +940,7 @@ void migrate_params_init(MigrationParameters *params)
>  {
>      params->tls_hostname = g_strdup("");
>      params->tls_creds = g_strdup("");
> +    params->accel_path = NULL;
>  
>      /* Set has_* up only for parameter checks */
>      params->has_throttle_trigger_threshold = true;
> @@ -1142,6 +1153,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>          return false;
>      }
>  
> +    if (params->has_zero_page_detection &&
> +        params->zero_page_detection == ZERO_PAGE_DETECTION_DSA_ACCEL) {
> +        if (!qemu_dsa_is_supported()) {
> +            error_setg(errp, "DSA acceleration is not supported.");
> +            return false;
> +        }
> +    }
> +
>      return true;
>  }
>  
> @@ -1255,6 +1274,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_direct_io) {
>          dest->direct_io = params->direct_io;
>      }
> +
> +    if (params->has_accel_path) {
> +        dest->has_accel_path = true;
> +        dest->accel_path = params->accel_path;
> +    }
>  }
>  
>  static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
> @@ -1387,6 +1411,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_direct_io) {
>          s->parameters.direct_io = params->direct_io;
>      }
> +    if (params->has_accel_path) {
> +        qapi_free_strList(s->parameters.accel_path);
> +        s->parameters.has_accel_path = true;
> +        s->parameters.accel_path =
> +            QAPI_CLONE(strList, params->accel_path);
> +    }
>  }
>  
>  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
> diff --git a/migration/options.h b/migration/options.h
> index 79084eed0d..3d1e91dc52 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -84,6 +84,7 @@ const char *migrate_tls_creds(void);
>  const char *migrate_tls_hostname(void);
>  uint64_t migrate_xbzrle_cache_size(void);
>  ZeroPageDetection migrate_zero_page_detection(void);
> +const strList *migrate_accel_path(void);
>  
>  /* parameters helpers */
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index a605dc26db..389776065d 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -629,10 +629,14 @@
>  #     multifd migration is enabled, else in the main migration thread
>  #     as for @legacy.
>  #
> +# @dsa-accel: Perform zero page checking with the DSA accelerator
> +#     offloading in multifd sender thread if multifd migration is
> +#     enabled, else in the main migration thread as for @legacy.
> +#
>  # Since: 9.0
>  ##
>  { 'enum': 'ZeroPageDetection',
> -  'data': [ 'none', 'legacy', 'multifd' ] }
> +  'data': [ 'none', 'legacy', 'multifd', 'dsa-accel' ] }
>  
>  ##
>  # @BitmapMigrationBitmapAliasTransform:
> @@ -840,6 +844,12 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @accel-path: If enabled, specify the accelerator paths that to be
> +#     used in QEMU. For example, enable DSA accelerator for zero page
> +#     detection offloading by setting the @zero-page-detection to
> +#     dsa-accel, and defines the accel-path to "dsa:<dsa_device path>".
> +#     This parameter is default to an empty list.  (Since 9.2)
> +#
>  # @direct-io: Open migration files with O_DIRECT when possible.  This
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
> @@ -858,7 +868,7 @@
>             'cpu-throttle-initial', 'cpu-throttle-increment',
>             'cpu-throttle-tailslow',
>             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
> -           'avail-switchover-bandwidth', 'downtime-limit',
> +           'avail-switchover-bandwidth', 'downtime-limit', 'accel-path',
>             { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
>             'multifd-channels',
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
> @@ -1021,6 +1031,12 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @accel-path: If enabled, specify the accelerator paths that to be
> +#     used in QEMU. For example, enable DSA accelerator for zero page
> +#     detection offloading by setting the @zero-page-detection to
> +#     dsa-accel, and defines the accel-path to "dsa:<dsa_device path>".
> +#     This parameter is default to an empty list.  (Since 9.2)
> +#
>  # @direct-io: Open migration files with O_DIRECT when possible.  This
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
> @@ -1066,7 +1082,8 @@
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
> -            '*direct-io': 'bool' } }
> +            '*direct-io': 'bool',
> +            '*accel-path': [ 'str' ] } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1231,6 +1248,12 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @accel-path: If enabled, specify the accelerator paths that to be
> +#     used in QEMU. For example, enable DSA accelerator for zero page
> +#     detection offloading by setting the @zero-page-detection to
> +#     dsa-accel, and defines the accel-path to "dsa:<dsa_device path>".
> +#     This parameter is default to an empty list.  (Since 9.2)
> +#
>  # @direct-io: Open migration files with O_DIRECT when possible.  This
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
> @@ -1273,7 +1296,8 @@
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
> -            '*direct-io': 'bool' } }
> +            '*direct-io': 'bool',
> +            '*accel-path': [ 'str' ] } }
>  
>  ##
>  # @query-migrate-parameters:
> diff --git a/util/dsa.c b/util/dsa.c
> index 50f53ec24b..18ed36e354 100644
> --- a/util/dsa.c
> +++ b/util/dsa.c
> @@ -23,6 +23,7 @@
>  #include "qemu/bswap.h"
>  #include "qemu/error-report.h"
>  #include "qemu/rcu.h"
> +#include <cpuid.h>
>  
>  #pragma GCC push_options
>  #pragma GCC target("enqcmd")
> @@ -689,6 +690,36 @@ static void dsa_completion_thread_stop(void *opaque)
>      qemu_sem_destroy(&thread_context->sem_init_done);
>  }
>  
> +/**
> + * @brief Check if DSA is supported.
> + *
> + * @return True if DSA is supported, otherwise false.
> + */
> +bool qemu_dsa_is_supported(void)
> +{
> +    /*
> +     * movdir64b is indicated by bit 28 of ecx in CPUID leaf 7, subleaf 0.
> +     * enqcmd is indicated by bit 29 of ecx in CPUID leaf 7, subleaf 0.
> +     * Doc: https://cdrdv2-public.intel.com/819680/architecture-instruction-\
> +     *      set-extensions-programming-reference.pdf
> +     */
> +    uint32_t eax, ebx, ecx, edx;
> +    bool movedirb_enabled;
> +    bool enqcmd_enabled;
> +
> +    __get_cpuid_count(7, 0, &eax, &ebx, &ecx, &edx);
> +    movedirb_enabled = (ecx >> 28) & 0x1;
> +    if (!movedirb_enabled) {
> +        return false;
> +    }
> +    enqcmd_enabled = (ecx >> 29) & 0x1;
> +    if (!enqcmd_enabled) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  /**
>   * @brief Check if DSA is running.
>   *
> -- 
> Yichen Wang
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

