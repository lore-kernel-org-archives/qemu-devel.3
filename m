Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70220C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 14:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0MY0-0005sn-8Q; Fri, 26 Apr 2024 10:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0MXx-0005sX-Tx
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:27:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0MXu-00031X-NM
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714141645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y9fV1vvDV73+eDuARk7i4Twpnelz8WGQIA4a7MmfxBA=;
 b=FAFXqk8ij8jNnFnidR0F5iiYQgYoixoI7rwQrvtGN59Xhq1cija0yTGDjBxxLBuy+TkFhC
 L4mlnnqKLg/3hIRADb5YdRgN8TpUAcreJThV71ZqGRENGIM7jfN8HkePEvBTVmI0yAEkg1
 G3eyasGDBPGkgjkYqUxZdK3sa+67MEE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-DO83r0LUPPKmM-0J27tpCQ-1; Fri, 26 Apr 2024 10:27:23 -0400
X-MC-Unique: DO83r0LUPPKmM-0J27tpCQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBA2380021A;
 Fri, 26 Apr 2024 14:27:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0536110009E6;
 Fri, 26 Apr 2024 14:27:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ECB7121E6811; Fri, 26 Apr 2024 16:27:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,  devel@lists.libvirt.org,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH 5/6] migration: Remove non-multifd compression
In-Reply-To: <20240425150939.19268-6-farosas@suse.de> (Fabiano Rosas's message
 of "Thu, 25 Apr 2024 12:09:38 -0300")
References: <20240425150939.19268-1-farosas@suse.de>
 <20240425150939.19268-6-farosas@suse.de>
Date: Fri, 26 Apr 2024 16:27:20 +0200
Message-ID: <87zftgqjw7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> writes:

> The 'compress' migration capability enables the old compression code
> which has shown issues over the years and is thought to be less stable
> and tested than the more recent multifd-based compression. The old
> compression code has been deprecated in 8.2 and now is time to remove
> it.
>
> Deprecation commit 864128df46 ("migration: Deprecate old compression
> method").
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

[...]

> diff --git a/migration/options.c b/migration/options.c
> index 5049bfb78e..5b0658bad1 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -40,13 +40,6 @@
>   * for sending the last part */
>  #define DEFAULT_MIGRATE_SET_DOWNTIME 300
>  
> -/* Default compression thread count */
> -#define DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT 8
> -/* Default decompression thread count, usually decompression is at
> - * least 4 times as fast as compression.*/
> -#define DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT 2
> -/*0: means nocompress, 1: best speed, ... 9: best compress ratio */
> -#define DEFAULT_MIGRATE_COMPRESS_LEVEL 1
>  /* Define default autoconverge cpu throttle migration parameters */
>  #define DEFAULT_MIGRATE_THROTTLE_TRIGGER_THRESHOLD 50
>  #define DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL 20
> @@ -92,8 +85,6 @@ Property migration_properties[] = {
>                       send_configuration, true),
>      DEFINE_PROP_BOOL("send-section-footer", MigrationState,
>                       send_section_footer, true),
> -    DEFINE_PROP_BOOL("decompress-error-check", MigrationState,
> -                      decompress_error_check, true),
>      DEFINE_PROP_BOOL("multifd-flush-after-each-section", MigrationState,
>                        multifd_flush_after_each_section, false),
>      DEFINE_PROP_UINT8("x-clear-bitmap-shift", MigrationState,
> @@ -102,17 +93,6 @@ Property migration_properties[] = {
>                       preempt_pre_7_2, false),
>  
>      /* Migration parameters */
> -    DEFINE_PROP_UINT8("x-compress-level", MigrationState,
> -                      parameters.compress_level,
> -                      DEFAULT_MIGRATE_COMPRESS_LEVEL),
> -    DEFINE_PROP_UINT8("x-compress-threads", MigrationState,
> -                      parameters.compress_threads,
> -                      DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT),
> -    DEFINE_PROP_BOOL("x-compress-wait-thread", MigrationState,
> -                      parameters.compress_wait_thread, true),
> -    DEFINE_PROP_UINT8("x-decompress-threads", MigrationState,
> -                      parameters.decompress_threads,
> -                      DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT),
>      DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
>                        parameters.throttle_trigger_threshold,
>                        DEFAULT_MIGRATE_THROTTLE_TRIGGER_THRESHOLD),
> @@ -188,7 +168,6 @@ Property migration_properties[] = {
>      DEFINE_PROP_MIG_CAP("x-rdma-pin-all", MIGRATION_CAPABILITY_RDMA_PIN_ALL),
>      DEFINE_PROP_MIG_CAP("x-auto-converge", MIGRATION_CAPABILITY_AUTO_CONVERGE),
>      DEFINE_PROP_MIG_CAP("x-zero-blocks", MIGRATION_CAPABILITY_ZERO_BLOCKS),
> -    DEFINE_PROP_MIG_CAP("x-compress", MIGRATION_CAPABILITY_COMPRESS),
>      DEFINE_PROP_MIG_CAP("x-events", MIGRATION_CAPABILITY_EVENTS),
>      DEFINE_PROP_MIG_CAP("x-postcopy-ram", MIGRATION_CAPABILITY_POSTCOPY_RAM),
>      DEFINE_PROP_MIG_CAP("x-postcopy-preempt",
> @@ -231,13 +210,6 @@ bool migrate_colo(void)
>      return s->capabilities[MIGRATION_CAPABILITY_X_COLO];
>  }
>  
> -bool migrate_compress(void)
> -{
> -    MigrationState *s = migrate_get_current();
> -
> -    return s->capabilities[MIGRATION_CAPABILITY_COMPRESS];
> -}
> -

Please also drop the declaration from migration/options.h.

>  bool migrate_dirty_bitmaps(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -451,7 +423,6 @@ INITIALIZE_MIGRATE_CAPS_SET(check_caps_background_snapshot,
>      MIGRATION_CAPABILITY_AUTO_CONVERGE,
>      MIGRATION_CAPABILITY_RELEASE_RAM,
>      MIGRATION_CAPABILITY_RDMA_PIN_ALL,
> -    MIGRATION_CAPABILITY_COMPRESS,
>      MIGRATION_CAPABILITY_XBZRLE,
>      MIGRATION_CAPABILITY_X_COLO,
>      MIGRATION_CAPABILITY_VALIDATE_UUID,
> @@ -476,11 +447,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>      ERRP_GUARD();
>      MigrationIncomingState *mis = migration_incoming_get_current();
>  
> -    if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
> -        warn_report("old compression method is deprecated;"
> -                    " use multifd compression methods instead");
> -    }
> -
>  #ifndef CONFIG_REPLICATION
>      if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
>          error_setg(errp, "QEMU compiled without replication module"
> @@ -549,7 +515,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>  #ifdef CONFIG_LINUX
>      if (new_caps[MIGRATION_CAPABILITY_ZERO_COPY_SEND] &&
>          (!new_caps[MIGRATION_CAPABILITY_MULTIFD] ||
> -         new_caps[MIGRATION_CAPABILITY_COMPRESS] ||
>           new_caps[MIGRATION_CAPABILITY_XBZRLE] ||
>           migrate_multifd_compression() ||
>           migrate_tls())) {
> @@ -571,17 +536,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>              return false;
>          }
>  
> -        /*
> -         * Preempt mode requires urgent pages to be sent in separate
> -         * channel, OTOH compression logic will disorder all pages into
> -         * different compression channels, which is not compatible with the
> -         * preempt assumptions on channel assignments.
> -         */
> -        if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
> -            error_setg(errp, "Postcopy preempt not compatible with compress");
> -            return false;
> -        }
> -
>          if (migrate_incoming_started()) {
>              error_setg(errp,
>                         "Postcopy preempt must be set before incoming starts");
> @@ -590,10 +544,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>      }
>  
>      if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
> -        if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
> -            error_setg(errp, "Multifd is not compatible with compress");
> -            return false;
> -        }
>          if (migrate_incoming_started()) {
>              error_setg(errp, "Multifd must be set before incoming starts");
>              return false;
> @@ -628,13 +578,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>          }
>      }
>  
> -    if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
> -        if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
> -            error_setg(errp, "Compression is not compatible with xbzrle");
> -            return false;
> -        }
> -    }
> -
>      if (new_caps[MIGRATION_CAPABILITY_MAPPED_RAM]) {
>          if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
>              error_setg(errp,
> @@ -642,12 +585,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>              return false;
>          }
>  
> -        if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
> -            error_setg(errp,
> -                       "Mapped-ram migration is incompatible with compression");
> -            return false;
> -        }
> -
>          if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
>              error_setg(errp,
>                         "Mapped-ram migration is incompatible with postcopy");
> @@ -744,27 +681,6 @@ uint32_t migrate_checkpoint_delay(void)
>      return s->parameters.x_checkpoint_delay;
>  }
>  
> -int migrate_compress_level(void)
> -{
> -    MigrationState *s = migrate_get_current();
> -
> -    return s->parameters.compress_level;
> -}
> -
> -int migrate_compress_threads(void)
> -{
> -    MigrationState *s = migrate_get_current();
> -
> -    return s->parameters.compress_threads;
> -}
> -
> -int migrate_compress_wait_thread(void)
> -{
> -    MigrationState *s = migrate_get_current();
> -
> -    return s->parameters.compress_wait_thread;
> -}
> -

