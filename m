Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F97ECD9A2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 19:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5VR-0006n1-Ox; Thu, 05 Feb 2026 14:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VQ-0006lO-L7
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:12 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VM-00037U-5P
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:12 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so20249285e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321546; x=1770926346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WJgihbxir9TVndoVLKFcaPLnULrfVxu1EQyax/iuZuY=;
 b=dxP0q/aN7suTqBcdTW+rHZUGQKT9hWcUakT4BrWXNBAp/LIfEqDnE7YHL3JcJ+niqa
 IwG5vqWeL/VmfeRzf61C+T+F87kD0ERSKy8MuX7WiZjiq1Sin8f/Lb2viiYwxAmSAiPV
 ccgCWYQjOobuC8rZg/v/DrqO8G3kNNmuBuKu7Zre6LSLgXbwB32E00Tl4gay77INsdpf
 GnfWNBf2oPNsn2m1yQEu4MXiZN8l1QjOkO0V9GIDLPNwovTN+ArpSx2mV6AxdI7BMWrE
 qdHSrsDRS9EnGIYb0XzYnwVj+GLU7xnD5HecCbb7vfvNRGezL/EfhKphkAfOmvGXAzWO
 6BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321546; x=1770926346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WJgihbxir9TVndoVLKFcaPLnULrfVxu1EQyax/iuZuY=;
 b=XSkOFDi9dgxnsd/PTAN7XFKQwEnrG0YtJ+jIKVeaUGRPPW8VAbYuJ0AStY7cai8ehO
 +XlPoLNEqjpRfNEFsiHOZOryFF81PvgoVt3IWXT+g5bXZKbIn+9M7HnG0czloZlm1j6Q
 2EIJWv0lYxCNR1V6e/z9NPtCoTJTLP0BfbIVRuKbEQFYkNFGzRh+su4FGFcvk3hOag6o
 3nqAcKLRkNfgqrVFkH7CMuycO1FJB1+/ksU4abnHV1CcxHQKj3SBFZL6rr4Q3GqfDpdK
 qLBLj56bSJsfBMLe8oXOwkNYq6iri+aCpr9R3bKS/sT8KIdc9Hq60U5wTNmLeqv6Lg5+
 eGJQ==
X-Gm-Message-State: AOJu0YyJBDvvdKTf/1IhuWD+DmrUGmls45+6NomJ12YvvV7DCXkmwkaU
 Q8OZxoB2A4gec4MAgc020wFPrWMnpxFFfzHczngISaHpQi4rjCS/GmWLgT9axMCeUTo=
X-Gm-Gg: AZuq6aIDemGreN9D9Nnqm1odCP2crRjxS9xm/93pAFbOLZfAX0DF8ltULtiZ9MoXv50
 zKzq9rYYV60nzH3UWoRc5EksF89ksObDUZdXPOXYSeFxm1vL0Cwq4fG9Gj3S2/XUw5VbzfM0gSl
 yvTughzr08ZzeZtHGtVbofrt1UegxPIlTL92LXWbpOAyjMB2ElzY833v4fiir9ax+fqdsecY8wt
 7rfPl0eLmLFJWyTLQJYnKYzLI8d296Z+XnGT1HerXr4QqIHqvV0zQ+dJZfCcdW/4S7wmVML2w04
 dnmsLPQCKRAIOl6UuoWroPYS8fneKSDAksp9VShky8Pnv1ocqU/7Sy1AwxKqKUulCOFeuk8CwlA
 wfyz37LV47keXlQKbDP/TCap5vcFv1wiEi0f2fkopGfmf0h8TtqvB1RfKFtd55KS5nUqcsUEgJ9
 5IHkJ8An4ev7er7hip0l5EACQoQ+3dmQ==
X-Received: by 2002:a05:600c:6285:b0:47e:e87b:af8 with SMTP id
 5b1f17b1804b1-48320231170mr7487375e9.21.1770321546222; 
 Thu, 05 Feb 2026 11:59:06 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:59:05 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 15/29] hw/core: Implement Remote Port Memory Master bus
 transactions
Date: Thu,  5 Feb 2026 20:58:10 +0100
Message-ID: <20260205195824.2610192-16-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Implement the core access handlers for the Remote Port Memory
Master device, which enables QEMU to initiate memory-mapped
transaction to remote peers.

The patch adds support for:
- Translation of QEMU MemoryTransactions into Remote Port
read/write packets
- Support for propagating of transaction attributes
(Secure, MasterID)
- Synchronous response waiting with optional timeout
- Add trace events for monitoring TX/RX bus transactions

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-memory-master.c | 167 +++++++++++++++++++++++++++-
 hw/core/remote-port.c               |   5 +
 hw/core/trace-events                |   4 +
 include/hw/core/remote-port.h       |  11 ++
 4 files changed, 185 insertions(+), 2 deletions(-)

