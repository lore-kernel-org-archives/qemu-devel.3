Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21996D1D876
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 21:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0os0-0004Yp-2h; Tue, 15 Oct 2024 17:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0orw-0004Mg-8I; Tue, 15 Oct 2024 17:14:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0ort-0000QF-Oi; Tue, 15 Oct 2024 17:14:16 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FJY4WM029966;
 Tue, 15 Oct 2024 21:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=+1f/2+JEnoQc+rvzc
 779brho+/Ext9vaX7kqkx/mgIY=; b=ArlpkwVH1NtoKYR5W3FWAAj12qI0HyO+/
 flV8IN7naHbAoelbkpFafcaN66JKH3bpQs2J1yZhzZzz6aRkwUs6dBnBJ4RYwriW
 JknsC9oZZzpNJD0KC4XstXsfAWapvJt70OJU2LwgdWZi7VJr06HEKeYq2ttf2S+b
 kOUiDN2Kse37z93l9HJDTY6e0DS7ANLpSevbMU+XeQ/R3qLNvlo5+mokqK6I+66Z
 +k4csYdtmHAhANVJVfeX3DeyNjx4qV+qC3D8xa1XAGAtzNWgh4wlgljgWQbRP0Py
 smGFS4e0YheUw+ccMpaeaiQMCbVec2Wmx3VgYT8xPCTBHBglYedlA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429x17gh0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:03 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FLE3or009607;
 Tue, 15 Oct 2024 21:14:03 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429x17gh08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FISLoo005218;
 Tue, 15 Oct 2024 21:14:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285nj5p7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49FLDxK235586662
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Oct 2024 21:13:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A5B02004B;
 Tue, 15 Oct 2024 21:13:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4AD520043;
 Tue, 15 Oct 2024 21:13:56 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Oct 2024 21:13:56 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH 09/14] ppc/xive2: Support crowd-matching when looking for
 target
Date: Tue, 15 Oct 2024 16:13:24 -0500
Message-Id: <20241015211329.21113-10-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015211329.21113-1-kowal@linux.ibm.com>
References: <20241015211329.21113-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8XHdpQbJSEja0I6f7Bsw4UjttCwHuxOX
X-Proofpoint-GUID: ABKB6igIrOWrqU2WYtNlxo5u5yHkRni-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410150140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

If an END is defined with the 'crowd' bit set, then a target can be
running on different blocks. It means that some bits from the block
VP are masked when looking for a match. It is similar to groups, but
on the block instead of the VP index.

Most of the changes are due to passing the extra argument 'crowd' all
the way to the function checking for matches.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive.h  | 10 +++---
 include/hw/ppc/xive2.h |  3 +-
 hw/intc/pnv_xive.c     |  5 +--
 hw/intc/pnv_xive2.c    | 12 +++----
 hw/intc/spapr_xive.c   |  3 +-
 hw/intc/xive.c         | 21 ++++++++----
 hw/intc/xive2.c        | 78 +++++++++++++++++++++++++++++++++---------
 hw/ppc/pnv.c           | 15 ++++----
 hw/ppc/spapr.c         |  4 +--
 9 files changed, 105 insertions(+), 46 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 7660578b20..c9070792ec 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -440,13 +440,13 @@ struct XivePresenterClass {
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
@@ -455,7 +455,7 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
                               bool cam_ignore, uint32_t logic_serv);
 bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
                            uint8_t nvt_blk, uint32_t nvt_idx,
-                           bool cam_ignore, uint8_t priority,
+                           bool crowd, bool cam_ignore, uint8_t priority,
                            uint32_t logic_serv, bool *precluded);
 
 uint32_t xive_get_vpgroup_size(uint32_t nvp_index);
@@ -475,10 +475,10 @@ struct XiveFabricClass {
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
index 049028d2c2..37aca4d26a 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -90,7 +90,8 @@ void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked);
 int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
                                uint8_t format,
                                uint8_t nvt_blk, uint32_t nvt_idx,
