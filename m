Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A11DCD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0D9-0007mL-4w; Tue, 09 Jun 2026 13:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Cw-0007aA-Di
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Ct-0001yZ-3m
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781025941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEeE/ILPbUfNm0fHrOlFecQ+K6hT8Mcwf1ycjvTaswU=;
 b=DfgDpzLsTXjLs5dyilDVMi6GmEDUnn+ltbbjchdyCT0u09lkGV6jKm7GDJ+UmUau3z9IYs
 6p1zxNK40PIcz2vIJMiqz+EiZXNw+cysTBawcYG7y7pqKQlpun0+lu9q5UQo9jHRZARL29
 8BYPri227aaNqsQXTlt76cUCWv5fMKg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-HpWW51MUOMmJEDZzkWkzxg-1; Tue, 09 Jun 2026 13:25:40 -0400
X-MC-Unique: HpWW51MUOMmJEDZzkWkzxg-1
X-Mimecast-MFC-AGG-ID: HpWW51MUOMmJEDZzkWkzxg_1781025940
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-517600719a9so96755031cf.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781025940; x=1781630740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nEeE/ILPbUfNm0fHrOlFecQ+K6hT8Mcwf1ycjvTaswU=;
 b=Wm7yPlLI57YIOvuX06IJtVuuQEWtcWT/pH6nQSqfyyHKavchVuxEU3KoHv2onED10E
 cEQNar2788/Ekur6ABLSRjsVKyKXzozOL0RoGb7xwjSLWmudkKfMkXoKv2cjEhoN7QnB
 xLlFdDUnUZUBMg2Dh4TSzhZd3fiFJBBujxw/JC4Kf517DvrcACrBfNuUjr72O3d78dHY
 qPr125Lg9zq2mFGcBpyn5jUVatEOiWZIB1E7bgc6Uux0gQdL8IRYflqJhq7IKIl59eAu
 l93TCln9Kw6gitQPJ8ENQrVQvEcig1B4uqjxBWAp/o2QYqoV/QsHvnOjZCIEUZ23BwMI
 YWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781025940; x=1781630740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nEeE/ILPbUfNm0fHrOlFecQ+K6hT8Mcwf1ycjvTaswU=;
 b=l4QowYb8g8F6gskIwr/rgSTZuK7KjXrSGmV+EBlK/k0HCy/7NAfjV2gDgROxviv2sT
 9qgaLuI5Ycnokd2dsgoYSTAUlyx9/GoY5inQQojXHeUZxXwQmcPbjoAkcUThCaLZJ6Fe
 BAlX1zApQegD5RJwFS5j6B0Nb0Hnh4TNRvvkIOzNSuM7UeOOG8CwIja3F6Xao8mHcJmS
 UOoUfj0HfmvSHdF69Yfl96B20C4qrlG1C43Bb8yPhcOogadDXm5pFmR/b4clVIX5ABzP
 WJ2WKF5VoYysaeaOpwVPoguVXzxvhcZgAaIZB1yToFUDsRyrjMdDQYMQXndhVnph5Idz
 twHw==
X-Gm-Message-State: AOJu0YzO6EN2OHBe8OJePo9HGARC2liKSDeQEZPfRLL+RrlSSrULcGOr
 WFtd/LxGsb+ndksZTLVi2DpKO+V9oHDOSqgBCUB75Swp1TrF0W4GgO634wqGLjQFuIMPovISzNz
 bErSv4u0AkmzI/UHL1nSzX8trZ/0azDrbHPDxvMG4EHWszq8cbdSX/LikY9aAtg50A1xa+gUCpy
 Ov/KFoTMr9DEQh6E0a06jtZPRjb3YYJse/ZYycPQ==
