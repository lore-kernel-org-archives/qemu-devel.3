Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BC9C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 20:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZcRp-00043z-UF; Thu, 01 Aug 2024 16:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRk-0003io-3h; Thu, 01 Aug 2024 16:30:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRe-0007N9-Rr; Thu, 01 Aug 2024 16:30:45 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471K1vpi018325;
 Thu, 1 Aug 2024 20:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=jTWZ20HOWIiMO
 evgp00aFmBNuNYX/VYTwkx4ar9VHf0=; b=LXntZ6wJ7ped+HLT0xJ2PdGRO47oT
 K+6Ysgb/BDs+6QLvnhSbU0/oIX3GvmfCaBdn//PclqHlrJkcdrP1Lvq5NRMICFCM
 7nMtaCczmdsho26sckIHCjLxJVudOL1w1G/WVeGz9ShvGPCsWDnU22cYTXAA+ALA
 A20dramVgYptJgOlLxOEii5AXMeSs2/npkdl5TCrOgxidxFEFBEUyugrdvAJ1g0c
 xyPTB7VYIuQPcivwbIoH+/OMlX+1q7eMUSvYdJXJlo2zJKftVh00Horf96uEvs4i
 Sx+8nq6wR7S+ENXDPUyHpI2EKe4Ec6tpT/1Rou91c53AfV5d4fxvP7OUw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rdfkghp6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:33 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 471KUW9x002982;
 Thu, 1 Aug 2024 20:30:32 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rdfkghp3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 471HBnXx007462; Thu, 1 Aug 2024 20:30:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7um0vh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 471KUQ1b55706064
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Aug 2024 20:30:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A0062004E;
 Thu,  1 Aug 2024 20:30:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30D0D20043;
 Thu,  1 Aug 2024 20:30:25 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Aug 2024 20:30:25 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH 05/13] ppc/xive2: Dump more NVP state with 'info pic'
Date: Thu,  1 Aug 2024 15:30:00 -0500
Message-Id: <20240801203008.11224-6-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240801203008.11224-1-kowal@linux.ibm.com>
References: <20240801203008.11224-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QdpVHampXOKUjcs4UvWc_KCo0TeZZS8o
X-Proofpoint-ORIG-GUID: 5xM_CuZYVyvMzZV_ALi4ZI-d0DTERSmT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=552 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408010135
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
index dd3ae102fb..034baabf1e 100644
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
+        g_string_append_printf(buf, " CL:%016lx", cache_line);
+    }
+
     /*
      * When the NVP is HW controlled, more fields are updated
      */
-- 
2.43.0


