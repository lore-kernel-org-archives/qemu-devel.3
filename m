Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF53D1D876
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 21:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0os2-0004f4-6H; Tue, 15 Oct 2024 17:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0ory-0004UQ-0a; Tue, 15 Oct 2024 17:14:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0orv-0000QW-2C; Tue, 15 Oct 2024 17:14:17 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FKJaSP022495;
 Tue, 15 Oct 2024 21:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=sQyX0uLyNbNulNrI3
 lQIe1EvVwwnkJ3bxq0p7BN2trQ=; b=Q3Jz/++FUDt1kYI4yC0/zQ9ZdDVhFOHb1
 HCtQZEezFas0t2KUQSeMO9UIYu3rIvcuDbN5aUv0t1x7JgFKL+tAC6JOSY9dqRfY
 QtOrEkO4bwJm+VX0A3ItQLTGdIVEQPuoGOUObW2jPoMISbTIOR4lOoH0cfvAuh8y
 RUw/yDzzVnwzpgoq5oLxIg5O8c20OoyAeygKaE66Me0CdCv4nlfdJMH3xY0oXb19
 FfWabDykYm4m6E0ZiNrtDXQM9RIEJX6csa+iHuO99229qMwU4g5z4jpc3qQYozgz
 JeRQvpwS0MXW/tLc407V9qRqtPrCRf/jjkC1Na+i5mr0//mvKtjTA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429yb505fy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:02 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FLE2qa029706;
 Tue, 15 Oct 2024 21:14:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429yb505ft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHfMbp002408;
 Tue, 15 Oct 2024 21:14:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emnyu1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49FLDupq29491514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Oct 2024 21:13:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C4FA2004B;
 Tue, 15 Oct 2024 21:13:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8285F20043;
 Tue, 15 Oct 2024 21:13:54 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Oct 2024 21:13:54 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH 08/14] Add support for MMIO operations on the  NVPG/NVC BAR
Date: Tue, 15 Oct 2024 16:13:23 -0500
Message-Id: <20241015211329.21113-9-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015211329.21113-1-kowal@linux.ibm.com>
References: <20241015211329.21113-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zJrcRn0HYJejsZDgY1Gkc-GfdJgIitF4
X-Proofpoint-GUID: SMPehxO8mkKU4arwCe_rOP2C5Dlts_xx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150140
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Add support for the NVPG and NVC BARs.  Access to the BAR pages will
cause backlog counter operations to either increment or decriment
the counter.

Also added qtests for the same.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive2.h           |   9 ++
 include/hw/ppc/xive2_regs.h      |   3 +
 tests/qtest/pnv-xive2-common.h   |   1 +
 hw/intc/pnv_xive2.c              |  80 +++++++++++++---
 hw/intc/xive2.c                  |  87 +++++++++++++++++
 tests/qtest/pnv-xive2-nvpg_bar.c | 154 +++++++++++++++++++++++++++++++
 tests/qtest/pnv-xive2-test.c     |   3 +
 hw/intc/trace-events             |   4 +
 tests/qtest/meson.build          |   3 +-
 9 files changed, 329 insertions(+), 15 deletions(-)
 create mode 100644 tests/qtest/pnv-xive2-nvpg_bar.c

diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index e61b978f37..049028d2c2 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -92,6 +92,15 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
                                uint8_t nvt_blk, uint32_t nvt_idx,
                                bool cam_ignore, uint32_t logic_serv);
 
+uint64_t xive2_presenter_nvp_backlog_op(XivePresenter *xptr,
+                                        uint8_t blk, uint32_t idx,
+                                        uint16_t offset);
+
+uint64_t xive2_presenter_nvgc_backlog_op(XivePresenter *xptr,
+                                         bool crowd,
+                                         uint8_t blk, uint32_t idx,
+                                         uint16_t offset, uint16_t val);
+
 /*
  * XIVE2 END ESBs  (POWER10)
  */
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 30868e8e09..66a419441c 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -234,4 +234,7 @@ typedef struct Xive2Nvgc {
 void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uint32_t nvgc_idx,
                                GString *buf);
 
+#define NVx_BACKLOG_OP            PPC_BITMASK(52, 53)
+#define NVx_BACKLOG_PRIO          PPC_BITMASK(57, 59)
+
 #endif /* PPC_XIVE2_REGS_H */