X-Gm-Gg: Acq92OEQ63GM4oa8PQhmU3KM2egCx9EfwtZG7lE8H1G8l8/nDSFiGWKJiSoiOIB8A2B
 P6hmtM0crPLyo0y5qAkZcFg3exdWwtsXNCGnqupXI9G5J2tgNiJJSPAIncl/3hiLQT6UJKyrjen
 llw5wBtFpVCDjaLtBH9NdBdbpIRXB2aY3b8YzQdelrJOEyXc612C9yD4pNM6ctTmJPu/cgPorop
 YXjnIdn/avbZIy2rqBflOaCmrPT2B0DJkg+QQlXKH7N51eXwdaE4KIVzVzYQsECyAeFT3aRoqvq
 6dH9XALGq1xtW+85L/L1V/5Hp0IZfjwZCp9EFpPPQ2IFXng1htozu5ZA4fVSL3BU7OKq/QRJ1YI
 GQo1yqO+Rkg9nbPVniywOLjA=
X-Received: by 2002:a05:622a:4d98:b0:517:59a1:82cb with SMTP id
 d75a77b69052e-51795bbdc93mr312956701cf.48.1781025939758; 
 Tue, 09 Jun 2026 10:25:39 -0700 (PDT)
X-Received: by 2002:a05:622a:4d98:b0:517:59a1:82cb with SMTP id
 d75a77b69052e-51795bbdc93mr312955831cf.48.1781025938988; 
 Tue, 09 Jun 2026 10:25:38 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775da2c56sm187524711cf.21.2026.06.09.10.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 10:25:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v2 10/10] migration: Switch to TYPE_OBJECT with object
 properties
Date: Tue,  9 Jun 2026 13:25:14 -0400
Message-ID: <20260609172514.2037645-11-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609172514.2037645-1-peterx@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The migration object used to depend on TYPE_DEVICE due to:

- Usage of qdev properties
- Apply compat properties and global properties

This patch re-based the object to TYPE_OBJECT with the changes:

- Switch to object properties API
- Manually apply both compat and global properties in post_init()

Note that to avoid too many property getter/setter helpers, this patch used
the object_property_add_*_ptr_def() APIs so that an pointer is passed to
bind to the property.  Such API is used for most of the conversions.

After patch, the migration object initializes instance properties within
its instance_init() callback, in migrate_params_init().

One side effect of this change is, since we switched to a loop to add all
capabilities, the name of the properties representing a migration
capability may chance from previously hard-coded ones (many with x-).  It's
fine since it's only used in -global so it's only for debugging.

Similarly, I removed "x-" from other properites that used to start with
"x-" but actually are not experimental.

After the whole conversion, we don't need migration_properties or the count
anymore, hence can be removed.  While at it, we can also remove two
DEFINE_PROP*() API that only migration uses (DEFINE_PROP_STR_OR_NULL, and
DEFINE_PROP_MIG_CAP).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.h   |   8 +-
 migration/migration.c |  35 ++-
 migration/options.c   | 526 ++++++++++++++++++++++++++----------------
 3 files changed, 351 insertions(+), 218 deletions(-)

diff --git a/migration/options.h b/migration/options.h
index b46221998a..eadbb8cf61 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -18,11 +18,6 @@
 #include "hw/core/qdev-properties-system.h"
 #include "migration/client-options.h"
 
-/* migration properties */
-
-extern const Property migration_properties[];
-extern const size_t migration_properties_count;
-
 /* capabilities */
 
 bool migrate_auto_converge(void);
@@ -92,6 +87,7 @@ uint64_t migrate_rdma_chunk_size(void);
 /* parameters helpers */
 
 bool migrate_params_check(MigrationParameters *params, Error **errp);
-void migrate_params_init(MigrationParameters *params);
+void migrate_params_init(MigrationState *s);
 void migrate_tls_opts_free(MigrationParameters *params);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 278cad502a..ae0c373549 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3964,15 +3964,6 @@ fail:
     }
 }
 
-static void migration_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->user_creatable = false;
-    device_class_set_props_n(dc, migration_properties,
-                             migration_properties_count);
-}
-
 static void migration_instance_finalize(Object *obj)
 {
     MigrationState *ms = MIGRATION(obj);
@@ -4001,7 +3992,7 @@ static void migration_instance_init(Object *obj)
     qemu_event_init(&ms->pause_event, false);
     qemu_mutex_init(&ms->error_mutex);
 
-    migrate_params_init(&ms->parameters);
+    migrate_params_init(ms);
 
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_sem, 0);
@@ -4028,20 +4019,26 @@ static bool migration_object_check(MigrationState *ms, Error **errp)
     return migrate_caps_check(old_caps, ms->capabilities, errp);
 }
 
