Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429F2C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 15:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU68N-0005tp-5X; Wed, 17 Jul 2024 10:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sU68L-0005sl-S8
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 10:59:57 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sU68J-0008BG-FS
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 10:59:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D301E21A5C;
 Wed, 17 Jul 2024 14:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721228394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fkqhkvrVsCLHHWok33IGyqdwGbdbgRFkvadGVbRfywQ=;
 b=2G0kaoO35i6EjUi/Ha/Fb5m1tjZ0OEUuai4hPcGRpYL2I+s1FItd+pPi5cB+ujztZiiKtE
 7R6h1yz36kDl2pcvVVuhxO6vbpbmIp48e9hRfTClXcfrC6ucZUisThd+lAbum3Gup7N7aB
 beeLdYJhoCycJgiYlfDFhPhpSepXc5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721228394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fkqhkvrVsCLHHWok33IGyqdwGbdbgRFkvadGVbRfywQ=;
 b=nDRCaGBg7ns2vi2pcsTQrDAXSWnRH59d16iwu4G/IfZgjepKm5UeMAblmzwG4uey8ftM5y
 RtYRxohWDIg1FaDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721228393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fkqhkvrVsCLHHWok33IGyqdwGbdbgRFkvadGVbRfywQ=;
 b=JacfN393XO7DBMiTVUhQb3tw9u6xqn1x6+8ivVKcTwilupmKDtFc1R5yl2QQ5vAFER0aTh
 BiPE3Sj6nqD9ToGplarzKPvCyo/lO8vzEoR+K65PGtNyA4GCu/qQE2qkSHlmj6o70RauZl
 4XHJR0FKIjUjT3zCg+k0xBQ1Q/A8xKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721228393;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fkqhkvrVsCLHHWok33IGyqdwGbdbgRFkvadGVbRfywQ=;
 b=2UP9VJnesAhSPhkTI7cpT4SgdnxEW9l/Hh2I7VPFORJW4m7NA4eXBi6T0/h9isslyQP1Du
 1nllIvlnAWMuRmCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E85C1368F;
 Wed, 17 Jul 2024 14:59:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pmykBWncl2Z3EgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Jul 2024 14:59:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yichen Wang <yichen.wang@bytedance.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Xu
 <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>, Yichen Wang <yichen.wang@bytedance.com>
Subject: Re: [PATCH v5 11/13] migration/multifd: Add migration option set
 packet size.
In-Reply-To: <20240711220451.19780-2-yichen.wang@bytedance.com>
References: <20240711220451.19780-1-yichen.wang@bytedance.com>
 <20240711220451.19780-2-yichen.wang@bytedance.com>
Date: Wed, 17 Jul 2024 11:59:50 -0300
Message-ID: <87msmg2heh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[17]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Yichen Wang <yichen.wang@bytedance.com> writes:

> From: Hao Xiang <hao.xiang@linux.dev>
>
> During live migration, if the latency between sender and receiver is
> high and bandwidth is also high (a long and fat pipe), using a bigger
> packet size can help reduce migration total time. The current multifd
> packet size is 128 * 4kb. In addition, Intel DSA offloading performs
> better with a large batch task.

Last time we measured, mapped-ram also performed slightly better with a
larger packet size:

        2 MiB   1 MiB   512 KiB  256 KiB  128 KiB
AVG(10) 50814   50396     48732    46423    34574
DEV       736     552       619      473     1430

