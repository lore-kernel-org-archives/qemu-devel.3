Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4530BC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 17:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzfKa-0004jr-KC; Tue, 01 Apr 2025 13:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tzfKI-0004gb-8A; Tue, 01 Apr 2025 13:23:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tzfKF-0005w0-Ce; Tue, 01 Apr 2025 13:23:01 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531Gf9Xw002667;
 Tue, 1 Apr 2025 17:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nC7FB1
 pwbm5octQaaoSTqyZZdYWIxjXLrstXWTcH8iQ=; b=iABUfT7TaVghQrkAoQZlQJ
 /Xl/4Q63x6F15yrU06xJbhWqupQAcBo8VSkE/k+RoIwTE5ZOp4+Jie1/gh/Fh67G
 AEoapkmgHfF1n7oGugOo31sEQlRDtiyptgRp+tdE07WMmcNdOKioAYVxOEjeec3D
 zFfSB+l6sJQp7CqCbdwh2vbpZtvz0v5g2hs/yQW6c1XtN7YmAe9Cpqr798SqVvpE
 werYQ8VCTUbOAoTn/CSIIU5/JRNDSKx3QOvvHH7fHcn1OjAyfSApHPkTCheg0yDn
 0HqEmCBf3pA3codRIR5FU+OfyfDw03hS+uuih2eW76F31si2gGZVbITLAq+ivRGg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r290n2mf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 17:22:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 531GQhea004829;
 Tue, 1 Apr 2025 17:22:52 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pujyunds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 17:22:52 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 531HMpdZ19857988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Apr 2025 17:22:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E302E58058;
 Tue,  1 Apr 2025 17:22:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF1AD5805D;
 Tue,  1 Apr 2025 17:22:49 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.127])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Apr 2025 17:22:49 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-s390x@nongnu.org, stefanha@redhat.com,
 fam@euphon.net, philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com,
 thuth@redhat.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com
Subject: [PATCH v3 3/3] block/nvme: Use host PCI MMIO API
Date: Tue,  1 Apr 2025 10:22:46 -0700
Message-ID: <20250401172246.2688-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401172246.2688-1-alifm@linux.ibm.com>
References: <20250401172246.2688-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ouiuaVic1suWTdaC7VFd9gvw0ttw8QTT
X-Proofpoint-GUID: ouiuaVic1suWTdaC7VFd9gvw0ttw8QTT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_06,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504010104
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use the host PCI MMIO functions to read/write
to NVMe registers, rather than directly accessing
them.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 block/nvme.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index bbf7c23dcd..ba66fbc93a 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -18,6 +18,7 @@
 #include "qobject/qstring.h"
 #include "qemu/defer-call.h"
 #include "qemu/error-report.h"
