Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEA6E7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 00:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKnmm-0005eq-Ki; Mon, 09 Dec 2024 19:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlR-0004lb-Cd; Mon, 09 Dec 2024 19:06:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlP-0001rf-Is; Mon, 09 Dec 2024 19:06:09 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA01xPp030669;
 Tue, 10 Dec 2024 00:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TFzKnbC2JSfiB0g4n
 K3R8z9haD//HGbPomOqiUV9RnQ=; b=lZ8/DQNJOqia6YqzGli7cMQZL8/ukI68j
 1FWo4hknJj7nsKiFfchmyaddGsDPmpi46lO0TPF5Iqlm2SGX5fRWKYC0RhRcTBde
 ZZGTF2JdD5IRe+zwZTBpd19H9Vydux9bHefozCrHqV58e0n77t9XgGXRH7Bv/3qw
 WzuRrYwhNR9JhtoX9b4GxpNqsAw0Ddh+zCZmxe1W+Xp7IjOiHhaaQMw1fZ5jbjBE
 0ejuWeFxV0kAnio7w57hAdM+8AM2GMkP3hDD6OCj5TZXwnZs3h4EhH76Z9aED+Wa
 F5KgeIyevZ6JuiHE25vOTy4mm6+Z9GfmmbeHDdbkYNkGYFvRWKCVQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjb9ys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:59 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B9NvuKq027636;
 Tue, 10 Dec 2024 00:05:59 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjb9ym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9NOmu2018608;
 Tue, 10 Dec 2024 00:05:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26k8y94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BA05sSB41615740
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 00:05:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ABC1B20040;
 Tue, 10 Dec 2024 00:05:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA0D220043;
 Tue, 10 Dec 2024 00:05:52 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Dec 2024 00:05:52 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 05/14] ppc/xive2: Process group backlog when pushing an OS
 context
Date: Mon,  9 Dec 2024 18:05:12 -0600
Message-Id: <20241210000527.9541-10-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210000527.9541-1-kowal@linux.ibm.com>
References: <20241210000527.9541-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JrtTNAsutVyv-oft0XhyPCLULCxicFAc
X-Proofpoint-ORIG-GUID: ODkH3hUoEmDEMjq82y9mU2APtVm78B8e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=765
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412090187
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

When pushing an OS context, we were already checking if there was a
pending interrupt in the IPB and sending a notification if needed.  We
also need to check if there is a pending group interrupt stored in the
NVG table. To avoid useless backlog scans, we only scan if the NVP
belongs to a group.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 hw/intc/xive2.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 3 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index a6dc6d553f..7130892482 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -279,6 +279,85 @@ static void xive2_end_enqueue(Xive2End *end, uint32_t data)
     end->w1 = xive_set_field32(END2_W1_PAGE_OFF, end->w1, qindex);
 }

+/*
+ * Scan the group chain and return the highest priority and group
+ * level of pending group interrupts.
+ */
+static uint8_t xive2_presenter_backlog_check(XivePresenter *xptr,
+                                             uint8_t nvp_blk, uint32_t nvp_idx,
+                                             uint8_t first_group,
+                                             uint8_t *out_level)
+{
+    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
+    uint32_t nvgc_idx, mask;
+    uint32_t current_level, count;
+    uint8_t prio;
+    Xive2Nvgc nvgc;
+
+    for (prio = 0; prio <= XIVE_PRIORITY_MAX; prio++) {
+        current_level = first_group & 0xF;
+
+        while (current_level) {
+            mask = (1 << current_level) - 1;
+            nvgc_idx = nvp_idx & ~mask;
+            nvgc_idx |= mask >> 1;
+            qemu_log("fxb %s checking backlog for prio %d group idx %x\n",
+                     __func__, prio, nvgc_idx);
+
+            if (xive2_router_get_nvgc(xrtr, false, nvp_blk, nvgc_idx, &nvgc)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVG %x/%x\n",
+                              nvp_blk, nvgc_idx);
+                return 0xFF;
+            }
+            if (!xive2_nvgc_is_valid(&nvgc)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVG %x/%x\n",
+                              nvp_blk, nvgc_idx);
+                return 0xFF;
+            }
+
+            count = xive2_nvgc_get_backlog(&nvgc, prio);
+            if (count) {
+                *out_level = current_level;
+                return prio;
+            }
+            current_level = xive_get_field32(NVGC2_W0_PGONEXT, nvgc.w0) & 0xF;
+        }
+    }
+    return 0xFF;
+}
+
+static void xive2_presenter_backlog_decr(XivePresenter *xptr,
+                                         uint8_t nvp_blk, uint32_t nvp_idx,
+                                         uint8_t group_prio,
+                                         uint8_t group_level)
+{
+    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
+    uint32_t nvgc_idx, mask, count;
+    Xive2Nvgc nvgc;
+
+    group_level &= 0xF;
+    mask = (1 << group_level) - 1;
+    nvgc_idx = nvp_idx & ~mask;
+    nvgc_idx |= mask >> 1;
+
+    if (xive2_router_get_nvgc(xrtr, false, nvp_blk, nvgc_idx, &nvgc)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVG %x/%x\n",
+                      nvp_blk, nvgc_idx);
+        return;
+    }
+    if (!xive2_nvgc_is_valid(&nvgc)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVG %x/%x\n",
+                      nvp_blk, nvgc_idx);
+        return;
+    }
+    count = xive2_nvgc_get_backlog(&nvgc, group_prio);
+    if (!count) {
+        return;
+    }
+    xive2_nvgc_set_backlog(&nvgc, group_prio, count - 1);
+    xive2_router_write_nvgc(xrtr, false, nvp_blk, nvgc_idx, &nvgc);
+}
+
 /*
  * XIVE Thread Interrupt Management Area (TIMA) - Gen2 mode
  *
@@ -588,8 +667,9 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
                                    uint8_t nvp_blk, uint32_t nvp_idx,
                                    bool do_restore)
 {
-    uint8_t ipb, backlog_level;
-    uint8_t backlog_prio;
+    XivePresenter *xptr = XIVE_PRESENTER(xrtr);
+    uint8_t ipb, backlog_level, group_level, first_group;
+    uint8_t backlog_prio, group_prio;
     uint8_t *regs = &tctx->regs[TM_QW1_OS];
     Xive2Nvp nvp;

@@ -624,8 +704,22 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
     backlog_prio = xive_ipb_to_pipr(ipb);
     backlog_level = 0;

+    first_group = xive_get_field32(NVP2_W0_PGOFIRST, nvp.w0);
+    if (first_group && regs[TM_LSMFB] < backlog_prio) {
+        group_prio = xive2_presenter_backlog_check(xptr, nvp_blk, nvp_idx,
+                                                   first_group, &group_level);
+        regs[TM_LSMFB] = group_prio;
+        if (regs[TM_LGS] && group_prio < backlog_prio) {
+            /* VP can take a group interrupt */
+            xive2_presenter_backlog_decr(xptr, nvp_blk, nvp_idx,
+                                         group_prio, group_level);
+            backlog_prio = group_prio;
+            backlog_level = group_level;
+        }
+    }
+
     /*
-     * Compute the PIPR based on the restored state.
+    * Compute the PIPR based on the restored state.
      * It will raise the External interrupt signal if needed.
      */
     xive_tctx_pipr_update(tctx, TM_QW1_OS, backlog_prio, backlog_level);
--
2.43.0