>
> This change adds an option to set the packet size, which is also useful
> for performance tunin. Both sender and receiver needs to set the same
> packet size for things to work.
>
> Set the option:
> migrate_set_parameter multifd-packet-size 4190208
>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> ---
>  migration/migration-hmp-cmds.c |  7 +++++++
>  migration/multifd-zlib.c       |  6 ++++--
>  migration/multifd-zstd.c       |  6 ++++--
>  migration/multifd.c            |  6 ++++--
>  migration/multifd.h            |  3 ---
>  migration/options.c            | 38 ++++++++++++++++++++++++++++++++++
>  migration/options.h            |  1 +
>  qapi/migration.json            | 21 ++++++++++++++++---
>  8 files changed, 76 insertions(+), 12 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index c422db4ecd..27ba0ce79a 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -292,6 +292,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %u ms\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELAY),
>              params->x_checkpoint_delay);
> +        monitor_printf(mon, "%s: %" PRIu64 "\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_PACKET_SIZE),
> +            params->multifd_packet_size);
>          monitor_printf(mon, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
>              params->multifd_channels);
> @@ -576,6 +579,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_dsa_accel_path = true;
>          visit_type_strList(v, param, &p->dsa_accel_path, &err);
>          break;
> +    case MIGRATION_PARAMETER_MULTIFD_PACKET_SIZE:
> +        p->has_multifd_packet_size = true;
> +        visit_type_size(v, param, &p->multifd_packet_size, &err);
> +        break;
>      case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
>          p->has_multifd_channels = true;
>          visit_type_uint8(v, param, &p->multifd_channels, &err);
> diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
> index 2ced69487e..bd900fe575 100644
> --- a/migration/multifd-zlib.c
> +++ b/migration/multifd-zlib.c
> @@ -49,6 +49,7 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
>      struct zlib_data *z = g_new0(struct zlib_data, 1);
>      z_stream *zs = &z->zs;
>      const char *err_msg;
> +    uint64_t multifd_packet_size = migrate_multifd_packet_size();
>  
>      zs->zalloc = Z_NULL;
>      zs->zfree = Z_NULL;
> @@ -58,7 +59,7 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
>          goto err_free_z;
>      }
>      /* This is the maximum size of the compressed buffer */
> -    z->zbuff_len = compressBound(MULTIFD_PACKET_SIZE);
> +    z->zbuff_len = compressBound(multifd_packet_size);
>      z->zbuff = g_try_malloc(z->zbuff_len);
>      if (!z->zbuff) {
>          err_msg = "out of memory for zbuff";
> @@ -200,6 +201,7 @@ out:
>   */
>  static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
>  {
> +    uint64_t multifd_packet_size = migrate_multifd_packet_size();
>      struct zlib_data *z = g_new0(struct zlib_data, 1);
>      z_stream *zs = &z->zs;
>  
> @@ -214,7 +216,7 @@ static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
>          return -1;
>      }
>      /* To be safe, we reserve twice the size of the packet */
> -    z->zbuff_len = MULTIFD_PACKET_SIZE * 2;
> +    z->zbuff_len = multifd_packet_size * 2;
>      z->zbuff = g_try_malloc(z->zbuff_len);
>      if (!z->zbuff) {
>          inflateEnd(zs);
> diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
> index ca17b7e310..8aaa7363be 100644
> --- a/migration/multifd-zstd.c
> +++ b/migration/multifd-zstd.c
> @@ -49,6 +49,7 @@ struct zstd_data {
>   */
>  static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
>  {
> +    uint64_t multifd_packet_size = migrate_multifd_packet_size();
>      struct zstd_data *z = g_new0(struct zstd_data, 1);
>      int res;
>  
> @@ -68,7 +69,7 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
>          return -1;
>      }
>      /* This is the maximum size of the compressed buffer */
> -    z->zbuff_len = ZSTD_compressBound(MULTIFD_PACKET_SIZE);
> +    z->zbuff_len = ZSTD_compressBound(multifd_packet_size);
>      z->zbuff = g_try_malloc(z->zbuff_len);
>      if (!z->zbuff) {
>          ZSTD_freeCStream(z->zcs);
> @@ -188,6 +189,7 @@ out:
>   */
>  static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
>  {
> +    uint64_t multifd_packet_size = migrate_multifd_packet_size();
>      struct zstd_data *z = g_new0(struct zstd_data, 1);
>      int ret;
>  
> @@ -209,7 +211,7 @@ static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
>      }
>  
>      /* To be safe, we reserve twice the size of the packet */
> -    z->zbuff_len = MULTIFD_PACKET_SIZE * 2;
> +    z->zbuff_len = multifd_packet_size * 2;
>      z->zbuff = g_try_malloc(z->zbuff_len);
>      if (!z->zbuff) {
>          ZSTD_freeDStream(z->zds);
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 014fee757a..87ed421364 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1189,7 +1189,8 @@ bool multifd_send_setup(Error **errp)
>      MigrationState *s = migrate_get_current();
>      Error *local_err = NULL;
>      int thread_count, ret = 0;
> -    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> +    uint32_t page_count =
> +        migrate_multifd_packet_size() / qemu_target_page_size();
>      bool use_packets = multifd_use_packets();
>      uint8_t i;
>  
> @@ -1600,7 +1601,8 @@ static void *multifd_recv_thread(void *opaque)
>  int multifd_recv_setup(Error **errp)
>  {
>      int thread_count;
> -    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> +    uint32_t page_count =
> +        migrate_multifd_packet_size() / qemu_target_page_size();
>      bool use_packets = multifd_use_packets();
>      uint8_t i;
>      int ret;
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 871e3aa063..63cec33c61 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -44,9 +44,6 @@ MultiFDRecvData *multifd_get_recv_data(void);
>  #define MULTIFD_FLAG_QPL (4 << 1)
>  #define MULTIFD_FLAG_UADK (8 << 1)
>  
> -/* This value needs to be a multiple of qemu_target_page_size() */
> -#define MULTIFD_PACKET_SIZE (512 * 1024)
> -
>  typedef struct {
>      uint32_t magic;
>      uint32_t version;
> diff --git a/migration/options.c b/migration/options.c
> index f839493016..1417fa6ab0 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -73,6 +73,12 @@
>  #define DEFAULT_MIGRATE_ANNOUNCE_ROUNDS    5
>  #define DEFAULT_MIGRATE_ANNOUNCE_STEP    100
>  
> +/*
> + * Parameter for multifd packet size.
> + */
> +#define DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE (128 * 4 * 1024)
> +#define MAX_MIGRATE_MULTIFD_PACKET_SIZE (1023 * 4 * 1024)

Why 1023?

> +
>  #define DEFINE_PROP_MIG_CAP(name, x)             \
>      DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
>  
> @@ -167,6 +173,9 @@ Property migration_properties[] = {
>      /*                    parameters.dsa_accel_path, qdev_prop_string, char *), */
>      /* DEFINE_PROP_STRING("dsa-accel-path", MigrationState, */
>      /*                    parameters.dsa_accel_path), */
> +    DEFINE_PROP_SIZE("multifd-packet-size", MigrationState,
> +                     parameters.multifd_packet_size,
> +                     DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE),
>  
>      /* Migration capabilities */
>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> @@ -777,6 +786,13 @@ int migrate_multifd_channels(void)
>      return s->parameters.multifd_channels;
>  }
>  
> +uint64_t migrate_multifd_packet_size(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->parameters.multifd_packet_size;
> +}
> +
>  MultiFDCompression migrate_multifd_compression(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -898,6 +914,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->downtime_limit = s->parameters.downtime_limit;
>      params->has_x_checkpoint_delay = true;
>      params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
> +    params->has_multifd_packet_size = true;
> +    params->multifd_packet_size = s->parameters.multifd_packet_size;
>      params->has_multifd_channels = true;
>      params->multifd_channels = s->parameters.multifd_channels;
>      params->has_multifd_compression = true;
> @@ -957,6 +975,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_max_bandwidth = true;
>      params->has_downtime_limit = true;
>      params->has_x_checkpoint_delay = true;
> +    params->has_multifd_packet_size = true;
>      params->has_multifd_channels = true;
>      params->has_multifd_compression = true;
>      params->has_multifd_zlib_level = true;
> @@ -1038,6 +1057,19 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>  
>      /* x_checkpoint_delay is now always positive */
>  
> +    if (params->has_multifd_packet_size &&
> +        ((params->multifd_packet_size < DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE) ||
> +            (params->multifd_packet_size >  MAX_MIGRATE_MULTIFD_PACKET_SIZE) ||
> +            (params->multifd_packet_size % qemu_target_page_size() != 0))) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +                    "multifd_packet_size",
> +                    "an integer in the range of "
> +                    stringify(DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE)
> +                    " to "stringify(MAX_MIGRATE_MULTIFD_PACKET_SIZE)", "
> +                    "and must be a multiple of guest VM's page size.");
> +        return false;
> +    }
> +
>      if (params->has_multifd_channels && (params->multifd_channels < 1)) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>                     "multifd_channels",
> @@ -1219,6 +1251,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>          dest->x_checkpoint_delay = params->x_checkpoint_delay;
>      }
>  
> +    if (params->has_multifd_packet_size) {
> +        dest->multifd_packet_size = params->multifd_packet_size;
> +    }
>      if (params->has_multifd_channels) {
>          dest->multifd_channels = params->multifd_channels;
>      }
> @@ -1344,6 +1379,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>          colo_checkpoint_delay_set();
>      }
>  
> +    if (params->has_multifd_packet_size) {
> +        s->parameters.multifd_packet_size = params->multifd_packet_size;
> +    }
>      if (params->has_multifd_channels) {
>          s->parameters.multifd_channels = params->multifd_channels;
>      }
> diff --git a/migration/options.h b/migration/options.h
> index 78b9e4080b..b37cffc887 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -86,6 +86,7 @@ const char *migrate_tls_hostname(void);
>  uint64_t migrate_xbzrle_cache_size(void);
>  ZeroPageDetection migrate_zero_page_detection(void);
>  const strList *migrate_dsa_accel_path(void);
> +uint64_t migrate_multifd_packet_size(void);
>  
>  /* parameters helpers */
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index ff41780347..1a9dc5d74c 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -839,6 +839,10 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @multifd-packet-size: Packet size in bytes used to migrate data.
> +#     The value needs to be a multiple of guest page size.
> +#     The default value is 524288 and max value is 4190208. (Since 9.2)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and
> @@ -864,7 +868,8 @@
>             'vcpu-dirty-limit',
>             'mode',
>             'zero-page-detection',
> -           'direct-io'] }
> +           'direct-io',
> +           'multifd-packet-size'] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -1020,6 +1025,10 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @multifd-packet-size: Packet size in bytes used to migrate data.
> +#     The value needs to be a multiple of guest page size.
> +#     The default value is 524288 and max value is 4190208. (Since 9.2)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and
> @@ -1061,7 +1070,8 @@
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
>              '*direct-io': 'bool',
> -            '*dsa-accel-path': ['str'] } }
> +            '*dsa-accel-path': ['str'],
> +            '*multifd-packet-size' : 'uint64'} }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1231,6 +1241,10 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @multifd-packet-size: Packet size in bytes used to migrate data.
> +#     The value needs to be a multiple of guest page size.
> +#     The default value is 524288 and max value is 4190208. (Since 9.2)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and
> @@ -1269,7 +1283,8 @@
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
>              '*direct-io': 'bool',
> -            '*dsa-accel-path': ['str'] } }
> +            '*dsa-accel-path': ['str'],
> +            '*multifd-packet-size': 'uint64'} }
>  
>  ##
>  # @query-migrate-parameters:

