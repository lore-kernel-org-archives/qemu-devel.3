Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76B4CC6B27
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGue5-0005QJ-Oa; Wed, 14 Oct 2026 04:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGudx-0005LZ-DN
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGudv-0004Y9-C3
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kn5ZMZk6eONf2Ptxa2axdEu8YJ5ExnL3tTNQ7WcxxXA=;
 b=GZCuiZwQ1bxHFpNT4Xi7PLOzUyy3aFrejcaqPVm6FY0upDA2MlDFf35AIe+Su0eJTB6Id0
 HI4pNlhnvyfUUBEkAXh1eqLW/0eRloTlXPcYL2nUZosHPoOPCziLP6u6tu2DLa97DWcV82
 ATRgTgxjOSesiWgQudN9Ug9Aqs2Q+tw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-D8nvQTdjPcurx0kbbSF7KQ-1; Wed,
 14 Oct 2026 08:47:15 +0000
X-MC-Unique: D8nvQTdjPcurx0kbbSF7KQ-1
X-Mimecast-MFC-AGG-ID: D8nvQTdjPcurx0kbbSF7KQ_1791967634
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B561018005B2; Wed, 14 Oct 2026 08:47:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3826C1803A40; Wed, 14 Oct 2026 08:47:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v3 03/17] igb: Add migration state machine via extended
 config space
Date: Wed, 14 Oct 2026 10:46:41 +0200
Message-ID: <20261014084655.127254-4-clg@redhat.com>
In-Reply-To: <20261014084655.127254-1-clg@redhat.com>
References: <20261014084655.127254-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Implement the VFIO migration v2 state machine and command dispatch
through the CTRL doorbell register in the DVSEC capability.

Add three CTRL commands:
 - SET_STATE: transitions follow the VFIO migration protocol
     RUNNING <-> STOP
     STOP <-> STOP_COPY
     STOP <-> RESUMING
     ERROR -> STOP
 - SAVE: DMA-writes the device state to a guest buffer
 - LOAD: DMA-reads it back

Add a DATA_SIZE register to report the state blob size. The save/load
stubs are filled in by the next patch.

AI-used-for: code (prototype)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_migration.h |  25 ++++-
 hw/net/igb_migration.c | 237 ++++++++++++++++++++++++++++++++++++++++-
 hw/net/trace-events    |   8 ++
 3 files changed, 268 insertions(+), 2 deletions(-)

diff --git a/hw/net/igb_migration.h b/hw/net/igb_migration.h
index ae1c85c9d553..34d643854a28 100644
--- a/hw/net/igb_migration.h
+++ b/hw/net/igb_migration.h
@@ -26,10 +26,11 @@
  *   +0x14  STATUS                     (RO: state[7:0], error_code[15:8])
  *   +0x18  BUF_ADDR_LO                (RW: shared buffer GPA low)
  *   +0x1C  BUF_ADDR_HI                (RW: shared buffer GPA high)
+ *   +0x20  DATA_SIZE                  (RO: state blob size in bytes)
  */
 
 #define IGB_MIG_DVSEC_OFFSET    0x160
-#define IGB_MIG_DVSEC_SIZE      0x20
+#define IGB_MIG_DVSEC_SIZE      0x24
 #define IGB_MIG_DVSEC_VER       1
 #define IGB_MIG_DVSEC_ID        1
 
@@ -39,10 +40,20 @@
 #define IGB_MIG_STATUS          0x14
 #define IGB_MIG_BUF_ADDR_LO     0x18
 #define IGB_MIG_BUF_ADDR_HI     0x1C
+#define IGB_MIG_DATA_SIZE       0x20
 
 /* CAPS register layout */
 #define IGB_MIG_CAP_F_STATE             (1u << 0)
 
+/* CTRL register: command in [7:0] */
+#define IGB_MIG_CTRL_CMD_MASK           0xFF
+#define IGB_MIG_CTRL_ARG_SHIFT          8
+
+/* CTRL commands */
+#define IGB_MIG_CMD_SET_STATE           1
+#define IGB_MIG_CMD_SAVE                2
+#define IGB_MIG_CMD_LOAD                3
+
 /* STATUS register: state in [7:0], error code [15:8] */
 #define IGB_MIG_STATUS_STATE_MASK       0xFF
 #define IGB_MIG_STATUS_ERROR_CODE_SHIFT 8
