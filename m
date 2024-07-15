Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC753C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 18:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTQX6-0007N5-4T; Mon, 15 Jul 2024 14:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sTQX4-0007GB-HD; Mon, 15 Jul 2024 14:34:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sTQX2-0007Gr-Ee; Mon, 15 Jul 2024 14:34:42 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FIUEMH018741;
 Mon, 15 Jul 2024 18:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=qjR0NYMgjXM3W
 X1uzfwScrGilcGOuslPhQZ4+l/ZgzM=; b=FhgaUo/uE6pddrCFtLIaCV7NY28Bu
 wbLGp2aMZ8pFna8dLLtOUvfPUTAL6myXwO0cecDePeb4XSGlpDJVCiQ6d/WNwzAX
 EVDdqsEpY/dWhKI+U6kSnHL/GuhmmYwhJvecf4RJD2x8QaQjbDA2a2lAXtSzyXP9
 GGVWi4YevDumhDOn2AlvkSfZb96/L54t7NZPYr5mWmXDY7snVwSdG8C71zoa5vNf
 8fE7CJWQh7NavFHrjk/ZXU8qrzlskH6nb3VMF3d225l2E85or/Mt2Utkkt63HnMN
 pMpcJvThuRF1zakkT+jn8KjHVSne89aNr9+9df+li00t3DV9vXEsrAg8A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d92xg0a6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:31 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46FIYV98025882;
 Mon, 15 Jul 2024 18:34:31 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d92xg0a5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46FIH54O028442; Mon, 15 Jul 2024 18:34:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40c6m2ywyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:30 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46FIYPga37290326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jul 2024 18:34:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1AA02004D;
 Mon, 15 Jul 2024 18:34:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D046620040;
 Mon, 15 Jul 2024 18:34:23 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jul 2024 18:34:23 +0000 (GMT)
From: Michael Kowal <kowal@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v2 3/9] pnv/xive: Support cache flush and queue sync inject
 with notifications
Date: Mon, 15 Jul 2024 13:33:26 -0500
Message-Id: <20240715183332.27287-4-kowal@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240715183332.27287-1-kowal@linux.vnet.ibm.com>
References: <20240715183332.27287-1-kowal@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tqR3eXhclu14I4C18MyBmb-EdhUDlloW
X-Proofpoint-ORIG-GUID: 3vWxywtesBx8Jb-6-iVtV5v2mAh0dCnJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150143
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=kowal@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nicholas Piggin <npiggin@gmail,com>

Adds support for writing a completion notification byte in memory
whenever a cache flush or queue sync inject operation is requested by
software.  QEMU does not cache any of the XIVE data that is in memory and
therefore it simply writes the completion notification byte at the time
that the operation is requested.

Co-authored-by: Glenn Miles <milesg@linux.vnet.ibm.com>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
---
 hw/intc/pnv_xive2_regs.h  |  16 ++++
 include/hw/ppc/pnv_chip.h |   1 +
 hw/intc/pnv_xive2.c       | 151 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 166 insertions(+), 2 deletions(-)

diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
index f8e4a677c6..ca05255d20 100644
--- a/hw/intc/pnv_xive2_regs.h
+++ b/hw/intc/pnv_xive2_regs.h
@@ -232,6 +232,10 @@
 #define  VC_ESBC_FLUSH_POLL_BLOCK_ID_MASK       PPC_BITMASK(32, 35)
 #define  VC_ESBC_FLUSH_POLL_OFFSET_MASK         PPC_BITMASK(36, 63) /* 28-bit */
 
+/* ESBC cache flush inject register */
+#define X_VC_ESBC_FLUSH_INJECT                  0x142
+#define VC_ESBC_FLUSH_INJECT                    0x210
+
 /* ESBC configuration */
 #define X_VC_ESBC_CFG                           0x148
 #define VC_ESBC_CFG                             0x240
@@ -250,6 +254,10 @@
 #define  VC_EASC_FLUSH_POLL_BLOCK_ID_MASK       PPC_BITMASK(32, 35)
 #define  VC_EASC_FLUSH_POLL_OFFSET_MASK         PPC_BITMASK(36, 63) /* 28-bit */
 