+#include "qemu/host-pci-mmio.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/cutils.h"
@@ -60,7 +61,7 @@ typedef struct {
     uint8_t  *queue;
     uint64_t iova;
     /* Hardware MMIO register */
-    volatile uint32_t *doorbell;
+    uint32_t *doorbell;
 } NVMeQueue;
 
 typedef struct {
@@ -100,7 +101,7 @@ struct BDRVNVMeState {
     QEMUVFIOState *vfio;
     void *bar0_wo_map;
     /* Memory mapped registers */
-    volatile struct {
+    struct {
         uint32_t sq_tail;
         uint32_t cq_head;
     } *doorbells;
@@ -292,7 +293,7 @@ static void nvme_kick(NVMeQueuePair *q)
     assert(!(q->sq.tail & 0xFF00));
     /* Fence the write to submission queue entry before notifying the device. */
     smp_wmb();
-    *q->sq.doorbell = cpu_to_le32(q->sq.tail);
+    host_pci_mmio_write_32(q->sq.doorbell, q->sq.tail);
     q->inflight += q->need_kick;
     q->need_kick = 0;
 }
@@ -441,7 +442,7 @@ static bool nvme_process_completion(NVMeQueuePair *q)
     if (progress) {
         /* Notify the device so it can post more completions. */
         smp_mb_release();
-        *q->cq.doorbell = cpu_to_le32(q->cq.head);
+        host_pci_mmio_write_32(q->cq.doorbell, q->cq.head);
         nvme_wake_free_req_locked(q);
     }
 
@@ -460,7 +461,7 @@ static void nvme_process_completion_bh(void *opaque)
      * so notify the device that it has space to fill in more completions now.
      */
     smp_mb_release();
-    *q->cq.doorbell = cpu_to_le32(q->cq.head);
+    host_pci_mmio_write_32(q->cq.doorbell, q->cq.head);
     nvme_wake_free_req_locked(q);
 
     nvme_process_completion(q);
@@ -749,9 +750,10 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
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
@@ -779,7 +781,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     /* Perform initialize sequence as described in NVMe spec "7.6.1
      * Initialization". */
 
-    cap = le64_to_cpu(regs->cap);
+    cap = host_pci_mmio_read_64(&regs->cap);
     trace_nvme_controller_capability_raw(cap);
     trace_nvme_controller_capability("Maximum Queue Entries Supported",
                                      1 + NVME_CAP_MQES(cap));
@@ -805,16 +807,17 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     bs->bl.request_alignment = s->page_size;
     timeout_ms = MIN(500 * NVME_CAP_TO(cap), 30000);
 
-    ver = le32_to_cpu(regs->vs);
+    ver = host_pci_mmio_read_32(&regs->vs);
     trace_nvme_controller_spec_version(extract32(ver, 16, 16),
                                        extract32(ver, 8, 8),
                                        extract32(ver, 0, 8));
 
     /* Reset device to get a clean state. */
-    regs->cc = cpu_to_le32(le32_to_cpu(regs->cc) & 0xFE);
+    cc = host_pci_mmio_read_32(&regs->cc);
+    host_pci_mmio_write_32(&regs->cc, cc & 0xFE);
     /* Wait for CSTS.RDY = 0. */
     deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * SCALE_MS;
-    while (NVME_CSTS_RDY(le32_to_cpu(regs->csts))) {
+    while (NVME_CSTS_RDY(host_pci_mmio_read_32(&regs->csts))) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to reset (%"
                              PRId64 " ms)",
@@ -843,19 +846,21 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     s->queues[INDEX_ADMIN] = q;
     s->queue_count = 1;
     QEMU_BUILD_BUG_ON((NVME_QUEUE_SIZE - 1) & 0xF000);
-    regs->aqa = cpu_to_le32(((NVME_QUEUE_SIZE - 1) << AQA_ACQS_SHIFT) |
-                            ((NVME_QUEUE_SIZE - 1) << AQA_ASQS_SHIFT));
-    regs->asq = cpu_to_le64(q->sq.iova);
-    regs->acq = cpu_to_le64(q->cq.iova);
+    host_pci_mmio_write_32(&regs->aqa,
+                        ((NVME_QUEUE_SIZE - 1) << AQA_ACQS_SHIFT) |
+                        ((NVME_QUEUE_SIZE - 1) << AQA_ASQS_SHIFT));
+    host_pci_mmio_write_64(&regs->asq, q->sq.iova);
+    host_pci_mmio_write_64(&regs->acq, q->cq.iova);
 
     /* After setting up all control registers we can enable device now. */
-    regs->cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << CC_IOCQES_SHIFT) |
+    host_pci_mmio_write_32(&regs->cc,
+                           (ctz32(NVME_CQ_ENTRY_BYTES) << CC_IOCQES_SHIFT) |
                            (ctz32(NVME_SQ_ENTRY_BYTES) << CC_IOSQES_SHIFT) |
                            CC_EN_MASK);
     /* Wait for CSTS.RDY = 1. */
     now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     deadline = now + timeout_ms * SCALE_MS;
-    while (!NVME_CSTS_RDY(le32_to_cpu(regs->csts))) {
+    while (!NVME_CSTS_RDY(host_pci_mmio_read_32(&regs->csts))) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to start (%"
                              PRId64 " ms)",
-- 
2.43.0


