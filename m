Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3409C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woE4S-0003TF-BY; Mon, 27 Jul 2026 01:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4K-00039t-B0
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4H-0003WF-PH
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785130801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=olDliIW7mfe1ldZof51Y2tBein2BaeyJp0eYsLkADPU=;
 b=bUOqjfXQiL8qzrEsDdZsCgjeb6L+gP6MXv92qwqTuRJETxwnZJ1iWR40F+BlgefBuMKlkv
 qnRDNPGAcmGbGzv3B8Th5Ej2ai7jjmXU47pXUaCH/10+E8aadqOC7J6DDyElKNXs0wRGb6
 FZ1g6DA7bJnLbruCfius24GEIMMWn00=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-6bv20D-MNiy9gpngUDaoyQ-1; Mon,
 27 Jul 2026 01:39:57 -0400
X-MC-Unique: 6bv20D-MNiy9gpngUDaoyQ-1
X-Mimecast-MFC-AGG-ID: 6bv20D-MNiy9gpngUDaoyQ_1785130796
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 038CD1955F2D; Mon, 27 Jul 2026 05:39:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3042F1956088; Mon, 27 Jul 2026 05:39:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH 04/11] igb: Add VF state serialization for live migration
Date: Mon, 27 Jul 2026 07:39:28 +0200
Message-ID: <20260727053935.1392269-5-clg@redhat.com>
In-Reply-To: <20260727053935.1392269-1-clg@redhat.com>
References: <20260727053935.1392269-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Add igb_pf_get_core() so migration code can reach the PF's IGBCore
from a VF device and implement igb_core_vf_save_state() and
igb_core_vf_load_state() to serialize and restore per-VF device state
through the migration BAR.

The wire format is a versioned blob: header (magic, version, VF
number, register count), offset/value pairs for per-VF registers,
dynamically scanned RA/RA2 entries, and TX context descriptors. PVT
shadow registers (PVTEIMS/PVTEIAC/PVTEIAM) are saved instead of the PF
aggregates which the L1 driver may have transiently cleared.

The load path validates the header, restores registers to mac[], syncs
EITR to eitr_guest_value[], and restores TX context. MSI-X table/PBA
is not saved - L1's VFIO reprograms it after migration.

Assisted-by: Claude
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_core.h      |   1 +
 hw/net/igb.c           |   6 +
 hw/net/igb_migration.c | 277 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 283 insertions(+), 1 deletion(-)

diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index d70b54e318f1..58d4f57c99bb 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -143,4 +143,5 @@ igb_receive_iov(IGBCore *core, const struct iovec *iov, int iovcnt);
 void
 igb_start_recv(IGBCore *core);
 
+IGBCore *igb_pf_get_core(void *pf);
 #endif
diff --git a/hw/net/igb.c b/hw/net/igb.c
index b43235996db2..222413dd237a 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -134,6 +134,12 @@ void igb_vf_reset(void *opaque, uint16_t vfn)
     igb_core_vf_reset(&s->core, vfn);
 }
 
+IGBCore *igb_pf_get_core(void *pf)
+{
+    IGBState *s = IGB(pf);
+    return &s->core;
+}
+
 static bool
 igb_io_get_reg_index(IGBState *s, uint32_t *idx)
 {
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index a0d044815fd9..61cf155a188d 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -75,16 +75,226 @@ bool igbvf_add_migration_cap(PCIDevice *dev, Error **errp)
     return true;
 }
 
+static IGBCore *igbvf_get_core(IgbVfState *s)
+{
+    return igb_pf_get_core(pcie_sriov_get_pf(PCI_DEVICE(s)));
+}
+
 /*
  * =====================================================================
  * Per-VF state serialization / deserialization
  * =====================================================================
+ *
+ * Wire format:
+ *   uint32_t  magic        (IGB_MIG_CAP_MAGIC)
+ *   uint32_t  version      (1)
+ *   uint32_t  vfn          (VF number)
+ *   uint32_t  num_regs     (total register pairs, fixed + RA)
+ *   { uint32_t offset; uint32_t value; } regs[num_regs]
+ *   uint32_t  num_tx_ctx   (number of TX queue context blocks)
+ *   { raw struct igb_tx data } tx_ctx[num_tx_ctx]
  */
 
