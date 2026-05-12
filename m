Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0D1CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuEB-0006yG-F7; Tue, 12 May 2026 17:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuCx-0003wt-Eu; Tue, 12 May 2026 17:00:03 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuCu-0005cT-Rs; Tue, 12 May 2026 17:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619276; bh=1HdcgX/LMaeNImKpnuqp9kdYf9fsxq1yKsfOxvZzWZE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kdvPqf3RbB3B3UsG6jnCBpk3Wfk4csICi9iKeUtqEAUEK8/FB4quPczWT79bdIIRK
 fqV2bfdG3exJcxLICIQDb4T0N3PU95D/0TUdRcVQS/x/oB22DH/shnBTRUUKYkNlss
 Ax0lR2BWBm2TEdwfzoWobTA5uDMcXuaXqHhFw739/J86CqBJH9xhbMhbO4DkTBNI3l
 5e/lJRVBZO8nYYx/r0XZRMonkBUZ8OUQuYLxmcip6Te66d1UYIZhxZGHI3HI2Eml+4
 BJPFj99Be7JFBnsUhliuGhh/eO+JYMI2BkD9feylIL7sQlbC0MFKsgQjsjO6ccO7VK
 gPL7hS6Y2TfGA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DCA6A1AA303;
 Tue, 12 May 2026 23:54:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E4B513ABC74;
 Tue, 12 May 2026 23:54:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Mingyuan Luo <myluo24@m.fudan.edu.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 055/107] virtio-blk: fix zone report buffer
 out-of-memory (CVE-2026-5761)
Date: Tue, 12 May 2026 23:53:42 +0300
Message-ID: <20260512205437.360850-55-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

An internal buffer is used when processing VIRTIO_BLK_T_ZONE_REPORT
requests. The buffer's size is controlled by the guest. A large value
can result in g_malloc() failure and the QEMU process aborts, resulting
in a Denial of Service (DoS) (most likely in cases where an untrusted
guest application or a nested guest with virtio-blk passthrough is able
to abort QEMU).

Modify the zone report implementation to work incrementally with a
bounded buffer size.

This is purely a QEMU implementation issue and no VIRTIO spec changes
are needed.

Mingyuan Luo found this bug and provided a reproducer which I haven't
put into tests/qtest/ because it requires a zoned storage device (e.g.
root and modprobe null_blk):

1) Prepare a zoned nullblk backend (/dev/nullb0):

sudo modprobe -r null_blk || true
sudo modprobe null_blk nr_devices=1 zoned=1
sudo chmod 0666 /dev/nullb0
cat /sys/block/nullb0/queue/zoned

2) Create qtest input:

cat >/tmp/vblk-zone-report-oom.qtest <<'EOF'
outl 0xcf8 0x80002004
outw 0xcfc 0x0007
outl 0xcf8 0x80002010
outl 0xcfc 0x0000c001
outb 0xc012 0x00
outb 0xc012 0x01
outb 0xc012 0x03
outl 0xc004 0x00000000
outw 0xc00e 0x0000
outl 0xc008 0x00000100
outb 0xc012 0x07
writel 0x00020000 0x00000010
writel 0x00020004 0x00000000
writeq 0x00020008 0x0000000000000000
writeq 0x00100000 0x0000000000020000
writel 0x00100008 0x00000010
writew 0x0010000c 0x0001
writew 0x0010000e 0x0001
EOF

for i in $(seq 1 1022); do
d=$((0x00100000 + i * 16))
n=$((i + 1))
printf 'writeq 0x%08x 0x0000000000200000\n' "$d" >> /tmp/vblk-zone-report-oom.qtest
printf 'writel 0x%08x 0x1fe00000\n' $((d + 8)) >> /tmp/vblk-zone-report-oom.qtest
printf 'writew 0x%08x 0x0003\n' $((d + 12)) >> /tmp/vblk-zone-report-oom.qtest
printf 'writew 0x%08x 0x%04x\n' $((d + 14)) "$n" >> /tmp/vblk-zone-report-oom.qtest
done

d=$((0x00100000 + 1023 * 16))
printf 'writeq 0x%08x 0x0000000000200000\n' "$d" >> /tmp/vblk-zone-report-oom.qtest
printf 'writel 0x%08x 0x1fe00000\n' $((d + 8)) >> /tmp/vblk-zone-report-oom.qtest
printf 'writew 0x%08x 0x0002\n' $((d + 12)) >> /tmp/vblk-zone-report-oom.qtest
printf 'writew 0x%08x 0x0000\n' $((d + 14)) >> /tmp/vblk-zone-report-oom.qtest
cat >> /tmp/vblk-zone-report-oom.qtest <<'EOF'
writew 0x00104000 0x0000
writew 0x00104002 0x0001
writew 0x00104004 0x0000
outw 0xc010 0x0000
EOF