diff --git a/tests/qtest/pnv-xive2-common.h b/tests/qtest/pnv-xive2-common.h
index 2135b04d5b..910f0f512e 100644
--- a/tests/qtest/pnv-xive2-common.h
+++ b/tests/qtest/pnv-xive2-common.h
@@ -108,5 +108,6 @@ extern void set_end(QTestState *qts, uint32_t index, uint32_t nvp_index,
 
 
 void test_flush_sync_inject(QTestState *qts);
+void test_nvpg_bar(QTestState *qts);
 
 #endif /* TEST_PNV_XIVE2_COMMON_H */
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 0482193fd7..9736b623ba 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -2203,21 +2203,40 @@ static const MemoryRegionOps pnv_xive2_tm_ops = {
     },
 };
 
-static uint64_t pnv_xive2_nvc_read(void *opaque, hwaddr offset,
+static uint64_t pnv_xive2_nvc_read(void *opaque, hwaddr addr,
                                    unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    XivePresenter *xptr = XIVE_PRESENTER(xive);
+    uint32_t page = addr >> xive->nvpg_shift;
+    uint16_t op = addr & 0xFFF;
+    uint8_t blk = pnv_xive2_block_id(xive);
 
-    xive2_error(xive, "NVC: invalid read @%"HWADDR_PRIx, offset);
-    return -1;
+    if (size != 2) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid nvc load size %d\n",
+                      size);
+        return -1;
+    }
+
+    return xive2_presenter_nvgc_backlog_op(xptr, true, blk, page, op, 1);
 }
 
-static void pnv_xive2_nvc_write(void *opaque, hwaddr offset,
+static void pnv_xive2_nvc_write(void *opaque, hwaddr addr,
                                 uint64_t val, unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    XivePresenter *xptr = XIVE_PRESENTER(xive);
+    uint32_t page = addr >> xive->nvc_shift;
+    uint16_t op = addr & 0xFFF;
+    uint8_t blk = pnv_xive2_block_id(xive);
 
-    xive2_error(xive, "NVC: invalid write @%"HWADDR_PRIx, offset);
+    if (size != 1) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid nvc write size %d\n",
+                      size);
+        return;
+    }
+
+    (void)xive2_presenter_nvgc_backlog_op(xptr, true, blk, page, op, val);
 }
 
 static const MemoryRegionOps pnv_xive2_nvc_ops = {
@@ -2225,30 +2244,63 @@ static const MemoryRegionOps pnv_xive2_nvc_ops = {
     .write = pnv_xive2_nvc_write,
     .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
     .impl = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
 };
 
-static uint64_t pnv_xive2_nvpg_read(void *opaque, hwaddr offset,
+static uint64_t pnv_xive2_nvpg_read(void *opaque, hwaddr addr,
                                     unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    XivePresenter *xptr = XIVE_PRESENTER(xive);
+    uint32_t page = addr >> xive->nvpg_shift;
+    uint16_t op = addr & 0xFFF;
+    uint32_t index = page >> 1;
+    uint8_t blk = pnv_xive2_block_id(xive);
 
-    xive2_error(xive, "NVPG: invalid read @%"HWADDR_PRIx, offset);
-    return -1;
+    if (size != 2) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid nvpg load size %d\n",
+                      size);
+        return -1;
+    }
+
+    if (page % 2) {
+        /* odd page - NVG */
+        return xive2_presenter_nvgc_backlog_op(xptr, false, blk, index, op, 1);
+    } else {
+        /* even page - NVP */
+        return xive2_presenter_nvp_backlog_op(xptr, blk, index, op);
+    }
 }
 
-static void pnv_xive2_nvpg_write(void *opaque, hwaddr offset,
+static void pnv_xive2_nvpg_write(void *opaque, hwaddr addr,
                                  uint64_t val, unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    XivePresenter *xptr = XIVE_PRESENTER(xive);
+    uint32_t page = addr >> xive->nvpg_shift;
+    uint16_t op = addr & 0xFFF;
+    uint32_t index = page >> 1;
+    uint8_t blk = pnv_xive2_block_id(xive);
 
-    xive2_error(xive, "NVPG: invalid write @%"HWADDR_PRIx, offset);
+    if (size != 1) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid nvpg write size %d\n",
+                      size);
+        return;
+    }
+
+    if (page % 2) {
+        /* odd page - NVG */
+        (void)xive2_presenter_nvgc_backlog_op(xptr, false, blk, index, op, val);
+    } else {
+        /* even page - NVP */
+        (void)xive2_presenter_nvp_backlog_op(xptr, blk, index, op);
+    }
 }
 
 static const MemoryRegionOps pnv_xive2_nvpg_ops = {
@@ -2256,11 +2308,11 @@ static const MemoryRegionOps pnv_xive2_nvpg_ops = {
     .write = pnv_xive2_nvpg_write,
     .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
     .impl = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
 };
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 0c53f71879..b6f279e6a3 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -88,6 +88,93 @@ static void xive2_nvgc_set_backlog(Xive2Nvgc *nvgc, uint8_t priority,
     }
 }
 