+/* Maximum number of registers in the VF state slice */
+#define IGB_VF_MAX_REGS 128
+
+/* Register offsets that constitute a VF's state slice */
+static void igb_vf_reg_list(uint16_t vfn, uint32_t *offsets, int *count)
+{
+    int n = 0;
+    int q0 = vfn;
+    int q1 = vfn + IGB_NUM_VM_POOLS;
+
+    /* Per-VF control and interrupt registers */
+    offsets[n++] = E1000_PVTCTRL(vfn) >> 2;
+    offsets[n++] = E1000_PVTEICS(vfn) >> 2;
+    offsets[n++] = E1000_PVTEIMS(vfn) >> 2;
+    offsets[n++] = E1000_PVTEIMC(vfn) >> 2;
+    offsets[n++] = E1000_PVTEIAC(vfn) >> 2;
+    offsets[n++] = E1000_PVTEIAM(vfn) >> 2;
+    offsets[n++] = E1000_PVTEICR(vfn) >> 2;
+
+    /* Per-VF statistics */
+    offsets[n++] = E1000_PVFGPRC(vfn) >> 2;
+    offsets[n++] = E1000_PVFGPTC(vfn) >> 2;
+    offsets[n++] = E1000_PVFGORC(vfn) >> 2;
+    offsets[n++] = E1000_PVFGOTC(vfn) >> 2;
+    offsets[n++] = E1000_PVFMPRC(vfn) >> 2;
+    offsets[n++] = E1000_PVFGPRLBC(vfn) >> 2;
+    offsets[n++] = E1000_PVFGPTLBC(vfn) >> 2;
+    offsets[n++] = E1000_PVFGORLBC(vfn) >> 2;
+    offsets[n++] = E1000_PVFGOTLBC(vfn) >> 2;
+
+    /* Mailbox */
+    offsets[n++] = E1000_V2PMAILBOX(vfn) >> 2;
+    offsets[n++] = E1000_P2VMAILBOX(vfn) >> 2;
+
+    /* Per-VF config */
+    offsets[n++] = E1000_VMOLR(vfn) >> 2;
+    offsets[n++] = E1000_VMVIR(vfn) >> 2;
+    offsets[n++] = E1000_PSRTYPE(vfn) >> 2;
+
+    /*
+     * VF receive addresses (RA/RA2) are saved dynamically in
+     * igb_core_vf_save_state by scanning for entries whose pool
+     * bits match this VF - the PF driver chooses the RA slot.
+     */
+
+    /* Interrupt routing */
+    offsets[n++] = (E1000_VTIVAR + vfn * 4) >> 2;
+    offsets[n++] = (E1000_VTIVAR_MISC + vfn * 4) >> 2;
+
+    /*
+     * EITR (Extended Interrupt Throttle Register) - 3 vectors per VF.
+     * Each VF has 3 MSI-X vectors, each with its own EITR controlling
+     * interrupt coalescing. Without saving these, interrupt
+     * throttling resets to zero after migration which can cause
+     * interrupt storms or latency changes. VF N uses PF EITR indices
+     * (22 - N*3) .. (24 - N*3).
+     */
+    {
+        int eitr_base = 22 - vfn * 3;
+        offsets[n++] = E1000_EITR(eitr_base) >> 2;
+        offsets[n++] = E1000_EITR(eitr_base + 1) >> 2;
+        offsets[n++] = E1000_EITR(eitr_base + 2) >> 2;
+    }
+
+    /* RX and TX queue registers for queues q0 and q1 */
+#define ADD_QUEUE_REGS(q) do { \
+    offsets[n++] = E1000_RDBAL(q) >> 2; \
+    offsets[n++] = E1000_RDBAH(q) >> 2; \
+    offsets[n++] = E1000_RDLEN(q) >> 2; \
+    offsets[n++] = E1000_SRRCTL(q) >> 2; \
+    offsets[n++] = E1000_RDH(q) >> 2; \
+    offsets[n++] = E1000_RDT(q) >> 2; \
+    offsets[n++] = E1000_RXDCTL(q) >> 2; \
+    offsets[n++] = E1000_RXCTL(q) >> 2; \
+    offsets[n++] = E1000_RQDPC(q) >> 2; \
+    offsets[n++] = E1000_TDBAL(q) >> 2; \
+    offsets[n++] = E1000_TDBAH(q) >> 2; \
+    offsets[n++] = E1000_TDLEN(q) >> 2; \
+    offsets[n++] = E1000_TDH(q) >> 2; \
+    offsets[n++] = E1000_TDT(q) >> 2; \
+    offsets[n++] = E1000_TXDCTL(q) >> 2; \
+    offsets[n++] = E1000_TXCTL(q) >> 2; \
+    offsets[n++] = E1000_TDWBAL(q) >> 2; \
+    offsets[n++] = E1000_TDWBAH(q) >> 2; \
+} while (0)
+
+    ADD_QUEUE_REGS(q0);
+    ADD_QUEUE_REGS(q1);
+#undef ADD_QUEUE_REGS
+
+    g_assert(n <= IGB_VF_MAX_REGS);
+    *count = n;
+}
+
+/*
+ * Scan RA and RA2 arrays for receive address entries assigned to
+ * this VF. The PF driver picks the RA slot, so we cannot use a
+ * fixed index - instead check each entry's pool bits.
+ */
+static uint32_t *igb_core_vf_save_ra(IGBCore *core, uint16_t vfn,
+                                     uint32_t *p, int *total_regs)
+{
+    uint32_t vf_pool_bit = E1000_RAH_POOL_1 << vfn;
+    static const struct {
+        uint32_t base;
+        int count;
+    } ra_banks[] = {
+        { RA,  16 },
+        { RA2,  8 },
+    };
+    int i, j;
+
+    for (i = 0; i < ARRAY_SIZE(ra_banks); i++) {
+        for (j = 0; j < ra_banks[i].count; j++) {
+            uint32_t ral_off = ra_banks[i].base + j * 2;
+            uint32_t rah_off = ra_banks[i].base + j * 2 + 1;
+            uint32_t rah_val = core->mac[rah_off];
+
+            if ((rah_val & E1000_RAH_AV) && (rah_val & vf_pool_bit)) {
+                *p++ = cpu_to_le32(ral_off);
+                *p++ = cpu_to_le32(core->mac[ral_off]);
+                *p++ = cpu_to_le32(rah_off);
+                *p++ = cpu_to_le32(rah_val);
+                *total_regs += 2;
+            }
+        }
+    }
+    return p;
+}
+
+static uint32_t *igb_core_vf_save_tx_ctx(IGBCore *core, int queue,
+                                         uint32_t *p)
+{
+    memcpy(p, &core->tx[queue], sizeof(struct igb_tx));
+    return (uint32_t *)((uint8_t *)p + sizeof(struct igb_tx));
+}
+
+static size_t igb_core_vf_state_max_size(int num_fixed_regs)
+{
+    int max_ra_entries = 16 + 8; /* RA bank (16) + RA2 bank (8) */
+    int max_ra_regs = max_ra_entries * 2; /* RAL + RAH per entry */
+
+    return 4 * sizeof(uint32_t)                    /* header */
+         + num_fixed_regs * 2 * sizeof(uint32_t)   /* fixed reg pairs */
+         + max_ra_regs * 2 * sizeof(uint32_t)      /* RA reg pairs */
+         + sizeof(uint32_t)                        /* num_tx_ctx */
+         + 2 * sizeof(struct igb_tx);              /* TX context */
+}
+
 static int igb_core_vf_save_state(IgbVfState *s,
                                   void *buf, size_t buf_size)
 {
-    int size = 0;
+    IGBCore *core = igbvf_get_core(s);
+    uint32_t offsets[IGB_VF_MAX_REGS];
+    int num_regs, total_regs;
+    uint32_t *p = buf;
+    uint32_t *num_regs_p;
+    int i, size;
+    int q0 = s->vfn;
+    int q1 = s->vfn + IGB_NUM_VM_POOLS;
+
+    /*
+     * Save PVT shadow registers (PVTEIMS/PVTEIAC/PVTEIAM) instead of
+     * extracting from PF aggregates - the L1 PF driver may have
+     * transiently cleared EIMS via EIMC. The load path ORs them back.
+     */
+    igb_vf_reg_list(s->vfn, offsets, &num_regs);
+
+    if (!buf) {
+        return igb_core_vf_state_max_size(num_regs);
+    }
+
+    if (igb_core_vf_state_max_size(num_regs) > buf_size) {
+        return -IGB_MIG_ERR_BAD_SIZE;
+    }
+
+    /* Header: magic, version, vfn, num_regs (updated below) */
+    *p++ = cpu_to_le32(IGB_MIG_CAP_MAGIC);
+    *p++ = cpu_to_le32(1); /* version */
+    *p++ = cpu_to_le32(s->vfn);
+    num_regs_p = p;
+    *p++ = cpu_to_le32(num_regs);
+
+    for (i = 0; i < num_regs; i++) {
+        *p++ = cpu_to_le32(offsets[i]);
+        *p++ = cpu_to_le32(core->mac[offsets[i]]);
+    }
+
+    total_regs = num_regs;
+
+    p = igb_core_vf_save_ra(core, s->vfn, p, &total_regs);
+
+    *num_regs_p = cpu_to_le32(total_regs);
+
+    /* TX context descriptors for this VF's two queues */
+    *p++ = cpu_to_le32(2); /* num_tx_ctx */
+    p = igb_core_vf_save_tx_ctx(core, q0, p);
+    p = igb_core_vf_save_tx_ctx(core, q1, p);
+
+    size = (uint8_t *)p - (uint8_t *)buf;
 
     trace_igbvf_mig_save_state(s->vfn, size);
     return size;
@@ -98,9 +308,74 @@ static int igb_core_vf_max_data_size(IgbVfState *s)
     return size;
 }
 