Please also drop the declarations from migration/options.h.

>  uint8_t migrate_cpu_throttle_increment(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -786,13 +702,6 @@ bool migrate_cpu_throttle_tailslow(void)
>      return s->parameters.cpu_throttle_tailslow;
>  }
>  
> -int migrate_decompress_threads(void)
> -{
> -    MigrationState *s = migrate_get_current();
> -
> -    return s->parameters.decompress_threads;
> -}
> -

Please also drop the declaration from migration/options.h.

>  uint64_t migrate_downtime_limit(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -938,14 +847,6 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>  
>      /* TODO use QAPI_CLONE() instead of duplicating it inline */
>      params = g_malloc0(sizeof(*params));
> -    params->has_compress_level = true;
> -    params->compress_level = s->parameters.compress_level;
> -    params->has_compress_threads = true;
> -    params->compress_threads = s->parameters.compress_threads;
> -    params->has_compress_wait_thread = true;
> -    params->compress_wait_thread = s->parameters.compress_wait_thread;
> -    params->has_decompress_threads = true;
> -    params->decompress_threads = s->parameters.decompress_threads;
>      params->has_throttle_trigger_threshold = true;
>      params->throttle_trigger_threshold = s->parameters.throttle_trigger_threshold;
>      params->has_cpu_throttle_initial = true;
> @@ -1014,10 +915,6 @@ void migrate_params_init(MigrationParameters *params)
>      params->tls_creds = g_strdup("");
>  
>      /* Set has_* up only for parameter checks */
> -    params->has_compress_level = true;
> -    params->has_compress_threads = true;
> -    params->has_compress_wait_thread = true;
> -    params->has_decompress_threads = true;
>      params->has_throttle_trigger_threshold = true;
>      params->has_cpu_throttle_initial = true;
>      params->has_cpu_throttle_increment = true;
> @@ -1050,27 +947,6 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>  {
>      ERRP_GUARD();
>  
> -    if (params->has_compress_level &&
> -        (params->compress_level > 9)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "compress_level",
> -                   "a value between 0 and 9");
> -        return false;
> -    }
> -
> -    if (params->has_compress_threads && (params->compress_threads < 1)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "compress_threads",
> -                   "a value between 1 and 255");
> -        return false;
> -    }
> -
> -    if (params->has_decompress_threads && (params->decompress_threads < 1)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "decompress_threads",
> -                   "a value between 1 and 255");
> -        return false;
> -    }
> -
>      if (params->has_throttle_trigger_threshold &&
>          (params->throttle_trigger_threshold < 1 ||
>           params->throttle_trigger_threshold > 100)) {
> @@ -1245,22 +1121,6 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>  
>      /* TODO use QAPI_CLONE() instead of duplicating it inline */
>  
> -    if (params->has_compress_level) {
> -        dest->compress_level = params->compress_level;
> -    }
> -
> -    if (params->has_compress_threads) {
> -        dest->compress_threads = params->compress_threads;
> -    }
> -
> -    if (params->has_compress_wait_thread) {
> -        dest->compress_wait_thread = params->compress_wait_thread;
> -    }
> -
> -    if (params->has_decompress_threads) {
> -        dest->decompress_threads = params->decompress_threads;
> -    }
> -
>      if (params->has_throttle_trigger_threshold) {
>          dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
>      }
> @@ -1365,30 +1225,6 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>  
>      /* TODO use QAPI_CLONE() instead of duplicating it inline */
>  
> -    if (params->has_compress_level) {
> -        warn_report("old compression is deprecated;"
> -                    " use multifd compression methods instead");
> -        s->parameters.compress_level = params->compress_level;
> -    }
> -
> -    if (params->has_compress_threads) {
> -        warn_report("old compression is deprecated;"
> -                    " use multifd compression methods instead");
> -        s->parameters.compress_threads = params->compress_threads;
> -    }
> -
> -    if (params->has_compress_wait_thread) {
> -        warn_report("old compression is deprecated;"
> -                    " use multifd compression methods instead");
> -        s->parameters.compress_wait_thread = params->compress_wait_thread;
> -    }
> -
> -    if (params->has_decompress_threads) {
> -        warn_report("old compression is deprecated;"
> -                    " use multifd compression methods instead");
> -        s->parameters.decompress_threads = params->decompress_threads;
> -    }
> -
>      if (params->has_throttle_trigger_threshold) {
>          s->parameters.throttle_trigger_threshold = params->throttle_trigger_threshold;
>      }
> diff --git a/migration/ram-compress.c b/migration/ram-compress.c
> deleted file mode 100644
> index fa4388f6a6..0000000000
> --- a/migration/ram-compress.c
> +++ /dev/null
> @@ -1,564 +0,0 @@
> -/*
> - * QEMU System Emulator
> - *
> - * Copyright (c) 2003-2008 Fabrice Bellard
> - * Copyright (c) 2011-2015 Red Hat Inc
> - *
> - * Authors:
> - *  Juan Quintela <quintela@redhat.com>
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a copy
> - * of this software and associated documentation files (the "Software"), to deal
> - * in the Software without restriction, including without limitation the rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> - * THE SOFTWARE.
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qemu/cutils.h"
> -
> -#include "ram-compress.h"
> -
> -#include "qemu/error-report.h"
> -#include "qemu/stats64.h"
> -#include "migration.h"
> -#include "options.h"
> -#include "io/channel-null.h"
> -#include "exec/target_page.h"
> -#include "exec/ramblock.h"
> -#include "ram.h"
> -#include "migration-stats.h"
> -
> -static struct {
> -    int64_t pages;
> -    int64_t busy;
> -    double busy_rate;
> -    int64_t compressed_size;
> -    double compression_rate;
> -    /* compression statistics since the beginning of the period */
> -    /* amount of count that no free thread to compress data */
> -    uint64_t compress_thread_busy_prev;
> -    /* amount bytes after compression */
> -    uint64_t compressed_size_prev;
> -    /* amount of compressed pages */
> -    uint64_t compress_pages_prev;
> -} compression_counters;
> -
> -static CompressParam *comp_param;
> -static QemuThread *compress_threads;
> -/* comp_done_cond is used to wake up the migration thread when
> - * one of the compression threads has finished the compression.
> - * comp_done_lock is used to co-work with comp_done_cond.
> - */
> -static QemuMutex comp_done_lock;
> -static QemuCond comp_done_cond;
> -
> -struct DecompressParam {
> -    bool done;
> -    bool quit;
> -    QemuMutex mutex;
> -    QemuCond cond;
> -    void *des;
> -    uint8_t *compbuf;
> -    int len;
> -    z_stream stream;
> -};
> -typedef struct DecompressParam DecompressParam;
> -
> -static QEMUFile *decomp_file;
> -static DecompressParam *decomp_param;
> -static QemuThread *decompress_threads;
> -static QemuMutex decomp_done_lock;
> -static QemuCond decomp_done_cond;
> -
> -static CompressResult do_compress_ram_page(QEMUFile *f, z_stream *stream,
> -                                           RAMBlock *block, ram_addr_t offset,
> -                                           uint8_t *source_buf);
> -
> -static void *do_data_compress(void *opaque)
> -{
> -    CompressParam *param = opaque;
> -    RAMBlock *block;
> -    ram_addr_t offset;
> -    CompressResult result;
> -
> -    qemu_mutex_lock(&param->mutex);
> -    while (!param->quit) {
> -        if (param->trigger) {
> -            block = param->block;
> -            offset = param->offset;
> -            param->trigger = false;
> -            qemu_mutex_unlock(&param->mutex);
> -
> -            result = do_compress_ram_page(param->file, &param->stream,
> -                                          block, offset, param->originbuf);
> -
> -            qemu_mutex_lock(&comp_done_lock);
> -            param->done = true;
> -            param->result = result;
> -            qemu_cond_signal(&comp_done_cond);
> -            qemu_mutex_unlock(&comp_done_lock);
> -
> -            qemu_mutex_lock(&param->mutex);
> -        } else {
> -            qemu_cond_wait(&param->cond, &param->mutex);
> -        }
> -    }
> -    qemu_mutex_unlock(&param->mutex);
> -
> -    return NULL;
> -}
> -
> -void compress_threads_save_cleanup(void)
> -{
> -    int i, thread_count;
> -
> -    if (!migrate_compress() || !comp_param) {
> -        return;
> -    }
> -
> -    thread_count = migrate_compress_threads();
> -    for (i = 0; i < thread_count; i++) {
> -        /*
> -         * we use it as a indicator which shows if the thread is
> -         * properly init'd or not
> -         */
> -        if (!comp_param[i].file) {
> -            break;
> -        }
> -
> -        qemu_mutex_lock(&comp_param[i].mutex);
> -        comp_param[i].quit = true;
> -        qemu_cond_signal(&comp_param[i].cond);
> -        qemu_mutex_unlock(&comp_param[i].mutex);
> -
> -        qemu_thread_join(compress_threads + i);
> -        qemu_mutex_destroy(&comp_param[i].mutex);
> -        qemu_cond_destroy(&comp_param[i].cond);
> -        deflateEnd(&comp_param[i].stream);
> -        g_free(comp_param[i].originbuf);
> -        qemu_fclose(comp_param[i].file);
> -        comp_param[i].file = NULL;
> -    }
> -    qemu_mutex_destroy(&comp_done_lock);
> -    qemu_cond_destroy(&comp_done_cond);
> -    g_free(compress_threads);
> -    g_free(comp_param);
> -    compress_threads = NULL;
> -    comp_param = NULL;
> -}
> -
> -int compress_threads_save_setup(void)
> -{
> -    int i, thread_count;
> -
> -    if (!migrate_compress()) {
> -        return 0;
> -    }
> -    thread_count = migrate_compress_threads();
> -    compress_threads = g_new0(QemuThread, thread_count);
> -    comp_param = g_new0(CompressParam, thread_count);
> -    qemu_cond_init(&comp_done_cond);
> -    qemu_mutex_init(&comp_done_lock);
> -    for (i = 0; i < thread_count; i++) {
> -        comp_param[i].originbuf = g_try_malloc(qemu_target_page_size());
> -        if (!comp_param[i].originbuf) {
> -            goto exit;
> -        }
> -
> -        if (deflateInit(&comp_param[i].stream,
> -                        migrate_compress_level()) != Z_OK) {
> -            g_free(comp_param[i].originbuf);
> -            goto exit;
> -        }
> -
> -        /* comp_param[i].file is just used as a dummy buffer to save data,
> -         * set its ops to empty.
> -         */
> -        comp_param[i].file = qemu_file_new_output(
> -            QIO_CHANNEL(qio_channel_null_new()));
> -        comp_param[i].done = true;
> -        comp_param[i].quit = false;
> -        qemu_mutex_init(&comp_param[i].mutex);
> -        qemu_cond_init(&comp_param[i].cond);
> -        qemu_thread_create(compress_threads + i, "compress",
> -                           do_data_compress, comp_param + i,
> -                           QEMU_THREAD_JOINABLE);
> -    }
> -    return 0;
> -
> -exit:
> -    compress_threads_save_cleanup();
> -    return -1;
> -}