+uint64_t xive2_presenter_nvgc_backlog_op(XivePresenter *xptr,
+                                         bool crowd,
+                                         uint8_t blk, uint32_t idx,
+                                         uint16_t offset, uint16_t val)
+{
+    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
+    uint8_t priority = GETFIELD(NVx_BACKLOG_PRIO, offset);
+    uint8_t op = GETFIELD(NVx_BACKLOG_OP, offset);
+    Xive2Nvgc nvgc;
+    uint32_t count, old_count;
+
+    if (xive2_router_get_nvgc(xrtr, crowd, blk, idx, &nvgc)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No %s %x/%x\n",
+                      crowd ? "NVC" : "NVG", blk, idx);
+        return -1;
+    }
+    if (!xive2_nvgc_is_valid(&nvgc)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVG %x/%x\n", blk, idx);
+        return -1;
+    }
+
+    old_count = xive2_nvgc_get_backlog(&nvgc, priority);
+    count = old_count;
+    /*
+     * op:
+     * 0b00 => increment
+     * 0b01 => decrement
+     * 0b1- => read
+     */
+    if (op == 0b00 || op == 0b01) {
+        if (op == 0b00) {
+            count += val;
+        } else {
+            if (count > val) {
+                count -= val;
+            } else {
+                count = 0;
+            }
+        }
+        xive2_nvgc_set_backlog(&nvgc, priority, count);
+        xive2_router_write_nvgc(xrtr, crowd, blk, idx, &nvgc);
+    }
+    trace_xive_nvgc_backlog_op(crowd, blk, idx, op, priority, old_count);
+    return old_count;
+}
+
+uint64_t xive2_presenter_nvp_backlog_op(XivePresenter *xptr,
+                                        uint8_t blk, uint32_t idx,
+                                        uint16_t offset)
+{
+    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
+    uint8_t priority = GETFIELD(NVx_BACKLOG_PRIO, offset);
+    uint8_t op = GETFIELD(NVx_BACKLOG_OP, offset);
+    Xive2Nvp nvp;
+    uint8_t ipb, old_ipb, rc;
+
+    if (xive2_router_get_nvp(xrtr, blk, idx, &nvp)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n", blk, idx);
+        return -1;
+    }
+    if (!xive2_nvp_is_valid(&nvp)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVP %x/%x\n", blk, idx);
+        return -1;
+    }
+
+    old_ipb = xive_get_field32(NVP2_W2_IPB, nvp.w2);
+    ipb = old_ipb;
+    /*
+     * op:
+     * 0b00 => set priority bit
+     * 0b01 => reset priority bit
+     * 0b1- => read
+     */
+    if (op == 0b00 || op == 0b01) {
+        if (op == 0b00) {
+            ipb |= xive_priority_to_ipb(priority);
+        } else {
+            ipb &= ~xive_priority_to_ipb(priority);
+        }
+        nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, ipb);
+        xive2_router_write_nvp(xrtr, blk, idx, &nvp, 2);
+    }
+    rc = !!(old_ipb & xive_priority_to_ipb(priority));
+    trace_xive_nvp_backlog_op(blk, idx, op, priority, rc);
+    return rc;
+}
+
 void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf)
 {
     if (!xive2_eas_is_valid(eas)) {
diff --git a/tests/qtest/pnv-xive2-nvpg_bar.c b/tests/qtest/pnv-xive2-nvpg_bar.c
new file mode 100644
index 0000000000..10d4962d1e
--- /dev/null
+++ b/tests/qtest/pnv-xive2-nvpg_bar.c
@@ -0,0 +1,154 @@
+/*
+ * QTest testcase for PowerNV 10 interrupt controller (xive2)
+ *  - Test NVPG BAR MMIO operations
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later. See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#include "pnv-xive2-common.h"
+
+#define NVPG_BACKLOG_OP_SHIFT   10
+#define NVPG_BACKLOG_PRIO_SHIFT 4
+
+#define XIVE_PRIORITY_MAX       7
+
+enum NVx {
+    NVP,
+    NVG,
+    NVC
+};
+
+typedef enum {
+    INCR_STORE = 0b100,
+    INCR_LOAD  = 0b000,
+    DECR_STORE = 0b101,
+    DECR_LOAD  = 0b001,
+    READ_x     = 0b010,
+    READ_y     = 0b011,
+} backlog_op;
+
+static uint32_t nvpg_backlog_op(QTestState *qts, backlog_op op,
+                                enum NVx type, uint64_t index,
+                                uint8_t priority, uint8_t delta)
+{
+    uint64_t addr, offset;
+    uint32_t count = 0;
+
+    switch (type) {
+    case NVP:
+        addr = XIVE_NVPG_ADDR + (index << (XIVE_PAGE_SHIFT + 1));
+        break;
+    case NVG:
+        addr = XIVE_NVPG_ADDR + (index << (XIVE_PAGE_SHIFT + 1)) +
+            (1 << XIVE_PAGE_SHIFT);
+        break;
+    case NVC:
+        addr = XIVE_NVC_ADDR + (index << XIVE_PAGE_SHIFT);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    offset = (op & 0b11) << NVPG_BACKLOG_OP_SHIFT;
+    offset |= priority << NVPG_BACKLOG_PRIO_SHIFT;
+    if (op >> 2) {
+        qtest_writeb(qts, addr + offset, delta);
+    } else {
+        count = qtest_readw(qts, addr + offset);
+    }
+    return count;
+}
+
+void test_nvpg_bar(QTestState *qts)
+{
+    uint32_t nvp_target = 0x11;
+    uint32_t group_target = 0x17; /* size 16 */
+    uint32_t vp_irq = 33, group_irq = 47;
+    uint32_t vp_end = 3, group_end = 97;
+    uint32_t vp_irq_data = 0x33333333;
+    uint32_t group_irq_data = 0x66666666;
+    uint8_t vp_priority = 0, group_priority = 5;
+    uint32_t vp_count[XIVE_PRIORITY_MAX + 1] = { 0 };
+    uint32_t group_count[XIVE_PRIORITY_MAX + 1] = { 0 };
+    uint32_t count, delta;
+    uint8_t i;
+
+    printf("# ============================================================\n");
+    printf("# Testing NVPG BAR operations\n");
+
+    set_nvg(qts, group_target, 0);
+    set_nvp(qts, nvp_target, 0x04);
+    set_nvp(qts, group_target, 0x04);
+
+    /*
+     * Setup: trigger a VP-specific interrupt and a group interrupt
+     * so that the backlog counters are initialized to something else
+     * than 0 for at least one priority level
+     */
+    set_eas(qts, vp_irq, vp_end, vp_irq_data);
+    set_end(qts, vp_end, nvp_target, vp_priority, false /* group */);
+
+    set_eas(qts, group_irq, group_end, group_irq_data);
+    set_end(qts, group_end, group_target, group_priority, true /* group */);
+
+    get_esb(qts, vp_irq, XIVE_EOI_PAGE, XIVE_ESB_SET_PQ_00);
+    set_esb(qts, vp_irq, XIVE_TRIGGER_PAGE, 0, 0);
+    vp_count[vp_priority]++;
+
+    get_esb(qts, group_irq, XIVE_EOI_PAGE, XIVE_ESB_SET_PQ_00);
+    set_esb(qts, group_irq, XIVE_TRIGGER_PAGE, 0, 0);
+    group_count[group_priority]++;
+
+    /* check the initial counters */
+    for (i = 0; i <= XIVE_PRIORITY_MAX; i++) {
+        count = nvpg_backlog_op(qts, READ_x, NVP, nvp_target, i, 0);
+        g_assert_cmpuint(count, ==, vp_count[i]);
+
+        count = nvpg_backlog_op(qts, READ_y, NVG, group_target, i, 0);
+        g_assert_cmpuint(count, ==, group_count[i]);
+    }
+
+    /* do a few ops on the VP. Counter can only be 0 and 1 */
+    vp_priority = 2;
+    delta = 7;
+    nvpg_backlog_op(qts, INCR_STORE, NVP, nvp_target, vp_priority, delta);
+    vp_count[vp_priority] = 1;
+    count = nvpg_backlog_op(qts, INCR_LOAD, NVP, nvp_target, vp_priority, 0);
+    g_assert_cmpuint(count, ==, vp_count[vp_priority]);
+    count = nvpg_backlog_op(qts, READ_y, NVP, nvp_target, vp_priority, 0);
+    g_assert_cmpuint(count, ==, vp_count[vp_priority]);
+
+    count = nvpg_backlog_op(qts, DECR_LOAD, NVP, nvp_target, vp_priority, 0);
+    g_assert_cmpuint(count, ==, vp_count[vp_priority]);
+    vp_count[vp_priority] = 0;
+    nvpg_backlog_op(qts, DECR_STORE, NVP, nvp_target, vp_priority, delta);
+    count = nvpg_backlog_op(qts, READ_x, NVP, nvp_target, vp_priority, 0);
+    g_assert_cmpuint(count, ==, vp_count[vp_priority]);
+
+    /* do a few ops on the group */
+    group_priority = 2;
+    delta = 9;
+    /* can't go negative */
+    nvpg_backlog_op(qts, DECR_STORE, NVG, group_target, group_priority, delta);
+    count = nvpg_backlog_op(qts, READ_y, NVG, group_target, group_priority, 0);
+    g_assert_cmpuint(count, ==, 0);
+    nvpg_backlog_op(qts, INCR_STORE, NVG, group_target, group_priority, delta);
+    group_count[group_priority] += delta;
+    count = nvpg_backlog_op(qts, INCR_LOAD, NVG, group_target,
+                            group_priority, delta);
+    g_assert_cmpuint(count, ==, group_count[group_priority]);
+    group_count[group_priority]++;
+
+    count = nvpg_backlog_op(qts, DECR_LOAD, NVG, group_target,
+                            group_priority, delta);
+    g_assert_cmpuint(count, ==,  group_count[group_priority]);
+    group_count[group_priority]--;
+    count = nvpg_backlog_op(qts, READ_x, NVG, group_target, group_priority, 0);
+    g_assert_cmpuint(count, ==, group_count[group_priority]);
+}
+
diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
index 1705127da1..a6008bc053 100644
--- a/tests/qtest/pnv-xive2-test.c
+++ b/tests/qtest/pnv-xive2-test.c
@@ -494,6 +494,9 @@ static void test_xive(void)
     reset_state(qts);
     test_flush_sync_inject(qts);
 
+    reset_state(qts);
+    test_nvpg_bar(qts);
+
     qtest_quit(qts);
 }
 
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 7435728c51..7f362c38b0 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -285,6 +285,10 @@ xive_tctx_tm_read(uint32_t index, uint64_t offset, unsigned int size, uint64_t v
 xive_presenter_notify(uint8_t nvt_blk, uint32_t nvt_idx, uint8_t ring, uint8_t group_level) "found NVT 0x%x/0x%x ring=0x%x group_level=%d"
 xive_end_source_read(uint8_t end_blk, uint32_t end_idx, uint64_t addr) "END 0x%x/0x%x @0x%"PRIx64
 
+# xive2.c
+xive_nvp_backlog_op(uint8_t blk, uint32_t idx, uint8_t op, uint8_t priority, uint8_t rc) "NVP 0x%x/0x%x operation=%d priority=%d rc=%d"
+xive_nvgc_backlog_op(bool c, uint8_t blk, uint32_t idx, uint8_t op, uint8_t priority, uint32_t rc) "NVGC crowd=%d 0x%x/0x%x operation=%d priority=%d rc=%d"
+
 # pnv_xive.c
 pnv_xive_ic_hw_trigger(uint64_t addr, uint64_t val) "@0x%"PRIx64" val=0x%"PRIx64
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index d2af58800d..9ef9819450 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -337,7 +337,8 @@ qtests = {
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': migration_files,
   'pxe-test': files('boot-sector.c'),
-  'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c'),
+  'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
+                          'pnv-xive2-nvpg_bar.c'),
   'qos-test': [chardev, io, qos_test_ss.apply({}).sources()],
   'tpm-crb-swtpm-test': [io, tpmemu_files],
   'tpm-crb-test': [io, tpmemu_files],
-- 
2.43.0


