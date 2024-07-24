Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E312FC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 21:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWjRA-0000iL-TJ; Wed, 24 Jul 2024 17:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sWjR3-0000KH-J5; Wed, 24 Jul 2024 17:22:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sWjR2-0000Xi-1U; Wed, 24 Jul 2024 17:22:09 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OJ0GsK015534;
 Wed, 24 Jul 2024 21:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=lJ6RsiRzm9qmO
 mOQZeHjlAKuGZb5yG+xk9FA8egDyvc=; b=hopDMtwxYH6Cxj9+15FqvalbdXbBJ
 6kWDLZMLjoyC/4Q/pNVCVysaDL4siJsDwIbWe+IKlTs9nONhxzQBPaBoXQ/ODe50
 k+ytiRaezMbKlfcRjeVBA+0REeOh2IJv54jBvGtzLH+B7ixWvAKWO2bjqqtV3yJ2
 7kajA4HiIReApk+PTPT6C+HHnnGcvglw1KELO2MHqSRklWtiEaDiLfL2L03sKn6+
 2/vzDCJIbnken+pmrdK64OoVWm6+Y5hfRC5HG2wCqwYvr1KS3LJm1wO4xejWfIEr
 LEpeBeezpNt4vy/XAuCMwpi6ReA1xhEHwdaddzF7u9Ge18jciEcJvXS4A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40k7cm89v8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:21:58 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46OLLwWq025663;
 Wed, 24 Jul 2024 21:21:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40k7cm89v7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:21:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46OJOu3T006625; Wed, 24 Jul 2024 21:21:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gxn7j42y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:21:57 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46OLLpb254198594
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2024 21:21:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 940F520063;
 Wed, 24 Jul 2024 21:21:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E91320065;
 Wed, 24 Jul 2024 21:21:50 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jul 2024 21:21:50 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v4 09/11] pnv/xive2: Move xive2_nvp_pic_print_info() to xive2.c
Date: Wed, 24 Jul 2024 16:21:28 -0500
Message-Id: <20240724212130.26811-10-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240724212130.26811-1-kowal@linux.ibm.com>
References: <20240724212130.26811-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PUPUv6AwyUTW6K6sN8fZI4XZebfHyzgG
X-Proofpoint-ORIG-GUID: GBHd4yCx-X4bs1JUaqCl_kVEX4_g3xVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_24,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=721 phishscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240150
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Moving xive2_nvp_pic_print_info() to align with the other "pic_print_info"
functions.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
---
 include/hw/ppc/xive2_regs.h |  2 ++
 hw/intc/pnv_xive2.c         | 27 ---------------------------
 hw/intc/xive2.c             | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 4e5e17cd89..ec5d6ec2d6 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -194,6 +194,8 @@ static inline uint32_t xive2_nvp_blk(uint32_t cam_line)
     return (cam_line >> XIVE2_NVP_SHIFT) & 0xf;
 }
 
+void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf);
+
 /*
  * Notification Virtual Group or Crowd (NVG/NVC)
  */
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 9fe3ec9a67..4740c56347 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -2436,33 +2436,6 @@ static void pnv_xive2_register_types(void)
 
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
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 3e7238c663..ac914b3d1c 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -137,6 +137,32 @@ void xive2_end_eas_pic_print_info(Xive2End *end, uint32_t end_idx,
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
-- 
2.43.0


