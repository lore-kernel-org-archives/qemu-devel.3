Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB43C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 18:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txVD3-0004MV-Am; Wed, 26 Mar 2025 14:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1txVCx-0004Jr-B4; Wed, 26 Mar 2025 14:10:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1txVCq-0000Eg-5B; Wed, 26 Mar 2025 14:10:30 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QI1vxB032084;
 Wed, 26 Mar 2025 18:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5dXtO4Kvrqlk7LPN3
 gLeL+uP8sHWD11OVNU1CjQNetA=; b=i0oxnrf0L0BnsMTG14hh1Qm1riTjwLxB/
 ay6mZdv8FHUgV7Zs3YTNet9hvzlwWMUeyaNGgJb7nlS/xuL45M+76NbHF/wqkRLJ
 PYIZqBN5ltTGYwHJL3kEB47utpIgYCd1jNuwQJATS1lOvexqid39TesIZAAfLm4w
 CaAPE3m1JnDYIGOliITpoQnGPJWGM9c61iq3dh475iueGGVjZMYe8dXYDlCLzVJY
 1Ib16UX/2yJ7c3EDPKlKPnr+toHui2YpMqM7mwAumn44LzxnBvz784iYPKn8mmO+
 37FEZpEyZMCeglABu1gfHPKAaPfY6GBBvVtMXhupCM84Nq1vUhgNA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45m3q0ng7s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 18:10:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52QEj6sY012234;
 Wed, 26 Mar 2025 18:10:12 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91m9jf0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 18:10:12 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52QIABeo36569514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Mar 2025 18:10:11 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 143655805A;
 Wed, 26 Mar 2025 18:10:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15FB85805E;
 Wed, 26 Mar 2025 18:10:10 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.243.159])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Mar 2025 18:10:09 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, schnelle@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com,
 fam@euphon.net, philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com,
 thuth@redhat.com
Subject: [PATCH v1 2/2] block/nvme: Enable NVMe userspace driver for s390x
Date: Wed, 26 Mar 2025 11:10:07 -0700
Message-ID: <20250326181007.1099-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326181007.1099-1-alifm@linux.ibm.com>
References: <20250326181007.1099-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VGqCXWE_ms37_t8LGVg92sGPiDLLBho7
X-Proofpoint-GUID: VGqCXWE_ms37_t8LGVg92sGPiDLLBho7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_08,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260110
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On s390x we can now support userspace mmio and mmap
from vfio. This patch uses s390x mmio support to
enable the NVMe userspace driver for s390x.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 block/nvme.c | 95 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 77 insertions(+), 18 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index bbf7c23dcd..90f5708d9b 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -24,6 +24,9 @@
 #include "qemu/option.h"
 #include "qemu/memalign.h"
 #include "qemu/vfio-helpers.h"
+#ifdef __s390x__
+#include "qemu/s390x_pci_mmio.h"
+#endif
 #include "block/block-io.h"
 #include "block/block_int.h"
 #include "system/block-backend.h"
@@ -60,7 +63,7 @@ typedef struct {
     uint8_t  *queue;
     uint64_t iova;
     /* Hardware MMIO register */
-    volatile uint32_t *doorbell;
+    uint32_t *doorbell;
 } NVMeQueue;
 
 typedef struct {
@@ -100,7 +103,7 @@ struct BDRVNVMeState {
     QEMUVFIOState *vfio;
     void *bar0_wo_map;
     /* Memory mapped registers */
-    volatile struct {
+    struct {
         uint32_t sq_tail;
         uint32_t cq_head;
     } *doorbells;
@@ -164,6 +167,58 @@ static QemuOptsList runtime_opts = {
     },
 };
 
+static inline uint32_t nvme_mmio_read_32(const void *addr)
+{
+    uint32_t ret;
+
+#ifdef __s390x__
+    ret = s390x_pci_mmio_read_32(addr);
+#else
+    /* Prevent the compiler from optimizing away the load */
+    ret = *((volatile uint32_t *)addr);
+#endif
+
+    return le32_to_cpu(ret);
+}
+
+static inline uint64_t nvme_mmio_read_64(const void *addr)
+{
+    uint64_t ret;
+
+#ifdef __s390x__
+    ret = s390x_pci_mmio_read_64(addr);
+#else
+    /* Prevent the compiler from optimizing away the load */
+    ret = *((volatile uint64_t *)addr);
+#endif
+
+    return le64_to_cpu(ret);
+}
+
+static inline void nvme_mmio_write_32(void *addr, uint32_t val)
+{
+    val = cpu_to_le32(val);
+
+#ifdef __s390x__
+    s390x_pci_mmio_write_32(addr, val);
+#else
+    /* Prevent the compiler from optimizing away the store */
+    *((volatile uint32_t *)addr) = val;
+#endif
+}
+
+static inline void nvme_mmio_write_64(void *addr, uint64_t val)
+{
+    val = cpu_to_le64(val);
+
+#ifdef __s390x__
+    s390x_pci_mmio_write_64(addr, val);
+#else
+    /* Prevent the compiler from optimizing away the store */
+    *((volatile uint64_t *)addr) = val;
+#endif
+}
+
 /* Returns true on success, false on failure. */
 static bool nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
                             unsigned nentries, size_t entry_bytes, Error **errp)
@@ -292,7 +347,7 @@ static void nvme_kick(NVMeQueuePair *q)
     assert(!(q->sq.tail & 0xFF00));
     /* Fence the write to submission queue entry before notifying the device. */
     smp_wmb();
-    *q->sq.doorbell = cpu_to_le32(q->sq.tail);
+    nvme_mmio_write_32(q->sq.doorbell, q->sq.tail);
     q->inflight += q->need_kick;
     q->need_kick = 0;
 }
