Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4F9C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 20:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZcRt-0004Ho-7t; Thu, 01 Aug 2024 16:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRl-0003oD-JK; Thu, 01 Aug 2024 16:30:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRh-0007Nj-7H; Thu, 01 Aug 2024 16:30:48 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471JKZhb006222;
 Thu, 1 Aug 2024 20:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=zh4nz8uWy+Jjz
 UogOcNEa1nAWKl+x65PqSnUET3GuCY=; b=EPIO+FS8b09SH4o3DS/z7eeB1Yd5C
 ipMcmOROtKZAMCa3BA7cE3EQKYTfcmH2XCHTr9z1q5YB6XwUmBz3FpRODqj2wtHN
 xqmC8bPQMn8OozsrV3nuNCrCnOlLWxC7OuDNMfezqt9Ua7fW98qiOhuDNpu7bOFf
 egCz88BrFYWNne8sNuWc4DEmxVTgUcFpUCuMF1ZE4J0cjMLFNTHoIXF9MDQAmtjK
 1DXb7AuVeli2ShymfZq5iMM4giVhZko98XdaJR5dC7WrhROe9ROkKhPeXHmYn4tP
 YxnQLB3OGjiT9oaQHXwYiwQGqEKetmocsQ8/ppNjjGZsfS4TER7QyQJqA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rdyhrg0v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:34 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 471KUXZp025473;
 Thu, 1 Aug 2024 20:30:33 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rdyhrg0s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 471Jh4oE009202; Thu, 1 Aug 2024 20:30:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndx3begj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 471KURFE27067124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Aug 2024 20:30:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C85942004F;
 Thu,  1 Aug 2024 20:30:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EE862004D;
 Thu,  1 Aug 2024 20:30:26 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Aug 2024 20:30:26 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH 06/13] ppc/xive2: Dump the VP-group and crowd tables with
 'info pic'
Date: Thu,  1 Aug 2024 15:30:01 -0500
Message-Id: <20240801203008.11224-7-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240801203008.11224-1-kowal@linux.ibm.com>
References: <20240801203008.11224-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VzDIPF1HL46OEC0g0Af0DSl0zCzsgUHI
X-Proofpoint-ORIG-GUID: GbTKWegIiz_dL0wBw1jW-5Jk_nmdNqFu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 spamscore=0 mlxlogscore=736 mlxscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010135
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

The 'info pic' HMP command dumps the state of the interrupt controller.
Add the dump of the NVG and NVC tables to its output to ease debug.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive2.h      | 12 ++++++
 include/hw/ppc/xive2_regs.h |  6 +++
 hw/intc/pnv_xive2.c         | 56 ++++++++++++++++++++++++--
 hw/intc/xive2.c             | 80 +++++++++++++++++++++++++++++++++++++
 4 files changed, 151 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 654f485e9b..b7a7c33ddd 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -53,6 +53,12 @@ typedef struct Xive2RouterClass {
                    Xive2Nvp *nvp);
     int (*write_nvp)(Xive2Router *xrtr, uint8_t nvp_blk, uint32_t nvp_idx,
                      Xive2Nvp *nvp, uint8_t word_number);
+    int (*get_nvgc)(Xive2Router *xrtr, bool crowd,
+                    uint8_t nvgc_blk, uint32_t nvgc_idx,
+                    Xive2Nvgc *nvgc);
+    int (*write_nvgc)(Xive2Router *xrtr, bool crowd,
+                      uint8_t nvgc_blk, uint32_t nvgc_idx,
+                      Xive2Nvgc *nvgc);
     uint8_t (*get_block_id)(Xive2Router *xrtr);
     uint32_t (*get_config)(Xive2Router *xrtr);
 } Xive2RouterClass;
@@ -67,6 +73,12 @@ int xive2_router_get_nvp(Xive2Router *xrtr, uint8_t nvp_blk, uint32_t nvp_idx,
                         Xive2Nvp *nvp);
 int xive2_router_write_nvp(Xive2Router *xrtr, uint8_t nvp_blk, uint32_t nvp_idx,
                           Xive2Nvp *nvp, uint8_t word_number);
