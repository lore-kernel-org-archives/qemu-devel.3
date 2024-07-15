Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512CBC3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 18:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTQX8-0007Xe-KR; Mon, 15 Jul 2024 14:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sTQX6-0007QH-Qj; Mon, 15 Jul 2024 14:34:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sTQX4-0007Hc-Vm; Mon, 15 Jul 2024 14:34:44 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FIU9db018344;
 Mon, 15 Jul 2024 18:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=gBm+mytZrG6dh
 39dchTlXy0VSdNgcYlmVkPwj6AabxM=; b=mczF8a1JvEXW7/UgvWnscV/SjYs5U
 CHKzayyYzOZ17JkMBZPeavK4PisAbYVKLTuB4k5isVuI2Lj5Vj+Z1EVhKfgy9tZ2
 G+52DiBWmgNLUeLxEmxE6fcdhQOOuBJ+wri5eZjrhhahDOBRsuHcBk9dnLQgCQVB
 uuir+3rq6QJ6eMOKLfGlQ/YWcQW4paNg2HFnpJL1i4eF125dBmYFfGg4GDNh1e7x
 QxEZZd/pICzCjVzzFWZoXq6S2E8favN6Dx1fOmvn4Gr64YhAmJYfhpoQTi5a+fCX
 /7FSN8imiglV7FJZjGWn+DT4Vip4gXA0u/8S6xemlF6rWtD1wodBagUQQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d92xg0ag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:40 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46FIYd4Y025910;
 Mon, 15 Jul 2024 18:34:39 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d92xg0ad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46FH5M06015025; Mon, 15 Jul 2024 18:34:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40c4wp8aa9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46FIYXOD50987470
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jul 2024 18:34:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A7A72004B;
 Mon, 15 Jul 2024 18:34:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A1CB20040;
 Mon, 15 Jul 2024 18:34:32 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jul 2024 18:34:32 +0000 (GMT)
From: Michael Kowal <kowal@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v2 9/9] pnv/xive2: Move xive2_nvp_pic_print_info() to xive2.c
Date: Mon, 15 Jul 2024 13:33:32 -0500
Message-Id: <20240715183332.27287-10-kowal@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240715183332.27287-1-kowal@linux.vnet.ibm.com>
References: <20240715183332.27287-1-kowal@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HMLwN7N_fWkzJNsVIOtPdwjbcX-Gb-sC
X-Proofpoint-ORIG-GUID: dFv3Zedw7xPGwPTF0St79sqOZ58cJca9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=806 suspectscore=0
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Moving xive2_nvp_pic_print_info() align with the other "pic_print_info"
functions and allows us to call functions internal to xive2.c.

In XIVE Gen 2 there were some minor changes to the TIMA header that were
updated when printed.

