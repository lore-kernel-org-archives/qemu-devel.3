Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB2BCCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeKI-0003aC-GE; Fri, 16 Oct 2026 05:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xHeK3-0003La-NQ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:33:58 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xHeJv-000651-Sh
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:33:52 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20261016093345epoutp03ac276d156c3b348504cc017d227b0aab~e_MSf7hWc0405904059epoutp03g
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:33:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20261016093345epoutp03ac276d156c3b348504cc017d227b0aab~e_MSf7hWc0405904059epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1792143225;
 bh=uuKZFG5+SAXuan4THhft6FFoR+I0YHS3AY9QdyHKQe8=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=jke5mrXY7OG89rbwFEnmjM88HYIfHjLtsasY95vbMhQ5r5B894n3bMhEA4j/TWDcQ
 oSBVzUYof8SyD3wQco4dtRdpNmAY1+8HjQZa8D6lt71gofC91Tzg7RX+xuBnu0Km3v
 QIFZdKgvKZvDxU+ObUSEqDwJG378GC+3WO5GgAxE=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
 20261016093344epcas2p3dbaedc4546d17dbbe3a4144e2ba82cee~e_MRoqZDt1849818498epcas2p39;
 Fri, 16 Oct 2026 09:33:44 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.212]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4j5frl62DPz2SSKX; Fri, 16 Oct
 2026 09:33:43 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH v2 5/6] hw/ufs: Support for Zoned UFS
From: Daejun Park <daejun7.park@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p8>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261016093343epcms2p8d5801bd57384c44d5120ae0b7c4eb206@epcms2p8>
Date: Fri, 16 Oct 2026 18:33:43 +0900
X-CMS-MailID: 20261016093343epcms2p8d5801bd57384c44d5120ae0b7c4eb206
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306
References: <20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p8>
 <CGME20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p8>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=daejun7.park@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: daejun7.park@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a "zoned" property to ufs-lu. A zoned logical unit is a host-managed
zoned block device made of sequential write required zones, with the
zone size and the maximum number of open zones set by zoned.zone_size
and zoned.max_open. max_open defaults to 6 because f2fs refuses a zoned
device with fewer open zones than its active logs, 6 by default.

The logical unit keeps the condition and the write pointer of each zone
in memory and emulates REPORT ZONES and the OPEN, CLOSE, FINISH and
RESET WRITE POINTER zone operations, with or without the ALL bit. Every
WRITE, WRITE AND VERIFY and WRITE SAME of at least one block that lies
within the capacity is checked against its zone before it reaches
scsi-hd: a write crossing the end of the zone fails with WRITE BOUNDARY
VIOLATION, a write to a full zone with INVALID FIELD IN CDB, and a write
that does not start at the write pointer with UNALIGNED WRITE COMMAND.
When max_open zones are open, a write to another zone closes an
implicitly open zone, and fails with INSUFFICIENT ZONE RESOURCES only if
all open zones were opened explicitly. The zone checks, the open zone
accounting and the sense codes follow the ZBC emulation of Linux
scsi_debug; unlike it, a ZONE COUNT above 1 is rejected and RESET WRITE
POINTER does not zero the zone.

The write pointer moves when a write is submitted, so that queued writes
to one zone pass the check in submission order: with MCQ, the Android
common kernel queues several writes to a zone on one submission queue
(BLK_FEAT_ORDERED_HWQ). It moves back if scsi-hd fails or drops that
write, unless the zone changed since, for example because a later write
to it was accepted. A pending unit attention is reported before any zone
command or zone check, as scsi-hd reports it before most commands,
INQUIRY and REPORT LUNS excepted.

UNMAP fails with INVALID COMMAND OPERATION CODE, since deallocation
would bypass the write pointers: READ CAPACITY(16) reports no logical
block provisioning, and the Block Limits and Logical Block Provisioning
VPD pages do not advertise UNMAP. Reads and the remaining commands go to
scsi-hd. Reads above the write pointer are not restricted and return
what the drive holds, also after RESET WRITE POINTER.

The wrapped scsi-hd stays a direct-access (TYPE_DISK) device. INQUIRY
data of a zoned logical unit reaches the guest through a transfer_data
callback, which sets the peripheral device type to TYPE_ZBC and adds the
ZBC device characteristics page (B6h) to the list of supported VPD
pages. The logical unit emulates that page, reporting unrestricted reads
(URSWRZ), which Linux requires for host-managed devices, and the maximum
number of open zones.

Setting the scsi-hd device type to TYPE_ZBC instead takes the rest of
the command set off the disk path. scsi-disk serves mode pages for
TYPE_DISK and TYPE_ROM only, so MODE SENSE fails, the guest assumes a
write-through cache and never sends SYNCHRONIZE CACHE or FUA writes.
With a Linux 7.3-rc7 guest, a zoned logical unit built that way logged
"Assuming drive cache: write through" and no flush reached QEMU on
fsync. With this patch the guest logs "Write cache: enabled, read cache:
enabled, supports DPO and FUA" and the flush arrives.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 hw/ufs/lu.c         | 829 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/ufs/trace-events |   6 +
 hw/ufs/ufs.h        |  36 +++
 include/block/ufs.h |  27 ++
 4 files changed, 893 insertions(+), 5 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index bebe4eaac2..19bab236a2 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -20,6 +20,9 @@
 #include "ufs.h"
 
 #define SCSI_COMMAND_FAIL (-1)
+#define REPORT_ZONES_HEADER_SIZE 64
+#define REPORT_ZONES_DESC_SIZE 64
+#define ZBC_VPD_B6_LEN 64
 
 static void ufs_build_upiu_sense_data(UfsRequest *req, uint8_t *sense,
                                       uint32_t sense_len)
@@ -58,6 +61,249 @@ static void ufs_build_scsi_response_upiu(UfsRequest *req, uint8_t *sense,
                           status, data_segment_length);
 }
 
