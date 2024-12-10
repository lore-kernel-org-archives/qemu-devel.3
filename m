Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81ADE7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 00:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKnnu-0007p1-S3; Mon, 09 Dec 2024 19:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlk-0004op-2M; Mon, 09 Dec 2024 19:06:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlh-0001vj-Vs; Mon, 09 Dec 2024 19:06:27 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9KRAN0014132;
 Tue, 10 Dec 2024 00:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=d0+aZG2Wxq7dL5cBO
 xKWamosOzieR+NeWSt262f1gDY=; b=qAIfri86Jt9Z07V+cqtvS7Gzo5bAiOqSk
 /jmm2iVkNBftiwzF6om5MXCoDD38KdeXD8pGcQ5mDELevPn6oEKmIL57ZHz6nZJm
 RNAb6kFS5ZxsuRPqo4I01HA2TSH0DGdOAvSlpPQ1hME80AwmUXd23D6ogwtEf4Vz
 t+dXR1iU8hyCTVy1sKPffHv+ggyuOxnDR3w9/YUu4gEzCQnxOoU8lEyT6MLU176l
 9zf63amNkWDAI4Sgg4K6+hcqRBMVdwSZlNWuEf6a/JBEI4aQrZ/dCH2Z+IS/b9jn
 9Ct7FHuzsmK3nbMO6OJd4+soeGFqBEGqCFEOmdF4ztDSwcnt4fx9A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq3gju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:19 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BA03sUa026748;
 Tue, 10 Dec 2024 00:06:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq3gjr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9N03Vs018618;
 Tue, 10 Dec 2024 00:06:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26k8yca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BA06Dwd50790842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 00:06:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68EB02004D;
 Tue, 10 Dec 2024 00:06:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97A9D20040;
 Tue, 10 Dec 2024 00:06:11 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Dec 2024 00:06:11 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 10/14] ppc/xive2: Check crowd backlog when scanning group
 backlog
Date: Mon,  9 Dec 2024 18:05:21 -0600
Message-Id: <20241210000527.9541-19-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210000527.9541-1-kowal@linux.ibm.com>
References: <20241210000527.9541-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: i5IEuivYtgS3ztCLnIwbEjgGkSdOg0Gt
X-Proofpoint-GUID: 6vM_mRwcmx62cZdgv8pSnI7Dcj63qJI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=731 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090187
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

When processing a backlog scan for group interrupts, also take
into account crowd interrupts.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive2_regs.h |  4 ++
 hw/intc/xive2.c             | 82 +++++++++++++++++++++++++------------
 2 files changed, 60 insertions(+), 26 deletions(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 66a419441c..89236b9aaf 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -237,4 +237,8 @@ void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uint32_t nvgc_idx,
 #define NVx_BACKLOG_OP            PPC_BITMASK(52, 53)
 #define NVx_BACKLOG_PRIO          PPC_BITMASK(57, 59)
 
+/* split the 6-bit crowd/group level */
+#define NVx_CROWD_LVL(level)      ((level >> 4) & 0b11)
+#define NVx_GROUP_LVL(level)      (level & 0b1111)
+
 #endif /* PPC_XIVE2_REGS_H */
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 1f2837104c..41d689eaab 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -367,6 +367,35 @@ static void xive2_end_enqueue(Xive2End *end, uint32_t data)
     end->w1 = xive_set_field32(END2_W1_PAGE_OFF, end->w1, qindex);
 }
 