@@ -441,7 +496,7 @@ static bool nvme_process_completion(NVMeQueuePair *q)
     if (progress) {
         /* Notify the device so it can post more completions. */
         smp_mb_release();
-        *q->cq.doorbell = cpu_to_le32(q->cq.head);
+        nvme_mmio_write_32(q->cq.doorbell, q->cq.head);
         nvme_wake_free_req_locked(q);
     }
 
@@ -460,7 +515,7 @@ static void nvme_process_completion_bh(void *opaque)
      * so notify the device that it has space to fill in more completions now.
      */
     smp_mb_release();
-    *q->cq.doorbell = cpu_to_le32(q->cq.head);
+    nvme_mmio_write_32(q->cq.doorbell, q->cq.head);
     nvme_wake_free_req_locked(q);
 
     nvme_process_completion(q);
@@ -749,9 +804,10 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     int ret;
     uint64_t cap;
     uint32_t ver;
+    uint32_t cc;
     uint64_t timeout_ms;
     uint64_t deadline, now;
-    volatile NvmeBar *regs = NULL;
+    NvmeBar *regs = NULL;
 
     qemu_co_mutex_init(&s->dma_map_lock);
     qemu_co_queue_init(&s->dma_flush_queue);
@@ -779,7 +835,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     /* Perform initialize sequence as described in NVMe spec "7.6.1
      * Initialization". */
 
-    cap = le64_to_cpu(regs->cap);
+    cap = nvme_mmio_read_64(&regs->cap);
     trace_nvme_controller_capability_raw(cap);
     trace_nvme_controller_capability("Maximum Queue Entries Supported",
                                      1 + NVME_CAP_MQES(cap));
@@ -805,16 +861,17 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     bs->bl.request_alignment = s->page_size;
     timeout_ms = MIN(500 * NVME_CAP_TO(cap), 30000);
 
-    ver = le32_to_cpu(regs->vs);
+    ver = nvme_mmio_read_32(&regs->vs);
     trace_nvme_controller_spec_version(extract32(ver, 16, 16),
                                        extract32(ver, 8, 8),
                                        extract32(ver, 0, 8));
 
     /* Reset device to get a clean state. */
-    regs->cc = cpu_to_le32(le32_to_cpu(regs->cc) & 0xFE);
+    cc = nvme_mmio_read_32(&regs->cc);
+    nvme_mmio_write_32(&regs->cc, (cc & 0xFE));
     /* Wait for CSTS.RDY = 0. */
     deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * SCALE_MS;
-    while (NVME_CSTS_RDY(le32_to_cpu(regs->csts))) {
+    while (NVME_CSTS_RDY(nvme_mmio_read_32(&regs->csts))) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to reset (%"
                              PRId64 " ms)",
@@ -843,19 +900,21 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     s->queues[INDEX_ADMIN] = q;
     s->queue_count = 1;
     QEMU_BUILD_BUG_ON((NVME_QUEUE_SIZE - 1) & 0xF000);
-    regs->aqa = cpu_to_le32(((NVME_QUEUE_SIZE - 1) << AQA_ACQS_SHIFT) |
-                            ((NVME_QUEUE_SIZE - 1) << AQA_ASQS_SHIFT));
-    regs->asq = cpu_to_le64(q->sq.iova);
-    regs->acq = cpu_to_le64(q->cq.iova);
+    nvme_mmio_write_32(&regs->aqa,
+                       ((NVME_QUEUE_SIZE - 1) << AQA_ACQS_SHIFT) |
+                       ((NVME_QUEUE_SIZE - 1) << AQA_ASQS_SHIFT));
+    nvme_mmio_write_64(&regs->asq, q->sq.iova);
+    nvme_mmio_write_64(&regs->acq, q->cq.iova);
 
     /* After setting up all control registers we can enable device now. */
-    regs->cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << CC_IOCQES_SHIFT) |
-                           (ctz32(NVME_SQ_ENTRY_BYTES) << CC_IOSQES_SHIFT) |
-                           CC_EN_MASK);
+    nvme_mmio_write_32(&regs->cc,
+                    ((ctz32(NVME_CQ_ENTRY_BYTES) << CC_IOCQES_SHIFT) |
+                    (ctz32(NVME_SQ_ENTRY_BYTES) << CC_IOSQES_SHIFT) |
+                    CC_EN_MASK));
     /* Wait for CSTS.RDY = 1. */
     now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     deadline = now + timeout_ms * SCALE_MS;
-    while (!NVME_CSTS_RDY(le32_to_cpu(regs->csts))) {
+    while (!NVME_CSTS_RDY(nvme_mmio_read_32(&regs->csts))) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to start (%"
                              PRId64 " ms)",
-- 
2.43.0


