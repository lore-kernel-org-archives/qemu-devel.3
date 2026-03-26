Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941BC109E55C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5efQ-0001tA-Rq; Thu, 26 Mar 2026 02:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5efP-0001t1-TK
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5efN-0005By-Sa
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774508284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zrTRRA12XoF3Tbcx0OtGL8uHjh+JUS5huNv0oocD7sI=;
 b=NhaN9AnUZPm+ayQfNaQjzkWdAr3b51hBJWEbzV2fjXsa6BZtuDlfnCrm5XYkxNcB9doPpk
 NIByaa1PPdneP1b0digLZtbyCqS8qko+Un0jOWdpxyo01PrdJoviTH5iTVIbUydGyWdDo6
 WnH6kkWzSP0mxuslToa+TrT9OMMiW70=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-Fr146CYjNKCu-tUksuc5mw-1; Thu,
 26 Mar 2026 02:58:01 -0400
X-MC-Unique: Fr146CYjNKCu-tUksuc5mw-1
X-Mimecast-MFC-AGG-ID: Fr146CYjNKCu-tUksuc5mw_1774508280
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E11C61954B1C; Thu, 26 Mar 2026 06:57:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AF2619560B1; Thu, 26 Mar 2026 06:57:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C3E1621E6937; Thu, 26 Mar 2026 07:57:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Samuel Zhang <guoqing.zhang@amd.com>
Cc: <qemu-devel@nongnu.org>,  <peterx@redhat.com>,  <farosas@suse.de>,
 <lizhijian@fujitsu.com>,  <eblake@redhat.com>,  <armbru@redhat.com>,
 <Emily.Deng@amd.com>,  <Victor.Zhao@amd.com>,  <PengJu.Zhou@amd.com>,
 <Qing.Ma@amd.com>
Subject: Re: [PATCH v2] migration/rdma: add x-rdma-chunk-size parameter
In-Reply-To: <20260326025825.2427332-1-guoqing.zhang@amd.com> (Samuel Zhang's
 message of "Thu, 26 Mar 2026 10:58:25 +0800")
References: <20260316062308.1240426-1-guoqing.zhang@amd.com>
 <20260326025825.2427332-1-guoqing.zhang@amd.com>
Date: Thu, 26 Mar 2026 07:57:56 +0100
Message-ID: <87jyuzhybv.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

By convention, we don't post new patches in reply to old ones.  Next
time :)

Samuel Zhang <guoqing.zhang@amd.com> writes:

> The default 1MB RDMA chunk size causes slow live migration because
> each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
> 1MB chunk size produce ~15000 flushes vs ~3700 with 1024MB chunk size.
>
> Add x-rdma-chunk-size parameter to configure the RDMA chunk size for
> faster migration.
> Usage: `migrate_set_parameter x-rdma-chunk-size 1024M`
>
> Performance with RDMA live migration of 8GB RAM VM:
>
> | x-rdma-chunk-size (B) | time (s) | throughput (MB/s) |
> |-----------------------|----------|-------------------|
> | 1M (default)          | 37.915   |  1,007            |
> | 32M                   | 17.880   |  2,260            |
> | 1024M                 |  4.368   | 17,529            |
>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
> v2:
> - Renamed x-rdma-chunk-shift to x-rdma-chunk-size (byte count)
> - Added validation in migrate_params_check()
> - Added hmp_migrate_set_parameter() support
> - Added hmp_info_migrate_parameters() support
> - Added migrate_mark_all_params_present()
> - Use qemu_strtosz() for size suffix support
>
>  migration/migration-hmp-cmds.c | 17 +++++++++++++++++
>  migration/options.c            | 32 +++++++++++++++++++++++++++++++-
>  migration/options.h            |  1 +
>  migration/rdma.c               | 30 ++++++++++++++++--------------
>  qapi/migration.json            | 11 +++++++++--
>  5 files changed, 74 insertions(+), 17 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 0a193b8f54..2c005c08a6 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -451,6 +451,13 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>                             params->direct_io ? "on" : "off");
>          }
>  
> +        if (params->has_x_rdma_chunk_size) {
> +            monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
> +                           MigrationParameter_str(
> +                               MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE),
> +                           params->x_rdma_chunk_size);
> +        }
> +
>          assert(params->has_cpr_exec_command);
>          monitor_print_cpr_exec_command(mon, params->cpr_exec_command);
>      }
> @@ -730,6 +737,16 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_mode = true;
>          visit_type_MigMode(v, param, &p->mode, &err);
>          break;
> +    case MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE:
> +        p->has_x_rdma_chunk_size = true;
> +        ret = qemu_strtosz(valuestr, NULL, &valuebw);