Please also drop the declarations from migration/ram-compress.h.

> -
> -static CompressResult do_compress_ram_page(QEMUFile *f, z_stream *stream,
> -                                           RAMBlock *block, ram_addr_t offset,
> -                                           uint8_t *source_buf)
> -{
> -    uint8_t *p = block->host + offset;
> -    size_t page_size = qemu_target_page_size();
> -    int ret;
> -
> -    assert(qemu_file_buffer_empty(f));
> -
> -    if (buffer_is_zero(p, page_size)) {
> -        return RES_ZEROPAGE;
> -    }
> -
> -    /*
> -     * copy it to a internal buffer to avoid it being modified by VM
> -     * so that we can catch up the error during compression and
> -     * decompression
> -     */
> -    memcpy(source_buf, p, page_size);
> -    ret = qemu_put_compression_data(f, stream, source_buf, page_size);
> -    if (ret < 0) {
> -        qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
> -        error_report("compressed data failed!");
> -        qemu_fflush(f);
> -        return RES_NONE;
> -    }
> -    return RES_COMPRESS;
> -}
> -
> -static inline void compress_reset_result(CompressParam *param)
> -{
> -    param->result = RES_NONE;
> -    param->block = NULL;
> -    param->offset = 0;
> -}
> -
> -void compress_flush_data(void)
> -{
> -    int thread_count = migrate_compress_threads();
> -
> -    if (!migrate_compress()) {
> -        return;
> -    }
> -
> -    qemu_mutex_lock(&comp_done_lock);
> -    for (int i = 0; i < thread_count; i++) {
> -        while (!comp_param[i].done) {
> -            qemu_cond_wait(&comp_done_cond, &comp_done_lock);
> -        }
> -    }
> -    qemu_mutex_unlock(&comp_done_lock);
> -
> -    for (int i = 0; i < thread_count; i++) {
> -        qemu_mutex_lock(&comp_param[i].mutex);
> -        if (!comp_param[i].quit) {
> -            CompressParam *param = &comp_param[i];
> -            compress_send_queued_data(param);
> -            assert(qemu_file_buffer_empty(param->file));
> -            compress_reset_result(param);
> -        }
> -        qemu_mutex_unlock(&comp_param[i].mutex);
> -    }
> -}