+int xive2_router_get_nvgc(Xive2Router *xrtr, bool crowd,
+                          uint8_t nvgc_blk, uint32_t nvgc_idx,
+                          Xive2Nvgc *nvgc);
+int xive2_router_write_nvgc(Xive2Router *xrtr, bool crowd,
+                            uint8_t nvgc_blk, uint32_t nvgc_idx,
+                            Xive2Nvgc *nvgc);
 uint32_t xive2_router_get_config(Xive2Router *xrtr);
 
 void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked);
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index d71a54f9ff..99840e88a8 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -212,6 +212,7 @@ void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf);
 typedef struct Xive2Nvgc {
         uint32_t        w0;
 #define NVGC2_W0_VALID             PPC_BIT32(0)
+#define NVGC2_W0_PGONEXT           PPC_BITMASK32(26, 31)
         uint32_t        w1;
         uint32_t        w2;
         uint32_t        w3;
@@ -221,4 +222,9 @@ typedef struct Xive2Nvgc {
         uint32_t        w7;
 } Xive2Nvgc;
 
+#define xive2_nvgc_is_valid(nvgc)    (be32_to_cpu((nvgc)->w0) & NVGC2_W0_VALID)
+
+void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uint32_t nvgc_idx,
+                               GString *buf);
+
 #endif /* PPC_XIVE2_REGS_H */
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 4740c56347..5959e2df3a 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -490,6 +490,35 @@ static int pnv_xive2_write_nvp(Xive2Router *xrtr, uint8_t blk, uint32_t idx,
                               word_number);
 }
 
+static int pnv_xive2_get_nvgc(Xive2Router *xrtr, bool crowd,
+                              uint8_t blk, uint32_t idx,
+                              Xive2Nvgc *nvgc)
+{
+    int type;
+
+    if (crowd) {
+        type = VST_NVC;
+    } else {
+        type = VST_NVG;
+    }
+    return pnv_xive2_vst_read(PNV_XIVE2(xrtr), type, blk, idx, nvgc);
+}
+
+static int pnv_xive2_write_nvgc(Xive2Router *xrtr, bool crowd,
+                                uint8_t blk, uint32_t idx,
+                                Xive2Nvgc *nvgc)
+{
+    int type;
+
+    if (crowd) {
+        type = VST_NVC;
+    } else {
+        type = VST_NVG;
+    }
+    return pnv_xive2_vst_write(PNV_XIVE2(xrtr), type, blk, idx, nvgc,
+                               XIVE_VST_WORD_ALL);
+}
+
 static int pnv_xive2_nxc_to_table_type(uint8_t nxc_type, uint32_t *table_type)
 {
     switch (nxc_type) {
@@ -2407,6 +2436,8 @@ static void pnv_xive2_class_init(ObjectClass *klass, void *data)
     xrc->write_end = pnv_xive2_write_end;
     xrc->get_nvp   = pnv_xive2_get_nvp;
     xrc->write_nvp = pnv_xive2_write_nvp;
+    xrc->get_nvgc   = pnv_xive2_get_nvgc;
+    xrc->write_nvgc = pnv_xive2_write_nvgc;
     xrc->get_config  = pnv_xive2_get_config;
     xrc->get_block_id = pnv_xive2_get_block_id;
 
@@ -2497,8 +2528,9 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, GString *buf)
     Xive2Eas eas;
     Xive2End end;
     Xive2Nvp nvp;
+    Xive2Nvgc nvgc;
     int i;
-    uint64_t xive_nvp_per_subpage;
+    uint64_t entries_per_subpage;
 
     g_string_append_printf(buf, "XIVE[%x] Source %08x .. %08x\n",
                            blk, srcno0, srcno0 + nr_esbs - 1);
@@ -2530,10 +2562,28 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, GString *buf)
 
     g_string_append_printf(buf, "XIVE[%x] #%d NVPT %08x .. %08x\n",
                            chip_id, blk, 0, XIVE2_NVP_COUNT - 1);
-    xive_nvp_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVP);
-    for (i = 0; i < XIVE2_NVP_COUNT; i += xive_nvp_per_subpage) {
+    entries_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVP);
+    for (i = 0; i < XIVE2_NVP_COUNT; i += entries_per_subpage) {
         while (!xive2_router_get_nvp(xrtr, blk, i, &nvp)) {
             xive2_nvp_pic_print_info(&nvp, i++, buf);
         }
     }
