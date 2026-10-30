Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528B0606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wk4DPc6s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMq86-00086r-12; Fri, 30 Oct 2026 13:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xMq84-00086K-II; Fri, 30 Oct 2026 13:11:00 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xMq7z-0004AC-Ld; Fri, 30 Oct 2026 13:11:00 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6DB9660611;
 Fri, 30 Oct 2026 17:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51BA1F000C1;
 Fri, 30 Oct 2026 17:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793380254;
 bh=qFdh76XqVT6Vb/j4EeU3aZ9u/K7IJDk796yLF87obf4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Wk4DPc6sWHmIttCtvzZ72bk3AtRbw47J5nP3mVvtup3EUMZGExBKzIU6HvbFTBPyy
 Vbzx6S8Lwg5ZO9YvuNM8PY5cJgt02FzmSZNezcf11BJyJDWh0BnEsZZiSPJwFuxjIO
 mH+kVXhb3UPzzs3Mn5j7R9PmBlDHwu86N7vekQCgFtuM+cinpQ3kOu5I3wey9pPDd3
 cRbThBFvZ96cGkLFWOnpyZPEzT6PEgntmtTwgS5gHc2hgbOIwcFIySgSHFAHf8n3CM
 XhbTMsE1QHqp9H+7R3fDcN70/uJHkNWO6GwqMhOrWsbF2ljaX+8WtnGO4pUj4gNe/3
 4eS3Wg4BBiT4Q==
From: Niklas Cassel <cassel@kernel.org>
To: qemu-devel@nongnu.org
Cc: Sam Li <faithilikerun@gmail.com>, dlemoal@kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Jeuk Kim <jeuk20.kim@samsung.com>, Daejun Park <daejun7.park@samsung.com>,
 Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v16 2/9] qcow2: add configurations for zoned format extension
Date: Fri, 30 Oct 2026 18:10:29 +0100
Message-ID: <20261030171038.702962-3-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030171038.702962-1-cassel@kernel.org>
References: <20261030171038.702962-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sam Li <faithilikerun@gmail.com>

To configure the zoned format feature on the qcow2 driver, it
requires settings as: the device size, zone model, zone size,
zone capacity, number of conventional zones, limits on zone
resources (max open zones and max active zones).

To create a qcow2 image with zoned format feature, use command like
this:
qemu-img create -f qcow2 zbc.qcow2 -o size=768M \
-o zone.size=64M -o zone.capacity=64M -o zone.conventional_zones=0 \
-o zone.max_open_zones=6 -o zone.max_active_zones=8 \
-o zone.mode=host-managed

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Acked-by: Markus Armbruster <armbru@redhat.com> # QAPI schema
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes by Niklas Cassel:
- validate the zoned extension header before it becomes the driver state,
  so that the clamped resource limits are the ones that take effect
- drop the zone append size limit from the header, the QAPI schema and the
  format documentation; it described a limit on an operation that the
  driver derives from the geometry instead
- do not report a zone write granularity; the block layer already requires
  an append to be a multiple of the sector size, and a coarser granularity
  belongs to a driver that has a medium with one
- take the zone capacity into account, as bdrv_zone_writable_end(), which
  bdrv_zone_is_full() then uses
- require the zone size to be a multiple of the cluster size, so that
  a zone never shares a cluster with another zone, and resetting it can
  zero its clusters in place
- require version 3 for a zoned image, as the zoned format is an
  incompatible feature, which a version 2 header cannot express; refuse
  a zoned extension without the incompatible feature bit when opening
---
 block/io.c                                    |  13 +-
 block/qcow2.c                                 | 363 +++++++++++++++++-
 block/qcow2.h                                 |  84 +++-
 docs/interop/qcow2.rst                        | 115 +++++-
 hw/block/block.c                              |   7 +
 include/block/block-io.h                      |   6 +
 include/block/block_int-common.h              |  12 +
 qapi/block-core.json                          |  86 ++++-
 tests/qemu-iotests/031.out                    |   8 +-
 tests/qemu-iotests/036.out                    |   4 +-
 tests/qemu-iotests/061.out                    |  14 +-
 tests/qemu-iotests/082.out                    | 108 ++++++
 tests/qemu-iotests/303.out                    |   4 +-
 tests/qemu-iotests/tests/qcow2-encryption.out |   4 +-
 14 files changed, 801 insertions(+), 27 deletions(-)

diff --git a/block/io.c b/block/io.c
index 06b1fc13b9..6e33da7f23 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3400,13 +3400,20 @@ bool bdrv_zone_is_conv(BlockDriverState *bs, uint32_t index)
     return BDRV_ZT_IS_CONV(bs->wps->wp[index]);
 }
 
+uint64_t bdrv_zone_writable_end(BlockDriverState *bs, uint32_t index)
+{
+    uint64_t writable = MIN_NON_ZERO(bs->bl.zone_capacity, bs->bl.zone_size);
+    IO_CODE();
+
+    return MIN((uint64_t)index * bs->bl.zone_size + writable,
+               (uint64_t)bs->total_sectors << BDRV_SECTOR_BITS);
+}
+
 bool bdrv_zone_is_full(BlockDriverState *bs, uint32_t index)
 {
-    uint64_t zone_end = MIN((uint64_t)(index + 1) * bs->bl.zone_size,
-                            (uint64_t)bs->total_sectors << BDRV_SECTOR_BITS);
     IO_CODE();
 
-    return bs->wps->wp[index] >= zone_end;
+    return bs->wps->wp[index] >= bdrv_zone_writable_end(bs, index);
 }
 
 void *qemu_blockalign(BlockDriverState *bs, size_t size)
diff --git a/block/qcow2.c b/block/qcow2.c
index 0358bc04f3..01215bcf9b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -73,6 +73,7 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
 #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
 #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
+#define  QCOW2_EXT_MAGIC_ZONED_FORMAT 0x007a6264
 
 static int coroutine_fn
 qcow2_co_preadv_compressed(BlockDriverState *bs,
@@ -194,6 +195,90 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const char *fmt, Error **errp)
     return cryptoopts_qdict;
 }
 