+static inline uint32_t ufs_zone_idx(UfsLu *lu, uint64_t lba)
+{
+    return lba / lu->zone_info.zone_size;
+}
+
+static inline UfsZoneState *ufs_get_zone_by_lba(UfsLu *lu, uint64_t lba)
+{
+    if (lba >= be64_to_cpu(lu->unit_desc.logical_block_count)) {
+        return NULL;
+    }
+
+    return &lu->zone_array[ufs_zone_idx(lu, lba)];
+}
+
+/* The last zone may be smaller than the zone size */
+static inline uint64_t ufs_zone_end(UfsZoneState *zone)
+{
+    return zone->start + zone->size;
+}
+
+static void ufs_assign_zone_cond(UfsLu *lu, UfsZoneState *zone,
+                                 UfsZoneCond new_cond)
+{
+    switch (zone->cond) {
+    case UFS_ZONE_COND_IMPLICIT_OPEN:
+    case UFS_ZONE_COND_EXPLICIT_OPEN:
+        lu->zone_info.nr_open--;
+        break;
+    default:
+        break;
+    }
+
+    zone->cond = new_cond;
+    zone->seq++;
+
+    switch (new_cond) {
+    case UFS_ZONE_COND_EMPTY:
+        zone->wp = zone->start;
+        break;
+    case UFS_ZONE_COND_IMPLICIT_OPEN:
+    case UFS_ZONE_COND_EXPLICIT_OPEN:
+        lu->zone_info.nr_open++;
+        break;
+    case UFS_ZONE_COND_FULL:
+        zone->wp = ufs_zone_end(zone);
+        break;
+    default:
+        break;
+    }
+}
+
+/* Close one implicitly open zone; false if there is none */
+static bool ufs_close_implicit_open_zone(UfsLu *lu)
+{
+    uint32_t i;
+
+    for (i = 0; i < lu->zone_info.nr_zones; i++) {
+        UfsZoneState *zone = &lu->zone_array[i];
+
+        if (zone->cond == UFS_ZONE_COND_IMPLICIT_OPEN) {
+            uint64_t seq = zone->seq;
+
+            /*
+             * Closing moves no write pointer: keep seq, so that a write in
+             * flight to this zone can still be undone.
+             */
+            ufs_assign_zone_cond(lu, zone, UFS_ZONE_COND_CLOSED);
+            zone->seq = seq;
+            return true;
+        }
+    }
+
+    return false;
+}
+
+/*
+ * Open an empty or closed zone. When all open zone resources are in use, an
+ * implicitly open zone is closed to make room; if every open zone was opened
+ * explicitly, the zone cannot be opened. A max_open of 0 means no limit.
+ */
+static bool ufs_open_zone(UfsLu *lu, UfsZoneState *zone, UfsZoneCond open_cond)
+{
+    switch (zone->cond) {
+    case UFS_ZONE_COND_EMPTY:
+    case UFS_ZONE_COND_CLOSED:
+        if (lu->zone_info.max_open &&
+            lu->zone_info.nr_open >= lu->zone_info.max_open &&
+            !ufs_close_implicit_open_zone(lu)) {
+            return false;
+        }
+        ufs_assign_zone_cond(lu, zone, open_cond);
+        return true;
+    case UFS_ZONE_COND_IMPLICIT_OPEN:
+        if (open_cond == UFS_ZONE_COND_EXPLICIT_OPEN) {
+            ufs_assign_zone_cond(lu, zone, UFS_ZONE_COND_EXPLICIT_OPEN);
+        }
+        return true;
+    default:
+        /* Explicitly open and full zones stay as they are */
+        return true;
+    }
+}
+
+static void ufs_close_zone(UfsLu *lu, UfsZoneState *zone)
+{
+    if (zone->cond == UFS_ZONE_COND_IMPLICIT_OPEN ||
+        zone->cond == UFS_ZONE_COND_EXPLICIT_OPEN) {
+        ufs_assign_zone_cond(lu, zone, zone->wp == zone->start ?
+                                       UFS_ZONE_COND_EMPTY :
+                                       UFS_ZONE_COND_CLOSED);
+    }
+}
+
+static void ufs_finish_zone(UfsLu *lu, UfsZoneState *zone, bool all)
+{
+    switch (zone->cond) {
+    case UFS_ZONE_COND_EMPTY:
+        /* FINISH ZONE with the ALL bit leaves empty zones alone */
+        if (all) {
+            break;
+        }
+        /* fallthrough */
+    case UFS_ZONE_COND_IMPLICIT_OPEN:
+    case UFS_ZONE_COND_EXPLICIT_OPEN:
+    case UFS_ZONE_COND_CLOSED:
+        ufs_assign_zone_cond(lu, zone, UFS_ZONE_COND_FULL);
+        break;
+    case UFS_ZONE_COND_FULL:
+        /* An in-flight write that filled the zone must not undo this */
+        zone->seq++;
+        break;
+    default:
+        break;
+    }
+}
+
+static void ufs_reset_write_pointer_zone(UfsLu *lu, UfsZoneState *zone)
+{
+    switch (zone->cond) {
+    case UFS_ZONE_COND_IMPLICIT_OPEN:
+    case UFS_ZONE_COND_EXPLICIT_OPEN:
+    case UFS_ZONE_COND_CLOSED:
+    case UFS_ZONE_COND_FULL:
+        ufs_assign_zone_cond(lu, zone, UFS_ZONE_COND_EMPTY);
+        break;
+    default:
+        break;
+    }
+}
+
+/*
+ * The write pointer moves when a write is accepted, so that queued writes to
+ * one zone pass the check in submission order. If scsi-hd then fails or
+ * drops the write (an aborted or purged request, an I/O error), move the
+ * write pointer back, unless the zone changed since: a later write was
+ * accepted, or a zone operation changed it.
+ */
+static void ufs_zbc_write_undo(UfsLu *lu, UfsRequest *req)
+{
+    UfsZoneState *zone = req->zone;
+
+    req->zone = NULL;
+    if (!zone || zone->seq != req->zone_seq) {
+        return;
+    }
+
+    trace_ufs_zbc_write_undone(lu->lun, zone->start, req->zone_wp_before);
+
+    if (zone->cond == UFS_ZONE_COND_FULL) {
+        /*
+         * The write filled the zone, which gave up its open resource, and
+         * another zone may hold it by now. So the zone comes back closed or
+         * empty, also if it was open explicitly before the write, or if an
+         * OPEN ZONE found it full in the meantime.
+         */
+        ufs_assign_zone_cond(lu, zone, req->zone_wp_before == zone->start ?
+                                       UFS_ZONE_COND_EMPTY :
+                                       UFS_ZONE_COND_CLOSED);
+    } else if (req->zone_wp_before == zone->start &&
+               req->zone_cond_before != UFS_ZONE_COND_EXPLICIT_OPEN) {
+        /* The write opened the zone implicitly */
+        ufs_assign_zone_cond(lu, zone, UFS_ZONE_COND_EMPTY);
+    }
+    zone->wp = req->zone_wp_before;
+    zone->seq++;
+}
+
+/*
+ * The wrapped scsi-hd is a direct-access (TYPE_DISK) device, so every
+ * command that a zoned LU forwards to it, including MODE SENSE, takes the
+ * regular disk path. Only the identification differs: a zoned LU reports
+ * itself as a host-managed zoned block device. Set the peripheral device
+ * type of the INQUIRY data that scsi-hd built to TYPE_ZBC, and add the ZBC
+ * device characteristics VPD page (emulated in ufs_emulate_zbc_cmd()) to the
+ * list of supported VPD pages. Since UNMAP is rejected, also hide it in the
+ * Block Limits and Logical Block Provisioning VPD pages. scsi-hd pads its
+ * data with zeros up to the allocation length, and len is never larger
+ * than that.
+ */
+static void ufs_zoned_fixup_inquiry(const uint8_t *cdb, uint8_t *buf,
+                                    uint32_t len)
+{
+    uint8_t page_len;
+
+    if (len == 0) {
+        return;
+    }
+
+    buf[0] = TYPE_ZBC;
+
+    if (!(cdb[1] & 0x1) || len < 4) {
+        return;
+    }
+
+    /* UNMAP is rejected, see ufs_emulate_zbc_cmd() */
+    if (cdb[2] == 0xb0) {
+        /* Block Limits: maximum UNMAP LBA and block descriptor counts */
+        if (len > 20) {
+            memset(&buf[20], 0, MIN(len, 28) - 20);
+        }
+        return;
+    }
+    if (cdb[2] == 0xb2) {
+        /* Logical Block Provisioning: clear LBPU */
+        if (len > 5) {
+            buf[5] &= ~0x80;
+        }
+        return;
+    }
+    if (cdb[2] != 0x00) {
+        return;
+    }
+
+    /* Supported VPD pages, in ascending order: 0xb6 goes last */
+    page_len = buf[3];
+    if (page_len < 255 && !memchr(&buf[4], 0xb6, MIN(page_len, len - 4))) {
+        buf[3] = page_len + 1;
+        if (4 + page_len < len) {
+            buf[4 + page_len] = 0xb6;
+        }
+    }
+}
+
 #define UFS_GROUP_NUMBER_MASK 0x1F
 #define UFS_WB_GROUP_NUMBER_DEFAULT 0x00 /* 00000b */
 #define UFS_WB_GROUP_NUMBER_PINNED 0x18 /* 11000b */
