Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A08D3C52C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 19:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Vzf-0005J1-HX; Thu, 17 Oct 2024 15:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1Vze-0005Iq-Fb
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 15:17:06 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1Vzc-0006dn-1V
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 15:17:06 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DD9391FD4B;
 Thu, 17 Oct 2024 19:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729192621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwl5fO0N8HDEQQzuysFJaPxSXvNSpPl4jWrfoUIME5o=;
 b=efdZc3Kk4GrolvUPkVjFCxfjtQQQVDfkiD9wCE8+A4T0UR82qP7ADTdqvDksjNOEoHkD6p
 +//tfnd4pxMiT8Vx3qlGOhdxdmjGvm/5sjmaSeMc/ThvhCOqmwRXDiCRUqYtZ+4z+9d47C
 tWz4zknlwRtuxb5VVAtI+wyhy7pHUOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729192621;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwl5fO0N8HDEQQzuysFJaPxSXvNSpPl4jWrfoUIME5o=;
 b=LNt0flkY7FOyXNNXujFsDlW43TXr7VpT/vaKQL7Q9cpbQAfLJgt1TGN0p1W0Jz/6EGdcAF
 8HoEb07dxYq21XDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pbxJk74N;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/jesHrke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729192620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwl5fO0N8HDEQQzuysFJaPxSXvNSpPl4jWrfoUIME5o=;
 b=pbxJk74N22z9gALUkqe0pWhSgotKWi+ZSAsuJjMjbCALtiYMFreH5p8A0xiipaftUYbNBl
 ZcRJGsHoX33JWAMA+ywlg+SfQHy8KwIzqMLu+iIcU43R5halNSa8KlGRxB8sL0mpcbYQ/e
 U90onWHOkfEYS5VRD2gxcLzQJPxqItE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729192620;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwl5fO0N8HDEQQzuysFJaPxSXvNSpPl4jWrfoUIME5o=;
 b=/jesHrkee4VYbsa+GGES7TlVKL9ehuoVIn8NCIEeJGY6ZO4SPmS04kIr5vVBlMVH01el/2
 XtFgbviQgfZkcYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CFA313A42;
 Thu, 17 Oct 2024 19:17:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uIA8CaxiEWdydwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 17 Oct 2024 19:17:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yichen Wang <yichen.wang@bytedance.com>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-A?=
 =?utf-8?Q?ndr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Xu
 <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>, Yichen Wang <yichen.wang@bytedance.com>
Subject: Re: [PATCH v6 10/12] migration/multifd: Add migration option set
 packet size.
In-Reply-To: <20241009234610.27039-11-yichen.wang@bytedance.com>
References: <20241009234610.27039-1-yichen.wang@bytedance.com>
 <20241009234610.27039-11-yichen.wang@bytedance.com>
Date: Thu, 17 Oct 2024 16:16:57 -0300
Message-ID: <877ca635g6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: DD9391FD4B
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[17]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,linux.dev:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,bytedance.com:email];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Yichen Wang <yichen.wang@bytedance.com> writes:

> From: Hao Xiang <hao.xiang@linux.dev>
>
> During live migration, if the latency between sender and receiver is
> high and bandwidth is also high (a long and fat pipe), using a bigger
> packet size can help reduce migration total time. The current multifd
> packet size is 128 * 4kb. In addition, Intel DSA offloading performs
> better with a large batch task.
>
> This change adds an option to set the packet size, which is also useful
> for performance tuning. Both sender and receiver needs to set the same
> packet size for things to work.
>
> Set the option:
> migrate_set_parameter multifd-packet-size 4190208
>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>

Looks good to me. However, could you do a migration-test pass setting
the maximum value for all the tests to see if anything breaks?

