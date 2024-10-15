Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D651FD1D876
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 21:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ore-0003k6-Sa; Tue, 15 Oct 2024 17:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0ord-0003iz-6F; Tue, 15 Oct 2024 17:13:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0ora-0000NS-Tc; Tue, 15 Oct 2024 17:13:56 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FJY63k030288;
 Tue, 15 Oct 2024 21:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=C+YqxDfKR9zNebasP
 VESqbOAs8dN8sSMjb5oSEWfYVE=; b=db9zXcdQQDMBKS0vYLkuYo2zRU5MLnkY+
 Wu75WvwJIrQdnQSUfsawn1O9gJAxi8CwW3PXcVtX9hZuebdvA/bLD5uLNUOfggJb
 DeVu1qA1276iuHRX9+clDjK9bc+RjrIhGQ8bDlwbaDjOvf5wDAihbobIClW9HKal
 jqwT4HFj75vr5oOd9cwRbQ7Y+ZqIi2NX6r8iuU1W9JdzGgDUX0sqp/85OdSfk5gt
 aiBD8Oo/fVSwSImSZszumM8fqgcOx2uvxg2QSha3vWdnMq4mAYdsnqfZwwvSTR9g
 JUCf1WpiHpe7g4ApK0BeXxypG82RZzwH0HvjHZI8B0nyHN47gOs4w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429x17ggyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:13:45 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FLDiiO009162;
 Tue, 15 Oct 2024 21:13:44 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429x17ggyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:13:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FI6Wbv006757;
 Tue, 15 Oct 2024 21:13:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xk5v8u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:13:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49FLDdbs51773736
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Oct 2024 21:13:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8F962004B;
 Tue, 15 Oct 2024 21:13:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC47B20043;
 Tue, 15 Oct 2024 21:13:37 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Oct 2024 21:13:37 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH 01/14] ppc/xive2: Update NVP save/restore for group attributes
Date: Tue, 15 Oct 2024 16:13:16 -0500
Message-Id: <20241015211329.21113-2-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015211329.21113-1-kowal@linux.ibm.com>
References: <20241015211329.21113-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UyvKiZD6TVZ6QAMJ70aWyu3xYdfXafvz
X-Proofpoint-GUID: PCTuyCA76AtwpafKwd8MELY4ZdWyym4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=714 phishscore=0 clxscore=1015
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

If the 'H' attribute is set on the NVP structure, the hardware
automatically saves and restores some attributes from the TIMA in the
NVP structure.
The group-specific attributes LSMFB, LGS and T have an extra flag to
individually control what is saved/restored.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive2_regs.h |  5 +++++
 hw/intc/xive2.c             | 18 ++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 1d00c8df64..30868e8e09 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -152,6 +152,9 @@ typedef struct Xive2Nvp {
         uint32_t       w0;
 #define NVP2_W0_VALID              PPC_BIT32(0)
 #define NVP2_W0_HW                 PPC_BIT32(7)
+#define NVP2_W0_L                  PPC_BIT32(8)
+#define NVP2_W0_G                  PPC_BIT32(9)
+#define NVP2_W0_T                  PPC_BIT32(10)
 #define NVP2_W0_ESC_END            PPC_BIT32(25) /* 'N' bit 0:ESB  1:END */
 #define NVP2_W0_PGOFIRST           PPC_BITMASK32(26, 31)
         uint32_t       w1;
@@ -163,6 +166,8 @@ typedef struct Xive2Nvp {
 #define NVP2_W2_CPPR               PPC_BITMASK32(0, 7)
 #define NVP2_W2_IPB                PPC_BITMASK32(8, 15)
 #define NVP2_W2_LSMFB              PPC_BITMASK32(16, 23)
+#define NVP2_W2_T                  PPC_BIT32(27)
+#define NVP2_W2_LGS                PPC_BITMASK32(28, 31)
         uint32_t       w3;
         uint32_t       w4;
 #define NVP2_W4_ESC_ESB_BLOCK      PPC_BITMASK32(0, 3)  /* N:0 */
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index d1df35e9b3..4adc3b6950 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -313,7 +313,19 @@ static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
 
     nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, regs[TM_IPB]);
     nvp.w2 = xive_set_field32(NVP2_W2_CPPR, nvp.w2, regs[TM_CPPR]);
-    nvp.w2 = xive_set_field32(NVP2_W2_LSMFB, nvp.w2, regs[TM_LSMFB]);
+    if (nvp.w0 & NVP2_W0_L) {
+        /*
+         * Typically not used. If LSMFB is restored with 0, it will
+         * force a backlog rescan
+         */
+        nvp.w2 = xive_set_field32(NVP2_W2_LSMFB, nvp.w2, regs[TM_LSMFB]);
+    }
+    if (nvp.w0 & NVP2_W0_G) {
+        nvp.w2 = xive_set_field32(NVP2_W2_LGS, nvp.w2, regs[TM_LGS]);
+    }
+    if (nvp.w0 & NVP2_W0_T) {
+        nvp.w2 = xive_set_field32(NVP2_W2_T, nvp.w2, regs[TM_T]);
+    }
     xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
 
     nvp.w1 = xive_set_field32(NVP2_W1_CO, nvp.w1, 0);
@@ -527,7 +539,9 @@ static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, nvp, 2);
 
     tctx->regs[TM_QW1_OS + TM_CPPR] = cppr;
-    /* we don't model LSMFB */
+    tctx->regs[TM_QW1_OS + TM_LSMFB] = xive_get_field32(NVP2_W2_LSMFB, nvp->w2);
+    tctx->regs[TM_QW1_OS + TM_LGS] = xive_get_field32(NVP2_W2_LGS, nvp->w2);
+    tctx->regs[TM_QW1_OS + TM_T] = xive_get_field32(NVP2_W2_T, nvp->w2);
 
     nvp->w1 = xive_set_field32(NVP2_W1_CO, nvp->w1, 1);
     nvp->w1 = xive_set_field32(NVP2_W1_CO_THRID_VALID, nvp->w1, 1);
-- 
2.43.0


