Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D568E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 00:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKnoz-0001MD-7D; Mon, 09 Dec 2024 19:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlo-0004pk-6d; Mon, 09 Dec 2024 19:06:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnll-0001wg-Dz; Mon, 09 Dec 2024 19:06:31 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9KcVBA019481;
 Tue, 10 Dec 2024 00:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=EXKrkWgLLK6hAXs1x
 6jNXaDKzREox44/gd6o2p2voKA=; b=ivDAVywx0/WHU7Zo+Rf6waTsQBWcAIg1z
 QzXSZQWEMuGhQ5FSnVrfYKoTxqi/kDs46ksUU/HvsLHtPS6P/N0a5+4NOHE0dmop
 eaQGeWFGyftkuNsrqCbFJ5AHNfNNPAWw3fL/9uy46+xGyjyws7AX/hD+fR1vGfn5
 097/f2zQNP44Towp5/gnzFm7caJCLK740Vgk4LB8bpJRE5ZbalVSdAjbR5rD03wF
 9QZvhreuCgtoQIaQCVKIKO8Ps18Ts0Uk+HEmnYdMCXW3N2tloo17Q0gbYqdoJqBB
 FVVVFppBTfqXkKWRvrIyx0LcREQO9TGwdb0GiQazZkzOloI0naLeg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8m6x7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:20 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B9Nsb2i014444;
 Tue, 10 Dec 2024 00:06:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8m6x2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9M3Pon016910;
 Tue, 10 Dec 2024 00:06:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12y16ws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:19 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BA06FRh52167134
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 00:06:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CF2520040;
 Tue, 10 Dec 2024 00:06:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB6672004B;
 Tue, 10 Dec 2024 00:06:13 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Dec 2024 00:06:13 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 10/14] ppc/xive2: Support crowd-matching when looking for
 target
Date: Mon,  9 Dec 2024 18:05:22 -0600
Message-Id: <20241210000527.9541-20-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210000527.9541-1-kowal@linux.ibm.com>
References: <20241210000527.9541-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: icbBs5f863iR6_iBjcrUPRc7waQqBCk0
X-Proofpoint-ORIG-GUID: tFiGsQc5ABobk7wotSfcc8VmYraqfTLK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090187
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

XIVE crowd sizes are encoded into a 2-bit field as follows:
  0: 0b00
  2: 0b01
  4: 0b10
 16: 0b11

A crowd size of 8 is not supported.

If an END is defined with the 'crowd' bit set, then a target can be
running on different blocks. It means that some bits from the block
VP are masked when looking for a match. It is similar to groups, but
on the block instead of the VP index.

Most of the changes are due to passing the extra argument 'crowd' all
the way to the function checking for matches.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive.h  | 10 +++---
 include/hw/ppc/xive2.h |  3 +-
 hw/intc/pnv_xive.c     | 10 +++---
 hw/intc/pnv_xive2.c    | 12 +++----
 hw/intc/spapr_xive.c   |  8 ++---
 hw/intc/xive.c         | 40 ++++++++++++++++++----
 hw/intc/xive2.c        | 78 +++++++++++++++++++++++++++++++++---------
 hw/ppc/pnv.c           | 15 ++++----
 hw/ppc/spapr.c         |  7 ++--
 9 files changed, 131 insertions(+), 52 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index f443a39cf1..8317fde0db 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -438,13 +438,13 @@ struct XivePresenterClass {
     InterfaceClass parent;
     int (*match_nvt)(XivePresenter *xptr, uint8_t format,
                      uint8_t nvt_blk, uint32_t nvt_idx,
-                     bool cam_ignore, uint8_t priority,
+                     bool crowd, bool cam_ignore, uint8_t priority,
                      uint32_t logic_serv, XiveTCTXMatch *match);
     bool (*in_kernel)(const XivePresenter *xptr);
     uint32_t (*get_config)(XivePresenter *xptr);
     int (*broadcast)(XivePresenter *xptr,
                      uint8_t nvt_blk, uint32_t nvt_idx,
-                     uint8_t priority);
+                     bool crowd, bool cam_ignore, uint8_t priority);
 };
 
 int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
@@ -453,7 +453,7 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
                               bool cam_ignore, uint32_t logic_serv);
 bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
                            uint8_t nvt_blk, uint32_t nvt_idx,