> ---
>  migration/migration-hmp-cmds.c |  7 ++++++
>  migration/multifd-zlib.c       |  6 ++++--
>  migration/multifd-zstd.c       |  6 ++++--
>  migration/options.c            | 39 ++++++++++++++++++++++++++++++++++
>  migration/options.h            |  1 +
>  qapi/migration.json            | 21 +++++++++++++++---
>  6 files changed, 73 insertions(+), 7 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 983f13b73c..561ed45250 100644
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
> @@ -580,6 +583,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>              QAPI_LIST_APPEND(tail, strv[i]);
>          }
>          break;
> +    case MIGRATION_PARAMETER_MULTIFD_PACKET_SIZE:
> +        p->has_multifd_packet_size = true;
> +        visit_type_size(v, param, &p->multifd_packet_size, &err);
> +        break;
>      case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
>          p->has_multifd_channels = true;
>          visit_type_uint8(v, param, &p->multifd_channels, &err);
> diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
> index 8cf8a26bb4..58c278533a 100644
> --- a/migration/multifd-zlib.c
> +++ b/migration/multifd-zlib.c
> @@ -39,6 +39,7 @@ static int multifd_zlib_send_setup(MultiFDSendParams *p, Error **errp)
>      struct zlib_data *z = g_new0(struct zlib_data, 1);
>      z_stream *zs = &z->zs;
>      const char *err_msg;
> +    uint64_t multifd_packet_size = migrate_multifd_packet_size();
>  
>      zs->zalloc = Z_NULL;
>      zs->zfree = Z_NULL;
> @@ -48,7 +49,7 @@ static int multifd_zlib_send_setup(MultiFDSendParams *p, Error **errp)
>          goto err_free_z;
>      }
>      /* This is the maximum size of the compressed buffer */
> -    z->zbuff_len = compressBound(MULTIFD_PACKET_SIZE);
> +    z->zbuff_len = compressBound(multifd_packet_size);
>      z->zbuff = g_try_malloc(z->zbuff_len);
>      if (!z->zbuff) {
>          err_msg = "out of memory for zbuff";
> @@ -162,6 +163,7 @@ out:
>  
>  static int multifd_zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
>  {
> +    uint64_t multifd_packet_size = migrate_multifd_packet_size();
>      struct zlib_data *z = g_new0(struct zlib_data, 1);
>      z_stream *zs = &z->zs;
>  
> @@ -176,7 +178,7 @@ static int multifd_zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
>          return -1;
>      }
>      /* To be safe, we reserve twice the size of the packet */
> -    z->zbuff_len = MULTIFD_PACKET_SIZE * 2;
> +    z->zbuff_len = multifd_packet_size * 2;
>      z->zbuff = g_try_malloc(z->zbuff_len);
>      if (!z->zbuff) {
>          inflateEnd(zs);
> diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
> index abed140855..1f97a5417c 100644
> --- a/migration/multifd-zstd.c
> +++ b/migration/multifd-zstd.c
> @@ -39,6 +39,7 @@ struct zstd_data {
>  
>  static int multifd_zstd_send_setup(MultiFDSendParams *p, Error **errp)
>  {
> +    uint64_t multifd_packet_size = migrate_multifd_packet_size();
>      struct zstd_data *z = g_new0(struct zstd_data, 1);
>      int res;
>  
> @@ -58,7 +59,7 @@ static int multifd_zstd_send_setup(MultiFDSendParams *p, Error **errp)
>          return -1;
>      }
>      /* This is the maximum size of the compressed buffer */
> -    z->zbuff_len = ZSTD_compressBound(MULTIFD_PACKET_SIZE);
> +    z->zbuff_len = ZSTD_compressBound(multifd_packet_size);
>      z->zbuff = g_try_malloc(z->zbuff_len);
>      if (!z->zbuff) {
>          ZSTD_freeCStream(z->zcs);
> @@ -149,6 +150,7 @@ out:
>  
>  static int multifd_zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
>  {
> +    uint64_t multifd_packet_size = migrate_multifd_packet_size();
>      struct zstd_data *z = g_new0(struct zstd_data, 1);
>      int ret;
>  
> @@ -170,7 +172,7 @@ static int multifd_zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
>      }
>  
>      /* To be safe, we reserve twice the size of the packet */
> -    z->zbuff_len = MULTIFD_PACKET_SIZE * 2;
> +    z->zbuff_len = multifd_packet_size * 2;
>      z->zbuff = g_try_malloc(z->zbuff_len);
>      if (!z->zbuff) {
>          ZSTD_freeDStream(z->zds);
> diff --git a/migration/options.c b/migration/options.c
> index a0b3a7d291..b1eaf1c095 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -80,6 +80,13 @@
>  #define DEFAULT_MIGRATE_ANNOUNCE_ROUNDS    5
>  #define DEFAULT_MIGRATE_ANNOUNCE_STEP    100
>  
> +/*
> + * Parameter for multifd packet size.
> + */
> +#define DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE (128 * 4 * 1024)
> +/* DSA device supports up to 1024 batches, i.e. 1024 * 4K pages */
> +#define MAX_MIGRATE_MULTIFD_PACKET_SIZE (1024 * 4 * 1024)
> +
>  #define DEFINE_PROP_MIG_CAP(name, x)             \
>      DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
>  
> @@ -173,6 +180,9 @@ Property migration_properties[] = {
>      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
>                         parameters.zero_page_detection,
>                         ZERO_PAGE_DETECTION_MULTIFD),
> +    DEFINE_PROP_SIZE("multifd-packet-size", MigrationState,
> +                     parameters.multifd_packet_size,
> +                     DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE),
>  
>      /* Migration capabilities */
>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> @@ -783,6 +793,13 @@ int migrate_multifd_channels(void)
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
> @@ -911,6 +928,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->downtime_limit = s->parameters.downtime_limit;
>      params->has_x_checkpoint_delay = true;
>      params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
> +    params->has_multifd_packet_size = true;
> +    params->multifd_packet_size = s->parameters.multifd_packet_size;
>      params->has_multifd_channels = true;
>      params->multifd_channels = s->parameters.multifd_channels;
>      params->has_multifd_compression = true;
> @@ -973,6 +992,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_max_bandwidth = true;
>      params->has_downtime_limit = true;
>      params->has_x_checkpoint_delay = true;
> +    params->has_multifd_packet_size = true;
>      params->has_multifd_channels = true;
>      params->has_multifd_compression = true;
>      params->has_multifd_zlib_level = true;
> @@ -1055,6 +1075,19 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
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
> @@ -1236,6 +1269,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>          dest->x_checkpoint_delay = params->x_checkpoint_delay;
>      }
>  
> +    if (params->has_multifd_packet_size) {
> +        dest->multifd_packet_size = params->multifd_packet_size;
> +    }
>      if (params->has_multifd_channels) {
>          dest->multifd_channels = params->multifd_channels;
>      }
> @@ -1364,6 +1400,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
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
> index 8198b220bd..8158d4879d 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -87,6 +87,7 @@ const char *migrate_tls_hostname(void);
>  uint64_t migrate_xbzrle_cache_size(void);
>  ZeroPageDetection migrate_zero_page_detection(void);
>  const strList *migrate_dsa_accel_path(void);
> +uint64_t migrate_multifd_packet_size(void);
>  
>  /* parameters helpers */
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index d8b42ceae6..1d14d8e82f 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -851,6 +851,10 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @multifd-packet-size: Packet size in bytes used to migrate data.
> +#     The value needs to be a multiple of guest page size.
> +#     The default value is 524288 and max value is 4190208.  (Since 9.2)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and
> @@ -877,7 +881,8 @@
>             'vcpu-dirty-limit',
>             'mode',
>             'zero-page-detection',
> -           'direct-io'] }
> +           'direct-io',
> +           'multifd-packet-size'] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -1038,6 +1043,10 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @multifd-packet-size: Packet size in bytes used to migrate data.
> +#     The value needs to be a multiple of guest page size.
> +#     The default value is 524288 and max value is 4190208.  (Since 9.2)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and
> @@ -1080,7 +1089,8 @@
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
>              '*direct-io': 'bool',
> -            '*dsa-accel-path': [ 'str' ] } }
> +            '*dsa-accel-path': [ 'str' ],
> +            '*multifd-packet-size' : 'uint64'} }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1255,6 +1265,10 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @multifd-packet-size: Packet size in bytes used to migrate data.
> +#     The value needs to be a multiple of guest page size.
> +#     The default value is 524288 and max value is 4190208.  (Since 9.2)

These will rot, better leave them out.

> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and
> @@ -1294,7 +1308,8 @@
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
>              '*direct-io': 'bool',
> -            '*dsa-accel-path': [ 'str' ] } }
> +            '*dsa-accel-path': [ 'str' ],
> +            '*multifd-packet-size': 'uint64' } }
>  
>  ##
>  # @query-migrate-parameters:

