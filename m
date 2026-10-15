Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B22CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKST-0002tr-PT; Thu, 15 Oct 2026 08:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKSR-0002qH-9t
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:21:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKSN-0005Ir-8S
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zjetcz5cxb4TTuuZEteF5VZxBDAYnVbJTCoPEJlR3hQ=;
 b=KFe8+Oza2stj/HywH+1XIv5foeP8Im8QTNjRGFwu7g/VomWtpXoXsUjP/QgzLILnKUjBOn
 XEqg0uRRpjF938Vt18yJCdepIJtjMHgCOVafbmoPaTcWD6Sx6hsR5e10iVg8uOLAh/cE23
 SqVOXKdNt77EeXLQb0G8jqArv0i91lk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-9gWTLlQONTm2S6CIwE3j6w-1; Thu,
 15 Oct 2026 12:21:07 +0000
X-MC-Unique: 9gWTLlQONTm2S6CIwE3j6w-1
X-Mimecast-MFC-AGG-ID: 9gWTLlQONTm2S6CIwE3j6w_1792066866
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 287C11955BC5; Thu, 15 Oct 2026 12:21:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B65C718004D2; Thu, 15 Oct 2026 12:21:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mikhail Malyshev <mike.malyshev@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 4/8] vfio/igd: sanitize DBUF_CTL POWER_STATE for iGPU
 passthrough
Date: Thu, 15 Oct 2026 14:20:51 +0200
Message-ID: <20261015122055.888209-5-clg@redhat.com>
In-Reply-To: <20261015122055.888209-1-clg@redhat.com>
References: <20261015122055.888209-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Mikhail Malyshev <mike.malyshev@gmail.com>

On some hosts the firmware POST modeset leaves the display data buffer
(DBUF) powered, so the passed-through iGPU's DBUF_CTL registers read
back POWER_STATE=1 while POWER_REQUEST=0 -- an inconsistent leftover that
never occurs under GVT-g, which emulates the register so POWER_STATE
follows POWER_REQUEST.

This was observed with a Windows guest (Intel KMD) on QEMU 9.1; a
Linux/i915 guest was not tested.  On the first-boot modeset the guest
driver samples POWER_STATE to decide which DBUF slices are already
enabled, sees the stale "powered" bit, and therefore never issues
POWER_REQUEST.  DBUF then powers down, the plane FIFO underruns, and
scanout is corrupted (vertical stripes) until a full modeset (e.g. a
display sleep/wake) re-requests power.

The programming is a single inconsistent read-modify-write.  Traced with
x-no-mmap=on so every BAR0 access is visible:

  read  0x45008 = 0x4040c000   STATE=1, REQUEST=0 (stale leftover)
  write 0x45008 = 0x4043c000   RMW: tracker bits only; REQUEST still 0
  read  0x45008 = 0x0043c000   STATE=0: DBUF powered down -> underrun

The driver sees STATE=1, assumes the slice is already powered, and leaves
REQUEST clear.  Only after a display sleep/wake does it set REQUEST, which
is why sleep/wake repairs the display:

  write 0x45008 = 0x8043c000   REQUEST=1
  read  0x45008 = 0xc043c000   STATE follows -> powered, scanout clean

The same pattern occurs on the other slice registers (0x44fe8, 0x44300,
0x44304).

Present a consistent view like GVT-g: trap the DBUF_CTL slice registers
(S1..S4, only as many as the generation exposes) in BAR0 and clear
POWER_STATE on read whenever POWER_REQUEST is not set.  Writes pass
straight through to the device.

Signed-off-by: Mikhail Malyshev <mike.malyshev@gmail.com>
Reviewed-by: Tomita Moeko <tomitamoeko@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20260724102959.1043264-1-mike.malyshev@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 413a49aae9163c6500bc50f29e5454f698addaa4..5e6160763cefb9d9739dd0a6462137c49109e81a 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -455,6 +455,96 @@ static bool vfio_pci_igd_override_gms(int gen, uint32_t gms, uint32_t *gmch)
 #define IGD_GGC_MMIO_OFFSET     0x108040
 #define IGD_BDSM_MMIO_OFFSET    0x1080C0
 