-                           bool cam_ignore, uint8_t priority,
+                           bool crowd, bool cam_ignore, uint8_t priority,
                            uint32_t logic_serv, bool *precluded);
 
 uint32_t xive_get_vpgroup_size(uint32_t nvp_index);
@@ -473,10 +473,10 @@ struct XiveFabricClass {
     InterfaceClass parent;
     int (*match_nvt)(XiveFabric *xfb, uint8_t format,
                      uint8_t nvt_blk, uint32_t nvt_idx,
-                     bool cam_ignore, uint8_t priority,
+                     bool crowd, bool cam_ignore, uint8_t priority,
                      uint32_t logic_serv, XiveTCTXMatch *match);
     int (*broadcast)(XiveFabric *xfb, uint8_t nvt_blk, uint32_t nvt_idx,
-                     uint8_t priority);
+                     bool crowd, bool cam_ignore, uint8_t priority);
 };
 
 /*
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index c07e23e1d3..8cdf819174 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -88,7 +88,8 @@ void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked);
 int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
                                uint8_t format,
                                uint8_t nvt_blk, uint32_t nvt_idx,
-                               bool cam_ignore, uint32_t logic_serv);
+                               bool crowd, bool cam_ignore,
+                               uint32_t logic_serv);
 
 uint64_t xive2_presenter_nvp_backlog_op(XivePresenter *xptr,
                                         uint8_t blk, uint32_t idx,
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 5bacbce6a4..d4796ab5a6 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1,10 +1,9 @@
 /*
  * QEMU PowerPC XIVE interrupt controller model
  *
- * Copyright (c) 2017-2019, IBM Corporation.
+ * Copyright (c) 2017-2024, IBM Corporation.
  *
- * This code is licensed under the GPL version 2 or later. See the
- * COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
@@ -473,7 +472,7 @@ static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
 
 static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
                               uint8_t nvt_blk, uint32_t nvt_idx,
-                              bool cam_ignore, uint8_t priority,
+                              bool crowd, bool cam_ignore, uint8_t priority,
                               uint32_t logic_serv, XiveTCTXMatch *match)
 {
     PnvXive *xive = PNV_XIVE(xptr);
@@ -500,7 +499,8 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
              * Check the thread context CAM lines and record matches.
              */
             ring = xive_presenter_tctx_match(xptr, tctx, format, nvt_blk,
-                                             nvt_idx, cam_ignore, logic_serv);
+                                             nvt_idx, cam_ignore,
+                                             logic_serv);
             /*
              * Save the context and follow on to catch duplicates, that we
              * don't support yet.
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 54abfe3947..91f3514f93 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -624,7 +624,7 @@ static bool pnv_xive2_is_cpu_enabled(PnvXive2 *xive, PowerPCCPU *cpu)
 
 static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
                                uint8_t nvt_blk, uint32_t nvt_idx,
-                               bool cam_ignore, uint8_t priority,
+                               bool crowd, bool cam_ignore, uint8_t priority,
                                uint32_t logic_serv, XiveTCTXMatch *match)
 {
     PnvXive2 *xive = PNV_XIVE2(xptr);
@@ -655,8 +655,8 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
                                                  logic_serv);
             } else {
                 ring = xive2_presenter_tctx_match(xptr, tctx, format, nvt_blk,
-                                                   nvt_idx, cam_ignore,
-                                                   logic_serv);
+                                                  nvt_idx, crowd, cam_ignore,
+                                                  logic_serv);
             }
 
             if (ring != -1) {
@@ -707,7 +707,7 @@ static uint32_t pnv_xive2_presenter_get_config(XivePresenter *xptr)
 
 static int pnv_xive2_broadcast(XivePresenter *xptr,
                                uint8_t nvt_blk, uint32_t nvt_idx,
-                               uint8_t priority)
+                               bool crowd, bool ignore, uint8_t priority)
 {
     PnvXive2 *xive = PNV_XIVE2(xptr);
     PnvChip *chip = xive->chip;
@@ -732,10 +732,10 @@ static int pnv_xive2_broadcast(XivePresenter *xptr,
 
             if (gen1_tima_os) {
                 ring = xive_presenter_tctx_match(xptr, tctx, 0, nvt_blk,
-                                                 nvt_idx, true, 0);
+                                                 nvt_idx, ignore, 0);
             } else {
                 ring = xive2_presenter_tctx_match(xptr, tctx, 0, nvt_blk,
-                                                  nvt_idx, true, 0);
+                                                  nvt_idx, crowd, ignore, 0);
             }
 
             if (ring != -1) {
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 283a6b8fd2..0477fdd594 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -1,10 +1,9 @@
 /*
  * QEMU PowerPC sPAPR XIVE interrupt controller model
  *
- * Copyright (c) 2017-2018, IBM Corporation.
+ * Copyright (c) 2017-2024, IBM Corporation.
  *
- * This code is licensed under the GPL version 2 or later. See the
- * COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
@@ -431,7 +430,8 @@ static int spapr_xive_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk,
 
 static int spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
                                 uint8_t nvt_blk, uint32_t nvt_idx,
-                                bool cam_ignore, uint8_t priority,
+                                bool crowd, bool cam_ignore,
+                                uint8_t priority,
                                 uint32_t logic_serv, XiveTCTXMatch *match)
 {
     CPUState *cs;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 308de5aefc..97d1c42bb2 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1667,10 +1667,37 @@ uint32_t xive_get_vpgroup_size(uint32_t nvp_index)
     return 1 << (ctz32(~nvp_index) + 1);
 }
 
-static uint8_t xive_get_group_level(uint32_t nvp_index)
+static uint8_t xive_get_group_level(bool crowd, bool ignore,
+                                    uint32_t nvp_blk, uint32_t nvp_index)
 {
-    /* FIXME add crowd encoding */
-    return ctz32(~nvp_index) + 1;
+    uint8_t level = 0;
+
+    if (crowd) {
+        /* crowd level is bit position of first 0 from the right in nvp_blk */
+        level = ctz32(~nvp_blk) + 1;
+
+        /*
+         * Supported crowd sizes are 2^1, 2^2, and 2^4. 2^3 is not supported.
+         * HW will encode level 4 as the value 3.  See xive2_pgofnext().
+         */
+        switch (level) {
+        case 1:
+        case 2:
+            break;
+        case 4:
+            level = 3;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        /* Crowd level bits reside in upper 2 bits of the 6 bit group level */
+        level <<= 4;
+    }
+    if (ignore) {
+        level |= (ctz32(~nvp_index) + 1) & 0b1111;
+    }
+    return level;
 }
 
 /*
@@ -1742,7 +1769,7 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
  */
 bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
                            uint8_t nvt_blk, uint32_t nvt_idx,
