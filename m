Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973ECCC6B27
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGue6-0005Qa-DO; Wed, 14 Oct 2026 04:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGue0-0005Nx-I9
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGudy-0004YF-Jy
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZlevP+DQ07XzyAne81NaqJe5jnhgHMpuZdVBuSnyelE=;
 b=QgYkOmesbWPsnHF41uRh3EUFsytxilFV6AW2QuZSoZG7InoJtP7Z9dbDnHMMgrIVfvZov7
 z5rdpOjA5WvL35zmrWWfRJQPOLUpMd1UxQ+kZrWoq7h9uZTEqk4z/SOZcJZPwvQ3mF5K0v
 OdoMZ3vN4G8IyBLxP95HJzTnvGZ4ESw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-h-eZ8RY9P5CnaGsDxh6Wbw-1; Wed,
 14 Oct 2026 08:47:20 +0000
X-MC-Unique: h-eZ8RY9P5CnaGsDxh6Wbw-1
X-Mimecast-MFC-AGG-ID: h-eZ8RY9P5CnaGsDxh6Wbw_1791967639
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 825F519560B4; Wed, 14 Oct 2026 08:47:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34D5B1800446; Wed, 14 Oct 2026 08:47:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v3 05/17] igb: Add VF register state serialization
Date: Wed, 14 Oct 2026 10:46:43 +0200
Message-ID: <20261014084655.127254-6-clg@redhat.com>
In-Reply-To: <20261014084655.127254-1-clg@redhat.com>
References: <20261014084655.127254-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Add save/load support for the per-VF register slice: control,
interrupt (PVT), statistics, mailbox control, per-VF config
(VMOLR/VMVIR/PSRTYPE), interrupt routing (VTIVAR), throttle
registers (EITR), and the two RX/TX queue register sets.

The register list is built dynamically by igb_vf_reg_list() so the
load path can validate that the blob contains exactly the expected
offsets, rejecting corrupted or version-mismatched blobs before any
state is modified.

Expose igb_pf_get_core() so the migration code in igbvf can reach
the PF's IGBCore.

AI-used-for: analysis, code (prototype)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_core.h      |   2 +
 hw/net/igb.c           |   5 ++
 hw/net/igb_migration.c | 170 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 176 insertions(+), 1 deletion(-)

diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index d70b54e318f1..60724e2824ab 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -143,4 +143,6 @@ igb_receive_iov(IGBCore *core, const struct iovec *iov, int iovcnt);
 void
 igb_start_recv(IGBCore *core);
 
+IGBCore *igb_pf_get_core(void *pf);
+
 #endif
diff --git a/hw/net/igb.c b/hw/net/igb.c
index 7268e5473fc3..f39f2bc3a04e 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -133,6 +133,11 @@ void igb_vf_reset(void *opaque, uint16_t vfn)
     igb_core_vf_reset(&s->core, vfn);
 }
 