+/*
+ * IGD BAR0 DBUF_CTL sanitize quirk.
+ *
+ * On hosts where the firmware POST modeset left the display engine powered,
+ * DBUF_CTL reads back POWER_STATE=1 while POWER_REQUEST=0 -- an inconsistent
+ * leftover that never occurs under GVT-g (which emulates the register so
+ * STATE follows REQUEST).  A passed-through guest driver samples POWER_STATE
+ * to decide which DBUF slices are already enabled, sees this stale "powered"
+ * bit, and therefore never issues POWER_REQUEST.  DBUF then powers down, the
+ * plane FIFO underruns, and scanout is corrupted until a full modeset (e.g.
+ * a display sleep/wake) re-requests power.
+ *
+ * Present a consistent view like GVT-g: intercept DBUF_CTL reads and clear
+ * POWER_STATE whenever POWER_REQUEST is not set.  Writes pass straight
+ * through to the device.
+ */
+#define IGD_DBUF_POWER_REQUEST  (1u << 31)
+#define IGD_DBUF_POWER_STATE    (1u << 30)
+
+/*
+ * DBUF_CTL slice registers within BAR0, in slice order (i915 numbers these
+ * S1..S4).  How many slices exist is generation-dependent, so only the first
+ * igd_dbuf_ctl_nslices(gen) entries are real DBUF_CTL registers on a given
+ * part; the rest are unrelated registers and must not be trapped.
+ */
+static const uint32_t igd_dbuf_ctl_offsets[] = {
+    0x45008, /* S1 */ 0x44FE8, /* S2 */ 0x44300, /* S3 */ 0x44304, /* S4 */
+};
+
+/*
+ * DBUF slice count by generation, matching i915 dbuf.slice_mask:
+ * gen9/10 = 1 (S1), gen11 = 2 (S1-S2), gen12+ = 4 (S1-S4).
+ *
+ * Within gen12 the slice count is actually per-platform, not per-gen: ADL-P /
+ * RPL-P / DG2 expose 4 slices, but TGL / RKL / ADL-S have only 2.  We return 4
+ * for all gen12+ (igd_gen() can't distinguish them), so on a <4-slice gen12
+ * part S3/S4 (0x44300/0x44304) are over-trapped.  This is harmless in practice:
+ * the read handler only mutates a value when POWER_REQUEST=0 && POWER_STATE=1,
+ * which whatever register lives at those offsets is very unlikely to present.
+ * A fully-correct count would have to key off the PCI device ID.
+ */
+static int igd_dbuf_ctl_nslices(int gen)
+{
+    if (gen <= 10) {
+        return 1;
+    }
+    if (gen == 11) {
+        return 2;
+    }
+    return 4;
+}
+
+typedef struct IGDDbufCtlQuirk {
+    VFIOPCIDevice *vdev;
+    uint32_t bar_offset;    /* offset within BAR0 MMIO */
+    uint8_t bar;
+} IGDDbufCtlQuirk;
+
+static uint64_t igd_dbuf_ctl_read(void *opaque, hwaddr addr, unsigned size)
+{
+    IGDDbufCtlQuirk *q = opaque;
+    VFIOPCIDevice *vdev = q->vdev;
+    uint64_t val = vfio_region_read(&vdev->bars[q->bar].region,
+                                    addr + q->bar_offset, size);
+
+    if (size == 4 && !(val & IGD_DBUF_POWER_REQUEST) &&
+        (val & IGD_DBUF_POWER_STATE)) {
+        val &= ~(uint64_t)IGD_DBUF_POWER_STATE;
+        error_report_once("IGD quirk: DBUF_CTL@0x%x cleared stale "
+                          "POWER_STATE (POWER_REQUEST=0)", q->bar_offset);
+    }
+    return val;
+}
+
+static void igd_dbuf_ctl_write(void *opaque, hwaddr addr,
+                               uint64_t data, unsigned size)
+{
+    IGDDbufCtlQuirk *q = opaque;
+    VFIOPCIDevice *vdev = q->vdev;
+
+    vfio_region_write(&vdev->bars[q->bar].region,
+                      addr + q->bar_offset, data, size);
+}
+
+static const MemoryRegionOps igd_dbuf_ctl_ops = {
+    .read = igd_dbuf_ctl_read,
+    .write = igd_dbuf_ctl_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 {
     VFIOQuirk *ggc_quirk, *bdsm_quirk;
@@ -507,6 +597,35 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
                                         1);
 
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
+
+    /*
+     * DBUF_CTL sanitize quirk (gen9+): trap the DBUF_CTL slice registers so
+     * POWER_STATE is reported consistently with POWER_REQUEST (see
+     * igd_dbuf_ctl_read()).  Only trap slices that actually exist on this
+     * generation -- the remaining offsets are unrelated registers.
+     */
+    if (gen >= 9) {
+        int i, nslices = igd_dbuf_ctl_nslices(gen);
+        VFIOQuirk *dbuf_quirk = vfio_quirk_alloc(nslices);
+        IGDDbufCtlQuirk *dq;
+
+        dq = g_new0(IGDDbufCtlQuirk, nslices);
+        dbuf_quirk->data = dq;
+
+        for (i = 0; i < nslices; i++) {
+            dq[i].vdev = vdev;
+            dq[i].bar = nr;
+            dq[i].bar_offset = igd_dbuf_ctl_offsets[i];
+            memory_region_init_io(&dbuf_quirk->mem[i], OBJECT(vdev),
+                                  &igd_dbuf_ctl_ops, &dq[i],
+                                  "vfio-igd-dbuf-ctl-quirk", 4);
+            memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
+                                                igd_dbuf_ctl_offsets[i],
+                                                &dbuf_quirk->mem[i], 1);
+        }
+
+        QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, dbuf_quirk, next);
+    }
 }
 
 static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
-- 
2.56.0