-                           bool cam_ignore, uint8_t priority,
+                           bool crowd, bool cam_ignore, uint8_t priority,
                            uint32_t logic_serv, bool *precluded)
 {
     XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xfb);
@@ -1773,7 +1800,7 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
      * a new command to the presenters (the equivalent of the "assign"
      * power bus command in the documented full notify sequence.
      */
-    count = xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, cam_ignore,
+    count = xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, crowd, cam_ignore,
                            priority, logic_serv, &match);
     if (count < 0) {
         return false;
@@ -1781,7 +1808,7 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
 
     /* handle CPU exception delivery */
     if (count) {
-        group_level = cam_ignore ? xive_get_group_level(nvt_idx) : 0;
+        group_level = xive_get_group_level(crowd, cam_ignore, nvt_blk, nvt_idx);
         trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, group_level);
         xive_tctx_pipr_update(match.tctx, match.ring, priority, group_level);
     } else {
@@ -1906,6 +1933,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
     }
 
     found = xive_presenter_notify(xrtr->xfb, format, nvt_blk, nvt_idx,
+                          false /* crowd */,
                           xive_get_field32(END_W7_F0_IGNORE, end.w7),
                           priority,
                           xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7),
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index f4621bdd02..20d63e8f6e 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1120,13 +1120,42 @@ static bool xive2_vp_match_mask(uint32_t cam1, uint32_t cam2,
     return (cam1 & vp_mask) == (cam2 & vp_mask);
 }
 
