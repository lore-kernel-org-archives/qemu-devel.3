Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E43F9D0DA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCgMI-00050M-Fo; Tue, 14 Apr 2026 12:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wCgMG-0004zR-Jj
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 12:11:24 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wCgME-0004Nt-52
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 12:11:24 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4EE346A8C4;
 Tue, 14 Apr 2026 16:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776183079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xWSVVoxSb5wBAmySmkuBOM4XrDfX0XFdBiMFTttefAw=;
 b=BlxPt5gOE+UF9cCGaxYY0MoiS1gDPxD8ILBRKVMQ9NEJkJ7CLPPR8VTuZRW05Y2fTq5tzY
 7Mk77lA9h/NT79uMQlWC+5MYxJJEjL5C3zMz8dSoGqzH50OeGMm+MZjjoulxn54aiXh8hU
 czG8DTcJ2ZSDWJqqg3EsWjBGriUcv/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776183079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xWSVVoxSb5wBAmySmkuBOM4XrDfX0XFdBiMFTttefAw=;
 b=CI2Iq48u5nhSo6Qnfcmx9wKDkPaxiaj/2IUp8SFg0sTcONybOFwZ2EcJsXjoJbTfUPsGT8
 rcOhz6IxFxb6EWAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BlxPt5gO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CI2Iq48u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776183079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xWSVVoxSb5wBAmySmkuBOM4XrDfX0XFdBiMFTttefAw=;
 b=BlxPt5gOE+UF9cCGaxYY0MoiS1gDPxD8ILBRKVMQ9NEJkJ7CLPPR8VTuZRW05Y2fTq5tzY
 7Mk77lA9h/NT79uMQlWC+5MYxJJEjL5C3zMz8dSoGqzH50OeGMm+MZjjoulxn54aiXh8hU
 czG8DTcJ2ZSDWJqqg3EsWjBGriUcv/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776183079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xWSVVoxSb5wBAmySmkuBOM4XrDfX0XFdBiMFTttefAw=;
 b=CI2Iq48u5nhSo6Qnfcmx9wKDkPaxiaj/2IUp8SFg0sTcONybOFwZ2EcJsXjoJbTfUPsGT8
 rcOhz6IxFxb6EWAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFF1C4B521;
 Tue, 14 Apr 2026 16:11:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HPd7KyZn3mlVYwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 14 Apr 2026 16:11:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Samuel Zhang <guoqing.zhang@amd.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, lizhijian@fujitsu.com, eblake@redhat.com,
 armbru@redhat.com, Emily.Deng@amd.com, Victor.Zhao@amd.com,
 PengJu.Zhou@amd.com, Qing.Ma@amd.com, Samuel Zhang <guoqing.zhang@amd.com>
Subject: Re: [PATCH v5] migration/rdma: add x-rdma-chunk-size parameter
In-Reply-To: <20260413035703.2602065-1-guoqing.zhang@amd.com>
References: <20260413035703.2602065-1-guoqing.zhang@amd.com>
Date: Tue, 14 Apr 2026 13:11:12 -0300
Message-ID: <875x5tzfmn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email,amd.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 4EE346A8C4
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Samuel Zhang <guoqing.zhang@amd.com> writes:

> The default 1MB RDMA chunk size causes slow live migration because
> each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
> 1MB chunk size produces ~15000 flushes vs ~3700 with 1024MB chunk size.
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
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Li Zhijian <lizhijian@fujitsu.com>
> Tested-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> v2:
> - Renamed x-rdma-chunk-shift to x-rdma-chunk-size (byte count)
> - Added validation in migrate_params_check()
> - Added hmp_migrate_set_parameter() support
> - Added hmp_info_migrate_parameters() support
> - Added migrate_mark_all_params_present()
> - Use qemu_strtosz() for size suffix support
> v3: [Markus]
> - Use visit_type_size() in HMP set parameter
> - Use MiB/GiB constants
> v4: [Markus]
> - Remove superfluous comment on DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE
> - Use "Only applies when migrating via RDMA" in QAPI doc
> v5:
> - Document that x-rdma-chunk-size must be set to the same value on both
>     source and destination before migration starts.
> - Add Acked-by and Tested-by from Li Zhijian.
>
>  migration/migration-hmp-cmds.c | 11 +++++++++++
>  migration/options.c            | 33 ++++++++++++++++++++++++++++++++-
>  migration/options.h            |  1 +
>  migration/rdma.c               | 30 ++++++++++++++++--------------
>  qapi/migration.json            | 13 +++++++++++--
>  5 files changed, 71 insertions(+), 17 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 0a193b8f54..4f6c1dbf89 100644
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
> @@ -734,6 +741,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_direct_io = true;
>          visit_type_bool(v, param, &p->direct_io, &err);
>          break;
> +    case MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE:
> +        p->has_x_rdma_chunk_size = true;
> +        visit_type_size(v, param, &p->x_rdma_chunk_size, &err);
> +        break;
>      case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
>          /*
>           * NOTE: g_autofree will only auto g_free() the strv array when
> diff --git a/migration/options.c b/migration/options.c
> index 7556fbc06b..2b5158200b 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -13,6 +13,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qemu/units.h"
>  #include "exec/target_page.h"
>  #include "qapi/clone-visitor.h"
>  #include "qapi/error.h"
> @@ -90,6 +91,7 @@ const PropertyInfo qdev_prop_StrOrNull;
>  
>  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
>  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
> +#define DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE           MiB
>  
>  const Property migration_properties[] = {
>      DEFINE_PROP_BOOL("store-global-state", MigrationState,
> @@ -183,6 +185,9 @@ const Property migration_properties[] = {
>      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
>                         parameters.zero_page_detection,
>                         ZERO_PAGE_DETECTION_MULTIFD),
> +    DEFINE_PROP_UINT64("x-rdma-chunk-size", MigrationState,
> +                      parameters.x_rdma_chunk_size,
> +                      DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE),
>  
>      /* Migration capabilities */
>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> @@ -1000,6 +1005,15 @@ ZeroPageDetection migrate_zero_page_detection(void)
>      return s->parameters.zero_page_detection;
>  }
>  
> +uint64_t migrate_rdma_chunk_size(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +    uint64_t size = s->parameters.x_rdma_chunk_size;
> +
> +    assert(MiB <= size && size <= GiB && is_power_of_2(size));
> +    return size;
> +}
> +
>  /* parameters helpers */
>  
>  AnnounceParameters *migrate_announce_params(void)
> @@ -1062,7 +1076,7 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
>          &p->has_announce_step, &p->has_block_bitmap_mapping,
>          &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
>          &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
> -        &p->has_cpr_exec_command,
> +        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
>      };
>  
>      len = ARRAY_SIZE(has_fields);
> @@ -1273,6 +1287,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>          return false;
>      }
>  
> +    if (params->has_x_rdma_chunk_size &&
> +        (params->x_rdma_chunk_size < MiB ||
> +         params->x_rdma_chunk_size > GiB ||
> +         !is_power_of_2(params->x_rdma_chunk_size))) {
> +        error_setg(errp, "Option x_rdma_chunk_size expects "
> +                   "a power of 2 in the range 1MiB to 1024MiB");
> +        return false;
> +    }
> +
>      return true;
>  }
>  
> @@ -1398,6 +1421,10 @@ static void migrate_params_test_apply(MigrationParameters *params,
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
> @@ -1524,6 +1551,10 @@ static void migrate_params_apply(MigrationParameters *params)
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
> index 7134d4ce47..0db115ec5e 100644
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
> @@ -1007,9 +1008,15 @@
>  #     is @cpr-exec.  The first list element is the program's filename,
>  #     the remainder its arguments.  (Since 10.2)
>  #
> +# @x-rdma-chunk-size: RDMA memory registration chunk size in bytes.
> +#     Default is 1MiB.  Must be a power of 2 in the range
> +#     [1MiB, 1024MiB].  Only applies when migrating via RDMA.
> +#     Must be set to the same value on both source and destination
> +#     before migration starts.  (Since 11.1)
> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> +# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
>  #     @x-vcpu-dirty-limit-period are experimental.
>  #
>  # Since: 2.4
> @@ -1046,6 +1053,8 @@
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
>              '*direct-io': 'bool',
> +            '*x-rdma-chunk-size': { 'type': 'uint64',
> +                                    'features': [ 'unstable' ] },
>              '*cpr-exec-command': [ 'str' ]} }
>  
>  ##

Acked-by: Fabiano Rosas <farosas@suse.de>

