Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B56C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 10:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIjP-0002Ce-84; Mon, 15 Jul 2024 06:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sTIjL-0001yq-HJ; Mon, 15 Jul 2024 06:14:51 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sTIjD-0003FB-OF; Mon, 15 Jul 2024 06:14:51 -0400
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 46FAEPei081117
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 15 Jul 2024 18:14:25 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from atcpcw16.andestech.com (10.0.1.106) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 18:14:27 +0800
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>, <peterx@redhat.com>,
 <david@redhat.com>, <philmd@linaro.org>, <palmer@dabbelt.com>,
 <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>, Ethan Chen
 <ethan84@andestech.com>
Subject: [PATCH v8 7/8] hw/misc/riscv_iopmp: Add DMA operation with IOPMP
 support API
Date: Mon, 15 Jul 2024 18:14:21 +0800
Message-ID: <20240715101421.1249537-1-ethan84@andestech.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb.dirty
In-Reply-To: <20240715095702.1222213-1-ethan84@andestech.com>
References: <20240715095702.1222213-1-ethan84@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.1.106]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 46FAEPei081117
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The iopmp_dma_rw() function performs memory read/write operations to system
memory with support for IOPMP. It sends transaction information to the IOPMP
for partial hit detection.

Signed-off-by: Ethan Chen <ethan84@andestech.com>
---
 hw/misc/riscv_iopmp.c         | 68 +++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_iopmp.h |  3 +-
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/hw/misc/riscv_iopmp.c b/hw/misc/riscv_iopmp.c
index 374bf5c610..0be32ca819 100644
--- a/hw/misc/riscv_iopmp.c
+++ b/hw/misc/riscv_iopmp.c
@@ -1217,5 +1217,73 @@ void iopmp_setup_cpu(RISCVCPU *cpu, uint32_t rrid)
     cpu->cfg.iopmp_rrid = rrid;
 }
 
+static void send_transaction_start(IopmpState *s, uint32_t rrid)
+{
+    int flag = 0;
+    if (rrid < s->rrid_num) {
+        while (flag == 0) {
+            /* Wait last transaction of rrid complete */
+            while (s->transaction_state[rrid].running) {
+                ;
+            }
+            qemu_mutex_lock(&s->iopmp_transaction_mutex);
+            /* Check status again */
+            if (s->transaction_state[rrid].running == false) {
+                s->transaction_state[rrid].running = true;
+                s->transaction_state[rrid].supported = true;
+                flag = 1;
+            }
+            qemu_mutex_unlock(&s->iopmp_transaction_mutex);
+        }
+    }
+}
+
+static void send_transaction_complete(IopmpState *s, uint32_t rrid)
+{
+    if (rrid < s->rrid_num) {
+        qemu_mutex_lock(&s->iopmp_transaction_mutex);
+        s->transaction_state[rrid].running = false;
+        s->transaction_state[rrid].supported = false;
+        qemu_mutex_unlock(&s->iopmp_transaction_mutex);
+    }
+}
+
+static void send_transaction_info(IopmpState *s, uint32_t rrid,
+                                  hwaddr start_addr, hwaddr size)
+{
+    if (rrid < s->rrid_num) {
+        s->transaction_state[rrid].start_addr = start_addr;
+        s->transaction_state[rrid].end_addr = start_addr + size - 1;
+    }
+}
+
+/*
+ * Perform address_space_rw to system memory and send transaction information
+ * to correspond IOPMP for partially hit detection.
+ */
+MemTxResult iopmp_dma_rw(hwaddr addr, uint32_t rrid, void *buf, hwaddr len,
+                         bool is_write)
+{
+    MemTxResult result;
+    MemTxAttrs attrs;
+    iopmp_protection_memmap *map;
+    /* Find which IOPMP is responsible for receiving transaction information */
+    QLIST_FOREACH(map, &iopmp_protection_memmaps, list) {
+        if (addr >= map->entry.base &&
+            addr < map->entry.base + map->entry.size) {
+            send_transaction_start(map->iopmp_s, rrid);
+            send_transaction_info(map->iopmp_s, rrid, addr, len);
+            break;
+        }
+    }
+
+    attrs.requester_id = rrid;
+    result = address_space_rw(&address_space_memory, addr, attrs, buf, len,
+                              is_write);
+    if (map) {
+        send_transaction_complete(map->iopmp_s, rrid);
+    }
+    return result;
+}
 
 type_init(iopmp_register_types);
diff --git a/include/hw/misc/riscv_iopmp.h b/include/hw/misc/riscv_iopmp.h
index 7e7da56d10..d87395170d 100644
--- a/include/hw/misc/riscv_iopmp.h
+++ b/include/hw/misc/riscv_iopmp.h
@@ -168,5 +168,6 @@ typedef struct IopmpState {
 void iopmp_setup_system_memory(DeviceState *dev, const MemMapEntry *memmap,
                                uint32_t mapentry_num);
 void iopmp_setup_cpu(RISCVCPU *cpu, uint32_t rrid);
-
+MemTxResult iopmp_dma_rw(hwaddr addr, uint32_t rrid, void *buf, hwaddr len,
+                         bool is_write);
 #endif
-- 
2.34.1