+static uint8_t xive2_get_vp_block_mask(uint32_t nvt_blk, bool crowd)
+{
+    uint8_t size, block_mask = 0b1111;
+
+    /* 3 supported crowd sizes: 2, 4, 16 */
+    if (crowd) {
+        size = xive_get_vpgroup_size(nvt_blk);
+        if (size == 8) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid crowd size of 8n");
+            return block_mask;
+        }
+        block_mask = ~(size - 1);
+        block_mask &= 0b1111;
+    }
+    return block_mask;
+}
+
+static uint32_t xive2_get_vp_index_mask(uint32_t nvt_index, bool cam_ignore)
+{
+    uint32_t index_mask = 0xFFFFFF; /* 24 bits */
+
+    if (cam_ignore) {
+        index_mask = ~(xive_get_vpgroup_size(nvt_index) - 1);
+        index_mask &= 0xFFFFFF;
+    }
+    return index_mask;
+}
+
 /*
  * The thread context register words are in big-endian format.
  */
 int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
                                uint8_t format,
                                uint8_t nvt_blk, uint32_t nvt_idx,
-                               bool cam_ignore, uint32_t logic_serv)
+                               bool crowd, bool cam_ignore,
+                               uint32_t logic_serv)
 {
     uint32_t cam =   xive2_nvp_cam_line(nvt_blk, nvt_idx);
     uint32_t qw3w2 = xive_tctx_word2(&tctx->regs[TM_QW3_HV_PHYS]);
@@ -1134,7 +1163,8 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
     uint32_t qw1w2 = xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
     uint32_t qw0w2 = xive_tctx_word2(&tctx->regs[TM_QW0_USER]);
 
-    uint32_t vp_mask = 0xFFFFFFFF;
+    uint32_t index_mask, vp_mask;
+    uint8_t block_mask;
 
     if (format == 0) {
         /*
@@ -1142,9 +1172,9 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
          * i=1: VP-group notification (bits ignored at the end of the
          *      NVT identifier)
          */
-        if (cam_ignore) {
-            vp_mask = ~(xive_get_vpgroup_size(nvt_idx) - 1);
-        }
+        block_mask = xive2_get_vp_block_mask(nvt_blk, crowd);
+        index_mask = xive2_get_vp_index_mask(nvt_idx, cam_ignore);
+        vp_mask = xive2_nvp_cam_line(block_mask, index_mask);
 
         /* For VP-group notifications, threads with LGS=0 are excluded */
 
@@ -1277,6 +1307,12 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
         return;
     }
 
+    if (xive2_end_is_crowd(&end) & !xive2_end_is_ignore(&end)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "XIVE: invalid END, 'crowd' bit requires 'ignore' bit\n");
+        return;
+    }
+
     if (xive2_end_is_enqueue(&end)) {
         xive2_end_enqueue(&end, end_data);
         /* Enqueuing event data modifies the EQ toggle and index */
@@ -1338,7 +1374,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     }
 
     found = xive_presenter_notify(xrtr->xfb, format, nvp_blk, nvp_idx,
-                          xive2_end_is_ignore(&end),
+                          xive2_end_is_crowd(&end), xive2_end_is_ignore(&end),
                           priority,
                           xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7),
                           &precluded);
@@ -1375,17 +1411,24 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
             nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, ipb);
             xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
         } else {
-            Xive2Nvgc nvg;
+            Xive2Nvgc nvgc;
             uint32_t backlog;
+            bool crowd;
 
-            /* For groups, the per-priority backlog counters are in the NVG */
-            if (xive2_router_get_nvgc(xrtr, false, nvp_blk, nvp_idx, &nvg)) {
-                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no NVG %x/%x\n",
-                              nvp_blk, nvp_idx);
+            crowd = xive2_end_is_crowd(&end);
+
+            /*
+             * For groups and crowds, the per-priority backlog
+             * counters are stored in the NVG/NVC structures
+             */
+            if (xive2_router_get_nvgc(xrtr, crowd,
+                                      nvp_blk, nvp_idx, &nvgc)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no %s %x/%x\n",
+                              crowd ? "NVC" : "NVG", nvp_blk, nvp_idx);
                 return;
             }
 