+static const void *igb_core_vf_load_tx_ctx(IGBCore *core, int queue,
+                                           const void *data)
+{
+    struct NetTxPkt *saved_pkt = core->tx[queue].tx_pkt;
+
+    memcpy(&core->tx[queue], data, sizeof(struct igb_tx));
+    core->tx[queue].tx_pkt = saved_pkt;
+    return (const uint8_t *)data + sizeof(struct igb_tx);
+}
+
 static int igb_core_vf_load_state(IgbVfState *s,
                                   const void *buf, size_t size)
 {
+    IGBCore *core = igbvf_get_core(s);
+    const uint32_t *p = buf;
+    uint32_t magic, version, saved_vfn, num_regs, num_tx;
+    int i;
+    int q0 = s->vfn;
+    int q1 = s->vfn + IGB_NUM_VM_POOLS;
+
+    magic = le32_to_cpu(*p++);
+    version = le32_to_cpu(*p++);
+    saved_vfn = le32_to_cpu(*p++);
+    num_regs = le32_to_cpu(*p++);
+
+    if (magic != IGB_MIG_CAP_MAGIC) {
+        return -IGB_MIG_ERR_BAD_MAGIC;
+    }
+    if (version != IGB_MIG_CAP_VERSION) {
+        return -IGB_MIG_ERR_BAD_VERSION;
+    }
+    if (saved_vfn != s->vfn) {
+        return -IGB_MIG_ERR_BAD_VFN;
+    }
+    if (num_regs > IGB_VF_MAX_REGS) {
+        return -IGB_MIG_ERR_BAD_SIZE;
+    }
+
+    for (i = 0; i < num_regs; i++) {
+        uint32_t offset = le32_to_cpu(*p++);
+        uint32_t value = le32_to_cpu(*p++);
+
+        if (offset < E1000E_MAC_SIZE) {
+            core->mac[offset] = value;
+
+            /*
+             * Sync EITR to eitr_guest_value[] shadow array, stripping
+             * E1000_EITR_CNT_IGNR so guest register readback returns
+             * the correct value.
+             */
+            if (offset >= EITR0 && offset < EITR0 + IGB_INTR_NUM) {
+                core->eitr_guest_value[offset - EITR0] =
+                    value & ~E1000_EITR_CNT_IGNR;
+            }
+        }
+    }
+
+    num_tx = le32_to_cpu(*p++);
+    if (num_tx == 2) {
+        p = igb_core_vf_load_tx_ctx(core, q0, p);
+        p = igb_core_vf_load_tx_ctx(core, q1, p);
+    }
+
+    /*
+     * MSI-X table/PBA is not saved - L1's VFIO reprograms it with
+     * destination-specific IRTE references after migration.
+     */
+
     trace_igbvf_mig_load_state(s->vfn, (uint32_t)size);
     return 0;
 }
-- 
2.55.0