Please also drop the declaration from migration/ram-compress.h.

> -
> -static inline void set_compress_params(CompressParam *param, RAMBlock *block,
> -                                       ram_addr_t offset)
> -{
> -    param->block = block;
> -    param->offset = offset;
> -    param->trigger = true;
> -}
> -
> -/*
> - * Return true when it compress a page
> - */
> -bool compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
> -                                     int (send_queued_data(CompressParam *)))
> -{
> -    int thread_count;
> -    bool wait = migrate_compress_wait_thread();
> -
> -    thread_count = migrate_compress_threads();
> -    qemu_mutex_lock(&comp_done_lock);
> -
> -    while (true) {
> -        for (int i = 0; i < thread_count; i++) {
> -            if (comp_param[i].done) {
> -                CompressParam *param = &comp_param[i];
> -                qemu_mutex_lock(&param->mutex);
> -                param->done = false;
> -                send_queued_data(param);
> -                assert(qemu_file_buffer_empty(param->file));
> -                compress_reset_result(param);
> -                set_compress_params(param, block, offset);
> -
> -                qemu_cond_signal(&param->cond);
> -                qemu_mutex_unlock(&param->mutex);
> -                qemu_mutex_unlock(&comp_done_lock);
> -                return true;
> -            }
> -        }
> -        if (!wait) {
> -            qemu_mutex_unlock(&comp_done_lock);
> -            compression_counters.busy++;
> -            return false;
> -        }
> -        /*
> -         * wait for a free thread if the user specifies
> -         * 'compress-wait-thread', otherwise we will post the page out
> -         * in the main thread as normal page.
> -         */
> -        qemu_cond_wait(&comp_done_cond, &comp_done_lock);
> -    }
> -}