3) Run the qtest input with ASAN build (compile qemu with --enable-asan):

build/qemu-system-x86_64 -display none \
-accel qtest -qtest stdio \
-machine pc -nodefaults -m 512M -monitor none -serial none \
-blockdev driver=host_device,node-name=disk0,filename=/dev/nullb0 \
-device virtio-blk-pci-transitional,drive=disk0,addr=04.0,queue-size=1024 \
< /tmp/vblk-zone-report-oom.qtest

Cc: Sam Li <faithilikerun@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Fixes: CVE-2026-5761
Fixes: 4f7366506a9 ("virtio-blk: add zoned storage emulation for zoned devices")
Reported-by: Mingyuan Luo <myluo24@m.fudan.edu.cn>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 4913ae36f9796c55d434dcbfa6bdb9ebb3e5e4b1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 5077793e5e..add6ad9d55 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -38,6 +38,9 @@
 #include "hw/virtio/virtio-blk-common.h"
 #include "qemu/coroutine.h"
 
+/* Internal buffer size limit for zone report */
+#define VIRTIO_BLK_MAX_ZONES_PER_BATCH 4096
+
 static void virtio_blk_ioeventfd_attach(VirtIOBlock *s);
 
 static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
@@ -451,15 +454,22 @@ err:
     return err_status;
 }
 
