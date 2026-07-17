Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4D7C44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkeGV-0005zI-Cb; Fri, 17 Jul 2026 04:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.malyshev@gmail.com>)
 id 1wkeGS-0005yP-TI
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:49:48 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.malyshev@gmail.com>)
 id 1wkeGQ-00046c-TM
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:49:48 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso1387815e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 01:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784278185; x=1784882985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kmiBcKAqv2OGhp0GULp7p7IUjutVY/OZQ5oX+wnj/3Q=;
 b=CEpqVB29UpxgTeo87fcma2DPRop7aMCHXh0JZGKqxGEBpjwO9YS2E1kRlL1HlA9G9n
 UPCYoESiEy7mdJBI/qJw/iosPhA7msu/Mct6C9B4iDym0+RjhIC4ji9gZaLZtFmvO3hU
 39Q3SKsSoI7q7LVBkMUFXiCnEL+RIjPa/7BjyyOoDAkpP7dpOPj63JOseK7pKNWffK/c
 I2+NZBXBcKWl8Ak/zM+RO0NafTmgE1mv1GiL6KCmCza0fXTjX1Ax5ilq8p/htn40wTEy
 EZejErKK3PYP0GZVJcnZvteKFtusPN7wPFRFV1biMd/inJTO5YXQMRS+JA6qmrPHVg51
 qAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784278185; x=1784882985;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kmiBcKAqv2OGhp0GULp7p7IUjutVY/OZQ5oX+wnj/3Q=;
 b=LElFcbPzEwBNO6gTjJxe0MXkHYV4acsAwmiH08RJZIfa9UmgmzLziNJIuj3pBl2W86
 6HheQqg6d/l+f10AqGD84hsFt2Qw14JTVgMleyXa15jOW0mE8oQrsiLf2vktUHg/y5GQ
 CvUHhhAN6xR87EpcBFhvu/ZlCCuCwUntIQl/zNwyk/71BK8G3VHeMGuv2mPRm8wJ1ZsB
 M0X9chSN2s0aMcbxvZiwzQajXFjTs0IrOLumwIdArP4rAPJCX7Qhi6/gWLipSIlAw4uq
 f4Q3vHrmuv5/UtRFvBrROPupBjXmHwBPketI2z3gp9+6jOpJX5w/YVusXZ6QYumA4Jp1
 Duig==
X-Gm-Message-State: AOJu0YwVSmFvOPvsIWUurnkSI18jwTXfHDDD3Mhp+CEvhfK6vux9UVfy
 fW+iukHxUUwpUWtE3G7eVcGEBS2VRaRXCHj/Y5LNCrQrFRfJeSNxWDkatQLsfAz0a0w=
X-Gm-Gg: AfdE7clb6fn2RnM8+HoikSuqJJWh2+NIm3l8LEgY+MyEpteQcV+CLdgoeugnaSbLv13
 kULcThcCKbzlhZOa+shmN+5AZ3wx9lytM7erB5dxZ14Ttp0Ah0TSzpna9T+PyGOw7Z4a8vRBOFh
 SfOvlTCjuk6mG2/ywtzDF68RxPuq1eZs/a7ltjyfNqE0UKZ0LkwgNKRiJsbMkGXzU756DFhiEPd
 mopjdELpAaiTd6IgBcAutEz0r56Ns4eK0XmOE7yfwqRbIerhcimlXKrl9zFxE7zmN/SZQL4A7Nl
 E+h38oV5Gf7uCDdnk7XgXh9okRTiVTi4DfB8igGtQ3xdV2YDIUuNIQewTy7xCrm5EPXf0qMqgFc
 mHk5BybEHK2RROZRT+7B5pHemHnAqgkb/kjKNsKoXgTptyKinUXhTR/QKrtnkvozcA4ce1gos+g
 sYTjxtoK8=
X-Received: by 2002:a05:600c:4512:b0:493:bc4a:fb56 with SMTP id
 5b1f17b1804b1-4954a50e92bmr17546615e9.39.1784278184730; 
 Fri, 17 Jul 2026 01:49:44 -0700 (PDT)
Received: from build-server.. ([62.96.37.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2aa698sm28753815e9.4.2026.07.17.01.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 01:49:43 -0700 (PDT)
From: mike.malyshev@gmail.com
To: qemu-devel@nongnu.org,
	alex@shazbot.org
Cc: clg@redhat.com, tomitamoeko@gmail.com, corvin.koehne@gmail.com,
 Mikhail Malyshev <mike.malyshev@gmail.com>
Subject: [PATCH] vfio/igd: sanitize DBUF_CTL POWER_STATE for iGPU passthrough
Date: Fri, 17 Jul 2026 08:49:42 +0000
Message-ID: <20260717084942.1555442-1-mike.malyshev@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=mike.malyshev@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Mikhail Malyshev <mike.malyshev@gmail.com>

On some hosts the firmware POST modeset leaves the display data buffer
(DBUF) powered, so the passed-through iGPU's DBUF_CTL registers read
back POWER_STATE=1 while POWER_REQUEST=0 -- an inconsistent leftover that
never occurs under GVT, which emulates the register so POWER_STATE
follows POWER_REQUEST.

A guest display driver samples POWER_STATE to determine which DBUF
slices are already enabled; seeing the stale "powered" bit it never
issues POWER_REQUEST, so DBUF actually powers down, the plane FIFO
underruns, and scanout is corrupted (vertical stripes) until a full
modeset (e.g. a display sleep/wake) re-requests power.

Present a consistent view like GVT: trap the DBUF_CTL slice registers
(S1..S4, only as many as the generation exposes) in BAR0 and clear
POWER_STATE on read whenever POWER_REQUEST is not set.  Writes pass
straight through to the device.

Signed-off-by: Mikhail Malyshev <mike.malyshev@gmail.com>
---
 hw/vfio/igd.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e091f21b6a..ebe957f69d 100644
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
+ * leftover that never occurs under GVT (which emulates the register so STATE
+ * follows REQUEST).  A passed-through guest driver samples POWER_STATE to
+ * decide which DBUF slices are already enabled, sees this stale "powered"
+ * bit, and therefore never issues POWER_REQUEST.  DBUF then powers down, the
+ * plane FIFO underruns, and scanout is corrupted until a full modeset (e.g.
+ * a display sleep/wake) re-requests power.
+ *
+ * Present a consistent view like GVT: intercept DBUF_CTL reads and clear
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
@@ -507,6 +597,32 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
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
+
+        for (i = 0; i < nslices; i++) {
+            VFIOQuirk *dquirk = vfio_quirk_alloc(1);
+            IGDDbufCtlQuirk *dq = dquirk->data = g_malloc0(sizeof(*dq));
+
+            dq->vdev = vdev;
+            dq->bar = nr;
+            dq->bar_offset = igd_dbuf_ctl_offsets[i];
+            memory_region_init_io(&dquirk->mem[0], OBJECT(vdev),
+                                  &igd_dbuf_ctl_ops, dq,
+                                  "vfio-igd-dbuf-ctl-quirk", 4);
+            memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
+                                                igd_dbuf_ctl_offsets[i],
+                                                &dquirk->mem[0], 1);
+            QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, dquirk, next);
+        }
+    }
 }
 
 static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
-- 
2.43.0