Please also drop the declaration from migration/ram-compress.h.

> -
> -/* return the size after decompression, or negative value on error */
> -static int
> -qemu_uncompress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
> -                     const uint8_t *source, size_t source_len)
> -{
> -    int err;
> -
> -    err = inflateReset(stream);
> -    if (err != Z_OK) {
> -        return -1;
> -    }
> -
> -    stream->avail_in = source_len;
> -    stream->next_in = (uint8_t *)source;
> -    stream->avail_out = dest_len;
> -    stream->next_out = dest;
> -
> -    err = inflate(stream, Z_NO_FLUSH);
> -    if (err != Z_STREAM_END) {
> -        return -1;
> -    }
> -
> -    return stream->total_out;
> -}
> -
> -static void *do_data_decompress(void *opaque)
> -{
> -    DecompressParam *param = opaque;
> -    unsigned long pagesize;
> -    uint8_t *des;
> -    int len, ret;
> -
> -    qemu_mutex_lock(&param->mutex);
> -    while (!param->quit) {
> -        if (param->des) {
> -            des = param->des;
> -            len = param->len;
> -            param->des = 0;
> -            qemu_mutex_unlock(&param->mutex);
> -
> -            pagesize = qemu_target_page_size();
> -
> -            ret = qemu_uncompress_data(&param->stream, des, pagesize,
> -                                       param->compbuf, len);
> -            if (ret < 0 && migrate_get_current()->decompress_error_check) {
> -                error_report("decompress data failed");
> -                qemu_file_set_error(decomp_file, ret);
> -            }
> -
> -            qemu_mutex_lock(&decomp_done_lock);
> -            param->done = true;
> -            qemu_cond_signal(&decomp_done_cond);
> -            qemu_mutex_unlock(&decomp_done_lock);
> -
> -            qemu_mutex_lock(&param->mutex);
> -        } else {
> -            qemu_cond_wait(&param->cond, &param->mutex);
> -        }
> -    }
> -    qemu_mutex_unlock(&param->mutex);
> -
> -    return NULL;
> -}
> -
> -int wait_for_decompress_done(void)
> -{
> -    if (!migrate_compress()) {
> -        return 0;
> -    }
> -
> -    int thread_count = migrate_decompress_threads();
> -    qemu_mutex_lock(&decomp_done_lock);
> -    for (int i = 0; i < thread_count; i++) {
> -        while (!decomp_param[i].done) {
> -            qemu_cond_wait(&decomp_done_cond, &decomp_done_lock);
> -        }
> -    }
> -    qemu_mutex_unlock(&decomp_done_lock);
> -    return qemu_file_get_error(decomp_file);
> -}
> -
> -void compress_threads_load_cleanup(void)
> -{
> -    int i, thread_count;
> -
> -    if (!migrate_compress()) {
> -        return;
> -    }
> -    thread_count = migrate_decompress_threads();
> -    for (i = 0; i < thread_count; i++) {
> -        /*
> -         * we use it as a indicator which shows if the thread is
> -         * properly init'd or not
> -         */
> -        if (!decomp_param[i].compbuf) {
> -            break;
> -        }
> -
> -        qemu_mutex_lock(&decomp_param[i].mutex);
> -        decomp_param[i].quit = true;
> -        qemu_cond_signal(&decomp_param[i].cond);
> -        qemu_mutex_unlock(&decomp_param[i].mutex);
> -    }
> -    for (i = 0; i < thread_count; i++) {
> -        if (!decomp_param[i].compbuf) {
> -            break;
> -        }
> -
> -        qemu_thread_join(decompress_threads + i);
> -        qemu_mutex_destroy(&decomp_param[i].mutex);
> -        qemu_cond_destroy(&decomp_param[i].cond);
> -        inflateEnd(&decomp_param[i].stream);
> -        g_free(decomp_param[i].compbuf);
> -        decomp_param[i].compbuf = NULL;
> -    }
> -    g_free(decompress_threads);
> -    g_free(decomp_param);
> -    decompress_threads = NULL;
> -    decomp_param = NULL;
> -    decomp_file = NULL;
> -}
> -
> -int compress_threads_load_setup(QEMUFile *f)
> -{
> -    int i, thread_count;
> -
> -    if (!migrate_compress()) {
> -        return 0;
> -    }
> -
> -    /*
> -     * set compression_counters memory to zero for a new migration
> -     */
> -    memset(&compression_counters, 0, sizeof(compression_counters));
> -
> -    thread_count = migrate_decompress_threads();
> -    decompress_threads = g_new0(QemuThread, thread_count);
> -    decomp_param = g_new0(DecompressParam, thread_count);
> -    qemu_mutex_init(&decomp_done_lock);
> -    qemu_cond_init(&decomp_done_cond);
> -    decomp_file = f;
> -    for (i = 0; i < thread_count; i++) {
> -        if (inflateInit(&decomp_param[i].stream) != Z_OK) {
> -            goto exit;
> -        }
> -
> -        size_t compbuf_size = compressBound(qemu_target_page_size());
> -        decomp_param[i].compbuf = g_malloc0(compbuf_size);
> -        qemu_mutex_init(&decomp_param[i].mutex);
> -        qemu_cond_init(&decomp_param[i].cond);
> -        decomp_param[i].done = true;
> -        decomp_param[i].quit = false;
> -        qemu_thread_create(decompress_threads + i, "decompress",
> -                           do_data_decompress, decomp_param + i,
> -                           QEMU_THREAD_JOINABLE);
> -    }
> -    return 0;
> -exit:
> -    compress_threads_load_cleanup();
> -    return -1;
> -}
> -
> -void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len)
> -{
> -    int thread_count = migrate_decompress_threads();
> -    QEMU_LOCK_GUARD(&decomp_done_lock);
> -    while (true) {
> -        for (int i = 0; i < thread_count; i++) {
> -            if (decomp_param[i].done) {
> -                decomp_param[i].done = false;
> -                qemu_mutex_lock(&decomp_param[i].mutex);
> -                qemu_get_buffer(f, decomp_param[i].compbuf, len);
> -                decomp_param[i].des = host;
> -                decomp_param[i].len = len;
> -                qemu_cond_signal(&decomp_param[i].cond);
> -                qemu_mutex_unlock(&decomp_param[i].mutex);
> -                return;
> -            }
> -        }
> -        qemu_cond_wait(&decomp_done_cond, &decomp_done_lock);
> -    }
> -}
> -
> -void populate_compress(MigrationInfo *info)
> -{
> -    if (!migrate_compress()) {
> -        return;
> -    }
> -    info->compression = g_malloc0(sizeof(*info->compression));
> -    info->compression->pages = compression_counters.pages;
> -    info->compression->busy = compression_counters.busy;
> -    info->compression->busy_rate = compression_counters.busy_rate;
> -    info->compression->compressed_size = compression_counters.compressed_size;
> -    info->compression->compression_rate = compression_counters.compression_rate;
> -}

Please also drop the declaration from migration/ram-compress.h.

Not nothing again.

The entire header may well need to go.

Please double-check the entire series for missing header updates.

[...]


QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