+
+    g_string_append_printf(buf, "XIVE[%x] #%d NVGT %08x .. %08x\n",
+                           chip_id, blk, 0, XIVE2_NVP_COUNT - 1);
+    entries_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVG);
+    for (i = 0; i < XIVE2_NVP_COUNT; i += entries_per_subpage) {
+        while (!xive2_router_get_nvgc(xrtr, false, blk, i, &nvgc)) {
+            xive2_nvgc_pic_print_info(&nvgc, i++, buf);
+        }
+    }
+
+    g_string_append_printf(buf, "XIVE[%x] #%d NVCT %08x .. %08x\n",
+                          chip_id, blk, 0, XIVE2_NVP_COUNT - 1);
+    entries_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVC);
+    for (i = 0; i < XIVE2_NVP_COUNT; i += entries_per_subpage) {
+        while (!xive2_router_get_nvgc(xrtr, true, blk, i, &nvgc)) {
+            xive2_nvgc_pic_print_info(&nvgc, i++, buf);
+        }
+    }
 }
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 034baabf1e..9d19273bc8 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -43,6 +43,51 @@ static uint64_t xive2_nvp_reporting_addr(Xive2Nvp *nvp)
     return cache_addr;
 }
 
+static uint32_t xive2_nvgc_get_backlog(Xive2Nvgc *nvgc, uint8_t priority)
+{
+    uint32_t val = 0;
+    uint8_t *ptr, i;
+
+    if (priority > 7) {
+        return 0;
+    }
+
+    /*
+     * The per-priority backlog counters are 24-bit and the structure
+     * is stored in big endian
+     */
+    ptr = (uint8_t *)&nvgc->w2 + priority * 3;
+    for (i = 0; i < 3; i++, ptr++) {
+        val = (val << 8) + *ptr;
+    }
+    return val;
+}
+
+__attribute__((unused))
+static void  xive2_nvgc_set_backlog(Xive2Nvgc *nvgc, uint8_t priority,
+                                   uint32_t val)
+{
+    uint8_t *ptr, i;
+    uint32_t shift;
+
+    if (priority > 7) {
+        return;
+    }
+
+    if (val > 0xFFFFFF) {
+        val = 0xFFFFFF;
+    }
+    /*
+     * The per-priority backlog counters are 24-bit and the structure
+     * is stored in big endian
+     */
+    ptr = (uint8_t *)&nvgc->w2 + priority * 3;
+    for (i = 0; i < 3; i++, ptr++) {
+        shift = 8 * (2 - i);
+        *ptr = (val >> shift) & 0xFF;
+    }
+}
+
 void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf)
 {
     if (!xive2_eas_is_valid(eas)) {
@@ -189,6 +234,23 @@ void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf)
     g_string_append_c(buf, '\n');
 }
 
+void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uint32_t nvgc_idx, GString *buf)
+{
+    uint8_t i;
+
+    if (!xive2_nvgc_is_valid(nvgc)) {
+        return;
+    }
+
+    g_string_append_printf(buf, "  %08x PGoNext:%02x bklog: ", nvgc_idx,
+                           xive_get_field32(NVGC2_W0_PGONEXT, nvgc->w0));
+    for (i = 0; i <= XIVE_PRIORITY_MAX; i++) {
+        g_string_append_printf(buf, "[%d]=0x%x ",
+                               i, xive2_nvgc_get_backlog(nvgc, i));
+    }
+    g_string_append_printf(buf, "\n");
+}
+
 static void xive2_end_enqueue(Xive2End *end, uint32_t data)
 {
     uint64_t qaddr_base = xive2_end_qaddr(end);
@@ -600,6 +662,24 @@ int xive2_router_write_nvp(Xive2Router *xrtr, uint8_t nvp_blk, uint32_t nvp_idx,
    return xrc->write_nvp(xrtr, nvp_blk, nvp_idx, nvp, word_number);
 }
 
+int xive2_router_get_nvgc(Xive2Router *xrtr, bool crowd,
+                          uint8_t nvgc_blk, uint32_t nvgc_idx,
+                          Xive2Nvgc *nvgc)
+{
+   Xive2RouterClass *xrc = XIVE2_ROUTER_GET_CLASS(xrtr);
+
+   return xrc->get_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, nvgc);
+}
+
+int xive2_router_write_nvgc(Xive2Router *xrtr, bool crowd,
+                            uint8_t nvgc_blk, uint32_t nvgc_idx,
+                            Xive2Nvgc *nvgc)
+{
+   Xive2RouterClass *xrc = XIVE2_ROUTER_GET_CLASS(xrtr);
+
+   return xrc->write_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, nvgc);
+}
+
 /*
  * The thread context register words are in big-endian format.
  */
-- 
2.43.0