+static void xive2_pgofnext(uint8_t *nvgc_blk, uint32_t *nvgc_idx,
+                           uint8_t next_level)
+{
+    uint32_t mask, next_idx;
+    uint8_t next_blk;
+
+    /*
+     * Adjust the block and index of a VP for the next group/crowd
+     * size (PGofFirst/PGofNext field in the NVP and NVGC structures).
+     *
+     * The 6-bit group level is split into a 2-bit crowd and 4-bit
+     * group levels. Encoding is similar. However, we don't support
+     * crowd size of 8. So a crowd level of 0b11 is bumped to a crowd
+     * size of 16.
+     */
+    next_blk = NVx_CROWD_LVL(next_level);
+    if (next_blk == 3) {
+        next_blk = 4;
+    }
+    mask = (1 << next_blk) - 1;
+    *nvgc_blk &= ~mask;
+    *nvgc_blk |= mask >> 1;
+
+    next_idx = NVx_GROUP_LVL(next_level);
+    mask = (1 << next_idx) - 1;
+    *nvgc_idx &= ~mask;
+    *nvgc_idx |= mask >> 1;
+}
+
 /*
  * Scan the group chain and return the highest priority and group
  * level of pending group interrupts.
@@ -377,29 +406,28 @@ static uint8_t xive2_presenter_backlog_check(XivePresenter *xptr,
                                              uint8_t *out_level)
 {
     Xive2Router *xrtr = XIVE2_ROUTER(xptr);
-    uint32_t nvgc_idx, mask;
+    uint32_t nvgc_idx;
     uint32_t current_level, count;
-    uint8_t prio;
+    uint8_t nvgc_blk, prio;
     Xive2Nvgc nvgc;
 
     for (prio = 0; prio <= XIVE_PRIORITY_MAX; prio++) {
-        current_level = first_group & 0xF;
+        current_level = first_group & 0x3F;
+        nvgc_blk = nvp_blk;
+        nvgc_idx = nvp_idx;
 
         while (current_level) {
-            mask = (1 << current_level) - 1;
-            nvgc_idx = nvp_idx & ~mask;
-            nvgc_idx |= mask >> 1;
-            qemu_log("fxb %s checking backlog for prio %d group idx %x\n",
-                     __func__, prio, nvgc_idx);
-
-            if (xive2_router_get_nvgc(xrtr, false, nvp_blk, nvgc_idx, &nvgc)) {
-                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVG %x/%x\n",
-                              nvp_blk, nvgc_idx);
+            xive2_pgofnext(&nvgc_blk, &nvgc_idx, current_level);
+
+            if (xive2_router_get_nvgc(xrtr, NVx_CROWD_LVL(current_level),
+                                      nvgc_blk, nvgc_idx, &nvgc)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVGC %x/%x\n",
+                              nvgc_blk, nvgc_idx);
                 return 0xFF;
             }
             if (!xive2_nvgc_is_valid(&nvgc)) {
-                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVG %x/%x\n",
-                              nvp_blk, nvgc_idx);
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVGC %x/%x\n",
+                              nvgc_blk, nvgc_idx);
                 return 0xFF;
             }
 
@@ -408,7 +436,7 @@ static uint8_t xive2_presenter_backlog_check(XivePresenter *xptr,
                 *out_level = current_level;
                 return prio;
             }
-            current_level = xive_get_field32(NVGC2_W0_PGONEXT, nvgc.w0) & 0xF;
+            current_level = xive_get_field32(NVGC2_W0_PGONEXT, nvgc.w0) & 0x3F;
         }
     }
     return 0xFF;
@@ -420,22 +448,23 @@ static void xive2_presenter_backlog_decr(XivePresenter *xptr,
                                          uint8_t group_level)
 {
     Xive2Router *xrtr = XIVE2_ROUTER(xptr);
-    uint32_t nvgc_idx, mask, count;
+    uint32_t nvgc_idx, count;
+    uint8_t nvgc_blk;
     Xive2Nvgc nvgc;
 
-    group_level &= 0xF;
-    mask = (1 << group_level) - 1;
-    nvgc_idx = nvp_idx & ~mask;
-    nvgc_idx |= mask >> 1;
+    nvgc_blk = nvp_blk;
+    nvgc_idx = nvp_idx;
+    xive2_pgofnext(&nvgc_blk, &nvgc_idx, group_level);
 
-    if (xive2_router_get_nvgc(xrtr, false, nvp_blk, nvgc_idx, &nvgc)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVG %x/%x\n",
-                      nvp_blk, nvgc_idx);
+    if (xive2_router_get_nvgc(xrtr, NVx_CROWD_LVL(group_level),
+                              nvgc_blk, nvgc_idx, &nvgc)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVGC %x/%x\n",
+                      nvgc_blk, nvgc_idx);
         return;
     }
     if (!xive2_nvgc_is_valid(&nvgc)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVG %x/%x\n",
-                      nvp_blk, nvgc_idx);
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVGC %x/%x\n",
+                      nvgc_blk, nvgc_idx);
         return;
     }
     count = xive2_nvgc_get_backlog(&nvgc, group_prio);
@@ -443,7 +472,8 @@ static void xive2_presenter_backlog_decr(XivePresenter *xptr,
         return;
     }
     xive2_nvgc_set_backlog(&nvgc, group_prio, count - 1);
-    xive2_router_write_nvgc(xrtr, false, nvp_blk, nvgc_idx, &nvgc);
+    xive2_router_write_nvgc(xrtr, NVx_CROWD_LVL(group_level),
+                            nvgc_blk, nvgc_idx, &nvgc);
 }
 
 /*
-- 
2.43.0


