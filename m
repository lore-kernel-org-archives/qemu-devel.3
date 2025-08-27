Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE7FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHlu-000283-Ij; Wed, 27 Aug 2025 11:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHjp-0007Ev-Eg; Wed, 27 Aug 2025 11:07:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHjm-0005Wf-D0; Wed, 27 Aug 2025 11:07:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2717C14C550;
 Wed, 27 Aug 2025 18:02:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 10087269858;
 Wed, 27 Aug 2025 18:03:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 40/59] ppc/xive2: Fix calculation of END queue sizes
Date: Wed, 27 Aug 2025 18:02:45 +0300
Message-ID: <20250827150323.2694101-40-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Glenn Miles <milesg@linux.ibm.com>

The queue size of an Event Notification Descriptor (END)
is determined by the 'cl' and QsZ fields of the END.
If the cl field is 1, then the queue size (in bytes) will
be the size of a cache line 128B * 2^QsZ and QsZ is limited
to 4.  Otherwise, it will be 4096B * 2^QsZ with QsZ limited
to 12.

Fixes: f8a233dedf2 ("ppc/xive2: Introduce a XIVE2 core framework")
Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-4-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit f16697292add6c3c15014a20fd5fce70b8c56734)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 7d584dfafa..790152a2a6 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -188,12 +188,27 @@ void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf)
                            (uint32_t) xive_get_field64(EAS2_END_DATA, eas->w));
 }
 
+#define XIVE2_QSIZE_CHUNK_CL    128
+#define XIVE2_QSIZE_CHUNK_4k   4096
+/* Calculate max number of queue entries for an END */
+static uint32_t xive2_end_get_qentries(Xive2End *end)
+{
+    uint32_t w3 = end->w3;
+    uint32_t qsize = xive_get_field32(END2_W3_QSIZE, w3);
+    if (xive_get_field32(END2_W3_CL, w3)) {
+        g_assert(qsize <= 4);
+        return (XIVE2_QSIZE_CHUNK_CL << qsize) / sizeof(uint32_t);
+    } else {
+        g_assert(qsize <= 12);
+        return (XIVE2_QSIZE_CHUNK_4k << qsize) / sizeof(uint32_t);
+    }
+}
+
 void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width, GString *buf)
 {
     uint64_t qaddr_base = xive2_end_qaddr(end);
-    uint32_t qsize = xive_get_field32(END2_W3_QSIZE, end->w3);
     uint32_t qindex = xive_get_field32(END2_W1_PAGE_OFF, end->w1);
-    uint32_t qentries = 1 << (qsize + 10);
+    uint32_t qentries = xive2_end_get_qentries(end);
     int i;
 
     /*
@@ -223,8 +238,7 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, GString *buf)
     uint64_t qaddr_base = xive2_end_qaddr(end);
     uint32_t qindex = xive_get_field32(END2_W1_PAGE_OFF, end->w1);
     uint32_t qgen = xive_get_field32(END2_W1_GENERATION, end->w1);
-    uint32_t qsize = xive_get_field32(END2_W3_QSIZE, end->w3);
-    uint32_t qentries = 1 << (qsize + 10);
+    uint32_t qentries = xive2_end_get_qentries(end);
 
     uint32_t nvx_blk = xive_get_field32(END2_W6_VP_BLOCK, end->w6);
     uint32_t nvx_idx = xive_get_field32(END2_W6_VP_OFFSET, end->w6);
@@ -341,13 +355,12 @@ void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uint32_t nvgc_idx, GString *buf)
 static void xive2_end_enqueue(Xive2End *end, uint32_t data)
 {
     uint64_t qaddr_base = xive2_end_qaddr(end);
-    uint32_t qsize = xive_get_field32(END2_W3_QSIZE, end->w3);
     uint32_t qindex = xive_get_field32(END2_W1_PAGE_OFF, end->w1);
     uint32_t qgen = xive_get_field32(END2_W1_GENERATION, end->w1);
 
     uint64_t qaddr = qaddr_base + (qindex << 2);
     uint32_t qdata = cpu_to_be32((qgen << 31) | (data & 0x7fffffff));
-    uint32_t qentries = 1 << (qsize + 10);
+    uint32_t qentries = xive2_end_get_qentries(end);
 
     if (dma_memory_write(&address_space_memory, qaddr, &qdata, sizeof(qdata),
                          MEMTXATTRS_UNSPECIFIED)) {
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index b11395c563..3c28de8a30 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -87,6 +87,7 @@ typedef struct Xive2End {
 #define END2_W2_EQ_ADDR_HI         PPC_BITMASK32(8, 31)
         uint32_t       w3;
 #define END2_W3_EQ_ADDR_LO         PPC_BITMASK32(0, 24)
+#define END2_W3_CL                 PPC_BIT32(27)
 #define END2_W3_QSIZE              PPC_BITMASK32(28, 31)
         uint32_t       w4;
 #define END2_W4_END_BLOCK          PPC_BITMASK32(4, 7)
-- 
2.47.2