+typedef struct {
+    unsigned int total_nr_zones;    /* max zones to fill in this request */
+    unsigned int nr_zones_done;     /* how many zones have been filled in */
+    int64_t iov_offset;             /* current byte position in in_iov[] */
+    int64_t offset;                 /* current zone report disk offset */
+    unsigned int nr_zones;          /* for zone report calls */
+    unsigned int zones_per_batch;   /* size of zone report buffer */
+    BlockZoneDescriptor *zones;     /* zone report buffer */
+} ZoneReportData;
+
 typedef struct ZoneCmdData {
     VirtIOBlockReq *req;
     struct iovec *in_iov;
     unsigned in_num;
     union {
-        struct {
-            unsigned int nr_zones;
-            BlockZoneDescriptor *zones;
-        } zone_report_data;
+        ZoneReportData zone_report_data;
         struct {
             int64_t offset;
         } zone_append_data;
@@ -516,16 +526,15 @@ static bool check_zoned_request(VirtIOBlock *s, int64_t offset, int64_t len,
 static void virtio_blk_zone_report_complete(void *opaque, int ret)
 {
     ZoneCmdData *data = opaque;
+    ZoneReportData *zrd = &data->zone_report_data;
     VirtIOBlockReq *req = data->req;
     VirtIODevice *vdev = VIRTIO_DEVICE(req->dev);
     struct iovec *in_iov = data->in_iov;
     unsigned in_num = data->in_num;
-    int64_t zrp_size, n, j = 0;
-    int64_t nz = data->zone_report_data.nr_zones;
+    int64_t n;
+    unsigned nz = zrd->nr_zones;
     int8_t err_status = VIRTIO_BLK_S_OK;
-    struct virtio_blk_zone_report zrp_hdr = (struct virtio_blk_zone_report) {
-        .nr_zones = cpu_to_le64(nz),
-    };
+    struct virtio_blk_zone_report zrp_hdr = {};
 
     trace_virtio_blk_zone_report_complete(vdev, req, nz, ret);
     if (ret) {
@@ -533,28 +542,18 @@ static void virtio_blk_zone_report_complete(void *opaque, int ret)
         goto out;
     }
 
-    zrp_size = sizeof(struct virtio_blk_zone_report)
-               + sizeof(struct virtio_blk_zone_descriptor) * nz;
-    n = iov_from_buf(in_iov, in_num, 0, &zrp_hdr, sizeof(zrp_hdr));
-    if (n != sizeof(zrp_hdr)) {
-        virtio_error(vdev, "Driver provided input buffer that is too small!");
-        err_status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
-        goto out;
-    }
-
-    for (size_t i = sizeof(zrp_hdr); i < zrp_size;
-        i += sizeof(struct virtio_blk_zone_descriptor), ++j) {
+    for (unsigned j = 0; j < nz; j++) {
         struct virtio_blk_zone_descriptor desc =
             (struct virtio_blk_zone_descriptor) {
-                .z_start = cpu_to_le64(data->zone_report_data.zones[j].start
+                .z_start = cpu_to_le64(zrd->zones[j].start
                     >> BDRV_SECTOR_BITS),
-                .z_cap = cpu_to_le64(data->zone_report_data.zones[j].cap
+                .z_cap = cpu_to_le64(zrd->zones[j].cap
                     >> BDRV_SECTOR_BITS),
-                .z_wp = cpu_to_le64(data->zone_report_data.zones[j].wp
+                .z_wp = cpu_to_le64(zrd->zones[j].wp
                     >> BDRV_SECTOR_BITS),
         };
 
-        switch (data->zone_report_data.zones[j].type) {
+        switch (zrd->zones[j].type) {
         case BLK_ZT_CONV:
             desc.z_type = VIRTIO_BLK_ZT_CONV;
             break;
@@ -568,7 +567,7 @@ static void virtio_blk_zone_report_complete(void *opaque, int ret)
             g_assert_not_reached();
         }
 
-        switch (data->zone_report_data.zones[j].state) {
+        switch (zrd->zones[j].state) {
         case BLK_ZS_RDONLY:
             desc.z_state = VIRTIO_BLK_ZS_RDONLY;
             break;
@@ -598,18 +597,47 @@ static void virtio_blk_zone_report_complete(void *opaque, int ret)
         }
 
         /* TODO: it takes O(n^2) time complexity. Optimizations required. */
-        n = iov_from_buf(in_iov, in_num, i, &desc, sizeof(desc));
+        n = iov_from_buf(in_iov, in_num, zrd->iov_offset, &desc, sizeof(desc));
         if (n != sizeof(desc)) {
             virtio_error(vdev, "Driver provided input buffer "
                                "for descriptors that is too small!");
             err_status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
+            goto out;
         }
+
+        zrd->iov_offset += sizeof(desc);
+    }
+
+    if (nz > 0) {
+        BlockZoneDescriptor *zone = &zrd->zones[nz - 1];
+        zrd->offset = zone->start + zone->length;
+    }
+
+    zrd->nr_zones_done += nz;
+
+    /* Call zone report again if the end hasn't been reached yet */
+    if (nz == zrd->zones_per_batch &&
+        zrd->nr_zones_done < zrd->total_nr_zones) {
+        zrd->nr_zones = MIN(zrd->zones_per_batch,
+                            zrd->total_nr_zones - zrd->nr_zones_done);
+        blk_aio_zone_report(req->dev->blk, zrd->offset, &zrd->nr_zones,
+                            zrd->zones, virtio_blk_zone_report_complete, data);
+        return;
+    }
+
+    /* Fill in header now that all zones have been reported */
+    zrp_hdr.nr_zones = cpu_to_le64(zrd->nr_zones_done);
+    n = iov_from_buf(in_iov, in_num, 0, &zrp_hdr, sizeof(zrp_hdr));
+    if (n != sizeof(zrp_hdr)) {
+        virtio_error(vdev, "Driver provided input buffer that is too small!");
+        err_status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
+        goto out;
     }
 
 out:
     virtio_blk_req_complete(req, err_status);
     g_free(req);
-    g_free(data->zone_report_data.zones);
+    g_free(zrd->zones);
     g_free(data);
 }
 
@@ -621,7 +649,8 @@ static void virtio_blk_handle_zone_report(VirtIOBlockReq *req,
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
     unsigned int nr_zones;
     ZoneCmdData *data;
-    int64_t zone_size, offset;
+    ZoneReportData *zrd;
+    int64_t offset;
     uint8_t err_status;
 
     if (req->in_len < sizeof(struct virtio_blk_inhdr) +
@@ -643,16 +672,21 @@ static void virtio_blk_handle_zone_report(VirtIOBlockReq *req,
     trace_virtio_blk_handle_zone_report(vdev, req,
                                         offset >> BDRV_SECTOR_BITS, nr_zones);
 
-    zone_size = sizeof(BlockZoneDescriptor) * nr_zones;
     data = g_malloc(sizeof(ZoneCmdData));
     data->req = req;
     data->in_iov = in_iov;
     data->in_num = in_num;
-    data->zone_report_data.nr_zones = nr_zones;
-    data->zone_report_data.zones = g_malloc(zone_size),
 
-    blk_aio_zone_report(s->blk, offset, &data->zone_report_data.nr_zones,
-                        data->zone_report_data.zones,
+    zrd = &data->zone_report_data;
+    zrd->total_nr_zones = nr_zones;
+    zrd->nr_zones_done = 0;
+    zrd->iov_offset = sizeof(struct virtio_blk_zone_report);
+    zrd->offset = offset;
+    zrd->zones_per_batch = MIN(nr_zones, VIRTIO_BLK_MAX_ZONES_PER_BATCH);
+    zrd->zones = g_malloc(zrd->zones_per_batch * sizeof(BlockZoneDescriptor));
+
+    zrd->nr_zones = zrd->zones_per_batch;
+    blk_aio_zone_report(s->blk, offset, &zrd->nr_zones, zrd->zones,
                         virtio_blk_zone_report_complete, data);
     return;
 out:
-- 
2.47.3