-static const TypeInfo migration_type = {
-    .name = TYPE_MIGRATION,
+static void migration_instance_post_init(Object *obj)
+{
     /*
-     * NOTE: TYPE_MIGRATION is not really a device, as the object is
-     * not created using qdev_new(), it is not attached to the qdev
-     * device tree, and it is never realized.
+     * Apply these properties on top of default values:
+     *
+     * (1) machine compat properties
+     * (2) -global settings in cmdlines
      *
-     * TODO: Make this TYPE_OBJECT once QOM provides something like
-     * TYPE_DEVICE's "-global" properties.
+     * Need to be applied in order so (2) takes precedence over (1).
      */
-    .parent = TYPE_DEVICE,
-    .class_init = migration_class_init,
+    object_apply_compat_props(obj);
+    object_apply_global_props(obj, global_props(), &error_fatal);
+}
+
+static const TypeInfo migration_type = {
+    .name = TYPE_MIGRATION,
+    .parent = TYPE_OBJECT,
     .instance_size = sizeof(MigrationState),
     .instance_init = migration_instance_init,
+    .instance_post_init = migration_instance_post_init,
     .instance_finalize = migration_instance_finalize,
 };
 
diff --git a/migration/options.c b/migration/options.c
index 5cbfd29099..1cc99382d3 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -54,7 +54,7 @@
 /* The delay time (in ms) between two COLO checkpoints */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
 #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
-#define DEFAULT_MIGRATE_MULTIFD_COMPRESSION MULTIFD_COMPRESSION_NONE
+#define DEFAULT_MIGRATE_MULTIFD_COMPRESSION "none"
 /* 0: means nocompress, 1: best speed, ... 9: best compress ratio */
 #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
 /*
@@ -81,216 +81,355 @@
 #define DEFAULT_MIGRATE_ANNOUNCE_ROUNDS    5
 #define DEFAULT_MIGRATE_ANNOUNCE_STEP    100
 
-#define DEFINE_PROP_MIG_CAP(name, x)             \
-    DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
-
-const PropertyInfo qdev_prop_StrOrNull;
-#define DEFINE_PROP_STR_OR_NULL(_name, _state, _field)                  \
-    DEFINE_PROP(_name, _state, _field, qdev_prop_StrOrNull, StrOrNull *, \
-                .set_default = true)
-
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
 #define DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE           MiB
 
-const Property migration_properties[] = {
-    DEFINE_PROP_BOOL("store-global-state", MigrationState,
-                     store_global_state, true),
-    DEFINE_PROP_BOOL("send-configuration", MigrationState,
-                     send_configuration, true),
-    DEFINE_PROP_BOOL("send-section-footer", MigrationState,
-                     send_section_footer, true),
-    DEFINE_PROP_BOOL("send-switchover-start", MigrationState,
-                     send_switchover_start, true),
-    DEFINE_PROP_BOOL("multifd-flush-after-each-section", MigrationState,
-                      multifd_flush_after_each_section, false),
-    DEFINE_PROP_UINT8("x-clear-bitmap-shift", MigrationState,
-                      clear_bitmap_shift, CLEAR_BITMAP_SHIFT_DEFAULT),
-    DEFINE_PROP_BOOL("x-preempt-pre-7-2", MigrationState,
-                     preempt_pre_7_2, false),
-    DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
-                     multifd_clean_tls_termination, true),
-
-    /* Migration parameters */
-    DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
-                      parameters.throttle_trigger_threshold,
-                      DEFAULT_MIGRATE_THROTTLE_TRIGGER_THRESHOLD),
-    DEFINE_PROP_UINT8("x-cpu-throttle-initial", MigrationState,
-                      parameters.cpu_throttle_initial,
-                      DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL),
-    DEFINE_PROP_UINT8("x-cpu-throttle-increment", MigrationState,
-                      parameters.cpu_throttle_increment,
-                      DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT),
-    DEFINE_PROP_BOOL("x-cpu-throttle-tailslow", MigrationState,
-                      parameters.cpu_throttle_tailslow, false),
-    DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
-                      parameters.max_bandwidth, MAX_THROTTLE),
-    DEFINE_PROP_SIZE("avail-switchover-bandwidth", MigrationState,
-                      parameters.avail_switchover_bandwidth, 0),
-    DEFINE_PROP_UINT64("x-downtime-limit", MigrationState,
-                      parameters.downtime_limit,
-                      DEFAULT_MIGRATE_SET_DOWNTIME),
-    DEFINE_PROP_UINT32("x-checkpoint-delay", MigrationState,
-                      parameters.x_checkpoint_delay,
-                      DEFAULT_MIGRATE_X_CHECKPOINT_DELAY),
-    DEFINE_PROP_UINT8("multifd-channels", MigrationState,
-                      parameters.multifd_channels,
-                      DEFAULT_MIGRATE_MULTIFD_CHANNELS),
-    DEFINE_PROP_MULTIFD_COMPRESSION("multifd-compression", MigrationState,
-                      parameters.multifd_compression,
-                      DEFAULT_MIGRATE_MULTIFD_COMPRESSION),
-    DEFINE_PROP_UINT8("multifd-zlib-level", MigrationState,
-                      parameters.multifd_zlib_level,
-                      DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
-    DEFINE_PROP_UINT8("multifd-qatzip-level", MigrationState,
-                      parameters.multifd_qatzip_level,
-                      DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL),
-    DEFINE_PROP_UINT8("multifd-zstd-level", MigrationState,
-                      parameters.multifd_zstd_level,
-                      DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL),
-    DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
-                      parameters.xbzrle_cache_size,
-                      DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
-    DEFINE_PROP_SIZE("max-postcopy-bandwidth", MigrationState,
-                      parameters.max_postcopy_bandwidth,
-                      DEFAULT_MIGRATE_MAX_POSTCOPY_BANDWIDTH),
-    DEFINE_PROP_UINT8("max-cpu-throttle", MigrationState,
-                      parameters.max_cpu_throttle,
-                      DEFAULT_MIGRATE_MAX_CPU_THROTTLE),
-    DEFINE_PROP_SIZE("announce-initial", MigrationState,
-                      parameters.announce_initial,
-                      DEFAULT_MIGRATE_ANNOUNCE_INITIAL),
-    DEFINE_PROP_SIZE("announce-max", MigrationState,
-                      parameters.announce_max,
-                      DEFAULT_MIGRATE_ANNOUNCE_MAX),
-    DEFINE_PROP_SIZE("announce-rounds", MigrationState,
-                      parameters.announce_rounds,
-                      DEFAULT_MIGRATE_ANNOUNCE_ROUNDS),
-    DEFINE_PROP_SIZE("announce-step", MigrationState,
-                      parameters.announce_step,
-                      DEFAULT_MIGRATE_ANNOUNCE_STEP),
-    DEFINE_PROP_STR_OR_NULL("tls-creds", MigrationState, parameters.tls_creds),
-    DEFINE_PROP_STR_OR_NULL("tls-hostname", MigrationState,
-                            parameters.tls_hostname),
-    DEFINE_PROP_STR_OR_NULL("tls-authz", MigrationState, parameters.tls_authz),
-    DEFINE_PROP_UINT64("x-vcpu-dirty-limit-period", MigrationState,
-                       parameters.x_vcpu_dirty_limit_period,
-                       DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD),
-    DEFINE_PROP_UINT64("vcpu-dirty-limit", MigrationState,
-                       parameters.vcpu_dirty_limit,
-                       DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT),
-    DEFINE_PROP_MIG_MODE("mode", MigrationState,
-                      parameters.mode,
-                      MIG_MODE_NORMAL),
-    DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
-                       parameters.zero_page_detection,
-                       ZERO_PAGE_DETECTION_MULTIFD),
-    DEFINE_PROP_UINT64("x-rdma-chunk-size", MigrationState,
-                      parameters.x_rdma_chunk_size,
-                      DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE),
-
-    /* Migration capabilities */
-    DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
-    DEFINE_PROP_MIG_CAP("x-rdma-pin-all", MIGRATION_CAPABILITY_RDMA_PIN_ALL),
-    DEFINE_PROP_MIG_CAP("x-auto-converge", MIGRATION_CAPABILITY_AUTO_CONVERGE),
-    DEFINE_PROP_MIG_CAP("x-events", MIGRATION_CAPABILITY_EVENTS),
-    DEFINE_PROP_MIG_CAP("x-postcopy-ram", MIGRATION_CAPABILITY_POSTCOPY_RAM),
-    DEFINE_PROP_MIG_CAP("x-postcopy-preempt",
-                        MIGRATION_CAPABILITY_POSTCOPY_PREEMPT),
-    DEFINE_PROP_MIG_CAP("postcopy-blocktime",
-                        MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME),
-    DEFINE_PROP_MIG_CAP("x-colo", MIGRATION_CAPABILITY_X_COLO),
-    DEFINE_PROP_MIG_CAP("x-release-ram", MIGRATION_CAPABILITY_RELEASE_RAM),
-    DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETURN_PATH),
-    DEFINE_PROP_MIG_CAP("x-multifd", MIGRATION_CAPABILITY_MULTIFD),
-    DEFINE_PROP_MIG_CAP("x-background-snapshot",
-            MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT),
-#ifdef CONFIG_LINUX
-    DEFINE_PROP_MIG_CAP("x-zero-copy-send",
-            MIGRATION_CAPABILITY_ZERO_COPY_SEND),
-#endif
-    DEFINE_PROP_MIG_CAP("x-switchover-ack",
-                        MIGRATION_CAPABILITY_SWITCHOVER_ACK),
-    DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
-    DEFINE_PROP_MIG_CAP("mapped-ram", MIGRATION_CAPABILITY_MAPPED_RAM),
-    DEFINE_PROP_MIG_CAP("x-ignore-shared",
-                        MIGRATION_CAPABILITY_X_IGNORE_SHARED),
-};
-const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
-
-static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
+static void migration_object_init_props_bool(MigrationState *s)
 {
-    const Property *prop = opaque;
-    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
-    StrOrNull *str_or_null = *ptr;
+    Object *obj = OBJECT(s);
+    int i;
 
-    /*
-     * The property should never be NULL because it's part of
-     * s->parameters and a default value is always set by qdev. It
-     * should also never be QNULL as the setter doesn't allow it.
-     */
-    assert(str_or_null && str_or_null->type != QTYPE_QNULL);
-    visit_type_str(v, name, &str_or_null->u.s, errp);
+    struct MigPropBool {
+        const char *name;
+        void *ptr;
+        bool defvar;
+    } bool_list[] = {
+        {
+            "store-global-state",
+            &s->store_global_state,
+            true,
+        },
+        {
+            "send-configuration",
+            &s->send_configuration,
+            true,
+        },
+        {
+            "send-section-footer",
+            &s->send_section_footer,
+            true,
+        },
+        {
+            "send-switchover-start",
+            &s->send_switchover_start,
+            true,
+        },
+        {
+            "x-preempt-pre-7-2",
+            &s->preempt_pre_7_2,
+            false,
+        },
+        {
+            "x-cpu-throttle-tailslow",
+            &s->parameters.cpu_throttle_tailslow,
+            false,
+        },
+        {
+            "multifd-clean-tls-termination",
+            &s->multifd_clean_tls_termination,
+            true,
+        },
+        {
+            "multifd-flush-after-each-section",
+            &s->multifd_flush_after_each_section,
+            false,
+        },
+    };
+    struct MigPropBool *prop;
+
+    for (i = 0; i < ARRAY_SIZE(bool_list); i++) {
+        prop = &bool_list[i];
+        object_property_add_bool_ptr_def(obj, prop->name,
+                                         prop->ptr, prop->defvar);
+    }
 }
 