@@ -56,8 +67,20 @@
 #define IGB_MIG_STATE_STOP_COPY         3
 #define IGB_MIG_STATE_RESUMING          4
 
+/* Error codes */
+#define IGB_MIG_ERR_UNK_CMD             1
+#define IGB_MIG_ERR_BAD_STATE           2
+#define IGB_MIG_ERR_NO_BUFFER           3
+#define IGB_MIG_ERR_DMA_FAILED          4
+#define IGB_MIG_ERR_BAD_SIZE            5
+
+/* Shared buffer constants */
+#define IGB_VF_STATE_MAX_SIZE           4096
+
 typedef struct IgbVfMigState {
     uint32_t mig_state;
+    uint32_t mig_data[IGB_VF_STATE_MAX_SIZE / sizeof(uint32_t)];
+    uint32_t mig_data_size;
     uint64_t mig_data_buf_addr;
 } IgbVfMigState;
 
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index 7ed722f6f0e1..174df22232a5 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -7,10 +7,231 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pcie.h"
 #include "igb_common.h"
 #include "igb_migration.h"
+#include "system/address-spaces.h"
+#include "trace.h"
+
+/*
+ * Per-VF state serialization / deserialization
+ */
+
+static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
+{
+    int size = 0;
+
+    trace_igbvf_mig_save_state(s->vfn, size);
+    return size;
+}
+
+static int igb_core_vf_max_data_size(IgbVfState *s)
+{
+    return sizeof(s->mig.mig_data);
+}
+
+static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
+{
+    trace_igbvf_mig_load_state(s->vfn, (uint32_t)size);
+    return 0;
+}
+
+static int igbvf_mig_load(IgbVfState *s, const void *buf, size_t size)
+{
+    int ret;
+
+    ret = igb_core_vf_load_state(s, buf, size);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
+}
+
+/*
+ * Migration command handlers
+ */
+
+static void igbvf_mig_update_data_size(IgbVfState *s, uint32_t size)
+{
+    IgbVfMigState *ms = &s->mig;
+
+    g_assert(size <= IGB_VF_STATE_MAX_SIZE);
+    ms->mig_data_size = size;
+    pci_set_long(PCI_DEVICE(s)->config +
+                 IGB_MIG_DVSEC_OFFSET + IGB_MIG_DATA_SIZE, size);
+}
+
+static uint8_t igbvf_mig_cmd_save(IgbVfState *s)
+{
+    IgbVfMigState *ms = &s->mig;
+    MemTxResult r;
+    int ret;
+
+    if (ms->mig_state != IGB_MIG_STATE_STOP_COPY) {
+        return IGB_MIG_ERR_BAD_STATE;
+    }
+
+    if (!ms->mig_data_buf_addr) {
+        return IGB_MIG_ERR_NO_BUFFER;
+    }
+
+    ret = igb_core_vf_save_state(s, ms->mig_data, sizeof(ms->mig_data));
+    if (ret < 0) {
+        return -ret;
+    }
+    igbvf_mig_update_data_size(s, ret);
+
+    r = address_space_write(&address_space_memory, ms->mig_data_buf_addr,
+                            MEMTXATTRS_UNSPECIFIED,
+                            ms->mig_data, ms->mig_data_size);
+    if (r != MEMTX_OK) {
+        return IGB_MIG_ERR_DMA_FAILED;
+    }
+
+    return 0;
+}
+
+static uint8_t igbvf_mig_cmd_load(IgbVfState *s, uint32_t data_size)
+{
+    IgbVfMigState *ms = &s->mig;
+    MemTxResult r;
+    int ret;
+
+    if (ms->mig_state != IGB_MIG_STATE_RESUMING) {
+        return IGB_MIG_ERR_BAD_STATE;
+    }
+
+    if (data_size == 0 || data_size > sizeof(ms->mig_data)) {
+        return IGB_MIG_ERR_BAD_SIZE;
+    }
+
+    igbvf_mig_update_data_size(s, data_size);
+
+    if (!ms->mig_data_buf_addr) {
+        return IGB_MIG_ERR_NO_BUFFER;
+    }
+
+    r = address_space_read(&address_space_memory, ms->mig_data_buf_addr,
+                           MEMTXATTRS_UNSPECIFIED,
+                           ms->mig_data, ms->mig_data_size);
+    if (r != MEMTX_OK) {
+        return IGB_MIG_ERR_DMA_FAILED;
+    }
+
+    ret = igbvf_mig_load(s, ms->mig_data, ms->mig_data_size);
+    if (ret < 0) {
+        return -ret;
+    }
+
+    return 0;
+}
+
+static uint8_t igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
+{
+    IgbVfMigState *ms = &s->mig;
+    uint32_t old = ms->mig_state;
+    int ret;
+
+    switch (new_state) {
+    case IGB_MIG_STATE_STOP:
+        if (old != IGB_MIG_STATE_RUNNING &&
+            old != IGB_MIG_STATE_STOP_COPY &&
+            old != IGB_MIG_STATE_RESUMING &&
+            old != IGB_MIG_STATE_ERROR) {
+            return IGB_MIG_ERR_BAD_STATE;
+        }
+        /* Restore DATA_SIZE to default max */
+        igbvf_mig_update_data_size(s, igb_core_vf_max_data_size(s));
+        break;
+
+    case IGB_MIG_STATE_RUNNING:
+        if (old != IGB_MIG_STATE_STOP) {
+            return IGB_MIG_ERR_BAD_STATE;
+        }
+        break;
+
+    case IGB_MIG_STATE_STOP_COPY:
+        if (old != IGB_MIG_STATE_STOP) {
+            return IGB_MIG_ERR_BAD_STATE;
+        }
+        ret = igb_core_vf_save_state(s, ms->mig_data, sizeof(ms->mig_data));
+        if (ret < 0) {
+            return -ret;
+        }
+        igbvf_mig_update_data_size(s, ret);
+        break;
+
+    case IGB_MIG_STATE_RESUMING:
+        if (old != IGB_MIG_STATE_STOP) {
+            return IGB_MIG_ERR_BAD_STATE;
+        }
+        memset(ms->mig_data, 0, sizeof(ms->mig_data));
+        igbvf_mig_update_data_size(s, 0);
+        break;
+
+    default:
+        return IGB_MIG_ERR_BAD_STATE;
+    }
+
+    ms->mig_state = new_state;
+    trace_igbvf_mig_set_state(s->vfn, old, new_state);
+    return 0;
+}
+
+static void igbvf_mig_update_status(IgbVfState *s, uint8_t err)
+{
+    IgbVfMigState *ms = &s->mig;
+    PCIDevice *dev = PCI_DEVICE(s);
+    uint32_t status;
+
+    status = ms->mig_state & IGB_MIG_STATUS_STATE_MASK;
+
+    if (err) {
+        ms->mig_state = IGB_MIG_STATE_ERROR;
+        status = IGB_MIG_STATE_ERROR | IGB_MIG_STATUS_ERR(err);
+    }
+
+    pci_set_long(dev->config + IGB_MIG_DVSEC_OFFSET + IGB_MIG_STATUS, status);
+    trace_igbvf_mig_status(s->vfn, status);
+}
+
+static void igbvf_mig_cmd_ctrl(IgbVfState *s, uint32_t val)
+{
+    IgbVfMigState *ms = &s->mig;
+    uint32_t cmd = val & IGB_MIG_CTRL_CMD_MASK;
+    uint32_t arg = val >> IGB_MIG_CTRL_ARG_SHIFT;
+    uint8_t err = 0;
+
+    trace_igbvf_mig_cmd(s->vfn, cmd, arg, ms->mig_state);
+
+    switch (cmd) {
+    case IGB_MIG_CMD_SET_STATE:
+        err = igbvf_mig_set_state(s, arg);
+        break;
+
+    case IGB_MIG_CMD_SAVE:
+        err = igbvf_mig_cmd_save(s);
+        break;
+
+    case IGB_MIG_CMD_LOAD:
+        err = igbvf_mig_cmd_load(s, arg);
+        break;
+
+    default:
+        err = IGB_MIG_ERR_UNK_CMD;
+        break;
+    }
+
+    if (err) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "igbvf: VF%u CTRL cmd %u failed (error %u)\n",
+                      s->vfn, cmd, err);
+    }
+    igbvf_mig_update_status(s, err);
+}
 
 bool igbvf_add_migration_dvsec(IgbVfState *s, Error **errp)
 {
@@ -52,6 +273,9 @@ bool igbvf_add_migration_dvsec(IgbVfState *s, Error **errp)
     memset(dev->wmask + offset + IGB_MIG_BUF_ADDR_LO, 0xff, 4);
     memset(dev->wmask + offset + IGB_MIG_BUF_ADDR_HI, 0xff, 4);
 
+    /* DATA_SIZE defaults to max; updated per command */
+    igbvf_mig_update_data_size(s, igb_core_vf_max_data_size(s));
+
     return true;
 }
 
