Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53640ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 21:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snlf9-0000il-S5; Mon, 09 Sep 2024 17:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1snlf6-0000YK-Nk; Mon, 09 Sep 2024 17:11:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1snlf4-000261-QN; Mon, 09 Sep 2024 17:11:04 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489EWSMI018449;
 Mon, 9 Sep 2024 21:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=9ldXKBgp/O3/x
 VhaD9bDwjRBovAKynycRoA0ZDNOHcU=; b=pOaw0fuHFlge2upF0yRHdd0szU/7z
 oaFpuAEOxpPPan+MAx5wvKqUxg1hslppj1GIS3x6Cj5cSOw1TRmVpUAQTwkiUee7
 kfvSQxmadtkAc2gUG2fo4SxIf2wlh9nkluAmreXOsoRPPunPERJEATEtGHyvtWRO
 dVDE+vCSw2RD4jvj9/PXO/DtBD0qIwg8BgeCdZy/J1oMEujkWPMIDop7jZ1s17eY
 /DZThngoEtjr4NFaS5RAyVB5L6iyivO1tJtNLtjLOA41aU4o8VpdJjrtNuulTbWF
 K7DngkkZNosIQ9O5y0aWX8lZksAqJ5PIdcqhIWWQ9aAcYvFxg19IzCZ5g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41geba42ax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:10:59 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 489LAwO6022505;
 Mon, 9 Sep 2024 21:10:58 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41geba42av-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:10:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 489IR157003176;
 Mon, 9 Sep 2024 21:10:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h15trgsv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:10:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 489LAslW33948398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Sep 2024 21:10:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E04F2004B;
 Mon,  9 Sep 2024 21:10:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11ADA20040;
 Mon,  9 Sep 2024 21:10:53 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Sep 2024 21:10:52 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v2 05/14] ppc/xive2: Dump more NVP state with 'info pic'
Date: Mon,  9 Sep 2024 16:10:29 -0500
Message-Id: <20240909211038.27440-6-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240909211038.27440-1-kowal@linux.ibm.com>
References: <20240909211038.27440-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kWi7Htj83dDFwAyEbPPm5aUqk1igL_HE
X-Proofpoint-GUID: Od2OLzDyVQPgjwVK1AOGiJuA6pOaCOOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_10,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=523 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409090166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

The 'PGoFirst' field of a Notify Virtual Processor tells if the NVP
belongs to a VP group.

Also, print the Reporting Cache Line address, if defined.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive2_regs.h |  1 +
 hw/intc/xive2.c             | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 7acf7dccf3..d71a54f9ff 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -151,6 +151,7 @@ typedef struct Xive2Nvp {
 #define NVP2_W0_VALID              PPC_BIT32(0)
 #define NVP2_W0_HW                 PPC_BIT32(7)
 #define NVP2_W0_ESC_END            PPC_BIT32(25) /* 'N' bit 0:ESB  1:END */
+#define NVP2_W0_PGOFIRST           PPC_BITMASK32(26, 31)
         uint32_t       w1;
 #define NVP2_W1_CO                 PPC_BIT32(13)
 #define NVP2_W1_CO_PRIV            PPC_BITMASK32(14, 15)
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index fbd05aa9f5..ac581fa195 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -161,14 +161,20 @@ void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf)
 {
     uint8_t  eq_blk = xive_get_field32(NVP2_W5_VP_END_BLOCK, nvp->w5);
     uint32_t eq_idx = xive_get_field32(NVP2_W5_VP_END_INDEX, nvp->w5);
+    uint64_t cache_line = xive2_nvp_reporting_addr(nvp);
 
     if (!xive2_nvp_is_valid(nvp)) {
         return;
     }
 
-    g_string_append_printf(buf, "  %08x end:%02x/%04x IPB:%02x",
+    g_string_append_printf(buf, "  %08x end:%02x/%04x IPB:%02x PGoFirst:%02x",
                            nvp_idx, eq_blk, eq_idx,
-                           xive_get_field32(NVP2_W2_IPB, nvp->w2));
+                           xive_get_field32(NVP2_W2_IPB, nvp->w2),
+                           xive_get_field32(NVP2_W0_PGOFIRST, nvp->w0));
+    if (cache_line) {
+        g_string_append_printf(buf, "  reporting CL:%016"PRIx64, cache_line);
+    }
+
     /*
      * When the NVP is HW controlled, more fields are updated
      */
-- 
2.43.0