diff --git a/hw/core/remote-port-memory-master.c b/hw/core/remote-port-memory-master.c
index d714f66ddf..4a6c43423d 100644
--- a/hw/core/remote-port-memory-master.c
+++ b/hw/core/remote-port-memory-master.c
@@ -41,10 +41,173 @@
 
 #define RP_MAX_ACCESS_SIZE 4096
 
+static int rp_mm_get_timeout(MemoryTransaction *tr)
+{
+    RemotePortMap *map = tr->opaque;
+    RemotePortMemoryMaster *s;
+
+    if (!map || !map->parent ||
+        !object_dynamic_cast(OBJECT(map->parent),
+                             TYPE_REMOTE_PORT_MEMORY_MASTER)) {
+        return 0;
+    }
+    s = REMOTE_PORT_MEMORY_MASTER(map->parent);
+    return s->rp_timeout;
+}
+
+MemTxResult rp_mm_access_with_def_attr(RemotePort *rp, uint32_t rp_dev,
+                                       struct rp_peer_state *peer,
+                                       MemoryTransaction *tr,
+                                       bool relative, uint64_t offset,
+                                       uint32_t def_attr)
+{
+    uint64_t addr = tr->addr;
+    RemotePortRespSlot *rsp_slot;
+    RemotePortDynPkt *rsp;
+    struct  {
+        struct rp_pkt_busaccess_ext_base pkt;
+        uint8_t reserved[RP_MAX_ACCESS_SIZE];
+    } pay;
+    uint8_t *data = rp_busaccess_tx_dataptr(peer, &pay.pkt);
+    struct rp_encode_busaccess_in in = {0};
+    int i;
+    int len;
+    int rp_timeout = rp_mm_get_timeout(tr);
+    MemTxResult ret;
+
+    if (rp_timeout) {
+        return MEMTX_ERROR;
+    }
+    DB_PRINT_L(0, "addr: %" HWADDR_PRIx " data: %" PRIx64 "\n",
+               addr, tr->data.u64);
+
+    if (tr->rw) {
+        /* Data up to 8 bytes is passed as values.  */
+        if (tr->size <= 8) {
+            for (i = 0; i < tr->size; i++) {
+                data[i] = tr->data.u64 >> (i * 8);
+            }
+        } else {
+            memcpy(data, tr->data.p8, tr->size);
+        }
+    }
+
+    addr += relative ? 0 : offset;
+
+    in.cmd = tr->rw ? RP_CMD_write : RP_CMD_read;
+    in.id = rp_new_id(rp);
+    in.dev = rp_dev;
+    in.clk = rp_normalized_vmclk(rp);
+    in.master_id = tr->attr.requester_id;
+    in.addr = addr;
+    in.attr = def_attr;
+    in.attr |= tr->attr.secure ? RP_BUS_ATTR_SECURE : 0;
+    in.size = tr->size;
+    in.stream_width = tr->size;
+    len = rp_encode_busaccess(peer, &pay.pkt, &in);
+    len += tr->rw ? tr->size : 0;
+
+    trace_remote_port_memory_master_tx_busaccess(rp_cmd_to_string(in.cmd),
+        in.id, in.flags, in.dev, in.addr, in.size, in.attr);
+
+    rp_rsp_mutex_lock(rp);
+    rp_write(rp, (void *) &pay, len);
+
+    if (!rp_timeout) {
+        rsp_slot = rp_dev_wait_resp(rp, in.dev, in.id);
+    } else {
+        rsp_slot = rp_dev_timed_wait_resp(rp, in.dev, in.id, rp_timeout);
+        if (rsp_slot->valid == false) {
+            /*
+             * Timeout error
+             */
+            rp_rsp_mutex_unlock(rp);
+            return MEMTX_ERROR;
+        }
+    }
+    rsp = &rsp_slot->rsp;
+
+    /* We dont support out of order answers yet.  */
+    assert(rsp->pkt->hdr.id == in.id);
+
+    switch (rp_get_busaccess_response(rsp->pkt)) {
+    case RP_RESP_OK:
+        ret = MEMTX_OK;
+        break;
+    case RP_RESP_ADDR_ERROR:
+        ret = MEMTX_DECODE_ERROR;
+        break;
+    default:
+        ret = MEMTX_ERROR;
+        break;
+    }
+
+    if (ret == MEMTX_OK && !tr->rw) {
+        data = rp_busaccess_rx_dataptr(peer, &rsp->pkt->busaccess_ext_base);
+        /* Data up to 8 bytes is return as values.  */
+        if (tr->size <= 8) {
+            for (i = 0; i < tr->size; i++) {
+                tr->data.u64 |= ((uint64_t) data[i]) << (i * 8);
+            }
+        } else {
+            memcpy(tr->data.p8, data, tr->size);
+        }
+    }
+
+    trace_remote_port_memory_master_rx_busaccess(
+        rp_cmd_to_string(rsp->pkt->hdr.cmd), rsp->pkt->hdr.id,
+        rsp->pkt->hdr.flags, rsp->pkt->hdr.dev, rsp->pkt->busaccess.addr,
+        rsp->pkt->busaccess.len, rsp->pkt->busaccess.attributes);
+
+    if (rp_timeout) {
+        for (i = 0; i < ARRAY_SIZE(rp->dev_state[rp_dev].rsp_queue); i++) {
+            if (rp->dev_state[rp_dev].rsp_queue[i].used &&
+                rp->dev_state[rp_dev].rsp_queue[i].valid) {
+                rp_resp_slot_done(rp, &rp->dev_state[rp_dev].rsp_queue[i]);
+            }
+        }
+    } else {
+        rp_resp_slot_done(rp, rsp_slot);
+    }
+    rp_rsp_mutex_unlock(rp);
+
+    /*
+     * For strongly ordered or transactions that don't allow Early Acking,
+     * we need to drain the pending RP processing queue here. This is
+     * because RP handles responses in parallel with normal requests so
+     * they may get reordered. This becomes visible for example with reads
+     * to read-to-clear registers that clear interrupts. Even though the
+     * lowering of the interrupt-wires arrives to us before the read-resp,
+     * we may handle the response before the wire update, resulting in
+     * spurious interrupts.
+     *
+     * This has some room for optimization but for now we use the big hammer
+     * and drain the entire qeueue.
+     */
+    rp_process(rp);
+
+    /* Reads are sync-points, roll the sync timer.  */
+    rp_restart_sync_timer(rp);
+    DB_PRINT_L(1, "\n");
+    return ret;
+}
+
+MemTxResult rp_mm_access(RemotePort *rp, uint32_t rp_dev,
+                         struct rp_peer_state *peer,
+                         MemoryTransaction *tr,
+                         bool relative, uint64_t offset)
+{
+    return rp_mm_access_with_def_attr(rp, rp_dev, peer, tr, relative, offset,
+                                      0);
+}
+
 static MemTxResult rp_access(MemoryTransaction *tr)
 {
-    /* TBD */
-    return MEMTX_OK;
+    RemotePortMap *map = tr->opaque;
+    RemotePortMemoryMaster *s = map->parent;
+
+    return rp_mm_access(s->rp, s->rp_dev, s->peer, tr, s->relative,
+                        map->offset);
 }
 
 static const MemoryRegionOps rp_ops_template = {
diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
index c783a12153..41ac1b46dc 100644
--- a/hw/core/remote-port.c
+++ b/hw/core/remote-port.c
@@ -62,6 +62,11 @@ static void rp_pkt_dump(const char *prefix, const char *buf, size_t len)
     qemu_hexdump(stdout, prefix, buf, len);
 }
 
