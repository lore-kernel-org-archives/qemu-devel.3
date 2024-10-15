Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFA3D1F9D8
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 21:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0os3-0004iU-Aj; Tue, 15 Oct 2024 17:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0os2-0004g1-Ad; Tue, 15 Oct 2024 17:14:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0os0-0000R4-AC; Tue, 15 Oct 2024 17:14:22 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FKsoI1005634;
 Tue, 15 Oct 2024 21:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/mT1cbEScz7D/Q/TK
 ztwqyR3ENNMowBPo+2jzLFWcRg=; b=fNUhr0Uw8O4GvrZGUivqc7Y2ZsNgICQKd
 Vrh2n2RVAEolgNtLkJENblFZYg0BMLBVGEhCzWG0STf+Wvri19/nUM3N5ulddx71
 /YR4U+4//rjrhIds424jc5Ue0gg0cFotCT7kzJOEF0yYIrNE0vYOzDhQS1slcDQB
 UzFCYs1laL+9euf1s6OrnNoKEVsTGk7jaXTjCaLTYT/IZ7vYg2c+WMMABjhS9Enr
 Xw1jswjnSCv+lIeOIOMUzY1nEswu24QaD4/OjpJ7WdYJXVtUVWbyqJksQqE1ieIE
 P4qoX7Rr/Eo6gXPDLsITHDpiScq83gDpusD0ZF/4fJVppaE6v7Niw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429yun81yh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:14 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FLDDLI007748;
 Tue, 15 Oct 2024 21:14:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429yun81yc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHpSRS001982;
 Tue, 15 Oct 2024 21:14:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emnyug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49FLE8LO52691292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Oct 2024 21:14:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E8272004D;
 Tue, 15 Oct 2024 21:14:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84B6B20043;
 Tue, 15 Oct 2024 21:14:06 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Oct 2024 21:14:06 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH 13/14] pnv/xive: Fix problem with treating NVGC as a NVP
Date: Tue, 15 Oct 2024 16:13:28 -0500
Message-Id: <20241015211329.21113-14-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015211329.21113-1-kowal@linux.ibm.com>
References: <20241015211329.21113-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cvBzA-Ovkn_CkOt9B6MB3K9QAaxnmmKe
X-Proofpoint-GUID: Yg6MIo9N9TE_o0RtPeUVeeejVQ_RM-ke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

From: Glenn Miles <milesg@linux.ibm.com>

When booting with PHYP, the blk/index for a NVGC was being
mistakenly treated as the blk/index for a NVP.  Renamed
nvp_blk/nvp_idx throughout the code to nvx_blk/nvx_idx to prevent
confusion in the future and now we delay loading the NVP until
the point where we know that the block and index actually point to
a NVP.

Suggested-by: Michael Kowal <kowal@us.ibm.com>
Fixes: 6d4c4f70262 ("ppc/xive2: Support crowd-matching when looking for target")
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 hw/intc/xive2.c | 78 ++++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index f812ba9624..8abccd2f4b 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -226,8 +226,8 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, GString *buf)
     uint32_t qsize = xive_get_field32(END2_W3_QSIZE, end->w3);
     uint32_t qentries = 1 << (qsize + 10);
 
-    uint32_t nvp_blk = xive_get_field32(END2_W6_VP_BLOCK, end->w6);
-    uint32_t nvp_idx = xive_get_field32(END2_W6_VP_OFFSET, end->w6);
+    uint32_t nvx_blk = xive_get_field32(END2_W6_VP_BLOCK, end->w6);
+    uint32_t nvx_idx = xive_get_field32(END2_W6_VP_OFFSET, end->w6);
     uint8_t priority = xive_get_field32(END2_W7_F0_PRIORITY, end->w7);
     uint8_t pq;
 
@@ -256,7 +256,7 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, GString *buf)
                            xive2_end_is_firmware2(end)   ? 'F' : '-',
                            xive2_end_is_ignore(end) ? 'i' : '-',
                            xive2_end_is_crowd(end)  ? 'c' : '-',
