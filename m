Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779A0C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtIE-0003bE-M5; Mon, 21 Jul 2025 12:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtHz-0003CY-Mx
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtHv-0001N3-FS
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753114969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cn7VHl4DO/rNgK3+mkF6GERVNq6gKa9iNDHFLe9Dwzk=;
 b=L7FBnWY/hqCJi69p+IM0rKKQG6y8al+scJQHIZZwS1Yc6eDsIDvwNzcMupNDZe1IKUdatJ
 mY6tkK1mzrIh0hB/BoIgKD3CYfWFsg2A23LILA5SNEFR5vqz22PDikwQsvKvWS0xKOQtPv
 9kGjB0BwkgU1E8waXjlMeeP8TmDn6XE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-ek7-4CstOvmFTvg1osrdtw-1; Mon,
 21 Jul 2025 12:22:47 -0400
X-MC-Unique: ek7-4CstOvmFTvg1osrdtw-1
X-Mimecast-MFC-AGG-ID: ek7-4CstOvmFTvg1osrdtw_1753114966
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D78A19560B3; Mon, 21 Jul 2025 16:22:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 929B4195608D; Mon, 21 Jul 2025 16:22:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/50] ppc/xive2: Fix calculation of END queue sizes
Date: Mon, 21 Jul 2025 18:21:46 +0200
Message-ID: <20250721162233.686837-4-clg@redhat.com>
In-Reply-To: <20250721162233.686837-1-clg@redhat.com>
References: <20250721162233.686837-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 include/hw/ppc/xive2_regs.h |  1 +
 hw/intc/xive2.c             | 25 +++++++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index b11395c56350..3c28de8a304d 100644
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
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index a08cf906d0e6..cb75ca879853 100644
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
-- 
2.50.1