@@ -62,6 +286,16 @@ uint32_t igbvf_mig_config_read(IgbVfState *s, uint32_t addr, int size)
     return pci_default_read_config(dev, addr, size);
 }
 
+static uint64_t igbvf_mig_get_buf_addr(IgbVfState *s)
+{
+    PCIDevice *dev = PCI_DEVICE(s);
+    uint32_t lo, hi;
+
+    lo = pci_get_long(dev->config + IGB_MIG_DVSEC_OFFSET + IGB_MIG_BUF_ADDR_LO);
+    hi = pci_get_long(dev->config + IGB_MIG_DVSEC_OFFSET + IGB_MIG_BUF_ADDR_HI);
+    return ((uint64_t)hi << 32) | lo;
+}
+
 bool igbvf_mig_config_write(IgbVfState *s, uint32_t addr, uint32_t val,
                             int size)
 {
@@ -70,7 +304,8 @@ bool igbvf_mig_config_write(IgbVfState *s, uint32_t addr, uint32_t val,
 
     switch (offset) {
     case IGB_MIG_CTRL:
-        /* Command handling will be added in a later commit */
+        s->mig.mig_data_buf_addr = igbvf_mig_get_buf_addr(s);
+        igbvf_mig_cmd_ctrl(s, val);
         break;
 
     case IGB_MIG_BUF_ADDR_LO:
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 001a20b0e2ac..23f6dbcfed82 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -295,6 +295,14 @@ igb_wrn_rx_desc_modes_not_supp(int desc_type) "Not supported descriptor type: %d
 # igbvf.c
 igbvf_wrn_io_addr_unknown(uint64_t addr) "IO unknown register 0x%"PRIx64
 
+# igb_migration.c
+igbvf_mig_cmd(uint16_t vfn, uint32_t cmd, uint32_t arg, uint32_t state) "VF%u: cmd %u arg %u (mig_state=%u)"
+igbvf_mig_status(uint16_t vfn, uint32_t status) "VF%u: status 0x%x"
+igbvf_mig_set_state(uint16_t vfn, uint32_t old_state, uint32_t new_state) "VF%u: state %u -> %u"
+igbvf_mig_save_state(uint16_t vfn, uint32_t size) "VF%u: saved %u bytes of device state"
+igbvf_mig_load_state(uint16_t vfn, uint32_t size) "VF%u: loaded %u bytes of device state"
+igbvf_mig_reset(uint16_t vfn) "VF%u: migration state reset"
+
 # spapr_llan.c
 spapr_vlan_get_rx_bd_from_pool_found(int pool, int32_t count, uint32_t rx_bufs) "pool=%d count=%"PRId32" rxbufs=%"PRIu32
 spapr_vlan_get_rx_bd_from_page(int buf_ptr, uint64_t bd) "use_buf_ptr=%d bd=0x%016"PRIx64
-- 
2.56.0