-static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
+static void migration_object_init_props_uint8(MigrationState *s)
 {
-    const Property *prop = opaque;
-    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
-    StrOrNull *str_or_null;
-    char *str;
+    Object *obj = OBJECT(s);
+    int i;
 
-    if (!visit_type_str(v, name, &str, errp)) {
-        return;
-    }
+    struct MigPropUint8 {
+        const char *name;
+        void *ptr;
+        uint8_t defvar;
+    } uint8_list[] = {
+        {
+            "clear-bitmap-shift",
+            &s->clear_bitmap_shift,
+            CLEAR_BITMAP_SHIFT_DEFAULT,
+        },
+        {
+            "throttle-trigger-threshold",
+            &s->parameters.throttle_trigger_threshold,
+            DEFAULT_MIGRATE_THROTTLE_TRIGGER_THRESHOLD,
+        },
+        {
+            "cpu-throttle-initial",
+            &s->parameters.cpu_throttle_initial,
+            DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL,
+        },
+        {
+            "cpu-throttle-increment",
+            &s->parameters.cpu_throttle_increment,
+            DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT,
+        },
+        {
+            "multifd-channels",
+            &s->parameters.multifd_channels,
+            DEFAULT_MIGRATE_MULTIFD_CHANNELS,
+        },
+        {
+            "multifd-zlib-level",
+            &s->parameters.multifd_zlib_level,
+            DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL,
+        },
+        {
+            "multifd-qatzip-level",
+            &s->parameters.multifd_qatzip_level,
+            DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL,
+        },
+        {
+            "multifd-zstd-level",
+            &s->parameters.multifd_zstd_level,
+            DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL,
+        },
+        {
+            "max-cpu-throttle",
+            &s->parameters.max_cpu_throttle,
+            DEFAULT_MIGRATE_MAX_CPU_THROTTLE,
+        },
+    };
+    struct MigPropUint8 *prop;
 
-    /*
-     * This property only applies to the command line usage of
-     * migration's TLS options (-global migration.tls-*) where the
-     * NULL value cannot be provided as input (only strings are
-     * allowed). Therefore, this StrOrNull implementation never
-     * produces a QNULL value to avoid ever returning values outside
-     * the range of what was previously handled by consumers of the
-     * TLS options.
-     */
-    str_or_null = g_new0(StrOrNull, 1);
-    str_or_null->type = QTYPE_QSTRING;
-    str_or_null->u.s = str;
+    for (i = 0; i < ARRAY_SIZE(uint8_list); i++) {
+        prop = &uint8_list[i];
+        object_property_add_uint8_ptr_def(obj, prop->name,
+                                          prop->ptr, prop->defvar);
+    }
+}
 