Additional END state 'info pic' information as added.  The 'ignore',
'crowd' and 'precluded escalation control' bits of an Event Notification
Descriptor are all used when delivering an interrupt targeting a VP-group
or crowd.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
---
 include/hw/ppc/xive2_regs.h |  9 +++++++++
 hw/intc/pnv_xive2.c         | 27 ---------------------------
 hw/intc/xive.c              | 12 +++++++++---
 hw/intc/xive2.c             | 33 +++++++++++++++++++++++++++++++--
 4 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 4e5e17cd89..4349d009d0 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -97,6 +97,7 @@ typedef struct Xive2End {
         uint32_t       w6;
 #define END2_W6_FORMAT_BIT         PPC_BIT32(0)
 #define END2_W6_IGNORE             PPC_BIT32(1)
+#define END2_W6_CROWD              PPC_BIT32(2)
 #define END2_W6_VP_BLOCK           PPC_BITMASK32(4, 7)
 #define END2_W6_VP_OFFSET          PPC_BITMASK32(8, 31)
 #define END2_W6_VP_OFFSET_GEN1     PPC_BITMASK32(13, 31)
@@ -111,6 +112,8 @@ typedef struct Xive2End {
 #define xive2_end_is_notify(end)                \
     (be32_to_cpu((end)->w0) & END2_W0_UCOND_NOTIFY)
 #define xive2_end_is_backlog(end)  (be32_to_cpu((end)->w0) & END2_W0_BACKLOG)
+#define xive2_end_is_precluded_escalation(end)          \
+    (be32_to_cpu((end)->w0) & END2_W0_PRECL_ESC_CTL)
 #define xive2_end_is_escalate(end)                      \
     (be32_to_cpu((end)->w0) & END2_W0_ESCALATE_CTL)
 #define xive2_end_is_uncond_escalation(end)              \
@@ -123,6 +126,10 @@ typedef struct Xive2End {
     (be32_to_cpu((end)->w0) & END2_W0_FIRMWARE1)
 #define xive2_end_is_firmware2(end)              \
     (be32_to_cpu((end)->w0) & END2_W0_FIRMWARE2)
+#define xive2_end_is_ignore(end)                \
+    (be32_to_cpu((end)->w6) & END2_W6_IGNORE)
+#define xive2_end_is_crowd(end)                 \
+    (be32_to_cpu((end)->w6) & END2_W6_CROWD)
 
 static inline uint64_t xive2_end_qaddr(Xive2End *end)
 {
@@ -194,6 +201,8 @@ static inline uint32_t xive2_nvp_blk(uint32_t cam_line)
     return (cam_line >> XIVE2_NVP_SHIFT) & 0xf;
 }
 
+void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf);
+
 /*
  * Notification Virtual Group or Crowd (NVG/NVC)
  */
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index ad0d6f45e4..7846f2ef33 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -2433,33 +2433,6 @@ static void pnv_xive2_register_types(void)
 
 type_init(pnv_xive2_register_types)
 
-static void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx,
-                                     GString *buf)
-{
-    uint8_t  eq_blk = xive_get_field32(NVP2_W5_VP_END_BLOCK, nvp->w5);
-    uint32_t eq_idx = xive_get_field32(NVP2_W5_VP_END_INDEX, nvp->w5);
-
-    if (!xive2_nvp_is_valid(nvp)) {
-        return;
-    }
-
-    g_string_append_printf(buf, "  %08x end:%02x/%04x IPB:%02x",
-                           nvp_idx, eq_blk, eq_idx,
-                           xive_get_field32(NVP2_W2_IPB, nvp->w2));
-    /*
-     * When the NVP is HW controlled, more fields are updated
-     */
-    if (xive2_nvp_is_hw(nvp)) {
-        g_string_append_printf(buf, " CPPR:%02x",
-                               xive_get_field32(NVP2_W2_CPPR, nvp->w2));
-        if (xive2_nvp_is_co(nvp)) {
-            g_string_append_printf(buf, " CO:%04x",
-                                   xive_get_field32(NVP2_W1_CO_THRID, nvp->w1));
-        }
-    }
-    g_string_append_c(buf, '\n');
-}
-
 /*
  * If the table is direct, we can compute the number of PQ entries
  * provisioned by FW.
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 70f11f993b..5a02dd8e02 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -692,9 +692,15 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, GString *buf)
         }
     }
 
-    g_string_append_printf(buf, "CPU[%04x]:   "
-                           "QW   NSR CPPR IPB LSMFB ACK# INC AGE PIPR  W2\n",
-                           cpu_index);
+    if (xive_presenter_get_config(tctx->xptr) & XIVE_PRESENTER_GEN1_TIMA_OS) {
+        g_string_append_printf(buf, "CPU[%04x]:   "
+                               "QW   NSR CPPR IPB LSMFB ACK# INC AGE PIPR"
+                               "  W2\n", cpu_index);
+    } else {
+        g_string_append_printf(buf, "CPU[%04x]:   "
+                               "QW   NSR CPPR IPB LSMFB   -  LGS  T  PIPR"
+                               "  W2\n", cpu_index);
+    }
 
     for (i = 0; i < XIVE_TM_RING_COUNT; i++) {
         char *s = xive_tctx_ring_print(&tctx->regs[i * XIVE_TM_RING_SIZE]);
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 3e7238c663..1f150685bf 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -89,7 +89,7 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, GString *buf)
     pq = xive_get_field32(END2_W1_ESn, end->w1);
 
     g_string_append_printf(buf,
-                           "  %08x %c%c %c%c%c%c%c%c%c%c%c%c "
+                           "  %08x %c%c %c%c%c%c%c%c%c%c%c%c%c %c%c "
                            "prio:%d nvp:%02x/%04x",
                            end_idx,
                            pq & XIVE_ESB_VAL_P ? 'P' : '-',
@@ -98,12 +98,15 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, GString *buf)
                            xive2_end_is_enqueue(end)  ? 'q' : '-',
                            xive2_end_is_notify(end)   ? 'n' : '-',
                            xive2_end_is_backlog(end)  ? 'b' : '-',
+                           xive2_end_is_precluded_escalation(end) ? 'p' : '-',
                            xive2_end_is_escalate(end) ? 'e' : '-',
                            xive2_end_is_escalate_end(end) ? 'N' : '-',
                            xive2_end_is_uncond_escalation(end)   ? 'u' : '-',
                            xive2_end_is_silent_escalation(end)   ? 's' : '-',
                            xive2_end_is_firmware1(end)   ? 'f' : '-',
                            xive2_end_is_firmware2(end)   ? 'F' : '-',
+                           xive2_end_is_ignore(end) ? 'i' : '-',
+                           xive2_end_is_crowd(end)  ? 'c' : '-',
                            priority, nvp_blk, nvp_idx);
 
     if (qaddr_base) {
@@ -137,6 +140,32 @@ void xive2_end_eas_pic_print_info(Xive2End *end, uint32_t end_idx,
                            (uint32_t) xive_get_field64(EAS2_END_DATA, eas->w));
 }
 
+void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf)
+{
+    uint8_t  eq_blk = xive_get_field32(NVP2_W5_VP_END_BLOCK, nvp->w5);
+    uint32_t eq_idx = xive_get_field32(NVP2_W5_VP_END_INDEX, nvp->w5);
+
+    if (!xive2_nvp_is_valid(nvp)) {
+        return;
+    }
+
+    g_string_append_printf(buf, "  %08x end:%02x/%04x IPB:%02x",
+                           nvp_idx, eq_blk, eq_idx,
+                           xive_get_field32(NVP2_W2_IPB, nvp->w2));
+    /*
+     * When the NVP is HW controlled, more fields are updated
+     */
+    if (xive2_nvp_is_hw(nvp)) {
+        g_string_append_printf(buf, " CPPR:%02x",
+                               xive_get_field32(NVP2_W2_CPPR, nvp->w2));
+        if (xive2_nvp_is_co(nvp)) {
+            g_string_append_printf(buf, " CO:%04x",
+                                   xive_get_field32(NVP2_W1_CO_THRID, nvp->w1));
+        }
+    }
+    g_string_append_c(buf, '\n');
+}
+
 static void xive2_end_enqueue(Xive2End *end, uint32_t data)
 {
     uint64_t qaddr_base = xive2_end_qaddr(end);
@@ -650,7 +679,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     }
 
     found = xive_presenter_notify(xrtr->xfb, format, nvp_blk, nvp_idx,
-                          xive_get_field32(END2_W6_IGNORE, end.w7),
+                          xive2_end_is_ignore(&end),
                           priority,
                           xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7));
 
-- 
2.43.0