+uint32_t rp_new_id(RemotePort *s)
+{
+    return qatomic_fetch_inc(&s->current_id);
+}
+
 void rp_rsp_mutex_lock(RemotePort *s)
 {
     qemu_mutex_lock(&s->rsp_mutex);
diff --git a/hw/core/trace-events b/hw/core/trace-events
index 2cf085ac66..6332002d65 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -32,3 +32,7 @@ clock_set_mul_div(const char *clk, uint32_t oldmul, uint32_t mul, uint32_t olddi
 
 # cpu-common.c
 cpu_reset(int cpu_index) "%d"
+
+# remote-port-memory-master.c
+remote_port_memory_master_tx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len, uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
+remote_port_memory_master_rx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len, uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
diff --git a/include/hw/core/remote-port.h b/include/hw/core/remote-port.h
index e5dfaf7c3b..172c4b6204 100644
--- a/include/hw/core/remote-port.h
+++ b/include/hw/core/remote-port.h
@@ -153,4 +153,15 @@ ssize_t rp_write(RemotePort *s, const void *buf, size_t count);
 
 struct rp_peer_state *rp_get_peer(RemotePort *s);
 
+uint32_t rp_new_id(RemotePort *s);
+
+static inline void rp_resp_slot_done(RemotePort *s,
+                                     RemotePortRespSlot *rsp_slot)
+{
+    rp_dpkt_invalidate(&rsp_slot->rsp);
+    rsp_slot->id = ~0;
+    rsp_slot->used = false;
+    rsp_slot->valid = false;
+}
+
 #endif
-- 
2.43.0