+/*
+ * Returns true if zone_opt is valid for an image with clusters of
+ * @cluster_size bytes, false otherwise.
+ */
+static bool
+qcow2_check_zone_options(Qcow2ZonedHeaderExtension *zone_opt,
+                         uint32_t cluster_size)
+{
+    uint32_t sequential_zones;
+
+    assert(zone_opt != NULL);
+
+    if (zone_opt->zoned != QCOW2_Z_NONE && zone_opt->zoned != QCOW2_Z_HM) {
+        warn_report("Zoned extension header zoned field has unknown "
+                    "value %" PRIu8, zone_opt->zoned);
+        return false;
+    }
+
+    if (zone_opt->zone_size == 0) {
+        warn_report("Zoned extension header zone_size field must not be 0");
+        return false;
+    }
+
+    if (!is_power_of_2(zone_opt->zone_size)) {
+        warn_report("Zoned extension header zone_size %" PRIu64
+                    "B is not a power of 2", zone_opt->zone_size);
+        return false;
+    }
+
+    /* A zone consists of whole clusters, which it shares with no other zone */
+    if (zone_opt->zone_size % cluster_size) {
+        warn_report("Zoned extension header zone_size %" PRIu64
+                    "B is not a multiple of the cluster size %" PRIu32 "B",
+                    zone_opt->zone_size, cluster_size);
+        return false;
+    }
+
+    if (zone_opt->nr_zones > QCOW2_MAX_NR_ZONES) {
+        warn_report("Zoned extension header nr_zones %" PRIu32
+                    " exceeds maximum %u",
+                    zone_opt->nr_zones, QCOW2_MAX_NR_ZONES);
+        return false;
+    }
+
+    if (zone_opt->zone_capacity > zone_opt->zone_size) {
+        warn_report("zone capacity %" PRIu64 "B exceeds zone size "
+                    "%" PRIu64 "B", zone_opt->zone_capacity,
+                    zone_opt->zone_size);
+        return false;
+    }
+
+    if (zone_opt->conventional_zones >= zone_opt->nr_zones) {
+        warn_report("Conventional_zones %" PRIu32 " exceeds "
+                    "nr_zones %" PRIu32 ".",
+                    zone_opt->conventional_zones, zone_opt->nr_zones);
+        return false;
+    }
+
+    if (zone_opt->max_active_zones > zone_opt->nr_zones) {
+        warn_report("max_active_zones %" PRIu32 " exceeds nr_zones %" PRIu32
+                    ", clamping to nr_zones",
+                    zone_opt->max_active_zones, zone_opt->nr_zones);
+        zone_opt->max_active_zones = zone_opt->nr_zones;
+    }
+
+    sequential_zones = zone_opt->nr_zones - zone_opt->conventional_zones;
+    if (zone_opt->max_open_zones > sequential_zones) {
+        warn_report("max_open_zones %" PRIu32 " exceeds the number of SWR "
+                    "zones, clamping to %" PRIu32,
+                    zone_opt->max_open_zones, sequential_zones);
+        zone_opt->max_open_zones = sequential_zones;
+    }
+    if (zone_opt->max_active_zones != 0 &&
+        zone_opt->max_open_zones > zone_opt->max_active_zones) {
+        warn_report("max_open_zones %" PRIu32 " exceeds max_active_zones "
+                    "%" PRIu32 ", clamping to max_active_zones",
+                    zone_opt->max_open_zones,
+                    zone_opt->max_active_zones);
+        zone_opt->max_open_zones = zone_opt->max_active_zones;
+    }
+
+    return true;
+}
+
 /*
  * read qcow2 extension and fill bs
  * start reading from start_offset
@@ -211,6 +296,7 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
     uint64_t offset;
     int ret;
     Qcow2BitmapHeaderExt bitmaps_ext;
+    Qcow2ZonedHeaderExtension zoned_ext;
 
     if (need_update_header != NULL) {
         *need_update_header = false;
@@ -432,6 +518,96 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             break;
         }
 
+        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
+        {
+            if (ext.len != sizeof(zoned_ext)) {
+                error_setg(errp, "zoned_ext: unexpected len=%" PRIu32 " "
+                           "(expected %zu)", ext.len, sizeof(zoned_ext));
+                return -EINVAL;
+            }
+            ret = bdrv_pread(bs->file, offset, ext.len, &zoned_ext, 0);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "zoned_ext: "
+                                 "Could not read ext header");
+                return ret;
+            }
+
+            zoned_ext.zone_size = be64_to_cpu(zoned_ext.zone_size);
+            zoned_ext.zone_capacity = be64_to_cpu(zoned_ext.zone_capacity);
+            zoned_ext.conventional_zones =
+                be32_to_cpu(zoned_ext.conventional_zones);
+            zoned_ext.nr_zones = be32_to_cpu(zoned_ext.nr_zones);
+            zoned_ext.max_open_zones = be32_to_cpu(zoned_ext.max_open_zones);
+            zoned_ext.max_active_zones =
+                be32_to_cpu(zoned_ext.max_active_zones);
+            /*
+             * A zoned image has the zoned incompatible feature bit set,
+             * which a version 2 image cannot have.
+             */
+            if (zoned_ext.zoned == QCOW2_Z_HM &&
+                !(s->incompatible_features & QCOW2_INCOMPAT_ZONED_FORMAT)) {
+                error_setg(errp, "Zoned extension header without the zoned "
+                           "incompatible feature bit");
+                return -EINVAL;
+            }
+
+            /*
+             * Validate the header before it becomes the driver state.
+             * qcow2_check_zone_options() also clamps the zone resource
+             * limits, so the driver has to pick up the checked copy.
+             */
+            if (!qcow2_check_zone_options(&zoned_ext, s->cluster_size)) {
+                error_setg(errp, "Invalid zoned extension header");
+                return -EINVAL;
+            }
+            s->zoned_header = zoned_ext;
+
+            /*
+             * refuse to open broken images: reject untrusted total_sectors
+             * that would overflow when converted to bytes, then verify
+             * nr_zones matches the device size.
+             */
+            if (bs->total_sectors < 0 ||
+                (uint64_t)bs->total_sectors > UINT64_MAX / BDRV_SECTOR_SIZE) {
+                error_setg(errp, "Image size overflows when converted "
+                           "to bytes");
+                return -EINVAL;
+            }
+            if (zoned_ext.nr_zones != DIV_ROUND_UP(
+                    (uint64_t)bs->total_sectors * BDRV_SECTOR_SIZE,
+                    zoned_ext.zone_size)) {
+                error_setg(errp, "Zoned extension header nr_zones field "
+                           "is wrong");
+                return -EINVAL;
+            }
+
+            /*
+             * Reject a header that claims more zones than the file can hold.
+             */
+            {
+                int64_t file_length = bdrv_co_getlength(bs->file->bs);
+                uint64_t wp_table_size =
+                    (uint64_t)zoned_ext.nr_zones * sizeof(uint64_t);
+
+                if (file_length < 0) {
+                    return file_length;
+                }
+                if (zoned_ext.zonedmeta_offset > (uint64_t)file_length ||
+                    (uint64_t)file_length - zoned_ext.zonedmeta_offset <
+                        wp_table_size) {
+                    error_setg(errp, "Zoned metadata region exceeds the "
+                               "image file size");
+                    return -EINVAL;
+                }
+            }
+
+#ifdef DEBUG_EXT
+            printf("Qcow2: Got zoned format extension: "
+                   "offset=%" PRIu64 "\n", offset);
+#endif
+            break;
+        }
+
         default:
             /* unknown magic - save it in case we need to rewrite the header */
             /* If you add a new feature, make sure to also update the fast
@@ -2076,6 +2252,22 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
     }
     bs->bl.pwrite_zeroes_alignment = s->subcluster_size;
     bs->bl.pdiscard_alignment = s->cluster_size;
+
+    switch (s->zoned_header.zoned) {
+    case QCOW2_Z_HM:
+        bs->bl.zoned = BLK_Z_HM;
+        break;
+    case QCOW2_Z_NONE:
+    default:
+        bs->bl.zoned = BLK_Z_NONE;
+        break;
+    }
+
+    bs->bl.nr_zones = s->zoned_header.nr_zones;
+    bs->bl.max_active_zones = s->zoned_header.max_active_zones;
+    bs->bl.max_open_zones = s->zoned_header.max_open_zones;
+    bs->bl.zone_size = s->zoned_header.zone_size;
+    bs->bl.zone_capacity = s->zoned_header.zone_capacity;
 }
 
 static int GRAPH_UNLOCKED
@@ -3184,6 +3376,11 @@ int qcow2_update_header(BlockDriverState *bs)
                 .bit  = QCOW2_INCOMPAT_EXTL2_BITNR,
                 .name = "extended L2 entries",
             },
+            {
+                .type = QCOW2_FEAT_TYPE_INCOMPATIBLE,
+                .bit  = QCOW2_INCOMPAT_ZONED_FORMAT_BITNR,
+                .name = "zoned format",
+            },
             {
                 .type = QCOW2_FEAT_TYPE_COMPATIBLE,
                 .bit  = QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
@@ -3229,6 +3426,29 @@ int qcow2_update_header(BlockDriverState *bs)
         buflen -= ret;
     }
 
+    /* Zoned devices header extension */
+    if (s->zoned_header.zoned == QCOW2_Z_HM) {
+        Qcow2ZonedHeaderExtension zoned_header = {
+            .zoned              = s->zoned_header.zoned,
+            .zone_size          = cpu_to_be64(s->zoned_header.zone_size),
+            .zone_capacity      = cpu_to_be64(s->zoned_header.zone_capacity),
+            .conventional_zones =
+                cpu_to_be32(s->zoned_header.conventional_zones),
+            .nr_zones           = cpu_to_be32(s->zoned_header.nr_zones),
+            .max_open_zones     = cpu_to_be32(s->zoned_header.max_open_zones),
+            .max_active_zones   =
+                cpu_to_be32(s->zoned_header.max_active_zones),
+        };
+        ret = header_ext_add(buf, QCOW2_EXT_MAGIC_ZONED_FORMAT,
+                             &zoned_header, sizeof(zoned_header),
+                             buflen);
+        if (ret < 0) {
+            goto fail;
+        }
+        buf += ret;
+        buflen -= ret;
+    }
+
     /* Keep unknown header extensions */
     QLIST_FOREACH(uext, &s->unknown_header_ext, next) {
         ret = header_ext_add(buf, uext->magic, uext->data, uext->len, buflen);
@@ -3603,6 +3823,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     ERRP_GUARD();
     BlockdevCreateOptionsQcow2 *qcow2_opts;
     QDict *options;
+    Qcow2ZoneCreateOptions *zone_struct;
+    Qcow2ZoneHostManaged *zone_host_managed;
 
     /*
      * Open the image file and write a minimal qcow2 header.
@@ -3629,6 +3851,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
 
     assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
     qcow2_opts = &create_options->u.qcow2;
+    zone_struct = qcow2_opts->zone;
+    zone_host_managed = NULL;
 
     bs = bdrv_co_open_blockdev_ref(qcow2_opts->file, errp);
     if (bs == NULL) {
@@ -3677,6 +3901,15 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         }
     }
 
+    /* The zoned format is an incompatible feature, which needs version 3 */
+    if (zone_struct && zone_struct->mode == QCOW2_ZONE_MODEL_HOST_MANAGED &&
+        version < 3) {
+        error_setg(errp, "Zoned images are only supported with compatibility "
+                   "level 1.1 and above (use version=v3 or greater)");
+        ret = -EINVAL;
+        goto out;
+    }
+
     if (!validate_cluster_size(cluster_size, qcow2_opts->extended_l2, errp)) {
         ret = -EINVAL;
         goto out;
@@ -3842,6 +4075,14 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         header->incompatible_features |=
             cpu_to_be64(QCOW2_INCOMPAT_DATA_FILE);
     }
+    if (zone_struct && zone_struct->mode == QCOW2_ZONE_MODEL_HOST_MANAGED) {
+        /*
+         * The incompatible bit must be set when the zone model is
+         * host-managed
+         */
+        header->incompatible_features |=
+            cpu_to_be64(QCOW2_INCOMPAT_ZONED_FORMAT);
+    }
     if (qcow2_opts->data_file_raw) {
         header->autoclear_features |=
             cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
@@ -3899,10 +4140,9 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     bdrv_graph_co_rdlock();
     ret = qcow2_alloc_clusters(blk_bs(blk), 3 * cluster_size);
     if (ret < 0) {
-        bdrv_graph_co_rdunlock();
         error_setg_errno(errp, -ret, "Could not allocate clusters for qcow2 "
                          "header and refcount table");
-        goto out;
+        goto unlock;
 
     } else if (ret != 0) {
         error_report("Huh, first cluster in empty image is already in use?");
@@ -3910,11 +4150,71 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     }
 
     /* Set the external data file if necessary */
+    BDRVQcow2State *s = blk_bs(blk)->opaque;
     if (data_bs) {
-        BDRVQcow2State *s = blk_bs(blk)->opaque;
         s->image_data_file = g_strdup(data_bs->filename);
     }
 
+    if (zone_struct && zone_struct->mode == QCOW2_ZONE_MODEL_HOST_MANAGED) {
+        s->zoned_header.zoned = QCOW2_Z_HM;
+        zone_host_managed = &zone_struct->u.host_managed;
+
+        if (zone_host_managed->has_size) {
+            s->zoned_header.zone_size = zone_host_managed->size;
+        } else {
+            s->zoned_header.zone_size = DEFAULT_ZONE_SIZE;
+        }
+
+        if (s->zoned_header.zone_size == 0) {
+            error_setg(errp, "Zoned extension header zone_size field "
+                       "can not be 0");
+            s->zoned_header.zoned = QCOW2_Z_NONE;
+            ret = -EINVAL;
+            goto unlock;
+        }
+        s->zoned_header.nr_zones = DIV_ROUND_UP(qcow2_opts->size,
+                                                s->zoned_header.zone_size);
+
+        if (zone_host_managed->has_capacity) {
+            s->zoned_header.zone_capacity = zone_host_managed->capacity;
+        } else {
+            s->zoned_header.zone_capacity = s->zoned_header.zone_size;
+        }
+
+        if (zone_host_managed->has_conventional_zones) {
+            s->zoned_header.conventional_zones =
+                zone_host_managed->conventional_zones;
+        } else {
+            s->zoned_header.conventional_zones = 0;
+        }
+
+        if (zone_host_managed->has_max_active_zones) {
+            s->zoned_header.max_active_zones =
+                zone_host_managed->max_active_zones;
+        } else {
+            s->zoned_header.max_active_zones = 0;
+        }
+
+        if (zone_host_managed->has_max_open_zones) {
+            s->zoned_header.max_open_zones =
+                zone_host_managed->max_open_zones;
+        } else if (zone_host_managed->has_max_active_zones) {
+            s->zoned_header.max_open_zones =
+                zone_host_managed->max_active_zones;
+        } else {
+            s->zoned_header.max_open_zones = 0;
+        }
+
+        if (!qcow2_check_zone_options(&s->zoned_header, s->cluster_size)) {
+            error_setg(errp, "Invalid zoned device options");
+            s->zoned_header.zoned = QCOW2_Z_NONE;
+            ret = -EINVAL;
+            goto unlock;
+        }
+    } else {
+        s->zoned_header.zoned = QCOW2_Z_NONE;
+    }
+
     /* Create a full header (including things like feature table) */
     ret = qcow2_update_header(blk_bs(blk));
     bdrv_graph_co_rdunlock();
@@ -3988,6 +4288,9 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     }
 
     ret = 0;
+    goto out;
+unlock:
+    bdrv_graph_co_rdunlock();
 out:
     blk_co_unref(blk);
     bdrv_co_unref(bs);
@@ -4066,6 +4369,9 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
         { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
         { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
+        { BLOCK_OPT_CONVENTIONAL_ZONES, "zone.conventional-zones" },
+        { BLOCK_OPT_MAX_OPEN_ZONES,     "zone.max-open-zones" },
+        { BLOCK_OPT_MAX_ACTIVE_ZONES,   "zone.max-active-zones" },
         { NULL, NULL },
     };
 
@@ -5462,6 +5768,27 @@ qcow2_get_specific_info(BlockDriverState *bs, Error **errp)
             .data_file_raw      = data_file_is_raw(bs),
             .compression_type   = s->compression_type,
         };
+        if (s->zoned_header.zoned == QCOW2_Z_HM) {
+            ImageInfoSpecificQCow2Zoned *z =
+                g_new0(ImageInfoSpecificQCow2Zoned, 1);
+            *z = (ImageInfoSpecificQCow2Zoned){
+                .mode = QCOW2_ZONE_MODEL_HOST_MANAGED,
+                .nr_zones = s->zoned_header.nr_zones,
+                .u.host_managed = {
+                    .has_size = true,
+                    .size = s->zoned_header.zone_size,
+                    .has_capacity = true,
+                    .capacity = s->zoned_header.zone_capacity,
+                    .has_conventional_zones = true,
+                    .conventional_zones = s->zoned_header.conventional_zones,
+                    .has_max_open_zones = true,
+                    .max_open_zones = s->zoned_header.max_open_zones,
+                    .has_max_active_zones = true,
+                    .max_active_zones = s->zoned_header.max_active_zones,
+                },
+            };
+            spec_info->u.qcow2.data->zone = z;
+        }
     } else {
         /* if this assertion fails, this probably means a new version was
          * added without having it covered here */
@@ -6285,6 +6612,36 @@ static QemuOptsList qcow2_create_opts = {
             .type = QEMU_OPT_BOOL,                                      \
             .help = "Assume the external data file already exists and " \
                     "do not overwrite it"                               \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_ZONE_MODEL,                               \
+            .type = QEMU_OPT_STRING,                                    \
+            .help = "zone model modes, mode choice: host-managed",      \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_ZONE_SIZE,                                \
+            .type = QEMU_OPT_SIZE,                                      \
+            .help = "zone size",                                        \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_ZONE_CAPACITY,                            \
+            .type = QEMU_OPT_SIZE,                                      \
+            .help = "zone capacity",                                    \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_CONVENTIONAL_ZONES,                       \
+            .type = QEMU_OPT_NUMBER,                                    \
+            .help = "numbers of conventional zones",                    \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_MAX_ACTIVE_ZONES,                         \
+            .type = QEMU_OPT_NUMBER,                                    \
+            .help = "max active zones",                                 \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_MAX_OPEN_ZONES,                           \
+            .type = QEMU_OPT_NUMBER,                                    \
+            .help = "max open zones",                                   \
         },
         QCOW_COMMON_OPTIONS,
         { /* end of list */ }
diff --git a/block/qcow2.h b/block/qcow2.h
index ba9fe68130..7757b98385 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -129,6 +129,11 @@
 
 #define DEFAULT_CLUSTER_SIZE 65536
 
+#define DEFAULT_ZONE_SIZE (256 * MiB)
+
+#define QCOW2_Z_NONE 0 /* Regular block device */
+#define QCOW2_Z_HM 1 /* Host-managed zoned block device */
+
 #define QCOW2_OPT_DATA_FILE "data-file"
 #define QCOW2_OPT_LAZY_REFCOUNTS "lazy-refcounts"
 #define QCOW2_OPT_DISCARD_REQUEST "pass-discard-request"
@@ -237,6 +242,62 @@ typedef struct Qcow2CryptoHeaderExtension {
     uint64_t length;
 } QEMU_PACKED Qcow2CryptoHeaderExtension;
 
+/* Maximum number of zones a zoned image can have. */
+#define QCOW2_MAX_NR_ZONES (1U << 20)
+
+typedef struct Qcow2ZonedHeaderExtension {
+    /* Zoned device attributes */
+    uint8_t zoned;
+    uint8_t reserved[3];
+    uint32_t nr_zones;
+    uint64_t zone_size;
+    uint64_t zone_capacity;
+    uint64_t zonedmeta_offset;
+    uint32_t conventional_zones;
+    uint32_t max_active_zones;
+    uint32_t max_open_zones;
+} QEMU_PACKED Qcow2ZonedHeaderExtension;
+
+typedef struct Qcow2ZoneListEntry {
+    QTAILQ_ENTRY(Qcow2ZoneListEntry) exp_open_zone_entry;
+    QTAILQ_ENTRY(Qcow2ZoneListEntry) imp_open_zone_entry;
+    QTAILQ_ENTRY(Qcow2ZoneListEntry) closed_zone_entry;
+} Qcow2ZoneListEntry;
+
+/*
+ * Per-zone tracking for write pointer (WP) advance. A submitter
+ * reserves an LBA range, performs the data write outside the zone
+ * lock, then waits until the persisted WP catches up to its end
+ * offset before returning success to the guest. A failure aborts
+ * all higher-LBA peers in the same zone.
+ */
+typedef enum Qcow2WPReqState {
+    /* data write submitted, awaiting completion */
+    QCOW2_WP_REQ_INFLIGHT,
+    /* data write completed, persisted WP not yet advanced past lba + len */
+    QCOW2_WP_REQ_PENDING,
+    /* persisted WP covers this range, submitter may ack success */
+    QCOW2_WP_REQ_RESOLVED,
+    /* data write failed, or a lower-LBA peer in the same zone failed */
+    QCOW2_WP_REQ_ABORTED,
+} Qcow2WPReqState;
+
+typedef struct Qcow2WPReq {
+    uint64_t lba;                       /* start offset of the data write */
+    uint64_t len;                       /* length in bytes */
+    Qcow2WPReqState state;
+    /* submitter waits for the data write to reach a terminal state */
+    CoQueue wait;
+    QTAILQ_ENTRY(Qcow2WPReq) entry;
+} Qcow2WPReq;
+
+typedef struct Qcow2ZoneWPState {
+    /* INFLIGHT reqs */
+    QTAILQ_HEAD(, Qcow2WPReq) in_flight;
+    /* PENDING reqs, sorted by lba */
+    QTAILQ_HEAD(, Qcow2WPReq) completed_pending;
+} Qcow2ZoneWPState;
+
 typedef struct Qcow2UnknownHeaderExtension {
     uint32_t magic;
     uint32_t len;
@@ -257,17 +318,20 @@ enum {
     QCOW2_INCOMPAT_DATA_FILE_BITNR  = 2,
     QCOW2_INCOMPAT_COMPRESSION_BITNR = 3,
     QCOW2_INCOMPAT_EXTL2_BITNR      = 4,
+    QCOW2_INCOMPAT_ZONED_FORMAT_BITNR = 5,
     QCOW2_INCOMPAT_DIRTY            = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
     QCOW2_INCOMPAT_CORRUPT          = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
     QCOW2_INCOMPAT_DATA_FILE        = 1 << QCOW2_INCOMPAT_DATA_FILE_BITNR,
     QCOW2_INCOMPAT_COMPRESSION      = 1 << QCOW2_INCOMPAT_COMPRESSION_BITNR,
     QCOW2_INCOMPAT_EXTL2            = 1 << QCOW2_INCOMPAT_EXTL2_BITNR,
+    QCOW2_INCOMPAT_ZONED_FORMAT     = 1 << QCOW2_INCOMPAT_ZONED_FORMAT_BITNR,
 
     QCOW2_INCOMPAT_MASK             = QCOW2_INCOMPAT_DIRTY
                                     | QCOW2_INCOMPAT_CORRUPT
                                     | QCOW2_INCOMPAT_DATA_FILE
                                     | QCOW2_INCOMPAT_COMPRESSION
-                                    | QCOW2_INCOMPAT_EXTL2,
+                                    | QCOW2_INCOMPAT_EXTL2
+                                    | QCOW2_INCOMPAT_ZONED_FORMAT,
 };
 
 /* Compatible feature bits */
@@ -426,6 +490,24 @@ typedef struct BDRVQcow2State {
      * is to convert the image with the desired compression type set.
      */
     Qcow2CompressionType compression_type;
+
+    /* States of zoned device */
+    Qcow2ZonedHeaderExtension zoned_header;
+    QTAILQ_HEAD(, Qcow2ZoneListEntry) exp_open_zones;
+    QTAILQ_HEAD(, Qcow2ZoneListEntry) imp_open_zones;
+    QTAILQ_HEAD(, Qcow2ZoneListEntry) closed_zones;
+    Qcow2ZoneListEntry *zone_list_entries;
+    uint32_t nr_zones_exp_open;
+    uint32_t nr_zones_imp_open;
+    uint32_t nr_zones_closed;
+
+    /* Per-zone in-memory WP tracking for zoned images. */
+    Qcow2ZoneWPState *zone_wp_state;
+    /*
+     * Cache holding the on-disk zonedmeta cluster(s) for zoned image.
+     * WP advances go through this cache.
+     */
+    Qcow2Cache *wp_cache;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/docs/interop/qcow2.rst b/docs/interop/qcow2.rst
index 5948591107..9385f40ee5 100644
--- a/docs/interop/qcow2.rst
+++ b/docs/interop/qcow2.rst
@@ -128,7 +128,26 @@ the next fields through ``header_length``.
                                 allows subcluster-based allocation. See the
                                 Extended L2 Entries section for more details.
 
-                    Bits 5-63:  Reserved (set to 0)
+                    Bit 5:      Zoned extension bit. If this bit is set then
+                                the file is an emulated zoned device. The
+                                zoned extension must be present.
+                                Implementations that do not support zoned
+                                emulation cannot open this file because it
+                                generally only make sense to interpret the
+                                data along with the zone information and
+                                write pointers.
+
+                                It is unsafe when any qcow2 user without
+                                knowing the zoned extension reads or edits
+                                a file with the zoned extension. The write
+                                pointer tracking can be corrupted when a
+                                writer edits a file, like overwriting beyond
+                                the write pointer locations. Or a reader tries
+                                to access a file without knowing write
+                                pointers where the software setup will cause
+                                invalid reads.
+
+                    Bits 6-63:  Reserved (set to 0)
 
          80 -  87:  compatible_features
                     Bitmask of compatible features. An implementation can
@@ -259,6 +278,7 @@ be stored. Each extension has a structure like the following::
                         0x23852875 - Bitmaps extension
                         0x0537be77 - Full disk encryption header pointer
                         0x44415441 - External data file name string
+                        0x007a6264 - Zoned extension
                         other      - Unknown header extension, can be safely
                                      ignored
 
@@ -344,6 +364,99 @@ The fields of the bitmaps extension are::
                    Offset into the image file at which the bitmap directory
                    starts. Must be aligned to a cluster boundary.
 
+Zoned extension
+---------------
+
+The zoned extension must be present if the incompatible_features bit 5 is set,
+and omitted when it is clear. As incompatible_features only exists from version
+3 on, a zoned image is a version 3 image. The extension contains fields for
+emulating the zoned storage model (https://zonedstorage.io/). Currently only
+the host-managed zone model is supported.
+
+The fields of the zoned extension are::
+
+    Byte       0:  zoned
+                   The byte represents the zoned model of the device. 0 is for
+                   a non-zoned device (all other information in this header
+                   is ignored). 1 is for a host-managed device, which only
+                   allows for sequential writes within each zone. Other
+                   values may be added later, the implementation must refuse
+                   to open a device containing an unknown zone model.
+
+          1 -  3:  Reserved, must be zero.
+
+          4 -  7:  nr_zones
+                   The number of zones. It is the sum of conventional zones
+                   and sequential zones. The maximum value for nr_zones is
+                   (2^32 - 1)/8 = 536870911.
+
+          8 - 15:  zone_size
+                   Total size of each zone, in bytes. The 64-bit field is to
+                   satisfy the virtio-blk zone_size range and emulate a read
+                   zoned device, whose maximum zone size can be as large as
+                   2TB.
+
+                   The value must be power of 2. Linux currently requires
+                   the zone size to be a power of 2 number of LBAs. Qcow2
+                   following this is mainly to allow emulating a real
+                   ZNS drive configuration.
+
+                   The value must also be a multiple of the cluster size, so
+                   that each zone consists of whole clusters, which it shares
+                   with no other zone. Resetting a zone can then zero its
+                   clusters without touching the data of other zones.
+
+         16 - 23:  zone_capacity
+                   The number of writable bytes within the zones. The bytes
+                   between zone capacity and zone size are unusable: reads
+                   will return 0s and writes will fail.
+
+                   A zone capacity is always smaller or equal to the zone
+                   size. It is for emulating a real ZNS drive configuration,
+                   which has the constraint of aligning to some hardware erase
+                   block size.
+
+         24 - 31:  zonedmeta_offset
+                   The offset of zoned metadata structure in the contained
+                   image, in bytes.
+
+         32 - 35:  conventional_zones
+                   The number of conventional zones. The conventional zones
+                   allow sequential writes and random writes. While the
+                   sequential zones only allow sequential writes.
+
+         36 - 39:  max_active_zones
+                   The maximum allowed active zones (zones in the implicit
+                   open, explicit open, or closed state). It cannot be larger
+                   than nr_zones.
+
+         40 - 43:  max_open_zones
+                   The maximum allowed open zones (zones in the implicit open
+                   or explicit open state). It cannot be larger than the number
+                   of SWR zones of the device, nor larger than max_active_zones.
+
+                   If the limits of open zones or active zones are equal to
+                   the total number of SWR zones, then it's the same as having
+                   no limits therefore max open zones and max active zones are
+                   set to 0.
+
+The zonedmeta clusters contain a table of the zone write pointers. Each entry
+is a 64-bit value encoding both the zone type and the zone's write pointer::
+
+    Bit   0 - 62:  Write pointer offset, in bytes, indicates the starting
+                   point of the next write position in that zone.
+                   For conventional zones the value is the zone's starting
+                   offset.
+
+              63:  Zone type. 0 = SWR; 1 = conventional.
+
+
+Each zone's write pointer in the zonedmeta area is durable on disk only after
+the data it covers is durable. For a write to a SWR zone, the data is written
+back to disk first, then the non-zoned qcow2 L1/L2/refcount metadata is written,
+and finally the write pointers are written. This ordering ensures that after
+a power failure the on-disk write pointer never leads data being written.
+
 Full disk encryption header pointer
 -----------------------------------
 
diff --git a/hw/block/block.c b/hw/block/block.c
index 3bb8121e9e..5b2e44351e 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -238,6 +238,13 @@ bool blkconf_check_zoned_geometry(BlockConf *conf, Error **errp)
         return false;
     }
 
+    if (!QEMU_IS_ALIGNED(bs->bl.zone_capacity, wg)) {
+        error_setg(errp, "zone capacity %" PRIu64 " is not a multiple of the "
+                   "zone write granularity %" PRIu32,
+                   bs->bl.zone_capacity, wg);
+        return false;
+    }
+
     /*
      * A write pointer that is not a multiple of the write granularity does not
      * fall on a logical block boundary, so the guest can neither read nor write
diff --git a/include/block/block-io.h b/include/block/block-io.h
index f671476f08..deda6cab2b 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -134,6 +134,12 @@ uint32_t bdrv_zone_index(BlockDriverState *bs, uint64_t offset);
  * bdrv_zone_is_full() this does not need the write pointer lock.
  */
 bool bdrv_zone_is_conv(BlockDriverState *bs, uint32_t index);
+/*
+ * The offset at which the writable part of a zone ends. That is a zone
+ * capacity beyond the start of the zone, except for a last zone that the
+ * capacity of the device cuts short.
+ */
+uint64_t bdrv_zone_writable_end(BlockDriverState *bs, uint32_t index);
 /*
  * True when the write pointer of a zone has reached the end of the writable
  * part of that zone, so that nothing more can be written to it until it is
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 0c7746a544..ff9b36d12b 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -57,6 +57,12 @@
 #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
 #define BLOCK_OPT_EXTL2             "extended_l2"
 #define BLOCK_OPT_KEEP_DATA_FILE    "keep_data_file"
+#define BLOCK_OPT_ZONE_MODEL        "zone.mode"
+#define BLOCK_OPT_ZONE_SIZE         "zone.size"
+#define BLOCK_OPT_ZONE_CAPACITY     "zone.capacity"
+#define BLOCK_OPT_CONVENTIONAL_ZONES    "zone.conventional_zones"
+#define BLOCK_OPT_MAX_ACTIVE_ZONES      "zone.max_active_zones"
+#define BLOCK_OPT_MAX_OPEN_ZONES        "zone.max_open_zones"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
@@ -911,6 +917,12 @@ typedef struct BlockLimits {
      */
     uint32_t zone_size_bits;
 
+    /*
+     * The number of usable logical blocks within the zone, expressed
+     * in bytes. A zone capacity is smaller or equal to the zone size.
+     */
+    uint64_t zone_capacity;
+
     /* total number of zones */
     uint32_t nr_zones;
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 741c8165c0..ddec1ae87b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -93,6 +93,9 @@
 #
 # @compression-type: the image cluster compression method (since 5.1)
 #
+# @zone: zoned configuration; only set when the image was created
+#     with a zoned model (since 11.1)
+#
 # Since: 1.7
 ##
 { 'struct': 'ImageInfoSpecificQCow2',
@@ -106,7 +109,8 @@
       'refcount-bits': 'int',
       '*encrypt': 'ImageInfoSpecificQCow2Encryption',
       '*bitmaps': ['Qcow2BitmapInfo'],
-      'compression-type': 'Qcow2CompressionType'
+      'compression-type': 'Qcow2CompressionType',
+      '*zone': 'ImageInfoSpecificQCow2Zoned'
   } }
 
 ##
@@ -5139,6 +5143,80 @@
 { 'enum': 'Qcow2CompressionType',
   'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
 
+##
+# @Qcow2ZoneModel:
+#
+# Zoned device model used in qcow2 image file
+#
+# @host-managed: The host-managed model only allows sequential write
+#     over the device zones.
+#
+# Since: 11.1
+##
+{ 'enum': 'Qcow2ZoneModel',
+  'data': [ 'host-managed'] }
+
+##
+# @Qcow2ZoneHostManaged:
+#
+# The host-managed zone model.  It only allows sequential writes.
+#
+# @size: Total number of bytes within zones (default: 256 MB).
+#
+# @capacity: The usable space within each zone, in bytes.  Always
+#     smaller than or equal to @size (default: same as @size).
+#
+# @conventional-zones: The number of conventional zones of the
+#     zoned device (default: 0).
+#
+# @max-open-zones: The maximal number of open zones.  Must be less
+#     than or equal to the number of non-conventional zones (i.e.
+#     ``size / zone.size - @conventional-zones``), and less than or
+#     equal to @max-active-zones (default: 0, meaning no limit).
+#
+# @max-active-zones: The maximal number of zones in the implicit
+#     open, explicit open or closed state.  It is less than or equal
+#     to the number of zones (default: 0, meaning no limit).
+#
+# Since: 11.1
+##
+{ 'struct': 'Qcow2ZoneHostManaged',
+  'data': { '*size':          'size',
+            '*capacity':      'size',
+            '*conventional-zones': 'uint32',
+            '*max-open-zones':     'uint32',
+            '*max-active-zones':   'uint32' } }
+
+##
+# @Qcow2ZoneCreateOptions:
+#
+# Creation options for zoned qcow2 images.
+#
+# @mode: The zone model used by the image.
+#
+# Since: 11.1
+##
+{ 'union': 'Qcow2ZoneCreateOptions',
+  'base': { 'mode': 'Qcow2ZoneModel' },
+  'discriminator': 'mode',
+  'data': { 'host-managed': 'Qcow2ZoneHostManaged' } }
+
+##
+# @ImageInfoSpecificQCow2Zoned:
+#
+# @mode: The zone model used by the image.
+#
+# @nr-zones: total number of zones in the image, derived at create
+#     time from the size and the zone size.
+#
+# Since: 11.1
+##
+{ 'union': 'ImageInfoSpecificQCow2Zoned',
+  'base': { 'mode':     'Qcow2ZoneModel',
+            'nr-zones': 'uint32' },
+  'discriminator': 'mode',
+  'data': { 'host-managed': 'Qcow2ZoneHostManaged' } }
+
 ##
 # @BlockdevCreateOptionsQcow2:
 #     Driver specific image creation options for qcow2.
@@ -5180,6 +5258,9 @@
 # @compression-type: The image cluster compression method
 #     (default: zlib, since 5.1)
 #
+# @zone: Options for zoned images.  If absent, the device is not
+#     zoned.  (since 11.1)
+#
 # Since: 2.12
 ##
 { 'struct': 'BlockdevCreateOptionsQcow2',
@@ -5196,7 +5277,8 @@
             '*preallocation':   'PreallocMode',
             '*lazy-refcounts':  'bool',
             '*refcount-bits':   'int',
-            '*compression-type':'Qcow2CompressionType' } }
+            '*compression-type':'Qcow2CompressionType',
+            '*zone':            'Qcow2ZoneCreateOptions' } }
 
 ##
 # @BlockdevCreateOptionsQed:
diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
index 0054c2ed97..02a68b34f7 100644
--- a/tests/qemu-iotests/031.out
+++ b/tests/qemu-iotests/031.out
@@ -117,7 +117,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 Header extension:
@@ -150,7 +150,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 Header extension:
@@ -164,7 +164,7 @@ No errors were found on the image.
 
 magic                     0x514649fb
 version                   3
-backing_file_offset       0x240
+backing_file_offset       0x270
 backing_file_size         0x17
 cluster_bits              16
 size                      67108864
@@ -188,7 +188,7 @@ data                      'host_device'
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 Header extension:
diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
index 1fa7cad28d..3ee310bb61 100644
--- a/tests/qemu-iotests/036.out
+++ b/tests/qemu-iotests/036.out
@@ -26,7 +26,7 @@ compatible_features       []
 autoclear_features        [63]
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 
@@ -38,7 +38,7 @@ compatible_features       []
 autoclear_features        []
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 *** done
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 951c6bf3e6..08bc08dd25 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -26,7 +26,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 magic                     0x514649fb
@@ -84,7 +84,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 magic                     0x514649fb
@@ -140,7 +140,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 ERROR cluster 5 refcount=0 reference=1
@@ -195,7 +195,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 magic                     0x514649fb
@@ -264,7 +264,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 read 65536/65536 bytes at offset 44040192
@@ -326,7 +326,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 ERROR cluster 5 refcount=0 reference=1
@@ -355,7 +355,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 read 131072/131072 bytes at offset 0
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index e0463815c6..deff62bc55 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -72,6 +72,12 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: create -f qcow2 -o ? TEST_DIR/t.qcow2 128M
 Supported options:
@@ -99,6 +105,12 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: create -f qcow2 -o cluster_size=4k,help TEST_DIR/t.qcow2 128M
 Supported options:
@@ -126,6 +138,12 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: create -f qcow2 -o cluster_size=4k,? TEST_DIR/t.qcow2 128M
 Supported options:
@@ -153,6 +171,12 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: create -f qcow2 -o help,cluster_size=4k TEST_DIR/t.qcow2 128M
 Supported options:
@@ -180,6 +204,12 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: create -f qcow2 -o ?,cluster_size=4k TEST_DIR/t.qcow2 128M
 Supported options:
@@ -207,6 +237,12 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: create -f qcow2 -o cluster_size=4k -o help TEST_DIR/t.qcow2 128M
 Supported options:
@@ -234,6 +270,12 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: create -f qcow2 -o cluster_size=4k -o ? TEST_DIR/t.qcow2 128M
 Supported options:
@@ -261,6 +303,12 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,help -F qcow2 TEST_DIR/t.qcow2 128M
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/t.qcow2,,help backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
@@ -301,6 +349,12 @@ Supported qcow2 options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 The protocol level may support further options.
 Specify the target filename to include those options.
@@ -391,6 +445,12 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: convert -O qcow2 -o ? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
@@ -418,6 +478,12 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: convert -O qcow2 -o cluster_size=4k,help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
@@ -445,6 +511,12 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: convert -O qcow2 -o cluster_size=4k,? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
@@ -472,6 +544,12 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: convert -O qcow2 -o help,cluster_size=4k TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
@@ -499,6 +577,12 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: convert -O qcow2 -o ?,cluster_size=4k TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
@@ -526,6 +610,12 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: convert -O qcow2 -o cluster_size=4k -o help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
@@ -553,6 +643,12 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: convert -O qcow2 -o cluster_size=4k -o ? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
@@ -580,6 +676,12 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: convert -O qcow2 -o backing_fmt=qcow2,backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 qemu-img: Could not open 'TEST_DIR/t.qcow2.base': Could not open backing file: Could not open 'TEST_DIR/t.qcow2,help': No such file or directory
@@ -620,6 +722,12 @@ Supported qcow2 options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 The protocol level may support further options.
 Specify the target filename to include those options.
diff --git a/tests/qemu-iotests/303.out b/tests/qemu-iotests/303.out
index b3c70827b7..684a481cae 100644
--- a/tests/qemu-iotests/303.out
+++ b/tests/qemu-iotests/303.out
@@ -47,7 +47,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 Header extension:
@@ -133,7 +133,7 @@ wrote 1048576/1048576 bytes at offset 7340032
     {
         "name": "Feature table",
         "magic": 1745090647,
-        "length": 384,
+        "length": 432,
         "data_str": "<binary>"
     },
     {
diff --git a/tests/qemu-iotests/tests/qcow2-encryption.out b/tests/qemu-iotests/tests/qcow2-encryption.out
index 9b549dc2ab..8be3e57f6e 100644
--- a/tests/qemu-iotests/tests/qcow2-encryption.out
+++ b/tests/qemu-iotests/tests/qcow2-encryption.out
@@ -10,7 +10,7 @@ data                      <binary>
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 image: TEST_DIR/t.IMGFMT
@@ -24,7 +24,7 @@ No errors were found on the image.
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Missing CRYPTO header for crypt method 2
-- 
2.56.0