-    qapi_free_StrOrNull(*ptr);
-    *ptr = str_or_null;
+static void migration_object_init_props_uint32(MigrationState *s)
+{
+    object_property_add_uint32_ptr_def(OBJECT(s), "x-checkpoint-delay",
+                                       &s->parameters.x_checkpoint_delay,
+                                       DEFAULT_MIGRATE_X_CHECKPOINT_DELAY);
 }
 
-static void release_StrOrNull(Object *obj, const char *name, void *opaque)
+static void migration_object_init_props_uint64(MigrationState *s)
 {
-    const Property *prop = opaque;
-    qapi_free_StrOrNull(*(StrOrNull **)object_field_prop_ptr(obj, prop));
+    Object *obj = OBJECT(s);
+    int i;
+
+    struct MigPropUint64 {
+        const char *name;
+        void *ptr;
+        uint64_t defvar;
+    } uint64_list[] = {
+        {
+            "downtime-limit",
+            &s->parameters.downtime_limit,
+            DEFAULT_MIGRATE_SET_DOWNTIME,
+        },
+        {
+            "x-vcpu-dirty-limit-period",
+            &s->parameters.x_vcpu_dirty_limit_period,
+            DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD,
+        },
+        {
+            "vcpu-dirty-limit",
+            &s->parameters.vcpu_dirty_limit,
+            DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT,
+        },
+        {
+            "x-rdma-chunk-size",
+            &s->parameters.x_rdma_chunk_size,
+            DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE,
+        },
+    };
+    struct MigPropUint64 *prop;
+
+    for (i = 0; i < ARRAY_SIZE(uint64_list); i++) {
+        prop = &uint64_list[i];
+        object_property_add_uint64_ptr_def(obj, prop->name,
+                                           prop->ptr, prop->defvar);
+    }
 }
 