+IGBCore *igb_pf_get_core(void *pf)
+{
+    return &IGB(pf)->core;
+}
+
 static bool
 igb_io_get_reg_index(IGBState *s, uint32_t *idx)
 {
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index de982909bbf2..0c21a5e45f32 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -10,11 +10,19 @@
 #include "qemu/log.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pcie.h"
+#include "net/eth.h"
+#include "net/net.h"
 #include "igb_common.h"
+#include "igb_core.h"
 #include "igb_migration.h"
 #include "system/address-spaces.h"
 #include "trace.h"
 
+static IGBCore *igbvf_get_core(IgbVfState *s)
+{
+    return igb_pf_get_core(pcie_sriov_get_pf(PCI_DEVICE(s)));
+}
+
 /*
  * Per-VF state serialization / deserialization
  */
@@ -22,21 +30,125 @@
 #define IGB_MIG_BLOB_MAGIC        0x4D494742  /* "MIGB" */
 #define IGB_MIG_BLOB_VERSION      1
 
+typedef struct IgbMigRegPair {
+    uint32_t offset;
+    uint32_t value;
+} IgbMigRegPair;
+
+#define IGB_VF_MAX_FIXED_REGS     64
+
 typedef struct IgbMigBlob {
     uint32_t magic;
     uint32_t version;
     uint32_t vfn;
+    uint32_t num_regs;
+    IgbMigRegPair regs[IGB_VF_MAX_FIXED_REGS];
 } IgbMigBlob;
 
 #define IGB_MIG_BLOB_SIZE            sizeof(IgbMigBlob)
 
 QEMU_BUILD_BUG_ON(IGB_MIG_BLOB_SIZE > IGB_VF_STATE_MAX_SIZE);
 
+/* Register offsets that constitute a VF's state slice */
+static int igb_vf_reg_list(uint16_t vfn, uint32_t *offsets)
+{
+    int n = 0;
+    int q0 = vfn;
+    int q1 = vfn + IGB_NUM_VM_POOLS;
+
+    /* Per-VF control and interrupt registers */
+    offsets[n++] = E1000_PVTCTRL(vfn) >> 2;
+    offsets[n++] = E1000_PVTEICS(vfn) >> 2;
+    offsets[n++] = E1000_PVTEIMC(vfn) >> 2;
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
+    /*
+     * Mailbox control registers only - the 16-dword payload buffer
+     * (VMBMEM) is transient and drained on quiesce.
+     */
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
+    g_assert(n <= IGB_VF_MAX_FIXED_REGS);
+    return n;
+}
 
 static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
 {
     int size = IGB_MIG_BLOB_SIZE;
+    IGBCore *core = igbvf_get_core(s);
     IgbMigBlob *blob = buf;
+    uint32_t offsets[IGB_VF_MAX_FIXED_REGS];
+    int num_regs;
+
+    num_regs = igb_vf_reg_list(s->vfn, offsets);
 
     if (!buf) {
         return size;
@@ -50,6 +162,12 @@ static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
     blob->version = cpu_to_le32(IGB_MIG_BLOB_VERSION);
     blob->vfn = cpu_to_le32(s->vfn);
 
+    blob->num_regs = cpu_to_le32(num_regs);
+    for (int i = 0; i < num_regs; i++) {
+        blob->regs[i].offset = cpu_to_le32(offsets[i]);
+        blob->regs[i].value = cpu_to_le32(core->mac[offsets[i]]);
+    }
+
     trace_igbvf_mig_save_state(s->vfn, size);
     return size;
 }
@@ -62,10 +180,34 @@ static int igb_core_vf_max_data_size(IgbVfState *s)
     return size;
 }
 
+static bool igb_core_vf_validate_regs(uint16_t vfn,
+                                      const IgbMigRegPair *regs,
+                                      uint32_t num_regs)
+{
+    uint32_t expected[IGB_VF_MAX_FIXED_REGS];
+    int num_expected;
+
+    if (num_regs > IGB_VF_MAX_FIXED_REGS) {
+        return false;
+    }
+
+    num_expected = igb_vf_reg_list(vfn, expected);
+    if (num_regs != num_expected) {
+        return false;
+    }
+    for (int i = 0; i < num_regs; i++) {
+        if (le32_to_cpu(regs[i].offset) != expected[i]) {
+            return false;
+        }
+    }
+    return true;
+}
+
 static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
 {
+    IGBCore *core = igbvf_get_core(s);
     const IgbMigBlob *blob = buf;
-    uint32_t magic, version, saved_vfn;
+    uint32_t magic, version, saved_vfn, num_regs;
 
     /* Validate blob header */
     if (size < IGB_MIG_BLOB_SIZE) {
@@ -85,6 +227,32 @@ static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
         return -IGB_MIG_ERR_BAD_VFN;
     }
 
+    /*
+     * Phase 1: Validate blob state before modifying any core state.
+     * A malformed blob must not leave the device partially updated.
+     */
+    num_regs = le32_to_cpu(blob->num_regs);
+    if (!igb_core_vf_validate_regs(s->vfn, blob->regs, num_regs)) {
+        return -IGB_MIG_ERR_BAD_DATA;
+    }
+
+    /*
+     * Phase 2: Apply state.  All offsets and placements are
+     * validated; writes cannot fail.
+     */
+    for (int i = 0; i < num_regs; i++) {
+        uint32_t offset = le32_to_cpu(blob->regs[i].offset);
+        uint32_t value = le32_to_cpu(blob->regs[i].value);
+
+        core->mac[offset] = value;
+
+        /* Replicate igb_set_eitr() side effect bypassed by direct write */
+        if (offset >= EITR0 && offset < EITR0 + IGB_INTR_NUM) {
+            core->eitr_guest_value[offset - EITR0] =
+                value & ~E1000_EITR_CNT_IGNR;
+        }
+    }
+
     trace_igbvf_mig_load_state(s->vfn, (uint32_t)size);
     return 0;
 }
-- 
2.56.0