-            if (!xive2_nvgc_is_valid(&nvg)) {
+            if (!xive2_nvgc_is_valid(&nvgc)) {
                 qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVG %x/%x is invalid\n",
                               nvp_blk, nvp_idx);
                 return;
@@ -1398,13 +1441,16 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
              * set the LSMFB field of the TIMA of relevant threads so
              * that they know an interrupt is pending.
              */
-            backlog = xive2_nvgc_get_backlog(&nvg, priority) + 1;
-            xive2_nvgc_set_backlog(&nvg, priority, backlog);
-            xive2_router_write_nvgc(xrtr, false, nvp_blk, nvp_idx, &nvg);
+            backlog = xive2_nvgc_get_backlog(&nvgc, priority) + 1;
+            xive2_nvgc_set_backlog(&nvgc, priority, backlog);
+            xive2_router_write_nvgc(xrtr, crowd, nvp_blk, nvp_idx, &nvgc);
 
             if (precluded && backlog == 1) {
                 XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xrtr->xfb);
-                xfc->broadcast(xrtr->xfb, nvp_blk, nvp_idx, priority);
+                xfc->broadcast(xrtr->xfb, nvp_blk, nvp_idx,
+                               xive2_end_is_crowd(&end),
+                               xive2_end_is_ignore(&end),
+                               priority);
 
                 if (!xive2_end_is_precluded_escalation(&end)) {
                     /*
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7c11143749..6681648ed6 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2585,7 +2585,7 @@ static void pnv_pic_print_info(InterruptStatsProvider *obj, GString *buf)
 
 static int pnv_match_nvt(XiveFabric *xfb, uint8_t format,
                          uint8_t nvt_blk, uint32_t nvt_idx,
-                         bool cam_ignore, uint8_t priority,
+                         bool crowd, bool cam_ignore, uint8_t priority,
                          uint32_t logic_serv,
                          XiveTCTXMatch *match)
 {
@@ -2599,8 +2599,8 @@ static int pnv_match_nvt(XiveFabric *xfb, uint8_t format,
         XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
         int count;
 
-        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
-                               priority, logic_serv, match);
+        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
+                               cam_ignore, priority, logic_serv, match);
 
         if (count < 0) {
             return count;
@@ -2614,7 +2614,7 @@ static int pnv_match_nvt(XiveFabric *xfb, uint8_t format,
 
 static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
                                 uint8_t nvt_blk, uint32_t nvt_idx,
-                                bool cam_ignore, uint8_t priority,
+                                bool crowd, bool cam_ignore, uint8_t priority,
                                 uint32_t logic_serv,
                                 XiveTCTXMatch *match)
 {
@@ -2628,8 +2628,8 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
         XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
         int count;
 
-        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
-                               priority, logic_serv, match);
+        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
+                               cam_ignore, priority, logic_serv, match);
 
         if (count < 0) {
             return count;
@@ -2643,6 +2643,7 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
 
 static int pnv10_xive_broadcast(XiveFabric *xfb,
                                 uint8_t nvt_blk, uint32_t nvt_idx,
+                                bool crowd, bool cam_ignore,
                                 uint8_t priority)
 {
     PnvMachineState *pnv = PNV_MACHINE(xfb);
@@ -2653,7 +2654,7 @@ static int pnv10_xive_broadcast(XiveFabric *xfb,
         XivePresenter *xptr = XIVE_PRESENTER(&chip10->xive);
         XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
 
-        xpc->broadcast(xptr, nvt_blk, nvt_idx, priority);
+        xpc->broadcast(xptr, nvt_blk, nvt_idx, crowd, cam_ignore, priority);
     }
     return 0;
 }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0d4efaa0c0..7a922ef309 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4,6 +4,9 @@
  * Copyright (c) 2004-2007 Fabrice Bellard
  * Copyright (c) 2007 Jocelyn Mayer
  * Copyright (c) 2010 David Gibson, IBM Corporation.
+ * Copyright (c) 2010-2024, IBM Corporation..
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -4437,7 +4440,7 @@ static void spapr_pic_print_info(InterruptStatsProvider *obj, GString *buf)
  */
 static int spapr_match_nvt(XiveFabric *xfb, uint8_t format,
                            uint8_t nvt_blk, uint32_t nvt_idx,
-                           bool cam_ignore, uint8_t priority,
+                           bool crowd, bool cam_ignore, uint8_t priority,
                            uint32_t logic_serv, XiveTCTXMatch *match)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(xfb);
@@ -4445,7 +4448,7 @@ static int spapr_match_nvt(XiveFabric *xfb, uint8_t format,
     XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
     int count;
 
-    count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
+    count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd, cam_ignore,
                            priority, logic_serv, match);
     if (count < 0) {
         return count;
-- 
2.43.0