-static void set_default_value_tls_opt(ObjectProperty *op, const Property *prop)
+static void migration_object_init_props_size(MigrationState *s)
 {
-    /*
-     * Initialization to the empty string here is important so
-     * query-migrate-parameters doesn't need to deal with a NULL value
-     * when it's called before any TLS option has been set.
-     */
-    object_property_set_default_str(op, "");
+    Object *obj = OBJECT(s);
+    int i;
+
+    struct MigPropSize {
+        const char *name;
+        void *ptr;
+        uint64_t defvar;
+    } size_list[] = {
+        {
+            "xbzrle-cache-size",
+            &s->parameters.xbzrle_cache_size,
+            DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE,
+        },
+        {
+            "max-postcopy-bandwidth",
+            &s->parameters.max_postcopy_bandwidth,
+            DEFAULT_MIGRATE_MAX_POSTCOPY_BANDWIDTH,
+        },
+        {
+            "announce-initial",
+            &s->parameters.announce_initial,
+            DEFAULT_MIGRATE_ANNOUNCE_INITIAL,
+        },
+        {
+            "announce-max",
+            &s->parameters.announce_max,
+            DEFAULT_MIGRATE_ANNOUNCE_MAX,
+        },
+        {
+            "announce-rounds",
+            &s->parameters.announce_rounds,
+            DEFAULT_MIGRATE_ANNOUNCE_ROUNDS,
+        },
+        {
+            "announce-step",
+            &s->parameters.announce_step,
+            DEFAULT_MIGRATE_ANNOUNCE_STEP,
+        },
+        {
+            "max-bandwidth",
+            &s->parameters.max_bandwidth,
+            MAX_THROTTLE,
+        },
+        {
+            "avail-switchover-bandwidth",
+            &s->parameters.avail_switchover_bandwidth,
+            0,
+        },
+    };
+    struct MigPropSize *prop;
+
+    for (i = 0; i < ARRAY_SIZE(size_list); i++) {
+        prop = &size_list[i];
+        object_property_add_size_ptr_def(obj, prop->name,
+                                         prop->ptr, prop->defvar);
+    }
 }
 