-                               bool cam_ignore, uint32_t logic_serv);
+                               bool crowd, bool cam_ignore,
+                               uint32_t logic_serv);
 
 uint64_t xive2_presenter_nvp_backlog_op(XivePresenter *xptr,
                                         uint8_t blk, uint32_t idx,
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 5bacbce6a4..346549f32e 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -473,7 +473,7 @@ static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
 
 static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
                               uint8_t nvt_blk, uint32_t nvt_idx,
-                              bool cam_ignore, uint8_t priority,
+                              bool crowd, bool cam_ignore, uint8_t priority,
                               uint32_t logic_serv, XiveTCTXMatch *match)
 {
     PnvXive *xive = PNV_XIVE(xptr);
@@ -500,7 +500,8 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
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
index 9736b623ba..236f9d7eb7 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -625,7 +625,7 @@ static bool pnv_xive2_is_cpu_enabled(PnvXive2 *xive, PowerPCCPU *cpu)
 
 static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
                                uint8_t nvt_blk, uint32_t nvt_idx,
-                               bool cam_ignore, uint8_t priority,
+                               bool crowd, bool cam_ignore, uint8_t priority,
                                uint32_t logic_serv, XiveTCTXMatch *match)
 {
     PnvXive2 *xive = PNV_XIVE2(xptr);
@@ -656,8 +656,8 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
                                                  logic_serv);
             } else {
                 ring = xive2_presenter_tctx_match(xptr, tctx, format, nvt_blk,
-                                                   nvt_idx, cam_ignore,
-                                                   logic_serv);
+                                                  nvt_idx, crowd, cam_ignore,
+                                                  logic_serv);
             }
 
             if (ring != -1) {
@@ -708,7 +708,7 @@ static uint32_t pnv_xive2_presenter_get_config(XivePresenter *xptr)
 
 static int pnv_xive2_broadcast(XivePresenter *xptr,
                                uint8_t nvt_blk, uint32_t nvt_idx,
-                               uint8_t priority)
+                               bool crowd, bool ignore, uint8_t priority)
 {
     PnvXive2 *xive = PNV_XIVE2(xptr);
     PnvChip *chip = xive->chip;
@@ -733,10 +733,10 @@ static int pnv_xive2_broadcast(XivePresenter *xptr,
 
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
index 283a6b8fd2..41cfcab3b9 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -431,7 +431,8 @@ static int spapr_xive_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk,
 
 static int spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
                                 uint8_t nvt_blk, uint32_t nvt_idx,
-                                bool cam_ignore, uint8_t priority,
+                                bool crowd, bool cam_ignore,
+                                uint8_t priority,
                                 uint32_t logic_serv, XiveTCTXMatch *match)
 {
     CPUState *cs;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 2aa6e1fecc..d5fbd9bbd8 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1681,10 +1681,18 @@ uint32_t xive_get_vpgroup_size(uint32_t nvp_index)
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
+        level = ((ctz32(~nvp_blk) + 1) & 0b11) << 4;
+    }
+    if (ignore) {
+        level |= (ctz32(~nvp_index) + 1) & 0b1111;
+    }
+    return level;
 }
 
 /*
@@ -1756,7 +1764,7 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
  */
 bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
                            uint8_t nvt_blk, uint32_t nvt_idx,
-                           bool cam_ignore, uint8_t priority,
+                           bool crowd, bool cam_ignore, uint8_t priority,
                            uint32_t logic_serv, bool *precluded)
 {
     XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xfb);