+/* EASC flush inject register */
+#define X_VC_EASC_FLUSH_INJECT                  0x162
+#define VC_EASC_FLUSH_INJECT                    0x310
+
 /*
  * VC2
  */
@@ -270,6 +278,10 @@
 #define  VC_ENDC_FLUSH_POLL_BLOCK_ID_MASK       PPC_BITMASK(36, 39)
 #define  VC_ENDC_FLUSH_POLL_OFFSET_MASK         PPC_BITMASK(40, 63) /* 24-bit */
 
+/* ENDC flush inject register */
+#define X_VC_ENDC_FLUSH_INJECT                  0x182
+#define VC_ENDC_FLUSH_INJECT                    0x410
+
 /* ENDC Sync done */
 #define X_VC_ENDC_SYNC_DONE                     0x184
 #define VC_ENDC_SYNC_DONE                       0x420
@@ -403,6 +415,10 @@
 #define  PC_NXC_FLUSH_POLL_BLOCK_ID_MASK        PPC_BITMASK(36, 39)
 #define  PC_NXC_FLUSH_POLL_OFFSET_MASK          PPC_BITMASK(40, 63) /* 24-bit */
 
+/* NxC Cache flush inject */
+#define X_PC_NXC_FLUSH_INJECT                   0x282
+#define PC_NXC_FLUSH_INJECT                     0x410
+
 /* NxC Cache watch assign */
 #define X_PC_NXC_WATCH_ASSIGN                   0x286
 #define PC_NXC_WATCH_ASSIGN                     0x430
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index a4ed17ac59..9502248561 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -131,6 +131,7 @@ struct Pnv10Chip {
 
 #define PNV10_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
 #define PNV10_PIR2CHIP(pir)      (((pir) >> 8) & 0x7f)
+#define PNV10_PIR2THREAD(pir)    (((pir) & 0x7f))
 
 struct PnvChipClass {
     /*< private >*/
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 5b075a220c..d62ac20d98 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -25,6 +25,7 @@
 #include "hw/ppc/ppc.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/reset.h"
+#include "sysemu/qtest.h"
 
 #include <libfdt.h>
 
@@ -32,6 +33,16 @@
 
 #undef XIVE2_DEBUG
 
+/* XIVE Sync or Flush Notification Block */
+typedef struct XiveSfnBlock {
+    uint8_t bytes[32];
+} XiveSfnBlock;
+
+/* XIVE Thread Sync or Flush Notification Area */
+typedef struct XiveThreadNA {
+    XiveSfnBlock topo[16];
+} XiveThreadNA;
+
 /*
  * Virtual structures table (VST)
  */
@@ -54,7 +65,7 @@ static const XiveVstInfo vst_infos[] = {
     [VST_NVC]  = { "NVCT", sizeof(Xive2Nvgc),    16 },
 
     [VST_IC]  =  { "IC",   1, /* ? */            16 }, /* Topology # */
-    [VST_SYNC] = { "SYNC", 1, /* ? */            16 }, /* Topology # */
+    [VST_SYNC] = { "SYNC", sizeof(XiveThreadNA), 16 }, /* Topology # */
 
     /*
      * This table contains the backing store pages for the interrupt
@@ -329,6 +340,70 @@ static int pnv_xive2_write_end(Xive2Router *xrtr, uint8_t blk, uint32_t idx,
                               word_number);
 }
 
+static inline int pnv_xive2_get_current_pir(PnvXive2 *xive)
+{
+    if (!qtest_enabled()) {
+        PowerPCCPU *cpu = POWERPC_CPU(current_cpu);
+        return ppc_cpu_pir(cpu);
+    }
+    return 0;
+}
+
+/*
+ * After SW injects a Queue Sync or Cache Flush operation, HW will notify
+ * SW of the completion of the operation by writing a byte of all 1's (0xff)
+ * to a specific memory location.  The memory location is calculated by first
+ * looking up a base address in the SYNC VSD using the Topology ID of the
+ * originating thread as the "block" number.  This points to a
+ * 64k block of memory that is further divided into 128 512 byte chunks of
+ * memory, which is indexed by the thread id of the requesting thread.
+ * Finally, this 512 byte chunk of memory is divided into 16 32 byte
+ * chunks which are indexed by the topology id of the targeted IC's chip.
+ * The values below are the offsets into that 32 byte chunk of memory for
+ * each type of cache flush or queue sync operation.
+ */
+#define PNV_XIVE2_QUEUE_IPI              0x00
+#define PNV_XIVE2_QUEUE_HW               0x01
+#define PNV_XIVE2_QUEUE_NXC              0x02
+#define PNV_XIVE2_QUEUE_INT              0x03
+#define PNV_XIVE2_QUEUE_OS               0x04
+#define PNV_XIVE2_QUEUE_POOL             0x05
+#define PNV_XIVE2_QUEUE_HARD             0x06
+#define PNV_XIVE2_CACHE_ENDC             0x08
+#define PNV_XIVE2_CACHE_ESBC             0x09
+#define PNV_XIVE2_CACHE_EASC             0x0a
+#define PNV_XIVE2_QUEUE_NXC_LD_LCL_NCO   0x10
+#define PNV_XIVE2_QUEUE_NXC_LD_LCL_CO    0x11
+#define PNV_XIVE2_QUEUE_NXC_ST_LCL_NCI   0x12
+#define PNV_XIVE2_QUEUE_NXC_ST_LCL_CI    0x13
+#define PNV_XIVE2_QUEUE_NXC_ST_RMT_NCI   0x14
+#define PNV_XIVE2_QUEUE_NXC_ST_RMT_CI    0x15
+#define PNV_XIVE2_CACHE_NXC              0x18
+
+static int pnv_xive2_inject_notify(PnvXive2 *xive, int type)
+{
+    uint64_t addr;
+    int pir = pnv_xive2_get_current_pir(xive);
+    int thread_nr = PNV10_PIR2THREAD(pir);
+    int thread_topo_id = PNV10_PIR2CHIP(pir);
+    int ic_topo_id = xive->chip->chip_id;
+    uint64_t offset = ic_topo_id * sizeof(XiveSfnBlock);
+    uint8_t byte = 0xff;
+
+    /* Retrieve the address of requesting thread's notification area */
+    addr = pnv_xive2_vst_addr(xive, VST_SYNC, thread_topo_id, thread_nr);
+
+    if (!addr) {
+        xive2_error(xive, "VST: no SYNC entry %x/%x !?",
+                    thread_topo_id, thread_nr);
+        return -1;
+    }
+
+    cpu_physical_memory_write(addr + offset + type, &byte, 1);
+
+    return 0;
+}
+
 static int pnv_xive2_end_update(PnvXive2 *xive, uint8_t watch_engine)
 {
     uint8_t  blk;
@@ -1180,6 +1255,10 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
         /* ESB update */
         break;
 
+    case VC_ESBC_FLUSH_INJECT:
+        pnv_xive2_inject_notify(xive, PNV_XIVE2_CACHE_ESBC);
+        break;
+
     case VC_ESBC_CFG:
         break;
 
@@ -1192,6 +1271,10 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
         /* EAS update */
         break;
 
+    case VC_EASC_FLUSH_INJECT:
+        pnv_xive2_inject_notify(xive, PNV_XIVE2_CACHE_EASC);
+        break;
+
     case VC_ENDC_CFG:
         break;
 
@@ -1226,6 +1309,10 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
         xive->vc_regs[VC_ENDC_FLUSH_CTRL >> 3] |= VC_ENDC_FLUSH_CTRL_POLL_VALID;
         break;
 
+    case VC_ENDC_FLUSH_INJECT:
+        pnv_xive2_inject_notify(xive, PNV_XIVE2_CACHE_ENDC);
+        break;
+
     /*
      * Indirect invalidation
      */
@@ -1426,6 +1513,10 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
         xive->pc_regs[PC_NXC_FLUSH_CTRL >> 3] |= PC_NXC_FLUSH_CTRL_POLL_VALID;
         break;
 
+    case PC_NXC_FLUSH_INJECT:
+        pnv_xive2_inject_notify(xive, PNV_XIVE2_CACHE_NXC);
+        break;
+
     /*
      * Indirect invalidation
      */
@@ -1729,6 +1820,12 @@ static const MemoryRegionOps pnv_xive2_ic_lsi_ops = {
 #define PNV_XIVE2_SYNC_OS_ESC           0x200
 #define PNV_XIVE2_SYNC_POOL_ESC         0x280
 #define PNV_XIVE2_SYNC_HARD_ESC         0x300
+#define PNV_XIVE2_SYNC_NXC_LD_LCL_NCO   0x800
+#define PNV_XIVE2_SYNC_NXC_LD_LCL_CO    0x880
+#define PNV_XIVE2_SYNC_NXC_ST_LCL_NCI   0x900
+#define PNV_XIVE2_SYNC_NXC_ST_LCL_CI    0x980
+#define PNV_XIVE2_SYNC_NXC_ST_RMT_NCI   0xA00
+#define PNV_XIVE2_SYNC_NXC_ST_RMT_CI    0xA80
 
 static uint64_t pnv_xive2_ic_sync_read(void *opaque, hwaddr offset,
                                        unsigned size)
@@ -1740,22 +1837,72 @@ static uint64_t pnv_xive2_ic_sync_read(void *opaque, hwaddr offset,
     return -1;
 }
 
+/*
+ * The sync MMIO space spans two pages.  The lower page is use for
+ * queue sync "poll" requests while the upper page is used for queue
+ * sync "inject" requests.  Inject requests require the HW to write
+ * a byte of all 1's to a predetermined location in memory in order
+ * to signal completion of the request.  Both pages have the same
+ * layout, so it is easiest to handle both with a single function.
+ */
 static void pnv_xive2_ic_sync_write(void *opaque, hwaddr offset,
                                     uint64_t val, unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    int inject_type;
+    hwaddr pg_offset_mask = (1ull << xive->ic_shift) - 1;
 
-    switch (offset) {
+    /* adjust offset for inject page */
+    hwaddr adj_offset = offset & pg_offset_mask;
+
+    switch (adj_offset) {
     case PNV_XIVE2_SYNC_IPI:
+        inject_type = PNV_XIVE2_QUEUE_IPI;
+        break;
     case PNV_XIVE2_SYNC_HW:
+        inject_type = PNV_XIVE2_QUEUE_HW;
+        break;
     case PNV_XIVE2_SYNC_NxC:
+        inject_type = PNV_XIVE2_QUEUE_NXC;
+        break;
     case PNV_XIVE2_SYNC_INT:
+        inject_type = PNV_XIVE2_QUEUE_INT;
+        break;
     case PNV_XIVE2_SYNC_OS_ESC:
+        inject_type = PNV_XIVE2_QUEUE_OS;
+        break;
     case PNV_XIVE2_SYNC_POOL_ESC:
+        inject_type = PNV_XIVE2_QUEUE_POOL;
+        break;
     case PNV_XIVE2_SYNC_HARD_ESC:
+        inject_type = PNV_XIVE2_QUEUE_HARD;
+        break;
+    case PNV_XIVE2_SYNC_NXC_LD_LCL_NCO:
+        inject_type = PNV_XIVE2_QUEUE_NXC_LD_LCL_NCO;
+        break;
+    case PNV_XIVE2_SYNC_NXC_LD_LCL_CO:
+        inject_type = PNV_XIVE2_QUEUE_NXC_LD_LCL_CO;
+        break;
+    case PNV_XIVE2_SYNC_NXC_ST_LCL_NCI:
+        inject_type = PNV_XIVE2_QUEUE_NXC_ST_LCL_NCI;
+        break;
+    case PNV_XIVE2_SYNC_NXC_ST_LCL_CI:
+        inject_type = PNV_XIVE2_QUEUE_NXC_ST_LCL_CI;
+        break;
+    case PNV_XIVE2_SYNC_NXC_ST_RMT_NCI:
+        inject_type = PNV_XIVE2_QUEUE_NXC_ST_RMT_NCI;
+        break;
+    case PNV_XIVE2_SYNC_NXC_ST_RMT_CI:
+        inject_type = PNV_XIVE2_QUEUE_NXC_ST_RMT_CI;
         break;
     default:
         xive2_error(xive, "SYNC: invalid write @%"HWADDR_PRIx, offset);
+        return;
+    }
+
+    /* Write Queue Sync notification byte if writing to sync inject page */
+    if ((offset & ~pg_offset_mask) != 0) {
+        pnv_xive2_inject_notify(xive, inject_type);
     }
 }
 
-- 
2.43.0