We use several variations of the conversion to size:

                       default          examples
function                suffix  scale     "1"         "64K"
-----------------------------------------------------------
qemu_strtosz()             B     1024      1        64*1024
qemu_strtosz_MiB()         M     1024   1024*1024   64*1024
qemu_strtosz_metric()      B     1000      1        64*1000

Unfortunate complication of the user interface if you ask me, but
changing it now is likely a bad idea.  My point is: which one to use
here?

This function uses two: qemu_strtosz_MiB() directly, and qemu_strtosz()
via visit_type_size().

Unless you have a specific reason to want default suffix 'M', use
visit_type_size(), it's less code, and the error reporting is better.


> +        if (ret != 0 || valuebw < (1<<20) || valuebw > (1<<30)
> +            || !is_power_of_2(valuebw)) {
> +            error_setg(&err, "Invalid size %s", valuestr);
> +            break;
> +        }

This is partly redundant with the checking in migrate_params_check().

If you use visit_type_size(), you don't need it at all.

If you use qemu_strtosz_MiB(), you should check less.  Have a look at
the other uses in this function.

> +        p->x_rdma_chunk_size = valuebw;
> +        break;
>      case MIGRATION_PARAMETER_DIRECT_IO:
>          p->has_direct_io = true;
>          visit_type_bool(v, param, &p->direct_io, &err);
> diff --git a/migration/options.c b/migration/options.c
> index f33b297929..91dd874b5e 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -90,6 +90,7 @@ const PropertyInfo qdev_prop_StrOrNull;
>  
>  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
>  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
> +#define DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE           (1<<20) /* 1MB */
>  
>  const Property migration_properties[] = {
>      DEFINE_PROP_BOOL("store-global-state", MigrationState,
> @@ -183,6 +184,9 @@ const Property migration_properties[] = {
>      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
>                         parameters.zero_page_detection,
>                         ZERO_PAGE_DETECTION_MULTIFD),
> +    DEFINE_PROP_UINT64("x-rdma-chunk-size", MigrationState,
> +                      parameters.x_rdma_chunk_size,
> +                      DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE),
>  
>      /* Migration capabilities */
>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> @@ -993,6 +997,15 @@ ZeroPageDetection migrate_zero_page_detection(void)
>      return s->parameters.zero_page_detection;
>  }
>  
> +uint64_t migrate_rdma_chunk_size(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +    uint64_t size = s->parameters.x_rdma_chunk_size;
> +
> +    assert((1<<20) <= size && size <= (1<<30) && is_power_of_2(size));

Suggest MiB <= size && size <= GiB.

> +    return size;
> +}
> +
>  /* parameters helpers */
>  
>  AnnounceParameters *migrate_announce_params(void)
> @@ -1055,7 +1068,7 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
>          &p->has_announce_step, &p->has_block_bitmap_mapping,
>          &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
>          &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
> -        &p->has_cpr_exec_command,
> +        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
>      };
>  
>      len = ARRAY_SIZE(has_fields);
> @@ -1227,6 +1240,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>          return false;
>      }
>  
> +    if (params->has_x_rdma_chunk_size &&
> +        (params->x_rdma_chunk_size < (1<<20) ||
> +         params->x_rdma_chunk_size > (1<<30) ||

Suggest < MiB and > GiB.

> +         !is_power_of_2(params->x_rdma_chunk_size))) {
> +        error_setg(errp, "Option x_rdma_chunk_size expects "
> +                   "a power of 2 in the range 1M to 1024M");
> +        return false;
> +    }
> +
>      if (!check_dirty_bitmap_mig_alias_map(params->block_bitmap_mapping, errp)) {
>          error_prepend(errp, "Invalid mapping given for block-bitmap-mapping: ");
>          return false;
> @@ -1391,6 +1413,10 @@ static void migrate_params_test_apply(MigrationParameters *params,
>          dest->direct_io = params->direct_io;
>      }
>  
> +    if (params->has_x_rdma_chunk_size) {
> +        dest->x_rdma_chunk_size = params->x_rdma_chunk_size;
> +    }
> +
>      if (params->has_cpr_exec_command) {
>          dest->cpr_exec_command = params->cpr_exec_command;
>      }
> @@ -1517,6 +1543,10 @@ static void migrate_params_apply(MigrationParameters *params)
>          s->parameters.direct_io = params->direct_io;
>      }
>  
> +    if (params->has_x_rdma_chunk_size) {
> +        s->parameters.x_rdma_chunk_size = params->x_rdma_chunk_size;
> +    }
> +
>      if (params->has_cpr_exec_command) {
>          qapi_free_strList(s->parameters.cpr_exec_command);
>          s->parameters.cpr_exec_command =
> diff --git a/migration/options.h b/migration/options.h
> index b502871097..b46221998a 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -87,6 +87,7 @@ const char *migrate_tls_creds(void);
>  const char *migrate_tls_hostname(void);
>  uint64_t migrate_xbzrle_cache_size(void);
>  ZeroPageDetection migrate_zero_page_detection(void);
> +uint64_t migrate_rdma_chunk_size(void);
>  
>  /* parameters helpers */
>  
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 55ab85650a..3e37a1d440 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -45,10 +45,12 @@
>  #define RDMA_RESOLVE_TIMEOUT_MS 10000
>  
>  /* Do not merge data if larger than this. */
> -#define RDMA_MERGE_MAX (2 * 1024 * 1024)
> -#define RDMA_SIGNALED_SEND_MAX (RDMA_MERGE_MAX / 4096)
> +static inline uint64_t rdma_merge_max(void)
> +{
> +    return migrate_rdma_chunk_size() * 2;
> +}
>  
> -#define RDMA_REG_CHUNK_SHIFT 20 /* 1 MB */
> +#define RDMA_SIGNALED_SEND_MAX 512
>  
>  /*
>   * This is only for non-live state being migrated.
> @@ -527,21 +529,21 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
>  static inline uint64_t ram_chunk_index(const uint8_t *start,
>                                         const uint8_t *host)
>  {
> -    return ((uintptr_t) host - (uintptr_t) start) >> RDMA_REG_CHUNK_SHIFT;
> +    return ((uintptr_t) host - (uintptr_t) start) / migrate_rdma_chunk_size();

Double-checking: this function isn't speed-critical, correct?

>  }
>  
>  static inline uint8_t *ram_chunk_start(const RDMALocalBlock *rdma_ram_block,
>                                         uint64_t i)
>  {
>      return (uint8_t *)(uintptr_t)(rdma_ram_block->local_host_addr +
> -                                  (i << RDMA_REG_CHUNK_SHIFT));
> +                                  (i * migrate_rdma_chunk_size()));
>  }
>  
>  static inline uint8_t *ram_chunk_end(const RDMALocalBlock *rdma_ram_block,
>                                       uint64_t i)
>  {
>      uint8_t *result = ram_chunk_start(rdma_ram_block, i) +
> -                                         (1UL << RDMA_REG_CHUNK_SHIFT);
> +                                         migrate_rdma_chunk_size();
>  
>      if (result > (rdma_ram_block->local_host_addr + rdma_ram_block->length)) {
>          result = rdma_ram_block->local_host_addr + rdma_ram_block->length;
> @@ -1841,6 +1843,7 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
>      struct ibv_send_wr *bad_wr;
>      int reg_result_idx, ret, count = 0;
>      uint64_t chunk, chunks;
> +    uint64_t chunk_size = migrate_rdma_chunk_size();
>      uint8_t *chunk_start, *chunk_end;
>      RDMALocalBlock *block = &(rdma->local_ram_blocks.block[current_index]);
>      RDMARegister reg;
> @@ -1861,22 +1864,21 @@ retry:
>      chunk_start = ram_chunk_start(block, chunk);
>  
>      if (block->is_ram_block) {
> -        chunks = length / (1UL << RDMA_REG_CHUNK_SHIFT);
> +        chunks = length / chunk_size;
>  
> -        if (chunks && ((length % (1UL << RDMA_REG_CHUNK_SHIFT)) == 0)) {
> +        if (chunks && ((length % chunk_size) == 0)) {
>              chunks--;
>          }
>      } else {
> -        chunks = block->length / (1UL << RDMA_REG_CHUNK_SHIFT);
> +        chunks = block->length / chunk_size;
>  
> -        if (chunks && ((block->length % (1UL << RDMA_REG_CHUNK_SHIFT)) == 0)) {
> +        if (chunks && ((block->length % chunk_size) == 0)) {
>              chunks--;
>          }
>      }
>  
>      trace_qemu_rdma_write_one_top(chunks + 1,
> -                                  (chunks + 1) *
> -                                  (1UL << RDMA_REG_CHUNK_SHIFT) / 1024 / 1024);
> +                                  (chunks + 1) * chunk_size / 1024 / 1024);
>  
>      chunk_end = ram_chunk_end(block, chunk + chunks);
>  
> @@ -2176,7 +2178,7 @@ static int qemu_rdma_write(RDMAContext *rdma,
>      rdma->current_length += len;
>  
>      /* flush it if buffer is too large */
> -    if (rdma->current_length >= RDMA_MERGE_MAX) {
> +    if (rdma->current_length >= rdma_merge_max()) {
>          return qemu_rdma_write_flush(rdma, errp);
>      }
>  
> @@ -3522,7 +3524,7 @@ int rdma_registration_handle(QEMUFile *f)
>                  } else {
>                      chunk = reg->key.chunk;
>                      host_addr = block->local_host_addr +
> -                        (reg->key.chunk * (1UL << RDMA_REG_CHUNK_SHIFT));
> +                        (reg->key.chunk * migrate_rdma_chunk_size());
>                      /* Check for particularly bad chunk value */
>                      if (host_addr < (void *)block->local_host_addr) {
>                          error_report("rdma: bad chunk for block %s"
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7134d4ce47..94d2c1c65f 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -806,7 +806,7 @@
>  #
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> +# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
>  #     @x-vcpu-dirty-limit-period are experimental.
>  #
>  # Since: 2.4
> @@ -831,6 +831,7 @@
>             'mode',
>             'zero-page-detection',
>             'direct-io',
> +           { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
>             'cpr-exec-command'] }
>  
>  ##
> @@ -1007,9 +1008,13 @@
>  #     is @cpr-exec.  The first list element is the program's filename,
>  #     the remainder its arguments.  (Since 10.2)
>  #
> +# @x-rdma-chunk-size: RDMA memory registration chunk size in bytes.
> +#     Default is 1M.  Must be a power of 2 in the range [1M, 1024M].

Let's use 1MiB and 1024MiB for extra clarity.

> +#     Only takes effect for RDMA migration.  (Since 11.1)
> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> +# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
>  #     @x-vcpu-dirty-limit-period are experimental.
>  #
>  # Since: 2.4
> @@ -1046,6 +1051,8 @@
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
>              '*direct-io': 'bool',
> +            '*x-rdma-chunk-size': { 'type': 'uint64',
> +                                    'features': [ 'unstable' ] },
>              '*cpr-exec-command': [ 'str' ]} }
>  
>  ##