-/*
- * String property like qdev_prop_string, except it's backed by a
- * StrOrNull instead of a char *.  This is intended for
- * TYPE_MIGRATION's TLS options.
- */
-const PropertyInfo qdev_prop_StrOrNull = {
-    .type  = "StrOrNull",
-    .get = get_StrOrNull,
-    .set = set_StrOrNull,
-    .release = release_StrOrNull,
-    .set_default_value = set_default_value_tls_opt,
-};
+static void migration_object_init_props_caps(MigrationState *s)
+{
+    Object *obj = OBJECT(s);
+    int i;
+
+    /* Migration capabilties are always turned off by default */
+    for (i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
+        object_property_add_bool_ptr_def(obj,
+                                         MigrationCapability_str(i),
+                                         &s->capabilities[i],
+                                         false);
+    }
+}
+
+#define  DEFINE_TLS_PROP_HELPERS(varname)                               \
+    static char *mig_prop_##varname##_get(Object *obj, Error **errp)    \
+    {                                                                   \
+        MigrationState *s = MIGRATION(obj);                             \
+        StrOrNull *var = s->parameters.varname;                         \
+                                                                        \
+        assert(var->type == QTYPE_QSTRING);                             \
+        return g_strdup(var->u.s);                                      \
+    }                                                                   \
+                                                                        \
+    static void mig_prop_##varname##_set(Object *obj, const char *str,  \
+                                         Error **errp)                  \
+    {                                                                   \
+        MigrationState *s = MIGRATION(obj);                             \
+        StrOrNull *new = g_new0(StrOrNull, 1);                          \
+                                                                        \
+        qapi_free_StrOrNull(s->parameters.varname);                     \
+                                                                        \
+        new->type = QTYPE_QSTRING;                                      \
+        new->u.s = g_strdup(str);                                       \
+        s->parameters.varname = new;                                    \
+    }
+
+DEFINE_TLS_PROP_HELPERS(tls_creds)
+DEFINE_TLS_PROP_HELPERS(tls_authz)
+DEFINE_TLS_PROP_HELPERS(tls_hostname)
+
+static void migration_object_init_props_tls(MigrationState *s)
+{
+    Object *obj = OBJECT(s);
+    ObjectProperty *prop;
+
+    prop = object_property_add_str(obj, "tls-creds",
+                                   mig_prop_tls_creds_get,
+                                   mig_prop_tls_creds_set);
+    object_property_set_default_str(prop, "");
+
+    prop = object_property_add_str(obj, "tls-hostname",
+                                   mig_prop_tls_hostname_get,
+                                   mig_prop_tls_hostname_set);
+    object_property_set_default_str(prop, "");
+
+    prop = object_property_add_str(obj, "tls-authz",
+                                   mig_prop_tls_authz_get,
+                                   mig_prop_tls_authz_set);
+    object_property_set_default_str(prop, "");
+}
+
+#define  DEFINE_ENUM_PROP_HELPERS(param_name)                           \
+    static int mig_prop_##param_name##_get(Object *obj, Error **errp)   \
+    {                                                                   \
+        return (int) MIGRATION(obj)->parameters.param_name;             \
+    }                                                                   \
+                                                                        \
+    static void mig_prop_##param_name##_set(Object *obj, int val,       \
+                                            Error **errp)               \
+    {                                                                   \
+        MIGRATION(obj)->parameters.param_name = val;                    \
+    }
+
+DEFINE_ENUM_PROP_HELPERS(multifd_compression)
+DEFINE_ENUM_PROP_HELPERS(zero_page_detection)
+DEFINE_ENUM_PROP_HELPERS(mode)
+
+static void migration_object_init_props_enum(MigrationState *s)
+{
+    Object *obj = OBJECT(s);
+    ObjectProperty *prop;
+
+    prop = object_property_add_enum(obj, "multifd-compression",
+                                    "MultiFDCompression",
+                                    &MultiFDCompression_lookup,
+                                    mig_prop_multifd_compression_get,
+                                    mig_prop_multifd_compression_set);
+    object_property_set_default_str(prop, DEFAULT_MIGRATE_MULTIFD_COMPRESSION);
+
+    prop = object_property_add_enum(obj, "mode", "MigMode", &MigMode_lookup,
+                                    mig_prop_mode_get, mig_prop_mode_set);
+    object_property_set_default_str(prop, "normal");
+
+    prop = object_property_add_enum(obj, "zero-page-detection",
+                                    "ZeroPageDetection",
+                                    &ZeroPageDetection_lookup,
+                                    mig_prop_zero_page_detection_get,
+                                    mig_prop_zero_page_detection_set);
+    object_property_set_default_str(prop, "multifd");
+}
+
+static void migration_object_init_properties(MigrationState *s)
+{
+    migration_object_init_props_bool(s);
+    migration_object_init_props_uint8(s);
+    migration_object_init_props_uint32(s);
+    migration_object_init_props_uint64(s);
+    migration_object_init_props_size(s);
+    migration_object_init_props_caps(s);
+    migration_object_init_props_tls(s);
+    migration_object_init_props_enum(s);
+}
 
 bool migrate_auto_converge(void)
 {
@@ -1107,9 +1246,10 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     return params;
 }
 
-void migrate_params_init(MigrationParameters *params)
+void migrate_params_init(MigrationState *s)
 {
-    migrate_mark_all_params_present(params);
+    migration_object_init_properties(s);
+    migrate_mark_all_params_present(&s->parameters);
 }
 
 static void migrate_post_update_params(MigrationParameters *new, Error **errp)
-- 
2.53.0