-                           priority, nvp_blk, nvp_idx);
+                           priority, nvx_blk, nvx_idx);
 
     if (qaddr_base) {
         g_string_append_printf(buf, " eq:@%08"PRIx64"% 6d/%5d ^%d",
@@ -401,7 +401,7 @@ static void xive2_pgofnext(uint8_t *nvgc_blk, uint32_t *nvgc_idx,
  * level of pending group interrupts.
  */
 static uint8_t xive2_presenter_backlog_check(XivePresenter *xptr,
-                                             uint8_t nvp_blk, uint32_t nvp_idx,
+                                             uint8_t nvx_blk, uint32_t nvx_idx,
                                              uint8_t first_group,
                                              uint8_t *out_level)
 {
@@ -413,8 +413,8 @@ static uint8_t xive2_presenter_backlog_check(XivePresenter *xptr,
 
     for (prio = 0; prio <= XIVE_PRIORITY_MAX; prio++) {
         current_level = first_group & 0x3F;
-        nvgc_blk = nvp_blk;
-        nvgc_idx = nvp_idx;
+        nvgc_blk = nvx_blk;
+        nvgc_idx = nvx_idx;
 
         while (current_level) {
             xive2_pgofnext(&nvgc_blk, &nvgc_idx, current_level);
@@ -443,7 +443,7 @@ static uint8_t xive2_presenter_backlog_check(XivePresenter *xptr,
 }
 
 static void xive2_presenter_backlog_decr(XivePresenter *xptr,
-                                         uint8_t nvp_blk, uint32_t nvp_idx,
+                                         uint8_t nvx_blk, uint32_t nvx_idx,
                                          uint8_t group_prio,
                                          uint8_t group_level)
 {
@@ -452,8 +452,8 @@ static void xive2_presenter_backlog_decr(XivePresenter *xptr,
     uint8_t nvgc_blk;
     Xive2Nvgc nvgc;
 
-    nvgc_blk = nvp_blk;
-    nvgc_idx = nvp_idx;
+    nvgc_blk = nvx_blk;
+    nvgc_idx = nvx_idx;
     xive2_pgofnext(&nvgc_blk, &nvgc_idx, group_level);
 
     if (xive2_router_get_nvgc(xrtr, NVx_CROWD_LVL(group_level),
@@ -1317,9 +1317,8 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     uint8_t priority;
     uint8_t format;
     bool found, precluded;
-    Xive2Nvp nvp;
-    uint8_t nvp_blk;
-    uint32_t nvp_idx;
+    uint8_t nvx_blk;
+    uint32_t nvx_idx;
 
     /* END cache lookup */
     if (xive2_router_get_end(xrtr, end_blk, end_idx, &end)) {
@@ -1384,23 +1383,10 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     /*
      * Follows IVPE notification
      */
-    nvp_blk = xive_get_field32(END2_W6_VP_BLOCK, end.w6);
-    nvp_idx = xive_get_field32(END2_W6_VP_OFFSET, end.w6);
-
-    /* NVP cache lookup */
-    if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no NVP %x/%x\n",
-                      nvp_blk, nvp_idx);
-        return;
-    }
-
-    if (!xive2_nvp_is_valid(&nvp)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVP %x/%x is invalid\n",
-                      nvp_blk, nvp_idx);
-        return;
-    }
+    nvx_blk = xive_get_field32(END2_W6_VP_BLOCK, end.w6);
+    nvx_idx = xive_get_field32(END2_W6_VP_OFFSET, end.w6);
 
-    found = xive_presenter_notify(xrtr->xfb, format, nvp_blk, nvp_idx,
+    found = xive_presenter_notify(xrtr->xfb, format, nvx_blk, nvx_idx,
                           xive2_end_is_crowd(&end), xive2_end_is_ignore(&end),
                           priority,
                           xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7),
@@ -1428,6 +1414,21 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
 
         if (!xive2_end_is_ignore(&end)) {
             uint8_t ipb;
+            Xive2Nvp nvp;
+
+            /* NVP cache lookup */
+            if (xive2_router_get_nvp(xrtr, nvx_blk, nvx_idx, &nvp)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no NVP %x/%x\n",
+                              nvx_blk, nvx_idx);
+                return;
+            }
+
+            if (!xive2_nvp_is_valid(&nvp)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVP %x/%x is invalid\n",
+                              nvx_blk, nvx_idx);
+                return;
+            }
+
             /*
              * Record the IPB in the associated NVP structure for later
              * use. The presenter will resend the interrupt when the vCPU
@@ -1436,7 +1437,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
             ipb = xive_get_field32(NVP2_W2_IPB, nvp.w2) |
                 xive_priority_to_ipb(priority);
             nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, ipb);
-            xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
+            xive2_router_write_nvp(xrtr, nvx_blk, nvx_idx, &nvp, 2);
         } else {
             Xive2Nvgc nvgc;
             uint32_t backlog;
@@ -1449,32 +1450,31 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
              * counters are stored in the NVG/NVC structures
              */
             if (xive2_router_get_nvgc(xrtr, crowd,
-                                      nvp_blk, nvp_idx, &nvgc)) {
+                                      nvx_blk, nvx_idx, &nvgc)) {
                 qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no %s %x/%x\n",
-                              crowd ? "NVC" : "NVG", nvp_blk, nvp_idx);
+                              crowd ? "NVC" : "NVG", nvx_blk, nvx_idx);
                 return;
             }
 
             if (!xive2_nvgc_is_valid(&nvgc)) {
                 qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVG %x/%x is invalid\n",
-                              nvp_blk, nvp_idx);
+                              nvx_blk, nvx_idx);
                 return;
             }
 
             /*
              * Increment the backlog counter for that priority.
-             * For the precluded case, we only call broadcast the
-             * first time the counter is incremented. broadcast will
-             * set the LSMFB field of the TIMA of relevant threads so
-             * that they know an interrupt is pending.
+             * We only call broadcast the first time the counter is
+             * incremented. broadcast will set the LSMFB field of the TIMA of
+             * relevant threads so that they know an interrupt is pending.
              */
             backlog = xive2_nvgc_get_backlog(&nvgc, priority) + 1;
             xive2_nvgc_set_backlog(&nvgc, priority, backlog);
-            xive2_router_write_nvgc(xrtr, crowd, nvp_blk, nvp_idx, &nvgc);
+            xive2_router_write_nvgc(xrtr, crowd, nvx_blk, nvx_idx, &nvgc);
 
-            if (precluded && backlog == 1) {
+            if (backlog == 1) {
                 XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xrtr->xfb);
-                xfc->broadcast(xrtr->xfb, nvp_blk, nvp_idx,
+                xfc->broadcast(xrtr->xfb, nvx_blk, nvx_idx,
                                xive2_end_is_crowd(&end),
                                xive2_end_is_ignore(&end),
                                priority);
-- 
2.43.0