@@ -1787,7 +1795,7 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
      * a new command to the presenters (the equivalent of the "assign"
      * power bus command in the documented full notify sequence.
      */
-    count = xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, cam_ignore,
+    count = xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, crowd, cam_ignore,
                            priority, logic_serv, &match);
     if (count < 0) {
         return false;
@@ -1795,7 +1803,7 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
 
     /* handle CPU exception delivery */
     if (count) {
-        group_level = cam_ignore ? xive_get_group_level(nvt_idx) : 0;
+        group_level = xive_get_group_level(crowd, cam_ignore, nvt_blk, nvt_idx);
         trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, group_level);
         xive_tctx_pipr_update(match.tctx, match.ring, priority, group_level);
     } else {
@@ -1920,6 +1928,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
     }
 
     found = xive_presenter_notify(xrtr->xfb, format, nvt_blk, nvt_idx,
+                          false /* crowd */,
                           xive_get_field32(END_W7_F0_IGNORE, end.w7),
                           priority,
                           xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7),
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index b6f279e6a3..1f2837104c 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1117,13 +1117,42 @@ static bool xive2_vp_match_mask(uint32_t cam1, uint32_t cam2,
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
@@ -1131,7 +1160,8 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
     uint32_t qw1w2 = xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
     uint32_t qw0w2 = xive_tctx_word2(&tctx->regs[TM_QW0_USER]);
 
-    uint32_t vp_mask = 0xFFFFFFFF;
+    uint32_t index_mask, vp_mask;
+    uint8_t block_mask;
 
     if (format == 0) {
         /*
@@ -1139,9 +1169,9 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
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
 
@@ -1274,6 +1304,12 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
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
@@ -1335,7 +1371,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     }
 
     found = xive_presenter_notify(xrtr->xfb, format, nvp_blk, nvp_idx,
-                          xive2_end_is_ignore(&end),
+                          xive2_end_is_crowd(&end), xive2_end_is_ignore(&end),
                           priority,
                           xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7),
                           &precluded);
@@ -1372,17 +1408,24 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
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
@@ -1395,13 +1438,16 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
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
index 9b42f47326..3a86a6edda 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2554,7 +2554,7 @@ static void pnv_pic_print_info(InterruptStatsProvider *obj, GString *buf)
 
 static int pnv_match_nvt(XiveFabric *xfb, uint8_t format,
                          uint8_t nvt_blk, uint32_t nvt_idx,
-                         bool cam_ignore, uint8_t priority,
+                         bool crowd, bool cam_ignore, uint8_t priority,
                          uint32_t logic_serv,
                          XiveTCTXMatch *match)
 {
@@ -2568,8 +2568,8 @@ static int pnv_match_nvt(XiveFabric *xfb, uint8_t format,
         XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
         int count;
 
-        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
-                               priority, logic_serv, match);
+        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
+                               cam_ignore, priority, logic_serv, match);
 
         if (count < 0) {
             return count;
@@ -2583,7 +2583,7 @@ static int pnv_match_nvt(XiveFabric *xfb, uint8_t format,
 
 static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
                                 uint8_t nvt_blk, uint32_t nvt_idx,
-                                bool cam_ignore, uint8_t priority,
+                                bool crowd, bool cam_ignore, uint8_t priority,
                                 uint32_t logic_serv,
                                 XiveTCTXMatch *match)
 {
@@ -2597,8 +2597,8 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
         XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
         int count;
 
-        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
-                               priority, logic_serv, match);
+        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
+                               cam_ignore, priority, logic_serv, match);
 
         if (count < 0) {
             return count;
@@ -2612,6 +2612,7 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
 
 static int pnv10_xive_broadcast(XiveFabric *xfb,
                                 uint8_t nvt_blk, uint32_t nvt_idx,
+                                bool crowd, bool cam_ignore,
                                 uint8_t priority)
 {
     PnvMachineState *pnv = PNV_MACHINE(xfb);
@@ -2622,7 +2623,7 @@ static int pnv10_xive_broadcast(XiveFabric *xfb,
         XivePresenter *xptr = XIVE_PRESENTER(&chip10->xive);
         XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
 
-        xpc->broadcast(xptr, nvt_blk, nvt_idx, priority);
+        xpc->broadcast(xptr, nvt_blk, nvt_idx, crowd, cam_ignore, priority);
     }
     return 0;
 }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8aa3ce7449..35a7bf8cce 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4539,7 +4539,7 @@ static void spapr_pic_print_info(InterruptStatsProvider *obj, GString *buf)
  */
 static int spapr_match_nvt(XiveFabric *xfb, uint8_t format,
                            uint8_t nvt_blk, uint32_t nvt_idx,
-                           bool cam_ignore, uint8_t priority,
+                           bool crowd, bool cam_ignore, uint8_t priority,
                            uint32_t logic_serv, XiveTCTXMatch *match)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(xfb);
@@ -4547,7 +4547,7 @@ static int spapr_match_nvt(XiveFabric *xfb, uint8_t format,
     XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
     int count;
 
-    count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
+    count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd, cam_ignore,
                            priority, logic_serv, match);
     if (count < 0) {
         return count;
-- 
2.43.0