@@ -170,6 +416,7 @@ static void ufs_hid_count_fragments(UfsRequest *req)
 static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
 {
     UfsRequest *req = scsi_req->hba_private;
+    UfsLu *lu = container_of(scsi_req->bus, UfsLu, bus);
     int16_t status = scsi_req->status;
     uint32_t transfered_len = scsi_req->cmd.xfer - resid;
 
@@ -180,6 +427,9 @@ static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
     if (status == GOOD) {
         ufs_wb_process_write_req(req, transfered_len);
         ufs_hid_count_fragments(req);
+        req->zone = NULL;
+    } else {
+        ufs_zbc_write_undo(lu, req);
     }
 
     ufs_build_scsi_response_upiu(req, scsi_req->sense, scsi_req->sense_len,
@@ -196,6 +446,7 @@ static void ufs_scsi_command_cancelled(SCSIRequest *scsi_req)
     UfsRequest *req = scsi_req->hba_private;
 
     assert(req != NULL);
+    ufs_zbc_write_undo(container_of(scsi_req->bus, UfsLu, bus), req);
     req->sreq = NULL;
     scsi_req->hba_private = NULL;
     scsi_req_unref(scsi_req);
@@ -204,9 +455,29 @@ static void ufs_scsi_command_cancelled(SCSIRequest *scsi_req)
 static QEMUSGList *ufs_get_sg_list(SCSIRequest *scsi_req)
 {
     UfsRequest *req = scsi_req->hba_private;
+    UfsLu *lu = container_of(scsi_req->bus, UfsLu, bus);
+
+    /* INQUIRY data of a zoned LU goes through ufs_scsi_transfer_data() */
+    if (lu->zone_enabled && scsi_req->cmd.buf[0] == INQUIRY) {
+        return NULL;
+    }
+
     return req->sg;
 }
 
+static void ufs_scsi_transfer_data(SCSIRequest *scsi_req, uint32_t len)
+{
+    UfsRequest *req = scsi_req->hba_private;
+    uint8_t *buf = scsi_req_get_buf(scsi_req);
+
+    /* Only INQUIRY of a zoned LU has no SG list, see ufs_get_sg_list() */
+    assert(scsi_req->cmd.buf[0] == INQUIRY && req->sg);
+
+    ufs_zoned_fixup_inquiry(scsi_req->cmd.buf, buf, len);
+    dma_buf_read(buf, len, NULL, req->sg, MEMTXATTRS_UNSPECIFIED);
+    scsi_req_continue(scsi_req);
+}
+
 static const struct SCSIBusInfo ufs_scsi_info = {
     .tcq = true,
     .max_target = 0,
@@ -214,6 +485,7 @@ static const struct SCSIBusInfo ufs_scsi_info = {
     .max_channel = 0,
 
     .get_sg_list = ufs_get_sg_list,
+    .transfer_data = ufs_scsi_transfer_data,
     .complete = ufs_scsi_command_complete,
     .cancel = ufs_scsi_command_cancelled,
 };
@@ -322,6 +594,453 @@ static int ufs_emulate_wlun_inquiry(UfsRequest *req, uint8_t *outbuf,
     return SCSI_INQUIRY_LEN;
 }
 
+/* ZBC device characteristics VPD page */
+static int ufs_emulate_zbc_vpd_page(UfsLu *lu, uint8_t *outbuf)
+{
+    memset(outbuf, 0, ZBC_VPD_B6_LEN);
+    outbuf[0] = TYPE_ZBC;
+    outbuf[1] = 0xb6;
+    stw_be_p(&outbuf[2], ZBC_VPD_B6_LEN - 4);
+
+    /* URSWRZ: reads are not restricted by the write pointer */
+    outbuf[4] = 0x01;
+    /* optimal number of open sequential write preferred zones */
+    stl_be_p(&outbuf[8], 0xffffffff);
+    /* optimal number of non-seq. written seq. write preferred zones */
+    stl_be_p(&outbuf[12], 0xffffffff);
+    /* maximum number of open sequential write required zones */
+    stl_be_p(&outbuf[16],
+             lu->zone_info.max_open ? lu->zone_info.max_open : 0xffffffff);
+    /* zone alignment method 0 and starting LBA granularity 0: zone length */
+
+    return ZBC_VPD_B6_LEN;
+}
+
+/* ZBC additional sense codes */
+static const struct SCSISense sense_code_UNALIGNED_WRITE = {
+    .key = ILLEGAL_REQUEST, .asc = 0x21, .ascq = 0x04
+};
+
+static const struct SCSISense sense_code_WRITE_BOUNDARY_VIOLATION = {
+    .key = ILLEGAL_REQUEST, .asc = 0x21, .ascq = 0x05
+};
+
+static const struct SCSISense sense_code_INSUFFICIENT_ZONE_RESOURCES = {
+    .key = DATA_PROTECT, .asc = 0x55, .ascq = 0x0e
+};
+
+static const struct SCSISense sense_code_INSUFFICIENT_RESOURCES = {
+    .key = ILLEGAL_REQUEST, .asc = 0x55, .ascq = 0x03
+};
+
+/* REPORT ZONES reporting options */
+static bool ufs_zbc_report_option_valid(uint8_t rep_opts)
+{
+    switch (rep_opts) {
+    case 0x00 ... 0x07:
+    case 0x10:
+    case 0x11:
+    case 0x3e:
+    case 0x3f:
+        return true;
+    default:
+        return false;
+    }
+}
+
+static bool ufs_zbc_report_option_match(UfsZoneState *zone, uint8_t rep_opts)
+{
+    switch (rep_opts) {
+    case 0x00: /* all zones */
+    case 0x3e: /* all zones except gap zones */
+        return true;
+    case 0x01:
+        return zone->cond == UFS_ZONE_COND_EMPTY;
+    case 0x02:
+        return zone->cond == UFS_ZONE_COND_IMPLICIT_OPEN;
+    case 0x03:
+        return zone->cond == UFS_ZONE_COND_EXPLICIT_OPEN;
+    case 0x04:
+        return zone->cond == UFS_ZONE_COND_CLOSED;
+    case 0x05:
+        return zone->cond == UFS_ZONE_COND_FULL;
+    default:
+        /*
+         * Read-only, offline, reset write pointer recommended, non-sequential
+         * write resources active and not write pointer zones: none exist.
+         */
+        return false;
+    }
+}
+
+/*
+ * outbuf holds at least the header and at most what the guest can take: the
+ * smaller of the allocation length and its data buffer.
+ */
+static bool ufs_zbc_report_zones(UfsLu *lu, UfsRequest *req, uint8_t *outbuf,
+                                 uint32_t outbuf_len, uint32_t *len,
+                                 SCSISense *sense)
+{
+    uint8_t *cdb = req->req_upiu.sc.cdb;
+    uint64_t nr_blocks = be64_to_cpu(lu->unit_desc.logical_block_count);
+    uint64_t zone_start_lba = ldq_be_p(&cdb[2]);
+    uint32_t alloc_len = ldl_be_p(&cdb[10]);
+    uint8_t rep_opts = cdb[14] & 0x3f;
+    bool partial = cdb[14] & 0x80;
+    uint32_t limit, max_descs, nr_descs = 0;
+    uint32_t offset = REPORT_ZONES_HEADER_SIZE;
+    uint32_t i;
+
+    trace_ufs_zbc_report_zones(lu->lun, zone_start_lba, alloc_len, rep_opts);
+
+    *len = 0;
+
+    if ((cdb[1] & 0x1f) != UFS_ZBC_REPORT_ZONES ||
+        !ufs_zbc_report_option_valid(rep_opts)) {
+        *sense = SENSE_CODE(INVALID_FIELD);
+        return false;
+    }
+
+    if (zone_start_lba >= nr_blocks) {
+        *sense = SENSE_CODE(LBA_OUT_OF_RANGE);
+        return false;
+    }
+
+    if (alloc_len == 0) {
+        return true;
+    }
+
+    assert(outbuf_len >= REPORT_ZONES_HEADER_SIZE);
+    limit = MIN(alloc_len, outbuf_len);
+    max_descs = limit > REPORT_ZONES_HEADER_SIZE ?
+                (limit - REPORT_ZONES_HEADER_SIZE) / REPORT_ZONES_DESC_SIZE :
+                0;
+
+    for (i = ufs_zone_idx(lu, zone_start_lba); i < lu->zone_info.nr_zones;
+         i++) {
+        UfsZoneState *zone = &lu->zone_array[i];
+
+        if (!ufs_zbc_report_option_match(zone, rep_opts)) {
+            continue;
+        }
+
+        if (nr_descs < max_descs) {
+            outbuf[offset] = zone->type;
+            outbuf[offset + 1] = zone->cond << 4;
+            stq_be_p(&outbuf[offset + 8], zone->size);
+            stq_be_p(&outbuf[offset + 16], zone->start);
+            stq_be_p(&outbuf[offset + 24], zone->wp);
+            offset += REPORT_ZONES_DESC_SIZE;
+        } else if (partial) {
+            break;
+        }
+
+        nr_descs++;
+    }
+
+    /* Zone list length and maximum LBA */
+    stl_be_p(&outbuf[0], nr_descs * REPORT_ZONES_DESC_SIZE);
+    stq_be_p(&outbuf[8], nr_blocks - 1);
+
+    *len = MIN(offset, limit);
+    return true;
+}
+
+/*
+ * OPEN ZONE with the ALL bit opens every closed zone, closing implicitly open
+ * zones as needed. It fails without changing anything if the closed and the
+ * explicitly open zones together exceed the open zone limit.
+ */
+static bool ufs_open_all_zones(UfsLu *lu)
+{
+    uint32_t i, nr_explicit = 0, nr_closed = 0;
+
+    for (i = 0; i < lu->zone_info.nr_zones; i++) {
+        nr_explicit += lu->zone_array[i].cond == UFS_ZONE_COND_EXPLICIT_OPEN;
+        nr_closed += lu->zone_array[i].cond == UFS_ZONE_COND_CLOSED;
+    }
+
+    if (lu->zone_info.max_open &&
+        nr_explicit + nr_closed > lu->zone_info.max_open) {
+        return false;
+    }
+
+    for (i = 0; i < lu->zone_info.nr_zones; i++) {
+        if (lu->zone_array[i].cond == UFS_ZONE_COND_CLOSED) {
+            ufs_assign_zone_cond(lu, &lu->zone_array[i],
+                                 UFS_ZONE_COND_EXPLICIT_OPEN);
+        }
+    }
+
+    while (lu->zone_info.max_open &&
+           lu->zone_info.nr_open > lu->zone_info.max_open) {
+        if (!ufs_close_implicit_open_zone(lu)) {
+            break;
+        }
+    }
+
+    return true;
+}
+
+static int ufs_zbc_zone_op(UfsLu *lu, UfsRequest *req, SCSISense *sense)
+{
+    uint8_t *cdb = req->req_upiu.sc.cdb;
+    uint8_t action = cdb[1] & 0x1f;
+    uint64_t zone_id = ldq_be_p(&cdb[2]);
+    uint16_t zone_count = lduw_be_p(&cdb[12]);
+    bool all = cdb[14] & 0x01;
+    UfsZoneState *zone;
+    uint32_t i;
+
+    trace_ufs_zbc_zone_op(lu->lun, action, zone_id, all);
+
+    switch (action) {
+    case UFS_ZBC_CLOSE_ZONE:
+    case UFS_ZBC_FINISH_ZONE:
+    case UFS_ZBC_OPEN_ZONE:
+    case UFS_ZBC_RESET_WRITE_POINTER:
+        break;
+    default:
+        *sense = SENSE_CODE(INVALID_FIELD);
+        return SCSI_COMMAND_FAIL;
+    }
+
+    if (all) {
+        if (action == UFS_ZBC_OPEN_ZONE) {
+            if (!ufs_open_all_zones(lu)) {
+                *sense = SENSE_CODE(INSUFFICIENT_ZONE_RESOURCES);
+                return SCSI_COMMAND_FAIL;
+            }
+            return 0;
+        }
+
+        for (i = 0; i < lu->zone_info.nr_zones; i++) {
+            zone = &lu->zone_array[i];
+            if (action == UFS_ZBC_CLOSE_ZONE) {
+                ufs_close_zone(lu, zone);
+            } else if (action == UFS_ZBC_FINISH_ZONE) {
+                ufs_finish_zone(lu, zone, true);
+            } else {
+                ufs_reset_write_pointer_zone(lu, zone);
+            }
+        }
+        return 0;
+    }
+
+    /* Operations on a range of zones are not supported */
+    if (zone_count > 1) {
+        *sense = SENSE_CODE(INVALID_FIELD);
+        return SCSI_COMMAND_FAIL;
+    }
+
+    zone = ufs_get_zone_by_lba(lu, zone_id);
+    if (!zone) {
+        *sense = SENSE_CODE(LBA_OUT_OF_RANGE);
+        return SCSI_COMMAND_FAIL;
+    }
+
+    if (zone_id != zone->start) {
+        *sense = SENSE_CODE(INVALID_FIELD);
+        return SCSI_COMMAND_FAIL;
+    }
+
+    switch (action) {
+    case UFS_ZBC_CLOSE_ZONE:
+        ufs_close_zone(lu, zone);
+        break;
+    case UFS_ZBC_FINISH_ZONE:
+        ufs_finish_zone(lu, zone, false);
+        break;
+    case UFS_ZBC_OPEN_ZONE:
+        if (!ufs_open_zone(lu, zone, UFS_ZONE_COND_EXPLICIT_OPEN)) {
+            *sense = SENSE_CODE(INSUFFICIENT_ZONE_RESOURCES);
+            return SCSI_COMMAND_FAIL;
+        }
+        break;
+    case UFS_ZBC_RESET_WRITE_POINTER:
+        ufs_reset_write_pointer_zone(lu, zone);
+        break;
+    }
+
+    return 0;
+}
+
+/* LBA and number of blocks of a command that writes the medium */
+static bool ufs_zbc_write_range(const uint8_t *cdb, uint64_t *lba,
+                                uint32_t *nr_blocks)
+{
+    switch (cdb[0]) {
+    case WRITE_6:
+        *lba = ldl_be_p(&cdb[0]) & 0x1fffff;
+        *nr_blocks = cdb[4] ? cdb[4] : 256;
+        return true;
+    case WRITE_10:
+    case WRITE_VERIFY_10:
+    case WRITE_SAME_10:
+        *lba = (uint32_t)ldl_be_p(&cdb[2]);
+        *nr_blocks = lduw_be_p(&cdb[7]);
+        return true;
+    case WRITE_12:
+    case WRITE_VERIFY_12:
+        *lba = (uint32_t)ldl_be_p(&cdb[2]);
+        *nr_blocks = ldl_be_p(&cdb[6]);
+        return true;
+    case WRITE_16:
+    case WRITE_VERIFY_16:
+    case WRITE_SAME_16:
+        *lba = ldq_be_p(&cdb[2]);
+        *nr_blocks = ldl_be_p(&cdb[10]);
+        return true;
+    default:
+        return false;
+    }
+}
+
+/*
+ * Check a write against the zone it targets and, if it may proceed, move the
+ * write pointer, remembering enough in req to undo that if scsi-hd does not
+ * complete the write. A write that reaches beyond the capacity or has no
+ * blocks goes to scsi-hd unchecked: scsi-hd fails the former and a
+ * zero-length WRITE SAME, and completes other zero-length writes without
+ * writing anything.
+ */
+static bool ufs_zbc_check_write(UfsLu *lu, UfsRequest *req, SCSISense *sense)
+{
+    const uint8_t *cdb = req->req_upiu.sc.cdb;
+    uint64_t nr_blocks = be64_to_cpu(lu->unit_desc.logical_block_count);
+    uint64_t lba;
+    uint32_t len;
+    UfsZoneState *zone;
+
+    if (!ufs_zbc_write_range(cdb, &lba, &len)) {
+        return true;
+    }
+
+    if (len == 0 || lba >= nr_blocks || len > nr_blocks - lba) {
+        return true;
+    }
+
+    zone = ufs_get_zone_by_lba(lu, lba);
+
+    if (lba + len > ufs_zone_end(zone)) {
+        *sense = SENSE_CODE(WRITE_BOUNDARY_VIOLATION);
+    } else if (zone->cond == UFS_ZONE_COND_FULL) {
+        *sense = SENSE_CODE(INVALID_FIELD);
+    } else if (lba != zone->wp) {
+        *sense = SENSE_CODE(UNALIGNED_WRITE);
+    } else {
+        req->zone_cond_before = zone->cond;
+        req->zone_wp_before = zone->wp;
+
+        if (ufs_open_zone(lu, zone, UFS_ZONE_COND_IMPLICIT_OPEN)) {
+            zone->wp += len;
+            zone->seq++;
+            if (zone->wp == ufs_zone_end(zone)) {
+                ufs_assign_zone_cond(lu, zone, UFS_ZONE_COND_FULL);
+            }
+            req->zone = zone;
+            req->zone_seq = zone->seq;
+            return true;
+        }
+        *sense = SENSE_CODE(INSUFFICIENT_ZONE_RESOURCES);
+    }
+
+    trace_ufs_zbc_write_rejected(lu->lun, lba, len, zone->wp, zone->cond,
+                                 sense->asc, sense->ascq);
+    return false;
+}
+
+/*
+ * Commands that a zoned LU handles itself. Everything else, including READ,
+ * MODE SENSE, writes that passed ufs_zbc_check_write() and the INQUIRY data
+ * that ufs_zoned_fixup_inquiry() adjusts, goes to the wrapped scsi-hd
+ * (UFS_REQUEST_NO_COMPLETE).
+ */
+static UfsReqResult ufs_emulate_zbc_cmd(UfsLu *lu, UfsRequest *req)
+{
+    g_autofree uint8_t *outbuf = NULL;
+    uint8_t *cdb = req->req_upiu.sc.cdb;
+    uint8_t sense_buf[UFS_SENSE_SIZE];
+    uint8_t scsi_status = GOOD;
+    uint32_t len = 0, xfer_len;
+    SCSISense sense;
+    bool ok;
+
+    /*
+     * Let scsi-hd report a pending unit attention first, as it does for
+     * every command it does not exempt (INQUIRY and REPORT LUNS among them),
+     * so that nothing here, including the write pointer of a write, changes
+     * before the guest has seen it.
+     */
+    if (cdb[0] != INQUIRY &&
+        (lu->scsi_dev->unit_attention.key == UNIT_ATTENTION ||
+         lu->bus.unit_attention.key == UNIT_ATTENTION)) {
+        return UFS_REQUEST_NO_COMPLETE;
+    }
+
+    switch (cdb[0]) {
+    case UFS_ZBC_IN: {
+        /* Size the buffer by what can be returned, not by the PRDT alone */
+        uint64_t report_len = REPORT_ZONES_HEADER_SIZE +
+                              (uint64_t)REPORT_ZONES_DESC_SIZE *
+                              lu->zone_info.nr_zones;
+        uint32_t outbuf_len = MIN(MIN(ldl_be_p(&cdb[10]), req->data_len),
+                                  report_len);
+
+        outbuf_len = MAX(outbuf_len, REPORT_ZONES_HEADER_SIZE);
+        outbuf = g_try_malloc0(outbuf_len);
+        if (!outbuf) {
+            sense = SENSE_CODE(INSUFFICIENT_RESOURCES);
+            ok = false;
+            break;
+        }
+        ok = ufs_zbc_report_zones(lu, req, outbuf, outbuf_len, &len, &sense);
+        break;
+    }
+    case UFS_ZBC_OUT:
+        ok = ufs_zbc_zone_op(lu, req, &sense) == 0;
+        break;
+    case INQUIRY:
+        /* Only the ZBC device characteristics VPD page is emulated here */
+        if (!(cdb[1] & 0x1) || cdb[2] != 0xb6) {
+            return UFS_REQUEST_NO_COMPLETE;
+        }
+        outbuf = g_malloc0(ZBC_VPD_B6_LEN);
+        len = MIN(ufs_emulate_zbc_vpd_page(lu, outbuf), lduw_be_p(&cdb[3]));
+        ok = true;
+        break;
+    case UNMAP:
+        /* Deallocating blocks would bypass the write pointers */
+        sense = SENSE_CODE(INVALID_OPCODE);
+        ok = false;
+        break;
+    default:
+        if (ufs_zbc_check_write(lu, req, &sense)) {
+            return UFS_REQUEST_NO_COMPLETE;
+        }
+        ok = false;
+        break;
+    }
+
+    if (!ok) {
+        scsi_build_sense(sense_buf, sense);
+        scsi_status = CHECK_CONDITION;
+        len = 0;
+    }
+
+    xfer_len = MIN(len, req->data_len);
+    if (xfer_len > 0 &&
+        dma_buf_read(outbuf, xfer_len, NULL, req->sg,
+                     MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
+        return UFS_REQUEST_FAIL;
+    }
+
+    ufs_build_scsi_response_upiu(req, sense_buf, sizeof(sense_buf), xfer_len,
+                                 scsi_status);
+
+    return UFS_REQUEST_SUCCESS;
+}
+
 static UfsReqResult ufs_emulate_scsi_cmd(UfsLu *lu, UfsRequest *req)
 {
     uint8_t lun = lu->lun;
@@ -405,6 +1124,16 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
     SCSIRequest *scsi_req;
     uint32_t len;
 
+    req->zone = NULL;
+
+    if (lu->zone_enabled) {
+        UfsReqResult result = ufs_emulate_zbc_cmd(lu, req);
+        /* UFS_REQUEST_NO_COMPLETE continues command processing */
+        if (result != UFS_REQUEST_NO_COMPLETE) {
+            return result;
+        }
+    }
+
     /*
      * Each ufs-lu has its own independent virtual SCSI bus. Therefore, we can't
      * use scsi_target_emulate_report_luns() which gets all lu information over
@@ -432,14 +1161,15 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
     /*
      * A command that moves data needs a PRDT. Without one there is no SG
      * list, and the SCSI layer would call the transfer_data callback, which
-     * ufs-lu does not set. Fail the request, as virtio-scsi does when the
-     * buffer does not match the command. A request that reports a pending
-     * unit attention instead moves no data; its sense is already set, so let
-     * it through and the guest sees the UA.
+     * only handles the INQUIRY data of a zoned LU. Fail the request, as
+     * virtio-scsi does when the buffer does not match the command. A request
+     * that reports a pending unit attention instead moves no data; its sense
+     * is already set, so let it through and the guest sees the UA.
      */
     if (scsi_req->cmd.mode != SCSI_XFER_NONE && !req->sg &&
         !scsi_req->sense_len) {
         scsi_req_unref(scsi_req);
+        ufs_zbc_write_undo(lu, req);
         return UFS_REQUEST_FAIL;
     }
 
@@ -466,6 +1196,10 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
 static const Property ufs_lu_props[] = {
     DEFINE_PROP_DRIVE("drive", UfsLu, conf.blk),
     DEFINE_PROP_UINT8("lun", UfsLu, lun, 0),
+    DEFINE_PROP_BOOL("zoned", UfsLu, params.zoned, false),
+    DEFINE_PROP_SIZE("zoned.zone_size", UfsLu, params.zone_size,
+                     UFS_DEFAULT_ZONE_SIZE),
+    DEFINE_PROP_UINT32("zoned.max_open", UfsLu, params.zone_max_open, 6),
 };
 
 static bool ufs_add_lu(UfsHc *u, UfsLu *lu, Error **errp)
@@ -498,12 +1232,71 @@ void ufs_init_wlu(UfsLu *wlu, uint8_t wlun)
     wlu->scsi_op = &ufs_emulate_scsi_cmd;
 }
 
+static bool ufs_lu_init_zoned(UfsLu *lu, Error **errp)
+{
+    uint64_t nr_blocks = be64_to_cpu(lu->unit_desc.logical_block_count);
+    uint64_t zone_size = lu->params.zone_size;
+    uint64_t nr_zones, start = 0;
+    UfsZoneState *zone;
+    uint32_t i;
+
+    if (!zone_size || zone_size % UFS_BLOCK_SIZE ||
+        zone_size / UFS_BLOCK_SIZE > UINT32_MAX) {
+        error_setg(errp,
+                   "zoned.zone_size must be a non-zero multiple of %d bytes "
+                   "below 16 TiB",
+                   UFS_BLOCK_SIZE);
+        return false;
+    }
+
+    zone_size /= UFS_BLOCK_SIZE;
+    if (zone_size > nr_blocks) {
+        error_setg(errp, "zoned.zone_size is larger than the drive");
+        return false;
+    }
+
+    /* The REPORT ZONES zone list length must fit in 32 bits */
+    nr_zones = DIV_ROUND_UP(nr_blocks, zone_size);
+    if (nr_zones > (UINT32_MAX - REPORT_ZONES_HEADER_SIZE) /
+                   REPORT_ZONES_DESC_SIZE) {
+        error_setg(errp, "too many zones (%" PRIu64 "), raise zoned.zone_size",
+                   nr_zones);
+        return false;
+    }
+
+    lu->zone_array = g_try_new0(UfsZoneState, nr_zones);
+    if (!lu->zone_array) {
+        error_setg(errp, "cannot allocate the state of %" PRIu64 " zones",
+                   nr_zones);
+        return false;
+    }
+
+    lu->zone_info.zone_size = zone_size;
+    lu->zone_info.nr_zones = nr_zones;
+    lu->zone_info.nr_open = 0;
+    lu->zone_info.max_open = lu->params.zone_max_open;
+
+    for (i = 0, zone = lu->zone_array; i < nr_zones; i++, zone++) {
+        /* SEQUENTIAL WRITE REQUIRED */
+        zone->type = 0x2;
+        zone->cond = UFS_ZONE_COND_EMPTY;
+        zone->start = start;
+        zone->size = MIN(zone_size, nr_blocks - start);
+        zone->wp = start;
+        start += zone->size;
+    }
+
+    lu->zone_enabled = true;
+    return true;
+}
+
 static void ufs_init_lu(UfsLu *lu)
 {
     BlockBackend *blk = lu->conf.blk;
     int64_t brdv_len = blk_getlength(blk);
 
     memset(&lu->unit_desc, 0, sizeof(lu->unit_desc));
+    lu->zone_enabled = false;
     lu->unit_desc.length = sizeof(UnitDescriptor);
     lu->unit_desc.descriptor_idn = UFS_QUERY_DESC_IDN_UNIT;
     lu->unit_desc.lu_enable = 0x01;
@@ -551,6 +1344,10 @@ static void ufs_init_scsi_device(UfsLu *lu, BlockBackend *blk, Error **errp)
     qdev_prop_set_uint32(scsi_dev, "logical_block_size", UFS_BLOCK_SIZE);
     qdev_prop_set_uint32(scsi_dev, "scsi-id", 0);
     qdev_prop_set_uint32(scsi_dev, "lun", lu->lun);
+    if (lu->params.zoned) {
+        /* Deallocating blocks would bypass the write pointers */
+        qdev_prop_set_uint32(scsi_dev, "discard_granularity", 0);
+    }
     if (!qdev_prop_set_drive_err(scsi_dev, "drive", blk, errp)) {
         object_unparent(OBJECT(scsi_dev));
         return;
@@ -567,6 +1364,7 @@ static void ufs_init_scsi_device(UfsLu *lu, BlockBackend *blk, Error **errp)
 
 static void ufs_lu_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     UfsLu *lu = DO_UPCAST(UfsLu, qdev, dev);
     BusState *s = qdev_get_parent_bus(dev);
     UfsHc *u = UFS_BUS(s)->hc;
@@ -590,12 +1388,30 @@ static void ufs_lu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (lu->params.zoned && !blk_supports_write_perm(blk)) {
+        error_setg(errp, "a zoned logical unit needs a writable drive");
+        return;
+    }
+
     ufs_init_lu(lu);
-    if (!ufs_add_lu(u, lu, errp)) {
+    if (lu->params.zoned && !ufs_lu_init_zoned(lu, errp)) {
         return;
     }
 
+    if (!ufs_add_lu(u, lu, errp)) {
+        goto fail;
+    }
+
     ufs_init_scsi_device(lu, blk, errp);
+    if (*errp) {
+        goto fail;
+    }
+    return;
+
+fail:
+    lu->zone_enabled = false;
+    g_free(lu->zone_array);
+    lu->zone_array = NULL;
 }
 
 static void ufs_lu_unrealize(DeviceState *dev)
@@ -603,6 +1419,9 @@ static void ufs_lu_unrealize(DeviceState *dev)
     UfsLu *lu = DO_UPCAST(UfsLu, qdev, dev);
 
     lu->scsi_dev = NULL;
+    lu->zone_enabled = false;
+    g_free(lu->zone_array);
+    lu->zone_array = NULL;
 }
 
 static void ufs_lu_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 5e5a54a3fb..1977a9c9ad 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -58,3 +58,9 @@ ufs_err_mcq_delete_cq_sq_not_deleted(uint8_t sqid, uint8_t cqid) "mcq sq %"PRIu8
 # HID (Host Initiated Defragmentation)
 ufs_hid_defrag_operation(uint8_t op, uint8_t state) "HID defrag operation 0x%"PRIx8", new state 0x%"PRIx8""
 ufs_hid_defrag_progress(uint32_t remaining, uint8_t progress) "HID defrag remaining %"PRIu32", progress %"PRIu8"%%"
+
+# lu.c (zoned logical units)
+ufs_zbc_report_zones(uint8_t lun, uint64_t lba, uint32_t alloc_len, uint8_t options) "lun 0x%"PRIx8", lba %"PRIu64", alloc_len %"PRIu32", options 0x%"PRIx8""
+ufs_zbc_zone_op(uint8_t lun, uint8_t action, uint64_t zone_id, bool all) "lun 0x%"PRIx8", action 0x%"PRIx8", zone id %"PRIu64", all %d"
+ufs_zbc_write_rejected(uint8_t lun, uint64_t lba, uint32_t len, uint64_t wp, uint8_t cond, uint8_t asc, uint8_t ascq) "lun 0x%"PRIx8", lba %"PRIu64", len %"PRIu32", wp %"PRIu64", cond 0x%"PRIx8", asc 0x%"PRIx8", ascq 0x%"PRIx8""
+ufs_zbc_write_undone(uint8_t lun, uint64_t zone_start, uint64_t wp) "lun 0x%"PRIx8", zone start %"PRIu64", wp back to %"PRIu64""
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 265a43faaa..4819e2522f 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -17,6 +17,25 @@
 #include "scsi/constants.h"
 #include "system/dma.h"
 
+typedef struct UfsZoneState {
+    uint8_t type;
+    UfsZoneCond cond;
+    uint64_t start;
+    uint64_t size;
+    uint64_t wp;
+    /* bumped by every change of cond or wp, except an implicit close */
+    uint64_t seq;
+} UfsZoneState;
+
+typedef struct UfsZoneInfo {
+    uint32_t zone_size;
+    uint32_t nr_zones;
+    uint32_t nr_open;
+    uint32_t max_open;
+} UfsZoneInfo;
+
+#define UFS_DEFAULT_ZONE_SIZE (128 * MiB)
+
 #define UFS_MAX_LUS 32
 #define UFS_MAX_MCQ_QNUM 32
 #define UFS_BLOCK_SIZE_SHIFT 12
@@ -64,6 +83,12 @@ typedef struct UfsRequest {
     QEMUSGList *sg;
     uint32_t data_len;
 
+    /* write accepted by a zoned LU, undone if scsi-hd does not complete it */
+    UfsZoneState *zone;
+    UfsZoneCond zone_cond_before;
+    uint64_t zone_wp_before;
+    uint64_t zone_seq;
+
     /* for MCQ */
     struct UfsSq *sq;
     struct UfsCqEntry cqe;
@@ -78,6 +103,12 @@ static inline bool ufs_mcq_req(UfsRequest *req)
 struct UfsLu;
 typedef UfsReqResult (*UfsScsiOp)(struct UfsLu *, UfsRequest *);
 
+typedef struct UfsLuParams {
+    bool zoned;
+    uint64_t zone_size;
+    uint32_t zone_max_open;
+} UfsLuParams;
+
 typedef struct UfsLu {
     DeviceState qdev;
     uint8_t lun;
@@ -86,6 +117,11 @@ typedef struct UfsLu {
     SCSIDevice *scsi_dev;
     BlockConf conf;
     UfsScsiOp scsi_op;
+    /* For Zoned UFS */
+    UfsLuParams params;
+    bool zone_enabled;
+    UfsZoneInfo zone_info;
+    UfsZoneState *zone_array;
 } UfsLu;
 
 typedef struct UfsParams {
diff --git a/include/block/ufs.h b/include/block/ufs.h
index 4a614fbe52..a0bbe873d6 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -708,6 +708,33 @@ enum {
     UFS_MASK_OCS = 0xFF,
 };
 
+/* ZBC zone conditions, table 26 of zbcr05 */
+typedef enum UfsZoneCond {
+    UFS_ZONE_COND_NOT_WP = 0x0,
+    UFS_ZONE_COND_EMPTY = 0x1,
+    UFS_ZONE_COND_IMPLICIT_OPEN = 0x2,
+    UFS_ZONE_COND_EXPLICIT_OPEN = 0x3,
+    UFS_ZONE_COND_CLOSED = 0x4,
+    UFS_ZONE_COND_READ_ONLY = 0xd,
+    UFS_ZONE_COND_FULL = 0xe,
+    UFS_ZONE_COND_OFFLINE = 0xf,
+} UfsZoneCond;
+
+/* ZBC IN and ZBC OUT operation codes and their service actions */
+#define UFS_ZBC_OUT 0x94
+#define UFS_ZBC_IN 0x95
+
+enum {
+    UFS_ZBC_REPORT_ZONES = 0x00,
+};
+
+enum {
+    UFS_ZBC_CLOSE_ZONE = 0x01,
+    UFS_ZBC_FINISH_ZONE = 0x02,
+    UFS_ZBC_OPEN_ZONE = 0x03,
+    UFS_ZBC_RESET_WRITE_POINTER = 0x04,
+};
+
 /*
  * struct UfshcdSgEntry - UFSHCI PRD Entry
  * @addr: Physical address; DW-0 and DW-1.

-- 
2.43.0

